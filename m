Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB454A039C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 23:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350593AbiA1W0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 17:26:44 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:51584 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230083AbiA1W0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 17:26:41 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20SMCt4l020724;
        Fri, 28 Jan 2022 22:26:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=JbNnOAY7/pNJVSMUUNZ+y8NOLvEedODea2X/9pS9EVw=;
 b=et2YnEDzk1j7yeMbTB8+Cvlsx/OoTbEoC3Iz5MYHA2PFhTDTtLcld0/nh5iqReYFw9mC
 6YnpMWPCHymDpxhRM+GYiyuMuLdBMM5KZ7q3szqT/PY3po5W0XgtkJiEkFQqta19IpHq
 U4cd2GpIf0uSY17u42ja47ysDMzvSdebe2jsOsblyXdb7+C/e5FZ9LiwVOIPP9mxI8U1
 Hxp0eyen+Z/nhRYlGI8Uzv/wxFRuS5ppPzv6pBq10y+wDCz9kS1YpDXanxpc5HA2Q+yS
 yEY2z+ZPBaFpACG6+tDVW3Bro3Ke64pwKGOi5aMZLf2ntqcCb5p1NQPEkKkI37lWy6mc HA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duvsj4j7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 22:26:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20SMHRA3142671;
        Fri, 28 Jan 2022 22:26:26 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by userp3030.oracle.com with ESMTP id 3dr726qbsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 22:26:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/syO7hxFpP/yvEYhRhBdWOCDru/5nNgiYqu3qs8vOjV/GPyX6cixtv/S3s6/GbHWUPNcul5acdeBEGDna+3JSbghmWUcNC8tqG4wlCEw6OHF++nwnjiiFhQd37OalMIZPQSwzOGaqegmt1rnD6M+t5Cx5gTe9KRmSzPp5rgvZ8Wa62yGtgR76sxjK08uMP+famDX7634MsfAuGYu49GEySefpydWBiM0jWgjH49qavN5v4AsfCX4epoYLDPjSe6rL1KNXlXLnLZsHaCbSwfQ4osez59ta0qPHJ5SzQVRBQXyZ18tBtHR1mzBNJTQkIse/y8KgR3OAgF3/l98ujhlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JbNnOAY7/pNJVSMUUNZ+y8NOLvEedODea2X/9pS9EVw=;
 b=RX3w0lgvyIQJMd9vjspr/7T6Fwyjke6Y07AEmuVkglNre9jtZY5cjJ0ETKzCD4gkGWFnc36me0ead/jI/8+qVk77VyfDi4eqpleHoW9d6qXSAcefCdrDU9fy0LFJOuVs0nHv0iX03IRpPwjf93HPdxsX9LFOJ5laWpBPuR+c941s7FJFHxHQVsBwlNmDyN21La2g4VFK5S4ZHrz1refFNrw+TEAPNixoNJasSBqO3ltTiXxJ/4N02aW/l+axV8sqxT9ArLE2IQs3FMEmcwYhLoxwValxGxa1qtNyEPy3TrA0I3eRYjQJxSI6tSSdOiVyRtV+8UAVYPuXeodcLmz0Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbNnOAY7/pNJVSMUUNZ+y8NOLvEedODea2X/9pS9EVw=;
 b=bUnWj5+j7Mjjz8Gig82LK0sGQLcNsekmTep2GIHUZNiQvu3m1ISRjebVjWGjKz9zMMJAfjVt1gM/cZHE6J2/287jmalmqEIccPNCXSP8NOG3T4l1EIlq6d/Ee1f7YmXuRBEfVca05Mle7v0o5oe36JfRiof6+64409vnccajBFk=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM6PR10MB2587.namprd10.prod.outlook.com (2603:10b6:5:b1::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Fri, 28 Jan
 2022 22:26:23 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::90eb:bb07:608b:7556]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::90eb:bb07:608b:7556%7]) with mapi id 15.20.4930.019; Fri, 28 Jan 2022
 22:26:23 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 1/3] mm: enable MADV_DONTNEED for hugetlb mappings
Date:   Fri, 28 Jan 2022 14:26:03 -0800
Message-Id: <20220128222605.66828-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128222605.66828-1-mike.kravetz@oracle.com>
References: <20220128222605.66828-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWHPR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:300:116::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31a24521-3813-4d2f-0f6d-08d9e2ad3703
X-MS-TrafficTypeDiagnostic: DM6PR10MB2587:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB2587391C93C61B74B1F2DB89E2229@DM6PR10MB2587.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7jy52z6mKJc7zK+yrrJeCX9IpvOkCzCDkXLXqPrb4w1rTfDNQtnuOeJqdVZ8jIsxbqOGMdIngLDqQJnzhzGhVLJ4XuREbay4ex044v5Bxy2xFXY3lIc9ZxZKQB/G3R7Xh+JZ1xvRVnAe0qyRttfpoHtx4mV/U6nDpxaiP2dIMaqOpvYN+F1PILXJrJiRgGokrkSwxZXF07K3oxSiAytr21amYpOV6+yhBqdvdsaVTim0Rs4oUvlOFcBHisyPqBii1BBV+femJG1FpiNaaF+LmGGCuBZKck0Nw3Wmg54a2/gK/3hqRPrvIBlCjv5G1r7Q0Aj6nqnDd48FG/j2in/Y0Kr6mOTLPEqnJPPJzxC/wevzifeW6SOiQ7UQrlRTAkEdGUEvZwmIPMRV9y7UGSg3eYnUZrzG6r9xkIBDkc4i0pNmDqpn5zsA2h6opsX1LPDfF2r1HE00Vw3clTujCs1on3inNgDSi9krKnRm6qqNwnanIrwkLZrD15aS2qiQpBdb0mfMLNPSePhTlp/shj83RvhsKWBOGzf1Nc8AcBH5Z8GnRjzzFJ55W5yLQD6d33pBIDich9/Z0DyYmDcYqJvVIMhTCsSKhZeuoUHJobr3D+skkeK8ufaOGBE5U4x0TJsylfNMTzBeg63+emxMAJ5Ntyg6jUk1Ymz9ZNoC0nEt9QqmR5KPuip7eoj9uiUdY8jVEjyDlJkBW8vGWYrYerLotA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(7416002)(66556008)(66476007)(8936002)(36756003)(66946007)(44832011)(38100700002)(38350700002)(54906003)(316002)(4326008)(5660300002)(6506007)(6512007)(6666004)(52116002)(107886003)(2906002)(83380400001)(508600001)(86362001)(6486002)(2616005)(1076003)(186003)(26005)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/HZyjxlSx7lYzQ/6qcq11/IpfMfBhJtLnIBa8RwZx2erWuJkmq67HDNFFP7P?=
 =?us-ascii?Q?+x07JDPP0610GAesNayMAn+LjHRLEqufbkBA7FC816/wRHUdVStUGWatsFb/?=
 =?us-ascii?Q?miwnjpdRn1SEI1mP5WxmoUtHsJ/W7+ovxM7Qu34yMNpW4KuIyErSEuiUubfo?=
 =?us-ascii?Q?jF/yyqnGLRs0TCCneX7RfxoByenVylQS9ujESetjumVn9yMYd8pwkYYU5bNj?=
 =?us-ascii?Q?rMDQkm3j04p1FE3GMxeB6Ltb1POSlVne456vT1MhtGLsM0OP5xJEvBaiz7K+?=
 =?us-ascii?Q?1x3IE38Tf35zWVyplQRgtvlRBuY0Cp1+qT09fkX1c82gHOZFqqp/2vXbviWU?=
 =?us-ascii?Q?vBQ0z1sZlVtrvKOAtcmyEn/x0eY0URuLW2bKOojMQO8iA4NGafHpGUTfS49w?=
 =?us-ascii?Q?Byi9ovv13lxVpOA1Evnb+LvAH9yJBy/U6O0kp8BxUJGvntGSH3E+dOxPPx//?=
 =?us-ascii?Q?/2FpEUisuiXvUNE/f0vkktyFLcm8AA9Orgbf5jkUOCLB9kdXwblgand1IdNx?=
 =?us-ascii?Q?3zfSleYIT/PnyK6F/6RKfAR2YpWJ9eqTuY4qeTrjHZy5ehXAamvVi2WXeIhA?=
 =?us-ascii?Q?X/njKNxDBzpUcq8fteZ69CvI4sBhoAGR8SCNbLzSo9eSjJ6HtJcugjv/qDbA?=
 =?us-ascii?Q?1BNO4qDoeZ5l56v6d3xoAi4/6q0DRQ12LxVFpdq48iNJ2gdRbuyfex+ni+S/?=
 =?us-ascii?Q?YX63JFBqbkVfJJWIDzVY5InmjuYa6IIhWsC8toVIHIlqTPP3aRUSn+hSWH/k?=
 =?us-ascii?Q?/6HbQv1nSlCbgA6pQtSEtvlN0dggMvsW8ZSEc2PO4PgsA/zxGeW2ptBDQxPg?=
 =?us-ascii?Q?XOqGJnkg8MytHiDudz1s2BnaJo3QKa27BRZukj7cHh+F7qUbw1DJuH42ykro?=
 =?us-ascii?Q?cvDxRTE3Nk1X5AJqZrK21tJChqHdbrDBRIcU5Rnb1vPLmuVqMOmFY1IPy366?=
 =?us-ascii?Q?cEHicIl/Ei7K4Nd9VMx/tke8IJ5rEhVh8ilfPoWjyMJt8YXcR+SYeI+kzSGa?=
 =?us-ascii?Q?L6M1ni9O73PpUzcJHc7yyDnxijOeebg1jmGQKMXjbm0Uej+0HFV0FxlT3c/c?=
 =?us-ascii?Q?WvNcu6ZoKKuqz4HNzqrRaJGRBkfwApzbeTCy+7hcMPEVdbzUg6WRG+IAlZDv?=
 =?us-ascii?Q?eVLiuX3jJwEhUzk5UCnzk5iUu7jB1oGopjq4Aq2jJ7SkVNELJ/QEdUqSqWDM?=
 =?us-ascii?Q?v0aGy9Yw9dw45C3jyizAdWaNoRze+MFAtRthl8hGHSjFnzaJSmB6/DFm0z1s?=
 =?us-ascii?Q?2SaBRTzSvd2E3kMn+v6JMkjnNlklgGnSUKhZBnEovkHspZmTRxaUeU1uF8Cp?=
 =?us-ascii?Q?Mb/my573Fl8bbDCiAjk5XvYPD8Ek/yO5mL8YK2aqwFO+orwovj28ZmESJMFY?=
 =?us-ascii?Q?6wKAILCTTX01tZpuzZohi8vi+NCl55qPvOYTP1jSGoECk96kkiXEnmNvtVJv?=
 =?us-ascii?Q?oOOVVRATBepSJ6WJx1v9a41ah3ozZhqPlvuxE7g+HXs35JW9/Is7vcI8b1vp?=
 =?us-ascii?Q?5nvQlszasJHXIeOwpmsHrIaCsfkXP9dznzmDXu8ISR5VZhM23LjB47oRb4sa?=
 =?us-ascii?Q?S8ce0fKy+qvDpe7HjEwwY0PhX8UI5rskY1k5vVC48v8VO6IV/hqP6fXhnY1R?=
 =?us-ascii?Q?eqfq2+G3Fsrlw8M79Uy4paE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a24521-3813-4d2f-0f6d-08d9e2ad3703
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 22:26:23.1521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3UnkqTiU/Il5pBmatQfASF2fq/d3tnT4HUa9UXE7oEYY+DJ6Ieeez08kRkxfwUSYbWCdw+I+bA14UeUQuDEoNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2587
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10241 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=861
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201280125
X-Proofpoint-ORIG-GUID: 69E9sNJSnegydv5YGvUvixRDFYf_G7Ol
X-Proofpoint-GUID: 69E9sNJSnegydv5YGvUvixRDFYf_G7Ol
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MADV_DONTNEED is currently disabled for hugetlb mappings.  This
certainly makes sense in shared file mappings as the pagecache maintains
a reference to the page and it will never be freed.  However, it could
be useful to unmap and free pages in private mappings.

The only thing preventing MADV_DONTNEED from working on hugetlb mappings
is a check in can_madv_lru_vma().  To allow support for hugetlb mappings
create and use a new routine madvise_dontneed_free_valid_vma() that will
allow hugetlb mappings.  Also, before calling zap_page_range in the
DONTNEED case align start and size to huge page size for hugetlb vmas.
madvise only requires PAGE_SIZE alignment, but the hugetlb unmap routine
requires huge page size alignment.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/madvise.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 5604064df464..01b4d145d8f0 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -796,10 +796,30 @@ static int madvise_free_single_vma(struct vm_area_struct *vma,
 static long madvise_dontneed_single_vma(struct vm_area_struct *vma,
 					unsigned long start, unsigned long end)
 {
+	/*
+	 * start and size (end - start) must be huge page size aligned
+	 * for hugetlb vmas.
+	 */
+	if (vma->vm_flags & VM_HUGETLB) {
+		struct hstate *h = hstate_vma(vma);
+
+		start = ALIGN_DOWN(start, huge_page_size(h));
+		end = ALIGN(end, huge_page_size(h));
+	}
+
 	zap_page_range(vma, start, end - start);
 	return 0;
 }
 
+static bool madvise_dontneed_free_valid_vma(struct vm_area_struct *vma,
+						int behavior)
+{
+	if (vma->vm_flags & VM_HUGETLB)
+		return behavior == MADV_DONTNEED;
+	else
+		return can_madv_lru_vma(vma);
+}
+
 static long madvise_dontneed_free(struct vm_area_struct *vma,
 				  struct vm_area_struct **prev,
 				  unsigned long start, unsigned long end,
@@ -808,7 +828,7 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 	struct mm_struct *mm = vma->vm_mm;
 
 	*prev = vma;
-	if (!can_madv_lru_vma(vma))
+	if (!madvise_dontneed_free_valid_vma(vma, behavior))
 		return -EINVAL;
 
 	if (!userfaultfd_remove(vma, start, end)) {
@@ -830,7 +850,7 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 			 */
 			return -ENOMEM;
 		}
-		if (!can_madv_lru_vma(vma))
+		if (!madvise_dontneed_free_valid_vma(vma, behavior))
 			return -EINVAL;
 		if (end > vma->vm_end) {
 			/*
-- 
2.34.1

