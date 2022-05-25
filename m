Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCA55340E8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 18:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244752AbiEYP6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbiEYP6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:58:46 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB1D6A046
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:58:44 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4L7bMk5qvPz9tFR;
        Wed, 25 May 2022 17:58:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2O8vcyPTfIX6; Wed, 25 May 2022 17:58:42 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4L7bMk4tMYz9t16;
        Wed, 25 May 2022 17:58:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 947B78B77C;
        Wed, 25 May 2022 17:58:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id SmFiMGNToGgI; Wed, 25 May 2022 17:58:42 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.180])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 261198B763;
        Wed, 25 May 2022 17:58:42 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 24PFwQaT419148
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 25 May 2022 17:58:26 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 24PFwQ9b419147;
        Wed, 25 May 2022 17:58:26 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, peterz@infradead.org,
        aik@ozlabs.ru, sv@linux.ibm.com, rostedt@goodmis.org,
        jpoimboe@redhat.com, naveen.n.rao@linux.vnet.ibm.com,
        mbenes@suse.cz
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v1 3/4] static_call: Call static_call_init() from start_kernel()
Date:   Wed, 25 May 2022 17:58:16 +0200
Message-Id: <95dbf2912ac97daf08cfb64c554cfa83266968e6.1653494186.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1653494186.git.christophe.leroy@csgroup.eu>
References: <cover.1653494186.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1653494295; l=790; s=20211009; h=from:subject:message-id; bh=JzHIizpKfjchzDO1PsEP9DpZzJ+lqwPqnOitXNRQVTI=; b=nBMV3Uel9aQS/GlB1HytDds3N2bnIEJCF4jGC2uO/yQJ0Hf8WtaF/mleEpLn0R5mvmbPXf2db0qa P+uIyLXQB/ZNEO58F+Evn2onb/axf+7ZurUpEnPYoB9NPpW3K2+K
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
index 98182c3c2c4b..b6c49c18ec5d 100644
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
2.35.3

