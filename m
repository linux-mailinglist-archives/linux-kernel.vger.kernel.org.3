Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DF555024B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 05:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384004AbiFRDDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 23:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383900AbiFRDDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 23:03:41 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520BA6CAA7;
        Fri, 17 Jun 2022 20:03:40 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25I32Nt4004650;
        Fri, 17 Jun 2022 22:02:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1655521343;
        bh=v9iLe16OQzDjus8PgEyzt81ju785zygpn75Qb7cPKDk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ubm9+IAhGGTk3kdTt5x7vdcv21zn8SduavN1QPsDFtatpMEQLnnpq14kmxzjhSdoM
         EhSYzwprF+3qoaWgxqEa7tkCA7AfNzT0CIUyyPN2V1vMiSYZKDtU+T7Pvq2yIkEfs4
         7jCtmDUFYShPMx+ispwTz24Ou/91SMS8cN3blxkI=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25I32NTI008896
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jun 2022 22:02:23 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 17
 Jun 2022 22:02:22 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 17 Jun 2022 22:02:22 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25I32MBg024730;
        Fri, 17 Jun 2022 22:02:22 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <krzysztof.kozlowski@linaro.org>, <olof@lixom.net>,
        <soc@kernel.org>, Arnd Bergmann <arnd@arndb.de>, <arm@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <linux-input@vger.kernel.org>,
        <khuong@os.amperecomputing.com>, <heiko@sntech.de>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <jonathanh@nvidia.com>, <sebastian.hesselbarth@gmail.com>,
        <agross@kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <tony@atomide.com>,
        <nicolas.ferre@microchip.com>, <joel@jms.id.au>,
        <linux-arm-msm@vger.kernel.org>, <robh+dt@kernel.org>,
        <bcousson@baylibre.com>, <thierry.reding@gmail.com>,
        <claudiu.beznea@microchip.com>, <vigneshr@ti.com>,
        <bjorn.andersson@linaro.org>, <openbmc@lists.ozlabs.org>,
        <peda@axentia.se>, <andrew@lunn.ch>,
        <linux-aspeed@lists.ozlabs.org>, <linus.walleij@linaro.org>,
        <festevam@gmail.com>, <xuwei5@hisilicon.com>,
        <alexandre.belloni@bootlin.com>, <leoyang.li@nxp.com>,
        <michal.simek@xilinx.com>, <andrew@aj.id.au>, <kristo@kernel.org>,
        <linux-imx@nxp.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        <linux-arm-kernel@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <j.neuschaefer@gmx.net>, <gregory.clement@bootlin.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>, <linux@armlinux.org.uk>,
        <kernel@pengutronix.de>, <dmitry.torokhov@gmail.com>,
        <linux-tegra@vger.kernel.org>
Subject: Re: (subset) [PATCH v3 00/40] dt-bindings: input: gpio-keys: rework matching children
Date:   Fri, 17 Jun 2022 22:02:21 -0500
Message-ID: <165552126299.28422.3856100388848453087.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof Kozlowski,

On Wed, 15 Jun 2022 17:52:24 -0700, Krzysztof Kozlowski wrote:
> Merging
> =======
> 1. dt-bindings: rebased on top of Rob's:
>    https://lore.kernel.org/all/20220608211207.2058487-1-robh@kernel.org/
> 
> 2. DTS patches are independent. They can be picked up directly by sub-arch
>    maintainers, by Arnd or Olof, or eventually by me (if you wish).
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[29/40] arm64: dts: ti: align gpio-key node names with dtschema
        commit: 85423386c9763fb20159892631eccc481a2d9b71

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

