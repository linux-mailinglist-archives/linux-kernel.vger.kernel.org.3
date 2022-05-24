Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643A25329E2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 14:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237097AbiEXL7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 07:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbiEXL7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:59:54 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A7B62CC0;
        Tue, 24 May 2022 04:59:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: benjamin.gaignard)
        with ESMTPSA id 010CB1F43E41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653393592;
        bh=+BemnG7IWyoEHXSpYjscGO1bMMzKPeDF+hhkBNitIBM=;
        h=From:To:Cc:Subject:Date:From;
        b=K3+bhaI6Q5Q/I4eji0874puJaOxxq0oWYPZy7M43IM3f1rN31peZG0mu5pkFh27nB
         RoKA4hbPU0534Khatc8OXkyXPK2BVRM/QW4QWXudiYOZ1m6YAx3xtGECwLUaNRgYUK
         9W/0jmJkZP4TUQZ2DWWmTifeIor2KTlzcouE0m9TuE08CiymG6eb7hXqxuaYkwGIde
         rG38f1I8Uzz+sEL1p7Mj0BDW+Vep5ZvFlV3hOZXMJf86/RUMO0v6sQeUFPo2uveETL
         P22K3uQ+D1Q624Qd/THbySbnPhPTD1+VVXaUHWShBWXxi8opTb0hqV8QO0toEJwHBt
         iFZUz4eEGz4Dg==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v2] media: Hantro: Correct G2 init qp field
Date:   Tue, 24 May 2022 13:59:45 +0200
Message-Id: <20220524115945.2294015-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation said that g2 init_qp field use bits 24 to 30 of
the 8th register.
Change the field mask to be able to set 7 bits and not only 6 of them.

Conformance test INITQP_B_Main10_Sony_1 decoding is OK with this
patch.

Fixes: cb5dd5a0fa518 ("media: hantro: Introduce G2/HEVC decoder")
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
With this patch and the patches needed for 10-bit support
Fluster HEVC score is 137/147

version 2:
- Add Fixes tag

 drivers/staging/media/hantro/hantro_g2_regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/hantro/hantro_g2_regs.h b/drivers/staging/media/hantro/hantro_g2_regs.h
index 877d663a8181..82606783591a 100644
--- a/drivers/staging/media/hantro/hantro_g2_regs.h
+++ b/drivers/staging/media/hantro/hantro_g2_regs.h
@@ -107,7 +107,7 @@
 
 #define g2_start_code_e		G2_DEC_REG(10, 31, 0x1)
 #define g2_init_qp_old		G2_DEC_REG(10, 25, 0x3f)
-#define g2_init_qp		G2_DEC_REG(10, 24, 0x3f)
+#define g2_init_qp		G2_DEC_REG(10, 24, 0x7f)
 #define g2_num_tile_cols_old	G2_DEC_REG(10, 20, 0x1f)
 #define g2_num_tile_cols	G2_DEC_REG(10, 19, 0x1f)
 #define g2_num_tile_rows_old	G2_DEC_REG(10, 15, 0x1f)
-- 
2.32.0

