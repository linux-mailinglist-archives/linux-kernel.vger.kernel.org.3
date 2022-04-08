Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3944F9BCA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 19:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238213AbiDHRhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 13:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238217AbiDHRg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 13:36:58 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CF557B10
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 10:34:54 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id e71so1790513ybf.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 10:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jd42eljeoA7am6iun/EUSb1/8DBUsy7OfKLkpCfQnwI=;
        b=LCmXkljF/PTt+d5imunqFnne5A0MjGLtTl1xSjGaE0A5FsH+fLknxoJFEWyEWwjgnO
         /4HSeVhdLNK52NjIYtcP/h0qXSOrEpVM1ysII5gkbbxdG8ideLw0TrAkHoOBPZHeXKus
         pR1pnrTNIOXO7xPIapV0Hfy2GnHgaRnrhr/wMG1hReEJkvPiChzVc9gzgb7Puz3MRNQm
         3Cjzu8TaYow5v5QZ/JnvRso6K2M3Uxvgb0yEdEGOV2jEYUdG0tmFsttOJKlVR4P9HgrQ
         cCZz469HW8rEd5ZXwyQ0P7kgBAUurURAbHxE4ZXbZ9yCYeBKNtze6BsUx4OieqJLGnX4
         8p0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jd42eljeoA7am6iun/EUSb1/8DBUsy7OfKLkpCfQnwI=;
        b=YrlwbDq60Cir7cSaPchHSx38/YQTfu8pXu48OqGLa/5/HQA75QIEbRwuYUsYBrL+Iq
         4PWO9CaBJCaGighXvTCsrog5KbljO6zC8ZR6+E21l1i5NmqRUSqBwUfy4eiBay/EDvuO
         X5FaiXnzRNMOOSaU2BvC8DcCVVHUOdpI4LHjgv3qbCUdA6/Pys0oxOfaXrs7zOgfP3Ec
         H6CK7oSza2zh5IkYDqNDyhOWQnaWgyJdLg+U0GeLoAAaoPaBJaD4brSgRXuMq8QhVpGR
         70wsS9PoEZmMIm1cqxgXIl5UZHWr9kRiKpY4HN7mY+JygsCyUjIdc8hVGB9hP6P6A+5A
         +7TQ==
X-Gm-Message-State: AOAM532nk6WEkP0F2XY+n/VqLxO8LFY3+onxI7lvz9BgBI7lBzRmi92v
        msIKvFmh9C9SHS8xTl7WZ+/0yHC9e/Pd0QvoFwbVOA==
X-Google-Smtp-Source: ABdhPJyJF/Vu21u1Ybk49qtraB/Ha/OoaBBpU4AzP6a6DQvrKFHEfKt9PFNVhB8Y0En5o6Xn94X9VMasp0/Xh92pKhg=
X-Received: by 2002:a25:dfc4:0:b0:63d:b28e:93ec with SMTP id
 w187-20020a25dfc4000000b0063db28e93ecmr15429921ybg.474.1649439293125; Fri, 08
 Apr 2022 10:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220407011605.1966778-1-rananta@google.com> <20220407011605.1966778-3-rananta@google.com>
 <87ilrlb6un.wl-maz@kernel.org> <CAJHc60yFD=osoifUpB4LBNo93eVq9zNV41bnu7uBZ0HsBGbMeA@mail.gmail.com>
 <87v8vj1pfl.wl-maz@kernel.org>
In-Reply-To: <87v8vj1pfl.wl-maz@kernel.org>
From:   Raghavendra Rao Ananta <rananta@google.com>
Date:   Fri, 8 Apr 2022 10:34:42 -0700
Message-ID: <CAJHc60wwXyC=cgpBHf4XXcpvuN=+HW2hjiOX+NidQ2euRHb-qg@mail.gmail.com>
Subject: Re: [PATCH v5 02/10] KVM: arm64: Setup a framework for hypercall
 bitmap firmware registers
To:     Marc Zyngier <maz@kernel.org>
Cc:     Andrew Jones <drjones@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 8, 2022 at 9:59 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 07 Apr 2022 18:24:14 +0100,
> Raghavendra Rao Ananta <rananta@google.com> wrote:
> >
> > Hi Marc,
> >
> > > > +#define KVM_REG_ARM_STD_BIT_TRNG_V1_0                BIT(0)
> > >
> > > I'm really in two minds about this. Having one bit per service is easy
> > > from an implementation perspective, but is also means that this
> > > disallow fine grained control over which hypercalls are actually
> > > available. If tomorrow TRNG 1.1 adds a new hypercall and that KVM
> > > implements both, how does the selection mechanism works? You will
> > > need a version selector (a la PSCI), which defeats this API somehow
> > > (and renders the name of the #define invalid).
> > >
> > > I wonder if a more correct way to look at this is to enumerate the
> > > hypercalls themselves (all 5 of them), though coming up with an
> > > encoding is tricky (RNG32 and RNG64 would clash, for example).
> > >
> > > Thoughts?
> > >
> > I was on the fence about this too. The TRNG spec (ARM DEN 0098,
> > Table-4) mentions that v1.0 should have VERSION, FEATURES, GET_UUID,
> > and RND as mandatory features. Hence, if KVM advertised that it
> > supports TRNG v1.0, I thought it would be best to expose all or
> > nothing of v1.0 by guarding them with a single bit.
> > Broadly, the idea is to have a bit per version. If v1.1 comes along,
> > we can have another bit for that. If it's not too ugly to implement,
> > we can be a little more aggressive and ensure that userspace doesn't
> > enable v1.1 without enabling v1.0.
>
> OK, that'd be assuming that we'll never see a service where version A
> is incompatible with version B and that we have to exclude one or the
> other. Meh. Let's cross that bridge once it is actually built.
>
> [...]
>
> > > > +     mutex_lock(&kvm->lock);
> > > > +
> > > > +     /*
> > > > +      * If the VM (any vCPU) has already started running, return success
> > > > +      * if there's no change in the value. Else, return -EBUSY.
> > >
> > > No, this should *always* fail if a vcpu has started. Otherwise, you
> > > start allowing hard to spot races.
> > >
> > The idea came from the fact that userspace could spawn multiple
> > threads to configure the vCPU registers. Since we don't have the
> > VM-scoped registers yet, it may be possible that userspace has issued
> > a KVM_RUN on one of the vCPU, while the others are lagging behind and
> > still configuring the registers. The slower threads may see -EBUSY and
> > could panic. But if you feel that it's an overkill and the userspace
> > should deal with it, we can return EBUSY for all writes after KVM_RUN.
>
> I'd rather have that. There already is stuff that rely on things not
> changing once a vcpu has run, so I'd rather be consistent.
>
Sure, I'll return EBUSY if the VM has started regardless of the incoming value.
> >
> > > > +      */
> > > > +     if (test_bit(KVM_ARCH_FLAG_HAS_RAN_ONCE, &kvm->arch.flags)) {
> > > > +             ret = *fw_reg_bmap != val ? -EBUSY : 0;
> > > > +             goto out;
> > > > +     }
> > > > +
> > > > +     WRITE_ONCE(*fw_reg_bmap, val);
> > >
> > > I'm not sure what this WRITE_ONCE guards against. Do you expect
> > > concurrent reads at this stage?
> > >
> > Again, the assumption here is that userspace could have multiple
> > threads reading and writing to these registers. Without the VM scoped
> > registers in place, we may end up with a read/write to the same memory
> > location for all the vCPUs.
>
> We only have one vcpu updating this at any given time (that's what the
> lock ensures). A simple write should be OK, as far as I can tell.
>
I agree that a write against another write should be fine without the
WRITE_ONCE. But my little concern was this write against a read
(unsure how userspace accesses these registers). I'm guessing it
shouldn't hurt to keep them in place, no? :)

Regards,
Raghavendra

> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
