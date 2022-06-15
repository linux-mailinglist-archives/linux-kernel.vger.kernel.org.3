Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1031154C436
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347162AbiFOJE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345535AbiFOJE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:04:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B53939B9F;
        Wed, 15 Jun 2022 02:04:53 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5CE3E66016CC;
        Wed, 15 Jun 2022 10:04:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655283892;
        bh=k6NEoZsjEYGP1QQyFCr7lIgY0FTshdoki5vnhmBsqGI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=X0Td8BpR6RVk71SDXY9PoAXRf/ZBNcH1Q3hSZtgI5enUId9VyYxt0lARaZWnl3F/8
         KxIoDrrg14aNl0vmKrfPQn6J6kBypZ3w9eBKoXZuQ3LFZfQnuzow6202twCiBNdpca
         AnVFtBrJI52x2O3ke8KdW+1kTVEXXtBj6ECTvRLs4tLX1pLF0aOIeL1WR8rQiP0pLa
         UKCaFzCjmP8amAZj/B9MooWbr6QLbeKetNZesO0da5DWehXjNt3lR/iyUejhZhZhwa
         BXkPC98coyDIYxxxLc7rcu1kVjMDJ2A+rstkYH7zVksrW/a9xTnEzLryRU+y/yNo76
         YBc58jHBInDyQ==
Message-ID: <c025dd3d-00ce-d0a4-b7cb-540901c71f4e@collabora.com>
Date:   Wed, 15 Jun 2022 11:04:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 2/2] clocksource/drivers/timer-mediatek: Implement
 CPUXGPT timers
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        paul.bouchara@somainline.org
References: <20220613133819.35318-1-angelogioacchino.delregno@collabora.com>
 <20220613133819.35318-3-angelogioacchino.delregno@collabora.com>
 <277ec646-b709-4a4a-8216-49d528d0e43e@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <277ec646-b709-4a4a-8216-49d528d0e43e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/06/22 20:35, Daniel Lezcano ha scritto:
> On 13/06/2022 15:38, AngeloGioacchino Del Regno wrote:
>> Some MediaTek platforms with a buggy TrustZone ATF firmware will not
>> initialize the AArch64 System Timer correctly: in these cases, the
>> System Timer address is correctly programmed, as well as the CNTFRQ_EL0
>> register (reading 13MHz, as it should be), but the assigned hardware
>> timers are never started before (or after) booting Linux.
>>
>> In this condition, any call to function get_cycles() will be returning
>> zero, as CNTVCT_EL0 will always read zero.
>>
>> One common critical symptom of that is trying to use the udelay()
>> function (calling __delay()), which executes the following loop:
>>
>>              start = get_cycles();
>>              while ((get_cycles() - start) < cycles)
>>                      cpu_relax();
>>
>> which, when CNTVCT_EL0 always reads zero, translates to:
>>
>>              while((0 - 0) < 0)  ==> while(0 < 0)
>>
>> ... generating an infinite loop, even though zero is never less
>> than zero, but always equal to it (this has to be researched,
>> but it's out of the scope of this commit).
>>
>> To fix this issue on the affected MediaTek platforms, the solution
>> is to simply start the timers that are designed to be System Timer(s).
>> These timers, downstream, are called "CPUXGPT" and there is one
>> timer per CPU core; luckily, it is not necessary to set a start bit
>> on each CPUX General Purpose Timer, but it's conveniently enough to:
>>   - Set the clock divider (input = 26MHz, divider = 2, output = 13MHz);
>>   - Set the ENABLE bit on a global register (starts all CPUX timers).
>>
>> The only small hurdle with this setup is that it's all done through
>> the MCUSYS wrapper, where it is needed, for each read or write, to
>> select a register address (by writing it to an index register) and
>> then to perform any R/W on a "CON" register.
>>
>> For example, writing "0x1" to the CPUXGPT register offset 0x4:
>> - Write 0x4 to mcusys INDEX register
>> - Write 0x1 to mcusys CON register
>>
>> Reading from CPUXGPT register offset 0x4:
>> - Write 0x4 to mcusys INDEX register
>> - Read mcusys CON register.
>>
>> Finally, starting this timer makes platforms affected by this issue
>> to work correctly.
> 
> Why not fix the ATF ?
> 
> 

Hello Daniel,

that's not the first time this question gets asked, and I've already
provided an explanation for that, please look at [1] for the long answer.

As for the shorter answer: OEM/ODM signatures, you can't just compile and
flash a new ATF on your own (and some ODMs don't even exist anymore).
There's no way other than this.

[1]: 
https://patchwork.kernel.org/project/linux-mediatek/patch/20220509210741.12020-3-angelogioacchino.delregno@collabora.com/#24863077

Regards,
Angelo
