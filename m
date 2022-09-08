Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63D75B150D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbiIHGsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiIHGrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:47:47 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B62BD2B16;
        Wed,  7 Sep 2022 23:47:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcQkK+rSq4c9JLVjMoeapd4DJuFOA8r3py1xRLDOdsl04TCgjhU9f/ZKeCdt+b/2mUfXNr4Adf7xbVqrPZBkcUGgfdZmOZZD+QorDCmo3jn9dvkVJpjal00dTX8rZMFkgVxFc/dHnrtLVJBtjPNaJAnz2vB0r4UHB7cKSX3jH7rBQLZ1MS+vWyQClIuzqhzWKTF7LHOuEklVUFRvJH+PPSZE0x/ogAryi47tPrXQ1he8+oSPR/oUIg1ZMdnY3rNmEqazBgGjFO9USQJYeGMFTrLnApjjcaJuuBZnoYn00YA31AV3vjHTVKrUpW5kWs+FSQpd2bagVctfNKa7sd2ysg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6LzYBVLiB4OLIdbI0hVyP5dTRLQswQ0mmo9DUHu9KA=;
 b=hQBTVSBzJRiAC0WNh7Ws3AspJ23wSDrVXRUPAIu+yu0VYcB9m0SNo8JJl1kWojeOoW351bvId0QbSwpRqpDsb2OanfYQSLUAQZ8imZM2pBFXW3WuYv4qKuflV/4YW180efNqGcA91ZKL6n94h/RKyoWgEZMXQKbLTKlDMZJi73pGjwiVJ3QceyI4+PSFWMrWu0Bka0m4O32hTJtKDvnYqxPC7oujLBHMKL4fTMpSMLZyM0Xbf1sM8A9RTfDlx5FVC+zM27Zs+SGAastRALYsR6iHISBJqm0AWJWejYU8XPjyRdFY+KauqrR8yH3NIMwn2mqOSBjmo+CtT70+Imk97Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6LzYBVLiB4OLIdbI0hVyP5dTRLQswQ0mmo9DUHu9KA=;
 b=Ial6UFznPe4oPNGS95V9YZq1hwRe68My5U6KmWFBEkZ2Zkzc+5A4LNSnWxHAbMrK9ndlTT9uDF1gQ46goyVCmhyRuGYyRqpnyxzTJrmUiwocQVjWMoxKsFDeHesh76pPXiSnZi79+HmUelzJeDUFFdZCq6+mudWjFQ1dwE7CysA=
Received: from BN9PR03CA0427.namprd03.prod.outlook.com (2603:10b6:408:113::12)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Thu, 8 Sep
 2022 06:47:33 +0000
Received: from BL02EPF0000C402.namprd05.prod.outlook.com
 (2603:10b6:408:113:cafe::e6) by BN9PR03CA0427.outlook.office365.com
 (2603:10b6:408:113::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Thu, 8 Sep 2022 06:47:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C402.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.10 via Frontend Transport; Thu, 8 Sep 2022 06:47:32 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 8 Sep
 2022 01:47:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 23:47:15 -0700
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 8 Sep 2022 01:47:11 -0500
From:   Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <saikrishna12468@gmail.com>,
        <git@amd.com>, Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: [PATCH v3 1/2] dt-bindings: mtd: spi-nor: Add reset-gpios property
Date:   Thu, 8 Sep 2022 12:14:27 +0530
Message-ID: <20220908064428.2962-2-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220908064428.2962-1-sai.krishna.potthuri@amd.com>
References: <20220908064428.2962-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C402:EE_|MN2PR12MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: fdf75e7b-f7bc-42d1-9d55-08da916601c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VTNmRv8GZakscBsTtjNkUgmBuMHYsDmoVLjLrU0nAwmxLZfNLG2NJG7mR9d7v/YRtN6v/fkKJT39uPBZvr7TZImnsbDl6iJ80lQKgwYqwi8la4+ioHKslRvQxPFGdLdbTI/EF/OtM+e+S8TLYJyE3TrqoCw0HHcDwAgjUY4i9lgx/dUF750E27vXhMWg5BNYPIXTUMrwnoszb7I3HqhlcBk9NOhMok/PEcosyxkNhkITUrZEdjDumBOlmBbiyTcOadtjxqw7SsbbE2jaUgtN/veVRgqI6/ufWiYXqCAY49yJ/9S/DJMm1Et6mbgHWY9g8o5p+r3FdHTYlXIWCve9efTU9akemfHRkg4v/KPeXximPDHKvjT3bC67LSj4pCPqkZORtC+fDd11z7QR6Lyw2/rmScOiYL5Y+UkHCPlTN69mzuSxbeMeM8+mhxnUA1LYX3/mkBNsTsR86B3QB3hQceRF4Ba8AFf1odcXz5PWIPehTFfbzsCWe9IANKgPcGH6AP+pUYQ8xphFZ8X6JcwQV4xVG6NVbnkanpTbs0bNtxsQUYOuJIm6LQH0q0RBPGTx0C4ODNj+yDWRvLBtZpv/oiKYGsJTxVJhZCh0Yv08+1k1bqv3tat+/VCY/3riWvg1gSX6O7KrReCCrEKNo4gyxx2Hi8KryoFtRkZy0j/DCly2XTZZ3+TdwJmZbbM/qYUm94ejmr5fxU2dERyaCPoUGh3PS5qUGaYHmXPphjEwu5H3yXCSd9Nwafdmyg4OaibJ0ErnZuqSxFxcDudeWjSQhgMUsgA956WEHGlw6cJhdk05iSG6VKbL8aZSv7NpYDxy
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(396003)(376002)(46966006)(40470700004)(36840700001)(426003)(41300700001)(478600001)(26005)(6666004)(2616005)(8936002)(2906002)(7416002)(5660300002)(82310400005)(40480700001)(1076003)(40460700003)(110136005)(186003)(54906003)(316002)(4326008)(70206006)(8676002)(336012)(356005)(47076005)(36756003)(81166007)(70586007)(103116003)(82740400003)(36860700001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 06:47:32.8247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf75e7b-f7bc-42d1-9d55-08da916601c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C402.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPI-NOR flashes have RESET pin which can be toggled using GPIO
controller, for those platforms reset-gpios property can be used to
reset the flash device.

Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
---
 Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
index 7149784a36ac..8a843b9b8673 100644
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
@@ -70,6 +70,12 @@ properties:
       be used on such systems, to denote the absence of a reliable reset
       mechanism.
 
+  reset-gpios:
+    description:
+      A GPIO line connected to the RESET (active low) signal of the device.
+      If "broken-flash-reset" is present then having this property does not
+      make any difference.
+
   partitions:
     type: object
 
@@ -88,6 +94,7 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     spi {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -97,6 +104,7 @@ examples:
             reg = <0>;
             spi-max-frequency = <40000000>;
             m25p,fast-read;
+            reset-gpios = <&gpio 12 GPIO_ACTIVE_LOW>;
         };
     };
 ...
-- 
2.17.1

