Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E72749D030
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243387AbiAZRA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:00:29 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:50160 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243314AbiAZRA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:00:28 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QFokUl029689;
        Wed, 26 Jan 2022 16:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=A19W1vuORAZ93ZSR7PF7TxCHOT+Q/BWXsxNdrbHjhmA=;
 b=NNsGB64SctTTKEToshBPdHuI/c+Snf1ryv4BmLUavnKrJzKNDICy1gVg03LwJ2BhuUhk
 9dRF5YsKiB0ivJmbejWg614e2ULBOxKy3Au1auQB7dwH6LW98aZxs//KXIcUeV16J8gv
 rxeuPQIieUQK3j68/fZB0u36YtTBT+Kedjmgh8qM81rlWDuqjkihO42ym5iE9E1Xs4aC
 ogf/dAht9ewT3IYxsPp6j9Sog3DXv+sYR0SN7b4ALCeotAXJroxtYRfnksCC2h45bF2b
 phmRoENiVbwftrvtWkSPsJfaOcmRWmfGC7WPWLRR6Zsr6gJx8B0PPLZDSa0ggtCNuhEo UA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsxvfpfsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 16:59:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QGuVjJ126637;
        Wed, 26 Jan 2022 16:59:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by userp3020.oracle.com with ESMTP id 3drbcrhab4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 16:59:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R05taGQjZlP1CSn4EpSSa1mWudgy6Go/WnuIS7fJLPOZgD+UhSWlLD+E13kSgxjLifHISxN87xq1xgz6GpPYPHk+d3HDks1dnyUUPtlLsHsvXcBh/jvBwgVHUFJ29kr5tEyGH0lMxqUE/igsTnbf448mn+wHJ/dDIaeJ0UoA0tL89V9Dmx2hyxbLjVRSR4UIYGjyycEuTfH1bV/2fZV4Ltq+KGpgN5Pnp+Y7FYC/yJlO2A7s53RO2I5nFl5fjfCNwhRvvqtg1lN4JaH+R9bug/EkW82uhLzsMLJyd0ABjW64ESL3zWn0AplGUVodzXBdU3lazf/3AKRLE8pUqEa4Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A19W1vuORAZ93ZSR7PF7TxCHOT+Q/BWXsxNdrbHjhmA=;
 b=OoLRHhpViPL552a8CytN3c2sVoBZT58dNfBpQYsxNcI7vkXdwclvBMwGx+NA94wV4fYvPYk58U0ha5FS0d+SSJ6YbzDn44knRBd10U3fb6UJh4lpa2kMLRUYdRjCzIq3bXZh2qcSbM4hizqdU2wyK9TA/qmhq1S4Lw+cTUeHeEPaAygAaU54/ip4rV4nTczXoE6erfHE0eNCWtFhRKN95UOri70X2T+V215rTUlebEWkWzPaGsDz7OUigpHaj1kjyw3iN5V2BsntLwOYIRdW2qGA5TzqJTqZd53p/3sz2FbHKb51dKFfsJXIF6gv38hE/orXHVnZAQleLl2dY7DaJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A19W1vuORAZ93ZSR7PF7TxCHOT+Q/BWXsxNdrbHjhmA=;
 b=ktnFcxY+SKk2adkQFEk39XxS0NeZTdqGhENJs21AU/yuSpFkZ0JH9Hh45qlObnWqt3Lbj+LvxT6cce/sQ86ZLC0O9fE/zEydwvXW5KtMHYsCg3w5yxkF4X0jncZdIuxu4g56UCLFZmi1eHkPrbR3TPZlCbfhFwoK06zgfDpWV6U=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR1001MB2058.namprd10.prod.outlook.com (2603:10b6:4:2b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Wed, 26 Jan
 2022 16:59:46 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.017; Wed, 26 Jan 2022
 16:59:46 +0000
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
Subject: Re: [PATCH v4 58/66] mm/mremap: Use vma_find() instead of vma linked
 list
Thread-Topic: [PATCH v4 58/66] mm/mremap: Use vma_find() instead of vma linked
 list
Thread-Index: AQHX5r/1hd39GhVMG0ubXF1xkkrhJ6xsJL0AgAm5+IA=
Date:   Wed, 26 Jan 2022 16:59:46 +0000
Message-ID: <20220126165939.reu2pu6wztmr274f@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-59-Liam.Howlett@oracle.com>
 <60a15c8b-c70b-0fd5-287e-d37d2107bf04@suse.cz>
In-Reply-To: <60a15c8b-c70b-0fd5-287e-d37d2107bf04@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09862263-0445-42de-03c7-08d9e0ed41cd
x-ms-traffictypediagnostic: DM5PR1001MB2058:EE_
x-microsoft-antispam-prvs: <DM5PR1001MB2058D85D33B8A87ECA911246FD209@DM5PR1001MB2058.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pOAyTvMoSZZCv9zXtIuXfH125gU2Qa+NzMXVhraSSLVvLuVlgUZCA/FRfOki+kfBU6ElFcMlFkhgGvp/59HySdpw1OwB88yxonwRW8wNoWSHdUUeKrRwtDG/50V4Wg30aOWt5pCUjGOw3T/BoGxb5PcIQO5ijDkAoH/eyOA+4a14UW8+qXPxu2jYEUoEk1K0Z412lDuBAdVBLYx6ezo//pxLYxpekN4zyPaAiC1bdV9IrUWUIdGlsUCZ7yAs1htBTh10HqRNdBTs7JmrP1O2ZuNUsM2ckLj3DNq8DY0+frCjBn0sEBt/7AbRdInoPTz4Gt2PskbH7bHtducOzsq1bU5cIJKfYq7hGvarWsO5zmUm7uFBpzpSPogELihpuSVtGUGxYf6Jeol0T8DCxPMj97t1GGFybHFej6usrdM1o5NfoIUU3DKGfXwtsdrUpiUk+lw3im48KuVdZjoXUjyAI+uC44o5T3bHLr5b+Q8rtFMCpsCY8FFW7mJbTCgDy5G6vWAijJacBENLtViM/sFkTcBvblnZ7JZYzqLPr++lIn4Tn8nWoLnZVF7LkIfu6kumA/byV54F+8E0RZjfMWhKITbAD1OeppdhSy9dsRawlIc3dQTgWA3Ajq66ttGzp2UppODS2dJsgLkH4Yi+bZLpAvt/Ny5YTkuk9/YjmzRcm74fSQ7y2kkGsVxCDyEaQDY5F5klQ0yff19H4MWFtN2DPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(66476007)(66446008)(64756008)(83380400001)(8936002)(2906002)(4326008)(44832011)(76116006)(6486002)(316002)(38100700002)(91956017)(1076003)(6506007)(508600001)(66556008)(54906003)(71200400001)(8676002)(122000001)(186003)(9686003)(86362001)(53546011)(6916009)(26005)(33716001)(7416002)(38070700005)(5660300002)(66946007)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+Sg15ZlG25iSOLgi9eLb6HVWI2zPwrgRzsIpiad3y0BZ4dwP1DjBlJx2pGJC?=
 =?us-ascii?Q?Vph8AeZqynq2enAJyINxw6sdNUvqQeXGxSJHl18jhbBURluz+ptUSIJGr61a?=
 =?us-ascii?Q?bt1eTf7t57AXEimnaE397m4otxv+4LBzOP/h1vtxEiW+QNTokyGHVk0Po8tq?=
 =?us-ascii?Q?MMMNvz1xJiX1qqPo6KoxwN2fhseVDPB6TaliY4LVEIkTEmbm2IS1eGB6nX3L?=
 =?us-ascii?Q?VpXgLblTPqXIUIk8133FV8EOiDC5MhpFXvkmZOSaOnoabhR+yV4xiqZDYhNM?=
 =?us-ascii?Q?nf+184c1NFlPmDzxchlUxL7srD3XRrYAZ7ok/7ww3u/EdoqdF6yzkk/VN8ne?=
 =?us-ascii?Q?UXgbJ+nuGJfqDXGLEdvWfxY1NNw7K/Q2dpV8ps/rSQ+mGh8mDl9lagkz7/JW?=
 =?us-ascii?Q?EcqcvuVg2aEh80PGM+XprW18Yqd3MeXmkIlxz2FR44cUv693v27J0H4qLBjC?=
 =?us-ascii?Q?+vaNlqWzD72Tm96mCFJqkrVRnfRpFBubM7opMVjTlKNTxQV1WuG9Qa/b8WQc?=
 =?us-ascii?Q?KFEWFcyClgT97Epkz15tvWoUjCnAFaGK50lkInlPvTFOfm1W5O3DklGVs9KB?=
 =?us-ascii?Q?wxbjINrlVlLeFzaKwXYnjnqUOX7DfOoOJyJoJKDyIfAETMKZD0jGb+kYKqw2?=
 =?us-ascii?Q?iuIdRl3y4NXGJki8AMWDVHYpNXGo8o3UyVDghm9x3a8LMKULnHCitGNsKqIA?=
 =?us-ascii?Q?BbYfBp6ZZFEs3tgqB4rT2Ny3FtKTfS/XYPNP92/sBL8d4wfjv1fSIaFHLCC0?=
 =?us-ascii?Q?aKR0dd7JJBM/8He4oOQJhlCztYPqOIb4mfLqUDLVulahIF9fq0uCqrbmyei6?=
 =?us-ascii?Q?qSrkSlRnIObEO4WoCbwAPvYaDdXO2NttHoW6Fkcl5D4aBuBWopKjdXSavNN9?=
 =?us-ascii?Q?nRKGjLYBXYQiTzy4XmxuctBNJ8wylV1GoTrWKz1YCdQ5IzpAuU5eNjQVu7i6?=
 =?us-ascii?Q?gWS+vGZgHspluLlx5neRHOE1vyF2W7vSrpoimqCRwOXO873APWg/O5hUEygQ?=
 =?us-ascii?Q?2CUIct4hrbYLlkGE7T4q5g8JdlmriwocLvIyD7EY7X9V9c+bp4xqlS4+jK/H?=
 =?us-ascii?Q?8EBQM4E03q7heth246/kdNkE98XeeHDE/VO9M8A50poowvhjAXXrQFnWmhQZ?=
 =?us-ascii?Q?BsNurCLmYCLX2t/ceRgWiO1WwpCkzyJhi2E5DNuLIUnYUAgHlDcs73FAcA6w?=
 =?us-ascii?Q?hk14ibUt4uCBAAQjUQqPk+iJkLeSnmbgZJnPQdWjRr/LCUDDH5XZvpYGErb4?=
 =?us-ascii?Q?alC12USNLBE0fUFAKDmnKlWTzJvVXW+C/zQdGKplRaXrxJ5EvXCzzx8ewomp?=
 =?us-ascii?Q?MHiBWSwBl4OoQpTsTKU0kCnKdILJogoGR9nvhFx2M9CXeS2YgQ4R0Y8yAwEG?=
 =?us-ascii?Q?mc4O7RIYSFV9M8SIkRfZ+8quySBSql2408MPYmsk8Mz+anxhhQaiRIA5eM1H?=
 =?us-ascii?Q?H+UJhFv0/sehZ2AWj9/KMOX+ELw9J5wvnW50/Sl7QP1ufxhhfMkLBYuUaLEb?=
 =?us-ascii?Q?3g5gKQm+fjnz7Vp21mSnTu//XjBmXy9CfRsSfwu2RuE2yxGv62IpnCS3fRj6?=
 =?us-ascii?Q?7ZupFY7QkFIkrnsVdate4FsHREwBlpl6UYRpi3UP7qQQ96VV6GvqhMhK78iP?=
 =?us-ascii?Q?M5gGXBuiCE7BmlnNQy0oW1k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7502B6525530084785B1CDA72C0EE083@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09862263-0445-42de-03c7-08d9e0ed41cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 16:59:46.4211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4fO8JVv97RWkng/2hwvdSadB/03I8YC8/mHaS8el2eA/xmhrBEFUO7KXNUn8/x+K2Z2JgMc6m/0S7bUeers70w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2058
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260104
X-Proofpoint-GUID: Sk8y94pvDDin90-yKYqs9NgilSU97ZsP
X-Proofpoint-ORIG-GUID: Sk8y94pvDDin90-yKYqs9NgilSU97ZsP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [220120 07:27]:
> On 12/1/21 15:30, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>=20
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>=20
> > ---
> >  mm/mremap.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index b09e107cd18b..4ad39c985d04 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -713,7 +713,7 @@ static unsigned long move_vma(struct vm_area_struct=
 *vma,
> >  	if (excess) {
> >  		vma->vm_flags |=3D VM_ACCOUNT;
> >  		if (split)
> > -			vma->vm_next->vm_flags |=3D VM_ACCOUNT;
> > +			find_vma(mm, vma->vm_end)->vm_flags |=3D VM_ACCOUNT;
> >  	}
> > =20
> >  	return new_addr;
> > @@ -869,9 +869,11 @@ static unsigned long mremap_to(unsigned long addr,=
 unsigned long old_len,
> >  static int vma_expandable(struct vm_area_struct *vma, unsigned long de=
lta)
> >  {
> >  	unsigned long end =3D vma->vm_end + delta;
> > +	struct vm_area_struct *next;
> >  	if (end < vma->vm_end) /* overflow */
> >  		return 0;
> > -	if (vma->vm_next && vma->vm_next->vm_start < end) /* intersection */
> > +	next =3D find_vma(vma->vm_mm, vma->vm_end);
> > +	if (next && next->vm_start < end) /* intersection */
>=20
> Could just use find_vma_intersection()?

Yes!  Then next is not needed.  That will be nice.

>=20
> >  		return 0;
> >  	if (get_unmapped_area(NULL, vma->vm_start, end - vma->vm_start,
> >  			      0, MAP_FIXED) & ~PAGE_MASK)
> =
