Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88171597E3A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 07:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243412AbiHRFty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 01:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243329AbiHRFtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 01:49:51 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6975C949
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 22:49:48 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 27I5UHL3001948;
        Thu, 18 Aug 2022 13:30:17 +0800 (GMT-8)
        (envelope-from kuohsiang_chou@aspeedtech.com)
Received: from localhost.localdomain.com (192.168.2.138) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 18 Aug
 2022 13:49:09 +0800
From:   KuoHsiang Chou <kuohsiang_chou@aspeedtech.com>
To:     <tzimmermann@suse.de>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     <airlied@redhat.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <kuohsiang_chou@aspeedtech.com>, <arc_sung@aspeedtech.com>,
        <tommy_huang@aspeedtech.com>, <hungju_huang@aspeedtech.com>,
        <luke_chen@aspeedtech.com>
Subject: [PATCH] drm/ast: Fix NO EDID on DP501
Date:   Thu, 18 Aug 2022 13:49:02 +0800
Message-ID: <20220818054902.40837-1-kuohsiang_chou@aspeedtech.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.138]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 27I5UHL3001948
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Corrected the definition of AST_DP501_PNP_CONNECTED.
2. Created the Base address for DP501 MCU.

Signed-off-by: KuoHsiang Chou <kuohsiang_chou@aspeedtech.com>
---
 drivers/gpu/drm/ast/ast_dp501.c | 10 ++++++++--
 drivers/gpu/drm/ast/ast_drv.h   |  2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_dp501.c b/drivers/gpu/drm/ast/ast_dp501.c
index 4f75a9efb..4693d68ca 100644
--- a/drivers/gpu/drm/ast/ast_dp501.c
+++ b/drivers/gpu/drm/ast/ast_dp501.c
@@ -180,7 +180,10 @@ void ast_set_dp501_video_output(struct drm_device *dev, u8 mode)

 static u32 get_fw_base(struct ast_private *ast)
 {
-	return ast_mindwm(ast, 0x1e6e2104) & 0x7fffffff;
+	if (ast->chip == AST2500)
+		return ast_mindwm(ast, 0x1e6e2104) & 0xfffffffe;
+	else
+		return ast_mindwm(ast, 0x1e6e2104) & 0x7fffffff;
 }

 bool ast_backup_fw(struct drm_device *dev, u8 *addr, u32 size)
@@ -257,7 +260,10 @@ static bool ast_launch_m68k(struct drm_device *dev)
 		ast_moutdwm(ast, 0x1e6e2000, 0x1688a8a8);

 		/* Launch FW */
-		ast_moutdwm(ast, 0x1e6e2104, 0x80000000 + boot_address);
+		if (ast->chip == AST2500)
+			ast_moutdwm(ast, 0x1e6e2104, boot_address | 0x00000001);
+		else
+			ast_moutdwm(ast, 0x1e6e2104, boot_address | 0x80000000);
 		ast_moutdwm(ast, 0x1e6e2100, 1);

 		/* Update Scratch */
diff --git a/drivers/gpu/drm/ast/ast_drv.h b/drivers/gpu/drm/ast/ast_drv.h
index 2e44b971c..81e1317d3 100644
--- a/drivers/gpu/drm/ast/ast_drv.h
+++ b/drivers/gpu/drm/ast/ast_drv.h
@@ -358,7 +358,7 @@ int ast_mode_config_init(struct ast_private *ast);

 #define AST_DP501_FW_VERSION_MASK	GENMASK(7, 4)
 #define AST_DP501_FW_VERSION_1		BIT(4)
-#define AST_DP501_PNP_CONNECTED		BIT(1)
+#define AST_DP501_PNP_CONNECTED		BIT(0)

 #define AST_DP501_DEFAULT_DCLK	65


base-commit: 8953e41fa70d4507c6f5508e030347f7eda3ba8a
--
2.27.0

