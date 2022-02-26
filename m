Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7563A4C529B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 01:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240813AbiBZASK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 19:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240459AbiBZARC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 19:17:02 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835AC2261DE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 16:16:25 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id t134-20020a62788c000000b004e1367caccaso3948321pfc.14
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 16:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=JDThRSqN0byFLKsQYI89Co7AKmuBCHnME5v6WomODDw=;
        b=KnNEuHSDYY9Qpv8Sc7pMTFoKsQ1o1irShtKNr/STHSxYwJLaYyi5K1uzyhNvsRIB+t
         GmneOFlCNqt6+D5k8U9urB6oYaTV70HwxQqPey79vYIYg2VXQBvVhwTPKie/2bAcGEen
         yw0Omtgx2d7PvTH+1z372LtMBDGvi4yvNRQ3516OqK89vTJfmn98v81FAVz13FI/gcb0
         FMOYaSUSX8sDJ4F/5NY/WaHzV00pF8Aw3qeWDHuBihAGUcaxx+SaNk6vPwupm8BgvMUt
         YT9pjc7hdVJFH6fBi0ci5quzkscOsEQIKLLvKn6WqvEuBmzO92jF8ncfBNTNQJv6r1rA
         c1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=JDThRSqN0byFLKsQYI89Co7AKmuBCHnME5v6WomODDw=;
        b=1MuTGzLSHzllG89cTQ/JijHzkbluiFX9kc7wjCh4HXD0P4gjogp04bPLR7resKjXqA
         579kwLibJG0NILt+kwlzNdVfNlwkidiepaaILsp98m4/uuCaWDv5wEvIpfExy5Lh3Vf7
         gXVvK5OwzDJyXUgeSjcSNdzLCjPtUCs0TZxqAQ243APz+3+vocl93y3Y9aApfOtQPd5k
         l3fF5sXJh/Pa2smszh6aIGUCnYnmIksGtp74OlewXOguoTPgb1PdCxneK/39v1qXw2P+
         CO5NblzfPioykmM0uAa2a2LODGJWe3jJW4hb3yPyuv4+e5gSqsFxynRK6nMAsAU6PygL
         Mnjg==
X-Gm-Message-State: AOAM5307PA1SKaZNR3GEVgb7bli9QfjsO0KguGNejMnHcCcUAOr1s6KL
        q35D8t3MXAvTTmVgH1mLYz2MgjrvyEo=
X-Google-Smtp-Source: ABdhPJyDXjmJG5ubpBBt2IByek7X49XHlU8cpZNg0E33OFPw7Jkh1SIZ8sqLHR0uUVnkCt9UJDZ4mM68s6g=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:b906:b0:14f:76a0:ad48 with SMTP id
 bf6-20020a170902b90600b0014f76a0ad48mr9902830plb.79.1645834584804; Fri, 25
 Feb 2022 16:16:24 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat, 26 Feb 2022 00:15:32 +0000
In-Reply-To: <20220226001546.360188-1-seanjc@google.com>
Message-Id: <20220226001546.360188-15-seanjc@google.com>
Mime-Version: 1.0
References: <20220226001546.360188-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v3 14/28] KVM: x86/mmu: Skip remote TLB flush when zapping all
 of TDP MMU
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't flush the TLBs when zapping all TDP MMU pages, as the only time KVM
uses the slow version of "zap everything" is when the VM is being
destroyed or the owning mm has exited.  In either case, KVM_RUN is
unreachable for the VM, i.e. the guest TLB entries cannot be consumed.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index c231b60e1726..87706e9cc6f3 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -874,14 +874,15 @@ bool __kvm_tdp_mmu_zap_gfn_range(struct kvm *kvm, int as_id, gfn_t start,
 
 void kvm_tdp_mmu_zap_all(struct kvm *kvm)
 {
-	bool flush = false;
 	int i;
 
+	/*
+	 * A TLB flush is unnecessary, KVM zaps everything if and only the VM
+	 * is being destroyed or the userspace VMM has exited.  In both cases,
+	 * KVM_RUN is unreachable, i.e. no vCPUs will ever service the request.
+	 */
 	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++)
-		flush = kvm_tdp_mmu_zap_gfn_range(kvm, i, 0, -1ull, flush);
-
-	if (flush)
-		kvm_flush_remote_tlbs(kvm);
+		(void)kvm_tdp_mmu_zap_gfn_range(kvm, i, 0, -1ull, false);
 }
 
 /*
-- 
2.35.1.574.g5d30c73bfb-goog

