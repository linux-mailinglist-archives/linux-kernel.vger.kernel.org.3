Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5F2465288
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 17:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351395AbhLAQMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 11:12:06 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:26916 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351410AbhLAQLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 11:11:46 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1FjYWQ010062;
        Wed, 1 Dec 2021 16:08:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=kM4eRWxkcIStu894fDNu64IJ4c+XH5JjDezrXnX0/7A=;
 b=aPDZKmdjmco/dMKIsn/SnJJG6GluBpPk3KVp3bl7VbozQrwVQKO4Pb+yQp4dcGlJWHiw
 c+PsFbu/KBtWFQSfzFD8LMJdy1IEUWS5Pxzi5N0lVNaFgYKIRkYEFlSsyoBHs6MpayPj
 Khj+T4Pw/YNT1uto2cAgdrZcTzNs8Ekw7t2qVT0OWAx/4bl8wvEP2veWiPpy8VXDFsbb
 bc5n5Mqp0mC3htpaftNoGTvOHVur3K+aevWi/KPBHtiVtiAhwKm7jgiwLZWKsx4sxCFu
 jbcPAN12WNMlD3uTvX0H+o01NFISFboywewakpYl7iBLIPgD/84eVTDx89zp/ZFHyHg0 TQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp9r513c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 16:08:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1FrlXf162009;
        Wed, 1 Dec 2021 16:07:55 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by aserp3020.oracle.com with ESMTP id 3cnhveus5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 16:07:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrHCeqv3tNmaX3xKbq0Cn20U5iUQm0us81LTHCNUl1NTl2QovXCB9uEL9tu4izAbTL4ahb24oVNWLT6d70lN+D50zCROrMv4MZ7OArZDd7wfaSsKqLKT71CSOXgSFsz18Yixgc84pzxC+uluq0fqQMqNWuNSGBY8R7hMHsMj+HAKIL6MCh4Bhm+g1ybixcvcve724izb74TWBTJDQdc6abAT/4nQOw36vaLS+EKBGHCg4pJlZsP/6unYkyNDbjIEisHj4bcH62WmUe2WQ/fctT1d/Q6lKQmlhHg4smmHB7cSsL7ZZyuRrvTV4H3EvP2igyViaq8NS/91p4OT+Wum3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kM4eRWxkcIStu894fDNu64IJ4c+XH5JjDezrXnX0/7A=;
 b=dpxn24bnucFJuCFVUM1QrGTGU/NxOxkHgjK4OiV1nzfKJGXzBgTMiD8ywkqSu3W64Nf+i1COTBiUrLg0rcyjTREgn2+qg7WHxHxtwd5vr4zS4FFEzZxaV3IP7kA7XwmCc8a4O+n1wvVRwbPVmj0jQx/OJ2TjnLKXh1ZL6IhnZKoQJecyfxaI7jiu45NHzgCt3AQVnGUiTASEXyQG6hbVKXlFTZA+mpLhZ1b/VfY7/ukCUtDJ76uVmS1YddbaRwRxXhXYbRNEs5IaSZyPLj6GfeoHix5/XShtesuuIMvcLG2f1fwloZBhGrKr8Df0PQkRn8vYfAzRrkLyYmku8aV81w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kM4eRWxkcIStu894fDNu64IJ4c+XH5JjDezrXnX0/7A=;
 b=UzO013KGDk6yIbdvhqUR4C4KDNpFcBwRoznAjjuRCHj20KDtR3tqArXJ6py82IkNuvGS9045R6tjWdQZdfzot067ryNf+KkcC4RLK749Vnkc3KxRhLJjTdER74FK2UInuaR7rbf3VHkCuyH4+3/FTL+KPaR8sXxkGkNQcJSlikc=
Received: from SN4PR10MB5559.namprd10.prod.outlook.com (2603:10b6:806:202::16)
 by SA1PR10MB5823.namprd10.prod.outlook.com (2603:10b6:806:235::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Wed, 1 Dec
 2021 16:07:53 +0000
Received: from SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::7514:eec6:460d:a074]) by SN4PR10MB5559.namprd10.prod.outlook.com
 ([fe80::7514:eec6:460d:a074%5]) with mapi id 15.20.4755.015; Wed, 1 Dec 2021
 16:07:53 +0000
From:   William Kucharski <william.kucharski@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     william.kucharski@oracle.com
Subject: [PATCH V2] cgroup: Trace event cgroup id fields should be u64
Date:   Wed,  1 Dec 2021 09:07:46 -0700
Message-Id: <20211201160746.726158-1-william.kucharski@oracle.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY4PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:903:99::13) To SN4PR10MB5559.namprd10.prod.outlook.com
 (2603:10b6:806:202::16)
MIME-Version: 1.0
Received: from localhost.localdomain (2601:285:8200:efd:34b9:1074:928e:e052) by CY4PR13CA0027.namprd13.prod.outlook.com (2603:10b6:903:99::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.7 via Frontend Transport; Wed, 1 Dec 2021 16:07:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 799a28e3-b7c8-4a1f-86a6-08d9b4e4babf
X-MS-TrafficTypeDiagnostic: SA1PR10MB5823:
X-Microsoft-Antispam-PRVS: <SA1PR10MB5823CD957D2D0A5C34BE62D781689@SA1PR10MB5823.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uIHVlc5otiXaSor/igKqOrsW2y4Fphb+VdB7JzoUzeyc46sPPnc0/5HVMqJrYOz0h4za1yRlwr5nG33XyTi3XhA8ll9KCAnut0MXeoXrIjJT8YDbWbAqSuuM78kLvM+SfS7Bv9YtkSCW8cs3zeIEdQi8gCdf5Yj6MM8XT8iUn1T7Cv9o6JWm8//418K2j5z9hVnmCCcUq0bTwcVlE3T9OuwZRpkkHyazQ2f/D7VS4olKt8bxHZzUc3dHdhRHwzZoWaWLuM/Za7dA0RxyZU3OfUx8LTOsUJbvPFDi76m7RLK8GXO90IulcvPfhiVH2YNGpkR/Zm08l0FhJWazB0khRY3133OUm3Oa+kcwnJFU91GgfkoUY321NWaM7UorXOp6e9/zXJzgws5LhHXh/f52WxyQukpIWKh6hlBpK+x1TCNmY5wn1GB9fj3NUhZa7cS6vnHhMGF0WrlsuKVoJQ0awzGRtoPKe+RxOhV44qY+8knh4ebzYqvbz+kfCXl3V4n3VFODxfUhzpRWutSYUgG1T7H+n0D5bUEj+qxIlS1WvMbgbB5X+cxdA+Wb324pd72xeMNkjDkRumA7p90USnCMpvMYoxEsrnX4iaPnsT0pTU13KjMA88E6YpZYHBiv11MBl4f41A8CqceufZgmYrRF8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5559.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(38100700002)(1076003)(36756003)(5660300002)(186003)(8676002)(4326008)(66556008)(110136005)(6512007)(508600001)(8936002)(6666004)(86362001)(107886003)(6506007)(2906002)(66946007)(6486002)(66476007)(52116002)(2616005)(83380400001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D94mq2UPUXUyNoGbZXRzwL9W75mjeTLIJhDuwsuLOVMvfja0+zOBBSppDh2J?=
 =?us-ascii?Q?4yASvJ8AhU+aQl9HWe1gQXfQlbfU7YF7tfTy7pY7vB/qkDrcNp6fayn+tKOV?=
 =?us-ascii?Q?oE+fx6kvjBnC1NzFf/6BTs4ifJCGy5V73zszzlagQjQ3E06zGBejEn3pofMO?=
 =?us-ascii?Q?yOc8pz0C6JasamMvC3e99zsBkiXjLGh9VTrnoMGEIqjmq62TbxmVxiFmHBHI?=
 =?us-ascii?Q?Be+ZVuqns+7Z0tMdYJB6IjgFtQuSeqEwfs/+zLBf+lLrfaCAvJ+pn+/7gtmL?=
 =?us-ascii?Q?bTCnQmnHQpk4HD2gS9UIwT014LyRlkeklCNQsPSsTd8YjFgq63CIJA8ROfhN?=
 =?us-ascii?Q?M0SYRM1VEHm/I3EfU9IXXmFClHmTgIgyhZeFmTnvULvx486FSjmgTPxFnSQY?=
 =?us-ascii?Q?SFLz1turED/SZTSDoUNnFFBFhWOiiYkjqyElNKh0+rOqmH/eLe/PM5dCOIfX?=
 =?us-ascii?Q?pv3mbsd7RdnpJ3B+Q/c+69E2tiqd5ALP9Aq20XtUPX4GqiWEAT+PM08QSfPR?=
 =?us-ascii?Q?McdMOsqcR4tn3qC/6ekloH+otZt/H/bHWQl1MrRo6eQJMWma5QUZvk6v6jGA?=
 =?us-ascii?Q?sXxa9A4Khy4zsThRouvAIATll0SV/T5t55MPuEiawVyZELNPzfVwCeBjxBF0?=
 =?us-ascii?Q?9Cxptqktn5Bd3CTLgEqjlke+8xSqiN4hZfXNHRVe74a21ZhI7lKuEf6OFSoD?=
 =?us-ascii?Q?tT4OQPuOEGW8foZ5yMomU00Cv3t7aNDCzQ47ydCfURr1+1J8UZUscONMJ9qS?=
 =?us-ascii?Q?haxntrQWIpgoyrlZdBa6LvWiTqniH8EDc/9DFjP0s8M9C6Xmu/3fTUSqmxBh?=
 =?us-ascii?Q?NIi17cTa+JPG5IeffXox9vHjvJijD89BqS+g44hV+7sAnnkQL2ljzJYMmrNf?=
 =?us-ascii?Q?q2YGgI0wad0BSdxNyCd/MNi1YDjv9BfLtQ0CQCi+ceeV0kz2I5ySGyckyGkY?=
 =?us-ascii?Q?QSpnvHv/ryEf/I6b+lRwY8DcYjm+Ujr/cpY7ZLBmY8pzpF5ruiJN3shbIFt4?=
 =?us-ascii?Q?4Umu00nsxrkN8KR9hmUJQSJqJD0gv1gomw7CqSDF4n2dl/EzpubLyxZ6LzaI?=
 =?us-ascii?Q?SdvUJPfblSz2LImYiE0XG3U0SiwDEL8snQXwKJRSG1vBp3qWi3CC7U0t3ayf?=
 =?us-ascii?Q?2fPT58XtwnlfxKCXtZwnCtNrviyzIVx1SaXf4YL0aluf15Yv3stHlcfYDAhN?=
 =?us-ascii?Q?rWzp4c7Lv1csG9P9pTpcFAuilYUagX//amcfIigiQX/x/G/jwz3MxE2QqxBy?=
 =?us-ascii?Q?I2DwjCXljIZFQua3XzuMxUZqhPhgAFNxQWl1UVqHKcpYgQ7Hh8IPbdEtWeYH?=
 =?us-ascii?Q?gEWWxx6CHqoZX2MXYjlela1yHemomCNufu4RzJM+5cCnRUOAuvxvZ6xwPm0p?=
 =?us-ascii?Q?9bWD6NDTwXXf8F924Y5QxuMWE2o75CfsNEeQEyyz66w7IGm/5sQjnpE/VfgB?=
 =?us-ascii?Q?/1Lm40de+RfE7V2Iy5FZtmC47eO5mGenSMB9iXN6TZ7u0gAfL87E5K0/1v9t?=
 =?us-ascii?Q?r75a5JIA24Cxv2ASJRaGVwa6BmR9r9ptFLQca/IbRvTifZSz4Fp/ylndFTR4?=
 =?us-ascii?Q?XrzRYT73WMGSRj37jgWxX7Y6v7vbcBiL6IVhSLd6HfD6ogiuLe9U16nG6UDa?=
 =?us-ascii?Q?kJp4fKKbKQX/zipiT1QTHkSwi5Os5m7QNT55Cfo9vnhZ2KXqGIa/OU7T3btG?=
 =?us-ascii?Q?T+aQNLo1M5f2SzCR5/f5PKTq0znX0N0N3DekP2X8JhYfrwhDuBiwTWLrNCCN?=
 =?us-ascii?Q?QXVmYnOZ0Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 799a28e3-b7c8-4a1f-86a6-08d9b4e4babf
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5559.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 16:07:53.0244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JIUT1clsjaKktB0yG81lyWmJ0CGFTsbyXs8GNTDOgfUp4KdPto/cIi/E4dGJ0wpPU2Cjd4lIS9mYmI8U1RiazvjWIuBZ+JUs51uxGhHIZ+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5823
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10185 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010089
X-Proofpoint-ORIG-GUID: P-11AQ-awP2HoyuYY7CIl_82B2sLBiJU
X-Proofpoint-GUID: P-11AQ-awP2HoyuYY7CIl_82B2sLBiJU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various trace event fields that store cgroup IDs were declared as
ints, but cgroup_id(() returns a u64 and the structures and associated
TP_printk() calls were not updated to reflect this.

Fixes: 743210386c03 ("cgroup: use cgrp->kn->id as the cgroup ID")
Signed-off-by: William Kucharski <william.kucharski@oracle.com>
---
V2: Do not remove spaces from macro arguments

 include/trace/events/cgroup.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/cgroup.h b/include/trace/events/cgroup.h
index 7f42a3de59e6..1b68c842ac46 100644
--- a/include/trace/events/cgroup.h
+++ b/include/trace/events/cgroup.h
@@ -59,7 +59,7 @@ DECLARE_EVENT_CLASS(cgroup,
 
 	TP_STRUCT__entry(
 		__field(	int,		root			)
-		__field(	int,		id			)
+		__field(	u64,		id			)
 		__field(	int,		level			)
 		__string(	path,		path			)
 	),
@@ -71,7 +71,7 @@ DECLARE_EVENT_CLASS(cgroup,
 		__assign_str(path, path);
 	),
 
-	TP_printk("root=%d id=%d level=%d path=%s",
+	TP_printk("root=%d id=%llu level=%d path=%s",
 		  __entry->root, __entry->id, __entry->level, __get_str(path))
 );
 
@@ -126,7 +126,7 @@ DECLARE_EVENT_CLASS(cgroup_migrate,
 
 	TP_STRUCT__entry(
 		__field(	int,		dst_root		)
-		__field(	int,		dst_id			)
+		__field(	u64,		dst_id			)
 		__field(	int,		dst_level		)
 		__field(	int,		pid			)
 		__string(	dst_path,	path			)
@@ -142,7 +142,7 @@ DECLARE_EVENT_CLASS(cgroup_migrate,
 		__assign_str(comm, task->comm);
 	),
 
-	TP_printk("dst_root=%d dst_id=%d dst_level=%d dst_path=%s pid=%d comm=%s",
+	TP_printk("dst_root=%d dst_id=%llu dst_level=%d dst_path=%s pid=%d comm=%s",
 		  __entry->dst_root, __entry->dst_id, __entry->dst_level,
 		  __get_str(dst_path), __entry->pid, __get_str(comm))
 );
@@ -171,7 +171,7 @@ DECLARE_EVENT_CLASS(cgroup_event,
 
 	TP_STRUCT__entry(
 		__field(	int,		root			)
-		__field(	int,		id			)
+		__field(	u64,		id			)
 		__field(	int,		level			)
 		__string(	path,		path			)
 		__field(	int,		val			)
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

