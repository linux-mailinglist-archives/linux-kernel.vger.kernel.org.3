Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12AB149B908
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379288AbiAYQoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:44:06 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:3574 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1584388AbiAYQiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:38:50 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PGc4DD015042;
        Tue, 25 Jan 2022 16:38:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=eK2FwE6qA7Esx0NHAXl49pwIpyore7p5bTlG1DMTujQ=;
 b=O6msnVk8jyW7CPR3e1p0lmuj1am04gGKF4+yuWjkRY4c3guLSY2f/A8Q/V83D+f5chzU
 oQ9kaoXiheAOIlPG6n2drb5VKe1+gfOB8wbFfCJdRPuyfESAHL1iPogv2jbSl84Zo4dY
 YQ1zSq4QtuALlPcIZ0nXNqrSgs50cmyzBoHxifoYVtTeIQBbsuEShzKq6oD8NEDWmhyB
 Hl3IQRvRP/sgIhBMXmUKdMzWkiJd+5ZAvApbtDQ4lbYASgLUkJQElxsL9WyzFwrscTvD
 W0SNCm1Iwq7/TSpAaWfBs7Oiggckj3lEfghqjn/rEOia2emZ5vXnvY2Yp/HWod9Pk4f3 ug== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsxaabnc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 16:38:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20PGR5ac190046;
        Tue, 25 Jan 2022 16:38:24 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by aserp3020.oracle.com with ESMTP id 3dtax6u84f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 16:38:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drZbgdCdbwvRXiyyAM3C8FdiSYDOTq1W93CFHnNcmDyZoDb9KJvvF40r1OZ+2klocZ/UoBn8aodO0OztVYNAQpf8mfO225/N+nB3RFaKCPyTmuRX/5212JjwodDMUxCkct6KVakh6/y1Fth/QD2psf29QV3UBuWUWrnKlawAWm+aCGxbave97ofVD3ZE3o9WdAr8979guF7z8eJLy0mKAaUah9Pwbf1rPtYXYZ2ptt2QMozRQxccU/k8IkUyoFTErFW4zxt1x03h9GB5FFisJpOFqJtj1OPQ0byqYAOZYglrXFKJQLii9zuWgZ/p4EBSY9OkVPaoD1O/phv5vA2r+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eK2FwE6qA7Esx0NHAXl49pwIpyore7p5bTlG1DMTujQ=;
 b=UcT64uPHRXcT8ng2QUIV1n19Uo7Yj3R4FYs8KnHDa0D/f+wb8H+rpGyvBOT0rJb91dAypxcUx7++DICbgRg+6228EQUke2maDPpDE8kRc9ZWZ/41qTQkeSiRqs2Ik/wnVNRq/PXsomgvQnpKbldI1DADT9qyc2LcNbU/OdNqCaWOUwShJdt9Kx1FnammQrRbiECPJ7GvqCDcFQs7fGKTZddAf/AuDLrQ1l3xPphOKrPzPs1dk/agkwCPCK966dbjU2Y2M19+K4RvcmrMeaBctOnX8Aco9NDlE4EmOTWG6zrI4g7eSxeQ1l9cTERJ7RV2dajSiNb9fOsctT/tvCCpTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eK2FwE6qA7Esx0NHAXl49pwIpyore7p5bTlG1DMTujQ=;
 b=kz/RAxAP7mlonM6OU/+JFSYK3XdsIwYzd3Ns7zUuqYsyYmME8gKH539r6HJUqg3Pv4bMOKsDskjEmexiN7YxlEQD+rn3OoLn4mNM/28mHFVeA4wbK1x5Ie3vfk8cJCWkJelf0dEjU30khzhDRwAhLUT19Nc6nAsmaUqNdvD0yA8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5385.namprd10.prod.outlook.com (2603:10b6:610:c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Tue, 25 Jan
 2022 16:38:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 16:38:22 +0000
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
Subject: Re: [PATCH v4 36/66] um: Remove vma linked list walk
Thread-Topic: [PATCH v4 36/66] um: Remove vma linked list walk
Thread-Index: AQHX5r/wXumaXL5xo0uEf4D3pnIFRKxpaGUAgAreBwA=
Date:   Tue, 25 Jan 2022 16:38:22 +0000
Message-ID: <20220125163806.bhepto3ccl4xnqef@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-37-Liam.Howlett@oracle.com>
 <c7801c49-1eef-6363-079e-a810d4125e84@suse.cz>
In-Reply-To: <c7801c49-1eef-6363-079e-a810d4125e84@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1328881-0db3-43d5-446c-08d9e02119d2
x-ms-traffictypediagnostic: CH0PR10MB5385:EE_
x-microsoft-antispam-prvs: <CH0PR10MB53856ECCDE001369CBC9CC09FD5F9@CH0PR10MB5385.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DMnrcSWHFHRjQKxS1afOgcI/3eAK4aqxMx+72bpfNn5eDjskfK5+G8KdXTs1kDkTkpO3LkkDZM/YaTnwMx/g/GF+7fY5m7ZmmgpoJUBvgUGivwS289sk06+WwncXO2rveG4gr08mSR8VqjH+/ErrvdJm556kop5lIoAIOLCO9b/NZR/U2+6O71vjTfck+sxP4BxhEgsEDfQcd3jpS+UAxfJ41ZOXN5M9K5V5uL83S+8D5magbBxiaEEwZhr+syONOSjvF1//DH0pDA84gkmteQCe7dfz+eIETeBQgP/dDgkoRFSQzYimzFEzCoEZazcHrtTjYuKRrCmkgRczF8FCyBek5BZwDJM9zhYZcw10m7CXx0VA3MndCz1HFF6VQ4/ZoPMWaiAp1ZWlOsVLk590dZ4KxzVjrXALMRLJIlVSMShizwPxomneVlvbflZwjVU9Cq2/XCfhC+KWRh3+2OPhlEEuuYx7XSeGqMp4NI346O56pXAI8U4Epm2JWGTs8o6XmGgyl7k5NaAQC/u3aS2TEcZ6WjVEr6ke0ohWhYsDcrNw/p1ouorHa94QeJUrmQ1IPKxM9ZM94vxqPeSgGpzCLA6cnTiXoO9HF6vZV65WjtEisJGE/j/gfH9KuYBO3EmxCu/i+wU39OoACW9ral6ZPk/JSywLm+pj4YC3BvPKTqT1fvJDWZqk8AQZt3gYR8UQTbdMuEh2yavxiHcGU6KiWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(33716001)(8936002)(64756008)(83380400001)(26005)(54906003)(66556008)(9686003)(186003)(7416002)(4326008)(53546011)(1076003)(316002)(38070700005)(6916009)(66476007)(6506007)(122000001)(2906002)(38100700002)(6512007)(5660300002)(71200400001)(8676002)(86362001)(508600001)(76116006)(44832011)(91956017)(6486002)(66946007)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GzH78Qc7H3p+BBNpDhXvTrRdQAa2LpgSMwa4ErZxyZfN+j8BHNeimsn4IYzj?=
 =?us-ascii?Q?DG04dnsjkY3/uo4WT98HNuM3PQXDXPRxQiUAHWkwGRgyE+K54THoZGZwqkxr?=
 =?us-ascii?Q?/kzvZenFCO6OOLeNK3fd1frP/HlQGLINN1o+61uvv6RXsCkiQYOhK/x2GA7X?=
 =?us-ascii?Q?ES5weJ85S4BTcYi5epv1XMFmtTIhKf2QAPU6rQsEeKJY2ocx5Z7K86pyJLW5?=
 =?us-ascii?Q?x7pO2xBdoxJqFS/xBnVAy6eQ4hmAznrwSSRSoDQq0Le1YbzLxCW9LfKtnCP1?=
 =?us-ascii?Q?9JWhe5TIP+11yM3wh3AHgp5HMKP5MOg/McpeIHMK+afXbH+HfmTaihKe/Gom?=
 =?us-ascii?Q?U4AMG4gJfGlzpV4WC/oM845Turyafl4sKVrL8fw/e0L/oWLIBqnqfyuETKf6?=
 =?us-ascii?Q?EtOou7s6Yp99gd3OOKU/hGIph1YOiNqs3/6loYYTJTk3tOE8mwv4o0PQ0ig0?=
 =?us-ascii?Q?C+OrsQfKT2R2r19vojkGr3RXZUfEXJ3odM1hYxnDxtsKXpQTEXX/xxhyKv/F?=
 =?us-ascii?Q?ABMsqTo4tsU8TCJHFKvEcG8UkljieFNW3MDgG8ZXsRI42TI8tjbPWcwaCtBu?=
 =?us-ascii?Q?toItK8KZrqA/TAPsLGzzjzNMVDAbTNh9YGy+qjSY6TUNtz6h6gtMTVn3WRTo?=
 =?us-ascii?Q?9segpPHQxmzQzr8FjNHa80dxhDmFjmqVspRlamVzv1nZJRTiqnWxOZm2/EDi?=
 =?us-ascii?Q?0LSqzo9rFUSFNUwR1DaVDk7W0ZflIKhlRVNy1AHNsTbchSikWdDd/4lscQ3U?=
 =?us-ascii?Q?aK5IuH7Vpj2hSEadlC6TwFA+erd4qt0A18cwAdFUJQ9htTCtN5VlOdjbS70I?=
 =?us-ascii?Q?h5gpw20f4YRJb66e22ZK+gM3rwVqzC045A6g2X6XvW4D8qsbvAXW7m+yHZ5v?=
 =?us-ascii?Q?RhcVhdtit4KtyIuJ2K6qLQryFSuL3BpNk8JMO42rm9JZZZZ8iv+z5+GJiH+P?=
 =?us-ascii?Q?K6cD5FzAEfhqcF5erz16Qw3bXL1YFty5EY/YSDjQF3/NVZESZtUz9bEzNa4H?=
 =?us-ascii?Q?GM3mlt7clnYzuWUuwsteLgfXe+96IY9Zr9k6odKuKsfKcb2m97j4ou8wtv0r?=
 =?us-ascii?Q?On0A0hpQ9riDJ5EiLU2jSO4w+FSrug65YzSGirbougS4jymxkRcYvoPXQtzK?=
 =?us-ascii?Q?RgjQjjY6Ckml1APRqbg+BXVTCpiHe8ALkcSidB8xBO8n8HMA4bpjNJTsnDON?=
 =?us-ascii?Q?CDUwNd/2Qq2u18Wi710Fd5cXnm9Jzk1/ld/nqvYfqE3m0NNJJajH7wLsLCYp?=
 =?us-ascii?Q?/S1dpUIzL0qMd67ON9wYvPjqwzrZZf9rsuatIxGQAUcqHWgl0TQt5e9GRnLh?=
 =?us-ascii?Q?dKpDxiQ2WI54aDPoxBuPgB4XgKJBzf/Ji/jsL1NwZhDPqPKhSaAF7k/fWMVB?=
 =?us-ascii?Q?J9fgMzQ4qr5HMFRL8f+cUSJ1cUCQL2yHHyiViOq0ImDPRDVJRSEvsetz+fEY?=
 =?us-ascii?Q?LYVqsmbrjO+HPXXuRO0heT8AUcgQKmx6QCe7gy0/IKaMJZxvVJsayaG+evE3?=
 =?us-ascii?Q?l5ksbaucbUtwMDWhlp+g/ZG8Shn64D6rzMRL1xqd3dPMMoZWGuG5iVthwqXq?=
 =?us-ascii?Q?0QOx4Tp/nJ1Dwimx435xvuU4ye3Qg/uqXagannmwcHdWFNFzpozX+eb5sHZS?=
 =?us-ascii?Q?WDDtVtwtGZfyYxrXRv7QJFE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C79A0189F894C942B5E1A7027ABF1873@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1328881-0db3-43d5-446c-08d9e02119d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 16:38:22.0763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /8uEDQYqCoXuisJUzli8UnACU6aDVNOKlIqC70OZJcONpus2J6+rsb+Acn5e1ocswMDkHMTw+Sw0jx5rDVRwkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5385
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201250105
X-Proofpoint-GUID: h3b8IX3Rd3xaTKb_tvqPD1pehE9X-k_O
X-Proofpoint-ORIG-GUID: h3b8IX3Rd3xaTKb_tvqPD1pehE9X-k_O
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [220118 13:41]:
> On 12/1/21 15:30, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > Use the VMA iterator instead.
> >=20
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  arch/um/kernel/tlb.c | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
> > index bc38f79ca3a3..25f043037d76 100644
> > --- a/arch/um/kernel/tlb.c
> > +++ b/arch/um/kernel/tlb.c
> > @@ -584,21 +584,19 @@ void flush_tlb_mm_range(struct mm_struct *mm, uns=
igned long start,
> > =20
> >  void flush_tlb_mm(struct mm_struct *mm)
> >  {
> > -	struct vm_area_struct *vma =3D mm->mmap;
> > +	struct vm_area_struct *vma;
> > +	VMA_ITERATOR(vmi, mm, 0);
> > =20
> > -	while (vma !=3D NULL) {
> > +	for_each_vma(vmi, vma)
> >  		fix_range(mm, vma->vm_start, vma->vm_end, 0);
> > -		vma =3D vma->vm_next;
> > -	}
> >  }
> > =20
> >  void force_flush_all(void)
> >  {
> >  	struct mm_struct *mm =3D current->mm;
> > -	struct vm_area_struct *vma =3D mm->mmap;
> > +	struct vm_area_struct *vma;
> > +	MA_STATE(mas, &mm->mm_mt, 0, 0);
> > =20
> > -	while (vma !=3D NULL) {
> > +	mas_for_each(&mas, vma, ULONG_MAX)
>=20
> Is there a reason to use the iterator in one case and mas_for_each in the=
 other?

No, I will changed the second one to the vma iterator.  Thanks.

>=20
> >  		fix_range(mm, vma->vm_start, vma->vm_end, 1);
> > -		vma =3D vma->vm_next;
> > -	}
> >  }
> =
