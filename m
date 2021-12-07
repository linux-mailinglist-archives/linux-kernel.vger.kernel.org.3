Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A982146BAA9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 13:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236034AbhLGMIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 07:08:38 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:60862 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbhLGMIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 07:08:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 682DFCE1A7E;
        Tue,  7 Dec 2021 12:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0A1C341C3;
        Tue,  7 Dec 2021 12:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638878703;
        bh=ujCHnMR34AzoG3Vi8aJNN8FINppyuK04wRnq0gfNiQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MZoqarWRRmjq2S95AYjelwGU5/W9x8CNj0QiHigq0C1l9A5f2d31V2UOqzQpHQpNk
         G6N7GU7Cl5HYfJkeRrJsyy/JE2KLDapb8lJnhKYkdYZqco9sy2gm5h3fTztMKRiDih
         E6NpUpWLQ0jFms5nBU05FQ2OAkH7NZBl+hHBlGmFG31S5/cAnamjaARGcPCg+42Q4L
         kbtGwgxiSSecsQFgy63b1QH2yF+AAHrmwGBD6qVc82OCt+CeP7C0rpz/8ta1SQxGIx
         gJ3ktWVVbQswr9+p5D2Y5e7zp68iKGMm64Lg7D+c+S4Ejl50IwDP09QsCRGyGxVsDX
         noNVVuLEFk49g==
Date:   Tue, 7 Dec 2021 17:34:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Kuogee Hsieh <khsieh@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        robdclark@gmail.com, robh+dt@kernel.org, sean@poorly.run,
        abhinavk@codeaurora.org, aravindh@codeaurora.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kishon@ti.com, p.zabel@pengutronix.de
Subject: Re: [PATCH v4] phy: qcom-qmp: add support for display port voltage
 and pre-emphasis swing
Message-ID: <Ya9N65mseobpBrYx@matsya>
References: <1631637901-11603-1-git-send-email-khsieh@codeaurora.org>
 <CAE-0n50R1wfw=V7o19N20YOqSrRZKR7Zd4QLcRcjYQNsdf3QHg@mail.gmail.com>
 <CAE-0n51OA3c_hcnpJ-k5ZQvCN3kv8PcjLMRw4BLx9OKZPjGLcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n51OA3c_hcnpJ-k5ZQvCN3kv8PcjLMRw4BLx9OKZPjGLcA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-12-21, 14:51, Stephen Boyd wrote:
> Quoting Stephen Boyd (2021-09-14 12:49:13)
> > Quoting Kuogee Hsieh (2021-09-14 09:45:01)
> > > Both voltage and pre-emphasis swing level are set during link training
> > > negotiation between host and sink. There are totally four tables added.
> > > A voltage swing table for both hbr and hbr1, a voltage table for both
> > > hbr2 and hbr3, a pre-emphasis table for both hbr and hbr1 and a pre-emphasis
> > > table for both hbr2 and hbr3. In addition, write 0x0a to TX_TX_POL_INV is
> > > added to complete the sequence of configure dp phy base on HPG.
> > >
> > > Chnages in v2:
> > > -- revise commit test
> > > -- add Fixes tag
> > > -- replaced voltage_swing_cfg with voltage
> > > -- replaced pre_emphasis_cfg with emphasis
> > > -- delete drv_lvl_reg and emp_post_reg parameters from qcom_qmp_v4_phy_configure_dp_swing()
> > > -- delete drv_lvl_reg and emp_post_reg parameters from qcom_qmp_phy_configure_dp_swing()
> > >
> > > Changes in V3:
> > > -- add __qcom_qmp_phy_configure_dp_swing() to commit swing/pre-emphasis level
> > >
> > > Changes in V4:
> > > -- pass 2D array to __qcom_qmp_phy_configure_dp_swing()
> > >
> > > Fixes: aff188feb5e1 ("phy: qcom-qmp: add support for sm8250-usb3-dp phy")
> > > Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> > > ---
> >
> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> 
> Can this patch be picked up?

Somehow this is not in my queue. Kuogee can you add tags received and
rebase and send please


-- 
~Vinod
