Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E055616C2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbiF3JrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbiF3JrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:47:14 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EDF4339F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 02:47:12 -0700 (PDT)
X-UUID: 9598c00f255d43a0954087a8dac8889c-20220630
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7,REQID:43f2f889-0537-4be0-a59d-a3f0d314a63b,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:87442a2,CLOUDID:d51d0e63-0b3f-4b2c-b3a6-ed5c044366a0,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 9598c00f255d43a0954087a8dac8889c-20220630
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <haibo.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 249206036; Thu, 30 Jun 2022 17:47:07 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 30 Jun 2022 17:47:06 +0800
Received: from mszsdtcf10.gcn.mediatek.inc (10.16.4.60) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 30 Jun 2022 17:47:05 +0800
From:   Haibo Li <haibo.li@mediatek.com>
To:     Sami Tolvanen <samitolvanen@google.com>
CC:     <xiaoming.yu@mediatek.com>, Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Haibo Li <haibo.li@mediatek.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Aaron Tomlin <atomlin@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Subject: [PATCH 2/2] ANDROID: cfi: free old cfi shadow asynchronously
Date:   Thu, 30 Jun 2022 17:46:46 +0800
Message-ID: <20220630094646.91837-3-haibo.li@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630094646.91837-1-haibo.li@mediatek.com>
References: <20220630094646.91837-1-haibo.li@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currenly, it uses synchronize_rcu() to wait old rcu reader to go away
in update_shadow.In embedded platform like ARM CA7X,
load_module blocks 40~50ms in update_shadow.
When there are more than one hundred kernel modules,
it blocks several seconds.

To accelerate load_module,change synchronize_rcu to call_rcu.

Signed-off-by: Haibo Li <haibo.li@mediatek.com>
Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
---
 kernel/cfi.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/cfi.c b/kernel/cfi.c
index 456771c8e454..a4836d59ca27 100644
--- a/kernel/cfi.c
+++ b/kernel/cfi.c
@@ -43,6 +43,8 @@ typedef u16 shadow_t;
 struct cfi_shadow {
 	/* Page index for the beginning of the shadow */
 	unsigned long base;
+	/* rcu to free old cfi_shadow asynchronously */
+	struct rcu_head rcu;
 	/* An array of __cfi_check locations (as indices to the shadow) */
 	shadow_t shadow[1];
 } __packed;
@@ -182,6 +184,13 @@ static void remove_module_from_shadow(struct cfi_shadow *s, struct module *mod,
 	}
 }
 
+static void _cfi_shadow_free_rcu(struct rcu_head *rcu)
+{
+	struct cfi_shadow *old = container_of(rcu, struct cfi_shadow, rcu);
+
+	vfree(old);
+}
+
 typedef void (*update_shadow_fn)(struct cfi_shadow *, struct module *,
 			unsigned long min_addr, unsigned long max_addr);
 
@@ -211,11 +220,10 @@ static void update_shadow(struct module *mod, unsigned long base_addr,
 
 	rcu_assign_pointer(cfi_shadow, next);
 	mutex_unlock(&shadow_update_lock);
-	synchronize_rcu();
 
 	if (prev) {
 		set_memory_rw((unsigned long)prev, SHADOW_PAGES);
-		vfree(prev);
+		call_rcu(&prev->rcu, _cfi_shadow_free_rcu);
 	}
 }
 
-- 
2.25.1

