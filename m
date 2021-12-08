Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D6B46DA4A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbhLHRsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:48:16 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:54684 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbhLHRsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:48:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CC85ECE2292
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 17:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE459C00446;
        Wed,  8 Dec 2021 17:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638985479;
        bh=OBsbhFHSgjiIsBZG+MprcH9LNQvGBI+PWjEEiYr2P/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z+W4hNL0UGcAbWSmq4uuNzN+91ptDMp4t+MqtEeKYS58lAt2wBNlX5jvhhxvdas/d
         AToxQhpbFxjAkRWxXYlhC2nVi524iS5hByrJnWN9NvqCumBMzj3DgYZyUPuGNhDHoS
         qT3ZkV04DPZsBhLEhE7CFerhddNWnp7ATn3bAqxJT/olV/hlE+JqkoZAx0fZqkbxOX
         Qqih6YuZtCrn5p+onLPPQD2fH6lUy1wQsn3NO2vWN9QEGavbAIMyqySoukbi9tULxU
         sTk01HQB2uiUnl2s7rg2v7IUhTlGiwTioHGG3DUHDNGgVOboA7R+BLAMLXBYrY1Xh4
         IeeuqKj60y/RA==
Date:   Wed, 8 Dec 2021 17:44:34 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 2/6] KVM: arm64: pkvm: Disable GICv2 support
Message-ID: <20211208174434.GC820@willie-the-truck>
References: <20211208152300.2478542-1-qperret@google.com>
 <20211208152300.2478542-3-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208152300.2478542-3-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 03:22:55PM +0000, Quentin Perret wrote:
> GICv2 requires having device mappings in guests and the hypervisor,
> which is incompatible with the current pKVM EL2 page ownership model
> which only covers memory. While it would be desirable to support pKVM
> with GICv2, this will require a lot more work, so let's make the
> current assumption clear until then.
> 
> Co-developed-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/vgic/vgic-v2.c | 5 +++++
>  arch/arm64/kvm/vgic/vgic-v3.c | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/vgic/vgic-v2.c b/arch/arm64/kvm/vgic/vgic-v2.c
> index 95a18cec14a3..8e337a0d7817 100644
> --- a/arch/arm64/kvm/vgic/vgic-v2.c
> +++ b/arch/arm64/kvm/vgic/vgic-v2.c
> @@ -345,6 +345,11 @@ int vgic_v2_probe(const struct gic_kvm_info *info)
>  	int ret;
>  	u32 vtr;
>  
> +	if (is_protected_kvm_enabled()) {
> +		kvm_err("GICv2 not supported in protected mode\n");
> +		return -ENXIO;
> +	}
> +
>  	if (!info->vctrl.start) {
>  		kvm_err("GICH not present in the firmware table\n");
>  		return -ENXIO;
> diff --git a/arch/arm64/kvm/vgic/vgic-v3.c b/arch/arm64/kvm/vgic/vgic-v3.c
> index 04f62c4b07fb..debad4e6e6c9 100644
> --- a/arch/arm64/kvm/vgic/vgic-v3.c
> +++ b/arch/arm64/kvm/vgic/vgic-v3.c
> @@ -651,7 +651,7 @@ int vgic_v3_probe(const struct gic_kvm_info *info)
>  	} else if (!PAGE_ALIGNED(info->vcpu.start)) {
>  		pr_warn("GICV physical address 0x%llx not page aligned\n",
>  			(unsigned long long)info->vcpu.start);
> -	} else {
> +	} else if (kvm_get_mode() != KVM_MODE_PROTECTED) {
>  		kvm_vgic_global_state.vcpu_base = info->vcpu.start;
>  		kvm_vgic_global_state.can_emulate_gicv2 = true;
>  		ret = kvm_register_vgic_device(KVM_DEV_TYPE_ARM_VGIC_V2);

Acked-by: Will Deacon <will@kernel.org>

Will
