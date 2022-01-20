Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFA1495371
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbiATRkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:40:39 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:60214 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229629AbiATRki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:40:38 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20KFgfLA014584;
        Thu, 20 Jan 2022 17:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=cs57aOygFDVYccYnY3nufPqwCD+9vzRLcTY/eTBdHGA=;
 b=phGTwmyl5Pa0C3SG2wP6Jn68uqIomfkfm97EvqxX4hwEpLsmx03FtSZv5CGorqEZ5DqF
 i3fH+Ga7E8RpXDj/cmU9/c4r3WuPWQ9kc2R7R/XlBJDC6lluj+J3n9maNbczC10NRcdC
 s8eWgvtt7r40U4gJ8x9o0+oS7r35w9akkpm4i4QAXBUKFrQiJsIn1+J0n/OGCAlIA6RQ
 aF8+drJJzoaXAmMEHhCWAZDcxl7uNXw253RVDPeP9o6Ycmh2Rzt/Tq1onka/bKKrdaWV
 yItplyC9QjVDSbtKqKT6AFfv4f7KItUaHvsCUcLjQW9OTRx7w9lEa+waO9tXABomWGX/ Gw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dqam9rbh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jan 2022 17:40:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20KHUWgw023751;
        Thu, 20 Jan 2022 17:40:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by aserp3020.oracle.com with ESMTP id 3dkp37xy3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jan 2022 17:40:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNspsCa19ofDx/yw6HhZNygnHcrqEHTpdmFrcrV3TG2exnfF22ykys1+2VtIwQjWk5Wxb/J+JQWkMgIsx2ZJCXghnEt69szkHciSq2UrTjRP/NPByuYog+Usp2H1Bm+cMwKz57HwNZezdQ2hp+JJbKcDhOCZSH5MMAE3umZ5N0RRimBa1FYB7hbhFuOuXUFxY79LP5e/NnakZxW9rvoMOKDTcnHrNFLoPa58Rf9nGYKHy5TgCe9QTrzCCHsDmHvX1Ta8uMEg8u25qaYoz0Y1IgzW5Lsw3RPCaRA4bYRgLEen3Vg7SDNrM60cT/2tkRXJx5LGmNLfyuimoik59CDPyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cs57aOygFDVYccYnY3nufPqwCD+9vzRLcTY/eTBdHGA=;
 b=MFIN/N80uoSJQEaEd9JhvrtnIr6zdnQ5a4GUK+Rad6OAGItCOj8YnZ+JuE5Eg4OT9mz3r37kSLktL5zu1kSslLAVG0iXB7OPs0O/nj791tFAv2rmiJaj0VYLpzT4sxug91ZMoFhs5O3rn+gkY1VU4TwJY03zvOb+LI4c8N2stY6+iCLMT2ibB4pn5pHw6z20VMoE7PSLSPauTdUzJueXmfnm77sjKktV+uaEEniVU6JNVIntVqkw9BGF6P3IVapXk27+yQuLw/piDQOnrjwUDbIT3jR+o66ypXM92/TN/HiWTtI30qbAhF89imSQv1BbPNJT+0+s026B5PgeqWOmpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cs57aOygFDVYccYnY3nufPqwCD+9vzRLcTY/eTBdHGA=;
 b=nM5rzW3XDfw12Cqhcn4VoWGNF/nLGnYTBa1sciSeyhNpKv4XE6BNNuATtq8SYVQUyGybXQdRwwkJvW2fCvL4bBlvnC6sKym+B2vQMMEmD4u8HhcKTwRwfzrhtiBhZxHfOVQ6kR/oGsp8q8ajM7W4vjxFtzSuVPKMWvNADK1MlJc=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by DM6PR10MB4140.namprd10.prod.outlook.com (2603:10b6:5:21b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 20 Jan
 2022 17:39:59 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::a52c:7825:c2c5:d259]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::a52c:7825:c2c5:d259%4]) with mapi id 15.20.4888.015; Thu, 20 Jan 2022
 17:39:59 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Vlastimil Babka <vbabka@suse.cz>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
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
Subject: Re: [PATCH v4 63/66] i915: Use the VMA iterator
Thread-Topic: [PATCH v4 63/66] i915: Use the VMA iterator
Thread-Index: AQHX5r/8pyGHA0a30UCeHYNaMLfKU6xsTxCAgAAONICAAB6xAA==
Date:   Thu, 20 Jan 2022 17:39:58 +0000
Message-ID: <20220120173952.m7nj3ejesko6eh2y@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-64-Liam.Howlett@oracle.com>
 <807fa53c-6492-52ca-abf3-ce58cc84ca08@suse.cz>
 <YemEqYFu1xdaTeHd@casper.infradead.org>
In-Reply-To: <YemEqYFu1xdaTeHd@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58cc56ab-16aa-497d-8252-08d9dc3be147
x-ms-traffictypediagnostic: DM6PR10MB4140:EE_
x-microsoft-antispam-prvs: <DM6PR10MB4140AA13BA5C9D6E2686DED9FD5A9@DM6PR10MB4140.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GPCkYUX45aXly/slGJEx4wdQT422Kh1BRcqRP1C9NFts1M5tW9282nvqol1m00Dv4k4n0PNzWgjAftmpDPZPTV9xgQNMW9CTUnBhGaHKfQqTQWBeFz4igUGKZ7U86VTUGhVJrYuKluSVmX6ycWlj5QgzFRdPBVCMPmZHza4j8zUuLd7ZYKywbAqMZwBmtsD4yg36FsLcaFzlAhIa5wISY1iX/qfn3tGgBW/vnh1olHVQYr6mm1lDN3B02Ml2ckfao+IKyvELI1if3z3xrU3LJnNdZ3qCw3cCuNs3BHLDydMGY/enWo/XUn9/Fv5THIcEeaP0rkdjJQ7Z5lIL0TVG202/9fqOGcLWDs18SHz16W0xqVhNlgKiCXCv4vHraKQC2M4W7/MFZQSUovZ+T91SnJRA+oyd3hVSjE12AG52ZUrZrAwySNuhcDYhyU2NkdoklE7dOuGY9MqYc1hj+0H4vtH4KZEUNs1GvRkhEfFbZnGt0H6d70CI8DAW2iN511jlbaAzpVUoIh5x44gdcYEkJeoFYRwaMIwa1OJFrpGi4kXYNq4xPlBOlDYpR/j9LUvRQ0MQ6sZRzWiVTHeCUP6sv5xMtP3XDJgEDmK/B/VV7ixU7uCN8R88Gf+Aa0Sv3mNI0q7GCvXvAXTM+KXA39rmqEUMaX/Xw5sbNCHbkd91qJJqloSLXkkvSfxnbPgKidvd3P4qDtvkRBZT+qKcdgO4mg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(83380400001)(26005)(4326008)(1076003)(54906003)(316002)(5660300002)(44832011)(508600001)(66446008)(186003)(6512007)(64756008)(9686003)(66946007)(66476007)(66556008)(76116006)(91956017)(71200400001)(7416002)(8676002)(38100700002)(38070700005)(86362001)(6506007)(6916009)(6486002)(53546011)(2906002)(122000001)(8936002)(33716001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jqlFAjldIemEp9LmiazLp3SVMN2PGXO/w/rAdwuc9ljV06EZ3GUxDyTEddgc?=
 =?us-ascii?Q?rV6dXmFZ0vjGhnXCG18HqA/rSMBSWoLzUpvspUZivws+BsXrBgLOYg6D1IF/?=
 =?us-ascii?Q?gwhFvflsCnJod/8SFIU23UEkdlBmh5uUHGIvbohf7va+576wA+N6tRJtQGAW?=
 =?us-ascii?Q?MJrAjd0U17LrGfzQG6W86EcgR+luudP5zKzPTWIer8cCNuRYDU+9CF8uGAq4?=
 =?us-ascii?Q?44lIjdjMgqST+LrpU3lD08LqUoconOY0DQaRnnNGWBzISzRjIC0NKYD0BVyT?=
 =?us-ascii?Q?Bjf6tk3NErpvKv77eftM6lt6V9HT80Tez1X95z5EBWk1fGzJveLiiFkW9nrI?=
 =?us-ascii?Q?8Fwl2qIJTD7RizrB1xQDTRFheZi+ZsipjJdd9zg2rFcJTXCB66hgbmYkvu97?=
 =?us-ascii?Q?FynByhU3CkwNRCZaBswbTH5vxb6lhJcwfVkcT8HCuk4Q+9j+hhE4oml/Wmpb?=
 =?us-ascii?Q?dzikehPKhk+OZl+dbo0KRVZJOBBFh8snTfegpHhw0NycIEs4UroEJDf3Yoim?=
 =?us-ascii?Q?SGt0PII0NMJY1iH56uYSsqTJxlBZM+E/bIWowtuKKXIyxENMCj1u/P6u3xZz?=
 =?us-ascii?Q?nNAJhiM31JEDWYcHw5ZEjjU4hZLPRtBq2xX/qQM8F11pTJkAwdxwgAqDFMqA?=
 =?us-ascii?Q?+JXU+TOotjOzRK/jpz0Zyz6klwfLZtcDRpfjj5r7TJrS3uBiikNZtegge1J4?=
 =?us-ascii?Q?4RckITwVSf5pKTBCL7bfqEYuzHqyxaoE8UzYWcceW0WWR721h9l6luY9Mouz?=
 =?us-ascii?Q?ccrZeCTPVzt6XyVpwmHonqHlvyeaE5dTLjj15WGahd/RkKU5l1tgKiXBc2vh?=
 =?us-ascii?Q?Xnp6wL6PP4Hk8jo9GYrWNe/hPVfk5TbLEETJI+IqXEA0aPdL4PPzX+znXHZv?=
 =?us-ascii?Q?trYuI3GzIrRFhKDLNDIFQnFV4qw0HmlP8zsQJWcPxqdHtBGd6AHVL9/iNmz6?=
 =?us-ascii?Q?zs3HNj0UdQ6iUBHig85+eZsUeXnnCyNBy8oAoDRPZDLaUTt8/AE/HUG4duxF?=
 =?us-ascii?Q?TuNYkrlbF6Xx6MLA+blv5gWD5DQaRbY9MCWlg+c2V43LQHGoy14GKYmFOQMK?=
 =?us-ascii?Q?Q/41H8HYQ1qfyU6+NlVxPz1S1ANyFgNK5k4ZHZ/zmRfrGetdulnTzgHQre5z?=
 =?us-ascii?Q?Z1iECovNXTHT+oOY+Osu8+hFwHUzLV0pxvPDeMLzenOqPucdEeWI8zXxSg2k?=
 =?us-ascii?Q?Dcp+YrcqpD/RhAMuM6fcpB82BB4np9IoHPLxmieVGDqBnYA/ViOvqLU2e9fU?=
 =?us-ascii?Q?EG1c4pfS5TZkQvQtdsFSlxneNc4to2pNof0DOsFZ2+iEyh4qq7pKDXdb6olD?=
 =?us-ascii?Q?v+BlVUSganhuy8VhcInKBUc+wIPek2VjzKdzzG2IanOq+TP0WoH5m+Soi9KN?=
 =?us-ascii?Q?hG8GQpJ1bFLzgQEn1MHqpjgiDitdl/hm1uaBut1GuowXQ3KJJ3+tXUtF5oaB?=
 =?us-ascii?Q?c3t15DtEqlhfVfXBrGvTuyLNys7esDcF5VNpiH5qU7HB2n8OeuStXKliCqs9?=
 =?us-ascii?Q?Q/giVrg+JWc4k21MFMuN/ld4jPqSu9JMH0D4u9tyTDewn1OCha/5LP9+Wm2+?=
 =?us-ascii?Q?waUHpvKI3upBd7fXLelpXeJbiaF/EzVRiBcqbiKCTNZmt/HQ0hHd3kAq6an1?=
 =?us-ascii?Q?XDBAlW7uGi2rC3+WhLUG0m8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7D8E88470C810D4CBE3C42085774C9A4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58cc56ab-16aa-497d-8252-08d9dc3be147
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 17:39:58.9127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yeu8QgdNim63yx/dzztEZ9Naxadykd6WMlIZhzhaJNbb/PtLKc1aHHqGwz7Wy50WgxKoYwj4cPYJBfZGfAaftg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4140
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10233 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200090
X-Proofpoint-GUID: sabtePCQcSOTm03QHo-WeLWUImUZQtxA
X-Proofpoint-ORIG-GUID: sabtePCQcSOTm03QHo-WeLWUImUZQtxA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Matthew Wilcox <willy@infradead.org> [220120 10:50]:
> On Thu, Jan 20, 2022 at 03:59:11PM +0100, Vlastimil Babka wrote:
> > On 12/1/21 15:30, Liam Howlett wrote:
> > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > >=20
> > > Replace the O(n.log(n)) loop with an O(n) loop.
> >=20
> > Not true?
>=20
> Oh, right, that should have been just the linked-list walk.
> I misread it as calling find_vma() for each iteration instead
> of just the first one.  Liam, do you mind updating the changelog
> here?

I will update the changelog for v5.

>=20
> I wonder whether we want a "for_each_contiguous_vma()" that
> will stop on a hole.  It seems like a relatively sensible thing
> to do -- walk across a contiguous range of memory and stop if
> there's no VMA mapping a page.  Like gup(), for example.

Hmm, so search for a non-zero gap across a range might be a reasonable
implementation.

>=20
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> >=20
> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> >=20
> > > ---
> > >  drivers/gpu/drm/i915/gem/i915_gem_userptr.c | 14 +++++---------
> > >  1 file changed, 5 insertions(+), 9 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gp=
u/drm/i915/gem/i915_gem_userptr.c
> > > index 3173c9f9a040..39960973c130 100644
> > > --- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
> > > +++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
> > > @@ -425,12 +425,11 @@ static const struct drm_i915_gem_object_ops i91=
5_gem_userptr_ops =3D {
> > >  static int
> > >  probe_range(struct mm_struct *mm, unsigned long addr, unsigned long =
len)
> > >  {
> > > -	const unsigned long end =3D addr + len;
> > > +	VMA_ITERATOR(vmi, mm, addr);
> > >  	struct vm_area_struct *vma;
> > > -	int ret =3D -EFAULT;
> > > =20
> > >  	mmap_read_lock(mm);
> > > -	for (vma =3D find_vma(mm, addr); vma; vma =3D vma->vm_next) {
> > > +	for_each_vma_range(vmi, vma, addr + len) {
> > >  		/* Check for holes, note that we also update the addr below */
> > >  		if (vma->vm_start > addr)
> > >  			break;
> > > @@ -438,16 +437,13 @@ probe_range(struct mm_struct *mm, unsigned long=
 addr, unsigned long len)
> > >  		if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
> > >  			break;
> > > =20
> > > -		if (vma->vm_end >=3D end) {
> > > -			ret =3D 0;
> > > -			break;
> > > -		}
> > > -
> > >  		addr =3D vma->vm_end;
> > >  	}
> > >  	mmap_read_unlock(mm);
> > > =20
> > > -	return ret;
> > > +	if (vma)
> > > +		return -EFAULT;
> > > +	return 0;
> > >  }
> > > =20
> > >  /*
> >=20
> =
