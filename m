Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738E7519379
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbiEDBWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245311AbiEDBS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:18:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0591F443E2
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:51 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243KvDsg027626;
        Wed, 4 May 2022 01:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Hissl+TYg1ZFcbpNE69lJPC/TpVSmXhffRFRuq41qQs=;
 b=l8Tvs8eONiQXfwtFaiHspqPzIwp/rr14Wx4DOoEkbvf+0+iZKXBl2NQWKx2WgTWtlgXC
 ZvX3+p4hSU6pu6MMoITzBSooKDulmxASnVkp8UeQO7VhobA0J4GTfXIlvb3NVCyKcHme
 nPfHCxtyLvcqLL+BjTwGZkQeYiewRidTmt512Kuv+rONoKIUKkTkNzEQrMe5Huf5qk8t
 bzYz2BmfzL7sy4Gl1p3dmp+UkbygWwP9GJ3bCsTAPZY45N2sSAEHIiZA8S2uVTzi3cxk
 dz78NUK6OHDYgCRByyvh/oOAJLRhj5p+EKcfBbMIuHBNUB+NYg1zQHYpNzx3nMqkSDZJ ZQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruw2f6ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441BJT5001264;
        Wed, 4 May 2022 01:14:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fs1a57vyf-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgA4ysNZ85ngUy+frGxjoj7/Syv5tA8x7205o2sATxWea7JCtWKm55HKJKskQhEdxMAIa2q8RBM+axbCohpVjSxShx12S5cueAJS+tYSkCZWLBLS1DuftubDlqKG86g3e5Py36CucVInVbanArI2FQ0YbV5Spy7KxnIQxKt7vJQHljdxnbyMKHMocxzX40oKg1BodYRnd2r0kQaLnUy51d3ud0iy911gdkw4EywmKlEip9KyZOG0WAMS22eW4EgYj8VYpdMthWkcL8Hy1TggEXKvRRiwHJpltBkSJmBeq/zIHcHiuGU6r8e+qeVFD7XYsvb3dX3pSNZY05y7IoiC8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hissl+TYg1ZFcbpNE69lJPC/TpVSmXhffRFRuq41qQs=;
 b=LIii1M09ePJRJ2Ucc5p/I8b6pTT458N/26X9MKz1MPa9hukRRgV9V3WNCtRB+1H5JWxQAB53/NQrih7Ed8SzZihSqZr6pkx7qLWVuKYQgSliSdH2/FsXPwuQaeq3hzCgL1tfK3F6U9TMpUgzqhnwMZ7abVz/YYLMNER7BnLv9xiVSptjMW0VGbK0yw47l7GCuPKzCBqXkvQxncc+QVbW1Y50Gv4YJqVIB10LqZ1zOAkoGxJIa6e7Q3Geg24zuJM1CmVd8mLYVTmR2IYTNr7xVFiSWfAqJNVrYTm1RGwxKDPhGvSzSSf3o5SMl4BcJOvlFoSJZaumE0rVPunj3nFluA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hissl+TYg1ZFcbpNE69lJPC/TpVSmXhffRFRuq41qQs=;
 b=aOth+UOHp5pmOmOsi24U4AwQUD5nxCMXNbcfgKU9XJVOrLer3u6gTlc6i1n1OegO+yqYyu2ZJ/z+u4hFsRsBdRhsZsf8xnGa3GY2Rz8erCDhfDq5bxjme+FIYJet0NbTrzclcp1tzZF/36pIIqIZvyrefpjD1rVOpVMD927szDM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2688.namprd10.prod.outlook.com (2603:10b6:805:4e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 01:14:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:14:42 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 68/69] mm/mmap: drop range_has_overlap() function
Thread-Topic: [PATCH v9 68/69] mm/mmap: drop range_has_overlap() function
Thread-Index: AQHYX1RA4YUOuSrVSkiTHMJE4ejJeg==
Date:   Wed, 4 May 2022 01:14:07 +0000
Message-ID: <20220504011345.662299-53-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5f98614-3db5-49dc-bd5e-08da2d6b7823
x-ms-traffictypediagnostic: SN6PR10MB2688:EE_
x-microsoft-antispam-prvs: <SN6PR10MB2688C2B1D28683CEBF5D8E44FDC39@SN6PR10MB2688.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YUtNzENuNycepYjFCvAyjsPgHpaGUuTqIsBwlNyiiulWtXUIx7L6PXLeHgoP+7wrcSZQqCcCZGrakg59Xuv/oPxNPp8u7/VzjMDPbjrYjvFMGAFJCp+ymKoMMxPeKCdPEWlk5A71FNaIHHTZEG/DWnl6qRz9Ap+bZCUbReSLsNxvknbH3sAuZPeDFEgqprXCrxGjo+NOAn2CTRf9SpZjwjGHkd50ZPBrIp2g7qdQlR0zjDSere19+jvAmJ7wkzCQ5iBNN34Lv+ceHsPOIZ+QzLFeP0SX4sHeP30YsYmhULwZq5brYrwbjBt7iMK6ylrCPi2CIDFYYx+N5oO6UtzOVm05kDOYQ2AVeAvwEGDBHR5uzKgCMTj6V4mWwO//l3Jnxem4IHnR1aPIbTIiTf7w8vtoSzzYZVKcQjtpWbGoBIAIZvieKNmEmjJNCuQciHll7xP4ujKkNKDsQ1ODaq5bi0MpTRQ/RMewGWVF6oGEWZBYD7QFRlYNQd0wK9dPsqmIXo7lcY3rIhanFo9Qy62ROFfuWKfNtwZtwhsIar/KTKPeEZhMqwbzsSuD/mmA17lIxqSw/nr5yCyCKmVSlL7hNWRNCEZMzPd6lE589JtdDSuBWuDJH7gvDcLPqYwFATinjQ/mvx2ftbK7KQIKwrhuB5UQKbONN1MpsH+xv+fWywiyemSJZEalKSv3wQBs/XuBEAqsji2kOokyr+ph9urwHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(122000001)(1076003)(2616005)(66476007)(8676002)(66446008)(64756008)(38070700005)(36756003)(316002)(38100700002)(66556008)(66946007)(76116006)(91956017)(110136005)(26005)(6512007)(71200400001)(8936002)(6666004)(6506007)(2906002)(86362001)(5660300002)(6486002)(508600001)(83380400001)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?V/+MTFWddLVCcs3uVfGYP3j1ZOxcxBcag5e/lW5yoIqgmtPQTvhIhzJ2R9?=
 =?iso-8859-1?Q?Ai0gXimvhaEmIwWZqbkaMr2xznrCk7r32Sml6XTpfzGJ1MwT2DReO+ge94?=
 =?iso-8859-1?Q?3m30WCUv0+XqLlhE9eOfjxDijpJqCuG/w6xCqSWmOlNgubZPx826oNGjZZ?=
 =?iso-8859-1?Q?Wx82n6NZG5cZwLnMWpEYDs7cYTaRLhdNl9E4T/JhakhWKyADMaMj04bTD5?=
 =?iso-8859-1?Q?aipChULRRJz9Oxk4CU9RrTatVt9OP5NQ1HlKX0wgYeTgtEQ8XJy9EQSKue?=
 =?iso-8859-1?Q?JOWWKQUeSf3djNac7YN4x2P87NIQFNv+HCfZlg2TgyKQVbOf3+UJ1akIeZ?=
 =?iso-8859-1?Q?ALFc0p2IM1nesTynxwgnVwLmRzvSKrHVA0HmjmDGS82r7WWmLc3qGYuf5I?=
 =?iso-8859-1?Q?rNgOLJcBrt6Ptvz4Ne0wzB5crrOvGqsXCh4sJZWV5x9MXOKh1p+r5/fl38?=
 =?iso-8859-1?Q?tTwSp+mSz40kYif1YoAt1tKM/MCVrluH+YkrEZnUyV6P9rS30XTSpRLUC3?=
 =?iso-8859-1?Q?7DQSE5cQr+Tr+/a0Aurp3CJUatcbIaAQaZokowcLgxGbxz9Y9V1lvUxr4k?=
 =?iso-8859-1?Q?XgTIrTidnI2wK5ssA0mk4MdYC21QsCxoLzMd8sD9BOBxu+zAsZm4aJ3Nzs?=
 =?iso-8859-1?Q?5m7oLO1ZtwcVbWiwl+FyeUSgPG53+PIKm+L/Z3cHW5rBFLf3BuQ+IJazy/?=
 =?iso-8859-1?Q?UesnCgxORJgT9JJyCnN6zMwbh8WFn7EvK9UFmDtKrUMU8aDueIxylpW55j?=
 =?iso-8859-1?Q?tEI+2jzU7eQMJDafv981qCDfj/NSjiU+LDwsrq2Tj9iyLqIn6VVhp3oEQx?=
 =?iso-8859-1?Q?/YjlRqzq6lnYJZsahYIXaECmQb4WhmyHvmKzMRtOKdmUdPmBgU0cWTJCUm?=
 =?iso-8859-1?Q?POlygOFIy+ln+zoH80mzN5E5N0swolMf2Z2D4ISd19DXkJEVsJ/DFrIEqD?=
 =?iso-8859-1?Q?YfZqFo+evbf5iGOe8jldZVIlE0YXimLvHRz/fMYzpyA8ZRNh50AVIRWbn7?=
 =?iso-8859-1?Q?3LD9Vq8/GRItP+hOWkashEpq7Xn9uiNh6zF87jiTiOikxiLo81gf+jfez7?=
 =?iso-8859-1?Q?e4Js/17nGiLQVsEPADBDrjuAHQVcjX93Rpiv4KsY9Ial7aPwWCYuLvng0l?=
 =?iso-8859-1?Q?nV//wtXVIdueqXMLkIJ6muA2RDBaEk87B5quEKn39oP9R+qPUpFfJqWbrX?=
 =?iso-8859-1?Q?gLdeXZN/aBKpcW+B1+2ZBQYRkJ9ctPcw9EXkYFAVzUOtUdHytO+iPfGuJH?=
 =?iso-8859-1?Q?4VL0VhZylVjRauRS7C+jwTQzbCRhucPPl6Ph5Co6KISLeCHkwgbFL41GsP?=
 =?iso-8859-1?Q?EWZPqZ2umJVRbkRMOjS//QGF/VohMyw4DZWwfsWz90KIgORAkamz+7yATh?=
 =?iso-8859-1?Q?ewAyUVXycVxrixRF7W8ld3TXVIxdJf6rx/ZLTmLBzB++gTBxr4euyVWyOH?=
 =?iso-8859-1?Q?Tt2j6K2F9KW6P+csw8uNK0mIi3qi/wJqCsmnnze1XrcwmzvNpU5BiKHAZp?=
 =?iso-8859-1?Q?x5xjFFpBY3TYmILBFAd6SQ7/FMxPmflII7ct0P86nJgmyeMG8EKHKAZg0q?=
 =?iso-8859-1?Q?8n2Leu5gFnabC1GHBuQ5rXpS/bjK3RMgIW14YUrS2w7HdL4VaAOYNoOtqV?=
 =?iso-8859-1?Q?YOsmL8IE1GuXGwS5ZnkSbie5tA37iZWFB09I1ygu5JRZ49VFq7rvImfIfz?=
 =?iso-8859-1?Q?LR8YBXb4o3em7GGQUyZwl4Z71t9PbitslkPrEhTdfGPVPXNj2Fb37RAF0e?=
 =?iso-8859-1?Q?E6CY8pfkDQ3NTMrlJzuWKP17uml1bu8L0N8I1HKUiPCX5B/OoFClnZEfs/?=
 =?iso-8859-1?Q?MBvif7777eM2Y7NlmImhEL8ztI+tj3I=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f98614-3db5-49dc-bd5e-08da2d6b7823
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:14:07.8915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BDSbPcH1YAiIEFOx0Kc+nrmOprkWnj64444ZgTvwJKuu5S+/Wp0lUs2qOWBHIntjpDnSsQVxJ6QpzIN8cV38Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2688
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-GUID: 3lkLEK9D5ekYBcuV5kDWsPpwbZ-cHOxa
X-Proofpoint-ORIG-GUID: 3lkLEK9D5ekYBcuV5kDWsPpwbZ-cHOxa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Since there is no longer a linked list, the range_has_overlap() function
is identical to the find_vma_intersection() function.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mmap.c | 28 +---------------------------
 1 file changed, 1 insertion(+), 27 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 7704c879bc6d..32d3922cec27 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -437,30 +437,6 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_=
struct *vma)
 		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
 }
=20
-/*
- * range_has_overlap() - Check the @start - @end range for overlapping VMA=
s and
- * sets up a pointer to the previous VMA
- * @mm: the mm struct
- * @start: the start address of the range
- * @end: the end address of the range
- * @pprev: the pointer to the pointer of the previous VMA
- *
- * Returns: True if there is an overlapping VMA, false otherwise
- */
-static inline
-bool range_has_overlap(struct mm_struct *mm, unsigned long start,
-		       unsigned long end, struct vm_area_struct **pprev)
-{
-	struct vm_area_struct *existing;
-
-	MA_STATE(mas, &mm->mm_mt, start, start);
-	rcu_read_lock();
-	existing =3D mas_find(&mas, end - 1);
-	*pprev =3D mas_prev(&mas, 0);
-	rcu_read_unlock();
-	return existing ? true : false;
-}
-
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
@@ -3251,9 +3227,7 @@ void exit_mmap(struct mm_struct *mm)
  */
 int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	struct vm_area_struct *prev;
-
-	if (range_has_overlap(mm, vma->vm_start, vma->vm_end, &prev))
+	if (find_vma_intersection(mm, vma->vm_start, vma->vm_end))
 		return -ENOMEM;
=20
 	if ((vma->vm_flags & VM_ACCOUNT) &&
--=20
2.35.1
