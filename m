Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CB749FB5D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 15:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347933AbiA1OJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 09:09:54 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:33738 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346969AbiA1OJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 09:09:52 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20SCwlYV023006;
        Fri, 28 Jan 2022 14:09:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=01/2NcrmF9qS/+2qLQ6u+jmLyC2Wme3VgR/gQ6bhdOo=;
 b=x/bf1zFL0qCL/S9+Cez4L1hJPPEaZLacTprNR+AR5fz8HHbrLw43Lbso34/mdOuO3Sdw
 ky93TxE0BbfAibfOtj4FEGhv7syTRPeVRsM844LXe//taE5jIl17UZEuZTRIwN94KkYu
 buqRXtgU9D7wGBMKDJCKjwlktN0zcPgxcqkWENtMl3xgaptKWsLQNJaqfY66QBVQAWkT
 N0gB/LjwE8TYMjW8Td0cVkAGQUSz3mVi0XZrbfZBU5/aFdfRzi7wex30bqdCsXoSQu+m
 vo77ffDuy2D0jkNWc8vdocT0DMiG3e0cLVv2QZotC3cZvO5P/11NM/NSe5FqxBjwgb2y +A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duvquud9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 14:09:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20SE5Asf168578;
        Fri, 28 Jan 2022 14:09:37 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by userp3030.oracle.com with ESMTP id 3dr725r6n8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 14:09:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpRdr+QbFsdtl5/jC1ANcjHs9OodLhBosI0pQwHofvwwavIPgBYF10JRbDsG7AXyk50qugWrBguZJIzHef9uUKoRQIQQzk6ZH8KDsDxMweYtLJMMl3absI+RJuVBNd/ewJgxD8Jztr44GO9GLY4yHTRrMnTgJXtGHJEEYI22+31YAGqxCVik0eL62UwfKtHb2zvFaGG9VUWY1VXh/RpcbxkuutiS5ww/zwSiHINWo2AEx4zqb6b+9vzkUgdUTZVvkdSiv3FKUfms3FB7h9b8R+brL6KBPKDNUL8wJ9kA+WTf/mi6FmF9RVkQGJp8p44KbR+00MnOVP6otTLHkUYbIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01/2NcrmF9qS/+2qLQ6u+jmLyC2Wme3VgR/gQ6bhdOo=;
 b=HQ51lAIDXnBrXsiHpBbLno41rIkj8opSa67IOQlDXeZB3NjVHDe4VA6LoPR5Up+QDv+D+EA1KMthfFOAtY0N8zuou0mIEFyBk+CuopR28D4vuPdMO8ruXbHRqzxgbZgcN/IQBAQUlE1uYpAdKOCWbarmupNwKFTmqrKzqgdpx/U9NCEhbXwbxrxqX6VRO0rspTZZmehmGH19iq7uTdT2buImK8WMHuyULRVIk2OmMzzVeo6dKmVpQEiV/8olv1kuMLN5KEt7iWWLZP9XaHu63JDxeu1fE3sRyad7fXSx5tidy/Zdm3Y/j0y1rS9hdcpjCv5O2eU74NADjdtM482Ujg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01/2NcrmF9qS/+2qLQ6u+jmLyC2Wme3VgR/gQ6bhdOo=;
 b=gTWTbxKN78Gm0Qd6zhjNO14joPytlBcto+9i7gXsRBAgRWy4nwQiRnY+GX5Zg+Kc+Ezct+wDSrGNmWQvbZOzF2hQx5MzqqWsOY5/GW3RF9va8PcyHLTgpeVPG8GwyIchAJQW4pefmi/xohKUBqJixxmdNZp52aE5XNMGlWzNVVc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH0PR10MB4939.namprd10.prod.outlook.com
 (2603:10b6:610:c0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 14:09:35 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.019; Fri, 28 Jan 2022
 14:09:35 +0000
Date:   Fri, 28 Jan 2022 17:09:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] fs/ntfs3: remove unnecessary NULL check
Message-ID: <20220128140922.GA29766@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0165.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::18) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5229d1b7-ec50-48e7-6cd2-08d9e267d028
X-MS-TrafficTypeDiagnostic: CH0PR10MB4939:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB493950E37CE285612FD396248E229@CH0PR10MB4939.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1RzDlVtmhGxEjp/0VWJOQ7otYHeCkruOHP0OA9FrZK3T2izuCtIV1u9Fg3zdygHmgfg+PrQYosvBUn2hfllhMfkNkonjlt1kN2OLHEPU/G46VGEM0pENBRVjm81ADOillITlAr2bdKyrmbqKr7EQGaAUczWWlYzTDXxn1mYaG6O3kpFfT777ShvCIHJy0tKh9RsxHvsXsYhEoUtJMBqZrMSO8bofrvI0aw4Ci6Qty8LWX6v6sVMr1GOLSUcKvc7L0vGb140ZvBcBeA0VcwDzhmsSLMhS5Gq20vKPcB9J0NpSXi0b+4jR2hct8+ddNMTJ7U80YhukGmP2EUXZkK6C7nRfWfka26u3XBdd2sElPYfnBp+H/33bHaga3gvYfqgeEeGMw6WPojYbDWEXXRLcRXhGqasGMGr6AgVN5WBs/++GbNKEXdVVzEVel3FCV9NpHLeEu0/BeZLJty+ROrtTUOj7J6xAJaCDkzLHdqY7ypISKe2qUZ6aid0lQXFQ+VsXOD6VPGvnzYYSTwGQU8d4cPeC3yoeZ6yHIvRuEPeRvDMnDn9MJ5cUNmfdYfzKLYv3KHihWRTL17ZqYR74k6qKfh0J35vVXYoJJRkyg4p54BTVQnXh5odMfXaAy5Q3OjWZw++KbkvDCd/TldhxmuwPBRIzR43Y5DBThmscoYBleXDvCvVgHy3zkKxq7yUPvw705tSNdVkTc3l3kWLDgLEyFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6666004)(33656002)(110136005)(8936002)(4326008)(86362001)(38350700002)(38100700002)(66946007)(8676002)(66556008)(66476007)(508600001)(1076003)(6486002)(316002)(186003)(9686003)(6512007)(33716001)(5660300002)(44832011)(6506007)(83380400001)(26005)(2906002)(52116002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pc1++0H6fL6qQCwZL6hgrY8njhgS+D3vJwmdGjnGN56uXaFfAmJ5vnqj87iU?=
 =?us-ascii?Q?0tSoUAJz+G+M6BJWK641TGsJ+njF48Ib39FTBs6atjDalhHW8+hX48Cipm7W?=
 =?us-ascii?Q?V/sVGbpNQNE0xJuKiabSZfPbWP51VM6W+XLzZ3Bb8pJ+KYGfyKa6wTe7spaA?=
 =?us-ascii?Q?jGmzEHjL31eoMJCmKSoGyIyP7fD/gcOJlqS+lW052SG0TEo8Aovy6YS8Vh3w?=
 =?us-ascii?Q?CCub9OOqf1S+IMg/G3zhaVDWyenVxnyAXVdIe6dkEIe/+HH9RlnPIxjdZbSV?=
 =?us-ascii?Q?bEO8fmxRtca5Nnviq+2O+udimaB8BX5ZWytuVrtYeJoQNyy/ElCPumKd9U1U?=
 =?us-ascii?Q?mnQdrkHKnABxgA+zjClOdf6DglGc+w1C8D0GiQxdCWLr+O80RhIpG7JkkURE?=
 =?us-ascii?Q?kftmzWRMdMYqDGVkFr/lXn0+ofNj2Pp5bpDLq6diNWl7j+vrW/skxDOaMZiH?=
 =?us-ascii?Q?s8NiJwsN4f+eXmXLjf2yuUDM9VFotuROAZPzd7cqrHDwtwwfstgP+TxQMWU5?=
 =?us-ascii?Q?ssx1SIaeDLZKklTLX5K8Xcz065hmdw6kFltqB6EcDDiqshDatcr2YktSVsOM?=
 =?us-ascii?Q?KMaBc5NrbFmnXXJ576xfOiqI8Q3k2gom4eGyYKruAZ0csBgDRslQnw5jb7nQ?=
 =?us-ascii?Q?xqlhF2H5IkbUInbsCM1tAOvUsh+s9BXk4Sy4oWxcRhN/Pjc7OeY2ApNemgfF?=
 =?us-ascii?Q?VZnFsfdLoPpbgWVAZtHy6cZvKR1a39VFiqWjJa9wDfxFlq40GrA7anof6l8b?=
 =?us-ascii?Q?NzQeTbSYQUOdvOOdfFuWQtvjA63c3fuspYgeYZmnbZUUM/WjfggXWGZXI/NU?=
 =?us-ascii?Q?J4JpQm6t6gtVBI6PfsE1XKqPnkYx7aEu3sbebhp7nLiuLXTS5YhAOsSRRoVK?=
 =?us-ascii?Q?gqnK96RhiScfdgONhj1B/6A5B/QHnmzpNWtcnPVdeUZirEDd4O3jkb+tVNev?=
 =?us-ascii?Q?kAIzQ86a27OUbhIauXwsEVqi9ezBReirGDA6gU6D385K5vpzyrmJqloSEUAZ?=
 =?us-ascii?Q?R1pqGSxsUgR/KukWjFgIERt7qDK8wGksHt9TCXVoFLNtq7zJZ6vQt99+LtuU?=
 =?us-ascii?Q?FgfvigerDppZ95H7YlEbk4UeK3gIUZFyxXiOcj7QWUdijT+/cQSbr5BCv+G5?=
 =?us-ascii?Q?ojJ09/Xzfv5LRlvvTAmsDweOf8BBXh8tJH/ME4sJzpPE7XtKBdcVLSnz4bLF?=
 =?us-ascii?Q?6IrFa+X1KgcUtIiimJNSfB5B+tqqpss6E4Gq3pwP1JYanfAMMRRWUURoBI3a?=
 =?us-ascii?Q?xbKhpQcZiOxTh/XP9pIKPeEKdJNU8IfEdqrqC/lSWwbKiZJk1+/6SPUrHQAC?=
 =?us-ascii?Q?dcFZjPzDNMD5i7lC15kmvhhj8fLq8x3nnXcRv/QjE9x9UTLoQMIFIRSUfWHJ?=
 =?us-ascii?Q?OBFJ0AgxDbnu17YAGkDYqHQSQDKDxWFyU/y63Q0za5gVdqwHPSKpOWybeDB7?=
 =?us-ascii?Q?hM1tMC1pXdLyb0r/Nc2R2Q+LeT+1xd8AvsZkwL2Z5nTOCCHmgj9xHJXJsWCM?=
 =?us-ascii?Q?x69scZrsAIGnL5hBr7+tNZ4kYweWsTwId2xevGlnulYGdCKqxvk9fLcpmDts?=
 =?us-ascii?Q?oOVf5GerndNhC8r0r+jBlPfvSExw3y+WX9emwVZQnds5zpsPVTJi8tQpRKy8?=
 =?us-ascii?Q?/e33RDN3M7hCQ9xE+c5UhJD9tpa6naOwfy3togJK18BE32HVTM3/a6LfLZNl?=
 =?us-ascii?Q?PX8Bp2FzZ3H0oY4gJuIrot99MTA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5229d1b7-ec50-48e7-6cd2-08d9e267d028
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 14:09:35.4423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RIr0ts4FqZ55l9nOwdIqVUC+IcuR4QqzndvIqupEYBAHiOTbJ1R+o1FTWw+kQFA/bsYz9AlayzHadEREsTitkRAJ2CY2ugk0YJ9xWohHL/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4939
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10240 signatures=669575
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201280090
X-Proofpoint-GUID: qEIZNgYB0XBy-yOdROpkqaCZRe0ZXI-o
X-Proofpoint-ORIG-GUID: qEIZNgYB0XBy-yOdROpkqaCZRe0ZXI-o
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code triggers a Smatch warning:

    fs/ntfs3/fsntfs.c:1606 ntfs_bio_fill_1()
    warn: variable dereferenced before check 'bio' (see line 1591)

The "bio" pointer cannot be NULL so there is no need to check.
Originally there was more extensive NULL checking but it was removed
because bio_alloc() will never fail if it is allowed to sleep.

Remove this check as well.

Fixes: 087b2fb84908 ("ntfs3: remove ntfs_alloc_bio")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
This patch applies on top of Christoph's bio allocation series and needs
through the block tree, I think.  I included a Fixes tag even though
it's not really a bugfix...

 fs/ntfs3/fsntfs.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 0660a07c5a96..3de5700a9b83 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -1603,11 +1603,10 @@ int ntfs_bio_fill_1(struct ntfs_sb_info *sbi, const struct runs_tree *run)
 		}
 	} while (run_get_entry(run, ++run_idx, NULL, &lcn, &clen));
 
-	if (bio) {
-		if (!err)
-			err = submit_bio_wait(bio);
-		bio_put(bio);
-	}
+	if (!err)
+		err = submit_bio_wait(bio);
+	bio_put(bio);
+
 	blk_finish_plug(&plug);
 out:
 	unlock_page(fill);
-- 
2.20.1

