Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E484AEE2F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 10:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbiBIJjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 04:39:52 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbiBIJf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 04:35:59 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE883E010917;
        Wed,  9 Feb 2022 01:35:53 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nHj3m-0007nJ-En; Wed, 09 Feb 2022 10:14:46 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Rob Herring <robh@kernel.org>,
        =?utf-8?B?6LW15Luq5bOw?= <yifeng.zhao@rock-chips.com>,
        "zyf@rock-chips.com" <zyf@rock-chips.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        linux-rockchip <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        robh+dt <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        =?utf-8?B?6ZmI5Lqu?= <cl@rock-chips.com>, kishon <kishon@ti.com>,
        "Kever. Yang" <kever.yang@rock-chips.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "david.wu@rock-chips.com" <david.wu@rock-chips.com>,
        "michael. riesch" <michael.riesch@wolfvision.net>,
        linux-phy <linux-phy@lists.infradead.org>,
        =?utf-8?B?5ZC06Imv5bOw?= <wulf@rock-chips.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH v8 2/4] dt-bindings: phy: rockchip: Add Naneng combo PHY bindings
Date:   Wed, 09 Feb 2022 10:14:45 +0100
Message-ID: <6069846.8JqooZBoOc@diego>
In-Reply-To: <2022020911371529703712@rock-chips.com>
References: <20220208091326.12495-1-yifeng.zhao@rock-chips.com> <1644352412.075016.2969144.nullmailer@robh.at.kernel.org> <2022020911371529703712@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Mittwoch, 9. Februar 2022, 04:38:15 CET schrieb zyf@rock-chips.com:
> Hi Rob,
> 
> We move "rockchip,rk3568-pipe-grf" from syscon.yaml to grf.yaml.
> How to fix this compilation failed?

as you can see in the example, there is already a
	#include <dt-bindings/clock/rk3568-cru.h>
so you probably just need to add another include for the grf.yaml


Heiko

> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index fdd96e378df0..e9bb96ab9446 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -52,6 +52,8 @@ properties:
>                - rockchip,rk3288-qos
>                - rockchip,rk3368-qos
>                - rockchip,rk3399-qos
> +              - rockchip,rk3568-pipe-grf
> +              - rockchip,rk3568-pipe-phy-grf
> 
> 
> >On Tue, 08 Feb 2022 17:13:24 +0800, Yifeng Zhao wrote:
> >> Add the compatible strings for the Naneng combo PHY found on rockchip SoC.
> >>
> >> Reviewed-by: Rob Herring <robh@kernel.org>
> >> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> >> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> >> ---
> >>
> >> Changes in v8: None
> >> Changes in v7:
> >> - remove u3otg0_port_en, u3otg1_port_en and pipe_sgmii_mac_sel
> >>
> >> Changes in v5:
> >> - modify description for ssc and ext-refclk
> >> - remove apb reset
> >>
> >> Changes in v4:
> >> - restyle
> >> - remove some minItems
> >> - add more properties
> >> - remove reset-names
> >> - move #phy-cells
> >> - add rockchip,rk3568-pipe-grf
> >> - add rockchip,rk3568-pipe-phy-grf
> >>
> >> Changes in v3: None
> >> Changes in v2:
> >> - Fix dtschema/dtc warnings/errors
> >>
> >>  .../phy/phy-rockchip-naneng-combphy.yaml      | 109 ++++++++++++++++++
> >>  1 file changed, 109 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
> >>
> > 
> >My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> >on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> >yamllint warnings/errors:
> > 
> >dtschema/dtc warnings/errors:
> >Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.example.dt.yaml:0:0: /example-0/syscon@fdc50000: failed to match any schema with compatible: ['rockchip,rk3568-pipe-grf', 'syscon']
> >Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.example.dt.yaml:0:0: /example-0/syscon@fdc70000: failed to match any schema with compatible: ['rockchip,rk3568-pipe-phy-grf', 'syscon']
> > 
> >doc reference errors (make refcheckdocs):
> > 
> >See https://patchwork.ozlabs.org/patch/1589719
> > 
> >This check can fail if there are any dependencies. The base for a patch
> >series is generally the most recent rc1.
> > 
> >If you already ran 'make dt_binding_check' and didn't see the above
> >error(s), then make sure 'yamllint' is installed and dt-schema is up to
> >date:
> > 
> >pip3 install dtschema --upgrade
> > 
> >Please check and re-submit.
>  
>  
> 




