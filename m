Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC7A471908
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 08:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhLLHPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 02:15:04 -0500
Received: from smtpbg604.qq.com ([59.36.128.82]:59988 "EHLO smtpbg604.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhLLHPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 02:15:03 -0500
X-QQ-mid: bizesmtp46t1639293297tac9mnvn
Received: from localhost.localdomain (unknown [182.132.179.213])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sun, 12 Dec 2021 15:14:55 +0800 (CST)
X-QQ-SSF: 01000000002000D0I000B00A0000000
X-QQ-FEAT: 8QKpqxZbV7FYtRzLYMIsptAal0aV5pn5hYkqAwSjoSxsCPGc+6SNiywpXuteq
        mVzKZwdqscScGXH8ot1LRy2u/ljJemuxh+mEAZMoyLNzfoOzgQChgaF7IZUd7rwpi36y291
        7aEBEVatFAEynuK3rogtM9PSyttSTg+42EhVABl4+tLvyQavESvYBldxtFo1891d0eIYjF+
        epuIxP263lEDKUOLMUxh+AjsSESkHYdXAQaH4Nz7jwxQDgJAREOiNdJ/7ueUUmJqWf0lJGQ
        ncOLrpj4UgCSSy/H1/h5iSgqWog67D3Cmbk+5RhLpFjR11T95kh0FNsmQw8cVOZy93Ug2pF
        kF9CL59Owfsi+AHBqXsOX3BSS/q8mb89RglyEOhY6UHdJu1gjs5MBt/Ynwnfg==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     frowand.list@gmail.com
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] of: unneed to initialise statics to 0 or NULL
Date:   Sun, 12 Dec 2021 15:14:54 +0800
Message-Id: <20211212071454.298251-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Static variables do not need to be initialised to 0 or NULL,
because compilers will initialise all uninitialised statics
to 0 or NULL. Thus, remove the unneeded initializations.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/of/pdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/pdt.c b/drivers/of/pdt.c
index 7eda43c66c91..37d02fcb81d0 100644
--- a/drivers/of/pdt.c
+++ b/drivers/of/pdt.c
@@ -40,7 +40,7 @@ static inline void irq_trans_init(struct device_node *dp) { }
 
 static char * __init of_pdt_build_full_name(struct device_node *dp)
 {
-	static int failsafe_id = 0; /* for generating unique names on failure */
+	static int failsafe_id; /* for generating unique names on failure */
 	const char *name;
 	char path[256];
 	char *buf;
@@ -67,7 +67,7 @@ static struct property * __init of_pdt_build_one_prop(phandle node, char *prev,
 					       void *special_val,
 					       int special_len)
 {
-	static struct property *tmp = NULL;
+	static struct property *tmp;
 	struct property *p;
 	int err;
 
-- 
2.34.1

