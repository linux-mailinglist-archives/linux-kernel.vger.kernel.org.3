Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285CA58ED58
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbiHJNcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbiHJNbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:31:31 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E8748CBA;
        Wed, 10 Aug 2022 06:31:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6eeM5/s/b/epnCf59M1JTbp0s5oR8emRCSsRr5vGipTCCQ72teaMuYju7n17oc7EP/zEnKKAxZbaUaDmHBQ+W5DNPsbSl1Jwn3xyo8KrTBzhmz6bumbkExYuzn+isNEiFqXzDrQ+bsxbABKDWDEoQMkWEunjqYszQyEq18O7GYLB9KbDn9+KACf23zESyzuWjBLi2CaFlRiCBW1vvkpSdQ0o21yNOKgBBkG9aAabKvSKgwv1kmlh5tDfOFFYBNH9TLpZBgHsS8JUGrZSDEnhfVB5KsTyn1LnZ8PMEZVsiYQ/neWtaDll2pfnF17dZkGF1Pi0dl5vTDEy5zkmTuufw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPjZcCpE8/Wkh8Pljy+xAhG6G5BTjXqGngd9RPk6heI=;
 b=S8UV2Cuqri8h0qKhg/akAR+d7OoiDghuaPDHcBs2Ee0YtgxpGoW8EQV6kAKCQvLCI/bRjbpqGwczq4GmEEw8nX+iR8JsC4dQkYaOZjSLxh3Q4vHCK8mt+OLq7/U6YqwU8uJfc7A4Btx7TPlDWQsszfwNqsMzt/0LuYsYukCIJk5pdvKrESZZVemsS4ShSVKWc/ykccoeagT23fqEDgNq9sJIdZDIiB2NqFFGZUoCd/YiP8EqC3RkI98sxNWoA6z3Ie9lR81re8oEDUIBFM9hlqqWcVNWxJ/SR6UWS3vYbg8IgDVqU+JcLMD7zXvfZCFY1EMvT7z5iPJoyPsCxRPYaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPjZcCpE8/Wkh8Pljy+xAhG6G5BTjXqGngd9RPk6heI=;
 b=rBDOMmUtQG1mqeRbz+7cdL7syeZEDaPu/Ar1gew6TfzhxQPTLa90n1F/uE7Ws8ZwA4tvR39cAln666sXWTdHjiRyMu+v3NhJVsAImln48DsFWGawGm8sQ4Uvu1LOAfJqjetm+nF2Otq/VOHf4zXVmSBesPZIWc6egAVSX4dDdyw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 by AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Wed, 10 Aug
 2022 13:31:27 +0000
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca]) by AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca%5]) with mapi id 15.20.5525.010; Wed, 10 Aug 2022
 13:31:27 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, brgl@bgdev.pl, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, Shenwei Wang <shenwei.wang@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/3] dt-bindings: firmware: imx: Add imx-scu gpio node
Date:   Wed, 10 Aug 2022 08:30:04 -0500
Message-Id: <20220810133005.74653-3-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220810133005.74653-1-shenwei.wang@nxp.com>
References: <20220810133005.74653-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::23) To AM9PR04MB8274.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc847117-8ebf-4e55-9bcc-08da7ad4a088
X-MS-TrafficTypeDiagnostic: AM6PR04MB6630:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zd7geGX6FSTKO1lDwueuX1F4YIKIuv9QAf7qJRXzKxSt+HliH9q/2cJRiYf+witJV8uMPeaEnfQalnF8pdqpqH+SS45QG1EeWJ9gQ3ZuI5LN3VFjswt3ZaD2Q6u+TvymFiUaSlkjmP3u/zdrgIUNmF7d4x+gH+c+mZLkN4gYjEmV9GR2hGbfuik4CYp+TVRtD14GBJVT7VYAjtKrZ0B+quHsnbbw9e3FpqxRuFfulfPuwfcnIfzCQGUyb0K5mVYiNNmwZwIW2EylKCBNVxrcOi32NlEHXZE0UeDUonL3Gw1JM3BxerMWXsV4FpcVt9l3ZigaN31rZ1vRwgTaAfooJjbyn/XRx8dnskBNPYTviFXEc8PlbIpnQdIIU0zRHX1ULukEciOIfPx7wBTl4TwofW/J7BG08f1qS6ta8CMA558lAq5UzX0FIdpoYSvpl554Ge0TQ6I7kM5QS4uv/Hjr0hEiBTBVdgHKu2KXziKOgmZ0nHGC+huj3Z1L8J+uuA/9yU2lzrut7+wvsTKoVRiSeCs24rCKm/RyI+QCQDgGNQmG540ua34hdBVVapX7xm2nNBsl9EYZnEmFvA74+ekka92byweT7ROyA54n1b191FHgpRbf84lUhG7lAFNjfnlI21oqhN1m5ZH/qb5PaXEyAbyaBeQk+SzblPdnMkX25O2ap406vwFSa5LnqWslzui23quJuNbYyN/0BZ0B7YJV9DCK+HpyWtPDBjwE4WN36ZFLFvQu3iQpIxSW9jNnqfIWoYpyRFfxhtrkmb8gqd5DF2TiohjKaErBQSfRRpgCETE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8274.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(478600001)(2906002)(186003)(55236004)(36756003)(8936002)(44832011)(6666004)(52116002)(4744005)(1076003)(6486002)(54906003)(2616005)(316002)(66476007)(66946007)(6506007)(5660300002)(83380400001)(26005)(38100700002)(6512007)(6636002)(8676002)(66556008)(4326008)(7416002)(38350700002)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9w+yWjA0y2vrqThJCo2iJzk8+Bm07GnYlzNpgrf8XTxQDiyRIzeVPkGQszf/?=
 =?us-ascii?Q?a8IzUE+0zD2+lkONtm5QLzcGw3RyGsv3Dl7e3MxN3V77kvwVxdYOvzc5rwN0?=
 =?us-ascii?Q?DxAVyVNeMMqxd5yTIcp5eQE+KMt5B/TyjZqZ0ha9doh+MYqnNnnxI4fesV1/?=
 =?us-ascii?Q?UR9IQ8JC4EJIhlHGUBJNuFe3K067J2xjrjIFLchLf2dba42ZD77C3N6vewbx?=
 =?us-ascii?Q?dku0eDaWLqPUiFCqeD08AGBMiHf21N56hBXS4IdU3ZDb8mKHFxcr0AJHgQTg?=
 =?us-ascii?Q?z91ygPKmAP0dak1JkfjJhHu/EZIvdl/l3Lv5k6vJ7Pi7Rf2XQL7OourRp6Pf?=
 =?us-ascii?Q?cJ3qg5WYaaDnF04THswBgzu972BzeaX4Z2AXBssmxTjTlAhcphwwG/rnT3DB?=
 =?us-ascii?Q?KELpOEgHpQgSxZ6PGr52LaNccaGKDsnJtyvXfSq2eSWulI8bONyWTuzIXFTH?=
 =?us-ascii?Q?yApQGD1qteKbsN+F56AX75pNuCYqkRsxr1AIpvbmK15MXTdB/8UqOhl02x4G?=
 =?us-ascii?Q?qfgYW/Afeuum0FA6adCKGN0/N0D1j2ZytWbw5vKd/fW85iJ0/+ad42s2Oiz9?=
 =?us-ascii?Q?NZKOexIqFtNQdjtEQY+hrgKh0K6i/MmbJJKoOY3MKfSSXQxAhUZMdSOat+qA?=
 =?us-ascii?Q?eSM7JVWAEXkF5S8ZQrZan+K6lP1SqBR7mL/YgG7e+nSdtVVuhntdJSdKcmmh?=
 =?us-ascii?Q?dj+z9RKXdO5X8xrTShWvv93pJMAfdOEv18xb7K9ORS+vDO6VkgxlRRonLMTZ?=
 =?us-ascii?Q?3yzN4g1eNWQjeahjHvtdIJKSZfsewSX+74388FeY9QxVyEfQh6UZNJQ6SwCd?=
 =?us-ascii?Q?Z5vrCrxDqZLz1OVBUhXLSp/dmyrqjNB3VL5250kl51e/KbgiXE2n2N3zxl+e?=
 =?us-ascii?Q?xD5wOqO33nzBhz1cufeTQFZNfoSYORjsXsvmdBcCeLgedHN9IlridX7L2cXU?=
 =?us-ascii?Q?1iHMfwymj+9gSFQgVD4g622zH7VBI59dGTp9KhZVFyeRYSJZLPX+209JYhGV?=
 =?us-ascii?Q?Vrmjy9ek2RmQbPtUsIhK01GUOWtA7kuFSnPa+VXr3seA2D4fpyqWTCnNKCAY?=
 =?us-ascii?Q?1V3kK6I2IXZLLSbHGldttvHbs64MoNGtsqGCLqeTBI8KQSQLmvVTJN6YoNVh?=
 =?us-ascii?Q?iQcpziN6E03yBpo8LZGPSc12gJUP65A2YRMDyvzfPb9ueHN0ZI2c+fRIyIJR?=
 =?us-ascii?Q?tvOpLHVu1yzP6XDlGuaf4CdjBCgUkUpx1LijIkG7aVhNQhTBMy1AQxpkl65a?=
 =?us-ascii?Q?QGrl3svgcNGmiiDhtWSTKqlROfi759i5vw7sCD832mlHOM84xK9XUA2y0Wv0?=
 =?us-ascii?Q?uzM6WcIJKhE1rcgnRDu+EvXWUxw84BPgHxLXD5WP8rgGsm5unRInNy1qXgeD?=
 =?us-ascii?Q?yjqpLm6Eh8R0o5fLxMtuZb3jZATZQWFWL7Ti9/WE27GHbpGc9T3+/Y5ssBCo?=
 =?us-ascii?Q?ycSTdVRthMK001D7U6GopHyVnqzS1H1vtzJi0mVytAoAmTav75mDIUxz0oif?=
 =?us-ascii?Q?vZ0xIkmyKu8NpSafiMBo0jSSn3Xboc79UZIA+NSrX3BCgWB2JTfZ3qFn4QYd?=
 =?us-ascii?Q?QxS8k2YZ6LKZPXjlKMqcCXpMK1rzc1/+sR+SRGCN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc847117-8ebf-4e55-9bcc-08da7ad4a088
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8274.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 13:31:27.4289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wWFU+n1HuCX8dEgbQ4nNOJTAdRgXfhxmlDzyehiB1n4/dzzcBahxpqKjHh/QY7XjTkiN8pFODSJOpuIm0UfCwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6630
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the description for imx-scu gpio subnode.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/firmware/fsl,scu.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
index b40b0ef56978..afcfc8ea90c4 100644
--- a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
+++ b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
@@ -30,6 +30,11 @@ properties:
       Clock controller node that provides the clocks controlled by the SCU
     $ref: /schemas/clock/fsl,scu-clk.yaml
 
+  gpio:
+    description:
+      Control the GPIO PINs on SCU domain over the firmware APIs
+    $ref: /schemas/gpio/fsl,imx8-scu-gpio.yaml
+
   ocotp:
     description:
       OCOTP controller node provided by the SCU
-- 
2.25.1

