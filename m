Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A79544F86
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344220AbiFIOgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244901AbiFIOfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:35:23 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140079.outbound.protection.outlook.com [40.107.14.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B0D31F78C;
        Thu,  9 Jun 2022 07:35:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tg9gAhZ7qDTGba9A+7DCx9A3c7EtPXEl0ClZhG1eJUpFVE1rsnpccOVwB5GPoCYKgrLu8QBN7RvB/fvAQxM0u7DgTAEb+yOlXkWZRzqqHbAR0zWp+UbfEBWSAtg0k3n0mkORQyrJIHLUyD9oybKC6Hc/vxPONT9z7cVPOTu7/oS9fGBgLGzlMThuK6jbebuz2V7Ls+cq/D73oebCzAT3/okJQ7J7thhmaGG9TNQmNnUI65wTMSPo/0dcIECyep2xbzI6bIZYdjSEhemWUFTmQDZ97GEF+uVixMS1CZtI12S7r+FpgcFS9RaxviXpG5c/cQeFC5jFLatv2GqZBjovGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hco6TCJrMZkUFKp0ro7/epSlYhQqRvn8mJSQLxtfLPw=;
 b=CfcUD4a8oDXdDtY3vUQ9hB7ogHZpemGIaauGeLNg+BA+tqkNFgX1+uTd1ACJJyskEKtwCH/sXNxg70p+ztBn0rrRK2HUYv6SslQ9+pycEXoNsRVWVKCeejikuFyWr0WLzSq2b+Th/AMc2UbNuHudJeyvS6waxWJGkJATbRMfPGtB88iXjDID6JVKeZ8Q+SSXbZXM8XxlD/jdLDiB/xQPaCpVuEuCSm645K9X2i4ThM6rPIOxEpKsxO3uM7240eXoWryIW6pwzL8Ug+jxW04MfD0G6H3OlDnyGpI3W2e7/DeEU6WHX51nn9Vj5u19vAazYfbyAAIjm9ubvPPHc/8BRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hco6TCJrMZkUFKp0ro7/epSlYhQqRvn8mJSQLxtfLPw=;
 b=nVSZd6B6EKGVRxukG1i9ap7oeCASsyOgU5ge+I5RYbdkAAtCbmEz0qeemy3WkDku7Sk034Mo2tQpTJcfgJAsgqDMrLpw5qmfOUBNrtHI8pzXN08Qkvq70rVZHlg02FpkJmAZepAx0MriKnyHVTPU7jZ34LfCTWgYxclZOhe5pJI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB5885.eurprd04.prod.outlook.com (2603:10a6:803:e1::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Thu, 9 Jun
 2022 14:35:12 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1%5]) with mapi id 15.20.5332.013; Thu, 9 Jun 2022
 14:35:12 +0000
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
        Guenter Roeck <linux@roeck-us.net>,
        Stefan Agner <stefan@agner.ch>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH v3 03/10] dt-bindings: pinctrl: imx: Add fsl,scu-iomux yaml file
Date:   Thu,  9 Jun 2022 17:34:16 +0300
Message-Id: <20220609143423.2839186-4-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220609143423.2839186-1-abel.vesa@nxp.com>
References: <20220609143423.2839186-1-abel.vesa@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR07CA0042.eurprd07.prod.outlook.com
 (2603:10a6:20b:46b::29) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57c376c7-de0e-4586-d4ab-08da4a25377a
X-MS-TrafficTypeDiagnostic: VI1PR04MB5885:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB5885258D87709B20413F7C5CF6A79@VI1PR04MB5885.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x6jmtyw1O6VCTfUMth1VLgi5KZ18lTdoJixUUEtNEZT35t2T6MW5VloWn1UIiP4AakhQLVeeNUxJHjRKDqfULwK0KbQjnKMUz9BMXksL6x9Fsm9zRpIwa0f2qs/I09DvTOqYiSzd+1AtIPFlfwPnUghYVSNQ08QFqKdGoSDLa4JrNQcSbCpkHkZ3pAcTWfGkhGDhJq0cveM6KlNsZ6TbP6b7xz25TSIC3gJS7o/idi3+WdaZexSiy4JzWDEJLFSE4V/3Eh6QhRbr20AijTRsFvG8VFH2/g0Gcmll2EeHCgGvkv37exsDAHOHTw7pGDusaD5Pi/65VB312ByD9QRwCxODGrU1bcfEgRvB1+zCcYHtOv8OjyQbjZWD/XOWL8uLNen6bfbSX28lwZgzoQPkYxaFxgm7YTa/YK6uXxWt8NSAbWU6EOAs95Ivtj1hbYcg4X6l8VNZwlNnKVC8vSBUrHLXEQzutiaJTAer1JhA61K70apnI13fJmkF/SU/kLUyMjG0a7arDo8+XXTVujUI6ikx+Bi31uYiuFnfQ8vVzy7xzlz4PO1wZWjLD0AJdYtM1P4fBlDKDloCTIAfWms5L0Z10yqlBh8r+VlrCSZdkgKfBXSCUxPPhadyaIb/Z3ti4GmAPVv2c3NebHP7yG7Nd6D5E7KKK5/K7U/lKzrcJWD35chVzjn26073FFa66MhX7RSiDd+AtIyRNXt3sscKrAvCJf+d0TotVCFXzNwdrpfu9FGRK2M+utoY/QYcOw7hGYqSaWTBTGIKG5/n6Zl7+Qu+fa4GC1NcA/sBkWjpNfNkTLnF347tIw63he9zq3t8qIEIFwveal+WLj5tOjiMHBG11o3eAjynbuHksmsg89s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(316002)(36756003)(54906003)(110136005)(6506007)(6486002)(508600001)(2906002)(966005)(7416002)(38100700002)(5660300002)(86362001)(44832011)(8936002)(8676002)(83380400001)(2616005)(186003)(52116002)(38350700002)(921005)(1076003)(66556008)(26005)(6512007)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G/EMEZvPVZNFkueyiyLKvJL1+4apfRK2fcH0nheGbgj8qLxUtZ0TlA2rU0X9?=
 =?us-ascii?Q?fg+ToVcZY7etcvJPOlmWhYm+6Lye95RDOfmuRzalrUksteK42+QPWVlN6c8A?=
 =?us-ascii?Q?wpIKUZj8HwiMiRsQSUpQ+sTvck0+IGSjXxWB2dGU6ePPKI6BbSX/QG6pvhfn?=
 =?us-ascii?Q?vWx7u+AcWIt6TJgopXHjWzq6UG+q7noFAL2Rn70yJCfAi5U/gGf65ip5P8bq?=
 =?us-ascii?Q?jgTUI7MOLtgLdNID/BERg9jEMnC6sYQyhPfgId7MQYIsqq3+pkdPQeEbjHP0?=
 =?us-ascii?Q?R2dWOEDKDcVeLgCnYvAQcMos3LmggcoNEzDGd2ho9WUtqhusddwrnH9yDHhU?=
 =?us-ascii?Q?x9FBpu7JM1Q23bJ+6tZDQYhsxnghDpjHDuukDKgmUcLGkWgZ81dQkHlg1Adk?=
 =?us-ascii?Q?VnKJgxMzJmT8U3p9R2LZFxEFyIa+E31BKx1SNy7f59ErR5Wttmai9vZ9NG64?=
 =?us-ascii?Q?+/Uz8AdwBIvLPfTvYYr+kiQCJMrZ62GiKoxpSnNMupl07p7MUZ4bHe++mL5T?=
 =?us-ascii?Q?5z3rt1FssF+JhgP7bFFFPo8cAuaavgiUAxK1B75OGEMDpMYeHzH8gzAMBMBT?=
 =?us-ascii?Q?1QgWARRLl3E+ITwUhufz2MlaZ4jlog8ujR96BjnOwvg8GnAO0RWdfjSgPzx7?=
 =?us-ascii?Q?JqO5DsIjnmac4Y1xdx/OglCh5pWu/pW0OVpi/y8RRj4C5ygevRCkX2eJtNZd?=
 =?us-ascii?Q?Kp/Ip5Fns+CpppacRqIhXRFeJutOUkE9I63Ur0VXbbh86dhQuML/fLiSoGeP?=
 =?us-ascii?Q?tc6Okwkcc7Er6TqMRFYoQM1V8/+oOmvR8+p9e5U1VSNnQs9E2MvMaZs9EGHN?=
 =?us-ascii?Q?5Dw8H1Xf5qsghp/rdjl5ycJVFMK8tL7DE8jkPp9QeaYJVBd5nA2gVRK4Z87e?=
 =?us-ascii?Q?OrZ/qa62bNfw2q3fFU0Anx30MLr41bS5D7yqK23QEMuq6Wn5T6ZwUujQkqOK?=
 =?us-ascii?Q?w7iKjX74I1oIDZFwUd92JJGgDMiB3IZqd5GOAg07WMwNHbk2gQ2CVI92yLvA?=
 =?us-ascii?Q?oczsL3jJ+3e8wuN+miLExOpomm3uEYXCioAXd1U68Hn0xCmN4Ov5Kb/OTTAL?=
 =?us-ascii?Q?9n55PVR38wNFkHO45rCkdNsnUm+e9qEJFFCHVFzDruRzFNkUbRWRXc9jKFyF?=
 =?us-ascii?Q?DNewX4srzxRsIEAixvPyS2rRcQMewMafSODFE/pmCkiPXPDfwmstKoscPZK6?=
 =?us-ascii?Q?GDqE01mCAnYCf5gEvoO9EXYep73J4K5VbV6ii1gpA9ixri4fEt+97yqcv/LJ?=
 =?us-ascii?Q?hGOkGMYgiCuOMdreGSwdrtr2rZibgIppqTX8mOOflX/ZasXdlpcY14ssCphw?=
 =?us-ascii?Q?00VN0NpIeiXved98ytCAOQEDwRHK+W7G9PN3N7XRX83IckXMLtnlmr3mTRUB?=
 =?us-ascii?Q?onmgJgM0db8tcYGqxMiZuzGPOtpbNK5xn5UlKNbiH77GghB8rMWVzxt8xEZH?=
 =?us-ascii?Q?eC+zC+e0NjAfp5KhPKKpPelqUnGGpOoFyYHwDOS7o+iVMqd3kTbYDtzA1ZrK?=
 =?us-ascii?Q?rqE5q17zFZX7ts81+98HCVMVWZm2GDe8/6zMQummK/X6ssnlpHqdjr8U4Ylx?=
 =?us-ascii?Q?r8DcJ2klfCvwNUAbXeuMSSB1pbOZqBxqF7Hr7xpOiSViilAvo4W01gNkZkZl?=
 =?us-ascii?Q?0QzrB7IAHpk4d8e0HfWB9aqgWp7rO7ycIirpY4qvCOWc1htbdT8BvPdCL5Dp?=
 =?us-ascii?Q?CGK7u4TZAsQhOFCWdiJBiUidWys+7vvR1q/uZE4kYnNlJkI8b6OhUKdF3B6g?=
 =?us-ascii?Q?JCFry4pFyg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c376c7-de0e-4586-d4ab-08da4a25377a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 14:34:53.3419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5htr2WjMKHhRzaE4ICxGGjzd7ggIIrd+liKdGPNkebiaw/MhWGJX3dOMpRzfLS3EAEJnQk442AZ2qcWuLpc9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5885
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to replace the fsl,scu txt file from bindings/arm/freescale,
we need to split it between the right subsystems. This patch documents
separately the 'iomux/pinctrl' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 .../bindings/pinctrl/fsl,scu-pinctrl.yaml     | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
new file mode 100644
index 000000000000..d325340403ef
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/fsl,scu-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - Pinctrl bindings based on SCU Message Protocol
+
+maintainers:
+  - Dong Aisheng <aisheng.dong@nxp.com>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+  This binding uses the i.MX common pinctrl binding.
+  (Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt)
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,imx8qm-iomuxc
+          - fsl,imx8qxp-iomuxc
+          - fsl,imx8dxl-iomuxc
+
+patternProperties:
+  "grp$":
+    type: object
+
+required:
+  - compatible
+
+additionalProperties: false
-- 
2.34.3

