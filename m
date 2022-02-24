Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908DA4C33A0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 18:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiBXR1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 12:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiBXR1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 12:27:11 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC139278CBF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:26:26 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id x18-20020a170902b41200b0014fc2665bddso1423532plr.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=b6uNiWvgAwogCk/jxX+wM4vHns+UEbCP4x0AKJLO+4Q=;
        b=h+4yAjVxpHpHUG9ZXzKDxIY+XLIBSv6S2i9Dizt7ZsHBT6ZQPOVwypGOZXKBNUg6DZ
         R6n9PG3mnByfdNrm8n/8ktstVfOHvp/Ref4D+MPm4vuwgKFo4gTWrv7W38u0oQKvhnxi
         Bc+teTfh7/CqaXBRR3MXfqLp30xNrKZPqHJhTjpFdSvBNQUJb6opdmPm7JNfTOliqfz7
         +lNPqy0LF97Pb3uCq/4tTwWMkFYwLB+f6iUL/onr8Z86zLRqVweT0wANPb0ELlZb9XmW
         sKD0BqPMfSCeVVNxMxORAmwxagVX3bmp6ivji2USJVMpXim36w50UMdzJYYiaax+rIQe
         I7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=b6uNiWvgAwogCk/jxX+wM4vHns+UEbCP4x0AKJLO+4Q=;
        b=kGQuPP9gBxU8cRtxPFXIdAH1MSqItkid/BgbPheqqPH7b5+BKhkkoZrSvsgpWrQpf7
         V5hPX42O7PqQszlsCIZctGtcJ0dUbY89c1tkr798UPeiM+3EN5JlcVlAfFFlncQ/S6J1
         gWS0eprcsxHBhcb6dKaIlOkhUxbYvVMPy0WwdIYYBJSeUbN1sF0N22tJZewpPyNMoTi1
         pxQfS3gGzOE0WmptdlNuwSkHV4jfjH/qxwTgx3RKtoNUrs1i2Cu/IE8JKvY8AWqVsdYb
         Dl2nJCoQ6x/oP2asfVb6zQYwPvudDjsxKkPqp/E3SKmo25RQyIOtoPpwnvDXkkTQiEfp
         fOJQ==
X-Gm-Message-State: AOAM530tLq+3pw9Ygi53bbQPVk0cmOgD0D5Q1bItDIioTuAvgkqCEPAc
        ckvO8CDM8fOsgRK9eG8qbUKq9mcbq/Xm
X-Google-Smtp-Source: ABdhPJwk7AgkVcTxMVZ+wEFay2w+mClV6dcietIwRyKAlHhoCWyT1LJHKiM+ia3GXTfTot6zyZ3GOK98LzI0
X-Received: from rananta-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1bcc])
 (user=rananta job=sendgmr) by 2002:a17:902:930b:b0:14d:b0c0:1f71 with SMTP id
 bc11-20020a170902930b00b0014db0c01f71mr3700280plb.113.1645723586271; Thu, 24
 Feb 2022 09:26:26 -0800 (PST)
Date:   Thu, 24 Feb 2022 17:25:54 +0000
In-Reply-To: <20220224172559.4170192-1-rananta@google.com>
Message-Id: <20220224172559.4170192-9-rananta@google.com>
Mime-Version: 1.0
References: <20220224172559.4170192-1-rananta@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v4 08/13] Docs: KVM: Add doc for the bitmap firmware registers
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Marc Zyngier <maz@kernel.org>, Andrew Jones <drjones@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Raghavendra Rao Anata <rananta@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
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

Add the documentation for the bitmap firmware registers in
psci.rst. This includes the details for KVM_REG_ARM_STD_BMAP,
KVM_REG_ARM_STD_HYP_BMAP, and KVM_REG_ARM_VENDOR_HYP_BMAP
registers.

Since the document is growing to carry other hypercall related
information, make necessary adjustments to present the document
in a generic sense, rather than being PSCI focused.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 Documentation/virt/kvm/arm/psci.rst | 83 ++++++++++++++++++++++-------
 1 file changed, 65 insertions(+), 18 deletions(-)

diff --git a/Documentation/virt/kvm/arm/psci.rst b/Documentation/virt/kvm/arm/psci.rst
index d52c2e83b5b8..bc5c2886ca23 100644
--- a/Documentation/virt/kvm/arm/psci.rst
+++ b/Documentation/virt/kvm/arm/psci.rst
@@ -1,32 +1,32 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-=========================================
-Power State Coordination Interface (PSCI)
-=========================================
+=======================
+ARM Hypercall Interface
+=======================
 
-KVM implements the PSCI (Power State Coordination Interface)
-specification in order to provide services such as CPU on/off, reset
-and power-off to the guest.
+KVM handles the hypercall services as requested by the guests. New hypercall
+services are regularly made available by the ARM specification or by KVM (as
+vendor services) if they make sense from a virtualization point of view.
 
-The PSCI specification is regularly updated to provide new features,
-and KVM implements these updates if they make sense from a virtualization
-point of view.
-
-This means that a guest booted on two different versions of KVM can
-observe two different "firmware" revisions. This could cause issues if
-a given guest is tied to a particular PSCI revision (unlikely), or if
-a migration causes a different PSCI version to be exposed out of the
-blue to an unsuspecting guest.
+This means that a guest booted on two different versions of KVM can observe
+two different "firmware" revisions. This could cause issues if a given guest
+is tied to a particular version of a hypercall service, or if a migration
+causes a different version to be exposed out of the blue to an unsuspecting
+guest.
 
 In order to remedy this situation, KVM exposes a set of "firmware
 pseudo-registers" that can be manipulated using the GET/SET_ONE_REG
 interface. These registers can be saved/restored by userspace, and set
-to a convenient value if required.
+to a convenient value as required.
 
-The following register is defined:
+The following registers are defined:
 
 * KVM_REG_ARM_PSCI_VERSION:
 
+  KVM implements the PSCI (Power State Coordination Interface)
+  specification in order to provide services such as CPU on/off, reset
+  and power-off to the guest.
+
   - Only valid if the vcpu has the KVM_ARM_VCPU_PSCI_0_2 feature set
     (and thus has already been initialized)
   - Returns the current PSCI version on GET_ONE_REG (defaulting to the
@@ -74,4 +74,51 @@ The following register is defined:
     KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_2_NOT_REQUIRED:
       The workaround is always active on this vCPU or it is not needed.
 
-.. [1] https://developer.arm.com/-/media/developer/pdf/ARM_DEN_0070A_Firmware_interfaces_for_mitigating_CVE-2017-5715.pdf
+Contrary to the above registers, the following registers exposes the hypercall
+services in the form of a feature-bitmap. This bitmap is translated to the
+services that are exposed to the guest. There is a register defined per service
+call owner and can be accessed via GET/SET_ONE_REG interface.
+
+By default, these registers are set with the upper limit of the features that
+are supported. User-space can discover this configuration via GET_ONE_REG. If
+unsatisfied, the user-space can write back the desired bitmap back via
+SET_ONE_REG. The features for the registers that are untouched, probably because
+userspace isn't aware of them, will be exposed as is to the guest.
+
+The psuedo-firmware bitmap register are as follows:
+
+* KVM_REG_ARM_STD_BMAP:
+    Controls the bitmap of the ARM Standard Secure Service Calls.
+
+  The following bits are accepted:
+
+    KVM_REG_ARM_STD_BIT_TRNG_V1_0:
+      The bit represents the services offered under v1.0 of ARM True Random
+      Number Generator (TRNG) specification, ARM DEN0098.
+
+* KVM_REG_ARM_STD_HYP_BMAP:
+    Controls the bitmap of the ARM Standard Hypervisor Service Calls.
+
+  The following bits are accepted:
+
+    KVM_REG_ARM_STD_HYP_BIT_PV_TIME:
+      The bit represents the Paravirtualized Time service as represented by
+      ARM DEN0057A.
+
+* KVM_REG_ARM_VENDOR_HYP_BMAP:
+    Controls the bitmap of the Vendor specific Hypervisor Service Calls.
+
+  The following bits are accepted:
+
+    KVM_REG_ARM_VENDOR_HYP_BIT_PTP:
+      The bit represents the Precision Time Protocol KVM service.
+
+Errors:
+
+    =======  =============================================================
+    -ENOENT   Unknown register accessed.
+    -EBUSY    Attempt a 'write' to the register after the VM has started.
+    -EINVAL   Invalid bitmap written to the register.
+    =======  =============================================================
+
+.. [1] https://developer.arm.com/-/media/developer/pdf/ARM_DEN_0070A_Firmware_interfaces_for_mitigating_CVE-2017-5715.pdf
\ No newline at end of file
-- 
2.35.1.473.g83b2b277ed-goog

