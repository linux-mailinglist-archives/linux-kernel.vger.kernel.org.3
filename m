Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D943048A865
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 08:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348526AbiAKH1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 02:27:23 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:58866 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235312AbiAKH1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 02:27:21 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20B3TIcS027035;
        Tue, 11 Jan 2022 07:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=R1bqjfuceoBxlxOHJgXYAOmyuuTUXr4lmIc0c+pCyJg=;
 b=glWqN7HljZyNtFQqigiNOpYzAZI3M5opIDa9QfXS76ahbcQYdO0j5lF/2XoJ06Sxffm6
 5TuLyPBw9w5Gx71rUPWBsGTNCqExOPzeLZLJAvHCm0wjUpVZtdJXFlfoQVfCoF90/obT
 C898nfK2qc8kPeNUNQH3hWN+sKVoYgd7QV5Y4f+lSryEJJWgCpOa+rvkQ1QfeW71DLD5
 TzUr08xZZXX/OKAtfvYttgkm6FkfCS7CFSnlBzX2kv0ljONqs5wyVfBhGWbKH78lmiOI
 JrqBcwaq860oKXoqO+dPiB/GkaLWNXa2comXkAl/UEO5G8zQkKBrTJMW+MR6rHdEix2O /A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgn74a7jy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 07:27:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20B7G819081720;
        Tue, 11 Jan 2022 07:27:12 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by userp3030.oracle.com with ESMTP id 3deyqwpd62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 07:27:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nek3Cv5WbFBf2AcRK4W4aRbheM0cisz4aHQYVLNlZiRwP3Wv//AgZ+thlaMsaJyFy6t0ocvvR5k9K5ieE+Uhamu0HASek0aCVdbKbDiW643W3vUgP59EJMi712eBNE6yG3irlvhw3Jo8CUPct2e1cQk4AUwzmFyZvhSc79gapwozqUCmAgZKvUUT2tBnMguDb19HGMyYljLz2/DqlAMqezRzZU1VdkT3guaFcBgUJTy9nwP2P3sJ2PXtPAPSgk3gWm2bMvuflzH4wctrm3GQ9u5uctyFkw6rIIbxIEiaT3GFD6x6KZN+Dw0JweYaPlvqOkHzxRFl7ch0swsjiN6BfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1bqjfuceoBxlxOHJgXYAOmyuuTUXr4lmIc0c+pCyJg=;
 b=DiIZc3ymP2kIzLs8y3gTGKanQkHI1X+lpI688WbsJtm+J5r/PmjXD/lMe4t6HzkOi4MQrXzf0iK/Rt3PuOjgK5bfDmAzzLQFz7O3eB9oQ+rJgwf3lSuhMeUUU/jLOnfp9RiLSMMCPetwpWqZ9Mi3ParVv0vPfVlV4R/FbYcC0VPFyhJguYG4IC5yZemxVcdWkDlzI23KnGcQeGhWEe+xVOu3WbwKEdhm9PhIofrF1o1YNbQNnXeu9KiGosx0Mn8Mq8kGbU0tYpm8GQktE7ndoaZr37Jp4j9PrZdJUU+0tDvBxknDwF1CpcRndNFJrDo3ZpMAAsNrUzxMLPRC7hJNKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1bqjfuceoBxlxOHJgXYAOmyuuTUXr4lmIc0c+pCyJg=;
 b=DhWDmeD8QNv4VbMJUdM+XUBO82WYvp1Hc1vu66urNNozjBGMv58OnppzOU15NlE0eWJDVDoxknSEYG7T/U4h9ozodhYVKjAX18sEOr26EubFwSAzgpG+oovtFIGqzExBnE/1UTEcrFGlO0d/2LtXSRKy0Cz0M0Zj6OAzAqijXe0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1824.namprd10.prod.outlook.com
 (2603:10b6:300:10a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 07:27:10 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 07:27:10 +0000
Date:   Tue, 11 Jan 2022 10:26:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Watson Chow <watson.chow@avnet.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] regulator: max20086: fix error code in
 max20086_parse_regulators_dt()
Message-ID: <20220111072657.GK11243@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0196.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::22) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49c1eee9-abfd-4ac9-8c54-08d9d4d3c76e
X-MS-TrafficTypeDiagnostic: MWHPR10MB1824:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1824337119F4F6EBEF7A98FD8E519@MWHPR10MB1824.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vMa515bblFvuqoX31SQ9CuiErtaOaLSVXfcwKhY5+n5iY82JQ/uPSwDyGeMQX1loYPpr4nASiw6IT610PZgkJSxU2fJ8yJZ9yb3JEhAUz/V9gmGCGuuOj43tvU6euc28YqBmHfqtcUcw5XXvmYFJ8t4z7tNEa8/F3lQctFYGL64BjLzGEwX7nvmQpe9laoUUlgqwzREKE6UwU4bA5kimqJn3mr5k/lmXJvuhCrVskWpPlV/JmntH5toeSm6tCsJVilgQL2GhyOGhF77tlxxScj/DF4JmzP5GCWTaRBGcwx6NKAXuTuV5eNRSTRwq2kbvI4wdoaTRZvTM5HZxDGnb1RN5ohhDXtzAYlmbXitj7NMsaGc2DVHjgx8y5Fu2K/64nBYrqOxDzce4FWkVInbClu7REusEr7yd8W7N+BXNwStd7p3PVnpQceIE+/jdYq36YC7qimvXyaovmAoT8hj53TDwDbO6c49OnT9n8offrsvdvu0YdayQz982wCbdGzTCVJcqhnFantOksK1C08kRyxlFPPi4r6XaBT28wCjxYm7Jep1z/69ZC4Hvr7e3QmvqW1z1FwcnS9SNlUY52Svyb8is8778mzVW1NcgFKzjg3Nbbl8V6wIa7vGS5yN2Tvdqel8sbPXXxdiVkWSKJnyNYDACtEzMxVDRHacLiPte1i2tJZmdBGj6rjYZ3swX/N4gUmY1HujkrnyjOWqyTcxrXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(33656002)(8676002)(1076003)(86362001)(5660300002)(4744005)(38350700002)(44832011)(38100700002)(8936002)(186003)(33716001)(26005)(316002)(110136005)(4326008)(54906003)(6506007)(83380400001)(66946007)(508600001)(6666004)(66556008)(6512007)(66476007)(2906002)(52116002)(9686003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hMxJa5Onon0vD2YHolW3CjRnPjLOfJiJZSZNyLXE/cSKFB6aRupFHcEEpoxq?=
 =?us-ascii?Q?X5xTDkwLpHClx2CTsbEc9vZr6rp4HtG/keAd05gpoYu/JKdlFrrcO2HPZkGU?=
 =?us-ascii?Q?ooODQBesOG99pQnq6Zl2Qz5wSvoVIvir3sFuhJtN5NEDKq6WgFEq93a2WCH0?=
 =?us-ascii?Q?L7eF+ByvZ0MbKpIrI+Tf9Hj9zBt1qpljez6Pr955ySjKTLLY6Y/Rh/1iaUdl?=
 =?us-ascii?Q?LlgSYeWB7GAMeD49Bfz/hJgbjDvpg/g4lpLKi9ukG6ydqXexC/hEY7fIbQl6?=
 =?us-ascii?Q?PnCePhyAYI4LmqSS+I0YC2lGSigQ6Lc+I2mXNSULeWk4g+5uqjlSpF79tugu?=
 =?us-ascii?Q?mbrcNeDrDi5ve3MlhEIDRfj+iO9A+5phJ1yPSusDNVJI2UOKrQph6iHVVdL1?=
 =?us-ascii?Q?YbgGswmQIFwA1BRU8YgpVZRPjKeucG21vvfcRkELGbJKDWSrnDDRc2cUF5mG?=
 =?us-ascii?Q?RVL3Ndro1aYMqMfIKhL3zceLwqG5TKDV6SHs78mWZpCp7Vi24TuYAp93uY+2?=
 =?us-ascii?Q?Y9qHJjDKmDcvS97UH2FqtySluaPmpDGTNtw7if9YwYc7LaEce9663XpppLrq?=
 =?us-ascii?Q?S1rX/f+R7Sm4BxFPopek06DXDS0BACo5TxeF2xd2pHIe+jYiFXdGj62OqVo1?=
 =?us-ascii?Q?ub66wWYp/keIVDUz74TSzBaccMcyVG/0TJYmXDuwniZzvYpNa0nLklhp02St?=
 =?us-ascii?Q?65RJdk9WWRSYIPfwKsqNEmlMoHaTbTx6VNxKuxwjRUaBvfSdLCoa3WdN9MW6?=
 =?us-ascii?Q?5/g5IP2UGh54vfSghmJJeXr3h+jF1uglOPKhmXRqv5aWEwURVaByGKYW3kQ5?=
 =?us-ascii?Q?lcdijbVtOrQlIGDr91t4Cu1XMNypDulJrupkgydwCnFX0zNVsV+WcBA+i4Ej?=
 =?us-ascii?Q?Pr/YPc5aUbF0l5yAaa5Qx6v8HoDLc+dAhux2jSwuR3dfU94PufJWgz3JpuAV?=
 =?us-ascii?Q?Fp3pzr/W1dYdwevzDVvocltE1D/gH5JPqLtSk2I6YLTjRXmD0AtpUBnDXNVn?=
 =?us-ascii?Q?CQeUYfwJNot533cmgD8Toen1YggihpV8VcJpPxdVD7VQmJEUuAEKK/0qkja2?=
 =?us-ascii?Q?R3+Bl2E5MbywahsW9zbuJ5ND0FvqogPaGzpIthQ3L23eJM/sFv8jvA+shb0Y?=
 =?us-ascii?Q?OBVsH1V1JYsD7Or7hP4ejC7BefCAhjO9ZNzoSd7IXsoa3uApLyWbdDn9FgNS?=
 =?us-ascii?Q?/gzBuLQfSSgwOfplqwqBuDCJabOthH+XIoZ7ASfQjiLPp+nw7GjPkaty2Nvm?=
 =?us-ascii?Q?6aDST5A8xcX96rvXw4d3ZDEczAvZLtL5B9tU2/3eUSvd77t0fKjFPmj2CeEW?=
 =?us-ascii?Q?jyIGSwhrz25taGMkO6KDybz/CM1jL0xa0UslvkXmtq7vJy/5uOy7KtOspMeM?=
 =?us-ascii?Q?9OMY85PFraNlGBmOFc9ZgMC4Enk9RktpG7BILxp0MHETuSjSLKY8G3VPTlCD?=
 =?us-ascii?Q?eenw2UeWGa8iIiLnJuaN5Pm+7kByqphPzlL6TJv7oq8AQHA9YwS/s7zv5NHJ?=
 =?us-ascii?Q?rKJYVw8/N+GeFl4TqiA+xY7K3iXKMe5P5koF0n0RPoziY5hw5A71n9Jo650r?=
 =?us-ascii?Q?lVR4Yj4kz322L2E+ggO97qZCZDRn7apIO8LMwNTFjjaaY8upVMuvo9e/KFXt?=
 =?us-ascii?Q?Ybgny/dj3imoFagU+UIT5HnzJswVshs8Cxlmb71DM3VUaW1lyKQbjcFXQZr8?=
 =?us-ascii?Q?HEZNXcAPfFDlORGpa9dEHfOCz/8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c1eee9-abfd-4ac9-8c54-08d9d4d3c76e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 07:27:10.1390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wmi9id7k4E+24YMH9dJ8oC4gCC6n/xcCc4Ftft/ERbjR7bMBFypUagJZUwF+AV9lHRwgrvQgZQsKsXvlAEb6VoLGlkfNVSWbPrr3+SzMVZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1824
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110039
X-Proofpoint-ORIG-GUID: yYrTE1_7jRqBJJnaX92ptQNuGWHeZBVD
X-Proofpoint-GUID: yYrTE1_7jRqBJJnaX92ptQNuGWHeZBVD
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code accidentally returns PTR_ERR(NULL) which is success.  It
should return a negative error code.

Fixes: bfff546aae50 ("regulator: Add MAX20086-MAX20089 driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/regulator/max20086-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/max20086-regulator.c b/drivers/regulator/max20086-regulator.c
index fbc56b043071..63aa6ec3254a 100644
--- a/drivers/regulator/max20086-regulator.c
+++ b/drivers/regulator/max20086-regulator.c
@@ -140,7 +140,7 @@ static int max20086_parse_regulators_dt(struct max20086 *chip, bool *boot_on)
 	node = of_get_child_by_name(chip->dev->of_node, "regulators");
 	if (!node) {
 		dev_err(chip->dev, "regulators node not found\n");
-		return PTR_ERR(node);
+		return -ENODEV;
 	}
 
 	for (i = 0; i < chip->info->num_outputs; ++i)
-- 
2.20.1

