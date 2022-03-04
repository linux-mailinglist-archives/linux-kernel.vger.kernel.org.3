Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CC84CD9A4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240885AbiCDRFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240877AbiCDRFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:05:15 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4AD19D76E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 09:04:27 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4K9DjJ0qGtz9sTB;
        Fri,  4 Mar 2022 18:04:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XPoTwYhh8rpQ; Fri,  4 Mar 2022 18:04:20 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4K9DjG2bsMz9sT7;
        Fri,  4 Mar 2022 18:04:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 343F48B779;
        Fri,  4 Mar 2022 18:04:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id PielNCpPyJwu; Fri,  4 Mar 2022 18:04:18 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.204.129])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BF9DD8B77B;
        Fri,  4 Mar 2022 18:04:17 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 224H48I11979760
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 4 Mar 2022 18:04:08 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 224H48Dp1979759;
        Fri, 4 Mar 2022 18:04:08 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 2/4] powerpc/smp: Declare current_set static
Date:   Fri,  4 Mar 2022 18:04:03 +0100
Message-Id: <a55eb65c9d7319f0af3c31e3f6ba36522f10003d.1646413435.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3ed660a585df2080ea8412ec20fbf652f5bf013a.1646413435.git.christophe.leroy@csgroup.eu>
References: <3ed660a585df2080ea8412ec20fbf652f5bf013a.1646413435.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1646413443; l=1215; s=20211009; h=from:subject:message-id; bh=SfwvLWKmUrmxjgGOVMfmYnAtA1FqTUHzhzptA0F7XFQ=; b=q/JrDD+POs64+gksEn50T1orHEnwlbgex1TANvZqhnngNh6kHqyW9zwLKThJJeEYo0UUGtHKCMNa 5XgFr+XcA9jsAM4K5+9/ZsdTBs8hMyPhGWXX4i+nHQoGygRqe+jn
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

current_set extern not needed anymore since
commit eafd825ed710 ("powerpc/64: Simplify __secondary_start
paca->kstack handling")

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/asm-prototypes.h | 1 -
 arch/powerpc/kernel/smp.c                 | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index 4fd79207fd41..283bfeb8bf4c 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -20,7 +20,6 @@
 #include <uapi/asm/ucontext.h>
 
 /* SMP */
-extern struct task_struct *current_set[NR_CPUS];
 extern struct task_struct *secondary_current;
 void start_secondary(void *unused);
 
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index b7fd6a72aa76..7e30a6fe5adf 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -716,7 +716,7 @@ void smp_send_stop(void)
 }
 #endif /* CONFIG_NMI_IPI */
 
-struct task_struct *current_set[NR_CPUS];
+static struct task_struct *current_set[NR_CPUS];
 
 static void smp_store_cpu_info(int id)
 {
-- 
2.34.1

