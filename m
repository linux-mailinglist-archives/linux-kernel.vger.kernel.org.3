Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3155C46BBE2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 13:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbhLGM7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 07:59:02 -0500
Received: from mail-sgaapc01on2125.outbound.protection.outlook.com ([40.107.215.125]:15329
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231583AbhLGM7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 07:59:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qr6Fvs+mRVfEF3nCKw5PKBQlQp/bcICfJxLB7VXDGa0Y8dz3ecIDIYkO25CkeTngOfXDp3hycMoco0WS6ML2kQC1e8ilSjmTflDfdpoDWEd1olIbkbdUEx1YGRyGgQhpeXdnxD1LIWz2Q7ar0lhC4BJloYv0ugrWcS8F4oqPFRqglg0e8ocpkM4fQNgxGDlom6mXf8rM8mCBUemkwH4h+EQYIiJ85ypw54VvM+zHrGRUft7fDYklgME43uhuxxPC8NlVaLokrUkvcGEwub+OEv4yy3AxEFIQjGqbhp3rTajF28i60H+LZP8MLeAzm5x7DScbbnNCPCFTK6D8SLUgZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EW3a0aVPHXUsF1IMTOpSypJhFqjQqoTbVumWRjtJ5/w=;
 b=ef7K+yHzXidrfhNThMzrzh4QO2w0jGbhTxiw6tM3o2QJmbV44Z3ReXzdqy+ZoEXThy+2YWsfq6zxr7ZcoO+GlWnxWK209sEA2aXpeYKrD054Gxjm5C23fCL7sXZQLiSltdATtuktDpWOFjB0Ox3saPGr2P/9FDPHV5u+S3mEDKugGGpZ3qo8i0PxVDwfmL+bN6Mv2etYYqoOxTcxnUjme/cbiqFSC8I7rlkHI5Jvc2AXQwvHzLU5VaIMEmn8oFHskAXFjQG7Tfs+XXwpTtdgL3L7LW6X5HbGdaX3CStgMqa8+wWOUh2O9b2tJ5Nj05vJppP564Zx5MMbmYGAgKJVdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EW3a0aVPHXUsF1IMTOpSypJhFqjQqoTbVumWRjtJ5/w=;
 b=XueCBp1pTFneTt54K7esX0u7/EHKC7cV9xLgqQBnkW/xn8PnfjcaUTLB/FwMf+FStuE4987pR4XHgTKMRkWEXscU/OBVLduodjjz5sQRE786OKxfnt0EX3z/KaE5Q3zc1/FcA6GD4+YWRxNtq386pCaBmPwVI7HCfAfpYgyQhP4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3388.apcprd06.prod.outlook.com (2603:1096:100:3c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 12:55:25 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396%4]) with mapi id 15.20.4755.021; Tue, 7 Dec 2021
 12:55:25 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] x86: mm: use WARN_ONCE instead of printk and WARN_ON_ONCE
Date:   Tue,  7 Dec 2021 04:55:00 -0800
Message-Id: <1638881702-3106-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0048.apcprd04.prod.outlook.com
 (2603:1096:202:14::16) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (103.220.76.181) by HK2PR04CA0048.apcprd04.prod.outlook.com (2603:1096:202:14::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4755.21 via Frontend Transport; Tue, 7 Dec 2021 12:55:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae2d47a1-01b5-4912-9bfb-08d9b980d681
X-MS-TrafficTypeDiagnostic: SL2PR06MB3388:EE_
X-Microsoft-Antispam-PRVS: <SL2PR06MB33889970520E699BBE931B25BD6E9@SL2PR06MB3388.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:376;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x0UVR2/EDNIDlHy6+sMjW3qqoBqnoJctOQB0lqhdgQdjbGVNCcFhhaUHnjhy6x42jpitz7qphmQjIGUx484OE1DHbG1CHHFEtleZVEWSF3JYMUphJzpO0Ndj4tjHOe+IDVsLr6tLhFKrhYgheZ9anzlEzLlLwaHGNUJAtscWnaKyOhPvdpW7Cfg1/BQ48LPBSJu3VOBEMTZALrPm2qkVO9i/fdhWLVNdmiI9b0uPtLbXuHNmKXwGFo5AgB8atyaQatHc7HlTMDF1V5h5phM4XP9ymyk+Zt4De83T4tmY/xWynh7QlPWLAA/EBLn/oGiO3/wLrp1d+5tSqYCIDZz+fT43Hbrzs0QLcrqq0adFmIQEZHoFPFSc4CfTnNW75m8xmth0J3ddj98pP0z5jNFQfHP1iSkSpH1weB7vpNIWHKtaHCc/GRd2Xe+CTkvlYFV1AqQz6i5w6bH7+b/ZCnH1Y07aTf0LFpcXers7W0NvmXT47567j2h20owS7NRLm7ulkLRJa5R3/7hnq2YZc0K3DTZNtq6/+PMJbxHt1QP2RedrG4Q4xKMli8/rOtJvTg3tkL/SzBnCBsY+h3a2IXToaQ/i7j1nOkYITytB5EjMzNl68a4GpnbnBEViZfRPgqEAp+N/2M2KHKkXfrKUeY2oFdxQOToIli9ek9CvHMA2dpBanAaRgvnCL3j1241B5ecFc0IjsMVi8PXnKGrSMqaA9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(186003)(956004)(36756003)(5660300002)(38350700002)(83380400001)(107886003)(8676002)(26005)(2616005)(4326008)(6666004)(4744005)(316002)(6512007)(6506007)(66946007)(6486002)(508600001)(110136005)(66556008)(66476007)(52116002)(86362001)(2906002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8C4bDgOjTu9o55SLt62KEpsBH397Ey+ho9zypQ49HOj4IU6EJWynTtPBU3Si?=
 =?us-ascii?Q?i7v9Fxa/5nXJALEgAsHJtjfoBtIJ+IYbEAEuZzDslkb339SVHmGLFlLUuWo/?=
 =?us-ascii?Q?EUV3ehQGQdlL2/DqnyvCmbDJrDz5Q6ki5AsZQNYL/lIAAXLrS+cmfYv6Lfzm?=
 =?us-ascii?Q?jPqMBRWp32Nse6Q/4yLlTm3narRmf4UUzhstpiI3yUJQi5EEcc0tof/F+Ih+?=
 =?us-ascii?Q?xqkUq792CHyWc4YuJRNz+OHLLqi6a/GYHFSULmLjOZ+3PsN5VPwpQHo841qf?=
 =?us-ascii?Q?JGILmbKvoRvFr6aBSFIRTzup/EJzXvayCVeF3e19vKKsPUYESzp3qnIznRgt?=
 =?us-ascii?Q?nPcvShVhTMoSDgG3cMrek5e9hE8hkR9rqMQAdRyA4inwHcIkVJoLS+U9KZrO?=
 =?us-ascii?Q?o/U1roQwh2nA2Hs4df2TLQ79fdkJ5N0x1Xgk9SxrT45UIIniYJxYOzVgMznA?=
 =?us-ascii?Q?moS7g/a/Ang6cTGsMZVLwQ46aJ4LWhuWdsomcLPE9pkG5QWj/9n1nKCk6/wn?=
 =?us-ascii?Q?DFH5mHgycyuCkk58vHlGp0bLxiNMJkw3wmSFBIv8fab9jTcuOcxYrYlJszik?=
 =?us-ascii?Q?4/ntS33g3QhAxYS1tWusn3usbbIVAEa4pMBoszbeD+0HWmGRQ9jJ8cTIBycn?=
 =?us-ascii?Q?1BWjE3pIhtKu2cxuabVAjYIhO5S5XcqknXvGVLN+ehYP9oNpcVoaiVEJctSK?=
 =?us-ascii?Q?31PWW1dpaRFhTAfpawjOrWKaPHm9/sV2Pu9Tl+3zfPiJEU4fpYzdTpCvW1JE?=
 =?us-ascii?Q?9VXAXbNDiMQdeYu/kjWKUlgD2vUcmdPAqShIxYU8yIKT/fGjNj//AgwCR4Xo?=
 =?us-ascii?Q?85bX1IE7DZKF4m7hV1SaOk/OzhRhwSV+QdVN6SnxvCP6YNRNRRj2i+foIxDM?=
 =?us-ascii?Q?np/f2Ii4fM4ezEk5q5ue0haaZ11Gro0zvjrQLOek3WPI09xIfk9gFiWMOXZg?=
 =?us-ascii?Q?dPqdmWOEmcwzWmyFhdUwSRjqgHvh2/qgaVJrUMvMRPFNHac0SNBZlDS50M4+?=
 =?us-ascii?Q?wufML6dmpcVTYtR6EbgAxq/2hV6HtrDFnPFwi8/xbfeW5RWtu3V03VrSBIOv?=
 =?us-ascii?Q?NZgvo+OXGPm/OKc8GiKQnr67OWxfbRAWW0JM0ZrhvIIPe2l6UK7q8ldp2er8?=
 =?us-ascii?Q?r6m21WXMt04OnZ3VTFKxM/WxXeGkzCMx/RO2cxrNjW5YUXxqIdKpMLe04EKq?=
 =?us-ascii?Q?xj2jNAfHsIgeh8dmAz8w2V0chUdsq4VAezeQLdad+Eu8Z3L3cpSSXXyYD8ZI?=
 =?us-ascii?Q?gL+SiSxpFb4Y8/2ovynHojnlQDY1zV5nKr4ArnvtX0fRqX9XhJcdwwjND4R3?=
 =?us-ascii?Q?jiZUijR+MRcOs0GpjHaAQvsRjzvut/wOao1Yb79YbI4jiBM/Btn16uD/s04t?=
 =?us-ascii?Q?8OLV+3MordQMKJidIV6ZvYmLKEwAyMqG3C51iKM7YEuGeV6h0xsBRArPi0zG?=
 =?us-ascii?Q?vNS8c+u9LJV6CnMOjclcuhB4VTstAydHAi71rkMsr6TuGhcXt5ZXYUBx1y6m?=
 =?us-ascii?Q?vER3mRtBrwJKc9s1YU0JGEBmAy4SPSHRHEFA3/ogAAoacVNe+CPGPmYHeRvI?=
 =?us-ascii?Q?pIluesHrgnvS1G80LDxJxGkS2cWOfD8yvZACnP4neGadBSixM7NXvYBfPtTw?=
 =?us-ascii?Q?JXRLCtIc2VyWaCAsee64Zq0=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2d47a1-01b5-4912-9bfb-08d9b980d681
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 12:55:25.7892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QikPdr3Q/B8aiqz5dQttkDnJj1raBB2KDw918qpcqUNSch+6tTeqylp3oxuSfmYB387SQRKvSutmZG37RC5mhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3388
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

Simply use WARN_ONCE instead of printk(KERN_WARNING, ...) and WARN_ON_ONCE.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 arch/x86/mm/ioremap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 026031b..af9a321
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -195,9 +195,8 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
 		return NULL;
 
 	if (!phys_addr_valid(phys_addr)) {
-		printk(KERN_WARNING "ioremap: invalid physical address %llx\n",
-		       (unsigned long long)phys_addr);
-		WARN_ON_ONCE(1);
+		WARN_ONCE(1, "ioremap: invalid physical address %llx\n",
+			 (unsigned long long)phys_addr);
 		return NULL;
 	}
 
-- 
2.7.4

