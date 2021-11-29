Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBFA54627F3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 00:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbhK2XQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 18:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237010AbhK2XQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:16:00 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A67C0C20DA
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 14:54:57 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso15524655pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 14:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=amMkdn1gHVYRhW1QzSDCQ1u8GlmuMsgmsvb7le63zRc=;
        b=OXcWBE1sJsuIxNp6pgfiaC80UcnnCyVu5LjIdfVeDZM7iZbqghB72+yoFNXjb5TQ1S
         eHksfqCFOtyJdHhMufreHEc1706paI+BPLHh4MsQ4oHciqF9PKZqm6p5dnkdfxSJ4Dvx
         AZ5C79t0Yz5vrpqxaGJECKEAlUkRUZBAoXGbAXvDee51NyhLFDwDW+tm1XBPC+lPFiIt
         SI7i4sWwte1hzsq/w9jaKIVVUHtayuAbzOcQyKXWkXbWUZ71oDj58ltm5pNDc4xKgvqU
         eiXBDoV9R6gn3j9vGEIi3P+8G0TlGTc0w5+VaffzKlTn4S1HhrEJLOxb7FkXoQOuncMC
         Yu2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=amMkdn1gHVYRhW1QzSDCQ1u8GlmuMsgmsvb7le63zRc=;
        b=4UXr5vWOVAyeijK6gGTeIfYz3HameD0C1WsNWs+SUoBDTBaABv74zCO09qvJoQj12P
         gAKdbhcJgQq/9Ls7YTiPfny+GcEjghMzuvBm61v+jpcnU77/xBWr6zY4c8PLqJuxWSFn
         +EAt+JWUczQIJ0KwoN/QbATR3H2hIkicMfOYXXc0BGJlfEbJFKOn3ppEbF12AQLzfiQK
         QPf+XDfnZWKA6zBFCw2do5ajdQ3DmwenwZyy85gJwwSfar6dtcS/v8vzgPGPRjEh3ORS
         bsLq2UBvZaGlCWcBNo+oncS3+DJx+f5yUWoz+WwDbQRj/RCJycr8TRJ1NoHuY1VZ4LbD
         dSIw==
X-Gm-Message-State: AOAM533estJn3Hd4hHBYpobO0P/PLoS6p9NNhjXNCfIoBrL2DyN4RsyO
        aAg+1QjwoXGWvaY1aIUBm7IzQA==
X-Google-Smtp-Source: ABdhPJzCBwfV8mmw3OYRI4z8/Ga72Qnl+uHz3ylVdXV0WGMA69d/iCpT26qxnlgUl9BKkyJ8kJLuaA==
X-Received: by 2002:a17:902:8c92:b0:144:b6fb:f82f with SMTP id t18-20020a1709028c9200b00144b6fbf82fmr64274340plo.14.1638226497129;
        Mon, 29 Nov 2021 14:54:57 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id m3sm1936006pgj.25.2021.11.29.14.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:54:56 -0800 (PST)
Date:   Mon, 29 Nov 2021 22:54:53 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pgonda@google.com
Subject: Re: [PATCH 10/12] KVM: SEV: Prohibit migration of a VM that has
 mirrors
Message-ID: <YaVaPbT2FOkcpY+n@google.com>
References: <20211123005036.2954379-1-pbonzini@redhat.com>
 <20211123005036.2954379-11-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123005036.2954379-11-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021, Paolo Bonzini wrote:
> VMs that mirror an encryption context rely on the owner to keep the
> ASID allocated.  Performing a KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM
> would cause a dangling ASID:
> 
> 1. copy context from A to B (gets ref to A)
> 2. move context from A to L (moves ASID from A to L)
> 3. close L (releases ASID from L, B still references it)
> 
> The right way to do the handoff instead is to create a fresh mirror VM
> on the destination first:
> 
> 1. copy context from A to B (gets ref to A)
> [later] 2. close B (releases ref to A)
> 3. move context from A to L (moves ASID from A to L)
> 4. copy context from L to M
> 
> So, catch the situation by adding a count of how many VMs are
> mirroring this one's encryption context.
> 
> Fixes: 0b020f5af092 ("KVM: SEV: Add support for SEV-ES intra host migration")
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/svm/sev.c                        | 22 ++++++++++-
>  arch/x86/kvm/svm/svm.h                        |  1 +
>  .../selftests/kvm/x86_64/sev_migrate_tests.c  | 37 +++++++++++++++++++
>  3 files changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 025d9731b66c..89a716290fac 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -1696,6 +1696,16 @@ int svm_vm_migrate_from(struct kvm *kvm, unsigned int source_fd)
>  	}
>  
>  	src_sev = &to_kvm_svm(source_kvm)->sev_info;
> +
> +	/*
> +	 * VMs mirroring src's encryption context rely on it to keep the
> +	 * ASID allocated, but below we are clearing src_sev->asid.

Prefer something to explan why this is disallowed instead of simply saying the
src's ASID is cleared/released, e.g.

	/*
	 * Disallow migrating a VM with active mirrors, as the mirrors rely on
	 * the VM to keep the ASID allocated.  Transferring all mirrors to dst
	 * would require locking all mirrors, and there's no known use case for
	 * intra-host migration of a VM with mirrors.
	 */

> +	 */
> +	if (src_sev->num_mirrored_vms) {
> +		ret = -EBUSY;
> +		goto out_unlock;
> +	}
> +
>  	dst_sev->misc_cg = get_current_misc_cg();
>  	cg_cleanup_sev = dst_sev;
>  	if (dst_sev->misc_cg != src_sev->misc_cg) {
> @@ -1987,6 +1997,7 @@ int svm_vm_copy_asid_from(struct kvm *kvm, unsigned int source_fd)
>  	 */
>  	source_sev = &to_kvm_svm(source_kvm)->sev_info;
>  	kvm_get_kvm(source_kvm);
> +	source_sev->num_mirrored_vms++;
>  
>  	/* Set enc_context_owner and copy its encryption context over */
>  	mirror_sev = &to_kvm_svm(kvm)->sev_info;
> @@ -2019,12 +2030,21 @@ void sev_vm_destroy(struct kvm *kvm)
>  	struct list_head *head = &sev->regions_list;
>  	struct list_head *pos, *q;
>  
> +	WARN_ON(sev->num_mirrored_vms);
> +
>  	if (!sev_guest(kvm))
>  		return;
>  
>  	/* If this is a mirror_kvm release the enc_context_owner and skip sev cleanup */
>  	if (is_mirroring_enc_context(kvm)) {
> -		kvm_put_kvm(sev->enc_context_owner);
> +		struct kvm *owner_kvm = sev->enc_context_owner;
> +		struct kvm_sev_info *owner_sev = &to_kvm_svm(owner_kvm)->sev_info;
> +
> +		mutex_lock(&owner_kvm->lock);
> +		if (!WARN_ON(!owner_sev->num_mirrored_vms))

Why not make num_mirrored_vms an atomic_t so that the destruction path doesn't
need to take owner_kvm->lock?  The asymmetry is a bit odd, but this feels worse
in its own way.

And since this is effectively a refcount, I almost wonder if it would make sense
to do:

	if (!refcount_inc_not_zero(&source_sev->num_mirrored_vms)) {
		refcount_set(&source_sev->num_mirrored_vms, 1);
		kvm_get_kvm(source_kvm);
	}

and then

	if (refcount_dec_and_test(&source_sev->num_mirrored_vms))
		kvm_put_kvm(owner_kvm);

to "officially" refcount something.


> +			owner_sev->num_mirrored_vms--;
> +		mutex_unlock(&owner_kvm->lock);
> +		kvm_put_kvm(owner_kvm);
>  		return;
>  	}
>  
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 5faad3dc10e2..1c7306c370fa 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -79,6 +79,7 @@ struct kvm_sev_info {
>  	struct list_head regions_list;  /* List of registered regions */
>  	u64 ap_jump_table;	/* SEV-ES AP Jump Table address */
>  	struct kvm *enc_context_owner; /* Owner of copied encryption context */
> +	unsigned long num_mirrored_vms; /* Number of VMs sharing this ASID */

Unsigned long is odd.  It's guaranteed to be u64 since SEV is 64-bit only.  If
it really is possible to overflow a refcount_t/int, than u64 or atomic64_t seems
more appropriate.

>  	struct misc_cg *misc_cg; /* For misc cgroup accounting */
>  	atomic_t migration_in_progress;
>  };
