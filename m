Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3AD4C5333
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 03:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiBZCA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 21:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiBZCAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 21:00:25 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCDB2960D9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 17:58:25 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21PMY2fe015761;
        Sat, 26 Feb 2022 01:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8rD8w5V54n5fuvZ8Pjwp1hgrp7l4GQlcKMlYWMclA4I=;
 b=Hu143O0Vn+mApsNuerAFI8bu9wLp92JlF7L1tVIqHHc4DIi7eFvhwD8RQ6uYUHJSsX5p
 DwvPHLWqHT+wWKizYyysl6OFBYM5QwEMjjOhUrr732FrHQUnvoKI6u/m5JBWi5UFnzXH
 r8HI6M9MbW3aHBEUgavIxQexIrAGfYSYLLQWWOazny4ZsmC4nJWnTv8Gf8ILXkppy4FX
 rCcPP72Y8DRASyRuTztnajihqgmBufNeZtzqao4xyDXemAbjbHh+AmkHAhJeiWBLw3gr
 kSLnKpi8puOp7CP3KrE3a32ADn+bhAN2YrWe68xuRZOelhCLr9gTxd0FKJVZVE7fMX51 Vg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ef06b1tr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Feb 2022 01:58:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21Q1ulv0090098;
        Sat, 26 Feb 2022 01:58:11 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by aserp3020.oracle.com with ESMTP id 3eb485c5tw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Feb 2022 01:58:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbLkYAccrot+UOmh2SFT/kpiMDOEMEwCkh9rMhG/Yr14n4KdZ9jU4uwSskUhxugy2dgmIw55p+SFRbcbkDkDURo8vcHYB2wfyU85n5Twhz7Ao+doD+5o290lCbDWUb79JjH4mabqCHgq+PcTYibbox7eUXs4GNPvH4jz/xLU5VSzRx+4eJcrZW69h4rvNboC9Q1KX0/vr0uKDKiyVqj1bFTULN4ujhIegR/WPK6ZoL13AkB0loN4Xc6A+rFwWM/PFqbqm1dMiFMzRreQ9Xq3VuE2uaXgaX33UuDpXFhmyvfaa9ENEGqloErhhVBq4F0PquUQqeAaes0OThwAmjUwsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rD8w5V54n5fuvZ8Pjwp1hgrp7l4GQlcKMlYWMclA4I=;
 b=Qmk1XBSTwoPk8w5tadMBL4Uo5Rudp1jAI+6B4DkEp+gtWj0BrcmpKrbwynxNNwcmnuhfD400dpZGh8rGSx5C9ICZaEkMB6tYwh0Z8/ZLQXzL02Of8aVUL4O6yjLxWkLmgBH8PKnkiU60OJo98eIdKRvE8F1+ZJrxT1Y5lmSbT3i497lJaF8uHIYmlfugJWmBoWFs5f6ebhOsqocnKJSnLuOwZuPbyM5Kialx2jU6tNagPZ0Xh6gwxOGoFs2Oo5JqAjKmOl0wWD/fb2imGJZX+WrTvRZXhUENiDIxuOYgCYwUpSrlS82nCOnbGVQN9Oxp63v15JSTCPqwT0ATo3/rmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rD8w5V54n5fuvZ8Pjwp1hgrp7l4GQlcKMlYWMclA4I=;
 b=NODQ5rVf7e59u89uUdOjAKqV/mcslYtgc/l8A9ejefFQGWCZ0LPEAuF5i9wtm74M3qtEmoRbogxneRVEcJ1/2oMiBivZZgtnM6TjaU/OOs7R0H8KE7cXrrW23iakY0mswO6eoFryVKcglsWKeI+tGQZD84v7qiwY8lK0ptAuMpw=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BN8PR10MB3666.namprd10.prod.outlook.com (2603:10b6:408:b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Sat, 26 Feb
 2022 01:58:09 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::496:3f86:4e1c:1d5b]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::496:3f86:4e1c:1d5b%6]) with mapi id 15.20.5017.025; Sat, 26 Feb 2022
 01:58:09 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Nathan Chancellor <nathan@kernel.org>
CC:     Qian Cai <quic_qiancai@quicinc.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 00/71] Introducing the Maple Tree
Thread-Topic: [PATCH v6 00/71] Introducing the Maple Tree
Thread-Index: AQHYInmXxzMTjmF25U+e/3QAVwcn6KyjsEsAgAEA+wCAABTmAIAABoMAgAAlWwCAADGWgA==
Date:   Sat, 26 Feb 2022 01:58:09 +0000
Message-ID: <20220226015803.h4w6y3doe3om2sbc@revolver>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <YhhRrBpXTFolUAKi@qian> <20220225190846.u4fwebimd5ejfdpd@revolver>
 <20220225202334.bsw5t3retcchpn2e@revolver> <YhlAPOquxUICyGsR@qian>
 <Yhlfkk/gTz6a/hOD@archlinux-ax161>
In-Reply-To: <Yhlfkk/gTz6a/hOD@archlinux-ax161>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63e06240-8074-4a14-debe-08d9f8cb7035
x-ms-traffictypediagnostic: BN8PR10MB3666:EE_
x-microsoft-antispam-prvs: <BN8PR10MB3666110D22F160F1DB6CFF79FD3F9@BN8PR10MB3666.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1z2er/Tv9t35QCcE2x15BIiz/zLSRvTdG8TZrMeo5TciLX5l7xAiyjBvwMgtV41fbh/F9vmnrFqOkD+x8u2+Vnp5579v+6qtuwpzQh2BKGnlPZl9X46HjlMtZZD2CDMmMmSjBva7Icsgrg98Z24lUjk37a8u5wkLBSzKmrJ2W4t9rnOVVUn2NbUNnw/rjUZW2tf6tGV1jPUBwk53SgVipDWo8txU3CRtb/kEAWNXWsnScy9sF4D0J45n+qW1tIHJx6AD6a84R0FrVnwObZmjNPC3Puo28KSbIQcPOGn2zeXVEVLKAXFAnguy5oVxgfe0COC4v2e4kv86j7FJDmGtCBb80K9A1NpgfyMs/71rRTJOK0jWa1NnN/NmrTP4dleA8A7QKYKNECyS9FY3Say5hrOYzP4ZupFtjmph40NUfl2GQWk6UQzVKFIFSkMeapl69kFid5X2GxE1/hGBcEbSva3I3S5A5lk+ND5CXf/LSQqF3t3ySkdUQnzbXeIaGaAvJ67eMq6J0eZNMfmU/WyUz13lHMJI64z73YkEXXMGfeFUvOc2UQ8KmosgsgwT05rngTxmRlGVt0oG7L4/7nT5RHjuOZ+9cNnR9spqdE7heb7QxTiBeQwsqUlD7DnOiDd7k1hKEkfAGAHgG23Js/eCodH6lA7oQqm4sjQtaujhQKSK1ACdLwsR0N7LwlgW39ozhGVX+fk7W1Nqlw3u/bDmEhXDWqRIP/dQhjRJf3So6ZARWzRvgNt3xoP5nToX9wsDhfMpJxJUTLAFetmxl3XPTASczObm630bZUKq0xu89P58irbhqld8El6G80ZA17FVIM6mgwFqjC4fO+t8fCzO/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(8936002)(6506007)(44832011)(5660300002)(4326008)(38070700005)(2906002)(71200400001)(86362001)(6512007)(8676002)(64756008)(966005)(6486002)(54906003)(122000001)(508600001)(38100700002)(91956017)(66556008)(66476007)(66446008)(6916009)(76116006)(316002)(66946007)(9686003)(83380400001)(33716001)(1076003)(186003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WVGjkbIeeFqIEduxbSiNvu7W6RNJzgiwmM8PZyagyiYn66T0wKbWyZupJ9YX?=
 =?us-ascii?Q?dW7hybgof6RbPcskcs7Y6/nw8GjX/UWmJaywAiCI0MiKxqZKiBY0+NzluSc0?=
 =?us-ascii?Q?OivAGrlNWAE8M8jx6WqOuI3iy6KsNtl6s5866+FKm4UQuPtQhqedZZuISbuk?=
 =?us-ascii?Q?GoGOCQ4Fn0JTOETIPP9R1ufcAOTCU/mPH5E7DBpgu8y7KMBC3y0MFZcZXJUY?=
 =?us-ascii?Q?dukMpklOYaqKn1SIK+wqfoyCbn7Il6Pc3Bj7zROB0C72sxwlvrUSG5je7pPg?=
 =?us-ascii?Q?ZJxtTVMf5JRBx34Q2M472USxKE01MUseZ07X1kzyAm22quTz3X0kph0n/E5V?=
 =?us-ascii?Q?bdCDPMbBDciLb7OyuhN34hQZVWnNgaJSPP0reZNE8TAdtWtPzGlaTrsbr4ES?=
 =?us-ascii?Q?Tl75m4yZCY6GxS4aFIHA+OuYs8rud2cy7w+q+iT0SDXxKgSJNINPqDuaRIvG?=
 =?us-ascii?Q?g+CgaGS0BpX75jSrekjXwf/b6HVCOnRzCvht0ZtgHEcFhRrClZg6xEgZSnC6?=
 =?us-ascii?Q?ubxaEhO9UtlmiAU2GjgTbLLmteGRkmWRtyYaDwUFDLpvdUVcbZENlV9t2Hxj?=
 =?us-ascii?Q?IkFNtKoamzzVSyIvDcYFynRg6Ol//idWHE2tWGRcsjHZWlCtkv29i2TzDWsB?=
 =?us-ascii?Q?VMF1+wAYXu2vH0WpHQGDlwbG4Z+pSLjFosUMUcFj2zUa1XQKDT/4P4I2KFIc?=
 =?us-ascii?Q?/gnme5AhWIfnrLGAbJqp6/PVLSQ3hFtGwsaWDTr1HTNBa+buFIh2dxgZ+rhK?=
 =?us-ascii?Q?BrNfOzy6qptTsSFmlt3h0dZb4bO/qOs+QBidm6DXsxf83GIpiHPL1xm0RZZl?=
 =?us-ascii?Q?KmoggIL2kC/tekAVErkdYeXPOxFvZB8SCqJbRHKj/J+mEU0Dkwwkr1iDI1Bs?=
 =?us-ascii?Q?lbBfcCxXQOUx5abpGTC9hbDYd7qiOWRU15kdStKfBDnxYKIAz0R6KaI+ZZWd?=
 =?us-ascii?Q?HvUGdfz1ypSaC5wpJLtFRiB3TaLQX16pkCYnuxRllKwEk1fdomaFO/PlU5N7?=
 =?us-ascii?Q?RN3yPwph+qE66NCuxZlYdaqQTva5RWByi8wq0nViIDqp1gUKJDO1FdBCUyG+?=
 =?us-ascii?Q?JZbY7eEL77DQQaHuyQDZjtDvY1WNn40CKMGehtX5floc2zJE2gFB7UqbTHLh?=
 =?us-ascii?Q?8y2sfWUJ16lj0TB/a46VeRRGpKN4vlMnSjccFwBT4nnaPDhCbqNJy2i9wEwg?=
 =?us-ascii?Q?TrbMLV6zt9Uk2IvZ4TT80Kq+vWXo4WSI0gW5GPC44WjL88BUwFNrNB3s5dz+?=
 =?us-ascii?Q?7c755jVu5h4rDI0jMIPAl1yKdQk67J4z4eLyIUBM96f0PiEHEbV3o1Wun4H+?=
 =?us-ascii?Q?TdkL7+0XNtErVJUk2618v12rM21qG3yPMgP83ZlpLTCpvinWPwiSYusBFwhz?=
 =?us-ascii?Q?LmBukoJ3l9WrlA3aXulYiwKbi2X/qHVWlZSHOw1pPdFN1Qq/aUEyvu0H2iux?=
 =?us-ascii?Q?MMHxL5AJXAC/mZJiNxw2NfjBy8dm9rCX+hZlwRlEsDXLLmCzv+3yn/9DfcI4?=
 =?us-ascii?Q?vlATD0K0VhvLqTzWoUxjchifIg5UcRmx68Z9s5ajajrb6bZLe4jW4kCiIK5u?=
 =?us-ascii?Q?fTu3YQ63PBW7QLvYJ7iGfLRIv7InDuOrQ90bhr/Tbrc4IC+jLCadksw2Qpar?=
 =?us-ascii?Q?aPKAtdd46Czbh8/pAEFm6MU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6B73BE56922565409602D10835C49E3F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e06240-8074-4a14-debe-08d9f8cb7035
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2022 01:58:09.3326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qxpWYcRybDuE3kS5o3caFGwsp7gigClRso8nJH/mzDbhDSKNppzxdYKZPjcDHKhz/8NG2V/0DZia80zmk9/Qzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3666
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10269 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202260014
X-Proofpoint-ORIG-GUID: p-21_5Ziu0ekeqoOBKhDI_OOWjZX646W
X-Proofpoint-GUID: p-21_5Ziu0ekeqoOBKhDI_OOWjZX646W
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Nathan Chancellor <nathan@kernel.org> [220225 18:00]:
> On Fri, Feb 25, 2022 at 03:46:52PM -0500, Qian Cai wrote:
> > On Fri, Feb 25, 2022 at 08:23:41PM +0000, Liam Howlett wrote:
> > > I just booted an arm64 VM with my build and kasan enabled with no iss=
ue.
> > > Could you please send me your config file for the build?
> >=20
> > On linux-next, I just do:
> >=20
> > $ make arch=3Darm64 defconfig debug.config [1]
> >=20
> > Then, I just generate some memory pressume into swapping/OOM Killer to
> > trigger it.
> >=20
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git=
/tree/kernel/configs/debug.config
>=20
> Is the stacktrace [1] related to the conflict that Mark encountered [2]
> while merging the maple and folio trees? Booting a next-20220223 kernel
> on my Raspberry Pi 3 and 4 shows constant NULL pointer dereferences
> (just ARCH=3Darm and ARCH=3Darm64 defconfigs) and reverting the folio and
> maple tree merges makes everything work properly again.
>=20
> [1]: https://lore.kernel.org/r/YhhRrBpXTFolUAKi@qian/
> [2]: https://lore.kernel.org/r/20220224011653.1380557-1-broonie@kernel.or=
g/

Maybe?  I'm trying to figure out why it's having issues.. I've not been
able to reproduce it with just my maple tree branch.  Steven Rostedt
found a bad commit that has been fixed in either 20220224, I believe
[1].  It might be best to try next-20220225 and see if you have better
luck if that's an option.

[1]:
https://lore.kernel.org/linux-fsdevel/f6fb6fd4-dcf2-4326-d25e-9a4a9dad5020@=
fb.com/T/#t


Thanks,
Liam=
