Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A184964D7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 19:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382064AbiAUSMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 13:12:36 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:7570 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351822AbiAUSMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 13:12:33 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20LGxZXf031839;
        Fri, 21 Jan 2022 18:11:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=YfqIwRJ1wXe+O3uVRjqEFWwh0Sm+XqoFa7yIZtmWvxM=;
 b=ouVq9c3ErMdLwFlHG/T7JOwmpDjhB4WA/h0IaSZ841fuSYTq+/cRoQN0S2HiZxEZs21Q
 tfK6BY4LIjSCt+5qzKqWxLEqWp9rH/XlM/en6JzTuyzzY/MwIlnSox6j4Z7/WDBYTpp9
 HnzWhQaak4RKWJRsau/xr7sTGRL9wcwP+BPdnei0PyxWo7VKbIXnCiVWirGlKze8NExB
 Kh8hYyzZrdRUamtQPA4w3TEBFSrPgFDb8Ky0VRvtFPmlt9+eZg6l2O8Fc0y6wxClrml1
 IUA/tnOSWfaqHSea3zKWpG+hy9uAN3z7p21VLI5UMZ49hrtgA5F4CplwhQ3JaNkkzs53 sQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dqhycj6tp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 18:11:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20LI6YGP192324;
        Fri, 21 Jan 2022 18:11:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by aserp3020.oracle.com with ESMTP id 3dqj0td0pv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 18:11:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGu+as7U+kuDxdmNj0doU1of0oprh0U6ZJaUaGnTpUix9U5r6Q8/2UPpGiq4De/TdhHW0ItvTBsUhXRIDW4UFjc+d3byD9/ltrZsXPqHSAjut9GEOYkZAUDe+XjAxPYCbDfuZFNriR5CvakcaLalD0skKwC762+N+jwL+pwFE88UtsFDg5b0Q/oaNx9dD1Sx2ID1pEhfRPQEvzSQoj4DXxObpiz84RW/nlSuK9ybbAqvrfmxD9sGFbtkTvOuB0ulkMCvc7v/nMCoBdCq2DSmcxQijFY+0+W5WTf+/zj91zkDpfatUsm3H0ibzHH4zllWt6/rctTrZ8XgGv1HohWeWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfqIwRJ1wXe+O3uVRjqEFWwh0Sm+XqoFa7yIZtmWvxM=;
 b=Oxah3i7+6aQ6O7CAILgM2pcMW156uXOhO8cdpT8sm/uhJsSkeyjGuO0CO76eLZG3doHP1fFyVbceFLobM3/9rrSE8GMkxJ2wN6GA9yGXVzjWTZUqU0vsyjcqY7ZjC2DzjJf6lUS2LQimqvmm+O4p+OfjNf6UCe72GDIVNKeQy9EqN9khhsMI2J5m9aVOFSkx3OdmXr1D6YCa9qxyj5vcYjINbCBbLc7l4j1rBx9EwoUfew/0PZlI8cGTDfwxYLFFs6OXtib+TG0MIq+enc1ELdmGXJHYbqFfNaHTvyx8oMUizumMuu0QZ2A/3+5UWsM2rbDAy7Ql1AI1sGa67CMJjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfqIwRJ1wXe+O3uVRjqEFWwh0Sm+XqoFa7yIZtmWvxM=;
 b=Z6vsS4yRbTnZlRwOoOCq7TPKLNG0Z4kF+krIuw8HHO84raSn0RN4yf5JsgUanz3rRjCvRhJ3TCU1oPgXxHoLXfp9uXj+pZJcvI5YEH/3LiMKDzLjm0YVlbw6vgHSoC01UT/MOqff4zLdTLidvwOVGw3aI4HCoFcRLAD9WrG+Pk8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB3498.namprd10.prod.outlook.com (2603:10b6:5:17a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 21 Jan
 2022 18:11:44 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 18:11:44 +0000
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
Subject: Re: [PATCH v4 23/66] mm/mmap: Use advanced maple tree API for
 mmap_region()
Thread-Topic: [PATCH v4 23/66] mm/mmap: Use advanced maple tree API for
 mmap_region()
Thread-Index: AQHX5r/sfPNRBD0VUEaGWF0gvD9gy6xns++AgAZjOoA=
Date:   Fri, 21 Jan 2022 18:11:44 +0000
Message-ID: <20220121181137.bswrb76rrx53gwul@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-24-Liam.Howlett@oracle.com>
 <d2520b56-953b-2552-149b-41f232a7fc0b@suse.cz>
In-Reply-To: <d2520b56-953b-2552-149b-41f232a7fc0b@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97ad6e59-0dc4-42ab-4a77-08d9dd097b53
x-ms-traffictypediagnostic: DM6PR10MB3498:EE_
x-microsoft-antispam-prvs: <DM6PR10MB349842647C6D2ED066F1C6E1FD5B9@DM6PR10MB3498.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MVO0iKIcaOdFw+hHZw6/OQDDBqCFznuITNGSTjQl5ckzkvwoG+45j7dOYf0R3nLIG8q2GMbe2curW4WwBEYg2zV5oCrMS36l2h7yFp35Vf4pfTG/T6j2wwdvnd99VFW/zeWOQ2CD4h1m9oxwPdOda2DaLFjb0XIKTzejjjjl7+pLWoKoEvLzbA/g3vBlmfeB+mOkJ1+azzNB9ecs17hQp6lKpOEeS8k6iESZa2H4HkZ9lK/5ejcLcFnwCvpcmCVtzDORUPtpSgo6RrVwnEznu3j3cVKkJPrOvqStuWbt9TpNwxttlj1MKleKwc44TfHNRE98+lf1WLwCvgdZ00omv2B0+gxD7M/JE0EDJIApBYo+BRkbAgiPUV4knsnoSQ0B/GFlTPpGaESEe0ugHXv7/h07wEN8wP5ZoR88DRVxrI6HnN+muEV8A/Ug9VtKjltKbFil6FO1k9A8h/ogNnApSx352Tjamb6hgeEYg6ekX+cRxc9EepAoFoC2wwYs3kluioyTD3Gqa8y5cpZN6eqPOst/lxOZsmjpVZS1cvtdaNdyih21tkKlgLl3m4K7lVNhnHP7e0nasld3tuPWNZNJKY3BX7NuW7L1m6h9HjRTVAk/VTloiKFWVe0pOL5OJw/X2Ur8yX+eX1ex9HTAHu4ya5RjT4OCcksgUPZI6caAoULKgwod98Eva5lHm0JAnpt4uWPH2yc1uY1gYmKxzOW10g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(508600001)(6486002)(6506007)(2906002)(122000001)(66946007)(44832011)(38100700002)(54906003)(6916009)(64756008)(86362001)(316002)(4326008)(8936002)(66556008)(5660300002)(91956017)(8676002)(9686003)(186003)(38070700005)(33716001)(83380400001)(53546011)(6512007)(26005)(66476007)(7416002)(71200400001)(66446008)(1076003)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tsmicQ0V+QPZYkuN9U0DNePx8mDJVvB5A8w3YqthzQDgx9WO7G+WmJzq7dLU?=
 =?us-ascii?Q?o4EXNX28PeYtT5E+b1L+4zwcZRokh49j+pr0ozldmDeoCzj2Jvmgpj+dK56s?=
 =?us-ascii?Q?yY2ThI0sVu9W3uy5fENwfBLVbuoQ9CJ3f6GycG+mxwRj2b5xRYUqnTIok79n?=
 =?us-ascii?Q?BTzTX6feIQMjq/sw7FffDRUdaH62NEdb2l16cKW+LLtPYODvLPA6iz05hpM9?=
 =?us-ascii?Q?jkyUP+hwpFHyX7PI4yP9JAAXwTdGkFYxG6tIrTDjw7E0NRvkeC2xy0ZozQIY?=
 =?us-ascii?Q?hSv5N0LxaTXtQY3EWpZf7h5HYZKom/MTeXXMArVOEP2M8BZo3CvZwiaFFRcj?=
 =?us-ascii?Q?p7/JcCdnLrN2SuDNKt9awV7NYKtk1QbIbI01UMihmk0osi2LkBAsYzLI7RMN?=
 =?us-ascii?Q?Sos+DjYjqPLLC8w/bnyrKbaQ9KgN/e5DicdgRO25SzlCsz+yMqZFooT7gtfV?=
 =?us-ascii?Q?0toWBYQQtJGvJe2krW02MeA1cWTNJYN9YTFczBaKZQb8KPNjsGBUbq1KPS36?=
 =?us-ascii?Q?Bfbdf4LJp++evhiOhyWMPBkvGvR6cxkTh/oVeoQhcPL2Wk1HfTnpzkgPmsNu?=
 =?us-ascii?Q?FS+hl30szoB8GOXC4Ps7iG/VGpIFdFePitgPCPDzjp73JtTuo0EQZ++Osm3a?=
 =?us-ascii?Q?UzSgHdBL/SlvPqdlOY8NpI+FFwt+gDk5GCF4SRNo/2uziCwiEJjytTepUjhA?=
 =?us-ascii?Q?yhJxPpdlqrXBMK0kO0YdswRn/uybzSjYBJHHFZoAob3a+AnUfXRMqa5hzYuf?=
 =?us-ascii?Q?WtU4utJXojhaxGZnoxCseYEgLKNcoDtraW9UsvgQ+Xee8Hk75mwnKYe1RWhs?=
 =?us-ascii?Q?DxbfIItOEsFQHRvrIEXndohTyIbKkxqPfHWCYK6V/BlfqOD2+Z9cUEb0gnF0?=
 =?us-ascii?Q?TOnqab/R/tWBFpMduecjK1Af4auKUlFs/S5qxM2bnvW47mA6r5EQFAIszqAY?=
 =?us-ascii?Q?1JvkzHKOZTcoiX5WwXuSs6uvwxDOB40YWiQ6AiqwmSAXKLPsD3Fjzaq/Akd7?=
 =?us-ascii?Q?MJE37Q0/TShYnbYIGsYLVdm7wVkxxFDdw7JGLDbzYuzPcAxBlZc+i/BVIv/M?=
 =?us-ascii?Q?m9I4eMvvh2evZ2RkQp+EE7qliRtVDvdA7wsSa1MST3HO9WiL+fH88SjuBYkt?=
 =?us-ascii?Q?mmqGxwb+yKwvQQX9hyNMY/ffLLRiLzJe81ReGdvas+xWXVnlen1EwcVE7G/e?=
 =?us-ascii?Q?+oO7vDzVG1R1spEWppJLfI3seGpuGx/ZpP6/KuShDdLxMR7JTmifdi7HJzRN?=
 =?us-ascii?Q?7LnsY9XXAPsBVjTGJCIFz93dAjMCnE9Mi8Z69BnE9cJGW3mcFf//SUAtvdpp?=
 =?us-ascii?Q?GGLeo2EKXcYWkdpJgN1XdSQhm9MfbHeqKJCClreslYOUPZtJM/jQ/9p19fnY?=
 =?us-ascii?Q?6gp2XYPGjAvWXihNEhI65o1MUpRmMea6DbLM9LJXfyeEanxjQRhpGEh0zEYZ?=
 =?us-ascii?Q?kmk8UHnKO/4exB2wNfrRAEdURo13p3AtPLlXVfxOL+pNSIFQg1gh9NQDDr5W?=
 =?us-ascii?Q?s8ulJoaCttNUAWCsmMWXeuQYixWh/dh8axWznQfWBnicZYayNh3E66MrZ3oy?=
 =?us-ascii?Q?tQf9UmuEv5vsApE6ZZnbZ9AO4k9IH06RixlT3hTJAx3EHOiNOOda7MQQPhDp?=
 =?us-ascii?Q?m9mABJeMCADM3A8+KNJNqGc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <943D457FCCFD9948985BA144A986EAA8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ad6e59-0dc4-42ab-4a77-08d9dd097b53
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 18:11:44.1886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p32I0PrM5J6AoDPTvLWDTcZKAyWW2C9/3CsN9Whm+r7cybXCSt8fKwlaLPTRaYbJz8mp86WQA0cahymnqdCB5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3498
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10234 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=954 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201210119
X-Proofpoint-ORIG-GUID: SnGYiVSEMzDyzCMu_o9_Ev-Nly1cibvI
X-Proofpoint-GUID: SnGYiVSEMzDyzCMu_o9_Ev-Nly1cibvI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [220117 11:39]:
> On 12/1/21 15:30, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > Changing mmap_region() to use the maple tree state and the advanced
> > maple tree interface allows for a lot less tree walking.
> >=20
> > This change removes the last caller of munmap_vma_range(), so drop this
> > unused function.
> >=20
> > Add vma_expand() to expand a VMA if possible by doing the necessary
> > hugepage check, uprobe_munmap of files, dcache flush, modifications the=
n
> > undoing the detaches, etc.
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  mm/mmap.c | 227 +++++++++++++++++++++++++++++++++++++++++-------------
> >  1 file changed, 175 insertions(+), 52 deletions(-)
> >=20
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index c06c5b850e1e..b0b7e327bf8b 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -496,29 +496,6 @@ static inline struct vm_area_struct *__vma_next(st=
ruct mm_struct *mm,
> >  	return vma->vm_next;
> >  }
> > =20
> > -/*
> > - * munmap_vma_range() - munmap VMAs that overlap a range.
> > - * @mm: The mm struct
> > - * @start: The start of the range.
> > - * @len: The length of the range.
> > - * @pprev: pointer to the pointer that will be set to previous vm_area=
_struct
> > - *
> > - * Find all the vm_area_struct that overlap from @start to
> > - * @end and munmap them.  Set @pprev to the previous vm_area_struct.
> > - *
> > - * Returns: -ENOMEM on munmap failure or 0 on success.
> > - */
> > -static inline int
> > -munmap_vma_range(struct mm_struct *mm, unsigned long start, unsigned l=
ong len,
> > -		 struct vm_area_struct **pprev, struct list_head *uf)
> > -{
> > -	// Needs optimization.
> > -	while (range_has_overlap(mm, start, start + len, pprev))
> > -		if (do_munmap(mm, start, len, uf))
> > -			return -ENOMEM;
> > -	return 0;
> > -}
> > -
> >  static unsigned long count_vma_pages_range(struct mm_struct *mm,
> >  		unsigned long addr, unsigned long end)
> >  {
> > @@ -619,6 +596,101 @@ static void __insert_vm_struct(struct mm_struct *=
mm, struct vm_area_struct *vma)
> >  	mm->map_count++;
> >  }
> > =20
> > +/*
> > + * vma_expand - Expand an existing VMA
> > + * @mas: The maple state
> > + * @vma: The vma to expand
> > + * @start: The start of the vma
> > + * @end: The exclusive end of the vma
> > + */
>=20
> Looks like this, similarly to the brk case, replaces one path calling
> vma_merge->__vma_adjust() with something else. But this one is better
> encapsulated and visible, so less likely to be forgotten in case somethin=
g
> changes. Would be even better if the brk case used it too :) seems like i=
t
> doesn't, at least as of this patch.
>=20
> But it would be great to improve the documentation here - some params are
> not documented, notably 'next', and I would explicitly state which scenar=
ios
> it does cover - i.e. vma_merge() lists 8 scenarios and I assume this can
> handlea subset of those?

Yes, I will add the missing parameters to the documentation.  I will
also add nodes about how this handles expanding vma and may merge next,
but does not handle other scenarios.

> And scenarios not covered could be VM_WARN_ON'd?
> Without such stated assumptions, it's hard/impossible to review both the
> implementation against them and, and the callers against them.

Okay, I'll add some VM_WARN_ON's too.

>=20
> > +inline int vma_expand(struct ma_state *mas, struct vm_area_struct *vma=
,
> > +		      unsigned long start, unsigned long end, pgoff_t pgoff,
> > +		      struct vm_area_struct *next)
> > +{
> > +	struct mm_struct *mm =3D vma->vm_mm;
> > +	struct address_space *mapping =3D NULL;
> > +	struct rb_root_cached *root =3D NULL;
> > +	struct anon_vma *anon_vma =3D vma->anon_vma;
> > +	struct file *file =3D vma->vm_file;
> > +	bool remove_next =3D false;
> > +	int error;
> > +
> > +	if (next && (vma !=3D next) && (end =3D=3D next->vm_end)) {
>=20
> For example here this suggests that a case of 'end > next->vm_end' case i=
s
> not covered? How do I know whether it's intended or a bug?
>=20

Okay, thanks.  I will have a look to see how many I can come up with.=
