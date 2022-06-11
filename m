Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44B45476AB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 18:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237798AbiFKQzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 12:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236770AbiFKQzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 12:55:44 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EED46FA2E;
        Sat, 11 Jun 2022 09:55:43 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4LL3qc4l1kz9tSH;
        Sat, 11 Jun 2022 18:55:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 54irvjHsnLrs; Sat, 11 Jun 2022 18:55:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4LL3qb02SMz9tSJ;
        Sat, 11 Jun 2022 18:55:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E074A8B768;
        Sat, 11 Jun 2022 18:55:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ZtZubZVjpOjl; Sat, 11 Jun 2022 18:55:38 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.6.192])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9D4638B77C;
        Sat, 11 Jun 2022 18:55:38 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 25BGtQqR742066
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 11 Jun 2022 18:55:26 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 25BGtQR1742065;
        Sat, 11 Jun 2022 18:55:26 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH 2/2] powerpc: Move prom_init() out of asm-prototypes.h
Date:   Sat, 11 Jun 2022 18:55:16 +0200
Message-Id: <e111e4f0addb0fa810d5f6a71d3b8e62c0b53492.1654966508.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <3b1dfb19a2c3265fb4abc2bfc7b6eae9261a998b.1654966508.git.christophe.leroy@csgroup.eu>
References: <3b1dfb19a2c3265fb4abc2bfc7b6eae9261a998b.1654966508.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1654966513; l=1938; s=20211009; h=from:subject:message-id; bh=fAU2YJdaMaOCNND6abnDDcAnCp5BkcWZrEWb3FSr2r4=; b=M0hlhV7MqNO1F1MezaSEWaQWJ4ODhBlt/ywxnrufJ0TCozr+u4yi5MIx1ahy7GJ+pRPUeNmT+I5+ vP5IxmV/BwZJt8oFInL4YdYaoDNr6lO53jkSLvmXxZtlMyCoxf+E
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

This is the end of the work started with commit 76222808fc25 ("powerpc:
Move C prototypes out of asm-prototypes.h")

Now that asm/machdep.h doesn't include asm/setup.h anymore, there are
no conflicts anymore with the function prom_init() defined in
drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowrom.o

So we can move it to asm/setup.h

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/asm-prototypes.h | 6 ------
 arch/powerpc/include/asm/setup.h          | 5 +++++
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index d995c65d18ab..3b2bbc273055 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -34,12 +34,6 @@ int64_t __opal_call(int64_t a0, int64_t a1, int64_t a2, int64_t a3,
 		    int64_t a4, int64_t a5, int64_t a6, int64_t a7,
 		    int64_t opcode, uint64_t msr);
 
-/* prom_init (OpenFirmware) */
-unsigned long __init prom_init(unsigned long r3, unsigned long r4,
-			       unsigned long pp,
-			       unsigned long r6, unsigned long r7,
-			       unsigned long kbase);
-
 /* misc runtime */
 extern u64 __bswapdi2(u64);
 extern s64 __lshrdi3(s64, int);
diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index 8fa37ef5da4d..14a0b8af738e 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -85,6 +85,11 @@ void __init machine_init(u64 dt_ptr);
 void __init early_setup(unsigned long dt_ptr);
 void early_setup_secondary(void);
 
+/* prom_init (OpenFirmware) */
+unsigned long __init prom_init(unsigned long r3, unsigned long r4,
+			       unsigned long pp, unsigned long r6,
+			       unsigned long r7, unsigned long kbase);
+
 #endif /* !__ASSEMBLY__ */
 
 #endif	/* _ASM_POWERPC_SETUP_H */
-- 
2.35.3

