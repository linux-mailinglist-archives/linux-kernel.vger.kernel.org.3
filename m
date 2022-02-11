Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63BC4B2EEA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350383AbiBKUxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:53:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349812AbiBKUxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:53:18 -0500
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr [80.12.242.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283BBCED
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 12:53:16 -0800 (PST)
Received: from [192.168.1.18] ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id IcumnKiHYAWDQIcunnFclD; Fri, 11 Feb 2022 21:53:14 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 11 Feb 2022 21:53:14 +0100
X-ME-IP: 90.126.236.122
Message-ID: <9b563415-f58a-15f1-b375-64ef4e98ca05@wanadoo.fr>
Date:   Fri, 11 Feb 2022 21:53:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] power: supply: da9150: use div64_u64() instead of
 do_div()
Content-Language: fr
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Qing Wang <wangqing@vivo.com>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1644395986-4349-1-git-send-email-wangqing@vivo.com>
 <20220211205026.6jhtt66wco5ht6i6@mercury.elektranox.org>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220211205026.6jhtt66wco5ht6i6@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 11/02/2022 à 21:50, Sebastian Reichel a écrit :
> Hi,
> 
> On Wed, Feb 09, 2022 at 12:39:46AM -0800, Qing Wang wrote:
>> From: Wang Qing <wangqing@vivo.com>
>>
>> do_div() does a 64-by-32 division.
>> When the divisor is u64, do_div() truncates it to 32 bits, this means it
>> can test non-zero and be truncated to zero for division.
>>
>> fix do_div.cocci warning:
>> do_div() does a 64-by-32 division, please consider using div64_u64 instead.
>>
>> Signed-off-by: Wang Qing <wangqing@vivo.com>
>> ---
> 
> Thanks, queued.

All these patches are broken and should be NACKed, fixed or reverted if 
applied.

See [1].

CJ

[1]: 
https://lore.kernel.org/linux-kernel/19b96972-cee7-937f-21ce-c78982ed2048@linaro.org/

> 
> -- Sebastian
> 
>>   drivers/power/supply/da9150-fg.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/power/supply/da9150-fg.c b/drivers/power/supply/da9150-fg.c
>> index 6e36782..896491a
>> --- a/drivers/power/supply/da9150-fg.c
>> +++ b/drivers/power/supply/da9150-fg.c
>> @@ -250,7 +250,7 @@ static int da9150_fg_current_avg(struct da9150_fg *fg,
>>   	div = (u64) (sd_gain * shunt_val * 65536ULL);
>>   	do_div(div, 1000000);
>>   	res = (u64) (iavg * 1000000ULL);
>> -	do_div(res, div);
>> +	div64_u64(res, div);
>>   
>>   	val->intval = (int) res;
>>   
>> -- 
>> 2.7.4
>>

