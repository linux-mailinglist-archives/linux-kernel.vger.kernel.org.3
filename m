Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC244CA780
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241219AbiCBOJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242813AbiCBOJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:09:34 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3F02DD72
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 06:08:32 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 222CT84J006557;
        Wed, 2 Mar 2022 14:08:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ac8dw52fjLWlZDRBaGJEKwX4NiC89aw/sWkJc10bJN0=;
 b=hRsuWphBdSgpacbIgzklvAdduRPjd1+9GEsJgL5bHyM+Vklp1Ak9e0nDCBloHsI6IJep
 SGb9nXjMGyPn9+gwiQtyCu8cHVqB9P5X8w/6E2myeJ1u1qkqmZQOPsri1+RcitLmDXDh
 j/jb0qNVPIlG73syggzKltnLlNb+Gy2HYAGLm6fTBSQ2PkyPis3Ux6CmsSLnR8lY55QD
 GmJdBWu95cRyvsdyA5ZyWxof+Z8eZYCHPp+/zsbApJP8gOyCsjVrDHBO6bLJc36y143y
 XSPwls8JTkCSOOaHKgiwsK+DZQUFfe3jXtbzwzUCZX7UtKgkBFmfMUV7xroPASiycAFT LQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ehdayv7xj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Mar 2022 14:08:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 222E6qOq039772;
        Wed, 2 Mar 2022 14:08:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by aserp3020.oracle.com with ESMTP id 3efc16pavw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Mar 2022 14:08:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkzGmzav9poVLMFWbBNZRis3tNfwCVT2XM0cdYdUrngV20+czoAVDJepGijPgDT+Ny71BClDS8nBTYwt6d5rwdnRsLQk43MeKUO3Vg6Iv3r3h8bx7jRgfWmum1qKTFYANw8ZVq3b060vwI+5X+7ELXGHqei7cozr3ftzC8+FP1ky6zTqVL6FckOalA1TCvC1EyAHrp38NUNt11GfNTw/i4kqe8We5q/0NEPL0rOzT/DW+Mes2hkkFs7drB04DACwpacjxLUokkoePWbwPXnFzJAOOqrEMB9JghmZcNpghkVso5yuNUZD74Op/u/wwSra9E9lTLtnfPvl4OFRKzdG4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ac8dw52fjLWlZDRBaGJEKwX4NiC89aw/sWkJc10bJN0=;
 b=fbsy7AZTELEPQDsAKl9vWjNNJgWpOV/b6YRgUONEi4ETyGmH/cY12UlnXUVmf84OYj9snBHs3ZjrRwHfC0y5ZTWgjoTVvC63lV237gVp+MrTTIipHDyAZdI+fM/elHsTx51tFOJKj2B6eykUa2j55YXnsWN6YqjSjGOs2++iyFAu5s6lwrWFXAR/ny302gaLkrIg1JjsNwa+PaO+k/RBhlpypw9pn8yAyz+srmzqRXBpEWroMfCgYID5KmVPlZvLC7pjY/XjiEBLZD67wNxzkgWNojovv3e14hjnb9DVUfvU78f3Z0xdf+Y46zX8J+rEXgaPSy4xKWYDSK35WI2M4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ac8dw52fjLWlZDRBaGJEKwX4NiC89aw/sWkJc10bJN0=;
 b=wZFPSRLdQk3xHyQpyzOLmoLEXdR3AyobhXQZjCnRq40uitY9hZSU+gSMkOHCKM/gPE85bYP928Dj+eu7O3E6K3ZsOLdRDd/vRapG6GpeJ5F+stXQQI1w+HsOpWRstg8WN1MABb9q7vd8jdu1Zg6y2Nvti3NY2BmG+atOlMvIh/Q=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB4948.namprd10.prod.outlook.com (2603:10b6:208:307::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 2 Mar
 2022 14:08:06 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a%3]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 14:08:06 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Vasily Gorbik <gor@linux.ibm.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v6 08/71] Maple Tree: Add new data structure
Thread-Topic: [PATCH v6 08/71] Maple Tree: Add new data structure
Thread-Index: AQHYInpU/hKtaWQ3X0yDuzeh55NMz6ymqQwAgAJzKICAAL9NAIABOHaAgAAktgCAAQA8AA==
Date:   Wed, 2 Mar 2022 14:08:06 +0000
Message-ID: <20220302140725.4yxcedu35dswxjzu@revolver>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-8-Liam.Howlett@oracle.com>
 <your-ad-here.call-01645924312-ext-0398@work.hours>
 <20220228143633.r4zoemgtmrq4uzvb@revolver>
 <your-ad-here.call-01646100074-ext-8278@work.hours>
 <20220301203935.r74qjc7p6qbno4xw@revolver>
 <your-ad-here.call-01646175058-ext-9349@work.hours>
In-Reply-To: <your-ad-here.call-01646175058-ext-9349@work.hours>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0901b850-5172-4f5e-c266-08d9fc561312
x-ms-traffictypediagnostic: BLAPR10MB4948:EE_
x-microsoft-antispam-prvs: <BLAPR10MB49487B6BB60444E963A98383FD039@BLAPR10MB4948.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7jY0tZXCNgyYRlazOEciHX8FrOvYAR4ar4KmJc6Np/GiuULEnCYSW4MTEEAuemWKsXrsURs3ltmfBbzCiSfXMsWGKq4wr5ydCABIIGyomouVNDrUd5ATyljCi09pFfGIXpJmk1vU6fWQbq3fvGYQMPz8Rpxc4t3cI1FrNHwx5IGU+ol9A0wcWvfaLPHjAi5jGlVaLIhLZKVvxwLP+pSYoPMo3rFIDXCsN/7RBn1jUURmLBTB57phCFLZcz08Eqm0SyJ39PVQBKzt+av755R051cJ0FhQXDI8Jinxk6XzNVS+6bh2QKyBexfCUHAkBd9c4ctohiqPr8gDjkWpGrXkhISJu0k6jCYAjUj4NJt3pAd/zKRJQS9GqAG4Z8h662figO1oiYU8S1cCocjA7aRZC/SQBZQhqYCiNQs4RimC7ySWwdZLSfZ5HqWnCZkdm8+HmZsRG9GfaVbuRT/d1DURo/Gb+/sZTG4phj0GU/O2IvpJ4xEkY6OJ3UUbHpW+RzViRbCJJO+mDCw77oxyCItXzjA9xSPfvta8IHHcaQlhV4T8rmJDgIgw3xWowvuz44NIG4W3S8BpyL6Qp4xQkVCs6zs8x+6PTUWnc9guOfP4Yt1IG5TL9AwuQIALz2SKwMbrZPLG+9/ugvYdlmpj32eVH3Hh5Ctl6ovuA2uNtP7H4t7Hv87ruz7i8Qp71E6CgE9/9t9r9vOfkV/NYTh37v1YqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(86362001)(64756008)(8936002)(8676002)(4326008)(66476007)(66446008)(66946007)(66556008)(71200400001)(76116006)(33716001)(44832011)(2906002)(6486002)(508600001)(91956017)(5660300002)(38070700005)(38100700002)(316002)(6916009)(6506007)(122000001)(83380400001)(9686003)(6512007)(54906003)(1076003)(26005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3yFGcfyy1IPLjdpadaPtIKb6IEy4B04QXbakk8BAZjEG1Vq2XYrmKuFTLBZL?=
 =?us-ascii?Q?j8NtnYnt6ZR85O5RUD7clWVvDzsicm+9nlAIE7AaDQla6NXiIKOy7Db8E7Fs?=
 =?us-ascii?Q?Z5VMwBaEqTU+S3cV8j8mZN74pLeYxNRvOuLS5D7iP6giUMySMwuKRLL1bt/A?=
 =?us-ascii?Q?Wo3SNsNqV2Ce7AfmvNTsxhSb8xRk+FCCaHFYb/id9S8xJdw/L18nNEqt/jgX?=
 =?us-ascii?Q?VonW1iq4w9m7KjvOXl23K+B8r5BykKoP1zlD3Epz6KIIyi70UoSYzTqzYDGB?=
 =?us-ascii?Q?vM9aZCbdPDGiHR7JYglVIRaWx0seL+mysc9oQSgUidFGVCbKa4TpfFbrv08w?=
 =?us-ascii?Q?+gyUJBQTLks50AZhTi2PO8o/xGqoGEewtnYZfCu+KLtrzwanaP4oF8R+D//F?=
 =?us-ascii?Q?h+rMcX7HQYWBIH/886HQdHTtxFSzGo3ZecEhtKZEhgXDzWMdMXifIeGDf6fJ?=
 =?us-ascii?Q?/rEw+aGvXrGClvPRbYsM4eM7tiAnCOm8ZXxCwY82UICEC+lA6Q4WlKe+yx30?=
 =?us-ascii?Q?TQm9MBqpoBcFI6RckTlGBZDPdS7wr4Ziibd/Y1FUcU3LE2VI94cBzZPrhmbE?=
 =?us-ascii?Q?xBJzo37kk4nGYbJI2Mx65t6eneRssJnMcKYwYa+5OBPOOFpe0U+TCOQpdgUA?=
 =?us-ascii?Q?Zfu5a7ao5GqNjZbNkqBpi4P+2DyPiegFaWCqu0/TbKqK93GvfFlmzRgptDri?=
 =?us-ascii?Q?ebMNGU0NaOr7RkdekYaJfxh/j36S8dwetwRMmQeROhoBR+y6katLbu/Bxj0P?=
 =?us-ascii?Q?dyKq+W3HdG7oo+YZGDtPdqVGqvBEg2ExrMrVA+Vm2uVeZBTK6hjytKTuN6hN?=
 =?us-ascii?Q?4BKjRLQsGFtq1QU3bBSMykm/EKC4Zpy5bePnjJszeNaRDGf5gpog3gg5l2XP?=
 =?us-ascii?Q?rbdrNbzqydJxtQNqev/woJM1pUQIPdopnpEaEGHzLEVg6AwAeUzthBaktHXF?=
 =?us-ascii?Q?p+Y6PukU7cKyYOCeUkAm8gzMG75xn72PWK33FK6V4Wryt1M4m2nQxTllUde4?=
 =?us-ascii?Q?EqE/yzprMWT1qHR6VRpFscfhYd1YlePnFSaAR3tXHPW6IY5WXP3gIMoE+WXJ?=
 =?us-ascii?Q?oveMW5WDLgXDVRgaZMqW438XT5vNyxr+ZiyMrbXp+SgMSRA43E3f4nFcZL9L?=
 =?us-ascii?Q?QmMx+PYOOVw9yVgDm/TwAh9uUqhQbSxJuZ/xE7HzYP81D8Npoza4L00OeTpj?=
 =?us-ascii?Q?kZ5wgD/ElCQRq/aVIrPKbO/RzKQgw+tzmDeVYR5RWdbfa0vNX0qiR54kTDma?=
 =?us-ascii?Q?ui4HdhmKjysU5axR/iI4vypweHgL44P98J6szKWk6ayCySUGstpXLygDXDOc?=
 =?us-ascii?Q?o93HHz6OpCtPVz3YBD45kmFZFmg5iJdrKD7cFW4SJyG6MX/9x9Idae3MBA2m?=
 =?us-ascii?Q?MgAML7GrdFMBYs/g9b8rHliyyjaNc7fxJs5JMCwsJmMDWFC4LpJw2kydZnbV?=
 =?us-ascii?Q?R3ncIxfpRq3VQl8VLwmozYaLF1t1CusGv6i5MXrvyWF9cG+JuKKDZB5MGWws?=
 =?us-ascii?Q?PXAooyxue8gcgQCAqFd7c2WOZwquD3OhzViXGFyX7ZyLoGCOCT5udShmypO+?=
 =?us-ascii?Q?anTtLywfvV4bRhr8+3EzfpWa5F9kn+lZIDpsWVlpl5mA7tUo9WIlhzcnwWGM?=
 =?us-ascii?Q?cOTCyvwrw2h9k6sliqz+Vmg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <95B40A9984349E4681D528368CB69D75@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0901b850-5172-4f5e-c266-08d9fc561312
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2022 14:08:06.6238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: at7tzbUrqz/cEliTeZPAsnl8bIzrPCiGUa2gwXFmMwfcUqWtS4RFi4KFyBNhbIS2PGWD1esdF2fHQSw9/geO4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4948
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10273 signatures=685966
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203020061
X-Proofpoint-GUID: w6isX6pyppS3AQ8bE1inHXW6p3C0nNuq
X-Proofpoint-ORIG-GUID: w6isX6pyppS3AQ8bE1inHXW6p3C0nNuq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



* Vasily Gorbik <gor@linux.ibm.com> [220301 17:51]:
> On Tue, Mar 01, 2022 at 08:39:44PM +0000, Liam Howlett wrote:
> > * Vasily Gorbik <gor@linux.ibm.com> [220228 21:01]:
> > > This condition is not present in mas_dead_leaves() where we potential=
ly
> > > iterate over all 16 slots, simply checking that we have a "valid" nod=
e pointer
> > > with:
> > >=20
> > > entry & ~MAPLE_NODE_MASK !=3D 0
> >=20
> > I have fixed this and another issue that Hugh pointed out [1].  I have
> > been working on an s390 VM since you reported your issue and have been
> > getting strange behaviour and have been able to detect the bug reported
> > by Hugh with the config KASAN option.  With the fix I described above
> > and fixing the do_mas_align_munmap() splitting order I broken in my
> > linked list removal, I am now able to boot my s390 VM and log in with
> > KASAN, VM debug, maple tree debug, rbtree debug, debug page flags, and
> > Poison pages after freeing all set in the config I use.  I've pushed th=
e
> > fix to a tag on my branch [2] and I'd appreciate it if you could test i=
t
> > on your side.
>=20
> Great, I gave it a spin and it looks much better now! I'll go run some st=
ress
> tests.
>=20
> BTW, since you've made efforts to isolate mapple tests in userspace I
> wonder how much sense it would make to use libfuzzer to give API some goo=
d
> coverage-guided exercise.
>=20
> I've written a minimal libfuzzer test (just a hack) for the "Normal API" =
and got
> couple of flavours of crashes. Just rebased onto your latest branch state
> and still get them. Please have a look if those are valid findings.


Thanks!  Yes, the first one is certainly a valid bug.  I was able to
reproduce it and fix the issue in my tree.  I'll have a look and see
what else it throws out.

Cheers,
Liam=
