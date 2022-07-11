Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD8E57042A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 15:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiGKNX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 09:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiGKNX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:23:57 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CA71A068;
        Mon, 11 Jul 2022 06:23:56 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id l11so330352qvu.13;
        Mon, 11 Jul 2022 06:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i7Y2STqU+qPlVyZe6RfsFqCzhGI06GzC5rAA/iBUOWY=;
        b=e5rAxazlawNtbiIO5WOHZvYj3ODCoNnXNI/CGx1QwXFKZHCvk94FMooIKlKn5ABcZK
         NMOtMS6Jp1fxw76/WA7pSd0C9F1v1+bDWTLyvmoI2sktl9aQUkOJxg/XOTfTngv1nDNk
         JSRwmyU5xdWco7YJOQf5FjgoCU0DrKPA8VYGfMFt+GUL9sc6NoZU90DscIynluitoyIg
         nfMSBaAr55XOT0k2S+tug+xupxBUYF8XUVB5l0FaMkjeyf45e4P3lbgqWjeig7lHIqqi
         h5w8Wb4pfKCMUpOa06XJuIds+9k3noSe8GFJzEwADSTKlb8599p7mcQBH2ZdOaq54Xob
         AzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i7Y2STqU+qPlVyZe6RfsFqCzhGI06GzC5rAA/iBUOWY=;
        b=id9Abzm/IfVcZTGuCokhgbQVzAYK8/lubbVT6JDEjO7++vSHd4DMG4uKkm97Q8cTnU
         pEKZfSbKo3sjsAfIDeJ8XjNXe3Y0KX/MQLRtgeShbeOAkeJkoFbKLOJbO+q2Nm7z2Z9K
         8G2jY1wK0eNUqfnFe1aeuR+/DvyZI67M2DunPVNe7spjFxOfPlNnXqCpp7U56Eq2b1R4
         nshlPPe3t0Z4hqid41fkrk8oYLjxH4k63B55hOerTZPTrnonZDt1pCyIWBVv0C+01kje
         Bqn93/mrsIhrcrM9rfGx8jc/sITYudfW/Er+t03yw1A6muEyjjWf20q0sZID79eYU3wH
         Tbfg==
X-Gm-Message-State: AJIora9dMG8XvVhqlmiaXKaq5TxH13e0X+lhP0sJ5Ch9/o5bAyUVYWrx
        tqrChqyxcevxH6Utyc037a2luubEjV9lVbNLBRs=
X-Google-Smtp-Source: AGRyM1vj/kgRu4xxPgaaHRW2F0Oc1OIRrL8u09YahVoyaLnsKOCWC39eJg6XS1bsdvW+S6fAMb8tzy1/a172gcMGfX0=
X-Received: by 2002:a0c:8c89:0:b0:470:9ab6:bb27 with SMTP id
 p9-20020a0c8c89000000b004709ab6bb27mr13500635qvb.118.1657545835511; Mon, 11
 Jul 2022 06:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220711104719.40939-1-robimarko@gmail.com> <20220711104719.40939-2-robimarko@gmail.com>
 <CAA8EJprfAW7kFSPxs7=LEHLmAVrWhV8KRbUseg8jXyiUbyZuRQ@mail.gmail.com>
In-Reply-To: <CAA8EJprfAW7kFSPxs7=LEHLmAVrWhV8KRbUseg8jXyiUbyZuRQ@mail.gmail.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Mon, 11 Jul 2022 15:23:44 +0200
Message-ID: <CAOX2RU7+f3vXdOmMNi6Dt=9jadrgVFhrU56vm=6dYKkhnPUJwQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] clk: qcom: apss-ipq6018: fix apcs_alias0_clk_src
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, sivaprak@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-clk@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2022 at 14:48, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Mon, 11 Jul 2022 at 14:22, Robert Marko <robimarko@gmail.com> wrote:
> >
> > While working on IPQ8074 APSS driver it was discovered that IPQ6018 and
> > IPQ8074 use almost the same PLL and APSS clocks, however APSS driver is
> > currently broken.
> >
> > More precisely apcs_alias0_clk_src is broken, it was added as regmap_mux
> > clock.
> > However after debugging why it was always stuck at 800Mhz, it was figured
> > out that its not regmap_mux compatible at all.
> > It is a simple mux but it uses RCG2 register layout and control bits, so
>
> To utilize control bits, you probably should also use

Hi,
I am not really sure what you mean here?

>
> > utilize the new clk_rcg2_mux_closest_ops to correctly drive it while not
> > having to provide a dummy frequency table.
>
> Could you please clarify this. Your new rcg2 ops seems to be literally
> equivalent to the clk_regmap_mux_closest_ops provided the shift and
> width are set correctly..

Well, I have tried playing with the clk_regmap_mux_closest_ops but I
just cannot get it
to work.

The width like you pointed out should be 8, register offset is
currently pointing at the RCG control
register and not the CFG one, so it obviously does not work.

Setting the register to 0x54 and shift to 8 will just fail silently,
leaving the shift at 7 and correcting
the register won't work as RCG control bits are not utilized at all
with regmap_mux and DIRTY_CFG
is active when I manually look at the register.

So, I am really not sure how clk_regmap_mux_closest_ops are supposed
to work here at all.

Regards,
Robert
>
> > While we are here, use ARRAY_SIZE for number of parents.
> >
> > Tested on IPQ6018-CP01-C1 reference board and multiple IPQ8074 boards.
> >
> > Fixes: 5e77b4ef1b19 ("clk: qcom: Add ipq6018 apss clock controller")
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> >  drivers/clk/qcom/apss-ipq6018.c | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/clk/qcom/apss-ipq6018.c b/drivers/clk/qcom/apss-ipq6018.c
> > index d78ff2f310bf..be952d417ded 100644
> > --- a/drivers/clk/qcom/apss-ipq6018.c
> > +++ b/drivers/clk/qcom/apss-ipq6018.c
> > @@ -16,7 +16,7 @@
> >  #include "clk-regmap.h"
> >  #include "clk-branch.h"
> >  #include "clk-alpha-pll.h"
> > -#include "clk-regmap-mux.h"
> > +#include "clk-rcg.h"
> >
> >  enum {
> >         P_XO,
> > @@ -33,16 +33,15 @@ static const struct parent_map parents_apcs_alias0_clk_src_map[] = {
> >         { P_APSS_PLL_EARLY, 5 },
> >  };
> >
> > -static struct clk_regmap_mux apcs_alias0_clk_src = {
> > -       .reg = 0x0050,
> > -       .width = 3,
> > -       .shift = 7,
>
> Judging from rcg2 ops, .shift should be set to 8.
>
> > +static struct clk_rcg2 apcs_alias0_clk_src = {
> > +       .cmd_rcgr = 0x0050,
> > +       .hid_width = 5,
> >         .parent_map = parents_apcs_alias0_clk_src_map,
> >         .clkr.hw.init = &(struct clk_init_data){
> >                 .name = "apcs_alias0_clk_src",
> >                 .parent_data = parents_apcs_alias0_clk_src,
> > -               .num_parents = 2,
> > -               .ops = &clk_regmap_mux_closest_ops,
> > +               .num_parents = ARRAY_SIZE(parents_apcs_alias0_clk_src),
> > +               .ops = &clk_rcg2_mux_closest_ops,
> >                 .flags = CLK_SET_RATE_PARENT,
> >         },
> >  };
> > --
> > 2.36.1
> >
>
>
> --
> With best wishes
> Dmitry
