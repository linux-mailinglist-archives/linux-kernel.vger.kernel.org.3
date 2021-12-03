Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C44467AA8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 16:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381910AbhLCP5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 10:57:38 -0500
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:53555 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381903AbhLCP5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 10:57:37 -0500
Received: from [192.168.1.18] ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id tAszmOO0S2lVYtAszm6OyC; Fri, 03 Dec 2021 16:54:12 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 03 Dec 2021 16:54:12 +0100
X-ME-IP: 86.243.171.122
Subject: Re: [PATCH] xen-blkfront: Use the bitmap API when applicable
To:     Joe Perches <joe@perches.com>, Juergen Gross <jgross@suse.com>,
        boris.ostrovsky@oracle.com, sstabellini@kernel.org,
        roger.pau@citrix.com, axboe@kernel.dk
Cc:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <1c73cf8eaff02ea19439ec676c063e592d273cfe.1638392965.git.christophe.jaillet@wanadoo.fr>
 <c529a221-f444-ad26-11ff-f693401c9429@suse.com>
 <d8f87c17-75d1-2e6b-65e1-23adc75bb515@wanadoo.fr>
 <6fcddba84070c021eb92aa9a5ff15fb2a47e9acb.camel@perches.com>
 <3d71577f-dabe-6e1a-4b03-2a44f304b702@wanadoo.fr>
 <863f2cddacac590d581cda09d548ee0a652df8a1.camel@perches.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <1e9291c6-48bb-88e5-37dc-f604cfa4c4db@wanadoo.fr>
Date:   Fri, 3 Dec 2021 16:54:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <863f2cddacac590d581cda09d548ee0a652df8a1.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 03/12/2021 à 04:03, Joe Perches a écrit :
> On Thu, 2021-12-02 at 20:07 +0100, Christophe JAILLET wrote:
>> Le 02/12/2021 à 19:16, Joe Perches a écrit :
>>> On Thu, 2021-12-02 at 19:12 +0100, Christophe JAILLET wrote:
>>>> Le 02/12/2021 à 07:12, Juergen Gross a écrit :
>>>>> On 01.12.21 22:10, Christophe JAILLET wrote:
>>>>>> Use 'bitmap_zalloc()' to simplify code, improve the semantic and avoid
>>>>>> some open-coded arithmetic in allocator arguments.
>>>>>>
>>>>>> Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
>>>>>> consistency.
>>>>>>
>>>>>> Use 'bitmap_copy()' to avoid an explicit 'memcpy()'
>>> []
>>>>>> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
>>> []
>>>>>> @@ -442,16 +442,14 @@ static int xlbd_reserve_minors(unsigned int
>>>>>> minor, unsigned int nr)
>>>>>>         if (end > nr_minors) {
>>>>>>             unsigned long *bitmap, *old;
>>>>>> -        bitmap = kcalloc(BITS_TO_LONGS(end), sizeof(*bitmap),
>>>>>> -                 GFP_KERNEL);
>>>>>> +        bitmap = bitmap_zalloc(end, GFP_KERNEL);
>>>>>>             if (bitmap == NULL)
>>>>>>                 return -ENOMEM;
>>>>>>             spin_lock(&minor_lock);
>>>>>>             if (end > nr_minors) {
>>>>>>                 old = minors;
>>>>>> -            memcpy(bitmap, minors,
>>>>>> -                   BITS_TO_LONGS(nr_minors) * sizeof(*bitmap));
>>>>>> +            bitmap_copy(bitmap, minors, nr_minors);
>>>>>>                 minors = bitmap;
>>>>>>                 nr_minors = BITS_TO_LONGS(end) * BITS_PER_LONG;
>>>
>>> 		nr_minors = end;
>>> ?
>>>
>>
>> No,
>> My understanding of the code is that if we lack space (end > nr_minors),
>> we need to allocate more. In such a case, we want to keep track of what
>> we have allocated, not what we needed.
>> The "padding" bits in the "long align" allocation, can be used later.
> 
>>
>> first call
>> ----------
>> end = 65
>> nr_minors = 63
>>
>> --> we need some space
>> --> we allocate 2 longs = 128 bits
>> --> we now use 65 bits of these 128 bits
> 
> or 96, 32 or 64 bit longs remember.

32 and 64 for sure, but I was not aware of 96. On which arch?

> 
>>
>> new call
>> --------
>> end = 68
>> nr_minors = 128 (from previous call)
> 
> The initial allocation is now bitmap_zalloc which
> specifies only bits and the nr_minors is then in
> BITS_TO_LONGS(bits) * BITS_PER_LONG
> 
> Perhaps that assumes too much about the internal
> implementation of bitmap_alloc
> 
> 

I get your point now, and I agree with you.

Maybe something as what is done in mc-entity.c?
Explicitly require more bits (which will be allocated anyway), instead 
of taking advantage (read "hoping") that it will be done.

Could be:

@@ -440,26 +440,25 @@ static int xlbd_reserve_minors(unsigned int minor, 
unsigned int nr)
  	int rc;

  	if (end > nr_minors) {
  		unsigned long *bitmap, *old;

-		bitmap = kcalloc(BITS_TO_LONGS(end), sizeof(*bitmap),
-				 GFP_KERNEL);
+		end = ALIGN(end, BITS_PER_LONG);
+		bitmap = bitmap_zalloc(end, GFP_KERNEL);
  		if (bitmap == NULL)
  			return -ENOMEM;

  		spin_lock(&minor_lock);
  		if (end > nr_minors) {
  			old = minors;
-			memcpy(bitmap, minors,
-			       BITS_TO_LONGS(nr_minors) * sizeof(*bitmap));
+			bitmap_copy(bitmap, minors, nr_minors);
  			minors = bitmap;
-			nr_minors = BITS_TO_LONGS(end) * BITS_PER_LONG;
+			nr_minors = end;
  		} else
  			old = bitmap;
  		spin_unlock(&minor_lock);
-		kfree(old);
+		bitmap_free(old);
  	}

  	spin_lock(&minor_lock);
  	if (find_next_bit(minors, end, minor) >= end) {
  		bitmap_set(minors, minor, nr);
@@ -2608,11 +2607,11 @@ static void __exit xlblk_exit(void)
  {
  	cancel_delayed_work_sync(&blkfront_work);

  	xenbus_unregister_driver(&blkfront_driver);
  	unregister_blkdev(XENVBD_MAJOR, DEV_NAME);
-	kfree(minors);
+	bitmap_free(minors);
  }
  module_exit(xlblk_exit);

  MODULE_DESCRIPTION("Xen virtual block device frontend");
  MODULE_LICENSE("GPL");


