Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69F651EEEA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 18:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbiEHQUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 12:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235317AbiEHQUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 12:20:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFA6116B
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 09:16:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D513A61214
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 16:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21AFC385AC;
        Sun,  8 May 2022 16:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652026583;
        bh=CkIfvyZhn3UwDJ95LJhpy4E2fC0AEDACS/lXd1lmtwM=;
        h=From:To:Cc:Subject:Date:From;
        b=JGdlu0gLkAb4XE6UFvVOrQL6j2fjO/l6RdQhmATeanZ1iTdtm2tZFccq3eWQB9q+E
         VFBx+xKbpKkvYmW6Ei4J1Xo4vKGUPPIPf2Hxh0w/uvM0LVhvj8T27N4NfRJ1xUTIli
         XV2fOkCDlnt+GhlYNh0WckeoeJYrMGD4JtoHexNPrYFiNHNzy38X0t0zSZeQiYIHL3
         yvDv9UZZHwV6MkL4hIZfUl0K8HIMed3lvnE5TxrK1eKT6k0UCCU1R/YYVwvFwQyLVo
         bHxiTLDjYh2p/jwA6Yzpz+Wf0RXNKz4B2Mcmkaswo5bwDY1RePoM6CX/QnrDqFkwLk
         /1qwsgtP83pqw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: [PATCH v2 0/4] unified way to use static key and optimize pgtable_l4_enabled
Date:   Mon,  9 May 2022 00:07:45 +0800
Message-Id: <20220508160749.984-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, riscv has several features which may not be supported on all
riscv platforms, for example, FPU, SV48, SV57 and so on. To support
unified kernel Image style, we need to check whether the feature is
suportted or not. If the check sits at hot code path, then performance
will be impacted a lot. static key can be used to solve the issue. In
the past, FPU support has been converted to use static key mechanism.
I believe we will have similar cases in the future. For example, the
SV48 support can take advantage of static key[1].

patch1 is a simple W=1 warning fix.
patch2 introduces an unified mechanism to use static key for riscv cpu
features.
patch3 converts has_cpu() to use the mechanism.
patch4 uses the mechanism to optimize pgtable_l4|[l5]_enabled.

[1] http://lists.infradead.org/pipermail/linux-riscv/2021-December/011164.html

Since v1:
 - Add a W=1 warning fix
 - Fix W=1 error
 - Based on v5.18-rcN, since SV57 support is added, so convert
   pgtable_l5_enabled as well.

Jisheng Zhang (4):
  riscv: mm: init: make pt_ops_set_[early|late|fixmap] static
  riscv: introduce unified static key mechanism for CPU features
  riscv: replace has_fpu() with system_supports_fpu()
  riscv: convert pgtable_l4|[l5]_enabled to static key

 arch/riscv/Makefile                 |   3 +
 arch/riscv/include/asm/cpufeature.h | 110 ++++++++++++++++++++++++++++
 arch/riscv/include/asm/pgalloc.h    |  16 ++--
 arch/riscv/include/asm/pgtable-64.h |  40 +++++-----
 arch/riscv/include/asm/pgtable.h    |   5 +-
 arch/riscv/include/asm/switch_to.h  |   9 +--
 arch/riscv/kernel/cpu.c             |   4 +-
 arch/riscv/kernel/cpufeature.c      |  29 ++++++--
 arch/riscv/kernel/process.c         |   2 +-
 arch/riscv/kernel/signal.c          |   4 +-
 arch/riscv/mm/init.c                |  52 ++++++-------
 arch/riscv/mm/kasan_init.c          |  16 ++--
 arch/riscv/tools/Makefile           |  22 ++++++
 arch/riscv/tools/cpucaps            |   7 ++
 arch/riscv/tools/gen-cpucaps.awk    |  40 ++++++++++
 15 files changed, 274 insertions(+), 85 deletions(-)
 create mode 100644 arch/riscv/include/asm/cpufeature.h
 create mode 100644 arch/riscv/tools/Makefile
 create mode 100644 arch/riscv/tools/cpucaps
 create mode 100755 arch/riscv/tools/gen-cpucaps.awk

-- 
2.34.1

