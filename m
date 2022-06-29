Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D272560D0A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 01:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiF2XPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 19:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiF2XPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 19:15:49 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B5D1FCF0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 16:15:47 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id mf9so35637320ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 16:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bG+DjagJnbdid/PBSdK+0prSzy07zYpuPGDlj0ayBSY=;
        b=K4B8l2nlk+aCvUttsAs9sekZHHBiucWouZ+Un99URZidtr9zK2o4/nqzHUMfO4fqAp
         vG00rJ/mjxwVM+2DHzxvWRLH+JfCOD9XDiTN87Nx13f49rTfhaiEaiWRLYtPBDDReAYz
         WQBrCjWkzz9REeMZ1uYiPbYuG7VEqA1Il3ugw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bG+DjagJnbdid/PBSdK+0prSzy07zYpuPGDlj0ayBSY=;
        b=DzNtp9yNrqg7sp2HFZItbczxfK9CYkaLow8FSz62FQcOrZaIs1QH1P+5MHh1oUfbzu
         qFWNydDm1iAt80Tdt+HIyxLMTGp75de8iF+z67t7LfX6Zntkq1yz0Apks1ErBihdlC2x
         Q7nEq2PXYCZ3oa3K2FFwi506PJyDntBEl1KTr4z/1MFCwNhoFO4aBYkPvUZVp+T2iNT3
         jBwsfZ2gtQr1cPO3X79yMogx/mLjtRE7RS0jBwffBuHaLAlHvTmHDPN6RRl2XsKa9/Qw
         elIbEvv07ugq+uXAOsu1GpduTt9KbqhOC5ppLLs3IebzkDKrGG5E23CikgRQjzie8+Oh
         ToqA==
X-Gm-Message-State: AJIora8WcYdrK8Q2HhCTbkAd+b2OccTa00Mk9iJm0RIv6j/kmBh3BEUl
        Yq44ndxn8Z7aScJFUUUHGkiiudtiaiAMiD7thVg=
X-Google-Smtp-Source: AGRyM1uarj5hNlyPBoZP00tRLnuO0uphgdW4qUnQsBS58vvmmm4l+SwyMRqCmCgYLisJQi3oZmGQww==
X-Received: by 2002:a17:907:7b85:b0:711:e42d:4955 with SMTP id ne5-20020a1709077b8500b00711e42d4955mr5802133ejc.482.1656544545978;
        Wed, 29 Jun 2022 16:15:45 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id g5-20020a17090613c500b00722fb3c99bcsm8253772ejc.203.2022.06.29.16.15.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 16:15:43 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id d17so18985948wrc.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 16:15:42 -0700 (PDT)
X-Received: by 2002:adf:fb12:0:b0:20c:79b2:a200 with SMTP id
 c18-20020adffb12000000b0020c79b2a200mr5522968wrr.617.1656544542123; Wed, 29
 Jun 2022 16:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <1656496841-5853-1-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1656496841-5853-1-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 29 Jun 2022 16:15:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UXP+dfYEHpsS_djnWYxNVUS__2Uu5Mmxt2G4T=vfSSQQ@mail.gmail.com>
Message-ID: <CAD=FV=UXP+dfYEHpsS_djnWYxNVUS__2Uu5Mmxt2G4T=vfSSQQ@mail.gmail.com>
Subject: Re: [V2] tty: serial: qcom-geni-serial: Fix get_clk_div_rate() which
 otherwise could return a sub-optimal clock rate.
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Mukesh Savaliya (QUIC)" <quic_msavaliy@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 29, 2022 at 3:01 AM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> In the logic around call to clk_round_rate(), for some corner conditions,
> get_clk_div_rate() could return an sub-optimal clock rate. Also, if an
> exact clock rate was not found lowest clock was being returned.
>
> Search for suitable clock rate in 2 steps
> a) exact match or within 2% tolerance
> b) within 5% tolerance
> This also takes care of corner conditions.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: c2194bc999d4 ("tty: serial: qcom-geni-serial: Remove uart frequency table. Instead, find suitable frequency with call to clk_round_rate")
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
> v2: removed minor optimisations to make more readable
> v1: intial patch contained slightly complicated logic
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 122 +++++++++++++++++++++++++---------
>  1 file changed, 90 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 2e23b65..d0696d1 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -943,52 +943,111 @@ static int qcom_geni_serial_startup(struct uart_port *uport)
>         return 0;
>  }
>
> -static unsigned long get_clk_div_rate(struct clk *clk, unsigned int baud,
> -                       unsigned int sampling_rate, unsigned int *clk_div)
> +static unsigned long find_clk_rate_in_tol(struct clk *clk, unsigned int desired_clk,
> +                       unsigned int *clk_div, unsigned int percent_tol, bool exact_match)
>  {
> +       unsigned long freq;
> +       unsigned long div, maxdiv, new_div;
> +       u64 mult;
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
> +               mult = (u64)div * desired_clk;
> +               if (mult != (unsigned long)mult)
>                         break;
>
> -               freq = clk_round_rate(clk, (unsigned long)mult);
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
> +                       offset = div_u64(mult * percent_tol, 100);
> +
> +               test_freq = mult - offset;
> +               freq = clk_round_rate(clk, test_freq);
> +
> +               /*
> +                * A dead-on freq is an insta-win
> +                */
>                 if (!(freq % desired_clk)) {
>                         ser_clk = freq;
> -                       break;
> +                       *clk_div = freq / desired_clk;
> +                       return ser_clk;
>                 }
>
> -               if (!prev)
> -                       ser_clk = freq;
> -               else if (prev == freq)
> -                       break;
> +               if (!ser_clk) {
> +                       new_div = DIV_ROUND_CLOSEST(freq, desired_clk);
> +                       new_freq = new_div * desired_clk;
> +                       offset = (new_freq * percent_tol) / 100;

Can't you overflow in the above calculation? If "percent_tol" is 5
then anything over ~859 MHz would overflow. I guess it's not likely,
but since you take so much care elsewhere... Mabye this should be:

offset = div_u64((u64)new_freq * percent_tol, 100)


> +
> +                       if (new_freq - offset <= freq && freq <= new_freq + offset) {

This whole algorithm is predicated on clk_round_rate() only ever
rounding up. ...so you don't need to check if the clock is too low,
only if the clock is too high. Well, at least after you move the
"break" condition below to right after the clk_round_rate().


> +                               /* Save the first (lowest freq) within tolerance */
> +                               ser_clk = freq;
> +                               *clk_div = new_div;
> +                               /* no more search for exact match required in 2nd run */
> +                               if (!exact_match)
> +                                       break;
> +                       }
> +               }
>
> -               prev = freq;
> +               div = freq / desired_clk + 1;

Can't you infinite loop now?

Start with:

desired_clk = 10000
div = 1
percent_tol = 2


Now:

mult = 10000
offset = 200
test_freq = 9800
freq = 9800
div = 9800 / 10000 + 1 = 0 + 1 = 1

...and then you'll loop again with "div = 1", won't you? ...or did I
get something wrong in my analysis? This is the reason my proposed
algorithm had two loops.


> +               /*
> +                * Only time clock framework doesn't round up is if
> +                * we're past the max clock rate. We're done searching
> +                * if that's the case.
> +                */
> +               if (freq < test_freq)
> +                       break;

Why did you move this test to the end? It should be right after the
clk_round_rate(). If clk_round_rate() ever returns something lower
than the clock you asked for (which is the minimum tolerance that
we'll accept) then we can just bail out right away.


>         }
>
> -       if (!ser_clk) {
> -               pr_err("%s: Can't find matching DFS entry for baud %d\n",
> -                                                               __func__, baud);
> -               return ser_clk;
> +       return ser_clk;
> +}
> +
> +static unsigned long get_clk_div_rate(struct clk *clk, unsigned int baud,
> +                       unsigned int sampling_rate, unsigned int *clk_div)
> +{
> +       unsigned long ser_clk;
> +       unsigned long desired_clk;
> +
> +       desired_clk = baud * sampling_rate;
> +       if (!desired_clk) {
> +               pr_err("%s: Invalid frequency\n", __func__);
> +               return 0;
>         }
>
> -       *clk_div = ser_clk / desired_clk;
> -       if (!(*clk_div))
> -               *clk_div = 1;
> +       ser_clk = 0;

Get rid of this init of ser_clk to 0. It doesn't do anything.


> +       /*
> +        * try to find exact clock rate or within 2% tolerance,
> +        * then within 5% tolerance
> +        */
> +       ser_clk = find_clk_rate_in_tol(clk, desired_clk, clk_div, 2, true);
> +       if (!ser_clk)
> +               ser_clk = find_clk_rate_in_tol(clk, desired_clk, clk_div, 5, false);
> +
> +       if (!ser_clk)
> +               pr_err("Couldn't find suitable clock rate for %d\n", desired_clk);
> +       else
> +               pr_debug("desired_clk-%d, ser_clk-%d, clk_div-%d\n",
> +                       desired_clk, ser_clk, *clk_div);
>
>         return ser_clk;
>  }
> @@ -1021,8 +1080,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
>         if (ver >= QUP_SE_VERSION_2_5)
>                 sampling_rate /= 2;
>
> -       clk_rate = get_clk_div_rate(port->se.clk, baud,
> -               sampling_rate, &clk_div);
> +       clk_rate = get_clk_div_rate(port->se.clk, baud, sampling_rate, &clk_div);
>         if (!clk_rate)
>                 goto out_restart_rx;
>
> --
> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by the Linux Foundation.
>
