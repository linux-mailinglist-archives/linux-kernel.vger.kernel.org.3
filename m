Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D920250B285
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 10:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445435AbiDVIEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 04:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiDVIEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 04:04:44 -0400
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr [80.12.242.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD5B527D7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 01:01:51 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.180.246])
        by smtp.orange.fr with ESMTPA
        id hoEen0sqCYnCyhoEen2yeU; Fri, 22 Apr 2022 10:01:49 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 22 Apr 2022 10:01:49 +0200
X-ME-IP: 86.243.180.246
Message-ID: <ef8e4a32-bc05-2632-bc09-00a20faf49dd@wanadoo.fr>
Date:   Fri, 22 Apr 2022 10:01:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drivers/base/memory: Fix a reference counting issue in
 __add_memory_block()
Content-Language: en-GB
To:     Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Scott Cheloha <cheloha@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Newsgroups: gmane.linux.kernel.janitors,gmane.linux.kernel
References: <d44c63d78aafe844f920dc02ad6af25acc448fcf.1650611702.git.christophe.jaillet@wanadoo.fr>
 <YmJaoSam6g95yToH@dhcp22.suse.cz>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <YmJaoSam6g95yToH@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 22/04/2022 à 09:34, Michal Hocko a écrit :
> On Fri 22-04-22 09:15:21, Christophe JAILLET wrote:
>> There is no point in doing put_device()/device_unregister() on a
>> device that has just been registered a few lines above. This will lead to
>> a double reference decrement.
> 
> This is a bit confusing. I would rephrase.
> "
> __add_memory_block calls both put_device and device_unregister when
> storing the memory block into the xarray. This is incorrect because
> xarray doesn't take an additional reference and device_unregister
> already calls put_device.
> "
> 
> Btw. I do not think this failure path can be triggered, or is there a
> way to hit it?
>   
>> I guess that this put_device()/device_unregister() is a cut'n'paste from
>> remove_memory_block() (i.e. unregister_memory() at the time being) which
>> does need it.
>>
>> Fixes: 4fb6eabf1037 ("drivers/base/memory.c: cache memory blocks in xarray to accelerate lookup")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Other than that looks good to me. With the changelog clarified,
> especially the part that evaluates whether this is a real or a
> theoretical problem, feel free to add
> Acked-by: Michal Hocko <mhocko@suse.com>

I'll send a v2 with the updated changelog.

I do agree that this is certainly a theoretical issue.
Moreover, should it be triggered, I think that it would only print a 
warning message about an erroneous decrement on a ref counted resource 
that is already 0.

Well, it also saves 2 LoC and will look more logical to other readers 
(and static checkers :) )

Thanks for the quick review for both of you.

CJ
> 
> Thanks!
> 
>> ---
>>   drivers/base/memory.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>> index 7222ff9b5e05..084d67fd55cc 100644
>> --- a/drivers/base/memory.c
>> +++ b/drivers/base/memory.c
>> @@ -636,10 +636,9 @@ static int __add_memory_block(struct memory_block *memory)
>>   	}
>>   	ret = xa_err(xa_store(&memory_blocks, memory->dev.id, memory,
>>   			      GFP_KERNEL));
>> -	if (ret) {
>> -		put_device(&memory->dev);
>> +	if (ret)
>>   		device_unregister(&memory->dev);
>> -	}
>> +
>>   	return ret;
>>   }
>>   
>> -- 
>> 2.32.0
> 

