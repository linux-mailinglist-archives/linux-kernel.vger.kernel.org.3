Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7BC1497A58
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242127AbiAXI2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:28:21 -0500
Received: from mail-gv0che01on2128.outbound.protection.outlook.com ([40.107.23.128]:41184
        "EHLO CHE01-GV0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236330AbiAXI2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:28:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZeK4UMSR+FbEHA1FioB7TpDP3a/XxgVjD+RayqJm0DZ91pNXH7Gg3I0fKIZkcKevKIKsTAX2NWzm36399vE90NjWqxZTNEbzDPowjdXAupmUCvbYVO0wHdmiuvVSuZtV/LPw9CDukNc3LINr5Tuavi3XWL0cJDpN5IBZl4+HnpJkAucae2zYspIPm+Pn6lxJ+Cl0kbgk+QLmsk3SSkAcADNMCvjr4RAHyczKb+Gm9Tjg9MqPLYmHl3TJbCPyuR3KPW3PJPTI2iwZAGA6giwwTM95pIB1io55niJjyWiM8yhsQjwv9jn+xe+Jaw1bpGsfp/FA2IIQQEwbDbYDrC/dGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8nimqkeTMpgA2YPpvATxQrTcVrQQDl5iLgecwDMWs0=;
 b=nFCvETpUp2nq19ynEM2x4rFqxPo9chNXhWsv8SqXszfvYQ6ZzOdwe10apv2RoJNDcuW5bE/jEYUBzZgtmE8BRaYrZcRcjuk3MSmefYTBF07QXDQ58yueK5u8+UXBWjvVaHjyXWsjoxeesY0ARavWdCDslDRIltFM6Jo0B+NFBerlBH8mMZjFEwUyPtWJ1YtwKE4fWIkqOg3ejbWSk46qtDreAoSZDsdME+V09eVZa8xWMDUcGAABsVkWFODB4bswqcJGmNk9jY7sG4CJ0nZq8ZotB9kxmzOCnm4IibUYyk2T/l4GccdQ+Mu2GoODowTl51MUprZY3cuRHZvzGGH+yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8nimqkeTMpgA2YPpvATxQrTcVrQQDl5iLgecwDMWs0=;
 b=S0rfFneSVayNjIEVW/O3ZojJd6xTNymdAzxH5XW8PUqkpV/zL8gKDtCLouGDnlkQRsOEz+2zQe8jp532hQ1fcfLT4VW5IdSHG6nh7JcRBe+lUMtXAkI53KE0C1N4XldCGOE6GNWkkD9LKudHYRw/qqUNmYDWTJ4L9lKyAcut8vY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3d::11)
 by GV0P278MB0227.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:31::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 24 Jan
 2022 08:28:16 +0000
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d837:7398:e400:25f0]) by ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d837:7398:e400:25f0%2]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 08:28:16 +0000
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Stefan Agner <stefan.agner@toradex.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v2 2/2] cpufreq: Add i.MX7S to cpufreq-dt-platdev blocklist
Date:   Mon, 24 Jan 2022 09:28:03 +0100
Message-Id: <20220124082803.94286-3-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124082803.94286-1-francesco.dolcini@toradex.com>
References: <20220124082803.94286-1-francesco.dolcini@toradex.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:26::20) To ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:3d::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc5470b4-0464-4e28-f6e5-08d9df1377f8
X-MS-TrafficTypeDiagnostic: GV0P278MB0227:EE_
X-Microsoft-Antispam-PRVS: <GV0P278MB0227111CD3D6E6EA7868D2F7E25E9@GV0P278MB0227.CHEP278.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xsZSd7M5p7EGVvTV7CNwZlldP6zNHKO+5c6wUXtqqWlSIuZTARDh9zPh9+y1I47K31/GRc2k+FnJKCItxYhpsyT/kvQ8VZsA40Mo7uRhpjwvOFiUqqpCbsTgH+oKqlCpjP1IAFhijLlP9Ijdz8jq1EJ1Mp8AEsEo942wS5IvFA/2GLanlxmISYqVEuMx+ZoE0Yx3NbBbTLzgMWIUPpuIxuatkHh97I4gFlZ8TdiXi2BfBQblLAZXEI1lEjNp4PS9kDK5xgsEFTLrvJi6uch9udLHXwnMnGgsSx72agzJBMBJQSqNq+z1YhE0xD0iLgjpVpNfMQyX58JLtGh1bwYdeAbtDfBEWj9pjkuI5VxqCdF5Qii2Ghw10LnCZYHTtHeUog7qNXp+R4NjH04vuAIMnpiJNG9w6AApU1nTtIHWFmYf15IBqK7O95vbM2bORW7VVYRgygaISfbvAES7Fmv9Azms2CDZpbd4Xzf1UiWYz4tdJTg4LH7GdLayTAwkD1GqiZPezaKhgsAD4av6eaAUuSGRtbDHPFy67bgdn7nwJLhSfJS2nFAf9XOHB/miKuWO4z5u/f+uBVUTuXJeZDpnRa169iKUG6B/+rllEuhJjVCXfdzMSGvu1XwxrN5yFTx5gfIRWZLDS0glGKjQheyD6j//mfJfjlaEfhnJ8oNkYS6iBJwQ3Rp8o6d0w+GQec5yO37hmqiE176tY6ek7joEew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39840400004)(366004)(396003)(376002)(54906003)(52116002)(26005)(1076003)(44832011)(110136005)(83380400001)(5660300002)(38100700002)(186003)(38350700002)(4326008)(8936002)(8676002)(66476007)(2906002)(66556008)(6666004)(316002)(86362001)(7416002)(36756003)(2616005)(6506007)(508600001)(6486002)(66946007)(6512007)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SPGKqyvPuSxoAcsa8sRzr0gZ7PMwj7BWzVdHYRMqf+LDul+Tv10tfxgdHJaY?=
 =?us-ascii?Q?sM63lsouFqwwJNauXzj6ciEOFRmhG+1GNolRJAS/r2L246uMLmR7dBlsCKBh?=
 =?us-ascii?Q?A9N3hUFM7+vAPU+JtEFA4jO3MMbcTnfr8sjWr/wDTr+UvtUHZeZzhmeXZFMv?=
 =?us-ascii?Q?k93+O+i0OMxCc42lTnLJpcIjb5TY+yxs4M5kU7KCm5T3ejT58exeZkR3S8he?=
 =?us-ascii?Q?2mOI0d/g2razACga45RIqtZbz/C2qHx4BlyvmSJKCwqza+yRYlgpdhdDSwyy?=
 =?us-ascii?Q?zgDpNlGao+XVFa/aPgp7o9PR2O8668k7D7Gj1plDbesinWOfszF2gE/x9ort?=
 =?us-ascii?Q?5R2cl7ybe0PN9S7nYhRkNFX7NxLE81up6A3Wh9nEc6fegM3hZS1xdAdzTraE?=
 =?us-ascii?Q?4cQRZDGVDs0fgb+6x5Jb/UMRTu70P16tCZQ9KZhNdL7aafaUMBnOi7bEwoqP?=
 =?us-ascii?Q?sOABG3sThH1ZpQ8Q8Mq58GBcT/g0d8MrMNLE3lssmYSkASVhZDI4DDLTYnm3?=
 =?us-ascii?Q?U5QjzGA2bZS6WEeobKfs3je6QOGdC+UOjlcMGCtESnwICcwaaHpDY+SU2As8?=
 =?us-ascii?Q?xCdrfItp4eAvxktA8Ro4AKYB8anrxWreyO7iD8cSsN6ASBN8VsXL7YNgM7hI?=
 =?us-ascii?Q?VaLbhPIQhYY2uK1W7o2kemOediV+frVMJVda3eoZ2UdMKHgKOo0KtX5np8xj?=
 =?us-ascii?Q?FtVkDnhzsxks+jI/Ag3z0MVUD8jseAFUXQsM0QQo2W8sxlnTmjOEfCTilsNC?=
 =?us-ascii?Q?jnC4lYZZfLRZAp2OEZ2WkThzLwBDyif60KazOiW1TBsxwN9E2BCsuRIN3zxw?=
 =?us-ascii?Q?pMn1LWhjhavOM61ZvWrakYrxZGxbtM9rlC1Crng9cbshsZXyQwTVddLsuLyt?=
 =?us-ascii?Q?Y+TPa8cv4PMNOK15ob/pmvyyWhLdujUMBfiZzsE7wcu0OnqWgKdMLw6WO+qX?=
 =?us-ascii?Q?zAYrXwwO7gF1uej0GJNmi7ApX004xt4pYTrVSHSN9KU5f8Eb/s/DPxrA2GOo?=
 =?us-ascii?Q?AT7sEWiOxR2o5bDHcx2tqfCTYz5FuYge+AurESeucRNSAXgGT+YqxxlBFFiZ?=
 =?us-ascii?Q?HqiCxFTODQGXJsXk94txq2KsasVpe2UCRp9wkn5ZUCs6B8P+LI8VcAMEFfcO?=
 =?us-ascii?Q?lsjzUbGtiFgK7THrapfVwt0+vVUqP0PbA+imVCxAEAupZtorV8F2NDmEhNSx?=
 =?us-ascii?Q?+mff6JrE5lFffzrh5Vj4HHlMctikdjlPmjtGgXGJsu3wB5KzvXDKbgAfbkiz?=
 =?us-ascii?Q?6wX9liWENFBzT7T4TOTXDKp5A6IuBptaDkKMSjQSBPEf1+aQcqVtuuAYsj/r?=
 =?us-ascii?Q?poVh2jbhWPjK09NDDyb4a81pIR6yZnA/2kQw4pRMACfFK9Ny0cgWJQij6fFd?=
 =?us-ascii?Q?mZFM/Ec4IyVI8i91OJL+GX1NNteyaJQJ6AaLaqACLPAc7yTYceOTyAAU2+5+?=
 =?us-ascii?Q?lxb5Z4iM8VjmyOHI8PaWOE7dnUwhZZeQ6k8F1CUW7TLE9XJhQDwv9dCMfGhz?=
 =?us-ascii?Q?Iqw63pLWjhHyu8lOi8txWAZxkEby1Egmk8Bo25vQFpC5yCUmGT4svfH049Jt?=
 =?us-ascii?Q?RwZB0uHxoz/bPJXfp/NcPTN0K4WR+Y2Yt+IN/3i/l5aw0z9Cu84qkf8UM7oh?=
 =?us-ascii?Q?BnlSJx0dZ+XYrZx3EKqze5WANpXgSMlOdpfOn9u5coUtWq7FZOiKBUB1ey10?=
 =?us-ascii?Q?+ZpaMQ=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc5470b4-0464-4e28-f6e5-08d9df1377f8
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 08:28:16.0878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MrlL7szsoIpMlANosw9TiJJNipujOYukmDHCHOvhmoQ6py3OuRT1E3xptFvMwKowHusY0bcdi6azMaSL6qE8iH36b6R9NkCbdsGqBIyiEog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0227
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan.agner@toradex.com>

The i.MX 7Solo currently does not have multiple operating points,
however, in order for the i.MX Thermal driver to successfully probe
a cpufreq device is required. Add it to the cpufreq-dt-platdev
driver's blocklist to allow using imx-cpufreq-dt.

Signed-off-by: Stefan Agner <stefan.agner@toradex.com>
Cc: Stefan Agner <stefan@agner.ch>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: removed empty line
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index ca1d103ec449..6b808f805eab 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -110,6 +110,7 @@ static const struct of_device_id blocklist[] __initconst = {
 
 	{ .compatible = "fsl,imx7ulp", },
 	{ .compatible = "fsl,imx7d", },
+	{ .compatible = "fsl,imx7s", },
 	{ .compatible = "fsl,imx8mq", },
 	{ .compatible = "fsl,imx8mm", },
 	{ .compatible = "fsl,imx8mn", },
-- 
2.25.1

