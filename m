Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54EE4C314E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiBXQbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiBXQbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:31:40 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E7628D386
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 08:31:00 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id i5so3284851oih.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 08:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UtvGHwpTPxnNK4df830HsbQ5tqR9fciM9/AXkb63doE=;
        b=ezsfkKAm3SoATQ8pbdZnOmKRIPKE6xVK9TxybTM5YRuqZBED0GKI+NSlQKXYJNU6a9
         wUhfHlw1PQYC9gUeoQbyNVCKCxFtT6ARNpmAz0vNLaysBNBKvGynHBIoc6aFC6oIQenf
         fLbC9wytOC33ipG/dDymdMC8C962u/ItTirw3NV39yarM02FPLSk0q4W8hk6vJYIcQT6
         xXB7Sp+1WoiBxpxytz/VKqSH8llpk12Q0WCpLXGFQd/aV+63jfag7c029qhb0DFsjE4z
         Kj3OqWnAVTlniXK45mmZO5L3RoNpOtjKeX7D8Fa12mJX5E4hxgutUXHVapL7kAQm5u9I
         LuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UtvGHwpTPxnNK4df830HsbQ5tqR9fciM9/AXkb63doE=;
        b=Nzn6+2syRfViEqnVJCQKmQwMLKvaaiJeDZux1w0C3uo2IE8nq8WGopaAeqbRUraIAu
         7LJ/bSTnGfM97NIxuV16bGOU0x8qcrnzAZLKStp1dxV8EiFZS9WgOJDJSIv1ZqKpG7jW
         tK+rJ6x6TYGgH8zbkfvp2hNMhX5sr0A24PVwMVtyyhBwROTPVgGyoxC4AyaXy5anzn0k
         itfcGVLBYM7Q3ooorIR19opzf+nrNfrm6NkYp9SGD4M4i/syn3AoQOAl8W825i4Y3BBv
         u1LmfgIkC3r5Ja5bsBmueZPJGrJWDJQ/h3Y5X91h8/dBtOzKHWka0OSTIzoLNrd/k0ga
         Ua+g==
X-Gm-Message-State: AOAM531nCo3AaV0cZtUkljjbrZg1mu/UQctCImx0uu55C6GX/Hbger0u
        P0akUO5Vn4ueZq+jQ5pBKuKWHurz5Rc5AA==
X-Google-Smtp-Source: ABdhPJyLngbnCzXVfVhLUeGhokc4vEYxVcUw8ZYCKRZ1+I+U+Abro1TlFcBGQ9rXJ+VjKw2M1RmFmw==
X-Received: by 2002:a05:6870:4410:b0:d3:1505:36c8 with SMTP id u16-20020a056870441000b000d3150536c8mr6822284oah.300.1645719214522;
        Thu, 24 Feb 2022 08:13:34 -0800 (PST)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id g18sm1365629otp.17.2022.02.24.08.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:13:33 -0800 (PST)
Date:   Thu, 24 Feb 2022 08:15:32 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/16] clk: qcom: gcc-ipq806x: drop hardcoded pxo and
 cxo source clk
Message-ID: <YhevJB2nY/X6sWnS@ripper>
References: <20220217235703.26641-1-ansuelsmth@gmail.com>
 <20220217235703.26641-8-ansuelsmth@gmail.com>
 <YhcAdq4ouQenhn2f@builder.lan>
 <YhepQc3k8l1g5NZ/@Ansuel-xps.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhepQc3k8l1g5NZ/@Ansuel-xps.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24 Feb 07:50 PST 2022, Ansuel Smith wrote:

> On Wed, Feb 23, 2022 at 09:50:14PM -0600, Bjorn Andersson wrote:
> > On Thu 17 Feb 17:56 CST 2022, Ansuel Smith wrote:
> > 
> > > We now define these clk in dts. Drop pxo and cxo hardcoded in the gcc
> > > probe function.
> > > 
> > 
> > As noted on the previous patch, this breaks booting with existing dtbs.
> > So I would like to split this with 1-2 releases in between to avoid any
> > problems.
> > 
> > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > 
> > on the change though.
> > 
> > Regards,
> > Bjorn
> >
> 
> Should I change this and register these clks only if they are not present?
> 

The .fw_name will match against clock-names to resolve a phandle to
e.g. &pxo_board and if not found should fall back to matching by .name
and finding these clocks. So I don't see a conflict in keeping them
around.

Once we know that the dts change is in place I think we should merge
this as is.

Regards,
Bjorn

> > > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > > ---
> > >  drivers/clk/qcom/gcc-ipq806x.c | 11 +----------
> > >  1 file changed, 1 insertion(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
> > > index f6db7247835e..a4bf78fe8678 100644
> > > --- a/drivers/clk/qcom/gcc-ipq806x.c
> > > +++ b/drivers/clk/qcom/gcc-ipq806x.c
> > > @@ -3119,23 +3119,14 @@ MODULE_DEVICE_TABLE(of, gcc_ipq806x_match_table);
> > >  
> > >  static int gcc_ipq806x_probe(struct platform_device *pdev)
> > >  {
> > > -	struct device *dev = &pdev->dev;
> > >  	struct regmap *regmap;
> > >  	int ret;
> > >  
> > > -	ret = qcom_cc_register_board_clk(dev, "cxo_board", "cxo", 25000000);
> > > -	if (ret)
> > > -		return ret;
> > > -
> > > -	ret = qcom_cc_register_board_clk(dev, "pxo_board", "pxo", 25000000);
> > > -	if (ret)
> > > -		return ret;
> > > -
> > >  	ret = qcom_cc_probe(pdev, &gcc_ipq806x_desc);
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > -	regmap = dev_get_regmap(dev, NULL);
> > > +	regmap = dev_get_regmap(&pdev->dev, NULL);
> > >  	if (!regmap)
> > >  		return -ENODEV;
> > >  
> > > -- 
> > > 2.34.1
> > > 
> 
> -- 
> 	Ansuel
