Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A3146B1ED
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 05:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbhLGEiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 23:38:52 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:35777 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233659AbhLGEiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 23:38:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638851721; x=1670387721;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eTel0w7VygXn/pm9eOkUy8bQgfXCGjtLPIeibzj37WY=;
  b=hEN2dCOUDeFuIgoRzIGBiIroyoz53Z4VQyIH7a5KvQ1TLxoAf7Xe8khF
   r8n218diPfpsAyXNgiOzz4Yun+C2yf3JP/6O+PAOLyaNFLLbZn9pngMib
   soP2TZxe1ny/aaJW7g4/mFoXYDtjFI2IiH4SaAYRGk+QufUuvRkcwK5HN
   Q=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Dec 2021 20:35:21 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 20:35:21 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 6 Dec 2021 20:35:21 -0800
Received: from quicinc.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 6 Dec 2021
 20:35:20 -0800
Date:   Mon, 6 Dec 2021 20:35:19 -0800
From:   Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <maz@kernel.org>, <mturquette@baylibre.com>, <robh+dt@kernel.org>,
        <tglx@linutronix.de>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v6 2/5] clk: qcom: Add LUCID_EVO PLL type for SDX65
Message-ID: <20211207043519.GB28122@quicinc.com>
References: <cover.1638402361.git.quic_vamslank@quicinc.com>
 <7e1805ef3f7cddc1222906d8b8e5b79548b46f63.1638402361.git.quic_vamslank@quicinc.com>
 <20211203001844.78E7FC00446@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211203001844.78E7FC00446@smtp.kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 04:18:43PM -0800, Stephen Boyd wrote:
> Quoting quic_vamslank@quicinc.com (2021-12-01 16:21:32)
> > diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
> > index eaedcceb766f..e0c67b76d8ac 100644
> > --- a/drivers/clk/qcom/clk-alpha-pll.c
> > +++ b/drivers/clk/qcom/clk-alpha-pll.c
> > @@ -1741,35 +1760,47 @@ static int alpha_pll_lucid_5lpe_set_rate(struct clk_hw *hw, unsigned long rate,
> >                                           LUCID_5LPE_ALPHA_PLL_ACK_LATCH);
> >  }
> >  
> > +static int __clk_lucid_pll_postdiv_set_rate(struct clk_hw *hw, unsigned long rate,
> > +                                            unsigned long parent_rate, unsigned long enable_vote_run)
> > +{
> > +        struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
> > +       struct regmap *regmap = pll->clkr.regmap;
> 
> What's going on with the tabbing here?

Yes, actually i used a tab instead of space here. I will correct it.

> 
> > +        int i, val = 0, div, ret;
> 
> Do we need to initialize to 0?

Not needed. Will remove.

> 
> > +        u32 mask;
> > +
> > +        /*
> > +         * If the PLL is in FSM mode, then treat set_rate callback as a
> > +         * no-operation.
> > +         */
> > +        ret = regmap_read(regmap, PLL_USER_CTL(pll), &val);
> > +        if (ret)
> > +                return ret;
> > +
> > +        if (val & enable_vote_run)
> > +                return 0;
> > +
> > +        if (!pll->post_div_table) {
> > +                pr_err("Missing the post_div_table for the PLL\n");
> 
> Probably useful to know which PLL is missing a table here.

I think that's a good idea on returning which PLL is missing a table. 


Thanks,
Vamsi

