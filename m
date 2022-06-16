Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687D754E7BF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378131AbiFPQpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377742AbiFPQoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:44:16 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30054.outbound.protection.outlook.com [40.107.3.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465902A720;
        Thu, 16 Jun 2022 09:44:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAbKgtPO9KFtjeMzY4pHBrn7VJ3o++n7qBMDf7JQTIRcgRocov1XoSrscQE6k/OVRyi6R4wNezTEIgOWVfmEgPl8VOtLSFnAKNZxUO0DZGQsWGAf2a3bOfIb4ja0ooRy/miJSR3yX7nsFJ18beX49XWBLKC28m+CBqq2ba0/D1Snnt3NdVjVxquKsnLLIWyP5oLwXtVnmnQk6hZrfyWEW8ZSE41w+aapqag5bEQmy4grdh2zYfpffM4wPimOa2K4/bvnk1By7HV8WfdFlzK30KUqI5kJDnSJBl/s2ChtfAmgZ4aJpRbQVPEBdiNgEPTR5M7ypIKa1yLMLQqhSQyqOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8LE+x3TttH7qT+Takh6K2M/5SNH7ZTo25mc68bUfwU=;
 b=MQxxnSB2qCvqDPeNuvuZ0xwy9wBk49d2HGJ5t+xBzl+X6ENfacKBCQcMaSGCp/3hr9E30uY/lY3DqPqFOmY1xZ+BxdJicWPot+Oh3REY/u4AEQtuhVohhFcXY3xStPw84fbsX/fUCI37efGwP8vXXnqEil7CtNfEGRihSlNeBe8yA5cH/8JyLKTiEPVDSa3NM/23j7ckvxHWfEjHGshADToldkZGOpqZbsF4XPvH1w+G0pun28IzZW2aLCyqbSQMCb0vqubgp48hlWDmdDTaYIqjNRachjaVQYxglBjyp5M/uNIovWXeNc6mwA+LPZuxNu3tD64cRI0YiOdfCtxAVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8LE+x3TttH7qT+Takh6K2M/5SNH7ZTo25mc68bUfwU=;
 b=POeasC3EBUXSf4ursWPWLXculBHDi/L58twa5tQQghQ638Q4fx3Dww5IRUdf2NBg7FLrv1pWJz2bLm3KkmK+OBIcWMY/SaXFtaDoLOHe7T4FeZuOuvr3VCt/UtHvbJuCSbwztmn/ekR5KSkmxoTrWJf55Y+JllqX796scoXS4bg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by HE1PR0401MB2649.eurprd04.prod.outlook.com (2603:10a6:3:85::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Thu, 16 Jun
 2022 16:44:11 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619%5]) with mapi id 15.20.5353.015; Thu, 16 Jun 2022
 16:44:11 +0000
From:   Viorel Suman <viorel.suman@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Liu Ying <victor.liu@nxp.com>,
        Ming Qian <ming.qian@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v5 09/14] dt-bindings: watchdog: Add fsl,scu-wdt yaml file
Date:   Thu, 16 Jun 2022 19:42:58 +0300
Message-Id: <20220616164303.790379-10-viorel.suman@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220616164303.790379-1-viorel.suman@nxp.com>
References: <20220616164303.790379-1-viorel.suman@nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0029.eurprd04.prod.outlook.com
 (2603:10a6:208:122::42) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 809084f6-39a0-4daf-1db3-08da4fb77079
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2649:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <HE1PR0401MB26495A0F08CCD11F64BACAE392AC9@HE1PR0401MB2649.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jGIid24nIMqp3aBRIs6JA21E2CNsNytbgrA0xZswTslFhKRH3j8K/PJnpS/lDHo+mXS43viW7PxTiiwromvNXn0FeiNWnYVU3O5sWRWN/PbbBylcavlihG6CC6KJpfsgFrkgjBS6zUzHhJNLG/dDDRDkSY06+Aj3yhbtzZaTV9U/hv+h8sGDb8fLTUlTPfCwbFAuoCu1nT/hEuMJGQvoRPa/9EGyeCeXDqJGywXCZZAnYS01nC58tojc5lYugt+DYz5zSY29vliTeccVVBMTNNE8tXGKaGZrBIVWuptVraYQo5dSX10cQOsMqeFcOJsWp907zyTecz5OMPN27BZG+lrT2M/sj5p4pXqMXdb0Qg7J+uuX0f5ir0D+1OF6VB05L/46kAc9MvvHWbKzd+nsexLs089Cr1WoRf9bnIo+PURcR12J8EQdL1+CNntpXk4wYKORSQFolvCGxXpQOhUfDJaS/qj7rw7f/ULvz8oRRqXVrxCLApc/umMOI/LaYzRFH8jgt6fCZ7L0I/SKdPkcgAWTjBr0qTPHGvKl+/eWRZX/Vzgkyg/m3WlBCinPRE9LSRxMWatkKUnwMHU6ploUliQ/mpnn4OAHMj6awRwwNo7I/lklD1fOuSZIS0nbQiBF0BVgXPvt8GUK9dKPbyZoDtjWO6mUoPeA2qknD/kt23Otf+B9wOO/EqkHLPyvS8ECPXFewG8yCRmsflhPVsb19mkUZfXfPaJ6Hqc14n/cUOazR4ggeC3PKmc17CQN9OjSQSih3Km6xShNDGUu+KsblglM3b5SeN7NOKOKz1rh+oQjlKMYbYo3K5VpKE80vbA+cIeBXwzo9HZhSagRm7j+8vA1TafvjhMUALaxPEk1fIg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(1076003)(86362001)(186003)(38100700002)(6666004)(5660300002)(2616005)(26005)(7416002)(6512007)(66556008)(7406005)(2906002)(83380400001)(66946007)(38350700002)(316002)(110136005)(52116002)(6506007)(8676002)(508600001)(44832011)(4326008)(966005)(36756003)(6486002)(66476007)(8936002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?6JidFXwx/XVqAMyimcl9wtVcXkaiHr0VOkOWStqcte0W2D9w42NZxf+9yJ?=
 =?iso-8859-1?Q?HYqoTa9+cKE7SX0ttYF2MgW9uFhB8ZCgzVELCl7uVOyj+8nxux2Ymi6mEg?=
 =?iso-8859-1?Q?ry8zlFNmA7ewm8HZpxWqCrdwJGnJ/BoylJJ90E6KHQPsMZ14JkGtXZza3e?=
 =?iso-8859-1?Q?/Ip3Ba/1OTrjmyUq69xBsurqqziTt5F4GQjZQZnJQAQmezL5K05WDtksU6?=
 =?iso-8859-1?Q?hETRpw24qN+oic7vu+ec3vpky4Y04Gtis0MDdwTEtBSKyGcQfzVhTrVRrE?=
 =?iso-8859-1?Q?21i4/XAfv68gofjWdvCAcUSKH+evslqz5WxIOu3Sw7k3agEtneodcY7zmB?=
 =?iso-8859-1?Q?JmyIdhmFIGXpoxkAVcOmYUD3F3M+KIQZUgpg0PsD2aAyjj4l8wGsabgDSh?=
 =?iso-8859-1?Q?M978mWXyw+kJs/3sZejA+epdvOlskZgvWbrpUtgjUSzyIyJflpcVOdRhvn?=
 =?iso-8859-1?Q?r81FKhgjJ2NoPRRr7XQvL5qAEHP6UjTQ04qIELc6kWvWKLliZxL2cg53xf?=
 =?iso-8859-1?Q?hdIWCuv77nxKRUFJfGXu26mOjmcavPD+ZNc25dz1brykD4p2JzvPGBMzXX?=
 =?iso-8859-1?Q?VeNMGaoNWPudD+smOf95oqiEwmaxK1u0dZFkZ7Ph9fuYoeX5BlZz4eTyeU?=
 =?iso-8859-1?Q?3RTKU2HNuXccKWLPbEfq9G1wUVmf6SVHUDH9zkJo1Ar0uV7qedDgQnaSzD?=
 =?iso-8859-1?Q?iOn+5+bcYffwz7uLIu3ShHHfSy6ipYyK4smMCiLiLcJVRyGQ+39IZ1kg5R?=
 =?iso-8859-1?Q?medtfH7mpiyRrHkEqImi6citV9KAlj0V8EJ19iOXQTtmSAIPAjTOZZ5yMW?=
 =?iso-8859-1?Q?Pa3x6W1DCkuOdA2sbM8DDeZyMFedwZJBRjqU825iQM2lTSwxh3JdUjKBWl?=
 =?iso-8859-1?Q?0n8nNaqZzldkn29vas43+VSIXISVSbZ9rVBVpy6NRZy+D4FFzDz6iU7LPA?=
 =?iso-8859-1?Q?STA9bTx+3ZnZWlHTlIl9oXqS9cob+DJfPnXAiM1VEzIoI5yHoUi3araLoI?=
 =?iso-8859-1?Q?wpGuUb7oU2OOl3naHhCV9tSnaAndEsykzfgg2YJOjeKydfHOahivuw9Wl0?=
 =?iso-8859-1?Q?a6S9YrO27pAzDOWGItZvy+xTBRhmUEZn9Gz3BiwXCFQAhAxSj0tqAiHfGm?=
 =?iso-8859-1?Q?oF+y1myDw+ePCPv7sz8m1mm/i3oYjof549DOl61mWPfdfnSpUlD9uFwOKG?=
 =?iso-8859-1?Q?5gulv6lgqRNMWEluoP0voZk9n20/WfyvyrMWfGcGRBq+lJdREW3CNd1lJA?=
 =?iso-8859-1?Q?zYxbcg9B1ltGamF9nd1Cog6NVLpKi2D5ik7LJuX6gkd+2LuQQ5IkBkKmSZ?=
 =?iso-8859-1?Q?+O1Zo8JlC7RROFMxC3CXNQcsEWKvMTqIB9hKx+ohzWH7RRrlKC0NyWxCRo?=
 =?iso-8859-1?Q?nfYSv97+/KhQqJd1fxNy8XZSQLKnQQkoFDTFVg3iIua/j2BCo5Z0C28+Wm?=
 =?iso-8859-1?Q?80nR8+nP1+m8CLlLqYYG+DAvX1Y4BfD5ld2a/E1hKXEubp94ojKR4VSvBc?=
 =?iso-8859-1?Q?tEAqRPX1IWAksBY7z+ACl1Y6JxmgYQtXjcXTc9JVOKptxPGLE+K6IRidc0?=
 =?iso-8859-1?Q?9ArUPXdRg+Pedw2hMjkh+a7XTdKp5YHKtlvR/u+UEJu2/qCwU5SY5JgRkE?=
 =?iso-8859-1?Q?kZcQMU503VpWbTjVyyz3VAbRMw1+Qx8ldtPgZDzzHxBjFh0W64EBMRigGl?=
 =?iso-8859-1?Q?iBLlgsGF+EkhOCT8zG51FVvVuZvMQadvmpvfHNxAycRwoQuU16WgY0DTth?=
 =?iso-8859-1?Q?vAe7dTjFIv7OrDzmXx3NBeczGXUICGXP5k9c7vnHC9lhPJ5tnBR/m0JpLR?=
 =?iso-8859-1?Q?equKBfHWhA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 809084f6-39a0-4daf-1db3-08da4fb77079
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 16:44:11.5160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S3UQ63R0hlqo3okGavsx6DUnUxW533rGDxu3pb4Z3b6ERUkwL+DHc2+9DB9CNz5osDTKJm1CfPM+cKH5i1FpNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2649
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Vesa <abel.vesa@nxp.com>

In order to replace the fsl,scu txt file from bindings/arm/freescale,
we need to split it between the right subsystems. This patch documents
separately the 'watchdog' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 .../bindings/watchdog/fsl,scu-wdt.yaml        | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml b/Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml
new file mode 100644
index 000000000000..c5d3063a4130
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/fsl,scu-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - Watchdog bindings based on SCU Message Protocol
+
+maintainers:
+  - Dong Aisheng <aisheng.dong@nxp.com>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+
+allOf:
+  - $ref: /schemas/watchdog/watchdog.yaml
+properties:
+  compatible:
+    items:
+      - const: fsl,imx8qxp-sc-wdt
+      - const: fsl,imx-sc-wdt
+
+  timeout-sec: true
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    watchdog {
+             compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
+             timeout-sec = <60>;
+    };
-- 
2.25.1

