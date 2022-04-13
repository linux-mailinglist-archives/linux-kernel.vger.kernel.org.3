Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396804FF798
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 15:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiDMN3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 09:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbiDMN3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 09:29:03 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8443C5D198;
        Wed, 13 Apr 2022 06:26:41 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id k23so3965001ejd.3;
        Wed, 13 Apr 2022 06:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=CSb8eXfi4X28YB6JnZMBoT5Zw178Jb3u+JBDfRQAguM=;
        b=JUiSoH3Sh7ufvAtp/1YhMcSgW+hKbCmq8VOb/r+qBA5GY4IE3vpkQpSisdMgsA6pis
         +R+mCjhrwG1l7GaUdhQusG3EhPM9Jy0obDLxSs6USKzUq+z/b1Z6uuz9q+tE39igYHuy
         UJSVY1kVhGXESKjve3OpGaeG0lJHVVAwflPCTOzY4/cuQbWBuFrllJ5ug5jgYmF8TBbk
         rSDwkMGpIF008ynIi+tm9eIJ02+cZKMiI8ax/iMbMfu2VFpStk/rKA7LYax5i4g+zKIF
         syuDuqnpozsWDuV9mM6nDGXL5Bx7pEfzSrV+/FBx7NvLpnAa+oXH8hqCHv+5B+TSxKhT
         IkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=CSb8eXfi4X28YB6JnZMBoT5Zw178Jb3u+JBDfRQAguM=;
        b=yX4vepMriUNSj0laq9OeMyCnrKz82dKcEEMlMCcdJNQn/vTxHcU6Q1NNzMwZBIpxWh
         g+a71/MeAi0k4OEEDhrwUC8Q0eq/j2lvVGN4dqk93JPVlL3uCTcax09RYIyQg9pWxJWz
         KOr9Toox1Nx0lIkJpIBtoU6QI5keEtUZwCDs0YpL6wACAAqOEwnCSLoMY28v+hsOOe4C
         T3kzvs0PdXqgnB1Gbl3/PTvihdYs2x6K+UExjiQGz5XdNJPAqxfZoiIhBF5maj3aHnf3
         XQyuIH0zJgNTUzWypSnWeCLGXqxdeviO59fIhZNDn127SFEDIaLr2hnGF0cdCoFPH37S
         DdQw==
X-Gm-Message-State: AOAM530FI92FeeGLO6GcTTqbmhig7xbkY948qCXFphVBQ7YAhTWXuFkL
        7WfMq2cPZAcFS6amMwoaVao=
X-Google-Smtp-Source: ABdhPJzSGApHRcC/6JIo3Z18BaToM/wyEJaY3ofsmWRsGW0EF896BAKDZCye8IsWf5NtXqaEsGTO9Q==
X-Received: by 2002:a17:907:868c:b0:6e8:d608:bcc7 with SMTP id qa12-20020a170907868c00b006e8d608bcc7mr777827ejc.148.1649856399891;
        Wed, 13 Apr 2022 06:26:39 -0700 (PDT)
Received: from Ansuel-xps. (host-80-182-176-248.retail.telecomitalia.it. [80.182.176.248])
        by smtp.gmail.com with ESMTPSA id s12-20020a1709062ecc00b006e8558c9a5csm6027235eji.94.2022.04.13.06.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 06:26:38 -0700 (PDT)
Message-ID: <6256cf8e.1c69fb81.b313c.dd8b@mx.google.com>
X-Google-Original-Message-ID: <YlbOXhL/Ni1R6kUu@Ansuel-xps.>
Date:   Wed, 13 Apr 2022 15:21:34 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH v3 07/18] ARM: dts: qcom: reduce pci IO size to 64K for
 ipq8064
References: <20220309190152.7998-1-ansuelsmth@gmail.com>
 <20220309190152.7998-8-ansuelsmth@gmail.com>
 <a7034b5e-24de-ef17-ae93-c626beb35a41@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7034b5e-24de-ef17-ae93-c626beb35a41@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 04:19:42PM +0300, Dmitry Baryshkov wrote:
> On 09/03/2022 22:01, Ansuel Smith wrote:
> > The current value for pci IO is problematic for ath10k wifi card
> > commonly connected to ipq8064 SoC.
> > The current value is probably a typo and is actually uncommon to find
> > 1MB IO space even on a x86 arch.
> 
> I checked other Qualcomm platforms (including downstream apq8084.dtsi). All
> of them list 1MB region as IO space.
> 
> Interesting enough I couldn't get PCI to work on my IFC6410 (apq8064). It
> has an ethernet adapter AR8151 sitting on the PCIe bus. The driver probes,
> transmits packets successfully, but receives only garbage. I'm not sure if
> it is the hardware or a software problem. Same adapter works fine on db820c.
>

I didn't understand if device works correctly without this change. 
The alternative to this, is to change the io space globally for every arm
target and it was pointed out that it was a strange change to do. 99%
the 1mb region present on every qcom platform is a copy past error but
still a region that big worked before some kernel version just because
the kernel didn't check them.
So it's both reduce IO in dtsi or extend IO_SPACE_LIMIT for every arm
target.

> > Also with recent changes to the pci
> > driver, pci1 and pci2 now fails to function as any connected device
> > fails any reg read/write. Reduce this to 64K as it should be more than
> > enough and 3 * 64K of total IO space doesn't exceed the IO_SPACE_LIMIT
> > hardcoded for the ARM arch.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > Tested-by: Jonathan McDowell <noodles@earth.li>
> > ---
> >   arch/arm/boot/dts/qcom-ipq8064.dtsi | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > index e247bf51df01..36bdfc8db3f0 100644
> > --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > @@ -918,7 +918,7 @@ pcie0: pci@1b500000 {
> >   			#address-cells = <3>;
> >   			#size-cells = <2>;
> > -			ranges = <0x81000000 0 0x0fe00000 0x0fe00000 0 0x00100000   /* downstream I/O */
> > +			ranges = <0x81000000 0 0x0fe00000 0x0fe00000 0 0x00010000   /* downstream I/O */
> >   				  0x82000000 0 0x08000000 0x08000000 0 0x07e00000>; /* non-prefetchable memory */
> >   			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> > @@ -969,7 +969,7 @@ pcie1: pci@1b700000 {
> >   			#address-cells = <3>;
> >   			#size-cells = <2>;
> > -			ranges = <0x81000000 0 0x31e00000 0x31e00000 0 0x00100000   /* downstream I/O */
> > +			ranges = <0x81000000 0 0x31e00000 0x31e00000 0 0x00010000   /* downstream I/O */
> >   				  0x82000000 0 0x2e000000 0x2e000000 0 0x03e00000>; /* non-prefetchable memory */
> >   			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> > @@ -1020,7 +1020,7 @@ pcie2: pci@1b900000 {
> >   			#address-cells = <3>;
> >   			#size-cells = <2>;
> > -			ranges = <0x81000000 0 0x35e00000 0x35e00000 0 0x00100000   /* downstream I/O */
> > +			ranges = <0x81000000 0 0x35e00000 0x35e00000 0 0x00010000   /* downstream I/O */
> >   				  0x82000000 0 0x32000000 0x32000000 0 0x03e00000>; /* non-prefetchable memory */
> >   			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
> 
> 
> -- 
> With best wishes
> Dmitry

-- 
	Ansuel
