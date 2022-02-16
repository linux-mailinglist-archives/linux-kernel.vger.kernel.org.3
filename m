Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9166B4B9041
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 19:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237609AbiBPSc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 13:32:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiBPSc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 13:32:27 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1E611ACF7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 10:32:14 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21GHiJkB027784;
        Wed, 16 Feb 2022 18:32:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=eBh5I30Owh+PlEw/0NQcjHSWPduUMiCb/mBTT5iHguI=;
 b=tYjq9MAPv9EgzEAwvWNg8wHj1yq1YeAKt9Oq4tWBexuWYWt4hc5OMO2y7gaQ+tUBKEf/
 dKRvHDZblfL9f/9dfolQ7THRRW22me/2pctTdS14IVK2M5iExsq/Fu8ZPkGCHGsRbrgg
 wSTlDfRIFKsDIrCjolQtiSb4aAYpHhlQkg/Fk/GNjU4vOjcqe3YIhLsLb8CcOvnH/anS
 kskmL3LkPoy15NhdMSWeRh1j7s3G+5MIK9UmBAUiCbvu/icMcUwsgUHV3fX+2qSlOGlh
 rXokk3n8+r3F8Yjnpm9QHKdc9enyB4GQLM/QCdp7sRLlxX7VQYXkucCG6qCocSG4KKNt CA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8nr9376p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Feb 2022 18:32:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21GIUWKB002904;
        Wed, 16 Feb 2022 18:32:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by aserp3030.oracle.com with ESMTP id 3e8ns9e6sj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Feb 2022 18:32:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fe2N0lIU1xYzjkdRw6weFToIJaIkxdQnMOmZXU054xOCcKSUtqHLomVX5Y+5/b3Wf/HfbSBI8+Kll/VU4tA99QG5aWmJcrn66x1tCpKaVig0VchMnA/HLF9cd+HHRL5+EUffEGSDo9nl7Mqfr+3XVxDzpQn97h4qk9Sk39/SjdQ6EFNmb1LmQqcRPJ1Vi7W7bqeINLvtjby7tSVT38WxQp4B40dUdbwYM1zYXgdqdnstFuoHsZtY42lQ3LmnqIc4PrxSRICaiT+j/2aIpwArUNKSqnhQvDcmQub2k0l4BmrHVpYuXkzC5wNk4qGCNubNKIJ5j9/B3+lZi0qAbX1wyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBh5I30Owh+PlEw/0NQcjHSWPduUMiCb/mBTT5iHguI=;
 b=CYM+gRsZWjuWlxZuENl5I+4g9s0AikucdbDmnJLSkwAJ5pNFu2hC5gJ4rC+s4o/B+Mlbh2lU2tPPxprjLV80onSnkv/YZAm6piqyWGN22sjBClGJir6hZGsFrwTPMDs9sn53Q26MnudVdAk0dL42vtVLiQzo7DTmcIu/Tcyhg8FXevI1e2LB3rTyIr089UQ9wj4udKVRgKLv09V8dk6K5gLaeVKNoCY7X2YZPD9Ld0+0MbEmk9OUXbmVldFfJ+g6f8eMYup4tBDYjDoOr5V+stfH4AN95pQoW8jPKA+n365SxS7EGXM+KWXrvEzn+aZO3afYgP7nFoJml3zQ1ZVIww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBh5I30Owh+PlEw/0NQcjHSWPduUMiCb/mBTT5iHguI=;
 b=I0GUhTQUqvHiO2TvHL0/+EyOPdAmbzgm+G0dag1nj4CxfWt8y1rz7FyDF2PCpIyw/zNF76b8ZgnXOhbZv/8QhsSoABzWjjccm2gZ2/dxDPcbpvGMvM5aPeA0pI3g7EeCHiOC5CqXoOm2C7aoWBKsBiru+BL0cIq3w1+NgSya4fg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1734.namprd10.prod.outlook.com (2603:10b6:910:8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Wed, 16 Feb
 2022 18:32:04 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Wed, 16 Feb 2022
 18:32:04 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Mark Hemment <markhemm@googlemail.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v6 11/71] mm: Add VMA iterator
Thread-Topic: [PATCH v6 11/71] mm: Add VMA iterator
Thread-Index: AQHYInpX4E2+2y4Cnkm1gGIt+et0gqyWATWAgACA0QA=
Date:   Wed, 16 Feb 2022 18:32:04 +0000
Message-ID: <20220216183155.nstxhvhggrxktfoz@revolver>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-11-Liam.Howlett@oracle.com>
 <CANe_+UgS7Gh2i=aPQYO4nrLJ4kL-2kkkrj8Q1kUztsWAAPOWDQ@mail.gmail.com>
In-Reply-To: <CANe_+UgS7Gh2i=aPQYO4nrLJ4kL-2kkkrj8Q1kUztsWAAPOWDQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ecd42289-214f-4b0d-429f-08d9f17aa170
x-ms-traffictypediagnostic: CY4PR10MB1734:EE_
x-microsoft-antispam-prvs: <CY4PR10MB1734CE0ECB9450C9E92BEA27FD359@CY4PR10MB1734.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RFP6Q/oPOdAyGCLfqrr4bwKWXyXK0h11ctO0jqvDhMWqC73WmtffpoLzJvVRDpVngIYmpqCl1LcA01WkmlzOJ10QzD4mG/Wp23rIM0nNRNimr8OCW5vJd53n9KpKqqwVNCW3HXcqPlo6MSaNtcBT3recUHvzJM6du/HPq7iq1UEHccFgDMKe8BL4z8F1/6xxweL45Ks1nkj8dcs7oPVcuBsfU0ZZn6+aAaCPl6aq3XwfjMtoZcE09p9dXjCCJmoBA2fCjuZdyMJtvf3SJAiZePnEPOif9tlX8Ppoy0FaxUJQHb3kbJNACkKZ5xB/8ueIFvrAXZC9lJd1fkK1ZL7JN8nkguOGo1bQDqSSMUTw2cVGh6Qp6dZAJAZrRW/leUEC5P9zSMFlahVVRQ0TTf3B/HDeSNwxOevAcgOqAacH+oR1WytHl73wdwZcp4c3d4TaOiCt4wwkpUxLcEev9vG87FBWm0mAoPBlomguVk2XP+6rCd5eq7CQskjoP98g02JG0k5eA4E/AIXZuoSvTJ0B2PNkeDib+txxiBAsW7wI2KgQvO3tN8mt8lZzaaChSCQI0epmu+v8p3LrvP8iPxeNYzv2zCSiWbHlL/Skioa0vOhZpKs6IgT0WusiyI75hYt+uDnVLDtRZrfLz4wj9ncob2V+oKVwbhAowCOliiGoUFQD3V2yNeEIFYljwEFFOhHJdkAdJYWoJ6gv4DehItz8Cg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(54906003)(6916009)(38100700002)(86362001)(38070700005)(33716001)(122000001)(1076003)(3716004)(26005)(66476007)(44832011)(76116006)(6512007)(9686003)(6506007)(66446008)(8936002)(2906002)(8676002)(5660300002)(66946007)(4326008)(66556008)(71200400001)(6486002)(64756008)(91956017)(508600001)(83380400001)(316002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f5K9/XECUAH99idgGxJqZo1L8H14yuU/QXkI+OkOB0M/lv0J2zP4p6AIEnp6?=
 =?us-ascii?Q?WBdXSarF64JB6LElT0NzFmuZHFJrtMnqhml842bEjhzRHhnnDEAipxxbM0W1?=
 =?us-ascii?Q?Ztyu/F7xAhOoSfqET3vYuvrK3zWFh5BaOSIYtvNusBhopeYS1l1KJx/gZY0D?=
 =?us-ascii?Q?EQ9Fbb2D9B/JfuYt/UYH0rLGwIRg1nqhhtizMNgaP/Uj1n0oF78Qn4WGYVJe?=
 =?us-ascii?Q?3v8urp01U8dRs/fBbg4jxGAuhe1PDjPmiMC/eFmc12ocbb7Pto8M9EAHxzvd?=
 =?us-ascii?Q?LMLSnCX0nezw2afTgQiAt9LGogTr9BYuCPDeGPI0hdpL2cpF7OvI4LT7ZLv1?=
 =?us-ascii?Q?62IA6c2oi/fuzTqWUqUnyE0+YEBTINTyk5b0rwj/u6zcO4aVjyEh8CB1Q4BE?=
 =?us-ascii?Q?nHqO+Mov6v3Q53v4VhoIqD4EAvLD8HIr5y2BuqsmyCcnrRUGU7w/lFxYDhO7?=
 =?us-ascii?Q?EA34uutnAl5FudwMSKNhT+qav2POscv5xvPVgsv8VUALnZt2e2KgdXwLvRfe?=
 =?us-ascii?Q?m3CFQ6pJpQw45w5govll+1t+3dzO1+sDYwh1x/RmeY3p/iNTrZSox8TDrTSA?=
 =?us-ascii?Q?Pe8tZpNcSQTX+/gGpXPZ5wGDEsfKFbWQpwl6SgUKPqinuhsryC5pohzB4KbG?=
 =?us-ascii?Q?1dsSpvEMbmhdMC+Ol3FKbd1upbMM65IIaBy5lQaAU+vpfAuu8BoQtBl/BVkQ?=
 =?us-ascii?Q?Rz1KZzyK/tODVddvukysSqghY4Ph35af+g6pavrrzGjAZvZpMq3sp18lrpV1?=
 =?us-ascii?Q?zxNn0+Ql7R3bNa5rNQjC9eDcxGo3gtpk4xvBE6X4wBykoKEWqfAfuVOs6kNG?=
 =?us-ascii?Q?6k3wvJB7MRPhmy8BvmMSzgQj5XF4GB4SP5E/7j/4hme7kIpxzucEVX3k79bE?=
 =?us-ascii?Q?HtJpIV/ZVXiW3OGL6Y70CgBJEvG87/6SVXCfYszRCRQZtNHVKkpbDRszo+vJ?=
 =?us-ascii?Q?kysrlrcK8K1Eb3th4JpsK93ZeJvlMkH4cdlck/MKONJ/2qtwWn5A0pUewDrT?=
 =?us-ascii?Q?dX9LwjtpkSMH785mE6THG/q5ARuFdARJwrriMLdffVNYTANXjqg/wMhQ0stI?=
 =?us-ascii?Q?rCTQpJjUXv46gj/e0wQpInS46JVGk08gBT6k21ZkjWlECIsMF9yJSEpAxQkU?=
 =?us-ascii?Q?8yJ31MHnHgN0My5Dt8MF6OqTNrcnNXX5sfhXq4lHdiySdTjVVht6vngL2A3R?=
 =?us-ascii?Q?bFBLsWu5I4aZKphLCGw7Uf24QYaf+s3+p28jJFNC2uLw5zXpz1Tyh6JvP+IQ?=
 =?us-ascii?Q?MPInLQ/mnfg29umj45l2OCU8mimE3YQg/2cQJYF3PBYT2b0zvnsKFpx3FEyG?=
 =?us-ascii?Q?bWdm04jB+/n33V2+Q56/u+nkGkQw6eVzJHlSWzNzALFE3UdT/KAwX+Wf8VYW?=
 =?us-ascii?Q?GFP5Wcy+ZpmLjmnQuJ9pI+9tc/IFGVtVQ2fLTbIn695PIg31gJXpvJnk8MUy?=
 =?us-ascii?Q?PupAnJTthBzSsaWpjhp0RP2/MFlIOa5MiY8/01yJmPfHaT13li150LIaO1nO?=
 =?us-ascii?Q?fZ0jSt57csodEt3NVo/Q+QIP4hTvkIjZe0eLtAjI8EYYtR51n7uvMZNXpYOX?=
 =?us-ascii?Q?8PEwGfulcunjvRu4HcmLLdmgzhACVFEVZ6MPU5PdqjF0SMjAezxJIIIzmRv+?=
 =?us-ascii?Q?bS/hIl4qC57g58Biua/VwR0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AF23630DF1E6CB429F4D2EFE11F14499@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd42289-214f-4b0d-429f-08d9f17aa170
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 18:32:04.5335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eWf8DGwQTPHr5jZBzf6D9j36yYAWoAjB9OvaoXLUtou8uv2WsSWf77Zz9Qt0VBPp11pPcycDeiqQ9fZ5Gez+0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1734
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10260 signatures=675971
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=864 bulkscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202160104
X-Proofpoint-GUID: uKle4mR3LAAVG9ep9VNd4dt2U-k_BNYQ
X-Proofpoint-ORIG-GUID: uKle4mR3LAAVG9ep9VNd4dt2U-k_BNYQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mark Hemment <markhemm@googlemail.com> [220216 05:51]:
> On Tue, 15 Feb 2022 at 14:43, Liam Howlett <liam.howlett@oracle.com> wrot=
e:
> >
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> >
> > This thin layer of abstraction over the maple tree state is for
> > iterating over VMAs.  You can go forwards, go backwards or ask where
> > the iterator is.  Rename the existing vma_next() to __vma_next() --
> > it will be removed by the end of this series.
> >
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> >  include/linux/mm.h       | 31 +++++++++++++++++++++++++++++++
> >  include/linux/mm_types.h | 21 +++++++++++++++++++++
> >  mm/mmap.c                | 10 +++++-----
> >  3 files changed, 57 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > +/* The MM code likes to work with exclusive end addresses */
> > +#define for_each_vma_range(vmi, vma, end)                             =
 \
> > +       while ((vma =3D vma_find(&vmi, end - 1)) !=3D NULL)
> > +
>=20
> Becareful of operator precedence; parentheses around "end'".

Good catch.  Thanks, I will fix this.

>=20
> Cheers,
> Masrk=
