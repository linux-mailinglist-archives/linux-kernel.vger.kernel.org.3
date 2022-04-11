Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B99C4FB1A4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 04:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244335AbiDKCRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 22:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238514AbiDKCRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 22:17:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4500760E2;
        Sun, 10 Apr 2022 19:15:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD86A61034;
        Mon, 11 Apr 2022 02:15:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27AAAC385A4;
        Mon, 11 Apr 2022 02:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649643318;
        bh=HrfWFfTOe6j154rTRQZaqm2rUNiKm4IP07T469feT/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nFFEDTg+4TToywMjDQAyVK4Sm6uES5N8uq0ECkFg/s59aFORXQIraYALz/8TEzIVj
         2LKpDmWyJX42tlLPtiEr4I9Gt7yc8yDIt2EpwKTHQeBbNsU7KdDZeZZi1ca7j9kMub
         PxnufUDnVkOkQrq5Mn/IPKAHohFINKwiLsBCovPwYGff4p+9BC9gYT6aoiszmeqs5N
         I9UvPgOZrkmmfwUpWQ7ZY0q0j+Hqhj9j5absFY6WL+NJAE5eiDI6x1Xguwt+BLW+ev
         RuUGzJhoennVgSVLYmMDdytVCXjQZNkwzgRDQGK6xoe7TVO/ShrPZA9M31BFLyoxT6
         b1iA6lN9O98IQ==
Date:   Mon, 11 Apr 2022 10:15:07 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Heiko Schocher <hs@denx.de>, Jacky Bai <ping.bai@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Kuldeep Singh <kuldeep.singh@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olof Johansson <olof@lixom.net>, Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] arm64: prepare and add verdin imx8m plus support
Message-ID: <20220411021507.GG129381@dragon>
References: <20220408145725.812566-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408145725.812566-1-marcel@ziswiler.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 04:57:22PM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> 
> Add DMA properties to uart2 node of the base i.MX 8M Plus device tree,
> add toradex,verdin-imx8mp et al. to dt-bindings and finally, add
> initial support for Verdin iMX8M Plus.
> 
> Changes in v3:
> - Add missing audio codec todo on development board as well.
> - Actually define scl/sda-gpios for Verdin I2C_2_DSI aka i2c2. Also
>   pointed out by Laurent. Thanks!
> - Update PMIC LDO4 and I2C level shifter enablement comment.
> - Fix USDHC2_VSELECT sleep pinctrl value and add a comment.
> - Add comment about lowering frequency on Verdin I2C_2_DSI as suggested
>   by Laurent.
> - Re-based on top of Shawn's latest for-next based on 5.18-rc1.
> 
> Changes in v2:
> - Add Laurent's reviewed-by tag.
> - Add Krzysztof's reviewed-by tag.
> - Fix capitalisation of verdin in comments as reported by Laurent.
> - Add/modify todo comments as suggested by Laurent.
> - Add Laurent's reviewed- and tested-by tags.
> 
> Marcel Ziswiler (3):
>   arm64: dts: imx8mp: add uart2 dma
>   dt-bindings: arm: fsl: add toradex,verdin-imx8mp et al.
>   arm64: dts: freescale: add initial support for verdin imx8m plus

Applied all, thanks!
