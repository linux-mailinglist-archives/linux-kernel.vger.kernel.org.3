Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE0A577583
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 11:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbiGQJUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 05:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGQJUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 05:20:42 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F1AC1;
        Sun, 17 Jul 2022 02:20:41 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v16so12848506wrd.13;
        Sun, 17 Jul 2022 02:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=r99CdT1PzVk6pdobY2R7Np2RplJVZgM0dg4GVhWWAAw=;
        b=IohY1BZ5m9i4q7LqwaNwUFM/RlgDdu8YnXhJThZoBUomEtGuDfd7Bdq1u5mdN3Mp2K
         Eth4F1WF5Q2CDkGt9ETihUvIYMA6hmo7xLxjYc6LXRajZgIplsl4PUnm+VNV3QG3D1sh
         yyk1kz7dWM13AJbfCRsn7qcUtLT3yzerOn2UEsf1sKX/8YoDQMQAg39FKtTChAQWev5Y
         5DEepa4g+PaFBcGkV6zdOBIbRg9S/UbS8rWhm/xOv1b0oFfOw98YQttN2+tMTzvqc3HH
         avPwA1rPCs2gWJa3ox6szmV+YRxQ1d7WpiSlCYYr/SiBCLzdvcGLdGjsUBcUq+RW6bfN
         NlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=r99CdT1PzVk6pdobY2R7Np2RplJVZgM0dg4GVhWWAAw=;
        b=Wuj9/+pJrbv/EKOC3h8KfN3t3QFbvXp0urvdTNYC03kY9ah3jhMAVwBazLnO0mESE2
         rypWVTOXFrn+Y+zr9sOjRi4mv6ViR8HA+kPkUvBxHopxbgO7hxCiPuLyOcsDtFihYcBr
         o729W4p5Yuk9ZUBlXLlFxivpo5PmEqRZfLU5KrU27UNObVID0Anu4oQkB7o5F2H9nDQn
         yR9Rx0j7dBSdb9/Aj82VP8ShDIaN6mLI7jDDIrgoxiakR4jaftxB8Kuf0YnFf0DePtE3
         i7c6RvHL7fkrM/Moc3Gg/9+WcevzXjVbNG2p5NpR1pPQvoxWR8YwFvOm9gh3i2GSYf9C
         WLlA==
X-Gm-Message-State: AJIora9jV9jpQpcFQjTcBTy3W3ZC0qLtFX1Dxt2AtQolxGpdzQYgTjKu
        ICVE3dvzPeWoy4H7QLuBFv0=
X-Google-Smtp-Source: AGRyM1sDoOnrWRnbbuSVgNasWg26N0yAF0DmpPFLksHtx/LOrUgIzgFzRHuRK4fXDNSaXZBOsAOoAQ==
X-Received: by 2002:adf:e28a:0:b0:210:b31:722 with SMTP id v10-20020adfe28a000000b002100b310722mr19054605wri.65.1658049639999;
        Sun, 17 Jul 2022 02:20:39 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id t64-20020a1c4643000000b003a30c3d0c9csm8211385wma.8.2022.07.17.02.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 02:20:39 -0700 (PDT)
Message-ID: <62d3d467.1c69fb81.5f14.0dce@mx.google.com>
X-Google-Original-Message-ID: <YtPUZcE5x+CGKzhq@Ansuel-xps.>
Date:   Sun, 17 Jul 2022 11:20:37 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] Add ipq806x missing bindings
References: <20220707010943.20857-1-ansuelsmth@gmail.com>
 <YtN3/wYKFeAZEsX8@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtN3/wYKFeAZEsX8@builder.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 09:46:23PM -0500, Bjorn Andersson wrote:
> On Wed 06 Jul 20:09 CDT 2022, Christian Marangi wrote:
> 
> > This is a respin of "Multiple addition to ipq8064 dtsi" series
> > with major changes and some commit removed.
> > 
> > This series try to add some of the missing bindings for ipq806x.
> > 
> > This still lacks of the cpu bindings and all the bindings required
> > to scale cpu clk or L2. These will come later as the driver and
> > documentation require some changes.
> > 
> > So for now we try to add bindings that can directly applied without
> > making changes to any drivers.
> > 
> > Changes:
> > v2:
> > - Dropped "add sic non secure node for ipq8064" (no user found)
> > - Dropped "add smem node for ipq8064" (require changes to the driver
> >   to remove syscon node and use regs directly, will be added in a
> >   different series)
> > - Dropped "fix dtc warning for missing #address-cells for ipq8064" (
> >   doesn't actually fix any warning)
> > - Changed "enable usb phy by default for ipq8064" to disable usb phy
> >   by default
> > - Reworked rpm smb208 declaration to a saparate dtsi
> > - Fixed order with compatible-reg-status
> > - Squashed "remove redundant binding from ipq8064 rb3011 dts" with
> >   "add multiple missing pin definition for ipq8064" to prevent dtc
> >   error.
> > - Add review tag for snps patch
> > 
> > Changes from "Multiple addition to ipq8064 dtsi":
> > v3:
> > - Fix error in rb3011 dts
> > - Add tested-by tag on the entire series
> > v2:
> > - Added missing patch
> > - Added additional gsbi6 spi
> > - Added extra description for L2 cache opp
> > - Fxied smb208 enabled by default that is problematic for rb3011 devices
> > 
> > Christian Marangi (8):
> >   ARM: dts: qcom: add multiple missing pin definition for ipq8064
> >   ARM: dts: qcom: add gsbi6 missing definition for ipq8064
> >   ARM: dts: qcom: add specific ipq8064 dtsi with smb208 rpm regulators
> >   ARM: dts: qcom: add missing snps,dwmac compatible for gmac ipq8064
> >   ARM: dts: qcom: disable usb phy by default for ipq8064
> >   ARM: dts: qcom: reduce pci IO size to 64K for ipq8064
> >   ARM: dts: qcom: fix and add some missing gsbi node for ipq8064
> >   ARM: dts: qcom: add speedbin efuse nvmem node
> 
> Please prefix your ipa8064-specific patches with
>   "ARM: dts: qcom: ipq8064: ..."
> 
> It makes the git history easier to read, so I fixed it up while applying
> these.
>

Oh ok! I wasn't aware of this tag looking at the old commits. Will do
that in the next commits.

> > 
> >  arch/arm/boot/dts/qcom-ipq8064-ap148.dts   |   6 -
> >  arch/arm/boot/dts/qcom-ipq8064-rb3011.dts  |   9 --
> >  arch/arm/boot/dts/qcom-ipq8064-smb208.dtsi |  37 +++++
> >  arch/arm/boot/dts/qcom-ipq8064.dtsi        | 150 +++++++++++++++++++--
> >  4 files changed, 179 insertions(+), 23 deletions(-)
> >  create mode 100644 arch/arm/boot/dts/qcom-ipq8064-smb208.dtsi
> > 
> > -- 
> > 2.36.1
> > 

-- 
	Ansuel
