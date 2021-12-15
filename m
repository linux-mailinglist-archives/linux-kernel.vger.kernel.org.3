Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1EE476093
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 19:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343719AbhLOSUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 13:20:12 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41538 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343674AbhLOSUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 13:20:07 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BFIGSYf018870;
        Wed, 15 Dec 2021 18:19:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Tlz2nR+88jD4i9RaMLSplZ3wcGl9XPh9tdMy4pkeleg=;
 b=hyTtHmQbd+J+ujIxSRBICAv9vOkev4G1tkl7JFqGDT6TXIpX1jd6ZEGqfQRXgwAc2icy
 f+MaKt0gHfN88q+rM+KbOVRgcN/MyUiLVnq2evoXUNcweWstVSc35ifB10XCWUNVaJYV
 HSDq9871sKS1p/YTaeEAjv8/VyECVuW+z+LkWPyiCC0yI9xneDIRVrphPwKbNwA9L4px
 znzlgkHqN0Vyhu82w9LZKUMaxIYF0MGZd4gwLHG5qRufSodq+T6AzECxnW6SIqjiMFni
 n01G/TqA/uEuui94nrTn3bYDecS7RJAMqBPPCLuSq2wGMBwTkywrvOwaAtMhloE6zCK4 vg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cyknrgdrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 18:19:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BFIGX66054406;
        Wed, 15 Dec 2021 18:19:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by aserp3020.oracle.com with ESMTP id 3cxmrc7f8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 18:19:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgqutWpLg76hgZ4NMUnqEQoq3nF3msNOlN5fVn4yQYrqM8zSfSiHNrFpLmA+FpQqrXDjoVG4kKkMD3mcQ50doHNptr0KmK8cDojC+YXVK57GE7SQBreHiui3XzzaOCerSKR2TMQIZf10rdUbbAbJw2s0qTVDW1SJgE2Yv4y1uzRaQq0PwpEqYJeF3vNOH/u8OGVK4PXDrGA8beCaXDWOluANg5hcZOxQ4RUUJZ0TnTmRmspSh8EMvj079yVZMeInHX3XHnm7xim6J00GmODKj2o5ERfeNR9IJRrXMQBX/M7xUxh2x8xtmY/efFP1aSHO3JVpN6y2UHpMU361E3raeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tlz2nR+88jD4i9RaMLSplZ3wcGl9XPh9tdMy4pkeleg=;
 b=jS7S4/+1Q4cTAWRO+AM3tVQIiKHeK/F+Im7k2Y3vJnlYehEsSR9hhKaqHoVCsQkUSuN7Dsk13EVwcYYpJp15Sd93GQVEYQkF4gimsGdw0H8l/CXwKufsWEMGiI1+DJ25Vfa1T+P5WQKqzqT31PnhBEkRsS593nfpSvovfbtOj82RTbgK/15up/Pb8mMZ0Dt69SBRs2yTQ9elcUxJiCkPu2BMo8YrCOXoHgHpNL98F5L1Ttt12Sh84bgBPiRNXnm9zFOfT5VnsbW7eyXnyffrMHdVmEZnP/xXzgh80GtMiAr7PX1UWAwn1PkEHu8ddltEN7NYlbVSGGjc3n+Zw+4lJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tlz2nR+88jD4i9RaMLSplZ3wcGl9XPh9tdMy4pkeleg=;
 b=wTlhnQQ137MfLffus6qpKgnEQxYJKCv8J9JxfZixswIys73T97FHBdXjIFAR3nln+CmqH24LkdJr1odn3ITzbzFblIexMC0dnGx5PqLABV8iHvDL6Tp75VUdDQjoREg64m9aPnxE7dtd9udnpFAIOmJA2eNpoBleDLtWN3jwpxE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3455.namprd10.prod.outlook.com (2603:10b6:805:cd::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Wed, 15 Dec
 2021 18:19:41 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 18:19:41 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>
Subject: Re: [PATCH v4 10/66] mm/mmap: Use the maple tree for find_vma_prev()
 instead of the rbtree
Thread-Topic: [PATCH v4 10/66] mm/mmap: Use the maple tree for find_vma_prev()
 instead of the rbtree
Thread-Index: AQHX5r/nzpZEy6UqyEmCdHgcNq/17awz11OAgAAbz4A=
Date:   Wed, 15 Dec 2021 18:19:40 +0000
Message-ID: <20211215181937.fpvrnsghdiubcxqr@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-11-Liam.Howlett@oracle.com>
 <92ef4cae-ccfb-d952-6b36-71036329e8da@suse.cz>
In-Reply-To: <92ef4cae-ccfb-d952-6b36-71036329e8da@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bf2c51d-2f68-4c42-2a61-08d9bff77642
x-ms-traffictypediagnostic: SN6PR10MB3455:EE_
x-microsoft-antispam-prvs: <SN6PR10MB34553A8B698519D9F64A8DF7FD769@SN6PR10MB3455.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tgmn2XC8zXOMGB2z1aqdoJ++Rmxoxgb6G5HOkFWFMcw+8ZxUYZRL27WWo5wwyyvmynAe2DG+e0ojUResX+Jm+VBsrn+Ws/+QJ3IfSyKKQE2aGW68yl0p5X60uhAid9HTW6OX0w7CuQ7RqXIzFfKpstDybVkGIP7gpUrtscA9n8y0oTrs8hN2HCbHCYrSMHTzVfR4E9IZ/CSDXFzSePHkgk4LihxyQFSHeIpCNUIR2bSNhoAsT7ZN2fkUA1oOX3HkxsMP2OYY5MmIOHxOqAtSt23sICj1r2LjWg19Iqz4ggAUzOfaDtHeU4oXGj65NCI5mGpIcIOyOedyuDh1ecxMRToKo4myjaPXn9VkFXnbwYZhgiMUdp85zwhN5aNlvbRNUYq7pnOwuGlKvmkvIKeveER8CFxDhW1zRz+/lJeJYHx3lFc3srJwG1DbfcEaQXc4YURZ23Xqn/WRpPqUepUqCVClbJyvh2x2yB11pM1AUOO/+oH7EO971VcRVJpsXtS+uF/svZwXuYWl5iEOMmjDoZoe0nX7Bf66O0C09WW8dxaWG8TYe3LWQg2HOiD3Jo6gbPdQU7psFoOcdAaDYUBWvTa15CMBQAPLIybb08l6cYfm2XP1d3jhMZmoftDKTaPWI7R6bNiI14ob1ZtRzS++eo0rBxnpuWEmmUtxbYKmfSDHFVz75QocvhFIx3Je3O/+AB0ss+6CSOb56qb3T9B5Eg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(26005)(86362001)(8936002)(6486002)(186003)(6512007)(5660300002)(8676002)(9686003)(6506007)(4326008)(53546011)(122000001)(2906002)(66446008)(7416002)(91956017)(66946007)(66556008)(71200400001)(66476007)(1076003)(33716001)(44832011)(508600001)(316002)(38100700002)(76116006)(54906003)(64756008)(38070700005)(3716004)(6916009)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DY2eah7JP0Lcl/Az9WlNNgbjHTRD1HwRxALC88jPT4l6TlK8ln3GzQXJi1qV?=
 =?us-ascii?Q?2EMAgu5jroEbO9AaHKBOvHZo8wfdoKxFvR2SkP8x9ZlXOyXGXJSbQG82HgTA?=
 =?us-ascii?Q?najqvk9rijPziaGcYurN/BR60J7Ta2vF/t0w25GeUFeXa63loKjZK7UVBu0u?=
 =?us-ascii?Q?W2P872wY/TDEkFkpYAscAvsCEyDh9WHhhCwbXipSsSj0pPjgsc7ZUCOhAQi/?=
 =?us-ascii?Q?JF6tA5tVIw5s+UxAzjK83IAcgNfjGNluy6UI/RsPaMJPDyQsYlbHIpN9fkyB?=
 =?us-ascii?Q?nDkoVFDqox0IVQ20qncEXjgKqIwbtPHp3p2oP0ff81UT20I2wvr8Z3S7UIS4?=
 =?us-ascii?Q?UhYL+p2i56ZSQjyM38CK/jB3AuSmlxOEkx9wapNQdO2PPVgO1pKwPF0/d2Lh?=
 =?us-ascii?Q?ROyG6WwJs3F3ySuk10hm57MMGQzhxqvKWlcWAQXY0zYlM/HOElUA0fqRusZ4?=
 =?us-ascii?Q?VsbwAYxEmL4jf7QouYXLFFUMunEID5gHgUv09lySydiZgdNF5ZVdSdUf2Z4k?=
 =?us-ascii?Q?FFbH4tLzQA1fMBuC4kBXXm8FG0pJ6aEQR3xnHa+3EkOwp2rr+9D7kKhewc7b?=
 =?us-ascii?Q?Y1YK6rHGv43VySlgNrpn5PREpX/65miZUmf9dcITiFozjMX487oYv48Es2w0?=
 =?us-ascii?Q?5lFEbqh5Y+LH/Mi2JeCRMPAqVaJwjy3msyya6PYw0zfeXDO6YyKRfuGPt43Z?=
 =?us-ascii?Q?Jh09oikhVwWGAMe9BbaexCBYTvnZoUZYvf9RcTKNIL4ZTljtPIPMGrz8LIGb?=
 =?us-ascii?Q?tQSA/NogyRqIvxmahRlcJY81NQLDfLEkkSdLklqq/8wBf6yzOxoGtQkLDMDN?=
 =?us-ascii?Q?z0ppg3R+x+HPkAteUW5LKFyr2PFGFmckx853H0m3UCEd09jKkjHwZ3VG5PtE?=
 =?us-ascii?Q?K9FW3FLf5jy0PtpR9QKTp/y0bJVbnmLUfaB3B93Pku7YIjVhpxcUA07ZD6Hl?=
 =?us-ascii?Q?5RpXkj0rhbDXVzx/l/LsTGB4DFKyM/mPG4umd+uV+5MPXgzw3Y6fXiqTgkuq?=
 =?us-ascii?Q?uXjO+o2gPjJ/Zkt9I+Sn7FV/oGhmssdX9MmbCHia9e6lWA68Av50RMR9sB4v?=
 =?us-ascii?Q?jk5jWyIbHSp7hAgz8ISJfQa/uCik1vS0wANcr0v6RR5G8LgmB7Vvo8GyHioz?=
 =?us-ascii?Q?CbKFtJG9cEtGRszlydmN42IpPwHSATGHfP1wv6l3FHUZhU/jjVCyJc44WMuB?=
 =?us-ascii?Q?WbpqbME8WZJPPLt/2ppg2RQg/F3oIv6nyy2EGLmYNaztJwCi+3XV+o7uZLH1?=
 =?us-ascii?Q?xeXYCcOluDamsFhXdJl5XBr04ow1Q2+1J+lfxsUy+5o+8P/7r6FFm0mUlDAf?=
 =?us-ascii?Q?jDrbDkNC2svjymhI4xPUkKNfruh0T4yM4faI9tkDkgD10YvURXR3UJPSHdXU?=
 =?us-ascii?Q?5KAAZu60adJDCC9ftr3XK2XIA3a765KPMrN/Wk54i2+J9PfCZKSxGQaDsAlF?=
 =?us-ascii?Q?ComOLfAp0Uk1xLlLqOlUf8d5JEZjMb/Uhzg763a3D3zF1Y4kbb3mDZlX7ZsT?=
 =?us-ascii?Q?QkfUB1rsrhewfHg2IFlyN8UmkW0224a+gZ85wlZoni5opAw3IFOWtQryYpI9?=
 =?us-ascii?Q?Ut7VepOQWTREozqTA4/PcXiLP2LBToUoE69LsjK/03tZXG8MWRYdB4HttQ4c?=
 =?us-ascii?Q?7K6Fjz50xrcVYLX5T5aiLKs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F9A1CC64DA26D34981C6AF415589776B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf2c51d-2f68-4c42-2a61-08d9bff77642
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2021 18:19:41.0573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qMW0fWZf1eRpS+fM2NZT/dxCJF5Cr2iZ6TsrNojOYbAPKO7PIn1sVKH1peiH/tN0KxxmBY/f51bokdI/Qd9onA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3455
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10199 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=996 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112150102
X-Proofpoint-ORIG-GUID: Z8sPJSi0zmpZkIJmHy9IQzqgckw_JDYo
X-Proofpoint-GUID: Z8sPJSi0zmpZkIJmHy9IQzqgckw_JDYo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [211215 11:40]:
> On 12/1/21 15:29, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > Use the maple tree's advanced API and a maple state to walk the tree
> > for the entry at the address of the next vma, then use the maple state
> > to walk back one entry to find the previous entry.
> >=20
> > Add kernel documentation comments for this API.
>=20
> Additional note: the previous patch for find_vma() mentioned "Using the
> maple tree interface mt_find() will handle the RCU locking" while
> find_vma_prev() uses the advanced maple tree API, thus IIUC without RCU
> locking, and doesn't add its own. This can easily result in a bug,
> especially if the documentation comments don't mention it at all?


Yes, you are correct that mt_find() will handle the RCU locking, while
the advanced interface does not use the locking.  However, now that the
maple tree can use an external lock and uses the mmap_lock(), it's not
necessary to use RCU locks in these cases until we have users that are
removed from the mmap_lock().  I will add a comment so that this is not
missed when things are removed from the mmap_lock().

>=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  mm/mmap.c | 24 ++++++++++++++----------
> >  1 file changed, 14 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 6a7502f74190..8425ab573770 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2454,23 +2454,27 @@ struct vm_area_struct *find_vma(struct mm_struc=
t *mm, unsigned long addr)
> >  }
> >  EXPORT_SYMBOL(find_vma);
> > =20
> > -/*
> > - * Same as find_vma, but also return a pointer to the previous VMA in =
*pprev.
> > +/**
> > + * find_vma_prev() - Find the VMA for a given address, or the next vma=
 and
> > + * set %pprev to the previous VMA, if any.
> > + * @mm: The mm_struct to check
> > + * @addr: The address
> > + * @pprev: The pointer to set to the previous VMA
> > + *
> > + * Returns: The VMA associated with @addr, or the next vma.
> > + * May return %NULL in the case of no vma at addr or above.
> >   */
> >  struct vm_area_struct *
> >  find_vma_prev(struct mm_struct *mm, unsigned long addr,
> >  			struct vm_area_struct **pprev)
> >  {
> >  	struct vm_area_struct *vma;
> > +	MA_STATE(mas, &mm->mm_mt, addr, addr);
> > =20
> > -	vma =3D find_vma(mm, addr);
> > -	if (vma) {
> > -		*pprev =3D vma->vm_prev;
> > -	} else {
> > -		struct rb_node *rb_node =3D rb_last(&mm->mm_rb);
> > -
> > -		*pprev =3D rb_node ? rb_entry(rb_node, struct vm_area_struct, vm_rb)=
 : NULL;
> > -	}
> > +	vma =3D mas_walk(&mas);
> > +	*pprev =3D mas_prev(&mas, 0);
> > +	if (!vma)
> > +		vma =3D mas_next(&mas, ULONG_MAX);
> >  	return vma;
> >  }
> > =20
> =
