Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515C6530C0D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbiEWIgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbiEWIgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:36:12 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45B364E0
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:36:10 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p22so24259522lfo.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=64FblKzsQYdGz6fqkSHe4/Mnt+TinFiqj0bwW9V3nQ8=;
        b=B+TVMJ5dSczlHf5hzCe9CK0Uj1rFfGdBn7KefVcBPApXD17SLcM3OGQ90A1xIofsNv
         +PETzFrxt2sdHhthin7x03r59noroWWNCRxu4OfEK6QA26aRTpZpqq1oLVoUjmxVZvda
         cpPHPCK7bRtoU2IWYPwfuUSTLGO77qH94EGzJ8PZfafDZq502nwFq5CCO31iNOQGbTVV
         wNG3D8QAq7VKM1DR7MJXy9ZC+Q5cRd3RY51RArwhbSSMk8bwLoHs88uH7rKlj2lvFYHL
         MYfqjXitAlDssggn4Li97mzBL/j559MP3s0GfD6KeZU7LW4RkV7jJo2eBTJ5T+ZHiXLd
         pXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=64FblKzsQYdGz6fqkSHe4/Mnt+TinFiqj0bwW9V3nQ8=;
        b=4hik1e1+FRVnJmZu5A4vnaauTA4IzNzPuePlC+nTIGaAO+9nyFJ5zHTQqYY3/Cl3Nd
         u+U8199dPhY4vFFSP8lTm0ziMLilR9tzP4Qf0bApBvpoNVgVYXsN/1K/Jh1Qi0J3g8wM
         GYF8wR1lIjnrhXQfhl1AkjWhL+K0axFs2ug/7ZxncDVVjVfRol4lxOdcP7YUhkrv/lzx
         GPZvvRI8hKy3LMIV09Ta1t6tk7UvN93S9gvNqWoGuNuuV11EfssefXIS5QE0utYapKA4
         Qv83s6+Z9ZuE+E67W2DCkRo3dyGWJIf0L8IrtNS4g8A37k6WfNRJ8uYPHw54+orFoZtW
         TgAQ==
X-Gm-Message-State: AOAM533AW1nRR8hnbRUAK3BiWdd/T/clmjy5Ha/aeTqq57oivWBR4Op5
        LnWHP9bx15JYST64s6SuzkbCNfglTPwN9E3CeAF0ow==
X-Google-Smtp-Source: ABdhPJzfBH1kHFR9kNrtbR06c7LH74ucbt8enU+3V++mcBeFmHUd7OphsNKGBrMJRzhlCYzUbLF5FS8Pbs4QHhtUmw4=
X-Received: by 2002:a05:6512:ace:b0:473:cca7:a7fa with SMTP id
 n14-20020a0565120ace00b00473cca7a7famr15173051lfu.410.1653294969007; Mon, 23
 May 2022 01:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220523063033.1778974-1-liu3101@purdue.edu>
In-Reply-To: <20220523063033.1778974-1-liu3101@purdue.edu>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 23 May 2022 10:35:57 +0200
Message-ID: <CACT4Y+Zpasug=cr2k-17aD_EBsvMZB8kQnaJ+KPgoPOZAj___Q@mail.gmail.com>
Subject: Re: [PATCH] tracing: disable kcov on trace_preemptirq.c
To:     Congyu Liu <liu3101@purdue.edu>
Cc:     andreyknvl@gmail.com, rostedt@goodmis.org, mingo@redhat.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
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

On Mon, 23 May 2022 at 08:30, Congyu Liu <liu3101@purdue.edu> wrote:
>
> Functions in trace_preemptirq.c could be invoked from early interrupt
> code that bypasses kcov trace function's in_task() check. Disable kcov
> on this file to reduce random code coverage.
>
> Signed-off-by: Congyu Liu <liu3101@purdue.edu>

Acked-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  kernel/trace/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index d77cd8032213..0d261774d6f3 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -31,6 +31,10 @@ ifdef CONFIG_GCOV_PROFILE_FTRACE
>  GCOV_PROFILE := y
>  endif
>
> +# Functions in this file could be invoked from early interrupt
> +# code and produce random code coverage.
> +KCOV_INSTRUMENT_trace_preemptirq.o := n
> +
>  CFLAGS_bpf_trace.o := -I$(src)
>
>  CFLAGS_trace_benchmark.o := -I$(src)
> --
> 2.34.1
>
