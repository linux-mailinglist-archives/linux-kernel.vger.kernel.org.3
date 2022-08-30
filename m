Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659985A6518
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 15:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiH3Nj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 09:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiH3NjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:39:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB7714FCAE
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 06:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661866699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7h85PcHhqC17acYkgYlh5qRDnYIfh81R2bPVuDZg1T4=;
        b=fg16uMEH8TFdywmDQMlJwrddK51veT+VReyVHWyOzD4l0FYfomG//HvcOMlD3aur7sRNCY
        5AFAxK6m+lzdKk97EJlkvDe0ZJ6Hcwx4KNLIhGVC/e7u6xscpossW5vU4a7KFnATP43WII
        OLbupnmBj0XyEGg6PxEduC8qWQIZFsU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-359-arhrFy7VPuK2edH1Td5NRA-1; Tue, 30 Aug 2022 09:38:18 -0400
X-MC-Unique: arhrFy7VPuK2edH1Td5NRA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA319811E83;
        Tue, 30 Aug 2022 13:38:16 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.194.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8FDA2166B26;
        Tue, 30 Aug 2022 13:38:14 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 14/33] KVM: nVMX: WARN once and fail VM-Enter if eVMCS sees VMFUNC[63:32] != 0
Date:   Tue, 30 Aug 2022 15:37:18 +0200
Message-Id: <20220830133737.1539624-15-vkuznets@redhat.com>
In-Reply-To: <20220830133737.1539624-1-vkuznets@redhat.com>
References: <20220830133737.1539624-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <seanjc@google.com>

WARN and reject nested VM-Enter if KVM is using eVMCS and manages to
allow a non-zero value in the upper 32 bits of VM-function controls.  The
eVMCS code assumes all inputs are 32-bit values and subtly drops the
upper bits.  WARN instead of adding proper "support", it's unlikely the
upper bits will be defined/used in the next decade.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx/evmcs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kvm/vmx/evmcs.c b/arch/x86/kvm/vmx/evmcs.c
index c3a5309f6e82..b64e29f1359f 100644
--- a/arch/x86/kvm/vmx/evmcs.c
+++ b/arch/x86/kvm/vmx/evmcs.c
@@ -469,6 +469,14 @@ int nested_evmcs_check_controls(struct vmcs12 *vmcs12)
 					       vmcs12->vm_entry_controls)))
 		return -EINVAL;
 
+	/*
+	 * VM-Func controls are 64-bit, but KVM currently doesn't support any
+	 * controls in bits 63:32, i.e. dropping those bits on the consistency
+	 * check is intentional.
+	 */
+	if (WARN_ON_ONCE(vmcs12->vm_function_control >> 32))
+		return -EINVAL;
+
 	if (CC(!nested_evmcs_is_valid_controls(EVMCS_VMFUNC,
 					       vmcs12->vm_function_control)))
 		return -EINVAL;
-- 
2.37.2

