Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3163564290
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 21:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiGBTmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 15:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiGBTmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 15:42:09 -0400
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1D9BF54
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 12:42:07 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 7j0Fovq0J26JC7j0Fox7ym; Sat, 02 Jul 2022 21:42:06 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 02 Jul 2022 21:42:06 +0200
X-ME-IP: 90.11.190.129
Message-ID: <62d3cfcd-a32e-59d1-c376-c95e8da1049f@wanadoo.fr>
Date:   Sat, 2 Jul 2022 21:42:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/4] s390/cio: Rename bitmap_size() as idset_bitmap_size()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        vneethv@linux.ibm.com, oberpar@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        almaz.alexandrovich@paragon-software.com, yury.norov@gmail.com,
        linux@rasmusvillemoes.dk, linux-s390@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Newsgroups: gmane.linux.kernel.janitors,gmane.linux.kernel.device-mapper.devel,gmane.linux.kernel
References: <cover.1656785856.git.christophe.jaillet@wanadoo.fr>
 <3f2ad7fb91948525f6c52e0d36ec223cd3049c88.1656785856.git.christophe.jaillet@wanadoo.fr>
 <YsCUW6vT7LlAv2UE@smile.fi.intel.com>
 <6063ee97-1bbe-2391-78cb-57572851a52c@wanadoo.fr>
 <YsCdSkzSbVz9gnci@smile.fi.intel.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <YsCdSkzSbVz9gnci@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 02/07/2022 à 21:32, Andy Shevchenko a écrit :
> On Sat, Jul 02, 2022 at 09:24:24PM +0200, Christophe JAILLET wrote:
>> Le 02/07/2022 à 20:54, Andy Shevchenko a écrit :
>>> On Sat, Jul 02, 2022 at 08:29:09PM +0200, Christophe JAILLET wrote:
> 
> ...
> 
>>>> -		memset(set->bitmap, 0, bitmap_size(num_ssid, num_id));
>>>> +		memset(set->bitmap, 0, idset_bitmap_size(num_ssid, num_id));
>>>
>>> Why not to use bitmap_zero()?
> 
> ...
> 
>>>> -	memset(set->bitmap, 0xff, bitmap_size(set->num_ssid, set->num_id));
>>>> +	memset(set->bitmap, 0xff, idset_bitmap_size(set->num_ssid, set->num_id));
>>>
>>> Why not to use bitmap_fill() ?
> 
>> For this initial step, I wanted to keep changes as minimal as possible (i.e
>> just function renaming)
>>
>> In fact, I plan to send a follow-up patch on this file.
>> This would remove the newly renamed idset_bitmap_size() function, use the
>> bitmap API directly (as you pointed-out) with
>> "set->num_ssid * set->num_id" as size.
>>
>> It is already done this way in idset_is_empty(), so it would be more
>> consistent.
>>
>> If the serie needs a v2 (or if required), I can add an additional 5th patch
>> for it. Otherwise it will send separatly later.
> 
> If you use bitmap APIs as I suggested above as the first patch, the rest will
> have less unneeded churn, no?
> 
> 

Makes sense.

I'll wait for some other potential comments 1 day or 2 and send a v2 
with the simplification you propose as an initial step.

Thanks for your feed-back.

CJ
