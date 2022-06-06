Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8AC53EB6E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239904AbiFFOo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239823AbiFFOoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:44:23 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB3E4F468
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:44:22 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id e11so12873034pfj.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 07:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jBAA4iYHay9IQkyL5K+TapNcySE+x8r/WS3Y7D8As50=;
        b=DbOxjk9ucf3qjonFJffz3Ct1P+0PiLR750bdqny3X2ftXXx9Vgh3gpP0dIUpm4Sw6s
         JKrvykWkcvT6WCWSN6dMMmyT94+egxtTmmNeKpks8O8CA25IVGc/eNBphAvl3YXVWK9D
         Osd3e6TlgUJw0rTGdBZ2xgfouqA/Tj1BAjCCQaW/OEKQPac2/WPN43cMNEH+6qi1ninw
         qq4mBW52s0o6NrJgauJqytAI5Jk3W72OqTzreZHW61PP6Pk3ZthMPDltldQfvjt2WDKU
         pwpsZp7gwZX3OldIAVL2IrYUU0n0THC4mUhfiNo+zu2gviOGfO9+/PJvFJLmioKd8ESK
         pnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jBAA4iYHay9IQkyL5K+TapNcySE+x8r/WS3Y7D8As50=;
        b=yqhZXEGfQOFdyMfaXVOrMLyUOvU21xC28BW6HXrRQNHgPE26Y9slPbhZS7tj5q8Btt
         aaXXU75hrdKI01KknMqXwQPyf++PRhgu2pgG98c78BQtPGQa6qTVamco8/U1+SOatjfm
         8R3ZHzuZadm+uM+CgN9PyK4D8mj2vM9bdj/98ogM3ZzutzPCnWkXSwm/D/SO4Bbby7UD
         qFlhMi0vzDonF54fkL+GkTAdERjqTQMLmHRaAJsUJspd09Zhs+GIe6suf0Ihu2KlFmFC
         bI2g5zF99h8k5KMfI3W8YWpGoi6C4pa8LQEI6jSna8pYdBZXllbIikeRrpiooyAihtZn
         eIUw==
X-Gm-Message-State: AOAM533DLVcbrVzbwugArPh943Fz21WVapnjioGG11FKdLgFe5AM9g7G
        4cc5nbypnpgBwGMJZ+n0hdmv/ujkYiM=
X-Google-Smtp-Source: ABdhPJz/K8VVU6Tqrrp0ULTd4g+UcdOOIbcqLIQqotxD65cO1xU85WjDfrc/1ugghIdGDz2asCXwuQ==
X-Received: by 2002:a63:24a:0:b0:3fc:52a9:b5d6 with SMTP id 71-20020a63024a000000b003fc52a9b5d6mr21072765pgc.132.1654526661252;
        Mon, 06 Jun 2022 07:44:21 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c21500b00163bfaf0b17sm8664139pll.233.2022.06.06.07.44.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jun 2022 07:44:20 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: [PATCH V3 0/7] x86/entry: Convert error_entry() to C code
Date:   Mon,  6 Jun 2022 22:45:02 +0800
Message-Id: <20220606144509.617611-1-jiangshanlai@gmail.com>
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

[V2]: https://lore.kernel.org/lkml/20220516131739.521817-1-jiangshanlai@gmail.com/
[V1]: https://lore.kernel.org/lkml/20220511072747.3960-1-jiangshanlai@gmail.com/

Changed from V2:
	Fix conflict in arch/x86/include/asm/proto.h in patch7

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

