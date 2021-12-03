Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74074467095
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 04:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378312AbhLCDQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 22:16:49 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58810 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbhLCDQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 22:16:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C800662929;
        Fri,  3 Dec 2021 03:13:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211E5C00446;
        Fri,  3 Dec 2021 03:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638501203;
        bh=DdwSeerV2Xi07oZhGu9qh5VtX+ueZAwyzDuRtv+i7dI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=USBCYJlPryWKcuiJQe74WOwsbu1u2M+dTdS/X75xp89aVakbgPflKpJ9wGWC1Y+dX
         kLYky5zJ2rcigzx4mDN/6DfyP72tR0sGogQNAeM2IoTa7xSh93cbsLLY8NRFfuZTUh
         UP0M7SVlPnnpoLehZ+GJtFhlw/s9OvC4Z0qmntD7NeMNW/eP6B54cLfjhktl2D8Nag
         PjfnhfxF3b1dGNLj4+uA0r6cxLWk3Z/gsjs31j18nLGf38bSPlA4bai8ak+M1uGIX1
         Vq4+ZpfnIXVnz7xsVhVh6rftWAhjF0uZxwJvo8HXYHuc+pD0lnl3Vo6xfRGH/gg3HK
         WE/WNTeMOpeFA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9161450a-40e0-c84f-f529-c903d6f1d722@quicinc.com>
References: <20211201072718.3969011-1-vkoul@kernel.org> <20211202230624.C05F3C00446@smtp.kernel.org> <9161450a-40e0-c84f-f529-c903d6f1d722@quicinc.com>
Subject: Re: [PATCH] spmi: pmic-arb: Add support for PMIC v7
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Dai <daidavid1@codeaurora.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Collins <quic_collinsd@quicinc.com>
To:     David Collins <quic_collinsd@quicinc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Date:   Thu, 02 Dec 2021 19:13:21 -0800
User-Agent: alot/0.9.1
Message-Id: <20211203031323.211E5C00446@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Collins (2021-12-02 15:51:18)
> On 12/2/21 3:06 PM, Stephen Boyd wrote:
> > Quoting Vinod Koul (2021-11-30 23:27:18)
> >> @@ -1169,8 +1270,12 @@ static int spmi_pmic_arb_probe(struct platform_=
device *pdev)
> >>         pmic_arb =3D spmi_controller_get_drvdata(ctrl);
> >>         pmic_arb->spmic =3D ctrl;
> >> =20
> >> +       /*
> >> +        * Don't use devm_ioremap_resource() as the resources are shar=
ed in
> >> +        * PMIC v7 onwards, so causing failure when mapping
> >> +        */
> >>         res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "co=
re");
> >> -       core =3D devm_ioremap_resource(&ctrl->dev, res);
> >> +       core =3D devm_ioremap(&ctrl->dev, res->start, resource_size(re=
s));
> >=20
> > What does this mean? We have two nodes in DT that have the same reg
> > properties? How does that work?
>=20
> PMIC Arbiter v7 has two SPMI bus master interfaces.  These are used to
> communicate with two sets of PMICs.  The SPMI interfaces operate
> independently; however, they share some register address ranges (e.g.
> one common one is used for APID->PPID mapping).

It looks like the two SPMI busses share the mapping table which is OK
because it's read-only but then the 'chnls' and 'obsrvr' regions are
also shared. There must be some global lock in place to make sure the
two controllers aren't writing to the same register in there? Or are we
saved because the mapping table splits the regions between the two
busses?

> The most
> straightforward way to handle this is to treat them as two independent
> top-level DT devices.
>=20
> In this case the "cnfg" address is used in the DT node name as that is
> unique between the two instances.

Nice trick. The reg properties aren't supposed to change order though so
we shouldn't do that.

>=20
> Here are the DT nodes used downstream on a target with PMIC Arbiter v7:
>=20
> spmi0_bus: qcom,spmi@c42d000 {
>         compatible =3D "qcom,spmi-pmic-arb";
>         reg =3D <0xc42d000 0x4000>,
>               <0xc400000 0x3000>,
>               <0xc500000 0x400000>,
>               <0xc440000 0x80000>,
>               <0xc4c0000 0x10000>;
>         reg-names =3D "cnfg", "core", "chnls", "obsrvr", "intr";
>         interrupts-extended =3D <&pdc 1 IRQ_TYPE_LEVEL_HIGH>;
>         interrupt-names =3D "periph_irq";
>         interrupt-controller;
>         #interrupt-cells =3D <4>;
>         #address-cells =3D <2>;
>         #size-cells =3D <0>;
>         cell-index =3D <0>;
>         qcom,channel =3D <0>;
>         qcom,ee =3D <0>;
>         qcom,bus-id =3D <0>;
> };
>=20
> spmi1_bus: qcom,spmi@c432000 {
>         compatible =3D "qcom,spmi-pmic-arb";
>         reg =3D <0xc432000 0x4000>,
>               <0xc400000 0x3000>,
>               <0xc500000 0x400000>,
>               <0xc440000 0x80000>,
>               <0xc4d0000 0x10000>;
>         reg-names =3D "cnfg", "core", "chnls", "obsrvr", "intr";
>         interrupts-extended =3D <&pdc 3 IRQ_TYPE_LEVEL_HIGH>;
>         interrupt-names =3D "periph_irq";
>         interrupt-controller;
>         #interrupt-cells =3D <4>;
>         #address-cells =3D <2>;
>         #size-cells =3D <0>;
>         cell-index =3D <0>;
>         qcom,channel =3D <0>;
>         qcom,ee =3D <0>;
>         qcom,bus-id =3D <1>;
> };

It feels like we should make a parent node that holds the core, chnls,
obsrvr reg properties with a new compatible string and then have two
child nodes for each bus. Then the various PMICs can hang off those two
different bus nodes. Of course, it needs DT review to make sure nothing
else goes wrong.

>=20
> Note the inclusion of a new DT property: "qcom,bus-id".  This was
> defined in a DT binding patch that isn't present in Vinod's submission.
> Here is its definition:
>=20
> - qcom,bus-id : Specifies which SPMI bus instance to use.  This property
>                 is only applicable for PMIC arbiter version 7 and
>                 beyond.
>                 Support values: 0 =3D primary bus, 1 =3D secondary bus
>                 Assumed to be 0 if unspecified.
>=20

How is it used in the driver? Does something care what is primary and
what is secondary?
