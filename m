Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3415A72AF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 02:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbiHaAhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 20:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbiHaAgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 20:36:48 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88640A8950
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:35:38 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id v202-20020a6361d3000000b004300a4a30dbso829565pgb.20
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc;
        bh=0HXY0EEA1Ha5zVQSoYds7krJoiBKDZH41KEpFRGKQBk=;
        b=tJJWk6gHdA3Q/3/ppn1buDVs74SZMkiSxm9h9DAGV4S3Ojwz0SYC89VGuOsrtzS4Oc
         TAkzd0myieatN1aT5PFhwdSIN8hjqBrxtcL8Ct8Kk66vbmp3qi4Kk9q6AU8UlaMktG6m
         vWal4FN12VXiLg+Kl8GGR8MMnh5KaZZFamxs+uYum7eQNlir8Y6rZxQDor6AQHSEhCny
         3v5VvOJ1apVC4AA5eC8ZviJ9p0WzC/AlTdiUlTVS0a05I69UUew5sNcWBt/Hueu3x+1K
         yNpnDcKTd3VlEbtLisO5TpzfssAdwvnwqRGOSLWnJ6y6n6c9ZdPsUWa+ZwhbslYgEPnA
         GTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc;
        bh=0HXY0EEA1Ha5zVQSoYds7krJoiBKDZH41KEpFRGKQBk=;
        b=RyI0s8ekjVBlaBL4n3pVazO/uwes/RVOcLzmo8pA2Vekx7oFAQR8qEljUI9TBZygga
         xApwzVuerrRgDDTNLvUnYul+pnPdBJKUQIa727ngoS4nui1HWysfenDyridmQnxAewox
         hnAmcmuHldgUQ5WXRxy/KM37sVNa1sSpto8FE4/lB9+6mdw1+gyDiXXKzlJ27fXap32g
         +nqQNvH4JL0xxmIO+dI2VOS/LIlscR/EvAgfBx0/qvG9WjD29P0E9he/5KPdr7p7y+7U
         c8PbP4s3QMxpqS0zA96ZwmLrZ2dFu9NcvOJBiz2eVIryeIFamota8NxUSMXHr0YUYsOW
         IYBw==
X-Gm-Message-State: ACgBeo2fj5NUYhSOlWe5ncPMOUkTK0t9B98e1ijkB/uWav3wgsNphq23
        ZEaPGHa7BBsRGP2iwaCXTemyFcG6H5E=
X-Google-Smtp-Source: AA6agR5nPKcjBevp91WFt9YRwA6+l0+inVdDs1vL1ZnLIyKe5/LKdV7S/tmoziioGqnNYaClWetxEoFjK4g=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:445b:0:b0:42c:7b67:287e with SMTP id
 t27-20020a63445b000000b0042c7b67287emr6195583pgk.166.1661906118100; Tue, 30
 Aug 2022 17:35:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 31 Aug 2022 00:34:52 +0000
In-Reply-To: <20220831003506.4117148-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220831003506.4117148-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220831003506.4117148-6-seanjc@google.com>
Subject: [PATCH 05/19] KVM: SVM: Compute dest based on sender's x2APIC status
 for AVIC kick
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Li RongQing <lirongqing@baidu.com>
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

Compute the destination from ICRH using the sender's x2APIC status, not
each (potential) target's x2APIC status.

Fixes: c514d3a348ac ("KVM: SVM: Update avic_kick_target_vcpus to support 32-bit APIC ID")
Cc: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index b59f8ee2671f..3ace0f2f52f0 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -441,6 +441,7 @@ static int avic_kick_target_vcpus_fast(struct kvm *kvm, struct kvm_lapic *source
 static void avic_kick_target_vcpus(struct kvm *kvm, struct kvm_lapic *source,
 				   u32 icrl, u32 icrh, u32 index)
 {
+	u32 dest = apic_x2apic_mode(source) ? icrh : GET_XAPIC_DEST_FIELD(icrh);
 	unsigned long i;
 	struct kvm_vcpu *vcpu;
 
@@ -456,13 +457,6 @@ static void avic_kick_target_vcpus(struct kvm *kvm, struct kvm_lapic *source,
 	 * since entered the guest will have processed pending IRQs at VMRUN.
 	 */
 	kvm_for_each_vcpu(i, vcpu, kvm) {
-		u32 dest;
-
-		if (apic_x2apic_mode(vcpu->arch.apic))
-			dest = icrh;
-		else
-			dest = GET_XAPIC_DEST_FIELD(icrh);
-
 		if (kvm_apic_match_dest(vcpu, source, icrl & APIC_SHORT_MASK,
 					dest, icrl & APIC_DEST_MASK)) {
 			vcpu->arch.apic->irr_pending = true;
-- 
2.37.2.672.g94769d06f0-goog

