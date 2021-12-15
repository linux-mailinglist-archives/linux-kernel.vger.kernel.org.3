Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E91C475D1A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244639AbhLOQNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244634AbhLOQNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:13:15 -0500
Received: from mail-lj1-x249.google.com (mail-lj1-x249.google.com [IPv6:2a00:1450:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702CAC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:13:15 -0800 (PST)
Received: by mail-lj1-x249.google.com with SMTP id bn28-20020a05651c179c00b002222b4cc6d8so6556292ljb.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2TGPIYSaEIjKXjmvhnIXxrzrd8fguGN1MQzZdij/gwk=;
        b=bx6YgQQWKyCSriIz1R2rvmpQeUPcD0LpKjIZj+LDd11kYfmZKlDmapJ/NyEJhKB7GO
         0GNru/GfkcY439wnQd6qGZWJ0R4V8TCPgdF4fQCmFf2mLn1nyyp7lky7fe2/FaH0RHIt
         ayc9pOBPTj6NebOFz8Q/fypnbTOti4vduxE+9sd9VMnD0V8ByjDjpM0LtEIpro98NX+C
         xloCTF1+b5uUnxrAf8KMgFnozY/oViJEotm4Te4lvAcvr85lmaAQHI0wOMWk9biEgA94
         CdeqYpF58doTpOxXGhwdvr8+ryDxaa43mMdVMz3zcHokS9iuQ95w4Vg0j4BSjvXa10iK
         gr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2TGPIYSaEIjKXjmvhnIXxrzrd8fguGN1MQzZdij/gwk=;
        b=Cz1dSpKkpD56QhMpDknaz/7h4r/pwHuM+SMIHmTJS8oqC46XfgSKSdsCC3+4aDizv7
         3aUtWKHfooMMXAJfptDvz3mwC4Y82tse2u92U4En4V+wDOkTI9hm/Yv/wCr7sWZ1bdqu
         bPPyFl/JcEjqn7JyzfrH+tzDSvIHLP7OheOo43fzIhiC082AJlvz8JEKbwzKT5C/EK40
         x5er1BMCFWGhSbjosLg3jBE2EIhv6Q8ZLZpUsMW2/ypaJSD/Vw1BAlorM6+YJ6LYyPZM
         DdoeHxd5R96XxAT0/FKrYVmnOVDJIgW7QDegqWeLQAabE9M06F4wOirqoeZsytbSp8U6
         jHVg==
X-Gm-Message-State: AOAM531b/FzTwU0nih3QVVsFxR76i4tArQyNL2p+pTr9J6bDG2HPpydy
        VYTp/kvbGMPzYSjOy5pTplvgePbYLgw3
X-Google-Smtp-Source: ABdhPJzILf2Wp1hVJt12n/LnfOzJSJvsC7ZTraq2mR6Vo+DADiIAWTxTcbaMTv7WHfizd8OOLb/5vfdAWkVM
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:fc03:4f5b:4e9b:3ec1])
 (user=qperret job=sendgmr) by 2002:a05:6512:388b:: with SMTP id
 n11mr10318861lft.198.1639584793573; Wed, 15 Dec 2021 08:13:13 -0800 (PST)
Date:   Wed, 15 Dec 2021 16:12:26 +0000
In-Reply-To: <20211215161232.1480836-1-qperret@google.com>
Message-Id: <20211215161232.1480836-10-qperret@google.com>
Mime-Version: 1.0
References: <20211215161232.1480836-1-qperret@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 09/14] KVM: arm64: Introduce wrappers for host and hyp spin
 lock accessors
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     qperret@google.com, qwandor@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

In preparation for adding additional locked sections for manipulating
page-tables at EL2, introduce some simple wrappers around the host and
hypervisor locks so that it's a bit easier to read and bit more difficult
to take the wrong lock (or even take them in the wrong order).

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 32 ++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 92262e89672d..907d3cbf1809 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -28,6 +28,26 @@ static struct hyp_pool host_s2_pool;
 
 const u8 pkvm_hyp_id = 1;
 
+static void host_lock_component(void)
+{
+	hyp_spin_lock(&host_kvm.lock);
+}
+
+static void host_unlock_component(void)
+{
+	hyp_spin_unlock(&host_kvm.lock);
+}
+
+static void hyp_lock_component(void)
+{
+	hyp_spin_lock(&pkvm_pgd_lock);
+}
+
+static void hyp_unlock_component(void)
+{
+	hyp_spin_unlock(&pkvm_pgd_lock);
+}
+
 static void *host_s2_zalloc_pages_exact(size_t size)
 {
 	void *addr = hyp_alloc_pages(&host_s2_pool, get_order(size));
@@ -339,14 +359,14 @@ static int host_stage2_idmap(u64 addr)
 
 	prot = is_memory ? PKVM_HOST_MEM_PROT : PKVM_HOST_MMIO_PROT;
 
-	hyp_spin_lock(&host_kvm.lock);
+	host_lock_component();
 	ret = host_stage2_adjust_range(addr, &range);
 	if (ret)
 		goto unlock;
 
 	ret = host_stage2_idmap_locked(range.start, range.end - range.start, prot);
 unlock:
-	hyp_spin_unlock(&host_kvm.lock);
+	host_unlock_component();
 
 	return ret;
 }
@@ -370,8 +390,8 @@ int __pkvm_host_share_hyp(u64 pfn)
 	if (!addr_is_memory(addr))
 		return -EINVAL;
 
-	hyp_spin_lock(&host_kvm.lock);
-	hyp_spin_lock(&pkvm_pgd_lock);
+	host_lock_component();
+	hyp_lock_component();
 
 	ret = kvm_pgtable_get_leaf(&host_kvm.pgt, addr, &pte, NULL);
 	if (ret)
@@ -433,8 +453,8 @@ int __pkvm_host_share_hyp(u64 pfn)
 	BUG_ON(ret);
 
 unlock:
-	hyp_spin_unlock(&pkvm_pgd_lock);
-	hyp_spin_unlock(&host_kvm.lock);
+	hyp_unlock_component();
+	host_unlock_component();
 
 	return ret;
 }
-- 
2.34.1.173.g76aa8bc2d0-goog

