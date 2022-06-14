Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC45254BB4C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 22:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357520AbiFNUJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 16:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357794AbiFNUIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:08:39 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B234EF6E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:08:09 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id x1-20020a170902ec8100b0016634ff72a4so5340468plg.15
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=xo1qDgQfLuXoeUJsd2fB/DhbQ6NUNvOIxbn7J+1FRkI=;
        b=YAFZFhP4ujJ+4Z4z2Wzs5pJblK6AlYCVkpLyv4/Ji/q6/TLZKupD0qmSlBWboQLswM
         xQMp4YENRSgn7lLS90Q0x7/2FmGOgk96VUCA+KEEp6GMAk6ag6chPKsaDncgt4j3bva+
         KTyvAQmMI3fbEpZNolhUH2iTNhxvz4UGBLcOkNCpIdVihOPeWF6XkoA27rSKadSa8aJ2
         XYvKNAxIi2uanQyfP3jTNIWIzTfW+fJlm7mPAOITbk9DelYy0K8sZUeMKvEX5ghVByF5
         OnStN04CJjgjqX7mGbvQ+k5HX5dO5f5eMF9qrbd2ppu5n5UqEqYdxjGrk9bF3MFaiIFc
         TI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=xo1qDgQfLuXoeUJsd2fB/DhbQ6NUNvOIxbn7J+1FRkI=;
        b=TLaV7HLS7SJT1syo6BI+AwfqPaWohSi2Ik7UNaS98W4VdB7GgvSRLv1YbeV/VH04aI
         soNFocaQVmzjBZwI5qFRD6HE5elOukrsH5JQMULhcV2ldOs1u2PTYk/HIxDUJSzwHQ0k
         nU1hhh3F37/K3HAWFEM7ctkebz3Kn0NrPRp8x+44g9VARZLWM5dy4VeVz/uXODduOwhJ
         CHuSEG5eVGRfcKT91Egh3IreOShAdoZ61D7WgOeCXQ42nxpA90KvTtIaI0L8wprGoUL2
         C72wiR46EibJH6ikDtY8/8bbxFlvkoZULe/BMTc2pa8Ou06AIJ5d+O0MvHXnG88C7g8w
         DY0g==
X-Gm-Message-State: AJIora+NzfrpuhuOEaeDmHFYlbpc8VYJQNpFsDkHqjXKlL1N6ZuIBrA5
        hPkG5Bxh16rhFhXU2L0jG+43OX2frh8=
X-Google-Smtp-Source: AGRyM1tO2CBJtsKmDlSqCBIPkUlrozcg78gkzMsXmJdD2PKSXmOVgsKKc0huRWug6941nM+zyJ+YTU3SdIk=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:903:32c4:b0:163:e765:5071 with SMTP id
 i4-20020a17090332c400b00163e7655071mr5876009plr.153.1655237280764; Tue, 14
 Jun 2022 13:08:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 14 Jun 2022 20:06:52 +0000
In-Reply-To: <20220614200707.3315957-1-seanjc@google.com>
Message-Id: <20220614200707.3315957-28-seanjc@google.com>
Mime-Version: 1.0
References: <20220614200707.3315957-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v2 27/42] KVM: selftests: Use vcpu_get_cpuid_entry() in CPUID test
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>
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

Use vcpu_get_cpuid_entry() instead of an open coded equivalent in the
CPUID test.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86_64/cpuid_test.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/cpuid_test.c b/tools/testing/selftests/kvm/x86_64/cpuid_test.c
index 8723d73dcdbd..694583803468 100644
--- a/tools/testing/selftests/kvm/x86_64/cpuid_test.c
+++ b/tools/testing/selftests/kvm/x86_64/cpuid_test.c
@@ -147,7 +147,6 @@ struct kvm_cpuid2 *vcpu_alloc_cpuid(struct kvm_vm *vm, vm_vaddr_t *p_gva, struct
 
 static void set_cpuid_after_run(struct kvm_vcpu *vcpu)
 {
-	struct kvm_cpuid2 *cpuid = vcpu->cpuid;
 	struct kvm_cpuid_entry2 *ent;
 	int rc;
 	u32 eax, ebx, x;
@@ -157,7 +156,7 @@ static void set_cpuid_after_run(struct kvm_vcpu *vcpu)
 	TEST_ASSERT(!rc, "Setting unmodified CPUID after KVM_RUN failed: %d", rc);
 
 	/* Changing CPU features is forbidden */
-	ent = get_cpuid_entry(cpuid, 0x7, 0);
+	ent = vcpu_get_cpuid_entry(vcpu, 0x7);
 	ebx = ent->ebx;
 	ent->ebx--;
 	rc = __vcpu_set_cpuid(vcpu);
@@ -165,7 +164,7 @@ static void set_cpuid_after_run(struct kvm_vcpu *vcpu)
 	ent->ebx = ebx;
 
 	/* Changing MAXPHYADDR is forbidden */
-	ent = get_cpuid_entry(cpuid, 0x80000008, 0);
+	ent = vcpu_get_cpuid_entry(vcpu, 0x80000008);
 	eax = ent->eax;
 	x = eax & 0xff;
 	ent->eax = (eax & ~0xffu) | (x - 1);
-- 
2.36.1.476.g0c4daa206d-goog

