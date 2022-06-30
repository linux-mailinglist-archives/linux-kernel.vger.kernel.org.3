Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714A35616C1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbiF3JrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbiF3JrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:47:13 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E7942EE1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 02:47:11 -0700 (PDT)
X-UUID: 63e02b56a5f448f2bc6664e7bc080df7-20220630
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7,REQID:5aa947b7-da57-4ea7-b869-05581f124e91,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:87442a2,CLOUDID:73c53086-57f0-47ca-ba27-fe8c57fbf305,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 63e02b56a5f448f2bc6664e7bc080df7-20220630
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <haibo.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1331765317; Thu, 30 Jun 2022 17:47:05 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 30 Jun 2022 17:47:03 +0800
Received: from mszsdtcf10.gcn.mediatek.inc (10.16.4.60) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 30 Jun 2022 17:47:03 +0800
From:   Haibo Li <haibo.li@mediatek.com>
To:     Sami Tolvanen <samitolvanen@google.com>
CC:     <xiaoming.yu@mediatek.com>, Kees Cook <keescook@chromium.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
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
Subject: [PATCH 1/2] ANDROID: cfi: enable sanitize for cfi.c
Date:   Thu, 30 Jun 2022 17:46:45 +0800
Message-ID: <20220630094646.91837-2-haibo.li@mediatek.com>
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

currenly,cfi.c is excluded from cfi sanitize because of cfi handler.
The side effect is that we can not transfer function pointer to
other files which enable cfi sanitize.

Enable cfi sanitize for cfi.c and bypass cfi check for __cfi_slowpath_diag

Signed-off-by: Haibo Li <haibo.li@mediatek.com>
Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
---
 kernel/Makefile | 3 ---
 kernel/cfi.c    | 8 +++++++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/Makefile b/kernel/Makefile
index a7e1f49ab2b3..a997bef1a200 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -40,9 +40,6 @@ KCSAN_SANITIZE_kcov.o := n
 UBSAN_SANITIZE_kcov.o := n
 CFLAGS_kcov.o := $(call cc-option, -fno-conserve-stack) -fno-stack-protector
 
-# Don't instrument error handlers
-CFLAGS_REMOVE_cfi.o := $(CC_FLAGS_CFI)
-
 obj-y += sched/
 obj-y += locking/
 obj-y += power/
diff --git a/kernel/cfi.c b/kernel/cfi.c
index 08102d19ec15..456771c8e454 100644
--- a/kernel/cfi.c
+++ b/kernel/cfi.c
@@ -311,7 +311,7 @@ static inline cfi_check_fn find_check_fn(unsigned long ptr)
 	return fn;
 }
 
-void __cfi_slowpath_diag(uint64_t id, void *ptr, void *diag)
+static inline void __nocfi _run_cfi_check(u64 id, void *ptr, void *diag)
 {
 	cfi_check_fn fn = find_check_fn((unsigned long)ptr);
 
@@ -320,6 +320,12 @@ void __cfi_slowpath_diag(uint64_t id, void *ptr, void *diag)
 	else /* Don't allow unchecked modules */
 		handle_cfi_failure(ptr);
 }
+
+void __cfi_slowpath_diag(u64 id, void *ptr, void *diag)
+{
+	/*run cfi check without cfi sanitize to avoid calling cfi handler recursively*/
+	_run_cfi_check(id, ptr, diag);
+}
 EXPORT_SYMBOL(__cfi_slowpath_diag);
 
 #else /* !CONFIG_MODULES */
-- 
2.25.1

