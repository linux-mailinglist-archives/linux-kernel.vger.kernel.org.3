Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2AB649C155
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 03:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbiAZC35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 21:29:57 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:25052 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236373AbiAZC34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 21:29:56 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PMnBQa019815;
        Wed, 26 Jan 2022 02:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=J8FebE3jFTzMCoGs6LvxI7DpuzlnbC9pxQZfsTBkf5Q=;
 b=FvnTQwJiSiTD3pVY6Oi9CxA2bWBa9r/zvwyRoylRdJF02GPn8n/y76KPEaH6gS7h0wP2
 4SrkTaoQf6U5lqL7ZIj17QJfMFGXDyPezyWhC9pGZSGNYMBy9bbELZ4+1P6DX84gVOeG
 2c6HjArFehkpXfKgEJoIL1nDdrjL2JdeXf79J1pIvhOSugQIorYC1jkSlntQxp+sNZ0i
 gx3USMfYnBvuMyQWGwuGxac5+MGHjx30ex3hf0dp85ei5HhO4CFzs9A9X/cAWci+VhXb
 4f1aR1bnfdfiFRJvHEClglOOJ4+dFcp4Ja2cqL3ONUn6wjZgdV5DUBO1+6L17+iQqPv3 lQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy7aw1u6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 02:29:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20Q2GkB2066300;
        Wed, 26 Jan 2022 02:29:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by aserp3020.oracle.com with ESMTP id 3dtax7mjvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 02:29:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuqEvHnnYCbYvuFo9sPMTBIJtf05unqlLuNe7poADZ7gRlasHvN2vqvzk7VRAywuuRCV5xiCUfFjGbWytl/dZCAPoRyDjyAVXj5gzIiDGs4ZIMZLNnpRdosw3cJcNmiuYth5q7/PZ0tMn5AQaC868qPxIeJvlQ5GIb/Jy7RBPI/pE45m0Tl5uMhVD3GB4iTQ6XavkDiaCH35A8Ck6DqmrHNIoh3x1Btvykm/6wE9ALCxbjwO+SABZnshJFMAl62lWGyhDVuCNC2wrAO2Fc9KlERPq8iinL0+VyKjG5TKOJ11dzLXFhKn4MJS84597fqLzPMbzdg4tNT0cMZAnLrlFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8FebE3jFTzMCoGs6LvxI7DpuzlnbC9pxQZfsTBkf5Q=;
 b=To2TjoGdQiduygsn/693oCHluV8lHT2Fe5QycCCmrWgT7qULpP5nRWWhklsayzM3pVNuPh0yUyGZCTqeqSiOeUSTBdRgZpmvaenAF+bfTYf+fe6h1JfrIxCEyiUXioQ8WthTp0zsYszgXAd/kNkztghT/awmQizIrzVkCylhlL9ddkt1VnBEJ0KSzMfFaY55XJl7RRxnnz+KsSIL7nL62ROJHbO2rOdcobI7r+IjIpzVOlpLEQhTxsgAFH6ZwCoZDH9eZHF5fC11C5KmA4ZKRjhRilPvCC7LawnxBfKhXudhjTkWZ1TzcIZOIeOKCtfiTxrwsVuFvidY9NGYh6XzFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8FebE3jFTzMCoGs6LvxI7DpuzlnbC9pxQZfsTBkf5Q=;
 b=J1wz/ekyI/dgx+Ky+25rAyBnw2zq0wDMkEne54SryTatVZZtvMH/Q0DAMdPCOyLbFX3mjx+HwDu/jUUV/BeuyeGhKAfAHF4/eHfCEe8WqUNVvcAeVx//NDpBx3jZV2puls78iyy2uX7EnGP7uWoPmYEnoz/SO+rlFF94xvBeBa8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 02:29:25 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4909.019; Wed, 26 Jan 2022
 02:29:25 +0000
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
Subject: Re: [PATCH v4 52/66] mm/ksm: Use maple tree iterators instead of vma
 linked list
Thread-Topic: [PATCH v4 52/66] mm/ksm: Use maple tree iterators instead of vma
 linked list
Thread-Index: AQHX5r/0oKsiVYoWv0SiYWzYqFoOkqxq7vEAgAn8mYA=
Date:   Wed, 26 Jan 2022 02:29:25 +0000
Message-ID: <20220126022919.cgf547sxd35kxdml@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-53-Liam.Howlett@oracle.com>
 <5dfd4ff3-082f-5621-01b0-cf789eff8835@suse.cz>
In-Reply-To: <5dfd4ff3-082f-5621-01b0-cf789eff8835@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41c1f298-2b88-48c9-1805-08d9e073abd3
x-ms-traffictypediagnostic: CO1PR10MB4705:EE_
x-microsoft-antispam-prvs: <CO1PR10MB4705CDBAB1B48427B083932AFD209@CO1PR10MB4705.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ol1f5dhyFlUpnb3h/eJYJu4qg3Yg1u3+77M0LCjyenQiimrf3HgpGjM3llsZXWNNivdeiBCrIi3k/PfgVw+PPowjJpIvd5V2ZA6YHwc9QPm8A+w8KtReieTMp/F3QKjumG75yNeznUKDwckXr5INrSnj1jo8j1w+eshLwPdGKFjCy4K9B5yXsAOt8Sb8vlwiEzJfdN4kUfNxTU/hiUG0RjXE05445UYy0gkxE4p25JDgj/AYAz8FoFVmpnK38PRYOJoeirE447n88QnJZ/KjpbqC5WvO+J6CjUe8jr+0cWjKGLTlIu49qa9PD7s8dTmkOATVkbECEs94Tl+WOrR89qBrknUBUILVtCqk88367Z4WK+iioUbQ9e0H82HRrOyCRbh7UVLzcl1eT7jfM4laEQXU9KO1yV3WWeQasp2EikLOg9CvUOoTnDbrrNknoZAYAPpVwLkoauS32K3MMFsEzdtdodrhBeSbsf+vp7QqLVR34l+LI10ELGCH4CyatinGhlrz7UXP1/5MQkPb7MFC6r4vLtvFpccIROR5BtefdHbh2npQMSbLRk8rRjwkY9g3n3bQFUeANraMtki4tpRXw1W7fICIAigoFow1gV8pllZmhnVsasT6uqiRJwz0jVHESTaMwncIkUJB5nwllNhKI7Vne7oH+LBx97N6QkgFb1PN5PNO+3Lj+PRP751XGIsoKfFR0OispAqFmDzyc3mMWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(9686003)(1076003)(53546011)(508600001)(83380400001)(4326008)(86362001)(6506007)(6512007)(71200400001)(122000001)(6486002)(26005)(186003)(6916009)(316002)(38100700002)(5660300002)(7416002)(54906003)(44832011)(66476007)(64756008)(91956017)(66446008)(66556008)(8676002)(8936002)(66946007)(2906002)(33716001)(38070700005)(76116006)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fDn1kU//owwufxmRKDJUwtaAEhBHUBVM8HgCaPv5NJyS30FNMPlqw2CQz508?=
 =?us-ascii?Q?+WZ4jJX0tuFs80JXqYQl+2eHi8Ohw9426VJBVg5bazvnA0kNex+Tvb8inntD?=
 =?us-ascii?Q?pYSZiIMWwG3xp/2zM4WTeLs22hQ/4muEyg79cDwq4mLJO9sxuWMlV0/vCEaI?=
 =?us-ascii?Q?doqDdarRTqWreK+J4Oaz+EUGwwNJAkW2hsJTSnFDB00yjHMfq6PErM5/p3N6?=
 =?us-ascii?Q?/OUiCXWoG8k3r21wM1F/W7mReYmV2ahNH4rCEEyKTFnTG0EeRTfM1p+i8jhe?=
 =?us-ascii?Q?hoYw54e/MD5+F7VvOtea+R5Lx9tUxknPaZ6yKdGnYXuPqVzWToIZggaEzyGK?=
 =?us-ascii?Q?HDFHfr5w16ykUuO9xRFoyre5DbCcPPtwNHlY4XUyNfKQv3Pv8rZ1OGMKZGPT?=
 =?us-ascii?Q?tau0YV1preoa0Ntb7K6cZ/nrlGmAyR0cGpHYrTsITgplpiYFWFKkayT17O9u?=
 =?us-ascii?Q?GrBI4dadkmp5ZDry+/4m4iRjo1J083qKPqrJBdtGzz2i9+Rxkot7ygtQEavR?=
 =?us-ascii?Q?XmCqtlmK1jj93CkuVJrPANLlfNHYyZkYSf7KXLHDEZQjQzk9W5epkIZnzTye?=
 =?us-ascii?Q?3rMGgYffHvubzC8qFJM5zo72I8hpFGTP/2fTPziBWfY5Snwu7uC4PbsBkuxb?=
 =?us-ascii?Q?L1ms5M6vxS3FCe/4rnYiXseyed+krJdJkOTKmwO0mu+Tx7CfFZFflrHFhIXD?=
 =?us-ascii?Q?Z4zZc3HlL0ka3MH8mfDt3cEv5y7eT3FOIov2dZll9ZDDkQdco62B3rkhSR+o?=
 =?us-ascii?Q?lpdawdfOck6GBOiQEoeek4/TrFNIuShPoOEqMpGfsoe3T4ukHCNB0UZk5zfC?=
 =?us-ascii?Q?b8FE5hbOKi6zdaLSf9AaEYkT4rGvftjkcCXnKs20yE2LnELpCVg5IUGexJ5s?=
 =?us-ascii?Q?ThzFZPOr11Nsly5P4F6yjg3dokRDsaiCwAfETh9g2e0UDWScUKPheS1j20mY?=
 =?us-ascii?Q?Hg3/lONHRfhMvroJ3FqSKZfUxc/OoSmSU/o4W4teXyurMBncri8PpTdU+FtF?=
 =?us-ascii?Q?QVqpS7bvCpd6lMyUytfyDFCeGDF4CE0WKZK5lFP74bOPpsvDbGDO0CdjFaYb?=
 =?us-ascii?Q?zZo5czEo7H4o56yhr7bmdfA6R1vl5M5mWKewNARdiKVaE+pRSpevsttkGCtf?=
 =?us-ascii?Q?+AuxPkIThF27SbEZWeQP/267UIPEjULynOFLkQoHaJ7Ak5/hWcVYLGLon4D/?=
 =?us-ascii?Q?JXaf0gHK6WwDd5LR84VxtgmxrqWVoS+HhVabEnmUyXqGpD+fK9ppiSD9Mtst?=
 =?us-ascii?Q?9O/K8DDCnRSAd0zLE//Be7gQu/rIA4AxrRUuD/vl2pdF7EReter/s4vVb+ls?=
 =?us-ascii?Q?Jt0OXWzyhilvXlXqHoi/guAGbA6RXr0it2UxP9yDfX3AAXY3BITOoUMw/m/X?=
 =?us-ascii?Q?qZp3yduvRze1Iik1hP6HmSnE7Hku6svdF/l6EalJGVUtjSYEoDqQofwEdajP?=
 =?us-ascii?Q?YBO4JunjKtiEyxYWWHvAx77UQuepxlcJjNQwBqeOjxscJtSS0+MfEKbAbT8N?=
 =?us-ascii?Q?fOMkhAwUaHUkxqjrJ+G/TXW8+Mt9Gx3K/d8Qfsi5zqrTpHdTnaqiQrFxe3hc?=
 =?us-ascii?Q?c7JoXsa67CREwa2lwL0ZxSQdsNU/SSitnHsAtAHaCcBJigi6Y8dfTiMqH541?=
 =?us-ascii?Q?inylKSwE7zAig+qCg0GDd60=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3C027F5E455AE5488F3492169FBE93E5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c1f298-2b88-48c9-1805-08d9e073abd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 02:29:25.7297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4RYsBmk8fUdY90nA4rlt431JnF0ueThcW6V9+dfEqqBuKnhN3V/txeY6GbQVeGI1Ok6XK9FDGkB0sMJuQ/1wXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4705
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260008
X-Proofpoint-GUID: __bGEldst2G7YXt--ALwlVKhOttLBn8E
X-Proofpoint-ORIG-GUID: __bGEldst2G7YXt--ALwlVKhOttLBn8E
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [220119 12:59]:
> On 12/1/21 15:30, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>=20
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>=20
> > ---
> >  mm/ksm.c | 19 ++++++++++++-------
> >  1 file changed, 12 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/mm/ksm.c b/mm/ksm.c
> > index 0662093237e4..d309249c95a4 100644
> > --- a/mm/ksm.c
> > +++ b/mm/ksm.c
> > @@ -973,11 +973,13 @@ static int unmerge_and_remove_all_rmap_items(void=
)
> >  						struct mm_slot, mm_list);
> >  	spin_unlock(&ksm_mmlist_lock);
> > =20
> > -	for (mm_slot =3D ksm_scan.mm_slot;
> > -			mm_slot !=3D &ksm_mm_head; mm_slot =3D ksm_scan.mm_slot) {
> > +	for (mm_slot =3D ksm_scan.mm_slot; mm_slot !=3D &ksm_mm_head;
> > +	     mm_slot =3D ksm_scan.mm_slot) {
> > +		MA_STATE(mas, &mm_slot->mm->mm_mt, 0, 0);
>=20
> VMA_ITERATOR would be a bit shorter.

Yes.  I will change to the vma iterator here and below.

Thanks.

>=20
> > +
> >  		mm =3D mm_slot->mm;
> >  		mmap_read_lock(mm);
> > -		for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
> > +		mas_for_each(&mas, vma, ULONG_MAX) {
> >  			if (ksm_test_exit(mm))
> >  				break;
> >  			if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
> > @@ -2226,6 +2228,7 @@ static struct rmap_item *scan_get_next_rmap_item(=
struct page **page)
> >  	struct vm_area_struct *vma;
> >  	struct rmap_item *rmap_item;
> >  	int nid;
> > +	MA_STATE(mas, NULL, 0, 0);
> > =20
> >  	if (list_empty(&ksm_mm_head.mm_list))
> >  		return NULL;
> > @@ -2283,13 +2286,14 @@ static struct rmap_item *scan_get_next_rmap_ite=
m(struct page **page)
> >  	}
> > =20
> >  	mm =3D slot->mm;
> > +	mas.tree =3D &mm->mm_mt;
> > +	mas_set(&mas, ksm_scan.address);
> > +
> >  	mmap_read_lock(mm);
> >  	if (ksm_test_exit(mm))
> > -		vma =3D NULL;
> > -	else
> > -		vma =3D find_vma(mm, ksm_scan.address);
> > +		goto no_vmas;
> > =20
> > -	for (; vma; vma =3D vma->vm_next) {
> > +	mas_for_each(&mas, vma, ULONG_MAX) {
> >  		if (!(vma->vm_flags & VM_MERGEABLE))
> >  			continue;
> >  		if (ksm_scan.address < vma->vm_start)
> > @@ -2327,6 +2331,7 @@ static struct rmap_item *scan_get_next_rmap_item(=
struct page **page)
> >  	}
> > =20
> >  	if (ksm_test_exit(mm)) {
> > +no_vmas:
> >  		ksm_scan.address =3D 0;
> >  		ksm_scan.rmap_list =3D &slot->rmap_list;
> >  	}
> =
