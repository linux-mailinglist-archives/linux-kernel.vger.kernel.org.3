Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26E556063F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiF2Qpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiF2Qpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:45:36 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F73739BAB;
        Wed, 29 Jun 2022 09:45:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etgZXA3nkbH8+e78lZ2ef/mCfFX3s3V8y81jJIbYOmXvHVJ9bIeJV3gbU5ue1Y1zTUsGvteroXIRYKDqj/8qnu+F41Pg5HOrd9wIDW4/bQ512Mn9E3e8iSqefmO8RhsLLowUSXqK0J257G31aTbqqnYICXRZhdTsYVCOQ4PzrP12RV0VjE3uJFcJKV77necexPWmN6te2F/crQ9WTCUOU0sVN9V9CqlaaiiT1zbcdkmpgQBaPc0v4ue5d+FO3X8SgNOBW/HmrpqNroHtQqpWtu0yLWFmqQ7EEmvu6PJeQkhic3y5c3qsc1Vi7YLAYoUVJOsoyCl/3TBF7mdJhdfsDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wqX8CXxDbQIfMGxmN20AkxCU2FInyDVSXQZzraW6Po=;
 b=L25sEryIW2PNreaYwyqFUunFg7AFHWcNwPEMqy8zaiohxn/SHv/kXEKyuDbBD0d3BVVI4W6XgkwhWMIwRGCviT4FXV4I2MS44Fi86Ar1V2Ash531LJhYmtEZmwL+Mp11N4GW+SEEjSZZNmwd4EHB9ClG5G+IvsbMszAV2Q114lTekZy/e1o5+Iq1pk2CVHU+3MtzVdhFek7oodQtW5JOa/L6HWC+Kinr6mqwxTZ6mC/RYWYB2KrbFtjb/damDwEflNGIyxCqy7c90bXV7N+CoQt9nQACjA9iKe/T1CCYZyKt6vgFxA9Bt3MjELvfFEdXRl0bcnKxpTdNzUloGCxIjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wqX8CXxDbQIfMGxmN20AkxCU2FInyDVSXQZzraW6Po=;
 b=Vi21iSAvQCmsAccSPLjcreupapdnv2qeAjjDyhFAMqYKFdCepZL3TdZpjU9NVABv+1dK0VXlcVFN/MF0Wgk1S3O7cGk+hvhBsTfj597KFYuCUgXJtDAq2of8lWOl4zroO20l5888FhdGyM32rlftOJeeCTJylti/ZWPXfAE+2qQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by VI1PR04MB5840.eurprd04.prod.outlook.com (2603:10a6:803:e1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 16:45:14 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 16:45:14 +0000
From:   "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
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
        Liu Ying <victor.liu@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Ming Qian <ming.qian@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 06/14] dt-bindings: rtc: Add fsl,scu-rtc yaml file
Date:   Wed, 29 Jun 2022 19:44:06 +0300
Message-Id: <20220629164414.301813-7-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629164414.301813-1-viorel.suman@oss.nxp.com>
References: <20220629164414.301813-1-viorel.suman@oss.nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P195CA0028.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::33) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19fce6fb-0e5a-41b7-73d4-08da59eebd85
X-MS-TrafficTypeDiagnostic: VI1PR04MB5840:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mDQJAFOg/xf/wDoxybf7tdAYU8c4Xdk4/xTQpt8qUuRLWIpDkHkKqhlTMqAvU5Zp2yu0ctyBgcsXLGb94R+SenOxvkfBhuhcmPZOF0t8F8R+AWWzU5Q98lKsAmuZY2chiunpjO/TwvD0WDBrLJZZnMy2Jb3QYTfXLOoebiHJnqokLHHSdaX3Gv6xrTMSSdWYO114OJKGNoBEUxHiQCRbwhlHOQ8aq/y3x3yCI8/mxmsgC+E2fhHWmaHtyQwh03qdhrqXH/3xSKpS10VYYVRrRrXZQs6u9dsF6ItSycEdaH7h1XH+E37K3tLRnmOlroVDFtfPwFlGtJtjQxeHWssKscBkZ/IFKyNJbURIKCAB1mZ/viS4lNFUOusG5RdxgLVjjnFn2yu6RaYXp89fO4lpolLfXPc4RsOvJ0+Mk2Bpa22efnhhXu1VYbbkinaGAQWFYRHkDH8z61f+2y3i+pCfOU6dHL2ZDqJT1kgb5b7TePPyAaftDVYN5k3IGp40okv6GvdNqUqCA5RIDanBjfKQiafsyehTvKruhlBz0NTG+FziEcFJ/Ghnx2Ca0OHakTRXM2O0Foehr0UdfQIg/wlg3uEPqVQogM/G0SXoUBavbKxxeWhdtsl9RO8G7RToNpg0wcTmqSk0NkRXA16xCOVCp/AsBvuh69CePYFhkes55UExCRI8mo6ehG9mammCzeVVG2GK+P73akugfQwIELSp+SFOxaPEGDpxHJKbwp8e2JgzfVOUtToza73twziwO9vnadmwizFdQlFFN6XnwQQREO+Mv8DmPEaOhOOxpAAplxPpPbMj/okzPhPssyfJPLJqk+7BVUdxlMaSWrszCWSVwdic6VFAuV+esRN+6OarslJns5fI1VoFf8kyfg77nQ48
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(66946007)(6506007)(26005)(316002)(6512007)(66476007)(5660300002)(66556008)(6486002)(8676002)(8936002)(52116002)(921005)(38350700002)(41300700001)(186003)(2616005)(7416002)(478600001)(86362001)(110136005)(6666004)(83380400001)(966005)(1076003)(38100700002)(7406005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?SBCHY+BgyqVAmCLN6YCs/MILorUDxbHREHM3kzhmwywlbVzIMQ4Av5GD9y?=
 =?iso-8859-1?Q?fJ3hE25lG81/L6m4SwgIcYD5JM6WdXtdtXoCOzrP48oMADN6P3qCM5wQpS?=
 =?iso-8859-1?Q?4zC2rc+7PdoP7RrWjczZ6BoVtkpiLQXBzDozeto+gNveX+qLAcMsbf8JLP?=
 =?iso-8859-1?Q?Qcq8Gc83DjvPC4XpMJwQ83Meh+/CvOGzrJ1A33jpmWbdSCJVo6jZeSPMf7?=
 =?iso-8859-1?Q?WRaTLFBnTetIWcEOdVqhs1TajT/87kbpmcL+F8P7vXXhP+1ErCVGwdbHCY?=
 =?iso-8859-1?Q?wvC7udp50kTTQ1kuA6LjZ+PEVxi5A8gDicIEwHsoWC/iOAWDgprR/9XaWE?=
 =?iso-8859-1?Q?IEoUdrpbvYUJkewXpizhe7PBGnDYuCNobtg0/EfzYtNGB22fDp4JFO/qWJ?=
 =?iso-8859-1?Q?IjruvBKl6vzct3/2u/sRPLXirBi0kG3wZLJ80TputB8efMHQ7MvuAUAv7z?=
 =?iso-8859-1?Q?ABVQsH6oOJmwXrLA3piJ/tcklOnGW52zJsModYqbYKUA1sisuAd3fJrH4/?=
 =?iso-8859-1?Q?ljQAvey0ayGZ8vdCezAxEZkz1TRGlzrxWD+j55i2rXmqS1k312d4eY0VQi?=
 =?iso-8859-1?Q?3I3LSvGAPjMstgJrfl9V1CPw2tbe0Gxia1+bSwgplxjE8hley4SA3MvNWM?=
 =?iso-8859-1?Q?tjQxZUMj3BShBb48WdikPPTNWJm+7AAt84CdIdc+Jk2BynTvY0WSun8pUA?=
 =?iso-8859-1?Q?nrIbR4wHAQAJA6d9Aq7QYTMSTUGgoTO+b/V45M0FvVHWM1kdp/BK77OBL7?=
 =?iso-8859-1?Q?ajjJJ8YJsUSFq7jVAwk0xLFg6yv7t9067joQFLyH65RertzNfDVtydcbp5?=
 =?iso-8859-1?Q?PrLSTfNzWrEAWdLIZ71i/Q2eFhavdIt2+P75ulQl89QodfVaTRYY4+hgb5?=
 =?iso-8859-1?Q?1fqOhp73aLULyzGJHr0RYOXahmBqYF/s++bvLBVUInlMT2yfCjprATlGlt?=
 =?iso-8859-1?Q?YHsmioMnfffdI9jpTvllGcMGnvkYSAnSDbgBU5L08nNrebglUBd00r2Vv+?=
 =?iso-8859-1?Q?3/Ep68TYZ7Tx+2tu5L7mJV15QqmSZxkCZCStA6aAe2/uqiDFeit8gdT9uA?=
 =?iso-8859-1?Q?5mHSJGmBDsDdJdaV5ROzCqceSKkdhu1LSDFHjDsmY1hk031s79B9EMmyCu?=
 =?iso-8859-1?Q?EJvOtO6sqcedpZmhohqUe9Hvr1QBRo+9B8tkEV9yXV5t0g71jer7DjzXU2?=
 =?iso-8859-1?Q?29p2Na6cZchvW+VwoBeB4PHs74L4WQD6dA0wS3Wj65kun6s0NO06QyHrGc?=
 =?iso-8859-1?Q?tSXc224t0MY3yb8YXCOKsRecP7SfLkW6q3NAMCD2PMaYW0XocMh+NTzX1U?=
 =?iso-8859-1?Q?ZHs7S5szWMV9GX7dPwKBFfO9zz8TcS18ewrCQqZo2FCoDoXzFB8JtZR3pB?=
 =?iso-8859-1?Q?GN72Q1Uip1UKSez5JuArVOAaVqEqx44adQzczRBSIC6a+HTMp09Rl7mdmL?=
 =?iso-8859-1?Q?i2Q2IQMmlsz1GYdDAne5B+XpalP88R4GYsUC6rT9OGKh2esqr+xSfpj+KT?=
 =?iso-8859-1?Q?ADEO3OZE/Z9tsSN0n4grBLbz2YHFWA2pQjMFyVb3WEvU3O7tssCneG+Ghx?=
 =?iso-8859-1?Q?0/+E/rLg2y0KGglhupacz/jcEk29dSsYXjWewqijtrkVLvgg53MEZlYKUK?=
 =?iso-8859-1?Q?nPdMZ+M5PsBZc//0CMDvgH4bEMtlzj+dbo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19fce6fb-0e5a-41b7-73d4-08da59eebd85
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 16:45:14.4324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XUjU/sBCd75M7LfbD9VkYi2JIr1nRJ2SGPVnnNt6k9Zf4RNiW0AaV5dfE84v6hYhZ5MjOvQ5UPbsZ5lPNOzoTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5840
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Vesa <abel.vesa@nxp.com>

In order to replace the fsl,scu txt file from bindings/arm/freescale,
we need to split it between the right subsystems. This patch documents
separately the 'rtc' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 .../devicetree/bindings/rtc/fsl,scu-rtc.yaml  | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml

diff --git a/Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml b/Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml
new file mode 100644
index 000000000000..940588e278fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/fsl,scu-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - RTC bindings based on SCU Message Protocol
+
+maintainers:
+  - Dong Aisheng <aisheng.dong@nxp.com>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+
+allOf:
+  - $ref: "rtc.yaml#"
+
+properties:
+  compatible:
+    const: fsl,imx8qxp-sc-rtc
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    rtc {
+        compatible = "fsl,imx8qxp-sc-rtc";
+    };
-- 
2.25.1

