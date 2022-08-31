Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7CF5A72D5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 02:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbiHaAiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 20:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiHaAhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 20:37:14 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44429AB1BF
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:36:03 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id 14-20020a056a00072e00b0053689e4d0e5so5206526pfm.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc;
        bh=jKorNpXhvwAGsXROivEBSj6hwWRnB+Rxe5sOrtAqphg=;
        b=tIU13tu3TrRZIwVjv3NBqNY45MhfLObBL6gThmPiOhUD6+etBUdAZjTHH2Bd9lYATB
         mm3B0SIcYf9WsoH4X+DNkzgG0ymiFjKf1dhwKuhKL7+DbEf1731yMvENCFd8Y2rOCqLX
         0NfwwTsjoiy6K40RaNI/f3p/JN1vVV9LgEN7ez756T3aQvTU/ln2o4jBeW8T/dteao5w
         lELNQ1P6djW8X4RFC1e/w1a+VZ6BI1RA6yX2YixQqGUyYIpXwRgH9G27UQNl2EFMPGRB
         MQ4noN2nDGKNGasEYXlxnYPZh7xlR/0dImt5IH7XdJWUg4VEgZMYS9sXuO5nMQYQIzan
         nD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc;
        bh=jKorNpXhvwAGsXROivEBSj6hwWRnB+Rxe5sOrtAqphg=;
        b=HOEwaigQQCMFKM8CiEAEbEEKo/ckaq5FcJpbDsmIhf0J5Vdyz+/dv0dc0XMxCSURdz
         AHEh1nuvLfaw0H5G+fPFtdEQCAGNQ63KNwM9jq4/GDH8OaupKjccnXR3okdWGoBbhtwR
         Out1ogl4vYNxb8KMs9h8ovlXlb/qYvQNyIAJ/8q4BChnlMG/4ZvJ6WpOf4bigJKW1OfR
         pJerB8w07NRzWygt4QEhepGAYwxtbZRqY1lflUbgZFj5BKzNgAAuriJ7nZwpMvavqz45
         9fOChGgYYKmhLvxeC+j8TuD9dgD7WxgGBOuhjpvoQirfMkzBBUK6viWo7eKc+RM4CIHM
         zUVQ==
X-Gm-Message-State: ACgBeo3CUI6TMdw//8oARwilKtEEFUu8blw0O/7w9zqJpJQQ+tQRWt/4
        Hm6dFAN/fjXRbouVSxi1neWiJNCmdV4=
X-Google-Smtp-Source: AA6agR7yN+Sp/Y+nZ4AuoglDHrI+LXd3f1PmIguhTRo3PXqVoSa11JZpxTjMBfll0T0+/fbcDbejWHARNus=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:4b0c:b0:1f4:ffac:699a with SMTP id
 lx12-20020a17090b4b0c00b001f4ffac699amr600872pjb.145.1661906131231; Tue, 30
 Aug 2022 17:35:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 31 Aug 2022 00:35:00 +0000
In-Reply-To: <20220831003506.4117148-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220831003506.4117148-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220831003506.4117148-14-seanjc@google.com>
Subject: [PATCH 13/19] KVM: x86: Disable APIC logical map if vCPUs are aliased
 in logical mode
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable the optimized APIC logical map if multiple vCPUs are aliased to
the same logical ID.  Architecturally, all CPUs whose logical ID matches
the MDA are supposed to receive the interrupt; overwriting existing map
entries can result in missed IPIs.

Fixes: 1e08ec4a130e ("KVM: optimize apic interrupt delivery")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 82278acae95b..d537b51295d6 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -303,12 +303,13 @@ void kvm_recalculate_apic_map(struct kvm *kvm)
 		if (!mask)
 			continue;
 
-		if (!is_power_of_2(mask)) {
+		ldr = ffs(mask) - 1;
+		if (!is_power_of_2(mask) || cluster[ldr]) {
 			new->mode = KVM_APIC_MODE_XAPIC_FLAT |
 				    KVM_APIC_MODE_XAPIC_CLUSTER;
 			continue;
 		}
-		cluster[ffs(mask) - 1] = apic;
+		cluster[ldr] = apic;
 	}
 out:
 	old = rcu_dereference_protected(kvm->arch.apic_map,
-- 
2.37.2.672.g94769d06f0-goog

