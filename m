Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB125717EB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbiGLLCx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Jul 2022 07:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbiGLLCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:02:44 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EAB91AF748
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:02:41 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2047.outbound.protection.outlook.com [104.47.22.47]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-I4DavvXvNzejsb9UX1TvtA-1; Tue, 12 Jul 2022 13:02:36 +0200
X-MC-Unique: I4DavvXvNzejsb9UX1TvtA-1
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZRAP278MB0317.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:28::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.16; Tue, 12 Jul 2022 11:02:34 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3d:ca30:8c24:1a95]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3d:ca30:8c24:1a95%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 11:02:34 +0000
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: [PATCH v1 1/4] mfd: stmpe: Probe sub-function by compatible
Date:   Tue, 12 Jul 2022 13:02:29 +0200
Message-ID: <20220712110232.329164-2-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712110232.329164-1-francesco.dolcini@toradex.com>
References: <20220712110232.329164-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MR1P264CA0167.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::8) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e22c139-fdef-4b9c-40c6-08da63f60638
X-MS-TrafficTypeDiagnostic: ZRAP278MB0317:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: mZLZoXonhfwIwI3U+sJQTLQ2n3nfY/Zh/MyKZjpt1CShLZRZxV7TdCo4JwUojxf+HXk5UsGgYOp89LTL550QM/XJo66G8pzyap9zd9Rii/pwkTyq0Tv2R4LE8dECmt/yfR/Jnc1L+QyfKjrkv02YcUkX93P1MiNbJGgCPMQAI2UIPDvNeJR+D6QBKRVNHrqgc/6FWT5uL4hm8DqNzrkqDe7SanKhP8yHtB5tHotpc0UWt+eDpnL+Nwz6RIy8vrM2DPiTCKdpL0u0UJuoYs85shWQiuLgsAliy8QtVRFaPV7feZtNYfqDxL20YhJxVgYo4qqV9yQXtkwAO/B4o4Wyvz+MsH65t5D9HiddLFKYqvu6+P4OoPinzv90jfinZWv1b2rDSMIxvaCi+qqRnSaki/Iif/dxp9xOahNqK5q4i9AyEx9vbSkyynu0oPITVLZCG/AkD7anDdsA7S32EiKwShheCeQAZ6i2L0alrqHm7LVtkC+8p9uK2m6rqEklTEa/E/Eglc5AHSnaGR/oRc2XW76upXrR8qAmwpoyiOnbaA/mbHvaiHR1PyI9p07y+z9LmfbZ52No3E+UIOfLg6bC5zE0p69/ir6h6mcmPJg14vj2XPuzO2ANk+mxs0OTSGC0hrA5lAxMlcPbSKcax2gJ7FMfdD/MTqliibCSAXO4d1h1ppQBYtchq74tdxA9yVD3X10wf96MppVcnkXOgd5dzaIUphGaCqzLUso27B65Cds53y3MUklVR/yfQs0qqapRlqslmv8D678hl+SpuiHm/ZBxHaTgnotKki3ysPAza5LqpZN27/k/yCqbEN9DqYLy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(376002)(39850400004)(396003)(136003)(66476007)(38350700002)(1076003)(52116002)(41300700001)(38100700002)(2906002)(54906003)(186003)(6506007)(6666004)(44832011)(36756003)(7416002)(66946007)(316002)(110136005)(8936002)(478600001)(5660300002)(26005)(86362001)(83380400001)(66556008)(8676002)(2616005)(6486002)(6512007)(4326008);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZDchQm8uVduf/c9BMPbGlZJ8LAx6y9sxW+XKihuhqqgm8WaMiEf6WayTKBBT?=
 =?us-ascii?Q?uvEFSonR8WXL1rjqzhtl/yhl1J81OCSckVEaFpiZyPKlCb1AmKigC8YmSk06?=
 =?us-ascii?Q?ltSw8fd2E0OgisScVZkL8rC1M/UnCNy4J9lng8IhAKiYjO1Xn0HovYnDY5bo?=
 =?us-ascii?Q?q3Tq0eZRJOLPfkNd3VIws/ViaxbR+PA77gEf2k7GUpfluhlsniWrC3bcGrhU?=
 =?us-ascii?Q?/L14wJ7528OlIVkTWtWfKVji0MmN5kgYIkugRuhUpRQombLu+JX+MIqFeYTE?=
 =?us-ascii?Q?doup/Zdq1iv8v4z/C1jGvKq5kynQX7sNxUT/Zvs54LmE9FaFJoYNXYzwOoCW?=
 =?us-ascii?Q?a/NlsZr59MwNmG+gZvNrSelIft0yK7wq/5V3Qf6EzFJulxSvOz3m1UH+FB1E?=
 =?us-ascii?Q?I9EE+BhSswvoIVM/UnR/49U17Ob6+1O6YG7LKGZM3cudiPoXwdGdV0neDV75?=
 =?us-ascii?Q?vH3PREvh3CMd9Ymi/fOY9ZlPnfuT9htU/kcYVdv0w0u9QfcPJ7eKcXgAmAgg?=
 =?us-ascii?Q?bL76PH16oqEluyEN1PE+5HvKRzfW+mbFb2Zao8tyzd8355YBLA6Gq0D0Bk6J?=
 =?us-ascii?Q?0mhI2lQu2NusiDQ6HOTfQoHusYrZL3AXIsXZlHMUBiYMv56oKwqa/xRqv29s?=
 =?us-ascii?Q?bbi0gN+3ApRDwgLJXw9YAkKkhQMr5yCrZU89wyEsUivBMZWDL2ri18AqjuWS?=
 =?us-ascii?Q?ZLKjZRq4B3oJPiJ4EzgU8KwDzAY+FVFgBFWky+MaWuab8VhEY0pWgy3d/83o?=
 =?us-ascii?Q?YG77kRabI7uI4mFg2hnL83JmeQPpi8JZFIpAwTHTFiergI+z5494gwZpMgYG?=
 =?us-ascii?Q?vSG/myBBtlyRFbEcBSt6j0pgzzdnFzhmW1+0Dlk1PI1rpA6GTuVEGAYEOUg5?=
 =?us-ascii?Q?PIUpzMxKpcIerilf+MUKMJsi5OkfaQvdnAO9ItgQ00Zh1zifc6D6KZ5QZ4WE?=
 =?us-ascii?Q?Qs0cE5D4r0k2ZmYF9RURWBo52Y3vq02OVjMbR8ZhBdNI2haVZa4qsWZQ2Oyz?=
 =?us-ascii?Q?3Wf8bU8Jk/BF7YmJGMLiGUVAlVijuQtjvdWcTpPVASIqstr/JLHH1dZnc0h2?=
 =?us-ascii?Q?qWEno+ibroNeRCHCmhYA8eJSIrc9DZ1gYwp+nLKsCCdWFWolMfCqZEDAdowf?=
 =?us-ascii?Q?Ll044nbORGjSnHblllpsOXlL8lmBNxMm1UrKJ3rlTqEaD9SBDqvJ70NmSy1g?=
 =?us-ascii?Q?TgHHRi3rlvJ+pPAgv/hVTDHfooN+SMiaGnjF51QZzXuIwRziX/siNsBG17+t?=
 =?us-ascii?Q?YwE7aKv+OPFOX8kJzyq0Ku4HxYNitZBeuMxVdj8hoQ2j6D/lceNz2+/+6ECx?=
 =?us-ascii?Q?W6/pcgl7IqYSAICNNilK65ssdIwqHULAYjJBCkuj0BQwoo0CFZzHG3Me1WuL?=
 =?us-ascii?Q?oIlQWuJc4jqyrVW0+3TohiHLqMhGhvps3kXjevnX0gb/1jNjdpxwwq7PI5UA?=
 =?us-ascii?Q?t3CWoDqjjd/oVKh93IkDKZw2Lwm2k+gDrpXQOAfj447HNBg5tXHbXKiaph0Q?=
 =?us-ascii?Q?Cl1shKdjibzLRYQtCG3sg/1+vqMLXLhdV7CjDdtp6a1fQxJohUDvQ4r6LRE6?=
 =?us-ascii?Q?W0g35fGc8xnX3KFDnJpt/8d+e/XpOUY1l0ihIdNSSAzkI6ou+WVv+f0+nW65?=
 =?us-ascii?Q?Jg=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e22c139-fdef-4b9c-40c6-08da63f60638
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 11:02:34.4582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQZwiFZU5nnN2xv/juma7DOF4oqxtzNAeM/TVwmB1coh0AXBUlhYiv2cm2Wkjx77lPYTcLee4/CkXwHIAxMBLXhj/Phi6i/NmuHquL7enUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0317
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=francesco.dolcini@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use sub-function of_compatible during probe, instead of using the node
name. The code should not rely on the node names during probe, in
addition to that the previously hard-coded node names are not compliant
to the latest naming convention (they are not generic and they use
underscores), and it was broken by mistake already once [1].

While doing this change `rotator` entry was removed, it is not
used in any device tree file, there is no cell defined, it's just dead
non-working code with no of_compatible for it.

[1] commit 56086b5e804f ("ARM: dts: imx6qdl-apalis: Avoid underscore in node name")

Suggested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/mfd/stmpe.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index aeb9ea55f97d..90a07a94455f 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -23,6 +23,12 @@
 #include <linux/regulator/consumer.h>
 #include "stmpe.h"
 
+#define STMPE_GPIO_COMPATIBLE   "st,stmpe-gpio"
+#define STMPE_KEYPAD_COMPATIBLE "st,stmpe-keypad"
+#define STMPE_PWM_COMPATIBLE    "st,stmpe-pwm"
+#define STMPE_TS_COMPATIBLE     "st,stmpe-ts"
+#define STMPE_ADC_COMPATIBLE    "st,stmpe-adc"
+
 /**
  * struct stmpe_platform_data - STMPE platform data
  * @id: device id to distinguish between multiple STMPEs on the same board
@@ -321,14 +327,14 @@ static struct resource stmpe_gpio_resources[] = {
 
 static const struct mfd_cell stmpe_gpio_cell = {
 	.name		= "stmpe-gpio",
-	.of_compatible	= "st,stmpe-gpio",
+	.of_compatible	= STMPE_GPIO_COMPATIBLE,
 	.resources	= stmpe_gpio_resources,
 	.num_resources	= ARRAY_SIZE(stmpe_gpio_resources),
 };
 
 static const struct mfd_cell stmpe_gpio_cell_noirq = {
 	.name		= "stmpe-gpio",
-	.of_compatible	= "st,stmpe-gpio",
+	.of_compatible	= STMPE_GPIO_COMPATIBLE,
 	/* gpio cell resources consist of an irq only so no resources here */
 };
 
@@ -350,7 +356,7 @@ static struct resource stmpe_keypad_resources[] = {
 
 static const struct mfd_cell stmpe_keypad_cell = {
 	.name		= "stmpe-keypad",
-	.of_compatible  = "st,stmpe-keypad",
+	.of_compatible  = STMPE_KEYPAD_COMPATIBLE,
 	.resources	= stmpe_keypad_resources,
 	.num_resources	= ARRAY_SIZE(stmpe_keypad_resources),
 };
@@ -376,7 +382,7 @@ static struct resource stmpe_pwm_resources[] = {
 
 static const struct mfd_cell stmpe_pwm_cell = {
 	.name		= "stmpe-pwm",
-	.of_compatible  = "st,stmpe-pwm",
+	.of_compatible  = STMPE_PWM_COMPATIBLE,
 	.resources	= stmpe_pwm_resources,
 	.num_resources	= ARRAY_SIZE(stmpe_pwm_resources),
 };
@@ -461,7 +467,7 @@ static struct resource stmpe_ts_resources[] = {
 
 static const struct mfd_cell stmpe_ts_cell = {
 	.name		= "stmpe-ts",
-	.of_compatible	= "st,stmpe-ts",
+	.of_compatible	= STMPE_TS_COMPATIBLE,
 	.resources	= stmpe_ts_resources,
 	.num_resources	= ARRAY_SIZE(stmpe_ts_resources),
 };
@@ -484,7 +490,7 @@ static struct resource stmpe_adc_resources[] = {
 
 static const struct mfd_cell stmpe_adc_cell = {
 	.name		= "stmpe-adc",
-	.of_compatible	= "st,stmpe-adc",
+	.of_compatible	= STMPE_ADC_COMPATIBLE,
 	.resources	= stmpe_adc_resources,
 	.num_resources	= ARRAY_SIZE(stmpe_adc_resources),
 };
@@ -1362,19 +1368,16 @@ static void stmpe_of_probe(struct stmpe_platform_data *pdata,
 	pdata->autosleep = (pdata->autosleep_timeout) ? true : false;
 
 	for_each_available_child_of_node(np, child) {
-		if (of_node_name_eq(child, "stmpe_gpio")) {
+		if (of_device_is_compatible(child, STMPE_GPIO_COMPATIBLE))
 			pdata->blocks |= STMPE_BLOCK_GPIO;
-		} else if (of_node_name_eq(child, "stmpe_keypad")) {
+		else if (of_device_is_compatible(child, STMPE_KEYPAD_COMPATIBLE))
 			pdata->blocks |= STMPE_BLOCK_KEYPAD;
-		} else if (of_node_name_eq(child, "stmpe_touchscreen")) {
+		else if (of_device_is_compatible(child, STMPE_TS_COMPATIBLE))
 			pdata->blocks |= STMPE_BLOCK_TOUCHSCREEN;
-		} else if (of_node_name_eq(child, "stmpe_adc")) {
+		else if (of_device_is_compatible(child, STMPE_ADC_COMPATIBLE))
 			pdata->blocks |= STMPE_BLOCK_ADC;
-		} else if (of_node_name_eq(child, "stmpe_pwm")) {
+		else if (of_device_is_compatible(child, STMPE_PWM_COMPATIBLE))
 			pdata->blocks |= STMPE_BLOCK_PWM;
-		} else if (of_node_name_eq(child, "stmpe_rotator")) {
-			pdata->blocks |= STMPE_BLOCK_ROTATOR;
-		}
 	}
 }
 
-- 
2.25.1

