Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4027515A8A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 07:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241068AbiD3FE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 01:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbiD3FEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 01:04:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF4012A9A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 22:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=UN4x7iH4NKXkteoWIh3EUxDFhL5V4nUDAqGTxkHP6DM=; b=KR8l/WAr9lBc5OBVsczVxMqTZl
        gvcPHgjQ70H81QG8/xWxtjwDT0OaksyA7HF1GxQSxddUnU1ExA/LAcuB1vjdlaN9WRWwbZy0irhom
        b+F/edUU5pBSHWcE7s3O2b0ENOUIvvsmxPvw8UddvBsxFBT2RrVLWGzQAWEmngUE/YdqbzrT33WBc
        3mX7IO8twjOIrUAfQrmjfJaOCSKLxyeUyfwFEiMBqTBmnMjQiG8Enh8hTdC/jTkoA3pRBkINSF+kz
        P8SnjKUlpMVqpZl97eq3gZI6JKWfKbfj/Oc5q3IJh4SXcg1WzCQN9NV0jJ87Evc45068WMf+jGyk9
        /Ppu/P5w==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkfES-00DdP7-Cx; Sat, 30 Apr 2022 05:01:24 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Fuad Tabba <tabba@google.com>, Marc Zyngier <maz@kernel.org>,
        David Brazdil <dbrazdil@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Subject: [PATCH] KVM: arm64: nvhe: eliminate kernel-doc warnings
Date:   Fri, 29 Apr 2022 22:01:23 -0700
Message-Id: <20220430050123.2844-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't use begin-kernel-doc notation (/**) for comments that are not in
kernel-doc format.

This prevents these kernel-doc warnings:

arch/arm64/kvm/hyp/nvhe/switch.c:126: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Disable host events, enable guest events
arch/arm64/kvm/hyp/nvhe/switch.c:146: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Disable guest events, enable host events
arch/arm64/kvm/hyp/nvhe/switch.c:164: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Handler for protected VM restricted exceptions.
arch/arm64/kvm/hyp/nvhe/switch.c:176: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Handler for protected VM MSR, MRS or System instruction execution in AArch64.
arch/arm64/kvm/hyp/nvhe/switch.c:196: warning: Function parameter or member 'vcpu' not described in 'kvm_handle_pvm_fpsimd'
arch/arm64/kvm/hyp/nvhe/switch.c:196: warning: Function parameter or member 'exit_code' not described in 'kvm_handle_pvm_fpsimd'
arch/arm64/kvm/hyp/nvhe/switch.c:196: warning: expecting prototype for Handler for protected floating(). Prototype was for kvm_handle_pvm_fpsimd() instead

Fixes: 09cf57eba304 ("KVM: arm64: Split hyp/switch.c to VHE/nVHE")
Fixes: 1423afcb4117 ("KVM: arm64: Trap access to pVM restricted features")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Fuad Tabba <tabba@google.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: David Brazdil <dbrazdil@google.com>
Cc: James Morse <james.morse@arm.com>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.cs.columbia.edu
---
 arch/arm64/kvm/hyp/nvhe/switch.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -150,7 +150,7 @@ static void __hyp_vgic_restore_state(str
 	}
 }
 
-/**
+/*
  * Disable host events, enable guest events
  */
 static bool __pmu_switch_to_guest(struct kvm_cpu_context *host_ctxt)
@@ -170,7 +170,7 @@ static bool __pmu_switch_to_guest(struct
 	return (pmu->events_host || pmu->events_guest);
 }
 
-/**
+/*
  * Disable guest events, enable host events
  */
 static void __pmu_switch_to_host(struct kvm_cpu_context *host_ctxt)
@@ -188,7 +188,7 @@ static void __pmu_switch_to_host(struct
 		write_sysreg(pmu->events_host, pmcntenset_el0);
 }
 
-/**
+/*
  * Handler for protected VM MSR, MRS or System instruction execution in AArch64.
  *
  * Returns true if the hypervisor has handled the exit, and control should go
@@ -205,7 +205,7 @@ static bool kvm_handle_pvm_sys64(struct
 		kvm_handle_pvm_sysreg(vcpu, exit_code));
 }
 
-/**
+/*
  * Handler for protected floating-point and Advanced SIMD accesses.
  *
  * Returns true if the hypervisor has handled the exit, and control should go
