Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF804A645A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242141AbiBAS67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:58:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:48617 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242108AbiBAS6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643741931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zGmX9IUnSXmMKokNO9qz3Kz26obyyHFvs70RDRmlrrg=;
        b=O8jovZw5eAe+YPloDVVN1AL8/pBxnPcrhCa1jDlN9pBy/GJvJU9s5GuWxNndoj02GvG/oa
        hp+lFjUiv+cO0p7e1D1vE7hF01ZNt4T4cZAbklM94Z8ZYcpBO3hIZ0Shptot4lGFPbFR4+
        vrN8CIVRBwv8NPIhxnfIIGBRmVsn9mc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-45-xUcHV--bNCeGMWoIzLFlzg-1; Tue, 01 Feb 2022 13:58:50 -0500
X-MC-Unique: xUcHV--bNCeGMWoIzLFlzg-1
Received: by mail-wm1-f69.google.com with SMTP id q127-20020a1ca785000000b00352a4860babso1358208wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 10:58:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=zGmX9IUnSXmMKokNO9qz3Kz26obyyHFvs70RDRmlrrg=;
        b=iKBslaPlR7aa3ZH1jxq6iBW2i1itIOJ6g7UNloz2gk+lil0ecSDg3Lu1Vj2k68b1c5
         KwtUit620/LUPBvxPSDI61KUJpdIuT20XNptPYQZM3wHTAO58fzAQiV5r76mHfuAmube
         4qDfGP9CaUH9+IvpQoVUukFI2sVlpMsPMVs1hxOaF53HspzSIC9Wg1tLS1s9ccby21wT
         Ox4ssG1/ndWd8rqqApyUypPX3x7WlQIB8XTseePshgoXrFQAeTLRRQ1W3Zh92ccEsdhH
         Xp07EvBs/YgYOKe+0NMh+N8XVbL1GrRd7I8frpib1CUDFmyMiXXUEvwJHOC4DJlQmI6f
         awow==
X-Gm-Message-State: AOAM530Dq0nabhxTWqvgg00qvoF3QmFyvXM1Fxe+qe9ZEqZSvsW8Ul3d
        IHKJwoSZF2JW9/bBX9DWzBkzqUQgZ7+OmpP2HC9HsIkCx4dpHuIQoswBf4+C78aBadhR7SbJIN3
        HAE9xI6iu7+KkTTcA4W/EFbp8CJd9QborDV1Ars4tsoZLOWwgalD0fQiMMn4Hg5j5iOtUUlWRhN
        LQ
X-Received: by 2002:a5d:6488:: with SMTP id o8mr20084701wri.24.1643741929365;
        Tue, 01 Feb 2022 10:58:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJydb89it+jdwnGcOW3qs/xUthVZ9WACtZIazDlbT40Esp04XJ588FmYR//DxX+r1dbAtIK3Jg==
X-Received: by 2002:a5d:6488:: with SMTP id o8mr20084681wri.24.1643741929074;
        Tue, 01 Feb 2022 10:58:49 -0800 (PST)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id m8sm14991135wrn.106.2022.02.01.10.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 10:58:48 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] KVM: SVM: nSVM: Implement Enlightened MSR-Bitmap
 for Hyper-V-on-KVM and fix it for KVM-on-Hyper-V
In-Reply-To: <66bcd1bf-0df4-8f02-9c0d-f71cecef71f4@redhat.com>
References: <20211220152139.418372-1-vkuznets@redhat.com>
 <35f06589-d300-c356-dc17-2c021ac97281@redhat.com>
 <87sft2bqup.fsf@redhat.com>
 <66bcd1bf-0df4-8f02-9c0d-f71cecef71f4@redhat.com>
Date:   Tue, 01 Feb 2022 19:58:47 +0100
Message-ID: <87o83qbehk.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 2/1/22 15:31, Vitaly Kuznetsov wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>> 
>>> On 12/20/21 16:21, Vitaly Kuznetsov wrote:
>>>> Enlightened MSR-Bitmap feature implements a PV protocol for L0 and L1
>>>> hypervisors to collaborate and skip unneeded updates to MSR-Bitmap.
>>>> KVM implements the feature for KVM-on-Hyper-V but it seems there was
>>>> a flaw in the implementation and the feature may not be fully functional.
>>>> PATCHes 1-2 fix the problem. The rest of the series implements the same
>>>> feature for Hyper-V-on-KVM.
>>>>
>>>> Vitaly Kuznetsov (5):
>>>>     KVM: SVM: Drop stale comment from
>>>>       svm_hv_vmcb_dirty_nested_enlightenments()
>>>>     KVM: SVM: hyper-v: Enable Enlightened MSR-Bitmap support for real
>>>>     KVM: nSVM: Track whether changes in L0 require MSR bitmap for L2 to be
>>>>       rebuilt
>>>>     KVM: x86: Make kvm_hv_hypercall_enabled() static inline
>>>>     KVM: nSVM: Implement Enlightened MSR-Bitmap feature
>>>>
>>>>    arch/x86/kvm/hyperv.c           | 12 +--------
>>>>    arch/x86/kvm/hyperv.h           |  6 ++++-
>>>>    arch/x86/kvm/svm/nested.c       | 47 ++++++++++++++++++++++++++++-----
>>>>    arch/x86/kvm/svm/svm.c          |  3 ++-
>>>>    arch/x86/kvm/svm/svm.h          | 16 +++++++----
>>>>    arch/x86/kvm/svm/svm_onhyperv.h | 12 +++------
>>>>    6 files changed, 63 insertions(+), 33 deletions(-)
>>>>
>>>
>>> Queued 3-5 now, but it would be nice to have some testcases.
>
> Hmm, it fails to compile with CONFIG_HYPERV disabled, and a trivial
> #if also fails due to an unused goto label.  Does this look good to you?
>

Hm, it does but honestly I did not anticipate this dependency --
CONFIG_HYPERV is needed for KVM-on-Hyper-V but this feature is for
Hyper-V-on-KVM. Let me take a look tomorrow.

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index e3759a79d39a..a2b5267b3e73 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -173,9 +173,16 @@ void recalc_intercepts(struct vcpu_svm *svm)
>    */
>   static bool nested_svm_vmrun_msrpm(struct vcpu_svm *svm)
>   {
> +	int i;
> +
> +	if (!(vmcb12_is_intercept(&svm->nested.ctl, INTERCEPT_MSR_PROT)))
> +		return true;
> +
> +	svm->vmcb->control.msrpm_base_pa = __sme_set(__pa(svm->nested.msrpm));
> +
> +#if IS_ENABLED(CONFIG_HYPERV)
>   	struct hv_enlightenments *hve =
>   		(struct hv_enlightenments *)svm->nested.ctl.reserved_sw;
> -	int i;
>   
>   	/*
>   	 * MSR bitmap update can be skipped when:
> @@ -185,10 +192,8 @@ static bool nested_svm_vmrun_msrpm(struct vcpu_svm *svm)
>   	    kvm_hv_hypercall_enabled(&svm->vcpu) &&
>   	    hve->hv_enlightenments_control.msr_bitmap &&
>   	    (svm->nested.ctl.clean & VMCB_HV_NESTED_ENLIGHTENMENTS))
> -		goto set_msrpm_base_pa;
> -
> -	if (!(vmcb12_is_intercept(&svm->nested.ctl, INTERCEPT_MSR_PROT)))
>   		return true;
> +#endif
>   
>   	for (i = 0; i < MSRPM_OFFSETS; i++) {
>   		u32 value, p;
> @@ -213,10 +216,6 @@ static bool nested_svm_vmrun_msrpm(struct vcpu_svm *svm)
>   	}
>   
>   	svm->nested.force_msr_bitmap_recalc = false;
> -
> -set_msrpm_base_pa:
> -	svm->vmcb->control.msrpm_base_pa = __sme_set(__pa(svm->nested.msrpm));
> -
>   	return true;
>   }
>   
>
>
> Thanks,
>
> Paolo
>

-- 
Vitaly

