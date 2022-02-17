Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46E24B9796
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 05:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbiBQEQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 23:16:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbiBQEQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 23:16:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E32363EF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 20:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645071403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uvgra8lQGgOpBqMk4pMXRXiHA0fHA6JUJqFHkqjemnY=;
        b=AZZPb3BFEkYcjAStsAO7sYjDPQz6ihcaO6tazV6D4XY7bPN3XyUk/Z3QWrj6eFHUTHMGt/
        JrF/gK7qU2OEUD3rLpqdlC6sQ4h10A6U65jHkhA89+EbFygCpywFF0HkH0NsiEN6QMyG3U
        6Qj7p+YL2sDlXVCTULXtwJpy1QaFu4o=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-151-28CAQ78sO8ORsANRBrLt0w-1; Wed, 16 Feb 2022 23:16:42 -0500
X-MC-Unique: 28CAQ78sO8ORsANRBrLt0w-1
Received: by mail-lj1-f198.google.com with SMTP id s20-20020a2eb8d4000000b00244c0c07f5aso1762168ljp.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 20:16:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uvgra8lQGgOpBqMk4pMXRXiHA0fHA6JUJqFHkqjemnY=;
        b=HLgZ6rTGl9u7Mc69SzQ4ZcoJXtcK49H53MLNJ4WaDmuJ5gtNHk2aKR/d0kiWDF6vxw
         xJ/jE4NFIGd/OoUXY3Jd9MlTESjMdZ7FfyOYq9fVafQWhdvOKOf3wybmKXDzXyDG5PEk
         YGiB8y1zVkNV8okA4xCMldKOUHuUzmbFhx1vMDXsKqTZQsITdnFDq/Dz54aYHOFxBPkm
         rsZzVMZhfvzQyBLwE3ySkxFWz+5S8Ie4/b+eL/Qhqc2l74WgqfgOlTkG/LyP8CLbtcGJ
         gkLD9F68NMbeVUiHMmCi4Mq0T4+pMS9Xt1zwibCi15Y8DEPtLZpQxN6DUVjOViwaE1Hs
         6t8w==
X-Gm-Message-State: AOAM530RK7vboqoDoVBz3GqDL5HhsIZFiDEGQqD9CANbZJzsVfw2pSZm
        /dw11bEN6yDNA402zw6oKpwdtppGLyMPGoYeWhSxj5iEwTcEXrF0J1tYVj70YH4EKKik0QSrv5O
        NmI18V8eeDdfTkvqwaijpWNyYmL7q2Rnd76GxB/a+
X-Received: by 2002:a05:6512:3188:b0:439:a8c3:4102 with SMTP id i8-20020a056512318800b00439a8c34102mr822543lfe.17.1645071400555;
        Wed, 16 Feb 2022 20:16:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzVelNsYA1A7fOpSCi3Bz5QAUA9WO8Oz90QOPtUPRfGO3tmlM+CPe3K9G10eRjkWeyU78T6AAgIl2FdxPOb6sg=
X-Received: by 2002:a05:6512:3188:b0:439:a8c3:4102 with SMTP id
 i8-20020a056512318800b00439a8c34102mr822532lfe.17.1645071400307; Wed, 16 Feb
 2022 20:16:40 -0800 (PST)
MIME-Version: 1.0
References: <20220211060742.34083-1-leobras@redhat.com> <5fd84e2f-8ebc-9a4c-64bf-8d6a2c146629@redhat.com>
 <cunsfslpyvh.fsf@oracle.com> <6bee793c-f7fc-2ede-0405-7a5d7968b175@redhat.com>
 <CAJ6HWG6RB6NS8vx0vWdgRhO54B+NqHyBvpg7dRjd_78TRnJ9eg@mail.gmail.com> <9b1d925c-1e6a-8a06-ada5-941adb5b349f@redhat.com>
In-Reply-To: <9b1d925c-1e6a-8a06-ada5-941adb5b349f@redhat.com>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Thu, 17 Feb 2022 01:16:29 -0300
Message-ID: <CAJ6HWG6ANQb_qGcMMjzHfov5SxTJ+__m5QCdFoYvbMPJxu2Jbw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] x86/kvm/fpu: Mask guest fpstate->xfeatures with guest_supported_xcr0
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     David Edmondson <david.edmondson@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Yang Zhong <yang.zhong@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 8:45 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 2/16/22 08:48, Leonardo Bras Soares Passos wrote:
> > On Mon, Feb 14, 2022 at 6:56 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> >> On top of this patch, we can even replace vcpu->arch.guest_supported_xcr0
> >> with vcpu->arch.guest_fpu.fpstate->user_xfeatures. Probably with local
> >> variables or wrapper functions though, so as to keep the code readable.
> >
> > You mean another patch (#2) removing guest_supported_xcr0 field from
> > kvm_vcpu_arch ?
> > (and introducing something like kvm_guest_supported_xcr() ?)
>
> Yes, introducing both kvm_guest_supported_xcr0() that just reads
> user_xfeatures, and kvm_guest_supported_xfd() as below.

Oh, I see. Thanks for clearing that up!

>
> >> For example:
> >>
> >> static inline u64 kvm_guest_supported_xfd()
> >> {
> >>          u64 guest_supported_xcr0 = vcpu->arch.guest_fpu.fpstate->user_xfeatures;
> >>
> >>          return guest_supported_xcr0 & XFEATURE_MASK_USER_DYNAMIC;
> >> }
> >
> > Not sure If I get the above.
> > Are you suggesting also removing fpstate->xfd and use a wrapper instead?
> > Or is the above just an example?
> > (s/xfd/xcr0/ & s/XFEATURE_MASK_USER_DYNAMIC/XFEATURE_MASK_USER_SUPPORTED/ )
>
> The above is an example of how even "indirect" uses as
> guest_supported_xcr0 can be changed to a function.
>
> >> Also, already in this patch fpstate_realloc should do
> >>
> >>           newfps->user_xfeatures = curfps->user_xfeatures | xfeatures;
> >>
> >> only if !guest_fpu.  In other words, the user_xfeatures of the guest FPU
> >> should be controlled exclusively by KVM_SET_CPUID2.
> >
> > Just to check, you suggest adding this on patch #2 ?
> > (I am failing to see how would that impact on #1)
>
> In patch 1.  Since KVM_SET_CPUID2 now changes newfps->user_xfeatures, it
> should be the only place where it's changed, and arch_prctl() should not
> change it anymore.
>
> Paolo
>

Oh, yeah, that makes sense to me. Thanks for pointing that out!
I will send a v4 shortly.

Best regards,
Leo

