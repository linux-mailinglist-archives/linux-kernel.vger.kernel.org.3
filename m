Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D0E49D593
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 23:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiAZWkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 17:40:40 -0500
Received: from mail.z3ntu.xyz ([128.199.32.197]:43330 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbiAZWkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 17:40:39 -0500
Received: from g550jk.localnet (ip-213-127-106-2.ip.prioritytelecom.net [213.127.106.2])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 9A474C5811;
        Wed, 26 Jan 2022 22:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1643236836; bh=30PYBiUXaYsqcqhi5/zLJAyf4JS6d9jdtTqTbDhdWws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Zsi74eCrawSXfVgUD63F4bgrcWAtunjuUXMbzJO1Xc51zSytG8tQjFc6NKexJNuoB
         yP+JE+CVhx3d4sRWkW+6O8nI91Bs3gT9ea9k1t3TXILtDiluJfV6chice+J0QjBvvy
         YrhN3QhEYSs8gp48tgxrmKAA7HAD++Ge653jBBN0=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Bartosz Dudziak <bartosz.dudziak@snejp.pl>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 2/2] clk: qcom: Add MSM8226 Multimedia Clock Controller support
Date:   Wed, 26 Jan 2022 23:40:36 +0100
Message-ID: <6707575.DvuYhMxLoT@g550jk>
In-Reply-To: <Ya42ZAKupwKiWpJf@builder.lan>
References: <20211113015844.92762-1-bartosz.dudziak@snejp.pl> <20211113015844.92762-2-bartosz.dudziak@snejp.pl> <Ya42ZAKupwKiWpJf@builder.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

are you planning to work on this? If not I can pick it up and make a v2.
Please let me know!

Regards
Luca

On Montag, 6. Dezember 2021 17:12:20 CET Bjorn Andersson wrote:
> On Fri 12 Nov 19:58 CST 2021, Bartosz Dudziak wrote:
> > diff --git a/drivers/clk/qcom/mmcc-msm8974.c
> > b/drivers/clk/qcom/mmcc-msm8974.c
> [..]
> 
> >  static int mmcc_msm8974_probe(struct platform_device *pdev)
> >  {
> >  
> >  	struct regmap *regmap;
> > 
> > +	const struct of_device_id *match;
> > +
> > +	match = of_match_device(mmcc_msm8974_match_table, &pdev->dev);
> 
> Could you please use of_device_get_match_data() instead?
> 
> > +	if (!match)
> 
> As a general suggestion; I don't see how we would end up here with
> !match, but if we somehow do it would be during development and you
> would have an easier time debugging this by hitting a NULL pointer
> dereference with a callstack, than tracking down why your clocks are
> missing...
> 
> Thanks,
> Bjorn
> 
> > +		return -ENODEV;
> > 
> > -	regmap = qcom_cc_map(pdev, &mmcc_msm8974_desc);
> > +	regmap = qcom_cc_map(pdev, match->data);
> > 
> >  	if (IS_ERR(regmap))
> >  	
> >  		return PTR_ERR(regmap);
> > 
> > -	clk_pll_configure_sr_hpm_lp(&mmpll1, regmap, &mmpll1_config, true);
> > -	clk_pll_configure_sr_hpm_lp(&mmpll3, regmap, &mmpll3_config, false);
> > +	if (match->data == &mmcc_msm8974_desc) {
> > +		clk_pll_configure_sr_hpm_lp(&mmpll1, regmap, 
&mmpll1_config, true);
> > +		clk_pll_configure_sr_hpm_lp(&mmpll3, regmap, 
&mmpll3_config, false);
> > +	} else {
> > +		msm8226_clock_override();
> > +	}
> > 
> > -	return qcom_cc_really_probe(pdev, &mmcc_msm8974_desc, regmap);
> > +	return qcom_cc_really_probe(pdev, match->data, regmap);
> > 
> >  }
> >  
> >  static struct platform_driver mmcc_msm8974_driver = {




