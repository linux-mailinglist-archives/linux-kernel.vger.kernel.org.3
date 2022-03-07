Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB534D0121
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243155AbiCGO0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbiCGOZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:25:59 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80081.outbound.protection.outlook.com [40.107.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14936E8F3;
        Mon,  7 Mar 2022 06:25:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MF1pExKcVrT3jQtxltpMmY59wa+aZ623a4cCH+wSLx64deeIXlnCloTgpxTCAg8sAGmvZveUdoV2rHGxHcwOHFSkAVFys+xa11AdyG/isY2gbsgGcVSwVf0nUSNGZTX32Yc32hOJ+brxgtrr9whzjvBosGJ4zOx6PhmYKSwxXzvti/eytzBYTdqxfpGPfR59Qi8nxK9WJV/eENACKgPxDPCJ9uVRq69GregSGtCzm2yF+E3HvKsj+p+TWJ9pzAWGbE0vdrHPb55lU0jTjBGFngWB3fzVlhIjFZLrroNWHdbCniLSCbHXY0riNyCQHmbEqopXsI1rnEtC8CjU6ILwyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0vWWcVgJTwSV3oWsklkfnjAchuSjNJZ6p2t/RqO1Xk=;
 b=hjEICGBwrRBhSIa5xhOj4XDF9SrX8sIqCfwEqaByIJg4ua/iQmauJe8NZR/r+H/Tu+riu87JlqmD4dCOYoG2LA8dHtaWiK80PSsaRyP4KKs41TJhis/zudgLxn0/2vgQBz7ZwkmWOGBhiMOpnciUt/EOaX8ql2T9fGLAaYSkLyEgQL6l5kpEyfXN7qV/U5FbWfzIfhwQNNFuBv/GqOXUdi/6kZW+xNXgdUh4lSt/Xt8LKGLBTeAu7kHrKgQ4Os+4Uqs6vGbdvg6BrQ8eakz9/zii0P7cJamu5ZucCJOM+Q9euSkr2o0qkhIP9sloNuH8OlY65Q5rIZTq2QArJYDPGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=variscite.com; dmarc=pass action=none
 header.from=variscite.com; dkim=pass header.d=variscite.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=variscite.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0vWWcVgJTwSV3oWsklkfnjAchuSjNJZ6p2t/RqO1Xk=;
 b=RxK1YJlLoAXiIgD14COtre3gouWsZeZVXEZjUer8twJTIhJjSZBdnjG3p+mmWdrD2fC+IsrU4wnLgz1Ko7HPe3tunZW1XgMuEEY1dVD/H0z/4sNzrh7Bhu8WrSMdKkhy4AP/YEnBWxGebec+BUUhU0owUY9S6V0/9Sbb7hUJpe7/tIUG2DXWMGs6k9G5+d+mneBYj/vQMIpa/y1ed/u8xGCDDRS4hcI3Z64bSGonfCK6j9cNFkUH5XkU+R3Ihg87RBpLJza6VtbCPNly4ZI6D/XadPg0d+ENPAORMVw5/n7E4fsqXsVIVXzpGX7HicmhqPCbsI0/ibXGlG+mSBlnzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=variscite.com;
Received: from AM9PR08MB6999.eurprd08.prod.outlook.com (2603:10a6:20b:41a::7)
 by AM9PR08MB6065.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 14:25:01 +0000
Received: from AM9PR08MB6999.eurprd08.prod.outlook.com
 ([fe80::784c:5631:d38f:9a63]) by AM9PR08MB6999.eurprd08.prod.outlook.com
 ([fe80::784c:5631:d38f:9a63%6]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 14:25:01 +0000
From:   Alifer Moraes <alifer.m@variscite.com>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, dmitry.torokhov@gmail.com,
        eran.m@variscite.com, festevam@gmail.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-input@vger.kernel.org, pierluigi.p@variscite.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org,
        u.kleine-koenig@pengutronix.de, mcontenti <marco.c@variscite.com>,
        Alifer Moraes <alifer.m@variscite.com>
Subject: [PATCH] input: keyboard: snvs_pwrkey: Add key-release-only
Date:   Mon,  7 Mar 2022 11:24:42 -0300
Message-Id: <20220307142442.28206-1-alifer.m@variscite.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CP3P284CA0064.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:6e::9) To AM9PR08MB6999.eurprd08.prod.outlook.com
 (2603:10a6:20b:41a::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1455f8a-ddc6-4953-85c8-08da004643e5
X-MS-TrafficTypeDiagnostic: AM9PR08MB6065:EE_
X-Microsoft-Antispam-PRVS: <AM9PR08MB60652879D077CC73AFE1879887089@AM9PR08MB6065.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: smM6/6Y1jxsEKPTvML9Z10f7HtA9Hpi0xsV2dxoQOodVTr6ff7Ze3WWcJhM0ZK7qCjXE9/3iCDh8Wj9PKOhmeEK4Te69wW5UCcjawKaqUmV85FaxlzHDdKCT4uB4ldziyT+QjVO99jWXuu8V2oH/lFxZveoiFpJi33STE7IYdBJmNpYT/JHCtC3USKGU0Gx4ct2VuP6gjj7xRQKTIf5ZjvtXoj6+eC0ybmglWnSmE2pJG5unJPrVBnA1Qwe8x8a8KIqJ74Vt490OS72zXYa5ioG0MKIZpexlNpu6+IV/qmLloZ0DpjdE/U+RKr9UE93AbbnAPsDtW4AU3ExGgwYw6flV0jTUaKAr4dIYejei2nw8qXRhN8LUgWvChLTz7Ky365ZY6vw2FTQ1IRgDKpG7IJKfHMzqzRPA9TbzO6z2wyAyMjnpiND+lu0FjPwZYFLybTBvikVyksVcmNL87ujXlntZoF7VTDd4So6pEK0TEwrpFUnNcSDubFCR/T5LlHzza1Kgd6+cK2Qop65IO1VAgmTujo8Ctj5AULnNHvbyn8clynkZe0fapTr0tU9T/RflGu196qElodFIinSaIg6Ntd4bcsD5OwvxLtk5o/O6qnhIE01GuU6hashSI/pqP635xh0O6vzmNXd3qqa/2+sALeUhnB8Y/qUemcCVP0yXqkrV8HRsYtuKPoZqj0nBv0MlDcfNKylvmMWFrVGpI2tAKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6999.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(39840400004)(136003)(346002)(366004)(376002)(396003)(6506007)(316002)(66476007)(8676002)(66556008)(66946007)(4326008)(107886003)(5660300002)(7416002)(1076003)(2906002)(2616005)(26005)(186003)(6512007)(52116002)(83380400001)(8936002)(6666004)(86362001)(38100700002)(38350700002)(508600001)(36756003)(6486002)(54906003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n6z0C2nfG0Yub2BOKuxh8zsETglXjVNTaU6a83r+XzriMJwS7RmSyjvSWHh2?=
 =?us-ascii?Q?FD6nM9M/Uge6TmBZT4Tl4GqOnXhAgl9I8ddjCG5/fRIxxYpY/MF3fgQv/nk9?=
 =?us-ascii?Q?lpOcPFPesIDTspTzhCGyhh27yCEY6HVsQcTnXGyL/87BUTqV8p5n6zUfBfPv?=
 =?us-ascii?Q?xXaUSxEEmyqR+SjGCuC86yexd2NfADi3mxdMCJu5RiV8npLx3WuLr/pOTMTK?=
 =?us-ascii?Q?qEXBFaLr0tOL6oXWiXFuj+fzujmGVyTZmySptS9HLnd2HpEE8TK84t1vvK3T?=
 =?us-ascii?Q?9W0ggcdmE+WI2M3wzJ9fpAJjT5UzCDWGU5vLKsmwGoc34D5A5hgA1HshOBNY?=
 =?us-ascii?Q?dRi1+oouuGJ+Vk5mDrPmJier/NlAILCXRtvs3OHZNAbqf2Pu2EatgT2xELoX?=
 =?us-ascii?Q?7glhrAzaVC+H9dXxYqyfZlaB21R54wTea87p9oj3apMc2m22tR7fPs8FnWCf?=
 =?us-ascii?Q?lbMLKi34/e9MPqdWZH1xOZvhEsDe9EyPUuR51/+2zkhIlTLfEoKLO7ncIXpH?=
 =?us-ascii?Q?4PyhSO3qsxB2bswETibjsGQ1DELXnbLUQNBluih4aiD8GjpenPXEX4lpxygo?=
 =?us-ascii?Q?fmrUUy0Pxj9LMf9ikOW4fTDU+DSb3HIQ6yuA8+sND6kIH2Eq2bHgvGbl3OyR?=
 =?us-ascii?Q?BLoX34IfQeppe9l6w9BlCoHBFXLhd7cfc2ExWVNp3DYrGppxhEzPThHk/cRQ?=
 =?us-ascii?Q?6QyqoiZIHpkEW61oAltVfXjeRlihW7mgaBj1o2AuXs2+NuXgI61Ra5CygvOx?=
 =?us-ascii?Q?M4OXVfg9Kpw09B32d1za5JfuSr6qRDXVieJnU7zCB71MV3zqeP6lkfZM67XK?=
 =?us-ascii?Q?JWQx2HbE/RWTgJn3sCdr3sRSzKLAme+d6D1Hai7hGJxnf/4ev7hDpt0jdXjv?=
 =?us-ascii?Q?xam/aknkvN1cxp64hHYlfjGtCCMzi5xf31w8c6Sxg39OJd7XBjrb8NTy8dAz?=
 =?us-ascii?Q?+TP5ONzGR5cRICem3TDBS6jII8n0luKfNFFRRn4HdVp5mci8scpJ/lY3K2GD?=
 =?us-ascii?Q?yE+4Z7nuZqx8cxYsWalZPIlaEggLXqW7aIXrbjqMe2MPGDQv3EkUn4c5pEZ1?=
 =?us-ascii?Q?ZQWOJHoTj9bUg8iOlJC8GElLSDJyk9f4nvxgLX36bFNrWPjt4msNMbCfbYXK?=
 =?us-ascii?Q?zPpFrvxlc7IycYs8cZPiec+Wqnt/kMRajYoqrdZFrR1rgniSZ7EbZUq8FHeu?=
 =?us-ascii?Q?RUquym9WkFMTcIY8lleRqbTpzCzzTp7NeXFaHm/TtD/ieEWRrEMe+AkkzaWJ?=
 =?us-ascii?Q?aoaoiaU7sH4yLwtS/vJQ6qvIROdCIYyFqfVqqJHXmx3FVEiZ/PwgnhsLB4xP?=
 =?us-ascii?Q?ZdJ2zngYgvJx0mE81JHeUuZsyBvWFfVtclx/0jgj8c4Dao+1jsLryZPwgnB7?=
 =?us-ascii?Q?Px5ZgbU952nkjZE4IMdQzyFp/N2ntqEn3BVMi+FfV7EX3socurEHwyfyCqtC?=
 =?us-ascii?Q?zfbUpS1OHuG0rTJBvXxu+hRmow2GhL0ubgKoZ/WZN3s+/4xNUDW0+oI8DbYx?=
 =?us-ascii?Q?wfvoF0Lb6UM2hvOSz2eBe4iPdACWJAXHakT9BBeWrNMp2hqq4bEGp6ejcpUo?=
 =?us-ascii?Q?lIKEK9XjqgF3qSlqPGDUFyYXl22luxymniZFwZewXVjJTBMu6Tr4nPdbLnKA?=
 =?us-ascii?Q?hUEKHPptfobJDwKjFosirbo=3D?=
X-OriginatorOrg: variscite.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1455f8a-ddc6-4953-85c8-08da004643e5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6999.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 14:25:01.4266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 399ae6ac-38f4-4ef0-94a8-440b0ad581de
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cRuEbOC/3UDulbzQnUfSKL/Od9OA4B+Byh5kLYpPo5p5RxrMWRujgMBzQjEqddXb6/ZYd6mzGUFkDBXJz7ayBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6065
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eran Matityahu <eran.m@variscite.com>

On imx6qdl the interrupt only triggers on the release of the key.
Normally, the driver is looking for a change in the state of the key,
but since the interrupt triggers on release the key value is always 0,
so there was no event.

Add "key-release-only" boolean dts property to address this issue,
and create both key press and key release events when the key
is actually released.

Signed-off-by: Eran Matityahu <eran.m@variscite.com>
Signed-off-by: mcontenti <marco.c@variscite.com>
Signed-off-by: Alifer Moraes <alifer.m@variscite.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi       |  1 +
 drivers/input/keyboard/snvs_pwrkey.c | 21 ++++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index d27beb47f9a3..9811e6bfd8e5 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -845,6 +845,7 @@ snvs_pwrkey: snvs-powerkey {
 					regmap = <&snvs>;
 					interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 					linux,keycode = <KEY_POWER>;
+					key-release-only;
 					wakeup-source;
 					status = "disabled";
 				};
diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
index 65286762b02a..b558e6f898fa 100644
--- a/drivers/input/keyboard/snvs_pwrkey.c
+++ b/drivers/input/keyboard/snvs_pwrkey.c
@@ -66,6 +66,22 @@ static void imx_imx_snvs_check_for_events(struct timer_list *t)
 	}
 }
 
+static void imx_imx_snvs_check_for_release_events(struct timer_list *t)
+{
+	struct pwrkey_drv_data *pdata = from_timer(pdata, t, check_timer);
+	struct input_dev *input = pdata->input;
+	u32 state;
+
+	/* interrupt only reports release of key so do not wait for state change */
+	state = 1;
+	input_event(input, EV_KEY, pdata->keycode, state);
+	input_sync(input);
+
+	state = 0;
+	input_event(input, EV_KEY, pdata->keycode, state);
+	input_sync(input);
+}
+
 static irqreturn_t imx_snvs_pwrkey_interrupt(int irq, void *dev_id)
 {
 	struct platform_device *pdev = dev_id;
@@ -177,7 +193,10 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 	/* clear the unexpected interrupt before driver ready */
 	regmap_write(pdata->snvs, SNVS_LPSR_REG, SNVS_LPSR_SPO);
 
-	timer_setup(&pdata->check_timer, imx_imx_snvs_check_for_events, 0);
+	if (of_property_read_bool(np, "key-release-only"))
+		timer_setup(&pdata->check_timer, imx_imx_snvs_check_for_release_events, 0);
+	else
+		timer_setup(&pdata->check_timer, imx_imx_snvs_check_for_events, 0);
 
 	input = devm_input_allocate_device(&pdev->dev);
 	if (!input) {
-- 
2.25.1

