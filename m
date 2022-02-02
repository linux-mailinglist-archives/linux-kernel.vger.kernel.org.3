Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C161C4A6A34
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244352AbiBBCpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:45:25 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:34630 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244165AbiBBCm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:42:56 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120HCjT011409;
        Wed, 2 Feb 2022 02:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+4nU7Ofk1jrXrP4pqOdfm0N2E62lly6HrFJ1/GN1vsQ=;
 b=Ogzg6/1X0A0Ks4ajFWYj7/sJWdcCqlme0EeN0XiMglueSlPW5RYyK7gKs2BvJB49xdLr
 w2T9g7a9i/lQUj54Zrgt7zAr6zUKKVoKARtJh4FqWq1CmRbNpl0uEkJWV9boTUD0JW4F
 Vqw4Ql9lyjWKBprg/6ERweQMoWmZin6Iv2GIrbawXjgHOysPfVTVEAQIff4VSPkw4+SH
 59svWOvKKrPm6C5YL1wwi1f2DiOyyTQ6jYW0q6L6jQko4pfNiPOLZcbOmxWWOVcnKqCQ
 axcCr74NHk/263W+T1ayH0ArdjOx1BPRTH9XhbOlFM6JPGFI0Uhre8IWk3xDZSq+1EQl PA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9fvsee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122Zwef015318;
        Wed, 2 Feb 2022 02:42:50 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by aserp3030.oracle.com with ESMTP id 3dvumggu7d-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzwDcwbHa96PAMjFHOS5/d8cd/TWCY9EoBySgXarmeKYnHkaCKvirIA1usyUVtSayDVjANLtAbETr76hyY9ecLvjbIo8OfJ9rcwgkIC7tYvlYxeY12BL5yudb/Ix4rENtKx3QagdUEU6+jUSgHMG3oV5ZwVNapCI8rR8QmRwfzZhKIz0gMovyMuiYZMLORfevr80qWsEPf+k7KT7MMFflgfo3e81tYpvmK/mEy/7xhTH0seDE7hJnKSQS+ia5ivVsGuF14vtBjIY/KcmfBTZQhhIpNsTcRheWgSoTt8bRFoAfX1cuzfkDLiWRKH4SvMpOQYJxxVu+MKcbhUel+H4dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4nU7Ofk1jrXrP4pqOdfm0N2E62lly6HrFJ1/GN1vsQ=;
 b=eRwqKQmqRe+Rj+Zyr12oZDxmaqSdVrnVoVQgN8LP133CU9A4bBNsEYJ0QddlDdFQYP65IE202AShxj33w4+spQ/JsRGyRHRPaOL8d9KcYMfn1XqiIB4gkohsc+82+HWkUHoiBDLj8zPqWb7ZV30Z2HPVmQuYby8yptvgQf0uiADRdjZPlujH6353ri+SoRYfyLpbQn4RJYSOnHxuLkSmIndiyT//ssRLDPXMWfR6D8qZHccIvFPiK2HqPiCXaS1yoPEN3WnS0EqDnU7Wdh6/7H/DO1Dg6vDGXbQVBZrkXic4aWqjpguxiVpHdvX7zuGZnFqBwUVDdk8y8TQ1wfSgDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4nU7Ofk1jrXrP4pqOdfm0N2E62lly6HrFJ1/GN1vsQ=;
 b=lnsrrbxjI9bxv/bWtNXGV9HLrmIaNY0hGqVFkzUZY6xSSvABMqe8U+KnsmIDFRfmgFmnWB9s7UZF1heafOe9UvKToYFZAq4exZjkFKTp74df8qGXnko7Tq9S0PWEO6JhJJrFKGE74z+Pp7OMuzZ4ZGg1T+rfP1sYO76RR+cvIOk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 02:42:48 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:48 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 38/70] optee: Remove vma linked list walk
Thread-Topic: [PATCH v5 38/70] optee: Remove vma linked list walk
Thread-Index: AQHYF958c2jsoacebU2eJj+2FwwhPw==
Date:   Wed, 2 Feb 2022 02:42:14 +0000
Message-ID: <20220202024137.2516438-39-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc853fe6-7dac-40d0-6253-08d9e5f5b2de
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_
x-microsoft-antispam-prvs: <BY5PR10MB41292AC1BD11C856DE589DC4FD279@BY5PR10MB4129.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uoYKHMh46szKYNwVkenjXzNf5LWH60mNCF7DGi3bJ7pi+8TmlZZ6My+tA6ynJ++6vkzWRCAh3mcmYmFuVxA5GlhUCRhtBX+H4qUunvDduTGxpaOl6seibbqoeR0QlQNiX/kwhwhIs1k5fWp115Kwjomd2t25x/vgpJKQGBIJjDPilyZ8naSvNQxo5lLtVzYui57fwLjfYFi5j8jboPwUu2S3nVuqiFtdFgdCMrR7VwVAuLK4x97n4if/yT9D/fQmLyVcvWg5f3g8Xurj1uk6zd/8ahaXtG5tAEY3mRbvWjv/ajqVjuZFOUHvIpfAWffYORFqC1ugNmDW0GIXXfkloHdyGU8jy+dN3KtA7pkCRZgnv7bRFzuG7xFzOpJZlv3TLf9yAhLYLoFrLtahNzqJRmDX2yElxT2HPDmZQu49n89eP2icbNtOhkiM8nB5fjHEgaCm0l8V9RHukefnmcKrUqZKceMQPAYrziLfjN3eRt557m146g+HGQLKJkckP8VXZ7bJIu3wQJWg8VL/Mm8X60dT0ufKUPVWwPSjpJxQZspyQbAKLdmASiJntf7d7zRAzKP6DSxsRaRKPAapVYtlGrClLzdMKbZYpCWlExqrV4KwR4WNWYPMsOnyowGnVS+u5iFhZaFhirFI/9hui4FBwbaFjPeT6FQEBkW2mJrjDfSu04yDEOuvBK76qiziZ6Y58T5zlw6jiNsnRg8bVNnDuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(2906002)(8676002)(66446008)(64756008)(66476007)(66556008)(76116006)(2616005)(66946007)(5660300002)(91956017)(44832011)(6512007)(86362001)(71200400001)(6506007)(6666004)(508600001)(6486002)(83380400001)(38070700005)(122000001)(38100700002)(186003)(110136005)(316002)(26005)(36756003)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1HZgCpimLd3cUS9XSbzeKK/Vqh/DGFQGXhzrprgEyc3jYmRMqcBMKqpyTG?=
 =?iso-8859-1?Q?wAbiWddi6yO2Y8frtvspHGCZjBrSscjTn7eH9LwlHcgBoBogoB3yPWaE0k?=
 =?iso-8859-1?Q?fwtivIQvgVt1ZzoKuIf97gkp4+CcGvJ+gf0QuxExr0DwbbpjaUvf6eZP9P?=
 =?iso-8859-1?Q?OdwrrzDp64tWrkEzljQjwTFA4gAWeHceDafSU+ylqnymhQUepOOnXYvPcX?=
 =?iso-8859-1?Q?kqkNfzaKdusdYq+1L9ZySldW5bm80o+OpHTEirUxT/QSAJQcSNkfv3ezg4?=
 =?iso-8859-1?Q?uuTBvoSNA5sPTeBu48Bi3j09DjNxMmKa7lHHXoA7/Ju+E8Q1PbrnQNHKud?=
 =?iso-8859-1?Q?ODSRtF16p8A0hQTOchQJXVLYwCctqLY6gLHmNAFEU7NJQQZxMBMmJtGz4+?=
 =?iso-8859-1?Q?h4V+Myl+e1OTAKPzDohZBsPLorOmhXKFR1lplP4yhP5mGyawpaBDLcvSWt?=
 =?iso-8859-1?Q?IR6GqZnJ29CpUjznh79b4H737/bkZ+Mh4oBY4IM4mbh3LZsMRlLz7KdFfn?=
 =?iso-8859-1?Q?fp4r5HW7M3y8ExzcRSZueg4vX46SJOq68lXUQawktWz8ZgzqjcU3l2vRXo?=
 =?iso-8859-1?Q?/ZCmSGYPp/KGeqRZIIggwxFCBGLYzXDT2xp/67N6LCIqY0rlrYIw86YtbP?=
 =?iso-8859-1?Q?5yiBvxIRA+TmrjM0Ouk1dCzSMQARfJi9A+EykGpBY72PlDj06ZELJku/S5?=
 =?iso-8859-1?Q?K+zkIXv1bHaGT8/Xl8vY7isTxfeWGC4puLZKSKSKvpQCI6BTldP1UnpGBj?=
 =?iso-8859-1?Q?XlGbwRHR3pZZphyhQ7DYceXrgnd/gPwmZufodAW/k2A6mErnwRbxUjliv6?=
 =?iso-8859-1?Q?HZmD2A6kiQwMZzsR1RJB3G9q4NgaeQC4f2MQYvCBcZV94gt/nUnAZOK8Sd?=
 =?iso-8859-1?Q?ps8TZ1AnfY2E65tOPdJgMf7kaLH6kJ6EX4jQjFCjN69Kw286M/jVI5s0kI?=
 =?iso-8859-1?Q?6I0vn2xSCQdbpx8z0S7hFc6gP8tzIVQOiAiaQhAxiYcOOufYAsUICG1Xpj?=
 =?iso-8859-1?Q?hSFR9/bPAU/j7Qmr5GYiGH99wg0t+riGqBPY7UrSgbtRj63rGgj9fNDr4/?=
 =?iso-8859-1?Q?X76mVkDOfXM9R0/rUwB9WL8qm2AVhWIVie5cTtQTXIZchsGKmj6o2ikQLZ?=
 =?iso-8859-1?Q?z36qMa5zQo2uXU3VP9Vkxp3gzudtqv2b57Exa86M75F/DwFuf8j7ywzya/?=
 =?iso-8859-1?Q?b+uqSBF+E9syt3YMBTbXbxYjmTRfMRSILfdIran72NOsAKELBLd1QHlqlF?=
 =?iso-8859-1?Q?x6kVoSGvoGPU3Y8Ttkba6KYvYjioMOlXACGvPydN+YJ5LAHxoWZYvjyftO?=
 =?iso-8859-1?Q?BkXqDsoCdHkQAq080TkbtkDm/nc4pjbJ7Hjs3rn0CbeZmqlJliQjBjrT7A?=
 =?iso-8859-1?Q?cHK7KcM2SCuVOR4K0JL706oHCGaVXLjkYHVWYWxPccn07c+qt9wpDDWHHT?=
 =?iso-8859-1?Q?GW9amY59Xuc4Dl4fVhIrsgbz0hnlx0v/dig686wxsWho4Ojazx4hiIuPXz?=
 =?iso-8859-1?Q?VUaCw1SvxCAmfRSU4sP7YznvpytsybT5VoSWldgmdubv/OAHm2Vd1HON9s?=
 =?iso-8859-1?Q?8OWCQ4aMynfSdc1opnZIBft4668MXFLgG3+QlSdGehM0P0kJ6y0ny9z6+o?=
 =?iso-8859-1?Q?rbp7CoBh4kgv0xaGJGEJOdP11xfX935ocWkZbAve5wGXigW/w6gRG9AqBy?=
 =?iso-8859-1?Q?6EpZRTZr2SBNyAv5R4Y=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc853fe6-7dac-40d0-6253-08d9e5f5b2de
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:14.3450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M6m4FrDVgPGKe0XjvGm6E0kf71CtUyw9t8oxNSQ6IROJvPFTOwNpMfPLsZjDtrHx1OSmwgX7+KTi45NvNrKFew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4129
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-GUID: rHi56rsiBMBfzG4leL-YUX17cg_H6gye
X-Proofpoint-ORIG-GUID: rHi56rsiBMBfzG4leL-YUX17cg_H6gye
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the VMA iterator instead.  Change the calling convention of
__check_mem_type() to pass in the mm instead of the first vma in the
range.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 drivers/tee/optee/call.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index b25cc1fac945..177575c445de 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -342,15 +342,18 @@ static bool is_normal_memory(pgprot_t p)
 #endif
 }
=20
-static int __check_mem_type(struct vm_area_struct *vma, unsigned long end)
+static int __check_mem_type(struct mm_struct *mm, unsigned long start,
+				unsigned long end)
 {
-	while (vma && is_normal_memory(vma->vm_page_prot)) {
-		if (vma->vm_end >=3D end)
-			return 0;
-		vma =3D vma->vm_next;
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, start);
+
+	for_each_vma_range(vmi, vma, end) {
+		if (!is_normal_memory(vma->vm_page_prot))
+			return -EINVAL;
 	}
=20
-	return -EINVAL;
+	return 0;
 }
=20
 int optee_check_mem_type(unsigned long start, size_t num_pages)
@@ -366,8 +369,7 @@ int optee_check_mem_type(unsigned long start, size_t nu=
m_pages)
 		return 0;
=20
 	mmap_read_lock(mm);
-	rc =3D __check_mem_type(find_vma(mm, start),
-			      start + num_pages * PAGE_SIZE);
+	rc =3D __check_mem_type(mm, start, start + num_pages * PAGE_SIZE);
 	mmap_read_unlock(mm);
=20
 	return rc;
--=20
2.34.1
