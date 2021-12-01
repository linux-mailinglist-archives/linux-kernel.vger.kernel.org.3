Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F1D464FB6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350013AbhLAOfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:35:06 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:34966 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238208AbhLAOet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:34:49 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EP4qD018228;
        Wed, 1 Dec 2021 14:30:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=LL5RhqM2+z2eKX4tnCl5/6xouyv5Yk2FeACqYlFdsUk=;
 b=e6ObAJySIarLHsRaLy7GAu3tcYVWb0khfVwOKP6JEBhAIoj9XBV/sn+u1FpJR/S9EE5s
 W9C6RN06elqHUoDDH81PIZYxVjnCfm9iNMvqqW021KRHfvncTuybxRb3zYGLJCecObQN
 hsQRJRPj4xFgNml0TgAbuUIy9ybaeQOZz7l566G7pPcKXUgiN+JUQM0MWcr52S5xF71z
 YZqSuTYtL4fPzL46QcIsoJp2cKTrEvSdcBvQBwowoYgq9dqhA5RaSjavxzmMDkWHjihN
 GeZlMFxwZ/+BpfO/lECiZn11XhRe6nJiAIaEA3UJOY5qo5ENX+FK6DUDS9Kl3LYMsI/G bw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cpasyg0y3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBMFI049269;
        Wed, 1 Dec 2021 14:29:56 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by aserp3030.oracle.com with ESMTP id 3ckaqgkcte-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:29:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/4ARms8A/rRc2kDDAVU3O9hpaPL7rj31aymaZVWvfxsv2HXcqbkpm5DMf0xyLvtnFykT3kx3vgydZyRjrZXXgGV4Gz/Y8T/N1V/hzJfZq7SuUUWDnzstytjg3WJXwQana8KQv/BeZNlthtR4baKgok9P4QxgZ7thKuHZ79OI2NzLG7H8d+BAIOHtiPUQvvrWcaIEP9rb8q10az1tfnFSgVKSwsep3lYeH0wdFdPb0wICwtgZzXgv1DhtVYs+cBB+mUhOtADTl5ngH3JbKj33Y30BwI7LnWjLpY9JE97IwJLT3YhHhXCBGrfo5PQLrXi1US/tGzvYs3penveifOdHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LL5RhqM2+z2eKX4tnCl5/6xouyv5Yk2FeACqYlFdsUk=;
 b=nBLDU/m+XGLuOMBeyVhoMUIa6AaufPBsrt1+J04uyonotHgrrYiCxivuI/1QR51WTo+COaAxt7LPtl8edkc3YwdAJSdHq96/H/Rbw/nyFuKyLr89SCT2vU9ektyas82TGbWEMwzCL9dvLfU5jd+fmJ67q9LIVhYTEzf3xHzyzIBA84MG+GGdULEMgQp708SEQHKmZHJbNAH5pJowfclRl90y7zaSnaSHJgDV9af4C3Oer8Pcv8KMlnrkPLVaIwmeDP8oP1zj2Pb47sjJvlvhzga9GT4+5YlsrkKZ3+PrFXwXov5GPIXEdfbXELIIFAA/cCMLshasK8L16LK85qpVpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LL5RhqM2+z2eKX4tnCl5/6xouyv5Yk2FeACqYlFdsUk=;
 b=fIjMcPt2yCNxAmpVWCAMojBcTWUhXpt4P6L1JQBJbsTUh7iY2gkSnubUIjZeTmNaeH9eoGIfmyeehn/zx9hIffXCDZ1j4M1Is9bBQMWB/BlC4Yvk1q5sqOqzfDrbmxcWF5dpeY+V/NP5Ws8gY9V2o7QDwyer/m1M2hn2vnG4bQI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2768.namprd10.prod.outlook.com (2603:10b6:805:4a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 14:29:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:29:53 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v4 10/66] mm/mmap: Use the maple tree for find_vma_prev()
 instead of the rbtree
Thread-Topic: [PATCH v4 10/66] mm/mmap: Use the maple tree for find_vma_prev()
 instead of the rbtree
Thread-Index: AQHX5r/nzpZEy6UqyEmCdHgcNq/17Q==
Date:   Wed, 1 Dec 2021 14:29:53 +0000
Message-ID: <20211201142918.921493-11-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3149d291-403d-4a12-fe72-08d9b4d70a46
x-ms-traffictypediagnostic: SN6PR10MB2768:
x-microsoft-antispam-prvs: <SN6PR10MB276866C512F7FB3AEC602F2CFD689@SN6PR10MB2768.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c40QEwJSJShjcJCddtvkcBwcfCr32MADJ034z/umkYKjkxTDL54pxrCm/zqZ7FDZ70oEWp2PpZDMCbEzTYXkVNcUnjutsaNEZ8NRgBCp3OrGEaQRqZCEwuOQwc/bARFnredoz7odgPFEqURvMvyWZ9jqlv0x6OpPrHYFcG66qhJLsEjY9sNfnIj70//QRiM7wrsMZDCms0nE3lIHP/YQfiYSpnyxa4ImD4llka0arQBkE4BP38nvo9LRgJmY/qJpJBaf5wmDM8pxW7/jiM1eC+ECkWAngDIinnLd1WvsamEA1lN3R6ExklYDGdkz/+H879oPiOR3IUV59FnBABwtfSYS1ThyXvV5gt9qCbQ7f3qOPSR1A1WNIPp4ddLjE+4DzRxau5bUt01J1OeNE2arZk5hQTKqgxCmhFDI2kh3dT/cxoBtYTDFmjPWZqYu4/HYIE2crf1lrFWhPamu/XboextO312OTuTvilam1YeOZ1y5I6qbAGoIktNhe0xnaHp3oK+FZgC/385weE5X0myDzs9FMTJxAhQXyCXACAYiue0qPErtAx4D62Zf8eCYr5D1F07MJyC0YTwY+VcwFMe/Puht0dczYK7QKvSRwM+Gr9IZuN+OWAtRrpT9+fImOkc6W4s/pr/vqAkHjdtWXNv2ds5CCiJOhMh2W38KCMsiHcnnVxktHE6q9fMNVfPioFQq9IArZkcsyLTBJ9UIhSdLSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(508600001)(66446008)(64756008)(66556008)(66476007)(44832011)(7416002)(66946007)(110136005)(316002)(36756003)(122000001)(6486002)(54906003)(2616005)(4326008)(186003)(91956017)(5660300002)(71200400001)(38070700005)(26005)(8676002)(86362001)(83380400001)(76116006)(2906002)(1076003)(38100700002)(8936002)(6506007)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?++sXJ6lAdYEMg5iKSblwFFnI08M+Yjx+w14PPeTiGfVI64GitJLcDv8bwD?=
 =?iso-8859-1?Q?GvfR47l1SgzkzcRR6Q2BxjhqRqdIBW2K/uyk3lOELqNP3Y49k1Jmc2BP+8?=
 =?iso-8859-1?Q?z7kLXzq3SHpQSnRoXSa6MM4XvsF8Yt6fROY+bJkBS63ryyIATInqhYn/L8?=
 =?iso-8859-1?Q?SuR5On0Qh+U3qhrtWJ2JQC+R0cs70PcpJmtKbWlb3j34W4tiJlrw0BwiKx?=
 =?iso-8859-1?Q?E5B5hglINcF/OL0XFIfoWHt4+jxgX3MjulKXJq/onjkvIXPJDqXuU28GTo?=
 =?iso-8859-1?Q?X4GbAPBXxwBOwGhd3BQUJ4qi4QPUxrB3ELJ9aYbWihlPYqhIs/P7DAhuN5?=
 =?iso-8859-1?Q?q0hJCqUaCC7YXu4kLtZRGg+uxni4kTsf6CFQeSN3Et41o6tv8eeQTG46kZ?=
 =?iso-8859-1?Q?sglQv8f6cQwsH0F0lHS0UheR6YL4wUBQH4I8lzXOfLcF2Yqm6Qng+EZOHp?=
 =?iso-8859-1?Q?YobniSkiGIHPbE7ovp0A2BVWyzBaslmu8vtp+x2ohe8JnEUx+mADcPJ4sp?=
 =?iso-8859-1?Q?CZTlBfIHXriOMWhsPGVi0cg74irFAHqpUcZlt0h6J1BhY1JrdqOVouh73G?=
 =?iso-8859-1?Q?4SsPFyxPQZKW0flielUCrxrYSfoTjtSEFYOmtVR4YHv3wCIW3edTnC20uX?=
 =?iso-8859-1?Q?dAeNCyNrBkfzVWpmQ54Qh4rm2blIbpK9p7uZNZDxp4PQWt7+MXeg13xCsZ?=
 =?iso-8859-1?Q?y12j6CmOHL7QZ6ZhPDtySpQUAOcWxMi2KoIbYeR6jZNE6YCWU7vnJnagOd?=
 =?iso-8859-1?Q?qBL3q/eJj/im1C5fqDNC6BrPCboioGMzZwU1BNgl54dzkFwEOlAxP8VZwx?=
 =?iso-8859-1?Q?m4wT/AszaIqKe6lKRmfyeu/AdRgm8QnpujxT9z79VY3UkI1KX1IElcbEjy?=
 =?iso-8859-1?Q?IeR38wnBWyKF5CAY4+T3GRNaSsucVw8kNHgPF957QGvCpWJcWEZjMTdjEp?=
 =?iso-8859-1?Q?rBYR4AQA4EHPIh111Rui5FEbEMtxABxTphk3kZodHcuvz2GDWUwHVbVU3g?=
 =?iso-8859-1?Q?oUqXEZKF6yNQ0It5K3xY9k4W+Mc31CTeKQKhS/Nzh4ufEo6xe81VXyNOok?=
 =?iso-8859-1?Q?TFKlGb6dJ6uesjt/WEbfRQ5RnsZJhebQs2iWE+RZOyGp1tCnbiH+S869js?=
 =?iso-8859-1?Q?7PwvFSFNjhiNfO6axK4wpgNKQReANJMfPb9C0U0IjrWsuwdx2tg62AoqsR?=
 =?iso-8859-1?Q?kLxl944xFC01Yr8mlF6ljHyFeUDgxHSMsJFejO7Nnvpy0GOJxHcyqpkYAD?=
 =?iso-8859-1?Q?xtAE6tju9eQ5nPbxAod+IVceIWoiQoqyW7sljahZ/IMlQO1LbmVbg+s6kj?=
 =?iso-8859-1?Q?hOFJJ6LjUkaf9fGG8QMk/MM2EJuOcsV95AxAr42fh/tuklJuROYPeksW+k?=
 =?iso-8859-1?Q?FmO7acbj87Seq9gYPfiIJiQ7yH4c3y6cc4Doa8XhUeIQ+idda+cjYVpm5F?=
 =?iso-8859-1?Q?WZVgFxsVGDrxQ07V1+cVSaJLB09of1Gi/yCNUJXvpGcltAsrpDk4luL5Am?=
 =?iso-8859-1?Q?Kib7oB832EL2MVrj6JGU5lkB4ZrqWxgoFhGuGLCUV/dNtz9SmGPVV3Q9K4?=
 =?iso-8859-1?Q?Nq4nXCbgChAfLTJW92udW0eLQrfG0vYUvlhxMXSFOJABD0PB/3SMB7h3yK?=
 =?iso-8859-1?Q?pOUS3YWZhZK6jzIuBH2CCjz7RGtFhj/TQ9PYW0OT2BrdQLgqLrvZUT6XJZ?=
 =?iso-8859-1?Q?JmNizL2PM+hxB/ALPUQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3149d291-403d-4a12-fe72-08d9b4d70a46
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:29:53.1829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lYfMVs++YXapUman7zYpTJylfhOcr3tP09/Oyx/yRweewmN4m7IQOGd/dVB3Sjh54UaLxy2MB8/I6M7l7sU/xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2768
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-GUID: _laGFCEzj3TdJDynW4xpSiUUNVJFXfV3
X-Proofpoint-ORIG-GUID: _laGFCEzj3TdJDynW4xpSiUUNVJFXfV3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the maple tree's advanced API and a maple state to walk the tree
for the entry at the address of the next vma, then use the maple state
to walk back one entry to find the previous entry.

Add kernel documentation comments for this API.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/mmap.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 6a7502f74190..8425ab573770 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2454,23 +2454,27 @@ struct vm_area_struct *find_vma(struct mm_struct *m=
m, unsigned long addr)
 }
 EXPORT_SYMBOL(find_vma);
=20
-/*
- * Same as find_vma, but also return a pointer to the previous VMA in *ppr=
ev.
+/**
+ * find_vma_prev() - Find the VMA for a given address, or the next vma and
+ * set %pprev to the previous VMA, if any.
+ * @mm: The mm_struct to check
+ * @addr: The address
+ * @pprev: The pointer to set to the previous VMA
+ *
+ * Returns: The VMA associated with @addr, or the next vma.
+ * May return %NULL in the case of no vma at addr or above.
  */
 struct vm_area_struct *
 find_vma_prev(struct mm_struct *mm, unsigned long addr,
 			struct vm_area_struct **pprev)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
-	vma =3D find_vma(mm, addr);
-	if (vma) {
-		*pprev =3D vma->vm_prev;
-	} else {
-		struct rb_node *rb_node =3D rb_last(&mm->mm_rb);
-
-		*pprev =3D rb_node ? rb_entry(rb_node, struct vm_area_struct, vm_rb) : N=
ULL;
-	}
+	vma =3D mas_walk(&mas);
+	*pprev =3D mas_prev(&mas, 0);
+	if (!vma)
+		vma =3D mas_next(&mas, ULONG_MAX);
 	return vma;
 }
=20
--=20
2.30.2
