Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C465481DC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239759AbiFMIPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239778AbiFMINX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:13:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0ABEB3;
        Mon, 13 Jun 2022 01:13:18 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7B924660163F;
        Mon, 13 Jun 2022 09:13:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655107997;
        bh=nngcLlLkWokhulYNje5MIUVohalGmGQRGzNdGDIqhOg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oUJLCpDwf6d8vCEwFuLYeiFLaqPJ3EL68/bcBr6sbAbGzc+N/DXSCCdHMIGrwe9ml
         bN1WxFu0/szl4ZkMs77VDe868k+7i2zq94TTq/sYBpB+AZLVdeyxCfWdHoRSvXvqfw
         78roJdyviEA8KQtMfXF3SN579GsYRv8qwbkHmrHXAFURrEC44PsMKIdobYnmyq9bLx
         PgY6B9oTiBQclhsLYbiZM1R55H+F7GMMsgy76kt8n5wNyz91LluFdLVpUH0HnoeQQe
         6Sb0GPrzbO1qFd5SeZVpBoCwqnt5uJOWy6RFQdX0NkmV2fN4m1diJhIc7Wzroyef2H
         PcqPencC5Of5g==
Message-ID: <80c7fa61-e25a-fc45-bdcb-60ac3796b96e@collabora.com>
Date:   Mon, 13 Jun 2022 10:13:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 6/6] iommu: mtk_iommu: Lookup phandle to retrieve
 syscon to pericfg
Content-Language: en-US
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@linaro.org
References: <20220609100802.54513-1-angelogioacchino.delregno@collabora.com>
 <20220609100802.54513-7-angelogioacchino.delregno@collabora.com>
 <db422fe4d0b5391ee2aacae989d7e48209e1095f.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <db422fe4d0b5391ee2aacae989d7e48209e1095f.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/06/22 07:32, Yong Wu ha scritto:
> On Thu, 2022-06-09 at 12:08 +0200, AngeloGioacchino Del Regno wrote:
>> On some SoCs (of which only MT8195 is supported at the time of
>> writing),
>> the "R" and "W" (I/O) enable bits for the IOMMUs are in the
>> pericfg_ao
>> register space and not in the IOMMU space: as it happened already
>> with
>> infracfg, it is expected that this list will grow.
> 
> Currently I don't see the list will grow. As commented before, In the
> lastest SoC, The IOMMU enable bits for IOMMU will be in ATF, rather
> than in this pericfg register region. In this case, Is this patch
> unnecessary? or we could add this patch when there are 2 SoCs use this
> setting at least?  what's your opinion?
> 

Perhaps I've misunderstood... besides, can you please check if there's any
other SoC (not just chromebooks, also smartphone SoCs) that need this logic?

Thanks,
Angelo


