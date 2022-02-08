Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7915A4ADBDE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243130AbiBHPAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379124AbiBHO7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 09:59:47 -0500
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30042.outbound.protection.outlook.com [40.107.3.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C28C061577
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 06:59:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=foGVUmmSDbgAp8bOkccqNb3mzIX1opRbXJIOO2lAGaypBc1IE269UhlvbRPm11JjNQtuxD+WtDM0yV+za8x1/Kzzbk1/mxwpEiS+wZPFc/aD6NpYvlaiVjIj1MLlhkm9D+aCj4FrgHt9yqYZh7vdibQjeMOkV/jarAA8xHpI/ZMj4Wk52LGQXo/nVe7D5P5NRpRIrRSPuoAZJbe9DBYZF/5lHmfd8xrRAUU7KplHj1Me5I1NH4cn02bV+7Rl5OAwNLIwDLyqf/BPnkLWhpoZbM3cO8Qg3l7Ua+DubA9rC5gcSDZrUPgF1sTJj5pX/OUZc2NBufTYXDphvhAA2qzG+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWxulmt5pKpIYfZj8l1bKz1fd617C0peC5yCF3jz4VY=;
 b=cKu49UAJKVduXjRoh9vyDjVeCBNiBOZbyEflohHMgBKmue9Uau+v4TbnENXx67UiKja1p8Ofrd/PWwRNXWZWDySVIIDhn57OD+EJsoOtX6DZMusXaa/5cTUxa5Dn48keesNo8oAhIOOw5TGZ1W1enl0izuYiruBxytfaj1VZR8IR5ifo8SzKcDE29yQKN6q1wovq5F6QK9lHszE+E4JZlX8ZGwNIuL1pWeDGzoepXG5nreOmE1s58fO69R5Bgz1dS8tcQcCjUFOJVfOp7yrPCiqH6L8I/JY5tezsYGr3t2CBudf4rdpnqhldG3T/rjn4osMuLqQM/Zeee+HQ8ILexw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWxulmt5pKpIYfZj8l1bKz1fd617C0peC5yCF3jz4VY=;
 b=FnRy0GEQQfy8quL+vK3xj/o3klycUdg3I0H2d0O5bdUaju9zhGgRajWQl06MV1WfVmhOi8uHgh/FNzYJGusiq6LVtLtDTDzGtbvuZ919HfPJyE+i3xOpFJCAs0vKe4FA6qJwjig2OYNq9dnjhQHJv4U2wuxG2QlWW3Etxqw8QoY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by HE1PR04MB3018.eurprd04.prod.outlook.com (2603:10a6:7:1f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Tue, 8 Feb
 2022 14:59:44 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f826:3bf6:b77d:5a53]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f826:3bf6:b77d:5a53%7]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 14:59:44 +0000
From:   laurentiu.tudor@nxp.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     ioana.ciornei@nxp.com, diana.craciun@oss.nxp.com,
        jon@solid-run.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 6/6] bus: fsl-mc: add .shutdown() op for DPRC driver
Date:   Tue,  8 Feb 2022 16:59:28 +0200
Message-Id: <20220208145928.12468-7-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220208145928.12468-1-laurentiu.tudor@nxp.com>
References: <20220208145928.12468-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR08CA0025.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::38) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63b4a48b-8a9b-443e-8fef-08d9eb13a41b
X-MS-TrafficTypeDiagnostic: HE1PR04MB3018:EE_
X-Microsoft-Antispam-PRVS: <HE1PR04MB301861F9BE93FF91CF22F52DEC2D9@HE1PR04MB3018.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7p9FBeJabpVRIQJslyEuag/K1QPdQp8jHkZu2vUVPAXkWxOIXvuRoabrDE4ZGpe3GIgAkgiNj87M5Fp/qkXysXwkp5RwGxF3+hwsqaxIu9rz/RneR3dg6xTH63LsE618jk4hQmTmQUlL++6iFtzC+4s1mKW7EXojx/HaDEQn4vnDwO26sydlvcsoN9PzBAsxXHWb0dMutS7ekwPGVrpkpcNJD/i9TczePdx8a7AS32JGk9fRxWzy4I9KM38HplovgbY+JvmQKgBLVKeY6ivI7ysufFpupIh/A6M+3+Ft8J5SMMG/MJTZykpBGWZ5pVbWlUPNpGDlAE61i/icOkKaS6qck3euQFLTCJn/qWZVDC30dkukzdWc8Ihi09xY4SjqU43kdAl2o3RlB8ORZ6/vIBg+Mf4oUesaMQXovGcN/cfUliLI+EAJybusyU1JV4vnOdz09UYS+LNurnYCofVa5fX4MgwLoedEW64fBz4yDEoI0tuHKMPNd84Zxo99h4BoWGFkZIRN+BtmyhtsJq4SgpPjYGVo4bs3+KPArQpl0Ikj5duj5o/mHDmRPtFafcFES6RqWSYIMv8spWe8Wm0lGfqnlZkGGgz9O/vYxMh9CqlzIB4A8bopIrQodDym/pnQcV9e04CaYecO954G779JDwTzO25bMBCE01EYTtFhO/+tv+4GJEjCUTTDsKr8B8589TFujh0xcLWAlurKLyZPo4I00puHjt3yR8zTPwE30Ms=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(6666004)(66476007)(316002)(9686003)(66556008)(508600001)(52116002)(186003)(6506007)(2906002)(6512007)(1076003)(26005)(5660300002)(6486002)(8676002)(66946007)(4326008)(86362001)(36756003)(83380400001)(8936002)(38350700002)(38100700002)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D7V2S6EemvJLobL8U24ZPeRpXVeEykQrUbzUQa71Axm0iDXAyjolR8ffglcd?=
 =?us-ascii?Q?/ck27xADVKHV3Yb5vyTW1qj1TgOW//Mypw/e4BOiwxv1rDlYbdb/EkK/If9y?=
 =?us-ascii?Q?q2auAb5HZ5mNfzeOJ5J+Od0Al5hGeCoX2uAu9DXc55pwBKs/1mG+n6o0xXY0?=
 =?us-ascii?Q?vBBIgzqZazsXIQKeaMKXCmsFctrm87eb9yQGVFAJqWQECBOZCzAc28x2yDIr?=
 =?us-ascii?Q?ux1gpLv5u+o7TOrGzgAQRvhpfdx/DqMqMxl1eIsrI+wsjLtTEdcrtb1yqf3W?=
 =?us-ascii?Q?g9QPLhnCOaFRpJatY3uMGUDYQMl6F6nSPNULGF0FOKF4dwJaIjK/Dtkl3V4m?=
 =?us-ascii?Q?eVeKOprzzIFHqcI6VFUL539XIAtPrDv/U8mNDqbCgfChDJnDeB6j+HjocEAo?=
 =?us-ascii?Q?Dfh3XfvZsly9swr8T/pU/yoYl3GonkVyTRg1nYPBmGeuCERS7o+l+WTreVxE?=
 =?us-ascii?Q?tIfQK+emMqyRr+rq1MoYmDkvbvHDbNn1gxSXk++yt3wEDuNEcGVxDAXjdfhG?=
 =?us-ascii?Q?UFKiJbOE4JMEAEvAbkTOC2QaICFWMYCN25or0nJ5Y8c6gMOI0X/k74BlgM2d?=
 =?us-ascii?Q?OVFMPnAlM4VQ4w0CKL8cbTsJLHQH4Og3ysnj2/TOj3CJ/5w5Qq+TvkQFmS1c?=
 =?us-ascii?Q?Z74h3NomaOL8vcdxLVNuPfwHHp1QoI4z92WdBHaRcoPYN7YACynse4iSRXsw?=
 =?us-ascii?Q?onBmO3g9O8NWc8AmxItqGwQJKn8Z7umM3q2S40RuxggggHzNntqLA4ez6CLJ?=
 =?us-ascii?Q?o3TEgNwfpnSaaUFdWjrFE4BMUND0AauzsSaEeyd25gKOwMsc7p3Hor3wu7fG?=
 =?us-ascii?Q?FjBZhYg5Drq3Li2DxIMONQ4aeAnbxHqbhJ6V0hUHPp3NI82SgfyWslPdVpJE?=
 =?us-ascii?Q?RKntupfzkk7uT/yNlaWozGXLAEwiMhEdGmJXmPbafcXEW8PYc7+2naVEoRBn?=
 =?us-ascii?Q?nyM8sNyJAGBI76l15K+yXDUFlgkU8pElXx9qKxIM9bILJnf4aEMrX6VbhSD4?=
 =?us-ascii?Q?zoBzAsR8hEga8KfcYYg12mNfJN38GHcKJvFI+RVq+sWftfe/jge2HC4GaiUR?=
 =?us-ascii?Q?VGJwPyLyvf+VOP0fRz3t/Oyu/NhDA+erZdx8NDhJCrAeITgfeTdEspKy0OdG?=
 =?us-ascii?Q?GOf03LwYVAWsTabwkzx3a1T3kfWkHh2V9YkajxZ23Jq7uBTJTvG3E3adsa5d?=
 =?us-ascii?Q?3CF3RZ3k0hTnScWjp9LZbzD20jEmeg14N6gOrMmdL6nYiWMd9dcC5s9i0zOl?=
 =?us-ascii?Q?g2fYsMwNX41ZGA98teW6PnvtPdEOA45oJkiMO2ffk5LMxdTKRmzYD0W6JErV?=
 =?us-ascii?Q?GsfawgFkkRXM7YksWF0D7knyfx3p5g+RyrEvnYRa8kEzfpigLOlEuLuRtH1s?=
 =?us-ascii?Q?iHeQAeeSHyQJJXj2/IX9zm4xIUZ9qndijOKvXitZF+Zy+5lOnGjiBapkzQON?=
 =?us-ascii?Q?2MjaeYXmj9v7AD8RmkdLL9w+onchkSYFroUepG0mtbW/gIZElNM/Qvt9m5+f?=
 =?us-ascii?Q?Tw6zDYKlSlt0EeVv8BkAulNaKXc2bXXBTsx+MLJJxSxdhQcoUpmPyvVtDmLf?=
 =?us-ascii?Q?+mNlk+srt4MiP/IjGm55KMlIrD7WEmVNLx68DZjfHsD5/qYR0TeEltvmXzBc?=
 =?us-ascii?Q?MQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b4a48b-8a9b-443e-8fef-08d9eb13a41b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 14:59:44.1530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ueabyqt34p5Suf3eGPHZRC5NiivLa11BA6uULrV88a/Al7JIDgEE3cRIOQ+oD449j+pf6H8cZg6fbNKxqhO95Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3018
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

In order for kexec scenarios to work, implement a .shutdown() op for
the DPRC driver.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/dprc-driver.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index 82bf3fe09273..405cd054c2ea 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -861,6 +861,30 @@ static int dprc_remove(struct fsl_mc_device *mc_dev)
 	return 0;
 }
 
+/**
+ * dprc_shutdown - callback invoked when a DPRC should be quiesced
+ *
+ * @mc_dev: Pointer to fsl-mc device representing the DPRC
+ *
+ * Closes the DPRC device in the MC.
+ * It tears down the interrupts that were configured for the DPRC device.
+ * It destroys the interrupt pool associated with this MC bus.
+ */
+static void dprc_shutdown(struct fsl_mc_device *mc_dev)
+{
+	struct fsl_mc_bus *mc_bus = to_fsl_mc_bus(mc_dev);
+
+	if (!is_fsl_mc_bus_dprc(mc_dev))
+		return;
+
+	if (!mc_bus->irq_resources)
+		return;
+
+	dprc_cleanup(mc_dev);
+
+	dev_info(&mc_dev->dev, "DPRC device shutdown");
+}
+
 static const struct fsl_mc_device_id match_id_table[] = {
 	{
 	 .vendor = FSL_MC_VENDOR_FREESCALE,
@@ -877,6 +901,7 @@ static struct fsl_mc_driver dprc_driver = {
 	.match_id_table = match_id_table,
 	.probe = dprc_probe,
 	.remove = dprc_remove,
+	.shutdown = dprc_shutdown,
 };
 
 int __init dprc_driver_init(void)
-- 
2.17.1

