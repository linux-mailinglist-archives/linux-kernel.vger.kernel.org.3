Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3FC34AEBBB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240451AbiBIICc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240316AbiBIICU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:02:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D40C05CB84
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 00:02:23 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644393742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mGICh+XWg4zl0BiLYSOzGN+Dsvh3xZ6pQjRuhNeu4t0=;
        b=ExUJbo84qFWHQkDAcAAStNINkRabfk8iqlakMkfpAmeUEtkbAySRTYSeSJDPzjC8ESDJjs
        swNFfrhhlAGeF0NLs/r64Eyk+1Td6b9zKYMN3ok5zwYOgcaOAP1qkPPo1oL2jV2sNsdI5+
        LiSOvtHlUYOZK+mDwdteqLAhgWjyasTaXK64aUt9UGdT8Z5UiiLBZU6owgmiZqsUOgXuLM
        fEDKOzNGXSw1XwOn+qC53DI8miXoiqN0FrfwxuqRL9vsRDzdbnbAHm6QPh7QLy1Brvz86x
        AowW/70fENFFaxAkvAaZcbDSXsWmL22tSd1WGdhaLdOKNblqDvfFYeWtRQhi+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644393742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mGICh+XWg4zl0BiLYSOzGN+Dsvh3xZ6pQjRuhNeu4t0=;
        b=g1B138BAtPqSmJQ3szFTc93wehmOLL8GH6VVKCoGPE7yBHuAp4eaCSW9kuMmWr95Ow20Gr
        zuRl08iV0JPH6NDg==
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
Subject: [PATCH REPOST v2 2/2] cpu/hotplug: Allow the CPU in CPU_UP_PREPARE state to be brought up again.
Date:   Wed,  9 Feb 2022 09:02:14 +0100
Message-Id: <20220209080214.1439408-3-bigeasy@linutronix.de>
In-Reply-To: <20220209080214.1439408-1-bigeasy@linutronix.de>
References: <20220209080214.1439408-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Link: https://lore.kernel.org/r/20211206152034.2150770-3-bigeasy@linutronix=
.de
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

