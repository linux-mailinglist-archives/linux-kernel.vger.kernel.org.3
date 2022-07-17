Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA085777DE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 21:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiGQTCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 15:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGQTCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 15:02:13 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5041120B6
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 12:02:12 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l68so5976926wml.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 12:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lk12/tpXTVU6up0Wt2/X99tShnjn+1oi0pbFBCCHdiY=;
        b=k8dg2dnozSZK58gGe/uYCFWyHCllyYsYNtTj3/11ajimjpONsm4zkGbvrfalM1N2Xd
         XAJEGHQOOW3s4iTeVPmiAjaauCx+bZIZgyrEn4MTcttTNr4WaGgh1+YTb4/S/d86/oX5
         vvt6eQDKQQdgin/SnREFbe4yxGZh/FqwaCFJPiyJTJtVDCHvxD7KkNdkdCAUxN0DXdgp
         NuFnc+a6h8yImF6GsoVa620DgsaA2rNGi3X9ibQTl6zd5TOWG+t4uEcSCmpxDThwp92J
         6B+weZuVGIcFloTQoamwsXUcezI917Z+Jx2/L+gTlwhC82fsj6cv1CeN0ISYNLVx3Uk4
         b6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lk12/tpXTVU6up0Wt2/X99tShnjn+1oi0pbFBCCHdiY=;
        b=k5AqVY0Pwaav2zLRLcyM3Zoo1BF77VTJmLnezjHt1ZG4JiOLKen+RHdCo+ddcdLMpR
         Sy20/OfJTdU3hnmzx+J9+6kQR1eeLQazg5Q80Xe4Ahi6dV72XGWf1pIXOjCU5D5lPISs
         dAaIQ8oERuuxMotqPo6CNiLS4aC8WU+duMg7reAxGHH4WCjGpBVj0vBhAC8yp2zSD43A
         T8nDAGdISeTM538vcGFNd/DSIhJP+9AzX+6jPKU+fQIwVsuKh14qejrFmP3ECtt+SEaD
         HvAZg7qyGZFe3APLHVrcCUv6aMNJr1YbEZpGb9uX58Dw6jwvktFWQBv4y6+bG6aWuPVO
         VIhg==
X-Gm-Message-State: AJIora/FXdKQiOjiUroe8Nbp7pao/LevNuy1Lu32f2IJek47oK/0NGsO
        cmRiM63v2BhlcwJECcD1CcDHNxHQdSlF+mzUDM3i6A==
X-Google-Smtp-Source: AGRyM1txM6jdFQSAihKOCcCQ02JZOMHBF4S9utIUHEL5wAa8Yd7D1Z3rq2vr36XdQB1ibThKxK+VFG5OnZx+sJbPO7A=
X-Received: by 2002:a05:600c:4eca:b0:3a1:9c39:ac20 with SMTP id
 g10-20020a05600c4eca00b003a19c39ac20mr29653002wmq.61.1658084531022; Sun, 17
 Jul 2022 12:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220715235824.2549012-1-kaleshsingh@google.com> <87zgh8yq7q.wl-maz@kernel.org>
In-Reply-To: <87zgh8yq7q.wl-maz@kernel.org>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Sun, 17 Jul 2022 12:02:00 -0700
Message-ID: <CAC_TJveFHh1ykT0ctZC7zK_6rwNSgMe+242h_aVZ_48GD3Xtaw@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: Fix hypervisor address symbolization
To:     Marc Zyngier <maz@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Fuad Tabba <tabba@google.com>, Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>, android-mm@google.com,
        "Cc: Android Kernel" <kernel-team@android.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2022 at 3:43 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sat, 16 Jul 2022 00:58:24 +0100,
> Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > With CONFIG_RANDOMIZE_BASE=y vmlinux addresses will resolve correctly
>
> I guess you mean *incorrectly* here, right?

Yes, sorry. "INcorrectly" I meant to say.

>
> > from kallsyms. Fix this by adding the KASLR offset before printing the
> > symbols.
> >
> > Based on arm64 for-next/stacktrace.
>
> In general, place these remarks after the '---' line, as they don't
> really make sense in the commit itself (which is likely to be merged
> on a different base anyway).
>
> >
> > Fixes: 6ccf9cb557bd ("KVM: arm64: Symbolize the nVHE HYP addresses")
> > Reported-by: Fuad Tabba <tabba@google.com>
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >  arch/arm64/kvm/handle_exit.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> > index f66c0142b335..e43926ef2bc2 100644
> > --- a/arch/arm64/kvm/handle_exit.c
> > +++ b/arch/arm64/kvm/handle_exit.c
> > @@ -347,10 +347,10 @@ void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr,
> >                       kvm_err("nVHE hyp BUG at: %s:%u!\n", file, line);
> >               else
> >                       kvm_err("nVHE hyp BUG at: [<%016llx>] %pB!\n", panic_addr,
> > -                                     (void *)panic_addr);
> > +                                     (void *)(panic_addr + kaslr_offset()));
> >       } else {
> >               kvm_err("nVHE hyp panic at: [<%016llx>] %pB!\n", panic_addr,
> > -                             (void *)panic_addr);
> > +                             (void *)(panic_addr + kaslr_offset()));
> >       }
> >
> >       /*
> >
>
> I'll fix the above as I apply the patch, no need to respin.

Thanks Marc.

-- Kalesh

>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
