Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A600B469FA4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391924AbhLFPuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389328AbhLFPf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:35:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBA5C07E5F5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 07:20:59 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638804057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=41Yw8yf+7TjYHl20/Q/EDf0gZtvNJ2sbLTnT1+NsteE=;
        b=LQgKbrKct/We7aHQ0TZFYlFpu0pNkOgrZ0sdarc6GLYKUkQoeNNAReN09czDjhMhsLh9te
        BX3g529ypr8U7D45FxquyLLsCnFTwa0E8VwTVABJ3Nz8tDiFDmwt9s65LduJcR/MYqdWBf
        TIlYLOsZZ356mha/P1VdYYQwPYgxszdT1xkJgZqKp7s4Q4jUgb4VTxhB2dRrgJejQ+s6Hu
        RG2ATWq0wWTu0Hp7ii/kr1uHYB2VoBrrmPiAeKTaaGoYw854rUmH3ZiCOjFfry6OfkAJFM
        QqoIe6pKucm2KTK3qWnikwFJv8x4UouEHovyaNHMt7s4xGg1BcQDOUnjW0tbtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638804057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=41Yw8yf+7TjYHl20/Q/EDf0gZtvNJ2sbLTnT1+NsteE=;
        b=sxMj8+RWZBRXTITuDvoBALBqgfRKj9Zi74fNBcRPtr6Ur/ZuBm1c25eHa7tYX8nSmHpODY
        3rlnDKXz8mPQb8Bg==
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        xen-devel@lists.xenproject.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Longpeng <longpeng2@huawei.com>,
        Gonglei <arei.gonglei@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Henry Wang <Henry.Wang@arm.com>
Subject: [PATCH 2/2] cpu/hotplug: Allow the CPU in CPU_UP_PREPARE state to be brought up again.
Date:   Mon,  6 Dec 2021 16:20:34 +0100
Message-Id: <20211206152034.2150770-3-bigeasy@linutronix.de>
In-Reply-To: <20211206152034.2150770-1-bigeasy@linutronix.de>
References: <20211206152034.2150770-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Longpeng(Mike)" <longpeng2@huawei.com>

A CPU will not show up in virtualized environment which includes an
Enclave. The VM splits its resources into a primary VM and a Enclave
VM. While the Enclave is active, the hypervisor will ignore all requests
to bring up a CPU and this CPU will remain in CPU_UP_PREPARE state.
The kernel will wait up to ten seconds for CPU to show up
(do_boot_cpu()) and then rollback the hotplug state back to
CPUHP_OFFLINE leaving the CPU state in CPU_UP_PREPARE. The CPU state is
set back to CPUHP_TEARDOWN_CPU during the CPU_POST_DEAD stage.

After the Enclave VM terminates, the primary VM can bring up the CPU
again.

Allow to bring up the CPU if it is in the CPU_UP_PREPARE state.

[bigeasy: Rewrite commit description.]

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/20210901051143.2752-1-longpeng2@huawei.com
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Henry Wang <Henry.Wang@arm.com>
Link: https://lore.kernel.org/r/20211122154714.xaoxok3fpk5bgznz@linutronix.=
de
---
 kernel/smpboot.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/smpboot.c b/kernel/smpboot.c
index f6bc0bc8a2aab..b9f54544e7499 100644
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -392,6 +392,13 @@ int cpu_check_up_prepare(int cpu)
 		 */
 		return -EAGAIN;
=20
+	case CPU_UP_PREPARE:
+		/*
+		 * Timeout while waiting for the CPU to show up. Allow to try
+		 * again later.
+		 */
+		return 0;
+
 	default:
=20
 		/* Should not happen.  Famous last words. */
--=20
2.34.1

