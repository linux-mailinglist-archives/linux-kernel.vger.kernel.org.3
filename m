Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4431A5076B0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355979AbiDSRky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243229AbiDSRkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:40:52 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F37227CCB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:38:09 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m14so23433299wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Hcnu+Y1xvTQT/d8TtH/DkfZU528Zec6EC6l/WHUGtw=;
        b=CIQjN/Q+4uhjvLGUdKIpDCetpFRAAL1b0jKxHI6pNWCWGj6uodyebfvqMYTJH9JHXZ
         REqxLvl8ztnJYis9WD5FWWeEhOcyDAQQLn1SHMd8KmuTQDoR0imYRPzXRHhWqrmbNH1S
         QyrafESTkKiLUc57QNe1bvNaiDLi5rMGQl1aBjzi1Lqq9xiIXyRoInIF9/N3XLQGtL6+
         3DAfFDiRIZYwqyq8olQkz3ucGHnwIV7yAF8ne+XvwiDO7pTHxn9NC2KIea7xtpNuUzhj
         BPOnr2fxwdBodOYuwTPaW8gRvxdvu9PA2Pn5ijwjgwpAKqtIus+L19F9dim0h2U+bXsp
         sWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Hcnu+Y1xvTQT/d8TtH/DkfZU528Zec6EC6l/WHUGtw=;
        b=z+gdKF3/BKxKLnaPqxhJFjXXwD9pIOLekyu/YxzXrETq41drRqhfym+FbEZbfmYT8K
         BVhyILUaDgfe7KOzcvQIBwYHxIoR6ahOxv/7/J+POZlf6ssLlVppddIYATOgd7lE0QE/
         XY11mY0ZerqtIlvCeRIQShKmOS3ic6R1GDVBwZV+buRFsFhMZQasaYxe4Kvp9pKmYbrU
         /vb1jgmVR4s2QFv1b8II+GBsJTTDxkhYpQz4qiTQeMwncOlxuNMXgzNxiDeQwv42wEIo
         OITp/Sa3RmzyTjbRvFO1GyGZ1wkTu7pS2VpTYMOqtbX6xitPRuzCKUodfJr3YOly9wkO
         9oUg==
X-Gm-Message-State: AOAM532FDB/kgDXz1xxtDlVorxoh4d0KWF8jBsJiGi7ntscgR8RdKhBH
        2guAWHN978C3+nQ+MMMLB8yh+nxdi0jtYL/9TFtAcw==
X-Google-Smtp-Source: ABdhPJzpHnn5Va+Zva11H7oHeOnzsrgG/lcYPxvwzn3M3FVNvkOV1Y1fDhhCyXgdlAWLhZa4n6At69/woFeeGpnw7nU=
X-Received: by 2002:a5d:42cd:0:b0:207:af3f:79c9 with SMTP id
 t13-20020a5d42cd000000b00207af3f79c9mr12547729wrr.577.1650389887738; Tue, 19
 Apr 2022 10:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220314200148.2695206-1-kaleshsingh@google.com>
 <20220314200148.2695206-8-kaleshsingh@google.com> <CA+EHjTwQRUCjvcMHNe1f0kPBdU=vS+f2+e_eefhnJDR4s73cQA@mail.gmail.com>
 <CAC_TJveNRaDFcQGo9-eqKa3=1DnuVDs4U+ye795VcJ1ozVkMyg@mail.gmail.com> <YlbXHg64HK2d3dgm@FVFF77S0Q05N>
In-Reply-To: <YlbXHg64HK2d3dgm@FVFF77S0Q05N>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Tue, 19 Apr 2022 10:37:56 -0700
Message-ID: <CAC_TJveJYFkHPQLYdL8SCEAwMPgwpF_-ctMqKJ9w=eDa_M0u5w@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] KVM: arm64: Unwind and dump nVHE HYP stacktrace
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Fuad Tabba <tabba@google.com>, Will Deacon <will@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andrew Walbran <qwandor@google.com>,
        Andrew Scull <ascull@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        LKML <linux-kernel@vger.kernel.org>
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

On Wed, Apr 13, 2022 at 6:59 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi Kalesh,
>
> Sorry for the radiosilence.
>
> I see that in v7 you've dropped the stacktrace bits for now; I'm just
> commenting here fot future reference.
>
> On Thu, Mar 31, 2022 at 12:22:05PM -0700, Kalesh Singh wrote:
> > Hi everyone,
> >
> > There has been expressed interest in having hypervisor stack unwinding
> > in production Android builds.
> >
> > The current design targets NVHE_EL2_DEBUG enabled builds and is not
> > suitable for production environments, since this config disables host
> > stage-2 protection on hyp_panic() which breaks security guarantees.
> > The benefit of this approach is that the stack unwinding can happen at
> > EL1 and allows us to reuse most of the unwinding logic from the host
> > kernel unwinder.
> >
> > Proposal for how this can be done without disabling host stage-2 protection:
> >   - The host allocates a "panic_info" page and shares it with the hypervisor.
> >   - On hyp_panic(), the hypervisor can unwind and dump its stack
> > addresses to the shared page.
> >   - The host can read out this information and symbolize these addresses.
> >
> > This would allow for getting hyp stack traces in production while
> > preserving the security model. The downside being that the core
> > unwinding logic would be duplicated at EL2.
> >
> > Are there any objections to making this change?
>
> I'm fine with the concept of splitting the unwind and logging steps; this is
> akin to doing:
>
>         stack_trace_save_tsk(...);
>         ...
>         stack_trace_print(...);
>
> ... and I'm fine with having a stack_trace_save_hyp(...) variant.
>
> However, I would like to ensure that we're reusing logic rather than
> duplicating it wholesale.

Agreed. Although some reimplementation may be unavoidable, as we can't
safely link against kernel code from the protected KVM hypervisor.
Perhaps we can move some of the common logic to a shared header that
can be included in both places (host, hyp), WDYT?

> There are some changes I would like to make to the
> stacktrace code in the near future that might make that a bit easier, e.g.
> reworking the stack transition checks to be table-driven, and factoring out the
> way we handle return trampolines.

Sounds good to me.

Thanks,
Kalesh
>
> I'll Cc you on changes to the stacktrace code. There are some preparatory
> cleanups I'd like to get out of the way first which I'll send shortly.
>
> Thanks,
> Mark.
