Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18F847FACD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 08:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235557AbhL0Hti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 02:49:38 -0500
Received: from mail-eopbgr40076.outbound.protection.outlook.com ([40.107.4.76]:15936
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235549AbhL0Htb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 02:49:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1AcN4SBHgQ1yHO3gfrImedY3/UJLP8wDGC5hI5n1QoMHyjXZMjTA2PzvUCLnpr4MtsOsw7Qo55+rtNfhi5XU7nSA0ONsbrWfwiw9gHlVL9igNKQEobqqeCQlEnBzghnOMlgX0uY1Pa0h/IVkonfvx0xXWe0Sdjbzrf6DU0L+mxM8x3tfz3WzAujqmIAO6zvvQr9P0jaSm/M/INq4hHWK8swtNTkVIZjRGzdq5klncrb1g31/u8yZHafygVSOt2XoX5agyyzjH5KMgX4T838Kb6kQR6lkBUNEYjOCj8Yb5UOsXxEI2yx/OtIhzoaUIl39MX4tP9AdfGKLYtOADUdkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrla7n5i7KUZGtYAELn/2sYg1nmTTmWaoDIY8GDqCE8=;
 b=EjRk1qAsOpFSzDTvv3x58gfkRc4UXetvjxSG7chLVOxj98uC1/+t92lD6hvuJbm/fZ7mS6sOaYbyedzdoRf7vbp6qpwCFt+UMNXE3sXg3lYjdWTMqnbm6ZBzCIqtM26z+qrYpEr6R07+LRSAOKPMsDRqWop725IMgzlwM8C/+a7htY0DDYn3/nymbdX9qzE2JIfkz9RuiIQtB1HNF4zSu/Bo3D3QxpdTobbDvLUUVQ3cMR4Q/tmfNr9bCbeqT4qV4UCwKFcfmInfqAd0rsZ76VTgZdBC99wjGYPfNQLCMVChvBDfhAksuOheXFNoVuKUjxp1trn06utIuTfuNhJP2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrla7n5i7KUZGtYAELn/2sYg1nmTTmWaoDIY8GDqCE8=;
 b=iv4jIGqKMrNPhmtnmaFf8LMEGSAgdtcgZStmLF9OGzOVBf3zmAMo/9uU2kUjjaXCFpy0AjOTs07/zkWWHgQZ0c5UWfxovFx63GJqOe8QCqDaranvyxtswaZAHsoOjpj2yi1w31/pDp8COR1fjGovMpqCrWvUbqOBhpgBeu2oU7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5631.eurprd04.prod.outlook.com (2603:10a6:803:dd::27)
 by VI1PR04MB5629.eurprd04.prod.outlook.com (2603:10a6:803:de::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Mon, 27 Dec
 2021 07:49:28 +0000
Received: from VI1PR04MB5631.eurprd04.prod.outlook.com
 ([fe80::90fe:b60a:94b5:c748]) by VI1PR04MB5631.eurprd04.prod.outlook.com
 ([fe80::90fe:b60a:94b5:c748%5]) with mapi id 15.20.4823.022; Mon, 27 Dec 2021
 07:49:28 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     conor.culhane@silvaco.com, alexandre.belloni@bootlin.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 5/8] i3c: master: svc: set ODSTOP to let I2C device see the STOP signal
Date:   Mon, 27 Dec 2021 15:45:26 +0800
Message-Id: <20211227074529.1660398-6-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211227074529.1660398-1-xiaoning.wang@nxp.com>
References: <20211227074529.1660398-1-xiaoning.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0132.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::36) To VI1PR04MB5631.eurprd04.prod.outlook.com
 (2603:10a6:803:dd::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5dc0b8b0-7324-41e9-7a2f-08d9c90d68ce
X-MS-TrafficTypeDiagnostic: VI1PR04MB5629:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB5629AF946594258A0B35C911F3429@VI1PR04MB5629.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gs3gq53PwEeziYfkPTHDySK8cESJ51iqg82/N5FFJhDnbdzfDPUiRDjsostjrjvKrWsY553sIr19KAQ8u8QkfclvGnspmGLGCWg/hf7vMrjNNXcD4YZA/b7onzIVVRmPA6QQaW4BjxVX/EQYyD4oJYAIlimU2F40sGOKQu8/d2ZuhoNiWeVIQ/puBgcvoY/UbhtH/a5GJeMnexLSLu3tdpp2cyOlZS3Clq3hiSSWe1+Olo5a7Wt2vvSoV7R8IjUlkgNi2W9/tYn3dwahiaAmpSjoMfIcGbjFXp2GnWHlBORsoCxSsujPd2GGNtwzU5Dsi4xUfqWoU0algCu/KfCZKzf6kzqYun9MHxO6gNQozj7W+wc+m28PoznM4FQ8Ts+xftTmp+zdla7/N48X5Nu/euHikyuzhRarYOpMH5bh4Kl7DPYtapEyN+AFnMzySY5/x8ri4qxINPxGK4O+Q8uOBOZpv57LhtbsV4pdHG/6eDGMrFRpDawiAPdiVZjET9g3VC6eThoVi8vVGHQ2q2swdsTVg6j1K/73LP59bH5kGPsxxhgpl+Hy3KHZc4Z75SWD8XAUN7EraWfKl6R4EY/eu6+uapFahopQb0Or3in8ZuUmnW6xHQLd8ga9S4pa9wrRq5JnCxdtiqwhSiRCa2+klzxtKG/YRCLOFywXiOAUtnLwfeZTN3bTpTKpohZGWj1FBYmu8RffZs7ptDI2yZoI6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5631.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(26005)(2906002)(6916009)(83380400001)(86362001)(36756003)(66556008)(6486002)(66476007)(66946007)(8936002)(52116002)(4326008)(38350700002)(38100700002)(2616005)(186003)(508600001)(8676002)(6512007)(1076003)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TWZjbsSdNoNNh3ZMEJCLv7bHfoFOyqZPuLRBPtU0LUb1iyqUqy5bfoKR3Chz?=
 =?us-ascii?Q?JCiFbDfNk1EhF+G99ujwm3PYIZgI52Gx4gwvRqK+IhQwozgS9KBTChL2MtEv?=
 =?us-ascii?Q?bTCOV+zSicGw92+C0SBXI6L5MW98e/Dc9rIEs2X7IgTbSpxKzXAwG1ur/HdV?=
 =?us-ascii?Q?ZLo7TaWUyxA1ISqrLG0aTTWkztIha1/GEO/k0jpc/gLtU6F4mya62366W+gs?=
 =?us-ascii?Q?j/F6hJnngAMw7SpVFaFyahlsmfYIo+eHCGzCD9p6tYjFlDi0JA0SwHvgy12K?=
 =?us-ascii?Q?coIqzhDe5ZLEuNpmfgcC5kTcUljixpX+2KXUhC7AOtWXnxkufvt9c3EVpG8P?=
 =?us-ascii?Q?dwWdegtbLFFHWbqu0xl5av/DP4Q1EQO91QCxkp0bhLUvYPkCJiLG3nuT0agV?=
 =?us-ascii?Q?/L7gl/1BCEwRtDLJx9/iVhHiIBN3jHAxdDdqJxWY11ipnl57x8Ny7VjN6TGM?=
 =?us-ascii?Q?9z+lD0wjO36BpdpubNd3ELy2zhJ26vjMnO4bufzf54tn53NOogCwpvTG9VMl?=
 =?us-ascii?Q?9kz2jwY2BGRSNS7uNyhXuFk0yURb55cyeOmdQsGf4LlJ9A/vz2eRPwhg9FsH?=
 =?us-ascii?Q?68l4u9eNEVTeyfVXzeQ/JepIZZxrfPJU1NpJH7t00e4/8rM5wjED0UtwH6Uq?=
 =?us-ascii?Q?rm1/6iUFqboRgL2ykRivHJGZ/cg67CAI0eOS7QxPqThoNv/b6qI6lPmK0fNG?=
 =?us-ascii?Q?/+C7jcK4SBOSKD6YdW2tZiVF2BlRl2wHbYzkqNqygn0DPcdaxIDHFs8beSEr?=
 =?us-ascii?Q?24AumaNFH0rRvveL6QLtjA3BG18aGfJY1PyjTsGSSQqG1ME01ZJQ1QCnmZmp?=
 =?us-ascii?Q?3EpqcMg4BJY4iWfZqesPlf5WeZI4fEsrN5nh0wSEhabI4HITsH+0nlrcciVz?=
 =?us-ascii?Q?QNlkZKKGo+faRnVue9tGJ4M60IDQcfmhnuk1uW4MuyuyR8l/N5Oax5XMLs4d?=
 =?us-ascii?Q?bcnpNmbxUqo1y+OYBLwuXt3wj86yJNEI5Z4DUzJaGSVeg5hk82bTEED3iTpa?=
 =?us-ascii?Q?7CS9DnaTRNlWr5nf+zI9pt3JVzuU5bxX/Us8YWJGsl3fI9QKhrSauLt206qZ?=
 =?us-ascii?Q?1On28qNz5B3G7nB4yadm83axmiEJw7Nbt5ICSl4klFfQnmP+pg4ZHAwYlYB6?=
 =?us-ascii?Q?ADoVoFk2Qmj+gPsn8oeR1Vhcxk4gbBgX9Rapdybt/J2XYsDHl7838mgqTXUm?=
 =?us-ascii?Q?UVq0ccQkEJlI2ec94v/yAgop2uJBITNxdVpL59vyWij2KG81v/5jWT/e2rL5?=
 =?us-ascii?Q?jDieP1o3XICtU6p5n1F44xG9AJxeWJCTpBKMGEBLTqYCRE3ReO4tLNIEmJt5?=
 =?us-ascii?Q?6t4aiDZxxd9EOw6JC2hvw3b/rOVbK8m/IGTSnyx8KFSfEtG50Meavq/m7rPi?=
 =?us-ascii?Q?ho5EKRXhlToXnWBmZFpMD3fANXjAS8/GS0fwBq78soMknYWRv8uHmeZcST8T?=
 =?us-ascii?Q?u2vw8WwuN/y21bgaaLApXZEWZCsfOwftajl1dCn2jCDMlvpwZhFnr7qvl9WZ?=
 =?us-ascii?Q?uAzxsaeIQavyTkf2geMoRveRaU0GRIHOr4Bva7InHPBpnAJL33jRotwwrDtS?=
 =?us-ascii?Q?atnrtONQ140PS0QiAZktYPQv+1A/vTdH0g8wTs6BQVrV1CCpCs/nFKX+MQax?=
 =?us-ascii?Q?tqMQXxPp5TqfrsHvijGe9tQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc0b8b0-7324-41e9-7a2f-08d9c90d68ce
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5631.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2021 07:49:28.1954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eKPIsNZ2WwD06w5veGyDr7LQoqqOv787vjAC4EoOIH9MBzdDtVrl/bVqEe6PBYBzJ9ck3M/78nbISXy/juJrsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5629
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If using I2C/I3C mixed mode, need to set ODSTOP. Otherwise, the I2C
devices cannot see the stop signal. It may cause message sending errors.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Jun Li <jun.li@nxp.com>
---
V5:
No change.
---
 drivers/i3c/master/svc-i3c-master.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 74b38772d692..bc9c7fd69cbe 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -477,7 +477,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 	struct i3c_device_info info = {};
 	unsigned long fclk_rate, fclk_period_ns;
 	unsigned int high_period_ns, od_low_period_ns;
-	u32 ppbaud, pplow, odhpp, odbaud, i2cbaud, reg;
+	u32 ppbaud, pplow, odhpp, odbaud, odstop, i2cbaud, reg;
 	int ret;
 
 	/* Timings derivation */
@@ -507,6 +507,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 	switch (bus->mode) {
 	case I3C_BUS_MODE_PURE:
 		i2cbaud = 0;
+		odstop = 0;
 		break;
 	case I3C_BUS_MODE_MIXED_FAST:
 	case I3C_BUS_MODE_MIXED_LIMITED:
@@ -515,6 +516,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 		 * between the high and low period does not really matter.
 		 */
 		i2cbaud = DIV_ROUND_UP(1000, od_low_period_ns) - 2;
+		odstop = 1;
 		break;
 	case I3C_BUS_MODE_MIXED_SLOW:
 		/*
@@ -522,6 +524,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 		 * constraints as the FM+ mode.
 		 */
 		i2cbaud = DIV_ROUND_UP(2500, od_low_period_ns) - 2;
+		odstop = 1;
 		break;
 	default:
 		return -EINVAL;
@@ -530,7 +533,7 @@ static int svc_i3c_master_bus_init(struct i3c_master_controller *m)
 	reg = SVC_I3C_MCONFIG_MASTER_EN |
 	      SVC_I3C_MCONFIG_DISTO(0) |
 	      SVC_I3C_MCONFIG_HKEEP(0) |
-	      SVC_I3C_MCONFIG_ODSTOP(0) |
+	      SVC_I3C_MCONFIG_ODSTOP(odstop) |
 	      SVC_I3C_MCONFIG_PPBAUD(ppbaud) |
 	      SVC_I3C_MCONFIG_PPLOW(pplow) |
 	      SVC_I3C_MCONFIG_ODBAUD(odbaud) |
-- 
2.25.1

