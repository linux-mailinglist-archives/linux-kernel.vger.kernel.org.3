Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09F44A8A04
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352819AbiBCR3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:29:23 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:5688 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233628AbiBCR3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:29:20 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 213HTDw4011873;
        Thu, 3 Feb 2022 17:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=mFUg70Ylm8IMy9c6C4RRueoicnMXb+9N6y42x3022yc=;
 b=tWWO4T5ewTVb7A40RdiuaD0NzBhy61lA4DcU1o0q6BBaR/C28irftzxhnoOEsU1pBa6G
 y6VBIZTaJEIVHaTXVYrb9y8JgYV4G6ie3ruBaZBLU0kEDqfahjGZMsGqe99Wzq7/V79J
 +OFGuDZOyDM7tfbwIls4b4Na+tXmTpM8JBArbTKFwXzrNOxOA1vvmg3ICUMwnY4M110k
 SalTNLa9iu9+Ecc6zi0buYRwDf83aLMlsKddhWGYHesaOIPXWpCYlovLGPy9dTQVWo7G
 Vbo2UfDs9JE03UdU8MQA5yri/TTvleC5lONoKH8IvWLAzSeiqhR4Dm4hYvIWFWo+gV6w aA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e0hevregy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 17:29:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 213HFIF7012273;
        Thu, 3 Feb 2022 17:29:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by aserp3020.oracle.com with ESMTP id 3dvwdat5km-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 17:29:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNQyMNSFq4zMvvdsGHDGuiyI7SpF7lNXvEE134hisFwSwaXPSHvj1Jz+GrayMo7psLaP0ADLY9ojV8ZJLYLKkyqpEavkIeEvKI+jV3kLTggjlXSnpk9zDvzd501zm/Q5rrAmXEP02IX7AcmnIHcV/9LnIvS3TrhERTmQXvB2Kj25NM8Sf+giRIsuhlh0egRL7UfHAxE6iW6BVkxPm0T9MIK6SWF6az6VFEqgYKBqOGLN7zSTAYdFXuucvGYYEe3Qslrpg2K79bbzPWlY9sLdMrGOBS/zKzV/dY00q/1T3pSnwWAihAULdEsz066tY3camQUbjytGiQ7a6RcE6p2yNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFUg70Ylm8IMy9c6C4RRueoicnMXb+9N6y42x3022yc=;
 b=PyVCfxEogh5gVYWeCiEbpzcCybZP2+iVX1wPy40iIkqdB7aWZgLYyzXnMZLMLmn5hB0s52o287bMVQBslgSlmDf5LpjCf/UXcB+Dot8dOFGAPWmpYxTCExHfz8AK/ql+QNGOq47tnngBnTm3Bu18ReDSY1XGuZ0NtZ5KaOWC5jUXuae+HOW+1QcIq3QK6IMuGuvvXNztKpCvOEYS7F7I7b9JMxNboDIJ+6Yt4rM7j1oeQoIsQzEC/he71h+QtpymynwQNPyI+lMNPQPe8zPp75iLZsql2KbMtROmFcL8jo9FRFUrrusPbU11RnMTPkv64szw4g52LKRnxbuxUhwyAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFUg70Ylm8IMy9c6C4RRueoicnMXb+9N6y42x3022yc=;
 b=eINcU8JIDxYFHAmdQdUwd++yjOkOGGLYsI9jwzTiZVbMY+wptriThe4YH6J9M7qdt2SPs2eD8fRAdHaDNvoHB3XcVt8ShcFkzCfeg/eXBL9RaUVWEHOkxHb5f9MGn2FZWXi6PoxJ+8OfnsUpnbnwQJ0gDJC441brr6OLGoCtDkw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4745.namprd10.prod.outlook.com (2603:10b6:806:11b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 17:29:07 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4951.014; Thu, 3 Feb 2022
 17:29:07 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Mark Hemment <markhemm@googlemail.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 07/70] Maple Tree: Add new data structure
Thread-Topic: [PATCH v5 07/70] Maple Tree: Add new data structure
Thread-Index: AQHYF95x/Sfcc+vEiUSQ90JwlBJbIqyB/zeAgAAYIYA=
Date:   Thu, 3 Feb 2022 17:29:07 +0000
Message-ID: <20220203172841.z53nwjus6sp2t7lx@revolver>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
 <20220202024137.2516438-8-Liam.Howlett@oracle.com>
 <CANe_+UhTyOr2SPc=SMhK=7t8Uw+HvehdTw1Ti1XGcLfJ_=BMjA@mail.gmail.com>
In-Reply-To: <CANe_+UhTyOr2SPc=SMhK=7t8Uw+HvehdTw1Ti1XGcLfJ_=BMjA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f4d7061-4b2b-4cec-ecbf-08d9e73aae86
x-ms-traffictypediagnostic: SA2PR10MB4745:EE_
x-microsoft-antispam-prvs: <SA2PR10MB47458CED90CCC6851A38D5EAFD289@SA2PR10MB4745.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sTL1D1MTdEEB+nV4Xm9I8eT95fz/swS+9AkEzvv1eH+5+/Udq0974WiK0ZCcovPiztnsN2R3NS7U3erI2AeTIzURThhCatMFJWAGvVVFivyo31sTrBORJYOS5tszLdqdSA8dxcAtrMuKECSNcvgfTZAVkWgIN3rQ3nq/VYP5yPONfwozmIo+p3AH5YkjPOeOTMr0hx+/1RpQUuunCHhJw6MbAPFhb1cAusxiTFwlrYxqGE1W1a0sRvnOB1A4JBAKmZKvlWcTZMTm/R1Ilo/z+WIDve8hbe6EGbwfc/a/crl46qijhAVm3/dNJEg2HuET2vteHKoIIn259Tg/ESWuLzGwbfEzUN8tzTpkC/mNxt06A4SaZXUXnYSnRVCH8T62PenImBDS499yxcANQWNX02trOwj/gU1DwzIpkpvnGWkXEFj1TOLfi+HGQvxex9DELxwv6G52ebHZCKE7aWBuiAyhFbjehel+aVdtb1brWZqt5wvcFWaHKHgVjSSm1Ws6f8UHTUygIf6B+UDREcrURqY0EEETa3lvQzPUJC5/e6cAZdry2+s6cJNPQL/UpjFMuI3NPljseRD66wsOb0pD9wB2ObnTaTA5kvfpNshL0qEeXvK1ju4KhF/tIm0xS4Pl1dMIKr7LKiyF/NNA+95mjG9TsPhxQR5T6teFj3+o86nO5y4sNTDOa1WJgrBTlgSWCs31ZCNyPkFV8augNP2y6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(83380400001)(2906002)(44832011)(186003)(26005)(1076003)(122000001)(38100700002)(8936002)(8676002)(4326008)(6486002)(54906003)(6916009)(86362001)(6506007)(6512007)(5660300002)(9686003)(71200400001)(33716001)(508600001)(38070700005)(66556008)(316002)(66946007)(76116006)(91956017)(66476007)(66446008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dLMeohyCfw2tWz/NthL9iTVIUaQrab5s0q2OFLlEtKGyVKAa/1JY18k7xw4P?=
 =?us-ascii?Q?Cb2uPg8L3gjsZN9DE+DH5vTk+TeZfGRiTm90XvIxeiqbHWHGx/AplQbHxMJ0?=
 =?us-ascii?Q?TaT5aBarDtIymzGGyK+tw+igDU6gqM/jT20wda0lp7pU+RyPdd7Jg0mFwtuw?=
 =?us-ascii?Q?T0RWUm1GJe4JxLZqK4CXEXI5tL0byieH1y5xGLJpoBD44Q8jqWajZEx7ibO+?=
 =?us-ascii?Q?rb4JtvSzQAhS3/bNxrb5yxlTjj7G0bt+DHPtEGmgygPsghSpc22Ke5GgYuTY?=
 =?us-ascii?Q?guHAPMXz5LvypE9wqJIhjWkQrErDwRPRec0RecrKiSOm/QSBYwMCWeBR4RnE?=
 =?us-ascii?Q?n0wMq5IcT52Has7UNQj1mDm3aUJiawKNqQ0bToY5vXIU5MbwIQ6OXVVjXaBh?=
 =?us-ascii?Q?3cGKh7QzDlqoTNjIla/Ea1mW76iI0FQj6SYlDY69ByYT0a6AOZFY9PxAMbup?=
 =?us-ascii?Q?u8kdEG0uvJ+6MjsSyGkNisnaOfktIN1Vtvj/CambxNwDLLBtkrws+OjKNpNu?=
 =?us-ascii?Q?pPUynBjlCEcsvn0shhvfxCxTmjWkp9GF809RQxDHp+OiAbTvwiHAsfps2D+X?=
 =?us-ascii?Q?nslowXOn86OJZAaQz88SeaDGbkS6cgikC6Tf2l0AO61oX4xVmQR7/mekpCJX?=
 =?us-ascii?Q?GDlAJLmHkIGVZNiIcMy8p5l9pNnsDI2kUNTY7w/d0pP+iCYhE0Pg4bxgzWc/?=
 =?us-ascii?Q?+7OHPamEwY9ovvG8xOB5sFTkcQDRzLqPXVO73kI+5RXeJSzN8O3n3xHPmrXy?=
 =?us-ascii?Q?aC/QLHO/GQAx56exUoUnZheEDYrmxUmoGYBo4WEDC5NuYQ6nwpKDZdRfW8nP?=
 =?us-ascii?Q?7eirvF1Wf1BjHAXZff11yULGdwdV8CICRIP73vJZN512uO0dgmg61GjlldPO?=
 =?us-ascii?Q?hlwsyUuIVbZ2Q6yuxv5ynzKaqYWA8qVamNtzoOgg41CYaoNitY/o6w1ag9Sg?=
 =?us-ascii?Q?sE5/wHgX2lOHuV2Cl65hCeTtXzi/E8m0ytzSt7Zq7ABx8AqFTvSF6p0kaVdc?=
 =?us-ascii?Q?OJqKpoTAAszA6i+tLVomdV9ISuvbRuBqqJzR8Zs6aAo2pEnuByaIVaRmYEhF?=
 =?us-ascii?Q?KXzcDxbcsIPxISNXnAqtZDZQRatwHD1UeoSD95ouPP5zmk2S7dMbD7+Rmjm9?=
 =?us-ascii?Q?ucDgkIfXvTwn8/XWxmz+cBww+PoCRzbuhVMTGHifuoUqOJmChsP1i+wfOgmH?=
 =?us-ascii?Q?BX5rqGNesYOwT8vl93tlYvwXOU6wMh2pHi1N10IYkHeRmGBIAcw9skDwMn/j?=
 =?us-ascii?Q?ACaKbA/Z5f0wIKJfYaypseNvBaedT3FTKRpQa1+zRficaY2vd4NoHf5IgjFa?=
 =?us-ascii?Q?2nMzqF//qLmI6zDxxoLxsf+Y1JhE8BSqLQhrSo9fxnriz4u6xxkS569G2ZQE?=
 =?us-ascii?Q?Yiw87bgsGJQRvdHS2VW1NbtvYLNr6Q2lKetScYpWIVYU8REZ+VUGXWbskMUF?=
 =?us-ascii?Q?PLUkYk82aiaJ7gfs0MvEyh8YknFqmWeEZ9RzgwquQRJCXMErFg4ND+rUtEAu?=
 =?us-ascii?Q?RvAiF/rfJ9PCQ6b/pWs1rNncOa0Wqdamg9jQ50GCgyzJ1h2Gt7T3lpJ09xXO?=
 =?us-ascii?Q?JoI6TO2u8WdksdKXM3QMudRQ9tJ4ZtgLkErNNBAAZdo02xImNJk7zq+pxwEi?=
 =?us-ascii?Q?A08BgU7JBt/s2Ob4mfdRm24=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <527487F24B07AB4D90C328EB9D44BADA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4d7061-4b2b-4cec-ecbf-08d9e73aae86
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 17:29:07.1520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YSOAPEwtSZXXnY8P1Z1llOQGVHvHpJi5BCibDGt2rB1a6QTWwKUj6JERByhpS4cCNv8EM9gT4M8WklN8Vcsk1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4745
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10247 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202030105
X-Proofpoint-GUID: xRfsMT1P0szLTXlc3y5wMHulgfiDdM_N
X-Proofpoint-ORIG-GUID: xRfsMT1P0szLTXlc3y5wMHulgfiDdM_N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mark Hemment <markhemm@googlemail.com> [220203 11:02]:
> On Wed, 2 Feb 2022 at 02:42, Liam Howlett <liam.howlett@oracle.com> wrote=
:
> >
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >
> > The maple tree is an RCU-safe range based B-tree designed to use modern
> > processor cache efficiently.  There are a number of places in the kerne=
l
> > that a non-overlapping range-based tree would be beneficial, especially
> > one with a simple interface.  The first user that is covered in this
> > patch set is the vm_area_struct, where three data structures are
> > replaced by the maple tree: the augmented rbtree, the vma cache, and th=
e
> > linked list of VMAs in the mm_struct.  The long term goal is to reduce
> > or remove the mmap_sem contention.
> >
> > The tree has a branching factor of 10 for non-leaf nodes and 16 for lea=
f
> > nodes.  With the increased branching factor, it is significantly shorte=
r than
> > the rbtree so it has fewer cache misses.  The removal of the linked lis=
t
> > between subsequent entries also reduces the cache misses and the need t=
o pull
> > in the previous and next VMA during many tree alterations.
> >
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >  Documentation/core-api/index.rst              |    1 +
> >  Documentation/core-api/maple_tree.rst         |  196 +
> >  MAINTAINERS                                   |   12 +
> >  include/linux/maple_tree.h                    |  673 ++
> >  include/trace/events/maple_tree.h             |  123 +
> >  lib/Kconfig.debug                             |    9 +
> >  lib/Makefile                                  |    3 +-
> >  lib/maple_tree.c                              | 6943 +++++++++++++++++
> >  tools/testing/radix-tree/.gitignore           |    2 +
> >  tools/testing/radix-tree/Makefile             |   13 +-
> >  tools/testing/radix-tree/generated/autoconf.h |    1 +
> >  tools/testing/radix-tree/linux/maple_tree.h   |    7 +
> >  tools/testing/radix-tree/maple.c              |   59 +
> >  .../radix-tree/trace/events/maple_tree.h      |    3 +
> >  14 files changed, 8042 insertions(+), 3 deletions(-)
> >  create mode 100644 Documentation/core-api/maple_tree.rst
> >  create mode 100644 include/linux/maple_tree.h
> >  create mode 100644 include/trace/events/maple_tree.h
> >  create mode 100644 lib/maple_tree.c
> >  create mode 100644 tools/testing/radix-tree/linux/maple_tree.h
> >  create mode 100644 tools/testing/radix-tree/maple.c
> >  create mode 100644 tools/testing/radix-tree/trace/events/maple_tree.h
>=20
> ...
> > +Allocating Nodes
> > +----------------
> > +
> > +Allocations are usually handled internally to the tree, however if all=
ocations
> > +need to occur before a write occurs then calling mas_entry_count() wil=
l
> > +allocate the worst-case number of needed nodes to insert the provided =
number of
> > +ranges.  This also causes the tree to enter mass insertion mode.  Once
> > +insertions are complete calling mas_destroy() on the maple state will =
free the
> > +unused allocations.
>=20
> mas_entry_count() has been renamed to mas_expected_entries().
> (Note: test code is still using mas_entry_count()).

Thanks, I just discovered the test code issue on my side.


