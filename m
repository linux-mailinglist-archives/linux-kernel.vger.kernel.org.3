Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF29511DD3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244347AbiD0RnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244409AbiD0RnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:43:08 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FF4D1166;
        Wed, 27 Apr 2022 10:39:44 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:2c00:b769:f52a:a984])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id EC0611F446E5;
        Wed, 27 Apr 2022 18:39:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651081183;
        bh=wubek6jsK6/qsanCIGdPiaJ1o3gzVzBo/gvth1wB/vo=;
        h=From:To:Cc:Subject:Date:From;
        b=Y79/wIxYTbOwPYixAGTaBBZNRB8zmd3SZGjCnvJfsNZuvLmEbWYnslZK5M6WvQ6P5
         JxK16BOcFIrkY3jGUv26y92R6MejCsgD6c6Z/mAZRflie9cpLpzuBvFPmWI17ul61U
         wr4M23odwjjKx+6B9eajZykjqQNi76CmliFGZpQpO1PWoTT7udjFd2SgYuP4y4yw6O
         gPLpFcV0XJME9s8onFeTdEdGiA3KcpSVdbXDj9cfU99FU9QqAPEc9tPhE2UbWZI8Wg
         TZxQUY4ak+HCJ5SHRwoOqJcWStTzGg9nitn/dWyrlaJDKieEbVyloWjjzLpA/Jyh4w
         Bow5OUVMSEyIQ==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        jon@nanocrew.net, aford173@gmail.com, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v2] media: hantro: HEVC: Fix tile info buffer value computation
Date:   Wed, 27 Apr 2022 19:39:36 +0200
Message-Id: <20220427173936.17092-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use pps->column_width_minus1[j] + 1 as value for the tile info buffer
instead of pps->column_width_minus1[j + 1].
The patch fixes DBLK_E_VIXS_2, DBLK_F_VIXS_2, DBLK_G_VIXS_2,
SAO_B_MediaTek_5, TILES_A_Cisco_2 and TILES_B_Cisco_1 tests in fluster.

Fixes: cb5dd5a0fa51 ("media: hantro: Introduce G2/HEVC decoder")

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
version 2:
- Add Fixes tag, thanks Dan

 drivers/staging/media/hantro/hantro_g2_hevc_dec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
index bb512389c1a5..ffeb2fbeefd2 100644
--- a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
+++ b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
@@ -74,7 +74,7 @@ static void prepare_tile_info_buffer(struct hantro_ctx *ctx)
 					no_chroma = 1;
 				for (j = 0, tmp_w = 0; j < num_tile_cols - 1; j++) {
 					tmp_w += pps->column_width_minus1[j] + 1;
-					*p++ = pps->column_width_minus1[j + 1];
+					*p++ = pps->column_width_minus1[j] + 1;
 					*p++ = h;
 					if (i == 0 && h == 1 && ctb_size == 16)
 						no_chroma = 1;
-- 
2.32.0

