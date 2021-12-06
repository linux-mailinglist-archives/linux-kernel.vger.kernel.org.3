Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B6346A0DA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358179AbhLFQQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:16:24 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46646 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386391AbhLFQP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:15:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9386861371
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 16:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E24C341C1;
        Mon,  6 Dec 2021 16:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638807149;
        bh=dwbrNjZZfbu4oEgK1JyUMMblUgSIXuqfZwlfGeMoXPc=;
        h=From:To:Cc:Subject:Date:From;
        b=a9Z803W9nzZK1lISjFvZTCPzk5gyjgPf80jyDPez6w2IaEu2N5Ny5VuMEVutBTGKJ
         gALiRfbRgaEg/GwxHiVUjdD+XvupTZusEYKusCqUVKulKJ84aSvDi6QoAJF6dSDRrH
         T5igpNHJHXA93HttOAqSgGuzg9DhexvLcFSPhBmd38lf2gRszUelaAzvrZmtkA1Nzo
         Et1BonhmJCUVbZqWxl4nLVsLbXF7JY8LfMv7yg0LmcQMRsiT4Kb+SAemnLF5z1I5N1
         HbeJ874mdet+GqLXVwACn1t/JtNIXD5+3dhPT0/xHyoEz5mBV2ufkMXVFzpgVA4Ogs
         BD05a6x6djLMw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        hpa@zytor.com, Eric Biederman <ebiederm@xmission.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kexec@lists.infradead.org,
        Alexandre ghiti <alex@ghiti.fr>
Subject: [PATCH v2 0/5] kexec: use IS_ENABLED(CONFIG_KEXEC_CORE) instead of #ifdef
Date:   Tue,  7 Dec 2021 00:05:09 +0800
Message-Id: <20211206160514.2000-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the conditional compilation using "#ifdef CONFIG_KEXEC_CORE"
by a check for "IS_ENABLED(CONFIG_KEXEC_CORE)", to simplify the code
and increase compile coverage.

I only modify x86, arm, arm64 and riscv, other architectures such as
sh, powerpc and s390 are better to be kept kexec code as-is so they
are not touched.

Since v1:
 - collect Reviewed-by tag
 - fix misleading commit msg.

Jisheng Zhang (5):
  kexec: make crashk_res, crashk_low_res and crash_notes symbols always
    visible
  riscv: mm: init: use IS_ENABLED(CONFIG_KEXEC_CORE) instead of #ifdef
  x86/setup: use IS_ENABLED(CONFIG_KEXEC_CORE) instead of #ifdef
  arm64: mm: use IS_ENABLED(CONFIG_KEXEC_CORE) instead of #ifdef
  arm: use IS_ENABLED(CONFIG_KEXEC_CORE) instead of #ifdef

 arch/arm/kernel/setup.c |  7 +++----
 arch/arm64/mm/init.c    |  9 +++------
 arch/riscv/mm/init.c    |  6 ++----
 arch/x86/kernel/setup.c | 10 +++-------
 include/linux/kexec.h   | 12 ++++++------
 5 files changed, 17 insertions(+), 27 deletions(-)

-- 
2.34.1

