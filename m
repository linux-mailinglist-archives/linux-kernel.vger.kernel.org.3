Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA9854397C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343704AbiFHQuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245714AbiFHQtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:49:55 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50053.outbound.protection.outlook.com [40.107.5.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC17AF33D;
        Wed,  8 Jun 2022 09:49:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJ7kE353gO4DV2yK8nMX92dF14uhMVV8D1k9MacsEKZYtO/JiUSlNyK/2bvBDj3IOhsvT8jRZQWk6HpnfEv1tIPMMEvkDWRok1kL1BJWkV/bs925HnfPMck1vggymQMH5NQY21yrz7c8m2v6kAZ+KDSxPOfdMPQWn3rgtuns52CPVSZuwMmGfuOFMB7nXIHQmwr3+2pyQgXWTz8uCh67319x3RjeKDWipzlusPADm3pWZ+IPU2k61ULH3r8yHEbIdv5t0ey1ipTH1+QGK25P2n9jazJcZhvqvQGnsmUIemiyNn1qKoN1hqR+bgaDa71ad38DMTE2bpGz3FVXnA5wmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRj+jCxisfvEYIycrLclJZbKmOaDEVKO/jcM11WJs3I=;
 b=BcUpiQR3YHK9rgSj6XygTazki10+4hnTlGuVBnjgsshoyOx7iSFAlJRHDluIapQ6ZE/R95M5CTpZOR9yYr/O4Wd+S4B5jMkhv986YXjubQhibUctnAcZlWuOZn133DMdxkTXkYdVB9Y3Hq9Du0J+DZas+8pFeyW01dWwIutoDXmgn7yBMQENuBh7bmAl0TxNpjRxVmH9565NP+GqrNEML7RNXD1mnWn6UEp1RClDYNze+Xpw/oa1HRl3rstyxFO+Q27+1xWCN3yXWhtAuOJwVDl/voiVtJJDFIzeaoT11k2EZ6MHLUkgYyi2tuLYZJDuSB9LyuNjpEO2G8mEC4KdDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRj+jCxisfvEYIycrLclJZbKmOaDEVKO/jcM11WJs3I=;
 b=IxDKccT4n+4mRn1ax6nhHkA6PjRfywzTiCyYWC86XpCVR6QUcDiPGypg9uagDdK5JFradjWe1N97JijDi0aDjO36Yz1tVv7Tcvm6qLEmn6d0p9mFu2xhWAbZRn7DOQi2M71jMt1/DdvvRw0OwigqVF+GORUlaxwdAep3Afpy3v8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by DBAPR04MB7431.eurprd04.prod.outlook.com (2603:10a6:10:1a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Wed, 8 Jun
 2022 16:49:51 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1%5]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 16:49:51 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH v2 05/10] dt-bindings: nvmem: Add fsl,scu-ocotp yaml file
Date:   Wed,  8 Jun 2022 19:49:23 +0300
Message-Id: <20220608164928.2706697-6-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220608164928.2706697-1-abel.vesa@nxp.com>
References: <20220608164928.2706697-1-abel.vesa@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0701CA0052.eurprd07.prod.outlook.com
 (2603:10a6:203:2::14) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c780c2e4-411d-46dc-d377-08da496ee7f7
X-MS-TrafficTypeDiagnostic: DBAPR04MB7431:EE_
X-Microsoft-Antispam-PRVS: <DBAPR04MB743160D988E0E264113F8011F6A49@DBAPR04MB7431.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rkf0OGs3ugwq8mNs2cKBxDwNt5RcjehuMdbHjqsOoAqNiNMCCtm8p7v1+84iXYIOwnXSG9A8QHaKpz+Ml3HiR+RAoXK0Sar/wrGc+rGE30KEj1ra1YSpn6omj4WLfeHMO4tBry5CR+VI9C1pdNrdOgqbYrwtRf1DdKw1R2yd695DgexxeiXm7t0IAxSEMZGoAcHh0xWAFvMVOnz1X1a8NI6ptmGzttm9/AGbiI0IV1SeasAEAx0J8H5AM2nQpdnH9L4M9QJnxju6yPA/FMH/R0dCXi3I0cNucnWR9o3IoBuPCzh/GifJYO8t0M28vdZKp7GfQzzyqfNiClexxowaoM80FWTaT3m0SBzyih1Y2vrHcpmC2KapiKFXe5vf9ZRlCnnlG1G1fvyfQSXqYdxf37dSvCIQfa20Y7RDkNpYCT73xRKbMFR7FnnNWv+M9z9q7OZDCuuObjmIWrMLC2cUzeLOgoAGYWJjE+H+7np/LyzOnrOv1R0Dq0fg7D8JH6sRLbQzdKLrVigboT9FIb7lbsy4cQfazUUho/aSkkMPjvDYME4i12/HudiK+UG57vReNwib0+R6/OYH1PTlwNsyuhN7JwnIxvaGjCH9rd7utwFAYTWUT6iyyag6nnIvUH1wayfaH8UwChi8Z/IRMwuGV0ICFt+d3fgnKd5igKE63wc/vkLTneD+zqaEvvBzQxifaus1H8Xq959dI/F3aJI0HrBKeBOG6G/lSh5yoDjqKmkkt9Zo08ZevrxFP4kTFSBZ7zGyLskLY5uesDbs5qF8j/SmPP1/jy0P8Gt+IaqjjjIy28vr7xm46i2RuOYT87KBhGR6FimTt+1gg3NgZMu3tg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(6506007)(83380400001)(66556008)(52116002)(38350700002)(44832011)(4326008)(110136005)(1076003)(508600001)(8676002)(86362001)(6486002)(966005)(186003)(2616005)(6666004)(66476007)(38100700002)(2906002)(8936002)(7416002)(54906003)(26005)(921005)(6512007)(316002)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HZVI3kPpxB/QVo+NRYYnAYliG9Ro1CjG/IzgawuK76oeKRl9fEULZvYUZQEF?=
 =?us-ascii?Q?ueA+KHPuFb4XMKmG/R//zhBrc9mGyzVLrwRgmyHkmfv5d5lJUG58URWcO4/b?=
 =?us-ascii?Q?IugZ7NL2Y71LIlhvG51mnUAsWM3hnWAthsqo+/btcVp22Se8ELODusVuXpHT?=
 =?us-ascii?Q?9PTMRudrauAyBjDyexzwGzDy48JTyf4NHnkgVkwouOOZm8l7zZgj2eXAVaH+?=
 =?us-ascii?Q?wHFeC7UuTOscY3wtJVkrUPtP0YkW0zIL7KreosHecBW/x1idhi6z0TZUMnXX?=
 =?us-ascii?Q?5nat5ceBKUgVoM+7Fdq+xTYCtXpXm0tI+xyAkqpzbK1FPC/sFjgme/nMJ4eS?=
 =?us-ascii?Q?MGwRb5Ng/WVxYmiwH326BfjG9FF0HcF0reM0B2j34ho7gUGU38CTQpqfHIo8?=
 =?us-ascii?Q?brn9YUDkB0bOy0KoqW6lgpQzeiFbo3gKkAOP1QQgNXEk/sIwWYwM4Wk8HhVw?=
 =?us-ascii?Q?+a2pXvEXiac3NHakKKnEx+yxMyDSx/A7oV1Yv8JzSWnBz0oZ3FkmkBYgAtmI?=
 =?us-ascii?Q?lmLRcqH+0CZ10vJICQnsD8FLplLQUvfVCAfd6HoTP/g+mr7Imt918au2dCpZ?=
 =?us-ascii?Q?jAqxOKDAcx8H2XGa4ezlFS6Huz2VdgoRd7p0oevKnxoxiNzoizZd7i9ekeUH?=
 =?us-ascii?Q?u39kZ/nT/Kmd3wkdTpk7BIRurlnVDDNssMwTmOQ69Lo9dRIWv0qBAPxyIaPK?=
 =?us-ascii?Q?c/TaHNasHpHq1fLOf29zh+rl4LmtB9ffDc3j8oumv3lToAh04AyYq1Mqlg4q?=
 =?us-ascii?Q?ZANdqcmmB8nAx3jsOXX+BFoTq8pIcHSoGP4ksrGLDGNIL9JRRLBRocH5XfSi?=
 =?us-ascii?Q?O4yoWQbwiAOcYB4DRna4Zl0CnwMdq/LkhECS82BaG6VUXQGv2syyjxVIlcmJ?=
 =?us-ascii?Q?DZeHOvWygfvbfWsj2GWFeezyEAyNHrw3+u4kqX6MouMPjdw9WEAkmq2gvg81?=
 =?us-ascii?Q?vxl+k7mOqQfcihq3KpYOu4Cn4msoM9+ATMKyUgdb+Uge5vfVSRhK/DrHr99g?=
 =?us-ascii?Q?sh1e9ir5WuzB8CD5fcCeDXQvgciH6pQ/e74dF4LDcTktFeBmwsYbcZt/SR3b?=
 =?us-ascii?Q?mMmMAbnj2sl5MgUoe/0OokVTx7AbS3G62Q9O29R4t8pCSD2GgOJmwvji9KCE?=
 =?us-ascii?Q?xqbo5hDUjop2BkXbYuxYDdS0TAFkWrsAsF7rcPdSOI0Cx/px4Wtx0VEbeAFg?=
 =?us-ascii?Q?Wm6WzAPFVrlEwM0H2NIKOAsyhFHG3C/H1Ma+9HF37eKm7xC6gStmN1RzuohK?=
 =?us-ascii?Q?2R2CpKxpYcvuAHksNo/opcQY+PSnlhJroOxXb7Vjp3oVHm/39HhGqdnJbXhi?=
 =?us-ascii?Q?GPpuLyyTOjmzBuRhBu4zp+wnWvnTHmXjqLEB+Tw+3vJPkmuF9QnUjXBOjXQW?=
 =?us-ascii?Q?i93C4fw5tu5pLDusejmjgwtIbF6XlTyDzDXiw4uMAyVZZFSIaFM994M+1xkL?=
 =?us-ascii?Q?kmQlfvrDSEYOvrYi9XSDdpGPLEkoigwtgdq63ctEdoejYraaEMlrj9PgZdhA?=
 =?us-ascii?Q?cts1x6wLfLieqginIuU/4lLNtkNOw20HGD1M3ecPxfht0KCrNoI86RYn45Cn?=
 =?us-ascii?Q?m2uvJ1WFSszC/GsbVGQwkFuYa2b2lbrd5vT08/TGTakllD1pw+8hw23Sxpf6?=
 =?us-ascii?Q?/ybGXUhXmrvx5NZnmM/suaoICDxV2H+LOmSGy9JnoJsirAaOteIntxFeIK1Q?=
 =?us-ascii?Q?ZBPFB2MCtOMT7ElvtD7DaQvA02/BNpmVMlwbDdkhI9LNbEDfmx9JDhqcge1H?=
 =?us-ascii?Q?O4hkInC0YA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c780c2e4-411d-46dc-d377-08da496ee7f7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 16:49:51.5229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lGFsA5mW46LF9fTi7artRh6TAX6UgdWzbS+RznHOWppZGuzK/Im/w2CripwNGpYZp8MCHJRvx1fp1jzrTcxHpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7431
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to replace the fsl,scu txt file from bindings/arm/freescale,
we need to split it between the right subsystems. This patch documents
separately the 'ocotp' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 .../bindings/nvmem/fsl,scu-ocotp.yaml         | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/fsl,scu-ocotp.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/fsl,scu-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,scu-ocotp.yaml
new file mode 100644
index 000000000000..28d9152f4aee
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/fsl,scu-ocotp.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/fsl,scu-ocotp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - OCOTP bindings based on SCU Message Protocol
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+  Detailed bindings are described in bindings/nvmem/nvmem.txt
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8qm-scu-ocotp
+      - fsl,imx8qxp-scu-ocotp
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+patternProperties:
+  "^mac@[0-9a-f]*$":
+    type: object
+
+required:
+  - compatible
+  - '#address-cells'
+  - '#size-cells'
+
+additionalProperties: false
-- 
2.34.3

