Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8F95B24D9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 19:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiIHRj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 13:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiIHRix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:38:53 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C06F16CB
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 10:38:34 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MNmYk0hRYz9smT;
        Thu,  8 Sep 2022 19:38:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VqsMJqpEJcPG; Thu,  8 Sep 2022 19:38:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MNmYf6lrWz9sm3;
        Thu,  8 Sep 2022 19:38:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CABE18B78F;
        Thu,  8 Sep 2022 19:38:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id YtUcEqIJuiyE; Thu,  8 Sep 2022 19:38:14 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.247])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D6C628B7A9;
        Thu,  8 Sep 2022 19:38:13 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 288Hc4193449118
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 8 Sep 2022 19:38:04 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 288Hc43O3449117;
        Thu, 8 Sep 2022 19:38:04 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 02/19] powerpc/64e: Tie PPC_BOOK3E_64 to PPC_E500MC
Date:   Thu,  8 Sep 2022 19:37:35 +0200
Message-Id: <f2d30eb7fadcfd89f7ac3784cb0b4a4b47d47db1.1662658653.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <4e7e6259e5af0e0e171f19ee1f85ab5b2553723f.1662658653.git.christophe.leroy@csgroup.eu>
References: <4e7e6259e5af0e0e171f19ee1f85ab5b2553723f.1662658653.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1662658667; l=1555; s=20211009; h=from:subject:message-id; bh=hWapOXxL+AWJ4bmJMMo/qtoq2LbneXxETO5Q1Cu17zU=; b=/h4Bknw119k7NmOybEi4WoxBoQg//sNqZnYVVfySbIgWi69VTbM6SXr9iV9hB6dv0YgJPmDmi5Z2 Atp731ewCNEjSb8D8rWeodbSM5nwLvpITZ4okV3QA6XowbTArSoX
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

The only 64-bit Book3E CPUs we support is the e500mc.

However our Kconfig allows configurating a kernel that has 64-bit
Book3E support, but no e500mc support enabled. Such a kernel
would never boot, it doesn't know about any CPUs.

To fix this, force e500mc to be selected whenever we are
building a 64-bit Book3E kernel.

And add a test to detect futur situations where cpu_specs is empty.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/cputable.c         | 2 ++
 arch/powerpc/platforms/Kconfig.cputype | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index d8e42ef750f1..2829ea537277 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -2018,6 +2018,8 @@ struct cpu_spec * __init identify_cpu(unsigned long offset, unsigned int pvr)
 	struct cpu_spec *s = cpu_specs;
 	int i;
 
+	BUILD_BUG_ON(!ARRAY_SIZE(cpu_specs));
+
 	s = PTRRELOC(s);
 
 	for (i = 0; i < ARRAY_SIZE(cpu_specs); i++,s++) {
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 5185d942b455..19fd95a06352 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -108,6 +108,8 @@ config PPC_BOOK3S_64
 config PPC_BOOK3E_64
 	bool "Embedded processors"
 	select PPC_FSL_BOOK3E
+	select E500
+	select PPC_E500MC
 	select PPC_FPU # Make it a choice ?
 	select PPC_SMP_MUXED_IPI
 	select PPC_DOORBELL
-- 
2.37.1

