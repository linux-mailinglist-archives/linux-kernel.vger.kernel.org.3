Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292A747CFAF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 11:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239833AbhLVKDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 05:03:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52044 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234306AbhLVKDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 05:03:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640167428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=f9/yK/O5A9S2EhVeQBL3YUflpa0Yjrj43LgFGsF2Kkg=;
        b=jL08A+NJrmR/mVNhJUCDWMMQ27e8vwAisgV/mpAhQKlFROWJRYBcr2Xv9DjaOd/qZhWfeQ
        gLC2eQO/VjpcgHaMkFZJii3alRwU27ThR8Zj2CYm+fGpre7oJfG7w5hNziHSvef6HY9Mdz
        d5A4ndD7wvgTG0JsZcucGuQ8DBVz5o8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-Xr-OViLVOwKLys5xTopGzA-1; Wed, 22 Dec 2021 05:03:47 -0500
X-MC-Unique: Xr-OViLVOwKLys5xTopGzA-1
Received: by mail-wm1-f72.google.com with SMTP id a203-20020a1c7fd4000000b0034574187420so2745099wmd.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 02:03:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f9/yK/O5A9S2EhVeQBL3YUflpa0Yjrj43LgFGsF2Kkg=;
        b=beSnw0oXdYd3MV26m1KIWpFKIcxSs3TGoQ0+JxaXfaNT73mK3IMVglE0bvP3SuSjPa
         7e6xisMgHRiGAbwMWQ2w67oh2n288T+kBfgUwrRGnUH8XGPW/pfpgRDJny98C3/Jf+cN
         YoOyaSQ70RdoCeq1oBxkMMADSmNSrunaWJobVV/CEsFI9rDeX5KQKtlzKESzCsLZv2+O
         V/EBSaX5XwLiMtJ2PaentKs4ovzbpNk8KoUZnmBZpjkRJdQLZwgVO9ab/xV2K2bIbqkF
         3iqXOoX1IrMrQ41widgDJgO/Hre4ZxTkaFmzQ+2Mjf2uw/ybZPvB1NYnDwSx7CnSAP1Z
         UUnw==
X-Gm-Message-State: AOAM530vKsPwLSC/9zcAqd0n5UuZRn9uxQ5pnbXHG/RgioxRgbhUD7lI
        KEspYUNOlAxHV3pv/uVu/qrfosA/Er0Z/i6KogvuS5xOcZbAvdetgthmeF12q9CmYFV40vDo9lw
        44hQAbSZk1h8QFnoN0gf6f8X4
X-Received: by 2002:adf:cd85:: with SMTP id q5mr1627019wrj.80.1640167426620;
        Wed, 22 Dec 2021 02:03:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwhGoo7qunBs9vEZ4WK0OFS5LfpnU36hGkYF4e7Ft3KMdCqby6+ZGClQMI6d85XqH+nfancuw==
X-Received: by 2002:adf:cd85:: with SMTP id q5mr1627004wrj.80.1640167426402;
        Wed, 22 Dec 2021 02:03:46 -0800 (PST)
Received: from krava.redhat.com ([83.240.60.218])
        by smtp.gmail.com with ESMTPSA id y11sm1704432wry.70.2021.12.22.02.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 02:03:46 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] kprobe: Remove kprobe_instance and its related functions
Date:   Wed, 22 Dec 2021 11:03:45 +0100
Message-Id: <20211222100345.412013-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last user od kprobe_instance got removed in [1],
now it just occupies space, removing it.

[1] ec6aba3d2be1 ("kprobes: Remove kprobe::fault_handler")

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/kprobes.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 21eccc961bba..d20ae8232835 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -62,7 +62,6 @@ static bool kprobes_all_disarmed;
 
 /* This protects 'kprobe_table' and 'optimizing_list' */
 static DEFINE_MUTEX(kprobe_mutex);
-static DEFINE_PER_CPU(struct kprobe *, kprobe_instance);
 
 kprobe_opcode_t * __weak kprobe_lookup_name(const char *name,
 					unsigned int __unused)
@@ -353,17 +352,6 @@ struct kprobe_insn_cache kprobe_optinsn_slots = {
 #endif
 #endif
 
-/* We have preemption disabled.. so it is safe to use __ versions */
-static inline void set_kprobe_instance(struct kprobe *kp)
-{
-	__this_cpu_write(kprobe_instance, kp);
-}
-
-static inline void reset_kprobe_instance(void)
-{
-	__this_cpu_write(kprobe_instance, NULL);
-}
-
 /*
  * This routine is called either:
  *	- under the 'kprobe_mutex' - during kprobe_[un]register().
@@ -421,11 +409,8 @@ void opt_pre_handler(struct kprobe *p, struct pt_regs *regs)
 	struct kprobe *kp;
 
 	list_for_each_entry_rcu(kp, &p->list, list) {
-		if (kp->pre_handler && likely(!kprobe_disabled(kp))) {
-			set_kprobe_instance(kp);
+		if (kp->pre_handler && likely(!kprobe_disabled(kp)))
 			kp->pre_handler(kp, regs);
-		}
-		reset_kprobe_instance();
 	}
 }
 NOKPROBE_SYMBOL(opt_pre_handler);
@@ -1177,11 +1162,9 @@ static int aggr_pre_handler(struct kprobe *p, struct pt_regs *regs)
 
 	list_for_each_entry_rcu(kp, &p->list, list) {
 		if (kp->pre_handler && likely(!kprobe_disabled(kp))) {
-			set_kprobe_instance(kp);
 			if (kp->pre_handler(kp, regs))
 				return 1;
 		}
-		reset_kprobe_instance();
 	}
 	return 0;
 }
@@ -1193,11 +1176,8 @@ static void aggr_post_handler(struct kprobe *p, struct pt_regs *regs,
 	struct kprobe *kp;
 
 	list_for_each_entry_rcu(kp, &p->list, list) {
-		if (kp->post_handler && likely(!kprobe_disabled(kp))) {
-			set_kprobe_instance(kp);
+		if (kp->post_handler && likely(!kprobe_disabled(kp)))
 			kp->post_handler(kp, regs, flags);
-			reset_kprobe_instance();
-		}
 	}
 }
 NOKPROBE_SYMBOL(aggr_post_handler);
-- 
2.33.1

