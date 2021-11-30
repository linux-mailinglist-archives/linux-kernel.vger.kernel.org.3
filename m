Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E897463000
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 10:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240371AbhK3JuA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 30 Nov 2021 04:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235310AbhK3JuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 04:50:00 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B32C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 01:46:41 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mrziW-0001tB-5w; Tue, 30 Nov 2021 10:46:28 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mrziU-0003cb-1z; Tue, 30 Nov 2021 10:46:26 +0100
Message-ID: <ea057e8b080a7f553ee45f282459090dca4fb4c6.camel@pengutronix.de>
Subject: Re: [PATCH v9 16/22] drm/mediatek: add ETHDR support for MT8195
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     "Nancy.Lin" <nancy.lin@mediatek.com>, CK Hu <ck.hu@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        singo.chang@mediatek.com, srv_heupstream@mediatek.com
Date:   Tue, 30 Nov 2021 10:46:26 +0100
In-Reply-To: <20211130033519.26086-17-nancy.lin@mediatek.com>
References: <20211130033519.26086-1-nancy.lin@mediatek.com>
         <20211130033519.26086-17-nancy.lin@mediatek.com>
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

Hi Nancy,

On Tue, 2021-11-30 at 11:35 +0800, Nancy.Lin wrote:
[...]
> +void mtk_ethdr_stop(struct device *dev)
> +{
> +	struct mtk_ethdr *priv = dev_get_drvdata(dev);
> +	struct mtk_ethdr_comp *mixer = &priv->ethdr_comp[ETHDR_MIXER];
> +
> +	writel(0, mixer->regs + MIX_EN);
> +	writel(1, mixer->regs + MIX_RST);
> +	reset_control_reset(devm_reset_control_array_get(dev, true, true));

Are these reset lines really shared with other hardware units, and more
specifically, are there other drivers that also try to control them?

If so, please use devm_reset_control_array_get_optional_shared().

Otherwise use devm_reset_control_array_get_optional_exclusive() instead.

If you really need to share the reset line with other hardware and have
to trigger it more than once, the only use case supported by the reset
framework is to use reset_control_reset() before starting the hardware
for each user and then reset_control_rearm() after stopping it for all
users (see [1]). That would both stop the reset from being triggered
while the hardware is active (before last _rearm) and allow another
reset once after all hardware is stopped.

[1] https://www.kernel.org/doc/html/latest/driver-api/reset.htm#triggering

Also, request the reset control once in the probe function, not every
time ETHDR is stopped. Otherwise you'll end up leaking devres memory

regards
Philipp
