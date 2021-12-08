Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B87D46CA71
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 02:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243309AbhLHB6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 20:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243324AbhLHB62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 20:58:28 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14914C061D60
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 17:54:56 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id b8-20020a17090a10c800b001a61dff6c9dso685622pje.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 17:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=0rf52m0OFsJ6vdpTPwC+YH53TFkMwIcyep6ybPqU2JE=;
        b=ALX+F6xb+1ftz8ZFqlXHYKMF5o6uoCIfAV9YWKQ6dHwcp3tfhgBpTtXHqLEo/dtnlO
         M8Va2r/PG5RN6w5P/yocjEnBZU08zfh5dvhN+FbGIAWaN+qWccNVYOqlVKRk1pBLeQEo
         qZnXEBWMMHGZ7RpCMpn9tE+eXwU6tOu/Fehr/2Ua54V+tr5S5OdFVC96vcomF0dGVodt
         vhVF/58K3GVasiXXOQZLDcQ6Yca0uw7ChaThbBk0o6c5X3I2pIt2k/bS+DQs3hU6t3+e
         gg85TLtmU20/H4+8Z11G23Rl3zHTgTuUj4nfIfjvTI245cspZEU1PXyFCz5NwmvHezLi
         c80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=0rf52m0OFsJ6vdpTPwC+YH53TFkMwIcyep6ybPqU2JE=;
        b=XRAG5sz5HTEMopJ4dsOjcghssv4hSezRZDWHWxJT9Dn4ne4ogopTBtTG3SBn0gtEtz
         seMSjxTOtqYJVY0ro8PfRQpoKPI4hse8+b+J38KMn6O9q39m6CSwbuOE2Yj4WvJd1Jhx
         SQ6owjnLidmNoOSULiPuEqhu7u1y5j5SdbTsa8CHwWKVXMZE0j6K8yWAiM1QhzgWG5EG
         Kvi55o2+hK3iJGGLwoOJXIjXbGthqz3HSVIREWfAyw5LLTS7lhpSWWQ67w7A61tjvSn0
         rMyGMjuXLisTz5t5WYIeqFUUMqhJ5ZDmzOr1hesGxJfU04mTCLiv4AotBNSoEg8zgnHC
         QPnA==
X-Gm-Message-State: AOAM5327up8MHDa2a7XFzsynSgYZPM25u03CjzgMFIXxpnkY0QkVs1WI
        hEJffI3VB/nNDrjc5yxgnN8hb3LkVPc=
X-Google-Smtp-Source: ABdhPJxMvVDgDQDgT5n2opsiPcTnngzCmW7OhEj/nnOqNcYBinuBirWqSvdpU36Uf7z5Mv1VYTYwKMs+lew=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:e74e:b0:142:fa5:49f1 with SMTP id
 p14-20020a170902e74e00b001420fa549f1mr55709592plf.84.1638928495591; Tue, 07
 Dec 2021 17:54:55 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  8 Dec 2021 01:52:15 +0000
In-Reply-To: <20211208015236.1616697-1-seanjc@google.com>
Message-Id: <20211208015236.1616697-6-seanjc@google.com>
Mime-Version: 1.0
References: <20211208015236.1616697-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 05/26] KVM: Drop unused kvm_vcpu.pre_pcpu field
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        kvm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove kvm_vcpu.pre_pcpu as it no longer has any users.  No functional
change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 include/linux/kvm_host.h | 1 -
 virt/kvm/kvm_main.c      | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index a745efe389ab..30cc1327065c 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -305,7 +305,6 @@ struct kvm_vcpu {
 	u64 requests;
 	unsigned long guest_debug;
 
-	int pre_pcpu;
 	struct list_head blocked_vcpu_list;
 
 	struct mutex mutex;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 863112783ed9..d3e86f246e1c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -427,7 +427,6 @@ static void kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
 #endif
 	kvm_async_pf_vcpu_init(vcpu);
 
-	vcpu->pre_pcpu = -1;
 	INIT_LIST_HEAD(&vcpu->blocked_vcpu_list);
 
 	kvm_vcpu_set_in_spin_loop(vcpu, false);
-- 
2.34.1.400.ga245620fadb-goog

