Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB4958B455
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 09:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241711AbiHFHx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 03:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241639AbiHFHx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 03:53:57 -0400
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6467612AF1
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 00:53:53 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id KEd3oFnAvsfCIKEd3oQT3U; Sat, 06 Aug 2022 09:53:51 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 06 Aug 2022 09:53:51 +0200
X-ME-IP: 90.11.190.129
Message-ID: <7c03dd48-7e44-11a8-1855-74313874aee7@wanadoo.fr>
Date:   Sat, 6 Aug 2022 09:53:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] driver core: Define dev_err_probe() as __cold
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tglx@linutronix.de, jgg@ziepe.ca, ira.weiny@intel.com,
        dan.j.williams@intel.com, andriy.shevchenko@linux.intel.com,
        wonchung@google.com, list@mail.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <0d4391f85d916508dba096caf132b0a973b08800.1659768386.git.christophe.jaillet@wanadoo.fr>
 <Yu4URNSoKRiNWmyj@kroah.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <Yu4URNSoKRiNWmyj@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 06/08/2022 à 09:12, Greg KH a écrit :
> On Sat, Aug 06, 2022 at 08:49:23AM +0200, Christophe JAILLET wrote:
>> Give a hint to the compiler that dev_err_probe() is used for error
>> handling. So calling paths are unlikely.
>>
>> >From gcc documentation:
>> 	The paths leading to calls of cold functions within code are marked
>> 	as unlikely by the branch prediction mechanism.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   include/linux/device.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/device.h b/include/linux/device.h
>> index 424b55df0272..4ac16bde9bf7 100644
>> --- a/include/linux/device.h
>> +++ b/include/linux/device.h
>> @@ -1093,7 +1093,7 @@ void device_links_supplier_sync_state_pause(void);
>>   void device_links_supplier_sync_state_resume(void);
>>   
>>   extern __printf(3, 4)
>> -int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
>> +int __cold dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
> 
> As the probe() path is by default "slow", does this actually help
> anything?  I never recommend using any sort of manual likely/unlikely
> hints unless the results can be seen, otherwise the compiler and CPU
> almost always do a better job over time.
> 
> thanks,
> 
> greg k-h
> 

Based on a few tests, the generated code is different.
But it is hard to compare if it looks better or not because many things 
are shuffled.

My point is that the proposed change is easy and that the hint "should 
always be correct in this particular case".
Also _dev_err() and co. functions are already annotated with __cold.

But honestly, I agree with your POV.

Sometimes the resulting .o is slightly smaller, sometimes slightly bigger.

So, unless s.o. else cares, let leave it as is, timing of probe does not 
really matter anyway.


CJ
