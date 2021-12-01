Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CB446539F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351722AbhLARJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 12:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351721AbhLARIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:08:31 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE82C0613E0
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 09:04:55 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id y4-20020adfd084000000b00186b16950f3so4472795wrh.14
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 09:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=T0JsrzG68YfPigMGVPlPrd/xCSmb5pbfUw0MQLeIq18=;
        b=FxwXE/GBzpALB+WDGk4xxS/qk7AEHYIAQOFqBsax91XFh54Oe4XTkZKSH5mjhhiGwi
         xojuzI07IO1NX0heyd2/dn4DPfxq0MBzpigfJwCCo9EWFe/7k5cjD6K87Hr1bnzMr75n
         LPvlTZ5UVckhBdhWY1tA5gp6BooYMA6vk6UqpvQCQKxmxXijzAAUxOLQHmq3W/UT5K76
         LLOzTHeRcv7HG31p0iL095jbrbR4CWaw0qd/Lm3WvIAX+mRlmQSBbLi4bERT3mmAXGm9
         giXC8vRUXTgmyMn6BJyiPcxZQDAjsrAMk92/xCu0oed2MKOEUxmlhKYTnIEcRcGVQi/j
         d5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=T0JsrzG68YfPigMGVPlPrd/xCSmb5pbfUw0MQLeIq18=;
        b=ADCxxkQkdPrr5/Z0yh5hSeB+/XB9lFTLTcByqNHArkmTnblZImJDzYpuEZhpME3Q5d
         1IaWRmPPT8njYozIZMBC4oIwWbhgmmiN7faTz9AJeKTjE1OrJMGccm1y9PKy0BUuWhKF
         v8ygfStHtlaTzbBcmIVcG9uMq5qSpgCpm3iadfugY+Z9+GI0IfBbc9TnrcrCa4rp23gG
         oIWIBIL4K4VOsupOzOcaKiJKQDZ/hyyjLd9EJt9OfsJcjHsi9RPa1GkQrKTjmt5kWAiz
         4MY1KTL+TXPl4ujHTkg8tbK1kviBX79UfXq/pM0Z71Pxn03QslDg0eSjI0N1AnaUPniW
         KvjQ==
X-Gm-Message-State: AOAM532TaN0vhFACQ+W5lZuIN2piH4yisRflR93HcaEBno1WJGFvyQ28
        2BnRJV+wFETVBcl9Oc7LWvq440irQBTj
X-Google-Smtp-Source: ABdhPJzxm+jj5EWvAYdKtX2YJJnnLDNfrgC/7WKMyffToJZDquq3DYO27TbqsoOCOfqh0AkV6YTZ7zDrqd13
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:1cab:1a20:2ef1:ddde])
 (user=qperret job=sendgmr) by 2002:adf:fb09:: with SMTP id
 c9mr8021924wrr.223.1638378293678; Wed, 01 Dec 2021 09:04:53 -0800 (PST)
Date:   Wed,  1 Dec 2021 17:04:04 +0000
In-Reply-To: <20211201170411.1561936-1-qperret@google.com>
Message-Id: <20211201170411.1561936-11-qperret@google.com>
Mime-Version: 1.0
References: <20211201170411.1561936-1-qperret@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 10/15] KVM: arm64: Introduce wrappers for host and hyp spin
 lock accessors
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
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
index c1a90dd022b8..757dfefe3aeb 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -27,6 +27,26 @@ static struct hyp_pool host_s2_pool;
 
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
@@ -338,14 +358,14 @@ static int host_stage2_idmap(u64 addr)
 
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
@@ -369,8 +389,8 @@ int __pkvm_host_share_hyp(u64 pfn)
 	if (!addr_is_memory(addr))
 		return -EINVAL;
 
-	hyp_spin_lock(&host_kvm.lock);
-	hyp_spin_lock(&pkvm_pgd_lock);
+	host_lock_component();
+	hyp_lock_component();
 
 	ret = kvm_pgtable_get_leaf(&host_kvm.pgt, addr, &pte, NULL);
 	if (ret)
@@ -432,8 +452,8 @@ int __pkvm_host_share_hyp(u64 pfn)
 	BUG_ON(ret);
 
 unlock:
-	hyp_spin_unlock(&pkvm_pgd_lock);
-	hyp_spin_unlock(&host_kvm.lock);
+	hyp_unlock_component();
+	host_unlock_component();
 
 	return ret;
 }
-- 
2.34.0.rc2.393.gf8c9666880-goog

