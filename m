Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0D94FB3C3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 08:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244941AbiDKGgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 02:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244109AbiDKGgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 02:36:05 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690DD5F57;
        Sun, 10 Apr 2022 23:33:52 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id DB7D81F4107B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649658830;
        bh=u3uQuEDnE9EX2L4+tIGDl0Cqo3qLuBHUkok5AGR5HKE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=E4SbbvgsRYSjlYEcyx+QlzecVo8btv1iWtsyV18q/LB5p/7rOdWIsF38Z/9ozTjVM
         iO9jXi51hf3mFHqka7QGjl/NSjfeK2C8HqZlxEHXD9JtBYbGOUFigIjv/0qTtkQFah
         3fftiVGZTEgSicTKgwaLIaws6gZ3rg951Nv+XpLX1q3UXK93tIQyEaBqKb8hD06vBD
         uRIxgrytEmT1JzrbwsvnH0xusNOXedyBKhyZgB38KuAfEOsxTTGP/PVM2N7yeQemTq
         OCWCFbedOc2PcaO1kEBqVPOlZ4bUfILziWv1hZg7mXklLxC+m2Z8AGQ6k5+qFjAx37
         MNZiZAMcITjxA==
Message-ID: <0ce65e42-6567-9fd5-d959-3bc5aa0457eb@collabora.com>
Date:   Mon, 11 Apr 2022 09:33:46 +0300
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
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <ba28886f-be5d-9ab2-41d0-942609934263@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/11/22 09:05, Ashish Mhetre wrote:
> 
> 
> On 4/10/2022 7:48 PM, Dmitry Osipenko wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> 06.04.2022 08:24, Ashish Mhetre пишет:
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
>>> update memory controller DT node with MC channels\n");
>>> +             return 0;
>>> +     }
>>> +
>>> +     mc->bcast_ch_regs = devm_platform_ioremap_resource_byname(pdev,
>>> "mc-broadcast");
>>> +     if (IS_ERR(mc->bcast_ch_regs))
>>> +             return PTR_ERR(mc->bcast_ch_regs);
>>
>> Looks to me that you don't need to use of_property_count_elems_of_size()
>> and could only check the "mc-broadcast" presence to decide whether this
>> is an older DT.
>>
> Now that we are using reg-names in new DT, yes it'd be fine to just
> check mc-broadcast to decide it's a new or old DT.
> 
>> mc->bcast_ch_regs = devm_platform_ioremap_resource_byname(pdev,
>> "broadcast");
>> if (IS_ERR(mc->bcast_ch_regs)) {
>>          dev_warn(&pdev->dev, "Broadcast channel is missing, please
>> update your
>> device-tree\n");
>>          return PTR_ERR(mc->bcast_ch_regs);
>> }
> 
> return 0;
> 
> to avoid DT ABI break, right?

Yes, it should be "return 0".
