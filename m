Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CD854B4E9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356943AbiFNPlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345160AbiFNPk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:40:59 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9D836309
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:40:57 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id c11so2992752vkn.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=piScKtqRvHw1IYDuJFxYjo3aE7lfG3qLoSCxhUyNnz4=;
        b=I7KHFvWekg+pv1Vmu0HOSzOdUCDbYdwC4arUqp2Y2ybU/3AX1+NwBg0WX50ij6t5py
         75y79402bGQz8jPQcSMPvrxWMv1FF9cUBQLeLo1NuvZ0N/ISaFBB0DoO3pPSG4MzTReQ
         EvRncO+KeUXmnmfBWjKfDzhV4pqs1e1w0aS7Urgz5dcRHUfi09+5afXy/nNpOeHzLij6
         9BG2yFbTr7NYSbCgMLTcmsrPzc5GQw0mIZ6RPBx9VdHd3efx/oWABeQKu3EchBAXuxeg
         Ah5Kzt0NVjSPGrRxA8c6z7CX7T98/fA9ulrSVhtU61+cALukPONyjeS5d+1+22LuZmFl
         RBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=piScKtqRvHw1IYDuJFxYjo3aE7lfG3qLoSCxhUyNnz4=;
        b=6unIgqJYSVGcI595+hLyF5emxzDrwL+vtMmdJ5vUG5N+ljQApyopsQoG0lKFbF+60u
         nE+FtWGO/EesvcPWZYMD7vNPisRn0Vunj1MBxS5v97WpbHlg6Pphm8WBevU1sdcRuDwe
         X+gI9a9PnBAvbF+5To6rRrIoC5XF29X3Ax45mCCfjv6W9K8EcWQ1yYoKZKswdlTQmeWi
         xndMwbCg9U/uFb1oyRv02X1ZhIV3DzNYsFgSS9QDigvC9UKJjh6BJubGP4DCOHgW9FxB
         HSt3QT+SCP7PSKuV6fabTAiE9v7RccgzLjkuMfAsKShsNim1b/uyIKL8BaGg8yvyWIun
         Qr6A==
X-Gm-Message-State: AJIora+xh591J+G/K6v37872IBaWhRM4NiHadnaaU6ui86bcfehp69sV
        0An8vz1CRnRG7QBRgi47kwL5N+v52utASaJW4Fb3Yw==
X-Google-Smtp-Source: AGRyM1ti2FhMHTOV9Gs8KPszNf4LcQ6P4eH9GowBi/dqxiPwslOMqkHiQ6WvbnpMw20B6iJy+kM2DB7lIL3kvGH927I=
X-Received: by 2002:a05:6122:200f:b0:368:990b:3ffc with SMTP id
 l15-20020a056122200f00b00368990b3ffcmr2591048vkd.2.1655221256650; Tue, 14 Jun
 2022 08:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220603235656.715800-1-namhyung@kernel.org> <20220603235656.715800-2-namhyung@kernel.org>
In-Reply-To: <20220603235656.715800-2-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 14 Jun 2022 08:40:44 -0700
Message-ID: <CAP-5=fWFamGi4ZXHz6+4gWmaaK-zo_p=EEF=uju0Pm0fcTAe1w@mail.gmail.com>
Subject: Re: [PATCH 1/5] perf lock: Print wait times with unit
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 3, 2022 at 4:57 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Currently it only prints the time in nsec but it's a bit hard to read
> and takes longer in the screen.  We can change it to use different
> units and keep the number small to save the space.
>
> Before:
>   $ perf lock report
>
>                 Name   acquired  contended   avg wait (ns) total wait (ns)   max wait (ns)   min wait (ns)
>
>         jiffies_lock        433         32            2778           88908           13570             692
>    &lruvec->lru_lock        747          5           11254           56272           18317            1412
>       slock-AF_INET6          7          1           23543           23543           23543           23543
>     &newf->file_lock        706         15            1025           15388            2279             618
>       slock-AF_INET6          8          1           10379           10379           10379           10379
>          &rq->__lock       2143          5            2037           10185            3462             939
>
> After:
>                 Name   acquired  contended     avg wait   total wait     max wait     min wait
>
>         jiffies_lock        433         32      2.78 us     88.91 us     13.57 us       692 ns
>    &lruvec->lru_lock        747          5     11.25 us     56.27 us     18.32 us      1.41 us
>       slock-AF_INET6          7          1     23.54 us     23.54 us     23.54 us     23.54 us
>     &newf->file_lock        706         15      1.02 us     15.39 us      2.28 us       618 ns
>       slock-AF_INET6          8          1     10.38 us     10.38 us     10.38 us     10.38 us
>          &rq->__lock       2143          5      2.04 us     10.19 us      3.46 us       939 ns
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-lock.c | 48 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 40 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 23a33ac15e68..57e396323d05 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -251,6 +251,31 @@ struct lock_key {
>         struct list_head        list;
>  };
>
> +static void lock_stat_key_print_time(unsigned long long nsec, int len)
> +{
> +       static const struct {
> +               float base;
> +               const char *unit;
> +       } table[] = {
> +               { 1e9 * 3600, "h " },
> +               { 1e9 * 60, "m " },
> +               { 1e9, "s " },
> +               { 1e6, "ms" },
> +               { 1e3, "us" },
> +               { 0, NULL },
> +       };
> +
> +       for (int i = 0; table[i].unit; i++) {
> +               if (nsec < table[i].base)
> +                       continue;
> +
> +               pr_info("%*.2f %s", len - 3, nsec / table[i].base, table[i].unit);
> +               return;
> +       }
> +
> +       pr_info("%*llu %s", len - 3, nsec, "ns");
> +}
> +
>  #define PRINT_KEY(member)                                              \
>  static void lock_stat_key_print_ ## member(struct lock_key *key,       \
>                                            struct lock_stat *ls)        \
> @@ -258,11 +283,18 @@ static void lock_stat_key_print_ ## member(struct lock_key *key,  \
>         pr_info("%*llu", key->len, (unsigned long long)ls->member);     \
>  }
>
> +#define PRINT_TIME(member)                                             \
> +static void lock_stat_key_print_ ## member(struct lock_key *key,       \
> +                                          struct lock_stat *ls)        \
> +{                                                                      \
> +       lock_stat_key_print_time((unsigned long long)ls->member, key->len);     \
> +}
> +
>  PRINT_KEY(nr_acquired)
>  PRINT_KEY(nr_contended)
> -PRINT_KEY(avg_wait_time)
> -PRINT_KEY(wait_time_total)
> -PRINT_KEY(wait_time_max)
> +PRINT_TIME(avg_wait_time)
> +PRINT_TIME(wait_time_total)
> +PRINT_TIME(wait_time_max)
>
>  static void lock_stat_key_print_wait_time_min(struct lock_key *key,
>                                               struct lock_stat *ls)
> @@ -272,7 +304,7 @@ static void lock_stat_key_print_wait_time_min(struct lock_key *key,
>         if (wait_time == ULLONG_MAX)
>                 wait_time = 0;
>
> -       pr_info("%*"PRIu64, key->len, wait_time);
> +       lock_stat_key_print_time(wait_time, key->len);
>  }
>
>
> @@ -291,10 +323,10 @@ static const char         *output_fields;
>  struct lock_key keys[] = {
>         DEF_KEY_LOCK(acquired, "acquired", nr_acquired, 10),
>         DEF_KEY_LOCK(contended, "contended", nr_contended, 10),
> -       DEF_KEY_LOCK(avg_wait, "avg wait (ns)", avg_wait_time, 15),
> -       DEF_KEY_LOCK(wait_total, "total wait (ns)", wait_time_total, 15),
> -       DEF_KEY_LOCK(wait_max, "max wait (ns)", wait_time_max, 15),
> -       DEF_KEY_LOCK(wait_min, "min wait (ns)", wait_time_min, 15),
> +       DEF_KEY_LOCK(avg_wait, "avg wait", avg_wait_time, 12),
> +       DEF_KEY_LOCK(wait_total, "total wait", wait_time_total, 12),
> +       DEF_KEY_LOCK(wait_max, "max wait", wait_time_max, 12),
> +       DEF_KEY_LOCK(wait_min, "min wait", wait_time_min, 12),
>
>         /* extra comparisons much complicated should be here */
>         { }
> --
> 2.36.1.255.ge46751e96f-goog
>
