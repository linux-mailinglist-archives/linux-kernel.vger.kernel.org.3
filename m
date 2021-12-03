Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A5C467168
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 06:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237705AbhLCFWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 00:22:37 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52024 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbhLCFWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 00:22:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C462B825B7
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 05:19:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE51C53FC7;
        Fri,  3 Dec 2021 05:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638508751;
        bh=DIZ3iH9eTHW1kh3AtvEImcM5tdEzpteHHLSK3AhyocI=;
        h=From:To:Cc:Subject:Date:From;
        b=pwAgFJYrBa6ZaXpfWCune5BzG6L7h1HBmuLVVxnUVumJnJNly8D9n25nol++Q6NrE
         omijuK2cbfxAN0weD9K0s5YOrmKpa+sXTxvw30B87IOuPW2ty0CSz1BmIrPFZ+ZC7Y
         Gw90LwhSB7r3c2My/ifoHcj/cjfue3r8HPoRLqLFgGzx5+cBV2Nu/RcEUibuOIfuvJ
         SHcugi2aJOTLuv3i5ibsKLT1MnzCnwtMk7uy3jIo8qwoIUN2bznKPITIj6XYr+LH43
         3oKo7rN/NdUvshAWpldSxfqFHfTacl7nM8Es81p38wsHP7hhvDDDUcwsBG3iwXy670
         JhW8DJiDTf9kQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        hpa@zytor.com, Eric Biederman <ebiederm@xmission.com>,
        Alexandre Ghiti <alex@ghiti.fr>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kexec@lists.infradead.org
Subject: [RFC PATCH 0/5] kexec: use IS_ENABLED(CONFIG_KEXEC_CORE) instead of #ifdef
Date:   Fri,  3 Dec 2021 13:11:52 +0800
Message-Id: <20211203051157.2160-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the conditional compilation using "#ifdef CONFIG_KEXEC_CORE"
by a check for "IS_ENABLED(CONFIG_BLK_DEV_INITRD)", to simplify the
code and increase compile coverage.

I only modifies x86, arm, arm64 and riscv, other arch are not touched.
If the idea is accepted, I will modify all architectures code.

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

