Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906E34EB6F9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 01:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241028AbiC2XuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 19:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240992AbiC2XuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 19:50:02 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3431E9BBB6;
        Tue, 29 Mar 2022 16:48:16 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id EC0281F40F3A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648597694;
        bh=5RCxnQpK5I7Y2zWLKGLxBiVPTh/yCn+uO0KyYdxQQQ8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=a9w3F/vzA0sFlOCcLd85ycKnYywA+CP5LeOCfthZ1gDdaKR6rF7wb+pGb1w3Lzsxb
         8sKZMKFgzrGhqWiKyZhCBP7uOCaZF2rASpfVv1lDWpm/C6Xt7K67TGxiMUSg6S+/he
         PK40aipOdT3Am2PfAWvr/S08mVe9IdvC++qY7+BIm/X12tiJMw6OB/8oo7mM9H0cB8
         /4+gpdn+u+thh9lB0dL8yVtGxPULDQDas6PMYX53E5B4ZV6nBFBxbiaP0ygVJ9Vvx8
         xXAcf1mdKKJGAbgf+K4GQw+GjQ+yMA46G0hGGJoeI0furZEDcXIJNvh9CWQMRe19+w
         UF73voLivci6A==
Message-ID: <22eb6b37-3bcd-71ab-f99f-dc059043b56b@collabora.com>
Date:   Wed, 30 Mar 2022 02:48:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v5 1/4] memory: tegra: Add memory controller channels
 support
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220316092525.4554-1-amhetre@nvidia.com>
 <20220316092525.4554-2-amhetre@nvidia.com>
 <83bc4c12-13e3-d239-3845-a3541b1fbb2a@gmail.com>
 <981610f0-374a-b18f-8e3a-445b20edb257@nvidia.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <981610f0-374a-b18f-8e3a-445b20edb257@nvidia.com>
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

On 3/25/22 07:50, Ashish Mhetre wrote:
> 
> 
> On 3/19/2022 9:12 PM, Dmitry Osipenko wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> 16.03.2022 12:25, Ashish Mhetre пишет:
>>>  From tegra186 onwards, memory controller support multiple channels.
>>> Add support for mapping address spaces of these channels.
>>> Make sure that number of channels are as expected on each SOC.
>>> During error interrupts from memory controller, appropriate registers
>>> from these channels need to be accessed for logging error info.
>>>
>>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>>> ---
>>>   drivers/memory/tegra/mc.c       |  6 ++++
>>>   drivers/memory/tegra/tegra186.c | 52 +++++++++++++++++++++++++++++++++
>>>   drivers/memory/tegra/tegra194.c |  1 +
>>>   drivers/memory/tegra/tegra234.c |  1 +
>>>   include/soc/tegra/mc.h          |  7 +++++
>>>   5 files changed, 67 insertions(+)
>>>
>>> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
>>> index bf3abb6d8354..3cda1d9ad32a 100644
>>> --- a/drivers/memory/tegra/mc.c
>>> +++ b/drivers/memory/tegra/mc.c
>>> @@ -749,6 +749,12 @@ static int tegra_mc_probe(struct platform_device
>>> *pdev)
>>>        if (IS_ERR(mc->regs))
>>>                return PTR_ERR(mc->regs);
>>>
>>> +     if (mc->soc->ops && mc->soc->ops->map_regs) {
>>> +             err = mc->soc->ops->map_regs(mc, pdev);
>>> +             if (err < 0)
>>> +                     return err;
>>> +     }
>>> +
>>>        mc->debugfs.root = debugfs_create_dir("mc", NULL);
>>>
>>>        if (mc->soc->ops && mc->soc->ops->probe) {
>>> diff --git a/drivers/memory/tegra/tegra186.c
>>> b/drivers/memory/tegra/tegra186.c
>>> index 3d153881abc1..a8a45e6ff1f1 100644
>>> --- a/drivers/memory/tegra/tegra186.c
>>> +++ b/drivers/memory/tegra/tegra186.c
>>> @@ -139,11 +139,62 @@ static int tegra186_mc_probe_device(struct
>>> tegra_mc *mc, struct device *dev)
>>>        return 0;
>>>   }
>>>
>>> +static int tegra186_mc_map_regs(struct tegra_mc *mc,
>>> +                             struct platform_device *pdev)
>>> +{
>>> +     struct device_node *np = pdev->dev.parent->of_node;
>>> +     int num_dt_channels, reg_cells = 0;
>>> +     struct resource *res;
>>> +     int i, ret;
>>> +     u32 val;
>>> +
>>> +     ret = of_property_read_u32(np, "#address-cells", &val);
>>> +     if (ret) {
>>> +             dev_err(&pdev->dev, "missing #address-cells property\n");
>>> +             return ret;
>>> +     }
>>> +
>>> +     reg_cells = val;
>>> +
>>> +     ret = of_property_read_u32(np, "#size-cells", &val);
>>> +     if (ret) {
>>> +             dev_err(&pdev->dev, "missing #size-cells property\n");
>>> +             return ret;
>>> +     }
>>> +
>>> +     reg_cells += val;
>>> +
>>> +     num_dt_channels =
>>> of_property_count_elems_of_size(pdev->dev.of_node, "reg",
>>> +                                                       reg_cells *
>>> sizeof(u32));
>>> +     /*
>>> +      * On tegra186 onwards, memory controller support multiple
>>> channels.
>>> +      * Apart from regular memory controller channels, there is one
>>> broadcast
>>> +      * channel and one for stream-id registers.
>>> +      */
>>> +     if (num_dt_channels < mc->soc->num_channels + 2) {
>>> +             dev_warn(&pdev->dev, "MC channels are missing, please
>>> update\n");
>>
>> Update what?
>>
>>> +             return 0;
>>> +     }
>>> +
>>> +     mc->mcb_regs = devm_platform_get_and_ioremap_resource(pdev, 1,
>>> &res);
>>
>> Can't we name each reg bank individually in the DT and then use
>> devm_platform_ioremap_resource_byname()?
>>
> That can be done but I think current logic will be better as we can
> simply ioremap them by running in loop and assigning the mc_regs array.
> Otherwise there will be like 17 ioremap_byname() individual calls for
> Tegra194 and Tegra234.
> Will it be fine having that many ioremap_byname() calls?
> Also, Tegra186 has 5 channels which are less than Tegra194 and Tegra234.
> If we go with ioremap_byname() then we'll have to differentiate number
> of ioremap_byname() calls.
for (i = 0; i < mc->soc->num_channels; i++) {
	sprintf(name, "mc%u", i);
	err = devm_platform_ioremap_resource_byname(dev, name);
	...
}
