Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6585501D3B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 23:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345468AbiDNVRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 17:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237304AbiDNVRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 17:17:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2A1C6EE9;
        Thu, 14 Apr 2022 14:14:55 -0700 (PDT)
Received: from [IPV6:2a00:5f00:102:0:10b3:10ff:fe5d:4ec1] (unknown [IPv6:2a00:5f00:102:0:10b3:10ff:fe5d:4ec1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 54D001F47CE5;
        Thu, 14 Apr 2022 22:14:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649970894;
        bh=45lr61m9iGCAZVul+Bks15jmw1Puw71mKHjjKMgF/kM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Z1NujI6mIKhUzAdDTLgfe8GrUrwpKOSR6x8xb5pLrzSROOZ3WVyixGEZewDfcBvnD
         P063OzaVG/nS32pSgW2G+PASJqmH+kkKOxtrga3gqPlpZuj7dKiJ2pJPGTzVbEhgl3
         iq6LpeR7t/3zcsxh9OvEpdEj1mPR7VIUUS3Bc8vYvVxGCmrG1R+sZpqRNCxU5h69lh
         z2zqC2s4wGNkyrcZNtZ8nxNAMls04YXtSQhrjpyjLEwfcmvXr/KciGv62UvQoqwd3z
         qxReZqmSGaVfC9deQI+E8mU2/q/bO2G2vPP2w4iVrZukDQ1WtTTV3hKVDfHJp0ABwm
         +3QvheM+aNOAA==
Message-ID: <274d09f6-2d07-920b-661b-95d899262c9b@collabora.com>
Date:   Fri, 15 Apr 2022 00:14:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v7 2/4] memory: tegra: Add MC error logging on tegra186
 onward
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>, digetx@gmail.com,
        krzysztof.kozlowski@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220413094012.13589-1-amhetre@nvidia.com>
 <20220413094012.13589-3-amhetre@nvidia.com>
 <eeb513c9-f010-c45b-bca6-a10c96691147@collabora.com>
 <534dbd19-b43b-63e6-69e0-3441dd224ef0@nvidia.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <534dbd19-b43b-63e6-69e0-3441dd224ef0@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 08:31, Ashish Mhetre wrote:
> 
> 
> On 4/14/2022 2:43 AM, Dmitry Osipenko wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 4/13/22 12:40, Ashish Mhetre wrote:
>>> +irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
>>>   {
>>>        struct tegra_mc *mc = data;
>>> +     unsigned int bit, channel;
>>>        unsigned long status;
>>> -     unsigned int bit;
>>>
>>> -     /* mask all interrupts to avoid flooding */
>>> -     status = mc_readl(mc, MC_INTSTATUS) & mc->soc->intmask;
>>> +     if (mc->soc->num_channels) {
>>> +             u32 global_status;
>>> +             int err;
>>> +
>>> +             global_status = mc_ch_readl(mc, MC_BROADCAST_CHANNEL,
>>> MC_GLOBAL_INTSTATUS);
>>
>> This will crash if mc->bcast_ch_regs = ERR_PTR(-EINVAL) for older dtbs.
> 
> Actually interrupts won't occur till we write MC_INTMASK register from
> broadcast channel with appropriate intmask value. I have added check in
> tegra_mc_probe() while registering irq which will write MC_INTMASK from
> broadcast only when mc->bcast_ch_regs is initialized i.e.
> !IS_ERR(mc->bcast_ch_regs).
> So interrupt handler won't be triggered at all if
> mc->bcast_ch_regs = ERR_PTR(-EINVAL).
> 

Should be cleaner to set mc->bcast_ch_regs to NULL anyways. The ERR_PTR
doesn't add much value and only makes code less readable.
