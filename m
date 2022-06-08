Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370E1543798
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 17:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244428AbiFHPjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 11:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244248AbiFHPjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:39:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF59914CA27;
        Wed,  8 Jun 2022 08:39:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B748360AEC;
        Wed,  8 Jun 2022 15:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1300BC34116;
        Wed,  8 Jun 2022 15:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654702742;
        bh=nsyJF3pXdweJoPkZuCtmk2FLBqcSIdPNeR+uaAPmkd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K1qQ8DTPCBBnskV/dUbQ3macERVbOoszjDUywAD2ERkwPhgvDEGLjnFpgnUR18t4C
         RGMyuR5Wwrucrbgy8Pf+xazXJYk3lOvvGv5pGLR6mh9YtZHYOu20IqRjAv5n3QlFFu
         hZ6JwUdIy1qhQBXmp+2tUfwWe7BaxrGdDpuhAhf70st36XwV2v4A/24VvTP1ZHIBBa
         HOD4Nz+ek1Shig3aNVsl/qAZXMDmL5equZF9oFi/XF7Z54DFGDHsJnv0hSaP27LBKj
         7/M5acZoNzTOUQQ2+gtWusi2QLKckrBnvVVBWfqC/6rPXKwaLpb9kX7Se6unhYkjPZ
         3Qm+zgxTU7sSw==
Date:   Wed, 8 Jun 2022 21:08:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] phy: qcom-qmp: Add USB4 5NM QMP combo PHY
 registers
Message-ID: <YqDCkNB9Ss0D9PnO@matsya>
References: <20220607213543.4057620-1-bjorn.andersson@linaro.org>
 <20220607213543.4057620-4-bjorn.andersson@linaro.org>
 <d9658f54-e594-8f0e-071e-ef627285d281@linaro.org>
 <Yp/ZkxNltUgE79nC@ripper>
 <CAA8EJppSKfWXoNhqj+XOVV18P+uP=5fo7kaOGNWdYnN-NH8xNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJppSKfWXoNhqj+XOVV18P+uP=5fo7kaOGNWdYnN-NH8xNw@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-06-22, 02:52, Dmitry Baryshkov wrote:
> On Wed, 8 Jun 2022 at 02:02, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
> >
> > On Tue 07 Jun 15:24 PDT 2022, Dmitry Baryshkov wrote:
> >
> > > On 08/06/2022 00:35, Bjorn Andersson wrote:
> > > > Add all registers defines from qcom,usb4-5nm-qmp-combo.h of the msm-5.4
> > > > kernel. Offsets are adjusted to be relative to each sub-block, as we
> > > > describe the individual pieces in the upstream kernel and "v5_5NM" are
> > > > injected in the defines to not collide with existing constants.
> > > >
> > > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > ---
> > > >
> > > > Changes since v1:
> > > > - New patch
> > > >
> > > >   .../qualcomm/phy-qcom-usb4-5nm-qmp-combo.h    | 1547 +++++++++++++++++
> > > >   1 file changed, 1547 insertions(+)
> > > >   create mode 100644 drivers/phy/qualcomm/phy-qcom-usb4-5nm-qmp-combo.h
> > > >
> > > > diff --git a/drivers/phy/qualcomm/phy-qcom-usb4-5nm-qmp-combo.h b/drivers/phy/qualcomm/phy-qcom-usb4-5nm-qmp-combo.h
> > > > new file mode 100644
> > > > index 000000000000..7be8a50269ec
> > > > --- /dev/null
> > > > +++ b/drivers/phy/qualcomm/phy-qcom-usb4-5nm-qmp-combo.h
> > > > @@ -0,0 +1,1547 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > > +/*
> > > > + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> > > > + */
> > > > +
> > > > +#ifndef PHY_QCOM_V5_5NM_QMP_COMBO_USB4_H
> > > > +#define PHY_QCOM_V5_5NM_QMP_COMBO_USB4_H
> > > > +
> > > > +/* USB4-USB3-DP Combo PHY register offsets */
> > > > +/* Module: USB43DP_COM_USB43DP_COM_USB4_USB3_DP_COM */
> > > > +#define USB43DP_V5_5NM_COM_PHY_MODE_CTRL                           0x00
> > > > +#define USB43DP_V5_5NM_COM_SW_RESET                                        0x04
> > > > +#define USB43DP_V5_5NM_COM_POWER_DOWN_CTRL                         0x08
> > > > +#define USB43DP_V5_5NM_COM_SWI_CTRL                                        0x0c
> > > > +#define USB43DP_V5_5NM_COM_TYPEC_CTRL                                      0x10
> > > > +#define USB43DP_V5_5NM_COM_TYPEC_PWRDN_CTRL                                0x14
> > > > +#define USB43DP_V5_5NM_COM_DP_BIST_CFG_0                           0x18
> > > > +#define USB43DP_V5_5NM_COM_RESET_OVRD_CTRL1                                0x1c
> > > > +#define USB43DP_V5_5NM_COM_RESET_OVRD_CTRL2                                0x20
> > > > +#define USB43DP_V5_5NM_COM_DBG_CLK_MUX_CTRL                                0x24
> > > > +#define USB43DP_V5_5NM_COM_TYPEC_STATUS                                    0x28
> > > > +#define USB43DP_V5_5NM_COM_PLACEHOLDER_STATUS                              0x2c
> > > > +#define USB43DP_V5_5NM_COM_REVISION_ID0                                    0x30
> > > > +#define USB43DP_V5_5NM_COM_REVISION_ID1                                    0x34
> > > > +#define USB43DP_V5_5NM_COM_REVISION_ID2                                    0x38
> > > > +#define USB43DP_V5_5NM_COM_REVISION_ID3                                    0x3c
> > >
> > > QPHY_V5_DP_COM_foo ?
> > >
> >
> > My first version of the QMP patch used V5 defines and USB worked
> > sometimes. So I hacked up a thing to dump the phy sequences of the
> > downstream and upstream kernels, compared the magic numbers and then
> > tried to fit suitable constants.
> >
> > But it obviously was a waste of time and I would have to make up a
> > different naming scheme for the ones that doesn't match the existing
> > constants - when we could just use the autogenerated files that exist in
> > the downstream kernels.
> 
> I decided that I should write more about it. My main issue with using
> downstream tables is that we end up with tons of repetitive defines.
> Each chip generation would bring 2-4 sets of tables, wouldn't it? This
> can easily become an unsupported beast.
> I'd propose to follow the opposite path. Let's split the existing
> tables on a per-generation, per-region basis. Yes, we'd end up with
> tens of the header files. However then when new generation arrives, we
> can split corresponding header files on a region-by-region basis, and
> compare each region with existing tables. If the region matches, use
> it. If it does not, create a new header. Yes, I can do this for the
> existing header as a continuation of the QMP split saga, if everybody
> agrees that this is a good path.
> 
> You can ask, why do I suggest such a scheme? Because it looks like the
> lowest common scheme. If we check downstream, we have USB/USB+DP with
> huge autogenerated tables. Then comes UFS, which mostly follows naming
> of the phy-qcom-qmp.h.
> 
> And the last one is a PCIe. I do not know about the sc8280xp, but for
> the rest of the platforms we do not have register names at all. When I
> was porting the SM8450 PCIe PHY support, I had to guess the correct
> generation beforehand. With just 5 QSERDES_COM_ namespaces, guessing
> is easy. If  we had separate namespaces for the UFS and for several
> USB PHY instances, guessing would be next to impossible. And then
> creating a correct table would also be impossible. Well, as long as we
> do not accept tables without register names.
> 
> Thus I think we should resort to using a single naming scheme rather
> than following downstream here. If you dislike existing
> QSERDES_Vn/QPHY_Vn, let's come up with something more sensible.

Bjorn has a valid point that we should not tinker with downstream
auto-generated headers and use as is. But Dmitry also has a good
argument of this becoming unmanageable mess.

So which of the lesser devils should we deal with... Former is easy to
do, latter involves a bit of work for kernel developers...

TBH My personal taste would be latter as that keeps the code clean... We
have seen the versions are getting managed terribly downstream.. Maybe
splitting the headers up is a good idea in that direction...

Thought...?
 
-- 
~Vinod
