Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3561F4E6BDA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 02:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357237AbiCYBQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 21:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357238AbiCYBQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 21:16:00 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408E16CA66;
        Thu, 24 Mar 2022 18:13:53 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d7so8873601wrb.7;
        Thu, 24 Mar 2022 18:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=moy457V60g+buPTP+WcRIp+1vIPbliveRPailb9KOg4=;
        b=f6ZPae4fm1keK7p99FDucn/ApZHHevr1A711MwALj4Shdf3TWG7H8XZWvtSkh4CDXI
         vcuVQTga6WwX8S1e7OPXWmaSfSEpjBm5KVho39cbMmE8BQ2WdswVsHV30VwwUQUSoMRu
         KwkoUMm8ftsSsfe2zaZjMX5KF5j6S0wZZtVn698XvruRBDG+ANFLhlb7IY8nXozB0miJ
         XbFGLS5pWN84UpPhOZCl/ko2jY+GMUZU0hhoZ4ZEHyayKbu3x0ex6OchruoBRLuhz4IN
         mSnuY5aUyHiUVM9MXuLXsm9Dg9wwh64aL1ig9Ga8qRG97cXTj2A3AyrVn8RujdiIxR69
         VYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=moy457V60g+buPTP+WcRIp+1vIPbliveRPailb9KOg4=;
        b=G/GQfnwQRtOqEbziicmnSkzFX4t4i7GslHK8w+DVajhHPABb7n58cDzlvlUT1RtAic
         7QC0q1SJ9mkb683GoqFtvXEGJvw6sekNm/rpKeKYoT3vyh+mpOP9bPnw1gZMAsfjdSvP
         45i0vD7YplGNiTBtlSIBvinLdihoenzHnKUJ4da2fVmsOCn+Fj7WNJj1mCMJAxRBWC69
         AZy7MpCpGPS6CLLJLm3ZDGnMqkytzWISjz4h50+qR7b7s63qdCid1LCOTfszu4ToGvfi
         /uxvp54KLQqid//7TbpkveyFVk62Qm2DCawg64ig0unV8GdPnQyOIGNNUGcl5b/6lG/E
         s3zQ==
X-Gm-Message-State: AOAM531BubHNO6E3Rc8lfYUs/97sz29e0kJ1ifatq1EN689lqB2rTYC3
        +zgS7ScAoa8Ryy9lLZSOCi6qwM0SgE0=
X-Google-Smtp-Source: ABdhPJxAkmTvVDicwr7jISX05a1XEgJd81u2WGmY/d+fLfjVlBiP14GpN/+SL/cWu7ryWiu58lt6rg==
X-Received: by 2002:adf:f90c:0:b0:204:41a9:21d8 with SMTP id b12-20020adff90c000000b0020441a921d8mr6900181wrr.251.1648170831633;
        Thu, 24 Mar 2022 18:13:51 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.gmail.com with ESMTPSA id y7-20020a5d4ac7000000b00203e4c8bdf1sm3677670wrs.93.2022.03.24.18.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 18:13:51 -0700 (PDT)
Date:   Fri, 25 Mar 2022 02:13:49 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 03/18] clk: qcom: gcc-ipq806x: add PXO_SRC in clk table
Message-ID: <Yj0XTYgoMScoiUHP@Ansuel-xps.localdomain>
References: <20220321231548.14276-1-ansuelsmth@gmail.com>
 <20220321231548.14276-4-ansuelsmth@gmail.com>
 <20220325011037.03173C340EC@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325011037.03173C340EC@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 06:10:35PM -0700, Stephen Boyd wrote:
> Quoting Ansuel Smith (2022-03-21 16:15:33)
> > PXO_SRC is currently defined in the gcc include and referenced in the
> > ipq8064 DTSI. Correctly provide a clk after gcc probe to fix kernel
> > panic if a driver starts to actually use it.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> 
> What is this patch about? clk providers shouldn't be calling clk_get().
>

If pxo is passed as a clock in dts and defined as a fixed clock, what
should be used? 

> >  drivers/clk/qcom/gcc-ipq806x.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
> > index 27f6d7626abb..7271d3afdc89 100644
> > --- a/drivers/clk/qcom/gcc-ipq806x.c
> > +++ b/drivers/clk/qcom/gcc-ipq806x.c
> > @@ -26,6 +26,8 @@
> >  #include "clk-hfpll.h"
> >  #include "reset.h"
> >  
> > +static struct clk_regmap pxo = { };
> > +
> >  static struct clk_pll pll0 = {
> >         .l_reg = 0x30c4,
> >         .m_reg = 0x30c8,
> > @@ -2754,6 +2756,7 @@ static struct clk_dyn_rcg ubi32_core2_src_clk = {
> >  };
> >  
> >  static struct clk_regmap *gcc_ipq806x_clks[] = {
> > +       [PXO_SRC] = NULL,
> >         [PLL0] = &pll0.clkr,
> >         [PLL0_VOTE] = &pll0_vote,
> >         [PLL3] = &pll3.clkr,
> > @@ -3083,6 +3086,10 @@ static int gcc_ipq806x_probe(struct platform_device *pdev)
> >         if (ret)
> >                 return ret;
> >  
> > +       clk = clk_get(dev, "pxo");
> > +       pxo.hw = *__clk_get_hw(clk);
> > +       gcc_ipq806x_clks[PXO_SRC] = &pxo;
> > +
> >         regmap = dev_get_regmap(dev, NULL);
> >         if (!regmap)
> >                 return -ENODEV;
> > -- 
> > 2.34.1
> >

-- 
	Ansuel
