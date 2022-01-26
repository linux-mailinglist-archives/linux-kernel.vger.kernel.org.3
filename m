Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F5C49C15F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 03:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236458AbiAZCev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 21:34:51 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:53924 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232619AbiAZCet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 21:34:49 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PMn6YP019615;
        Wed, 26 Jan 2022 02:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=gTbIY7u+eMx2HHxWJQLUCR3u/gO2rulPImejZtl4ycU=;
 b=xZJ5OLRSNtmDd+p8o85MytNvw4ul9/S6Apl/zGxM3mIXHYSa2OGZRvGzAkHAmYPhti0U
 srdnoeF1ZfSdZYbm9qCSpQ5FyyZinMhigQU1XmaA2ABvQ8XyQYeJHPiVoX3dF1E5HFBM
 2o1s/FcpWkJPRAzUTwVuc9G+7+DqM1/dMecTllTgDY5Y0NNv6psdlQbq28fm5AsDGD3B
 CyZkEcZTZS7c0D7YX2zjjbDd/1Yhrz/Emhce387UkrmLae3IyFrGodQpFe4j2atkZuur
 4BtKkUBmFkjUkQ7MNITBL00meeKeHBx4lVxjp4B/SsmmmGU5bDWG4R5eq9dhwfy9y+6k ow== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy7aw2cp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 02:34:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20Q2GRG5177688;
        Wed, 26 Jan 2022 02:34:26 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
        by userp3020.oracle.com with ESMTP id 3drbcq74m4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 02:34:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVx4FQ8EveXPhy3+xEnHKqNcL8+EUip7P0V1/ybDR3oEc2xggs5jGkS4Pkh8ioY8yehzMJRvyRlVMkePGim5h7K09jxaC9jDsJT8QaxuV/jUc7xELZ0SZ0/XHTyQk2Bc6luCJ0UoBPN0zRgvoQYlbMnQPsGCVTE5bhbswjvxhnSXqoSIJ3e44Pp5ofcvbwP4iMUxRG/PBkLEKLPzKQA1uq5FYsYQogbTDX9zKBGVZr2zrJ0q9cdQ/i8Fu0pBBhnltXSb8wz5tEOkPTbifn87XUUHFHZIMbgZe3lttSGHG+lgWenHa6x737x9hddeBEKY8JIRGmE3pQPgq+JGBexLyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTbIY7u+eMx2HHxWJQLUCR3u/gO2rulPImejZtl4ycU=;
 b=drk/xaBpaur5Y5IPmxPUB6ex03V3g/wVuMEDtgL4v8d0rQWxbf3BKOXbQBLKrvyXNY9QWwr+3uj5eSjUi8DduJz4TCkMqnUhZv2nQK7vWoNW5/XAobsOOpSWAw1c94qD7pP8X6PpFURBVQcuUyrjIkDs2jTbsh1u4HOKQRa1663hcB59JqzVbODrnqRjdvl889W646M5V7WgioIwLgY7VCwa36KYnr7tIH96C1gIDDYfD5SBjWmd34RhB74XRdYOZa18bhkQtlZ9XAcLk3FbFmCWelXZ3tCHnJwqe4103Q+3CaXrr2NUHGzkaIQybk0zmrjwk52GXNO84mbBoQEdtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTbIY7u+eMx2HHxWJQLUCR3u/gO2rulPImejZtl4ycU=;
 b=ua8EzzuJ5oeeV1a7deDywO3CeitnfAQblwwt9XZJJutIhta/odLhGh62SNJdjYl/kjfbdBLH0n9WPQZzvMAMAwIbQQ9vyjfiJfXZnAusqy1EXszl7HSSmIkjJlTJlyPdGpN0l9Agchfx67AVPxTvo1CLSzkK3jz3kFDthkS3IN8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4454.namprd10.prod.outlook.com (2603:10b6:510:3a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 26 Jan
 2022 02:34:24 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4909.019; Wed, 26 Jan 2022
 02:34:24 +0000
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
Subject: Re: [PATCH v4 54/66] mm/memcontrol: Stop using mm->highest_vm_end
Thread-Topic: [PATCH v4 54/66] mm/memcontrol: Stop using mm->highest_vm_end
Thread-Index: AQHX5r/0O9Cuh4hAxUG/bXy3RaGp8KxsEj4AgAjasQA=
Date:   Wed, 26 Jan 2022 02:34:24 +0000
Message-ID: <20220126023418.p5m52qqqvhlek3nr@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-55-Liam.Howlett@oracle.com>
 <3d5a348a-1c99-9cb5-3279-31a9419da032@suse.cz>
In-Reply-To: <3d5a348a-1c99-9cb5-3279-31a9419da032@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d6fa651-d777-4513-195d-08d9e0745db9
x-ms-traffictypediagnostic: PH0PR10MB4454:EE_
x-microsoft-antispam-prvs: <PH0PR10MB44545A7C62FEAE78353656D0FD209@PH0PR10MB4454.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 66xpv3EI7Q5LYcQ3OIaPuMfbm2i0LxvkYwkngsggwr40jgbb3MGBXEU00mu4F0a9wIK0b+cHBBe+aR8ZbkCoIk+ezMMbF+337cTv1DXyIIvARv7Jx4WUBNxvzsje7/RSB9AOk3E7JeqLhpNgT/Gqagx3IXFqZt0ms/N7zMU0EhYIIGnNiy1rebj9z9Hi2EYhlRuOxBMxwdQyBc29Ov8UJmc2sCo3CeYfAuhk3GyFnl0PXftj90ipdJkJxFVVjVf+tDcQAp4GbQQhv/qcICYzYJsFuSnelfImmBTK23+1NcZekbaUE1LGdxXEbC3YnghtxRYPdY1MTvl0QE1pCs29jpdpB71XpsT4Rhfc9WvobcwoXP/3Yr02CZnMwOXU9SrMoZv1LixCY0YBHIc3y95U2OGBr5ROfzMlZUTHviFSSyzd34vIDRsX3uttHKmlvbgyNCj28OOcddYwl6ruTNBr9OajAwVDuPP5CmSEoIOGZ4hJqKf/nC06Jjb9tZIOG5bAW+x5SSc1GbiHKY45mD5XbKD2oXxWdyW7PXGuh/kBnyxIfVGwPIbPqmm7l5OPF2fFdqO7e69onf/p9Wg3mKr2wLJxT3UxQeEcYdSx6CY745Jtjn4L2/+q7bz2j85RYP3Lcofw+O2tHVmQWy+j8YDmI3m0Bx0Azg7dxZ+fPDB04uTchERnGyjOwROedSUIi2bUFaYG9VnDuJpASEQljrrNyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(9686003)(6486002)(186003)(38070700005)(44832011)(122000001)(1076003)(26005)(316002)(86362001)(6506007)(53546011)(71200400001)(2906002)(6512007)(54906003)(6916009)(66476007)(76116006)(8676002)(66556008)(64756008)(66446008)(66946007)(7416002)(91956017)(5660300002)(83380400001)(4326008)(33716001)(508600001)(8936002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SvtwqtEsRrgtN2bozGyrZ9ti2j0k/VoZG/y/B5YV7AnHfJtLIDBVqdrMmWLG?=
 =?us-ascii?Q?MZCWs1tARRMuSE7+KU6UNNfaMZgsExMONjBqI/1oLKs1D1gbd6Z4q7HIf1Rc?=
 =?us-ascii?Q?e6DotyCouFTQyVxFBXZe7PdirbhAch0I1fuz+MYKyEtZyx6QNd/1lq52ngup?=
 =?us-ascii?Q?kuW/kgTQv+yiQYXrhoHUkOZOGpdxvpH8iaPyXVkTtzoMXBdb6mRQnhXhNvSL?=
 =?us-ascii?Q?/YHavfNwWsYAdl1g2AmOkaed4iZOTHQLO84l/Ph/eKENNOQ4MOamuRdMGr0F?=
 =?us-ascii?Q?NcpsWHi/acSY9HiwzSCSuuP1IrBuvXdx/cWJVtw51ZDsSfWwZAXmFJ08uARj?=
 =?us-ascii?Q?1eemiBex0CkptnMsv7YxEMXkd0wm75BeoU773pPj4GGsSiIS85fKQ5fX9Wma?=
 =?us-ascii?Q?62maDK27LdowW9lmKb8sI8ePnA4KIMixIh8dkD0PT0KkgobiJMgJB5qLwKsW?=
 =?us-ascii?Q?6LVFbdrbMbFlD1lp8okTfGJ7ZKXCl3h95aUWpt8HdscZ2NIgzAlgZMy3DMBw?=
 =?us-ascii?Q?foi5XGPmfHhESR4rwRGKRMh5kFTO8J40dUzGyD7eZaF+cVoJkeqhUHpTORPk?=
 =?us-ascii?Q?hDDCK5TZ9Un3xh6I/tCXkmN+2C79XKBrHIgszPsKCFfMx+PvqVkqhkhPMGR2?=
 =?us-ascii?Q?sJgapQWP7F6UdVnZ/a3FqsJXqyHhqVUyJ3FzleaA5gSGuuS8VIsmQBni6Ph1?=
 =?us-ascii?Q?jlRQ21uMWL+CXrs+SpW6nCsfdZ0Odb8VB40qHS9z6QU8VY5+FNY0mrHH39Mr?=
 =?us-ascii?Q?TWvA8AyUH+3HcN+M5YKVystqEZTXQGiO/p362yusfg/Jio+P63H7sy44Zv9G?=
 =?us-ascii?Q?6xHsx962yJ/8cyZ0bTn0qYXFZV5OPu1PCCSWgA2E2SHCJiHsADlNR4rVLRJO?=
 =?us-ascii?Q?ZbmABEySh4zMLA7XSQNaMbyp/VAxN/x/XAQ7Gs0eRHxmdtMZgODKtUvDhs6B?=
 =?us-ascii?Q?fIyhGUN/8jFBNiMMJFGuookXC823kbFw41Ab6fqvKT/zD405McRQjlby+9+b?=
 =?us-ascii?Q?dOOIXZqZ3f5Ui1FmsFcYr9XoifT4lS7KTQ9IXxj6/Vdm5Qkv5MHeX9giBz4i?=
 =?us-ascii?Q?wnxW77emcCsmnRRUp6OSksv+4ry4gcAu8s37U0zBrmBMAlSo4feF2QLaswhI?=
 =?us-ascii?Q?nrNCa4A+Lh1L8qlpXToG8f7LxkrQxYXHoYHk3+sspe8/3XE+cK/X3A4mLfsZ?=
 =?us-ascii?Q?pyq54IjpwUPvAHmaC48ZDSMAofS9edshMrSzy2c/7GWOG7jQJuRTieqLzP3R?=
 =?us-ascii?Q?dquTHzINRK7+LnFOtkG38lWaHx+lf7NJ+rqKgHkszVDZ/yRmQ4dl3ZfCTPFu?=
 =?us-ascii?Q?WO3VIFPCsJei1AHu5MBfDYeIE4CQuj9esC6qFqNoFQXK1FOdlCiyOvTF68CK?=
 =?us-ascii?Q?lMJ5kgfr1ngKEp6bsvOvSSRkjLA+bP37ySe2KJkIaMmIVdHQ3lWANQqjpYDP?=
 =?us-ascii?Q?rqJsT3PTZ4K7cWcWOmvQY5Q0BdeAIbQnBJGeRR9ignE3NBbqM2cBFKSXBAsL?=
 =?us-ascii?Q?bco/qkEgTBCX8+71eviucBSqu2wDfllZ8WLZOVuzKvZDAjcyhVJvJTk9CiOv?=
 =?us-ascii?Q?BVzv/Xt1brTh7HGhyapwPn9naZjK9BdbpIFOlgh+eW6dAUapFPX0KxQRwJY6?=
 =?us-ascii?Q?xeYZs1nbjr20ou0q1nDHvBo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <171D1A0D26EF4F48827920D9122320E8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6fa651-d777-4513-195d-08d9e0745db9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 02:34:24.1782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ae5PRiTqFON181wFbzqByN3mA13WT5WG2zb0BAIehLj214CM1K7qJnjdtMEBvuE5Sl9QNYOrZN15UX186EjBNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4454
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260008
X-Proofpoint-GUID: fgxkf3PmpzIbz-uXbAYBLPPJtlMFUxkH
X-Proofpoint-ORIG-GUID: fgxkf3PmpzIbz-uXbAYBLPPJtlMFUxkH
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [220120 06:21]:
> On 12/1/21 15:30, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  mm/memcontrol.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 781605e92015..ac95b3eca557 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -5808,7 +5808,7 @@ static unsigned long mem_cgroup_count_precharge(s=
truct mm_struct *mm)
> >  	unsigned long precharge;
> > =20
> >  	mmap_read_lock(mm);
> > -	walk_page_range(mm, 0, mm->highest_vm_end, &precharge_walk_ops, NULL)=
;
> > +	walk_page_range(mm, 0, -1, &precharge_walk_ops, NULL);
>=20
> Wouldn't ULONG_MAX look better?

Sure, I'm happy enough to use ULONG_MAX.

>=20
> >  	mmap_read_unlock(mm);
> > =20
> >  	precharge =3D mc.precharge;
> > @@ -6106,9 +6106,7 @@ static void mem_cgroup_move_charge(void)
> >  	 * When we have consumed all precharges and failed in doing
> >  	 * additional charge, the page walk just aborts.
> >  	 */
> > -	walk_page_range(mc.mm, 0, mc.mm->highest_vm_end, &charge_walk_ops,
> > -			NULL);
> > -
> > +	walk_page_range(mc.mm, 0, -1, &charge_walk_ops, NULL);
> >  	mmap_read_unlock(mc.mm);
> >  	atomic_dec(&mc.from->moving_account);
> >  }
> =
