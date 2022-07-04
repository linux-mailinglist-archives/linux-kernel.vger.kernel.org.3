Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B364F564B3C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 03:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbiGDBlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 21:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiGDBlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 21:41:03 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA8163FB
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 18:40:57 -0700 (PDT)
X-UUID: 8e59aac5f0134b549cd7c9d5d3303cb3-20220704
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7,REQID:83713f8e-e021-4666-8692-bb82e3d371e5,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:87442a2,CLOUDID:df526e86-57f0-47ca-ba27-fe8c57fbf305,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 8e59aac5f0134b549cd7c9d5d3303cb3-20220704
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <haibo.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2042083025; Mon, 04 Jul 2022 09:40:53 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 4 Jul 2022 09:40:52 +0800
Received: from mszsdtcf10.gcn.mediatek.inc (10.16.4.60) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 4 Jul 2022 09:40:51 +0800
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
Subject: [PATCH v2 1/2] cfi: enable sanitize for cfi.c
Date:   Mon, 4 Jul 2022 09:40:45 +0800
Message-ID: <20220704014046.34596-2-haibo.li@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220704014046.34596-1-haibo.li@mediatek.com>
References: <20220704014046.34596-1-haibo.li@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
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
 kernel/cfi.c    | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

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
index 08102d19ec15..6c8ae07b5835 100644
--- a/kernel/cfi.c
+++ b/kernel/cfi.c
@@ -311,7 +311,7 @@ static inline cfi_check_fn find_check_fn(unsigned long ptr)
 	return fn;
 }
 
-void __cfi_slowpath_diag(uint64_t id, void *ptr, void *diag)
+void __nocfi __cfi_slowpath_diag(u64 id, void *ptr, void *diag)
 {
 	cfi_check_fn fn = find_check_fn((unsigned long)ptr);
 
-- 
2.25.1

