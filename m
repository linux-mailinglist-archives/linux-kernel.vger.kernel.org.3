Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DB854F71A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382247AbiFQL6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381709AbiFQL6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:58:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DD7220FB;
        Fri, 17 Jun 2022 04:58:13 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:faf2:1a12:f903:cc5e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0F50A660179B;
        Fri, 17 Jun 2022 12:58:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655467091;
        bh=p1IL0WApAId0OF2roNkCC1LN0QMRN6h/Fzya6tDqTJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O6latk3LWVF1Zw3HOlI6NzxIuXB815MakCNbc3pJmtgKdofzf6w08jd57TXK/Eh50
         s9WBWe/hiDYqdPXNM8UQanOMXEkmE3GELVblXCsSRAIIpjUdiQy+FTtlAYxReVpQQr
         cMFITh4k19Q0S0AIv5FKNuU+YT9AtQzfeV43nsIm+QoOqnZ4ctJ6NnXpWygkBaomOH
         MsgIL7ELBB0sbMdm9/UtCkIPeJMm6yMv4ZYJjOB7A8IvWiGDrenDxyjeiiqdtR3fJD
         365J04MD9DgFqFKYXBV/p1g1lvqsBC+6yB4FyFC877kowvJ/hAT4b5LYN00pmv+fQ2
         UC2aJjRGXK+Bw==
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
Subject: [PATCH 1/7] media: hantro: Store HEVC bit depth in context
Date:   Fri, 17 Jun 2022 13:57:56 +0200
Message-Id: <20220617115802.396442-2-benjamin.gaignard@collabora.com>
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

Store HEVC bit depth in context.
Bit depth is equal to hevc sps bit_depth_luma_minus8 + 8.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/staging/media/hantro/hantro_hevc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/media/hantro/hantro_hevc.c b/drivers/staging/media/hantro/hantro_hevc.c
index 5984c5fa6f83..dcb5c8703b6e 100644
--- a/drivers/staging/media/hantro/hantro_hevc.c
+++ b/drivers/staging/media/hantro/hantro_hevc.c
@@ -163,6 +163,8 @@ int hantro_hevc_validate_sps(struct hantro_ctx *ctx, const struct v4l2_ctrl_hevc
 		/* Only 8-bit is supported */
 		return -EINVAL;
 
+	ctx->bit_depth = sps->bit_depth_luma_minus8 + 8;
+
 	/*
 	 * for tile pixel format check if the width and height match
 	 * hardware constraints
-- 
2.32.0

