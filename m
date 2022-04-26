Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD0E50EFBD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 06:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243479AbiDZEY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 00:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238351AbiDZEYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 00:24:55 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E003AA65;
        Mon, 25 Apr 2022 21:21:44 -0700 (PDT)
X-UUID: 4b209e21fff44b8db9b50cf1d8a5d1cf-20220426
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:07766553-23e1-4553-9b94-30a25d4527fc,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:75
X-CID-INFO: VERSION:1.1.4,REQID:07766553-23e1-4553-9b94-30a25d4527fc,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:75
X-CID-META: VersionHash:faefae9,CLOUDID:a9a71cf0-06b0-4305-bfbf-554bfc9d151a,C
        OID:7e66e66b3acb,Recheck:0,SF:13|15|28|17|19|48,TC:nil,Content:0,EDM:-3,Fi
        le:nil,QS:0,BEC:nil
X-UUID: 4b209e21fff44b8db9b50cf1d8a5d1cf-20220426
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 212249784; Tue, 26 Apr 2022 12:21:37 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 26 Apr 2022 12:21:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 26 Apr 2022 12:21:36 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-modules@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <yj.chiang@mediatek.com>,
        <lecopzer.chen@mediatek.com>
Subject: [PATCH] module: show disallowed symbol name for inherit_taint()
Date:   Tue, 26 Apr 2022 12:21:20 +0800
Message-ID: <20220426042120.9686-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error log for inherit_taint() doesn't really help to find the symbols
which violate GPL rules.

For example,
if a module has 50 disallowed symbols, the log only shows the content below
and is duplicated with 50 lines.
    AAA: module using GPL-only symbols uses symbols from proprietary module BBB.
    AAA: module using GPL-only symbols uses symbols from proprietary module BBB.
    ...

This patch add symbol name to tell the offending symbols explicitly.

To-be:
    AAA: module using GPL-only symbols uses symbols SS1 from proprietary module BBB.
    AAA: module using GPL-only symbols uses symbols SS2 from proprietary module BBB.
    ...

Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
---
 kernel/module.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 6cea788fd965..30973f0d2b7c 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1372,20 +1372,20 @@ static int verify_namespace_is_imported(const struct load_info *info,
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
@@ -1417,7 +1417,7 @@ static const struct kernel_symbol *resolve_symbol(struct module *mod,
 	if (fsa.license == GPL_ONLY)
 		mod->using_gplonly_symbols = true;
 
-	if (!inherit_taint(mod, fsa.owner)) {
+	if (!inherit_taint(mod, fsa.owner, name)) {
 		fsa.sym = NULL;
 		goto getname;
 	}
-- 
2.18.0

