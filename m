Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669CB59D0F8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 08:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240441AbiHWGBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 02:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239864AbiHWGBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 02:01:10 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2123.outbound.protection.outlook.com [40.107.243.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19515FACE;
        Mon, 22 Aug 2022 23:01:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVoeyliMDxW3sNwFZQD7uhvljDG538L0XTh5YfSTCwXdC24sMuenSqNafJX9mis1l2GxLNJ6lKttvQi/vXGE0hdcSaM8FdLYuXAgIA6ac15bpY4OjIv+bi63rI6wFsrPUBNKb0tQCzN+kr8CYCq8gQumzW9BcfvNCzyjKODPkkTKw8MB5ZvDtszUPKUZEF6UedvJihxtchM4BwwskGpMNqTVwPE/g1x9UneY09skLFR8zGVHdWbpFmBStSFfs+FcpcSSrgpNqPMWIu7e68pJ6wSMDcPRnXuChD7v2+HHQ1bPISgzO/ycKsV7dxQb34CcIrdg9qYeaaLHNAhAfa6jJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWl8WJlZlg9EK+sQRmc6nuPyK2n9bVOnW2dI8MsIlQc=;
 b=R+feRj39FnBp9trFAbyNvl/bQ44t7IbrCMEzKz75Dv6TYeqWZjbKCyeU8UG9UFTqiESmDXWds3fpD0lELixueZiFHdROTREZ770Mir1305ist/514v64xt6lxaFefzXX2vFIjmkcwi3lfyGuBdmuAI7WwiKh7rPQBgedsJS12CVWaeb/HWYumQ3UzeBXqz+QLs/10lTMHC4qRSOWnikLOGJDltwk2SueYb2kYX8JHmBL85YSgD+TRP4e6lbUmGOHVuGyXgc7V21pzCfFfc9AlPIyXwoxtjlh0bhT081qk9Y8ELR1iM8dKPRqKNLUkB706hZ+cneYSi11HFGVhKbjlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWl8WJlZlg9EK+sQRmc6nuPyK2n9bVOnW2dI8MsIlQc=;
 b=Ed4Bm5el7MGQ9tdVyl81osH+d1V/ip+KXFm8oXdV+pUIB3GY0xeV9HIrLa7Acrt/4wGwrVY19PcxuKZFR1Z/naQyy33fIKYTnkGesydUjfoxAjtc1zgMXuDjFJhsPfx6NLc5GcJkUrOIe3taigPZYHwlfS3CmwNvrZflUgRiU38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by BYAPR10MB2984.namprd10.prod.outlook.com
 (2603:10b6:a03:8f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Tue, 23 Aug
 2022 06:01:05 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::b869:6c52:7a8d:ddee]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::b869:6c52:7a8d:ddee%4]) with mapi id 15.20.5504.028; Tue, 23 Aug 2022
 06:01:05 +0000
From:   Colin Foster <colin.foster@in-advantage.com>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     UNGLinuxDriver@microchip.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v1 1/1] dt-bindings: phy: ocelot-serdes: convert to YAML
Date:   Mon, 22 Aug 2022 23:00:52 -0700
Message-Id: <20220823060052.3921849-2-colin.foster@in-advantage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220823060052.3921849-1-colin.foster@in-advantage.com>
References: <20220823060052.3921849-1-colin.foster@in-advantage.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::29) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c2756fb-9fa2-47f0-1513-08da84ccdd42
X-MS-TrafficTypeDiagnostic: BYAPR10MB2984:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mH9jKUcsA74MdyqaWmTrI4QlEpD/cEMbeBzbkE7+ToOkaWHBMMMYYNzIT6rToA2UkZ5qo3+ebotk70cteApHNwpghJiaTJODIJQ4vM1pOhdH5xSkYy+gyJ3XEWQAf1BG8WLz9pET05v32R99KlXSTORdv+/75ZgYl+Aii8aUAhsKyZyQTcqrzEfuYTURK+5pzmZmpktOjuYAZKKeoWUkKJVMsSDAorux5lJH6Y1u1769wPgwmnFG56nRl8Vm2EgQ53TB/7NeMkOtFokUHgu2A6eAGNb/NSinXtNWeNRo1tiItNeZtrdRDjN+8o1B3KwuFizgKjBOZsqbBIirJKvbUR5oWEODZCb1phxDWeXwsLfDoMvL/TWpWg5GozUOxePtzaXuJCnkQjLfEzW5TQEdFx0w8ka7xovUGFpIAoeX8Di/6zZ9BCGOxRbChE0j1CYPyb2GBBVanc8Ev3R++8jCcSyNe7xD/18C3fQTQgkAm2a6W78ZtPBd1iEGKxGnJFjt3dTTu+K4vUmgeBB4OsOn59YyQK/9xxY8fXbTfgl91MH4rpevtE7odTTazotqmByURM0O26h616ruCc0FHees0oZbeJ2LO4mcyhcuiWVbS/T1IsR/BCWllHgXPf/ffGKQlm5xHPCgtBVew+RQklV6bI8KQeuvVS2Yjr+Fpt3iIGHDMszKCUhWkyGhpR7oSbwWT6kdM5Kdi+f71r+ySSo11gyv8Zi37/0dTcbyUU5PcZsuwUTE07yEctLwc0eVshlet/BZwIip5B5KsfdYYFlmt0lNsBy0VVhmJ5dzhlnU4Y4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(366004)(39830400003)(396003)(376002)(86362001)(1076003)(186003)(2616005)(38350700002)(38100700002)(83380400001)(44832011)(8936002)(7416002)(5660300002)(4326008)(66946007)(66556008)(8676002)(66476007)(2906002)(36756003)(41300700001)(478600001)(6486002)(966005)(6512007)(26005)(52116002)(6506007)(6666004)(316002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eMNMPvIjXDknovJB590NUSe6T4MJuF32K2AdD00v01IKtMBqrvSXlW5LgIQy?=
 =?us-ascii?Q?b9ceAADrxmbt7GcGt0mmmy/oK9fpO6CMcyChU5PB2lLnohykyOG/iWTZGOou?=
 =?us-ascii?Q?iCu0DZF02jWinZvpgtaLED/NBa2LmKcT5pZ+KaKNnJdvtardz7Z+OA6uV07z?=
 =?us-ascii?Q?k9N/BaidmpoFgCZwix5CWu1bbDF0L/DeFVmILId+mC/s6/NOJVaTz3Orqc+b?=
 =?us-ascii?Q?m3iBqjTwbjPPaQHzeoQTQYGT44DeCJLdxGQRurqINHon0s7q2JmLzircmrWr?=
 =?us-ascii?Q?B1sBcSXG9BDRFwC1LOW5v9l8W+97AW2Wu78MgC0ODko8/F3OG2HJXags95tm?=
 =?us-ascii?Q?L1MbPslGIDTeDx6oRDVhqn+F1nsw/Il8o96MCwb9zPp6J2njuVkfdQPqCkRh?=
 =?us-ascii?Q?+QiXjaHVV5iNGfrRAsrXw4OC2oDOfpfBGSGcsAV7lUZ6L2c3iXtKQjPbyWez?=
 =?us-ascii?Q?FuVbWE6n1i1XuJf7yvYnVaFd/4nHZGBlrcl2Z/wbjUf3Eg7A5dQmF4miZ/9C?=
 =?us-ascii?Q?LEB7YIjNP1pYrv63Olc1S2N3T5l5x2K0w4U4WVFJmeL3dN87qhjdtjYuZoYZ?=
 =?us-ascii?Q?BoLNLh60oLg7wivp8SQSPvgrQyYMANBir8fjrRr9ob5/n8x7J+aujuNFzmct?=
 =?us-ascii?Q?ivoLmpCnnmcQEE3jn9eXpiAJscFyks5Up75VPO/ktSdqgpwlli/8cfcKFMSM?=
 =?us-ascii?Q?/7FHXmNaSr/7WAvgqOD1wLHLrwyT9Zk7PckUpkUPolH289VfjnAUT3SOq9ih?=
 =?us-ascii?Q?y/XtTshao5GCJloRTeeAvEasne5NwD3gQV+PDa0rt2BxDHATekWx4etfqyIw?=
 =?us-ascii?Q?/2is+yKizISkfGIFRRxcWVn9uL00ZeioDierxQawjAW5LKmZfzJimHjs+m41?=
 =?us-ascii?Q?zA10dgP+yLw45RswWN/ihmDUwLRdRjTmXobbu1mIPuhDaWeB5YvA0LytAsUE?=
 =?us-ascii?Q?aIw9OpSpqXUyKwmbPmmtIRz0imqaeVCcgb27V9lOU2PFf3pr+mNoLnto5TfW?=
 =?us-ascii?Q?53KNIXRiHBD2GsDZoBEcdO8er8JFW8EEzWrrSkK9Z7R271isZn0DuomZehDw?=
 =?us-ascii?Q?oHrxgCCexDYwiVIRjK5M56m7qbktEuLdz26B/+Gh2ifOaqDaRbR+jn1fsJi9?=
 =?us-ascii?Q?BPo4Hh3Ml7IyE0kCyfCTSIxtP/t3sH+KZrkD1GIv+SlMG2RMSm90KbeBSBXv?=
 =?us-ascii?Q?9QgYK6xGigmkBF+2CDfZkvY9XaMJ8RP+eYSsZipCazLYBdXdVGHVNUHSdrS0?=
 =?us-ascii?Q?yajrARHYy9vxxbRsVWE92/QFlG4lzUw7pWF/607WiCnXEifRQEFwQE7Ns7ei?=
 =?us-ascii?Q?YRJQIUXrXtSXFIGvc0+raHrMNOkmO1KUJx0YN9pcOuQMDwhY9R/AjaU9/8jw?=
 =?us-ascii?Q?t198aMIdmYhAgN1mJCV/6z44h+eAInxFn+rOsKxQkpdaua9Sm1egBsCWmD1m?=
 =?us-ascii?Q?wL87S1491H/RGpYUSk/KOgcKAJhsoBkD3ei8+jRkob42yVLkLfJwgNaPggTS?=
 =?us-ascii?Q?t2owjchKSsbr4pqO0coAmDO1nrgMFtFF3ljVyhcywAsqDmNUQKTbMgIPJouV?=
 =?us-ascii?Q?tiQAXtefdErzRmcKODGHcpNu9pb6KWUX0056Yc+4H53dZSNVcdi5Hyr8HmEh?=
 =?us-ascii?Q?+5RJODpmJZqftS810QrZlKc=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2756fb-9fa2-47f0-1513-08da84ccdd42
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 06:01:04.8199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DiId1xQFVb+g11e+p23dPe1UHvr2xj+IJGczXOmYYIqItwe7lWP5jkxiVeko0FiErdwLvTKtEufAcmUlQRaWvbb8c6xeHNAFC4BtWzidZqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2984
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the phy-ocelot-serdes device tree binding to the new YAML format.

Additionally, add the file to MAINTAINERS since the original file didn't
exist.

Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
---
 .../bindings/phy/phy-ocelot-serdes.txt        | 43 -------------
 .../bindings/phy/phy-ocelot-serdes.yaml       | 61 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 3 files changed, 62 insertions(+), 43 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-ocelot-serdes.yaml

diff --git a/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt b/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt
deleted file mode 100644
index 332219860187..000000000000
--- a/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-Microsemi Ocelot SerDes muxing driver
--------------------------------------
-
-On Microsemi Ocelot, there is a handful of registers in HSIO address
-space for setting up the SerDes to switch port muxing.
-
-A SerDes X can be "muxed" to work with switch port Y or Z for example.
-One specific SerDes can also be used as a PCIe interface.
-
-Hence, a SerDes represents an interface, be it an Ethernet or a PCIe one.
-
-There are two kinds of SerDes: SERDES1G supports 10/100Mbps in
-half/full-duplex and 1000Mbps in full-duplex mode while SERDES6G supports
-10/100Mbps in half/full-duplex and 1000/2500Mbps in full-duplex mode.
-
-Also, SERDES6G number (aka "macro") 0 is the only interface supporting
-QSGMII.
-
-This is a child of the HSIO syscon ("mscc,ocelot-hsio", see
-Documentation/devicetree/bindings/mips/mscc.txt) on the Microsemi Ocelot.
-
-Required properties:
-
-- compatible: should be "mscc,vsc7514-serdes"
-- #phy-cells : from the generic phy bindings, must be 2.
-	       The first number defines the input port to use for a given
-	       SerDes macro. The second defines the macro to use. They are
-	       defined in dt-bindings/phy/phy-ocelot-serdes.h
-
-Example:
-
-	serdes: serdes {
-		compatible = "mscc,vsc7514-serdes";
-		#phy-cells = <2>;
-	};
-
-	ethernet {
-		port1 {
-			phy-handle = <&phy_foo>;
-			/* Link SERDES1G_5 to port1 */
-			phys = <&serdes 1 SERDES1G_5>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.yaml b/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.yaml
new file mode 100644
index 000000000000..0666974d886a
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/phy-ocelot-serdes.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microsemi Ocelot SerDes muxing driver
+
+maintainers:
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
+  - UNGLinuxDriver@microchip.com
+
+description: |
+  On Microsemi Ocelot, there is a handful of registers in HSIO address
+  space for setting up the SerDes to switch port muxing.
+
+  A SerDes X can be "muxed" to work with switch port Y or Z for example.
+  One specific SerDes can also be used as a PCIe interface.
+
+  Hence, a SerDes represents an interface, be it an Ethernet or a PCIe one.
+
+  There are two kinds of SerDes: SERDES1G supports 10/100Mbps in
+  half/full-duplex and 1000Mbps in full-duplex mode while SERDES6G supports
+  10/100Mbps in half/full-duplex and 1000/2500Mbps in full-duplex mode.
+
+  Also, SERDES6G number (aka "macro") 0 is the only interface supporting
+  QSGMII.
+
+  This is a child of the HSIO syscon ("mscc,ocelot-hsio", see
+  Documentation/devicetree/bindings/mips/mscc.txt) on the Microsemi Ocelot.
+
+properties:
+  compatible:
+    enum:
+      - mscc,vsc7514-serdes
+  "#phy-cells":
+    const: 2
+    description: |
+      from the generic phy bindings, must be 2. The first number
+      defines the input port to use for a given SerDes macro. The
+      second defines the macro to use. They are defined in
+      dt-bindings/phy/phy-ocelot-serdes.h
+
+required:
+  - compatible
+  - "#phy-cells"
+
+examlpes:
+  - |
+    serdes: serdes {
+      compatible = "mscc,vsc7514-serdes";
+      #phy-cells = <2>;
+    };
+
+    ethernet {
+      port1 {
+        phy-handle = <&phy_foo>;
+        /* Link SERDES1G_5 to port1 */
+        phys = <&serdes 1 SERDES1G_5>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 714fd8b45e5a..10dd3c6ad6ad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13481,6 +13481,7 @@ M:	UNGLinuxDriver@microchip.com
 L:	linux-mips@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/mips/mscc.txt
+F:	Documentation/devicetree/bindings/phy/phy-ocelot-serdes.yaml
 F:	Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml
 F:	Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
 F:	arch/mips/boot/dts/mscc/
-- 
2.25.1

