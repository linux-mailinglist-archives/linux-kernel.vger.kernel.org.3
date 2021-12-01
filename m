Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCAF46456B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 04:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239518AbhLADbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 22:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbhLADbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 22:31:07 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FD2C061746
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 19:27:47 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 71so22072895pgb.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 19:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JDqr2QfE9FNuA18WUHwMUU6jztbFb/7X65WnDCxhbds=;
        b=KxfD4XzWfo7EZ/RcoT8RadbeTCJsAu69S1SF/Mfp6yG55NnsxqEui/UXNxUEPwUOM8
         2DbFVSF5jd8bysfIUAhhwfrrilV3BId1mlAYHZTTOR9+Acuem0v2PRCMF1ffz5HiigTi
         apLTeslg6S0BHbE+PPFMNhR7P7BtE0GOIosPeuYo0dP7bbJrMf6ihoD7eBVLdrTSpkhV
         8cW6dNoDjU0wjdUtGBzskt7sBahyPym1ko+mklLxtJMvqlNaRD7JOkaxl10X1YDgokq6
         esV5iMYywRC5+uqQ+mtpuvcLYI7WISKJ3hqYW6MW/zyqY1uBlBPZkb8hSvBlZChNK7Uq
         ewCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JDqr2QfE9FNuA18WUHwMUU6jztbFb/7X65WnDCxhbds=;
        b=FaKDF9g5LFeoRpbeKf/bIQ9Cj1zF+4QLmbzuFMOD+B2IlrxnS4iYMcyMQaFiSU0aYw
         pZFP+2QUFAm3zvDIutBpKUGybxe+0XIOQupN97/0ZmymH5Rn2DrRgkdFhc/th6fV0pkc
         2ATTKEn6rexni5sALeX4m8meodzzQLe5c4qZHVfeqYyL2lRdb0XLsoF51NbHIuHdapCv
         oWrLxaDycIMQEcF0Ln7ku1zfmC3pNWZovNO5yVdOgWL1BxRrpkRksIUqBa7DvMWQ6OEf
         d7q0X2MRa6n8fK8Pk/mCjT1RkxCC5DHAXAldU9FlPfrG1Vjdym5IGkN+mk3/BxYJsO6g
         utAQ==
X-Gm-Message-State: AOAM531pSMkTlZ+GUFDtTAfPgfrTkp9hAW7v+tp4/toyLaNojoZSOdyg
        yFZoC9KDG86I02WQ5f2wEgqNiA==
X-Google-Smtp-Source: ABdhPJx0+D0Jw3Va3pxLD/Dxl937j9h8N9r9VbH4OOKoze8YM5BLsF/p6ENHBftuUylRVRa1Vc9w7Q==
X-Received: by 2002:a05:6a00:1516:b0:4a0:2c42:7f17 with SMTP id q22-20020a056a00151600b004a02c427f17mr3265923pfu.74.1638329266940;
        Tue, 30 Nov 2021 19:27:46 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id h186sm22147106pfg.64.2021.11.30.19.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 19:27:46 -0800 (PST)
Date:   Wed, 1 Dec 2021 03:27:43 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Igor Mammedov <imammedo@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Anup Patel <anup.patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        Ben Gardon <bgardon@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 25/29] KVM: Call kvm_arch_flush_shadow_memslot() on
 the old slot in kvm_invalidate_memslot()
Message-ID: <Yabrr6Q9WxFb3Eec@google.com>
References: <cover.1638304315.git.maciej.szmigiero@oracle.com>
 <72e1c87ddce1c2836bf8a82962202dc4c34bb53f.1638304316.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72e1c87ddce1c2836bf8a82962202dc4c34bb53f.1638304316.git.maciej.szmigiero@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> kvm_invalidate_memslot() calls kvm_arch_flush_shadow_memslot() on the
> active, but KVM_MEMSLOT_INVALID slot.
> Do it on the inactive (but valid) old slot instead since arch code really
> should not get passed such invalid slot.

One other thing that's worth noting in the changelog is that "old->arch" may have
stale data.  IMO that's perfectly ok, but it's definitely a quirk.  Ideally KVM
would disallow touching "arch" for an INVALID slot, but that would require another
arch hook if kvm_prepare_memory_region() failed to refresh old->arch if necessary
before restoring it. :-/

Paolo, thoughts on this goofy case?  I don't love it, but I dislike having

	kvm_arch_flush_shadow_memslot(kvm, invalid_slot);

in the final code even more.

Reviewed-by: Sean Christopherson <seanjc@google.com> 

> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>  virt/kvm/kvm_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index c57748ee41e8..086f18969bc3 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1632,7 +1632,7 @@ static void kvm_invalidate_memslot(struct kvm *kvm,
>  	 *	- gfn_to_hva (kvm_read_guest, gfn_to_pfn)
>  	 *	- kvm_is_visible_gfn (mmu_check_root)
>  	 */
> -	kvm_arch_flush_shadow_memslot(kvm, working_slot);
> +	kvm_arch_flush_shadow_memslot(kvm, old);
>  
>  	/* Was released by kvm_swap_active_memslots, reacquire. */
>  	mutex_lock(&kvm->slots_arch_lock);
