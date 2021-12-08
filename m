Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F6946D6E3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 16:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235961AbhLHP0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 10:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235978AbhLHP0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:26:45 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA37C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 07:23:13 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id k25-20020a05600c1c9900b00332f798ba1dso3172307wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 07:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yo/eXM0M5vLhun4zn7QEhUouednn+qQj5dLApDQTa4k=;
        b=YQiiyTtUq3FaM4VAJoRYtem6jDT89osDA2RviQd2g7IHWgQJ2hB10vOD4CnqbX80AH
         Q03Kv0t3cWaNVFH1q6wRsylJ5jUi0wqfgyba5j8cMwuubV0aq//6Yx3rXFD3A7vFd+5a
         QaJSdPOTGPYL7v2/LTUouYfSPXGBXWEV6dqjmyQm6v5eRnmQFCNoPjtn5tvVgXgzaOXf
         UvQqBvOuCgat8swSkzUAV+FtJRHigg7wX2okKam46SRWE5L0r64Ce2BYha5fYY273J7A
         ULh+k1+ojzQY3CDqEKIVR7qDEtjRXHo6xmgkTRZFN2V1FPXKiL26iAIlSpweK5BIkit2
         QJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yo/eXM0M5vLhun4zn7QEhUouednn+qQj5dLApDQTa4k=;
        b=msL2utL8GAFmzTbidCyCqVa0fnMvwZuAXwY2WdCSBKIdKnpqO4WaH4/VgLk3SX+KRf
         3qcKG9jL+I8uy8VTOVP6Uu/TZ/r63EzQjE68LQKRE2uNfWps6xrRIir/XJoT2DPDcVca
         NsROD43fUFwkfQP76F+Qz6ruDRQbMOOtmR3fzFWvkYgSfWULwusK17ePlesfRa8911ey
         J/enh8gIQGYgzmM6o5TdpjFM4skJd5Y76eiW3T2L9RLE85UFqFUTG6g/ZbYQohncyegF
         Z6P3vpTCvsbL6uQ7bH2JyjqgnNoaUCCNqhbNsBjLZjM0saEWQziGTTfGYBNbHyNe72Db
         z7NQ==
X-Gm-Message-State: AOAM533y+WfD9Hu6VZFjzTU1Pkg79u5+Xdnq2x0VvF86fMy7bpw3yNu7
        heX+rcswyyP9v9sXTnW0Bi+tnVCkI634
X-Google-Smtp-Source: ABdhPJwOfjubqI7meWxcl9D37/U/vlVJzBvp2U2d2RIIBKuRn/8kPhrJIutIwFz0Y5iAUysi8gbYXfV0y2wu
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:c718:14b8:982a:57d5])
 (user=qperret job=sendgmr) by 2002:a05:6000:252:: with SMTP id
 m18mr59432350wrz.117.1638976991841; Wed, 08 Dec 2021 07:23:11 -0800 (PST)
Date:   Wed,  8 Dec 2021 15:22:56 +0000
In-Reply-To: <20211208152300.2478542-1-qperret@google.com>
Message-Id: <20211208152300.2478542-4-qperret@google.com>
Mime-Version: 1.0
References: <20211208152300.2478542-1-qperret@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH 3/6] KVM: arm64: Make the hyp memory pool static
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hyp memory pool struct is sized to fit exactly the needs of the
hypervisor stage-1 page-table allocator, so it is important it is not
used for anything else. As it is currently used only from setup.c,
reduce its visibility by marking it static.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/mm.h | 1 -
 arch/arm64/kvm/hyp/nvhe/setup.c      | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mm.h b/arch/arm64/kvm/hyp/include/nvhe/mm.h
index ef6a58a04235..3f60d6cc5368 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mm.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mm.h
@@ -12,7 +12,6 @@
 
 extern struct kvm_pgtable pkvm_pgtable;
 extern hyp_spinlock_t pkvm_pgd_lock;
-extern struct hyp_pool hpool;
 extern u64 __io_map_base;
 
 int hyp_create_idmap(u32 hyp_va_bits);
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 51e68a040d8a..e31149965204 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -18,7 +18,6 @@
 #include <nvhe/mm.h>
 #include <nvhe/trap_handler.h>
 
-struct hyp_pool hpool;
 unsigned long hyp_nr_cpus;
 
 #define hyp_percpu_size ((unsigned long)__per_cpu_end - \
@@ -28,6 +27,7 @@ static void *vmemmap_base;
 static void *hyp_pgt_base;
 static void *host_s2_pgt_base;
 static struct kvm_pgtable_mm_ops pkvm_pgtable_mm_ops;
+static struct hyp_pool hpool;
 
 static int divide_memory_pool(void *virt, unsigned long size)
 {
-- 
2.34.1.400.ga245620fadb-goog

