Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A905579F7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbiFWMGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 08:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbiFWMGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:06:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1DA74BFE1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 05:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655985960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XKkAbvg7nHOQsYMknh4bOR0Tp8ylYr8DS/cIYJGH8eE=;
        b=AxpUe+oHia83l2DZPWDrgo5YimAhnBN9DWF06QZClKTTh3PPSk9gZLhIA3gpiWIeyAKdDy
        BEvgW3b1Ner2y2zCkJUEk0z2sKeUK54FoxXCHh7iFogaYvM70aULXPk4hWrNJ/hAq+WZWv
        n/Cr6ch5/MhOjYO2nFsOmqtrOn8bX/A=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216-0p17QeJ1Nn2CC9mxVzmSgg-1; Thu, 23 Jun 2022 08:05:59 -0400
X-MC-Unique: 0p17QeJ1Nn2CC9mxVzmSgg-1
Received: by mail-ed1-f71.google.com with SMTP id z20-20020a05640235d400b0042dfc1c0e80so15563806edc.21
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 05:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=XKkAbvg7nHOQsYMknh4bOR0Tp8ylYr8DS/cIYJGH8eE=;
        b=IaJvmV/g1AutxoqCYyJdBEyRLcuphrXuQl0vbEUA/RZA/AHleSomGDDBf7x4NGsIvH
         T26upt/ZZFdBXO3+DN6/r4HpgmMe1UU8AWMiPd8bBrpVNan8eMkNY7YDyvH8MCnAOW+a
         52QQXGwUnp5SIo6UiHMqN2Vf5/iO90N7ezbHM4ysagpvjHpXq5LQKjM1k4kGKKMSG0kg
         i8CzowVgJYlOix8cqZn4bh4eav1kVFM0/BBx4VnEgWZI+IbtdeIo02EY2gHV7vhRvqdi
         /Bvcf31PCxWhW8UljYu4SLjpm2l/10WvjxEaup3O1zLj78cR68Jyzx1Z11JZuZr/cc1E
         8Xzg==
X-Gm-Message-State: AJIora+EPY2xoFoixedd+eyZhDWLGdr5bvTp9D833g82khVdS1iKtKep
        lbTBTxi9ZZumFf+aldHu5ir0AIjzLCpG+bfhWTQuPcvNdsXECVM9qtT2Fp119phK1Bzi75V52cY
        E0bPwz8YJ/KLCiwsme1uVy7/I
X-Received: by 2002:a17:906:5253:b0:711:ee52:764e with SMTP id y19-20020a170906525300b00711ee52764emr7736810ejm.171.1655985958429;
        Thu, 23 Jun 2022 05:05:58 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u4asV0Pu86jIee+oQLYqnLC3peuzDjqrfGcjdfItSZSz687eqRvEoj9T3qd0dntTCJPN3QzQ==
X-Received: by 2002:a17:906:5253:b0:711:ee52:764e with SMTP id y19-20020a170906525300b00711ee52764emr7736782ejm.171.1655985958209;
        Thu, 23 Jun 2022 05:05:58 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id fy11-20020a1709069f0b00b007104b37aab7sm10244396ejc.106.2022.06.23.05.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 05:05:57 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] MAINTAINERS: Reorganize KVM/x86 maintainership
In-Reply-To: <20220623114615.2600316-1-pbonzini@redhat.com>
References: <20220623114615.2600316-1-pbonzini@redhat.com>
Date:   Thu, 23 Jun 2022 14:05:56 +0200
Message-ID: <878rpny47v.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> For the last few years I have been the sole maintainer of KVM, albeit
> getting serious help from all the people who have reviewed hundreds of
> patches.  The volume of KVM x86 alone has gotten to the point where one
> maintainer is not enough; especially if that maintainer is not doing it
> full time and if they want to keep up with the evolution of ARM64 and
> RISC-V at both the architecture and the hypervisor level.
>
> So, this patch is the first step in restoring double maintainership
> or even transitioning to the submaintainer model of other architectures.
>
> The changes here were mostly proposed by Sean offlist and they are twofold:
>
> - revisiting the set of KVM x86 reviewers.  It's important to have an
>   an accurate list of people that are actively reviewing patches ("R"),
>   as well as people that are able to act on bug reports ("M").  Otherwise,
>   voids to be filled are not easily visible.  The proposal is to split
>   KVM on Hyper-V, which is where Vitaly has been the main contributor
>   for quite some time now; likewise for KVM paravirt support, which
>   has been the main interest of Wanpeng.  Jim and Joerg have not been
>   particularly active (though Joerg has worked on guest support for AMD
>   SEV); knowing them a bit, I can't imagine they would object to their
>   removal or even be surprised, but please speak up if you do.
>
> - promoting Sean to maintainer for KVM x86 host support.  While for
>   now this changes little, let's treat it as a harbinger for future
>   changes.  The plan is that I would keep the final integration testing
>   for quite some time, and probably focus more on -rc work.  This will
>   give me more time to clean up my ad hoc setup and moving towards a
>   more public CI, with Sean focusing instead on next-release patches,
>   and the testing up to where kvm-unit-tests and selftests pass.  In
>   order to facilitate collaboration between Sean and myself, we'll
>   also formalize a bit more the various branches of kvm.git.
>
> Nothing is going to change with respect to handling pull requests to Linus
> and from other architectures, as well as maintainance of the generic code
> (which I expect and hope to be more important as architectures try to
> share more code) and documentation.  However, it's not a coincidence
> that my entry is now the last for x86, ready to be demoted to reviewer
> if/when the right time comes.
>
> (Man, this commit message sounds emotional).
>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Cc: kvm@vger.kernel.org
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Wanpeng Li <wanpengli@tencent.com>
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  MAINTAINERS | 37 ++++++++++++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 9 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 97014ae3e5ed..3f7c485195d9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10897,28 +10897,47 @@ F:	tools/testing/selftests/kvm/*/s390x/
>  F:	tools/testing/selftests/kvm/s390x/
>  
>  KERNEL VIRTUAL MACHINE FOR X86 (KVM/x86)
> +M:	Sean Christopherson <seanjc@google.com>
>  M:	Paolo Bonzini <pbonzini@redhat.com>
> -R:	Sean Christopherson <seanjc@google.com>
> -R:	Vitaly Kuznetsov <vkuznets@redhat.com>
> -R:	Wanpeng Li <wanpengli@tencent.com>
> -R:	Jim Mattson <jmattson@google.com>
> -R:	Joerg Roedel <joro@8bytes.org>
>  L:	kvm@vger.kernel.org
>  S:	Supported
> -W:	http://www.linux-kvm.org
>  T:	git git://git.kernel.org/pub/scm/virt/kvm/kvm.git
>  F:	arch/x86/include/asm/kvm*
> -F:	arch/x86/include/asm/pvclock-abi.h
>  F:	arch/x86/include/asm/svm.h
>  F:	arch/x86/include/asm/vmx*.h
>  F:	arch/x86/include/uapi/asm/kvm*
>  F:	arch/x86/include/uapi/asm/svm.h
>  F:	arch/x86/include/uapi/asm/vmx.h
> -F:	arch/x86/kernel/kvm.c
> -F:	arch/x86/kernel/kvmclock.c
>  F:	arch/x86/kvm/
>  F:	arch/x86/kvm/*/
>  
> +KVM PARAVIRT (KVM/paravirt)
> +M:	Paolo Bonzini <pbonzini@redhat.com>
> +R:	Wanpeng Li <wanpengli@tencent.com>
> +L:	kvm@vger.kernel.org
> +S:	Supported
> +T:	git git://git.kernel.org/pub/scm/virt/kvm/kvm.git
> +F:	arch/x86/kernel/kvm.c
> +F:	arch/x86/kernel/kvmclock.c
> +F:	arch/x86/include/asm/pvclock-abi.h
> +F:	include/linux/kvm_para.h
> +F:	include/uapi/linux/kvm_para.h
> +F:	include/uapi/asm-generic/kvm_para.h
> +F:	include/asm-generic/kvm_para.h
> +F:	arch/um/include/asm/kvm_para.h
> +F:	arch/x86/include/asm/kvm_para.h
> +F:	arch/x86/include/uapi/asm/kvm_para.h

If we add Async PF to the 'KVM/paravirt' scope:

+F:   virt/kvm/async_pf.c
and maybe even
+F:   arch/x86/kvm/x86.c

then I can probably volunteer as a reviewer.

> +
> +KVM X86 HYPER-V (KVM/hyper-v)
> +M:	Vitaly Kuznetsov <vkuznets@redhat.com>
> +M:	Sean Christopherson <seanjc@google.com>
> +M:	Paolo Bonzini <pbonzini@redhat.com>

Don't we also need:

S:   Supported
L:   kvm@vger.kernel.org

here?

> +T:	git git://git.kernel.org/pub/scm/virt/kvm/kvm.git
> +F:	arch/x86/kvm/hyperv.*
> +F:	arch/x86/kvm/kvm_onhyperv.*
> +F:	arch/x86/kvm/svm/svm_onhyperv.*

+F:   arch/x86/kvm/svm/hyperv.*

> +F:	arch/x86/kvm/vmx/evmcs.*
> +
>  KERNFS
>  M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>  M:	Tejun Heo <tj@kernel.org>

-- 
Vitaly

