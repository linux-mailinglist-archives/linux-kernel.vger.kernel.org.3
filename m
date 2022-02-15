Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340DB4B6F1A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238904AbiBOOnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:43:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238889AbiBOOne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:43:34 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184F2103367
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:43:18 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FDBvXF007505;
        Tue, 15 Feb 2022 14:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=YKtqpJ0W/It1fwc35xWyObhYDey56NECnvep3UgU8CU=;
 b=souQhj6mX71MMkB0HMNEJB6Lzcw80+yShc3Z+FGMpHahAtgxKxi6Of5dSJPaqmmSQ7Xb
 YTiWKrYL0oJnlw7hoI2QnT1z+lcc6GnH+ZCQwXH7OX6aNy4hWiX30QRPax9y9B/2Tx5j
 jHTVxT9hKBz8R3DPjA347waPe4RhFNyn68qz9OfByWDOSBpKylkRc94dBeP6e4c7jjyS
 SEljSNEER7w/nF/lkmJoLsEcmT56sGmSjBu5xff7aYxCqeMnn2vwCEGQowLwHAVo+6Fe
 /pv2hm1bnEOevNmY12gfBJoGGkNicKYRhMgck0dpz5J4oeTM0RGuZehCHsIaenrZTtho cg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e884r97e7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeVaR085748;
        Tue, 15 Feb 2022 14:43:12 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by userp3020.oracle.com with ESMTP id 3e66bnpja7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j59b9q/a/oHIOdhv9IehqY/etJqd3MxFts9/KwyHulNF0Q8mU83HxlKi5EjSmsORDjzL9zKtrNqK0IIgyGgMbaVx0YhBJNVwksBPn1RNpPDLI5EwzZzU3c68zgd+UTKIwXd7i1d0aFG+sAVWJBIDewKFOfqHSNHYjZxti4wXe7N0VmdI7+oY4cXE5uWkgu80/DblpClrzE3NScU6dsJeL1ZWr5P+LR3FHKRRl0CW9/OvLVwNfE2geF72sdpcRU5Xjiul8f7Y/PHxSdtcud4r++WzgiSxaLfnbOlP5Smhy0IyJOdmtrTfWr0BaaR6agGys8voAkJmyEh+geQ9ukmR9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKtqpJ0W/It1fwc35xWyObhYDey56NECnvep3UgU8CU=;
 b=BZfbU93w2NltVkCwXvhyL/vecGy+KaRxNb/YJeSB+0hUxnH7JZxWEM+uk1JPeR/3zx7SGrui7xSzpYqf9oB4qK1E8zzQiTYWjQdTmr/B492M89OilOQVnbMxaiNHokbHS6CntJkqP18U7dKYKmiYTYasFocauIkiw3HAwHtoM/6YPET3I44nK95XJeuhuXGm+hUMeCWM4C/ELw1nYS3oTOfpDkAmZsQcyHY9eo3pbciCFIuCpX/4pXADZNZrJD/XmGdouy2Ek5M6jgY/7+N1QZX7TFudYGbw2+AZXweQnnTAgGO13bnBEUVPBXIKjqFYkwPn6NLezZN0y7x46vVkFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKtqpJ0W/It1fwc35xWyObhYDey56NECnvep3UgU8CU=;
 b=bB0BI3NGkX7NN5edqz8OkWCObYIP71yNGqM+13f7pNa1EkhW3JuTwjFpTjbO6AAvUOSPeslcyQsgWc/MjRbOetkSqEFSUyrDkjNhj8y6weMFTVsv8NlVo6toq6H4wXhtaznQNt7ulplL9rYSU7JzWJbWC9zM3HzZSHAd3IUWpk8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR1001MB2197.namprd10.prod.outlook.com (2603:10b6:910:48::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 14:43:07 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:07 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 11/71] mm: Add VMA iterator
Thread-Topic: [PATCH v6 11/71] mm: Add VMA iterator
Thread-Index: AQHYInpX4E2+2y4Cnkm1gGIt+et0gg==
Date:   Tue, 15 Feb 2022 14:43:05 +0000
Message-ID: <20220215144241.3812052-11-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db13fb20-486b-40b7-2864-08d9f0917ada
x-ms-traffictypediagnostic: CY4PR1001MB2197:EE_
x-microsoft-antispam-prvs: <CY4PR1001MB21973BF83840A81157D8560BFD349@CY4PR1001MB2197.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZNLK/i7IxcaPS65gcwBhSSTISDClEDUNCh6hi0ER0pOAzbxwjHMc5ZtU00wNp8Dxw8vdVJasONHjEHI8r79SslTD6OOhI3CmJpQTwLSnvkvHomEvW+OsEO8fTIysIaE5j/+6xy9l30fBU9JWiYvnmM/uGrp7hEjGRc98ILNCDAyeHI9oqdeEx5uVxFfsZB2ycuIs7EXQadgmpAHzmbYuDc3IDMx93iAyNge1d+J6GiIlvo3ApedmwNPX9I0Z+B5Kq0X+RjVzMc6pNQDf/vZMBS8Snicl+C8HzorYQXi4C7MVu17smU2+z0azdM9HAqGHKjAIFzQDF/JgPAy91a4M5HVkGgoUSuFS99z3QJcxei1300MN7KiQPT7WsliJ8AHL3miZWuWAGDejH20WFgRGbqryPPkKIJIbPdM73NcXej6Frhhk7/uk2D74vKTpgVSVWAZhCgHVeMAAdRefk+flqkOGMewIwTU6t2k0ml0bJMZL4wCURIBKwPrgJf4tgvcLxKCyWec8109llt/JbnTr7f7yZBH3UGnI2CHm0NkfcB2lfUsAES2VU4lilMQL6yfv/bIRGlxVWwnM1+4uHsmM/v3X2Jdn1sfeXreXcKKGMxeiRUWkS0wKrX7PGEBJxaor9hOv9b+yYFnfzAe3Ue7RICkBVc4KFkAq1b53bEhnmnvv61jK9yk0HlAgDqbb/P83jJvTZFn5DHLOdvOnoBy6cw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(186003)(66946007)(91956017)(6506007)(1076003)(508600001)(36756003)(64756008)(66446008)(8676002)(66476007)(2616005)(76116006)(110136005)(66556008)(6486002)(5660300002)(6512007)(2906002)(86362001)(83380400001)(26005)(38070700005)(71200400001)(38100700002)(122000001)(8936002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9rOSBVCvOPUd5KLJh9jPBPNwM4jH0VqaUUnZpzLAqa/yo9z9ptLhnlNBMA?=
 =?iso-8859-1?Q?ppmV2H2UTCN0V/SyEpjydhdS1aGbBL2vh9kDJc9pbC7+FHjQk9xPRf/7Kp?=
 =?iso-8859-1?Q?8K5tmh1cedlL8j/Z1dAlpLPFWbe8x5NGelUE3oJSXp3gnK0speXgRTWn3j?=
 =?iso-8859-1?Q?2RyB9Dz1jUBeDuS2zL4xFhoY69+yA/z5oeVdUeSBEqlTC0A0WU6CuAE3bT?=
 =?iso-8859-1?Q?q8b2wIDB2AZSWaQmYVgZJ18NFUYrpQtqsmhzhM/s/DiNOivvAG3FAw8sPs?=
 =?iso-8859-1?Q?7iws95GIOssRwn1W6UEOrzPrWU6jOgWlAeCrVRVmmtDu7/3XGg288ZYWz2?=
 =?iso-8859-1?Q?1OYiy3i8CsZlMO9G+wEnnQs34tFMg2LF6Wxm7HQq+IzS0R9SooweXbVi9V?=
 =?iso-8859-1?Q?mtX/4IbDXiFMiRqRxaGyGUZ1wghkSq8uI4VYcRGDi7XWUaIaNRdbDFp+qu?=
 =?iso-8859-1?Q?QSkHH6L7HPW7qO5XeeZpPQob/Rk7ljRqNQ6TrE8Hhhj/JGZ/oFwfmwjbih?=
 =?iso-8859-1?Q?WRWgL7lLurBEHo6dnpRhJ8F/pkX2MgUdlOzDrOS+A2wMevQ9mVkxdHIIrY?=
 =?iso-8859-1?Q?Qf7fMBPjoLWjz/njHpFfagkBf01fEWHyYlJVRjOhZkVYNBWn2tF/pytZ+6?=
 =?iso-8859-1?Q?XpoTUOr3ICXd73c9sHdnXxYoBeNPZMVpUlP0+2/ffhJ+jrY+6lwVSKsRIB?=
 =?iso-8859-1?Q?Xutq/NESzZssnp0FzKNxbDZWalbK9UVhCCjH089Bi9P92kRvRQZNckEB8r?=
 =?iso-8859-1?Q?TE3z0AoRn+zp4mSzHuPO4NEnfXTthyf5pnza0ebtkUazyNRQuyijOd8M73?=
 =?iso-8859-1?Q?SDdTUfKq0aYUYCQRKCZGs/DerjtkZqRj2eS64f4SAgiAhZUE+ilPkygHSF?=
 =?iso-8859-1?Q?EvJFra8ZWWHKrB09zWNjzpd2nAYeRsIj6XxUIkp0J15Nl4bDZFx34c3yWg?=
 =?iso-8859-1?Q?mfcR+mpu7EC1thx8ov8Ht1QPALYhphkdu5jeXlf09qPDsfprtUUlp0bpP5?=
 =?iso-8859-1?Q?MA1cgiLnZBz7+zSzNpya88x8e2v8jXtDWhdIbfnbxOJEkDgEUBnrxtpvKf?=
 =?iso-8859-1?Q?XDoWonyf93PnUSup9qPA1qcI73ktZLDdPaiX6rrBbpCYXYUB2OOEWq9gjo?=
 =?iso-8859-1?Q?mElt7rtnF7ffXgXab6EF1BnxulK6QUukMzL/NE/1VpfN1b035AiENrTto6?=
 =?iso-8859-1?Q?xgld3dEZ/qiDBLq3vvTvYcCn+GNFUpl17qAq8QwVh2KR/jWxS4H3EOetDI?=
 =?iso-8859-1?Q?WdwqhhNSr0vmujuxDLUoVS2OLeNr/x6lmUa1nYwSPVrVu0QPMUoVEpiW7K?=
 =?iso-8859-1?Q?OH6wsXMJnWGVhjaKJGB+9EWSCmMCKB8ktHq+megE9PDvnc1EgSbenn10Zc?=
 =?iso-8859-1?Q?wHs16SC2VOBkr43+/5KR12r17czB3x+B8d0qwB7C2+R+xOH/hvpJ2+56px?=
 =?iso-8859-1?Q?RDeJW342etsc/W8Uq0Thqfx/Tifx6uGsCEYxQWW53hOjjIoNpXoKhO2D7w?=
 =?iso-8859-1?Q?5NUltmkCceTBA1v6ClBW2idgaxhr3k93Os3Zr7taM+t53vaQt4Y2UNdx0r?=
 =?iso-8859-1?Q?I0CAmgxWqyjE779BPxO5TGk9EMC5o3oVv3BQru9GzUcb9MgzrQaRu1fyOe?=
 =?iso-8859-1?Q?V8ypzS9uApXEBxLP3tg3+uT1gEOHUeL24FMmWkDHuvHk3jQolhJ+Wtm2v3?=
 =?iso-8859-1?Q?qD2SG4UyD5c8aSBbDic=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db13fb20-486b-40b7-2864-08d9f0917ada
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:05.8240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZkQWcks5aVKKfOn8oH28m4Q9HHAFyBrDj/bbZGtEvdbMKkJwj+mQ8mC9ZLv4yrw7eZhXFt4O7iyaDeffB0TeHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2197
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150085
X-Proofpoint-GUID: NTSAnPG2g8PQtNMwbjYPQR_RU8VmNWf0
X-Proofpoint-ORIG-GUID: NTSAnPG2g8PQtNMwbjYPQR_RU8VmNWf0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This thin layer of abstraction over the maple tree state is for
iterating over VMAs.  You can go forwards, go backwards or ask where
the iterator is.  Rename the existing vma_next() to __vma_next() --
it will be removed by the end of this series.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mm.h       | 31 +++++++++++++++++++++++++++++++
 include/linux/mm_types.h | 21 +++++++++++++++++++++
 mm/mmap.c                | 10 +++++-----
 3 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c71cf425048e..0353e9a902a8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -655,6 +655,37 @@ static inline bool vma_is_accessible(struct vm_area_st=
ruct *vma)
 	return vma->vm_flags & VM_ACCESS_FLAGS;
 }
=20
+static inline
+struct vm_area_struct *vma_find(struct vma_iterator *vmi, unsigned long ma=
x)
+{
+	return mas_find(&vmi->mas, max);
+}
+
+static inline struct vm_area_struct *vma_next(struct vma_iterator *vmi)
+{
+	/*
+	 * Uses vma_find() to get the first VMA when the iterator starts.
+	 * Calling mas_next() could skip the first entry.
+	 */
+	return vma_find(vmi, ULONG_MAX);
+}
+
+static inline struct vm_area_struct *vma_prev(struct vma_iterator *vmi)
+{
+	return mas_prev(&vmi->mas, 0);
+}
+
+static inline unsigned long vma_iter_addr(struct vma_iterator *vmi)
+{
+	return vmi->mas.index;
+}
+
+#define for_each_vma(vmi, vma)		while ((vma =3D vma_next(&vmi)) !=3D NULL)
+
+/* The MM code likes to work with exclusive end addresses */
+#define for_each_vma_range(vmi, vma, end)				\
+	while ((vma =3D vma_find(&vmi, end - 1)) !=3D NULL)
+
 #ifdef CONFIG_SHMEM
 /*
  * The vma_is_shmem is not inline because it is used only by slow
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 687cb463ff6e..3cd5f8d8e3e2 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -663,6 +663,27 @@ static inline cpumask_t *mm_cpumask(struct mm_struct *=
mm)
 	return (struct cpumask *)&mm->cpu_bitmap;
 }
=20
+struct vma_iterator {
+	struct ma_state mas;
+};
+
+#define VMA_ITERATOR(name, mm, addr) 					\
+	struct vma_iterator name =3D {					\
+		.mas =3D {						\
+			.tree =3D &mm->mm_mt,				\
+			.index =3D addr,					\
+			.node =3D MAS_START,				\
+		},							\
+	}
+
+static inline void vma_iter_init(struct vma_iterator *vmi,
+		struct mm_struct *mm, unsigned long addr)
+{
+	vmi->mas.tree =3D &mm->mm_mt;
+	vmi->mas.index =3D addr;
+	vmi->mas.node =3D MAS_START;
+}
+
 struct mmu_gather;
 extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm);
 extern void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct=
 *mm);
diff --git a/mm/mmap.c b/mm/mmap.c
index a9244296b73b..4623e69e2c4d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -627,7 +627,7 @@ static int find_vma_links(struct mm_struct *mm, unsigne=
d long addr,
 }
=20
 /*
- * vma_next() - Get the next VMA.
+ * __vma_next() - Get the next VMA.
  * @mm: The mm_struct.
  * @vma: The current vma.
  *
@@ -635,7 +635,7 @@ static int find_vma_links(struct mm_struct *mm, unsigne=
d long addr,
  *
  * Returns: The next VMA after @vma.
  */
-static inline struct vm_area_struct *vma_next(struct mm_struct *mm,
+static inline struct vm_area_struct *__vma_next(struct mm_struct *mm,
 					 struct vm_area_struct *vma)
 {
 	if (!vma)
@@ -1293,7 +1293,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 	if (vm_flags & VM_SPECIAL)
 		return NULL;
=20
-	next =3D vma_next(mm, prev);
+	next =3D __vma_next(mm, prev);
 	area =3D next;
 	if (area && area->vm_end =3D=3D end)		/* cases 6, 7, 8 */
 		next =3D next->vm_next;
@@ -2812,7 +2812,7 @@ static void unmap_region(struct mm_struct *mm,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
 		unsigned long start, unsigned long end)
 {
-	struct vm_area_struct *next =3D vma_next(mm, prev);
+	struct vm_area_struct *next =3D __vma_next(mm, prev);
 	struct mmu_gather tlb;
=20
 	lru_add_drain();
@@ -3025,7 +3025,7 @@ int __do_munmap(struct mm_struct *mm, unsigned long s=
tart, size_t len,
 		if (error)
 			return error;
 	}
-	vma =3D vma_next(mm, prev);
+	vma =3D __vma_next(mm, prev);
=20
 	if (unlikely(uf)) {
 		/*
--=20
2.34.1
