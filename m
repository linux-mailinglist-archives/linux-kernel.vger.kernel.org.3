Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D054B4ADA23
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358615AbiBHNjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349830AbiBHNjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 08:39:47 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F780C03FED1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 05:39:46 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id g14so49815346ybs.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 05:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AB43GeMhzoWNJcuHGVxX4xPDF6JvmahIqFg1wRbGD9E=;
        b=JBVhCpQm4U1bayIyDFb2W7GCme8X/VBGonuobVv7G4Temo3gqMH7cdtrDi2dDqME8X
         qlUA/R+m0zXhAexPkTFUtqBqNdoZFt5qbB3plHDoz88JqFfTu1aVkMsyfF0EgOxSzRda
         1qIItw58w7UETvuGE9pDY1enmMQNK5prZ11UOZli3ZxaO3wMknlDmvZZwRcTEHf0up15
         +x6imdr/QjOS32lq+KtVY5HaiaYLz0lId0zPpB/fFR02/XlTzSHkm3NLqReoUijVSamF
         GSioTb7+A/ha9n1Jfco5RxwxnQ8nipskEL9uEvqm4//wVfCwNANLMa1pGh9GJYfteVTC
         lc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AB43GeMhzoWNJcuHGVxX4xPDF6JvmahIqFg1wRbGD9E=;
        b=FLMCR6j6sF3FAINSOT0AKBmhVY8d3N/yrMFwbT3x8xgUPHp1zMgmJs38sgmGGI/Sxp
         aqzX/F1S0n/aVaTcicEWN7hH1FGDQUJaRTwNChkeCPUdyDaGGzFu9QiKQF8mNtwFxr7p
         YJDsf13LjmOoB0F9d2zyZP4rgC+2FOddDLxqBWe0VsyilVEIV6RjeBrlPAPySuz43zWP
         gOATf43GswnEpPmsAxrqRF9YZd5huZTxwS04JQz0AyA4izqyo6j41Ewow7pIUPcBsB+s
         1Nxwoca08NwCX++xo7io4im0fNO0zB+J6Rblf3R3Vv0EbbRpgsQjNZ7tQOLBmH4ge/3U
         8VfQ==
X-Gm-Message-State: AOAM531K0zO+o3rVpmCq6QTSNM5hz7HRqGU9hxXXDfrkFLvKNEURTjZc
        /JJVBiWwOchUvsBpcl4ATPHpnmJCgLBRu4iVac2mGQ==
X-Google-Smtp-Source: ABdhPJxbDgXMBRv9C+RY1p8OyAGygwZn2GL78Z4+WOtcMuUdETn286pOhYdPFjFTIV+onoiigXO8dnUZoDWUsoPYX8M=
X-Received: by 2002:a05:6902:1548:: with SMTP id r8mr5071533ybu.374.1644327585600;
 Tue, 08 Feb 2022 05:39:45 -0800 (PST)
MIME-Version: 1.0
References: <1644324666-15947-1-git-send-email-yangtiezhu@loongson.cn> <1644324666-15947-6-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1644324666-15947-6-git-send-email-yangtiezhu@loongson.cn>
From:   Marco Elver <elver@google.com>
Date:   Tue, 8 Feb 2022 14:39:34 +0100
Message-ID: <CANpmjNPxLgosrY=CH9GpwHmOKFbCuPQfLBFS+QBZGKiQC-od9w@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] kasan: no need to unset panic_on_warn in end_report()
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Xuefeng Li <lixuefeng@loongson.cn>, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Tue, 8 Feb 2022 at 13:51, Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> panic_on_warn is unset inside panic(), so no need to unset it
> before calling panic() in end_report().
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Reviewed-by: Marco Elver <elver@google.com>


> ---
>  mm/kasan/report.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 3ad9624..f141465 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -117,16 +117,8 @@ static void end_report(unsigned long *flags, unsigned long addr)
>         pr_err("==================================================================\n");
>         add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
>         spin_unlock_irqrestore(&report_lock, *flags);
> -       if (panic_on_warn && !test_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags)) {
> -               /*
> -                * This thread may hit another WARN() in the panic path.
> -                * Resetting this prevents additional WARN() from panicking the
> -                * system on this thread.  Other threads are blocked by the
> -                * panic_mutex in panic().
> -                */
> -               panic_on_warn = 0;
> +       if (panic_on_warn && !test_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags))
>                 panic("panic_on_warn set ...\n");
> -       }
>         if (kasan_arg_fault == KASAN_ARG_FAULT_PANIC)
>                 panic("kasan.fault=panic set ...\n");
>         kasan_enable_current();
> --
> 2.1.0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/1644324666-15947-6-git-send-email-yangtiezhu%40loongson.cn.
