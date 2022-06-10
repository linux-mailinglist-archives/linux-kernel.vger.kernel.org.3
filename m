Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C270B546B97
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 19:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346855AbiFJRUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 13:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345071AbiFJRUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 13:20:49 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14922BDF
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 10:20:47 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x5so31069711edi.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 10:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qfQgXF3BjQHgKgwL1YdbeaEW6/52Ly7Lpz5CUFqFsEM=;
        b=NAloqdcvjhHsdzNQ1SubsI3WH73tzchSMgVC9yoEPsjjOfN5b6m9g1VHZuC1jhLZoa
         Tlf1hmf0u4i7OELZk4nLhyFtpUtfpDx/KPMyndFuUQEIrATDtE/I6i3glQg7GHYjfl7F
         Xy6YRH0yrdpeMWDqVPZRvGJFI6/tsr7beaapY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qfQgXF3BjQHgKgwL1YdbeaEW6/52Ly7Lpz5CUFqFsEM=;
        b=RQA0QZ/PGybGtnKtFO1JCYfJA4r/5Ld/VfD5DJ3LysPpeAEar1ZztL/FyTTMSE37U7
         IS4+d70XG24JDD1XaPteYU1d96Xm2SKhC4StL+cN0M5vtqVfVjJWyzenbtG//huja767
         ust1w7/OgBRPaAPac+6VBSoRtxoHLrkL+37PDl4mY0/Ms90iMcpHXh6fCPTd3QtWctC7
         XfalYXu4uzRJJ3kdsFOyV5cpoOqQYctsJtQcKFeRfW42MsHDyB9KQhVD1Sim8ZpJKOI0
         eG9q1kcvu82pzpwPokntPOkyZGw/Hcx5GFDxwQMCkE+MbO/UxWtYLnAV0QoLD3wM/2G1
         arUg==
X-Gm-Message-State: AOAM5300MqzOpP5zSacEct5x3UcFbv59S+S9wmqCVPaLDk1M1JYKsk+R
        AauYnlC1vCcCnjpVFPaa3dErESflEFXNHrWI
X-Google-Smtp-Source: ABdhPJz+HrYDfF+X28KY2ZbK1lp6/E9mxwaBESMUotr8x3Z9DrKgwPLG9xTScQrCgPMocSXmiXfm8A==
X-Received: by 2002:a05:6402:5c8:b0:433:545f:a811 with SMTP id n8-20020a05640205c800b00433545fa811mr5033984edx.101.1654881646199;
        Fri, 10 Jun 2022 10:20:46 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id hz10-20020a1709072cea00b0070e01426360sm10389721ejc.91.2022.06.10.10.20.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 10:20:44 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id c21so4277346wrb.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 10:20:43 -0700 (PDT)
X-Received: by 2002:a5d:6483:0:b0:20f:d046:6382 with SMTP id
 o3-20020a5d6483000000b0020fd0466382mr44849180wri.342.1654881643200; Fri, 10
 Jun 2022 10:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <1654021066-13341-1-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=UF3x5RHrQH-m1X-4kQSsKiufLnkew=VuJz7W9EAi3GHQ@mail.gmail.com>
 <5d950007-7a92-a41b-e569-79e806adb06a@quicinc.com> <CAD=FV=Xm1LJEoU5dKa5pMgqsHuAXuFVpdHvc1REULhAKTPbGnQ@mail.gmail.com>
 <ad393ad2-a247-3c61-5033-185d39b5596d@quicinc.com> <CAD=FV=XD+LozhkJZp0C7RUO01T-XuqBA-SJ0EQeyvGk0CxC3JQ@mail.gmail.com>
 <e677fd02-011f-4f4e-fa73-17dc96aea7d0@quicinc.com> <CAD=FV=UzjnEjMTLTRVXTrz6aoiBymJtnJ1o8dzPN9hn0Be3tng@mail.gmail.com>
 <da18c508-f32e-fece-6392-e6a95f7c7968@quicinc.com> <CAD=FV=Wytm9EYu=4ndN+En2AFEgPK9NjrUMbFPA_h6TwyxGCYA@mail.gmail.com>
 <765a170c-d335-d626-0609-7d0f3967b71d@quicinc.com> <CAD=FV=X2wTUH50MqFu=4WifvbTG+df-oYqQBRWeSPES7M2fxNw@mail.gmail.com>
 <BL0PR02MB45641E7841A666F867D0185EFAA69@BL0PR02MB4564.namprd02.prod.outlook.com>
In-Reply-To: <BL0PR02MB45641E7841A666F867D0185EFAA69@BL0PR02MB4564.namprd02.prod.outlook.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 10 Jun 2022 10:20:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WAEhncR462eT06KYuqmqx6QHb7wkvd1gxbsXqFRA06Ew@mail.gmail.com>
Message-ID: <CAD=FV=WAEhncR462eT06KYuqmqx6QHb7wkvd1gxbsXqFRA06Ew@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: qcom-geni-serial: minor fixes to get_clk_div_rate()
To:     "Vijaya Krishna Nivarthi (Temp) (QUIC)" <quic_vnivarth@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Mukesh Savaliya (QUIC)" <quic_msavaliy@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 10, 2022 at 2:33 AM Vijaya Krishna Nivarthi (Temp) (QUIC)
<quic_vnivarth@quicinc.com> wrote:
>
> Hi,
>
> Re-sending (2nd attempt) as emails are bouncing...
>
>
> > >
> > > But then once again, we would likely need 2 loops because while we are
> > > ok with giving up on search for best_div on finding something within
> > > 2% tolerance, we may not want to give up on exact match (freq %
> > > desired_clk == 0 )
> >
> > Ah, it took me a while to understand why two loops. It's because in one case
> > you're trying multiplies and in the other you're bumping up to the next
> > closest clock rate. I don't think you really need to do that. Just test the (rate -
> > 2%) and the rate. How about this (only lightly tested):
> >
> >     ser_clk = 0;
> >     maxdiv = CLK_DIV_MSK >> CLK_DIV_SHFT;
> >     div = 1;
> >     while (div < maxdiv) {
>
>
> div <= maxdiv ?

Ah, sure.


> >         mult = (unsigned long long)div * desired_clk;
> >         if (mult != (unsigned long)mult)
> >             break;
> >
> >         two_percent = mult / 50;
> >
> >         /*
> >          * Loop requesting (freq - 2%) and possibly (freq).
> >          *
> >          * We'll keep track of the lowest freq inexact match we found
> >          * but always try to find a perfect match. NOTE: this algorithm
> >          * could miss a slightly better freq if there's more than one
> >          * freq between (freq - 2%) and (freq) but (freq) can't be made
> >          * exactly, but that's OK.
> >          *
> >          * This absolutely relies on the fact that the Qualcomm clock
> >          * driver always rounds up.
> >          */
> >         test_freq = mult - two_percent;
> >         while (test_freq <= mult) {
> >             freq = clk_round_rate(clk, test_freq);
> >
> >             /*
> >              * A dead-on freq is an insta-win. This implicitly
> >              * handles when "freq == mult"
> >              */
> >             if (!(freq % desired_clk)) {
> >                 *clk_div = freq / desired_clk;
> >                 return freq;
> >             }
> >
> >             /*
> >              * Only time clock framework doesn't round up is if
> >              * we're past the max clock rate. We're done searching
> >              * if that's the case.
> >              */
> >             if (freq < test_freq)
> >                 return ser_clk;
> >
> >             /* Save the first (lowest freq) within 2% */
> >             if (!ser_clk && freq <= mult + two_percent) {
> >                 ser_clk = freq;
> >                 *clk_div = div;
> >             }
>
> My last concern is with search happening only within 2% tolerance.
> Do we fail otherwise?
>
> This real case has best tolerance of 1.9% and seems close.
>
> [   17.963672] 20220530 desired_clk-51200000
> [   21.193550] 20220530 returning ser_clk-52174000, div-1, diff-974000
>
> Perhaps we can fallback on 1st clock rate?

I don't feel super comfortable just blindly falling back on the 1st
clock rate. It could be wildly (more than 5%) wrong, can't it?

IMO:
* If you're not comfortable with 2%, you could always pick 3% or 4%.
As I said, my random web search seemed to indicate that up to 5% was
perhaps OK.
* It's probably overkill, but you could abstract the whole search out
and try searching once for 2% and then try 4%?


-Doug
