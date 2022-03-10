Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C824C4D4FAB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 17:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243932AbiCJQsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 11:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243832AbiCJQr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:47:26 -0500
Received: from mail-oi1-x249.google.com (mail-oi1-x249.google.com [IPv6:2607:f8b0:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0381959DD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 08:46:09 -0800 (PST)
Received: by mail-oi1-x249.google.com with SMTP id w19-20020a0568080d5300b002d54499cc1eso3960457oik.19
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 08:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2SsVLXVD0edRV3f8AavPnanFB3lHcUM5wj5R9N73Z6I=;
        b=X9PzltWeS/MgIUKPhKte0phhcvDP5rVVdeax0erbewyCCfBdsOHibEi8fYzoBxOm3n
         lquV3ZPS/bVpo7VWqKOcfwc13uwlPzt91z3H1Kj49soWFdKlSNwsoMSvnYuOz2apZ7Gg
         EC2Ic2idfwqNUZ54mzCbgskTaxB3j+bRdfIVKl2A7MUBqExVDssZmRBk8ES7vUP0QFbY
         5/jzj6vTwQdu8djATC+kxeNOVmHbjZHAA2KqsOOaPh8sABbO2NZDS7dRsTjf7wfNuHhX
         t2C8/xukDUdkokU00lehIxNdhwNgxpp8GDxwFe/LdvzyIdEbRN5uU8V87SHo8zWzaqYR
         8Gog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2SsVLXVD0edRV3f8AavPnanFB3lHcUM5wj5R9N73Z6I=;
        b=QaZbyv235aY409zco1SwBNZrL3LHrqi+VIO6hWoNwr8asjDDSusxDq95u1MDlR3xXQ
         mlcs6LkleZhFySp32wrA2BKzy0IGd39au6pzCVNiWme4mqu3LfEqJDomdluGNNfUYpj7
         sgjlXRQoClmfsCFg+r53/992ACMXmypx8AzQBjM1yc1unDf66fFs7VapNzGMxCCFaXkB
         msXhAcGNCT4MfnZFeERWIMScg8GJiAhGlLcMtDtFNHFPTV7r3FOuX/q0MFAwNXN68/Fs
         S0yjp/lr7ZsZtCaSMJsGDb8GkpOGy1CjFltZjXRFOrUO9tG9rKkBWQrZgfrkpo1GDFHg
         bd0g==
X-Gm-Message-State: AOAM530nPo9MG7tx5qb5nyUu2KN3JqFp1y7oiHqLthoI8UqziUniVh4f
        sY/ju4G4paxGrB98mRePjp98xFIbXjrW+QfaGnaytwcAJiFBzDosZbnyyEYW6P+mkRINfPB8RpJ
        NzgOH0N5aL0U1X97YcYdrvzN/ToZYjgkDlPl0Jq8y1VSb4udZwJu7W4tyVKRW7fvGoS31GWSx
X-Google-Smtp-Source: ABdhPJyQ3c/S0YI4mDS1HFjedf5Jv4X8SXDIvM1RCZxBxsVwayoIztg/KISrQ29u14LwkKCgTMjC0AJOgmN3
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:2d58:733f:1853:8e86])
 (user=bgardon job=sendgmr) by 2002:a05:6870:4149:b0:da:5e34:9448 with SMTP id
 r9-20020a056870414900b000da5e349448mr9042633oad.112.1646930768289; Thu, 10
 Mar 2022 08:46:08 -0800 (PST)
Date:   Thu, 10 Mar 2022 08:45:27 -0800
In-Reply-To: <20220310164532.1821490-1-bgardon@google.com>
Message-Id: <20220310164532.1821490-9-bgardon@google.com>
Mime-Version: 1.0
References: <20220310164532.1821490-1-bgardon@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH 08/13] KVM: x86/MMU: Factor out updating NX hugepages state
 for a VM
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out the code to update the NX hugepages state for an individual
VM. This will be expanded in future commits to allow per-VM control of
Nx hugepages.

No functional change intended.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 3b8da8b0745e..1b59b56642f1 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6195,6 +6195,15 @@ static void __set_nx_huge_pages(bool val)
 	nx_huge_pages = itlb_multihit_kvm_mitigation = val;
 }
 
+static int kvm_update_nx_huge_pages(struct kvm *kvm)
+{
+	mutex_lock(&kvm->slots_lock);
+	kvm_mmu_zap_all_fast(kvm);
+	mutex_unlock(&kvm->slots_lock);
+
+	wake_up_process(kvm->arch.nx_lpage_recovery_thread);
+}
+
 static int set_nx_huge_pages(const char *val, const struct kernel_param *kp)
 {
 	bool old_val = nx_huge_pages;
@@ -6217,13 +6226,8 @@ static int set_nx_huge_pages(const char *val, const struct kernel_param *kp)
 
 		mutex_lock(&kvm_lock);
 
-		list_for_each_entry(kvm, &vm_list, vm_list) {
-			mutex_lock(&kvm->slots_lock);
-			kvm_mmu_zap_all_fast(kvm);
-			mutex_unlock(&kvm->slots_lock);
-
-			wake_up_process(kvm->arch.nx_lpage_recovery_thread);
-		}
+		list_for_each_entry(kvm, &vm_list, vm_list)
+			kvm_set_nx_huge_pages(kvm);
 		mutex_unlock(&kvm_lock);
 	}
 
-- 
2.35.1.616.g0bdcbb4464-goog

