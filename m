Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4607D46B582
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhLGITy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 7 Dec 2021 03:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbhLGITx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:19:53 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F11C061748
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 00:16:24 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1muVe2-0001sY-Li; Tue, 07 Dec 2021 09:16:14 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1muVdz-0002lm-6b; Tue, 07 Dec 2021 09:16:11 +0100
Message-ID: <6251f4b5a886bc3276d72c5c33118cfb6ac2bf5b.camel@pengutronix.de>
Subject: Re: [RFC PATCH 2/3] media: platform: Add CRU driver for RZ/G2L SoC
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Niklas =?ISO-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Date:   Tue, 07 Dec 2021 09:16:11 +0100
In-Reply-To: <20211207012351.15754-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211207012351.15754-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
         <20211207012351.15754-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-12-07 at 01:23 +0000, Lad Prabhakar wrote:
[...]
> +static int rzg2l_cru_probe(struct platform_device *pdev)
> +{
> +	struct rzg2l_cru_dev *cru;
> +	struct v4l2_ctrl *ctrl;
> +	int irq, ret;
> +
> +	cru = devm_kzalloc(&pdev->dev, sizeof(*cru), GFP_KERNEL);
> +	if (!cru)
> +		return -ENOMEM;
> +
> +	cru->dev = &pdev->dev;
> +	cru->info = of_device_get_match_data(&pdev->dev);
> +
> +	cru->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(cru->base))
> +		return PTR_ERR(cru->base);
> +
> +	irq = platform_get_irq(pdev, 1);
> +	if (irq < 0)
> +		return irq;
> +
> +	cru->vclk = clk_get(&pdev->dev, "vclk");
> +	if (IS_ERR(cru->vclk))
> +		return PTR_ERR(cru->vclk);

devm_clk_get()?
Don't mix devm and non-devm functions like this, all devm functions
should be placed first.

> +	cru->cmn_restb = devm_reset_control_get_by_index(&pdev->dev, 0);

Your binding has reset-names defined, please request reset controls by
name. Use devm_reset_control_get_explicit() instead, same below.

> +	if (IS_ERR(cru->cmn_restb)) {
> +		dev_err(&pdev->dev, "failed to get cpg cmn_restb\n");
> +		return PTR_ERR(cru->cmn_restb);

These could return -EPROBE_DEFER, I suggest to

		return dev_err_probe(&pdev->dev, PTR_ERR(cru->cmn_restb),
				     "failed to get cpg cmn_restb\n");

instead, same below.

> +	}
> +	cru->presetn = devm_reset_control_get_by_index(&pdev->dev, 1);
> +	if (IS_ERR(cru->presetn)) {
> +		dev_err(&pdev->dev, "failed to get cpg presetn\n");
> +		return PTR_ERR(cru->presetn);
> +	}
> +	cru->aresetn = devm_reset_control_get_by_index(&pdev->dev, 2);
> +	if (IS_ERR(cru->aresetn)) {
> +		dev_err(&pdev->dev, "failed to get cpg aresetn\n");
> +		return PTR_ERR(cru->aresetn);
> +	}

regards
Philipp
