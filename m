Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B3049BE08
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 22:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbiAYVzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 16:55:14 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:30924 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233400AbiAYVyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 16:54:45 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PJFjjC031641;
        Tue, 25 Jan 2022 21:54:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=u9aoLZdB5iW6NScLpq2eyEchn8yXGGg6zPL4iKs+h0c=;
 b=p0T1x86wZ5jthk9IcUBygfuc0YFzQ4VQZn5JokLB48YNOD7RAOOwbW0ppkdO8P8Twhu2
 NL48uU72XBXEYRuKoM6f3zrMAKdZDvgRCQbDNJBIsmhCzNqnlQBzgQjOyBr/Q6uA2B80
 NwYl05nCPNW1ZaAw1mWKsU7sD3bbp8oZk1BpgjqRAV+4U87dxtsAV7M2hbQ6QRb5uDd0
 F/B9JOLEyJwVOgR2wGZIhb1g5VugxegSkbTiniN0tOW2F3nGDfaOZvgi5lWjgbaMLdp7
 dQItulyOdsFk/IQO85kJaFSta2ua5uL8hZkd1imJ4AqyUSAk9aGyZemcJKoru7yYtS+f Pg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy9s4dkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 21:54:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20PLpKiw105524;
        Tue, 25 Jan 2022 21:54:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by aserp3030.oracle.com with ESMTP id 3dr7ygnj8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 21:54:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKAULIpcGVmHsIJxqsnHLvgTI0k4+ClRO1MMnZVMee+atZpbwWgCwj0lw0zNj7a3/UHfw/vQ+SNUQyD8iZ1N2How/LacVD7zkwen1jb1EHkv+drQvND3PPHk2GJM+Jp0RSC7PMdwW6Us4pQQK1rrJZVERkcUeE9GcyHdBwfJ25et+gde2yDnr21i5yIugK//9OdXddxOXDgrhRgMFQ1vH3XR6470/OqyPmNvR/LLGfZnjWUGPokchSY6QKYCJyYGTVwoQrGdbn+ONhQQU9qoD7h0ZT7oQeyENhZ854LG0ie+6GXIgUcsg3CRfu4yZ2/+sGV8z0KU8vEknC0hIcUF6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9aoLZdB5iW6NScLpq2eyEchn8yXGGg6zPL4iKs+h0c=;
 b=XwtoqKUfzIQsAUP3Zrtnizg50jNloe3BQJLtGbhvVBT77zj4M4A/l59R4IhTPTM4T76XwAhqYwDdP/GL87CrB1hhqhL1akxIDKeNGRpjUovzfsFjYPg8V85/eXu+OcEF44eQqjNSxGWbXpqNO0OZyupgJzjBa5ppehbT8erKBq59IHNllf5AJYxLrXRZoKttNR6QUDhh4fo+c7BenIf+zhrs+pHb4RD+GUiMg1bMLNv9QjZLWiY/yIsEFIIoAKGsfxuUPs2qUpBArZmMVJb4t6isqcRpQ/55RaZUERv7qfcy90F4m74CngWQP3b1E/Ov2WkEQNL7+gL0p5V5gt8gYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9aoLZdB5iW6NScLpq2eyEchn8yXGGg6zPL4iKs+h0c=;
 b=mjy5y7C9Csu3ZA+qT3eYnMqda0g9Hcd9t+h4E5QSswfFEzp5CnpvViIW8LThzqS7UqCH7MyP1ikQBJt3TAdIWSjeah3hSneVjIjoMrdzeEbPp2IHqTk7LI+kXNXb4Z62pO5AD/C30ezzDKtwhuc6flnh3K3nzcdcN5d51DYxcVY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB4168.namprd10.prod.outlook.com (2603:10b6:610:79::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Tue, 25 Jan
 2022 21:54:16 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 21:54:16 +0000
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
Subject: Re: [PATCH v4 50/66] mm/gup: Use maple tree navigation instead of
 linked list
Thread-Topic: [PATCH v4 50/66] mm/gup: Use maple tree navigation instead of
 linked list
Thread-Index: AQHX5r/z7rLRvhlZeEK4SCrjVedv1Kxq6XUAgAm1MwA=
Date:   Tue, 25 Jan 2022 21:54:15 +0000
Message-ID: <20220125215408.ltkna5toordacwfk@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-51-Liam.Howlett@oracle.com>
 <d81af37a-0ce7-c226-6ea1-e4ae6a15243b@suse.cz>
In-Reply-To: <d81af37a-0ce7-c226-6ea1-e4ae6a15243b@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0ef0ecd-f0d8-4918-1ae9-08d9e04d3b3e
x-ms-traffictypediagnostic: CH2PR10MB4168:EE_
x-microsoft-antispam-prvs: <CH2PR10MB4168DF2422741AC00CBAF4B2FD5F9@CH2PR10MB4168.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PzxE6SvtVeLXi+kDbNxuealoZ6bY1cpt0+GmGpRs0jI3cC7uJkc1LgvtF695AeLe5ZRm1v6lZ3q3dtmm6pWe/yln7A7casRJodQABqFCOmSchPK+B2ZPZqySUnJa4tP5DxG8h7URV4BVR4vbg/geil9MIfv1PHHO1mNKoLUg9jY5xC62SlBJIyC9x4lCTppLJ0MDA+FYmccWUKyBEV9CVe4YWJ4Ct5hyL/BBeN2/bo6wzVHDIK15+N2Z/nR3Ps+QZlA9cuqs5S0zDJhfDnaArOzcsmYjyFCj/FWsTO37IJ1bixmKVbqnwuK8Dfy4NZYm6tnOlXyS3rT017pEMiRFuiVS26VyEIKOHFt+seOzv+9L5FREXX8PI9pVnP2RTHfWD0ux2S4S3BaQuRGv04U8lxWXreVfcaaT0tHJ0YIcwS0l+8i4Ig9itymRab3AnKg0p8++NGWX5rVOsszE57FzWukYAGjaHh0rt24/hkMOl/vEoFwbrvqu2fRWauOlrnIHXuFULo8z/AQp3DTTzRxJcT1UWO9xJaaPq0a9krXRwlV/4TN39O0KABfG9EegO8m0UTgb98KNC+YD5cxhRQjYiNBoPnDRnrENKTnJPFiwXg49sYuR3SMxHSuHkVBctyxYTw+6vSMyFpbKZunMFZ1nrnLER1rh4kcBvKWtKThFBmUwXr20NBuIX1spx75KMhcVh3zd7ttofZoOMi2jKsVRZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(83380400001)(1076003)(76116006)(66946007)(38100700002)(6916009)(38070700005)(44832011)(6506007)(66446008)(8936002)(33716001)(64756008)(66556008)(66476007)(4326008)(316002)(71200400001)(5660300002)(54906003)(8676002)(186003)(53546011)(508600001)(2906002)(26005)(122000001)(9686003)(7416002)(86362001)(6486002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qSoNDCO/0GPjNnlVV/BE3OCL2XObE7GVtYiAibzDfc28vnNbg9ecsZrXU9cd?=
 =?us-ascii?Q?MLKoxbRVoWhdTrEEOA1U2lGH73DyFNeSwZWOIYOLmaIqs6LkWSZ0eAC/OIo6?=
 =?us-ascii?Q?okM4ELTOMZFJUz/2BYjE81cdvcEu/z6KjOi2NzSl4U0/BThljIWW1U4nFnIj?=
 =?us-ascii?Q?eKWGN+v4sQCsZUEBDPf/8n4C62bMUyACvMaAquyY4A8xwDLGn+4I0OUDdarf?=
 =?us-ascii?Q?pEyRaHIMcwzAj27LY0dAK81njtzR5XSYLBPtmRo8R/I6Mvhw+U/TqzVgFDns?=
 =?us-ascii?Q?twHycMmuyz9hA/XBQwX5/dJRW7hATO5wK2OwZmOPTQy8IfaGnj2X10E5bspx?=
 =?us-ascii?Q?O6i5iDWoMyeMq3HMNFQ+4qHgaNUvE8zSm8VphC5XVeMg4IX9jdb8teQ70sZm?=
 =?us-ascii?Q?SJwJs4DP+MCk8x6e60y2Re5qwpkWmkAsfgYRx7e5OEnOzp7aA/SWSeluRQZo?=
 =?us-ascii?Q?DBtRnYiyaTuQFk0MlswFem52ohsHuiB6GqHeZsF+SHmn918GlfN9hKEMGyXg?=
 =?us-ascii?Q?nt4R8j+a3ykNopoy2wm5F80rUUtXJ0rKUpSXn7hlqrvLary9DjcQgV+oHJt/?=
 =?us-ascii?Q?ia09OiDenkcObEMmf0Hca5wIHIpbBHMymtU1XBc9TEULm/94FJdB6uZ8EoM0?=
 =?us-ascii?Q?E3NQErAVXXBRZvL0284oYsUKk3gx9t47Snwo8gMpvJZtWKeZlRhaPs1b0IEk?=
 =?us-ascii?Q?8/9/yoMnBSefxS1qiOEKJ6f90iR4+t41RhqW5VcVSjyZKuwECCEGS0YDQrXU?=
 =?us-ascii?Q?RIOtAmHSUEi0Nyjlz0DuEh/Fhn0HCE+fq6R6yJo1Zq6k5xu/gUnBFY3NLS1r?=
 =?us-ascii?Q?4V600k+b9smrb1/a/cZvUvmN82GTrYQmf1fmDPrPxYVnWVXGYdJ62arTy4g1?=
 =?us-ascii?Q?3CM2h+ivcKop40r0hoE1aUYYzf9LjUueOAksxR7ZZ7+f8LBqwpsacYcDdmiO?=
 =?us-ascii?Q?lezEgj1InkG8ACItp2Se8LiNmbhdf/nmjkCWd3cREwFiQsTdoQFymEKZ4afD?=
 =?us-ascii?Q?AnJqQDfBUSdynpKdIRRxJowNkrz2pu8qx63lk+Va//y68VhnFIVnOxSImU78?=
 =?us-ascii?Q?fA6pe31aNzgcmBkufIp5eQJ/hZIakbCLi19rtbvQ7Ki8HBrIjJx2MI25ZtGi?=
 =?us-ascii?Q?kY9OW0adsl9i4p5RHY1GGjWlNfmeNzrQ0Q4SxLkQE5j625WfPFxsIx1rQB4o?=
 =?us-ascii?Q?CPynUpt/1Rlnkd0CRHUldcvas32SZqoqZUqvINHAVVKE4T3yOhHQFSiGA8BQ?=
 =?us-ascii?Q?/7uQSY/FUqWyoBGPzKoBl81QITbB7US6VW8KybnIgYRe85eM65RrQQ5ZV8/H?=
 =?us-ascii?Q?BJtKzeqrz+lSVmlEsk+E9tP9ASUSE0BVCtsP6En/q4priwr460NjzDPrXNTs?=
 =?us-ascii?Q?BDvfa5m8to13J1XoILzLEvCpY1KJ1kqzojt0ojHqGdeQjOLfLY3FQUEIGduf?=
 =?us-ascii?Q?oAZBAo+NTM+MHUArOQugQr7tIDoBRYQ/eCaIbzfQy6XvjNu/sO3FrIPhx3Rg?=
 =?us-ascii?Q?xn7TD7NHFqoR2VBdevsJNz94g+DdIEgDmangmW9i3cTttnfsQFfib2pYU6xp?=
 =?us-ascii?Q?WB2fZeEyCIFtjbuEfCNKgCfM0I7eOmVKVH348AO2RWELpZHOQJ+9p3ttxCMG?=
 =?us-ascii?Q?gzlsz5a6d0oBQ/TEGrhifcI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <64BDA7A2556CE9449F266E15879385CF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ef0ecd-f0d8-4918-1ae9-08d9e04d3b3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 21:54:15.9884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gVs+lqzJjlg/UvUCw+HoxgztioDkStzV1NN0PML8c7pnUvJ6FMmyYpkjuHp8VcAKrcLp/lW58AregKqGmlrrMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4168
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201250131
X-Proofpoint-GUID: Lw_j1VrHAys1QW4hUflvakaM0U6CNldo
X-Proofpoint-ORIG-GUID: Lw_j1VrHAys1QW4hUflvakaM0U6CNldo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [220119 12:39]:
> On 12/1/21 15:30, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>=20
> Empty message.
>=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  mm/gup.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 2c51e9748a6a..60892e5df6a2 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -1570,7 +1570,6 @@ int __mm_populate(unsigned long start, unsigned l=
ong len, int ignore_errors)
> >  	long ret =3D 0;
> > =20
> >  	end =3D start + len;
> > -
> >  	for (nstart =3D start; nstart < end; nstart =3D nend) {
> >  		/*
> >  		 * We want to fault in pages for [nstart; end) address range.
> > @@ -1579,10 +1578,10 @@ int __mm_populate(unsigned long start, unsigned=
 long len, int ignore_errors)
> >  		if (!locked) {
> >  			locked =3D 1;
> >  			mmap_read_lock(mm);
> > -			vma =3D find_vma(mm, nstart);
> > +			vma =3D find_vma_intersection(mm, start, end);
>=20
> Is it ok to use start instead of nstart? At least theoretically,
> populate_vma_page_range() called later can reset locked to 0, so !locked
> doesn't guarantee we are in the first iteration?

It is not okay to use start instead of nstart, I will fix this patch.

>=20
> >  		} else if (nstart >=3D vma->vm_end)
> > -			vma =3D vma->vm_next;
> > -		if (!vma || vma->vm_start >=3D end)
> > +			vma =3D find_vma(mm, vma->vm_end);
> > +		if (!vma)
> >  			break;
> >  		/*
> >  		 * Set [nstart; nend) to intersection of desired address
> =
