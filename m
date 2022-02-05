Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D3F4AA942
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 15:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380077AbiBEOBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 09:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245487AbiBEOBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 09:01:44 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A85C061348
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 06:01:38 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id bx2so3188422edb.11
        for <linux-kernel@vger.kernel.org>; Sat, 05 Feb 2022 06:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/T0j4YmGJcgpIu421P1/dimIR0CxdCqo8uH7IcJ/4gQ=;
        b=ycgJvcnTlpqZNVhoA9CjXAOtRLtmOrllHT1AJKLyornTNPy09m2qelUk1JxtgQwfsh
         Emsd2HifHnckUBnGChCm10HiE0IGAta4CrWgFdqWXZTB0d/+t1dZw4cE8uESEFK/KosN
         bnscZp2nSU9kcgN5jFuravGijoeZsmlL4Rmxva3vPzZlmXfGdBzwtPTh5tkcYcKs0Koh
         648OpvPXCqky7qcStI1CCBKxOht54+wepTL893Z13+mx+caKvBtpIh8t3q5S1jZcrj/I
         6mHMOlPCdcHY24RFD7mDo+S1PDZm58w+2q5k9PldbILlFD8u9WGQYAvzqjmpAvBTctw1
         TYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/T0j4YmGJcgpIu421P1/dimIR0CxdCqo8uH7IcJ/4gQ=;
        b=Z2QeBDRtOamT8EYsjNqcF78pIFt1iKe643lhuIFcRtpSxK/aKwomGvtsxTy4frNWsq
         roJoMXnVeh8XuFbF1CjCJbVfct2hLEE/O716XTbId5ztXcVqCT12AEDYvdsyrjS+I6/a
         7Jakd3CThThSK0AHCiC8WmqB1oA49s/AF5I3ZYhYsw21bFaa0GVckcT7RNTjHcvQyya6
         9WN0+TS49UeFvscXf9mtk61J9DehodFUyXlI/p0RLB721UPIOdT5ToHkQgfncaIt2J74
         KWL9oAeob9G9l2icl4cDxTD8HW2TjwtwmdIryMCXG4QyE7Ti0CUUs2De8ACJjf5Z0sKd
         5eKQ==
X-Gm-Message-State: AOAM531aqPC+iQg8uuMzc+zinr1NnlY+vUK2bXUeckW8QJshOGJrl/S4
        Q4C7RjoToaIOnJLga8HypVMSjBX7qGcEqLh1UwyBBA==
X-Google-Smtp-Source: ABdhPJxjORbMvr+wAzN/c18pI3z16Av5bxvxOpm75K+cTPP+HabLnq/blEZ/OGup/Zv8zvg4hjtNH/oISTd1EXOz5/M=
X-Received: by 2002:a05:6402:34c2:: with SMTP id w2mr4442225edc.357.1644069696418;
 Sat, 05 Feb 2022 06:01:36 -0800 (PST)
MIME-Version: 1.0
References: <20220125171129.472775-1-aford173@gmail.com> <20220125171129.472775-3-aford173@gmail.com>
 <43e29322-fc4d-2c72-86b2-1f41fb05a2f9@xs4all.nl>
In-Reply-To: <43e29322-fc4d-2c72-86b2-1f41fb05a2f9@xs4all.nl>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Sat, 5 Feb 2022 11:01:23 -0300
Message-ID: <CAAEAJfDfd83LWOZmcg-==JTs7QHveT3dQ=BdnFc21=zZXrTxuA@mail.gmail.com>
Subject: Re: [PATCH V4 02/11] dt-bindings: power: imx8mq: add defines for VPU
 blk-ctrl domains
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        linux-media <linux-media@vger.kernel.org>,
        Adam Ford <aford173@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn, Hans,

On Thu, 27 Jan 2022 at 05:46, Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> Shawn,
>
> Can you take patches 2-4 of this series or shall I? In the latter case I
> need your Acked-by for these three patches.
>

Gentle reminder about these patches.

Thanks!
Ezequiel


> Regards,
>
>         Hans
>
> On 25/01/2022 18:11, Adam Ford wrote:
> > From: Lucas Stach <l.stach@pengutronix.de>
> >
> > This adds the defines for the power domains provided by the VPU
> > blk-ctrl on the i.MX8MQ.
> >
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > Acked-by: Rob Herring <robh@kernel.org>
> >
> > diff --git a/include/dt-bindings/power/imx8mq-power.h b/include/dt-bindings/power/imx8mq-power.h
> > index 8a513bd9166e..9f7d0f1e7c32 100644
> > --- a/include/dt-bindings/power/imx8mq-power.h
> > +++ b/include/dt-bindings/power/imx8mq-power.h
> > @@ -18,4 +18,7 @@
> >  #define IMX8M_POWER_DOMAIN_MIPI_CSI2 9
> >  #define IMX8M_POWER_DOMAIN_PCIE2     10
> >
> > +#define IMX8MQ_VPUBLK_PD_G1          0
> > +#define IMX8MQ_VPUBLK_PD_G2          1
> > +
> >  #endif
>
