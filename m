Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638774F1731
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357562AbiDDOjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377747AbiDDOhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:37:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36ECE3F319
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:35:48 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234Dl5EZ006371;
        Mon, 4 Apr 2022 14:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Xj29k3YFZEsyqMRPxI8nQzQdPVb8h7PSGOThiszUc1c=;
 b=P2oSUyuiMFEopEdy4m8aCyDmQesOimkDmMXq3ZlyUyLZH0kpHiCaoR5RPCpyMK+Td2A4
 elxn+p0Y23K8PDq5u+xpvTQi6U2YoplLBdyFt2F5/0xxlH5LCX5qENM2R64dinNcTxsH
 SJ6ih4wLzRYuh1CWiIcQPpQiV54Ty3ysTQWTuWMdybG1CJMLKnR4wSgcnOT8eyAmzJH3
 RquHN08zCuyFAd6gX5rkpkqd6icdwtfpDfxigFHslo7uEoQRRBVQ10CKUF8JaY3Lextb
 CxObqGJRTaNe5FuGTviw+t08/klT38asflRCCVe2mCxiiexTbM51n3ZwLMYG0X/lxLgV +w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d31bf1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EZaYc034331;
        Mon, 4 Apr 2022 14:35:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx2mgyc-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TU0qcW2uL+Cw/XudaDhJ2fi9dL1eSHrpSnBE3YEhfGe3Za+sqHM1a6xSAhJYU6rdpzyw256EKGyib200QS0mhxGQPFFN+nTePyPmL5nM4tvSesFSLtVdsw4Ar56BYmzSiwmmZqs/yY28SbGA/kplJNle9eS/1x95NxTvOk3a+fpU/srfCqwwtzhq/VGpeiP34yWur8gH+KIae+fOPf2V1Acoew6Uym7WvKB7e43pErcr1zuhOZXKmH20Ext2DxLM/7FDvtG/3UFbRgpPPKqIYs+wk+X0iIitUlrpEXHSZzrFTGbPcxT50KrjHzPec2Nq0bJ1ahGMHNP8PEOZYQbcOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xj29k3YFZEsyqMRPxI8nQzQdPVb8h7PSGOThiszUc1c=;
 b=b7pihtKkRSPO29yXdzEdockVgEnz5sgoyK8BAMyQBTvRVbb1D249/76isELBTRsZGGZ7/GZVnH6tZeHBc4+dxBl0YbkKzed9+jPrMVBOpnaFZ/EDdkFO/unTnaQRsanOB9NmmjGdQcQ38HaFKm1UNbCvEcfdl0PoIVbotYvg1vr6CQ1Ib0rXlsj0yEAP0kCjamLdYpU61BTDH/ehS3mkhq1QADvuQR7tEnKMDraMFLXQ/v35Ght1ymj0VSpA4W2CXPCBIbf+uSrQaS/9qf0eOuvwGa3Dj0KH5q3shWb1IfxhHSz68cF9fRtGIYI242XzwMEPKOc4AQUuWKPK6ipMew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xj29k3YFZEsyqMRPxI8nQzQdPVb8h7PSGOThiszUc1c=;
 b=buTCMsqfGZjzLHf8TGpSZMYE7BjD4gBxseXxhRa9XxjMx+NQKCRtJCiTToi0NVp6lrYbvc/QrkWrEmrTVinawHe6iV7s+GH+fKAie7JwkN7obaQXlw7ljza9hNSmYaj6y7wi9UZMGQFLLhqQZH6vY3XpckawICN/LvB5mdJTlqE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB5812.namprd10.prod.outlook.com (2603:10b6:303:18e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Mon, 4 Apr
 2022 14:35:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:35:37 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 10/70] mm: Add VMA iterator
Thread-Topic: [PATCH v7 10/70] mm: Add VMA iterator
Thread-Index: AQHYSDE/wHKSqX9D6kuly1+r8pO25w==
Date:   Mon, 4 Apr 2022 14:35:36 +0000
Message-ID: <20220404143501.2016403-11-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c409acb-247c-4ac5-3037-08da164862e9
x-ms-traffictypediagnostic: MW4PR10MB5812:EE_
x-microsoft-antispam-prvs: <MW4PR10MB5812F0A28E76818CBA0CBB8DFDE59@MW4PR10MB5812.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TeHEJtsTUd/Rf8ffip6fZBTtRlcADcDfZEej7CLuqqN7eYM2IEj7mU0S85KroK/1KlRSLTbVknMcumvn+puNpMxh7FdDhdSmigzj0xpG6Px9s/XOt7WzT+26ip0BbD6nKLEhqADdn0OahBtwxx7x1kb9H+m/M0403hQ983M317wDxzGQSZzhFHb1Rrof2YSGX/X9loHaqSNS2TDI10uT1ZweWXJSH+SD0xQSvv5ZSGBw/eyRnAHiwL2AvEs0q+qyYZPpZE4bkl2kgG7iYBkyO/EjHEx6VflUB7Z0nwqLpDPzrpDGZnHCjKU0R5Wb8kaK33aEOwvdnyTnzMs6ZASe9xqzVxHg+YYcfgkwkF4OpK7yCSix5uieT+2ZyKmA6rsOGMWWfvoKNlMgfw9TONQaLy3jCUDzQVTQb3bh7TqPsqSJDr/sXsxYv0OkM0wanjmfTbdAbJmM+SGUzfYG4X51sMf50dLYQChqtdkzotxqIovAWYTCt5ioNqDRFu9CIAA3ItVTVofZa2fvrcjONPcra+2ulF8erGewMwKUW3ynFS2nOy+4sw5zH5N+MTZbqZZk7wnI+Ev9em/tZRvkY9JHLiQm1xHcGf1mgfP9+yeELNSHRb/JNdG44RNQgpMtqlXk8HQiXDwXuteqBS6K8N15A6b/K7i6cg/IsLdIsU8Gd49Gc2iN7r+yzcp9ZgnfPc2glBR3pcdk44dBc04jTjXqHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6486002)(8936002)(1076003)(44832011)(83380400001)(508600001)(5660300002)(6506007)(36756003)(71200400001)(2616005)(2906002)(186003)(91956017)(64756008)(66556008)(66476007)(66446008)(76116006)(66946007)(6512007)(38070700005)(86362001)(38100700002)(8676002)(316002)(122000001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BSE//38Ne5xp0EVjQwgPNm1tGCaSec0/svWgnWGseuGqrMD2hpFWNyCJPn?=
 =?iso-8859-1?Q?FqMDdOtZ9OQSm3oT+dgN2OfGDk4Ul2o1GMHEcXwRiH6xKJQKjNOiPm7amE?=
 =?iso-8859-1?Q?ZhLVRvS5OFlT1svnqYJve+voo4PAdUmoR0P290w0yBwsW/QQQMfUyUh9sN?=
 =?iso-8859-1?Q?ruC6/GUleP3IUV4oyG3VnVtt7kXEVdgBDl0dCY6NtmJJO7RRTeSEjwYlfo?=
 =?iso-8859-1?Q?H085lbSO2XukufPX4dBODaj00FQTcpOl93cabzlV08KnhPgCnHV3ms35DT?=
 =?iso-8859-1?Q?00NFsZE/9JxgMJK+cwRXufqqKVUVT+uX0mxNKB6uyhyCYyDUUbK534KAR7?=
 =?iso-8859-1?Q?CKzcbQjC9uZpKKWpnnEGh9bzZAY+JPxvcYdueXgn6nLRXM8fkKuNOJYkTs?=
 =?iso-8859-1?Q?JKyC+t6HOTVJTmjg+VUTfLwQXdmsNRTFP1h9pKswlrmG2WBbCNEUXM711U?=
 =?iso-8859-1?Q?D7Uf2S+ip13SfVvmqrey6UcgEBvyrapxqUGucfcKMKDz5ggoEhiEL39UCO?=
 =?iso-8859-1?Q?ttABYTEgOaBd5pRRcmEu69pckd0wXImALgJZ9qi+NrAyqhpTguQ+8pWLMJ?=
 =?iso-8859-1?Q?6jaNYZDZ/J2vHUTY17pWCo9LD7DVPXpVCq1+oGwjeCgdwg6y0Gm30Ieqn/?=
 =?iso-8859-1?Q?ejrObQ6p68GntPSJ2wyrA3CKyrtsKjvl4fKri2DNYQaCrv68S2Cjbp8k3y?=
 =?iso-8859-1?Q?0XMJTAez3ubhAt+kU1cJryFX3zfoe+HfITjaja4M8SSU0Jha+eacHeqNDp?=
 =?iso-8859-1?Q?Jp7M+ptKgsSISIyvhp4YMz4xgWVXdspnOiuWFcUkWLPrUoRDClVOYtVhcG?=
 =?iso-8859-1?Q?OKy6KbUpJVrHKk9Lb/ctA5DNLxUcIr4jRC8Yhngifooooh1xavvekYtZJ0?=
 =?iso-8859-1?Q?66Jf6LaXUdhz2zRKT0UeXmzMWDmX2h8doe/gl5SZgFoMbjlydoBxiv1r1g?=
 =?iso-8859-1?Q?HBQ0EsCMpuhZLkSctfiPq3wHZRabIzk+8xjlK/8II+y188HT8mCkJXOjcl?=
 =?iso-8859-1?Q?IaFEDPG9aUbcjQmWSldavnpkH0L4ML+8GNtdMIygobnR/T7Sjw+LGs7ZeY?=
 =?iso-8859-1?Q?lDoKIKIMkEOctre8r+hblTTvMnvyxX1ieApHy+uqqcJwWyihO02RZtNBex?=
 =?iso-8859-1?Q?iiyICrUJMlJh4nZno5VK8sfneaM9y9EdwZjVfCkGNaMj4G/9ouyNbwZC2u?=
 =?iso-8859-1?Q?SDbDdv31nYTJKBKtmZ1SwaHHaSJa3Nwl6U4SHh9zI/FCDLQTv6zFixLl33?=
 =?iso-8859-1?Q?ki1eXJWehRXIpAil/5mk4miBvIiqOn5gqnWZueBilXd0oy0YAuR37o3xdv?=
 =?iso-8859-1?Q?DQbt4aK0lOXcgOrygaYQgv5ezaHB5RxfatFovuv3/kjDE0aObrnl2G+KTP?=
 =?iso-8859-1?Q?+7wXGpeNKJ6hoK5VvdsmQ7nQrIXmdyjQkggkIqYozA8ywNDNllwo+aMwpt?=
 =?iso-8859-1?Q?MSbK2e5+olam4H00CD80mpudNMqdfWqcDPdMl4Z+LAo9gqD7DJThV8fNHa?=
 =?iso-8859-1?Q?qFxhA691rd3h11f990sDJA5KGkNeSTOe/Zbljz9rthfyr8CcFCnrHpvEg/?=
 =?iso-8859-1?Q?KJM9OAL0SrbaVrktIQmxiHpUOWuiaAQsvEOd2yB/zlIGILqFJvphzRkbkM?=
 =?iso-8859-1?Q?JiUCCpMM819Aw56uFsGilp9ESVndza65emShb/Ep6MAFbl+dtPBhON/asw?=
 =?iso-8859-1?Q?fZYWnVKnegJgjyyTz0H4rYb3Ahp7ScZ0mA6KCoQuAiVfu3gCXOg6f3uxVk?=
 =?iso-8859-1?Q?A/RW+Qz/JTn+4WLW5c9v2Mw42McNXfZDBCkEcoPkVdr5Ae5Ksq8yxoCGa9?=
 =?iso-8859-1?Q?D7WGKEsEq74yUyuOlujJsxUayDkTja8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c409acb-247c-4ac5-3037-08da164862e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:36.4565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bam8Ch3umqEh4sDTDSBnfDq0c8rGxG8AjWqQU9jKViRNCNrgzQYjI9gP25lAFlVEUHPEiAtKgSaqvzcSC8TpLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5812
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_06:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040083
X-Proofpoint-GUID: BbWK16aZy_fuYxH7vHwHVr4tDi0aNjti
X-Proofpoint-ORIG-GUID: BbWK16aZy_fuYxH7vHwHVr4tDi0aNjti
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
index d21e4fdbe1a0..ec21ab9b6fc7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -658,6 +658,37 @@ static inline bool vma_is_accessible(struct vm_area_st=
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
+#define for_each_vma(vmi, vma)		while ((vma =3D vma_next(&(vmi))) !=3D NUL=
L)
+
+/* The MM code likes to work with exclusive end addresses */
+#define for_each_vma_range(vmi, vma, end)				\
+	while ((vma =3D vma_find(&(vmi), (end) - 1)) !=3D NULL)
+
 #ifdef CONFIG_SHMEM
 /*
  * The vma_is_shmem is not inline because it is used only by slow
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5efd9a095de4..56d5fb69051a 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -684,6 +684,27 @@ static inline cpumask_t *mm_cpumask(struct mm_struct *=
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
index ebdee54b92e3..82365f9427eb 100644
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
@@ -3011,7 +3011,7 @@ int __do_munmap(struct mm_struct *mm, unsigned long s=
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
