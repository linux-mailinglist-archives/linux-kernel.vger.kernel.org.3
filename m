Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C363554BB5F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 22:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357723AbiFNUJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 16:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357265AbiFNUIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:08:01 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7432D2FE4B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:07:52 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id u8-20020a170902e5c800b00168d1fb52a9so4454299plf.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=k6fOpzXTad6Gmd8LBBX4EXfh/QWW1eOl/5tiLfmnInI=;
        b=hYIn2Aps9BLc9Odukg1hEhbOJKDYn42y6mC71I32gF84OmC5sKaHZ9EvxNJ4wYI/vq
         l3E6kMq07QR7GNNB2N2XjdHDS2kyHcytQ3trME2Y1a9A6aJ9ecUj9ZEVp62H58Hy8Bh1
         rotM8RCRokburuGWnNThUCBRPJpShH9OCGXF0CzyUj1ODC7Zc5XmPuiDaPnLtD6clYdm
         EVPEfMLSua9QXnQ8odGH0ubEop13WOFZIloSDB7WE7ASrkoznsbY6DaRsjqFejIQcU/Q
         TZTpG4CJ0yrUB/kAiWYRsDOE/P0/L/4wF6W9bAXT0AKCsmt6p3lEyhI+WYGShNMOQjlg
         exmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=k6fOpzXTad6Gmd8LBBX4EXfh/QWW1eOl/5tiLfmnInI=;
        b=QD2jUkX6YlEk6/IQJzkzGmB8lXwLvkQDgBf72Y3D5F1RJagFH0GKYc9YmfUhME7eWA
         9dtNP8Gx0p0HN19/Qafhu4SnARSPfT/c09Nfk+80PG2T0BD9duna0CnVBQb2AZyR0yNm
         ZYc4wXqSPQZheVhOpcM754yQbxRDMC7NS7uuhp+VVNF++/vO07i1gVFdlBA5jaPVP2In
         BFsY2RQVGdpF9jkEJzynzmigky/xSG1+OkF+HtOP26ytiplq5acqiUiVgS6hyv22Gde6
         vBTXmOcLWzYycAklwB546WMJH5nj1cbOFKSrhoqEjaX2JCbOYhgK5fuiOVe0l422AZK3
         IFXg==
X-Gm-Message-State: AJIora+2prDVv6XB6nXkqwMPqUdiiG9TGHiDgQfJqaSDcUiw78vSJvSR
        XTc9D9q0AkhdxUy5f4rGLGO0b7sk2v4=
X-Google-Smtp-Source: AGRyM1sSxupj+zuoboxhbkSugiSNWO7sYWthUk7HXQ73ELSUtqT/NiZZPmh/kvNTGEKCCUwGY1HAZtb7R68=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:b597:b0:168:d8ce:4a63 with SMTP id
 a23-20020a170902b59700b00168d8ce4a63mr5925487pls.57.1655237271987; Tue, 14
 Jun 2022 13:07:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 14 Jun 2022 20:06:47 +0000
In-Reply-To: <20220614200707.3315957-1-seanjc@google.com>
Message-Id: <20220614200707.3315957-23-seanjc@google.com>
Mime-Version: 1.0
References: <20220614200707.3315957-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v2 22/42] KVM: selftests: Add helpers to get and modify a
 vCPU's CPUID entries
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>
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

Add helpers to get a specific CPUID entry for a given vCPU, and to toggle
a specific CPUID-based feature for a vCPU.  The helpers will reduce the
amount of boilerplate code needed to tweak a vCPU's CPUID model, improve
code clarity, and most importantly move tests away from modifying the
static "cpuid" returned by kvm_get_supported_cpuid().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/x86_64/processor.h  | 30 +++++++++++++++++++
 .../selftests/kvm/lib/x86_64/processor.c      | 18 +++++++++++
 2 files changed, 48 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index b62d93a15903..555e73f96982 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -620,6 +620,19 @@ struct kvm_cpuid_entry2 *get_cpuid_entry(struct kvm_cpuid2 *cpuid,
 					 uint32_t function, uint32_t index);
 void vcpu_init_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid);
 
+static inline struct kvm_cpuid_entry2 *__vcpu_get_cpuid_entry(struct kvm_vcpu *vcpu,
+							      uint32_t function,
+							      uint32_t index)
+{
+	return get_cpuid_entry(vcpu->cpuid, function, index);
+}
+
+static inline struct kvm_cpuid_entry2 *vcpu_get_cpuid_entry(struct kvm_vcpu *vcpu,
+							    uint32_t function)
+{
+	return __vcpu_get_cpuid_entry(vcpu, function, 0);
+}
+
 static inline int __vcpu_set_cpuid(struct kvm_vcpu *vcpu)
 {
 	int r;
@@ -643,6 +656,23 @@ static inline void vcpu_set_cpuid(struct kvm_vcpu *vcpu)
 	vcpu_ioctl(vcpu, KVM_GET_CPUID2, vcpu->cpuid);
 }
 
+void vcpu_set_or_clear_cpuid_feature(struct kvm_vcpu *vcpu,
+				     struct kvm_x86_cpu_feature feature,
+				     bool set);
+
+static inline void vcpu_set_cpuid_feature(struct kvm_vcpu *vcpu,
+					  struct kvm_x86_cpu_feature feature)
+{
+	vcpu_set_or_clear_cpuid_feature(vcpu, feature, true);
+
+}
+
+static inline void vcpu_clear_cpuid_feature(struct kvm_vcpu *vcpu,
+					    struct kvm_x86_cpu_feature feature)
+{
+	vcpu_set_or_clear_cpuid_feature(vcpu, feature, false);
+}
+
 static inline struct kvm_cpuid_entry2 *kvm_get_supported_cpuid_index(uint32_t function,
 								     uint32_t index)
 {
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 8226aa5274f3..887272a33837 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -766,6 +766,24 @@ void vcpu_init_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid)
 	vcpu_set_cpuid(vcpu);
 }
 
+void vcpu_set_or_clear_cpuid_feature(struct kvm_vcpu *vcpu,
+				     struct kvm_x86_cpu_feature feature,
+				     bool set)
+{
+	struct kvm_cpuid_entry2 *entry;
+	u32 *reg;
+
+	entry = __vcpu_get_cpuid_entry(vcpu, feature.function, feature.index);
+	reg = (&entry->eax) + feature.reg;
+
+	if (set)
+		*reg |= BIT(feature.bit);
+	else
+		*reg &= ~BIT(feature.bit);
+
+	vcpu_set_cpuid(vcpu);
+}
+
 uint64_t vcpu_get_msr(struct kvm_vcpu *vcpu, uint64_t msr_index)
 {
 	struct {
-- 
2.36.1.476.g0c4daa206d-goog

