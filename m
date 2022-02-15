Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E934B5EFF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 01:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiBOAYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 19:24:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiBOAYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 19:24:33 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41C31409DD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 16:24:24 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21ELiTcO015623;
        Tue, 15 Feb 2022 00:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=bpI3oA6uvdcXXK38Ap1/ZsnTvdZ3TQXzq3aaurKzXXc=;
 b=eC47Ahf3WlFyBiCKx3CF2IEj4STsdOaoW93Upw+qcoi+Uhyn9K1LQPb8HwDmQjUi6SeM
 thvZPGhi2YbznykhHHNF2FIBnjfXB5HPo7zt+dz8WwWZJUNcldXEymuMPeYmVw3a1NJj
 euV97rhql8i8c2BEmK71nAGythawbSrIKo1q5KzqgTdfKbTgVLNGao+uubKLRn/IxmcI
 KSxfE3zlVQ9bDFuejG0TkjX0vQX+mjPmoyluSAVCKpInZeni6Qk93urxW+5N30PgOvN7
 7URs1gOpHQIz9qSkV6FjNxkUEXUPBJpGio/c7dUS9blSY4oZ3VJ2mgVm7uATWuqN0rnb Aw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e63g1675k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 00:24:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21F0G2M1188442;
        Tue, 15 Feb 2022 00:24:04 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by aserp3020.oracle.com with ESMTP id 3e6qkxer0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 00:24:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0FtnTetpf2gIhFjEzbwkFQEEdlRNGV/sElMYwuoTFQX4h8auT6qDOHoDyDV1+xggRQ+l7RtxWhubWImd+2tX4Zh0SxUqSvaEy98ptQQIOQJbozCnxzc9ubHfJX29NY7DkKBI4lqKUJUsUMi59jPm18Ui7tmRyyMbwLt2Q6+zAd22iJtin4yTDNtBnA/Ysqn0JL0jfxqTPULD2me161xTpheyNzVlSSmxxHVYHMWE1poV0lEmDREsX4FaWf0lMxXKUHMeAVPK75WTn0wbA4lmRvmfP5ocM5aIvh9R4s+CsWwpPa4JrIlVpkNPBhnCkJBbjT07uGfhtibmwz70sK23A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpI3oA6uvdcXXK38Ap1/ZsnTvdZ3TQXzq3aaurKzXXc=;
 b=mh8TfCpbyMe1HvJCmJUq7p3JvyPnJ/CuZjyNAI5KCa4XdxPtpqmp9QS6ZYTeDYYpvvp8dC/xRyxhboOrqbkbFgsaghY3mSZF27Oudkx+rYRq2tVDjRimYa9vBpXdrvQbA7C7R0I8iOIIgMtalif99eq4Warq1DjtdXrwuWVl6vCaGjOrAO1w5iNTd6xWlW9qwrxUn3XEH0Gl+R61fyJz6NUyZZjIvMf22KJlgFglK/FiSm5qRH9AEX5dMISnnqdLuil8zuhpX2qtNpkkja3zSqM99hmOIpXL7kgt+cEiHuuPQoAEs1Nhai74vflZ7XDtuzOLmu3+v8hI+PozMYkQwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpI3oA6uvdcXXK38Ap1/ZsnTvdZ3TQXzq3aaurKzXXc=;
 b=nuyXZbC1Iz2EACHVC5+93/KcsSmjSqzsW0dAvMmvQ0zsOOca3059pphsugOi6+Pp1i5aiZwuV1AXnK1gCacPKQe8T9/WuKhvOhzqksC6o1TxIwsFglfN5yzslPylW5aD8oDqRCyzkZMUxnK0I79BP+QMxM/u7kw3fhaqAakUfDI=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CO1PR10MB4516.namprd10.prod.outlook.com (2603:10b6:303:6e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 00:24:02 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1%5]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 00:24:02 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v3 1/3] mm: enable MADV_DONTNEED for hugetlb mappings
Date:   Mon, 14 Feb 2022 16:23:46 -0800
Message-Id: <20220215002348.128823-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220215002348.128823-1-mike.kravetz@oracle.com>
References: <20220215002348.128823-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0128.namprd03.prod.outlook.com
 (2603:10b6:303:8c::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8659d293-d79e-4bb0-f584-08d9f019775c
X-MS-TrafficTypeDiagnostic: CO1PR10MB4516:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4516E6220A159FB89D91E137E2349@CO1PR10MB4516.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PUb+RNBKFSxfy/wKb2ousWFO7GDWrKhu/oVpNssFVgd1bBBViIZVIRvcIlAK2wQdn/sH/S+zTs2+0EbvDoUWKzdHsp8Ac7WPGACkMj2d6gUToEyt3TdTk6aVElxoa+XHVhKMO61JlYdu46qZm8dhH/AprExQNdHfX8e+aXCO1XxuGJlsFYZvtfouaUGu89XyG3VmJZraUGmdS8gVr4JZkg9MKf6et7l5UZFv559TAK8qlUdfr2tj2YFEduaNDyRW0fKNuPj8TECjgDhRuJXvJAA+A8ME6/U+1oKenMX4UvfXyEMVWsiXHb3CpQSjpAno8R9SvpaTwK0a5rLvTe2MYEyfzxjP8cmJ807jn7xQJS/yUdCUMlsqSzkDpyHIU8tKuR654y8dM+7cD52gfN1x7/swDvGkyI/KD7X2sLOZqFRre9v4vIxDdTs1rr1Mi17iqVYcDrzcpgRZvoi+IVaMPiVURBFi2Ikaei7NApNMbAdhhqa0qqaz7tjaICH29C7XrirTrtnifTpmvgHe7CWp4+V0KuENnE+Q8sSPK+hehRzvzaCbf2omLLCm/VjM6kmXP8CT4OrEZWlc8DL+/uQk5VBq+h5YUsBowbdqSL1KJAkINAs7NUsL6JZsAphxi4aOSdGL6xLwDBWu783zeKiD4KrmU9a07Th3ocGMHlIarjVCgZGpnkM1qtzTHaPthuFATeC9gJcgtNaTo3JnHeyHoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(4326008)(8676002)(8936002)(66476007)(66556008)(6506007)(5660300002)(508600001)(316002)(52116002)(44832011)(7416002)(38350700002)(38100700002)(54906003)(36756003)(6486002)(6666004)(86362001)(186003)(107886003)(2616005)(6512007)(26005)(83380400001)(2906002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4J5DhqWMHdAFfXDJZQh8gFowVcqJMXnC8kscpYf2rgUs8U6BH40S93We5Pbk?=
 =?us-ascii?Q?29lB+pY+h5eelbYW6PL02DdSfP20D82vDZ9GCugTQJXQHZw0Zzjm7Epry+RF?=
 =?us-ascii?Q?KAipcoppGF4WtT+MN+lswAurnzm+L6UnLpVwU4W8Dpya15EP5bHnJDAkOOIb?=
 =?us-ascii?Q?zadBeF8Do6nLF/bk1RRzBOYDbsNgHTerm7HKcixyZgnZfoFbf+Q1CnETuyxT?=
 =?us-ascii?Q?LnNZg/zZMXr7ENzMfwpW7pOhuqjOoZGyBUv/24TJJqZ5uX8hadBvHp6eHBlk?=
 =?us-ascii?Q?kv7Fwddzz/XcC9ZeNmBbgnj/8SK/1LJ8ttWsVwymHIgPgOtaAdoNjNaW0dxD?=
 =?us-ascii?Q?pHZN2W3xXEDGUwQ/ckMzNnAGz8iKo/xpjTp0d4hyZtNqAVrR65IPi0qDHxpK?=
 =?us-ascii?Q?4IWe5V8hCnb6u7vhaUY6iX9tGsGhkeoUKf08W5XfV5iQ/iJoUU0zUUxDB0nx?=
 =?us-ascii?Q?BjVxwSECL59ByA8anLSYd1IS3R/FcJdrUKOlPkpT6PnM/QwPxBcqDIivfUO/?=
 =?us-ascii?Q?xgqAO7L72KZlKBQscgWrXNOHOK/hzRuyr205YMWj6+KhmFGWKxrntxggXawX?=
 =?us-ascii?Q?kfTzYsjJP8d5gr4uOdXf/kxm3j7S9KLUU3fIiZyRZOPgegcj76O3KaBxiDxo?=
 =?us-ascii?Q?26kA/s/uDAqKwkzKn/u+7KBR0gMtcjIRNXWX3lyqZUGL2u5EQHrRpBmHjAuo?=
 =?us-ascii?Q?BURnlbmXVHYcP93kVA7O45vWRxCxATi57BqQuGM/bWKsCAujVjrNTXh/w1UG?=
 =?us-ascii?Q?J582J7R9Fg4tFGNsunCctMVsctwLN4SX3EIQuXSgiwnHnRz9irCDQqcOV/Ky?=
 =?us-ascii?Q?VRFtMuWJ+BgOwU8kOVB9Nb3w2q/5UEth/bZMmLhj76m9Tfa/+nD3Dy77EUhB?=
 =?us-ascii?Q?2KVhPds92iTf6e/BwK5GgR4XgCjzBUiu+SUo3sk8rx7ObL3nicQnjXyp3y1T?=
 =?us-ascii?Q?hcATBUm52ZT13At2QO1KfClQdOV/Tn24Ejt0lgYCH1BuDlTNhmalKyllLIqy?=
 =?us-ascii?Q?Ou6a8rUpDx5ecSpmbY78xjgqr+dRbSmOvSZ8JijKz0T5V8/a2XLg1tniX0ZG?=
 =?us-ascii?Q?eZ4rlkZygQZw0X/H92+YwYazvwzoBHiePS0obxcR7U/PmJxDc+q4UbufJwO3?=
 =?us-ascii?Q?5o/wDWwBsm+qRJJ/XjcroHN9NsD4WjaKQQ0zacfM97yH7gFNguLVlH0IQeSH?=
 =?us-ascii?Q?YNeTWIth4bZYquya1Ob5l5cMFEtGcSXrMWlP7sM0Mno8L7Qgka++hkXHor2b?=
 =?us-ascii?Q?1nqk3q4Zacw2NffyW9vr8gJqsQai4dg3IiUKffBs+JyQ6HtZnkKRz3YHrwlo?=
 =?us-ascii?Q?yx+kq65jNYk7SnGd3pS6CZsqcmlgHmKv+Cwy9xQPkB5u4yXLTsuSpdvbbTgB?=
 =?us-ascii?Q?+/dbxiaNJYapQ/ZqmDUKSpEvWoMubftGisfVi1jsWvNm+J9qcuCM4pYQGqfd?=
 =?us-ascii?Q?p37Qfl1uxerKPzvYySTlrAUfxDUZ93sSpxuK7aT2MtWADY+w1iQMCTKLd0eu?=
 =?us-ascii?Q?ek9iiTp8oRSMtV6zi8rIMuqhNt9Q+zlexpyNh8IbqQbZ2rtHLw61dSLWXvFK?=
 =?us-ascii?Q?Ph4xrEcittuqSbX2PXZ3qtOer2sqpGvzLlt/HFwGrdrDnwYDYqBO9QoT/R8D?=
 =?us-ascii?Q?yiBkmYzIj89Ll3fMlUwsSlM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8659d293-d79e-4bb0-f584-08d9f019775c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 00:24:01.9252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: atX4XXst0mgOxT9zBWXrlBk18Xt8hyfMxPhrlCXPK/reMKNeXINvhS8Pd32SqCzQI5ajcyy+Njq/hCJ9qmXNHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4516
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150000
X-Proofpoint-GUID: Iim7IaqlMWT-8TO0LR_ery1avForENQ0
X-Proofpoint-ORIG-GUID: Iim7IaqlMWT-8TO0LR_ery1avForENQ0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MADV_DONTNEED is currently disabled for hugetlb mappings.  This
certainly makes sense in shared file mappings as the pagecache maintains
a reference to the page and it will never be freed.  However, it could
be useful to unmap and free pages in private mappings.  In addition,
userfaultfd minor fault users may be able to simplify code by using
MADV_DONTNEED.

The primary thing preventing MADV_DONTNEED from working on hugetlb
mappings is a check in can_madv_lru_vma().  To allow support for hugetlb
mappings create and use a new routine madvise_dontneed_free_valid_vma()
that allows hugetlb mappings in this specific case.

For normal mappings, madvise requires the start address be PAGE aligned
and rounds up length to the next multiple of PAGE_SIZE.  Do similarly
for hugetlb mappings: require start address be huge page size aligned and
round up length to the next multiple of huge page size.  Use the new
madvise_dontneed_free_valid_vma routine to check alignment and round up
length/end.  zap_page_range requires this alignment for hugetlb vmas
otherwise we will hit BUGs.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/madvise.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index bed872a2ad5f..ede6affa1350 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -554,9 +554,14 @@ static void madvise_cold_page_range(struct mmu_gather *tlb,
 	tlb_end_vma(tlb, vma);
 }
 
+static inline bool can_madv_lru_non_huge_vma(struct vm_area_struct *vma)
+{
+	return !(vma->vm_flags & (VM_LOCKED|VM_PFNMAP));
+}
+
 static inline bool can_madv_lru_vma(struct vm_area_struct *vma)
 {
-	return !(vma->vm_flags & (VM_LOCKED|VM_HUGETLB|VM_PFNMAP));
+	return can_madv_lru_non_huge_vma(vma) && !is_vm_hugetlb_page(vma);
 }
 
 static long madvise_cold(struct vm_area_struct *vma,
@@ -829,6 +834,23 @@ static long madvise_dontneed_single_vma(struct vm_area_struct *vma,
 	return 0;
 }
 
+static bool madvise_dontneed_free_valid_vma(struct vm_area_struct *vma,
+					    unsigned long start,
+					    unsigned long *end,
+					    int behavior)
+{
+	if (!is_vm_hugetlb_page(vma))
+		return can_madv_lru_non_huge_vma(vma);
+
+	if (behavior != MADV_DONTNEED)
+		return false;
+	if (start & ~huge_page_mask(hstate_vma(vma)))
+		return false;
+
+	*end = ALIGN(*end, huge_page_size(hstate_vma(vma)));
+	return true;
+}
+
 static long madvise_dontneed_free(struct vm_area_struct *vma,
 				  struct vm_area_struct **prev,
 				  unsigned long start, unsigned long end,
@@ -837,7 +859,7 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 
 	*prev = vma;
-	if (!can_madv_lru_vma(vma))
+	if (!madvise_dontneed_free_valid_vma(vma, start, &end, behavior))
 		return -EINVAL;
 
 	if (!userfaultfd_remove(vma, start, end)) {
@@ -859,7 +881,12 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 			 */
 			return -ENOMEM;
 		}
-		if (!can_madv_lru_vma(vma))
+		/*
+		 * Potential end adjustment for hugetlb vma is OK as
+		 * the check below keeps end within vma.
+		 */
+		if (!madvise_dontneed_free_valid_vma(vma, start, &end,
+						     behavior))
 			return -EINVAL;
 		if (end > vma->vm_end) {
 			/*
-- 
2.34.1

