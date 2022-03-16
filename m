Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590584DA76E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 02:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352982AbiCPBnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 21:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343571AbiCPBnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 21:43:19 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2134.outbound.protection.outlook.com [40.107.117.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C795E14F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 18:42:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdPwBNSri0t/Lp7w7VWnZT34ut6Bhyp9KjxF0wrOoHTGMMZ9UI1EPKJMVAGM1QRtIFWlf4be9bVXs4Zuv0PL7+B6pvTOImmhiwP5w/vEtSvbNBe/P+zk2j13zYzEHH+sR/EZ74VM06yTPo1XgccjL+dygNC2/SECd34hHQ0jtdpyyqGpIygLLYzkVgqmf+MKOzuAWb9YEEYXyW/EZ17JeJRCVJr6Z+mFTHOEVqd7YTb8/ldW6vRmqSVJISyzXwudd5sQcJSE9cnwqrfYxaf8eGJwIVCmuwWyoGee+nDcMUNQyv0E3H+IqeRD3Wf3yI80nA9Fd/WlimiJlO/XHAGPSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H75yqMpuJTh4ATudWE8XiZZwRTEUcDlBamOZGP9qtMo=;
 b=E691N6QbCjOG65Z5oWP2zVfNAM0dukRiY+MprwrKnSMALWNR6EAoH70BsXC2VRXpOvW6tate8pu4Kdg5BXI9BnNAHY2fhW2irklWEnaf8Wxgy20WfKEDDYxWx93pKqmevlitpnbrfIUR1a7tDM4FvQkzQr/DviOhvGwHu19QblhF7yL7Pc3ylcJUEb7kSLJc3YZEShuFW+5fIzrl2CVOULBKUQkidrTnt2P6OKroXhHxqUZN+GLOgRAvFDrEywkY5Tm0Vxi1xcYKtJq6TG7bxQFS0bFkky2y9k7+O7SH0mtT6fheSVq00L4O6dgRB+56gqNWIlj3kOdkDDeRlQAQ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H75yqMpuJTh4ATudWE8XiZZwRTEUcDlBamOZGP9qtMo=;
 b=QT13iZT0HJWVGXqrz0eBXmBq6I0l7zsggxjlO39Nvu44TXthYuOzaZsr5fdQLCV0ZBFtGXJaP5uCKe/lyz8Me0rmZTT++JKR1ekpkP2ZR9RjxDLO62CjnZvoTrE/+tT0SpKbH9HyREh/bDOwrmjfKbD4D8wA+qGCkEvRnlryCIg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 KL1PR0601MB4131.apcprd06.prod.outlook.com (2603:1096:820:37::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 01:42:00 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732%4]) with mapi id 15.20.5061.028; Wed, 16 Mar 2022
 01:41:59 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kael_w@qq.com, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] mailbox: imx: Fix duplicate field initialization in imx
Date:   Wed, 16 Mar 2022 09:41:28 +0800
Message-Id: <20220316014128.89315-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0155.apcprd04.prod.outlook.com (2603:1096:4::17)
 To SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 589c9f09-9ca4-443b-b4dd-08da06ee28c5
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4131:EE_
X-Microsoft-Antispam-PRVS: <KL1PR0601MB4131BDD2ED877C4A2110E285AB119@KL1PR0601MB4131.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PLumlsBYArbkCPRedMFz76cNPOqcOJ2Ya41wjelQNK3iCDqY5A1zYx2djcVIDG5Ia0+Em/HUYhADoDLNHSzQebVgGhl0DePUzdaNaufIexLfDYQa4dweSq4Ti0g2Z3VecmqMNHfGkjp9dau4uEf0xoXRM2iZK7SA8+G6PSrF/uJGgFj+G+CI6DW5e8t/Ge1zSu3sS261LNUqRll/qPps3k+167wqy0YoGrGMb4C5pltGOnhbXw6NeUBYWa3EiX6ajW71K38fz4O8jX6bKVEQKkOpgcL1S6ssJA2H1Wtjnny7t/kS9q7YoWrQbSPy6I6h1+74jGSOQb7zN0givR9uVfseQWFzUUQrz3tMg3wrYZM2yfFhdlYinh/+loA7m4KCZI8gvjQsN4fXw6ZRzt37UuxFGTg9oTdEAWSFfHUxy+vQ8EyUfq3dhls6tOLfUmw+wXVh/Fj3+euBATmJbMxNB0AS3D11S7XYs3788uJJo/Hw+ZaUaxdHTsGSTbBk+5/sz2RUuGfLr1SXfDnfJLxPEe+S8pyYkwfvvv171zOTKRMjcxpRJyhusBY1DYzb7DEAKvnu0NJoxsJ2n1qjCQrMjEybRY75dppeyyXj/nzEEi9gM42EunMIuAzgxDgwSZ0KaaNcWbwYft4I+jtSDd3lf3SdgUVJNemIdm2TVEOhrGhiMq3M1ROCzcFdNXaEVIsBzto4tOOJCNQ503as+uUtQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(186003)(1076003)(2616005)(107886003)(110136005)(86362001)(316002)(508600001)(52116002)(6666004)(36756003)(6506007)(6512007)(4744005)(15650500001)(7416002)(8936002)(2906002)(5660300002)(83380400001)(38350700002)(38100700002)(4326008)(8676002)(66556008)(66476007)(66946007)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wtoWHUvcChLFxbcP10ICPXAJ8OAeSR8VqJZQkIaH4LaIiFh1bQVpxY1EYJHA?=
 =?us-ascii?Q?qooMxwwruIr2K186B6sINKWLD4boCYOpb3L2+WHMmSFhJwmPyqvLQR/pAbdp?=
 =?us-ascii?Q?7ke/G8gX4TYAHIXf/5g5usiX0E7LZF4za/hN+HqHn++MuckdOEZqFVNILf4t?=
 =?us-ascii?Q?qvlaU3gtHPtpRFoV1WZLgdHVEzzZJeWctd34A+9sT4lWuVhmL0YaQOStve9F?=
 =?us-ascii?Q?h7h689i9Adt75fmXZdsSfCRnk2jb38hlb9PkIuRqifOFjpsoM7d2AEJS0dND?=
 =?us-ascii?Q?cVgjHM6m6PQGummvLnsFyQHbSugtQ8n3jwPmgyWtCW2+frudK5NotTaKwN2S?=
 =?us-ascii?Q?LDR+9BhkdOi/HpnPt2WaTbY1buV47RLK/k525JI0G+TpoYIMDAlGYFT9zcVv?=
 =?us-ascii?Q?jr7YUP/AsMGiVDxFh9XNsZipMWyHNYjigOFeQEAO+SVDNopppDUdtsnd1Ign?=
 =?us-ascii?Q?3uZOSFZoNUhfOlXuV4+6b3YhOnsQZVYrldTsemWfiOqGqbP8srff1SWeS67P?=
 =?us-ascii?Q?8hyssQ+wHNPmuS5gskpyDx/r/OKbUcxFQbK7PGlZqhPg3zcwulmvT1zYCc2v?=
 =?us-ascii?Q?Vz1aRKvTJA1czfPKuZfB9vbwNWogqb+hzFHwgpkVK6dPhhk8YILb+AD8oq8n?=
 =?us-ascii?Q?HxoofBolRC8IoJ1zsEHAWK/leIIIGa57cAZcfV4zSUu4PiGf1IalGpPP2cfg?=
 =?us-ascii?Q?4TN0IP8U5bAGTwmgBk+xT5uJZr5O2VTtWK+4W4C/oWB3eJp3q6UHXJ7ei+pJ?=
 =?us-ascii?Q?IDcXmyVMj5V18MIJIS3I3rMIy086UJ4U7bNb13gXa9gkMqOZVTtCEsPjKi6n?=
 =?us-ascii?Q?q6Zz4TxvjUCQHtsVopyh1F+aZl+39e5XRNzZgkpB9IFYynS2SyoKwDw6jfqi?=
 =?us-ascii?Q?XsrGxtbjad25gftdTyB1rkdtuqzrEfN/s8CPsylJQx/5ShTjedrjQy+KLCED?=
 =?us-ascii?Q?wN2GDbuueyJ+kGpAvQ24qfOZrYtPkFmPhqmdeG7wAt8yxCh0jmk1tXxn5UO4?=
 =?us-ascii?Q?d52HcC3Big7tAcbN12wNoqvwJ/RWtO28/y7KEidHVKhhK2Y6jaxYpV1CSCNn?=
 =?us-ascii?Q?+o16Hbn4SXDXlTZWoP2vtCZBCwrkjnYt0ICAKt7HTY6Se1A4atC2P0sG0Rz+?=
 =?us-ascii?Q?y8e3M0iXKVLdUyuwKOJJaRnAEIxGlG1tkTPMHajVEhBrqYy2S8ckh6jvDb9g?=
 =?us-ascii?Q?kollvi073ivUOVGvsS3hB7Ga6Wu0BI7XhstZ1F+FFLOCufgA3JzHIn6LwWlR?=
 =?us-ascii?Q?C3udhcyphQJHDa3CmgCuAF5lA0+GDk3JDYv7CD3kNKe+dQmb4He/RT2gZC7x?=
 =?us-ascii?Q?Uej6MzEnlgXzQT3gd65nNn+/4ekthizBgpSXlBkXCkP+EZgfCF4oYBFmVTcq?=
 =?us-ascii?Q?3JepLh0m0szAg3IlpqQHqtmRxJO3n0SgRqEQGeZ+bVX0bbPPy6566OxZJZkU?=
 =?us-ascii?Q?JWcbusQkzLHjNoOmyVcbI7IPxnzUp91p?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 589c9f09-9ca4-443b-b4dd-08da06ee28c5
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 01:41:58.6593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5BZ3F7J/O/0+CdRLZp5aUw/wvdcPKLG2X/9vGSqIJhSddfl6kJBdFVL3o3kg1C03sAMMKDyNDUwvwcbHrUXD4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4131
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:
./drivers/mailbox/imx-mailbox.c:884:51-52: rxdb: first occurrence line
887, second occurrence line 889

Fixes: 315d2e562418 ("mailbox: imx: introduce rxdb callback")
Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/mailbox/imx-mailbox.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index e88f544a1548..df8a785be324 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -886,7 +886,6 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp = {
 	.rx	= imx_mu_generic_rx,
 	.rxdb	= imx_mu_generic_rxdb,
 	.init	= imx_mu_init_generic,
-	.rxdb	= imx_mu_generic_rxdb,
 	.type	= IMX_MU_V2,
 	.xTR	= 0x200,
 	.xRR	= 0x280,
-- 
2.35.1

