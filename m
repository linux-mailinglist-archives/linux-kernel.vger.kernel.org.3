Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9C6468308
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 07:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243286AbhLDHAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 02:00:52 -0500
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:62342 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242957AbhLDHAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 02:00:51 -0500
Received: from [192.168.1.18] ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id tOz3mtyH7MNzvtOz3m2FTn; Sat, 04 Dec 2021 07:57:24 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 04 Dec 2021 07:57:24 +0100
X-ME-IP: 86.243.171.122
Subject: Re: [PATCH] xen-blkfront: Use the bitmap API when applicable
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Joe Perches <joe@perches.com>, Juergen Gross <jgross@suse.com>,
        sstabellini@kernel.org, roger.pau@citrix.com, axboe@kernel.dk
Cc:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <1c73cf8eaff02ea19439ec676c063e592d273cfe.1638392965.git.christophe.jaillet@wanadoo.fr>
 <c529a221-f444-ad26-11ff-f693401c9429@suse.com>
 <d8f87c17-75d1-2e6b-65e1-23adc75bb515@wanadoo.fr>
 <6fcddba84070c021eb92aa9a5ff15fb2a47e9acb.camel@perches.com>
 <3d71577f-dabe-6e1a-4b03-2a44f304b702@wanadoo.fr>
 <863f2cddacac590d581cda09d548ee0a652df8a1.camel@perches.com>
 <1e9291c6-48bb-88e5-37dc-f604cfa4c4db@wanadoo.fr>
 <a6dd44e2-6ea6-d085-0131-1e9bac49461a@oracle.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <f9a5bc6c-347b-8243-2784-04199ef879c2@wanadoo.fr>
Date:   Sat, 4 Dec 2021 07:57:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <a6dd44e2-6ea6-d085-0131-1e9bac49461a@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 03/12/2021 à 22:04, Boris Ostrovsky a écrit :
> 
> On 12/3/21 10:54 AM, Christophe JAILLET wrote:
>> Le 03/12/2021 à 04:03, Joe Perches a écrit :
>>
>> I get your point now, and I agree with you.
>>
>> Maybe something as what is done in mc-entity.c?
>> Explicitly require more bits (which will be allocated anyway), instead 
>> of taking advantage (read "hoping") that it will be done.
>>
>> Could be:
>>
>> @@ -440,26 +440,25 @@ static int xlbd_reserve_minors(unsigned int 
>> minor, unsigned int nr)
>>      int rc;
>>
>>      if (end > nr_minors) {
>>          unsigned long *bitmap, *old;
>>
>> -        bitmap = kcalloc(BITS_TO_LONGS(end), sizeof(*bitmap),
>> -                 GFP_KERNEL);
>> +        end = ALIGN(end, BITS_PER_LONG);
>> +        bitmap = bitmap_zalloc(end, GFP_KERNEL);
>>          if (bitmap == NULL)
>>              return -ENOMEM;
>>
>>          spin_lock(&minor_lock);
>>          if (end > nr_minors) {
>>              old = minors;
>> -            memcpy(bitmap, minors,
>> -                   BITS_TO_LONGS(nr_minors) * sizeof(*bitmap));
>> +            bitmap_copy(bitmap, minors, nr_minors);
>>              minors = bitmap;
>> -            nr_minors = BITS_TO_LONGS(end) * BITS_PER_LONG;
>> +            nr_minors = end;
>>          } else
>>              old = bitmap;
>>          spin_unlock(&minor_lock);
>> -        kfree(old);
>> +        bitmap_free(old);
>>      }
>>
>>      spin_lock(&minor_lock);
>>      if (find_next_bit(minors, end, minor) >= end) {
> 
> 
> I don't think this will work anymore, we may now fail if another thread 
> gets a minor above the original (i.e. no aligned) @end.
> 

So, maybe adding an "official" 'bitmap_size()' (which is already 
existing and duplicated in a few places) would ease things.

It would replace the 'nr_minors = BITS_TO_LONGS(end) * BITS_PER_LONG;' 
and hide the implementation details of the bitmap API.

Something like:
static __always_inline size_t bitmap_size(unsigned long nr_bits)
{
	return BITS_TO_LONGS(nr_bits) * sizeof(long);
}

CJ

> 
> -boris
> 
