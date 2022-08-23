Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2C859E8C4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343936AbiHWRH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344868AbiHWRGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:06:05 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F99512B057
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 06:34:51 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MBqr81mPrzkWSD;
        Tue, 23 Aug 2022 21:31:20 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 23 Aug 2022 21:34:49 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 23 Aug 2022 21:34:35 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC:     <jpoimboe@kernel.org>, <peterz@infradead.org>, <bp@suse.de>,
        <mhiramat@kernel.org>, <sv@linux.ibm.com>,
        <christophe.leroy@csgroup.eu>, <naveen.n.rao@linux.vnet.ibm.com>,
        <chenzhongjin@huawei.com>
Subject: [PATCH] objtool: replace _ASM_PTR with quad in macros
Date:   Tue, 23 Aug 2022 21:31:24 +0800
Message-ID: <20220823133124.55914-1-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macros STACK_FRAME_NON_STANDARD and ANNOTATE_NOENDBR uses
_ASM_PTR. It switch between .long and .quad based on 32bit
or 64bit. However objtool doesn't work for 32bit, so _ASM_PTR
makes no sense.

Considering that _ASM_PTR comes from asm.h, which is x86
specific head file, while objtool.h is generic. Replace
_ASM_PTR with quad and remove asm.h reference.

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 include/linux/objtool.h       | 6 ++----
 tools/include/linux/objtool.h | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 62c54ffbeeaa..d2413cb78037 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -45,8 +45,6 @@ struct unwind_hint {
 
 #ifdef CONFIG_OBJTOOL
 
-#include <asm/asm.h>
-
 #ifndef __ASSEMBLY__
 
 #define UNWIND_HINT(sp_reg, sp_offset, type, end)		\
@@ -87,7 +85,7 @@ struct unwind_hint {
 #define ANNOTATE_NOENDBR					\
 	"986: \n\t"						\
 	".pushsection .discard.noendbr\n\t"			\
-	_ASM_PTR " 986b\n\t"					\
+	".quad 986b\n\t"					\
 	".popsection\n\t"
 
 #define ASM_REACHABLE							\
@@ -144,7 +142,7 @@ struct unwind_hint {
 
 .macro STACK_FRAME_NON_STANDARD func:req
 	.pushsection .discard.func_stack_frame_non_standard, "aw"
-	_ASM_PTR \func
+	.quad \func
 	.popsection
 .endm
 
diff --git a/tools/include/linux/objtool.h b/tools/include/linux/objtool.h
index 62c54ffbeeaa..d2413cb78037 100644
--- a/tools/include/linux/objtool.h
+++ b/tools/include/linux/objtool.h
@@ -45,8 +45,6 @@ struct unwind_hint {
 
 #ifdef CONFIG_OBJTOOL
 
-#include <asm/asm.h>
-
 #ifndef __ASSEMBLY__
 
 #define UNWIND_HINT(sp_reg, sp_offset, type, end)		\
@@ -87,7 +85,7 @@ struct unwind_hint {
 #define ANNOTATE_NOENDBR					\
 	"986: \n\t"						\
 	".pushsection .discard.noendbr\n\t"			\
-	_ASM_PTR " 986b\n\t"					\
+	".quad 986b\n\t"					\
 	".popsection\n\t"
 
 #define ASM_REACHABLE							\
@@ -144,7 +142,7 @@ struct unwind_hint {
 
 .macro STACK_FRAME_NON_STANDARD func:req
 	.pushsection .discard.func_stack_frame_non_standard, "aw"
-	_ASM_PTR \func
+	.quad \func
 	.popsection
 .endm
 
-- 
2.17.1

