Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AF9542541
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441952AbiFHB7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1835870AbiFGX5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:57:06 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD7B154347
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 16:29:06 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id br33so12664439qkb.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 16:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FiG/Hud81dwYwv++beYl18TZSvKyeM5nOEBoDQXc/3k=;
        b=Mhd6cpCaYW2Tl9OtEjwkeQyhLh8AP+YBY8ohGYJRJEdwgvp9n5japd0qSF3K7ob11Q
         BZQzSwqd0ed8DunZ5Yq4By8en7g2y5YtH/Homnn6/QyOy4Jh5dMNYD0xxXUrlg2R0YOt
         VSi+8B3al9Gl19aXHSB3Zw/oU4PzIAOoLRIeS3ymUQb3becgGH8C+waoXnX7MoFChAUi
         QzSAYSEvNxpkdsTMB/lwDDMovbmZcAjGanIX5mh5RtEdVlzDF67Uutz5OzBSPIvp9ERX
         4YjM0t4ARG6gxXmfL2SCnKJwkGC79J1x+1mMQA1rY2ZUIgjq3UVifYVey3cU0Vw5l6II
         jGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FiG/Hud81dwYwv++beYl18TZSvKyeM5nOEBoDQXc/3k=;
        b=hIyACj8EdY5QMPZvCge+EEQE78b8DWuqkJ75PNYcYz9f7TRJIL6HcGKFakF9qY5pss
         MZKB3TmD9JpktXmHq9V3aaS+kl0W5l8X7EDj5WqkH0dteXWQ+41DYMP9Dc2RH+9RsCHj
         5G++aBdTrr2CQIUP4AEe8wC/2qlPEkLQ2tOa4bliwqK7/gN9I6e4MgXB4TFvUwZYrizd
         TeNur9Hc6uazygIQFL1vUAsb8yD6oII9vb4ajy6t1ty7vnw8qUSw7LyWyT6eXQVWKADf
         OJkfXbU06k/hiXJYpzHo4UQvITxlp3GJ0slXNDkjlyOa+q8SbK6zJCPITQrg4eY8QuzP
         mFkg==
X-Gm-Message-State: AOAM530zqm2uWuuBy2IxH5dc3Ezv/Ktzz+ATZZzDkuV4eezKLsygG2kv
        aKV8/idVz+eDpAh02kKilJrO35XBOSC1NZGNctf1jg==
X-Google-Smtp-Source: ABdhPJwwRGTBBD5DqoWSE8LyFQtfkj3/fAdtxJwR2bzfmzzNtNXVVBWyuAU1DMg4twFQYPKztB8GkiUIAIASkkTukhY=
X-Received: by 2002:a05:620a:4156:b0:6a6:f8d2:6d9e with SMTP id
 k22-20020a05620a415600b006a6f8d26d9emr1947955qko.30.1654644545911; Tue, 07
 Jun 2022 16:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220607213543.4057620-1-bjorn.andersson@linaro.org>
 <20220607213543.4057620-4-bjorn.andersson@linaro.org> <d9658f54-e594-8f0e-071e-ef627285d281@linaro.org>
 <Yp/ZkxNltUgE79nC@ripper>
In-Reply-To: <Yp/ZkxNltUgE79nC@ripper>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 8 Jun 2022 02:28:54 +0300
Message-ID: <CAA8EJppTa88Rbo5R1SbycfvpPMAB18DXPd_iGJ_M+swE9KBv2Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] phy: qcom-qmp: Add USB4 5NM QMP combo PHY registers
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jun 2022 at 02:02, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
>
> On Tue 07 Jun 15:24 PDT 2022, Dmitry Baryshkov wrote:
>
> > On 08/06/2022 00:35, Bjorn Andersson wrote:
> > > Add all registers defines from qcom,usb4-5nm-qmp-combo.h of the msm-5.4
> > > kernel. Offsets are adjusted to be relative to each sub-block, as we
> > > describe the individual pieces in the upstream kernel and "v5_5NM" are
> > > injected in the defines to not collide with existing constants.
> > >
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > ---
> > >
> > > Changes since v1:
> > > - New patch
> > >
> > >   .../qualcomm/phy-qcom-usb4-5nm-qmp-combo.h    | 1547 +++++++++++++++++
> > >   1 file changed, 1547 insertions(+)
> > >   create mode 100644 drivers/phy/qualcomm/phy-qcom-usb4-5nm-qmp-combo.h
> > >
> > > diff --git a/drivers/phy/qualcomm/phy-qcom-usb4-5nm-qmp-combo.h b/drivers/phy/qualcomm/phy-qcom-usb4-5nm-qmp-combo.h
> > > new file mode 100644
> > > index 000000000000..7be8a50269ec
> > > --- /dev/null
> > > +++ b/drivers/phy/qualcomm/phy-qcom-usb4-5nm-qmp-combo.h
> > > @@ -0,0 +1,1547 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +/*
> > > + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> > > + */
> > > +
> > > +#ifndef PHY_QCOM_V5_5NM_QMP_COMBO_USB4_H
> > > +#define PHY_QCOM_V5_5NM_QMP_COMBO_USB4_H
> > > +
> > > +/* USB4-USB3-DP Combo PHY register offsets */
> > > +/* Module: USB43DP_COM_USB43DP_COM_USB4_USB3_DP_COM */
> > > +#define USB43DP_V5_5NM_COM_PHY_MODE_CTRL                           0x00
> > > +#define USB43DP_V5_5NM_COM_SW_RESET                                        0x04
> > > +#define USB43DP_V5_5NM_COM_POWER_DOWN_CTRL                         0x08
> > > +#define USB43DP_V5_5NM_COM_SWI_CTRL                                        0x0c
> > > +#define USB43DP_V5_5NM_COM_TYPEC_CTRL                                      0x10
> > > +#define USB43DP_V5_5NM_COM_TYPEC_PWRDN_CTRL                                0x14
> > > +#define USB43DP_V5_5NM_COM_DP_BIST_CFG_0                           0x18
> > > +#define USB43DP_V5_5NM_COM_RESET_OVRD_CTRL1                                0x1c
> > > +#define USB43DP_V5_5NM_COM_RESET_OVRD_CTRL2                                0x20
> > > +#define USB43DP_V5_5NM_COM_DBG_CLK_MUX_CTRL                                0x24
> > > +#define USB43DP_V5_5NM_COM_TYPEC_STATUS                                    0x28
> > > +#define USB43DP_V5_5NM_COM_PLACEHOLDER_STATUS                              0x2c
> > > +#define USB43DP_V5_5NM_COM_REVISION_ID0                                    0x30
> > > +#define USB43DP_V5_5NM_COM_REVISION_ID1                                    0x34
> > > +#define USB43DP_V5_5NM_COM_REVISION_ID2                                    0x38
> > > +#define USB43DP_V5_5NM_COM_REVISION_ID3                                    0x3c
> >
> > QPHY_V5_DP_COM_foo ?
> >
>
> My first version of the QMP patch used V5 defines and USB worked
> sometimes. So I hacked up a thing to dump the phy sequences of the
> downstream and upstream kernels, compared the magic numbers and then
> tried to fit suitable constants.
>
> But it obviously was a waste of time and I would have to make up a
> different naming scheme for the ones that doesn't match the existing
> constants - when we could just use the autogenerated files that exist in
> the downstream kernels.
>
> [..]
> > > +#define USB43DP_V5_5NM_QSERDES_TXA_DEBUG_BUS1                              0xf0
> > > +#define USB43DP_V5_5NM_QSERDES_TXA_DEBUG_BUS2                              0xf4
> > > +#define USB43DP_V5_5NM_QSERDES_TXA_DEBUG_BUS3                              0xf8
> > > +#define USB43DP_V5_5NM_QSERDES_TXA_TX_BKUP_RO_BUS                  0xfc
> >
> > QSERDES_V5_20_TX_foo ? This looks compatible with the 4 registers that we
> > have in the header, but I can not verify the rest of registers
> >
>
> Exactly the point I was making in my reply to the other patch.
>
> Per the documentation this is version 5.0.0, but these register offsets
> happens to match the 5.20 defines that we have...
>
> > > +
> > > +/* Module: USB43DP_QSERDES_RXA_USB43DP_QSERDES_RXA_USB4_USB3_DP_QMP_RX */
> [..]
> > > +#define USB43DP_V5_5NM_QSERDES_RXA_RX_BKUP_READ_BUS3_STATUS                0x3e8
>
> And these, doesn't match either V5 or V5_20.

Yes, I guessed so.

>
> [..]
> > > +#define USB43DP_V5_5NM_QSERDES_TXB_TX_BKUP_RO_BUS                  0xfc
> >
> > What is the difference between _TXA_ and _TXB_ ?
> >
>
> Nothing, I just don't want us to mess around with these files if we can
> get them dumped from the register documentation.

Well, you still had the register offsets adjusted, hadn't you? I think
we can also apply sed to convert the names and then check if they
match the existing headers or not. If they do not, create a new
prefix, repeat, etc.

>
> > > +
> [..]
> > > +
> > > +/* Module: USB3_PCS_MISC_USB3_PCS_MISC_USB3_PCS_MISC */
> > > +#define USB3_V5_5NM_PCS_MISC_TYPEC_CTRL                                    0x00
> > > +#define USB3_V5_5NM_PCS_MISC_TYPEC_PWRDN_CTRL                              0x04
> > > +#define USB3_V5_5NM_PCS_MISC_PCS_MISC_CONFIG1                              0x08
> > > +#define USB3_V5_5NM_PCS_MISC_CLAMP_ENABLE                          0x0c
> > > +#define USB3_V5_5NM_PCS_MISC_TYPEC_STATUS                          0x10
> > > +#define USB3_V5_5NM_PCS_MISC_PLACEHOLDER_STATUS                            0x14
> >
> > QPHY_V4_PCS_MISC (or v5)
> >
>
> Perhaps, but then we're just making up those prefixes and hoping for the
> best.
>
> [..]
> > > +#define USB3_V5_5NM_PCS_EQ_CONFIG2                                 0x1e0
> > > +#define USB3_V5_5NM_PCS_EQ_CONFIG3                                 0x1e4
> > > +#define USB3_V5_5NM_PCS_EQ_CONFIG4                                 0x1E8
> > > +#define USB3_V5_5NM_PCS_EQ_CONFIG5                                 0x1EC
> >
> > This looks like both QPHY_V4_PCS and QPHY_V5_PCS. Most probably we should
> > merge them together and add these defines.
> >
>
> Exactly, all these defines looks like defines we already have and if you
> pick the wrong one you end up with things not working - or in my case
> something that worked sometimes.
>
> > > +
> > > +/* Module: USB3_PCS_USB3_USB3_PCS_USB3_USB3_PCS_USB3 */
> [..]
> > > +#define USB3_V5_5NM_PCS_USB3_RXTERMINATION_DLY_SEL                 0x60
> >
> > Again, QPHY_V5_PCS_USB w/o the 0x300 offset
> >
>
> Yeah, that extra region needs to be added to the binding and driver.

We can add it to the driver first (and just make it as an offset from pcs).

-- 
With best wishes
Dmitry
