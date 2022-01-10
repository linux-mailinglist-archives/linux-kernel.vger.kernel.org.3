Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D19489F91
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242441AbiAJSuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242379AbiAJSuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:50:09 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DF8C061748
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:50:08 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id pf13so6082724pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JPHyMSD0Hht+l6xGbfoQXW2mPjKndXPFFsASkcOJqDE=;
        b=fym04tJGsUWhlyvnXG+ODJIBt4l3YTTIY5vplWKORvFwUS2mBRmbwMf1oavotirIwy
         a1EgN9CS3DnDpCTqXMzK1TNojevcXuGBmHwXVt/5aHpJgFqld5Aj73ipV3DTaND4UF9I
         eDqtcLy9E7Y2zdPK3P4sYzN0FzsRIvQrjO4tlVAVSh/Cb13nVrD8ZVZtPPfDj7TlLSUW
         MkyTRAhTfGo3dQgBuz0J1gsoBOeB3dlRRtfpjxCXsDCI5XuJe2I9vBaHrJhSdlsJTqBO
         3ndEey8gTKCEJ5SWFD7O2be66F17xuGNg0x9bqjk1djDe24FaFL64amnfiCPtNUvrwGU
         XDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JPHyMSD0Hht+l6xGbfoQXW2mPjKndXPFFsASkcOJqDE=;
        b=l4ivGraVMafE4kFvbMgz3e4vXTG9o1inMXhRXFA43s1zbxKS/Swh1Gew9xZpaILPwQ
         v8M7Yx1iPMpv5oZ/ow5kXbyVO7VkVJ1OX36VVcdELCrRajwtDE/mwUZ1JM2lJVahvIJ7
         P+tKNZTxX8l0TLTztycAqSZuAGykOHuHZYSabywwsBh7ksm/cqpp84Rrg3rLgWLD1W4W
         aOC5ou/Le3z1rPKXVromziVLVFKQ5bbIrlUaDXsEcWS/ruLWv34WFXq9uw6kHb4Hp78r
         6mPr7ydv5qaxvblRZwIr5EA/rOXhiZ6v94zfeyA79DRDyVntRps9vfa+QRK7bSDoMmxX
         X9aA==
X-Gm-Message-State: AOAM5308iyizgRXVV6WZX+dvFp9sbStUuv86D+2cf7n1nA+uPRcxRtCW
        xahlr9VJ4ssAtNbKxk5If2vasg==
X-Google-Smtp-Source: ABdhPJz9g5NFlzk/aqJ4LkDssTD+y6Hb+i2qg5eiqe1RGdzWYdRbqxVkbV2SsRHuBtU9LrtnPxuCjA==
X-Received: by 2002:a17:90a:c917:: with SMTP id v23mr8207612pjt.49.1641840608234;
        Mon, 10 Jan 2022 10:50:08 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id w6sm6026449pga.25.2022.01.10.10.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 10:50:07 -0800 (PST)
Date:   Mon, 10 Jan 2022 18:50:03 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Kechen Lu <kechenl@nvidia.com>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, wanpengli@tencent.com,
        vkuznets@redhat.com, mst@redhat.com, somduttar@nvidia.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/3] KVM: x86: only allow exits disable before
 vCPUs created
Message-ID: <Ydx/21chyOGW8hoZ@google.com>
References: <20211221090449.15337-1-kechenl@nvidia.com>
 <20211221090449.15337-2-kechenl@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221090449.15337-2-kechenl@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021, Kechen Lu wrote:
> Since VMX and SVM both would never update the control bits if exits
> are disable after vCPUs are created, only allow setting exits
> disable flag before vCPU creation.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

For this to carry my SOB, I should be attributed as the author, or add a
Co-developed-by: for me.  I'm also totally ok with a Suggested-by: or Reported-by:

And we should at least have

  Fixes: 4d5422cea3b6 ("KVM: X86: Provide a capability to disable MWAIT intercepts")

andy maybe Cc: stable@vger.kernel.org, though I'm not entirely sure this is stable
material as it could in theory do more harm than good if there's a busted userspace
out there.

If this doesn't carry my SOB...

Reviewed-by: Sean Christopherson <seanjc@google.com>

> Signed-off-by: Kechen Lu <kechenl@nvidia.com>
> ---
>  Documentation/virt/kvm/api.rst | 1 +
>  arch/x86/kvm/x86.c             | 6 ++++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index aeeb071c7688..d1c50b95bbc1 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6581,6 +6581,7 @@ branch to guests' 0x200 interrupt vector.
>  :Architectures: x86
>  :Parameters: args[0] defines which exits are disabled
>  :Returns: 0 on success, -EINVAL when args[0] contains invalid exits
> +          or if any vCPU has already been created
>  
>  Valid bits in args[0] are::
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0cf1082455df..37529c0c279d 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5764,6 +5764,10 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>  		if (cap->args[0] & ~KVM_X86_DISABLE_VALID_EXITS)
>  			break;
>  
> +		mutex_lock(&kvm->lock);
> +		if (kvm->created_vcpus)
> +			goto disable_exits_unlock;
> +
>  		if ((cap->args[0] & KVM_X86_DISABLE_EXITS_MWAIT) &&
>  			kvm_can_mwait_in_guest())
>  			kvm->arch.mwait_in_guest = true;
> @@ -5774,6 +5778,8 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>  		if (cap->args[0] & KVM_X86_DISABLE_EXITS_CSTATE)
>  			kvm->arch.cstate_in_guest = true;
>  		r = 0;
> +disable_exits_unlock:
> +		mutex_unlock(&kvm->lock);
>  		break;
>  	case KVM_CAP_MSR_PLATFORM_INFO:
>  		kvm->arch.guest_can_read_msr_platform_info = cap->args[0];
> -- 
> 2.30.2
> 
