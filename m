Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7895447300B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 16:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239976AbhLMPEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 10:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239988AbhLMPEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 10:04:02 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EF5C061372
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 07:03:58 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id z6so11361474plk.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 07:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zKT0gK8WlFxkldfUljSdLPCzJpgcOsj4NOowqaNGJQk=;
        b=bHSuRMckyi3+G3X9YvzQqqurMz5PU+TehAGDj3Dnj6WoHRTGnCPoPnyVwg10nI9L9C
         7jeahwboqymTabe+OTYZkcSDRQlqIz4Rnoz5S/zsRA/ilAdGjN/zeeD0IyCa1UhTQxQP
         Metuhh+Vu+HoysIzZNJdGskYJTaPd65Yu+6Yu8WL6QjV/PnJUUO8JLczyDAXFRHbL7iN
         EoYRkcDhv+B4m929fMJuDwXIcjLXL9LL0sQQBdHjulQ8qsKfgnqzOo3shSBeEz1z0iOv
         Hkms4rFtiXd91rQ9BWTZ0vx92QR/V5wj6vXWEwWxd6na3xifUNx324nUf7yeyNXqpdot
         TEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zKT0gK8WlFxkldfUljSdLPCzJpgcOsj4NOowqaNGJQk=;
        b=a3iMAlIjgdp2g/OFbpGrsGs6q2HyUjuurq5NxlfwkLDasNoQ7M0dsFGPY4IJsUqWwA
         mpEwUrgXxrMoUXW5WoHgA1SovbeUrt5YoMQu9oyPQboi1zYlVAoFPO51i263C0FEezgo
         5dBii/uWUgVEoFz8O6SmS6Hn1nWCjlfJBXHGu6h283xMHOoc1PmMbIRK/DjMXVqT7n01
         c7FEH8QxXw6xooUYK+CR6x49LTzbqUKjoirNMUHPqRju3fmED6udNCEF3XwNpgra0rkc
         9qiLpbg0ovIoD2wi0jixaYjDueQ1GpJo2SRmMiB9J1arVAZPIrAr9z7QDwjOR0+r60T1
         3/pQ==
X-Gm-Message-State: AOAM5326WhICqQS7b4A0cgbOoBFXHiIIbttLz6CgJJPaWhrSsKlDEMqK
        6P4JevcrIB6gpxEiX+sb/vA8FB8qvcjZ+w==
X-Google-Smtp-Source: ABdhPJwET8GHD9tpZosfS0KgsQlScotAfmdePO42J2nFOMrgaqKAoetMj0Tis7faRV1eSRCUnXh/4w==
X-Received: by 2002:a17:902:c412:b0:141:f710:2a94 with SMTP id k18-20020a170902c41200b00141f7102a94mr97263359plk.1.1639407837826;
        Mon, 13 Dec 2021 07:03:57 -0800 (PST)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id j11sm12844518pfj.35.2021.12.13.07.03.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Dec 2021 07:03:57 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: [PATCH 4/4] x86/nmi: Convert nmi_cr2/nmi_dr7 to be func-local variable
Date:   Mon, 13 Dec 2021 23:03:40 +0800
Message-Id: <20211213150340.9419-5-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211213150340.9419-1-jiangshanlai@gmail.com>
References: <20211213150340.9419-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

nmi_cr2 and nmi_dr7 are used inside a function (the outmost exc_nmi()),
they don't need to be percpu data.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/kernel/nmi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 44c3adb68282..673eee5831db 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -470,12 +470,12 @@ enum nmi_states {
 	NMI_LATCHED,
 };
 static DEFINE_PER_CPU(enum nmi_states, nmi_state);
-static DEFINE_PER_CPU(unsigned long, nmi_cr2);
-static DEFINE_PER_CPU(unsigned long, nmi_dr7);
 
 DEFINE_IDTENTRY_NMI(exc_nmi)
 {
 	irqentry_state_t irq_state;
+	unsigned long nmi_cr2;
+	unsigned long nmi_dr7;
 
 	/*
 	 * Re-enable NMIs right here when running as an SEV-ES guest. This might
@@ -491,7 +491,7 @@ DEFINE_IDTENTRY_NMI(exc_nmi)
 		return;
 	}
 	this_cpu_write(nmi_state, NMI_EXECUTING);
-	this_cpu_write(nmi_cr2, read_cr2());
+	nmi_cr2 = read_cr2();
 nmi_restart:
 
 	/*
@@ -500,7 +500,7 @@ DEFINE_IDTENTRY_NMI(exc_nmi)
 	 */
 	sev_es_ist_enter(regs);
 
-	this_cpu_write(nmi_dr7, local_db_save());
+	nmi_dr7 = local_db_save();
 
 	irq_state = irqentry_nmi_enter(regs);
 
@@ -511,12 +511,12 @@ DEFINE_IDTENTRY_NMI(exc_nmi)
 
 	irqentry_nmi_exit(regs, irq_state);
 
-	local_db_restore(this_cpu_read(nmi_dr7));
+	local_db_restore(nmi_dr7);
 
 	sev_es_ist_exit();
 
-	if (unlikely(this_cpu_read(nmi_cr2) != read_cr2()))
-		write_cr2(this_cpu_read(nmi_cr2));
+	if (unlikely(nmi_cr2 != read_cr2()))
+		write_cr2(nmi_cr2);
 	if (this_cpu_dec_return(nmi_state))
 		goto nmi_restart;
 
-- 
2.19.1.6.gb485710b

