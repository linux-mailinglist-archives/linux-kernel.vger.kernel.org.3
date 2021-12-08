Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780E846CEAD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 09:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244666AbhLHIMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 03:12:10 -0500
Received: from mail-sgaapc01on2114.outbound.protection.outlook.com ([40.107.215.114]:46816
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244653AbhLHIMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 03:12:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfvbeVWVcDton0L5Sf+eo5OBHH7KBtfuggnNqUbMgpb9RJEt1sWUTjOfaOssS+WcjjbtjQwb+RIX7v0SgJj5y540Wci6Fha6qar9U95LiceuVrdlC2ysMo3d3zt9rvGrdBfT+MONzgPP3n+fjqtbICqf4TBCE36NtrZe9+UwDjg/BOIhs2RqT+sGcoi+BkK8VPZvS8wYC5lLu+D8YQsJ6lok3GoCGctGYJ3Gwk7+wSSRmQO3zP+25kZ4P0cft+Zwtd+xkZLZS54oqsogK8ry0HIbwkH2N+hupT14c58wG1iyTlFcl86jr2SJijM/mOwMpXfBDQMZOUVL/reHEuaFsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fAGmES390m/sapoGO7auD4VRBQR5pWWFraYmUIC3c4=;
 b=mWKa34f8hD1EwM9k1IRJMx6cmRPCd2zedSyXSc0gO3H2nc4+HrNrhGGFfbB0UkpWqnE6J4S16pK/Nl8QoSLZ8+EJbKtwFO572CsmvgKH5WK7prcBLSN8zBLCFP+0Fkzs5fc45wXt+md4UgwOPyytbSYhELI5TLTTQbXYqoSlxCNyRLqocmGrxVGoleUfHRkL276zfD9S7Xr0XvX3wf16bvcnNlhWXpXc1UjjBDCBqLOfI5tcDIiMLcydNtkPiPLOWX/koOmvgVXHxfAGkMVon2dO8UTiUunBi9SxMVXZcE2LE9TGQr4sIfpjlZoV2EUH85lu7jYKR1/2CUK9AWXxKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fAGmES390m/sapoGO7auD4VRBQR5pWWFraYmUIC3c4=;
 b=m5Fz6RVQmrtr9yELJjos6DCmg898OXKD5NnhxSGEFFQvDacDci5ZNI/4uJA8YwUXqcMTVi0jhVhzYRBlI0H2brGphvQOTrOoL0iFiLSsEW7QPaZefzLcNyNVqoOlC3Sn1LWRw3F5erBQz0UfDuFKkCExEMimSTiWK8dpIunWYmQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by TYZPR06MB4288.apcprd06.prod.outlook.com (2603:1096:400:8b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.28; Wed, 8 Dec
 2021 08:08:34 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::6093:831:2123:6092]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::6093:831:2123:6092%8]) with mapi id 15.20.4755.023; Wed, 8 Dec 2021
 08:08:33 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Bhaumik Bhatt <bbhatt@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Carl Yin <carl.yin@quectel.com>, Yihao Han <hanyihao@vivo.com>,
        Carl Huang <cjhuang@codeaurora.org>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com
Subject: [PATCH] bus: mhi: core: replace snprintf with sysfs_emit
Date:   Wed,  8 Dec 2021 00:07:53 -0800
Message-Id: <20211208080816.43351-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0008.apcprd04.prod.outlook.com
 (2603:1096:202:2::18) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
Received: from ubuntu.vivo.xyz (103.220.76.181) by HK2PR0401CA0008.apcprd04.prod.outlook.com (2603:1096:202:2::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend Transport; Wed, 8 Dec 2021 08:08:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04246b55-7172-46c8-4a82-08d9ba21eda8
X-MS-TrafficTypeDiagnostic: TYZPR06MB4288:EE_
X-Microsoft-Antispam-PRVS: <TYZPR06MB4288F166D60812AA1C9E2F2DA26F9@TYZPR06MB4288.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hb9VTQlYFsZYtUV/k29zRudjkQVrKmUmjS7+zFZNSgTOtGJEjPeFVzC7pyfsX6YXDTLUG6Ge83hyzHtueiyoiWp1U+gau159ZAu3tV8CtdglSyUCZkCaVPUDWx59s+EBSQi9IUZlWVcNaSYG4L/DBOGcifLzgKqsAaYyc82Ulr5RjY7gByon9TGlUGbupSckipzeA7pNyQErXGMExQO/4JEg5ObbqiuSUn8ia6D00OGQVKHObzCRgAQ1LDkSFobvMh2rDMKqfXZKnaxZF3vFjNuU3N22JYviRFbUsAs7TDtOgo3O06jO3xwhrTfM7qaXt4AmnxfhMIm9oxzdQ6yqP9rJLwkKifTu96tvg/HZ4/5zyeP6Hwgd1Roq8WCeGrHhzj/7yqn+x7gVfGn4V5VPXbwctnrVCwy7Xnb1JruNX3X+AhMmYI71/fSsCptqcyLJzcPQWikYI6lXjUzltn4fh4O7zGt4Ipic/GlnV+mzms/T29J2GweICxNsjxIx8Hhaa/5+DKMmxbzPHk1mjfKFRS/dYFecTx+pQmP9i6iO/FIakWPRYNbIM1VkF0l7/ntSdFBBS5ExpJMwVlHdN7mzvcpIrgdNGrZFSrJv081+HKskbr8sd05MRmahliaCI7ISrMCHBts3u5/i9P3lAAubOrbekPDosHDd82hixw3oZwc4L0LGQDH4NTktM7hj6GUFxAIyMldhwhmcgvUeoX/AFg133T4hSE1mWOAQ0zS4zzp4hBAuQGnnzE4I6MJo1FHs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(956004)(6486002)(4744005)(1076003)(7416002)(107886003)(4326008)(921005)(86362001)(36756003)(6512007)(508600001)(110136005)(2906002)(83380400001)(6506007)(52116002)(38350700002)(38100700002)(6666004)(186003)(26005)(5660300002)(8936002)(8676002)(66946007)(66476007)(66556008)(316002)(182500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZlbTcySoMXqHWC13GvyC8O2Z4UDHM0n+5cTg1vBAeDiCqxjbtfAw2bwSF/S5?=
 =?us-ascii?Q?xul78hZkDtXR9gK/r1FySnOXK0GHfkd+aZcBboAHo4WuLZfqSoZ5hSlqTQWk?=
 =?us-ascii?Q?PvVu0Vc4x4uzkiBGi8jhj72WbvvmGy7zF4rY4cxELIxLRIaOff30iaxMOKfg?=
 =?us-ascii?Q?na8RSf3JZpuf8m2gCtoq+9JSzNgWdxRIZY4ydSb61ig3L6UoVQ9YMFwvy4e2?=
 =?us-ascii?Q?TF3dSb9uH+gq2EXWs9PU7Oadjc20TOgHVE7LNhKioNyrYniTi4kQ59q34c1e?=
 =?us-ascii?Q?R1ruk88A8Bo+b4C4vlTE3mR2x/F8+zH/TbY6TFj+Wb/oojmLVxHZOOuEj+l/?=
 =?us-ascii?Q?DKoal3y/kvrmS6QCkyhoilS1Ltv5K9RG3f3VFTuzvqRR9AweCANSVkvFSM/E?=
 =?us-ascii?Q?NuYdXxuZ9GaSfOoa3OKUT7RW4Qxuj2NX8+4glBRnyt71Sbp+6EHTC9s9qSfy?=
 =?us-ascii?Q?Uzv0ZYBjOEIzNU1HWmOgqQeS1GhIUT41v1m6j+b9hTfH2zQU/01SrGl9YOXo?=
 =?us-ascii?Q?RxWtxjOAeKD1qgJ5oDY+0SjmzUBJkkCHPUAL0jV5oNAzPyiwPsN4LBF0HnZc?=
 =?us-ascii?Q?HlHiCpIjMDTMZ9gcStsvh6gJFRAcx/Rdu2Qoh2T14F3Ha0H1s5QEhfoVBr0K?=
 =?us-ascii?Q?YVt9Wqk2ja0ijvROIZC/CFhXqEHzTy59VjLCWrbIgjBNsYDe5HvEQV0SXhyT?=
 =?us-ascii?Q?MeteUCYzXEEJ0jCZ7ML7VgJObL5/jJ+wE/mAoaomTnV3kX6nAp4+os49Alz2?=
 =?us-ascii?Q?TUNImusWRl6duYa21iqwNe6GVyVXZpD79GNLPv9bEZQTx37rgDyZkQ8aa4sZ?=
 =?us-ascii?Q?hFXboPOxbRaFCB6YO3V4I4w8YIY+Rf9IqFEPEQUxyyBGQsyfW23zBV/6X0ir?=
 =?us-ascii?Q?kigmNNboDeksKNP0YIj6ShpB9fDEw/aEjS6MRei14ZRxK5/FmlJiFSijCdJL?=
 =?us-ascii?Q?RczcOdje0nvT3T1U0Q+NUCWMn5soHcXIGsMY3TNUVMV2wfJ67JUBjPxS/h00?=
 =?us-ascii?Q?OQUnf1nOkiAiIFIPocVuDn3MM3DkvqsOCAtEmWrdYf4xlKF7/knImPgKe79/?=
 =?us-ascii?Q?NF5XrO22RBshq+fs74S++ACNXlGusbx2RxiVm5InBhm8EA4rqLlSigV4ElpQ?=
 =?us-ascii?Q?U9Bv2ERC/QBqJ1ikIzkUXXxNFzFSlBOPG37OO81zAF6cBU0RUmJGSSi5O1gg?=
 =?us-ascii?Q?ZMsKTMUiWsjavPPVog9L3/HcPORkebLw+P5YAk30ss7eDoXAGN6uLjKHRTLi?=
 =?us-ascii?Q?9KSGnpL6swqwkkWJti/sMCvsZyp+chgzDCu5un1UER8TqBMNSkEno8tatWl7?=
 =?us-ascii?Q?99d39XeavPzg/x+EAipa9Kshkx5cuYkqTFIpUgKTHiXul1TKDrLp3/xsJEA0?=
 =?us-ascii?Q?WnHE4264YdQd9BrILuFgX/xzwWACStvtglgzkxbjm+0kkOY/WgcBMpQrapd4?=
 =?us-ascii?Q?WJjdlMpFzoNTP2n/7lrn8njDUB+b0/mqesRI4+nAPCiLcWfmTKgpuJgQyJS9?=
 =?us-ascii?Q?jAaNvOFL/p2OpD4RKwjTnivp74rYo/0Mn+AwfZaBP1Jmcuwr2LW6L9F9mOyz?=
 =?us-ascii?Q?Rp4Up/dTc+R42Yy7KB9YvsrKrr92j0HI73+yi3AKoCjuNnVCV7CFzdpB8uON?=
 =?us-ascii?Q?zXy5qNp+U169WwR89+tJF7M=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04246b55-7172-46c8-4a82-08d9ba21eda8
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 08:08:33.7694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6SDnejJSSAoOe0SRxi2doMcQBqVAP3kqbuognTjSdDuFwgOKzk0sv5b6fCXKnHehNs3TyO+2EjZ/DRYyIvOkZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4288
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

coccinelle report:
./drivers/bus/mhi/core/init.c:97:8-16:
WARNING: use scnprintf or sprintf
Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 drivers/bus/mhi/core/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index 5aaca6d0f52b..a5a5c722731e 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -94,7 +94,7 @@ static ssize_t serial_number_show(struct device *dev,
 	struct mhi_device *mhi_dev = to_mhi_device(dev);
 	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
 
-	return snprintf(buf, PAGE_SIZE, "Serial Number: %u\n",
+	return sysfs_emit(buf, "Serial Number: %u\n",
 			mhi_cntrl->serial_number);
 }
 static DEVICE_ATTR_RO(serial_number);
-- 
2.17.1

