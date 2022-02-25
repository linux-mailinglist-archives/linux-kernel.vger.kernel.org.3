Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7915F4C3FD0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 09:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238381AbiBYIMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 03:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235930AbiBYIML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:12:11 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E9BDEEB
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 00:11:37 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id p9so3170385wra.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 00:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=UBLS7I7dklf7q80OfnsV44HmdpezS2KIc4AWPPfOP04=;
        b=VmMDQhXZmW4KDOJcfBmlCBg33brjp9/FsvEsQq7AffkbjS1GeappduvSErrFoHJCPH
         4xVqaTIfaNjdXXrn4CqxUSvsL006OkvNj7yqrfLpVd0Z52/JQ9gUjeWYtz6Yc68FhtKG
         jU3N4MsHypNSnstReXP0RnnZO9RTAkFEYromKyn1uYaGYpphZXkwPGdSSNFabKe6EIt8
         HWw6x1CDGsRjItQCpqpsawyGOJTtoQXC/t9q7nIvSAyArxgpm+fJA5mQDoCdHb6QKqG8
         0M5wBFSvZP1A6mkfw5cvFRmDYS2qleDoxRbH7NoIo7DqZs2OKcFLHEKhujpMyzKbT9OI
         zsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UBLS7I7dklf7q80OfnsV44HmdpezS2KIc4AWPPfOP04=;
        b=QeXpUpyMNXdnolnJ7s7w+4taS4TOYfyUhjVj2NSJA7VySh5N0Z3VB8y/bDnjQTo+xt
         5WEEPkdYdfCwWouS8cCfWDZPNbHB0EorxWSGml4WLc4xFvZj6+eQcJxAkpThuoBL6oY2
         Albx9PVmbpm59HgpH/tj0pZIwv13ju3VrTnuF4ws5NHO+eoIwiv+chgPojIpRbpQDQi5
         2uaFIH6te8fSrAx8WsRQlRxdF/wn7fD2ULNle4sBG5qER3o4J5Ws4cL1pEMOl2D1+yIN
         AOXmwdCPM2UvTPa6vBCaR9Jh293ohpt4Oa/oqlOqTSnWY+7pEiwEq15hK5V7rmA9WEDi
         RKBA==
X-Gm-Message-State: AOAM532q6A/PmFudHzQfsB97nqhVxD8wLnJwzpH0Jcg/c43Qea7jD5Mo
        Xp0q2FbswlRwFOX1I9FNerc=
X-Google-Smtp-Source: ABdhPJyCDoikK7f54V0mXZagQeuhGKw7xJp/PtqFade8F1gSuFIJPWK8WRRBh+uUcFbVeU632u363Q==
X-Received: by 2002:a5d:6389:0:b0:1ed:bc35:cda4 with SMTP id p9-20020a5d6389000000b001edbc35cda4mr5307355wru.350.1645776696385;
        Fri, 25 Feb 2022 00:11:36 -0800 (PST)
Received: from localhost.localdomain ([64.64.123.58])
        by smtp.gmail.com with ESMTPSA id m13-20020a05600c3b0d00b0037c00e01771sm5215190wms.34.2022.02.25.00.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 00:11:35 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com
Cc:     x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] arch: x86: xen: check the return value of kasprintf()
Date:   Fri, 25 Feb 2022 00:11:21 -0800
Message-Id: <20220225081121.18803-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function kasprintf() can fail, but there is no check of its return
value. To fix this bug, its return value should be checked with new
error handling code.

Fixes: f87e4cac4f4e ("xen: SMP guest support")
Fixes: 83b96794e0ea ("x86/xen: split off smp_pv.c")
Fixes: d5de8841355a ("x86: split spinlock implementations out into their own files")
Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 arch/x86/xen/smp.c      | 2 ++
 arch/x86/xen/smp_pv.c   | 2 ++
 arch/x86/xen/spinlock.c | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/x86/xen/smp.c b/arch/x86/xen/smp.c
index c3e1f9a7d43a..91261390f8c0 100644
--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -65,6 +65,8 @@ int xen_smp_intr_init(unsigned int cpu)
 	char *resched_name, *callfunc_name, *debug_name;
 
 	resched_name = kasprintf(GFP_KERNEL, "resched%d", cpu);
+	if (!resched_name)
+		return -ENOMEM;
 	rc = bind_ipi_to_irqhandler(XEN_RESCHEDULE_VECTOR,
 				    cpu,
 				    xen_reschedule_interrupt,
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 4a6019238ee7..7d1471fd1267 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -118,6 +118,8 @@ int xen_smp_intr_init_pv(unsigned int cpu)
 	char *callfunc_name, *pmu_name;
 
 	callfunc_name = kasprintf(GFP_KERNEL, "irqwork%d", cpu);
+	if (!callfunc_name)
+		return -ENOMEM;
 	rc = bind_ipi_to_irqhandler(XEN_IRQ_WORK_VECTOR,
 				    cpu,
 				    xen_irq_work_interrupt,
diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index 043c73dfd2c9..ccdb9eddd93b 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -75,6 +75,8 @@ void xen_init_lock_cpu(int cpu)
 	     cpu, per_cpu(lock_kicker_irq, cpu));
 
 	name = kasprintf(GFP_KERNEL, "spinlock%d", cpu);
+	if (!name)
+		return;
 	irq = bind_ipi_to_irqhandler(XEN_SPIN_UNLOCK_VECTOR,
 				     cpu,
 				     dummy_handler,
-- 
2.17.1

