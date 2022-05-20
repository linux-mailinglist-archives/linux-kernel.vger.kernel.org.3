Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137D252EF69
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350975AbiETPka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350971AbiETPk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:40:28 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CB7163288;
        Fri, 20 May 2022 08:40:27 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id BD8201F465BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653061226;
        bh=yoKFIOuJFjcpwDMOjsEHzdGLdIc03w5D68Xc3yzKzAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jbpr2YTZeoUG+rwaC/OO4MDeTDKG2yZdpcZOPXhVSWOVID/70YrC7K+04roRBxWbQ
         2XWcDqf0XXWPxPqTYPV6HcnIepPxvVChCNor2WBBr7w6O4j/kFU6cKk6vP2Z+Z9dE5
         7tgmyu4ouwDDcQ0dtQp8e4PQRmB5tRIBJspFmBTBKpGkE66u1x51+FG/h/TQZNXV2D
         ZGUpKZVvuaNylRUK6SrqWYIxnWw4/mV6NR7KkJ4WR73Djtj6MkJvnMbv+3+fknfBxB
         w3GH+ndrbZBberSAFrHjC0BO5mZVe+/NaEf8hZzevRiT7UlgeAi566XzqEOih6eyld
         5TZZOfTB8t0cg==
Date:   Fri, 20 May 2022 11:40:20 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        p.zabel@pengutronix.de, angelogioacchino.delregno@collabora.com,
        chun-jie.chen@mediatek.com, wenst@chromium.org,
        runyang.chen@mediatek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v7 00/19] Cleanup MediaTek clk reset drivers and support
 SoCs
Message-ID: <20220520154020.dywardvr3silhjwk@notapiano>
References: <20220519125527.18544-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220519125527.18544-1-rex-bc.chen@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 08:55:08PM +0800, Rex-BC Chen wrote:
> In this series, we cleanup MediaTek clock reset drivers in clk/mediatek
> folder. MediaTek clock reset driver is used to provide reset control
> of modules controlled in clk, like infra_ao.
> 
> Changes for v7:
> 1. v7 is based on linux-next next-20220519 and Chen-Yu's series[1].
> 2. Add support for MT8186.
> 
> [1]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=643003
> 
> Changes for v6:
> 1. Add a new patch to support inuput argument index mode.
> 2. Revise definition in reset.h to index.
> 
> Rex-BC Chen (19):
>   clk: mediatek: reset: Add reset.h
>   clk: mediatek: reset: Fix written reset bit offset
>   clk: mediatek: reset: Refine and reorder functions in reset.c
>   clk: mediatek: reset: Extract common drivers to update function
>   clk: mediatek: reset: Merge and revise reset register function
>   clk: mediatek: reset: Revise structure to control reset register
>   clk: mediatek: reset: Support nonsequence base offsets of reset
>     registers
>   clk: mediatek: reset: Support inuput argument index mode
>   clk: mediatek: reset: Change return type for clock reset register
>     function
>   clk: mediatek: reset: Add new register reset function with device
>   clk: mediatek: reset: Add reset support for simple probe
>   dt-bindings: arm: mediatek: Add #reset-cells property for
>     MT8192/MT8195
>   dt-bindings: reset: mediatek: Add infra_ao reset index for
>     MT8192/MT8195
>   clk: mediatek: reset: Add infra_ao reset support for MT8192/MT8195
>   arm64: dts: mediatek: Add infra #reset-cells property for MT8192
>   arm64: dts: mediatek: Add infra #reset-cells property for MT8195
>   dt-bindings: reset: mediatek: Add infra_ao reset index for MT8186
>   dt-bindings: arm: mediatek: Add #reset-cells property for MT8186
>   clk: mediatek: reset: Add infra_ao reset support for MT8186

For the whole series:

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

And also

Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

on mt8192-asurada-spherion. PCIe resets work as intended by adding on the pcie
node 

+                       resets = <&infracfg MT8192_INFRA_RST2_PEXTP_PHY_SWRST>,
+                                <&infracfg MT8192_INFRA_RST4_PCIE_TOP_SWRST>;
+                       reset-names = "phy", "mac";

Thanks for the great work on this series, Rex!

Nícolas
