Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565F54BA7CB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244097AbiBQSJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:09:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244023AbiBQSJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:09:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82FA915DDFC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 10:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645121323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kdCG/BqRA3h3SSjWYFY12VvohzTJC0/2p0AbBe0FxJA=;
        b=MLWxHYb0jUPyZmWayLKEHpH3D9tfrxgucyVl6XWkftXOlVAEqREVFpoPUrteYVqv+0AJFd
        vvtuTYFYmeJTBFrssgeJwCIaD1ooKLwwQh7zmiOrF/riEO9VxiC59DdkvXtVDLEPgTOd9a
        VCK240AuohjbX6bzcY0xCFDs96R8pFA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-gc2d0nn-PXy4zTtSteF8Bw-1; Thu, 17 Feb 2022 13:08:42 -0500
X-MC-Unique: gc2d0nn-PXy4zTtSteF8Bw-1
Received: by mail-lj1-f199.google.com with SMTP id b27-20020a2ebc1b000000b00246209c497dso187081ljf.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 10:08:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kdCG/BqRA3h3SSjWYFY12VvohzTJC0/2p0AbBe0FxJA=;
        b=GOoqvERKeqA5PCjxEScro2ENyLCMwOCLCkyOYE1q2/tzohIrmOC7a1OaqFtdAOM60Y
         DERZtZgBOxT0j6EUfljYgCbebpwQQXpXhvewvEKVzirsLX7hj2DJxxK5hvNQmq3+pHjR
         McUm33NS0a1xcsDrt1xyunqO6vZB1OeCTuDoT7tQQ6l5+C/EedPQKMcjsIg6io8CDWv1
         +wWMakOgv5VxGjjX5TXyJul/5zbTl2nHqrtjJDJpUqsnlHy2YHyqpip2I3tQlOH/Jm+L
         sU9qBgK48h1JaTzMS2NjzW8m5KtBUNcOkJfQu5LVwZE5lPec+MfLkiB7eznTmQhUJVNy
         0YtA==
X-Gm-Message-State: AOAM533n5QsKpb18+vtcYTXLP4ws8X9MngGcShj8Hs17d7OEw7ajzIdU
        3Jj2n8qsx+zIgcNv+mOPewgjg893lVP6y7HTZW2LXPK2QwlhqSrNn7IsZWxMSgNmDr7Jb2LXEuR
        nRdAYNzQIXwvlK7+peGIqmsVu0kvLMZShtFKQHyac
X-Received: by 2002:a05:6512:3d90:b0:437:73cb:8e76 with SMTP id k16-20020a0565123d9000b0043773cb8e76mr2969490lfv.187.1645121320970;
        Thu, 17 Feb 2022 10:08:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzChZlQY5QTvjHbE0p1UCY0dO09MQJLQKaTJOmCopXmMEEUgU0MgdXhF+IltPwII3QUm9GQahgHm2UTwnG0wkw=
X-Received: by 2002:a05:6512:3d90:b0:437:73cb:8e76 with SMTP id
 k16-20020a0565123d9000b0043773cb8e76mr2969460lfv.187.1645121320667; Thu, 17
 Feb 2022 10:08:40 -0800 (PST)
MIME-Version: 1.0
References: <20220217053028.96432-1-leobras@redhat.com> <087309d0-f39c-d5d0-2b6a-2dd8595b06ea@redhat.com>
In-Reply-To: <087309d0-f39c-d5d0-2b6a-2dd8595b06ea@redhat.com>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Thu, 17 Feb 2022 15:08:29 -0300
Message-ID: <CAJ6HWG66HZ7raAa+YK0UOGLF+4O3JnzbZ+a-0j8GNixOhLk9dA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] x86/kvm/fpu: Fix guest migration bugs that can
 crash guest
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        David Gilbert <dgilbert@redhat.com>,
        Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, Feb 17, 2022 at 11:52 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 2/17/22 06:30, Leonardo Bras wrote:
> > This patchset comes from a bug I found during qemu guest migration from a
> > host with newer CPU to a host with an older version of this CPU, and thus
> > having less FPU features.
> >
> > When the guests were created, the one with less features is used as
> > config, so migration is possible.
> >
> > Patch 1 fix a bug that always happens during this migration, and is
> > related to the fact that xsave saves all feature flags, but xrstor does
> > not touch the PKRU flag. It also changes how fpstate->user_xfeatures
> > is set, going from kvm_check_cpuid() to the later called
> > kvm_vcpu_after_set_cpuid().
> >
> > Patch 2 removes kvm_vcpu_arch.guest_supported_xcr0 since it now
> > duplicates guest_fpu.fpstate->user_xfeatures. Some wrappers were
> > introduced in order to make it easier to read the replaced version.
> >
> > Patches were compile-tested, and could fix the bug found.
>
> Queued, thanks (for 5.17 of course)!  For patch 2, I renamed the
> function to kvm_guest_supported_xcr0.
>
> Paolo
>

That's great!
Thanks Paolo!

