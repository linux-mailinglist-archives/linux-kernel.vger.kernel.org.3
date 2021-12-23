Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35CD047DEF1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 07:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346568AbhLWGL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 01:11:28 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:29462 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346560AbhLWGLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 01:11:25 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BN3qOPO005437;
        Wed, 22 Dec 2021 22:11:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=lJ9APA/34eI5B9CvFGyKfrTut9E+AyzRIvFFkYvjYaI=;
 b=qQOQYWQkMV2XafP0tanTKtc1IqKlyglJqtdFSD7gE5RBOqi2jo2ydCgXB9GbNZ5t5xVI
 dAif69UPhJBFjmMST4v2F565DoIOmOg/lU+IXgCCAyQEPojOztYE15354d3XabN2K7dj
 gJ4ECOc/S9oV7KefbPDjsSDSs15PXN0GPFVj1A4aWwDhiEA+aan1OgdEB2IQrwF5YHN/
 S8i4Nl5caXs9DqkLRV7cjQxn3w15ru+G0zCsRAf/XtszYBioqNu+f077F4AxwhBaqjfv
 AqLtktVmMWR71qVkPFSFc372V2MtlwKuibD0Yd233SKSIcXiIb64otI4iZZ2W1/SZuuZ Wg== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3d3rwxvkat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 22:11:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6/C2aIaAAdBXtERqAZ7KqgL6oRcdpAhwM/hDpV8BSokezfETE20OvMMgho7xldex2EGZGV5EwILmpP5TS3vcaCItbu6518WZa/dR9Og7U7ZwjBcoKSXEDWFkIX8J9MPcF/s7ROzcCUpFKG37x7J3C5aldAL2XcTtdcC7n8C0SBeff3/FfYJRv2QkF8sl/V7U/5gF7Ch+mhVdllvX5rTQdNQVSkHd8VETyNKzD5aAadtnmGKietFi/yps9w3RQN2iHRSyFnhDnWQUZ3kuyFI+jxc7NQo7OAj5YPXI7eRst7ga8p7nCPxEdy15Hf/THNf+lQkTS2yzNN4lNrcgoVHKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJ9APA/34eI5B9CvFGyKfrTut9E+AyzRIvFFkYvjYaI=;
 b=XL2jvHmzSJwlFxJapSgGIfI2BSLL6+85+EGBvYZKmCrFH6XZ1hsUTH37E2Vse4hJyJFIxJGgBb8+7ymAmqY0MZmNNo4vKf1UcnBoO9cHlDPFOnR17N0onWuQviXnrdp05sWuWefv4+s9/arBThnwDHuyFxzkdH7cwc8kMTVSZPyHfgS+QVNnDxHoUccn0O4O38RxLotWKTWYtVzVcwweUdT6OJR2COtr8Pi3MP1XimlZbE9K7ZFr4eOYRTj9DighCSw2Ckcf9xJipcFQgztHGxy/EGInV09FDDCN7ws3pM2SP39LGR8JkMlCGV173iRyHsITVUgieY3dRGAAxHWamA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJ9APA/34eI5B9CvFGyKfrTut9E+AyzRIvFFkYvjYaI=;
 b=OxcdD82uWKsknJh8+dCNzH6c6opj7GCI+vOuFHeVPmeIEYihpnC4lZTrAEKkhQjyRgMfki+mq+6A4mQb4X64jsO0Nn/ypIu8B8PENFvYSWAL1pcVuQ6bcycH+r6BBcG541dmefulfeHi/WAvGopZ3/FwLWXKm8RwAyVbcNDz5tk=
Received: from DM6PR02CA0101.namprd02.prod.outlook.com (2603:10b6:5:1f4::42)
 by CO1PR07MB9066.namprd07.prod.outlook.com (2603:10b6:303:151::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Thu, 23 Dec
 2021 06:11:13 +0000
Received: from DM6NAM12FT020.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::1d) by DM6PR02CA0101.outlook.office365.com
 (2603:10b6:5:1f4::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.17 via Frontend
 Transport; Thu, 23 Dec 2021 06:11:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 DM6NAM12FT020.mail.protection.outlook.com (10.13.179.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.7 via Frontend Transport; Thu, 23 Dec 2021 06:11:13 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 1BN6BD5N018996
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Dec 2021 22:11:14 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Dec 2021 07:11:06 +0100
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 23 Dec 2021 07:10:53 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 23 Dec 2021 07:10:53 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1BN69Hic016570;
        Thu, 23 Dec 2021 07:09:49 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1BN69HnR016569;
        Thu, 23 Dec 2021 07:09:17 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <a-govindraju@ti.com>
Subject: [PATCH v4 05/15] phy: cadence: Sierra: Add support to get SSC type from device tree
Date:   Thu, 23 Dec 2021 07:01:27 +0100
Message-ID: <20211223060137.9252-6-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20211223060137.9252-1-sjakhade@cadence.com>
References: <20211223060137.9252-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1de8848-7d5b-43e8-6bc3-08d9c5db05bc
X-MS-TrafficTypeDiagnostic: CO1PR07MB9066:EE_
X-Microsoft-Antispam-PRVS: <CO1PR07MB9066EB30CBC049F9A9E0116CC57E9@CO1PR07MB9066.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:206;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H0whvJuu6XwWop27eqcomW4c7YzvqEhq6atc/PBwDFp3mGplRYXX2tLawCJzK6frtw+6ozqTd7D62zRq0vp9yvrpIdjaMlx6biBUjBhzt0AmkLV4Zzr6R9nK2AHJ1Cby/rVhqvdp73LSvrnm5apQmEPWDxwiaYpEwERNUieuevt9wnLoKIv3fQyUZ0CiwwKJFW/D/u/k9Hs+icFdZqFgWUIoMQsis0Jy9tyIEBTGFxg094rkJPeyOCBQrn0PvO5HJh9JUkAQmKvuMRaaf0PhiKN9Z1ZoG++V18nEA6fQntZdRzGPSGWMwER/t/BabVnrNk95+F65ZAAxtavdhbUl4weQdYPpLEn1LZXFyQ9IwzgpAfQJmXlICb4K7mdp5oCQ1iWyUMW/et9ab0AoOC5Pa/IrmztrFtQ+svL7wjeMYHgpBRkliidtp+RqMhCksPOU5gcp5k4rLy+MWAdbVDdi9Qu1p6EfZNYulmWxEi2e1aAosq3HhA9FMGmOEIVkIs2svxh/Nqr6fjgY2xPcVadcxmZB7SDofK7nH1rVVuPgiGbb2UmLlDXT3rxTdBN3eoaBTI27LMmZe/6K/2NFC06CS2woHsKHtMJ8idEGDv5KZWixxHx03zOwvEnwI2VL0BtF995BhUQT+mU1LKXYMdU3Kw41MTubydtKp2R5rqg+rZEyFMWNVXVTpI4Dnq9h1rz5zGtoX3u5VlMBHT/yyt0kgoFXBMVo+Fk9IIeYbd99K2aGcwStXq3vGQ3LMnTmBPSklT7D/HPNjqtI09KnJnf7IoDib1rtFoEECyqSeRPACcE=
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(36840700001)(46966006)(40470700002)(186003)(36860700001)(40460700001)(1076003)(6666004)(36756003)(8676002)(47076005)(110136005)(4326008)(82310400004)(5660300002)(336012)(2906002)(26005)(2616005)(426003)(42186006)(86362001)(508600001)(70206006)(70586007)(316002)(7636003)(83380400001)(54906003)(356005)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 06:11:13.3442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1de8848-7d5b-43e8-6bc3-08d9c5db05bc
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT020.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR07MB9066
X-Proofpoint-ORIG-GUID: GzavaDypH6UorfMCMmHL0zKvIh60DDA1
X-Proofpoint-GUID: GzavaDypH6UorfMCMmHL0zKvIh60DDA1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-23_01,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112230034
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to get SSC type from DT.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index c82ac6716f5e..4674328574f5 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -238,6 +238,7 @@ struct cdns_sierra_inst {
 	u32 num_lanes;
 	u32 mlane;
 	struct reset_control *lnk_rst;
+	enum cdns_sierra_ssc_mode ssc_mode;
 };
 
 struct cdns_reg_pairs {
@@ -360,7 +361,7 @@ static int cdns_sierra_phy_init(struct phy *gphy)
 	const struct cdns_sierra_data *init_data = phy->init_data;
 	struct cdns_sierra_vals *pma_cmn_vals, *pma_ln_vals;
 	enum cdns_sierra_phy_type phy_type = ins->phy_type;
-	enum cdns_sierra_ssc_mode ssc = EXTERNAL_SSC;
+	enum cdns_sierra_ssc_mode ssc = ins->ssc_mode;
 	const struct cdns_reg_pairs *reg_pairs;
 	struct regmap *regmap;
 	u32 num_regs;
@@ -623,6 +624,9 @@ static int cdns_sierra_get_optional(struct cdns_sierra_inst *inst,
 		return -EINVAL;
 	}
 
+	inst->ssc_mode = EXTERNAL_SSC;
+	of_property_read_u32(child, "cdns,ssc-mode", &inst->ssc_mode);
+
 	return 0;
 }
 
-- 
2.26.1

