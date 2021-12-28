Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0584C480A67
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 15:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbhL1OmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 09:42:00 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34524 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbhL1Oly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 09:41:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 702F561196;
        Tue, 28 Dec 2021 14:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0161C36AEC;
        Tue, 28 Dec 2021 14:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640702512;
        bh=0DWs5iJTfzb/AG7lBwtZhAg40maM1nWs2s2i8EajS74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OxBh7C71IIHi9eO5f/pmVx9w0T1KnI8arKFeLEyKuSw0k29VBXEkTJRZveE91eXTZ
         Zp4HIyyeePW0cxsnvhM19Zq8yUN4TpicnnaJJTR77X7dNfLXaRvZoTBMxOp66HimNv
         HVRUw/5Pgn+LSyE8hKnUA77rJ1QYylCqmE/zSVKMaVD4oc8fAns99GeIItWl/PDjPR
         PNPCcZQ2R166HFL/1uLl7cAHv3S+40xgOpXXPr9RGMMjz7ITs4K6LO3GLRFyqAxJAV
         fKqtpUi80X7z40+I9PFzqcdszWf0uUtXjQ34NyfrqN4b7UIguk1ClwbWuOtZXh5KlX
         i1guq1GoJ0IPg==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        anup.patel@wdc.com, gregkh@linuxfoundation.org,
        liush@allwinnertech.com, wefu@redhat.com, drew@beagleboard.org,
        wangjunqiang@iscas.ac.cn, hch@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        inux-parisc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2 16/17] riscv: compat: Add UXL_32 support in start_thread
Date:   Tue, 28 Dec 2021 22:39:57 +0800
Message-Id: <20211228143958.3409187-17-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211228143958.3409187-1-guoren@kernel.org>
References: <20211228143958.3409187-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

If the current task is in COMPAT mode, set SR_UXL_32 in status for
returning userspace.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/riscv/kernel/process.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 03ac3aa611f5..1a666ad299b4 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -97,6 +97,11 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
 	}
 	regs->epc = pc;
 	regs->sp = sp;
+
+#ifdef CONFIG_COMPAT
+	if (is_compat_task())
+		regs->status |= SR_UXL_32;
+#endif
 }
 
 void flush_thread(void)
-- 
2.25.1

