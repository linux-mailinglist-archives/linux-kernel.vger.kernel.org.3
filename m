Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A33A46503B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243197AbhLAOqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:46:04 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:50428 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351007AbhLAOoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:44:37 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EZvIQ010074;
        Wed, 1 Dec 2021 14:40:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=MfCe7dZhNYRkUVpjc377wW8c40EJ5Xpib4BY9+xyl6g=;
 b=oHpN/FNqdLYHOHoVuMMmzY9/LPq/QoCJeSmwTtZ2YgQ+WGC/ASTwKonBZpPCChNU62Oy
 AdW342bZZ9f2QsU88CibTAJF7YZw9t1VA0S27YAInPoj8j1uDm/sEaLPV4EOnL0vI1vu
 hEbgVxC5nJey9OoVxw8WZ4be/pL+qGbPEEAHxvAhfnbWx7DTgjaiORW5f0ON1sO4fU5m
 39PyhoILtIwCxS5kN6IL2XcvNbdX36ZUvIWAO5gKDMBy3ooJ5v2y64k1bqKznlAp7ywA
 wh5VJDLwVigsxtwrJlVkj7Dhty8/ZXP+WdUiTPA8ADKCcoA8ZQk/gks4tL5BFbtvouOL mg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp9r50g84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:40:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EeLRS150160;
        Wed, 1 Dec 2021 14:40:54 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by userp3020.oracle.com with ESMTP id 3cke4rvnv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:40:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ed8h/YbSw4HLoxKzEqeS+gzwZFIReOJNzlwTOqkxWy1pwmeSntpXj5dyCk/4dXLtjVb29yze3jHJbhYrGSJ+1kluJJMniuPiMTFwjQpoAlIAx5Db8GZgYo3BwthCt4reN4AFZWvOjHwjAKlZv1EOmpBFxKfn9CVriSqaXwa5SBbFgxQosAvw6qipJ9bePrlKKyzgExvGngPBTw57ZhfrF4soYa6l3Dc96FEeKoXuDTWSwDKk73OMfSNP+2zNieNLgj4l6qvaW9cCEDKkf7KFKubVMv9+NRl8CMTxtzLev1yTuStBouEZcYtlpGOuuVmx+edb4W9eU/ekZaeuwBelLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MfCe7dZhNYRkUVpjc377wW8c40EJ5Xpib4BY9+xyl6g=;
 b=Id6SOEg2yPnHaF8ti2E7ahn0+f7EeNlPCDFJ5Y4MG2pc9xl0ZKyPJg4Ba/8BwIG5WimA3zAzJabpGq9U5kwft+vnfLd4Y4ufbqoYbqLnlfbK+9ge9KqHtBzwXWYCNBN3pbU0NGdJKclifqVr2UO85yyUYflTJvipbw7ZrYvFH28/xRlrcMCY9oJKyVNpFsPDLbnZ7q9k0Qv7pIRSCGVx9HSCXqXDPI1Z52ZZ4svZXBeUMix1gds8VZ8OGXZQXhckrw0+AcMdpICLYB7gVUj4I8lorI+hiwY9LKL2y/nsQjgMUWs4lXnerRaXTSieJVpBHzTZmE80T7J/Y+1/Ar5fvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfCe7dZhNYRkUVpjc377wW8c40EJ5Xpib4BY9+xyl6g=;
 b=X4R5qWoMh8nd29N6CQhXN+0HE4C9Wbe28QOBF3LU/t0fosXLwVclmpOJEfV+GFRg2F/YdDJ0SsI/btk/MrBidYdDw9yrFvA5tTqRVoG1bIgRxjBIyj9rZf8ihJjJxHYTov/bBUTlI+EKfxY6jipmE+MoD7Shhw5QdaoyHtvFeZQ=
Received: from SN4PR10MB5559.namprd10.prod.outlook.com (2603:10b6:806:202::16)
 by SN6PR10MB2445.namprd10.prod.outlook.com (2603:10b6:805:50::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 1 Dec
 2021 14:40:52 +0000
Received: from SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::7514:eec6:460d:a074]) by SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::7514:eec6:460d:a074%5]) with mapi id 15.20.4755.015; Wed, 1 Dec 2021
 14:40:52 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     william.kucharski@oracle.com
Subject: [PATCH] cgroup: Trace event cgroup id fields should be u64
Date:   Wed,  1 Dec 2021 07:40:43 -0700
Message-Id: <20211201144043.557470-1-william.kucharski@oracle.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY4PR06CA0052.namprd06.prod.outlook.com
 (2603:10b6:903:13d::14) To SN4PR10MB5559.namprd10.prod.outlook.com
 (2603:10b6:806:202::16)
MIME-Version: 1.0
Received: from localhost.localdomain (2601:285:8200:efd:34b9:1074:928e:e052) by CY4PR06CA0052.namprd06.prod.outlook.com (2603:10b6:903:13d::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24 via Frontend Transport; Wed, 1 Dec 2021 14:40:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8111b99c-4faf-4937-6198-08d9b4d892dd
X-MS-TrafficTypeDiagnostic: SN6PR10MB2445:
X-Microsoft-Antispam-PRVS: <SN6PR10MB24450E4C238284F798F4E7EB81689@SN6PR10MB2445.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VdmSl7pS6Nk3gZ84p43o+TZwDWMq7ww6iubGXPPs1y60XN77XCm5Gse2Be1h0DdPdzVhbLTOVvlRv3oDRQCW1roCijDLEE212oj7ym+nFpFF2fdHZVav1ArLKS2sUdihSUk06g8O21YaT6addhcrkK9DmYTEazAx53+8UIQb78FGCvT0nc2lUlkTGxXZozVx0QSKl4tjf94emf5ihWPgB0btC7TNLNTQa/2CBQ5UsQUnoBJOenJBNgld31T9CyJNno0VFMS5lYeoVWeap4kA+QkZ5Fpg1QhuQ/Vq1RNPSyG0PmVnGXkg9fL8zUTPxPG9P3wHfeWi2MkZ5yUIJL9hT0OMebDVMtrJ+6Bt5pQ6as5MXRn19FAATm1hBV3Vj/0LrdLMEkrrMdOuF7zfsFxSSvUOGFhduuG8WhrrD1uwtr9unasVM9Si2DzUbolDJDBh93rfZ7bpDt7B16yufYEAn5BB9kYz+HSYd6fgYWNyhpicupyOoREaGthFl8V+6IDDbZ/JEtSY//q8+hXmheuMdpw6mTsIvLP6rPvX4R9flWS8bMCrkM4KxeiPWLTGlM+w0A+ZznzmJ5qzjtn87wGISmhguQafo7c5EDWyYN8bql+PkI6ExfVy1htS4ZtOSXlJYRfFfaICT3OpejKLy6lKfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5559.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(316002)(44832011)(52116002)(86362001)(1076003)(4326008)(186003)(107886003)(6666004)(5660300002)(2616005)(110136005)(38100700002)(6506007)(66556008)(508600001)(83380400001)(66476007)(8936002)(2906002)(8676002)(6486002)(66946007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N+MpZ8vYIyGxXtrjuS7MxtaUImugMR5W2StwbShciQv+bDd044vvQ2cFEsgR?=
 =?us-ascii?Q?oftnUjFNNt2LBQtJmeIdvPQFTfJU34rfSkdf2uAb1wkf9yQn4Gwufv8kB1Bc?=
 =?us-ascii?Q?UHEBYt/MmviqFUXipppaPmE/mmre1VOVOHiMmEzFn578rB3qq8yb8HuFwl6C?=
 =?us-ascii?Q?0TGboUe5JZ6VydycnE8RlkNKND9Tnth3Egae4xL3PA8pZ00uXjSc0s7NIh56?=
 =?us-ascii?Q?N8baDiwGG2SJ1ydpfV9tRHh8yO0xKv1rpdk+LhM+3J9l8iGru8EJ5JkY0Et9?=
 =?us-ascii?Q?t0VQbEQoRAFr+sVB5kkLVzVnKrXw7zFp4O+dJuTQrYFBFIyHB/yNsOi+dtLy?=
 =?us-ascii?Q?DkoKCA1TWNyDQoUU1BiVgvFRmQFjg/0XzzbAqJoV/r6Zb6pz/kcD6stRoJ+f?=
 =?us-ascii?Q?3Z16WfVKmRA5L9W6Io0kpJRr679/2Qx5/t2CF4GaGREXcl03gtMnDKiuoRi0?=
 =?us-ascii?Q?DiexEX2cIucriy+zOSMfZWCcg/XdJt08+P7gMRAInEMICSlE6Hl3ln9fk0qw?=
 =?us-ascii?Q?QYvsLxvmn2oJDMXko+BR/yvkwE/dt2Gg+b9TOby74U3mZTwgKC0zluiUBY3K?=
 =?us-ascii?Q?K8JCiTrwBZco8nnKIPDD1PgQz5Wc19kciu/iePSjeZFPhky+CMekp5zlMaVR?=
 =?us-ascii?Q?loAns37/dvDZY9cAm14fhVzlJKbdVo+3rqcskmFUoR9AqwS/0hgoLZ0xHMBh?=
 =?us-ascii?Q?KGt+GiejDC6H77iVgxExrLSSAuAoAmznLJjpUbtVWKRePFy+L7kVTEUKbM/b?=
 =?us-ascii?Q?LKE51GULryEw5achIunpVlUb/IIM/o8sqn/ZvWDFO2zwgiultrmBLCOGlQ2T?=
 =?us-ascii?Q?CucQ9JoBb5QOavltEluiOQ4yiTav1NgemeSsSG+9VDmYYYgL1ms/YdwLPLqh?=
 =?us-ascii?Q?BB3pLmWaO68AHP0r5owpwkftORNKn9Vj+03XnLquhOaUCF5hb1qwMtbWvz+a?=
 =?us-ascii?Q?Ea3TnqE8E+vMoA8aWGWLp1gIMfKtGryf5mng1yAyLa6VoMkVSO96RoTL7OaS?=
 =?us-ascii?Q?NWm/ZSpz9M2WidURiTFMQHPUDNvZVIympx4ORgKlMSPvpUL7g919YCs0oWkk?=
 =?us-ascii?Q?FEcOw+/1dXEiEQJc3fFIwJqgYHpWa1zQ3y+k0VsyytPsh9SKfg3O7b4RyR+j?=
 =?us-ascii?Q?BAnlnAhPYbi2cqR7dvWT02zOD+3yF6DQDvWHoaxhpz5GDG1jwEssxL21ld9L?=
 =?us-ascii?Q?evzdtKgeFgK/6Tk7myZv3KIUYpDazWTjNTbXcfa12G6DkDMUNQUjANyyPcwg?=
 =?us-ascii?Q?mtJ1kmt3JoZr+rPFNwxBp/uKHstMClkdgwPuRXXkkEc3CouTlCJBNaRHxtYX?=
 =?us-ascii?Q?rQs9ePbVBLgRp2qwvmRx8+JOfrzk8WCAb4qgxuqHJG7Niza5TKblQv3ItKTJ?=
 =?us-ascii?Q?r2wk/Q6kIBwjGp7EazfGCMZLrhGlNKkWAEbuDgxXQ1hMOpKW3F8HoY8lovY4?=
 =?us-ascii?Q?Z9SI79JQzenp51OWEA2jBd7sg9B5y0Fbx0Kge0W1iGvyDSN0SOlikeoj2ipS?=
 =?us-ascii?Q?TtcPPtUlHJJ2+L/OEV3TEr0zpRPqSf8A0qoULcXd4RgT8bZ7RgL/RUcVMmd/?=
 =?us-ascii?Q?K1GiyWjqlwEDB/9lidJpwpL7vJaVOn9RC2mj7NNWsAPQNzUgzpAYmHDzkYJ/?=
 =?us-ascii?Q?muhaQQLAA3n3t5AxZpSzLrLedG/Ad6hT0KQv/LrB6KDkOedJqAC/roo0mwNz?=
 =?us-ascii?Q?l6wLJ98QO/61xo83FDc7Xip9Py2B9CxyQoOJlRT52/ImUR0BECn7qLaEzefQ?=
 =?us-ascii?Q?z4GwVCg/1Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8111b99c-4faf-4937-6198-08d9b4d892dd
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5559.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 14:40:52.1285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25Zr+lwWyjks0Sk4+Y0lSCIJCtaiGWKgoQd4eFii7on53BbXiz2gGvUlldu8GuaMXcqJ5DriHSupUgEnfE6eE9gdFm9w957E+EsS5lKBEI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2445
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010083
X-Proofpoint-ORIG-GUID: ZtIvLcPysXC5XCqsCQpy6UUk6FvO_uD4
X-Proofpoint-GUID: ZtIvLcPysXC5XCqsCQpy6UUk6FvO_uD4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various trace event fields that store cgroup IDs were declared
as ints, but cgroup_id(() returns a u64 and the conversion was
not intended.

Also remove extraneous spaces in fields that are no longer proper C style.

Fixes: 743210386c03 ("cgroup: use cgrp->kn->id as the cgroup ID")
Signed-off-by: William Kucharski <william.kucharski@oracle.com>
---
 include/trace/events/cgroup.h | 42 +++++++++++++++++------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/trace/events/cgroup.h b/include/trace/events/cgroup.h
index 7f42a3de59e6..a85b01aa1fff 100644
--- a/include/trace/events/cgroup.h
+++ b/include/trace/events/cgroup.h
@@ -15,9 +15,9 @@ DECLARE_EVENT_CLASS(cgroup_root,
 	TP_ARGS(root),
 
 	TP_STRUCT__entry(
-		__field(	int,		root			)
-		__field(	u16,		ss_mask			)
-		__string(	name,		root->name		)
+		__field(int, root)
+		__field(u16, ss_mask)
+		__string(name, root->name)
 	),
 
 	TP_fast_assign(
@@ -58,10 +58,10 @@ DECLARE_EVENT_CLASS(cgroup,
 	TP_ARGS(cgrp, path),
 
 	TP_STRUCT__entry(
-		__field(	int,		root			)
-		__field(	int,		id			)
-		__field(	int,		level			)
-		__string(	path,		path			)
+		__field(int, root)
+		__field(u64, id)
+		__field(int, level)
+		__string(path, path)
 	),
 
 	TP_fast_assign(
@@ -71,7 +71,7 @@ DECLARE_EVENT_CLASS(cgroup,
 		__assign_str(path, path);
 	),
 
-	TP_printk("root=%d id=%d level=%d path=%s",
+	TP_printk("root=%d id=%llu level=%d path=%s",
 		  __entry->root, __entry->id, __entry->level, __get_str(path))
 );
 
@@ -125,12 +125,12 @@ DECLARE_EVENT_CLASS(cgroup_migrate,
 	TP_ARGS(dst_cgrp, path, task, threadgroup),
 
 	TP_STRUCT__entry(
-		__field(	int,		dst_root		)
-		__field(	int,		dst_id			)
-		__field(	int,		dst_level		)
-		__field(	int,		pid			)
-		__string(	dst_path,	path			)
-		__string(	comm,		task->comm		)
+		__field(int, dst_root)
+		__field(u64, dst_id)
+		__field(int, dst_level)
+		__field(int, pid)
+		__string(dst_path, path)
+		__string(comm, task->comm)
 	),
 
 	TP_fast_assign(
@@ -142,7 +142,7 @@ DECLARE_EVENT_CLASS(cgroup_migrate,
 		__assign_str(comm, task->comm);
 	),
 
-	TP_printk("dst_root=%d dst_id=%d dst_level=%d dst_path=%s pid=%d comm=%s",
+	TP_printk("dst_root=%d dst_id=%llu dst_level=%d dst_path=%s pid=%d comm=%s",
 		  __entry->dst_root, __entry->dst_id, __entry->dst_level,
 		  __get_str(dst_path), __entry->pid, __get_str(comm))
 );
@@ -170,11 +170,11 @@ DECLARE_EVENT_CLASS(cgroup_event,
 	TP_ARGS(cgrp, path, val),
 
 	TP_STRUCT__entry(
-		__field(	int,		root			)
-		__field(	int,		id			)
-		__field(	int,		level			)
-		__string(	path,		path			)
-		__field(	int,		val			)
+		__field(int, root)
+		__field(u64, id)
+		__field(int, level)
+		__string(path, path)
+		__field(int, val)
 	),
 
 	TP_fast_assign(
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

