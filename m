Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1337B4EB72D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 01:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241264AbiC2XyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 19:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241307AbiC2Xxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 19:53:41 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D2622321A;
        Tue, 29 Mar 2022 16:51:48 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id 6ED681F4422B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648597907;
        bh=et/XZn08cRQRjlbxlsEMHOWSiI9trad+rRAwptS/tho=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eU/CXz4oCKEM4/AAl48PB10SdUxcEOaB3Blt+zaWn43GTSWZJrgDJ8Ybev+Blw9Tv
         IT92GcGSNbrHHuAYrrXJz8AMihjNPjUbWhEvGrhP8IA3sQSQXoIfykLEPPiDaGdW26
         O/pR1/c8HSh8NGHxPi5s33YDLQniat0vBgAsfJoZk6pQi9qCEsalSag5lKUFfT9p6u
         qqiv2XAnhdKHMAPNgvcrn45clwjCCtd+0N9GtdTeC+pj2gvFa67dJPf3cnyr7OmVVw
         hMSS+WBHsd90sFoqVzrWJtAlhX8+phvoQu7GPqIlZGXpjNB5ISerbaZNWO3yK59M0s
         T55aaXozmguDA==
Message-ID: <dacf1be8-f20c-de41-5ae5-9dba5e351881@collabora.com>
Date:   Wed, 30 Mar 2022 02:51:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v5 2/4] memory: tegra: Add MC error logging on tegra186
 onward
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220316092525.4554-1-amhetre@nvidia.com>
 <20220316092525.4554-3-amhetre@nvidia.com>
 <168cf065-bc17-1ffc-8cc0-75775c7f3bcb@gmail.com>
 <ecdc86b4-c207-de89-a094-6923a5573ac6@nvidia.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <ecdc86b4-c207-de89-a094-6923a5573ac6@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/22 20:23, Ashish Mhetre wrote:
> 
> 
> On 3/19/2022 9:29 PM, Dmitry Osipenko wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> 16.03.2022 12:25, Ashish Mhetre пишет:
>>> diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
>>> index 92f810c55b43..6f115436e344 100644
>>> --- a/include/soc/tegra/mc.h
>>> +++ b/include/soc/tegra/mc.h
>>> @@ -203,6 +203,8 @@ struct tegra_mc_soc {
>>>        const struct tegra_smmu_soc *smmu;
>>>
>>>        u32 intmask;
>>> +     u32 int_channel_mask;
>>
>> ch_intmask
>>
> Okay, I will update,
> 
>>> +     bool has_addr_hi_reg;
>>>
>>>        const struct tegra_mc_reset_ops *reset_ops;
>>>        const struct tegra_mc_reset *resets;
>>> @@ -210,6 +212,8 @@ struct tegra_mc_soc {
>>>
>>>        const struct tegra_mc_icc_ops *icc_ops;
>>>        const struct tegra_mc_ops *ops;
>>> +
>>> +     int (*get_int_channel)(const struct tegra_mc *mc, int
>>> *mc_channel);
>>
>> This should be a part of tegra_mc_ops.
> 
> tegra_mc_ops is common for T186, T194 and T234 i.e. all of them use
> tegra186_mc_ops. get_int_channel function has to be differently
> implemented for all of these SOCs. So I had put it in tegra_mc_soc.

Then tegra_mc_ops shouldn't be common anymore?
