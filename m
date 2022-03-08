Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85DE4D24B5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 00:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiCHXKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 18:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiCHXKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 18:10:48 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF0E6F4AE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 15:09:48 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id w17-20020a056830111100b005b22c584b93so455379otq.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 15:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xuc98iQ6lLN5ZWjfMkCi08X6OqD4xJL8S5CE7+O2xXo=;
        b=ufjwvyzNLdj8kL4OhOSrTDZr9TwtTMGBSYKptuax0eItS0/K2Li7gLDPnKGMSVhxb0
         AVhfV82OUzj4q6JGYm3SJjk7imPLYPvVWFEO7Hnvu22PjY7s+7eefgq1tGg2xQvMD5C2
         sZV0znnqEGyrfEKDzwX/Pzt7gjZvZapFf2MyBY3NHA1dRW+G5mrX2h6l7yXqZEdMRepF
         QQmuDgriXkK7wdMr2PHSVgeKuxkIB90+avmkKV5p17EWJln+MVCytyavDctuDJJIAJqM
         1YjRl1H5BKzo5yrDI8SbzUe8CKigHm7BWSTWlwIG0IoeV9jb8JsLgg96waj9ZOHo9jGk
         P6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xuc98iQ6lLN5ZWjfMkCi08X6OqD4xJL8S5CE7+O2xXo=;
        b=PnedKXmNjDToJhyL+pWOVt6eHg9H+ZNDCXuFQJSKwKOlCfxiT1MKHxZhH3tHhBfB10
         GGK1TgwRSnsQZf9W5446TNrlt2Vf91ROMp/KTrWlt1+4zTsd6KuJcCUE2XRH5vxzhPhS
         LlyfckNcyMWCrfLI4VKAr/RuCfIq7pvfo8Wk6cSWfxQ7VV/3GbiVa7s4Kb8+ZE8iYvj5
         Acpq88FOcc7F9V5Syr7On3YotbLb9zZrKzm2GrgQmqjilJfKF7iPpKp5aO8wArLcSyf3
         PYck+l2n1JZRK5/iXaZ3x1piVPQ+4sCMrykrX9nLdeDEvp9W4JM2yY6OmpEW/+OcaGY9
         MYxw==
X-Gm-Message-State: AOAM531iyPt33yrI6Fdtj9vsMLlmoufcTHwqIXhk6GLjQPNqyd7SLZWL
        TmEdcxY+sua5djtp1eLDNOb46A==
X-Google-Smtp-Source: ABdhPJxRpGsmLOMyITa2cLxJpOaQ0mqRRzUUbDozIlPaZ8piOB6fxUH+hJr2w8mLPUw47UxqSD2a9Q==
X-Received: by 2002:a9d:518c:0:b0:5b2:364b:7fbd with SMTP id y12-20020a9d518c000000b005b2364b7fbdmr5766151otg.255.1646780987672;
        Tue, 08 Mar 2022 15:09:47 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id z26-20020a9d62da000000b005b23f5488cdsm68215otk.52.2022.03.08.15.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 15:09:46 -0800 (PST)
Date:   Tue, 8 Mar 2022 17:09:45 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org, tdas@codeaurora.org,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v3 3/6] clk: qcom: gcc: Add emac GDSC support for SM8150
Message-ID: <YifiOa38WGMAeEq7@builder.lan>
References: <20220303084824.284946-1-bhupesh.sharma@linaro.org>
 <20220303084824.284946-4-bhupesh.sharma@linaro.org>
 <CAA8EJpow=NPM5TrK24qsziVWgrD0cfbtwUxBD45CE2EQAg-msA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpow=NPM5TrK24qsziVWgrD0cfbtwUxBD45CE2EQAg-msA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03 Mar 04:33 CST 2022, Dmitry Baryshkov wrote:

> On Thu, 3 Mar 2022 at 11:48, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
> >
> > Add the EMAC GDSC defines and driver structures for SM8150.
> >
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >  drivers/clk/qcom/gcc-sm8150.c               | 10 ++++++++++
> >  include/dt-bindings/clock/qcom,gcc-sm8150.h |  1 +
> >  2 files changed, 11 insertions(+)
> >
> > diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc-sm8150.c
> > index 85a431ac417b..08ba29e3a835 100644
> > --- a/drivers/clk/qcom/gcc-sm8150.c
> > +++ b/drivers/clk/qcom/gcc-sm8150.c
> > @@ -3448,6 +3448,15 @@ static struct clk_branch gcc_video_xo_clk = {
> >         },
> >  };
> >
> 
> Is it available on sm8150 or only on sa8155au? I think this deserves
> at least a comment.
> 

The ethernet controller is there on SM8150 as well.

Regards,
Bjorn

> > +static struct gdsc emac_gdsc = {
> > +       .gdscr = 0x6004,
> > +       .pd = {
> > +               .name = "emac_gdsc",
> > +       },
> > +       .pwrsts = PWRSTS_OFF_ON,
> > +       .flags = POLL_CFG_GDSCR,
> > +};
> > +
> >  static struct gdsc usb30_prim_gdsc = {
> >         .gdscr = 0xf004,
> >         .pd = {
> > @@ -3714,6 +3723,7 @@ static const struct qcom_reset_map gcc_sm8150_resets[] = {
> >  };
> >
> >  static struct gdsc *gcc_sm8150_gdscs[] = {
> > +       [EMAC_GDSC] = &emac_gdsc,
> >         [USB30_PRIM_GDSC] = &usb30_prim_gdsc,
> >         [USB30_SEC_GDSC] = &usb30_sec_gdsc,
> >  };
> > diff --git a/include/dt-bindings/clock/qcom,gcc-sm8150.h b/include/dt-bindings/clock/qcom,gcc-sm8150.h
> > index 3e1a91876610..40596b9ded06 100644
> > --- a/include/dt-bindings/clock/qcom,gcc-sm8150.h
> > +++ b/include/dt-bindings/clock/qcom,gcc-sm8150.h
> > @@ -243,5 +243,6 @@
> >  /* GCC GDSCRs */
> >  #define USB30_PRIM_GDSC                     4
> >  #define USB30_SEC_GDSC                                         5
> > +#define EMAC_GDSC                                              6
> >
> >  #endif
> > --
> > 2.35.1
> >
> 
> 
> -- 
> With best wishes
> Dmitry
