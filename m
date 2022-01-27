Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7172149E7AC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 17:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243844AbiA0QhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 11:37:00 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:1762 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235234AbiA0Qg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:36:59 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20RFts6l012326;
        Thu, 27 Jan 2022 16:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=GzZvHY/FvGUDx69ueg1hor0ZJiv6bpOUPfa5S6ScG90=;
 b=UW+YMtrGVbBYTU3bb0mOFjQc1MyyKiOAgf7Pd1N/BcMg++AnF0SP2tCEffQIE4WKTmZ6
 UPnzhXSHqhbz2ozPcp39X1lLSGTQ7lb88ZIYjeFgfd2C/dpBnZixXgJ07LLtwJv6DdQ/
 PxAurEAeVIMSj2H2uJRA/GesU48Q0vOZTWBB6fEdVjdVnVJzPuRwEoYEWLi4mp4JihrH
 1/5SeGXxaXC4SJssIMGFhKwq7uU+bo3F2i+oGaA57s/M8s4+9om1TjMa7C/lG7yq/WG3
 WKgL0Q5KZE93EA/3B7WVLCqZzUNjsK7ObRe0buCHUZfzXIgbxDJElM3W0AGiRmJH5z/q Pg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duvnk8knu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 16:36:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20RGUXo7037264;
        Thu, 27 Jan 2022 16:36:14 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2045.outbound.protection.outlook.com [104.47.74.45])
        by userp3020.oracle.com with ESMTP id 3drbcttk0e-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 16:36:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsoD0X1yqhp8xZik26T4VXaXLPrw5Y2/7RJ6i7AA7Gsvu/uUEOQii3PbZYo5I+2r34wjMVwGDjtuAyasHuEaBbQAQm9wfRYWnaK+gVh+NbmKA46leY4zjCQwzuw9VHrt7bkOdqSxGU4/k2f2JMoLCYyZvBt7Vk3YqcnijzYdxuG+5oxWQJaf8QRv8cwdOPB9clqhiuw3Jto/s8WqfHqlUb2wTrCVX1glfdJqZpyBNrBoEZ5Lo3X323ZlD6eq/BQJQdBNp/MhfINzk9TNa8GBYJxUW9/Ox+HD4qOstuMcTRxO0bQwJdDWEth23D+ABr677m+/YI/cSxo9/R39dLp/RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzZvHY/FvGUDx69ueg1hor0ZJiv6bpOUPfa5S6ScG90=;
 b=M0qE3QveiWYC13mhlTByTuwgt4xQT9b/0++jFy+EVfno5vPrAB3zzl2d2rrbtz3U9L5xKIZ/ZEQ7ajrJEuG5Vme8Gp/K6uNwXFFk0NmA+fPC4I0lyZG8X9TU0i6NCN8SZiFFAyuBFH9UGzsbp2NCcRsvROJYxBxXg43OI+anVFlZQ3duDLRby5Vc6mjjlqmyXcGBKW/bi8woHHyI6NePbwaVgwvFItKy9UnoCnvplTjFa01DrvpKrLB9wgkfYmhNwTlsd9X7+DuMOl7bsYpfOw39egaw9B0Id67OegDhexnUhGt38gpRf2yX9AgaV94rdmrgBo59TXr6P8E/BSYUng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzZvHY/FvGUDx69ueg1hor0ZJiv6bpOUPfa5S6ScG90=;
 b=OvjUMzrzCgDFw0r5/AH3AFhnl2LeB5znQ4pn6Q6sl/p5/Dvqk8o0Lr4ceTc5Yp/E1S22SyvUQALwHQQ/mdyLsxXmX3jOU9RZ0VIPL0Dq6iHF1xbK1pYM7tsbWbNe2tfmX0pKL40gJ9oXPZ8hEGFkREgs83mGGSjCKqmD6iFo3cY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BYAPR10MB2742.namprd10.prod.outlook.com (2603:10b6:a02:b0::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Thu, 27 Jan
 2022 16:36:10 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 16:36:10 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Matthew Wilcox <willy@infradead.org>,
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
Subject: Re: [PATCH v4 64/66] nommu: Remove uses of VMA linked list
Thread-Topic: [PATCH v4 64/66] nommu: Remove uses of VMA linked list
Thread-Index: AQHX5r/8HxPnsXSv40y1GuowyJAhjqxsURCAgAANYQCAABQrgIAK99SA
Date:   Thu, 27 Jan 2022 16:36:10 +0000
Message-ID: <20220127163601.sby4qvqitwj2nvin@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-65-Liam.Howlett@oracle.com>
 <3709289f-fe78-3e7a-649a-a38fb1b3329e@suse.cz>
 <YemFpinGspNII+hl@casper.infradead.org>
 <56968b52-8629-2751-6a95-3bffa84a2326@suse.cz>
In-Reply-To: <56968b52-8629-2751-6a95-3bffa84a2326@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5378b250-e0e6-42dc-035a-08d9e1b3206d
x-ms-traffictypediagnostic: BYAPR10MB2742:EE_
x-microsoft-antispam-prvs: <BYAPR10MB2742CF02B1E0C56A76CAF74CFD219@BYAPR10MB2742.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MQPRq0CrOBFbI7XfChB5k5xQbxmBepdNCh/LaSoUx7VRlW4R0SgUF1CtcViG6ZCEDmx1wyodIKUtPpy/L5nXR6hr0e8AcvLbqHbG4Oybv2OvwUW5fdHNoEesI4q+dPkZ/bYWHzaKIZvmPVUPUSMvSBXrhK1ibTTLH/ulZXOqfmIhgkDohY8ifu/QyrLnJS5uBLRuGiM4hv7LV8EM3SpBR6RhiY+UuGjxkk3g/e+ayU51eXBb83wa6BGmxUrKo+SDegQ0Pky51H0OBayOBaRzKj1omeEru/o5Z7nAvXfv4Qye9F/9+7a9Fm7JGzP8w2tCipWbhupmrQdaNFOoPnH67ICbe1pG628p9W17mtjruuTSyt32xfdXdW6XFTaWSmL7hLi8mpasz/ruWkI4d7YfnyPX2BqiuUz7+Ei5VHhKMv7EGw8wj7hcUOuhk1kf7HyP/vvMGt8GrlbBbGd9Xdd+4WfDaWdjAj+keP4kz5nbpgDTxpTmvxTYoMHb+tGIhEhPX6Uwm7v3kPJ8IeDMHa+ProxspksHcw2Jdnz4Bv7yZkuKwgRbIPoM8hnsFX3RuMXQqeRtisvv0diWXTuXhoKq3KunxdYpLQK4rwryMnsyTIrv5TjBaTJWg4AQJixqIPlT1uEKa4OvKbt6d0QT1cEgo+IpRbTZsI7RiU/3J7DHonaYVs78O+oSDRQ4fHrRFfI+H3JUBzrNoWLAmxO4aOAd+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(76116006)(64756008)(8676002)(8936002)(4326008)(71200400001)(66446008)(66476007)(66556008)(66946007)(316002)(86362001)(5660300002)(91956017)(7416002)(38070700005)(508600001)(6916009)(54906003)(6486002)(53546011)(6506007)(2906002)(122000001)(38100700002)(83380400001)(9686003)(6512007)(44832011)(33716001)(26005)(186003)(1076003)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ngZhxoPQy1j4EEwloImslWt4UMhydHtv12rOfZ18uvKv8bWu4w5zG3VRz2NG?=
 =?us-ascii?Q?qqSEOaksIrlhdR4y+yw/tzRV1yNez8y7VXKb6gggUfTnhug49ZeyC6BOInII?=
 =?us-ascii?Q?Lt+Qgzayl+OtoY3/SkaXf6ztKTkvRT1MbDOxKDTazxvi9DdZPVv3b0tuP9wY?=
 =?us-ascii?Q?GsY4oVfSAIwqBNb0jQ8lUjKt7ui/63kA84FkhqJy4ip2ESlAPKd4qovv5jgb?=
 =?us-ascii?Q?SlI5fzkaPrr7GGg1fb3yKnirFCQdTiJqu2XyONnxHH5M9W3jeFL19ic7JpLB?=
 =?us-ascii?Q?erClQjSznDIp/tk0tE7gaXGkn0AXxk9GkgH0kzo9CeFtFTXbYVGE1Zs+W+qo?=
 =?us-ascii?Q?wE17FGZVk8wx6az7wWJdEiLr/cVNfsjx/qMWKIGWeXjMJdb12IiGWBIfHOXh?=
 =?us-ascii?Q?qRtDW1lTaUWs8Fo0IJKz97S3foQw1KczjXNE22/RHi6BPIMoKBd1bKaO7Ic9?=
 =?us-ascii?Q?zgFlNs4FtRtav/h8pp9KAkITi3/P6mdMJjQt1N6Ny6ezvQrFxkMsq5fh9sww?=
 =?us-ascii?Q?Wg0w1F7vnuTBRz0MyvGJz6Cv+9iIrUaCT1JqFlZwdhR9cEYo7k1CqN346Z9x?=
 =?us-ascii?Q?82/Y6Vjz+yTycdWD+Ws1Bj7kz7w5d1aQDiWsV5afI/At6wlyavBR1A7tfwkI?=
 =?us-ascii?Q?s5Rwq9jdCIYSEqDyuvzQdvCncAUCv/9EOeP0VAlROPs4AimKbUWC05+dWD9P?=
 =?us-ascii?Q?Ul6jGc2GIuXvo3egRZwKVFXhW3KxsKq0sE3nttwMSKLhqcqhQv1xEVU2sWIJ?=
 =?us-ascii?Q?mXEIPyNC5E5YGbKfuU+6VB+y3m6lAqOnV5Zwrr1aGAvcfnUkjeEEU8NUpdwG?=
 =?us-ascii?Q?O9MV+fD04b7D3eXtFc7VVLwK31vaOn/7IR3QBmgs+sUrLsjumau0bRm+vVM+?=
 =?us-ascii?Q?juh5r1IP/nYREUiAu+WuaT7AcCYzAUM5aGRYoAiysLO0ITgKdJop4MXim90G?=
 =?us-ascii?Q?jbVO5EoHPsBeHVGYhQD/GEx4m5ePfn2DEv4+buR38M1PJCXXEkJZGy/RYAkW?=
 =?us-ascii?Q?dZnpwAH6HpBpMs9wMFFzeYs/wYioBCzy7A25sEAGcGFPB3/D8RR5hZObhT/+?=
 =?us-ascii?Q?Z/IxdkzRsmhQPHMRSeMTruPym1UFpaE6JODcZFrYS1d65yVNZEdIAeuZMkCw?=
 =?us-ascii?Q?pGxJ12+1pwLvVkvdd+5on287HHrpVUD4RM42TWzS4B959sOVleUYRsg5WRTE?=
 =?us-ascii?Q?QqmGchLi+YwcbPjt5uDdu0lsjFRxrl9f+CtVE3PAufw/r3dPU6iw7J0UIZaI?=
 =?us-ascii?Q?s2TLMrjEUyrUH7gHkN0han1ibGDSAAzeHpBpLjw8+cwF4qOAlZNr94R+wEWI?=
 =?us-ascii?Q?FWgKG2WtvY4ZKfVU8jBC8syj5RUS6F0izWiI3gCSrjK/cVYTYdkHedWSCdtA?=
 =?us-ascii?Q?YmlIhajPLGoKOC9C/Uek6QhkiMuJecXHApvfo9A6/rVtKpUfQd3VBgcKZE3C?=
 =?us-ascii?Q?LMdlqbUU3u27Bk4bT6bA51Aom6+YPJuNTXaNyXZaqqviJOvOfrgJXZ0Sx+yj?=
 =?us-ascii?Q?MgOE4lyyQD/QcG0PDrUPSBDYPVXvNtmju/3BtyOjrTAv3059kQz/jmIojHzL?=
 =?us-ascii?Q?cyNaVStFxwBarZpFBqJG0Ilyuw2dO8XlhuKnD8i/0OnlYQmFT/0OIx9B+i/T?=
 =?us-ascii?Q?Y6RpZ68LkvrOCFDDW9CB7Uo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7F82A9FCD04DFA4C86D548276E455AB0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5378b250-e0e6-42dc-035a-08d9e1b3206d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 16:36:10.1078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1BzUw6tXIMx87irCPgxPmqPkpait3OdYMnbMKwMWJhvZqg9e+1LGoxz06dVpbQ1sD1Ln30ESa8XndaFOlj8S0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2742
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=811
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201270100
X-Proofpoint-GUID: v91dZw3i4BOEG7qXIPxo3Ts0KjEfdWAb
X-Proofpoint-ORIG-GUID: v91dZw3i4BOEG7qXIPxo3Ts0KjEfdWAb
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [220120 12:06]:
> On 1/20/22 16:54, Matthew Wilcox wrote:
> > On Thu, Jan 20, 2022 at 04:06:21PM +0100, Vlastimil Babka wrote:
> >> On 12/1/21 15:30, Liam Howlett wrote:
> >> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> >> >=20
> >> > Use the maple tree or VMA iterator instead.  This is faster and will
> >> > allow us to shrink the VMA.
> >> >=20
> >> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> >> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> >>=20
> >> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> >>=20
> >> But I think some fixup needed:
> >>=20
> >> > @@ -1456,12 +1458,14 @@ void exit_mmap(struct mm_struct *mm)
> >> > =20
> >> >  	mm->total_vm =3D 0;
> >> > =20
> >> > -	while ((vma =3D mm->mmap)) {
> >> > -		mm->mmap =3D vma->vm_next;
> >> > +	mmap_write_lock(mm);
> >>=20
> >> If locking was missing, should have been added sooner than now?
> >=20
> > I don't think so?  This is the exit_mmap() path, so we know nobody
> > has access to the mm.  We didn't need to hold the lock at this point
> > before, but now for_each_vma() will check we're holding the mmap_lock.
>=20
> It has crossed my mind that it is there to make asserts happy, in which c=
ase
> a clarifying comment would be useful.

I will add the comment.

>=20
> >> > +	for_each_vma(vmi, vma) {
> >> >  		delete_vma_from_mm(vma);
> >> >  		delete_vma(mm, vma);
> >> >  		cond_resched();
> >> >  	}
> >> > +	__mt_destroy(&mm->mm_mt);
> >>=20
> >> And this at the point mm_mt was added?
> >=20
> > You mean we should have been calling __mt_destroy() earlier in the
> > patch series?
>=20
> Yeah.
>=20
> > Umm ... I'll defer to Liam on that one.

Yes, I will move this to the correct patch.=
