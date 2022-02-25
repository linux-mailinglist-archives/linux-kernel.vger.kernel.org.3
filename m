Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F024C3E80
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 07:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbiBYGkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 01:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbiBYGj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 01:39:56 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2131.outbound.protection.outlook.com [40.107.215.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BAB49911;
        Thu, 24 Feb 2022 22:39:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hi5XzIW2DTKsnXMIHmzFs8WSFUTJqZBubifcnVztJeaA51obE0jf2taNuLLP4IM0gW2ZN0I/7KIsmde44t4JIodQnZ9wwYxuwrnet4iUPqfuUScObN+jDLBXOpybZIQ71Gsw04zvf4blYWbW7p0J1eA43WotCqUIoI4v2AmVoH/OzDq4FfuW/lLL+weXspjGXO12FEIZ6CM50Q+wUxVo4GjQVR4q2/3KDWjEi7eJXRhUyB/UNdcOKF/J+vxdydHN3ZllKOSOtakMXW6IYz+pre94LZwVol3Ml6D5TTanXpuWEaSwsl+OzvP5uUBiCfVLoKSGTbgRu14qV4Y98BIGVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQzY0nOuXH4ufJf36nI2MOGptycedarG2oiDpeeDv/M=;
 b=QCeD53oZvRbINERLt3iWR8SPiCALSbnDcoCC/hfkljldDhYLKVHua+9e4bjl/7J1frpnmRPJghDbkTIUCTbQZwyw832P8XuOF4oGyYn3YXqXeDlg0CtP23vZ5B46lbxYfkuL8aQM255Fc7cukWy3MIYhzG/aRdUkIxpdQUTWUo2n81ixj0UyxmY3U4B0OYtzt5SwYHdI/XWM5209bHTXuzB6oC+Cs/9HBX3pk+8x6cBLQmF//lzyUSNnY5P960MHgp3Cp8LPF/pJtblAx2p9HcBGjiurflvhH3fVvK5okmLXPuYOhNlgGeIX0dVllJ55MEsgKy0pAOZD6+MxR/8tZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQzY0nOuXH4ufJf36nI2MOGptycedarG2oiDpeeDv/M=;
 b=jZGfz3m5xExiwBMRbcgzmHpCuxxkLFOKoey/nw/pyH+XKpNy7hzsxwg7sStliMpFloYgzIr8gp6XM6r2z/IfadkQ5PZ/wqIkpbly5HToQUYIh+bDPeqJaP85FVX6FeZrzCKzPhY8dsCfoBdibuasZgqWAlPuYLWmge3vKw9SQBI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 PSAPR06MB4246.apcprd06.prod.outlook.com (2603:1096:301:8b::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.24; Fri, 25 Feb 2022 06:39:21 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732%4]) with mapi id 15.20.4995.029; Fri, 25 Feb 2022
 06:39:21 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sunil Goutham <sgoutham@marvell.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jiabing.wan@qq.com
Subject: [PATCH] hwrng: cavium: fix NULL but dereferenced coccicheck error
Date:   Fri, 25 Feb 2022 14:38:59 +0800
Message-Id: <20220225063901.893274-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:203:d0::14) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b86e7dc-7cb0-4acc-cb54-08d9f8298e50
X-MS-TrafficTypeDiagnostic: PSAPR06MB4246:EE_
X-Microsoft-Antispam-PRVS: <PSAPR06MB424650F872C857DF26D94010AB3E9@PSAPR06MB4246.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ykTHui+dzb5Azr6CR8T++GEGcqadCORzOe2pbWrS8ew57/LZ7W7m8CSQg2Cyh9hLgWIeGkX+7WZLSmPsNEICkIycN5gG5/17YRMXVVsdcsh7yi7imm0lAx3VlvKo0TQ0QRUbrnxZvad/vsMNxuTVZOKBA+FJfdlvRC41f0AGEkERk1y7TOuPui4DGaSLNNRHP5MircAXp/bQ/CYmkRgKiVr8uljJ0tdY1UviEEt28rIvQUJ2g/L3+j57vToD4190VW/e2q1+t9e7gE1ufxJXSyl7udzJQPt2OaT2VAiXRfIgH4IXFHlfI1/IysJ3otODUER48DtK21Q3h9F1Ocr+BfhjunGHAx5OZi+EbXxMo8SBtL/m1FnIjMtsyVsK4jnVt/OALYbr3Ank2UIro/wBYWm0VFHpDnoCJYQVdyFd4o1DmDfxk9b7gY8/uQoKqIe5KbdCvUbnGDu6yqyLKa5Hvee2VKvo4/DJN4fCV+jU1E6ChtVAbvgs9NrshK/CNE01VjJgbJnSjT5oCi0ZgCOTYcjDNyqA4PqEv+ZBEdeuZjAmVJ3vt5m8OzUEiWWY8Ecj64jWyetzTxu3AmdcFmBzT6tX5kWS1ukhkKBaohT8t+yqAPM3vkSpg6rEJbn4ErOytodJUBvVwT4XZ3c/ETj6a1SLduqgTWybBODv78BHFSl15D0EG0Pvf59nEI1nu1lNpYW4ARk0kste8i9Ni1UITA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(86362001)(38350700002)(38100700002)(6666004)(52116002)(316002)(36756003)(8676002)(8936002)(4326008)(66476007)(6506007)(2616005)(66556008)(110136005)(6486002)(2906002)(6512007)(508600001)(83380400001)(4744005)(26005)(5660300002)(186003)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vpf8grCpRkhbw3H3u8O3yz+1J3oYoMka9ubzPX5wTActZ44eSFKvHa7cr5eQ?=
 =?us-ascii?Q?Z7lqlP5uOD1geDNtadsRWjCM6w3qozhAr+hPMfMc+570/ksNqdksAfHwfRm1?=
 =?us-ascii?Q?yAGz6oWdP4RGk1ktWUnx66Uci+VB8T1ha0lrwvpiKsWeMIVh2mZ54PvqoWN/?=
 =?us-ascii?Q?B58xWbiVzQ2nbo3kA96j0xfSNEsiMYStrSuBFos+2sZWdWTHKIqR2QePhm2l?=
 =?us-ascii?Q?JEMTTaoUjCMEfq1rNOjhq5cRUTCIqyBC5azZwH51rieyxQQq9WkLx+l1BxAh?=
 =?us-ascii?Q?j+nl4vL6dsqeBvWVmhIJugpI/53eSQmQh5BPu2jKJeKQcrJ9ui9Cl0zT7tg3?=
 =?us-ascii?Q?LrwHrH4YzumqKktpm1HKSaKrGP6/ykYkrYwWx7bglbhLbsUMGrnUYiuIePzJ?=
 =?us-ascii?Q?bAMXi2zPthm6I3K5fOEuj5UU9BeoMDqdxJC5H0C3IPanwyAE532PXU1MTYiw?=
 =?us-ascii?Q?wLKKK/TEWgVTx0+Wvr/UqzEyNwaBsCXf8P30d57b4MIzMAFgTK8z1cKn2/vA?=
 =?us-ascii?Q?OxYfXoZpI/bCJf93jz5cISt/I4hB6eB5apzf1HtCm5THfinUnNvLKKdbVx8/?=
 =?us-ascii?Q?Oh7Y1kKUR7tueIMB1hW3RkyiDkLijFxfGETi7o4ZnoWvdJC9DVCR+zC9bk2J?=
 =?us-ascii?Q?IIGSjIT/UVe0oS5kPv/ZZFXFM3ALqGuKlZMY8QU96JFh4voqA23rMneMT144?=
 =?us-ascii?Q?za5y59SotTCo0GTyqSNqUEWjwfKN+3eozXNWQEd2B8ragbXclbCIvcyQyWiG?=
 =?us-ascii?Q?A6dwa/U5irSonVKlO32QywuAAuIe69nY7Bgy6DcsgDdtCDKRHuy7chFTBrjm?=
 =?us-ascii?Q?AseVTqylvCAPNKVAtfa4XMxTIaEjps6K7hX6Rtcw+HOMR4tfVSeqyfYxiXsb?=
 =?us-ascii?Q?AFivooTrAZZsx7FiPS9DEMY5uVxMWQNx0+FuIGty5wl/1Nuv+kYu0ZoyZ7Zd?=
 =?us-ascii?Q?FQJJkkiE6htvSBdDPqA0H2AjZ/mtEMikrCbI9Hm9U+YZDJVS6RfhvK9Y7+dK?=
 =?us-ascii?Q?CNOnVpGbFQBujkeqd80mazbt9g3nSi0jUZSO9lqg6U8H2UNSMUl3AhYsbeye?=
 =?us-ascii?Q?SFrzI4gpQ5BErr1mlZlL3vcW2StC9DS8+uhJhICRXtADx1V+Q1VpZgZBK3a0?=
 =?us-ascii?Q?dKM3bZ6es/sDZljH/KkLWgmtDPwf1f7VI/TY1c+k6opVRCovPimc/XcE7sEo?=
 =?us-ascii?Q?7WKHEC+mrE7sVu6uTwrI3RFPhZfMia5NiPq0MVu5WOWNdARiOQRo5jm6kthU?=
 =?us-ascii?Q?IQTHVwgRK8lHVIjCGQAmDqFrPX4s7tUSYSlngZGRJxhKrz2PcswIBDpEGijZ?=
 =?us-ascii?Q?kUDaWi4Y3So7GJCB6VvldTNc+8g9/I6VFJA/mEfECPTa+yzyO4pHrRsJWRdP?=
 =?us-ascii?Q?sccquRAMftoNsQZmi2ZwFXoifc+meaCFn2TXdortcJRiM8aE71GbCBVRude3?=
 =?us-ascii?Q?f3w+RZn+4ybAl51O+055VXWSvAM2IZ/JhGdbt4qnlp4yPCK1NUmNNGu1RijS?=
 =?us-ascii?Q?7j/EcNI0HjJSu1N1CUlhXyC9a4gZmaCwSPaIM61v47ty3FLytgeABpUfp3QL?=
 =?us-ascii?Q?/kHm1DyWg4yqWT+aZ8sKSHOOUxFly/Sfn/F4Sz+mYIq+yZu2j/M3N06w9WgC?=
 =?us-ascii?Q?12YtRb3AW4/U7dgBVKg+2iA=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b86e7dc-7cb0-4acc-cb54-08d9f8298e50
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 06:39:21.6830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d7w00G2lsR24c2Xi6suidN2nIx1HAVHKKuTOfC88wZfKWGzSel1S7IpgTdttLCY4uUHMEGXmYzIrsHpMzsmWGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4246
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following coccicheck warning:
./drivers/char/hw_random/cavium-rng-vf.c:182:17-20: ERROR:
pdev is NULL but dereferenced.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/char/hw_random/cavium-rng-vf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/cavium-rng-vf.c b/drivers/char/hw_random/cavium-rng-vf.c
index 6f66919652bf..7c55f4cf4a8b 100644
--- a/drivers/char/hw_random/cavium-rng-vf.c
+++ b/drivers/char/hw_random/cavium-rng-vf.c
@@ -179,7 +179,7 @@ static int cavium_map_pf_regs(struct cavium_rng *rng)
 	pdev = pci_get_device(PCI_VENDOR_ID_CAVIUM,
 			      PCI_DEVID_CAVIUM_RNG_PF, NULL);
 	if (!pdev) {
-		dev_err(&pdev->dev, "Cannot find RNG PF device\n");
+		pr_err("Cannot find RNG PF device\n");
 		return -EIO;
 	}
 
-- 
2.35.1

