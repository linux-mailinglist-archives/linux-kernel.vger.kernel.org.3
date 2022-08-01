Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A74586EBB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbiHAQjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbiHAQjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:39:09 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF70257
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 09:39:08 -0700 (PDT)
Received: from localhost.localdomain (unknown [92.49.173.143])
        by mail.ispras.ru (Postfix) with ESMTPSA id F208A407625C;
        Mon,  1 Aug 2022 16:39:06 +0000 (UTC)
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Evgeniy Baskov <baskov@ispras.ru>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [RFC PATCH 0/8] x86_64: Harden compressed kernel, part 1
Date:   Mon,  1 Aug 2022 19:38:57 +0300
Message-Id: <cover.1659369873.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first half of changes aimed to increase security of early
boot code of compressed kernel for x86_64 by enforcing memory protection
on page table level.

It applies memory protection to the compressed kernel code executing
outside EFI environment and makes all identity mappings explicit
to reduce probability of hiding erroneous memory accesses.

Second half makes kernel more compliant PE image and enforces memory
protection for EFISTUB code, thus completing W^X support for compressed
kernel.

I'll send second half for review later.

Evgeniy Baskov (8):
  x86/boot: Align vmlinuz sections on page size
  x86/build: Remove RWX sections and align on 4KB
  x86/boot: Set cr0 to known state in trampoline
  x86/boot: Increase boot page table size
  x86/boot: Support 4KB pages for identity mapping
  x86/boot: Setup memory protection for bzImage code
  x86/boot: Map memory explicitly
  x86/boot: Remove mapping from page fault handler

 arch/x86/boot/compressed/acpi.c         |  21 ++-
 arch/x86/boot/compressed/efi.c          |  19 ++-
 arch/x86/boot/compressed/head_64.S      |   7 +-
 arch/x86/boot/compressed/ident_map_64.c | 128 ++++++++++------
 arch/x86/boot/compressed/kaslr.c        |   4 +
 arch/x86/boot/compressed/misc.c         |  52 ++++++-
 arch/x86/boot/compressed/misc.h         |  16 +-
 arch/x86/boot/compressed/pgtable.h      |  20 ---
 arch/x86/boot/compressed/pgtable_64.c   |   2 +-
 arch/x86/boot/compressed/sev.c          |   6 +-
 arch/x86/boot/compressed/vmlinux.lds.S  |   6 +
 arch/x86/include/asm/boot.h             |  26 ++--
 arch/x86/include/asm/init.h             |   1 +
 arch/x86/include/asm/shared/pgtable.h   |  29 ++++
 arch/x86/kernel/vmlinux.lds.S           |  15 +-
 arch/x86/mm/ident_map.c                 | 186 ++++++++++++++++++++----
 16 files changed, 403 insertions(+), 135 deletions(-)
 delete mode 100644 arch/x86/boot/compressed/pgtable.h
 create mode 100644 arch/x86/include/asm/shared/pgtable.h

-- 
2.35.1

