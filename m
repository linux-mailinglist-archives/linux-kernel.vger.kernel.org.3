Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94EB5112F6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbiD0H5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359132AbiD0H45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:56:57 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB5C1430EB;
        Wed, 27 Apr 2022 00:53:46 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C1B55221D4;
        Wed, 27 Apr 2022 09:53:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1651046024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MWEUJ65xXWxsOJoEBYb6OiJI9nm2vcZAzwPP79rJezw=;
        b=ISwvpTkTdIjkH410nQc3wKfzj5HuNCcoV6P66P38iTcySXiCcerHt70giJyG2GQ5O1z6a7
        lEBreCV41bbcHA5i4ZrRVrNE1jAxVRV0HlKth63PW9VPzQzDA24h4CCbFJHx35T2oI27x5
        Tkf8Ov2C9+ylnCxcF4Fq+RhlTi49EiM=
From:   Michael Walle <michael@walle.cc>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>,
        Shawn Guo <shawnguo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] dt-bindings: convert freescale extirq and scfg schemas
Date:   Wed, 27 Apr 2022 09:53:34 +0200
Message-Id: <20220427075338.1156449-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first two patches will be resend to the soc tree once the schema is
approved/picked up.

Please note, I'm still getting these weird "is too short" errors for
for interrupt-map entries, but it seems to work for you, so.. ;)

Michael Walle (4):
  ARM: dts: ls1021a: reduce the interrupt-map-mask
  arm64: dts: freescale: reduce the interrup-map-mask
  dt-bindings: interrupt-controller: fsl,ls-extirq: convert to YAML
  dt-bindings: fsl: convert fsl,layerscape-scfg to YAML

 .../arm/freescale/fsl,layerscape-scfg.txt     |  19 ---
 .../interrupt-controller/fsl,ls-extirq.txt    |  53 --------
 .../interrupt-controller/fsl,ls-extirq.yaml   | 118 ++++++++++++++++++
 .../bindings/soc/fsl/fsl,layerscape-scfg.yaml |  58 +++++++++
 arch/arm/boot/dts/ls1021a.dtsi                |   2 +-
 .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi |   2 +-
 .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi |   2 +-
 .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi |   2 +-
 .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi |   2 +-
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi |   2 +-
 10 files changed, 182 insertions(+), 78 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-scfg.txt
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/fsl,layerscape-scfg.yaml

-- 
2.30.2

