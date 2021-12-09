Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABB046E24C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 07:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbhLIGJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 01:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbhLIGJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 01:09:42 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D4BC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 22:06:10 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id a207-20020a621ad8000000b004aed6f7ec3fso3013343pfa.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 22:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=pPWXqVL2VmGtL+4wfJS4Lr1QCW5EOpCcuVv/bW8wHlA=;
        b=m445/XdfA4jroI3XDCtAyKS5RcJk3wwnVdhwXsQ243ogOY3c/PyQWynsCn+0RNOCgj
         meJXf7IP7nbg3lOB2Nba+ytkgp2C8qGV9AUhMCTKgTsfK7gseCSBvupR//ymsixlvIZ1
         vsGfLv0pKT5VLQ4m0g7imQGazSMcvx4ka6KA8taARhdZlZXJu774R2czYJgOvHjHs/vR
         /kA9el3lYEGONOqtRy2FuyUMD/ZVx/7qwwnaMoGtIuErlyLX4LUTxVAMa2om/KkntDRn
         vBdVr6pK4jeGKOWBt3lWtZ4sL1WgyTWQgyxOuypLI0QNVs32ahOiUNCpSA92pF8j/6rS
         YxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=pPWXqVL2VmGtL+4wfJS4Lr1QCW5EOpCcuVv/bW8wHlA=;
        b=ocFysm/GJhbHIIiLdxgbAX/ZGDuwv1/B8XIrCe6cLm/XnThdo4DZvGT76qFxrDasvE
         WuanN3QCB+XatKeuSFCFPh3m9D5wG3FhfOz+86384hrlrYSs26Rmd638jliv5dSc8Y0o
         4vjVISqDQOYbeZjH6+wwPgvmoUR3E6YRsanBvFh3BzjdcsUdti9YhMIwoqUmpy+Ep9NX
         ybKspUBdA7e8FIivoAnbfzlj1+tULP4SzY0XAx0Cm4jiffruq7a+dZFXF/EktTXch1KS
         srstuqGDmnLD6SsdpVa+jhrENAF3hx1HdiSZN+RtKfvd/j932aut/KC04CR9m0r9nlx2
         IU1Q==
X-Gm-Message-State: AOAM533JhapSdTGfKfEXTe7oFtbXE325fZYQt2C0zt8nIKV9jXsCY1s2
        a/yDi4QvB8A7P84leqFGIRGuH4r3XTk=
X-Google-Smtp-Source: ABdhPJw5bpr56J/RPTS/V7V8gkVuRzz14Sg1Q/BeN7En+5GJvUuj9YAH473VwOhaqUXE84d1Zl1zpbv79GU=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:84d:b0:4ae:da2:9ce7 with SMTP id
 q13-20020a056a00084d00b004ae0da29ce7mr9809877pfk.16.1639029969489; Wed, 08
 Dec 2021 22:06:09 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  9 Dec 2021 06:05:52 +0000
In-Reply-To: <20211209060552.2956723-1-seanjc@google.com>
Message-Id: <20211209060552.2956723-8-seanjc@google.com>
Mime-Version: 1.0
References: <20211209060552.2956723-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH 7/7] KVM: WARN if is_unsync_root() is called on a root without
 a shadow page
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>,
        Ben Gardon <bgardon@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN and bail if is_unsync_root() is passed a root for which there is no
shadow page, i.e. is passed the physical address of one of the special
roots, which do not have an associated shadow page.  The current usage
squeaks by without bug reports because neither kvm_mmu_sync_roots() nor
kvm_mmu_sync_prev_roots() calls the helper with pae_root or pml4_root,
and 5-level AMD CPUs are not generally available, i.e. no one can coerce
KVM into calling is_unsync_root() on pml5_root.

Note, this doesn't fix the mess with 5-level nNPT, it just (hopefully)
prevents KVM from crashing.

Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b6115d8ea696..18ecaadcf616 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3666,6 +3666,14 @@ static bool is_unsync_root(hpa_t root)
 	 */
 	smp_rmb();
 	sp = to_shadow_page(root);
+
+	/*
+	 * PAE roots (somewhat arbitrarily) aren't backed by shadow pages, the
+	 * PDPTEs for a given PAE root need to be synchronized individually.
+	 */
+	if (WARN_ON_ONCE(!sp))
+		return false;
+
 	if (sp->unsync || sp->unsync_children)
 		return true;
 
-- 
2.34.1.400.ga245620fadb-goog

