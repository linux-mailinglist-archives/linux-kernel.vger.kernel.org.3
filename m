Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195CE4AEBBC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240374AbiBIICX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238194AbiBIICU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:02:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F2CC05CB81
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 00:02:23 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644393741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FtIrm50qhttDnvw+t6HEGKMbZATCUZOMdzvBi9MSe90=;
        b=M+XiBZLvnS4bNyf917WB109HyC2w29CJUrl4+O3s0DgpsdEx7qd9LvVurUJCNhRS15Nnsu
        cRSfB+3pzT1O13psRd1f1F9RUn9biTeEoiOyQmgimdTbr/vjqZy4deWCmwndr0QD2ufJ+o
        Sqd0tsdtLPAXbSLtB6Ji4LmVP+iCKv0Wi8A/f7QNPsiv7QL9eRdaHboT0vES0Rkm5q3nVj
        SpwQ1re3o986jPQhDh5fxadxCmGBF1Vzc3lThDa3bMhOehonLIvbh9MLuv6ROwY5VULVZR
        2E4X2eG/cFMezVii0GULTAbaf5XfnGRONCEx1DX7F1mYfNUvbSlZMPFwSeGCFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644393741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FtIrm50qhttDnvw+t6HEGKMbZATCUZOMdzvBi9MSe90=;
        b=+3CvOrEeIA0hMtHDBMPRo5y999b5GRmR5FqI8tJFmUGxGgnh38jpNfHNPILyt8qyLKUD1R
        20dt3aOcmPlVKbDQ==
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
Subject: [PATCH REPOST v2 1/2] x86/xen: Allow to retry if cpu_initialize_context() failed.
Date:   Wed,  9 Feb 2022 09:02:13 +0100
Message-Id: <20220209080214.1439408-2-bigeasy@linutronix.de>
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
Link: https://lore.kernel.org/r/20211206152034.2150770-2-bigeasy@linutronix=
.de
---
 arch/x86/xen/smp_pv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 4a6019238ee7d..57c3f9332ec94 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -260,8 +260,11 @@ cpu_initialize_context(unsigned int cpu, struct task_s=
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

