Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA53544F8D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239293AbiFIOgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343865AbiFIOfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:35:41 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140079.outbound.protection.outlook.com [40.107.14.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEA9322397;
        Thu,  9 Jun 2022 07:35:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqfhNfLv7ITs0lW8HP/vYfAce/TJOd5JH+u0tYPhceme4OyFis5U4MpPyrGlnjDqD7Yj4e9CLQRk6pFrT2QzUFvgjoQ1FgmJuDacCIMmgu2ExUCO7T1C7VrokTmjrsUAVOpDeFebQJSk2+wVMI9oahJYfhOelzeOQKrB9+xubnpT4bZR/kej21SQHh67L5cpwWqi6gLs2NgaB9u98TNHfIcOZE48kIE700XggWBj/HViD89aIPa/T4/T6sPCEjFxpAoLfRplOWJCaOemAnwJt4LXyhLsF/5LeR9E04cOpkn6qsg8mZDe0IbxWMM0vCcPfhxJ6PXn7CcnnmtwfTp1Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQ3+VnUZocHTve68BX5jUeD5qNbbCwnp5Ilisz6IaVk=;
 b=l5Yl9mDNsR0l0BT/o2HTJ7i6ZT3S2UzPy104muZHIJF7kcejG40ZRcdpHcenCTy4wghFKDr3Un603uCWO8PmXLDP4YfBgYX00n9MisgLd625ZovxldOMMyalKj49mj70z23qTLaHevk06ICNexZEOYPmG8L9O5XA7080bz650KJTFHT3Mk5yRatwJ+2JGkMh6TduBlnpmSVbW9sY/G4CIvzreN13JY7RsJcGbwSTXnNgFVVSE8w5F7pNzY7j4m+PKUYRNjTEASBKmtDp6YzvFfz47TsJmowyq4mWM7wJ/1G+EW3npBgrRjwx+IuQ1woGXDq6rl2WuHCcTUF4WW5AJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQ3+VnUZocHTve68BX5jUeD5qNbbCwnp5Ilisz6IaVk=;
 b=Y0WpBBYk/3U75OfoOVS0fckctCojUo6LjwcFzRw8Hoilp8G1uxpZnutrSaCNjOxQNPyZzxZu3w5djxcrBsbGhmOMyleLnc45MvrGN7TtERKVCIkyXN9sjuAJUib1vW8xshu+59nK6VtsBKCTJJDsH9Pc2wU38v4J/GGy5/HPwbg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB5885.eurprd04.prod.outlook.com (2603:10a6:803:e1::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Thu, 9 Jun
 2022 14:35:26 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1%5]) with mapi id 15.20.5332.013; Thu, 9 Jun 2022
 14:35:26 +0000
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
Subject: [PATCH v3 07/10] dt-bindings: rtc: Add fsl,scu-rtc yaml file
Date:   Thu,  9 Jun 2022 17:34:20 +0300
Message-Id: <20220609143423.2839186-8-abel.vesa@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 87c5faea-03a0-4879-35d8-08da4a253c44
X-MS-TrafficTypeDiagnostic: VI1PR04MB5885:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB5885C1813CEFE814D7324EF1F6A79@VI1PR04MB5885.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J0UyDk0qcuOGRXVWieaROfCoNowZWGoTFI6B1gaojjKABgqy5k6v3EyoNJEvv6m6IykwzS9NG0ouaEPoHXrl24CUxT/btyxIUO/Z28r6UPze+1LcgGqQW6sCbxKyuQPsBThCd1r1ih8MK2HRSEUNsSVOzfML9s8bDqiJOgTE6wBLP50rXrA93Z8MkM70EHS8IXRyHasT6jMd7mYITbPC8YQ7NU2Ve5Yb3RWJnDZnXMha60IujOyq6Bjg2696dD4w9110PBbBC45SfWk9uUCoNz7nn3bM7KQ4yKH0MAXw29TOM57Layk+Fa9gkNyCrn7AZ6N40Be7Pd9IaOiZtorsVeEmLmUvV8+v8jMxliI8FfSgvKS3HGHgoxqHcEIGUEHtdYo93RqiXV36cAQ0l7dfUcqPd5q3cA9hEzqrPSpDebQG3nooDvpew6dGbdkO4YeRkWu7BTVuCFTK8SCW1EHUcHH3BiJWrKoBh9kimYRLbePwBpkSARIln+sMd7LkY8MAX+QLefkdfIXumnxY1e92BkDTd/xIbYqZMzjmg5jUs90PLTZ8JASpMUHRn4IUrQD2XOdZNQM/9TTDL3PSdAfEJ5dWSoMt6Nn94VUwPkr8p0mOM114zzQzejotkw/9r7x9OIhg6tSRc6uEj0WyTg3+lt2SQ7cnRwo0KrEx2ihI6b0qkTh/4kHm1yVsbPLUxnbknZ5HuqmeMGb+7LwRwmxaT5w7xhK+TkII8OM61Jh22XVq0VUYVbyKRZ/vzURvkmaQGus+9+RJixuBTazjzWIsgfpjD5FGKC5/R9OcuUz5WyV/4F7MO5bJoDf9mEfraVtY+6vm/phyD+9Ob2H18jmtfqcm78jJesrh1WRZkTn9eho=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(316002)(36756003)(54906003)(110136005)(6506007)(6486002)(508600001)(2906002)(966005)(7416002)(38100700002)(5660300002)(6666004)(86362001)(44832011)(8936002)(8676002)(83380400001)(2616005)(186003)(52116002)(38350700002)(921005)(1076003)(66556008)(26005)(6512007)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HKQuH9ZOrpxBuQHYMs4muWyA1JyhzAerS1GtnxcFEH/MCFAnZnm8tBsF7u/g?=
 =?us-ascii?Q?MyOiVWBsCqQx/Z1UnYuSZLCj9sgG6+99BwaSYOs/C6lnWv0SxlbQmRwn5NVm?=
 =?us-ascii?Q?4XrFj3I11qH/QwsfDbNZZBDyrZyXncZWyePELNd45qOWRiaDy+P6cP8kpcvY?=
 =?us-ascii?Q?4rauHX3ZNk7J64WGePltWf1708u3VXH8e447tnHArB3PmxSgr9TyJpfBm3sH?=
 =?us-ascii?Q?fJei7oUDIXbznS3yHXIsNRQL0yV1+LO4MBDaWB611Y5wM/D7GrtD5VVIsbQ0?=
 =?us-ascii?Q?w3dtOk2eiCRuPqs6snWQI0o9gQfLc+7ae9JTDzTdHYKsolEVp9gvecCcGSax?=
 =?us-ascii?Q?Xzccs7Ze4vpYJz1+U4qMoEUMwf4Jo62S/doXll9K9ySthBMO+FqIw7FakN+U?=
 =?us-ascii?Q?U40aJtTB601YfY5ERQNFnWanYCc4JrSKe0xbcmBRLfXFoYzCzma+fDVJLAzR?=
 =?us-ascii?Q?EE1AgVpm5QDjyoecvI/dNfxmZ/4mVoD8Zvc+YND0fm3tFeAtlDpTIlJIslxh?=
 =?us-ascii?Q?nrGM3Uzo3k+DLwjwzyhmQme+ps9NuMiWg9UjfDHyRCT10rCdDmHtp1dNz6Io?=
 =?us-ascii?Q?hfOm8xFd60Tn9laX7SkGLJwqmRRzW9zyicKCN2wl+lz3i5Ky0pWVKs1d0sPi?=
 =?us-ascii?Q?fBSrfmcHMmEJKjvNNtBuEJ0+7JNGRQPEeeS2qGTazPe3yiWOkOhy0Yb99+Yq?=
 =?us-ascii?Q?dBsVf7zHDTetpzKN2akHdJlKL7LHgSY97J0SI8iLo3KtgZe7eYjev6j9H581?=
 =?us-ascii?Q?wctfGfP4HiD3eNSH9CjAP+U0X7wd18h+UjkJ+PyDzRBT2MVB0sKSe6wzXRnK?=
 =?us-ascii?Q?pH4wiJbToZj6vG58EeokEq6ZGBv437vNpPnrytN3+Ehyq6hDq+/do9G4Q1XR?=
 =?us-ascii?Q?Ik26fvZ1kRDWAD8L5f5iRX4DdCOUOFlZuTqIK7mjMXk0REE37vbEaUi13jxT?=
 =?us-ascii?Q?pcBLYBLeKZqeqS36fbpYeE3m2U6mE2zaQkeWOOviJW2q4yjd6EJgpj9qeZKn?=
 =?us-ascii?Q?j2PG7Ncw1lZlTcS1U1pxl0GBz7ZMhxTLBHkDiXwHt9f63Wdb6iyIeioykJ1S?=
 =?us-ascii?Q?BtO7FZc9vyRSiI8AauuOnWTHioEVtKKSM32nOGb+57CEwVSuOAQa+p2Hun3f?=
 =?us-ascii?Q?nl7n0bFoSLyb6xcvmH1W40SU1YeAcBAxwUuVkVwq+HQXj50jOh9vpVDJOOui?=
 =?us-ascii?Q?u/uePtiJ1eAgYZUIvhgKIh2TfXd9Uf3RnBVmKSoEAaFlO0HbIf0ql35vevoY?=
 =?us-ascii?Q?IrKdpUJmizJa3Fs/4bYy2jsKUgOYiZxnLxsZBLSDFQNGNMts3UXcVsKE/g9F?=
 =?us-ascii?Q?aZPrhXSawELBWZ3PZYEAZQtw8GcRDxH/XQXsb6+ws12RPBiAsi7JRgWDhJhb?=
 =?us-ascii?Q?5ZcSCkaaAW0Uo+QGqewf2hid0HXt+oXR4tNQwRh0sfr9Rdn5RvruNlnZL038?=
 =?us-ascii?Q?TbDgXclDcs88sP0sJcv97tdD1BDIDey6XfyvzyPLF5+xUWadTONFAYe/DSba?=
 =?us-ascii?Q?ComeYBBK78QeyK9z2hDSkoLUZ55FQD8ayJzM3fvynLRRcZt3j7puGT8Dcm3E?=
 =?us-ascii?Q?q9wNLgfQ8Fx8ZWgBYS74Pzzts2OvyW2Ce3RG7ZExdUETU2I2LBhDXxAwKl+A?=
 =?us-ascii?Q?2JL0GSVv9qfjMMXahmpQ5d2g34g8zbHo3jVoqWUJOJw5XgW3B3ZDB0ENW4Od?=
 =?us-ascii?Q?JdsY/W+jMhekB8OoAYvlHAAenypdB3G442PK6iFBb8JmpBSCH8PO2ilCxsL0?=
 =?us-ascii?Q?M8jVAVatsQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c5faea-03a0-4879-35d8-08da4a253c44
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 14:35:01.4507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5J3eRTiPjKgn9WJeHnLZer+om3nxmmNHV63MHCoRkg3paucNRb+28iReMKEznXZmewh3q/7C0TywxYKMhig9xA==
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
separately the 'rtc' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 .../devicetree/bindings/rtc/fsl,scu-rtc.yaml  | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml

diff --git a/Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml b/Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml
new file mode 100644
index 000000000000..c97c970a381c
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml
@@ -0,0 +1,22 @@
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
+properties:
+  compatible:
+    const: fsl,imx8qxp-sc-rtc
+
+required:
+  - compatible
+
+additionalProperties: false
-- 
2.34.3

