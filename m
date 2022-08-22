Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251F959B9DF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbiHVG5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbiHVG5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:57:09 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9627427FFA;
        Sun, 21 Aug 2022 23:57:08 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27M6ucFe114754;
        Mon, 22 Aug 2022 01:56:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661151398;
        bh=I7jdU1zmmDs7myrWAvkwS8cEQtFHjbMlJ153YZHskLQ=;
        h=From:To:CC:Subject:Date;
        b=WrIliB40qK/oYcq3qw7E4QHBURMgehpQlDVDOKaj56+ttKOqqJMHvsboHiEGizU63
         wXSIb54hxfCgPhWXQaZ8t/Czbefv7+Xqs1fEqkE9VKjh8xaKR8xPy+UqTnZz8TScOP
         R60NUwqq7HK3mEjCbvur6vlx5QWn4cnoS1CFJV+U=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27M6uc0r030460
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Aug 2022 01:56:38 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 22
 Aug 2022 01:56:37 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 22 Aug 2022 01:56:37 -0500
Received: from uda0492258.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27M6uX36084154;
        Mon, 22 Aug 2022 01:56:34 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <robh+dt@kernel.org>, <lee.jones@linaro.org>,
        <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <kishon@ti.com>,
        <vkoul@kernel.org>, <dan.carpenter@oracle.com>,
        <grygorii.strashko@ti.com>, <rogerq@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <s-vadapalli@ti.com>
Subject: [PATCH v3 0/2] Add support for QSGMII mode
Date:   Mon, 22 Aug 2022 12:26:29 +0530
Message-ID: <20220822065631.27933-1-s-vadapalli@ti.com>
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

v2 -> v3:
1. Add $ref to "phy@[0-9a-f]+$" pattern property in
   Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml.
2. Restrict the optional ti,qsgmii-main-ports property to
   ti,j7200-cpsw5g-phy-gmii-sel property by adding an else statement and
   disallowing it for other compatibles.
3. Move the "items" constraint for the ti,qsgmii-main-ports property to
   the place the property is defined.

v1->v2:
1. Rename ti,enet-ctrl-qsgmii as ti,qsgmii-main-ports.
2. Change ti,qsgmii-main-ports property from bitmask to integer.
3.Update commit message with property name as ti,qsgmii-main-ports.

v2: https://lore.kernel.org/r/20220816055848.111482-1-s-vadapalli@ti.com/
v1: https://lore.kernel.org/r/20220531111221.22963-1-s-vadapalli@ti.com/

Siddharth Vadapalli (2):
  dt-bindings: phy: ti: phy-gmii-sel: Add bindings for J7200
  phy: ti: gmii-sel: Add support for CPSW5G GMII SEL in J7200

 .../mfd/ti,j721e-system-controller.yaml       |  6 +++
 .../bindings/phy/ti,phy-gmii-sel.yaml         | 30 +++++++++++++-
 drivers/phy/ti/phy-gmii-sel.c                 | 40 +++++++++++++++++--
 3 files changed, 72 insertions(+), 4 deletions(-)

--
2.25.1

