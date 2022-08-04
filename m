Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC070589CA8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239808AbiHDN2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbiHDN2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:28:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94FFE167D0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 06:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659619719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8mI2K9LPqJgaRLMP248bErw8NzNZESg05xXXJKMcom4=;
        b=RddcYTyxUCc6hS/3fXgZ4g8hFpijdk8SE1sJuHX5xhvo4/lFxwNp9P3+IRWRSO9el0sLQO
        F5Wd7hr9VNnkUQEaArRkaLyS8AaSqYTeQXVJ1XTn5BpdnJMXSmfeIkvmKjf3wP+c0UE3jg
        TbjJVoWVbX6iWavyuUNcxYvrjWYtXnI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-211-un5XmVksOrGZzA0bpIU0ng-1; Thu, 04 Aug 2022 09:28:36 -0400
X-MC-Unique: un5XmVksOrGZzA0bpIU0ng-1
Received: by mail-wr1-f70.google.com with SMTP id t12-20020adfba4c000000b0021e7440666bso4863496wrg.22
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 06:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=8mI2K9LPqJgaRLMP248bErw8NzNZESg05xXXJKMcom4=;
        b=DDOlXfoqoOUPkwfxPP2zQYNW3dOSz6BSDbM7j++3WvF+pIg1P4iSYTwkqyTwMDbZbt
         +DAp9zU4t0+8YgvJINYP1xqUq0kjL+C5hGFJPxL3htZx9cnRQ3YiTXSSx/7gxZa7Zqaw
         0+A9P5maeT23qeDh3J0sx2A0H7ez04UKUnzwb8+PpPp5dK5nMUakpkD64tFfEFl9XttT
         DXhgpSPJAOfkSBnWtfXG9gZMxl8d3jtGR8W9joZ7zHQeBT6hRBoz0p2R1smUJf8T97LM
         kgn2ZGK6IkezWyRDpOaJVov1N8XOMgPCU0+797A0s+3uY/KzDnCOGAamOcspt7iw2NNV
         uFzg==
X-Gm-Message-State: ACgBeo0UKGYVMa5ENHKVMZUH4AQ6VynwQVLgG4VeFqrrQ607Jl5PGE80
        94WRgiq+TxZ83NY5TygyzRdYmmJ+C0I3kBQbWp+1sbpiKx4T1QsiGgKNgxBcCnDkTvVTSn4KTo2
        lk6NAUZ2OXzz+Fmpvb0iywrbljpYIFXJENQ3du+3YfdOgigb32TF89EUZRyUSHvxKcQSwoaTS7L
        ta
X-Received: by 2002:a5d:50c6:0:b0:220:7a2a:bbd1 with SMTP id f6-20020a5d50c6000000b002207a2abbd1mr1428200wrt.471.1659619714354;
        Thu, 04 Aug 2022 06:28:34 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4+8brnDHpYm4si+9l3eNr2bcRsITNVeDi/VDvPQkPJPDf5a2PIGRTwY4bQ1YtD2eHppADynw==
X-Received: by 2002:a5d:50c6:0:b0:220:7a2a:bbd1 with SMTP id f6-20020a5d50c6000000b002207a2abbd1mr1428182wrt.471.1659619714056;
        Thu, 04 Aug 2022 06:28:34 -0700 (PDT)
Received: from goa-sendmail ([93.56.169.144])
        by smtp.gmail.com with ESMTPSA id q3-20020a056000136300b0021b956da1dcsm1142942wrz.113.2022.08.04.06.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 06:28:33 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Dave Young <ruyang@redhat.com>, Xiaoying Yan <yiyan@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>, stable@vger.kernel.org
Subject: [PATCH] KVM: x86: revalidate steal time cache if MSR value changes
Date:   Thu,  4 Aug 2022 15:28:32 +0200
Message-Id: <20220804132832.420648-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7e2175ebd695 ("KVM: x86: Fix recording of guest steal time
/ preempted status", 2021-11-11) open coded the previous call to
kvm_map_gfn, but in doing so it dropped the comparison between the cached
guest physical address and the one in the MSR.  This cause an incorrect
cache hit if the guest modifies the steal time address while the memslots
remain the same.  This can happen with kexec, in which case the steal
time data is written at the address used by the old kernel instead of
the old one.

While at it, rename the variable from gfn to gpa since it is a plain
physical address and not a right-shifted one.

Reported-by: Dave Young <ruyang@redhat.com>
Reported-by: Xiaoying Yan  <yiyan@redhat.com>
Analyzed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: stable@vger.kernel.org
Fixes: 7e2175ebd695 ("KVM: x86: Fix recording of guest steal time / preempted status")
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/x86.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e5fa335a4ea7..36dcf18b04bf 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3380,6 +3380,7 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 	struct gfn_to_hva_cache *ghc = &vcpu->arch.st.cache;
 	struct kvm_steal_time __user *st;
 	struct kvm_memslots *slots;
+	gpa_t gpa = vcpu->arch.st.msr_val & KVM_STEAL_VALID_BITS;
 	u64 steal;
 	u32 version;
 
@@ -3397,13 +3398,12 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 	slots = kvm_memslots(vcpu->kvm);
 
 	if (unlikely(slots->generation != ghc->generation ||
+		     gpa != ghc->gpa ||
 		     kvm_is_error_hva(ghc->hva) || !ghc->memslot)) {
-		gfn_t gfn = vcpu->arch.st.msr_val & KVM_STEAL_VALID_BITS;
-
 		/* We rely on the fact that it fits in a single page. */
 		BUILD_BUG_ON((sizeof(*st) - 1) & KVM_STEAL_VALID_BITS);
 
-		if (kvm_gfn_to_hva_cache_init(vcpu->kvm, ghc, gfn, sizeof(*st)) ||
+		if (kvm_gfn_to_hva_cache_init(vcpu->kvm, ghc, gpa, sizeof(*st)) ||
 		    kvm_is_error_hva(ghc->hva) || !ghc->memslot)
 			return;
 	}
-- 
2.37.1

