Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D29D5846A2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 21:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiG1Ttj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 15:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiG1Tth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 15:49:37 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62651B7BE
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 12:49:35 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id h145so2169213iof.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 12:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=csp-edu.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=hNrqN7wUMWjrs6dVVTuGDTVJ+Qagz9kPXPbUwKiCccA=;
        b=4/hLevQ+OVFoShgowRXTnBTJZeVcb9IsOtoG7xEDtgjD+GemPnRjK7pGxGHonrEEDJ
         HrlumeJPKhTUfuAT5Qcc0Wd+vfRhfIB+e1LQrescrlZ/dTw+UPL+KSJjVuOmRz0/aMI+
         wwvZ6K8WUytEF7Pp3VRbGwqfEbPC5NpyGa92Rt0JNdvCgfhELtuBSH73CAXzwJ+mYr9K
         1LPOHDUHgu2Aawq2UPog7MdwmnwqZqo02CVxadVBYG0/88bK0mUto0BEmomb6QosYY97
         gdYbkp5To2brnIGN7ztWxQ8evN5ra+gRvH9+R+/3uNZF0D++B/S4RmFXngvshKHMuAdw
         lWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=hNrqN7wUMWjrs6dVVTuGDTVJ+Qagz9kPXPbUwKiCccA=;
        b=S4ZVI6gC3kyUKqbtONK25LW+lhrH4sbmzN3Cj1cq+gdAx8XtYnyvB5eoLnMhShfrWL
         WbUjmlMKSwEfEMAhlOlpiW0GVtwKE/kNR43Xl1rSVtxZRt8BaL0stbTvfgs7ZST/17SI
         TKw25fj2ryZfFulReCj8khnp/AdxyGVr73Gcao16GbHm9kUd3dX5GpDJrotIRxNzEAHx
         j75mpmmSDYNaJ7CD4wzCINeR/spjucwYqlALVpwDJQPlaLOGIS+wvAN+Ps/Qfyoor6WU
         Qh75ddrGW1yg6xK2F0rGvhwLqFuH7DfUgAbsIe4lO6XIbcoqkaNkGO2vT2EOwi4FMsM3
         DMzA==
X-Gm-Message-State: AJIora9mikQkUOVtiAzh7Or5wCMSaQEDgQEIYO5egh3lWKE3a2axAbrj
        FhTN4ohEV/iuXnbatK6+EfMrZQ==
X-Google-Smtp-Source: AGRyM1vYw2WcsBR2Cnaxt6yfwVR7SG0qg1zyCShe/bZ3GlR7JtB9v75m4gWtCzSuONqYwXq1j54WVg==
X-Received: by 2002:a05:6602:3805:b0:67b:d39a:3c8b with SMTP id bb5-20020a056602380500b0067bd39a3c8bmr65060iob.51.1659037775255;
        Thu, 28 Jul 2022 12:49:35 -0700 (PDT)
Received: from kernel-dev-1 (75-168-113-69.mpls.qwest.net. [75.168.113.69])
        by smtp.gmail.com with ESMTPSA id i1-20020a0566022c8100b0067b74df7960sm682102iow.32.2022.07.28.12.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 12:49:34 -0700 (PDT)
From:   Coleman Dietsch <dietschc@csp.edu>
To:     kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, Pavel Skripkin <paskripkin@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Coleman Dietsch <dietschc@csp.edu>,
        syzbot+e54f930ed78eb0f85281@syzkaller.appspotmail.com
Subject: [PATCH] KVM: x86/xen: Fix bug in kvm_xen_vcpu_set_attr()
Date:   Thu, 28 Jul 2022 14:47:37 -0500
Message-Id: <20220728194736.383727-1-dietschc@csp.edu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This crash appears to be happening when vcpu->arch.xen.timer is already set and kvm_xen_init_timer(vcpu) is called.

During testing with the syzbot reproducer code it seemed apparent that the else if statement in the KVM_XEN_VCPU_ATTR_TYPE_TIMER switch case was not being reached, which is where the kvm_xen_stop_timer(vcpu) call is located.

Link: https://syzkaller.appspot.com/bug?id=8234a9dfd3aafbf092cc5a7cd9842e3ebc45fc42
Reported-and-tested-by: syzbot+e54f930ed78eb0f85281@syzkaller.appspotmail.com
Signed-off-by: Coleman Dietsch <dietschc@csp.edu>
---
 arch/x86/kvm/xen.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 610beba35907..4b4b985813c5 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -707,6 +707,12 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 		break;
 
 	case KVM_XEN_VCPU_ATTR_TYPE_TIMER:
+		/* Stop current timer if it is enabled */
+		if (kvm_xen_timer_enabled(vcpu)) {
+			kvm_xen_stop_timer(vcpu);
+			vcpu->arch.xen.timer_virq = 0;
+		}
+
 		if (data->u.timer.port) {
 			if (data->u.timer.priority != KVM_IRQ_ROUTING_XEN_EVTCHN_PRIO_2LEVEL) {
 				r = -EINVAL;
@@ -720,9 +726,6 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 				kvm_xen_start_timer(vcpu, data->u.timer.expires_ns,
 						    data->u.timer.expires_ns -
 						    get_kvmclock_ns(vcpu->kvm));
-		} else if (kvm_xen_timer_enabled(vcpu)) {
-			kvm_xen_stop_timer(vcpu);
-			vcpu->arch.xen.timer_virq = 0;
 		}
 
 		r = 0;
-- 
2.34.1

