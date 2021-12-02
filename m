Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59F8466A26
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 20:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376661AbhLBTKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 14:10:45 -0500
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:58062 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348377AbhLBTKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 14:10:43 -0500
Received: from [192.168.1.18] ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id srQMm8a6iHQrlsrQMmWszZ; Thu, 02 Dec 2021 20:07:19 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 02 Dec 2021 20:07:19 +0100
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
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <3d71577f-dabe-6e1a-4b03-2a44f304b702@wanadoo.fr>
Date:   Thu, 2 Dec 2021 20:07:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <6fcddba84070c021eb92aa9a5ff15fb2a47e9acb.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 02/12/2021 à 19:16, Joe Perches a écrit :
> On Thu, 2021-12-02 at 19:12 +0100, Christophe JAILLET wrote:
>> Le 02/12/2021 à 07:12, Juergen Gross a écrit :
>>> On 01.12.21 22:10, Christophe JAILLET wrote:
>>>> Use 'bitmap_zalloc()' to simplify code, improve the semantic and avoid
>>>> some open-coded arithmetic in allocator arguments.
>>>>
>>>> Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
>>>> consistency.
>>>>
>>>> Use 'bitmap_copy()' to avoid an explicit 'memcpy()'
> []
>>>> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> []
>>>> @@ -442,16 +442,14 @@ static int xlbd_reserve_minors(unsigned int
>>>> minor, unsigned int nr)
>>>>        if (end > nr_minors) {
>>>>            unsigned long *bitmap, *old;
>>>> -        bitmap = kcalloc(BITS_TO_LONGS(end), sizeof(*bitmap),
>>>> -                 GFP_KERNEL);
>>>> +        bitmap = bitmap_zalloc(end, GFP_KERNEL);
>>>>            if (bitmap == NULL)
>>>>                return -ENOMEM;
>>>>            spin_lock(&minor_lock);
>>>>            if (end > nr_minors) {
>>>>                old = minors;
>>>> -            memcpy(bitmap, minors,
>>>> -                   BITS_TO_LONGS(nr_minors) * sizeof(*bitmap));
>>>> +            bitmap_copy(bitmap, minors, nr_minors);
>>>>                minors = bitmap;
>>>>                nr_minors = BITS_TO_LONGS(end) * BITS_PER_LONG;
> 
> 		nr_minors = end;
> ?
> 

No,
My understanding of the code is that if we lack space (end > nr_minors), 
we need to allocate more. In such a case, we want to keep track of what 
we have allocated, not what we needed.
The "padding" bits in the "long align" allocation, can be used later.

first call
----------
end = 65
nr_minors = 63

--> we need some space
--> we allocate 2 longs = 128 bits
--> we now use 65 bits of these 128 bits

new call
--------
end = 68
nr_minors = 128 (from previous call)
--> no need to reallocate

CJ
