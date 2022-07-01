Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C5556369F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 17:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbiGAPIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 11:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbiGAPI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 11:08:29 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F921E3D3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 08:08:27 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id ej4so3319378edb.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 08:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hcqXoCNvopDleGLSFa51dBpHMpht82Uknafvcf4bZng=;
        b=FnCQrXwQdAiXkOt/d6R3dlF07Pr1NY6YMhAmFdxndaf4FP+XDLdXscmAl1od0umUx+
         vYOZ20u6Uyd3JQVR8/96RimEAKFLUo/4ptLmCfYTdMR0TEo1Uqt6DxgEzj8/GXveNISa
         wFHck2YTDwbdD5Dwh1LhfYQnHXn849zwAhYxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hcqXoCNvopDleGLSFa51dBpHMpht82Uknafvcf4bZng=;
        b=OeMtwgUwkeUrzsva9pR2G8JUfFb4zVZZbj9Qhih0I0nywYMzLpjD0pV4R6V0PPrYIn
         wBfukQGZgVbJbCpZdZnmTfcD+MBxd/pojAQgEc43WvnZcRjC2VfHRroGo13bIjtnpNWM
         nuFeeupxKJetV1Aadvci0XMgJV1kpexoWJxx/+V7SevT7mSQ+YYwC0MXYbShspZAq6dU
         ynTvke/hVxK94kwZ68WE1Y1SHXSz7xnQgM7KmdkN/q0frnfAkmGJP3OoI6tCQdhPW7Ul
         xFFykPhPmWuMyHsuNuJL2DHsN2yH4jRLkAQlJM4XB8m7DFD+RUXzmJXISo0q/xy3JXDN
         8dfA==
X-Gm-Message-State: AJIora8QCo/9UhgkyB4SpcnxtJGaGGuAYNVefjHjTDIXQWnCiOpSgFik
        pRuWR0v0oqtOd2+ptInHMg01jVvwoqqja/cQ
X-Google-Smtp-Source: AGRyM1uWzFXwWvOEvC/yyTjv8Y31D1C2MyPIx35Zm0idMl5hU1O7cyxhahEBC1hX3w4BXVeq1eTisg==
X-Received: by 2002:a05:6402:11:b0:431:680c:cca1 with SMTP id d17-20020a056402001100b00431680ccca1mr20097402edu.420.1656688106180;
        Fri, 01 Jul 2022 08:08:26 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id s12-20020a170906354c00b0072637b9c8c0sm9777466eja.219.2022.07.01.08.08.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 08:08:24 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id o16-20020a05600c379000b003a02eaea815so4209537wmr.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 08:08:23 -0700 (PDT)
X-Received: by 2002:a05:600c:3ace:b0:3a0:4ea4:5f77 with SMTP id
 d14-20020a05600c3ace00b003a04ea45f77mr16937352wms.57.1656688103060; Fri, 01
 Jul 2022 08:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <1656496841-5853-1-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=UXP+dfYEHpsS_djnWYxNVUS__2Uu5Mmxt2G4T=vfSSQQ@mail.gmail.com> <BL0PR02MB4564A1EC37911A464BBEC260FABD9@BL0PR02MB4564.namprd02.prod.outlook.com>
In-Reply-To: <BL0PR02MB4564A1EC37911A464BBEC260FABD9@BL0PR02MB4564.namprd02.prod.outlook.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 1 Jul 2022 08:08:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XCgsyTRT-T5jKN6c7tJ=du8gbpkMccm2VZpz+TFWyLsw@mail.gmail.com>
Message-ID: <CAD=FV=XCgsyTRT-T5jKN6c7tJ=du8gbpkMccm2VZpz+TFWyLsw@mail.gmail.com>
Subject: Re: [V2] tty: serial: qcom-geni-serial: Fix get_clk_div_rate() which
 otherwise could return a sub-optimal clock rate.
To:     "Vijaya Krishna Nivarthi (Temp) (QUIC)" <quic_vnivarth@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
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

On Fri, Jul 1, 2022 at 4:04 AM Vijaya Krishna Nivarthi (Temp) (QUIC)
<quic_vnivarth@quicinc.com> wrote:
>
> Hi,
>
>
> > -----Original Message-----
> > From: Doug Anderson <dianders@chromium.org>
> > Sent: Thursday, June 30, 2022 4:45 AM
> > To: Vijaya Krishna Nivarthi (Temp) (QUIC) <quic_vnivarth@quicinc.com>
> > Cc: Andy Gross <agross@kernel.org>; bjorn.andersson@linaro.org; Konrad
> > Dybcio <konrad.dybcio@somainline.org>; Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org>; Jiri Slaby <jirislaby@kernel.org>; linux-arm-
> > msm <linux-arm-msm@vger.kernel.org>; linux-serial@vger.kernel.org; LKML
> > <linux-kernel@vger.kernel.org>; Mukesh Savaliya (QUIC)
> > <quic_msavaliy@quicinc.com>; Matthias Kaehlcke <mka@chromium.org>;
> > Stephen Boyd <swboyd@chromium.org>
> > Subject: Re: [V2] tty: serial: qcom-geni-serial: Fix get_clk_div_rate() which
> > otherwise could return a sub-optimal clock rate.
> >
> >
> >
> > > +                               /* Save the first (lowest freq) within tolerance */
> > > +                               ser_clk = freq;
> > > +                               *clk_div = new_div;
> > > +                               /* no more search for exact match required in 2nd run */
> > > +                               if (!exact_match)
> > > +                                       break;
> > > +                       }
> > > +               }
> > >
> > > -               prev = freq;
> > > +               div = freq / desired_clk + 1;
> >
> > Can't you infinite loop now?
> >
> > Start with:
> >
> > desired_clk = 10000
> > div = 1
> > percent_tol = 2
> >
> >
> > Now:
> >
> > mult = 10000
> > offset = 200
> > test_freq = 9800
> > freq = 9800
> > div = 9800 / 10000 + 1 = 0 + 1 = 1
> >
> > ...and then you'll loop again with "div = 1", won't you? ...or did I get
> > something wrong in my analysis? This is the reason my proposed algorithm
> > had two loops.
> >
> >
>
> I went back to your proposed algorithm and made couple of simple changes, and it seemed like what we need.
>
> a) look only for exact match once a clock rate within tolerance is found
> b) swap test_freq and freq at end of while loops to make it run as desired
>
>
>         maxdiv = CLK_DIV_MSK >> CLK_DIV_SHFT;
>         div = 1;
>
>         while (div < maxdiv) {
>                 mult = (unsigned long long)div * desired_clk;
>                 if (mult != (unsigned long)mult)
>                         break;
>
>                 if (ser_clk)
>                         offset = 0;
>                 ===================a=====================
>                 else
>                         offset = div_u64(mult * percent_tol, 100);
>
>                 /*
>                  * Loop requesting (freq - 2%) and possibly (freq).
>                  *
>                  * We'll keep track of the lowest freq inexact match we found
>                  * but always try to find a perfect match. NOTE: this algorithm
>                  * could miss a slightly better freq if there's more than one
>                  * freq between (freq - 2%) and (freq) but (freq) can't be made
>                  * exactly, but that's OK.
>                  *
>                  * This absolutely relies on the fact that the Qualcomm clock
>                  * driver always rounds up.
>                  */
>                 test_freq = mult - offset;
>                 while (test_freq <= mult) {
>                         freq = clk_round_rate(clk, test_freq);
>
>                         /*
>                          * A dead-on freq is an insta-win. This implicitly
>                          * handles when "freq == mult"
>                          */
>                         if (!(freq % desired_clk)) {
>                                 *clk_div = freq / desired_clk;
>                                 return freq;
>                         }
>
>                         /*
>                          * Only time clock framework doesn't round up is if
>                          * we're past the max clock rate. We're done searching
>                          * if that's the case.
>                          */
>                         if (freq < test_freq)
>                                 return ser_clk;
>
>                         /* Save the first (lowest freq) within tolerance */
>                         if (!ser_clk && freq <= mult + offset) {
>                                 ser_clk = freq;
>                                 *clk_div = div;
>                         }
>
>                         /*
>                          * If we already rounded up past mult then this will
>                          * cause the loop to exit. If not then this will run
>                          * the loop a second time with exactly mult.
>                          */
>                         test_freq = max(test_freq + 1, mult);
>                                                      ====b====
>                 }
>
>                 /*
>                  * freq will always be bigger than mult by at least 1.
>                  * That means we can get the next divider with a DIV_ROUND_UP.
>                  * This has the advantage of skipping by a whole bunch of divs
>                  * If the clock framework already bypassed them.
>                  */
>                 div = DIV_ROUND_UP(freq, desired_clk);
>                                                        ===b==
>         }
>
>
> Will also drop exact_match now.
>
> Will upload v3 after testing.

The more I've been thinking about it, the more I wonder if we even
need the special case of looking for an exact match at all. It feels
like we should choose one: we either look for the best match or we
look for the one with the lowest clock source rate. The weird
half-half approach that we have right now feels like over-engineering
and complicates things.

How about this (again, only lightly tested). Worst case if we _truly_
need a close-to-exact match we could pass a tolerance of 0 in and we'd
get something that's nearly exact, though I'm not suggesting we
actually do that. If we think 2% is good enough then we should just
accept the first (and lowest clock rate) 2% match we find.

    abs_tol = div_u64((u64)desired_clk * percent_tol, 100);
    maxdiv = CLK_DIV_MSK >> CLK_DIV_SHFT;
    div = 1;
    while (div <= maxdiv) {
        mult = (u64)div * desired_clk;
        if (mult != (unsigned long)mult)
            break;

        offset = div * abs_tol;
        freq = clk_round_rate(clk, mult - offset);

        /* Can only get lower if we're done */
        if (freq < mult - offset)
            break;

        /*
         * Re-calculate div in case rounding skipped rates but we
         * ended up at a good one, then check for a match.
         */
        div = DIV_ROUND_CLOSEST(freq, desired_clk);
        achieved = DIV_ROUND_CLOSEST(freq, div);
        if (achieved <= desired_clk + abs_tol &&
            achieved >= desired_clk - abs_tol) {
            *clk_div = div;
            return freq;
        }

        /*
         * Always increase div by at least one, but we'll go more than
         * one if clk_round_rate() gave us something higher.
         */
        div = DIV_ROUND_UP(max(freq, (unsigned long)mult) + 1, desired_clk);
        }

    return 0;
