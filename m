Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119C5576342
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 15:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbiGON70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 09:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbiGON7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 09:59:11 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7398F20C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 06:59:10 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id j70so6128922oih.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 06:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FedCUjPaYWeA+erxDCoGCFWQ2IqT52osu7P0qCTsADw=;
        b=SfQLh5uuHMjqqGyxSvxqidpbRlKx2pbwugGUmYScb6znMBdlPl2TKCBAp4vdj16oT7
         wdac5LHirOZciCIyUnKx2JrrOLEzhewDvj+q2kGR5iu8pMh9s3ru88w2C6EsGNmtTHAj
         gV7PPytMXS5+9ZkeGzhbxb2WLZuw13rdJj85CPBa5Xq1dKXG+vvXoq57dWCnIpCuGrAN
         JMTz6EL+56pkYNzfnzlVs+Gh26RtJpMA9BiMei3ELFO43jzq0uoQScorY1jUnZcKnM7E
         51uyUv5MDDsybzgJGw3jQjQF9niyKnv3fG3qmmXgkjzjF3J1nObJQW0ESxaddGHdjvhB
         GJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FedCUjPaYWeA+erxDCoGCFWQ2IqT52osu7P0qCTsADw=;
        b=rJvr48Mk0KjPNkALdSqTd8Y+Uz4qFQkSbZGWrbYsf28wAsdUqpZscy23UK4h7Fkg4O
         Pyp90uq9TJFzOA4RgESwDn73jE/QFFaR5OKSz9ifG9B0qmEqOg8vQo4hwdCdfUJP7Cyp
         zJm89Y+XUwqe2UdiVVngwSc96/8GzWAB2VHl8hfTm83JQ7ScAttrtlVBIsSVdN8tGOd0
         u7Lxt6Q7pXdHi5MM7KrhTfd0Jst2nAPtlEKTDnvFhSxOpi5DaglcNEj6++QxOIvsbAGm
         fwDbtIaj3VlyfgpZCVhgXtQq/Z5pmrFRd4oLmzoHgmlRo1k1yLh68rY335UpNu3m4JpO
         +GTA==
X-Gm-Message-State: AJIora9rGN5s+M1lhzRCMpbtOO/gogtSnAbSlfSHb2DsX7UWD9TP22Cg
        1DEamWX1vQS6ihvzg7Ear+Bvy8GLQae8AgDi3jqlyw==
X-Google-Smtp-Source: AGRyM1sYJ9tUCJtAOpcRqsqhX74xUJZqwlSchSlNVe5+PXo4VKC+9LCHOatk8tOc3ga/R2H/Z3Mg9Q/uYeEhouETn98=
X-Received: by 2002:a05:6808:1596:b0:337:8c17:b17f with SMTP id
 t22-20020a056808159600b003378c17b17fmr7434645oiw.294.1657893549609; Fri, 15
 Jul 2022 06:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com> <20220715061027.1612149-3-kaleshsingh@google.com>
In-Reply-To: <20220715061027.1612149-3-kaleshsingh@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Fri, 15 Jul 2022 14:58:33 +0100
Message-ID: <CA+EHjTxpYgEYX4MRAYAVyptPZa6jUV2b_c_E4kLEMRcj6jsLUQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/18] arm64: stacktrace: Factor out on_accessible_stack_common()
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com, will@kernel.org, qperret@google.com,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, russell.king@oracle.com,
        vincenzo.frascino@arm.com, mhiramat@kernel.org, ast@kernel.org,
        drjones@redhat.com, wangkefeng.wang@huawei.com, elver@google.com,
        keirf@google.com, yuzenghui@huawei.com, ardb@kernel.org,
        oupton@google.com, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        android-mm@google.com, kernel-team@android.com
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

On Fri, Jul 15, 2022 at 7:10 AM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> Move common on_accessible_stack checks to stacktrace/common.h. This is
> used in the implementation of the nVHE hypervisor unwinder later in
> this series.
>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>

Thanks,
/fuad


>  arch/arm64/include/asm/stacktrace.h        |  8 ++------
>  arch/arm64/include/asm/stacktrace/common.h | 18 ++++++++++++++++++
>  2 files changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
> index 79f455b37c84..a4f8b84fb459 100644
> --- a/arch/arm64/include/asm/stacktrace.h
> +++ b/arch/arm64/include/asm/stacktrace.h
> @@ -56,7 +56,6 @@ static inline bool on_overflow_stack(unsigned long sp, unsigned long size,
>                         struct stack_info *info) { return false; }
>  #endif
>
> -
>  /*
>   * We can only safely access per-cpu stacks from current in a non-preemptible
>   * context.
> @@ -65,8 +64,8 @@ static inline bool on_accessible_stack(const struct task_struct *tsk,
>                                        unsigned long sp, unsigned long size,
>                                        struct stack_info *info)
>  {
> -       if (info)
> -               info->type = STACK_TYPE_UNKNOWN;
> +       if (on_accessible_stack_common(tsk, sp, size, info))
> +               return true;
>
>         if (on_task_stack(tsk, sp, size, info))
>                 return true;
> @@ -74,12 +73,9 @@ static inline bool on_accessible_stack(const struct task_struct *tsk,
>                 return false;
>         if (on_irq_stack(sp, size, info))
>                 return true;
> -       if (on_overflow_stack(sp, size, info))
> -               return true;
>         if (on_sdei_stack(sp, size, info))
>                 return true;
>
>         return false;
>  }
> -
>  #endif /* __ASM_STACKTRACE_H */
> diff --git a/arch/arm64/include/asm/stacktrace/common.h b/arch/arm64/include/asm/stacktrace/common.h
> index 64ae4f6b06fe..f58b786460d3 100644
> --- a/arch/arm64/include/asm/stacktrace/common.h
> +++ b/arch/arm64/include/asm/stacktrace/common.h
> @@ -62,6 +62,9 @@ struct unwind_state {
>         struct task_struct *task;
>  };
>
> +static inline bool on_overflow_stack(unsigned long sp, unsigned long size,
> +                                    struct stack_info *info);
> +
>  static inline bool on_stack(unsigned long sp, unsigned long size,
>                             unsigned long low, unsigned long high,
>                             enum stack_type type, struct stack_info *info)
> @@ -80,6 +83,21 @@ static inline bool on_stack(unsigned long sp, unsigned long size,
>         return true;
>  }
>
> +static inline bool on_accessible_stack_common(const struct task_struct *tsk,
> +                                             unsigned long sp,
> +                                             unsigned long size,
> +                                             struct stack_info *info)
> +{
> +       if (info)
> +               info->type = STACK_TYPE_UNKNOWN;
> +
> +       /*
> +        * Both the kernel and nvhe hypervisor make use of
> +        * an overflow_stack
> +        */
> +       return on_overflow_stack(sp, size, info);
> +}
> +
>  static inline void unwind_init_common(struct unwind_state *state,
>                                       struct task_struct *task)
>  {
> --
> 2.37.0.170.g444d1eabd0-goog
>
