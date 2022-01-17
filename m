Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A6D4903FC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbiAQIhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:37:20 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:21882 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbiAQIhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:37:19 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 20H8TxNu080890;
        Mon, 17 Jan 2022 16:29:59 +0800 (GMT-8)
        (envelope-from kuohsiang_chou@aspeedtech.com)
Received: from localhost.localdomain.com (192.168.2.180) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 17 Jan
 2022 16:36:52 +0800
From:   KuoHsiang Chou <kuohsiang_chou@aspeedtech.com>
To:     <tzimmermann@suse.de>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     <airlied@redhat.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <kuohsiang_chou@aspeedtech.com>, <arc_sung@aspeedtech.com>,
        <tommy_huang@aspeedtech.com>, <hungju_huang@aspeedtech.com>,
        <luke_chen@aspeedtech.com>
Subject: [PATCH] drm/ast: Create threshold values for AST2600
Date:   Mon, 17 Jan 2022 16:36:43 +0800
Message-ID: <20220117083643.41493-1-kuohsiang_chou@aspeedtech.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.180]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 20H8TxNu080890
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The threshold value is used for AST2600 only.

Signed-off-by: KuoHsiang Chou <kuohsiang_chou@aspeedtech.com>
---
 drivers/gpu/drm/ast/ast_mode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index 1c7a57a03..7f2e248a6 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -471,7 +471,10 @@ static void ast_set_color_reg(struct ast_private *ast,
 static void ast_set_crtthd_reg(struct ast_private *ast)
 {
 	/* Set Threshold */
-	if (ast->chip == AST2300 || ast->chip == AST2400 ||
+	if (ast->chip == AST2600) {
+		ast_set_index_reg(ast, AST_IO_CRTC_PORT, 0xa7, 0xe0);
+		ast_set_index_reg(ast, AST_IO_CRTC_PORT, 0xa6, 0xa0);
+	} else if (ast->chip == AST2300 || ast->chip == AST2400 ||
 	    ast->chip == AST2500) {
 		ast_set_index_reg(ast, AST_IO_CRTC_PORT, 0xa7, 0x78);
 		ast_set_index_reg(ast, AST_IO_CRTC_PORT, 0xa6, 0x60);
--
2.27.0

