Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C9257C857
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 11:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbiGUJ6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 05:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbiGUJ6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:58:37 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FDB820D6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:58:33 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-10d9137bd2eso1708187fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cke61x1VyLaOYMRXa+KSlFmuqpeiXyYoEp5L0oHK1QY=;
        b=Tv95sC0RqA3YKlr8Mh8ehqDQQXV9jQB2dagD6vtqdXmVNw98AKjRH+UwEbuwL2OHbz
         KAAkhFIW3FZwlIYmgkwTCOJgSBItuMIrzMHPGXkY7LvyHwdFnRrGX0LevGgQFkGpNRpE
         J9wqLlYi4/pflPV5HBV4XXjyVO6b+I8QstZAqTw65q71c3h/PMs622hA5yg4rCgfSeJ5
         2g5Di77DrhkMVDgr+gOZbpQD3/hK1YSEfxYJGaey4k6XC/JL0gnm47mrlpXpzdxznlaL
         oGUh9EqkT5n2W2VMQjS6SQd/55HLeg9DGahze8oyN1mdYMq19MZHbB0woZe+TGiOkWwU
         JilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cke61x1VyLaOYMRXa+KSlFmuqpeiXyYoEp5L0oHK1QY=;
        b=FrcUXRjVj5VGoOgWtN4P3iblv1SHgY680BNZP7HeeOeLuYZJJZlq5Qx/K1UIJEuq8K
         eVok2G2Ti/FLkgvs2eFneFI9nt6p0i++YITMOhyXWI/JIyfheHhk/8hLBu/M3tTPKXsM
         pZGm9u25TxDWlbo6DWL8M5OmAxp7x4guU2WU4/Fuw1tueEWf2sqv3NAQE3sa0LTgMopd
         xPl56Wl2DRDOVyhuuFmzTTJTQHrYUBlVoqnPkUbEbLHo0VGiZ4zZWP/H585jh3Q9GxIC
         zgZEICNtS16Lj93pW/QxzCZLGqgUscr7jisi2t6Rp/lx8z6JnasMkWqlTNYReKqBO8vA
         Q3+Q==
X-Gm-Message-State: AJIora8d7DB0OWtXU9tdBs2vSVBWa070v2SiAIE2XMeIIsN+oT4+he7c
        7LUwfVusycJBzOyxyGpaObXWp0SWTyTxa4E525tAag==
X-Google-Smtp-Source: AGRyM1s1/WqNg+sC8uUwNPbq5XStZk8otBFSfStT4w/YkwUXcQ6JM+u9wee9XyLVbencTF50D7kTRxumET8UpAglsaI=
X-Received: by 2002:a05:6871:890:b0:10b:f3eb:b45d with SMTP id
 r16-20020a056871089000b0010bf3ebb45dmr4955346oaq.294.1658397512248; Thu, 21
 Jul 2022 02:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220721055728.718573-1-kaleshsingh@google.com> <20220721055728.718573-10-kaleshsingh@google.com>
In-Reply-To: <20220721055728.718573-10-kaleshsingh@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Thu, 21 Jul 2022 10:57:56 +0100
Message-ID: <CA+EHjTwvGj+1TQ1OKDNhJsFd=TjwuPr=mjGxvZDqTKWYMcbN+Q@mail.gmail.com>
Subject: Re: [PATCH v5 09/17] KVM: arm64: Allocate shared pKVM hyp stacktrace buffers
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com, will@kernel.org, qperret@google.com,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        mhiramat@kernel.org, ast@kernel.org, wangkefeng.wang@huawei.com,
        elver@google.com, keirf@google.com, yuzenghui@huawei.com,
        ardb@kernel.org, oupton@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
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

Hi Kalesh,

On Thu, Jul 21, 2022 at 6:57 AM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> In protected nVHE mode the host cannot directly access
> hypervisor memory, so we will dump the hypervisor stacktrace
> to a shared buffer with the host.
>
> The minimum size for the buffer required, assuming the min frame
> size of [x29, x30] (2 * sizeof(long)), is half the combined size of
> the hypervisor and overflow stacks plus an additional entry to
> delimit the end of the stacktrace.
>
> The stacktrace buffers are used later in the seried to dump the

nit: seried/series

> nVHE hypervisor stacktrace when using protected-mode.
>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad


> Changes in v5:
>   - Fix typo in commit text, per Marc
>
>  arch/arm64/include/asm/memory.h      | 8 ++++++++
>  arch/arm64/kvm/hyp/nvhe/stacktrace.c | 4 ++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 0af70d9abede..cab80a9a4086 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -113,6 +113,14 @@
>
>  #define OVERFLOW_STACK_SIZE    SZ_4K
>
> +/*
> + * With the minimum frame size of [x29, x30], exactly half the combined
> + * sizes of the hyp and overflow stacks is the maximum size needed to
> + * save the unwinded stacktrace; plus an additional entry to delimit the
> + * end.
> + */
> +#define NVHE_STACKTRACE_SIZE   ((OVERFLOW_STACK_SIZE + PAGE_SIZE) / 2 + sizeof(long))
> +
>  /*
>   * Alignment of kernel segments (e.g. .text, .data).
>   *
> diff --git a/arch/arm64/kvm/hyp/nvhe/stacktrace.c b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
> index a3d5b34e1249..69e65b457f1c 100644
> --- a/arch/arm64/kvm/hyp/nvhe/stacktrace.c
> +++ b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
> @@ -9,3 +9,7 @@
>
>  DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack)
>         __aligned(16);
> +
> +#ifdef CONFIG_PROTECTED_NVHE_STACKTRACE
> +DEFINE_PER_CPU(unsigned long [NVHE_STACKTRACE_SIZE/sizeof(long)], pkvm_stacktrace);
> +#endif /* CONFIG_PROTECTED_NVHE_STACKTRACE */
> --
> 2.37.0.170.g444d1eabd0-goog
>
