Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C184A89D6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352791AbiBCRVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:21:25 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:10010 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237876AbiBCRVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:21:20 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 213HIjjG024324;
        Thu, 3 Feb 2022 17:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Uao+6Nv6QJmWVq5Oyl8Cm9nQOPUayovtFQX8qTRs0M8=;
 b=RmRVtn8q4knbmLef/OMWceaLrwyMWXqjOsq7+5MAQQvu4upeeQuDBIPXrrhpflu4P1ra
 rc7vUiZJOSarklz4valYYH0apD9R/qAB0qg13OkSf3SvOJDVZFFVfFCEJkf1EEq8Mrqa
 1WUw74cMuCkLOtNj1l0T5bYlHicVzZRuYWIUCsD6zfMPDijOA83Ko141DSVpSbr2Rep0
 LITkJl41DGDRyQ8Qk87ZHIUVb0aWmN9+SXIvKbMkNZOHaWMBB8mtb+IUTSWeQcNcTtep
 10Ou89s37LR5Bh6v+ii7Guv1Oys9uNuZyxVZY4LNin0uewWfvXx/95sgbAcMEht6E1nU Qg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e0hevrdr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 17:21:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 213HFHbt012193;
        Thu, 3 Feb 2022 17:21:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by aserp3020.oracle.com with ESMTP id 3dvwdasma7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 17:21:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkcLoqqwOwVkT41b85NtZgbZi++XhN+qK8/grzx74aA7yJuW1Uq8gwhfR+47Fq6O2GycnzALFsRLlLGTK5ryozqrswYEIExXjfz31h8N3pe97iXr4s1lNZ3mWSCXUz1b0jqK5MTeLRzJHvQNFiPqWZlRkG+GehMZDGlD1Twd5M9RmT/dWVjx4nHXDBGkuwBEOIpGStvzGYWdFMCH9h//ZG8086tZipp8V2Rv+ZQD6qL8dd9DsHwVOAEcHGgqqtxc93odDdICDVF4dK8L3AwRkn2jAH6MOHcCbqocN8OCEuPZran+qzOab6PEPHpkGXUq3NIPTRaH95lzr/y1KAZXMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uao+6Nv6QJmWVq5Oyl8Cm9nQOPUayovtFQX8qTRs0M8=;
 b=KK/PGEeUxAivEWSYvtFvcP+FcFqMk6/RVreNDEUyIoUGMbr4bO/0Yq31tuKQnlNONyMTBFvGbG6efYOiYFqA+tX6qJqFcWsM4XBIfDPTU6GPfxvu8+Ge+mkUX6mOQJZxNK2AwUjlu/vf9b5BbhiwdKM/UgEcf0P0R70mNCmJIZxVzTQ+i6llgcsD9msoPPdHghYza7mK6D4UJCrmvoVmxycd+pndAUMB7SdYIg81LSAlCHqZw1O0hDEv/LgtxEZ72X+lmdBJAK0xl8JnzNrDkMv6Ruthh1iWMh+sXBHqfbP37j90SZ21IN4/JUjSf0UZqt1ydAJdefRrqS9w+5swTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uao+6Nv6QJmWVq5Oyl8Cm9nQOPUayovtFQX8qTRs0M8=;
 b=zcBO7cnz4YKP01SmNnRiQzLUuf2wkOoASxzLkMJjrW7N1wxtMPs063T5F2IzLTiLQ2GcgGnwXh0WMo12FagWENlgrlRXNCZjPJtypKCc81o6MUOJPic4QhygG2dS1InqZk0rowle2pbhqzWs8ZPci2VtN+0V4A//noIwzXquWeM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5059.namprd10.prod.outlook.com (2603:10b6:208:327::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 17:20:58 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4951.014; Thu, 3 Feb 2022
 17:20:58 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Mark Hemment <markhemm@googlemail.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 15/70] kernel/fork: Use maple tree for dup_mmap()
 during forking
Thread-Topic: [PATCH v5 15/70] kernel/fork: Use maple tree for dup_mmap()
 during forking
Thread-Index: AQHYF951lzhurrNAW02to7QCIMdfV6yBu18AgABZrIA=
Date:   Thu, 3 Feb 2022 17:20:57 +0000
Message-ID: <20220203172051.i2jnhnkudzssdsxg@revolver>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
 <20220202024137.2516438-16-Liam.Howlett@oracle.com>
 <CANe_+Ui4tud5pnBx81qG-4V-pgO5XQX-rc9rXQWMCi6qqY5bew@mail.gmail.com>
In-Reply-To: <CANe_+Ui4tud5pnBx81qG-4V-pgO5XQX-rc9rXQWMCi6qqY5bew@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea98e3f2-1516-4ecb-e2f9-08d9e7398b16
x-ms-traffictypediagnostic: BLAPR10MB5059:EE_
x-microsoft-antispam-prvs: <BLAPR10MB50594CB660A4663FF6438355FD289@BLAPR10MB5059.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NP1B2bAoTGHhCSK7R6Nr+sAHkNArETdGuRCQG7P/nMqh2MA/49yX03S4pN0gufCoyGfqw3Fz8huWw4kpvaeJ+wTtmtKZBjNHzEIm86THKPQpILb0/UrTGjl0ZR4781krOZWa5U9LfhVBH45ToNegOYY1LJkURtKynvmcbwUK0m2tAcw953RstOlsxaq/4oIq0GktUKmYzTYJHH0z923lR3+/llxgZ/eKdke1gPWGpUShCG589sXpR+CEa30oqdxqOVvBKrWftaxSqD0JKY2uH5ftk/9KuyPsDUaYmkJS5vzuinf9qFL3QAadsi+luIdvbpFfxn4/+oy1fnrMdae1nzlv9D1SjzPLSBpOGgKzUpg6uLX48ZZDiRJHURTWsm1wjVlavsdoRUmSBllSDuECFz8E31PvtfwBJPU+j+nn2fG5ghcVG08/zrp1XQ5yXUV95yQgd4mG/DHTBnm85iXfon9HyAaPWdHKmNpeQ6R1RmjX1xSzus/K4Srzyk981JV/w57spGjDWd3LVDF1oadTw9yb6RKmU1vCyPwlqXUbzUvusDGIDRyGXJqJVDvEllzQx7JqwkE48UrxikyLFbtk3bW1LoZUqz3TmfWs0OwGIQS5Y8BakW/Rs1aY8dfcthOFs5KodWJXcTn7esjtLoq2wq7CebMsE+1eZDHJV1cShqU2HFTnDuZlCsj81wdQZh1atQBXJcYiRtXmQPWjKph8cw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66556008)(71200400001)(122000001)(508600001)(83380400001)(38070700005)(6486002)(5660300002)(64756008)(54906003)(1076003)(66446008)(66476007)(2906002)(8676002)(4326008)(6512007)(316002)(44832011)(66946007)(38100700002)(8936002)(76116006)(9686003)(186003)(6506007)(91956017)(33716001)(86362001)(6916009)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DLW8l/mPFRIO5OF565fskXxWCg1RlfFNlNH3b70RZh65RLMGhELCTZDsTuRL?=
 =?us-ascii?Q?fBhqBhSJkCgh366f8HsbmmZIR5jTrhqjrIO3+6haMoKouhWTRYgf7lZHy3W8?=
 =?us-ascii?Q?YcmcMMfscG3kIqEmMOLKp/fGjh5etObbgrIDW3t8wgFFBkkO3Q/03GL+bg4e?=
 =?us-ascii?Q?8+DIOBtTOT/ciS9/jRj8tyWCbp5Zw5rnVH5U7JmffY/l/h86fjq/QXEeTCNs?=
 =?us-ascii?Q?Dik8YMkDiOOWRgLxfihxC4h65RR6l5Ku+aVkv4ZrDxmNUhdqj3sNyzR1IOn1?=
 =?us-ascii?Q?dLi95ixBMwihFLCvIjSxP4wOTmx7yu3VEx4cjF1TiAmsJYAqLaAUIn9Qr+4V?=
 =?us-ascii?Q?utWvfj8UM0ZidUxk6lw2OpFdfnCKC8zGpN5rxhyM8CvhzqS4EcDd/w/75daD?=
 =?us-ascii?Q?TOBkUzNSb4nqD6UgpBhUuMV3VZFs2msmFJS4ZsL7RUpWDeX3pOQZOV7bSMbp?=
 =?us-ascii?Q?K9Mom+EFIdl9T+TMb+FBKbPPctic+bvF2+QRg2MnfjP9FmugpSenszeWBgNg?=
 =?us-ascii?Q?ja6SUUsLKCP1oApZ/UBNvprh02TkTsTQVy7IZqEok01moteYfdXQ6YGebrUX?=
 =?us-ascii?Q?FzGI1K+/3t117NobTYIpcMdFpz2bjL32EacXzjOaZ42h3wDeKO1WDVUrLYZf?=
 =?us-ascii?Q?MQhelSd4EgzM4SMemMGQVkZDOSIyzAOR3gOiMBYaBbMbg46TRdJctdt4sYB9?=
 =?us-ascii?Q?FnjUbfgHgQdrxAlLcbvmwUbVvXSCJVGY3CsbWXDVcwUNtH6NcdGjDyZ0fqI4?=
 =?us-ascii?Q?OUZME/hWSegXhkcit2YllJDR4RBkv0VhgH4+MVd+WCgBlQks77kaAsN3t9cZ?=
 =?us-ascii?Q?cCZImbryn76RS07S4OtUCBjzsvKGBJzdLWYndQqU2kietLtHLxaNyQFsjspW?=
 =?us-ascii?Q?vyOOq2+B75CbZgqKh/lB7Q/7FPSjx4G7w8EWbUmjtl++cy4/kWKJnLzEESwI?=
 =?us-ascii?Q?IZs0kvgRly5nVioQCwq1A/7Y5JSOBLoAikL+tzyNfsoUFZKv5jjVvXNHGDMu?=
 =?us-ascii?Q?72TosJshc6Vu4rX2rhfpaytty6BR3P4YoZnM1USxDRm3ivBmXkTPStgGcD2D?=
 =?us-ascii?Q?dK0G75KjNig3vcoL2Im6BpI84Bv3hjXK6Bb3pSF78jD1NdJ+aBQCdUHvOoG/?=
 =?us-ascii?Q?t91sJE02sfjCZO3aaD26xmSO+PAUKMUJjyEaz+EdrQDjyoyErKDrOXPVutkH?=
 =?us-ascii?Q?a0Ru94EOGMhzClXpzSmRxlMzR7HEzAqnWZSxAFWa6TpuM20Ert5dcjRhs7Jy?=
 =?us-ascii?Q?c5AGfc+EVXHTNUtQMR3NkaeYyVl5xbRuDA3EnMOnZhmrSoBZMIeDK5eajcgs?=
 =?us-ascii?Q?FhHejsmNj4YSjT8WRQPmvFEFgiCEnlNHjWk0Hp+XS7UOqAfatoifh86q6fNb?=
 =?us-ascii?Q?zdIJlJaNjEyKuurVBdaezXY6vlDHXaVSLuPnlBNiwCzIjW2FCnKbwIlgCJeo?=
 =?us-ascii?Q?sSGaN1SanWPs6G6XdWeFp9mFMOqnjU19kyWAbAboEONDFBWI1ARsph/7u2x1?=
 =?us-ascii?Q?/zU79TesU/rF3ZbMewVtnVsX8ukLGDT8z+qU7q762AjRb37Nw7Sf2uUo0kCu?=
 =?us-ascii?Q?Leg1qiBmTHVeLzOZTxgg5fpxigd6cH1HvEwikELDIgzglHrSlu/7e0f9V8y2?=
 =?us-ascii?Q?s69SLdnzvKLb3ngQJmmkX88=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1D0F182E2F3FF2459CCEA6A697C3F6ED@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea98e3f2-1516-4ecb-e2f9-08d9e7398b16
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 17:20:58.1695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QrMq5uJJMXcF3WlMWFZoAnemBTV4jNKO7t2L+Ij+hEt0WtD7Dvq7n1b0ofYi9gb2JS5BwrjgdLRLcM8OUiQagg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5059
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10247 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202030105
X-Proofpoint-GUID: wzrMnO3Kdcz_j5YzRV3tRdriiOkevW-5
X-Proofpoint-ORIG-GUID: wzrMnO3Kdcz_j5YzRV3tRdriiOkevW-5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mark Hemment <markhemm@googlemail.com> [220203 07:00]:
> On Wed, 2 Feb 2022 at 03:23, Liam Howlett <liam.howlett@oracle.com> wrote=
:
> >
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >
> > The maple tree was already tracking VMAs in this function by an earlier
> > commit, but the rbtree iterator was being used to iterate the list.
> > Change the iterator to use a maple tree native iterator and switch to
> > the maple tree advanced API to avoid multiple walks of the tree during
> > insert operations.  Unexport the now-unused vma_store() function.
> >
> > We track whether we need to free the VMAs and tree nodes through RCU
> > (ie whether there have been multiple threads that can see the mm_struct
> > simultaneously; by pthread(), ptrace() or looking at /proc/$pid/maps).
> > This setting is sticky because it's too tricky to decide when it's safe
> > to exit RCU mode.
> >
> > For performance reasons we bulk allocate the maple tree nodes.  The nod=
e
> > calculations are done internally to the tree and use the VMA count and
> > assume the worst-case node requirements.  The VM_DONT_COPY flag does
> > not allow for the most efficient copy method of the tree and so a bulk
> > loading algorithm is used.
> >
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> >  include/linux/mm.h       |  2 --
> >  include/linux/sched/mm.h | 13 +++++++++++++
> >  kernel/fork.c            | 35 +++++++++++++++++++++++++++++------
> >  3 files changed, 42 insertions(+), 8 deletions(-)
> ....
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 51a7971651ef..8ea683fcefcd 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -377,6 +377,16 @@ void vm_area_free(struct vm_area_struct *vma)
> >         kmem_cache_free(vm_area_cachep, vma);
> >  }
> >
> > +void mm_set_in_rcu(struct mm_struct *mm)
> > +{
> > +       if (!mt_in_rcu(&mm->mm_mt))
> > +               return;
> > +       mmap_write_lock(mm);
> > +       mm->mm_mt.ma_flags |=3D MT_FLAGS_USE_RCU;
> > +       mmap_write_unlock(mm);
> > +}
> > +EXPORT_SYMBOL(mm_set_in_rcu);
>=20
> The mt_in_rcu() test looks wrong (inverted).
> mt_in_rcu() returns true only when MT_FLAGS_USE_RCU is set, so this
> flag will never set here.
> All callers of mm_set_in_rcu() check mt_in_rcu() so the test here
> could be removed.

Yes, you are correct.  Thanks.  I will rerun my benchmarks with this
change.

It's not a critical thing at this point since all the vma work is still
under the mmap_lock.  But it could affect performance.
