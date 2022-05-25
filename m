Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B365340E7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 18:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238849AbiEYP7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241393AbiEYP6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:58:53 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E136A046
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:58:51 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4L7bMm0vPFz9tFM;
        Wed, 25 May 2022 17:58:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zQ_6I0Gbe9UZ; Wed, 25 May 2022 17:58:44 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4L7bMk5J8rz9tFN;
        Wed, 25 May 2022 17:58:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9D1408B77D;
        Wed, 25 May 2022 17:58:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id LUQf5xr7R8yb; Wed, 25 May 2022 17:58:42 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.180])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 362688B77B;
        Wed, 25 May 2022 17:58:42 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 24PFwQ0V419136
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 25 May 2022 17:58:26 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 24PFwMYv419135;
        Wed, 25 May 2022 17:58:22 +0200
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
Subject: [RFC PATCH v1 0/4] Implement inline static calls on PPC32
Date:   Wed, 25 May 2022 17:58:13 +0200
Message-Id: <cover.1653494186.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1653494295; l=1739; s=20211009; h=from:subject:message-id; bh=0xhGO3E3H3RXpaD4daFMpbbnZ1xIaAB21QBuFX2pPRY=; b=+mUn2iymhvQIjBKVlNw5Pq1rbKIsFcoFdHuJrXIo3yFqDb7rJiTgfLNayexLEBU9BSpxeDhVnsFU J0TOxwNFAZbJZv01mNkv9p9fdSBfszS6z0G4FNBnJCEF6v0N+SGK
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

This is first draft for implementing inline static calls on PPC32.

This series applies on top of the series v2 "objtool: Enable and implement --mcount option on powerpc"

For the time being only the case where functions are within 'bl' reach
is supported. Otherwise panic() is invoked.

For the other case, we'll need to use the trampoline we have at startup
before initialising inline static calls. But it seems that at the time
being once inline static calls are initialised we don't know anymore
where the trampoline was.
We'd need to keep the information somewhere (is the static_call_key ?)
We may also need to keep the information for when the trampoline itself
is out of 'bl' reach, in that case there is a trampoline setup by the
compiler and we'll need to remind the location of that trampoline. Guess
it should get saved somewhere when we initialise inline static calls ?

Christophe Leroy (4):
  Revert "objtool: Enable objtool to run only on files with ftrace
    enabled"
  objtool: Add R_REL32 macro
  static_call: Call static_call_init() from start_kernel()
  powerpc/static_call: Implement inline static calls

 arch/powerpc/Kconfig                          |  1 +
 arch/powerpc/include/asm/static_call.h        |  2 +
 arch/powerpc/kernel/static_call.c             | 41 ++++++++++++-------
 init/main.c                                   |  1 +
 scripts/Makefile.build                        |  4 +-
 tools/objtool/arch/powerpc/include/arch/elf.h |  1 +
 tools/objtool/arch/x86/include/arch/elf.h     |  1 +
 tools/objtool/check.c                         | 10 ++---
 tools/objtool/orc_gen.c                       |  2 +-
 9 files changed, 41 insertions(+), 22 deletions(-)

-- 
2.35.3

