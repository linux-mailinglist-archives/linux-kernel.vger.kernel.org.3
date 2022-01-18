Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8315492FF5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 22:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349599AbiARVU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 16:20:56 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:49378 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349491AbiARVUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 16:20:43 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20IKEDj5021239;
        Tue, 18 Jan 2022 21:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=Yrq2zSkIAuRB6yAhS9WJ7UnsVTZZ/949oV+gt52hZ6Q=;
 b=l450seAnpXgSCNfscMSSuo89ojpLVkZjaStBeylW9ATha05TOdWavWowBZLcbd9aiYGu
 94elNMkTQktdmAsx2z/kKkPw65pRFqggwpu5Q7RH9pJyZGWAsvH3Cupan0LHcpLoACeB
 fz5HOPv8jSMfd30bt1RfXkeVyD69/a26eKDZiULkGgv0FMEME2WjBxKBjniIrN8VUzfp
 DQPQnZQOLIXKlSwUDUx++DlILO9NA0LKUP8G7H0pihx4CtgR5biH8fUOppkm4hzglE74
 MawJVb0Tm8yim+2hEo6gNTKBHaimkboM25RKzz9RKfT7+wgJYPNfcwEM3bowt2X+aUQE 6A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc4q39je-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 21:20:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20ILKNHI147767;
        Tue, 18 Jan 2022 21:20:28 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2041.outbound.protection.outlook.com [104.47.74.41])
        by aserp3020.oracle.com with ESMTP id 3dkp34uype-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 21:20:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzW5GDZ4GxgnVWBIfnzcRO801YYHZy0+I31QLWpSN74JMWVuJyStJ8kEwAB9meRit2lU3BBU30u4V8QpR7bgfWUBllhrQ90b3JCEunbnYgFlwL45bb/1ZgQgAVD2R3iGPFc0Ms+XUhSA5TdNskJ6bCNfQzHPv23kbA2vulzyYTfCQ70YHIErNmGbraxgBzJ0I9WgfhCpu28xJ5/5XhOp04i2n4ZrxFjI3KvyC2VUXKEu89fnYpG2tH0h1qV3dGfMZeufqj5lpa9c8653/Yfq5RezYhVadvPVtwm0ESeoeO/rLnNzZ4jd1srXziB5Iqbhpeijpi79P9xNIx00hZUuPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yrq2zSkIAuRB6yAhS9WJ7UnsVTZZ/949oV+gt52hZ6Q=;
 b=dtrbCav/pXFjti3C8ICHCPffCvnHtf3eR+vK3eUbq2lREo4tGV/aMDjVALCnkR50ta5yYqjVCBKQB/o7gIF45+PX/Y+AlS4yPTBoW0cHxAqXv/NMrrCfE60DxAq0od6nDI580gB4WoPNrhqBdytBm3JM5cuDVPScNT1dmMFyvHi2eeemxtZPFhJoOCEYt15QsxNVg5GFYNpcux+TYEkKHEtxkgCw4lr5KsfbcOKukH+oaJXg0BtYCyqmYcGJzHlWpgcQNmrT56nsogqpUZaU8PQi8RSHHlXmbukHLW3hf11n/+R3nzZ/4VrqG/bhTf0DIFFkwYz7yjU7biLorNCFrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yrq2zSkIAuRB6yAhS9WJ7UnsVTZZ/949oV+gt52hZ6Q=;
 b=iH38Z2xmZHrB0Ms0daPRYcrLgvs4FHt5PTzpmWWAjRxxws//tiou2HiIgdYKvPkGNhFNSv8myk43Pji5kTcg0qPFWyn3zquiwn4/kN0I7rIkAJ7WWS4rlfuPnVJq12HWwIW0ObmzS3eKM5HEbvCXJuUjzOzQe7zOHlhHQKg5Skc=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by BYAPR10MB3029.namprd10.prod.outlook.com (2603:10b6:a03:8d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 18 Jan
 2022 21:20:25 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::104f:849b:6a11:c5c2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::104f:849b:6a11:c5c2%6]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 21:20:25 +0000
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     akpm@linux-foundation.org, willy@infradead.org,
        longpeng2@huawei.com, arnd@arndb.de, dave.hansen@linux.intel.com,
        david@redhat.com, rppt@kernel.org, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Khalid Aziz <khalid.aziz@oracle.com>
Subject: [RFC PATCH 5/6] mm: Add locking to msharefs syscalls
Date:   Tue, 18 Jan 2022 14:19:17 -0700
Message-Id: <a610631481f94b0bf3d2bf57523fe8dc80700290.1642526745.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1642526745.git.khalid.aziz@oracle.com>
References: <cover.1642526745.git.khalid.aziz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::14) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c25db69-5afa-44d0-85b9-08d9dac857b1
X-MS-TrafficTypeDiagnostic: BYAPR10MB3029:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB3029204AA35215BEE9DDB45D86589@BYAPR10MB3029.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:446;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JJPX24zegSP4oeoof77n9az6BwlFna1yV6B45AD8u3nPKDrik84yrW3ZMHp1VmObUBzJDOg1h1Km5bseVsd0m/8ZvWocoJpE9PWbVj0VUqfgfDUrCPo1PrkAE1ZVXyseF+4kNQQlwCZ3Hsa/ao9qvLvj01HttpqWmJpvI5JomcV2LJJdzSdBcjJa0lL69dyEnT6+8xiIqO8hNXNrW7Fs7ZVddX4d+u6pnCmpx5Wa965JFteAzr0e8WRkSoYw0qi5vikraA1N0bzN6Sdx7vc4A2njo57LMaI0A8/6kmIJPns5p5lmuBP/V2JR0DozVUAXX+k/ovbX50KcPW1GD9HOYTLiZNwVoanhQsl2ht28U0qhiY4ANiN/Dkx5vk21G0wKOdoWmgEJ4uXlI8fo0l51q2pYuslW5A9kdJRgWH7LlRLBc/yg1VlwUpiMDHnFGGNQrnnCDOxQZJpv58IFe73Nc1+pxbf73RresJJRLaWKS+HXR4LC47rO3/O8C2NN31sW+dUUBh2dCiGsyOsqvfZLG2FkbLApJEXu1YVDFDI9CbFlqdKavkHyV99rjZWCCDhwWq2cPYZGrXD1J3uF8NF3z7Yw4adpDrgKdtqqI0V9W31dWXahAicI1gp3YgE1czKdsWjAG5wqVBi7D00KRiiR5JuwGYZ6zZMHVAqFcHp8nXkJ4Y+KAwfbJk1uwI5ZESwU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(38100700002)(316002)(921005)(6512007)(186003)(6506007)(44832011)(83380400001)(6486002)(8936002)(6666004)(2906002)(66946007)(2616005)(52116002)(4326008)(7416002)(86362001)(66476007)(8676002)(508600001)(66556008)(107886003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ybbSL+jdCKpStF1oEf8c57rjlsws07Y1/aVu8j5tKhkgyW4vY0WKj2myBynE?=
 =?us-ascii?Q?OcZv4QVlVxlN5uwg+Y63M6QYhE78eooxc//6zqVf7piHQMOrCvU6LuIX6n+E?=
 =?us-ascii?Q?mPrYjMic7vVgxqsNaN7tY3/WZgaFdMqXSa9hRLMbVWl0+2bqjvk0F0IjAGfo?=
 =?us-ascii?Q?PK9gV6awi2U+WJhj8yhy8/RkELChL9Z1NsIGdgkPEbKQ1Kr0/zwgx+CybkKf?=
 =?us-ascii?Q?+b2b0qYKMfqchaITv8vKfnMPdLBkvTQWAGGM5JSBqgnhRAG3FKVyumoJMR4E?=
 =?us-ascii?Q?L0cAdR10/aH+9M+RZOjs2PUXWysbOLy4MjIAmpMY9o50okXhVqAYOh6iNfy8?=
 =?us-ascii?Q?kLWNFo8mdJ4mQ8bXImqI6KdO529arMH2mGo7PP8lCE8qbw3cKRRCcU+aU55G?=
 =?us-ascii?Q?nPmznAJt4A/vBxfBRqMPcH2kfvHMd+WasZAvy9Px+Vb2HrSyqeH2loTfsiAi?=
 =?us-ascii?Q?+2WdQrXTDKo3ggtKR7Tkvaz4JovVjdYc9Z6R6vqg1DSRy47aOUoxyAsGoFtl?=
 =?us-ascii?Q?Yzxu7uQm1Y95SMy57QV7/Rvc/uyg8IrQo2N+Q0gJ7QzMG2TnP9YnSXT3Q+ca?=
 =?us-ascii?Q?6QUFFwDunF0tA8l+bV8K05qjhvG6fs5+41ItRWDaPWLIFFau32hDzbMNS2pf?=
 =?us-ascii?Q?nFhARZHZJFBQH0nzMk95ma9Vy9296vRidMRQgeO/EXuWq99Sctm2l4qskvh8?=
 =?us-ascii?Q?Cw/hThimxNmW/7uKtdoS9QBJeordrY7DuTOZEY+JvTW5K7CW8uMZiZaewXN4?=
 =?us-ascii?Q?+Kvj+N7Vop43KyZdb7FxmRxNyKGUiuTuvSoUtZpmsiMRGFK5ZbmV6fyZd8Pu?=
 =?us-ascii?Q?tqlBBI4tk/PUUYl5jsHjQd2cbBThFQaPWGJKH0vDxBpKcxne+YT5bNF9XGeg?=
 =?us-ascii?Q?UaBM8OqOzWM72EzJWJg+gXkgQp1yGmxNP9+PLK03ypeJ6p6NqlmrHL6jUESF?=
 =?us-ascii?Q?bOXHYHm8tuQKR+ryLhGMkebwL2ROXlwrU1kL0tqmZPmIkVk5h7CJNbXe/loS?=
 =?us-ascii?Q?kpcogneJo0gYA1YxBAGtWFWFFf6RSjoC070A5e57nJmCGkv2lZP+PkToIgj9?=
 =?us-ascii?Q?iHU4iCfP9F5wtim3/g2W5Be97K9NnI9iTHftS6DCZSEJU4B9Cocj2Dr5HWLf?=
 =?us-ascii?Q?Ckg73UqhZdFkU9Z5nteuwRRLYK/nFxcQQF/2yF2cc1b+IbthlQcm9xip3Qh+?=
 =?us-ascii?Q?atyiOhigJPerc3p8e7LSycbySEUHdak/kwgbyevFfVt/I6B5KrAZKi8Mrjlx?=
 =?us-ascii?Q?gntD/JeRm9QvaiX/1nV3R8SlnhiQR2O3D4a1+JWaXieLZqKBwDgFDFeoLFlN?=
 =?us-ascii?Q?VT2Fk/+l9pSYvfCKGi6UChIWKb/y4b4HVTL7r/vIelDf/kPrnsDLSwLSl02Z?=
 =?us-ascii?Q?NxRtQLRSQGwrOsYj54FzN3n3ew+7C1NWAjgBl5f8uqVuY7M1XfqXmEiRwMP5?=
 =?us-ascii?Q?bNIJ9wC4ma9nTDvV1AfH9u4sdupqz+ElRGFYe/ny8tX/w6QzyMxo0S5pAZKa?=
 =?us-ascii?Q?FHQqCHHt2mX7O6VD7pJt7AUTzZ2f0AGRWzLNXvHwkFZm5mccCzaau/BmYOxO?=
 =?us-ascii?Q?OejhwKe+gEhAcf3nzzEvuRbcpWjQrFi5QHQSUfGvlSVyFUoya8A3MxKjD4eK?=
 =?us-ascii?Q?jzP1WgIsVM4KB79N5RraWRVv/gRUJYsJ0RTeqSiUoVpj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c25db69-5afa-44d0-85b9-08d9dac857b1
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 21:20:25.1545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwLLi3JJFGj1eMrlWevz9CA9SPFwoakBTi4PRMSquLO0uoH+6D01s3zU9kRfQPIa1op49gSmB6qXudiJAJUKTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3029
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201180122
X-Proofpoint-GUID: LIR0LEQ-rbqWTGbL3JHOMUe1UMH6uQ6s
X-Proofpoint-ORIG-GUID: LIR0LEQ-rbqWTGbL3JHOMUe1UMH6uQ6s
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lock the root inode for msharefs when creating a new file or deleting
an existing one to avoid races. mshare syscalls are low frequency
operations, so locking the root inode is reasonable.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 mm/mshare.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/mm/mshare.c b/mm/mshare.c
index 8273136363cc..adfd5a280e5b 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -194,11 +194,12 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 	err = msharefs_d_hash(msharefs_sb->s_root, &namestr);
 	if (err)
 		goto err_out;
+	inode_lock(d_inode(msharefs_sb->s_root));
 	dentry = d_lookup(msharefs_sb->s_root, &namestr);
 	if (dentry && (oflag & (O_EXCL|O_CREAT))) {
 		err = -EEXIST;
 		dput(dentry);
-		goto err_out;
+		goto err_unlock_inode;
 	}
 
 	if (dentry) {
@@ -231,6 +232,7 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 			goto err_relinfo;
 	}
 
+	inode_unlock(d_inode(msharefs_sb->s_root));
 	putname(fname);
 	return 0;
 
@@ -238,6 +240,8 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
 	kfree(info);
 err_relmm:
 	mmput(mm);
+err_unlock_inode:
+	inode_unlock(d_inode(msharefs_sb->s_root));
 err_out:
 	putname(fname);
 	return err;
@@ -263,10 +267,11 @@ SYSCALL_DEFINE1(mshare_unlink, const char *, name)
 	err = msharefs_d_hash(msharefs_sb->s_root, &namestr);
 	if (err)
 		goto err_out;
+	inode_lock(d_inode(msharefs_sb->s_root));
 	dentry = d_lookup(msharefs_sb->s_root, &namestr);
 	if (dentry == NULL) {
 		err = -EINVAL;
-		goto err_out;
+		goto err_unlock_inode;
 	}
 
 	inode = d_inode(dentry);
@@ -289,11 +294,14 @@ SYSCALL_DEFINE1(mshare_unlink, const char *, name)
 		dput(dentry);
 	}
 
+	inode_unlock(d_inode(msharefs_sb->s_root));
 	putname(fname);
 	return 0;
 
 err_dput:
 	dput(dentry);
+err_unlock_inode:
+	inode_unlock(d_inode(msharefs_sb->s_root));
 err_out:
 	putname(fname);
 	return err;
-- 
2.32.0

