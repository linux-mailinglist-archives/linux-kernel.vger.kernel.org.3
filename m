Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AA04AABD8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381569AbiBES6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:58:17 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:42281 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381257AbiBES4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:56:18 -0500
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 47E8424001A;
        Sat,  5 Feb 2022 18:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644087376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hEbyDZAwj+JYZxX167CZrODGu9JM7Aoq0VHUoYRotHU=;
        b=Dz+e1zpnMLO2pW/kckDcXmsMAomIsyZleOtFL28GuZRBhtcrnujPMlVIoBZSK7ZdJ31SNm
        7WQqXGsA3fF2iJffd3ozdJDxF0Z/dKD1VVvSk0ApUroAc7D57Yzw5ngTIvPwEMd7Zk+IPe
        bLEdMwQu8okaquqr1QggIpA+3S8WRbYB47VrbE8JghAHMPyBlPAEWqDpCCrUqRlIEM3enn
        jtY1CaLSkYVzBAR/SAGG4IMGztZkUpyjOhygun2InLn+FBocUjvVybnq8j/dokTjRfCe8g
        yfCsVCeJnj1l3xyfFSkr4bf4HbaVxFnwDTDVdopYZok+C77Y3czLy2hL6dOYaw==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 57/66] media: sun6i-csi: Request a shared interrupt
Date:   Sat,  5 Feb 2022 19:54:20 +0100
Message-Id: <20220205185429.2278860-58-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Request our interrupt shared since it is typically shared with the isp
block. The interrupt routine looks good to go for shared irq.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index e3ac7dad86ae..b8e925f6bc09 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -285,8 +285,8 @@ static int sun6i_csi_resources_setup(struct sun6i_csi_device *csi_dev,
 		goto error_clk_rate_exclusive;
 	}
 
-	ret = devm_request_irq(dev, irq, sun6i_csi_isr, 0, SUN6I_CSI_NAME,
-			       csi_dev);
+	ret = devm_request_irq(dev, irq, sun6i_csi_isr, IRQF_SHARED,
+			       SUN6I_CSI_NAME, csi_dev);
 	if (ret) {
 		dev_err(dev, "failed to request interrupt\n");
 		goto error_clk_rate_exclusive;
-- 
2.34.1

