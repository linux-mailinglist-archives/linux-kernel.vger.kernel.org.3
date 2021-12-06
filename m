Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8C2469FCD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352238AbhLFPxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389126AbhLFPfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:35:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB49DC09B197
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 07:20:52 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638804051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CpKf9mvjkPjVBj3xIynQ2IUnpCyITLeKj1fi9KomO3Y=;
        b=uWwUXVC0WnVC3w1cQSTya5dZeSue12+qWIVuC9ayyFkiDFL9G0Sfv5sgG3Mgji+USmrR3i
        EWpfPFRxIdEY4IeWA5TWOKrxndqoCjKhwS6Z84fCwmzqI5MqDfCdegIbuQZB9GjhIHEpm9
        FJUtBRyeKaSoniNraKma5SZ8iP39mUCHkVgOKy+C16EcbvOsEWo9i5G2eiITHhzNmorRso
        R1QtcOksTF0JVbuDGxPjJ7j9MocO7Ohie4/A49LY70+rxjBb6jRaD1eLJouksuwvmd3vQZ
        Rkq3hMTMD3s+vWnN5KKN/KHj6i88h4DUhAnWP0giyBHHvJVKFll4ezdxsGpv4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638804051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CpKf9mvjkPjVBj3xIynQ2IUnpCyITLeKj1fi9KomO3Y=;
        b=O6EsH4ldQp4/tYChtuSnommkfShCw+Bw6sFmYII9N55xtHImCMLD/K/4e4TqkJmdda93r3
        FJIAmKHYkC9TGkCw==
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
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/2] x86/xen: Allow to retry if cpu_initialize_context() failed.
Date:   Mon,  6 Dec 2021 16:20:33 +0100
Message-Id: <20211206152034.2150770-2-bigeasy@linutronix.de>
In-Reply-To: <20211206152034.2150770-1-bigeasy@linutronix.de>
References: <20211206152034.2150770-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Ostrovsky <boris.ostrovsky@oracle.com>

If memory allocation in cpu_initialize_context() fails then it will
bring up the VCPU and leave with the corresponding CPU bit set in
xen_cpu_initialized_map.
The following (presumably successful) CPU bring up will BUG in
xen_pv_cpu_up() because nothing for that VCPU would be initialized.

Clear the CPU bits, that were set in cpu_initialize_context() in case
the memory allocation fails.

[ bigeasy: Creating a patch from Boris' email. ]

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/xen/smp_pv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 6a8f3b53ab834..86368fcef4667 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -277,8 +277,11 @@ cpu_initialize_context(unsigned int cpu, struct task_s=
truct *idle)
 		return 0;
=20
 	ctxt =3D kzalloc(sizeof(*ctxt), GFP_KERNEL);
-	if (ctxt =3D=3D NULL)
+	if (ctxt =3D=3D NULL) {
+		cpumask_clear_cpu(cpu, xen_cpu_initialized_map);
+		cpumask_clear_cpu(cpu, cpu_callout_mask);
 		return -ENOMEM;
+	}
=20
 	gdt =3D get_cpu_gdt_rw(cpu);
=20
--=20
2.34.1

