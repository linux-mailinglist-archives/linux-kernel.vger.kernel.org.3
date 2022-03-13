Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46A04D769C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 17:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbiCMQCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 12:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiCMQCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 12:02:19 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E590E89CE2;
        Sun, 13 Mar 2022 09:01:11 -0700 (PDT)
Received: from apollo.. (unknown [IPv6:2a02:810b:4340:43bf:4685:ff:fe12:5967])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id F1D4C22238;
        Sun, 13 Mar 2022 17:01:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1647187270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BMJ8vMF7BASLVLZYhk3xHd53t++fSBFmJliFAFF8JaE=;
        b=CDBuG19+Bhs0Cigf+XXpXCutMGKS2/ppu+6XG75xS1VKPL3rTUJQhFCoyu3sq4Cf4iNyh9
        aILsLyOkdgdTWrQ66swx4wVKaeO5C4oOHVyuuZCRGi7ncfOjkh0pnO+eL7PfqrpaZZwhlI
        BpwDaq543ixJhc8yUTetTEPKFd4w0uQ=
From:   Michael Walle <michael@walle.cc>
To:     horatiu.vultur@microchip.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, robh@kernel.org,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH 1/2] dt-bindings: reset: lan966x phy reset driver bindings
Date:   Sun, 13 Mar 2022 17:00:56 +0100
Message-Id: <20220313160056.8767-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211029125848.k4vwmzxpljbwlve6@soft-dev3-1.localhost>
References: <20211029125848.k4vwmzxpljbwlve6@soft-dev3-1.localhost>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Horatiu,

> > On Tue, Oct 19, 2021 at 01:52:04PM +0200, Horatiu Vultur wrote:
> > > Document the lan966x phy reset device driving bindings.
> > > It is using register access for the internal PHYs and toggles
> > > GPIO for external PHYs.
> > >
> > > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > > ---
> > >  .../bindings/reset/lan966x-phy,rst.yaml       | 53 +++++++++++++++++++
> > >  1 file changed, 53 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/reset/lan966x-phy,rst.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/reset/lan966x-phy,rst.yaml b/Documentation/devicetree/bindings/reset/lan966x-phy,rst.yaml
> > > new file mode 100644
> > > index 000000000000..35a32458cafe
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/reset/lan966x-phy,rst.yaml
> > > @@ -0,0 +1,53 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: "http://devicetree.org/schemas/reset/lan966x-phy,rst.yaml#"
> > > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > > +
> > > +title: Microchip Lan966x PHY Reset
> > > +
> > > +maintainers:
> > > +  - Horatiu Vultur <horatiu.vultur@microchip.com>
> > > +
> > > +description: |
> > > +  The Microchip Lan966x Switch provides 2 internal PHY which needs to be
> > > +  released from reset before they can be accessed. Also it might have external
> > > +  PHYs which requires to toggle a GPIO before the access to the PHYs.

I don't think this driver is needed at all. See more below.

> > > +  external-phy-reset-gpios:
> > > +    description: used for release of reset of the external PHY
> > > +    maxItems: 1
> > 
> > This belongs in the external PHY's node.
> 
> My problem is if I put this in the external PHY's node, once the switch
> gets reset it would reset also the GPIO pin and then it can't connect
> to the external PHYs anymore.

But this will only solve your use case. If there is anything else
connected on the GPIO it will be reset, too. So you'd loose GPIO state
and you just 'fix' the exernal PHY reset lines here.

Fortunately, this is already solved by the shared reset lines. See [1]
for my proposal. Once the GPIO controller isn't reset anymore, we can
describe the reset line to the external PHYs by using the "reset-gpios"
property of the MDIO controller.

> The switch will need anyway to call this driver to release the reset of
> the internal PHYs, so I was thinking to put also the release of the
> external PHYs in the same driver.

There is already support for this in the MDIO driver, see [2]. This
is already used on the Ocelot series.

> Initially we wanted to extend the 'sparx5-switch-reset' driver to do
> this but the output of that discussion was to have 2 different drivers,
> one for the switch and one for the PHYs.

-michael

[1] https://lore.kernel.org/linux-devicetree/20220313154640.63813-1-michael@walle.cc/
[2] https://lore.kernel.org/netdev/20220313002153.11280-1-michael@walle.cc/
