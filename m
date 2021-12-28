Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA18A4806BD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 07:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbhL1Grp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 01:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbhL1Grn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 01:47:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED27C061574;
        Mon, 27 Dec 2021 22:47:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 678FFB80D9B;
        Tue, 28 Dec 2021 06:47:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD265C36AE8;
        Tue, 28 Dec 2021 06:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640674060;
        bh=pDkAgbZHBe02te6liij9nNRo6iDaWmoyo0HIE9qWJ7Q=;
        h=From:To:Cc:Subject:Date:From;
        b=J0tQTGU5yi38c+R7BCY6ovWaCF+3fcuMSMVPO0ZRPYD6cNTNbp6xwPfIVbvfPfsyJ
         Lepzv4jyp/tVTUjWsJIfMwPMiLq14rKXa3U3oMr52+7hhJoH1ePjkE/8VN2amD8bU5
         bkXgWGHWueeTbotl81lQ3/pKiQaiBBWeyq4F9gHflYHKxFQ026DrAOVB8E8bYuS7UP
         6a4Jc7YE3Qc7t1WXocvq21585wOb1llRUc6Qb/luci8VZ1KbmEaVFJ3/fFnSFPK3/u
         yppWVn13Bbucm8V7j+yKYEMcyL9CzCmkboFrXy6S/12731Coph7/qfrwdAyU+SHMqy
         Pi1bm8dXC+iEQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, will@kernel.org, tglx@linutronix.de,
        benh@kernel.crashing.org, arnd@arndb.de, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        christophe.leroy@csgroup.eu, hca@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.or,
        linuxppc-dev@lists.ozlabs.org, inux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V3 0/8] sched: Remove unused TASK_SIZE_OF for all archs
Date:   Tue, 28 Dec 2021 14:47:21 +0800
Message-Id: <20211228064730.2882351-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This macro isn't used in Linux, now. Delete in include/linux/sched.h
and arch's include/asm. This would confuse people who are
implementing the COMPAT feature for architecture.

Changes in v3:
 - Fixup Documentation/process/submitting-patches.rst, add sender
   Signed-off-by.

Changes in v2:
 - Add Arnd's comment in main patch
 - Optimize coding convention with Christophe's advise

Guo Ren (8):
  sched: Remove unused TASK_SIZE_OF
  sched: x86: Remove unused TASK_SIZE_OF
  sched: sparc: Remove unused TASK_SIZE_OF
  sched: powerpc: Remove unused TASK_SIZE_OF
  sched: s390: Remove unused TASK_SIZE_OF
  sched: parisc: Remove unused TASK_SIZE_OF
  sched: arm64: Remove unused TASK_SIZE_OF
  sched: mips: Remove unused TASK_SIZE_OF

 arch/arm64/include/asm/processor.h      | 2 --
 arch/mips/include/asm/processor.h       | 3 ---
 arch/parisc/include/asm/processor.h     | 3 +--
 arch/powerpc/include/asm/task_size_64.h | 6 +-----
 arch/s390/include/asm/processor.h       | 3 +--
 arch/sparc/include/asm/processor_64.h   | 3 ---
 arch/x86/include/asm/page_64_types.h    | 2 --
 include/linux/sched.h                   | 4 ----
 8 files changed, 3 insertions(+), 23 deletions(-)

-- 
2.25.1

