Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE6B56BF31
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239003AbiGHRcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 13:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238841AbiGHRcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 13:32:24 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE3322287
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 10:32:24 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4LfgMJ2JJDz9tMB;
        Fri,  8 Jul 2022 19:32:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eN4iI6ALbZ6f; Fri,  8 Jul 2022 19:32:12 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4LfgMF3R8kz9tMH;
        Fri,  8 Jul 2022 19:32:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5C1838B7AE;
        Fri,  8 Jul 2022 19:32:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id QpK6l3435sgp; Fri,  8 Jul 2022 19:32:09 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.233.202])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CEE6B8B7A0;
        Fri,  8 Jul 2022 19:32:08 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 268HW4eN1000744
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 8 Jul 2022 19:32:05 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 268HW45A1000743;
        Fri, 8 Jul 2022 19:32:04 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, sv@linux.ibm.com,
        agust@denx.de, jpoimboe@kernel.org, peterz@infradead.org,
        jbaron@akamai.com, rostedt@goodmis.org, ardb@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, chenzhongjin@huawei.com
Subject: [PATCH v2 5/7] init: Call static_call_init() from start_kernel()
Date:   Fri,  8 Jul 2022 19:31:24 +0200
Message-Id: <05d0dfdcfdc22b5235653a200495dea8977fcd0e.1657301423.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657301423.git.christophe.leroy@csgroup.eu>
References: <cover.1657301423.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1657301483; l=790; s=20211009; h=from:subject:message-id; bh=+7u0Pmx0yPcJZ9SXKFwBf7KVn08OQm0k5AwkZYSTlbI=; b=v6vkh1LPNbaYC1Yd9qVOugUFyYq5dDp3z6F20dQLgvo4tq1+m/gUS3hr6REuE9B8lCGZ4hq4JAKs P2wsKKm6DD+uGYj3qOhE9PV7hg7kSDx1poadOxq1R7/xF+tcu1di
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

Call static_call_init() just after jump_label_init().

x86 already called it from setup_arch(). This is not a
problem as static_call_init() is guarded from double call.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 init/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/init/main.c b/init/main.c
index 0ee39cdcfcac..7b8e9608f091 100644
--- a/init/main.c
+++ b/init/main.c
@@ -962,6 +962,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 	pr_notice("Kernel command line: %s\n", saved_command_line);
 	/* parameters may set static keys */
 	jump_label_init();
+	static_call_init();
 	parse_early_param();
 	after_dashes = parse_args("Booting kernel",
 				  static_command_line, __start___param,
-- 
2.36.1

