Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9642D49B97F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350740AbiAYRAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1587168AbiAYQ6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:58:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356F5C06177C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:58:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1CB8B81911
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:58:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADE8C340E6;
        Tue, 25 Jan 2022 16:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643129890;
        bh=uOqnm11FpH1adpfb3UZE/9ohT+Ih/nE0Pk0trATO/qQ=;
        h=From:To:Cc:Subject:Date:From;
        b=EakeZI4KcUK1oDesp+SP28y7+ja3m4oFhAYkxmXw0R/JYt2TIwjesfrGCFy4XdIkb
         /AWSYUU0A+T5qpsmLK7FUGt6K77nRGJkr6r6K5s59sA97iHfNk3PCIRsxNIVo9y9fG
         t4BWsisJnaXFlWK6C/2fOYZa81HN6bYnG4q8gsNmw7+wmJQ7y97kRE70udJAoS7X2D
         0DG11ionJa1Wfr+Rc5hlLAyTMBqVRV0Uun1KhOMDPhHVX04w/KwHe484lrTRFQPZc1
         IzHKg7siOB/GxssIfb5rtt00Pdy4rTKHchZ0DihEqnNd6a6WJioyh7ZENnfPvvTDhL
         X0kZreDIJkc1Q==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: [PATCH 0/3] unified way to use static key and optimize pgtable_l4_enabled
Date:   Wed, 26 Jan 2022 00:50:33 +0800
Message-Id: <20220125165036.987-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, riscv has several features why may not be supported on all
riscv platforms, for example, FPU, SV48 and so on. To support unified
kernel Image style, we need to check whether the feature is suportted
or not. If the check sits at hot code path, then performance will be
impacted a lot. static key can be used to solve the issue. In the
past FPU support has been converted to use static key mechanism. I
believe we will have similar cases in the future. For example, the
SV48 support can take advantage of static key[1].

patch1 introduces an unified mechanism to use static key for riscv cpu
features.
patch2 converts has_cpu() to use the mechanism.
patch3 uses the mechanism to optimize pgtable_l4_enabled.

[1] http://lists.infradead.org/pipermail/linux-riscv/2021-December/011164.html

Jisheng Zhang (3):
  riscv: introduce unified static key mechanism for CPU features
  riscv: replace has_fpu() with system_supports_fpu()
  riscv: convert pgtable_l4_enabled to static key

 arch/riscv/Makefile                 |   3 +
 arch/riscv/include/asm/cpufeature.h | 105 ++++++++++++++++++++++++++++
 arch/riscv/include/asm/pgalloc.h    |   8 +--
 arch/riscv/include/asm/pgtable-64.h |  21 +++---
 arch/riscv/include/asm/pgtable.h    |   3 +-
 arch/riscv/include/asm/switch_to.h  |   9 +--
 arch/riscv/kernel/cpu.c             |   2 +-
 arch/riscv/kernel/cpufeature.c      |  29 ++++++--
 arch/riscv/kernel/process.c         |   2 +-
 arch/riscv/kernel/signal.c          |   4 +-
 arch/riscv/mm/init.c                |  23 +++---
 arch/riscv/mm/kasan_init.c          |   6 +-
 arch/riscv/tools/Makefile           |  22 ++++++
 arch/riscv/tools/cpucaps            |   6 ++
 arch/riscv/tools/gen-cpucaps.awk    |  40 +++++++++++
 15 files changed, 234 insertions(+), 49 deletions(-)
 create mode 100644 arch/riscv/include/asm/cpufeature.h
 create mode 100644 arch/riscv/tools/Makefile
 create mode 100644 arch/riscv/tools/cpucaps
 create mode 100755 arch/riscv/tools/gen-cpucaps.awk

-- 
2.34.1

