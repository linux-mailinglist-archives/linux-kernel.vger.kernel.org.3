Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F3E53D1B0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 20:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347337AbiFCSlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 14:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347185AbiFCSlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 14:41:07 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD15113F24
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 11:41:02 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id s12so10352210ejx.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 11:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tfgEy8ixZ6ZzG1hX+J5dmstu4VMvlofoo5oVk+gJTR8=;
        b=kcuuIcWkvTicxyS6+1Qm10WySwzUgBbgzqKYnkoOn+hSvpBe38/geO1lkJMb8mUr8L
         T8SHAMd11ekLrMve/ISmr+jz5hBW7tL7PpoHzYoI4BtRfSQHWqnv8XuwDoJJ3XPAwYO7
         Y7rMgLMQTUk7KpcezfBiGWmJgc8dvdS7hEOxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tfgEy8ixZ6ZzG1hX+J5dmstu4VMvlofoo5oVk+gJTR8=;
        b=Mtx9zNyeFsijlF1fRngR0KBzd9LPsZ7p25Dk7jvfeccBP1vL3cmqEzzYdLhU5HJXC4
         TEqJ8IiVQPT1rS5q+6qxa5KwHtFo7VA8K2U86DvI4PBxc1KrRL1m/UXzOXVwdd5pAqTZ
         wmAwv9taS08ru2oe7/75jhi0F0QxTTmxsUu4Y4J21qJvZFpXGn+6k4bdxyeddSz4Wmlf
         ueTT0ZWqIu9qMFkUFiry86b6embu/yenZze6iPffz1QWc3gT5PQLt3pdumTMikWFyfQO
         EljlorBdJ6lyFHr+z0DQXA9Qasp61po+8/NRJ2kTemIBNqT+9nmofHxMS3HbRkIUQi34
         VC1Q==
X-Gm-Message-State: AOAM532NjrGbSfwyd4+NpKX8ToYeNRGnBbWhQanMVu374VwixcSjir2L
        d4FnxUoG7SXhO3BOPj8Q3K8hqvAtN3MtcroI/t8=
X-Google-Smtp-Source: ABdhPJyGqqlx/rYFLT8KGAlpvSJDDhP81VYM5+pUlm+QQur7SGd13F/nDmy5R2wDVHWp1JCW24sVOQ==
X-Received: by 2002:a17:907:62a0:b0:6fe:69f3:88de with SMTP id nd32-20020a17090762a000b006fe69f388demr9595981ejc.214.1654281661047;
        Fri, 03 Jun 2022 11:41:01 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id k9-20020a1709061c0900b006fec27575f1sm3068849ejg.123.2022.06.03.11.40.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 11:40:59 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id u8so7120778wrm.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 11:40:58 -0700 (PDT)
X-Received: by 2002:a05:6000:1842:b0:210:3d62:2768 with SMTP id
 c2-20020a056000184200b002103d622768mr9493879wri.301.1654281657955; Fri, 03
 Jun 2022 11:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <1654021066-13341-1-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=UF3x5RHrQH-m1X-4kQSsKiufLnkew=VuJz7W9EAi3GHQ@mail.gmail.com>
 <5d950007-7a92-a41b-e569-79e806adb06a@quicinc.com> <CAD=FV=Xm1LJEoU5dKa5pMgqsHuAXuFVpdHvc1REULhAKTPbGnQ@mail.gmail.com>
 <ad393ad2-a247-3c61-5033-185d39b5596d@quicinc.com>
In-Reply-To: <ad393ad2-a247-3c61-5033-185d39b5596d@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 3 Jun 2022 11:40:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XD+LozhkJZp0C7RUO01T-XuqBA-SJ0EQeyvGk0CxC3JQ@mail.gmail.com>
Message-ID: <CAD=FV=XD+LozhkJZp0C7RUO01T-XuqBA-SJ0EQeyvGk0CxC3JQ@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 3, 2022 at 10:43 AM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> Hi,
>
>
> On 6/1/2022 9:03 PM, Doug Anderson wrote:
> > Hi,
> >
> > On Wed, Jun 1, 2022 at 3:46 AM Vijaya Krishna Nivarthi
> > <quic_vnivarth@quicinc.com> wrote:
> >> Hi,
> >>
> >> On 6/1/2022 12:58 AM, Doug Anderson wrote:
> >>> Hi,
> >>>
> >>> On Tue, May 31, 2022 at 11:18 AM Vijaya Krishna Nivarthi
> >>> <quic_vnivarth@quicinc.com> wrote:
> >>>> Add missing initialisation and correct type casting
> >>>>
> >>>> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> >>>> ---
> >>>>    drivers/tty/serial/qcom_geni_serial.c | 8 ++++----
> >>>>    1 file changed, 4 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> >>>> index 4733a23..08f3ad4 100644
> >>>> --- a/drivers/tty/serial/qcom_geni_serial.c
> >>>> +++ b/drivers/tty/serial/qcom_geni_serial.c
> >>>> @@ -943,11 +943,11 @@ static int qcom_geni_serial_startup(struct uart_port *uport)
> >>>>    static unsigned long get_clk_div_rate(struct clk *clk, unsigned int baud,
> >>>>                           unsigned int sampling_rate, unsigned int *clk_div)
> >>>>    {
> >>>> -       unsigned long ser_clk;
> >>>> +       unsigned long ser_clk = 0;
> >>> In this patch it's not at all obvious why you'd need to init to 0. I
> >>> think the "for loop" is guaranteed to run at least once because
> >>> "max_div" is known at compile time. ...and currently each time through
> >>> the "for" loop you'll always set "ser_clk".
> >> Ok, I realised we will never break out of for loop exceeding ULONG_MAX
> >> in 1st pass, so yes ser_clk will always be set.
> >>
> >>> I think in a future patch you'll want to _remove_ this from the for loop:
> >>>
> >>> if (!prev)
> >>>     ser_clk = freq;
> >> Intent is to save (and use) 1st freq if we cannot find an exact divider.
> >>
> >> Isn't it ok?
> >>
> >> For example please find debug output for a required frequency of 51.2MHz.
> >>
> >> We try dividers 1, 2, 3 and end up with 52.1MHz the first result.
> >>
> >> [   18.815432] 20220509 get_clk_div_rate desired_clk:51200000
> >> [   18.821081] 20220509 get_clk_div_rate maxdiv:4095
> >> [   18.825924] 20220509 get_clk_div_rate div:1
> >> [   18.830239] 20220509 get_clk_div_rate freq:52174000
> >> [   18.835288] 20220509 get_clk_div_rate div:2
> >> [   18.839628] 20220509 get_clk_div_rate freq:100000000
> >> [   18.844794] 20220509 get_clk_div_rate div:3
> >> [   18.849119] 20220509 get_clk_div_rate freq:100000000
> >> [   18.854254] 20220509 get_clk_div_rate reached max frequency breaking...
> >> [   18.861072] 20220509 get_clk_div_rate clk_div=1, ser_clk=52174000
> >>
> >> The behaviour was same earlier too when root_freq table was present.
> > Are you certain about the behavior being the same earlier? Before
> > commit c2194bc999d4 ("tty: serial: qcom-geni-serial: Remove uart
> > frequency table..."), the behavior was that get_clk_cfg() would return
> > 0 if there was no exact match. Then get_clk_div_rate() would see this
> > 0 and print an error and return. Then the rest of
> > qcom_geni_serial_set_termios() would do nothing at all.
> >
> > Ah, or I guess what you're saying is that the table historically
> > contained "rounded" rates but that clk_round_rate() isn't returning
> > nice round rates. OK, but if we truly want to support an inexact
> > match, you'd want to pick the rate that reduces the error, not just
> > pick the first one. In other words, something like this (untested):
> >
> > freq = clk_round_rate(clk, mult);
> > diff = abs(((long)mult - freq) / div);
> > if (diff < best_diff) {
> >    best_diff = diff;
> >    ser_clk = freq;
> >    best_div = div;
> > }
> I am not sure if its required that freq is a multiple of best_div now
> that we don't have a multiple of desired_clk anyway.

How about just this (untested):

freq = clk_round_rate(clk, mult);
candidate_div = max(1, DIV_ROUND_CLOSEST(freq, desired_clk));
candidate_freq = freq / candidate_div;
diff = abs((long)desired_clk - candidate_freq);
if (diff < best_diff) {
  best_diff = diff;
  ser_clk = freq;
  best_div = candidate_div;
}

Here:

freq: a freq we can definitely make

candidate_div: the best number to divide freq by to get the desired clock.

candidate_freq: the frequency we'll end up if we divide freq by
candidate_div. We want this to be close to desired_clk.

diff: how far away the candidate_freq is away from what we want.

best_diff: how far away the best candidate was from what we wanted.

ser_clk: What we should pass to clk_set_rate() to get the best candidate.

best_div: What we should use as a divider to get the best candidate.


-Doug
