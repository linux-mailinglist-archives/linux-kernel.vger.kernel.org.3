Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707F94C7D70
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 23:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiB1Weu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 17:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiB1Wer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:34:47 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAF31110A3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 14:34:08 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id qx21so27737061ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 14:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BNRCF8PYv/Se3Dr3g8bGB7rOq5xJ078NNrz5/g8pVZs=;
        b=dt8e270gTFsMBghtAbbkonO5HxcUHpTucVjLM44I0WLBir1+DS5PcrwF0Bw9+ee9lm
         965+PQ4wRV+mwWDNaGkOQQ5IAxY3Vx4Bshrfw+oOBUTtgx962QizQihbGL3AbIUeBIKm
         L8YqXSasf7TPu/bpERcs89moST2jhYnBb3D5BAOrxVQU5VsdNrPKmNRemkZW7d/EpAG+
         smG9WO/GaHV1ft4HmSsFnMUMWPPRYHJoBcX7Qhw06F6e8YKkPSXe7WYX6i4WpUnaFbF8
         R4D8Zlc99G2ZZtfi0XblTrVgEt3Qtb5hHlnAkZjgSsKYfeCQWF5ERn5NkJj9WxjkLM6K
         h2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BNRCF8PYv/Se3Dr3g8bGB7rOq5xJ078NNrz5/g8pVZs=;
        b=rrQeGZeg0IRwmmhJMDkLv6Vr7Am4yhNjrIANYZJHgLAjvzSjHYVWilxNLt/fSqVHgn
         FNz9zQvwfYXIyDtZbBa56BHYhXKLxkBafaJsvP8mPmuDb4MtvaQk9umU8V5HJtAIQYfy
         q0W89p1AVGlFDD1ozluILkEQyBsPPwVIsYSDOUShPyR9htQCrYcR+XK9GFF2yhKuUsQh
         f1T/3i3Z5EbWed70dMruGUvzRFc58YduvsZCAVLKl9hxm3bBzi9b5f/ShvDWL8pSile5
         Bn9KpOD3dV1SYa6v6r4gB1MLbGYOmuT/UE5dQQvNbwGY/j9/L0ZV98teLF5qm+QTFAP3
         B6Pg==
X-Gm-Message-State: AOAM532nBHMtXRwvLmycGDYIy0zBYDtOWSpIFDkR3f6JW1l2vJ4gD/jn
        bRcTclTjn5dbmLjTkOhXVzVyuAiIsfyEJllAOOggEw==
X-Google-Smtp-Source: ABdhPJwngHlPx9ydRJblMPz4TG+lF6p3K7Ue+OV+Kni8efT/czu0ibYYp8WmkQsyLtrsC2zxud83CjsQy0Xne76qDvw=
X-Received: by 2002:a17:906:d14e:b0:6cd:8d7e:eec9 with SMTP id
 br14-20020a170906d14e00b006cd8d7eeec9mr16860815ejb.28.1646087646642; Mon, 28
 Feb 2022 14:34:06 -0800 (PST)
MIME-Version: 1.0
References: <20220225182248.3812651-1-seanjc@google.com> <20220225182248.3812651-8-seanjc@google.com>
In-Reply-To: <20220225182248.3812651-8-seanjc@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Mon, 28 Feb 2022 14:33:55 -0800
Message-ID: <CANgfPd_zdQAu7m1M_g0wy0wsUpyHDtbE+tUZOKQN59y0ABpvPw@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] KVM: WARN if is_unsync_root() is called on a root
 without a shadow page
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 10:23 AM Sean Christopherson <seanjc@google.com> wrote:
>
> WARN and bail if is_unsync_root() is passed a root for which there is no
> shadow page, i.e. is passed the physical address of one of the special
> roots, which do not have an associated shadow page.  The current usage
> squeaks by without bug reports because neither kvm_mmu_sync_roots() nor
> kvm_mmu_sync_prev_roots() calls the helper with pae_root or pml4_root,
> and 5-level AMD CPUs are not generally available, i.e. no one can coerce
> KVM into calling is_unsync_root() on pml5_root.
>
> Note, this doesn't fix the mess with 5-level nNPT, it just (hopefully)
> prevents KVM from crashing.
>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 825996408465..3e7c8ad5bed9 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3634,6 +3634,14 @@ static bool is_unsync_root(hpa_t root)
>          */
>         smp_rmb();
>         sp = to_shadow_page(root);
> +
> +       /*
> +        * PAE roots (somewhat arbitrarily) aren't backed by shadow pages, the
> +        * PDPTEs for a given PAE root need to be synchronized individually.
> +        */
> +       if (WARN_ON_ONCE(!sp))
> +               return false;
> +

I was trying to figure out if this should be returning true or false,
but neither really seems correct. Since we never expect this to fire,
perhaps it doesn't matter and it's easier to just return false so the
callers don't need to be changed. If this did fire in a production
scenario, I'd want it to terminate the VM too.

>         if (sp->unsync || sp->unsync_children)
>                 return true;
>
> --
> 2.35.1.574.g5d30c73bfb-goog
>
