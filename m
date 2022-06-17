Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10A554F722
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382168AbiFQL6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382186AbiFQL6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:58:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F672B26F;
        Fri, 17 Jun 2022 04:58:16 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:faf2:1a12:f903:cc5e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 433E56601856;
        Fri, 17 Jun 2022 12:58:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655467095;
        bh=3gDGpkk06mAHtR7r2AdzFP7ojDo8eosyId0TYaAzb0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V7ijhT1PVDl59M55MviVPo+G6c0DxIIFvfRu69WWtAtXq/iaVJqQQmk1H3Og4NeP7
         9h5bCty+9M24d82c3OiJ52fVcagAyjAzEesEjqrBb002UmANOLi3tBXue4EDrdz2QM
         na0bYj4KWvuB0ooFjuERsuY9w6yFrmzhBz5xqnuptTieA2IzMOLWdmz+PUpFTIPYip
         /cBvjF9pRhcWNPiDDtqv08/g1pdl8Ei4U4a1HoiQbuBFeMpFlrInjkWdelRAmTLhaK
         EJtjNHhBkIMb3hSwifY7alxjuuUp1AExSaiYr7V1TuO0JIMhuqvw//S7kuytSBEZXX
         emR9803mvXbxw==
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
Subject: [PATCH 7/7] media: hantro: Allows luma and chroma depth to be different
Date:   Fri, 17 Jun 2022 13:58:02 +0200
Message-Id: <20220617115802.396442-8-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220617115802.396442-1-benjamin.gaignard@collabora.com>
References: <20220617115802.396442-1-benjamin.gaignard@collabora.com>
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
---
 drivers/staging/media/hantro/hantro_hevc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/media/hantro/hantro_hevc.c b/drivers/staging/media/hantro/hantro_hevc.c
index 85688a4df166..26b1329893f7 100644
--- a/drivers/staging/media/hantro/hantro_hevc.c
+++ b/drivers/staging/media/hantro/hantro_hevc.c
@@ -156,9 +156,6 @@ static int tile_buffer_reallocate(struct hantro_ctx *ctx)
 
 int hantro_hevc_validate_sps(struct hantro_ctx *ctx, const struct v4l2_ctrl_hevc_sps *sps)
 {
-	if (sps->bit_depth_luma_minus8 != sps->bit_depth_chroma_minus8)
-		/* Luma and chroma bit depth mismatch */
-		return -EINVAL;
 	if (sps->bit_depth_luma_minus8 != 0 && sps->bit_depth_luma_minus8 != 2)
 		/* Only 8-bit and 10-bit is supported */
 		return -EINVAL;
-- 
2.32.0

