Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EB0556ED2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 01:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377073AbiFVXGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 19:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377035AbiFVXGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 19:06:30 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4034091D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 16:06:28 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id u9so23094047oiv.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 16:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=zXYmgG7iQa+o9ruLpRc7lOxD4CdoD1Y1uoQiQlZDBqc=;
        b=mTtoaFOOfvNf4OZWfFlLAwO3xBU1ZbIfli/EpJWBPWL57xAc4P0gpXqigLIUGMdodO
         iLCaAkNdy6EuDlcxS68SBMXabFnO2ARQRmBIyu3Y0tYcd/YL6c1E42rVQO20rdxwXxRB
         GjHg+TEOx1GXpp6gBmaHN7KSNqxpEK8UUZUuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=zXYmgG7iQa+o9ruLpRc7lOxD4CdoD1Y1uoQiQlZDBqc=;
        b=6nmYscwuSlhEvN5A/p8OLw3XHsrI6PlXGVDX4RHcN3mSVA3LM/OKSQONohezvL3CNh
         trqwnWF+cTchy/JGwsPPHWFJbkW/ajb2ozmCTODkc0A+88dlTb3B51J8AZfbqoWrdLAF
         FnpPcoprixJCa625LNXDmnmHyneD8PPk9Qa8LLk4BddbVYdbzpQEuVh+4uQpJJZJG0fc
         H2zJpmrJjR/W52TD9K3Lj1TBTjTw47IhBG6jpgxQB8WilQZFQbs5yqDHrssjrX6yffxY
         MjldTLK57z+DW0P+sXSwtLj5xmDUKH6fd8KoeDET+eEKNhazBt5lKJUWC8mDr4axWV5+
         cU7A==
X-Gm-Message-State: AJIora+hhcXNz7NZ+AfeIZIiwDRmEcQSVh8p1XFCnAgEkBmQmthkhwgm
        HzgmCXvFpgsouHHIrT1Js7n+VjeEnXOCW6JRiNMyHg==
X-Google-Smtp-Source: AGRyM1sij7Q/JNEXGd7mMJDDr0w3hnSkJAGMS2ASw1mgiG7IRIYHTxAgGCXltmU7phsqEKjTP5u7yYopM3/j3D5vue0=
X-Received: by 2002:a05:6808:e87:b0:32e:4789:d2c with SMTP id
 k7-20020a0568080e8700b0032e47890d2cmr430242oil.193.1655939187670; Wed, 22 Jun
 2022 16:06:27 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Jun 2022 19:06:27 -0400
MIME-Version: 1.0
In-Reply-To: <1655834239-20812-1-git-send-email-quic_vnivarth@quicinc.com>
References: <1655834239-20812-1-git-send-email-quic_vnivarth@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 22 Jun 2022 19:06:27 -0400
Message-ID: <CAE-0n507Rh1Q4Wcp9f=PVxkgY-L7ZNuZMH6sZw=+ajeUk=UC5Q@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: qcom-geni-serial: Fix get_clk_div_rate()
 which otherwise could return a sub-optimal clock rate.
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vijaya Krishna Nivarthi (2022-06-21 10:57:19)
> In the logic around call to clk_round_rate, for some corner conditions,

clk_round_rate(), not the parethesis to indicate it's a function.

> get_clk_div_rate() could return an sub-optimal clock rate. Also, if an
> exact clock rate was not found lowest clock was being returned.
>
> Search for suitable clock rate in 2 steps
> a) exact match or within 2% tolerance
> b) within 5% tolerance
> This also takes care of corner conditions.
>
> Fixes: c2194bc999d4 ("tty: serial: qcom-geni-serial: Remove uart frequency table. Instead, find suitable frequency with call to clk_round_rate")
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 134 ++++++++++++++++++++++++++--------
>  1 file changed, 102 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 2e23b65..8d247c1 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -943,52 +943,123 @@ static int qcom_geni_serial_startup(struct uart_port *uport)
>         return 0;
>  }
>
> -static unsigned long get_clk_div_rate(struct clk *clk, unsigned int baud,
> -                       unsigned int sampling_rate, unsigned int *clk_div)
> +static unsigned long find_clk_rate_in_tol(struct clk *clk, unsigned int desired_clk,
> +                       unsigned int *clk_div, unsigned int percent_tol, bool *exact_match)

Do we really need to pass in a bool pointer here for 'exact_match'?
Can't we calculate the exact match value in the callsite and simply pass
a bool (not pointer) to constrain the logic in this function?

>  {
> +       unsigned long freq;
> +       unsigned long div, maxdiv, new_div;
> +       unsigned long long mult;

I think u64 is used more often than unsigned long long.

>         unsigned long ser_clk;
> -       unsigned long desired_clk;
> -       unsigned long freq, prev;
> -       unsigned long div, maxdiv;
> -       int64_t mult;
> -
> -       desired_clk = baud * sampling_rate;
> -       if (!desired_clk) {
> -               pr_err("%s: Invalid frequency\n", __func__);
> -               return 0;
> -       }
> +       unsigned long test_freq, offset, new_freq;
>
> +       ser_clk = 0;
>         maxdiv = CLK_DIV_MSK >> CLK_DIV_SHFT;
> -       prev = 0;
> +       div = 1;
>
> -       for (div = 1; div <= maxdiv; div++) {
> -               mult = div * desired_clk;
> -               if (mult > ULONG_MAX)
> +       while (div <= maxdiv) {
> +               mult = (unsigned long long)div * desired_clk;

Cast to u64?

> +               if (mult != (unsigned long)mult)

What is this checking for? Do we expect the rate to be larger than
32-bits on 32-bit machines?

>                         break;
>
> -               freq = clk_round_rate(clk, (unsigned long)mult);
> -               if (!(freq % desired_clk)) {
> -                       ser_clk = freq;
> -                       break;
> +               /*
> +                * Loop requesting a freq within tolerance and possibly exact freq.
> +                *
> +                * We'll keep track of the lowest freq inexact match we found
> +                * but always try to find a perfect match. NOTE: this algorithm
> +                * could miss a slightly better freq if there's more than one
> +                * freq between (freq - offset) and (freq) but (freq) can't be made
> +                * exactly, but that's OK.
> +                *
> +                * This absolutely relies on the fact that the Qualcomm clock
> +                * driver always rounds up.
> +                * We make use of exact_match as an I/O param.
> +                */
> +
> +               /* look only for exact match if within tolerance is already found */
> +               if (ser_clk)
> +                       offset = 0;
> +               else
> +                       offset = (mult * percent_tol) / 100;

This needs to use div_u64() to be compatible with 32-bit machines.

> +
> +               test_freq = mult - offset;
> +               freq = clk_round_rate(clk, test_freq);
> +
> +               /*
> +                * A dead-on freq is an insta-win, look for it only in 1st run
> +                */
> +               if (*exact_match) {
> +                       if (!(freq % desired_clk)) {
> +                               ser_clk = freq;
> +                               *clk_div = freq / desired_clk;
> +                               return ser_clk;
> +                       }
> +               }
> +
> +               if (!ser_clk) {
> +                       new_div = DIV_ROUND_CLOSEST(freq, desired_clk);
> +                       new_freq = new_div * desired_clk;
> +                       offset = (new_freq * percent_tol) / 100;
> +
> +                       if (new_freq - offset <= freq && freq <= new_freq + offset) {
> +                               /* Save the first (lowest freq) within tolerance */
> +                               ser_clk = freq;
> +                               *clk_div = new_div;
> +                               /* no more search for exact match required in 2nd run */
> +                               if (!(*exact_match))
> +                                       break;
> +                       }
>                 }
>
> -               if (!prev)
> -                       ser_clk = freq;
> -               else if (prev == freq)
> +               div = freq / desired_clk + 1;
> +
> +               /*
> +                * Only time clock framework doesn't round up is if
> +                * we're past the max clock rate. We're done searching
> +                * if that's the case.
> +                */
> +               if (freq < test_freq)
>                         break;
> +       }
> +
> +       *exact_match = false;
> +       return ser_clk;
> +}
> +
> +static unsigned long get_clk_div_rate(struct clk *clk, unsigned int baud,
> +                       unsigned int sampling_rate, unsigned int *clk_div)
> +{
> +       unsigned long ser_clk;
> +       unsigned long desired_clk;
> +       unsigned long desired_tol;
> +       bool exact_match;
>
> -               prev = freq;
> +       desired_clk = baud * sampling_rate;
> +       if (!desired_clk) {
> +               pr_err("%s: Invalid frequency\n", __func__);
> +               return 0;
>         }
>
> -       if (!ser_clk) {
> -               pr_err("%s: Can't find matching DFS entry for baud %d\n",
> -                                                               __func__, baud);
> +       /* try to find exact clock rate or within 2% tolerance */
> +       ser_clk = 0;
> +       exact_match = true;
> +       desired_tol = 2;
> +
> +       ser_clk = find_clk_rate_in_tol(clk, desired_clk, clk_div, desired_tol, &exact_match);
> +       if (ser_clk) {
> +               if (!exact_match)
> +                       pr_warn("Cannot find exact match clk_rate, using one within 2 percent tolerance\n");

Should this be a pr_warn_once()? Because otherwise users are going to
see this error potentially quite often if tolerances can't be achieved.

>                 return ser_clk;
>         }
>
> -       *clk_div = ser_clk / desired_clk;
> -       if (!(*clk_div))
> -               *clk_div = 1;
> +       /* try within 5% tolerance now, no need to look for exact match */
> +       exact_match = false;
> +       desired_tol = 5;
> +
> +       ser_clk = find_clk_rate_in_tol(clk, desired_clk, clk_div, desired_tol, &exact_match);
> +       if (ser_clk)
> +               pr_warn("Cannot find exact match clk_rate, using one within 5 percent tolerance\n");

This is a debug print?

> +       else
> +               pr_err("Cannot find suitable clk_rate, giving up\n");
>
>         return ser_clk;
>  }
