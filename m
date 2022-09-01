Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61645A95FE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 13:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbiIALtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 07:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbiIALtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:49:00 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA83C13A7E4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 04:48:59 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MJK7s1Bkmz9sp8;
        Thu,  1 Sep 2022 13:48:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zENmgUcEPJFI; Thu,  1 Sep 2022 13:48:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MJK7r70wRz9sp7;
        Thu,  1 Sep 2022 13:48:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DD8BF8B780;
        Thu,  1 Sep 2022 13:48:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id TIenZCy2TllG; Thu,  1 Sep 2022 13:48:56 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.131])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A3AA18B764;
        Thu,  1 Sep 2022 13:48:56 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 281BmkoS1768874
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 1 Sep 2022 13:48:46 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 281BmgEQ1768870;
        Thu, 1 Sep 2022 13:48:42 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, sv@linux.ibm.com,
        bgray@linux.ibm.com, agust@denx.de, jpoimboe@kernel.org,
        peterz@infradead.org, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, chenzhongjin@huawei.com
Subject: [PATCH v3 0/6] Implement inline static calls on PPC32 - v3
Date:   Thu,  1 Sep 2022 13:48:19 +0200
Message-Id: <cover.1662032631.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1662032901; l=1870; s=20211009; h=from:subject:message-id; bh=GAgDRyI5Iv4v6NxY6e0q7Pc95r863rGYKNlkTCV4Iz4=; b=xIoTdQATVlMxl+qo3b8kowa0Ce1JnaXHUKOLiVoHMjZhqAH98kCIcW/VrJESaDkHweU7OcGCCuQ/ ZHZ5QlLlAZhSMhFyRCUfG3ew9RKhh2g10uAM5ujyxo71l437f4Kv
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

This series applies on top of the series v2 "objtool: Enable and
implement --mcount option on powerpc" [1]

A few modifications are done to core parts to enable powerpc
implementation:
- R_X86_64_PC32 is abstracted to R_REL32 so that it can then be
redefined as R_PPC_REL32.
- A call to static_call_init() is added to start_kernel() to avoid
every architecture to have to call it
- Trampoline address is provided to arch_static_call_transform() even
when setting a site to fallback on a call to the trampoline when the
target is too far.

[1] https://lore.kernel.org/all/20220829055223.24767-8-sv@linux.ibm.com/T/

This version of the series includes a preliminary patch (patch 1) that
should be squashed into Sathvika's series.

Christophe Leroy (6):
  Fixup for "objtool/powerpc: Add --mcount specific implementation"
  objtool: Add architecture specific R_REL32 macro
  init: Call static_call_init() from start_kernel()
  static_call_inline: Provide trampoline address when updating sites
  powerpc: Prepare arch_static_call_transform() for supporting inline
    static calls
  powerpc/static_call: Implement inline static calls

 arch/powerpc/Kconfig                          |  1 +
 arch/powerpc/include/asm/static_call.h        |  2 +
 arch/powerpc/kernel/static_call.c             | 58 ++++++++++++++-----
 arch/x86/kernel/static_call.c                 |  2 +-
 init/main.c                                   |  1 +
 kernel/static_call_inline.c                   |  2 +-
 tools/objtool/arch/powerpc/decode.c           | 39 +++++++++----
 tools/objtool/arch/powerpc/include/arch/elf.h |  1 +
 tools/objtool/arch/x86/include/arch/elf.h     |  1 +
 tools/objtool/check.c                         | 10 ++--
 tools/objtool/orc_gen.c                       |  2 +-
 11 files changed, 85 insertions(+), 34 deletions(-)

-- 
2.37.1

