Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF707577F2D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 12:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbiGRKAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 06:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbiGRKAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 06:00:41 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1941D1A825
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 03:00:40 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-10bd4812c29so22351187fac.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 03:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fqf6wKKo3lC9G5+M1ef19eODt2HuCtIL9StjZNMcJ2Q=;
        b=l2x2fTnLy/zYWJ+f+TQToWt/IL54nbJ0yVIZ9VFyPm/pVUDcF82T2gOZ/jVCW6DElN
         UWgcPRHI6xX0lDyb1tWoCVBHVK79+HEYJE2Yu9AzmeEoewLpPbHtbmSqMFUQFNHxDciA
         x1xo5AEfYAFfCRj0dLCeogElogO8j5dxrRuumXHd8LA4EZVj8qwuldImWV/9F+fd1tjx
         D3fQqoXguwPvdqrETsRZea2X1C0oRjt8Kw/Z7lpbKw1nr5cVeXjzlGEtc3Mi6NIjCEIl
         386k6PrXZYRZ9hOHUZCYC5qHd/+UWUAYGG6Ak6mb4UCFAOOoPtsJPSpmYRDn+G9lLv8l
         y2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fqf6wKKo3lC9G5+M1ef19eODt2HuCtIL9StjZNMcJ2Q=;
        b=fyj3sbl+WdrkIexFc2T89YkPSBlDoiyC38cFhcr+f+VnbrLw5uhSF3+h79fLE89BZR
         3Uqi2JzywmHXQIYQHmFlbmDxaTE0PX4TXXUBrQyTx0L38pl+l1kvrpMe54bN0Ui2105r
         sUhJDZLX9tMs8idsxMvtekrKAQjN0wl7VwoUHU1GBzrIP2Zn4jVxx1QkKgVeEG0wF8tr
         Z38zl3ZwBpXSS0SLuCHtagimweuRkXlD9a8FValew2+2EyaBnKIBAjy/AVTSyquNbJ0H
         DN0jigrGRbvBljFwXu5V2FjYUmZ/L9ZVWSTf4GZE6iywqfgzQLNVPU2hUJ5eLNGqUNxV
         f63A==
X-Gm-Message-State: AJIora/UXQFl6lo1hUcEB0UZIxyThSdrWMKzjnWmXNtJdELmNUwUIYK7
        KkBpEynH/thRsb9Wc+qAAymc+9geljC02/vznX7GxQ==
X-Google-Smtp-Source: AGRyM1uox4hxQ7LkNj0+VsFUqxedF8ftJbu1vwH/Lnq6o11cLxNrijgbGJXVHMZjzjG6ma999hSm5CQdlLp+a5Ur+6Q=
X-Received: by 2002:a05:6871:890:b0:10b:f3eb:b45d with SMTP id
 r16-20020a056871089000b0010bf3ebb45dmr14815410oaq.294.1658138439232; Mon, 18
 Jul 2022 03:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com> <20220715061027.1612149-10-kaleshsingh@google.com>
In-Reply-To: <20220715061027.1612149-10-kaleshsingh@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Mon, 18 Jul 2022 11:00:03 +0100
Message-ID: <CA+EHjTyY5ieRROhC9S-WzUybcp3j8egJLGpCHV_2vSt8ieUjXg@mail.gmail.com>
Subject: Re: [PATCH v4 09/18] KVM: arm64: Allocate shared pKVM hyp stacktrace buffers
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com, will@kernel.org, qperret@google.com,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, russell.king@oracle.com,
        vincenzo.frascino@arm.com, mhiramat@kernel.org, ast@kernel.org,
        wangkefeng.wang@huawei.com, elver@google.com, keirf@google.com,
        yuzenghui@huawei.com, ardb@kernel.org, oupton@google.com,
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

On Fri, Jul 15, 2022 at 7:11 AM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> In protected nVHE mode the host cannot directly access
> hypervisor memory, so we will dump the hypervisor stacktrace
> to a shared buffer with the host.
>
> The minimum size do the buffer required, assuming the min frame
> size of [x29, x30] (2 * sizeof(long)), is half the combined size of
> the hypervisor and overflow stacks plus an additional entry to
> delimit the end of the stacktrace.
>
> The stacktrace buffers are used later in the seried to dump the
> nVHE hypervisor stacktrace when using protected-mode.
>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
>  arch/arm64/include/asm/memory.h      | 7 +++++++
>  arch/arm64/kvm/hyp/nvhe/stacktrace.c | 4 ++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 0af70d9abede..28a4893d4b84 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -113,6 +113,13 @@
>
>  #define OVERFLOW_STACK_SIZE    SZ_4K
>
> +/*
> + * With the minimum frame size of [x29, x30], exactly half the combined
> + * sizes of the hyp and overflow stacks is needed to save the unwinded
> + * stacktrace; plus an additional entry to delimit the end.
> + */
> +#define NVHE_STACKTRACE_SIZE   ((OVERFLOW_STACK_SIZE + PAGE_SIZE) / 2 + sizeof(long))

I do find this computation to be a bit confusing, especially with the
addition of the entry to delimit the end. Especially when considering
that in patch 12, where you add pkvm_save_backtrace_entry(), you need
to compensate for it again.

Not sure what the best way is, having two definitions, or something
like that, with one for the size and one for the delimiter.

Thanks,
/fuad

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
