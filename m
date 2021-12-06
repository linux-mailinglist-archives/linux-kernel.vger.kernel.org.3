Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFEA746957F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242961AbhLFMTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:19:16 -0500
Received: from mail-psaapc01on2093.outbound.protection.outlook.com ([40.107.255.93]:43649
        "EHLO APC01-PSA-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242106AbhLFMTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:19:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGjI5Ky1PE7ZmM/swxHIfAe6mWb6NR3dAZ7BxGynYHHuzWqg7i0XhGUzPOhjFkT58KZ7NnlfEIBhYnfJ5xyUC+Tqz/NIMw+l3XGKk6VwjIniSRWYqZIDa9gGLRILP99YPlcg8Q+v+1fTdEw7tN7Fc/CO2OconjSLVn7yOR62lcWxk77qCj4lxlI7esDEBJkLElI6ul5J/CnPUOM2ys824195kSNCOuD4e3NU63SKHYql4t/OBf1EooPB3shQADW+Gy3v5KBN4tc+mPBiIIHrwEu23z/Va70y3Ntk9Xm0/ZJJ9Nf6rEKZyehNDwQ2/lo8X2LEfFiEHOKVDdlT6Nzw8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/gknw5y0/b2Hj6cY9p90ryyscE9KrvJA3NQHCf/9RU=;
 b=dijm0nY2bgwBJQ2rrk8EmwGPmkIW9qlnKLnhJKc3hYZFLBTMX+QeGwyYG0JKYbDoVASUquevBiGDXxG7KbmtfPn8ex87aQ9r+zB5Kt2H02EW1NaA8Q2T2lLo4z6WTWktYihUnK9Yx0pAVmneE4PWLd5pyudst9C0M75rQzTxSFX8pndvXqAhz/P8l7xZcjT38xr3OgAdc6Il0mB6S/1HJDZVsmCln2xdpIAQr0d2U/KOLz8EYOJsH2/IQmJjBRIVOJaVFzAZ5g2texMNRRRNkZGCd4bZHE1YTFJ+Lhl74lwMb09xASpmAuhbpo9K134a2vjoUJUPSkQDesPTSsKRdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/gknw5y0/b2Hj6cY9p90ryyscE9KrvJA3NQHCf/9RU=;
 b=IGJQMO98p81wgPBO6dieSA5zkhutspqQWUIJl484WariwIavfRtS1Q3mo8Bp4I6hEvI5DSCUENHB6ZIPYJ9KgXgTyELUZBkKnSZWjNLMjue3YfH7dqZsLOdc+NDgE4JPgQ/yVg0irxKhcMZxcifgPEaly5lwmqxgUm3/cRGiQRo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by TYZPR06MB4015.apcprd06.prod.outlook.com (2603:1096:400:28::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Mon, 6 Dec
 2021 12:15:44 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::6093:831:2123:6092]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::6093:831:2123:6092%8]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 12:15:44 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Yihao Han <hanyihao@vivo.com>
Subject: [PATCH] mtd: nand: fix boolreturn.cocci warning
Date:   Mon,  6 Dec 2021 04:15:30 -0800
Message-Id: <20211206121531.31808-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0074.apcprd04.prod.outlook.com
 (2603:1096:202:15::18) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
Received: from ubuntu.vivo.xyz (103.220.76.181) by HK2PR04CA0074.apcprd04.prod.outlook.com (2603:1096:202:15::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend Transport; Mon, 6 Dec 2021 12:15:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f89a833-22bd-4040-7ad7-08d9b8b22065
X-MS-TrafficTypeDiagnostic: TYZPR06MB4015:EE_
X-Microsoft-Antispam-PRVS: <TYZPR06MB401562DF00CF9BAB597EBF93A26D9@TYZPR06MB4015.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9HOmq1hilrNn0qnUbeH3uX++O+Ibl65uqbfo4Hjzgp6MeNxz1YHM9afwdgJZw92L2RIuIxVRaXAo+3iInJ/ht/sTU4/T3FtnMr6VSZ9IX2AFabO79zc4hsx2F2iY5vq/rY+ypneb0plDMx11K5CdyvzWsPSm/yiwmevuIOs4wyDfsmb58FupBXyzXU3M2wUe3LlErw1LElYO9yBBlgFuqmxVWn2GT3psrIm74y2ZzzKxkKk1xFgs5Ba4uoLY0DEyVvPNG39/69/0A2byiTg3OHLNJOz1+yepoj+2CXpe06/5GFnP60aFJ0SBaJj2cBTE/ZUJ0ffLc0dsdeSqIEjddtSL+K3bkOuQstuC3czWpSfYKILoQ5NfkozKd1zDQRU9D20RyoFRokD8mGVtDJ1A0gHqfAExv0rEB3JMjhQlPYh5ZEOkalQYZC90YHuKa4vB/Cw8O8b7Fn5TXjRsmr0Tb5TQftpJ1+rMZI7QHtR/rrq4DcextYr9Adc3C2vsRmIykG0V8P1WX/mx1AIVuFP9E57mGt2FeUAdXUTpcMpV/kkFztplsrYr1vVqknNkJ9heUFVhPnBJPxh9Fj3Bb0wGwBV/t0mZEytpgxhmoPm8LHEmyCwkppnK/wb1rXSdOsdwu0U0eZvgj0xHEl0fdEmbiUjC67Zdy3SG7OHrxXkBo2Q7rary74BzygW0zTp2bdegyR+HdvC/ILJNV1LDfDrExfNN/T9gkjdsgYgSLX5TK0Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(4326008)(110136005)(316002)(26005)(38100700002)(107886003)(38350700002)(6666004)(83380400001)(66946007)(186003)(6512007)(8676002)(86362001)(66556008)(66476007)(8936002)(956004)(52116002)(5660300002)(2616005)(6506007)(4744005)(6486002)(508600001)(1076003)(36756003)(182500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ORyO6AyPYsyyskn7rYkC5Hla5LUMDeEJr8nupySYHDvOjxki0ssIkoNeVs91?=
 =?us-ascii?Q?sBvd5nCb/BJ8i5mOviWyykcwPQlSLk05qFzVvv9Y9FuHW2OxIvetq6ohTFtK?=
 =?us-ascii?Q?uDSjQbnnWwtX+7MWnz112v8buoL/1N2PUGeWpELLds7SgT8Hd9gMCzxiDKCs?=
 =?us-ascii?Q?+A9yvbJR2fDAHk0B87PyLnJchtw++PrXEM4omKZWbHLAhpBVSLVALghtglBg?=
 =?us-ascii?Q?upPCYQ21q0zcAEPVZxseA6B+cNoRvEa5XIgHALrkDEV7mgqfYu++qQ3RmcbW?=
 =?us-ascii?Q?bDAemGvVcS0hCRaOi7oJfevnKypYJnN910D/7O0QG7FsL1kk3S4qYFEIW26I?=
 =?us-ascii?Q?0wWGRRrx6vECPre8PvH4RLCcYoYFif9lFJnPf6NL8RPgrV75xiwYNXg9YZnn?=
 =?us-ascii?Q?iQn9xcSOujgHlY9bdZS3BfYw0cKauNvJKe29vUc8APz+X798QiI0rAvwEMr2?=
 =?us-ascii?Q?9CcMSt96vkqcCFv7EXpdavBjjZa+UkTRS174yWhM5KMKFDzp+KIuGy5kL0b2?=
 =?us-ascii?Q?sSW7UKAx3l3E7UG9jd4XIBwN0sYAI27/MOV+IK/C6LXl9/M/W/sV5f6e+KfB?=
 =?us-ascii?Q?rGtcerg/HevXnJ9kmUhT/yhf8dWR4Iy3rezd+8xxQJU6N1EghVWLfPeotyRp?=
 =?us-ascii?Q?PtQ2B0rxwmw0R6g99Y1HrQyTTd27SaTyqNDY0CK9nZt2QCAxvf4S5quapFCb?=
 =?us-ascii?Q?nVBLDNkzBT7xHr4UnA1DaN/vPkBPFxJXATYO0Hi28N8yEQJLpKoWQBnTfWpj?=
 =?us-ascii?Q?JFkv5H9xPlDSUDHPyg5lLGAYIW3EZzNnE/Ngc7vBlUAZmvFcSjqzGCIg0A4n?=
 =?us-ascii?Q?d9x/xsj7jrTAfL69nB3lHVQfSJLERcUWruH9iBurCtvE1epT1M1KdXLCxA7i?=
 =?us-ascii?Q?4SnNvSg5KRoZDm8bvyqrKlsulU4TCclhXU29QFDbHDlR6Kr8VLXqdxT598Px?=
 =?us-ascii?Q?JOi2UGwezMhxZJ8u37KBiJY+FPeDUtHnh/qVahf/CpvMC6MSnY9zVLYnpnri?=
 =?us-ascii?Q?S3llBPfKoIQhUzRhiMt+WBuolew/HXY22UbNuDMJJpLnAq1ObCDKZtfM80oR?=
 =?us-ascii?Q?6u0S+18bpGnUBSKLSzy2ambXd0akjQQzYdoorV0yMCNoPpqWjwo1KRvrqMB0?=
 =?us-ascii?Q?0W+b0j2nwbDDtnJK1GuSWAJzSVKYo+6qaRyH+9kIp15YsEv6li3ssDTI4dKc?=
 =?us-ascii?Q?6rJ/3/cABh03MIX2esAm54ap84BcTm69BTk5I6+Cf+4lERAVNnTh//9l2SdD?=
 =?us-ascii?Q?+GuRgPD8djZ6XppCCrGN1QPoVBk0p5D3t5sRatauA6SNCrHgmoIJa78Vyp6m?=
 =?us-ascii?Q?QPSBGmmEjRgRXQ2fxgXDFv1pbNOOnovjm6Cb0hJyLtpugrQZhHJsY2qSki0w?=
 =?us-ascii?Q?5d81fDrvnWlJutsc4wNj2ghPVflITfC06bfZ6VV2BXWYXDhAshv/Zf+g9f9N?=
 =?us-ascii?Q?VyB7H8sEe9eooX2THg//c+w+JfZGcQmrIjGjqfJU77GoJmWTIr8LG33uECVE?=
 =?us-ascii?Q?MBFgHhMOmPYJNEvtpH7Z0hv7AczFRdC3+CIb8ik05KYlSn/Cu2sIt+I6E97J?=
 =?us-ascii?Q?89GLUGFLaM9078ACJFUDcG0prWss0BF0+uytDVTJ5rvl/IEj8/df4HBa2jlm?=
 =?us-ascii?Q?Hc/RJfn53Ctxk4Z/4ZM3RPY=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f89a833-22bd-4040-7ad7-08d9b8b22065
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 12:15:44.1556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lT3MERjXygkTAjF71oJNN9m7cmgC/TL5LxB6LD719ikjCZmxWVD4iJ152d9beegNqXObxNGLKAl9itKNwOJehA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4015
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./drivers/mtd/nand/core.c:25:9-10: WARNING: return of 0/1 in
function 'nanddev_isbad' with return type bool

Return statements in functions returning bool should use true/false
instead of 1/0.

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 drivers/mtd/nand/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/core.c b/drivers/mtd/nand/core.c
index 33c7788d76c2..416947f28b67 100644
--- a/drivers/mtd/nand/core.c
+++ b/drivers/mtd/nand/core.c
@@ -22,7 +22,7 @@
 bool nanddev_isbad(struct nand_device *nand, const struct nand_pos *pos)
 {
 	if (WARN_ONCE(mtd_expert_analysis_mode, mtd_expert_analysis_warning))
-		return 0;
+		return false;
 
 	if (nanddev_bbt_is_initialized(nand)) {
 		unsigned int entry;
-- 
2.17.1

