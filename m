Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B477C567FED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 09:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiGFHeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 03:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiGFHeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 03:34:17 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F83220D6
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 00:34:16 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id q16so17114384qtn.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 00:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jb91iJljh1gjsRV/F8EkDiuQ28gmCvX0uXYmKspWwRE=;
        b=bMPgHycDlJMX1A1+lC7ccpSRRCutkmKd1lfxz0jfsKB+wwUkeVlf9idf4sU3lLM3V1
         eD5dW8Pareb+7KbpTisfMOy8n+BvWbdXC1wUAsuZDDEsjWhRcNc5abGrQIqkpwZz6iah
         vH5sGtHIiEiYxVCcuKCoZMCCH2n2W5+93YhBlQMGOMHEa3EQ1dQgxptQYVru1P5zo/m0
         oas9oeSdy5PwSwaMhMIFnHkljSzRPHCSPkvtZzvDTBeQJcA5c78CE8ju+ez1HDnuEOSV
         sYNXB7f6I0wImGHRR6GDsuplDnN0vrMHg5/oXAqbd/76LX167WQiHmg1XjaKzLyhZFu+
         HaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jb91iJljh1gjsRV/F8EkDiuQ28gmCvX0uXYmKspWwRE=;
        b=U63+cdSREzF58DqVM2B0HZYMOV4dEvHJC54hfvVeTR+YAf691im+BU3wmOOzau3Aod
         7OUMWN4BLyvJRf9U1f5tJAKGUhWaNdltONz52CSyHTfDvR9G3BeMoammOOhCiNq4eEUD
         inCjtRWvX+eqEqAKbkw33hn3+ty0W6bzimgMCLnJlUt37TUmJATBN3nHTffOu3bgFsBj
         ZMMiyqDAPxG2mZ+jott/ao6uS0ETfZInUQ9FsfMvx43RH+fFpl8X8G0oJqiBdZRtZXFK
         gnesyfL+M2VbRF4AY7y3WTXHeQGiAKu+BWzZIE9kBQfAJyBRQIOrrb7YJAS78YufWYnw
         yqlQ==
X-Gm-Message-State: AJIora9nWt5FjpBVnmgVLzvtfqGAHDBl+X6VdE3ADYNlvAl1ZiAv9r7k
        uOcZVx3HtFVblVS3RUrKj0ZHbCUKXitthCxC+Vva5w==
X-Google-Smtp-Source: AGRyM1vNwsFSmtjVsNs+qS1DumMmT57Xa9JDFUpm++zhPJwW6GISNSgwHRNPzGaD2iP96DGuRfky182MTcA3jVELOak=
X-Received: by 2002:a05:6214:2a88:b0:473:5aa:e927 with SMTP id
 jr8-20020a0562142a8800b0047305aae927mr5462068qvb.122.1657092855292; Wed, 06
 Jul 2022 00:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220621163326.16858-1-ansuelsmth@gmail.com> <20220621163326.16858-3-ansuelsmth@gmail.com>
 <CAA8EJpqQTTevQa4pQg3E+x4_AOjYo8ajOqUrfwGsVtC8N=bpOw@mail.gmail.com>
 <62b228b6.1c69fb81.e4673.34a2@mx.google.com> <CAA8EJprb=xV9+gZMANAYrt_JnKAtC89h1RAosL+g517_-Ugd2g@mail.gmail.com>
 <62c4a38b.1c69fb81.4d58e.ce99@mx.google.com>
In-Reply-To: <62c4a38b.1c69fb81.4d58e.ce99@mx.google.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 6 Jul 2022 10:34:04 +0300
Message-ID: <CAA8EJprGf6V9K1gFDCE+bnKwhjVgLvruTRAZ-AOqfPsbmmYRLA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] clk: qcom: lcc-ipq806x: convert to parent data
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
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

On Tue, 5 Jul 2022 at 23:48, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> On Tue, Jun 21, 2022 at 11:43:10PM +0300, Dmitry Baryshkov wrote:
> > On Tue, 21 Jun 2022 at 23:23, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > >
> > > On Tue, Jun 21, 2022 at 08:15:57PM +0300, Dmitry Baryshkov wrote:
> > > > On Tue, 21 Jun 2022 at 19:33, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > > > >
> > > > > Convert lcc-ipq806x driver to parent_data API.
> > > > >
> > > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > > ---
> > > > > v2:
> > > > > - Fix Sob tag
> > > > >
> > > > >  drivers/clk/qcom/lcc-ipq806x.c | 79 +++++++++++++++++++---------------
> > > > >  1 file changed, 44 insertions(+), 35 deletions(-)
> > > > >
> > > > > diff --git a/drivers/clk/qcom/lcc-ipq806x.c b/drivers/clk/qcom/lcc-ipq806x.c
> > > > > index ba90bebba597..c07ca8dc6e3a 100644
> > > > > --- a/drivers/clk/qcom/lcc-ipq806x.c
> > > > > +++ b/drivers/clk/qcom/lcc-ipq806x.c
> > > > > @@ -24,6 +24,10 @@
> > > > >  #include "clk-regmap-mux.h"
> > > > >  #include "reset.h"
> > > > >
> > > > > +static const struct clk_parent_data gcc_pxo[] = {
> > > > > +       { .fw_name = "pxo", .name = "pxo" },
> > > >
> > > > I think you'd use .name = "pxo_board" here. You don't need to use the
> > > > interim clock.
> > > >
> > >
> > > In gcc and in the rest of this driver we use pxo. Wonder what is right?
> >
> > I'd use .fw_name = "pxo", .name = "pxo_board", like the rest of drivers do.
> >
>
> Will do the change, but I need an explaination... Is the use of
> pxo_board correct?
>
> I'm sending a patch that sets the pxo_board fixed clock in dts to output
> "pxo". The only clock that still use pxo_board is rpm, everything else
> at least for ipq806x use pxo and i'm sending a patch to use pxo for rpm.
>
> Considering pxo is always present and pxo_board should be dropped
> because every ipq806x driver use "pxo".
>
> What is correct naming pxo or pxo_board? I assume pxo right?

This might be not the case for the ipq806x, but here is the story for
all other (old) platforms:
- gcc driver manually registered pxo/cxo/xo fixed factor clocks.
- Then we started adding *xo_board clocks to the DT, as they represent
the external oscillators
-  PXO clock consumers receive a clocks entry with clock-names = "pxo"
which points to the pxo_board
- All clock drivers are now being switched to use .fw_name = "pxo",
.name = "pxo_board" to use the DT-defined pxo_board clock.

Hopefully at some point we can then drop the manually registered pxo
clock and always use the DT-based one.

-- 
With best wishes
Dmitry
