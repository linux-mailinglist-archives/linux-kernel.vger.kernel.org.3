Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF7A53742D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 06:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbiE3E5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 00:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbiE3E5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 00:57:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76712FFD9;
        Sun, 29 May 2022 21:57:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1C18B80B6F;
        Mon, 30 May 2022 04:57:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28294C3411A;
        Mon, 30 May 2022 04:57:28 +0000 (UTC)
Message-ID: <707bdfb5-a6d5-df4b-4b47-735bde4ec8fd@linux-m68k.org>
Date:   Mon, 30 May 2022 14:57:24 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Greg Ungerer <gerg@linux-m68k.org>
Subject: [git pull] m68knommu changes for v5.19
To:     torvalds@linux-foundation.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, gerg@kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the m68knommu changes for v5.19.

There is a collection of changes to add elf-fdpic loader support for m68k.
Also a collection of various fixes. They include typo corrections, undefined
symbol compilation fixes, removal of the ISA_DMA_API support and removal of
unused code.

I expect you will get a merge conflict in arch/m68k/kernel/ptrace.c.
The change to add some regset support conflicts with recent changes to
syscall_trace_enter/leave. The changes themselves don't interfere with
each other, just the diff context. Remove the conflicting line
"#endif /* CONFIG_COLDFIRE */" to resolve.

Regards
Greg



The following changes since commit 42226c989789d8da4af1de0c31070c96726d990c:

   Linux 5.18-rc7 (2022-05-15 18:08:58 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v5.19

for you to fetch changes up to 6b8be804ff376f6657ccdf6b29974e7c793d88c4:

   m68knommu: fix 68000 CPU link with no platform selected (2022-05-25 00:04:11 +1000)

----------------------------------------------------------------
m68knommu: changes for linux 5.19

. correctly set up ZERO_PAGE pointer
. drop ISA_DMA_API support
. fix comment typos
. fixes for undefined symbols
. remove unused code and variables
. elf-fdpic loader support for m68k

----------------------------------------------------------------
Arnd Bergmann (1):
       m68k: coldfire: drop ISA_DMA_API support

Greg Ungerer (9):
       m68knommu: set ZERO_PAGE() to the allocated zeroed page
       m68knommu: use asm-generic/mmu.h for nommu setups
       m68knommu: implement minimal regset support
       m68knommu: add definitions to support elf_fdpic program loader
       m68knommu: allow elf_fdpic loader to be selected
       m68knommu: fix undefined reference to `_init_sp'
       m68knommu: fix undefined reference to `mach_get_rtc_pll'
       m68k: removed unused "mach_get_ss"
       m68knommu: fix 68000 CPU link with no platform selected

Julia Lawall (1):
       m68k: fix typos in comments

  arch/m68k/Kconfig.bus               |  10 -
  arch/m68k/Kconfig.cpu               |   2 +-
  arch/m68k/Kconfig.machine           |   1 +
  arch/m68k/coldfire/Makefile         |   2 +-
  arch/m68k/coldfire/dma.c            |  43 ----
  arch/m68k/coldfire/intc.c           |   2 +-
  arch/m68k/coldfire/m53xx.c          |   2 +-
  arch/m68k/coldfire/pci.c            |   2 +-
  arch/m68k/hp300/config.c            |   7 -
  arch/m68k/include/asm/dma.h         | 483 ------------------------------------
  arch/m68k/include/asm/elf.h         |   9 +
  arch/m68k/include/asm/machdep.h     |   1 -
  arch/m68k/include/asm/mmu.h         |   4 +-
  arch/m68k/include/asm/pgtable_no.h  |   3 +-
  arch/m68k/include/uapi/asm/ptrace.h |   5 +
  arch/m68k/kernel/ptrace.c           |  58 +++++
  arch/m68k/kernel/setup_mm.c         |   9 -
  arch/m68k/kernel/setup_no.c         |   1 -
  arch/m68k/kernel/time.c             |   9 +
  arch/m68k/mm/motorola.c             |   1 -
  arch/m68k/q40/config.c              |   7 -
  drivers/mmc/host/Kconfig            |   2 +-
  fs/Kconfig.binfmt                   |   2 +-
  sound/core/Makefile                 |   2 -
  sound/isa/Kconfig                   |   2 +-
  25 files changed, 93 insertions(+), 576 deletions(-)
  delete mode 100644 arch/m68k/coldfire/dma.c
