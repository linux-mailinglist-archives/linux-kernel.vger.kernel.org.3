Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8784C46DAC3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238654AbhLHSPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 13:15:30 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:35022 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238649AbhLHSP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:15:28 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8HSZtG025182;
        Wed, 8 Dec 2021 18:11:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=iMUVqk9FgUKsYbhTXT43W/Z1l94YTrh88V5YHbNQsBI=;
 b=q5dsDONXooaO/oi9cutGqaj2b8I46LhloWJMjPKCxA8MD9bFscV7VM0WirKGbmZFrusd
 z/hhoAQoTdFA+iyZruFDCaxqyePRs/95q378O3Y1oZA9oKG74ADVAh0qVFgJBtLWWrSL
 NKADGqMx0c/zHLGqhbLA6bYlBbh1z4E447GyTydPng1ualbOe7hrDdKSNoEmMly8lnmd
 GAGvivRZ7/2txNkQ76LwVKI9ODIEbVO2r/oTisiEf4V1V8aCF3j//cG4kQYMQEZYPDzn
 sEqqi6gHflkgpKu+nsEniz0jzcs/vWMA0BiwqzYcQoiyUmtMTu5PsyzPgovQgj+FE72x 7g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ctrj2shq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Dec 2021 18:11:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B8IAkA8030628;
        Wed, 8 Dec 2021 18:11:31 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by userp3020.oracle.com with ESMTP id 3cr1sr3u2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Dec 2021 18:11:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6wzHV69p96Y4oB7duAxntN0/MkFKVlv4kr9e0YanyPip0NLzl5Lbqb2lJ3YaNyeAVZWe4GHEv+Mk0dbELngju3xSDFgA+7FutuFdE2S9ofQDXPWb0xZ8KbvTJQN3OPVeLTks0TfsXPXiQaeqPJc4bn6kACjsAxLzquHj5luby+rXw6U18TcN40XwGtHhuZmlKq1RUDsEexWtDzK1oO/4nu4i6HfF6q2DrvM5Q5OLENm4ueKz7irln6tNbcLjdS5+XKoZTNyce17bv72PiGqiL4VBfOQ+CwNuKiKKoyw0+pFexDCg+nWclrotDfXPgZMto7WQbiIyL/Ns7ucMpqyUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMUVqk9FgUKsYbhTXT43W/Z1l94YTrh88V5YHbNQsBI=;
 b=YOy/5p3MC0/4+jzmjEESH9+NxG/APU8xVT7/ezmpk84/cs6bQX7A5HG0bC8U8cmjx9fiBngDsMj/yjEqtTyn5HOuyQOJNf2BclsTYQZLPnEP6/0It2zP24a55y6YyVOOY0IKFOO61PJlplr0q2TvUzlk6cgqpFxPF8l0dNbpl43lYIzUb4Q8MFw56UCpnQeoHaEacZIHygGzWPBDG2DLSC7DHLooYSJEg6XGdMS/wJKNN4TEGWq/DveMPflxPM87m9hEAC4hZEWBoqMreKzWVcq36OSOSSqHJNCPQRWp5osKaMJ5j4mtD170+ZvrWWVx9SIm+X8BYUI0lOB82Of0Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMUVqk9FgUKsYbhTXT43W/Z1l94YTrh88V5YHbNQsBI=;
 b=Iq9Sig+XLO13dXKGSofy6NNkzt5Ki/UuxSARwdP8gWSKWMeCRsn1mJVxSgswgXnE3L3t+mStqefCYAQ/4UbGiFr/E4uQ24ow3m2UykhEr7v9yR3P3isGad4+vBvdia+0pgitsBX43w8h0JAvB0BpAiCFocSkPI47NPPLVYn9oPw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2461.namprd10.prod.outlook.com (2603:10b6:805:4f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Wed, 8 Dec
 2021 18:11:29 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%4]) with mapi id 15.20.4755.022; Wed, 8 Dec 2021
 18:11:29 +0000
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
Subject: Re: [PATCH v4 06/66] mm: Start tracking VMAs with maple tree
Thread-Topic: [PATCH v4 06/66] mm: Start tracking VMAs with maple tree
Thread-Index: AQHX5r/mD+pD2kMpi0SkA58fz4UERKwnW1kAgAGVKIA=
Date:   Wed, 8 Dec 2021 18:11:29 +0000
Message-ID: <20211208181121.us2sxqjaiamol7yf@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-7-Liam.Howlett@oracle.com>
 <d585f9e5-538e-bdab-c89b-b4e1cc03c7b2@suse.cz>
In-Reply-To: <d585f9e5-538e-bdab-c89b-b4e1cc03c7b2@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b46b9eb7-0504-4c2f-8492-08d9ba762832
x-ms-traffictypediagnostic: SN6PR10MB2461:EE_
x-microsoft-antispam-prvs: <SN6PR10MB2461E84F670B3832792024A0FD6F9@SN6PR10MB2461.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MYD97yDTUMYX2ayLAgclpo/fozGkqx3JRcXus5d94wWiCNy5sInvsIiRIGn4t7SC9CRUFRRZx+Md6y/chEn7YvnY7Fq3AgvPNF33ybgTbOLsJoDFpje0Cja3DCCId9PAkKj+LOozWCrhokrs4tGNWaLYVPi3wU9jaMISA071LxjvvYyaZjCD5h59GBgRywkHc23CCRYFc6Ax7E8A3Wdln6nKUafK2EyzuB5Esipqgk7Gfu1uIGeEUN1Qm+k+oQ9H+/FqhQkrKCL33sq5QpJhzL/gcGhr8Jddum25SpqfcXQFZT4YpEuLNyQgPbd0ML/TNQZwfuqRPqIInQ6m6f8TW5U3R0gFjpgAhZ6iDWjTcCy29oAld7aWvN7xUXhFp7ehcYS41hNj2STNDX+byAXrY7HjLFwg0vjMDHF61f1UEwOpL0Qo+yev1IGSjT0YJOuVzs7VjTqcSLzUrDGxbEevEaqH54nb6JICRxjFWJcd2HAE6SqErNP8MmoIeNn5FX3FcEIyy6lzNHy6tyBa2U5ZcWB1xLIKp5i6GUpngrBgvbAbaw6q357tva0gBqYNXhiTGYCHSmbwqPQsOOps8AutxEXQOSs8OvSFA3BBSPgJC+d/1QJ9ny/OHDFY9wjT8mF116S1HwCWe389PkRU19HMulAxqFsQrNfziHA4w7lk7fxzvhmdmBC9q8VH0eiwrOfvjBAZaQwXs/3rfP224VhebA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(122000001)(8676002)(6512007)(9686003)(71200400001)(54906003)(6486002)(6916009)(33716001)(8936002)(1076003)(316002)(26005)(7416002)(186003)(86362001)(2906002)(38100700002)(64756008)(91956017)(76116006)(66476007)(6506007)(5660300002)(38070700005)(66446008)(53546011)(66556008)(44832011)(66946007)(4326008)(83380400001)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B8nF11XUpiFMNoUH1vTf1ye83j/4E1MjPm69bK7hrn1NVCL15GBL27FXs5jo?=
 =?us-ascii?Q?9i0cMRtLwn0bZ0JRwmeekMbkEF70p2MUjfq1jxyLPdggxtnXQHRLK2tKn8hE?=
 =?us-ascii?Q?bH1EJJ8JmiBlQOYiLI5iR2Waf/hSvgjDWE44gkvSFgOL+4zZe9xv9HIyZlpx?=
 =?us-ascii?Q?hnVZrhrxA0KGJS45KYsW3WTacN21YStsDEn0QMiO4PzQakqD3BxT7pzGR8PM?=
 =?us-ascii?Q?KMZII5Zq6O80ajs9Sngt1YU4NG/hNTDtp2ZKxBTL40NqfDhssXuI02Hp1GS9?=
 =?us-ascii?Q?EVYKRGMFvsh8W4Zq9lvmonpHbJMoLNhZwL2giwkf0U41fqDUTgNheqG/Vipw?=
 =?us-ascii?Q?Go4DX/LECwm5MtARdzhuIm0BtSmIXP+3cubJU6ZgTUWa1XaPUobNrkxM+5L/?=
 =?us-ascii?Q?CYLb2b/pQySxlzncUmzWORtyWu+phzfbdUKCWkmspRpVbltIU318a2OrxCDr?=
 =?us-ascii?Q?VaLSwAAP1dEangLEFA5XjQsb6AEFbbE1R97R8OY5bO7pjFqnSuz2YVTG0XLK?=
 =?us-ascii?Q?oPw+dMHlggzGXrM2st0JAppLG7IbBaRcdY7WOmaq9yV/SpqtZ7oJtpQiqLr4?=
 =?us-ascii?Q?C4Rqd/GeySQlHhNzlJZZ/0mUiYyOKt7eAOYls6apEXBw3OxpnWxwlVJ3HQj0?=
 =?us-ascii?Q?jxV8dvoGVsRGznXhrabV2xNgwmkGpmhiHC3CxfdEku4jpF7EAjmSlb4pp5cy?=
 =?us-ascii?Q?iSGRVoXLrG9n3BXSlenRxswSjPjYxpRwh2qbt8m6wBXrg3q2YxuzUrZnSdxn?=
 =?us-ascii?Q?lEgpscErwNF2np6fy0QpyXo8MGx+gc1wfxkRKlW+ogwLU0NWCxMQKnwf/SGY?=
 =?us-ascii?Q?SIAXVaQOaCgpyflzXcFcRkfGTB/tV8p6rhytNDwEw+MMJGQi2nJj6HikCaXt?=
 =?us-ascii?Q?bt02m7Wx/2TbeL6ffnbuoHA0ycHkpGa859racJ+8ZPw/c0fJE7kfM5QrhIHS?=
 =?us-ascii?Q?6494ojE29e7NmkZ35dSsFjzlxVYZD/h0zuZoampT93CW/jJfEqhDXZ0B1Kcp?=
 =?us-ascii?Q?jD5sTDXW0bjP5ESUf9j0kET0ZGFVVpAUyn79zmo9ZtEZgU7d5X0DrOLWhRPV?=
 =?us-ascii?Q?YUV1dPu02ke04Ayz50v/U7xWZJrLHOylHlLD0N7XGRGLKDelig3fAkpp3kx3?=
 =?us-ascii?Q?DvZRyYP7rGZc2NdSfrXPjrXdczf2BIC/4jPuXyYcGRBLxsrfIBdfeKdiJXIc?=
 =?us-ascii?Q?FOEWrjsyf4f2xZVPJCqL8/oeW/ADh599PvCcyus5uce4CRp4+UuUpDgIZCda?=
 =?us-ascii?Q?NLpJC3oOHuq3MfRK5KkwKl3+aN5OSOUEEvO2QL0d30lQm7HzBJdzQJL68YuA?=
 =?us-ascii?Q?CZxoWv+9BmGxDhvkabcvdygP6Jqe64GPjdnNl6mmD3kZI//phakL/z81IwzK?=
 =?us-ascii?Q?juoy6Q9m+Ndz0H+I1onhCLntVH31412FYxnvH//I0E+qpuchC3PQpW+7LCxi?=
 =?us-ascii?Q?0YT8pS763DyqnH2LMu1Fa8wVLkxC2mfJiOsMeeYIip6CNJ0E9gfhFEYyhs3i?=
 =?us-ascii?Q?Eh5+46E7GsX1o6Pns0t2CA6on++8ybQp1uZ+kl1boYhGpRQMVSnfj+qwQHfp?=
 =?us-ascii?Q?78y+2c5PFc6AQwKSZ/EqYwbijmy4nnaymUMPWsjEBwT6eTOAgap8FZBCO1pD?=
 =?us-ascii?Q?KQ2yvRtSoYIFP0lBdHFcpNQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7CE8CE6E967D2349A3E4E67D2CEE42F2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b46b9eb7-0504-4c2f-8492-08d9ba762832
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2021 18:11:29.2473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kJ6GSKhZLjs98Q1zgtXF4dCCo+I5paAZ7XHLj4b9D6zZGsiFUpKyZA3nTAP5MxxxQKZeM5zPcdW5q9/+KEhnAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2461
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10192 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112080103
X-Proofpoint-ORIG-GUID: gr_UMouKlPT-9bKErb3IJoDGntY-_n1W
X-Proofpoint-GUID: gr_UMouKlPT-9bKErb3IJoDGntY-_n1W
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [211207 13:01]:
> On 12/1/21 15:29, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > Start tracking the VMAs with the new maple tree structure in parallel
> > with the rb_tree.  Add debug and trace events for maple tree operations
> > and duplicate the rb_tree that is created on forks into the maple tree.
> >=20
> > The maple tree is added to the mm_struct including the mm_init struct,
> > added support in required mm/mmap functions, added tracking in
> > kernel/fork for process forking, and used to find the unmapped_area and
> > checked against what the rbtree finds.
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  arch/x86/kernel/tboot.c     |   1 +
> >  drivers/firmware/efi/efi.c  |   1 +
> >  include/linux/mm.h          |   2 +
> >  include/linux/mm_types.h    |   3 +
> >  include/trace/events/mmap.h |  71 ++++++++++++
> >  init/main.c                 |   2 +
> >  kernel/fork.c               |   5 +
> >  mm/init-mm.c                |   2 +
> >  mm/internal.h               |  73 ++++++++++++
> >  mm/mmap.c                   | 220 +++++++++++++++++++++++++++++++++++-
> >  10 files changed, 378 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
> > index f9af561c3cd4..859e8d2ea070 100644
> > --- a/arch/x86/kernel/tboot.c
> > +++ b/arch/x86/kernel/tboot.c
> > @@ -98,6 +98,7 @@ void __init tboot_probe(void)
> >  static pgd_t *tboot_pg_dir;
> >  static struct mm_struct tboot_mm =3D {
> >  	.mm_rb          =3D RB_ROOT,
> > +	.mm_mt          =3D MTREE_INIT_EXT(mm_mt, MM_MT_FLAGS, tboot_mm.mmap_=
lock),
> >  	.pgd            =3D swapper_pg_dir,
> >  	.mm_users       =3D ATOMIC_INIT(2),
> >  	.mm_count       =3D ATOMIC_INIT(1),
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index ae79c3300129..0b40291416ca 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -55,6 +55,7 @@ static unsigned long __initdata rt_prop =3D EFI_INVAL=
ID_TABLE_ADDR;
> > =20
> >  struct mm_struct efi_mm =3D {
> >  	.mm_rb			=3D RB_ROOT,
> > +	.mm_mt			=3D MTREE_INIT_EXT(mm_mt, MM_MT_FLAGS, efi_mm.mmap_lock),
> >  	.mm_users		=3D ATOMIC_INIT(2),
> >  	.mm_count		=3D ATOMIC_INIT(1),
> >  	.write_protect_seq      =3D SEQCNT_ZERO(efi_mm.write_protect_seq),
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index a7e4a9e7d807..9eae78a155be 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2610,6 +2610,8 @@ extern bool arch_has_descending_max_zone_pfns(voi=
d);
> >  /* nommu.c */
> >  extern atomic_long_t mmap_pages_allocated;
> >  extern int nommu_shrink_inode_mappings(struct inode *, size_t, size_t)=
;
> > +/* maple_tree */
>=20
> Hm should it say mmap.c as that's where vma_store() is defined.
>=20
> ...

Yes, I will change that.

>=20
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index bfb0ea164a90..c2f1431886d4 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
>=20
> ...
>=20
> > @@ -1901,12 +2018,21 @@ static unsigned long unmapped_area(struct vm_un=
mapped_area_info *info)
> >  	struct mm_struct *mm =3D current->mm;
> >  	struct vm_area_struct *vma;
> >  	unsigned long length, low_limit, high_limit, gap_start, gap_end;
> > +	unsigned long gap;
> > +	MA_STATE(mas, &mm->mm_mt, 0, 0);
> > =20
> >  	/* Adjust search length to account for worst case alignment overhead =
*/
> >  	length =3D info->length + info->align_mask;
> >  	if (length < info->length)
> >  		return -ENOMEM;
> > =20
> > +	rcu_read_lock();
> > +	mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
> > +			   length);
>=20
> unmapped_area_topdown also uses mas_empty_area_rev(), shouldn't this one =
be
> non-rev()?

Yes, good catch. I changed this in a later patch to the correct function, b=
ut this needs to be fixed.

>=20
> > +	rcu_read_unlock();
> > +	gap =3D mas.index;
> > +	gap +=3D (info->align_offset - gap) & info->align_mask;
> > +
> >  	/* Adjust search limits by the desired length */
> >  	if (info->high_limit < length)
> >  		return -ENOMEM;
> > @@ -1988,20 +2114,39 @@ static unsigned long unmapped_area(struct vm_un=
mapped_area_info *info)
> > =20
> >  	VM_BUG_ON(gap_start + info->length > info->high_limit);
> >  	VM_BUG_ON(gap_start + info->length > gap_end);
> > +
> > +	VM_BUG_ON(gap !=3D gap_start);
> >  	return gap_start;
> >  }
> > =20
> > +static inline unsigned long top_area_aligned(struct vm_unmapped_area_i=
nfo *info,
> > +					     unsigned long end)
> > +{
> > +	return (end - info->length - info->align_offset) & (~info->align_mask=
);
> > +}
>=20
> Looks like this is never used anywhere and just deleted later in the seri=
es.

Yes, this was from a conflict in the mmotm branch a while back.  I will
remove it.

>=20
> > +
> >  static unsigned long unmapped_area_topdown(struct vm_unmapped_area_inf=
o *info)
> >  {
> >  	struct mm_struct *mm =3D current->mm;
> > -	struct vm_area_struct *vma;
> > +	struct vm_area_struct *vma =3D NULL;
> >  	unsigned long length, low_limit, high_limit, gap_start, gap_end;
> > +	unsigned long gap;
> > +
> > +	MA_STATE(mas, &mm->mm_mt, 0, 0);
> > +	validate_mm_mt(mm);
> > =20
> >  	/* Adjust search length to account for worst case alignment overhead =
*/
> >  	length =3D info->length + info->align_mask;
> >  	if (length < info->length)
> >  		return -ENOMEM;
> > =20
> > +	rcu_read_lock();
> > +	mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
> > +		   length);
> > +	rcu_read_unlock();
> > +	gap =3D (mas.index + info->align_mask) & ~info->align_mask;
> > +	gap -=3D info->align_offset & info->align_mask;
> > +
> >  	/*
> >  	 * Adjust search limits by the desired length.
> >  	 * See implementation comment at top of unmapped_area().=
