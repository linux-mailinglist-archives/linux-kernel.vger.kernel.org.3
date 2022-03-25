Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524C84E6BCF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 02:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357182AbiCYBMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 21:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357172AbiCYBMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 21:12:14 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82883BD2CE;
        Thu, 24 Mar 2022 18:10:41 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id m30so8897877wrb.1;
        Thu, 24 Mar 2022 18:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HvkcV8z1Bc+m493ClCYHNiaW7G29Eg9hcVHUQRf7Who=;
        b=CTcAv6iJgAHVgRIQlIsbKf/V9CE+McitMOyDzDYWzY+VyBr8THwxA+WQo5yZuc/jWv
         mWgwDeKIVzbCijVx/Xu5HE2MlB2dElREjaHMoSJXkPHGk0oN3hm8e6lmb1tA3wFKgC8P
         PpAuFKTAHp/xF8gKy7/kuSkHavVsRpDKIvtyHRBdl/aH/PGoSD+jFUUdkFcd+/3nKccm
         gsmf88Rmm/sUqKhXalNcn75A1pkmroselzGDXnaa5e+UlvPhWd37k6Qi4JdBc22c2mPE
         //KZ3I0qFQ9JXF00YB7eWzPHUuYJNnIuh5BN2VjbwJDIujLhkZ3pOGhJRXKVQ7thi96F
         +wJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HvkcV8z1Bc+m493ClCYHNiaW7G29Eg9hcVHUQRf7Who=;
        b=NgaWgV6hurzZfMGv4Jwi7k14vQhBk4IuRv0U6C34V4PF8lxg+KK9taFYaOS4Bh3Hev
         BwvYrHG4R3TOKPepggIQ3W3c+VRfLvGVfGXoD0FICVrtfpzbZYKyvKhFHES/JCBlGnJG
         ImRrPmBPHZudRuPID1DMZ7amMp0jttUFLgaDYgWr70TufZnK7u2nxo2Jl6iKSsSV4DEI
         TMC1HCBdtE0cX/52r2o34gWr0P/3TnQkBFA5A4/qsXuuUoYat7gZa3zfQ291CGn6z9sI
         YfwYNoBq4vFAoSJZqigtTNhnqKLpBWMMC4n44a1Zqt0XNcGtqUITBpUkGu26yzppXZwz
         CZ3g==
X-Gm-Message-State: AOAM531jSjcdVghRwj5sQrqd9QaZwJwI8xG3ynviZKtLD5MlrhmVPBil
        JDLPUT+u46q4PXdQSHsprpk=
X-Google-Smtp-Source: ABdhPJwmPD8TF+6tGkkbeNjlF/ALeS2gsOKypCO9EQNp887LJt4NxDWlIcdpUshqy1BiUs4B96pg3A==
X-Received: by 2002:a5d:6d07:0:b0:205:7ac5:1453 with SMTP id e7-20020a5d6d07000000b002057ac51453mr6809519wrq.149.1648170639919;
        Thu, 24 Mar 2022 18:10:39 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.gmail.com with ESMTPSA id p12-20020a5d48cc000000b001e6114938a8sm3792686wrs.56.2022.03.24.18.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 18:10:39 -0700 (PDT)
Date:   Fri, 25 Mar 2022 02:10:37 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 05/18] clk: qcom: kpss-xcc: convert to parent data API
Message-ID: <Yj0WjeFkHR1IwCsg@Ansuel-xps.localdomain>
References: <20220321231548.14276-1-ansuelsmth@gmail.com>
 <20220321231548.14276-6-ansuelsmth@gmail.com>
 <20220325010652.B1A90C340EC@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325010652.B1A90C340EC@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 06:06:50PM -0700, Stephen Boyd wrote:
> Quoting Ansuel Smith (2022-03-21 16:15:35)
> > Convert the driver to parent data API. From the Documentation pll8_vote
> > and pxo should be declared in the DTS so fw_name can be used instead of
> > parent_names. Name is still used to save regression on old definition.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  drivers/clk/qcom/kpss-xcc.c | 25 ++++++++-----------------
> >  1 file changed, 8 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/clk/qcom/kpss-xcc.c b/drivers/clk/qcom/kpss-xcc.c
> > index 4fec1f9142b8..347f70e9f5fe 100644
> > --- a/drivers/clk/qcom/kpss-xcc.c
> > +++ b/drivers/clk/qcom/kpss-xcc.c
> > @@ -12,9 +12,9 @@
> >  #include <linux/clk.h>
> >  #include <linux/clk-provider.h>
> >  
> > -static const char *aux_parents[] = {
> > -       "pll8_vote",
> > -       "pxo",
> > +static const struct clk_parent_data aux_parents[] = {
> > +       { .name = "pll8_vote", .fw_name = "pll8_vote" },
> > +       { .name = "pxo", .fw_name = "pxo" },
> >  };
> >  
> >  static unsigned int aux_parent_map[] = {
> > @@ -32,8 +32,8 @@ MODULE_DEVICE_TABLE(of, kpss_xcc_match_table);
> >  static int kpss_xcc_driver_probe(struct platform_device *pdev)
> >  {
> >         const struct of_device_id *id;
> > -       struct clk *clk;
> >         void __iomem *base;
> > +       struct clk_hw *hw;
> >         const char *name;
> >  
> >         id = of_match_device(kpss_xcc_match_table, &pdev->dev);
> > @@ -55,24 +55,15 @@ static int kpss_xcc_driver_probe(struct platform_device *pdev)
> >                 base += 0x28;
> >         }
> >  
> > -       clk = clk_register_mux_table(&pdev->dev, name, aux_parents,
> > -                                    ARRAY_SIZE(aux_parents), 0, base, 0, 0x3,
> > -                                    0, aux_parent_map, NULL);
> > +       hw = __devm_clk_hw_register_mux(&pdev->dev, NULL, name, ARRAY_SIZE(aux_parents),
> 
> Does something in devm_clk_hw_register_mux() not work here? Do we need a
> devm_clk_hw_register_mux_parent_data()? If so, please add it.
>

Main reason I can't use devm_clk_hw_register_mux is the fact I can't
provide a parent_map. Will add an additional macro. OK.

> > +                                       NULL, NULL, aux_parents, 0, base, 0, 0x3,
> > +                                       0, aux_parent_map, NULL);
> >

-- 
	Ansuel
