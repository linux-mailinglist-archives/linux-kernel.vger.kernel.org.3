Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1773A4A6A2A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244629AbiBBCou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:44:50 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:33722 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244185AbiBBCm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:58 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120Gv7Y026579;
        Wed, 2 Feb 2022 02:42:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=OUZsrnLeC+MA10co9wH7Xuo0qBt9iIF3VeVIf3DdGng=;
 b=WLj8FKJ/jJ5HNR/ZSAKBcE9gX5ohEbEwOtCMYQaRmpgFByqvArULiSuyuGzjHI7IpUHr
 zhwrwJVGft9SkyoXhPkKW6OxskoxLYC7HT96DcDsDdbyfcYmuFJ6I66wQzHZYb+oX106
 GhFuGGu/XogsHjoia6ZAgFPbhFoWu3e6gurgNBoErX+Nv7cbfDro7kC02N25zFxRS/7Q
 wilvEASefTzLkx0ME9cbrGeXExl+ERm12U1CGWTV3ME/y5CwTsoQhkswGTlPFdIQHXOo
 NopH6n12a/9rl/sNA064gE1tgpByW5WhBIOVtMAosL/tkfxleiwvInV6eeda+zCSUQVG +w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9vcu1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122Zweb015318;
        Wed, 2 Feb 2022 02:42:48 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by aserp3030.oracle.com with ESMTP id 3dvumggu7d-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTE13stkPRH8wfcsG86VbIy71O4yS4bes15178/FduTDPYxOBQYWabgUrrMAgVWeflUJzBfXGaE0lodqirs4rndtEWcdShB/D8ZbmXEUgq1D2/i8CG83SacbPKO8JUGxfMhnJDYmUw+rbvXfymuoOSMc6IkWBCgBixsG8RiH61KR+XwPcZLkT4lpbMBnCgSyh0x3ysCDjovN7dfE+ZsJthK5aQeBY4iaqSATc+Hy5AQyUw3yZOt7xAYcFEzT6Kh8tdEaQMfavXfJYO+CX5iJeR2IJgLi2Mystar0YtR2bUHVhB0MeMWiJtQkSibuHjHNPT7Pg6R709U5KA80FLLKiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUZsrnLeC+MA10co9wH7Xuo0qBt9iIF3VeVIf3DdGng=;
 b=Rehcm2qS8+aAuubay37d0u+1C08ECnKjNym6l3CiOWLKaVHTM7abwklM/ociMlGflUVPfwTA7SOIrXdBdNqyWPcUet8BjBJlmHeigu/I3zGt8PWPTmuWtQw72aVeb/S5onxgNE4pzAN5JT1IaQ2hP4dfGxumExHlMEpT97WEDK5agrs+p08lSb+sO9dJi0Y0ybXqAWL0Ms++5A5tVrmo0wtsR08Z/jeFeh0thOxXHLV9urWW8LV+lSX6Wh06/XsbAIj5YM8N+RLdPQopSZIWHmHvIVilKKLhMDk2uOSiEsHzbPT0Xopg+zJ90Gezb1B76NArR3tEhOmySLMo2/vSBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUZsrnLeC+MA10co9wH7Xuo0qBt9iIF3VeVIf3DdGng=;
 b=LtXuCu4sWibpWaI/HeepZScXGfDDOESQbpV+y9L9rXdBYUaIERhclgFmVRPFzdJVShSar5PUohYT9hsNZG3kmcwP+f1bbIvrhh5bvFq/gmepYOw0w+Y17g4Go5ko5iE3lQhm/ct0RsuaxrK4QVf1USCDiCSdo4r4mxrMOD/NbUE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 02:42:46 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:46 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 34/70] s390: Remove vma linked list walks
Thread-Topic: [PATCH v5 34/70] s390: Remove vma linked list walks
Thread-Index: AQHYF957cF3gzUsOaU+Z3vuT21MsqA==
Date:   Wed, 2 Feb 2022 02:42:12 +0000
Message-ID: <20220202024137.2516438-35-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 298455bc-0233-4ad5-6182-08d9e5f5b1b4
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_
x-microsoft-antispam-prvs: <BY5PR10MB4129F7EF70AC0ADA05A828F4FD279@BY5PR10MB4129.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R8zg0jaogcJ6YO9DihUxRlGkTTWJliJq/XQnyXtHhqp4ubJfvGJvxNtq8YGO3kxZU1o3lDQN5ZnbzfirtYnJxWNXFWVnnVfq2+rgjL1FNlYysRRapsQ3ByvOkisaI1b5uhBFXATUCZhWgHxaliGHVrm/Fl9KO4r7RmN6H9uNuwC+RcruSljNmq76uEd2O6eVlJoIFOXep9N1NzIm1KPoPFgoAr4+f8kbbel/0q2XFhg8rDkrdaZCapPEG8MyoqLaKNJ+mYjwcDk3eSupi6t9KmT8nAvR2pDCzo9DxJjttvMSA5p1PLk+f1thbY4obv+VPUQ8Q/C8si6tl+vwC4sVQw34p4rrr2jNLsNpUzZyt+kvL5lK789ZnyyMHQSEJjq/5DJQliv4qqntbgit2McU44HaNL01dXpKDl8u42qbmi59KwmI7CVM2GqBdU063VsoYnkK5zt9qk/mB/Xg84sjTrhs8KZapauTJc/xK2d1Shag4GyHbYIE9a6/YHRbxACMih3QFMddjWrl7hgMeS+YFBo3ZP8O0nzxGN8Q/O074v8H3P1LOeOUOgCBtSovMWw4IKz4x+/2LQtacB8qrKFeL3e723e4p5zPI2fQ8oY05JoQ8DLhjVrziw/GA0Ht/29eHz58ddaIysc39zXNOt8oLIwjhtIDVT6q5OKWnpjbDwVZjzikK4JETw3PBviewxKeEvtRJ0j7mSejI/2/MUNohg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(2906002)(8676002)(66446008)(64756008)(66476007)(66556008)(76116006)(2616005)(66946007)(5660300002)(91956017)(44832011)(6512007)(86362001)(71200400001)(6506007)(6666004)(508600001)(6486002)(83380400001)(38070700005)(122000001)(38100700002)(186003)(110136005)(316002)(26005)(36756003)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DMd+fsIPuuUx7ZTqqj8/juTaVC+RQPJJB9i3/DIsokX6mrwfUJD87ZPXD8?=
 =?iso-8859-1?Q?CQKm1bDUbE38TnRyeeA1k+qm3ApvJYoHb+jU1hc6vqZ1m+Y5aodCS50XFp?=
 =?iso-8859-1?Q?qZ0UyVge6+xbN1hvVQK5YlLemdR/hiUvToSFHiv1Ol7zj/5aYmjCK2Y3Jk?=
 =?iso-8859-1?Q?QF34PGJCwhkXeuoZ994KYj/vB6dUUrGNBdCFuZOPlsQByO7z/XTbiYYwnl?=
 =?iso-8859-1?Q?W+AATCxccOwb6MaUnTnfSJHY3Quwa6TZExJg7KVDTlc0uF8HQmSJZMyzUi?=
 =?iso-8859-1?Q?8zjERBg/INFdP/Y77l/b+yeq/Disb+MRKLzyrMGvPPepvVYapZEzOYqray?=
 =?iso-8859-1?Q?gdRb+Iu3ZE7CE75Shk5i8zGsGxp/LbA9FpXal6cmgYd9MTypxLdfVmHbgm?=
 =?iso-8859-1?Q?4K1T/WHmBHmk5ZKUnpJSo6PcAambKFoSoKf/vRWLW+MO0PL9Y7MXLcfWbe?=
 =?iso-8859-1?Q?vD5G5mLpaBOkm7XM6CZwmtU1uaLOiFtjCvbJa8HmVczKcsc4GlD+3SdFRz?=
 =?iso-8859-1?Q?mJZX+NqDS+UZa4SYJBpv6o/Ezg/ZfkIZOEQmSTkBugCI2NKXJd9Ngs0sGk?=
 =?iso-8859-1?Q?qoELmzbICbIaaJVDh/VpswCf1VzKt+Wi+SdpHT/3ghQ2H/aRS3bJiq3UtR?=
 =?iso-8859-1?Q?VSOlKeGRGuzOaA9VaFJROhSyeI0v+9oflXe8apcdEeYANE21fxJTJ/3VEx?=
 =?iso-8859-1?Q?LD0PdGsIT8r77L6PDN8YvXUF8bGEgnUCDZ33+2RVPwb2OIU9yImchL7eTG?=
 =?iso-8859-1?Q?BkFem468ic2wWPzPx4zrY2y/WnYiE9FdTzZVO5RrCFiQy1HPt6tKELTkMl?=
 =?iso-8859-1?Q?xKyIpQI6u6reinAo/yKPIiEz/2D+Jbb1aa1VuwnqHattpwqhdOtwsMJNFN?=
 =?iso-8859-1?Q?b3Klcml2ABdYIhNWkJ65FblzgQqF4OirdfJxAfW+BDpKUJiEKIGEy4HxqR?=
 =?iso-8859-1?Q?1p7XB8btaW+SG73Zw3jX4Ne8L7b1xuJMHHHtd+L642UY8EJ2+X1RpSfnzn?=
 =?iso-8859-1?Q?rGYjkvW8IyFbNQTTa7DjvCTHKojSxXPYDyVy/UHt4dLQ9VJvi5z14o0dCi?=
 =?iso-8859-1?Q?NOrEjMy3nNElJdVn/xQrR56DDVvFUukxXo1cnOn0GnH7DyJkgsw+KzHIAp?=
 =?iso-8859-1?Q?PLKcL71pE8sSYZnWNZ54oF2f2PgbCkF6abAiM0KpoyC5njKLoHeIdNLhKP?=
 =?iso-8859-1?Q?WCHIfZzPUDJK7KJLiMo2ex7ickZuyrzMwZvIsdC55ktC+5j+JLLIV7PpZx?=
 =?iso-8859-1?Q?DVOO2Zc4trq9K+4s2LJJt7mxPWxLiVDw82/T1HRll5R9LeckX1ZScjExnX?=
 =?iso-8859-1?Q?mgSPeog77CX4d8cbA/CAUbmRdSEMDvxDRPbCvdD5DwYN7WAs2Zqrng3wxr?=
 =?iso-8859-1?Q?+mO+vs9Kxh2SEgMqzsFm5udBEOOxrZs7snc8xqmZ4Xi7loTcj12TbXEmeT?=
 =?iso-8859-1?Q?IgXPk/SucuAYUjHO7JTvL13MqqkKWPKmP0qMRc1hHVGD7Y5Vvkjd2I4N5s?=
 =?iso-8859-1?Q?6zkzT3P0gFh9C/4gCqf40va1GJFato1uLKKPLO8JczngjpEjdQC8/+K6H3?=
 =?iso-8859-1?Q?qMW/KFFH09ZAzEPGXRVXnyg/Z+ygYJsEb4bZTJ8l0WqyRv95al5AVgrFO3?=
 =?iso-8859-1?Q?H5Q9zggOyFVg6slQ0sN08Y+CCoEw25J2f4z/Lk1fH5YbqdwTFOjwQpkI7J?=
 =?iso-8859-1?Q?0eEL/Fw+8Gx3/mc7t0I=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 298455bc-0233-4ad5-6182-08d9e5f5b1b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:12.8920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m4D803lNJtsgvu1afH0QQ9yvGIOWNP2jXytnpA4itVlx1Y5RfFv9QKXcVdQ6fGvxAUjD16tzv4nIIfC9HZ1HGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4129
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-ORIG-GUID: wP3AXER9VDGAgsqTpJRq2V4N4TvSxRfh
X-Proofpoint-GUID: wP3AXER9VDGAgsqTpJRq2V4N4TvSxRfh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 arch/s390/kernel/vdso.c | 3 ++-
 arch/s390/mm/gmap.c     | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 99694260cac9..66f7e7c63632 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -68,10 +68,11 @@ static struct page *find_timens_vvar_page(struct vm_are=
a_struct *vma)
 int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (!vma_is_special_mapping(vma, &vvar_mapping))
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index dfee0ebb2fac..20ae7f8f1c01 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2508,8 +2508,9 @@ static const struct mm_walk_ops thp_split_walk_ops =
=3D {
 static inline void thp_split_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma !=3D NULL; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		vma->vm_flags &=3D ~VM_HUGEPAGE;
 		vma->vm_flags |=3D VM_NOHUGEPAGE;
 		walk_page_vma(vma, &thp_split_walk_ops, NULL);
@@ -2577,8 +2578,9 @@ int gmap_mark_unmergeable(void)
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma;
 	int ret;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		ret =3D ksm_madvise(vma, vma->vm_start, vma->vm_end,
 				  MADV_UNMERGEABLE, &vma->vm_flags);
 		if (ret)
--=20
2.34.1
