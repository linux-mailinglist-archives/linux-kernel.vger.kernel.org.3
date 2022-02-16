Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7179D4B8F2B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 18:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237120AbiBPRde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 12:33:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiBPRdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 12:33:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383A021D082;
        Wed, 16 Feb 2022 09:33:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C903761BC5;
        Wed, 16 Feb 2022 17:33:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B78C340F1;
        Wed, 16 Feb 2022 17:33:15 +0000 (UTC)
Date:   Wed, 16 Feb 2022 23:03:12 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Hemant Kumar <hemantk@codeaurora.org>
Cc:     mhi@lists.linux.dev, quic_hemantk@quicinc.com,
        quic_bbhatt@quicinc.com, quic_jhugo@quicinc.com,
        vinod.koul@linaro.org, bjorn.andersson@linaro.org,
        dmitry.baryshkov@linaro.org, quic_vbadigan@quicinc.com,
        quic_cang@quicinc.com, quic_skananth@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        elder@linaro.org
Subject: Re: [PATCH v3 08/25] bus: mhi: ep: Add support for registering MHI
 endpoint controllers
Message-ID: <20220216173312.GF6225@workstation>
References: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
 <20220212182117.49438-9-manivannan.sadhasivam@linaro.org>
 <071200b2-8033-7016-f7e0-2a6ae6c947f2@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <071200b2-8033-7016-f7e0-2a6ae6c947f2@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 05:04:23PM -0800, Hemant Kumar wrote:
> Hi Mani,
> 
> On 2/12/2022 10:21 AM, Manivannan Sadhasivam wrote:
> > This commit adds support for registering MHI endpoint controller drivers
> > with the MHI endpoint stack. MHI endpoint controller drivers manages
> > the interaction with the host machines such as x86. They are also the
> > MHI endpoint bus master in charge of managing the physical link between the
> > host and endpoint device.
> > 
> > The endpoint controller driver encloses all information about the
> > underlying physical bus like PCIe. The registration process involves
> > parsing the channel configuration and allocating an MHI EP device.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >   drivers/bus/mhi/Kconfig       |   1 +
> >   drivers/bus/mhi/Makefile      |   3 +
> >   drivers/bus/mhi/ep/Kconfig    |  10 ++
> >   drivers/bus/mhi/ep/Makefile   |   2 +
> >   drivers/bus/mhi/ep/internal.h | 160 +++++++++++++++++++++++
> >   drivers/bus/mhi/ep/main.c     | 234 ++++++++++++++++++++++++++++++++++
> >   include/linux/mhi_ep.h        | 143 +++++++++++++++++++++
> >   7 files changed, 553 insertions(+)
> >   create mode 100644 drivers/bus/mhi/ep/Kconfig
> >   create mode 100644 drivers/bus/mhi/ep/Makefile
> >   create mode 100644 drivers/bus/mhi/ep/internal.h
> >   create mode 100644 drivers/bus/mhi/ep/main.c
> >   create mode 100644 include/linux/mhi_ep.h
> > 

[...]

> > +#define MHI_CTRL_INT_STATUS_A7			0x4
> can we get rid of all instances of "_A7" as this corresponds to Cortex-A7,
> in future this can change? At MHI core layer, we can avoid this naming
> convetion, even though register names are inculding them now and may change
> to something different later. This MHI EP driver would still be used for
> those new cortex vers.

Since these registers are not documented by the spec, I just went with
the register definition available for SDX55. But you are right, and Alex
too, that it may change in future.

I'll remove the A7 suffix.

Thanks,
Mani

> > +#define MHI_CTRL_INT_STATUS_A7_MSK		BIT(0)
> > +#define MHI_CTRL_INT_STATUS_CRDB_MSK		BIT(1)
> > +#define MHI_CHDB_INT_STATUS_A7_n(n)		(0x28 + 0x4 * (n))
> > +#define MHI_ERDB_INT_STATUS_A7_n(n)		(0x38 + 0x4 * (n))
> > +
> [..]
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a
> Linux Foundation Collaborative Project
