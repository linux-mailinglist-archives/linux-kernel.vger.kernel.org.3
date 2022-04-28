Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B933B512A09
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 05:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238337AbiD1Dhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 23:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiD1Dhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 23:37:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D167DA9F;
        Wed, 27 Apr 2022 20:34:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82FCD618FB;
        Thu, 28 Apr 2022 03:34:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A27EC385A0;
        Thu, 28 Apr 2022 03:34:26 +0000 (UTC)
From:   Greg Ungerer <gerg@linux-m68k.org>
To:     linux-m68k@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, dalias@libc.org,
        Greg Ungerer <gerg@linux-m68k.org>
Subject: [PATCH 0/4] m68knommu: add support for elf-fdpic
Date:   Thu, 28 Apr 2022 13:33:15 +1000
Message-Id: <20220428033319.239341-1-gerg@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to the m68k architecture code for the elf-fdpic loader.
As of commit 1bde925d2354 ("fs/binfmt_elf_fdpic.c: provide NOMMU loader
for regular ELF binaries") it is possible to run normal ELF executables
on nommu systems. These are simple enough to generate and test - even
without actual elf-fdpic toolchain support.

A few minor changes are required to have everything in place, all on the
architecture code side. The largest required addition is minimal regset
support (for elf-fdpic core dumping), otherwise a couple of cleanups and
some definitions is all that is required.

Note that this is only supporting nommu mode on the m68k at this time.
Changes will be required to the mm_context_t type to support elf-fdpic
with MMU enabled on m68k.

Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
---
 arch/m68k/include/asm/elf.h         |    9 +++++
 arch/m68k/include/asm/mmu.h         |    4 --
 arch/m68k/include/uapi/asm/ptrace.h |    5 +++
 arch/m68k/kernel/ptrace.c           |   58 ++++++++++++++++++++++++++++++++++++
 fs/Kconfig.binfmt                   |    2 -
 5 files changed, 74 insertions(+), 4 deletions(-)


