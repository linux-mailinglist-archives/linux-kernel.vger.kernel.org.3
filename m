Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECDF46B1E1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 05:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235745AbhLGEez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 23:34:55 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:9282 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233659AbhLGEey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 23:34:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638851484; x=1670387484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=adfjxvPtoTQBY1C+FT1LcQzKj4mW5Oha7NkxOuX1Y+I=;
  b=rmoK23D1BpZzwqsZ4ASJEk4sUuqvSxpTKYLmz7Q3lCCbK8Pi41eL9mKU
   8/tf8CZ6z0zashZ/lfMY4y4iiQROGoMAxHWpuw5hPXXMcJUelEVK+f/JZ
   TSA/5D6ffiwe/TyiE1fQOHN474vo9cjiByCE3V1/K/U1xZFxgIzEWKj56
   A=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Dec 2021 20:31:24 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 20:31:24 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 6 Dec 2021 20:31:23 -0800
Received: from quicinc.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 6 Dec 2021
 20:31:23 -0800
Date:   Mon, 6 Dec 2021 20:31:21 -0800
From:   Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <maz@kernel.org>, <mturquette@baylibre.com>, <robh+dt@kernel.org>,
        <tglx@linutronix.de>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v6 3/5] clk: qcom: Add SDX65 GCC support
Message-ID: <20211207043121.GA28122@quicinc.com>
References: <cover.1638402361.git.quic_vamslank@quicinc.com>
 <475a055e403762e54a1cae6c2c97d4ada6064607.1638402361.git.quic_vamslank@quicinc.com>
 <20211203002010.8225CC00446@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211203002010.8225CC00446@smtp.kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 04:20:09PM -0800, Stephen Boyd wrote:
> Quoting quic_vamslank@quicinc.com (2021-12-01 16:21:33)
> > +static struct clk_branch gcc_gp3_clk = {
> > +       .halt_reg = 0x39000,
> > +       .halt_check = BRANCH_HALT,
> > +       .clkr = {
> > +               .enable_reg = 0x39000,
> > +               .enable_mask = BIT(0),
> > +               .hw.init = &(struct clk_init_data){
> > +                       .name = "gcc_gp3_clk",
> > +                       .parent_data = &(const struct clk_parent_data){
> > +                               .hw = &gcc_gp3_clk_src.clkr.hw,
> > +                       },
> > +                       .num_parents = 1,
> > +                       .flags = CLK_SET_RATE_PARENT,
> > +                       .ops = &clk_branch2_ops,
> > +               },
> > +       },
> > +};
> > +
> > +static struct clk_branch gcc_pcie_0_clkref_en = {
> > +       .halt_reg = 0x88004,
> > +       /* The clock controller does not handle the status bit for
> 
> Please leave /* on it's own line for multiline comments.

Will do.

> 
> > +        * the clocks with gdscs(powerdomains) in hw controlled mode
> > +        * and hence avoid checking for the status bit of those clocks
> > +        * by setting the BRANCH_HALT_DELAY flag */
> 
> And */ too

Will do.

> 
> > +       .halt_check = BRANCH_HALT_DELAY,
> > +       .clkr = {
> > +               .enable_reg = 0x88004,
> > +               .enable_mask = BIT(0),
> > +               .hw.init = &(struct clk_init_data){
> > +                       .name = "gcc_pcie_0_clkref_en",
> > +                       .ops = &clk_branch2_ops,
> > +               },
> > +       },
> > +};

Thanks,
Vamsi
