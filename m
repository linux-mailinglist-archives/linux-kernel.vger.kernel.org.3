Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78F04FBAA2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241800AbiDKLQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiDKLQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:16:01 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAE513D;
        Mon, 11 Apr 2022 04:13:48 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id D0AEF1F4023C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649675626;
        bh=qXNSUAatAu+49KD5X1wMrep6ovWzzUkN4hPQhFlLpHo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IVYZr2Lw1IHAxdafW4UAznDuUStmuDMak/mGVhX2OPQBC97OvReLzXM7w6GjTI4od
         ujm+N0VxeBYFIU37jqFRai/sKBgAnp3ecq7ztk65C5WTeXu1vhMhXVibxY1ge2fTQC
         mLFHwgqKOotEr+6M4xTsLIlBfRfVQhyjXOm7VGHeKrWnfY+tWwJWirBytngkrbBn0g
         pBeOSKsVKdbuQSxyA1p8ayMTouZpGU1nODpAow528sWt/4izxgd+6O3DkIvzS9Hb/0
         hyeyiMdRtIXFek7ZljMoOK5eQ3wl4ymhy/sxJfgGCF7HgtH/u3/te7qSBOKFU1ILKD
         Sp1HIRmWKllCw==
Message-ID: <c3e6a50f-c098-5165-a596-ee386ac533e8@collabora.com>
Date:   Mon, 11 Apr 2022 14:13:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v6 1/4] memory: tegra: Add memory controller channels
 support
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        krzysztof.kozlowski@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     vdumpa@nvidia.com, Snikam@nvidia.com
References: <20220406052459.10438-1-amhetre@nvidia.com>
 <20220406052459.10438-2-amhetre@nvidia.com>
 <3bbbffff-6aa3-7068-6f0c-4372d53daf94@gmail.com>
 <ba28886f-be5d-9ab2-41d0-942609934263@nvidia.com>
 <0ce65e42-6567-9fd5-d959-3bc5aa0457eb@collabora.com>
 <16d5c86b-cb04-5f57-7923-724850ce2633@nvidia.com>
 <185f72b6-e6a1-3062-5f36-864973d12ec5@collabora.com>
 <3414a89d-bb80-ec89-3605-e435c7656321@nvidia.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <3414a89d-bb80-ec89-3605-e435c7656321@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/11/22 12:18, Ashish Mhetre wrote:
> 
> 
> On 4/11/2022 1:05 PM, Dmitry Osipenko wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 4/11/22 10:28, Ashish Mhetre wrote:
>>>
>>>
>>> On 4/11/2022 12:03 PM, Dmitry Osipenko wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On 4/11/22 09:05, Ashish Mhetre wrote:
>>>>>
>>>>>
>>>>> On 4/10/2022 7:48 PM, Dmitry Osipenko wrote:
>>>>>> External email: Use caution opening links or attachments
>>>>>>
>>>>>>
>>>>>> 06.04.2022 08:24, Ashish Mhetre пишет:
>>>>>>> +     num_dt_channels =
>>>>>>> of_property_count_elems_of_size(pdev->dev.of_node, "reg",
>>>>>>> +                                                       reg_cells *
>>>>>>> sizeof(u32));
>>>>>>> +     /*
>>>>>>> +      * On tegra186 onwards, memory controller support multiple
>>>>>>> channels.
>>>>>>> +      * Apart from regular memory controller channels, there is one
>>>>>>> broadcast
>>>>>>> +      * channel and one for stream-id registers.
>>>>>>> +      */
>>>>>>> +     if (num_dt_channels < mc->soc->num_channels + 2) {
>>>>>>> +             dev_warn(&pdev->dev, "MC channels are missing, please
>>>>>>> update memory controller DT node with MC channels\n");
>>>>>>> +             return 0;
>>>>>>> +     }
>>>>>>> +
>>>>>>> +     mc->bcast_ch_regs =
>>>>>>> devm_platform_ioremap_resource_byname(pdev,
>>>>>>> "mc-broadcast");
>>>>>>> +     if (IS_ERR(mc->bcast_ch_regs))
>>>>>>> +             return PTR_ERR(mc->bcast_ch_regs);
>>>>>>
>>>>>> Looks to me that you don't need to use
>>>>>> of_property_count_elems_of_size()
>>>>>> and could only check the "mc-broadcast" presence to decide whether
>>>>>> this
>>>>>> is an older DT.
>>>>>>
>>>>> Now that we are using reg-names in new DT, yes it'd be fine to just
>>>>> check mc-broadcast to decide it's a new or old DT.
>>>>>
>>>>>> mc->bcast_ch_regs = devm_platform_ioremap_resource_byname(pdev,
>>>>>> "broadcast");
>>>>>> if (IS_ERR(mc->bcast_ch_regs)) {
>>>>>>            dev_warn(&pdev->dev, "Broadcast channel is missing, please
>>>>>> update your
>>>>>> device-tree\n");
>>>>>>            return PTR_ERR(mc->bcast_ch_regs);
>>>>>> }
>>>>>
>>>>> return 0;
>>>>>
>>>>> to avoid DT ABI break, right?
>>>>
>>>> Yes, it should be "return 0".
>>>
>>> But if we "return 0" from here, then what about the case when ioremap()
>>> actually fails with new DT i.e. when broadcast reg is present in DT?
>>> In that case error should be returned and probe should be failed, right?
>>
>> You should check for the -ENOENT.
> 
> I checked __devm_ioremap_resource(), it returns -EINVAL if given
> resource is not present. So should we check for -EINVAL instead?

Yes
