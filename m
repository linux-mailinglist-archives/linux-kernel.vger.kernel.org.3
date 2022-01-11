Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62BA848ACE2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 12:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239152AbiAKLpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 06:45:38 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:40048 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238505AbiAKLpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 06:45:36 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20B7LpfX017740;
        Tue, 11 Jan 2022 03:45:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=J8PgVwC4bAZOxd+5Pkh40z6NspU+nTDs/UgN5wBXvH4=;
 b=Ox7KSynJwvM7+KCpLPiTyi4sSQIY+a+yftTPa2rpZfuxikCMD3KISofSU3eZ4lE24nnj
 OB7z8Q9yO3anYqxqPXIoQydukehNnBQKofnGW2hiVpFxhqmCSoO//sHBadmCgW8k0gRC
 kypjIzEmKoa8tj6hGDz+YgobPmO94/4zZEsVJROIkT7b67TSNOR+N8bAA7C4Rce51is3
 3AVjFg6RKGDKDiKGnZky1YXfTZecmGQuohs0QyCPobuWHXy6v4ITHJWonZcq3WOO2+HJ
 VeCnBDc3P4TVfPbtjnKYdoWvWW4svUyUXTSMzbDBCvGIVX/w+QEnqUrV7EtLNVziqo/b DQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3dgkxpkw4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 03:45:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8LfqUJV14HxAJHQXkmVO/hXLXKb3+6L4enOuPttZToiJKT3ZZD/MBteg/2+4C6Sz39NgYUD2wvch3CXcMvZUVERud/uo3tq4M08pzzkGsD1CcsvVxR8te0dh4pQM/00FWOp/Js4xlX0RyuAAMdZO1qLrTZZH4I+kNcqnTDf23VJZj2fKy90Lsm4BODYROIk5oVgXLGuZoocKgwITXhUO0QvGd5TuIaJCpqjxar0zDWRlDUks2JFHxbx6BOudPO1GyWzNnYxMFT8mmTVlgfKAtnqz9ESgqotZAMM0M34s5kVLoB68wNWfz89YJLKQFQPHuytqoVFroz2neiKKkFUmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8PgVwC4bAZOxd+5Pkh40z6NspU+nTDs/UgN5wBXvH4=;
 b=kDQJY80imYJ3PgR957+p9vIbjgGdeaqStu9XoRHjw4W7nV5kaZyuGf0Xy/DEzm4DSt+nqpHWLnPIEALligzXJwm/8h5vpDJKcPAftIOGuQmDigrDZWUrjBhiCHacuhMi5sC5IaD2DQx6zjzXgSxNAUNrhiwFAzSVHdEu075lXCze6Yvc9Xzn6/7VtfQSo52ZXxRCOj2zBqWuZ2TS3MJ6nrjBf2GKw/B1pkxX6FJPk33z2AwtUBdOOsMmdpI/O0bSGd9lvVJy0q5jcePx2Ty/l7mJQF2HEYu4se4ompwPklc3zCXCMK1wWsi94LjzBRXgJCuC3DzDp7DZy7aaP3L7Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 64.207.220.244) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=cadence.com; dmarc=temperror action=none
 header.from=cadence.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8PgVwC4bAZOxd+5Pkh40z6NspU+nTDs/UgN5wBXvH4=;
 b=enaTmgUsgXsVKGx5tVMwkU8LZUmtEnEsf4Mj0yfBGCydIEJix0u6QXsgm29DkN3RU+IlrCTrtJMQic+radAW/BoTc2TrY8xA9AxeWgwpUFYIMjWmFpuflHSc1+GKHYPj2ZQAiB0OnCU57jOQmXKT/pMsopdbCoCa7DhUOjb11ew=
Received: from BN6PR13CA0045.namprd13.prod.outlook.com (2603:10b6:404:13e::31)
 by DM6PR07MB5065.namprd07.prod.outlook.com (2603:10b6:5:1d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Tue, 11 Jan
 2022 11:45:30 +0000
Received: from BN8NAM12FT017.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::d3) by BN6PR13CA0045.outlook.office365.com
 (2603:10b6:404:13e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Tue, 11 Jan 2022 11:45:30 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 64.207.220.244) smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=cadence.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of cadence.com: DNS Timeout)
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT017.mail.protection.outlook.com (10.13.182.170) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.5 via Frontend Transport; Tue, 11 Jan 2022 11:45:28 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 20BBjSES084882
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 03:45:29 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 11 Jan 2022 12:45:15 +0100
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 11 Jan 2022 12:45:14 +0100
Received: from gli-login.cadence.com (10.187.128.100) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 11 Jan 2022 12:45:14 +0100
Received: from gli-login.cadence.com (localhost [127.0.0.1])
        by gli-login.cadence.com (8.14.4/8.14.4) with ESMTP id 20BBjD4Y045134;
        Tue, 11 Jan 2022 12:45:13 +0100
Received: (from pawell@localhost)
        by gli-login.cadence.com (8.14.4/8.14.4/Submit) id 20BBjDfd045133;
        Tue, 11 Jan 2022 12:45:13 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <pawell@cadence.com>
Subject: [PATCH] usb: cdnsp: remove not used temp_64 variables
Date:   Tue, 11 Jan 2022 12:44:49 +0100
Message-ID: <20220111114449.44402-1-pawell@gli-login.cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b62cf762-5d9d-4ba1-43c1-08d9d4f7dda7
X-MS-TrafficTypeDiagnostic: DM6PR07MB5065:EE_
X-Microsoft-Antispam-PRVS: <DM6PR07MB5065F81591BCB8FFEDE7FCA4DD519@DM6PR07MB5065.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: spDIMKJo1Z0oanYMKqL6aBQCDDiKJwpA5YuLQD5wm/6KnbW+th41gNFwYb6kbJ7b/c/Ky/6rCraNuaAkOWL7GU+7O4JhPMLN/NmSmP3RS6M1K+PnSx0FvFB8C6CAl82FD5O5VDoUJsK2pkt3y+Y1FhsO8GLuD9JNMc5DpdZEqB995VYchZXqXop1/jLzNwAz2GRTNuCEp2EoSXuLrzz7kKsblv9rxWsc2iUcps3HWHCBTZ9V3NXB+WfhOcjFAfJ31CzGrtxj2M8jk/DtNb2N8JtF2EjD2GaV60W31y0bmpED6PXAZvGJk30OEy7eGeqB7g0wLacinvvMjHRL0Rb1yB5E1/G+gTk8CD1c+5SDucqiaje/HE9DtJtt3xpErdcfiHm81MkavFBqdZ5OMVqqw/NU2Sw8HiLpTXIqaILLNUsUB0nMgYA8lUKntm1d91IYjTjtcwg5tAQ0uAnahQrWEiFhlYOFmfsASOX5UIXQvW3fOC/MPbWnnW+563tzxWm3/0nUC/OB/0zK9r6VnusJ6Fl+41sZftdzlNd+jhi+ZxSyPLhnmOGCTAVCn62LKG2Wrk5vH81lrlLbKpZzqe2OuCbMcUz4NyPazbZLUrd5/k0UnCCnXkbyP7CK+/OF/BWzRofmu5fauyIAWaKrjTuKfaUZJ3y01CXIZXlc6VoKABhDypsH/SSw3xV83rmIIBoYv7uIWUSepOxte6XSXXXoVs2cM7OXNFtcs34AWv78+ZAFbjyLruagXW6NoS8mDh7rqya8ijdBWS4G3KEgksfOg+Wq2tu84HIKKVOmdQD+hgOLjxmnddQcEuq89RQacOaEska2lrw74+CMrzP4BZppvQ==
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(36092001)(40470700002)(36840700001)(46966006)(4326008)(5660300002)(2906002)(8676002)(42186006)(316002)(6666004)(83380400001)(356005)(26005)(82310400004)(81166007)(107886003)(47076005)(86362001)(426003)(1076003)(63350400001)(508600001)(70206006)(6916009)(63370400001)(70586007)(4744005)(40460700001)(8936002)(36860700001)(186003)(336012)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 11:45:28.8966
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b62cf762-5d9d-4ba1-43c1-08d9d4f7dda7
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT017.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5065
X-Proofpoint-GUID: OQcZqJyvLVHo8haVMAxbTvc9EsKDnCaM
X-Proofpoint-ORIG-GUID: OQcZqJyvLVHo8haVMAxbTvc9EsKDnCaM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-11_04,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxlogscore=673 impostorscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201110070
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pawel Laszczak <pawell@cadence.com>

Patch removes initialized but not used variables temp_64
from cdnsp_run function.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/cdnsp-gadget.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
index 27df0c697897..ec8a0dc792bc 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -1243,12 +1243,9 @@ static int cdnsp_run(struct cdnsp_device *pdev,
 		     enum usb_device_speed speed)
 {
 	u32 fs_speed = 0;
-	u64 temp_64;
 	u32 temp;
 	int ret;
 
-	temp_64 = cdnsp_read_64(&pdev->ir_set->erst_dequeue);
-	temp_64 &= ~ERST_PTR_MASK;
 	temp = readl(&pdev->ir_set->irq_control);
 	temp &= ~IMOD_INTERVAL_MASK;
 	temp |= ((IMOD_DEFAULT_INTERVAL / 250) & IMOD_INTERVAL_MASK);
-- 
2.25.1

