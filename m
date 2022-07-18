Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A235B578820
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 19:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbiGRRJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 13:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbiGRRJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 13:09:50 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725A9E004
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 10:09:49 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d16so17980463wrv.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 10:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CRxPlNSYkYSm35uiYRBFTU8crdYHEWHvBXSEXMN6VP0=;
        b=S2DVeNOT5mYNSXmNtSQt8P9HlMZLBPTDBDd+ni5sZowLF+0QEC/n+/AWq2d3wW4Bw0
         2Qhv6901BsJjy13IPdZj3XjlhtH8D15Tf1QG77NZcNsHnyB9oJ+FoSvYg5wDCVsiNDZh
         bohhuB+5hVmf6hWIzXGjgqWtHReIs0YhT1Tjaz8Qz3VEBXpGix49oLjeBlKC7OEINOAo
         CVAPvXOWK8L+nzbll7P3kAACY3HZIbu9MRQaBMhcIrLgnQ33pshR/6nSPiEyOAnmDGwn
         VDxB9VcJ+cl8QvfolToor4LDRPJ+gj1M4cNchuf+fcSXzvsOZrhWzfFNNVsYIgGvh0RS
         b3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CRxPlNSYkYSm35uiYRBFTU8crdYHEWHvBXSEXMN6VP0=;
        b=8D119TKfZNiQTlU5GKZxiz/XhFageSV5cCzwAd2n1pPr2CKUz3sEnMPuaDPu4CRdMH
         +vyWUG6QdRlS5lElq0UGK3brtCUF2IoAkeWIpYDAEzqX5yO/SCUuB8h+/tiLSCsAJQP/
         +XPgl+nIyL1BmCYxpvqYnPqgDh7DI670xDMne2ZZGndIYOk29tFwIsatCEIuntXTuzKe
         dye6N5p3/viI30ZOIT7Sd/ugIaodE5kMNm4XkwPIBmIbdhV1DD3t5/3cnwnWm/B9hTJ+
         wqpqwHxCH2aYnpq1zfkxU+I7q2qslTWPZgP3ankPW2C8K1NxbGymLZaFY0yu5QcAZVAB
         DMww==
X-Gm-Message-State: AJIora9OfReCnTzOSSBljY+bdC55UKGQLGDWjzNglo8CckB2y5n1zVKL
        KX0KsEbaS3GjvMAibimiQyaYyeGTbit82YDMpFtBaw==
X-Google-Smtp-Source: AGRyM1tW6szJjClDeMP0rbtsXYy0fEocgRbX/Hxy1ioFyWfpCUpvg6n7/Kb8za7cH4w7H+iG7eAZHfScX+PE+FriedM=
X-Received: by 2002:adf:f20a:0:b0:21e:2608:9390 with SMTP id
 p10-20020adff20a000000b0021e26089390mr3106382wro.577.1658164187743; Mon, 18
 Jul 2022 10:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220715235824.2549012-1-kaleshsingh@google.com> <CA+EHjTxXX_d8M9VGCBokoKCCuvOoR_1u4JrSNKPTdN3qp9bQog@mail.gmail.com>
In-Reply-To: <CA+EHjTxXX_d8M9VGCBokoKCCuvOoR_1u4JrSNKPTdN3qp9bQog@mail.gmail.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Mon, 18 Jul 2022 10:09:36 -0700
Message-ID: <CAC_TJvdPwL76o-qE_Tw5R06JPeVLgy5O4nBYia=pzmEjA5dvng@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: Fix hypervisor address symbolization
To:     Fuad Tabba <tabba@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Will Deacon <will@kernel.org>,
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

On Mon, Jul 18, 2022 at 2:08 AM Fuad Tabba <tabba@google.com> wrote:
>
> Hi Kalesh,
>
> On Sat, Jul 16, 2022 at 12:58 AM Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > With CONFIG_RANDOMIZE_BASE=y vmlinux addresses will resolve correctly
> > from kallsyms. Fix this by adding the KASLR offset before printing the
> > symbols.
> >
> > Based on arm64 for-next/stacktrace.
> >
> > Fixes: 6ccf9cb557bd ("KVM: arm64: Symbolize the nVHE HYP addresses")
> > Reported-by: Fuad Tabba <tabba@google.com>
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
>
> Even with this patch applied I still don't get symbolization unless I
> disable randomization, either by setting CONFIG_RANDOMIZE_BASE=n or
> pass nokaslr as a kernel parameter. I tried both and in either case it
> works.

Hi Fuad,

Thanks for testing it. The fix only addressed the symbolization for
the hyp panic address. I plan to fix the symbolization of stacktrace
in the next version of this series.

--Kalesh

>
> Thanks,
> /fuad
>
>
> >  arch/arm64/kvm/handle_exit.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> > index f66c0142b335..e43926ef2bc2 100644
> > --- a/arch/arm64/kvm/handle_exit.c
> > +++ b/arch/arm64/kvm/handle_exit.c
> > @@ -347,10 +347,10 @@ void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr,
> >                         kvm_err("nVHE hyp BUG at: %s:%u!\n", file, line);
> >                 else
> >                         kvm_err("nVHE hyp BUG at: [<%016llx>] %pB!\n", panic_addr,
> > -                                       (void *)panic_addr);
> > +                                       (void *)(panic_addr + kaslr_offset()));
> >         } else {
> >                 kvm_err("nVHE hyp panic at: [<%016llx>] %pB!\n", panic_addr,
> > -                               (void *)panic_addr);
> > +                               (void *)(panic_addr + kaslr_offset()));
> >         }
> >
> >         /*
> >
> > base-commit: 82a592c13b0aeff94d84d54183dae0b26384c95f
> > --
> > 2.37.0.170.g444d1eabd0-goog
> >
