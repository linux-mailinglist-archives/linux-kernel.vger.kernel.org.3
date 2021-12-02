Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD49C4669A4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 19:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376582AbhLBSPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 13:15:32 -0500
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:57258 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376573AbhLBSPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 13:15:30 -0500
Received: from [192.168.1.18] ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id sqYum8DwlHQrlsqYumWmIy; Thu, 02 Dec 2021 19:12:06 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 02 Dec 2021 19:12:06 +0100
X-ME-IP: 86.243.171.122
Subject: Re: [PATCH] xen-blkfront: Use the bitmap API when applicable
To:     Juergen Gross <jgross@suse.com>, boris.ostrovsky@oracle.com,
        sstabellini@kernel.org, roger.pau@citrix.com, axboe@kernel.dk
Cc:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <1c73cf8eaff02ea19439ec676c063e592d273cfe.1638392965.git.christophe.jaillet@wanadoo.fr>
 <c529a221-f444-ad26-11ff-f693401c9429@suse.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <d8f87c17-75d1-2e6b-65e1-23adc75bb515@wanadoo.fr>
Date:   Thu, 2 Dec 2021 19:12:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <c529a221-f444-ad26-11ff-f693401c9429@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 02/12/2021 à 07:12, Juergen Gross a écrit :
> On 01.12.21 22:10, Christophe JAILLET wrote:
>> Use 'bitmap_zalloc()' to simplify code, improve the semantic and avoid 
>> some
>> open-coded arithmetic in allocator arguments.
>>
>> Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
>> consistency.
>>
>> Use 'bitmap_copy()' to avoid an explicit 'memcpy()'
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/block/xen-blkfront.c | 8 +++-----
>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
>> index 700c765a759a..fe4d69cf9469 100644
>> --- a/drivers/block/xen-blkfront.c
>> +++ b/drivers/block/xen-blkfront.c
>> @@ -442,16 +442,14 @@ static int xlbd_reserve_minors(unsigned int 
>> minor, unsigned int nr)
>>       if (end > nr_minors) {
>>           unsigned long *bitmap, *old;
>> -        bitmap = kcalloc(BITS_TO_LONGS(end), sizeof(*bitmap),
>> -                 GFP_KERNEL);
>> +        bitmap = bitmap_zalloc(end, GFP_KERNEL);
>>           if (bitmap == NULL)
>>               return -ENOMEM;
>>           spin_lock(&minor_lock);
>>           if (end > nr_minors) {
>>               old = minors;
>> -            memcpy(bitmap, minors,
>> -                   BITS_TO_LONGS(nr_minors) * sizeof(*bitmap));
>> +            bitmap_copy(bitmap, minors, nr_minors);
>>               minors = bitmap;
>>               nr_minors = BITS_TO_LONGS(end) * BITS_PER_LONG;
>>           } else
> 
> Shouldn't you use bitmap_free(old) some lines down?

Obvious.
I'll send a V2, Thx for the review.

CJ

> 
>> @@ -2610,7 +2608,7 @@ static void __exit xlblk_exit(void)
>>       xenbus_unregister_driver(&blkfront_driver);
>>       unregister_blkdev(XENVBD_MAJOR, DEV_NAME);
>> -    kfree(minors);
>> +    bitmap_free(minors);
>>   }
>>   module_exit(xlblk_exit);
> 
> 
> Juergen
> 

