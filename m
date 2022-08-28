Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AE25A4008
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 00:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiH1W0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 18:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiH1WZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 18:25:52 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A0E140BB
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 15:25:51 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id a13-20020a170902eccd00b001730da9d40fso5037703plh.10
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 15:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc;
        bh=O9kmISZGgihA4T8t28vEwYfV0dJn2c/+twbqczubmvE=;
        b=odN/wZEzKPDjrYtsqZpqQlo5DyO9yPziqUidIynlB4MzlR/AbwMMPfknzajSUH6HNN
         mrqpnrQLzHkNGzSGpAYvBoeMhpzSY3k0kOhV783lhGcKKFp/BbwngUm6DH6td6KOGU0Q
         Ri0FLTaKIIyyZAKTB3pexllFa7Kiv6mLBJf8Ju4W/W+L1pHV3dLn/t5mUMuHjQda+OkN
         sL5Q06Ga2C2Ik90dee0/qM7Aiw5AmmfTZt3qzEwcWAlI02tof5ncdNxfojTZheRk2MW6
         cO2LtinBWxi887wwh0EZBH/vN0tI0K7Xamm5gUrk/sogCaelnm1/K1dGKvrnV1KWvRgx
         2Xhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc;
        bh=O9kmISZGgihA4T8t28vEwYfV0dJn2c/+twbqczubmvE=;
        b=aYfXU1jrvEGvoxN1miM8UK74s5abNoHT2WKhFAdC/0SNeMD8ApLXd0yeS86XZAQO0s
         83HNdEX9oMesLBHueMADPuyuaGrrIYRaR2SkAvHD83GZj2+bFw4DegmROZ8nfh54kIhh
         OGM0dmH98GXKZYdF+OpMZEbRmKjD9cjfo+ywKUvivAlVAc8Npy7zAqOfzXlEUtPEB28N
         cMSFTAEjHISrvOQWEV8jrsInqcU1OhmW4eZcvbhDGTqf1dxaZKFjcvsxelmb0NIUEgw4
         X7gO4yu9i3ldSfS6aoFCbKPj9cXOEEWpuQbKy4FqBvNJ3oHpRxKlUt9d9Y9zioZu6Izm
         KwTg==
X-Gm-Message-State: ACgBeo28eAwd2kkF6Bhvb91mh4vyhPNyM8yltf2Vpxzeg2GrHBKLiX+9
        46RbQVLfJ9ednQo0/4j64E/THY4JA2mH
X-Google-Smtp-Source: AA6agR5A7jAZuGYFUVtouKXe1LOefqg+qPyGJ5Bwh+pnBY3tczIAGKNOk2pmuuyUa2uP/OofQYh6rQccmXGO
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a05:6a00:1345:b0:536:d73a:4392 with SMTP
 id k5-20020a056a00134500b00536d73a4392mr13739160pfu.6.1661725551230; Sun, 28
 Aug 2022 15:25:51 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Sun, 28 Aug 2022 22:25:43 +0000
In-Reply-To: <20220828222544.1964917-1-mizhang@google.com>
Mime-Version: 1.0
References: <20220828222544.1964917-1-mizhang@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220828222544.1964917-4-mizhang@google.com>
Subject: [PATCH v2 3/4] KVM: selftests: Add support for posted interrupt
 handling in L2
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Oliver Upton <oupton@google.com>,
        Mingwei Zhang <mizhang@google.com>,
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

Add support for posted interrupt handling in L2. This is done by adding
needed data structures in vmx_pages and APIs to allow an L2 receive posted
interrupts.

Cc: Jim Mattson <jmattson@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 tools/testing/selftests/kvm/include/x86_64/vmx.h | 10 ++++++++++
 tools/testing/selftests/kvm/lib/x86_64/vmx.c     | 14 ++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/vmx.h b/tools/testing/selftests/kvm/include/x86_64/vmx.h
index 99fa1410964c..69784fc71bce 100644
--- a/tools/testing/selftests/kvm/include/x86_64/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/vmx.h
@@ -577,6 +577,14 @@ struct vmx_pages {
 	void *apic_access_hva;
 	uint64_t apic_access_gpa;
 	void *apic_access;
+
+	void *virtual_apic_hva;
+	uint64_t virtual_apic_gpa;
+	void *virtual_apic;
+
+	void *posted_intr_desc_hva;
+	uint64_t posted_intr_desc_gpa;
+	void *posted_intr_desc;
 };
 
 union vmx_basic {
@@ -620,5 +628,7 @@ void nested_identity_map_1g(struct vmx_pages *vmx, struct kvm_vm *vm,
 void prepare_eptp(struct vmx_pages *vmx, struct kvm_vm *vm,
 		  uint32_t eptp_memslot);
 void prepare_virtualize_apic_accesses(struct vmx_pages *vmx, struct kvm_vm *vm);
+void prepare_virtual_apic(struct vmx_pages *vmx, struct kvm_vm *vm);
+void prepare_posted_intr_desc(struct vmx_pages *vmx, struct kvm_vm *vm);
 
 #endif /* SELFTEST_KVM_VMX_H */
diff --git a/tools/testing/selftests/kvm/lib/x86_64/vmx.c b/tools/testing/selftests/kvm/lib/x86_64/vmx.c
index 80a568c439b8..47ae419d7eb1 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/vmx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/vmx.c
@@ -556,3 +556,17 @@ void prepare_virtualize_apic_accesses(struct vmx_pages *vmx, struct kvm_vm *vm)
 	vmx->apic_access_hva = addr_gva2hva(vm, (uintptr_t)vmx->apic_access);
 	vmx->apic_access_gpa = addr_gva2gpa(vm, (uintptr_t)vmx->apic_access);
 }
+
+void prepare_virtual_apic(struct vmx_pages *vmx, struct kvm_vm *vm)
+{
+	vmx->virtual_apic = (void *)vm_vaddr_alloc_page(vm);
+	vmx->virtual_apic_hva = addr_gva2hva(vm, (uintptr_t)vmx->virtual_apic);
+	vmx->virtual_apic_gpa = addr_gva2gpa(vm, (uintptr_t)vmx->virtual_apic);
+}
+
+void prepare_posted_intr_desc(struct vmx_pages *vmx, struct kvm_vm *vm)
+{
+	vmx->posted_intr_desc = (void *)vm_vaddr_alloc_page(vm);
+	vmx->posted_intr_desc_hva = addr_gva2hva(vm, vmx->posted_intr_desc);
+	vmx->posted_intr_desc_gpa = addr_gva2gpa(vm, vmx->posted_intr_desc);
+}
-- 
2.37.2.672.g94769d06f0-goog

