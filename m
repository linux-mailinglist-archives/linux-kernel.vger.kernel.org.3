Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED19A528521
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236569AbiEPNQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiEPNQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:16:57 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C690A24595
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:16:55 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id s14so14404886plk.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7ngVjGJtdK+JoF1qKgARzQTnQIxfW+To/NpJBzEuOKA=;
        b=CzwN7objMNBUQa1ToVix+lofoeN2sfCLKJYbbswqAhjsm6ggQgrJ+l+Px7OuGbRItw
         tiQ8yy8yc3CWG/8k0cqLShqO9dzv5s/QwHJbfGgtOpEiAJcYiR1CuW/sEZmgZ2PE3voa
         rqv637OAfX95opPqASMnbzRs6VbC5tv1pM7CRKU07xs3LQZ9TRo5AhH30yLoc7VtyQta
         SbRuh4dbqATWR+eCUYYdirhkD1zk61zI8dEXT8epRuh5uKEXFaAW3LrXzmuV6q4jCvUc
         ghtGswRBfpvK9dcQsGc9b6d+JJfvpKPtb7KbGgisOEf4lUXE6oRTFoZGMuiimw64bbcX
         KfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7ngVjGJtdK+JoF1qKgARzQTnQIxfW+To/NpJBzEuOKA=;
        b=AROWzXOj+pi8qp24abyC+SDLNWQ4ECwoMOQAXD/BwVIsYFwEas9HDuY3m3Yls5speZ
         Xa1xToL29b7NSci3ISNPyspJ6QSKX9B0DqfxGpeMYLLAkfRXvMvEKzkpGiNPKEgTffE+
         ENbsLfrY2KQxDbDiVO1ks5/860913DuQcTmcK4N7ba4M0F2gXZPtJnQcIL1RhiGww3wk
         Hgg2amXjO5u/VDZpDacdjnOWf+ZIjep0+qzT/R2Q/bbkBUI+zLTErMJKloBJQNaZQi7X
         K/xmQrgaqKGepHWylDKBDfV5TpFTLgh5kXaAWfKpSyIFMsZGLBelpZEppYF9CmQSdr5D
         kV5A==
X-Gm-Message-State: AOAM5333rQ9wGz1jlyxaPSD4iGztcVA4dXmuAh3MXHL+y7G03u5NSN0O
        HQsSBJ+ltKrenoCouhPCzdu55F/GQiY=
X-Google-Smtp-Source: ABdhPJzc8X99+p6/hKccfJMP1FftM1xAxrt95XY/FJg6EnlYvdVSAF9hdGjCwSlPf0M4Iy7JFRrTFw==
X-Received: by 2002:a17:90a:e7d2:b0:1dc:3762:c72d with SMTP id kb18-20020a17090ae7d200b001dc3762c72dmr30945829pjb.243.1652707015105;
        Mon, 16 May 2022 06:16:55 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id b8-20020aa78708000000b0050dc76281a0sm6756524pfo.122.2022.05.16.06.16.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 May 2022 06:16:54 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: [PATCH V2 0/7] x86/entry: Convert error_entry() to C code
Date:   Mon, 16 May 2022 21:17:31 +0800
Message-Id: <20220516131739.521817-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

Add some C equivalent functions of the ASM macros and implement the whole
error_entry() as C code.

The patches are picked and re-made from the huge patchset
https://lore.kernel.org/lkml/20211126101209.8613-1-jiangshanlai@gmail.com/
which converts a large chunk of ASM code to C code.

The C version generally has better readability and easier to be
updated/improved.

This smaller patchset converts error_entry() only.
The equivalent ASM macros are not removed because they are still used by
the IST exceptions.

No functional change intended and comments are also copied.

The complier generates very similar code for the C code and the original
ASM code except minor differences.

The complier uses tail-call-optimization for calling sync_regs().  It
uses "JMP sync_regs" while the ASM code uses "CALL+RET".

The compiler generates "AND $0xe7,%ah" (3 bytes) for the code
"cr3 = user_cr3 & ~PTI_USER_PGTABLE_AND_PCID_MASK" while the ASM code in
SWITCH_TO_KERNEL_CR3() results "AND $0xffffffffffffe7ff,%rax" (6 bytes).

The compiler generates lengthier code for "cr3 |= X86_CR3_PCID_NOFLUSH"
because it uses "MOVABS+OR" (13 bytes)  rather than a single
"BTS" (5 bytes).

ALTERNATIVE and static_cpu_has() are also different which depends on
what alternative instructions for ALTERNATIVE are.

[V1]: https://lore.kernel.org/lkml/20220511072747.3960-1-jiangshanlai@gmail.com/

Changed from V1:
	remove unneeded cleanup in patch2

Changed from the old huge patchset:
	squash some patches

Lai Jiangshan (7):
  x86/entry: Introduce __entry_text for entry code written in C
  x86/entry: Move PTI_USER_* to arch/x86/include/asm/processor-flags.h
  x86: Mark __native_read_cr3() & native_write_cr3() as __always_inline
  x86/entry: Add arch/x86/entry/entry64.c for C entry code
  x86/entry: Add the C verion of SWITCH_TO_KERNEL_CR3 as
    switch_to_kernel_cr3()
  x86/traps: Add fence_swapgs_{user,kernel}_entry() and
    user_entry_swapgs_and_fence()
  x86/entry: Implement the whole error_entry() as C code

 arch/x86/entry/Makefile                |   3 +-
 arch/x86/entry/calling.h               |  10 --
 arch/x86/entry/entry64.c               | 137 +++++++++++++++++++++++++
 arch/x86/entry/entry_64.S              |  85 +--------------
 arch/x86/include/asm/idtentry.h        |   3 +
 arch/x86/include/asm/processor-flags.h |  15 +++
 arch/x86/include/asm/proto.h           |   1 +
 arch/x86/include/asm/special_insns.h   |   4 +-
 arch/x86/include/asm/traps.h           |   1 +
 arch/x86/kernel/traps.c                |   2 -
 include/linux/compiler_types.h         |   8 +-
 11 files changed, 169 insertions(+), 100 deletions(-)
 create mode 100644 arch/x86/entry/entry64.c

-- 
2.19.1.6.gb485710b

