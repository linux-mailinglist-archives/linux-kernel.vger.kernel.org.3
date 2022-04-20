Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C098450822B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359790AbiDTHdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbiDTHdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:33:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E614E627C;
        Wed, 20 Apr 2022 00:30:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F230618AF;
        Wed, 20 Apr 2022 07:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1DAC385A0;
        Wed, 20 Apr 2022 07:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650439816;
        bh=+EDTmtai/jQZPWiRlzQLKQkboIqyWdx84ej+J0tgCT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lbzpvm/rXJqIP40ZLzhNxJqSNboD4Hfk+B9K54hBNd9SBa1jZSKJAq2lqjHx5lTiF
         mHqnxAuKK9c96NUFSxyh9indJmJNNrFm60iDqkFLKpSBXKxorqWucVtDyZ4Rak6JAf
         tkWpFesOVCPMSmHBmRJgtbWu/RPnPFf4ojkPRdkbJpfkztunS9KhCVQVBBQjtqWM46
         KCAxxbGuDm+ycKV08gp9I0xd/vBXuTSv3ZScZh4X0VpsBD8Xwnd3TefnrnK+N6O/9B
         TLysoHxyA4HDXUahRW9izrVaarTquVdArJyMsTK1QHAgD20fmAbYVTFYXIH6hUhaaE
         K9CmiG516V9AA==
Date:   Wed, 20 Apr 2022 13:00:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, kishon@ti.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, andrzej.hajda@intel.com,
        narmstrong@baylibre.com, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, agx@sigxcpu.org,
        robert.chiras@nxp.com, martin.kepplinger@puri.sm
Subject: Re: [PATCH resend v8 0/5] phy: phy-fsl-imx8-mipi-dphy: Add i.MX8qxp
 LVDS PHY mode support
Message-ID: <Yl+2hOIcr6CrOv+T@matsya>
References: <20220419010852.452169-1-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419010852.452169-1-victor.liu@nxp.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-04-22, 09:08, Liu Ying wrote:
> Hi,
> 
> This is the v8 series to add i.MX8qxp LVDS PHY mode support for the Mixel
> PHY in the Freescale i.MX8qxp SoC.
> 
> The Mixel PHY is MIPI DPHY + LVDS PHY combo, which can works in either
> MIPI DPHY mode or LVDS PHY mode.  The PHY mode is controlled by i.MX8qxp
> SCU firmware.  The PHY driver would call a SCU function to configure the
> mode.
> 
> The PHY driver is already supporting the Mixel MIPI DPHY in i.MX8mq SoC,
> where it appears to be a single MIPI DPHY.
> 
> 
> Patch 1/5 sets PHY mode in the Northwest Logic MIPI DSI host controller
> bridge driver, since i.MX8qxp SoC embeds this controller IP to support
> MIPI DSI displays together with the Mixel PHY.
> 
> Patch 2/5 allows LVDS PHYs to be configured through the generic PHY functions
> and through a custom structure added to the generic PHY configuration union.
> 
> Patch 3/5 converts mixel,mipi-dsi-phy plain text dt binding to json-schema.
> 
> Patch 4/5 adds dt binding support for the Mixel combo PHY in i.MX8qxp SoC.
> 
> Patch 5/5 adds the i.MX8qxp LVDS PHY mode support in the Mixel PHY driver.

Applied patch 2-5 to phy-next, thanks

-- 
~Vinod
