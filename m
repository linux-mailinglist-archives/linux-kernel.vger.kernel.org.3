Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC9848350A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbiACQpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 11:45:55 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:56574 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231448AbiACQpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:45:53 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 203Femi7021728;
        Mon, 3 Jan 2022 16:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ZxbWMzcb6T5ccR9jvtrKAWCMwZvUVswjzeu0W6AvpSM=;
 b=dwzWIevd5a8bub4cWBn7RSWMZ8ItvxHXXrEkALyLx+wzHHnF2B5UlwoSmxt4nYFYRAGx
 7H29svMBV5qy3IZpx66ojHJ54tdzN6oXqCPUY+zUSO63fV+ezX3ssPiHUEjjRotuXZLZ
 FKutJd+zbMr5gBLo4LJ5bjFoIM6e+SV3JgwSMJg+W+huy0lxQRjHWKqkqohUyf5KzKxk
 NkYdQdc4IRLSjNRx500En0h0Il3RNjHSV55WsZ5MsyIRiYk+iBw1PciIlg6enBTPo+Ny
 SnlloOOHqXpWdoio54LMdPA7C54RQgRTYtVhFkAVzOAvc4FwIW4fdUfBBLN48j0Mc4me lw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc40fg5fd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jan 2022 16:45:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 203Ge1Qv010956;
        Mon, 3 Jan 2022 16:45:11 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by aserp3030.oracle.com with ESMTP id 3dad0ca8ec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jan 2022 16:45:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pjb3ZajCJyWziidThgPn7ncuYLKYnAW3pxgmquVTXA+x/6pCxTheQXlYmbmiyiBUq3L52cfzmwnozt2ue+bOerOA1Z1c46RIGsV0D3NwCzvY1GVYG2i2E2ZzskXtzRpDkOfrfwKtwEtVfNrk2DCNYjxzul2c7sXYUKol9soBDSgKpi4Z61IJorELwMA+0iH20jOx/EDKq5G+CvUfGYtJ0NpfdMFoZ14U6a5ea4d1TBksDLm9z0irVBDoCqllj6WCuTLwDv+Ju7q2LmpNtDxkPyRkd5yW498cPELcWAO5knWJoatYSEprNoYoVWMltSFo/PDrv9jMu0IryKGNoj8MBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxbWMzcb6T5ccR9jvtrKAWCMwZvUVswjzeu0W6AvpSM=;
 b=aEe/4dEw72Bi+uKqHbN1r8ORrIGMUPXjxoiNrGoFiX/ChQ/9KKaOFBmoongIozAVaysor/wFt0x8ISOIyxsWeSzLgbErHnhJA0PXgyrrtEXp8h6seA1LQwgflhWM5s32aUsQzXUHE5ufKV4frrn754emRIXxnM/FVkkV89y05Veiy2Nh6ylB/lBhZv+55c2VZ6AcnqULGRMCzPb+KMSVqLBToNBTq45q6yT17ADyqPkEUZUWIi9WjE6InbCRSuF102czOzMZx3hJqGMRpDcSF+y790TbqBVWu8j5RveLmbMhxBMwpGAlYqtAmDgkFG8b+TSy0srRUvSgnWYFmpajwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxbWMzcb6T5ccR9jvtrKAWCMwZvUVswjzeu0W6AvpSM=;
 b=U2DjjVc1vF+QkofF4mE1gxehjLDw2bO5ai5zzBuoTm2EbzJ2MeuePmndItg4h35ZjjvHRGGkoJTWONNfwdq9ZCkt51EJBcVaGGDUE2pQjWPX2MI+B+2ASn8YikCbN+KQj3ANsQtMU3aRXGOAA72PEaQMxdpEN4YzjSdGFOVSjS8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2990.namprd10.prod.outlook.com (2603:10b6:805:db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Mon, 3 Jan
 2022 16:45:09 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 16:45:09 +0000
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
Subject: Re: [PATCH v4 12/66] kernel/fork: Use maple tree for dup_mmap()
 during forking
Thread-Topic: [PATCH v4 12/66] kernel/fork: Use maple tree for dup_mmap()
 during forking
Thread-Index: AQHX5r/o3KEVgjJQgEmOR6p6STPGPKw1DTeAgBynyYA=
Date:   Mon, 3 Jan 2022 16:45:08 +0000
Message-ID: <20220103164501.es3oagajgzxnmtmm@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-13-Liam.Howlett@oracle.com>
 <d54a6f4b-5394-5191-19aa-1b24cab40ba0@suse.cz>
In-Reply-To: <d54a6f4b-5394-5191-19aa-1b24cab40ba0@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f3df1e5-343b-42da-bfe3-08d9ced8674d
x-ms-traffictypediagnostic: SN6PR10MB2990:EE_
x-microsoft-antispam-prvs: <SN6PR10MB2990CE37014D2A8993A15A26FD499@SN6PR10MB2990.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PcvX0UhCNGvF7M4frqfb4mY6j9twEuiiR9F88IQL3H36RLycqJZNu3fTWo6DnjZTAu+7pmU5LebQM28YGP7pfMv502/4UIvLHsAoKx+FQdqLce0x8Hoc/27cZcReEez+G9ReXAs3OkK4SqdB1+To758k5IwOvWIe3qpF4jGFTsbBk3xhvjRx9IEAg0UO5BV/9AndLvsNs/kRxGG3Ia4cZl0mmCPDcQdo2Ze8iFj79DL3WqPlqZ2+0sGf21DL4PSnV7SfWeHigLfGyKX4hNk8Cwxl1MXrj1TKlaNR1VfO4VLkd8imOs5O/Mln5MvEYrYrefuD4N13jlkw5YhvY7f09g5O44q+I5fkMJ9Qv7w+2cNxHJztsuNyNTeadZ3LhEoXGMuF3JOxhfzee7tgJnspIaeLX/nuvnPE0Ss/mHhQ6kfNW6oiHwrlE/EBuHWYGa54yGSb0AU51mQMieRjb426XXyKR8QNd+VKwcVaXkrpA+9ooZbxBpKWFcZ5uJtfZCK/xpfpIWzmp+nRKGu+YGn8YBcinK26ps5VrD4cYtaPtRNEeBMrcQ/f55Pp4fCRKSpBls1psuY1N9lpvpJolAaeSrgrhPrh+V20WVLyjU5xJlGaSIM7a/u7Xx35Olq/TZh3MEjFflFWZ8BNNgfE/8GtxBxpa8moYhICjyLBgw4PW2qHjmRgY/DZ3lVmlNWAWaXoNRoju5Jfq+KDkMQeDgoS/MHFuKeGPQiLJwqrb2IsHfOnrUEV72QUYwWNImFMHkBBioCwv2j9VWKMBEHTeNXXEhwc2/eLEhOCf3jhTUSSUHw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(38070700005)(53546011)(6506007)(7416002)(33716001)(86362001)(186003)(26005)(83380400001)(44832011)(1076003)(2906002)(6512007)(122000001)(4326008)(316002)(9686003)(64756008)(54906003)(6916009)(38100700002)(508600001)(8936002)(66946007)(76116006)(66476007)(66556008)(71200400001)(8676002)(66446008)(91956017)(5660300002)(6486002)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h19RQNu4TqOBzMt1u5zeoFc17zhUG4S+pHaMxTFEMZ3fb33LQHr6f5USDOAu?=
 =?us-ascii?Q?UoPVH+aqzrZKXFZakX0WIYvNrPsYL/PBGwjcTHraOIsc+c6Z33Tca+uuRoNW?=
 =?us-ascii?Q?+3NoYD5GhUI21BAI1xoZOIKF43+VSvGIaF6q/fYw4kqB9LfXuzRANzOKG0mq?=
 =?us-ascii?Q?jpsEBoZkhWVYvcEXGEMFXuEUQ+//WVc7H9SaG/mGr+GFqYom4TlL1SKHfzuD?=
 =?us-ascii?Q?pSWseYQIf00zwkw7F3SgcK6+XFlJg1kByWA+ccI1q3e+tijvjz2HkmpydnlJ?=
 =?us-ascii?Q?vSM9c5RHiUWekjXzB/AHwzgvn6m5hUEiBioMig+grOk1xI3B2QkcrPfXvzvb?=
 =?us-ascii?Q?A7EN3Vtvps8aBlZceo/YH+asc1bkUno+upznb9+cJXUmILYnhobJbRDEPgF8?=
 =?us-ascii?Q?v7VSwTct+kkuHsska+ZijlStxv80CuSbEpaaHDChVzXTua+t/pELvpXLmKtk?=
 =?us-ascii?Q?s2bCCAEOnm0J70CR9+33O/QNoS8VtZAX8hqwEBGDl5P+Y7BQSPHkojsTcyV9?=
 =?us-ascii?Q?wW3Zzjw7FEt1vEn/g6zXzUbwafMb+U0S4TZVlnF2y6tZ0DvB1wh6vO77ko22?=
 =?us-ascii?Q?AYoVCLdjM8I8spaRlmIvsPVSGSwWraQK9of0m/mgJaJ0HvS/a7MwaWGN11lQ?=
 =?us-ascii?Q?zYh0b20u5bPl63V0bILj8drreqArKwvoSbiprtLuQ3pxTcdGmSMYL37mVZeV?=
 =?us-ascii?Q?/TAtcVQFm8oOor3Ad9TlSOp43ZFEtsN5E2l87KDNxErhp3GkL2z1li8P51Y1?=
 =?us-ascii?Q?UvxiXBv+ttMBuXWoQkV1/P39vfDZUBIlU60s+Ebdecn+33jhvRdtauutlGkx?=
 =?us-ascii?Q?IqKsbk2IdnyEDLxJvAhW4kobFvjJpkuLZ2e8GBlaYZc/qTAUUcx1vysdcm/v?=
 =?us-ascii?Q?8LcdgSXcKZZIda0NvTtUAALmwFmUtlRTGbMG4rH/nkL1E3Eu/Hm0q9hgECpM?=
 =?us-ascii?Q?x11GEDCw7Zfn/jZGxR60RQHrvNE5iSVgO+VuEFWaidhZJ6QA1wELRM/YHs0+?=
 =?us-ascii?Q?Az7TvyrbrykrPz8A+82kBVJpCKg4XUuAxVnUzTVcUYNXmCisMII1SR4Bha6m?=
 =?us-ascii?Q?4X4Hbdgcm63uXZK1FAVQKtnoJ9VAqFPvdzEbpHo/ekkhxDE94BdT3RFjdYnB?=
 =?us-ascii?Q?hmuo4YDFiCElUwTlLo9zla/QrbJ+gRyq59e0aNHGpYmuTsm/adVM6sU1I3gR?=
 =?us-ascii?Q?sF2rmal0YnlyetTqnqryoYmGkiILhZzMDeydjpRsW9X/1iphwPjg2I9UcoHZ?=
 =?us-ascii?Q?oRt7padUSyrRX3pMKHdCRvvLG6jHIc6VRCS/7vXCFbx0gKy2qwdtVRnzIjmS?=
 =?us-ascii?Q?khO1nrsfSNL3dUG6wn329YKjTvLekMvMApQ2CWkbwqn08F608DJSz/pGWzjT?=
 =?us-ascii?Q?2JF9KR5gYQ88+dTvTTqTh1BD4Va9bCgq64yxfsEdql90XPrHk594aBvoEgII?=
 =?us-ascii?Q?0KFCAvk+05OkS7gzc1OKZSwEftEsKemRfTAQeYJ3i0sE6ZksKpVFo1+/u4hZ?=
 =?us-ascii?Q?pco76AERDjmtu0FEHqVbkQCTZtoFsTKkOW62EbsmZuj1gcCwN1MJ5TEym5OO?=
 =?us-ascii?Q?IXoLu0EHOKu6TE71YR67TQ7UM2u99z0uLYz9fZqAD+4iAwNc5eKMkF5WTEJi?=
 =?us-ascii?Q?JHYO21zRNYPO0O/riwc1vYw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <887DDC4BEF807E4395D924BA845B0EDF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3df1e5-343b-42da-bfe3-08d9ced8674d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2022 16:45:09.0104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: psOe8zJZ/ccQ/MciGpkJH3kLrYctBTTKexSNGFnL2f2kN0dSC6lILx2y1qhhu+nmwQinisjA7eokiGP64qwNSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2990
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10216 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201030113
X-Proofpoint-ORIG-GUID: mf2U4-3v-iSQ-YLUa8UvAiaC5wE48Zdr
X-Proofpoint-GUID: mf2U4-3v-iSQ-YLUa8UvAiaC5wE48Zdr
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [211216 06:09]:
> On 12/1/21 15:29, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > The maple tree was already tracking VMAs in this function by an earlier
> > commit, but the rbtree iterator was being used to iterate the list.
> > Change the iterator to use a maple tree native iterator and switch to
> > the maple tree advanced API to avoid multiple walks of the tree during
> > insert operations.  Unexport the now-unused vma_store() function.
> >=20
> > We track whether we need to free the VMAs and tree nodes through RCU
> > (ie whether there have been multiple threads that can see the mm_struct
> > simultaneously; by pthread(), ptrace() or looking at /proc/$pid/maps).
> > This setting is sticky because it's too tricky to decide when it's safe
> > to exit RCU mode.
>=20
> I don't immediately see why enabling the RCU tracking in mmget is part of
> the dup_mmap() change?

Enabling the RCU tracking during the dup_mmap() change seems the correct
place to put a change dealing with counting the number of users of the
mmap.  This commit switches to using the maple tree as the primary
method of tracking the mmap, so it seems logical to me.

>=20
> > For performance reasons we bulk allocate the maple tree nodes.  The nod=
e
> > calculations are done internally to the tree and use the VMA count and
> > assume the worst-case node requirements.  The VM_DONT_COPY flag does
> > not allow for the most efficient copy method of the tree and so a bulk
> > loading algorithm is used.
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>=20
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>=20
> >  static inline bool mmget_not_zero(struct mm_struct *mm)
> >  {
> > +	/*
> > +	 * There is a race below during task tear down that can cause the map=
le
>=20
> What does 'below' refer to here?

If mm_users is zero and we arrive at mmget_not_zero, the maple tree will
enter RCU mode.  The only way mm_users is zero would be task teardown,
so we could have a race with teardown and another thread.. but the
result would be that the maple tree would delay freeing nodes - which is
not tragic.

I had a discussion with Hilf Danton in v2 of this patch set with the
code slightly different, but with the same outcome [1].

So 'below' means below the comment block.

>=20
> > +	 * tree to enter rcu mode with only a single user.  If this race
> > +	 * happens, the result would be that the maple tree nodes would remai=
n
> > +	 * active for an extra RCU read cycle.
> > +	 */
> > +	if (!mt_in_rcu(&mm->mm_mt))
> > +		mm_set_in_rcu(mm);
> >  	return atomic_inc_not_zero(&mm->mm_users);
> >  }
> > =20
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index cc9bb95c7678..c9f8465d8ae2 100644

1.  https://lore.kernel.org/lkml/20210820174544.cvbdwpp6cfebos2m@revolver/=
