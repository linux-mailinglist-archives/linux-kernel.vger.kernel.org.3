Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAB85A9270
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbiIAIz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbiIAIzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:55:22 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197436C762;
        Thu,  1 Sep 2022 01:55:20 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2818tCgH071394;
        Thu, 1 Sep 2022 03:55:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1662022512;
        bh=Rp7Er2+2VSUffoa8YeSJqxXCd2HQa8OFaBesg8+O1Oo=;
        h=From:To:CC:Subject:Date;
        b=JwfIFzJiJbZWuUiGc+oVTqrs3QFjvyvNco758Hjuv+anedDgmcv7RSQalqT6gT4+y
         vbwt72WJzuQKuVZYJKDUlLceElNyxVoYx9sf8G3NZ1O9nZ3gN4/FN86iXIrj5/Ac/H
         A3AY8zL8P6/YU8paOY/MU3lMSUlYHMD3slZ6aq50=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2818tCIM118507
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Sep 2022 03:55:12 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 1 Sep
 2022 03:55:11 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 1 Sep 2022 03:55:11 -0500
Received: from uda0492258.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2818t7Ta061466;
        Thu, 1 Sep 2022 03:55:08 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <robh+dt@kernel.org>, <lee.jones@linaro.org>,
        <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <kishon@ti.com>,
        <vkoul@kernel.org>, <dan.carpenter@oracle.com>,
        <grygorii.strashko@ti.com>, <rogerq@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <s-vadapalli@ti.com>
Subject: [PATCH v4 0/2] Add support for QSGMII mode
Date:   Thu, 1 Sep 2022 14:25:04 +0530
Message-ID: <20220901085506.138633-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for J7200 CPSW5G.

Add support for QSGMII mode in phy-gmii-sel driver for CPSW5G in J7200.

Change log:

v3 -> v4:
1. Update $ref to /schemas/phy/phy-provider.yaml in
   Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml.
2. Update commit message for the "phy: ti: gmii-sel: Add support for
   CPSW5G GMII SEL in J7200" patch, describing the reason for defining the
   property "ti,qsgmii-main-ports" as an array.
3. Add a check in drivers/phy/ti/phy-gmii-sel.c to ensure that the value
   of the variable "main_ports" is within bounds. If the property
   "ti,qsgmii-main-ports" is either not mentioned in the devicetree or the
   value of the property is out of bounds, in both these cases,
   "main_ports" defaults to 1.
4. Use the function "of_property_read_u32()" instead of the function
   "of_property_read_u32_array()" in drivers/phy/ti/phy-gmii-sel.c.

v2 -> v3:
1. Add $ref to "phy@[0-9a-f]+$" pattern property in
   Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml.
2. Restrict the optional ti,qsgmii-main-ports property to
   ti,j7200-cpsw5g-phy-gmii-sel property by adding an else statement and
   disallowing it for other compatibles.
3. Move the "items" constraint for the ti,qsgmii-main-ports property to
   the place the property is defined.

v1 -> v2:
1. Rename ti,enet-ctrl-qsgmii as ti,qsgmii-main-ports.
2. Change ti,qsgmii-main-ports property from bitmask to integer.
3. Update commit message with property name as ti,qsgmii-main-ports.

v3: https://lore.kernel.org/r/20220822065631.27933-1-s-vadapalli@ti.com/
v2: https://lore.kernel.org/r/20220816055848.111482-1-s-vadapalli@ti.com/
v1: https://lore.kernel.org/r/20220531111221.22963-1-s-vadapalli@ti.com/


Siddharth Vadapalli (2):
  dt-bindings: phy: ti: phy-gmii-sel: Add bindings for J7200
  phy: ti: gmii-sel: Add support for CPSW5G GMII SEL in J7200

 .../mfd/ti,j721e-system-controller.yaml       |  6 +++
 .../bindings/phy/ti,phy-gmii-sel.yaml         | 30 +++++++++++-
 drivers/phy/ti/phy-gmii-sel.c                 | 47 +++++++++++++++++--
 3 files changed, 79 insertions(+), 4 deletions(-)

-- 
2.25.1

