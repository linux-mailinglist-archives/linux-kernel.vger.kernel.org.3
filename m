Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8A34E5C22
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 01:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346626AbiCXAJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 20:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240367AbiCXAJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 20:09:10 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206C28CCD1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 17:07:38 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nXB0k-00055s-Ts; Thu, 24 Mar 2022 01:07:30 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, liush@allwinnertech.com, guoren@kernel.org,
        atishp@atishpatra.org, anup@brainfault.org, drew@beagleboard.org,
        hch@lst.de, arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        gfavor@ventanamicro.com, andrea.mondelli@huawei.com,
        behrensj@mit.edu, xinhaoqu@huawei.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, samuel@sholland.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu, Heiko Stuebner <heiko@sntech.de>,
        Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v8 01/14] riscv: prevent null-pointer dereference with sbi_remote_fence_i
Date:   Thu, 24 Mar 2022 01:06:57 +0100
Message-Id: <20220324000710.575331-2-heiko@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220324000710.575331-1-heiko@sntech.de>
References: <20220324000710.575331-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The callback used inside sbi_remote_fence_i is set at sbi probe time
to the needed variant. Before that it is a NULL pointer.

Some users like the flush_icache_*() functions suggest a generic
functionality, that doesn't depend on a specific boot-stage but
uses sbi_remote_fence_i as one option to flush other cpu cores.

So they definitely shouldn't run into null-pointer dereference
issues when called "too early" during boot.

So introduce an empty function to be the standard for the __sbi_rfence
function pointer until sbi_init has run.

Users of sbi_remote_fence_i will have separate code for the local
cpu and sbi_init() is called before other cpus are brought up.
So there are no other cpus present at the time when the issue
might happen.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kernel/sbi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 775d3322b422..5a60a458c0b7 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -16,11 +16,19 @@
 unsigned long sbi_spec_version __ro_after_init = SBI_SPEC_VERSION_DEFAULT;
 EXPORT_SYMBOL(sbi_spec_version);
 
+static int __sbi_rfence_none(int fid, const struct cpumask *cpu_mask,
+			     unsigned long start, unsigned long size,
+			     unsigned long arg4, unsigned long arg5)
+{
+	return -EOPNOTSUPP;
+}
+
 static void (*__sbi_set_timer)(uint64_t stime) __ro_after_init;
 static int (*__sbi_send_ipi)(const struct cpumask *cpu_mask) __ro_after_init;
 static int (*__sbi_rfence)(int fid, const struct cpumask *cpu_mask,
 			   unsigned long start, unsigned long size,
-			   unsigned long arg4, unsigned long arg5) __ro_after_init;
+			   unsigned long arg4, unsigned long arg5)
+			   __ro_after_init = __sbi_rfence_none;
 
 struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
 			unsigned long arg1, unsigned long arg2,
-- 
2.35.1

