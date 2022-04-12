Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A544E4FE941
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 22:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbiDLUID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 16:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbiDLUHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 16:07:22 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0049CBF8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 12:59:11 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id l41-20020a05600c1d2900b0038ec007ac7fso1700387wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 12:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:cc;
        bh=syoYrG4G6wc/D9QpXxmJ5xqKPPyBOCzpGpn970RrPGk=;
        b=AzIAUSbC0HT1iPMFN81vdTHOeJ5CmdCGjCiwRGHENOURvCjSrPoZVBFIa00KT0UXk+
         Or3fgc9coJ7lNzQAc0ddVYnjGwFjDclwLFYllf98AUzuBWt16G57jAs/N8M0J7g9LPUu
         mWMeztpx/ZjRmxCCF2R3ibegnY9anVUyLrSu7m+rwcfbr/hSyS4CVx/LPGNjYUvrDkjh
         q6wpWRociYBSPlAKBwcqnhAPA1SqU57/6CZxe1mG1jX+IsybNjU21kfS6xE4al9aUgV1
         mBbGLI4OxFdiSGcFcC8DwVKCSALMD7SWm0N39L/VRN6IySmXhldp2j0kk/owvCDLgcL8
         mEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:cc;
        bh=syoYrG4G6wc/D9QpXxmJ5xqKPPyBOCzpGpn970RrPGk=;
        b=vSG1UwmmtyRnWVo+B122CBNP26IaIlPkg11cwXY6mllXAbMeAlzyvDBMz7lvPlMkPa
         LbU4OrIEMBZpZcbcT8/IcbWU0Ac/qDuV4q2q34cjXFGDMgONDAn3ERSJAeZblEzZZ9o8
         vKdTLvHj0Bx9fK+2+HNLHID84XACUEi939IiqMKuuu6ITjpy4GBGAea2A3QiGchXbYqk
         3d32z9cv6QrThYt0O87QAtre2omudi4qxYkAb/32HWgBJubO9WKMekVG5s/DMbUCvb7Y
         s3fwhpgSGLDLPjgzCVAxgXujQT0csqHL4Rj3fhhyYEYZGhO/2ERG9SVSvqRl88vk4paX
         B4DQ==
X-Gm-Message-State: AOAM533erMTviGM7UPHJDqcZIJQmcAOKGDvBMqOMky6gbXgbK3IPan8p
        mmJnps1FJ68dUUXn0jLY7GJEUj+XB+Hc
X-Google-Smtp-Source: ABdhPJz4RtEBFxR8dOWxNhwT5sJYg2f8+ScFUMpOLlbygiH0VMVqy9v9t961e6WlRx11zKc7fmqhPYqLSwZT
X-Received: from zhanwei.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2da8])
 (user=zhanwei job=sendgmr) by 2002:a7b:c186:0:b0:38e:c0de:36b6 with SMTP id
 y6-20020a7bc186000000b0038ec0de36b6mr5724019wmi.53.1649793545148; Tue, 12 Apr
 2022 12:59:05 -0700 (PDT)
Reply-To: Wei Zhang <zhanwei@google.com>
Date:   Tue, 12 Apr 2022 19:58:45 +0000
In-Reply-To: <20220412195846.3692374-1-zhanwei@google.com>
Message-Id: <20220412195846.3692374-2-zhanwei@google.com>
Mime-Version: 1.0
References: <20220412195846.3692374-1-zhanwei@google.com>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH 1/2] KVM: x86: allow guest to send its _stext for kvm profiling
From:   Wei Zhang <zhanwei@google.com>
Cc:     Wei Zhang <zhanwei@google.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Sangwhan Moon <sxm@google.com>, Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The profiling buffer is indexed by (pc - _stext) in do_profile_hits(),
which doesn't work for KVM profiling because the pc represents an address
in the guest kernel. readprofile is broken in this case, unless the guest
kernel happens to have the same _stext as the host kernel.

This patch adds a new hypercall so guests could send its _stext to the
host, which will then be used to adjust the calculation for KVM profiling.

Signed-off-by: Wei Zhang <zhanwei@google.com>
---
 arch/x86/kvm/x86.c            | 15 +++++++++++++++
 include/linux/kvm_host.h      |  4 ++++
 include/uapi/linux/kvm_para.h |  1 +
 virt/kvm/Kconfig              |  5 +++++
 4 files changed, 25 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 547ba00ef64f..abeacdd5d362 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9246,6 +9246,12 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
 		vcpu->arch.complete_userspace_io = complete_hypercall_exit;
 		return 0;
 	}
+#ifdef CONFIG_ACCURATE_KVM_PROFILING
+	case KVM_HC_GUEST_STEXT:
+		vcpu->kvm->guest_stext = a0;
+		ret = 0;
+		break;
+#endif
 	default:
 		ret = -KVM_ENOSYS;
 		break;
@@ -10261,6 +10267,15 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	 */
 	if (unlikely(prof_on == KVM_PROFILING)) {
 		unsigned long rip = kvm_rip_read(vcpu);
+#ifdef CONFIG_ACCURATE_KVM_PROFILING
+		/*
+		 * Profiling buffer is indexed by (rip - _stext), but it's
+		 * supposed to be indexed by (rip - guest_stext) instead.
+		 * Therefore apply an offest in advance to get correct results.
+		 */
+		if (vcpu->kvm->guest_stext)
+			rip += (unsigned long)_stext - vcpu->kvm->guest_stext;
+#endif
 		profile_hit(KVM_PROFILING, (void *)rip);
 	}
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 3f9b22c4983a..65caaa4d87c4 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -781,6 +781,10 @@ struct kvm {
 	struct notifier_block pm_notifier;
 #endif
 	char stats_id[KVM_STATS_NAME_SIZE];
+
+#ifdef CONFIG_ACCURATE_KVM_PROFILING
+	unsigned long guest_stext;
+#endif
 };
 
 #define kvm_err(fmt, ...) \
diff --git a/include/uapi/linux/kvm_para.h b/include/uapi/linux/kvm_para.h
index 960c7e93d1a9..dcb4ba1f033c 100644
--- a/include/uapi/linux/kvm_para.h
+++ b/include/uapi/linux/kvm_para.h
@@ -30,6 +30,7 @@
 #define KVM_HC_SEND_IPI		10
 #define KVM_HC_SCHED_YIELD		11
 #define KVM_HC_MAP_GPA_RANGE		12
+#define KVM_HC_GUEST_STEXT		13
 
 /*
  * hypercalls use architecture specific
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index a8c5c9f06b3c..8798f75ddade 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -72,3 +72,8 @@ config KVM_XFER_TO_GUEST_WORK
 
 config HAVE_KVM_PM_NOTIFIER
        bool
+
+# Offer an additional hypercall to a guest so it could pass value of _stext to
+# host, which will be used to adjust the calculation of KVM profiling.
+config ACCURATE_KVM_PROFILING
+       bool
-- 
2.35.1.1178.g4f1659d476-goog

