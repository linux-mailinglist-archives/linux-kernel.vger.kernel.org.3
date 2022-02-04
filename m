Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65B54A9F04
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 19:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377532AbiBDS3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 13:29:13 -0500
Received: from mail-yb1-f170.google.com ([209.85.219.170]:34765 "EHLO
        mail-yb1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377528AbiBDS3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 13:29:12 -0500
Received: by mail-yb1-f170.google.com with SMTP id v186so21328242ybg.1;
        Fri, 04 Feb 2022 10:29:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RqAWQmdoXqG0G2kwAD2e7NWcP4SlcibKebTgmg5BUJc=;
        b=Zm0l3IjTqEukeY0o6/T/SCAclek8V7MpbzXEgHBxNfVmP9rwFqvdx627TIXjpCruiE
         m/1QHVfd1fgqd+QPfMu9QRmlBtFSdmLh0aQg8PdYe4p7ZDz5QOCNxXMvU+93p7JdW16b
         w2KbtrqkJoIDeew/mth4VNcflmc9ZuTwVwtT+a/v/blzD81UQxpILMB5OVNUXUbb7dLW
         FCFMHos7UF0M1LytcEJRSMmrDBNOOT8LeKJ1vXLUQMVXHF2RvLzuVVGkQE3aS//LkURs
         8ajgCeMM0YPgE2zaAiBEzSsw3gWFofCsHBqGmYzHKSSE8feDi87+KrJGnprOM1WUxIlS
         BObg==
X-Gm-Message-State: AOAM533x6bw69EUBzGSmJapiBfGPDZOIkySNE+lWgQl7I6uzpUMHNxUp
        DTpCPIOyU0ae/sMbtNOijCuqz+VsIfrPK54WvNI=
X-Google-Smtp-Source: ABdhPJyj2XCqxLQigrO1h5Vv11Xf5spz6I7/vWZ0+MeoMysgAe/P23JU+jJp4PS9LwunFtvqgdIoJsFzwaMZadnFT94=
X-Received: by 2002:a25:180a:: with SMTP id 10mr492538yby.552.1643999351652;
 Fri, 04 Feb 2022 10:29:11 -0800 (PST)
MIME-Version: 1.0
References: <20220123183925.1052919-1-yury.norov@gmail.com> <20220123183925.1052919-4-yury.norov@gmail.com>
In-Reply-To: <20220123183925.1052919-4-yury.norov@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 4 Feb 2022 19:29:00 +0100
Message-ID: <CAJZ5v0j+LS_0jaZwvze_8ar2n1R1FYqx0w_nM89SySg7oExi6A@mail.gmail.com>
Subject: Re: [PATCH 03/54] thermal/intel: don't use bitmap_weight() in end_power_clamp()
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2022 at 7:39 PM Yury Norov <yury.norov@gmail.com> wrote:
>
> Don't call bitmap_weight() if the following code can get by
> without it.
>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  drivers/thermal/intel/intel_powerclamp.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
> index 14256421d98c..c841ab37e7c6 100644
> --- a/drivers/thermal/intel/intel_powerclamp.c
> +++ b/drivers/thermal/intel/intel_powerclamp.c
> @@ -556,12 +556,9 @@ static void end_power_clamp(void)
>          * stop faster.
>          */
>         clamping = false;
> -       if (bitmap_weight(cpu_clamping_mask, num_possible_cpus())) {
> -               for_each_set_bit(i, cpu_clamping_mask, num_possible_cpus()) {
> -                       pr_debug("clamping worker for cpu %d alive, destroy\n",
> -                                i);
> -                       stop_power_clamp_worker(i);
> -               }
> +       for_each_set_bit(i, cpu_clamping_mask, num_possible_cpus()) {
> +               pr_debug("clamping worker for cpu %d alive, destroy\n", i);
> +               stop_power_clamp_worker(i);
>         }
>  }
>
> --

Applied as 5.18 material, thanks!
