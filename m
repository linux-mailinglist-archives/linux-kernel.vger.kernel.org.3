Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E78B4908B6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239896AbiAQMaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiAQMaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:30:15 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D01C061574;
        Mon, 17 Jan 2022 04:30:15 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id 60-20020a9d0142000000b0059103eb18d4so19509217otu.2;
        Mon, 17 Jan 2022 04:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xp4+4+Wf5tUKljhMRbkkPD6L+kcOJd/sxyMiSoMO1F8=;
        b=OfdJFKiAlYwn1IT48NdRrcoE/gTwmk3XVMQFUqA2U8dTNaQ3/elLCLqDvlU2ojCIMa
         L4E8269GygXEjsMK4aBgOBHW6TX9+T2vNFN5YHdkNz3TwOW+22AtOVfoWG1IA5JN2Mvz
         scVHgGfrfq1LSUGg6ggMA0yJL7BVpjqChodCUmojEOW8lpgz0AYfbL2BKc3I7WrLZpb9
         1NkCiiNxcOp9aeox2XZhcDqgJGS5hxs5D9jqylZ4hB9GSOTfiqglHBddjnSfonod+XmM
         Q47X3ZmlC1pu6XqHKqsD4TPs/jmbAXvsCpDswjQVyQjbXN+Ft8XM0J5PgIpRD3ZTlcYQ
         zG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xp4+4+Wf5tUKljhMRbkkPD6L+kcOJd/sxyMiSoMO1F8=;
        b=N1AGXRB8k+J3CJhSZGa3LixdiSQLswXA96lqZ55ZbMSss1gyPpJZC8D8jHwHzxGZ+M
         KkOzL1sCJheMz6XCknDsZLyrTCBxhu8NzIJCMXF9DJWy/IOiNsU0Ojyp/ZFo1H65EnmJ
         0cgoCyjz0lSvhOytjHh1XT7kDxLtuHED3Gd6jcWpZFAyw8atdF/ZbWtufx6ufs/QqjXd
         iIpXwHIeJHyER0/1EYd02xh5kYg7qhihNVowDarSHqGt2Q7RJJddSP/04UD6Wxa+Fnp9
         wXrw0S3stzAT8LvSA/WlUT1iuE11O2jI94NJRHnsGbqerB7cj+0UoxCgCsQMbcrNlwoo
         3C5g==
X-Gm-Message-State: AOAM531/i5UzM9+PSKzxrPimthc8AZmHNLgVUfIGWx3E6hwE8J9Ossgs
        tXJrR677PVEz1TvDYiRaBkgx3Ge2nSTDwJq0UW4r9/5UdUM=
X-Google-Smtp-Source: ABdhPJz4HHHPGxTLEZqNI3Bi+FfcVyBZCrg7v/hyl0ovPK3zpRfgk4Sncfbh/+u+Jqouz2UpX4d5AOHo5YavyfgWfis=
X-Received: by 2002:a9d:d08:: with SMTP id 8mr16850521oti.334.1642422614470;
 Mon, 17 Jan 2022 04:30:14 -0800 (PST)
MIME-Version: 1.0
References: <20220114233904.907918-1-sean.anderson@seco.com>
In-Reply-To: <20220114233904.907918-1-sean.anderson@seco.com>
From:   Jun Li <lijun.kernel@gmail.com>
Date:   Mon, 17 Jan 2022 20:30:03 +0800
Message-ID: <CAKgpwJUMXk--4EaYOxAAtLJT85mDHRHMihr6n7y1HECN+gmBBw@mail.gmail.com>
Subject: Re: [PATCH 0/6] usb: dwc3: Calculate REFCLKPER et. al. from reference clock
To:     Sean Anderson <sean.anderson@seco.com>, Li Jun <jun.li@nxp.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Felipe Balbi <balbi@kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Anderson <sean.anderson@seco.com> =E4=BA=8E2022=E5=B9=B41=E6=9C=8815=
=E6=97=A5=E5=91=A8=E5=85=AD 10:11=E5=86=99=E9=81=93=EF=BC=9A
>
> This is a rework of patches 3-5 of [1]. It attempts to correctly program
> REFCLKPER and REFCLK_FLADJ based on the reference clock frequency. Since
> we no longer need a special property duplicating this configuration,
> snps,ref-clock-period-ns is deprecated.
>
> Please test this! Patches 3/4 in this series have the effect of
> programming REFCLKPER and REFCLK_FLADJ on boards which already configure
> the "ref" clock. I have build tested, but not much else.

DWC3 databook states a *condition* for program those settings:

This field must be programmed to a non-zero value only if
GFLADJ_REFCLK_LPM_SEL is set to '1' or GCTL.SOFITPSYNC is set to '1'.
The value is derived as follows:
FLADJ_REF_CLK_FLADJ=3D((125000/ref_clk_period_integer)-(125000/ref_clk_peri=
od))
* ref_clk_period where
=E2=96=A0 the ref_clk_period_integer is the integer value of the ref_clk
period got by truncating the decimal (fractional) value that is
programmed in the GUCTL.REF_CLK_PERIOD field.
=E2=96=A0 the ref_clk_period is the ref_clk period including the fractional=
 value.

So you may need a condition check, with that, only required users
are effected even with "ref" clock specified.

Li Jun

>
> [1] https://lore.kernel.org/linux-usb/20220114044230.2677283-1-robert.han=
cock@calian.com/
>
>
> Sean Anderson (6):
>   dt-bindings: usb: dwc3: Deprecate snps,ref-clock-period-ns
>   usb: dwc3: Get clocks individually
>   usb: dwc3: Calculate REFCLKPER based on reference clock
>   usb: dwc3: Handle fractional reference clocks
>   arm64: dts: zynqmp: Move USB clocks to dwc3 node
>   arm64: dts: ipq6018: Use reference clock to set dwc3 period
>
>  .../devicetree/bindings/usb/snps,dwc3.yaml    |  7 +-
>  arch/arm64/boot/dts/qcom/ipq6018.dtsi         |  3 +-
>  .../arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi |  4 +-
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi        |  4 +-
>  drivers/usb/dwc3/core.c                       | 98 ++++++++++++++++---
>  drivers/usb/dwc3/core.h                       |  6 +-
>  6 files changed, 98 insertions(+), 24 deletions(-)
>
> --
> 2.25.1
>
