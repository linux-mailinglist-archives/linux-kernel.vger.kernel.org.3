Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7CC6476056
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 19:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343517AbhLOSKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 13:10:35 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:58932 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245707AbhLOSKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 13:10:31 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BFGB56s013374;
        Wed, 15 Dec 2021 18:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=H0yUZVHtHMsJMtK/f60qqC3OnOEAKt+CfvY9pMKNkH8=;
 b=CERiljlVSxtcid1umQNRnPBPdokbSyu4i8JR4uRYZ2nwD1TW6GIFMNfn7wid6iW94tAI
 qJ5LxWtdbNcBdndBkpTr36TxjD8YRZpuZWm5kgc4gEjltWRP4CHNzAhB+fia3YsWh4bD
 H8hKIvreRqo4gy45lqyW+wF0l9jAG8M3YiJiE2mizFvG6Fzdf+wBLP1ptdgQpeGjpIH4
 io6RDL17UVXU70wvrfe1EjtVTkeXKXk1Rzdged/sMiRagc3xCe9kUpxn+CYXGJ6k7Xko
 JiMa6sEQfSe3YlIoG6yHHku5JCmNOCMEiQM67u8zhj3ziY8ZdJaWLpP9DrwdG2lgmN1g 8Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cyknp0daf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 18:09:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BFHuXLU163164;
        Wed, 15 Dec 2021 18:09:47 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by aserp3020.oracle.com with ESMTP id 3cxmrc74p4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 18:09:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnvoTBHX7rkjVGVVzlsvTRF+5V12WCiUZ9pTCJWMU0rNyY8/xCeXxz9CAD7tzNEsN/Xl2C2L+DAgFJk2q/K6N/6pCqCnfmwz5ppS/sCxQ2h1O5j6zpRGelm41b/KeTAHAkcRagYClCedMCie3C+7nRFxW/QOc8vgJslU0cJUQCYQj/9WoS5M3gQoMPnFEJXnH8g24YzX1o4aEjo3rVoTweYU6Xf18PY2UBygPZLNhw/V6zzfcsZ4MZQ5+MSUYcARqWKIog2t2xd9Fwph0KK0CReZeVUeo0SCLgmA1Cw+OSjgblEBORSNtxJC1QIIBOysWG+uEIbFvMpZadMk2dTDlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0yUZVHtHMsJMtK/f60qqC3OnOEAKt+CfvY9pMKNkH8=;
 b=lP8mowKk30ZfhYaVP78PHI5TPvnHrpY5Oh4GQTe1e3gkEKTJz8z6kYnAdUq0oLB/PNKkVAvfKng46IyS1WzXHbwA5R+OZpoSh4D5izHOdckENRi5hhv7hzN3mgg2WJ0W4rGrXmHp3Yh524LAGrJJWxNyeDAp4iyNWS5ioQvrtucQweU8Kj4vWsfrVTT96CerLOJGHXZNFTIi306JkqCWJFj8di7yKxJUq9v+Mb5H7XvMxIz2z7HCNga5UzQvO/kki5eGVYPJpnDJE68VsL3YAIJELyU90K5xP+N3gzdFB6jAxGBeu8NalYhP6rwPBFEdX9Y11P6iRoutuLDhUMd9RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0yUZVHtHMsJMtK/f60qqC3OnOEAKt+CfvY9pMKNkH8=;
 b=nw757ndfAiscLtvBBiKZ8pmPMeEUNQXAkI7gR2R3bkkWdyY9275ixvT0M+O/d3Qp/vBZxkNP3zuSi5CmtSeAIYGrGao3DtVPjYJdhRnDi27IAZnBsgSw6WNVmV8CrdL10n9FZDD4mTl9sQDed3eA4tTgasPaKOUaNLS0MlVxj4Q=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN4PR10MB5624.namprd10.prod.outlook.com (2603:10b6:806:20b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Wed, 15 Dec
 2021 18:09:45 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 18:09:45 +0000
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
Subject: Re: [PATCH v4 09/66] mm/mmap: Use the maple tree in find_vma()
 instead of the rbtree.
Thread-Topic: [PATCH v4 09/66] mm/mmap: Use the maple tree in find_vma()
 instead of the rbtree.
Thread-Index: AQHX5r/nx3yUoeR2AEiEqkmElp8OPqwzm1EAgABVDAA=
Date:   Wed, 15 Dec 2021 18:09:45 +0000
Message-ID: <20211215180903.huv74nff62lgepsa@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-10-Liam.Howlett@oracle.com>
 <4207b5a3-efac-40f3-6b42-6713c9283cdd@suse.cz>
In-Reply-To: <4207b5a3-efac-40f3-6b42-6713c9283cdd@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1eeff53f-05f8-4b1d-3260-08d9bff61305
x-ms-traffictypediagnostic: SN4PR10MB5624:EE_
x-microsoft-antispam-prvs: <SN4PR10MB5624AE5D7092E663FDEFF2D2FD769@SN4PR10MB5624.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OLzZNlYNd+Fe3d0ec0NACNZdzRGOFW1myd8YhomFVBMbW8Q4bF0LnmRIDWOtlHphZ9gm8rNzOZnCr3PWJ1viYoJ+nzPlrXCNg0Afi4rMa6U90kTy43KmIDZyZhGAJ1N7T5u4v0ba/0Jew98W9AfcVfhyPe+eH/+8A1L1xgG5844LMD3+intB9hXlJOtFsJh4nbwc1mdDcnAil6BoTCGiKPqx9Q8vH413yjeAOF0MQShDkm3JFlAbs/hEG1vq15dY4lKK8Ef6RjZh47X9gcYJ7djbNAI+KGUMVaJhBYxNYquI6/aOy5WyhGN7eAdxT7uSIuDFS7HAvGzKbxxV5WnRbM82Wt4DOTute3+WlJLAR5hZDuLmdUqgbqZOYFScd1oC34914325X0jqcyyUhHIItmfWzYc21jCLMe+bAenXwwOcB4dG04qAntamoSh0gaI3uOmufDTm2WLEcKchLmZppDtM8X1j/EHJDg3KOWv6bA0a7bGUE8Q9F9kg5K3ylAf7zLdFEln2ui2iv4h2VEGhY9XbmStv2YFPEuIPykOMoUe+jOikd1ROIqBRcO2vcWLaHh2MDw0DjQ8ggxzJ3PvsQGfFGywQiaeenTmpZDUlpz+vAE+QeK7i8RziUWSp8SjEh9f8bjpe9DONDbT8m5BKbQ1uyMTcZInTUDVJok8OCZ3Mn45TrJ+tibYVlLgh+PvyDsXu9xva4d02hKiVvUj+8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(1076003)(2906002)(4326008)(8676002)(44832011)(26005)(186003)(5660300002)(38100700002)(54906003)(71200400001)(53546011)(8936002)(6916009)(6506007)(38070700005)(9686003)(86362001)(316002)(122000001)(6486002)(6512007)(83380400001)(7416002)(64756008)(66946007)(66556008)(508600001)(76116006)(91956017)(66446008)(66476007)(33716001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vu2dsQkiexxqQ7flP26wQJVe4OQty70LdceBipOc2i+P0ZVH9xT+wSAv7i1t?=
 =?us-ascii?Q?BiWpsIJ9J8kfXAxfAqrckIK2tkGDGrkHIi2qrIjg4I/STYopgIEGIHrSPp8k?=
 =?us-ascii?Q?09bY3G5TZ+KFShw4hK6ulFoEnoh07hvaMoU19ZwGtEIccUNlXKX3yueE1nbo?=
 =?us-ascii?Q?34Dc+u4lXWu9CzBKeNYMN/HLPjK9Xv/xROFT1rjmanhKcSO5loxV3/kEoyPZ?=
 =?us-ascii?Q?5x2Dfbpvbj9+bVHqzoT18qNaXe3uAcxcNOhCB0Ck5qumf61Tsl+vWquRXAqx?=
 =?us-ascii?Q?l0mgvwipHXKzHt5awbpwPjb2SqjwI4QlSGDUn9wnPU96E37nnFhGs8tZj8lv?=
 =?us-ascii?Q?o9GNYN2/3khwvPeyQHuUC3HC8huVDJoBkoQjDyBwfr48AdUUPX7ijXJfoal+?=
 =?us-ascii?Q?pcVMfeF2jmgTMwT3kXFnN9UIvoVGwHobNs5n5lskphfQsyhhhcverobVV460?=
 =?us-ascii?Q?935aD3t/VXUrhJTPuCESmRAIJh32JLPAR1estguqi+okA8fVdR79bgN4MtUz?=
 =?us-ascii?Q?fS9oX4LKqWn3tuLtR0D/xec587Tm1s/NUShEmjGOXHUGnrQT1acwmM2GQjmt?=
 =?us-ascii?Q?opslvwPHcSrvp0QR/pmrsd5MofEbIrnu23zEp6tTnROwxgEiprIZ+9+z5OVE?=
 =?us-ascii?Q?fdWPteyfvhtzoWOhTrUnlKzXPkGB2JNcqE/ulgj4/w1IFC4gEtvp+3c75P46?=
 =?us-ascii?Q?4/YS9ZY7vnZItjWeTjX8lTl2/PuHO8jpb/SZBtHx3GkdqIuqIF0rSLWNMKOA?=
 =?us-ascii?Q?E8sX315VDDPfHexTHU4ML1YTZLWH/Kq1GEmbV9BvOXmPz7dvTrCCqmQA6FPQ?=
 =?us-ascii?Q?geOjU4dVZTTUvaI1V78MEUl1sJpNUuf+UtPVdF/HPS1LopeSJEkJSkmgti6N?=
 =?us-ascii?Q?INZ64o0giKgBhdyXsPvt7qhw1oZLbXBwQW248dCjb6SvrlGoYH7LYTuC0Eeq?=
 =?us-ascii?Q?TOb7icQZFumbTQy6p7T3+/AUZHsM/G2w5IV8V8+IFWjPB7h+aufwCi/xQPHF?=
 =?us-ascii?Q?w7jvIvAjHLpTS2azKv2PosYOf/zao/nvpK9KY288xT82dlj3nz4rG0wV0KlR?=
 =?us-ascii?Q?oeqiYGMTc9uewRlPqFmhv4eFWrLG9U32fB0PtQCAXA0e7ahS+KukvPSBTmiI?=
 =?us-ascii?Q?DKuSyMmWPPT7jb0GVOHJb9cYzP6gSTWekf8sJdFnLBpn04w6UgkEmtPPiFXj?=
 =?us-ascii?Q?X3Uyet4dQyXPOvxOK39y2O+wC19DSmEu86lkNk2sqOTSkELHjfYHPsJ7/KmL?=
 =?us-ascii?Q?lL/rM7+2P3MBdkHXr/CyLdWDsRk4lVvJ4VuPRU3l7zBcLHI+lqisyp296vMD?=
 =?us-ascii?Q?WK2FX3maLtRCpfbo9B5sRN+lvmb9epcWXDaTenbpVlHt8NHRWLdgEnh6pRaf?=
 =?us-ascii?Q?IC7spT6ykpESuYGCKttRarEhN/Fth2aSFIJZqTdbSwZT1ffmCJMS3rdJd2/3?=
 =?us-ascii?Q?eqDvp0vU2NK9CRtTFao0bjIVhoxOiyejMGlVRGfNxFzzSrwODCGoTHre5HJL?=
 =?us-ascii?Q?eIsI7Bi/XnAgCX96suEqnDZE8H1l6SEuddwkKF8idh83k7GHEALi9efZK91V?=
 =?us-ascii?Q?sGByRd8ZvF5Byu0l0EeoaoCE+M4jJSEsYwLs1X26Ldncgz2PRBwwG0rszisu?=
 =?us-ascii?Q?3o7YlIfMLmfasnqN+lXDx8c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D8E4514EA2FDF5499F860170108692B3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eeff53f-05f8-4b1d-3260-08d9bff61305
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2021 18:09:45.0666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3IgqdWLh9UHyC74AmuT60Z4Pp43Rnyv1rIA6CItIxFSE4BBHN5HLSdpf/VFrvWgglFiTX0+LpvxswNFomvkqTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5624
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10199 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112150101
X-Proofpoint-ORIG-GUID: ckKu2SqBoCzXgeYEZCatBJFuB9tUOtPU
X-Proofpoint-GUID: ckKu2SqBoCzXgeYEZCatBJFuB9tUOtPU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [211215 08:05]:
> On 12/1/21 15:29, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > Using the maple tree interface mt_find() will handle the RCU locking an=
d
> > will start searching at the address up to the limit, ULONG_MAX in this
> > case.
> >=20
> > Add kernel documentation to this API.
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>=20
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>=20
> Note below:
>=20
> > ---
> >  mm/mmap.c | 27 +++++++++------------------
> >  1 file changed, 9 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index de78fc0ce809..6a7502f74190 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2429,10 +2429,16 @@ get_unmapped_area(struct file *file, unsigned l=
ong addr, unsigned long len,
> > =20
> >  EXPORT_SYMBOL(get_unmapped_area);
> > =20
> > -/* Look up the first VMA which satisfies  addr < vm_end,  NULL if none=
. */
> > +/**
> > + * find_vma() - Find the VMA for a given address, or the next vma.
> > + * @mm: The mm_struct to check
> > + * @addr: The address
> > + *
> > + * Returns: The VMA associated with addr, or the next vma.
> > + * May return %NULL in the case of no vma at addr or above.
> > + */
> >  struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long ad=
dr)
> >  {
> > -	struct rb_node *rb_node;
> >  	struct vm_area_struct *vma;
> > =20
> >  	mmap_assert_locked(mm);
> > @@ -2441,22 +2447,7 @@ struct vm_area_struct *find_vma(struct mm_struct=
 *mm, unsigned long addr)
> >  	if (likely(vma))
> >  		return vma;
> > =20
> > -	rb_node =3D mm->mm_rb.rb_node;
> > -
> > -	while (rb_node) {
> > -		struct vm_area_struct *tmp;
> > -
> > -		tmp =3D rb_entry(rb_node, struct vm_area_struct, vm_rb);
> > -
> > -		if (tmp->vm_end > addr) {
> > -			vma =3D tmp;
> > -			if (tmp->vm_start <=3D addr)
> > -				break;
> > -			rb_node =3D rb_node->rb_left;
> > -		} else
> > -			rb_node =3D rb_node->rb_right;
> > -	}
> > -
> > +	vma =3D mt_find(&mm->mm_mt, &addr, ULONG_MAX);
>=20
> This updates addr to the end of vma->vm_end.
>=20
> >  	if (vma)
> >  		vmacache_update(addr, vma);
>=20
> And here vmacache is updated with the updated addr, which wasn't done
> before. This AFAIU has two consequences:
>=20
> - the original addr will not be cached, so this whole vma lookup will not=
 be
> cached and will always resort to maple tree search. Possibly affecting an=
y
> measurements you made. Especially the vmacache removal later in the serie=
s
> might now look like it makes not much of a performance difference - but
> vmcache is effectively dysfunctional.
>=20
> - the future lookup of address vma->vm_end will return this vma, although
> the address doesn't belong to it. Wouldn't be surprised if this caused
> infrequent mysterious bugs?
>=20
> Both will resolve with vmacache removal later, but better still fix this.

This is certainly worth fixing.  I am surprised that I did not hit a
random bug as you said above, I would expect it to occur as well.
Although, I didn't run each patch individually for long unless I was
tracking down an issue on a rebase.

As for the performance, I will retest the performance for the vmacache
included and excluded but since the overall performance of the patch set
is still valid, I don't expect a change here.

This is a really good catch, thanks.
Liam=
