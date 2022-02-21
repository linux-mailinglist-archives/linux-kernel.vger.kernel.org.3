Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2CC4BD42A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 04:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344189AbiBUDVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 22:21:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344182AbiBUDVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 22:21:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA61741338;
        Sun, 20 Feb 2022 19:20:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7451D6113A;
        Mon, 21 Feb 2022 03:20:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4EAC340EB;
        Mon, 21 Feb 2022 03:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645413652;
        bh=BsOF4O9MtEGZQijN1hcpOFMalvpmK6xjtHuxCcuIQQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k4VXj7rF+wz86jES+PoZdNgQjJgM2iW96fedLE4I9DomqSA6llWHIZOFHOdK07D5H
         M99z4xpfQdLrGC0jSP27y7geI7M9aBPb4Vk+CbQxrs62ViFpNXtrDzsdCIiDw0Z97/
         2uEe6A2224Dbv3Pv9tlodMhrjl07sns0RsTETb1XG2TEoEwV/D4tPCcvS92hy8BFbd
         z/JDDYKIN1XY6GlLYvPZHF6vVInpGPKAiq7jAo7cFxqlBOEaVFsrQ/zcc1kHQd3yWT
         2ttjjUXHkbiUBuwUDdmGnokynoQRUXvUEqLfeDD+ejZB3klS0VdGzW/jSK9bP+a8Wd
         FFoPlzA4kZiWA==
Date:   Mon, 21 Feb 2022 11:20:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mp-evk: add support for I2C5
Message-ID: <20220221032046.GG2249@dragon>
References: <20220211153843.3721618-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211153843.3721618-1-hugo@hugovil.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 10:38:43AM -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Add support for i2c5, which is used to access the
> external I2C bus on connector J22 of the imx8mp-evk.
> 
> Limit the speed to 100kHz since this is an external I2C bus.
> 
> Disabled by default, since it is shared with the CAN1 bus.
> 
> To enable i2c5, you need to disable the CAN1 function, enable the i2c5
> function and also configure the CAN1/I2C5_SEL GPIO to HIGH to
> select i2c5 instead of CAN1. This can be done by defining a gpio-hog
> inside the pca6416 node, in your board device tree, like in this example:
> 
> &flexcan1 {
> 	status = "disabled";
> };
> 
> &i2c5 {
> 	status = "okay";
> };
> 
> &pca6416 {
> 	can1-i2c5-sel-hog {
> 		gpio-hog;
> 		gpios = <2 GPIO_ACTIVE_HIGH>;
> 		output-high;
> 		line-name = "can1-i2c5-sel";
> 	};
> };
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Applied, thanks!
