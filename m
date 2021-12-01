Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB3946536E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 17:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351599AbhLARBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 12:01:20 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:54464 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351519AbhLARBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:01:18 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1GrDnM032524;
        Wed, 1 Dec 2021 16:57:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=e2XwtHlIVm+X7IBFjmlw79VP+G8thDJowr6WE7lT8/4=;
 b=a+3HWm2ejmkVfjKNmQ+DLOfi8d0i99Ww/4AwYgzpjDVdXQ1ZwXUpUl93Y0O2SuR2EBDK
 Corjyf5MjbSye8jC0LdCRZYIgQHQIIEzGjioSLxsqAcW5dI+ZtAHE4/Dq+8adml1g6CX
 5LywojIRyP2uY/YxKZQx19cEFeV/alw38FRx1ltzd32yIgdsNH6SqPzs7YD/2nyL2Fb2
 /fGB4x9YxkK/O0zcjJa6zxW7p/I2fkXXmQ54IdQtc4TXo3rAUQtk+FYAy23aNmQcSljY
 hJzO5sYFqR/wfihSL08Zwp4Sg2gzEDci+HZAlC77yI+pLpv4O8AVOe5T2cRtmCoak+1L 0w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cpb700yb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 16:57:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1Goage180696;
        Wed, 1 Dec 2021 16:57:07 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by userp3030.oracle.com with ESMTP id 3ck9t259yc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 16:57:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vb3ije7eTLwDo9h1D/zSX4A5sx/V0i7LWr2jIsINu+N5Cqr0+9Cfrr9OVos4lBoOi3ix4aZu1a1kgwlLMPFKRGz9V4u11gwD8hHcGFLn0ctibYH8cMC4xIN0+QbrV976NHGhI7kUl2Q6wVFxifd+B0opyCRCl77H9ZceHP1d3Sv4qCydCUpfzRpeOrdhpfjx66voLHu59Qcz5h3SAtiOJnXriDcvFrwEtrZVjVkrE4QC74FwpN5qL/yZOVLWruovPQdjW+YdY3LvDYY0oT+JksVsFGivZDKELAmBZZQbTMC4uEZ5MC/2bJ6JLQR+ni1UX3QbbLh8hUHly8eNJXDRsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2XwtHlIVm+X7IBFjmlw79VP+G8thDJowr6WE7lT8/4=;
 b=IWE5ooKljkMR/q6CIqTd51mnr64YAeHgCfn606udwr0kLr1mdXU5MMY5q4bs2WwwA5PoJvNIpxhnc7s0jgwZuSYQaaqtq6QwnDp94ck39zMFHuG0evXBEFnQTlWL6C3hmutRoHW7buzvo2u2d1ITk8l4DLsQKwu5y06uwk3VEEzZxjXv6hHRYcgszXWKH5VnCIJBbqZeAMvaAHjMfxKy+gwxTt02DRHuL65UUwK2NGt5WcCxBoh3jMs21H3eZE3ycTxDKythAwNUJcozGPGmA3xWjDgj1rNwW7r9bUKjYD+MdUAGbU1FPIsUMcS3YI0S0Ef5ppjbqhIct8XRVpt3og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2XwtHlIVm+X7IBFjmlw79VP+G8thDJowr6WE7lT8/4=;
 b=cVoOb17/bbKekjZ8VJsm5G/wKn8vk9xQZtzL3bhmrCjBI/mwHy+AaVMt7dAsSOv9Et0KcQ6yo00MghmRtzSS+KgGvVCfsYi3UaCpSS7rw5J2HQXu4M9qMb7ui+xWGMEYt2ph31jLzTNyo9p4UIVj0nzwdPfkLlUT/YDC2nJvGQo=
Received: from SN4PR10MB5559.namprd10.prod.outlook.com (2603:10b6:806:202::16)
 by SN6PR10MB2879.namprd10.prod.outlook.com (2603:10b6:805:d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 1 Dec
 2021 16:57:05 +0000
Received: from SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::7514:eec6:460d:a074]) by SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::7514:eec6:460d:a074%5]) with mapi id 15.20.4755.015; Wed, 1 Dec 2021
 16:57:05 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     william.kucharski@oracle.com
Subject: [PATCH V3] cgroup: Trace event cgroup id fields should be u64
Date:   Wed,  1 Dec 2021 09:56:58 -0700
Message-Id: <20211201165658.728107-1-william.kucharski@oracle.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY4PR21CA0047.namprd21.prod.outlook.com
 (2603:10b6:903:12b::33) To SN4PR10MB5559.namprd10.prod.outlook.com
 (2603:10b6:806:202::16)
MIME-Version: 1.0
Received: from localhost.localdomain (2601:285:8200:efd:34b9:1074:928e:e052) by CY4PR21CA0047.namprd21.prod.outlook.com (2603:10b6:903:12b::33) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 1 Dec 2021 16:57:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dffe8bf6-1a9c-41c7-75da-08d9b4eb9a97
X-MS-TrafficTypeDiagnostic: SN6PR10MB2879:
X-Microsoft-Antispam-PRVS: <SN6PR10MB2879AFE634D27C42E79B6BA081689@SN6PR10MB2879.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:494;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tva0o/Mk7iOm6J/EBSoZcHprLBjfVFnCoGevk9eJGqV5aKyjpbBnLL8aRZuA9CxIi2FNGJHYi3qpNRU4nBl0X/35B+E/8UpDpSocZawlDr7IoxTRc+VIF7q1567Fa7uNz33k8dTDbYJjn9IpRkpjbIblm1YIUMsH7Le0a7HTHdq9eJxUBVIOyaqobl2GDOmAMLHEewHU4U8+F4wseDheI6lJhedkdyN+aPEkUnlsnq3DV3Z4nqxrvqS75DzjGfhxI2eddFuTAilNS0Y3R2WsHRUeAXxEVTfUkEy4XZB/83UvVImVuD+CKRpxgvDcUImzmBvo1SJLhrNg036SwCXZNymOxMrDOfWRdCICsamMGiGd4VtduU79mryMNrZCLf3cHrjiiMrVaRhOoe+i35EuR6Ly7/ON0J5DtpU/CBwbIjIYBDpXHeMrpTUtAbGtuHXzc8bIIz7FURL+3W8jKv56Mz+kICU3S4b5jbh6T0qZwErhfwNPybbzdpt6px6oB8Ck2kOQ3NxZYdAQlouHHLbWdOQ7GgeRLzeteLlOu5zVrzAsUdRXRurooiz24KrbngyTwC0MbYcnaDz7o7jR0G6pqh0HVbYNA6a/muGRHFPAvdVHbxhizsO2XKk0whCFBFQxFZ/Tjv71pJbYd68fdnb7vQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5559.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(8936002)(83380400001)(6506007)(107886003)(316002)(44832011)(5660300002)(1076003)(38100700002)(4326008)(6666004)(2616005)(2906002)(8676002)(6486002)(86362001)(52116002)(186003)(6512007)(66946007)(66476007)(66556008)(36756003)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MpAvK+cr/8LHp0XHK1M7IQuyNK8t3nhZAqVu5zs90+qblSa7Xg6txlYcvoD+?=
 =?us-ascii?Q?4JBNlhlc6c5OkhHygH0Rxw7E/aGUT6UeuTCCElyZTb34hTDOcFfalJanni3Y?=
 =?us-ascii?Q?eA90U1HbU/d5M5QZpUP5RO0JMBdc6jqbBQ5iiFSmk+c9zV1VrgxRJKROug6b?=
 =?us-ascii?Q?h0yvJ7AkEEcBjQ+9ddAESBtx/yX80k7ihCNmwtw7Q/v0bRkuNocFy3CDxavD?=
 =?us-ascii?Q?4OhX+HAykEQ0My/PLSSu3E0wVWtof920e5OjkBKNm9vJkXj8x8gmWyf++4Nb?=
 =?us-ascii?Q?Y7D0khBi8Vo/jVls4zQMw8w0ss5sfIvizXzrxcu7/2ablnqOXaUEXrbb+JDj?=
 =?us-ascii?Q?22RVpmdHseEEzam/PK32RqBVpBgGuOh65A4cg5A5cVjAGQKFsn79mUNGW202?=
 =?us-ascii?Q?5MUKsoWVf7dKubUPEfmPbKGwdQwA9ib9aHmtsjdcH8S0pPgZL96+6u+bv+lA?=
 =?us-ascii?Q?2GcXWop6sxrIB9qqowl0JpsOtmqeDQUaCDguqWmW5uHB6uM1CfwgTIWfN1ce?=
 =?us-ascii?Q?ZQwZYm35B0bAweCCa4I6rQQvDZy28+c1ZLqI32lAr/I9wz42WWhOJWtR03m5?=
 =?us-ascii?Q?SVIFcZSmLYX4P8VtW7hujhBuHZQzg/bntqLKiwkRh0O5aC8tOguIH6zeMYbX?=
 =?us-ascii?Q?qomOZhn4bwQrKUeyXW7cHQCTNPwU6roevPRurMZhDRC5OEu938IdJ8svW0Ae?=
 =?us-ascii?Q?9SN7J9KXPf28O1m+QxsWRP5Ml+a7CkKa9roZl1Sl0hJBVKI/y1zNpQK15vPF?=
 =?us-ascii?Q?aXqicIh0tLCBNQEn9r2eh5jQA8Qm5pK11j0PUfv+E2eG0ASLvihOlw/V/ogR?=
 =?us-ascii?Q?3jpCWJtVJ00gvmf+KFjGTvJ5Z4FnZ73fISaGrj/Vw3tKSxXVRsGUzd81y2KW?=
 =?us-ascii?Q?Poyf/3o3zVnd33fnQIfaaL0yKDkImTZTe5kOnPmrM0O+nwxWVSomUcUYS8Kz?=
 =?us-ascii?Q?LRD0Ub+UWKjcIY4ua8QBtRKSXEBnos8io9oI/0u4DbmTe76llW9sJHEXN7Iq?=
 =?us-ascii?Q?qV68pQAQH8SNHQnJ6NYAmMNSvEV+y6pSrTsU6ssybLb3vzrTKIsu4NhJq4Kx?=
 =?us-ascii?Q?ee2BatZ1Lt3dPKynlTNVdtACYusY7rxVYCFsU1cc5rhP2pRiWDxhDCXRmwj3?=
 =?us-ascii?Q?OHBPHJcOu145UuWM1YdQ2UopdP5Nwrl+d4va9DVIl1zukAlU2LmCBLkffDGR?=
 =?us-ascii?Q?ZOkwn14kdZZGhGZOtGYpxii5xQTxN1pmJ5OeVs9fBWTXOS5v32dwjPxWRP3e?=
 =?us-ascii?Q?AjnVdUBwjcC4VkPPaaA/zFJ5dc+/xiAtM+61O9oQxxEMuveVhXxZsrq8uHQh?=
 =?us-ascii?Q?LAUlroyT5kpHWKA8RUM63OLCqwVnDhl4omcxpkmzPr3Np1fbQgV3kbR5YiLS?=
 =?us-ascii?Q?5zgDAzZEfbYnSp6crgnCmejsGeCkbAN6mUGl3PSz5RPlWQqMr/DEFAvIWnDj?=
 =?us-ascii?Q?RcRC9pioDF+5xg5m2lAQmTNgkDr6QFBbSg03xaDa15xBdcVMPp3FOvIKMUfq?=
 =?us-ascii?Q?eq44xYkn6vThXAX3Aq1RwZkmUXbH5Fv5RnfS7ceFZLIt6CBNYWfF5tJxkAsh?=
 =?us-ascii?Q?cuJn3HpD/oOxg/+PaFJVSXpfAvu3DqLQv/4FdQiO5rq1x9JysjOHjq8UN5a5?=
 =?us-ascii?Q?7Bq+b+ieOPXcyowi3Bghn022y1BKCngZ84HQunknJUZnIgurYJC1UXIiDQry?=
 =?us-ascii?Q?DtVZTV6oGZkhlhjmPTv9c2k+uPVenp8tGVbfIDzFJ8/44YmSSByfyd5UO9VP?=
 =?us-ascii?Q?jueM3mZgYrJpmRJ9KEKbSTceIUFX7y8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dffe8bf6-1a9c-41c7-75da-08d9b4eb9a97
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5559.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 16:57:05.5668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BjIhVA/NOIfaD60t17z+idJIVc4TcxoXR1P3udupavDCcTvhvyQC1Ou1Mw2KndQqhO78Uw8ht5mHkQMQUQw6G3HZYsbTxPDgxWRoCSkMpA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2879
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10185 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010091
X-Proofpoint-ORIG-GUID: eGdez8uQ7ryB8B2C6tX1tCjZ9heq9ilu
X-Proofpoint-GUID: eGdez8uQ7ryB8B2C6tX1tCjZ9heq9ilu
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various trace event fields that store cgroup IDs were declared as
ints, but cgroup_id(() returns a u64 and the structures and associated
TP_printk() calls were not updated to reflect this.

Fixes: 743210386c03 ("cgroup: use cgrp->kn->id as the cgroup ID")
Signed-off-by: William Kucharski <william.kucharski@oracle.com>
---
 V3: Reorder structures to avoid leaving alignment padding holes
 V2: Do not remove tabs from macro definitions

 include/trace/events/cgroup.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/cgroup.h b/include/trace/events/cgroup.h
index 7f42a3de59e6..dd7d7c9efecd 100644
--- a/include/trace/events/cgroup.h
+++ b/include/trace/events/cgroup.h
@@ -59,8 +59,8 @@ DECLARE_EVENT_CLASS(cgroup,
 
 	TP_STRUCT__entry(
 		__field(	int,		root			)
-		__field(	int,		id			)
 		__field(	int,		level			)
+		__field(	u64,		id			)
 		__string(	path,		path			)
 	),
 
@@ -71,7 +71,7 @@ DECLARE_EVENT_CLASS(cgroup,
 		__assign_str(path, path);
 	),
 
-	TP_printk("root=%d id=%d level=%d path=%s",
+	TP_printk("root=%d id=%llu level=%d path=%s",
 		  __entry->root, __entry->id, __entry->level, __get_str(path))
 );
 
@@ -126,8 +126,8 @@ DECLARE_EVENT_CLASS(cgroup_migrate,
 
 	TP_STRUCT__entry(
 		__field(	int,		dst_root		)
-		__field(	int,		dst_id			)
 		__field(	int,		dst_level		)
+		__field(	u64,		dst_id			)
 		__field(	int,		pid			)
 		__string(	dst_path,	path			)
 		__string(	comm,		task->comm		)
@@ -142,7 +142,7 @@ DECLARE_EVENT_CLASS(cgroup_migrate,
 		__assign_str(comm, task->comm);
 	),
 
-	TP_printk("dst_root=%d dst_id=%d dst_level=%d dst_path=%s pid=%d comm=%s",
+	TP_printk("dst_root=%d dst_id=%llu dst_level=%d dst_path=%s pid=%d comm=%s",
 		  __entry->dst_root, __entry->dst_id, __entry->dst_level,
 		  __get_str(dst_path), __entry->pid, __get_str(comm))
 );
@@ -171,8 +171,8 @@ DECLARE_EVENT_CLASS(cgroup_event,
 
 	TP_STRUCT__entry(
 		__field(	int,		root			)
-		__field(	int,		id			)
 		__field(	int,		level			)
+		__field(	u64,		id			)
 		__string(	path,		path			)
 		__field(	int,		val			)
 	),
@@ -185,7 +185,7 @@ DECLARE_EVENT_CLASS(cgroup_event,
 		__entry->val = val;
 	),
 
-	TP_printk("root=%d id=%d level=%d path=%s val=%d",
+	TP_printk("root=%d id=%llu level=%d path=%s val=%d",
 		  __entry->root, __entry->id, __entry->level, __get_str(path),
 		  __entry->val)
 );
-- 
2.33.1

