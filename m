Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688EC5A5191
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiH2QWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiH2QWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:22:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA7A8A7CB;
        Mon, 29 Aug 2022 09:22:14 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:3d67:aec0:f788:1143])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AC9776601F01;
        Mon, 29 Aug 2022 17:22:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661790133;
        bh=KNBM1Ycd4hgicIVPBAmq9OSHzMCSnL+16JukGewVOMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L6KP9dbqiR2QXE3ioXkmpSrTTs+yLaskjMI+VkZTz7k6mJPXv7s79Kw0FMOEIADYm
         fBrxFjWwqiN5tVgoUUNuFSREv2fOBm0B+0pOk0vN09BBa1CrTZkSpXfGnJGBs57dbY
         9fNxfwGHE2TVfIqzpC6b6Fu2d4PnbNIErbopE5VvXLvzYaKuEhhJRFd1ZEtTLdZQI4
         K9nv+Gc9VDlg/+4YzqSowQXWYiLHV+8f45im+K8xhmOPkN/3aCck3/d7mXO1Q9NWS+
         IElQA3jcbDiU/2idfWfZhXe20KEIL15Unb+c5MAZGaQVbyqQTN/cXb9CjSj3M3HZhd
         VcwrqzDUpVdDg==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, hverkuil@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        nicolas.dufresne@collabora.com, andrzej.p@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v3 7/7] media: hantro: Allows luma and chroma depth to be different
Date:   Mon, 29 Aug 2022 18:21:59 +0200
Message-Id: <20220829162159.881588-8-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220829162159.881588-1-benjamin.gaignard@collabora.com>
References: <20220829162159.881588-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luma and chroma depth are set on different hardware registers.
Even if they aren't identical the bitstream can be compliant
to HEVC specifications and decoded by the hardware.

With this patch TSUNEQBD_A_MAIN10_Technicolor_2 conformance test
is successfully decoded.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 drivers/media/platform/verisilicon/hantro_drv.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index 7c75922e2e98..8cb4a68c9119 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -271,9 +271,6 @@ static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
 	} else if (ctrl->id == V4L2_CID_STATELESS_HEVC_SPS) {
 		const struct v4l2_ctrl_hevc_sps *sps = ctrl->p_new.p_hevc_sps;
 
-		if (sps->bit_depth_luma_minus8 != sps->bit_depth_chroma_minus8)
-			/* Luma and chroma bit depth mismatch */
-			return -EINVAL;
 		if (sps->bit_depth_luma_minus8 != 0 && sps->bit_depth_luma_minus8 != 2)
 			/* Only 8-bit and 10-bit are supported */
 			return -EINVAL;
-- 
2.32.0

