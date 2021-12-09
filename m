Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0B546F65E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 23:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbhLIWFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 17:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbhLIWFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 17:05:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD49C061746;
        Thu,  9 Dec 2021 14:02:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C9BFB826AA;
        Thu,  9 Dec 2021 22:02:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF26C004DD;
        Thu,  9 Dec 2021 22:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639087322;
        bh=IxWBkL/LSkBYY7wdZtmzNCrFoN69Auzds9R9m3Sbjf4=;
        h=From:To:Cc:Subject:Date:From;
        b=nZ/jzr+g1Situ29zm+EWXTgMBpg0LHq0na0KaYL25B3/32F9HDaNDPIiH3LDgH9X2
         MD3eknrQ0MKfW5m21K3viEkfMT1aLoJxFqWVaugqdWDpSwYdvmRvWOXr1nTK7QkxWU
         wjC9BrFjtQnt+L5DMG/p3kpGNyQM2fnfVlq1Mh758lb0BgFUq60yBAPXcgGTWv11I+
         Nzlx3Sj/DyN1G6V3damdnvJOZEEZPj4mIzboSagMI+Y3b/nfYj9iK/a6Xuw9UWVpzf
         xheOw4R0Soi3l7xUeJj7xItbc8ZLHNNj9r/cx8MJ/zyg6h62XJXjyRlTpjAH0zY4cQ
         Y8uEFIOXt4WMw==
From:   broonie@kernel.org
To:     Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <maz@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Subject: linux-next: manual merge of the kvm-arm tree with the kvm tree
Date:   Thu,  9 Dec 2021 22:01:58 +0000
Message-Id: <20211209220158.2674729-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the kvm-arm tree got a conflict in:

  arch/arm64/kvm/arm.c

between commit:

  6109c5a6ab7f3 ("KVM: arm64: Move vGIC v4 handling for WFI out arch callback hook")

from the kvm tree and commit:

  b5aa368abfbf4 ("KVM: arm64: Merge kvm_arch_vcpu_run_pid_change() and kvm_vcpu_first_run_init()")

from the kvm-arm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc arch/arm64/kvm/arm.c
index 7385bbdfdc42c,9b745d2bc89aa..0000000000000
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@@ -661,44 -698,6 +680,39 @@@ static void vcpu_req_sleep(struct kvm_v
  	smp_rmb();
  }
  
 +/**
 + * kvm_vcpu_wfi - emulate Wait-For-Interrupt behavior
 + * @vcpu:	The VCPU pointer
 + *
 + * Suspend execution of a vCPU until a valid wake event is detected, i.e. until
 + * the vCPU is runnable.  The vCPU may or may not be scheduled out, depending
 + * on when a wake event arrives, e.g. there may already be a pending wake event.
 + */
 +void kvm_vcpu_wfi(struct kvm_vcpu *vcpu)
 +{
 +	/*
 +	 * Sync back the state of the GIC CPU interface so that we have
 +	 * the latest PMR and group enables. This ensures that
 +	 * kvm_arch_vcpu_runnable has up-to-date data to decide whether
 +	 * we have pending interrupts, e.g. when determining if the
 +	 * vCPU should block.
 +	 *
 +	 * For the same reason, we want to tell GICv4 that we need
 +	 * doorbells to be signalled, should an interrupt become pending.
 +	 */
 +	preempt_disable();
 +	kvm_vgic_vmcr_sync(vcpu);
 +	vgic_v4_put(vcpu, true);
 +	preempt_enable();
 +
 +	kvm_vcpu_halt(vcpu);
 +	kvm_clear_request(KVM_REQ_UNHALT, vcpu);
 +
 +	preempt_disable();
 +	vgic_v4_load(vcpu);
 +	preempt_enable();
 +}
 +
- static int kvm_vcpu_initialized(struct kvm_vcpu *vcpu)
- {
- 	return vcpu->arch.target >= 0;
- }
- 
  static void check_vcpu_requests(struct kvm_vcpu *vcpu)
  {
  	if (kvm_request_pending(vcpu)) {
