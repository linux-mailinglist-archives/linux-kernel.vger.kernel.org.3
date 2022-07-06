Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2B95691A2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbiGFSWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbiGFSV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:21:57 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D70275DF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 11:21:55 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z41so20351078ede.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 11:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jTCcnXwrbvC9f2vkYBP1n1zMmWAv12/HjslqX/s4eDw=;
        b=mJfU2hQC7iIBESYayCWOUCu/+eqdhnay4juHkR2cK3MObVEAgnDTvJg70J3aFQZk4q
         3eKiqsOAFWoThsdmC3u0rQ2XhTBN/fjYz7oAKrBkoep+Ss8+FV6QjFK3Yt3qsrD1Olwi
         +AdWNRtfEIafRh3yHV24+bvzLRPwriahB8VK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jTCcnXwrbvC9f2vkYBP1n1zMmWAv12/HjslqX/s4eDw=;
        b=gOtk/mNOea4i7rKrsA4A5xqQ1wNcgsShSAj5EwKfwqQsqmf8MMLDonjMxyc0yWO6cp
         oC+6Xl1AjcB3XPzzIf7XBj3C28zdh1PoTuHuxLT7SGtR9ITNhnSGF8Qf0Ti3mpUhBWgI
         aVzSB1qe7F6TWf1qFZ6Fd5ev+ZGjibCUCgQIwMDCY4snsGaJ9Zk8HFsyqy0u32qnHE5i
         5IYe36pe5MwllaTGTOmhVUChA0ckIbCeTEk2tbII3XbaEiuQlCc1LjhaxKhuA/U0v6JO
         5kwjSVUbyuJBDIxlBY6b6G1JOcVbfMlIhTM5C6KzNzfVQxrXAt4hPjx9vvmz9BpLXqyQ
         AxVQ==
X-Gm-Message-State: AJIora9kxYR6bUd6rY3wxJdq1uley2GuKeiBoQPC7hErBTPl2DvBjPQZ
        wRBsygKK2yhg3yuytaUts16S9noQOM2/ygpm
X-Google-Smtp-Source: AGRyM1vTod+X6C4oJ/osLF03sXkBD6Ll0MZWS5n/70eqkCHZXpc6OoA3jqEPf/71z4hYDWN/NMF+aQ==
X-Received: by 2002:a05:6402:3454:b0:43a:86c8:637 with SMTP id l20-20020a056402345400b0043a86c80637mr7616192edc.393.1657131713892;
        Wed, 06 Jul 2022 11:21:53 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id 21-20020a170906301500b00728f6d4d0d7sm10988915ejz.67.2022.07.06.11.21.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 11:21:51 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id r14so17412966wrg.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 11:21:50 -0700 (PDT)
X-Received: by 2002:adf:d1e9:0:b0:21b:c8f8:3c16 with SMTP id
 g9-20020adfd1e9000000b0021bc8f83c16mr37736518wrd.659.1657131710095; Wed, 06
 Jul 2022 11:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <1656496841-5853-1-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=UXP+dfYEHpsS_djnWYxNVUS__2Uu5Mmxt2G4T=vfSSQQ@mail.gmail.com>
 <BL0PR02MB4564A1EC37911A464BBEC260FABD9@BL0PR02MB4564.namprd02.prod.outlook.com>
 <CAD=FV=XCgsyTRT-T5jKN6c7tJ=du8gbpkMccm2VZpz+TFWyLsw@mail.gmail.com>
 <BL0PR02MB45643EEB3C1571E0F2364B8FFABE9@BL0PR02MB4564.namprd02.prod.outlook.com>
 <CAD=FV=Up_NNd5RNJ+xLrPOHfPb_YG1ut=BjU=O2yP8w2hG9Ugw@mail.gmail.com> <69e3fec3-bd49-8877-f1f8-453b09b8c940@quicinc.com>
In-Reply-To: <69e3fec3-bd49-8877-f1f8-453b09b8c940@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 6 Jul 2022 11:21:36 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VhA=iGnip_DOdNOZn_mjqgC=37o4tWFQXNpTAqf=09sA@mail.gmail.com>
Message-ID: <CAD=FV=VhA=iGnip_DOdNOZn_mjqgC=37o4tWFQXNpTAqf=09sA@mail.gmail.com>
Subject: Re: [V2] tty: serial: qcom-geni-serial: Fix get_clk_div_rate() which
 otherwise could return a sub-optimal clock rate.
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     "Vijaya Krishna Nivarthi (Temp)" <vnivarth@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 6, 2022 at 10:44 AM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> Hi,
>
>
> On 7/6/2022 8:56 PM, Doug Anderson wrote:
> > Hi,
> >
> > On Mon, Jul 4, 2022 at 11:57 AM Vijaya Krishna Nivarthi (Temp)
> > <vnivarth@qti.qualcomm.com> wrote:
> >> Hi,
> >>
> >>
> >>> -----Original Message-----
> >>> From: Doug Anderson <dianders@chromium.org>
> >>> Sent: Friday, July 1, 2022 8:38 PM
> >>> To: Vijaya Krishna Nivarthi (Temp) (QUIC) <quic_vnivarth@quicinc.com>
> >>> Cc: Andy Gross <agross@kernel.org>; bjorn.andersson@linaro.org; Konra=
d
> >>> Dybcio <konrad.dybcio@somainline.org>; Greg Kroah-Hartman
> >>> <gregkh@linuxfoundation.org>; Jiri Slaby <jirislaby@kernel.org>; linu=
x-arm-
> >>> msm <linux-arm-msm@vger.kernel.org>; linux-serial@vger.kernel.org; LK=
ML
> >>> <linux-kernel@vger.kernel.org>; Mukesh Savaliya (QUIC)
> >>> <quic_msavaliy@quicinc.com>; Matthias Kaehlcke <mka@chromium.org>;
> >>> Stephen Boyd <swboyd@chromium.org>
> >>> Subject: Re: [V2] tty: serial: qcom-geni-serial: Fix get_clk_div_rate=
() which
> >>> otherwise could return a sub-optimal clock rate.
> >>>
> >>> WARNING: This email originated from outside of Qualcomm. Please be wa=
ry
> >>> of any links or attachments, and do not enable macros.
> >>>
> >>> Hi,
> >>>
> >>> On Fri, Jul 1, 2022 at 4:04 AM Vijaya Krishna Nivarthi (Temp) (QUIC)
> >>> <quic_vnivarth@quicinc.com> wrote:
> >>>> Hi,
> >>>>
> >>>>
> >>>>> -----Original Message-----
> >>>>> From: Doug Anderson <dianders@chromium.org>
> >>>>> Sent: Thursday, June 30, 2022 4:45 AM
> >>>>> To: Vijaya Krishna Nivarthi (Temp) (QUIC)
> >>>>> <quic_vnivarth@quicinc.com>
> >>>>> Cc: Andy Gross <agross@kernel.org>; bjorn.andersson@linaro.org;
> >>>>> Konrad Dybcio <konrad.dybcio@somainline.org>; Greg Kroah-Hartman
> >>>>> <gregkh@linuxfoundation.org>; Jiri Slaby <jirislaby@kernel.org>;
> >>>>> linux-arm- msm <linux-arm-msm@vger.kernel.org>;
> >>>>> linux-serial@vger.kernel.org; LKML <linux-kernel@vger.kernel.org>;
> >>>>> Mukesh Savaliya (QUIC) <quic_msavaliy@quicinc.com>; Matthias
> >>>>> Kaehlcke <mka@chromium.org>; Stephen Boyd
> >>> <swboyd@chromium.org>
> >>>>> Subject: Re: [V2] tty: serial: qcom-geni-serial: Fix
> >>>>> get_clk_div_rate() which otherwise could return a sub-optimal clock=
 rate.
> >>>>>
> >>>>>
> >>>>>
> >>>>>> +                               /* Save the first (lowest freq) wi=
thin tolerance */
> >>>>>> +                               ser_clk =3D freq;
> >>>>>> +                               *clk_div =3D new_div;
> >>>>>> +                               /* no more search for exact match =
required in 2nd run
> >>> */
> >>>>>> +                               if (!exact_match)
> >>>>>> +                                       break;
> >>>>>> +                       }
> >>>>>> +               }
> >>>>>>
> >>>>>> -               prev =3D freq;
> >>>>>> +               div =3D freq / desired_clk + 1;
> >>>>> Can't you infinite loop now?
> >>>>>
> >>>>> Start with:
> >>>>>
> >>>>> desired_clk =3D 10000
> >>>>> div =3D 1
> >>>>> percent_tol =3D 2
> >>>>>
> >>>>>
> >>>>> Now:
> >>>>>
> >>>>> mult =3D 10000
> >>>>> offset =3D 200
> >>>>> test_freq =3D 9800
> >>>>> freq =3D 9800
> >>>>> div =3D 9800 / 10000 + 1 =3D 0 + 1 =3D 1
> >>>>>
> >>>>> ...and then you'll loop again with "div =3D 1", won't you? ...or di=
d I
> >>>>> get something wrong in my analysis? This is the reason my proposed
> >>>>> algorithm had two loops.
> >>>>>
> >>>>>
> >>>> I went back to your proposed algorithm and made couple of simple
> >>> changes, and it seemed like what we need.
> >>>> a) look only for exact match once a clock rate within tolerance is
> >>>> found
> >>>> b) swap test_freq and freq at end of while loops to make it run as
> >>>> desired
> >>>>
> >>>>
> >>>>          maxdiv =3D CLK_DIV_MSK >> CLK_DIV_SHFT;
> >>>>          div =3D 1;
> >>>>
> >>>>          while (div < maxdiv) {
> >>>>                  mult =3D (unsigned long long)div * desired_clk;
> >>>>                  if (mult !=3D (unsigned long)mult)
> >>>>                          break;
> >>>>
> >>>>                  if (ser_clk)
> >>>>                          offset =3D 0;
> >>>>                  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3Da=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>                  else
> >>>>                          offset =3D div_u64(mult * percent_tol, 100)=
;
> >>>>
> >>>>                  /*
> >>>>                   * Loop requesting (freq - 2%) and possibly (freq).
> >>>>                   *
> >>>>                   * We'll keep track of the lowest freq inexact matc=
h we found
> >>>>                   * but always try to find a perfect match. NOTE: th=
is algorithm
> >>>>                   * could miss a slightly better freq if there's mor=
e than one
> >>>>                   * freq between (freq - 2%) and (freq) but (freq) c=
an't be made
> >>>>                   * exactly, but that's OK.
> >>>>                   *
> >>>>                   * This absolutely relies on the fact that the Qual=
comm clock
> >>>>                   * driver always rounds up.
> >>>>                   */
> >>>>                  test_freq =3D mult - offset;
> >>>>                  while (test_freq <=3D mult) {
> >>>>                          freq =3D clk_round_rate(clk, test_freq);
> >>>>
> >>>>                          /*
> >>>>                           * A dead-on freq is an insta-win. This imp=
licitly
> >>>>                           * handles when "freq =3D=3D mult"
> >>>>                           */
> >>>>                          if (!(freq % desired_clk)) {
> >>>>                                  *clk_div =3D freq / desired_clk;
> >>>>                                  return freq;
> >>>>                          }
> >>>>
> >>>>                          /*
> >>>>                           * Only time clock framework doesn't round =
up is if
> >>>>                           * we're past the max clock rate. We're don=
e searching
> >>>>                           * if that's the case.
> >>>>                           */
> >>>>                          if (freq < test_freq)
> >>>>                                  return ser_clk;
> >>>>
> >>>>                          /* Save the first (lowest freq) within tole=
rance */
> >>>>                          if (!ser_clk && freq <=3D mult + offset) {
> >>>>                                  ser_clk =3D freq;
> >>>>                                  *clk_div =3D div;
> >>>>                          }
> >>>>
> >>>>                          /*
> >>>>                           * If we already rounded up past mult then =
this will
> >>>>                           * cause the loop to exit. If not then this=
 will run
> >>>>                           * the loop a second time with exactly mult=
.
> >>>>                           */
> >>>>                          test_freq =3D max(test_freq + 1, mult);
> >>>>                                                       =3D=3D=3D=3Db=
=3D=3D=3D=3D
> >>>>                  }
> >>>>
> >>>>                  /*
> >>>>                   * freq will always be bigger than mult by at least=
 1.
> >>>>                   * That means we can get the next divider with a DI=
V_ROUND_UP.
> >>>>                   * This has the advantage of skipping by a whole bu=
nch of divs
> >>>>                   * If the clock framework already bypassed them.
> >>>>                   */
> >>>>                  div =3D DIV_ROUND_UP(freq, desired_clk);
> >>>>                                                         =3D=3D=3Db=
=3D=3D
> >>>>          }
> >>>>
> >>>>
> >>>> Will also drop exact_match now.
> >>>>
> >>>> Will upload v3 after testing.
> >>> The more I've been thinking about it, the more I wonder if we even ne=
ed the
> >>> special case of looking for an exact match at all. It feels like we s=
hould choose
> >>> one: we either look for the best match or we look for the one with th=
e
> >>> lowest clock source rate. The weird half-half approach that we have r=
ight
> >>> now feels like over-engineering and complicates things.
> >>>
> >>> How about this (again, only lightly tested). Worst case if we _truly_=
 need a
> >>> close-to-exact match we could pass a tolerance of 0 in and we'd get
> >>> something that's nearly exact, though I'm not suggesting we actually =
do that.
> >>> If we think 2% is good enough then we should just accept the first (a=
nd
> >>> lowest clock rate) 2% match we find.
> >>>
> >>>      abs_tol =3D div_u64((u64)desired_clk * percent_tol, 100);
> >>>      maxdiv =3D CLK_DIV_MSK >> CLK_DIV_SHFT;
> >>>      div =3D 1;
> >>>      while (div <=3D maxdiv) {
> >>>          mult =3D (u64)div * desired_clk;
> >>>          if (mult !=3D (unsigned long)mult)
> >>>              break;
> >>>
> >>>          offset =3D div * abs_tol;
> >>>          freq =3D clk_round_rate(clk, mult - offset);
> >>>
> >>>          /* Can only get lower if we're done */
> >>>          if (freq < mult - offset)
> >>>              break;
> >>>
> >>>          /*
> >>>           * Re-calculate div in case rounding skipped rates but we
> >>>           * ended up at a good one, then check for a match.
> >>>           */
> >>>          div =3D DIV_ROUND_CLOSEST(freq, desired_clk);
> >>>          achieved =3D DIV_ROUND_CLOSEST(freq, div);
> >>>          if (achieved <=3D desired_clk + abs_tol &&
> >>>              achieved >=3D desired_clk - abs_tol) {
> >>>              *clk_div =3D div;
> >>>              return freq;
> >>>          }
> >>>
> >>>          /*
> >>>           * Always increase div by at least one, but we'll go more th=
an
> >>>           * one if clk_round_rate() gave us something higher.
> >>>           */
> >>>          div =3D DIV_ROUND_UP(max(freq, (unsigned long)mult) + 1, des=
ired_clk);
> >> Wouldn=E2=80=99t DIV_ROUND_UP(freq, desired_clk) suffice here?
> >> freq >=3D mult-offset, else we would have hit break.
> > No. As you say, freq >=3D "mult-offset". That means that freq could be
> > =3D=3D "mult-offset", right? If offset > 0 then freq could be < mult. T=
hen
> > your DIV_ROUND_UP() would just take you right back to where you
> > started the loop with and you'd end up with an infinite loop, wouldn't
> > you?
> >
> Probably No.
>
> ( (freq >=3D mult-offset) && (freq <=3D mult) ) =3D>
>
> ( (freq >=3D mult-offset) && (freq <=3D mult+offset) )
>
> would mean that
>
> div =3D DIV_ROUND_CLOSEST(freq, desired_clk);
> evaluates to original div and we are within tolerance and hence we can re=
turn and hence don't even reach DIV_ROUND_UP?
>
> Please note that freq can skip any multiples and land up anywhere.
>
> As long as it has not gone beyond clock rate table, either it lands
> within tolerance of nearest multiple of desired_clk (in which case we
> return)
>
> OR
>
> We move on to next div =3D (freq/desired_clk + 1)

Ah, you are correct. So just:

div =3D DIV_ROUND_UP(freq, desired_clk);

...because freq _has_ to be greater than mult. If it was < "mult -
offset" we would have ended the loop. If it was between "mult -
offset" and "mult + offset" (inclusive) then we would have success. So
freq must be > "mult + offset" at the end of the loop.

-Doug
