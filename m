Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98CA149C172
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 03:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236552AbiAZCs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 21:48:56 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:52488 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236514AbiAZCsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 21:48:54 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PMnMII001977;
        Wed, 26 Jan 2022 02:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=x7MpexBs/fNP06tPwJtqb2E9Y30ao7wEDmUm78n/eD0=;
 b=Rxk+zERKCDNzpu2UyXHJeQ3z9mTzLW/pnzD6AG6xPYc7c2lqdxagD7rHXlD2uRWjfIa7
 EeOpFFmdvgDKxVLfm4JMvjmp+3ERzmhWfWEqY26SmWRSZO5GiTgm7LOrFkFQJrM0kH24
 LF6KSaHhebhSxKiPJ/Z4p8vByHnKDyEfo7M2wGRTzgmL7GmcGLQdreJFWocV6nuYlI4F
 r+7kVTD+xMxCw/PAxeiUtMuJFkZbw2S148y8Xgx1SbqnRzu+5RdJwl25CrF/KlMkDes7
 XQ6I/GAyuKHSjtBZegL+MZTqXTtojX7guO390Wc3mto7s5UYmVqFBK74MKuyObemUpOd eQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dswh9n91u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 02:48:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20Q2kRDK057989;
        Wed, 26 Jan 2022 02:48:29 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by userp3020.oracle.com with ESMTP id 3drbcq7jcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 02:48:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsavkRfDTLvDeuVDSB45VN13/fUXfI5cYEl2Ksq7tcIzKs4PvMZ02LR6CQp93rDtUAfJ+Ed/0OMkdiTPDHvCtSZnWzzWqbnUwClXna6HWCX+cjGeeA9dsloqz2fp38NdGQezmuIvGeqY1AWBq75qCq1uVVbJpmRoUCxyhEEbF8xWm7PjnZuFgIkXWRd6hMd01ni231XaZeY6wGR3dPfgnNhI4WGm43PNPbL5Br5TiU98HCuJKXeBuTTlucR9xtNk7iYRC1FnLmeYHcM3fZJS/RQbiE5RlmHUdbVpoFCdn7mwfAt2x4P2yaVh60Us3/l89awviucz672JI0Y+pse75A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7MpexBs/fNP06tPwJtqb2E9Y30ao7wEDmUm78n/eD0=;
 b=oJAtDvlYT+W+2mju5dj5bRyHU+VfEhsq8J2vyTKRG7eko0dgZ4s1hvJmfXvPOxEXC+Hp0p1zuzyM8ikkCjevYou1Cep6ULNQsLJXZvtahtgQpeq3+S5GX97vQIVD3c7PG8N0UMmnsQNaI4ewwkqAfW5QbkwVo6NlUYycqMI+MHxsXvYVNPLADrc+dPZHs2dibQtxgD1MdiAK6swg+TkftES7pjCkA92vQfMW1cH6n7dgG0i6eUXrRl0/9Gl3oaOTe+FDG0sImt6nRw7/sVv4cjrTnnlhT0z8O1WgliroHSWjnrgbFB4IQkBEXn4rnd5zEzklsacmfBVQ8WhFxuPo8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7MpexBs/fNP06tPwJtqb2E9Y30ao7wEDmUm78n/eD0=;
 b=zZ/+9aXGDOD2AMtbtKYYP2O+KsJ0YlbGW/aV5+NedNHlY7zREf6GZm6WH/yNHBN7zk9ouI3W9vhsFk9zxIc5DH6kEZ+i64Lqz+TWwUYgHvCLkM4cA5/HwTZ/MR4eNQURzMc7o+n/2Is7nyaA75cELxP5daTOkXXASKJs0qUuWGw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MWHPR10MB1694.namprd10.prod.outlook.com (2603:10b6:301:9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 26 Jan
 2022 02:48:26 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4909.019; Wed, 26 Jan 2022
 02:48:26 +0000
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
Subject: Re: [PATCH v4 55/66] mm/mempolicy: Use maple tree iterators instead
 of vma linked list
Thread-Topic: [PATCH v4 55/66] mm/mempolicy: Use maple tree iterators instead
 of vma linked list
Thread-Index: AQHX5r/0Jk+tXlVP4UiIr9o8XNMVtqxsHKmAgAjUMIA=
Date:   Wed, 26 Jan 2022 02:48:26 +0000
Message-ID: <20220126024819.i35wd6uxh463wkps@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-56-Liam.Howlett@oracle.com>
 <10798a7d-e157-03c2-abf4-f005a3507cae@suse.cz>
In-Reply-To: <10798a7d-e157-03c2-abf4-f005a3507cae@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4dd8daf2-ac70-4fb0-4bad-08d9e076539b
x-ms-traffictypediagnostic: MWHPR10MB1694:EE_
x-microsoft-antispam-prvs: <MWHPR10MB16949F0FDBEAF1776D7C74C4FD209@MWHPR10MB1694.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: di6wQNlLveJgQGdhE9cHtqbXe/JS/QzeEq/Ru3ZkJ6+YHt8HRBADgJpsHmwaXNv5q+AcZw6IWLXE+kLGKB14Vlym2rP0v6ZfDlrU+++bkPZA/jseso8y9tLMOyJu3qnB362uy3R0zoygfpA3OtcqB6/rdbJc4/dC4ISbJx9WBb3I/QmPq4SZ+fxqr8K8EjnLBaTo61Vvh6d1VevzgesZdptC0R/JjbIl9Kruoa3pULiDxmF1BT9265hGmnOmN6QNKsH0dE7szRDuOkJFbaNDD0P6BHPS1lkp9TLjEHW3+tMFAQdqNFUuHh126uyDGITmHq7cZP73+F0L8hWOV7Dpic9g/6yv6m9IIAbeNShy5GG/YtN55JXlGAREt8iWShR3Tcb78Lr8qICOWzliN04Q7wPgC/jE6Cnmg8hHtdNH1GM7AVl0TKS2Oyj9Jmc1lg8vlzY7arjJYV2bBoXOpc2CkPW0QeFMh1XzFtNsVHwgSurpizyrIpavB9Zk7LxJu4VLb88rwr7HjWEmoOkbvUm2boPA6ueiFH5FAp1eQMaxyIGQEjYFqtGBHmI4LDQU/58x+35uy/xugOhczTvcPOCTT4IGCwBA1BXjlBD7Btu+I6pc8g2DsXi185GfN6bXZ9J6UO4YUuJXtU/skI1uYX0spH/7tJI1STOFEO78y+0p8hW2kZZrd9wevX868UOFhi3ZakbcHpy4mxbsu+W1JMK62w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(8676002)(76116006)(8936002)(86362001)(7416002)(64756008)(91956017)(54906003)(66476007)(66556008)(44832011)(66446008)(4326008)(1076003)(2906002)(66946007)(508600001)(316002)(122000001)(71200400001)(33716001)(83380400001)(38100700002)(6506007)(53546011)(26005)(38070700005)(6916009)(186003)(6486002)(9686003)(6512007)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R7Ia0d11jW2Rcy7g06CBqwHXZRm6zjkLl6Kw/JVuvM8B2ckLiBQLG84jf8PV?=
 =?us-ascii?Q?pKvsv+jS3jBgejwNAZVt90ZpoUZaif332sQI8SAxrSqMfGep3Rq+1kE+plAe?=
 =?us-ascii?Q?+ZMLAkjt6Dejtg31LkIEze9XsDB7pxOx6Wv5oyFcu1hmbmyGosQjzeNxZqI7?=
 =?us-ascii?Q?p60FoQtlxaj7bA9vd2411YFz0oEGKYYSwBs4IEIQ58DEn9JtcXxgj++VVprk?=
 =?us-ascii?Q?pI6Gq7kVNtM0hGIynwSa8wYf8V40xzLNVInPDY2OpTkhvJovGkVPwX6GzR4J?=
 =?us-ascii?Q?vKBM9t3DUafrmKlp0+SdCAh7Yy3SBlpnrKTr+qRsGQoOtXHBSPoLxcQIcvWc?=
 =?us-ascii?Q?u3w3PYv/miXaSE4SlplWPMNY0hFWE3tgr21Sw1k05hhKGudReKcbq5Nb1XY3?=
 =?us-ascii?Q?ZOb5UCCtxzj09f0e0Qqx4hKzk4Y0kTTu47ar7boTuPji5wKVdmTao4emQJce?=
 =?us-ascii?Q?e/f3fFoUI+IbNckiInB9Nr3jInJocF3IGqhGdA0jD4CNkwoADPjnk9WSQqT5?=
 =?us-ascii?Q?Ql4AVZxtMk/3nrshRr73OOU8FdfwqA64jNYfDOvQFp5pjBjuMw8wwR1txDcQ?=
 =?us-ascii?Q?6xh8jr0RvDB/C+UcH3sQqX4sfeCv8hBMun0cirQj1DCfHVkXTBUIKDg/w6wW?=
 =?us-ascii?Q?iwJ5mCw0AfW0yOynHz4rIbmSeMW9TOitLHx+wbIU1l2EqpalPwQxG72fYwou?=
 =?us-ascii?Q?TNbmwRUag52/1z584DkloaKKF4UgIzN6WG+q9iZuR0VYE0+GwapP+gj9wmst?=
 =?us-ascii?Q?Zj4fZAmIzYi1F2v3xBosjZ/Z23qOzTyTZcQLgPiPXLEQFWnnPL/hN4weCiRG?=
 =?us-ascii?Q?AigKXYoJ7LYNxbB1F1K2fo28Rr6L+4HbOXbITr3eI589wjcbxaV/3hDK/2te?=
 =?us-ascii?Q?Pc1MD3Ht88w9fhrokKNmo5DOheUbo2JTcPpDJfS/SixXkpOh/LDumO4Ngn/W?=
 =?us-ascii?Q?pNOhzlv1yjK6TvTwXqcuP1bjc656W99xJYwu0XNsDpAw5i60u7pIxSYLfSVk?=
 =?us-ascii?Q?OD9JSix/MEpntpn78DBJvGMHLgm/fmbnCqRhSdQHLtzzM+upSvZv4ZRuwDAB?=
 =?us-ascii?Q?IIKAQvkcbPknRmodGxZfMoJIQu9zHsH/+qH+rl7JgY2fgUfUJK6psT1j536p?=
 =?us-ascii?Q?s8gcOXtbrFCFcPzryt/dUWRVfUYyXUJVS/qEK+NZv37QbtCnKvSimsdWuvFN?=
 =?us-ascii?Q?tkPhfnCP6LL+JnshkVMA2gkh0BzWPc0M73/+gWNJ/rz8pvaj+ckBANdOOABJ?=
 =?us-ascii?Q?E7FbZmXeKhnqwx0Ot764Gr/BbfZamlW82ODo6pp0sNFycuhC2S69qt0gIBKy?=
 =?us-ascii?Q?qMqrEbC2Rn4LVOFDiJCplfA4GlVdLTHgavijujpyLcAXgG0LUiJrEUvjRj8O?=
 =?us-ascii?Q?4/8iOlRTDU77jpfNjGREpQR7VF3FKBSLUS4j6lm9d4OKH1LX/YrIMAZJHS5v?=
 =?us-ascii?Q?OUzC9za5hu4GHs3UXvkFlIoqW2cuHKJnVhJQcklvqrG1HW/oQkPJzMmPwCpg?=
 =?us-ascii?Q?NDR7/wyWs7pNxR4axkmH7VvDv4etgyjQAJdvS8xqFZgvFDyt6z/zU+cbqFM1?=
 =?us-ascii?Q?aVyzyNYRZmzrHpOvE8S+meOUCtPGUi4epkTu6ypG9bMvJMlLAynEGPl0EeGe?=
 =?us-ascii?Q?O5Fa/9g3PFW3HO+CCW1eBkA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0C7C9A388E876B488EAAD86F3A3F8E0C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd8daf2-ac70-4fb0-4bad-08d9e076539b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 02:48:26.2147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5tM8xj6SuBhmj1WYJEN/KPahRetpC4NJnhSf4sxokllok5Jk1hFLp59Z4YpUGZq073jTXCA3ksNTlN6NQ8z1TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1694
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260010
X-Proofpoint-ORIG-GUID: J6rxX2vvGhYrHSslbQRxvDIQOLtjpG05
X-Proofpoint-GUID: J6rxX2vvGhYrHSslbQRxvDIQOLtjpG05
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [220120 06:58]:
> On 12/1/21 15:30, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  mm/mempolicy.c | 53 ++++++++++++++++++++++++++------------------------
> >  1 file changed, 28 insertions(+), 25 deletions(-)
> >=20
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 10e9c87260ed..0e2d918f4f30 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -377,9 +377,10 @@ void mpol_rebind_task(struct task_struct *tsk, con=
st nodemask_t *new)
> >  void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new)
> >  {
> >  	struct vm_area_struct *vma;
> > +	MA_STATE(mas, &mm->mm_mt, 0, 0);
>=20
> VMA_ITERATOR?

Yes, I will make this change.  Thanks.

>=20
> > =20
> >  	mmap_write_lock(mm);
> > -	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
> > +	mas_for_each(&mas, vma, ULONG_MAX)
> >  		mpol_rebind_policy(vma->vm_policy, new);
> >  	mmap_write_unlock(mm);
> >  }
> > @@ -652,7 +653,7 @@ static unsigned long change_prot_numa(struct vm_are=
a_struct *vma,
> >  static int queue_pages_test_walk(unsigned long start, unsigned long en=
d,
> >  				struct mm_walk *walk)
> >  {
> > -	struct vm_area_struct *vma =3D walk->vma;
> > +	struct vm_area_struct *next, *vma =3D walk->vma;
> >  	struct queue_pages *qp =3D walk->private;
> >  	unsigned long endvma =3D vma->vm_end;
> >  	unsigned long flags =3D qp->flags;
> > @@ -667,9 +668,10 @@ static int queue_pages_test_walk(unsigned long sta=
rt, unsigned long end,
> >  			/* hole at head side of range */
> >  			return -EFAULT;
> >  	}
> > +	next =3D find_vma(vma->vm_mm, vma->vm_end);
> >  	if (!(flags & MPOL_MF_DISCONTIG_OK) &&
> >  		((vma->vm_end < qp->end) &&
> > -		(!vma->vm_next || vma->vm_end < vma->vm_next->vm_start)))
> > +		(!next || vma->vm_end < next->vm_start)))
> >  		/* hole at middle or tail of range */
> >  		return -EFAULT;
> > =20
> > @@ -783,28 +785,24 @@ static int vma_replace_policy(struct vm_area_stru=
ct *vma,
> >  static int mbind_range(struct mm_struct *mm, unsigned long start,
> >  		       unsigned long end, struct mempolicy *new_pol)
> >  {
> > -	struct vm_area_struct *next;
> > +	MA_STATE(mas, &mm->mm_mt, start - 1, start - 1);
> >  	struct vm_area_struct *prev;
> >  	struct vm_area_struct *vma;
> >  	int err =3D 0;
> >  	pgoff_t pgoff;
> > -	unsigned long vmstart;
> > -	unsigned long vmend;
> > -
> > -	vma =3D find_vma(mm, start);
> > -	VM_BUG_ON(!vma);
> > =20
> > -	prev =3D vma->vm_prev;
> > -	if (start > vma->vm_start)
> > -		prev =3D vma;
> > +	prev =3D mas_find_rev(&mas, 0);
> > +	if (prev && (start < prev->vm_end))
> > +		vma =3D prev;
> > +	else
> > +		vma =3D mas_next(&mas, end - 1);
> > =20
> > -	for (; vma && vma->vm_start < end; prev =3D vma, vma =3D next) {
> > -		next =3D vma->vm_next;
> > -		vmstart =3D max(start, vma->vm_start);
> > -		vmend   =3D min(end, vma->vm_end);
> > +	do {
> > +		unsigned long vmstart =3D max(start, vma->vm_start);
> > +		unsigned long vmend =3D min(end, vma->vm_end);
>=20
> What if vma is null? Shouldn't this rather be a "for (; vma; vma =3D
> mas_next(...)"

We have already found the vma above.  I am re-using the maple state to
save walking the tree.  I will re-add the VM_BUG_ON(!vma), but I think
it's more efficient the way it is.

>=20
> > =20
> >  		if (mpol_equal(vma_policy(vma), new_pol))
> > -			continue;
> > +			goto next;
> > =20
> >  		pgoff =3D vma->vm_pgoff +
> >  			((vmstart - vma->vm_start) >> PAGE_SHIFT);
> > @@ -812,8 +810,8 @@ static int mbind_range(struct mm_struct *mm, unsign=
ed long start,
> >  				 vma->anon_vma, vma->vm_file, pgoff,
> >  				 new_pol, vma->vm_userfaultfd_ctx);
> >  		if (prev) {
> > +			mas_pause(&mas);
> >  			vma =3D prev;
> > -			next =3D vma->vm_next;
> >  			if (mpol_equal(vma_policy(vma), new_pol))
> >  				continue;
> >  			/* vma_merge() joined vma && vma->next, case 8 */
> > @@ -823,19 +821,23 @@ static int mbind_range(struct mm_struct *mm, unsi=
gned long start,
> >  			err =3D split_vma(vma->vm_mm, vma, vmstart, 1);
> >  			if (err)
> >  				goto out;
> > +			mas_pause(&mas);
> >  		}
> >  		if (vma->vm_end !=3D vmend) {
> >  			err =3D split_vma(vma->vm_mm, vma, vmend, 0);
> >  			if (err)
> >  				goto out;
> > +			/* mas_pause() unnecessary as the loop is ending */
> >  		}
> > - replace:
> > +replace:
> >  		err =3D vma_replace_policy(vma, new_pol);
> >  		if (err)
> >  			goto out;
> > -	}
> > +next:
> > +		prev =3D vma;
> > +	} while ((vma =3D mas_next(&mas, end - 1)) !=3D NULL);
> > =20
> > - out:
> > +out:
> >  	return err;
> >  }
> > =20
> > @@ -1053,6 +1055,7 @@ static int migrate_to_node(struct mm_struct *mm, =
int source, int dest,
> >  			   int flags)
> >  {
> >  	nodemask_t nmask;
> > +	struct vm_area_struct *vma;
> >  	LIST_HEAD(pagelist);
> >  	int err =3D 0;
> >  	struct migration_target_control mtc =3D {
> > @@ -1068,8 +1071,9 @@ static int migrate_to_node(struct mm_struct *mm, =
int source, int dest,
> >  	 * need migration.  Between passing in the full user address
> >  	 * space range and MPOL_MF_DISCONTIG_OK, this call can not fail.
> >  	 */
> > +	vma =3D find_vma(mm, 0);
> >  	VM_BUG_ON(!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)));
> > -	queue_pages_range(mm, mm->mmap->vm_start, mm->task_size, &nmask,
> > +	queue_pages_range(mm, vma->vm_start, mm->task_size, &nmask,
> >  			flags | MPOL_MF_DISCONTIG_OK, &pagelist);
> > =20
> >  	if (!list_empty(&pagelist)) {
> > @@ -1198,13 +1202,12 @@ static struct page *new_page(struct page *page,=
 unsigned long start)
> >  {
> >  	struct vm_area_struct *vma;
> >  	unsigned long address;
> > +	MA_STATE(mas, &current->mm->mm_mt, start, start);
> > =20
> > -	vma =3D find_vma(current->mm, start);
> > -	while (vma) {
> > +	mas_for_each(&mas, vma, ULONG_MAX) {
> >  		address =3D page_address_in_vma(page, vma);
> >  		if (address !=3D -EFAULT)
> >  			break;
> > -		vma =3D vma->vm_next;
> >  	}
> > =20
> >  	if (PageHuge(page)) {
> =
