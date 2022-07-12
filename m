Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9F85720EC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbiGLQeA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Jul 2022 12:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiGLQdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:33:54 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7358E20BC0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:33:53 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2047.outbound.protection.outlook.com [104.47.22.47]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-RMZy1JirNn-sjAT-K7IYzg-2; Tue, 12 Jul 2022 18:33:49 +0200
X-MC-Unique: RMZy1JirNn-sjAT-K7IYzg-2
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZRAP278MB0173.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.15; Tue, 12 Jul 2022 16:33:47 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3d:ca30:8c24:1a95]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::3d:ca30:8c24:1a95%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 16:33:47 +0000
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
Subject: [PATCH v2 2/5] mfd: stmpe: Probe sub-function by compatible
Date:   Tue, 12 Jul 2022 18:33:42 +0200
Message-ID: <20220712163345.445811-3-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712163345.445811-1-francesco.dolcini@toradex.com>
References: <20220712163345.445811-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: MR2P264CA0144.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:30::36) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 615b4774-40a9-4985-a9b2-08da64244b77
X-MS-TrafficTypeDiagnostic: ZRAP278MB0173:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: wULL2Qvbwqj3+4wWPDq7bm0L7TPQxKzRgJkrW03HWJ9s+TgYVYszoZ7LQaUrUfcbY1jEc0KexmwB21ubewwi/lcWddMS6upsvjf/tycQTCzO97l/tWkZKkNjRYyGZAp1jMlIIfipCqEBHmlcCzVWfPUIlHAcl1Bmi1S4KQmW07Vkv6QYnQobQJfR3Ot2cbKiECuCZmHeQKED7QCxEqmaPSSxWHnFw5oMvBfkxE4f45No4ZJ5U7+aE7ljxnDq/M7TzN4kCWM2z9gTZprkD3TfQYLev85nz5ukA6OxTbhCsjkExxmitXkwxEJqSCjF5fhe4wtEakcmCj1m7jUMn9yqb9S0eNhN2n+pk1XiDRzkrqoevWpkaZoeSLFd444mXquhBqi+/VpIwGBiVpAqsR0o2Mgxu36sXxObKTaVeiNUuGqZOwFuFL6Fk5D1s12raHyXGKwOXokQUeia57CfnbQt/cfsuY0BUL8hDS/jNxsv1JvLcFOBAEj/DQAiRhH9yginEMsBo8HER4Zcn4pUea2X83H3uatMRnJTnZFfDvnw4ySeMjNJV0cI9BUW+xjezLYmjbDEXqlk1WVTaJ7FrF1XyQWiLm3WjPbI6HQxqBq8xMUPbtPuMG7Ipm2imqDY8kEJYZPeqT5TUqkBQzW9ODh7jj/OPnyUyHE2V7JV4diqV4M5bjk9YYVM6zRtwRO7IC7qIBEs4ghXLEB5OyK2LT8odGxZhRs0YkMoLdAeqcnXZIlpr7gIGr9+QZ67KCekjnl3xl7Ia3wVD+DRaRxx6Pb78bld5WH+DDopi9MHzbs2k5rQR9Ed+0CLhfisK/cOvJja
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(376002)(346002)(366004)(396003)(136003)(478600001)(44832011)(6666004)(36756003)(6486002)(8936002)(41300700001)(83380400001)(54906003)(7416002)(110136005)(316002)(5660300002)(2616005)(66946007)(26005)(1076003)(66556008)(8676002)(6512007)(186003)(52116002)(4326008)(66476007)(2906002)(38350700002)(6506007)(38100700002)(86362001);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vwNnOiMo8cbLnNWHFmHH4YgoTBl46eCwFG8K7gPnzlC8S466HauzwF35u8Rl?=
 =?us-ascii?Q?fQZPNTZ2sZbT+rKKqzKkP9IMAOZpEtcWrHLwd7BmJ1f7td4WXKTgvhOGxVej?=
 =?us-ascii?Q?mq1ibQPoWxCUkY6alv6whNOTFvY/rJWUSH1PM/PdDHKnB6rgKTea3++rYWAy?=
 =?us-ascii?Q?E9CLI9QVoV0dZCzzG8MPwIg9xvT7dghZ27c+1pGfMXDgkS1GLEHzDoJKUqWf?=
 =?us-ascii?Q?eMFlQgCO7n7H+PzHQ4fV/Nt0BxsTWJwOLew41iPxgQyizhFNAbID3T9JWdNA?=
 =?us-ascii?Q?S01NGXoQSR7ggB1PO7e6XnqMukPGwMvc66Menll0ulXZ3P/HWHJDiu2AMdXc?=
 =?us-ascii?Q?fP1LLLUvDhnb2SnKQp6Db6GquaQ57VQdxKmdFYFd5BekrKJUPORat8peCrmj?=
 =?us-ascii?Q?jjuzehjoKthB5vT8YvRt09HoYNHH1TEWqzHYQ7p3GzVn++gHGJoJ3ar0QKya?=
 =?us-ascii?Q?6GPjf/8OwXuDRNg7C04i2ktFI2QYDHVkdM4bKK8fQ2J6kyX6JVhbc3eW4CHj?=
 =?us-ascii?Q?vc2Gd84yqXq9bEB0t9R8/vhOLdtuGkZEW6rSuwn4jZGJW0KxYGCSN12P096O?=
 =?us-ascii?Q?J8Ilq/tKE8qpF/sXDKCntx1QM5k4UdCelGvRQLkozBSl/EPwnWoOBlKPQPdy?=
 =?us-ascii?Q?5OTO2aeA00XwnwIY77UCcU5epAkD6Vvzgra7unITTI9PPUd6v1XWovu9FTcK?=
 =?us-ascii?Q?Vi8XornaSmLQIf/oagJDzan8MQ1vSxonl2s9+cBP7FK0qYQVTuOXlJxziRDl?=
 =?us-ascii?Q?9yra3J4cRIM+PpXcaG78L891FzNrNGh4ok8NR+s2aH4ce3lJ5vfXKyNfiIgM?=
 =?us-ascii?Q?3NOGZ15cS02iby/z7T3mGirNVRie9AyovXCel6AYSxZoTHoXv2LFaCw2HZHF?=
 =?us-ascii?Q?+GDbZmxaBnHJVaO1cvE+659889pfuu5AZo10dOXNb0ftYWH9ARRLl9MKIGOJ?=
 =?us-ascii?Q?sdrKvlz7m/88WoUbOF173Gtm3j8Z0lQ6GgNkY0a/lb5r5R7TuxfDhj2kTjPF?=
 =?us-ascii?Q?aIg1MVazWBfuQ5l5zroqSeUdMfMZIYwh9IGa/J2lqWZoQsrSamBDuu/ldZTL?=
 =?us-ascii?Q?Wvpcf/C0O3txRYaq292bQlmFwwkQBI4YtUvvpVChOVu2u/rmpfV1TthpGQnr?=
 =?us-ascii?Q?EbRVB97SJwUMKY+aO2Nz9IAKwNFncoQ/SVN16Jw4OLGZHRMWUtCB/4jN11Z+?=
 =?us-ascii?Q?+HRK2kTH+ql/z0ULb2w/O9jjvo15/L1TrpxrHzhAdHq5mf9R9BSY05Z+/9A4?=
 =?us-ascii?Q?RliPK2ubTrVMsTz6emSwofg0JJLvMqYivVvB1cu28pKu+8FUWFN5RRNc/Qta?=
 =?us-ascii?Q?seG/ConGOBHkbkjLl30ae7sy/DSy9aBtWINKYQJ6vTezpCLdZCOQ6YeXh1BU?=
 =?us-ascii?Q?qABlhw3cEFRCSdf4Yon9gl5L+GXT0U8HrVXu8RwJ6VImUh0tcnU5W+BeIhFa?=
 =?us-ascii?Q?HNeQ0Am3h1jPVWc/mhL/+YAmqkhVLrHQ+xfp0IHjgSwIC0phFtgMNESe/Q3A?=
 =?us-ascii?Q?skbKk96kj0tze3zYHzQgiGapxwSczysr1S2M8ZLcvuHfsJlmuBgejqmDkSh7?=
 =?us-ascii?Q?urFCV8OMu2TqiKTxnm+tRyh/wP5vhWeSjJK4K/BtQxhcfMI+cTWd3Z5ug7aR?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 615b4774-40a9-4985-a9b2-08da64244b77
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 16:33:47.5341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tqk+vkjL3WHilQ/VpbFnWQcRwEOs1ejq8NOo19ltGFtkzjkrfLg0GM4fDbvW1g3z9JV8Je8fS0Yhq3mGZEAtV6H21i9BCiUv1DFN/MskGII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0173
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

[1] commit 56086b5e804f ("ARM: dts: imx6qdl-apalis: Avoid underscore in node name")

Suggested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2:
 - remove define usage for compatible strings
 - moved rotator removal from probe to a separate patch
---
 drivers/mfd/stmpe.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index 4aa4ac2ff406..987e251d90ae 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -1362,17 +1362,16 @@ static void stmpe_of_probe(struct stmpe_platform_data *pdata,
 	pdata->autosleep = (pdata->autosleep_timeout) ? true : false;
 
 	for_each_available_child_of_node(np, child) {
-		if (of_node_name_eq(child, "stmpe_gpio")) {
+		if (of_device_is_compatible(child, stmpe_gpio_cell.of_compatible))
 			pdata->blocks |= STMPE_BLOCK_GPIO;
-		} else if (of_node_name_eq(child, "stmpe_keypad")) {
+		else if (of_device_is_compatible(child, stmpe_keypad_cell.of_compatible))
 			pdata->blocks |= STMPE_BLOCK_KEYPAD;
-		} else if (of_node_name_eq(child, "stmpe_touchscreen")) {
+		else if (of_device_is_compatible(child, stmpe_ts_cell.of_compatible))
 			pdata->blocks |= STMPE_BLOCK_TOUCHSCREEN;
-		} else if (of_node_name_eq(child, "stmpe_adc")) {
+		else if (of_device_is_compatible(child, stmpe_adc_cell.of_compatible))
 			pdata->blocks |= STMPE_BLOCK_ADC;
-		} else if (of_node_name_eq(child, "stmpe_pwm")) {
+		else if (of_device_is_compatible(child, stmpe_pwm_cell.of_compatible))
 			pdata->blocks |= STMPE_BLOCK_PWM;
-		}
 	}
 }
 
-- 
2.25.1

