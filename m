Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07A25112A6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358923AbiD0Hjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358904AbiD0Hjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:39:33 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5537EA66E1;
        Wed, 27 Apr 2022 00:36:19 -0700 (PDT)
X-UUID: dcba21c0319d4221b04a69ce7f6291ab-20220427
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:029bc05d-2773-494e-be7a-08c748ab380e,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:149fde2e-6199-437e-8ab4-9920b4bc5b76,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: dcba21c0319d4221b04a69ce7f6291ab-20220427
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1086870149; Wed, 27 Apr 2022 15:36:11 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 27 Apr 2022 15:36:10 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 27 Apr 2022 15:36:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Apr 2022 15:36:10 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-modules@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <yj.chiang@mediatek.com>,
        <lecopzer.chen@mediatek.com>, <atomlin@redhat.com>
Subject: [RESEND PATCH] module: show disallowed symbol name for inherit_taint()
Date:   Wed, 27 Apr 2022 15:36:06 +0800
Message-ID: <20220427073606.29752-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error log for inherit_taint() doesn't really help to find the
symbol which violates GPL rules.

For example,
if a module has 300 symbol and includes 50 disallowed symbols,
the log only shows the content below and we have no idea what symbol is.
    AAA: module using GPL-only symbols uses symbols from proprietary module BBB.

It's hard for user who doesn't really know how the symbol was parsing.

This patch add symbol name to tell the offending symbols explicitly.
    AAA: module using GPL-only symbols uses symbols SSS from proprietary module BBB.

Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
---
 kernel/module/main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 05a42d8fcd7a..a90084c44c55 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1049,20 +1049,20 @@ static int verify_namespace_is_imported(const struct load_info *info,
 	return 0;
 }
 
-static bool inherit_taint(struct module *mod, struct module *owner)
+static bool inherit_taint(struct module *mod, struct module *owner, const char *name)
 {
 	if (!owner || !test_bit(TAINT_PROPRIETARY_MODULE, &owner->taints))
 		return true;
 
 	if (mod->using_gplonly_symbols) {
-		pr_err("%s: module using GPL-only symbols uses symbols from proprietary module %s.\n",
-			mod->name, owner->name);
+		pr_err("%s: module using GPL-only symbols uses symbols %s from proprietary module %s.\n",
+			mod->name, name, owner->name);
 		return false;
 	}
 
 	if (!test_bit(TAINT_PROPRIETARY_MODULE, &mod->taints)) {
-		pr_warn("%s: module uses symbols from proprietary module %s, inheriting taint.\n",
-			mod->name, owner->name);
+		pr_warn("%s: module uses symbols %s from proprietary module %s, inheriting taint.\n",
+			mod->name, name, owner->name);
 		set_bit(TAINT_PROPRIETARY_MODULE, &mod->taints);
 	}
 	return true;
@@ -1094,7 +1094,7 @@ static const struct kernel_symbol *resolve_symbol(struct module *mod,
 	if (fsa.license == GPL_ONLY)
 		mod->using_gplonly_symbols = true;
 
-	if (!inherit_taint(mod, fsa.owner)) {
+	if (!inherit_taint(mod, fsa.owner, name)) {
 		fsa.sym = NULL;
 		goto getname;
 	}
-- 
2.18.0

