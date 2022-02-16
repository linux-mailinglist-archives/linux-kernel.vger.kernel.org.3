Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2153A4B8200
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiBPHse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:48:34 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiBPHsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:48:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21588B0A77
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 23:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644997696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yHZYsT5ix1DYMi+Zf0P6MnA53EdR4cjFb5WjbXBThys=;
        b=FZcp3srALKjmoIFOfSL7ik9BKYp3YdzAJ84yBzitjZgjZPfVN6SiJsHSimmiiq8hBmNyLF
        6OdmMZ/uNnCFzwqDMo8Ah77day9wKhBHIeYFXq+8DIuuo3j4OpsdBtxcZletGk1qnGKAZS
        MCq1QU2ml3aQQQG0smq79mNRahLA0Cw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-183-t451dXCzNoWycF3AKgmEmw-1; Wed, 16 Feb 2022 02:48:15 -0500
X-MC-Unique: t451dXCzNoWycF3AKgmEmw-1
Received: by mail-lf1-f71.google.com with SMTP id z24-20020a056512371800b0043ea4caa07cso445974lfr.17
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 23:48:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yHZYsT5ix1DYMi+Zf0P6MnA53EdR4cjFb5WjbXBThys=;
        b=bBtUhu64X23qeNQOOjLzNHXiPQ0CyK/+Sh8u7+40gonTz8E89Xfe+Yt2CtXRLLpr88
         h+e8ijUvBS/FfLOv1ivkbiLqwJ6beIYp9w63wiwAuZiCv/piz433JLxPhSPENAdu5iFC
         mzsvYcUSsfRYdfvCk6y/7tpcyWcY0K/jWbTBnXjOeNmIBqgI5I+1qRJ9GM5kB/MBabR2
         Jd/TNIuATtCdHBN9GuoxOYKDDUna0iQnrYyIHQusj/chEhkTk85zW1CiSJuS06RizZze
         /aBpH2A//VpehZh5nn4OX79dHoaqbAJiLeY7LgQsG7ClUAR/YMd5SuAH5A3houriaI5W
         rSJA==
X-Gm-Message-State: AOAM532UNF/cQZHfWYvxajpL6P/3Gx59zZKHVheW3Z+rZnF7p7uDBq82
        o+ixNpSkKkAnZ9PCRqxALlw6mwqWAazUVWXRNJBZG/weD8rQ9YuJRcmIe7j49ShIAk84ihTJGxB
        BCSXRMYBApnbOol1jRTYBoYu9Tj5W5EGCB43Y5icI
X-Received: by 2002:a19:761a:0:b0:43c:79ae:6aef with SMTP id c26-20020a19761a000000b0043c79ae6aefmr1154798lff.630.1644997693749;
        Tue, 15 Feb 2022 23:48:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzllVwf8xyUIv+2iLLWS6Qj/Jdq4aMgi9FUbytGUO2dDIeLl24XOTc73Yb/RVau2um+auQDQ4sK5y6MgMa7+QY=
X-Received: by 2002:a19:761a:0:b0:43c:79ae:6aef with SMTP id
 c26-20020a19761a000000b0043c79ae6aefmr1154776lff.630.1644997693558; Tue, 15
 Feb 2022 23:48:13 -0800 (PST)
MIME-Version: 1.0
References: <20220211060742.34083-1-leobras@redhat.com> <5fd84e2f-8ebc-9a4c-64bf-8d6a2c146629@redhat.com>
 <cunsfslpyvh.fsf@oracle.com> <6bee793c-f7fc-2ede-0405-7a5d7968b175@redhat.com>
In-Reply-To: <6bee793c-f7fc-2ede-0405-7a5d7968b175@redhat.com>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Wed, 16 Feb 2022 04:48:02 -0300
Message-ID: <CAJ6HWG6RB6NS8vx0vWdgRhO54B+NqHyBvpg7dRjd_78TRnJ9eg@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paolo, thanks for the feedback!

On Mon, Feb 14, 2022 at 6:56 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 2/14/22 10:43, David Edmondson wrote:
> > Sorry if this is a daft question:
> >
> > In what situations will there be bits set in
> > vcpu->arch.guest_supported_xcr0 that are not set in
> > vcpu->arch.guest_fpu.fpstate->xfeatures ?
> >
> > guest_supported_xcr0 is filtered based on supported_xcr0, which I would
> > expect to weed out all bits that are not set in ->xfeatures.
>
> Good point, so we can do just
>
>         vcpu->arch.guest_fpu.fpstate->user_xfeatures =
>                 vcpu->arch.guest_supported_xcr0;

Updated for v4.

>
> On top of this patch, we can even replace vcpu->arch.guest_supported_xcr0
> with vcpu->arch.guest_fpu.fpstate->user_xfeatures. Probably with local
> variables or wrapper functions though, so as to keep the code readable.

You mean another patch (#2) removing guest_supported_xcr0 field from
kvm_vcpu_arch ?
(and introducing something like kvm_guest_supported_xcr() ?)

> For example:
>
> static inline u64 kvm_guest_supported_xfd()
> {
>         u64 guest_supported_xcr0 = vcpu->arch.guest_fpu.fpstate->user_xfeatures;
>
>         return guest_supported_xcr0 & XFEATURE_MASK_USER_DYNAMIC;
> }

Not sure If I get the above.
Are you suggesting also removing fpstate->xfd and use a wrapper instead?
Or is the above just an example?
(s/xfd/xcr0/ & s/XFEATURE_MASK_USER_DYNAMIC/XFEATURE_MASK_USER_SUPPORTED/ )

>
> Also, already in this patch fpstate_realloc should do
>
>          newfps->user_xfeatures = curfps->user_xfeatures | xfeatures;
>
> only if !guest_fpu.  In other words, the user_xfeatures of the guest FPU
> should be controlled exclusively by KVM_SET_CPUID2.

Just to check, you suggest adding this on patch #2 ?
(I am failing to see how would that impact on #1)

>
> Thanks,
>
> Paolo
>

Thank you!

Best regards,
Leo

