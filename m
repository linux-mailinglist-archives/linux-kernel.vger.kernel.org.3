Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9820B55757F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiFWIcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiFWIcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:32:10 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551F0488BA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 01:32:07 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 25N8FfJP034709;
        Thu, 23 Jun 2022 16:15:41 +0800 (GMT-8)
        (envelope-from kuohsiang_chou@aspeedtech.com)
Received: from localhost.localdomain.com (192.168.2.148) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 23 Jun
 2022 16:31:22 +0800
From:   KuoHsiang Chou <kuohsiang_chou@aspeedtech.com>
To:     <tzimmermann@suse.de>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     <airlied@redhat.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <kuohsiang_chou@aspeedtech.com>, <hungju_huang@aspeedtech.com>,
        <luke_chen@aspeedtech.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH v1] drm/ast: Fixed the casting issue reported by sparse
Date:   Thu, 23 Jun 2022 16:31:16 +0800
Message-ID: <20220623083116.35365-1-kuohsiang_chou@aspeedtech.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <d6c93aa6-db63-2e16-83f3-057cef30e9d4@suse.de>
References: <d6c93aa6-db63-2e16-83f3-057cef30e9d4@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.148]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 25N8FfJP034709
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V1:
1.Fixed sparse:cast truncates bits form constant value ()cast
  truncates bits from constant value (ffffffffffffff00 becomes 0)

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: KuoHsiang Chou <kuohsiang_chou@aspeedtech.com>
---
 drivers/gpu/drm/ast/ast_dp.c  | 8 ++++----
 drivers/gpu/drm/ast/ast_drv.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
index f573d5824..2c71b8eef 100644
--- a/drivers/gpu/drm/ast/ast_dp.c
+++ b/drivers/gpu/drm/ast/ast_dp.c
@@ -34,7 +34,7 @@ int ast_astdp_read_edid(struct drm_device *dev, u8 *ediddata)
 		 * CRE4[7:0]: Read-Pointer for EDID (Unit: 4bytes); valid range: 0~64
 		 */
 		ast_set_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xE4,
-					(u8) ~ASTDP_EDID_READ_POINTER_MASK, (u8) i);
+					ASTDP_AND_CLEAR_MASK, (u8) i);
 		j = 0;

 		/*
@@ -274,8 +274,8 @@ void ast_dp_set_mode(struct drm_crtc *crtc, struct ast_vbios_mode_info *vbios_mo
 	 * CRE1[7:0]: MISC1 (default: 0x00)
 	 * CRE2[7:0]: video format index (0x00 ~ 0x20 or 0x40 ~ 0x50)
 	 */
-	ast_set_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xE0, (u8) ~ASTDP_CLEAR_MASK,
+	ast_set_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xE0, ASTDP_AND_CLEAR_MASK,
 				ASTDP_MISC0_24bpp);
-	ast_set_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xE1, (u8) ~ASTDP_CLEAR_MASK, ASTDP_MISC1);
-	ast_set_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xE2, (u8) ~ASTDP_CLEAR_MASK, ModeIdx);
+	ast_set_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xE1, ASTDP_AND_CLEAR_MASK, ASTDP_MISC1);
+	ast_set_index_reg_mask(ast, AST_IO_CRTC_PORT, 0xE2, ASTDP_AND_CLEAR_MASK, ModeIdx);
 }
diff --git a/drivers/gpu/drm/ast/ast_drv.h b/drivers/gpu/drm/ast/ast_drv.h
index a34db4380..2e44b971c 100644
--- a/drivers/gpu/drm/ast/ast_drv.h
+++ b/drivers/gpu/drm/ast/ast_drv.h
@@ -433,7 +433,7 @@ int ast_mode_config_init(struct ast_private *ast);
  */
 #define ASTDP_MISC0_24bpp			BIT(5)
 #define ASTDP_MISC1				0
-#define ASTDP_CLEAR_MASK			GENMASK(7, 0)
+#define ASTDP_AND_CLEAR_MASK		0x00

 /*
  * ASTDP resoultion table:

base-commit: ab3bfa333f25d26bb8bf414419f9a2e6a46a141f
--
2.27.0

