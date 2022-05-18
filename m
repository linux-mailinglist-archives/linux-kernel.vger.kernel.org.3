Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470E552B56D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbiERI4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 04:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbiERI4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 04:56:53 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD65140AD
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 01:56:41 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id w14so2369853lfl.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 01:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MUKJ8QRlQSCBTIhaVerC8fhj0gKK+rHwygeAwjxNYCY=;
        b=Nmd6m7vKMoactSrKbr4Nix6LQbVjUP6rFRWifOBFatjP+N7IeeqBVHYLSa77WqvQD9
         g6nGZy63F1g5mbww37f5NcXAiqGfGo2Cr/muP7cDysBF3zn2qgT1g0jPtCEKBF1SgbVa
         olkfwbVPDBHNHEczZpUkl6BSEeKXotVgHfrXNlBI9Wzl8jceWypYnEd2TjJ3aTg6fNag
         fgmfH+bPz2QZRZoCLMpgLtMTeSQt7DrmnoDAgZBhOypQQyoOO/B0RL3RWe9Od/HvOmFt
         Et3FbfFvokSIc9rsQb1cTPkY7NtyMtGKuDT4UcqAm6AcUlbEEjBlBizFLPAOpa39RBuZ
         vJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MUKJ8QRlQSCBTIhaVerC8fhj0gKK+rHwygeAwjxNYCY=;
        b=eVWOa8MpHZC0KVmhQeDEn5wV5GVU1oxt4XrEgbuqpHbmYzQpqoVRY9wnEcOcRnQSXl
         F3/Cf8a0828VY5dUT9cXahzfHScSxTz6q5YaL2ULuKc97FPGcidz70WmWQ3d5FjnCtZm
         XM7Leh3Vdgm+SHd6BUZ+XO9vD6vlx/9aa69CtSkoRF4XIl/slbTEWux2mDSExLYZVge4
         Kk2QET00D/ZDI+aPdPq3CouQkFKUWkzzdG3kzy8HWGpF5tLPvYUFFF8uwsu1uqo1xBVG
         UkCXgVieOXQSGrsvdTc9aIdTTE6qqsc69MsIwh4O8IcT2U9Bk/zM8JOpY7Naw8L7lyNV
         B0vw==
X-Gm-Message-State: AOAM531A4NEMNSorNnQkbQ+ynQmVLtaiAzRsHX072AIvwVBtk+Fx8uv4
        V57TFY/ZUVBB2Hg8I2Utj2vSII6lSWtZVm/Vj1BvAw==
X-Google-Smtp-Source: ABdhPJx+cXKEKs1mIsHj8/P7XypRtEE3dZitodNjxZ1jSGPGR+KPl4+lOzVFYAMjmbItA+ovODMsGjLIhYCbYrL3paQ=
X-Received: by 2002:a05:6512:696:b0:473:a6ef:175d with SMTP id
 t22-20020a056512069600b00473a6ef175dmr19713174lfe.540.1652864188483; Wed, 18
 May 2022 01:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220517210532.1506591-1-liu3101@purdue.edu>
In-Reply-To: <20220517210532.1506591-1-liu3101@purdue.edu>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 18 May 2022 10:56:17 +0200
Message-ID: <CACT4Y+Z+HtUttrd+btEWLj5Nut4Gv++gzCOL3aDjvRTNtMDEvg@mail.gmail.com>
Subject: Re: [PATCH] kcov: fix race caused by unblocked interrupt
To:     Congyu Liu <liu3101@purdue.edu>
Cc:     andreyknvl@gmail.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
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

On Tue, 17 May 2022 at 23:05, Congyu Liu <liu3101@purdue.edu> wrote:
>
> Some code runs in interrupts cannot be blocked by `in_task()` check.
> In some unfortunate interleavings, such interrupt is raised during
> serializing trace data and the incoming nested trace functionn could
> lead to loss of previous trace data. For instance, in
> `__sanitizer_cov_trace_pc`, if such interrupt is raised between
> `area[pos] = ip;` and `WRITE_ONCE(area[0], pos);`, then trace data in
> `area[pos]` could be replaced.
>
> The fix is done by adding a flag indicating if the trace buffer is being
> updated. No modification to trace buffer is allowed when the flag is set.

Hi Congyu,

What is that interrupt code? What interrupts PCs do you see in the trace.
I would assume such early interrupt code should be in asm and/or not
instrumented. The presence of instrumented traced interrupt code is
problematic for other reasons (add random stray coverage to the
trace). So if we make it not traced, it would resolve both problems at
once and without the fast path overhead that this change adds.


> Signed-off-by: Congyu Liu <liu3101@purdue.edu>
> ---
>  include/linux/sched.h |  3 +++
>  kernel/kcov.c         | 16 ++++++++++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index a8911b1f35aa..d06cedd9595f 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1408,6 +1408,9 @@ struct task_struct {
>
>         /* Collect coverage from softirq context: */
>         unsigned int                    kcov_softirq;
> +
> +       /* Flag of if KCOV area is being written: */
> +       bool                            kcov_writing;
>  #endif
>
>  #ifdef CONFIG_MEMCG
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index b3732b210593..a595a8ad5d8a 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -165,6 +165,8 @@ static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_stru
>          */
>         if (!in_task() && !(in_serving_softirq() && t->kcov_softirq))
>                 return false;
> +       if (READ_ONCE(t->kcov_writing))
> +               return false;
>         mode = READ_ONCE(t->kcov_mode);
>         /*
>          * There is some code that runs in interrupts but for which
> @@ -201,12 +203,19 @@ void notrace __sanitizer_cov_trace_pc(void)
>                 return;
>
>         area = t->kcov_area;
> +
> +       /* Prevent race from unblocked interrupt. */
> +       WRITE_ONCE(t->kcov_writing, true);
> +       barrier();
> +
>         /* The first 64-bit word is the number of subsequent PCs. */
>         pos = READ_ONCE(area[0]) + 1;
>         if (likely(pos < t->kcov_size)) {
>                 area[pos] = ip;
>                 WRITE_ONCE(area[0], pos);
>         }
> +       barrier();
> +       WRITE_ONCE(t->kcov_writing, false);
>  }
>  EXPORT_SYMBOL(__sanitizer_cov_trace_pc);
>
> @@ -230,6 +239,10 @@ static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
>         area = (u64 *)t->kcov_area;
>         max_pos = t->kcov_size * sizeof(unsigned long);
>
> +       /* Prevent race from unblocked interrupt. */
> +       WRITE_ONCE(t->kcov_writing, true);
> +       barrier();
> +
>         count = READ_ONCE(area[0]);
>
>         /* Every record is KCOV_WORDS_PER_CMP 64-bit words. */
> @@ -242,6 +255,8 @@ static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
>                 area[start_index + 3] = ip;
>                 WRITE_ONCE(area[0], count + 1);
>         }
> +       barrier();
> +       WRITE_ONCE(t->kcov_writing, false);
>  }
>
>  void notrace __sanitizer_cov_trace_cmp1(u8 arg1, u8 arg2)
> @@ -335,6 +350,7 @@ static void kcov_start(struct task_struct *t, struct kcov *kcov,
>         t->kcov_size = size;
>         t->kcov_area = area;
>         t->kcov_sequence = sequence;
> +       t->kcov_writing = false;
>         /* See comment in check_kcov_mode(). */
>         barrier();
>         WRITE_ONCE(t->kcov_mode, mode);
> --
> 2.34.1
>
