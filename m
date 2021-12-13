Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD9C472B2D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbhLMLU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:20:58 -0500
Received: from gloria.sntech.de ([185.11.138.130]:37648 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231296AbhLMLU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:20:56 -0500
Received: from p5b127e39.dip0.t-ipconnect.de ([91.18.126.57] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mwjNt-0001Dm-EB; Mon, 13 Dec 2021 12:20:45 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     atishp@atishpatra.org, anup@brainfault.org, jszhang@kernel.org,
        christoph.muellner@vrull.eu, philipp.tomsich@vrull.eu,
        mick@ics.forth.gr, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 2/2] riscv: provide default implementations for __sbi_set_timer and __sbi_send_ipi
Date:   Mon, 13 Dec 2021 12:20:34 +0100
Message-Id: <20211213112034.2896536-2-heiko@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211213112034.2896536-1-heiko@sntech.de>
References: <20211213112034.2896536-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mentioned function pointers get called from different sbi functions
which may get called from other areas of the kernel without fully
checking if the sbi initialization was done.

So similarly to sbi_remote_fence_i, provide empty functions for them
to prevent any null-pointer dereferences in the future.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/riscv/kernel/sbi.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 69d0a96b97d0..6a21345c6712 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -14,6 +14,13 @@
 unsigned long sbi_spec_version __ro_after_init = SBI_SPEC_VERSION_DEFAULT;
 EXPORT_SYMBOL(sbi_spec_version);
 
+static void __sbi_set_timer_none(uint64_t stime_value) {}
+
+static int __sbi_send_ipi_none(const unsigned long *hart_mask)
+{
+	return -EOPNOTSUPP;
+}
+
 static int __sbi_rfence_none(int fid, const unsigned long *hart_mask,
 			     unsigned long start, unsigned long size,
 			     unsigned long arg4, unsigned long arg5)
@@ -21,8 +28,9 @@ static int __sbi_rfence_none(int fid, const unsigned long *hart_mask,
 	return -EOPNOTSUPP;
 }
 
-static void (*__sbi_set_timer)(uint64_t stime) __ro_after_init;
-static int (*__sbi_send_ipi)(const unsigned long *hart_mask) __ro_after_init;
+static void (*__sbi_set_timer)(uint64_t stime) __ro_after_init = __sbi_set_timer_none;
+static int (*__sbi_send_ipi)(const unsigned long *hart_mask)
+			    __ro_after_init = __sbi_send_ipi_none;
 static int (*__sbi_rfence)(int fid, const unsigned long *hart_mask,
 			   unsigned long start, unsigned long size,
 			   unsigned long arg4, unsigned long arg5)
-- 
2.30.2

