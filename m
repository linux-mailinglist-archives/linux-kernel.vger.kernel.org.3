Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C0C48FFDA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 02:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236680AbiAQBNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 20:13:30 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:40698 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233958AbiAQBN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 20:13:29 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20GBe11i002821;
        Mon, 17 Jan 2022 01:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=VVDSRRMRfjTKLSkWLYSSTv1aQavS6eae1Rw3P0O0300=;
 b=UzeQ7vLwTqat7ZVxWG5+wneUxq+Bip588dah87asFNmFeRfr1m3jDyMGep70kUqmBi7E
 avKw5JiDTiw8THphZvTQ6Iq59st6mMvo52uJL1rMps4yx5iRTjKho0TZQzpix3c3FrCS
 lghJi9zPsqrMtFtkKC+8LkcgF378Gy3WSJL0gmynWE9AU9oHDYyl88aBK1e+NozT0QKc
 7NWN0ZpkZOpKJEd8Q0/sJMnqMROqwi5hxZhAxIezFeDF5saGnVCbacu1JazfPNppi6W1
 z7sE6qEPQJGspu83SACFpDPvaDpJ6sYRPvHcNEzeLYUMmRzUcPG0Gc7krXYUOlMcFETu eg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dkmv228r4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jan 2022 01:12:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20H1B1aW118334;
        Mon, 17 Jan 2022 01:12:41 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by aserp3030.oracle.com with ESMTP id 3dkmaa1jtx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jan 2022 01:12:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPfP5DXR/F2anK+A7vCncXchkyQAt5wKfr5iccb7RjBRgLKvH3qJKk6iW0qjap7a3bemIQzagsCf5hcASrDeNuStRJcvvDkFFZ9sHkPaO7PE7M4l5Xt5K8HEAus60Xlm6jakCWvAGuSjSR6pSsGeTRbWgwPJzfqQEhypMYlPw+BDlrUl5GJPzrfzRdSRTg4iYgjgoGHW+KCNGI4itMOI3gz7hArc38qKJhvK4rFfrHsbt+g8fJxWuZ5ANwn5gVHOXHBwlQ+ndZR17rX2eOsXzbIAcomUdgI6FBThSza5eO1zs5lzYkx8ive+QaBxB1RzTG/ZEQW6t508P2ApBj9SJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVDSRRMRfjTKLSkWLYSSTv1aQavS6eae1Rw3P0O0300=;
 b=QwagfoodRd8vf7MNR2g5Xna+yNDMoW5T8nRYkmCHb9D08gYwAz7KXbqECryRrnCU9ec5/mAqP2u2ySw3F1MZ/UcEQaooZEGPTjz0n76p5VL0PBijhwkcOYTwMQZhfsF63ingrvj1GPm5IDE9ulfAYt+L/FyVz/SlBJ4Qt7wqy7GCdb68gHoHC2gVDB2EfVPAh7szKLZHQ0eYwrka6NDGt15/JmlTj7gtBGnwQkVfn1JFWfvfwUXxujXqsDQcOb+cDOWAKDg7aL3D8EtyLRc4Z0RvY204nBFFiuzPS5xuZxPYA7A0+Rp6lXrYe+DOmOkRwiDr8qD/1JDyU9XdR9rbVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVDSRRMRfjTKLSkWLYSSTv1aQavS6eae1Rw3P0O0300=;
 b=jm27w2kY9AcJUmLR1I0BXHVIRATY2if2FqkQNSLYwK99p0nu+d19U5K39q71U1p5de/koTnxqAVd7TUMD5C3c9ZpSUbtN5EvWg4nKpk1YKOKEE6B8dKR+85fxL8tiDj9n9HuhUdvMK7k2lgXmXrNmjBRse+vWKrmk+WzU7WpqUY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MWHPR10MB1406.namprd10.prod.outlook.com (2603:10b6:300:1d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Mon, 17 Jan
 2022 01:12:39 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4888.013; Mon, 17 Jan 2022
 01:12:39 +0000
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
Subject: Re: [PATCH v4 16/66] mm: Remove rb tree.
Thread-Topic: [PATCH v4 16/66] mm: Remove rb tree.
Thread-Index: AQHX5r/pFs5QB33Z/Eer0iQ/ZM5uPqxfiyQAgAcl9oA=
Date:   Mon, 17 Jan 2022 01:12:39 +0000
Message-ID: <20220117011231.rkcdvkfqozdaexcg@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-17-Liam.Howlett@oracle.com>
 <77fc73e7-f6c4-27ea-66ef-63f61e0929eb@suse.cz>
In-Reply-To: <77fc73e7-f6c4-27ea-66ef-63f61e0929eb@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f975e45c-929e-479d-53b3-08d9d9567489
x-ms-traffictypediagnostic: MWHPR10MB1406:EE_
x-microsoft-antispam-prvs: <MWHPR10MB14066AD4C172CB2CE34841D6FD579@MWHPR10MB1406.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cWcFIDXbXk1urZlNQZmPaUcFaK1qkhAwdAnKLf6iR7X3j2Q3pzG6FjnWABFUx6TL+EjU+9/eJD8+M2JDSobG+6Yi4eDEPRHgfMEFkkn4cI51aJtUYUs+b+T3iZx2BOpDYgnfD/PcFGoLZxaOiPWtgKcd/EFFerDnbt67FXSFEZvimVifY+VUqWbyX49ZV8x8I4XLNcowgeFenDF6pLelHry+UWAwwW6S+OZaQM+X2/GPDKuUmvKsad0i18KTqmNqThd8s6GgEHiIa90iL1OIHnUVP/SEFvN7UCrA/dgjpkwvQrlQ/Qw+GhTfYDcioV9yj+fMGXE9xYHv2Haokp/F6mFLnDfC9JeAr4OYe+lUL905+zKfgroML7Dt5P7ZxE2+COAZ0uwIJyGtfhMPgrdbO/9V40m6zZiVnhBQzDfEpsWhnpJe/x77Y12DHelr8B6Z06KlHXsOHbfPub45m0yn7EalmJg+5CIuag18wgI/UBlfyCfuJyVqA77OE6gBWan1SoKg4hXEnedSn3j8yfS6CpKbloFBokWRmMiiiDP01E8ERZOyQesODDC7H3DiWxNxyI/WFiO7F1OeBypB8FF/9Wfss5nL9R+FDM4na651gyfeqtIhJN8YHbSgvL9kK1ugYDdhLMzplJld8sjy5IJBDkwngLf44xXWhmShhrwaSPC+d8Tij0qQ7+onDuWNZbn2h6ED4ryXdrVq4nJyblHrSQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(9686003)(316002)(66556008)(54906003)(5660300002)(122000001)(508600001)(66446008)(4326008)(6512007)(44832011)(6486002)(186003)(66476007)(71200400001)(66946007)(1076003)(38070700005)(8936002)(2906002)(86362001)(53546011)(91956017)(6506007)(6916009)(76116006)(3716004)(83380400001)(26005)(33716001)(38100700002)(64756008)(7416002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oBj8tr2zOFFb4wd9f/4fiY+kleWlX2nf7Vt9XmHRUh9zLyiJlGaag/+k3jrz?=
 =?us-ascii?Q?JOi9qTnv/U2RFdFICyKrzt+L7RAqPQiR1oW4nmAm+9FHk1trnXPNsfm8rCeW?=
 =?us-ascii?Q?3hoVUqFXGRvKv4vAFEi5Hh1PIwsM0v7Hv1sjrjJlwjCg5DffY2DNRCbd6hoD?=
 =?us-ascii?Q?oat7/Z+EMOCsfV042V4dsUBYHdxcXIR+Pf5uODWEdiYp0xh1pOSHwsHhKyG3?=
 =?us-ascii?Q?sPmRpaSC2KvFJEuYPIl5tLFPrj9VeYN8Qp+0/GuDiUC94yX/I13l8DTF3AEL?=
 =?us-ascii?Q?FrOZWPpnbMXuPI3EYoAfkgEOOg+JOZV3qo1n5KYHhj/ABjNvknIWhxH7bf6/?=
 =?us-ascii?Q?+quiO5zdJXHeORP2YBlbyWcitt2p/gpb263Ug00eYmnesVdiOwfFg7v6u3yz?=
 =?us-ascii?Q?e5l7UGbqdH5RlLchazMoOyt8SeSoRe5Zmj7G2zEKrpmOZPO1wAhKlvmvV1YE?=
 =?us-ascii?Q?ATTlYu+k2rEllcSStKMEzhH9b6FpvSLnr0yNyzC1jCj6i5Wevs3sllAkz6dY?=
 =?us-ascii?Q?9bj0sVPHR/wdygOzGQEee70zIA4u16SahuunGvFPejrE1Il+IHyH+/NCNaeO?=
 =?us-ascii?Q?aSkRK/Nvfwj+9tuDd/f9U6GgcVVtTCC88ael2ZxppSnx9SKU4QdZBRPVv7Jd?=
 =?us-ascii?Q?s7Ry1RZCTypuYVjjOUXyK3Ddm7qY2FPl+kpTnsGuVX08a8UlwjTaIAEtNgPQ?=
 =?us-ascii?Q?l5djgBarP9ZlLwahSl4uFAE/nNKqkbSM/qu6K50m9SaTT7BZUwsfePh+PwC8?=
 =?us-ascii?Q?kJ52Ce38BGlm+ey57wnhYL0X3H+e9kiOA1fO756Ht1IjKClEooNPbuFmFoja?=
 =?us-ascii?Q?HcqJkKBuxksaQsV0b4BJmJX35OSAsFFHayMSWzAeVeExXNyNQIdkJHJfaUWM?=
 =?us-ascii?Q?oRkEfKjL2A84iM3nCWbY8GGIMMvwLmFpbwuWou8WKnuyLRIWHjpsY40hSsG2?=
 =?us-ascii?Q?auibW14Ww79hnqtHGapEAort4j2QJYBerlNnx+FwjtLC9MrT2IXKvD2yV+F1?=
 =?us-ascii?Q?aRGeQbdQctpu7X7SH02KhL75vDu9DGsuLBbque2aSjy8au6bXq0/fyaiC1d5?=
 =?us-ascii?Q?JOwNQfWH7Z/3ix6C6UKSgX6/yJYPzYItVuVRVy/et2qG697Bl40foPzEnlbI?=
 =?us-ascii?Q?yUPezipUlgpJBKgvafBS01FFvn9UeKirmE2ZTqSNpSu2uAA4uNAbmxqUkHZh?=
 =?us-ascii?Q?UXzDVqptP1VTRsbIRsYucCuu3xcKjPFjcXY/IXbAnEds6ko9ozcmYf0lq58R?=
 =?us-ascii?Q?fF9UAMhCx1I0Xw2DnpUTP8SHElJfdpl8Q22iLsHlfQ9GrMhQQF7WmuX6T7rt?=
 =?us-ascii?Q?sS9zD+DAMnjD7Wo0oImEXRcc2+SGKd385DC1i11vTO8Mp4v3gPZY4mxKGbw9?=
 =?us-ascii?Q?7KzbM/o3S2NjkQo+RHVOJbRGprnZ8qLJ91bks4r8sGveIQKdB8tLuCxogrGI?=
 =?us-ascii?Q?6Wm6drkA9LTQUc1zUEd/vp00aG4c4L5D7pWq1aI0uILsYlyFcTBcu7MKLw7/?=
 =?us-ascii?Q?0pGG51udYtqPmIh9y7K+FPtP7tkI8nzKki8ezl5bK6B0mayLeUmnBV4QbC2S?=
 =?us-ascii?Q?G+5ir2slrzQurjZs0BgBiLy+cHQiKTEjbntiVPM06mDHVJSCAN8BRwXOKO3F?=
 =?us-ascii?Q?Kud6WevhJm4KK0ih4C27mTQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E1EBE7240A5D364C9CD2C1D6632604EB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f975e45c-929e-479d-53b3-08d9d9567489
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2022 01:12:39.4426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u1DX2TdBA5Vafn/5k/kS/waIVoqOtLDLdY6tWMcPLsDX1UDOt5QYQLyxl7mRr7hYIikvVCrYCwOMsuzja9zyLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1406
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10229 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201170006
X-Proofpoint-GUID: VD5Rq172KdK1EVoRFY8Q6A3v4i-kpFC5
X-Proofpoint-ORIG-GUID: VD5Rq172KdK1EVoRFY8Q6A3v4i-kpFC5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [220112 07:03]:
> On 12/1/21 15:29, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > Remove the RB tree and start using the maple tree for vm_area_struct
> > tracking.
> >=20
> > Drop validate_mm() calls in expand_upwards() and expand_downwards() as
> > the lock is not held.
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>=20
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>=20
> > ---
> >  arch/x86/kernel/tboot.c    |   1 -
> >  drivers/firmware/efi/efi.c |   1 -
> >  include/linux/mm.h         |   2 -
> >  include/linux/mm_types.h   |  14 --
> >  kernel/fork.c              |   8 -
> >  mm/init-mm.c               |   2 -
> >  mm/mmap.c                  | 496 ++++++++-----------------------------
> >  mm/nommu.c                 |  88 ++-----
> >  mm/util.c                  |   8 +
> >  9 files changed, 136 insertions(+), 484 deletions(-)
>=20
> Nice stats.

Thanks.

>=20
> Wanted to suggest splitting out the swith to range_has_overlap() but I th=
ink
> I see how it's not feasible.
>=20
> > diff --git a/mm/util.c b/mm/util.c
> > index e58151a61255..ab02382c2d57 100644
> > --- a/mm/util.c
> > +++ b/mm/util.c
> > @@ -287,6 +287,8 @@ void __vma_link_list(struct mm_struct *mm, struct v=
m_area_struct *vma,
> >  	vma->vm_next =3D next;
> >  	if (next)
> >  		next->vm_prev =3D vma;
> > +	else
> > +		mm->highest_vm_end =3D vm_end_gap(vma);
> >  }
> > =20
> >  void __vma_unlink_list(struct mm_struct *mm, struct vm_area_struct *vm=
a)
> > @@ -301,6 +303,12 @@ void __vma_unlink_list(struct mm_struct *mm, struc=
t vm_area_struct *vma)
> >  		mm->mmap =3D next;
> >  	if (next)
> >  		next->vm_prev =3D prev;
> > +	else {
>=20
> Nit: style suggests that once else is { } block then if block should be t=
oo,
> even though it remains a single line.

Ack, I will fix this.  Although this function is completely dropped
later in the series.

>=20
> > +		if (prev)
> > +			mm->highest_vm_end =3D vm_end_gap(prev);
> > +		else
> > +			mm->highest_vm_end =3D 0;
> > +	}
> >  }
> > =20
> >  /* Check if the vma is being used as a stack by this task */
>=20
> =
