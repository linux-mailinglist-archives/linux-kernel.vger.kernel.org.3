Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E8453AA53
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355677AbiFAPjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245480AbiFAPjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:39:16 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3638125C5D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 08:39:15 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id s6so3366914lfo.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 08:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vRk6vGh4OfMebJCRUN5kYJGknCcMU4aXJTSlNgPPV/8=;
        b=dz0pNJaKv1dxbzo4juQ9Qea7coq/NfvPKfaWaZ3cTsCJFgxdHHo0i3kmtV/kijyBSM
         LzF2AeScklVgZakFDbWt9wKF4Oo7UX2o67OLZXbCOKSp1q5ka/v6z93T/hE663iEwQHX
         28gJrNT8FZ4I9Xm4jMQ2Njq3Gd8tKQYlLJRE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vRk6vGh4OfMebJCRUN5kYJGknCcMU4aXJTSlNgPPV/8=;
        b=c5/81WQPoTYSihZg0TQoT+WcSaMavKT3pT99c9NNRdhD0/XL5QvjLdg42lI6anOwp/
         WQZea5Rfr+6M1pEDXeGw6RXl6rYU/PkqdcSYvWktPnCjuHC4iLzeLkNpDw6NvGDjeVvX
         a5ImXP3c4ueeYMiJxuNzg/v2zAsaENMYiQBV4X84DGwDCx1Ux5VbIpowjlspEAyfyszf
         z7PhTVQE9J9m6Q21KkmZ3rHPSHhVVZ5WikZ415zcGGdgqCwj1vKBayVcSuvIIDabtbSq
         JRw6QqC/X1nuvXbMTcHdYkMa5ZZb9NFXLb7jNmkaK+eiSpywzGQyGVyQdJzztL2PQyHw
         t1sQ==
X-Gm-Message-State: AOAM531syXKpjl5YeHbqB5J7b5d3+vEYhhP5llIZJ2YwshJaiZu7w59X
        VVgGyMazQ9tsvi1SHCWAVRTLvPXsf8txxHM/
X-Google-Smtp-Source: ABdhPJwKpLA7yHlx6uRjV0M/x5xSdKq7dPr2yANZKDPGSxnVjFILPuFEGaPhVolUZH3bwnX2n+/jGw==
X-Received: by 2002:a17:906:9b86:b0:6fe:d37f:b29d with SMTP id dd6-20020a1709069b8600b006fed37fb29dmr58602ejc.327.1654097606855;
        Wed, 01 Jun 2022 08:33:26 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id gg1-20020a170906e28100b006f3ef214da9sm864704ejb.15.2022.06.01.08.33.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 08:33:25 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id x17so2878961wrg.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 08:33:25 -0700 (PDT)
X-Received: by 2002:a05:6000:1c03:b0:20e:5cac:1eb5 with SMTP id
 ba3-20020a0560001c0300b0020e5cac1eb5mr7850wrb.422.1654097604512; Wed, 01 Jun
 2022 08:33:24 -0700 (PDT)
MIME-Version: 1.0
References: <1654021066-13341-1-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=UF3x5RHrQH-m1X-4kQSsKiufLnkew=VuJz7W9EAi3GHQ@mail.gmail.com> <5d950007-7a92-a41b-e569-79e806adb06a@quicinc.com>
In-Reply-To: <5d950007-7a92-a41b-e569-79e806adb06a@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 1 Jun 2022 08:33:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xm1LJEoU5dKa5pMgqsHuAXuFVpdHvc1REULhAKTPbGnQ@mail.gmail.com>
Message-ID: <CAD=FV=Xm1LJEoU5dKa5pMgqsHuAXuFVpdHvc1REULhAKTPbGnQ@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: qcom-geni-serial: minor fixes to get_clk_div_rate()
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        quic_msavaliy@quicinc.com, Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 1, 2022 at 3:46 AM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> Hi,
>
> On 6/1/2022 12:58 AM, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, May 31, 2022 at 11:18 AM Vijaya Krishna Nivarthi
> > <quic_vnivarth@quicinc.com> wrote:
> >> Add missing initialisation and correct type casting
> >>
> >> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> >> ---
> >>   drivers/tty/serial/qcom_geni_serial.c | 8 ++++----
> >>   1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> >> index 4733a23..08f3ad4 100644
> >> --- a/drivers/tty/serial/qcom_geni_serial.c
> >> +++ b/drivers/tty/serial/qcom_geni_serial.c
> >> @@ -943,11 +943,11 @@ static int qcom_geni_serial_startup(struct uart_port *uport)
> >>   static unsigned long get_clk_div_rate(struct clk *clk, unsigned int baud,
> >>                          unsigned int sampling_rate, unsigned int *clk_div)
> >>   {
> >> -       unsigned long ser_clk;
> >> +       unsigned long ser_clk = 0;
> > In this patch it's not at all obvious why you'd need to init to 0. I
> > think the "for loop" is guaranteed to run at least once because
> > "max_div" is known at compile time. ...and currently each time through
> > the "for" loop you'll always set "ser_clk".
>
> Ok, I realised we will never break out of for loop exceeding ULONG_MAX
> in 1st pass, so yes ser_clk will always be set.
>
> > I think in a future patch you'll want to _remove_ this from the for loop:
> >
> > if (!prev)
> >    ser_clk = freq;
>
> Intent is to save (and use) 1st freq if we cannot find an exact divider.
>
> Isn't it ok?
>
> For example please find debug output for a required frequency of 51.2MHz.
>
> We try dividers 1, 2, 3 and end up with 52.1MHz the first result.
>
> [   18.815432] 20220509 get_clk_div_rate desired_clk:51200000
> [   18.821081] 20220509 get_clk_div_rate maxdiv:4095
> [   18.825924] 20220509 get_clk_div_rate div:1
> [   18.830239] 20220509 get_clk_div_rate freq:52174000
> [   18.835288] 20220509 get_clk_div_rate div:2
> [   18.839628] 20220509 get_clk_div_rate freq:100000000
> [   18.844794] 20220509 get_clk_div_rate div:3
> [   18.849119] 20220509 get_clk_div_rate freq:100000000
> [   18.854254] 20220509 get_clk_div_rate reached max frequency breaking...
> [   18.861072] 20220509 get_clk_div_rate clk_div=1, ser_clk=52174000
>
> The behaviour was same earlier too when root_freq table was present.

Are you certain about the behavior being the same earlier? Before
commit c2194bc999d4 ("tty: serial: qcom-geni-serial: Remove uart
frequency table..."), the behavior was that get_clk_cfg() would return
0 if there was no exact match. Then get_clk_div_rate() would see this
0 and print an error and return. Then the rest of
qcom_geni_serial_set_termios() would do nothing at all.

Ah, or I guess what you're saying is that the table historically
contained "rounded" rates but that clk_round_rate() isn't returning
nice round rates. OK, but if we truly want to support an inexact
match, you'd want to pick the rate that reduces the error, not just
pick the first one. In other words, something like this (untested):

freq = clk_round_rate(clk, mult);
diff = abs(((long)mult - freq) / div);
if (diff < best_diff) {
  best_diff = diff;
  ser_clk = freq;
  best_div = div;
}

Why do you need this? Imagine that the desired rate was 50000001 or
49999999. The closest match would be to use the rate 100000000 and
divide it by 2. ...but your existing algorithm would just arbitrarily
pick the first rate returned.

NOTE also that you could end up with a slightly higher or slightly
lower clock than requested, right? So it's important to:
* Do signed math when comparing.
* Save the "div" instead of trying to recompute it at the end.


> The table did contain 51.2MHz and we would exit with same but on call to
> clk_set_rate(51.2MHz) we were ending up with 52.1MHz
>
> >
> > ...and _that's_ when you should init "ser_clk" to 0. Until then I'd
> > leave it as uninitialized...
> >
> > Honestly, I'd throw all the fixes into one series, too.
>
> My concern was if there would be a requirement to split the changes.
>
> Will put in all in 1 series with Fixes tag.
>
> >
> >
> >>          unsigned long desired_clk;
> >>          unsigned long freq, prev;
> >>          unsigned long div, maxdiv;
> >> -       int64_t mult;
> >> +       unsigned long long mult;
> >>
> >>          desired_clk = baud * sampling_rate;
> >>          if (!desired_clk) {
> >> @@ -959,8 +959,8 @@ static unsigned long get_clk_div_rate(struct clk *clk, unsigned int baud,
> >>          prev = 0;
> >>
> >>          for (div = 1; div <= maxdiv; div++) {
> >> -               mult = div * desired_clk;
> >> -               if (mult > ULONG_MAX)
> >> +               mult = (unsigned long long)div * (unsigned long long)desired_clk;
> > I think you only need to cast one of the two. The other will be
> > up-cast automatically.
> Will change.
> >
> >
> >> +               if (mult > (unsigned long long)ULONG_MAX)
> > I don't think you need this cast. As far as I know the C language will
> > "upcast" to the larger of the two types.
> Will change.
> >
> >
> > -Doug
>
> Thank you.
>
> -Vijay/
>
