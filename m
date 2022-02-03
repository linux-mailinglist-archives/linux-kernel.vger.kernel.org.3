Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49144A89EB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352807AbiBCRZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:25:53 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:51708 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231916AbiBCRZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:25:51 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 213HImRh030339;
        Thu, 3 Feb 2022 17:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=IGG7aVltT6+Nl5Qy5GZ00la0x1sitC4n7ot1/PF3cbI=;
 b=Y/ngYO8Yxzc/6aqLEKqGOyhvrrrQtATP5XBNXS1jC+H+0ah1GADOcYgjRncXqQ6ud4Gb
 lY8KVktjJu+mOA+/aWq2gR4LWFHaR71JYMixEhra6UeNDQaOHlgMP+HOWotj3/K5lBGY
 zrjZJKxf9JZD97DrrgPITHJTonmCFe7mSbNabu230+FXfGHiBj7wGR4qXb7rux41tbrB
 8kmROHGyp2L0/SwncSuz8/jahDP7/bCWC2EEWp8H68VIGSH4jahebt4bnN03C2/+jnny
 0IgbeNpv+M+vMsZo+F4jyVAEd5TiGZBRZI0y1oAakdFcuEJ7/cRbyZq4gm5ENag9WNdC vQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e0hfsrcxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 17:25:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 213HFnll040184;
        Thu, 3 Feb 2022 17:25:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by aserp3030.oracle.com with ESMTP id 3dvumkyvsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Feb 2022 17:25:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROsXh/PypPmxzoFefLHksJUCD9qy7jEGcmqLey/oT8AZeKC/RhTzTXBV1ppKG4ftjXFHvjiVdUCntoLthyGh583UD7Fyi6GldRDWeCJVZMijE4IJQWcQultqe6ApB/QNVWXGPg07sK9xKy+rHgIKZHUKBUoW9UrFag6tiwL/a86ucVpvehWscG3v9O1F6EJlNrnO/LqpYJQyhSWB+k7Mpcv9HwtQ1JUHBwOlWpKV10KrqzJlRKqIMEGIBmvcl1Y0dX92WjArhO/XnvsHE6j0UeJVnKyqZ21DV0FQ4p7EScipoZBaD//0YsIJ5N+oTHr20XBQ7pVX+yyvOtd8OZEtTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGG7aVltT6+Nl5Qy5GZ00la0x1sitC4n7ot1/PF3cbI=;
 b=TKgfCEu/J1dwVNiZSINNZUwjer+eI/v6f4hRnY836YShd96R6ly00r0tO5v6fhKI6UROrKzsVcu2ar7mc5vRAfM+faQjEZNZNgYLi8B2dMxrWB4fCg/LpBLFXgF39u7W6ziN9LZ1hpnUUWRmYYvpwhFb45gKnNnqkHJN/TUXPk5rSNfTRZ+7lq700SeDYUTW1HEuULat32p9JMjJs/Kxx0iFRNZ1vpojBtfCx5JxVNQvlfgJYg4pgLZwHwStfhcvxkSsyvdVTgVjeXkKHltaBN94yfuD0si+UMkuSft4GIRSUpRToksBcMCzfWcU/fz1vgP247v8XIz8TvC9vgMSog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGG7aVltT6+Nl5Qy5GZ00la0x1sitC4n7ot1/PF3cbI=;
 b=dZnB8NYqZDaj0OMRCeY5XOLlq979dVPLyFD8p/hI7o/h3mLD7ohYHocZcB9OIXRjRzoqskUXwHZTRd6aqBQPFqMKhsw6bHEPbnh4HZUAYkGFu/vJFp+u+yytPDSKsSDteKZqNjS5++1IeS7TNGDsDyywf1heYypsUBvvg803Z8c=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN6PR10MB1394.namprd10.prod.outlook.com (2603:10b6:404:45::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 17:25:40 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4951.014; Thu, 3 Feb 2022
 17:25:40 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Mark Hemment <markhemm@googlemail.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 68/70] mm: Remove the vma linked list
Thread-Topic: [PATCH v5 68/70] mm: Remove the vma linked list
Thread-Index: AQHYF96DwcfP2GXKQkeyOLdIyTnhm6yBvcCAgABYm4A=
Date:   Thu, 3 Feb 2022 17:25:40 +0000
Message-ID: <20220203172533.em5ejhfstja5lk33@revolver>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
 <20220202024137.2516438-69-Liam.Howlett@oracle.com>
 <CANe_+UjtS5_ynjfMfHC_hkb7mAADbsL8UWG7HOwM0aN3Mjn58Q@mail.gmail.com>
In-Reply-To: <CANe_+UjtS5_ynjfMfHC_hkb7mAADbsL8UWG7HOwM0aN3Mjn58Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43aa14aa-9208-4e48-3697-08d9e73a335e
x-ms-traffictypediagnostic: BN6PR10MB1394:EE_
x-microsoft-antispam-prvs: <BN6PR10MB13948BF020ACEDB3F4244234FD289@BN6PR10MB1394.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vjNbbHjyCb6guO04odkUiqtKnhSXpHZbABvWRZhqAWFUnQp880S6JVpGTJwQoNYSnRw6Kv0ANY1wEMg+E+36SAVo35roGTOJOEX8L9PHWi62Q+lV2YpZ4OCB5xAwkHSMjeoFECOmioHQh+gbSylZkxTz9ASQDY1529CFUWjWldFyAf7bLiceQlEVaWLUcLlMXpULWncc7VBcoYuOyiqihvdgpVZEXCQRfjJwxxiRR/CfyIvbYL3RJkxWjgK9594OqbNvYZy8iz+CZii1c0+GF9NDbTfI++nVJqEdtm/wTvo0rSZGOto4Np97sYvfvApwn/vDp8dyckGEB6LC31weF/6nIRBKN7nPZfOl+HsqseSo93WzeXN1Coa5tN1316EApUFtOsCXgoPF8TVwZx0XZ+JJzu8TAyIe4EUZ4oJFLNFW/Fjt/1oKJSsOofBhYd2w3SNkCYAhCBlvx+qKcqOAIMGNJ//aI7eWSkNpWbtL0UCe/XydTy9FVD2/Ra60067wVm5p47DgDz2NMQdb24q50Bl2iJa3/cmmXNPNMiGl3U+36ZfThyAXPBSjGUYXLOAgQvtQIeEmxDTPoeCK+AuB8vAPSEphOP3b4HISQXCbmnyH+93lH8dkj1NAtAMFId0D1n3CuvJvWPluT9zl6D0DfDErg4I4ayoSWMcDrYAT9g2/CLYckGA5Ki0cbp4hVWONln/hBwop2KOpB4KKCrLc5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38070700005)(2906002)(508600001)(6916009)(44832011)(6506007)(86362001)(54906003)(5660300002)(71200400001)(6486002)(8936002)(83380400001)(186003)(316002)(91956017)(76116006)(8676002)(1076003)(122000001)(66446008)(66476007)(66556008)(64756008)(33716001)(6512007)(9686003)(66946007)(38100700002)(4326008)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BsnHuCxwi796NohN9kF4VmW9BshHLOjoL77iYuO5sLmrgrXDJvp3tluLrzHv?=
 =?us-ascii?Q?030QA1vhnB+d3HZTDDwYQC8KvHHLOaiatgWasQCIaonjL8eyzMYNZ/ST+Nz6?=
 =?us-ascii?Q?1nzhRPxB4Jp+ZgyKb3gxT6t3MQ9NQx5CDaC0HsQvdp6pLC59LyBgxsjaR0vX?=
 =?us-ascii?Q?Yh37tQ3re3yzOhgS3RwbVxdHibwjwxLkmBABp1U7lux9MmZRL4UBIYplVJ8K?=
 =?us-ascii?Q?iWfj5kV2mS4FFSeLMkPTarjGd7zCQV6UeHtC8OaApGp1yT+Bt1BF2ksMexBI?=
 =?us-ascii?Q?4/0rhF07xHFMUn942QtyNzCVf0FhOsos2gvWkL524atQjnpDeAzK6mCTMwtw?=
 =?us-ascii?Q?yay6+1IsXCp+JLE/i3Fzk/r2wRIR+T26x7bZ9+eEjZlXZTw+Up/W37To0nlb?=
 =?us-ascii?Q?GFOUJczjjV3JrF9w5PxfnXc7Ut/Da8wD4wE9AEUec5H222Jx+cv79Hm2IlFc?=
 =?us-ascii?Q?b1SIGs5em3022bcFd5qtHU8s04rSbSquRpeE1ek4wS86hqnEsbEBd7wrxhZW?=
 =?us-ascii?Q?YvSBZPyKJXXHaKAptwxPbltmta1jWpZ6+qO5M3h5603MU7/o2aNSwpLQwcvs?=
 =?us-ascii?Q?cq529z1nrodUW+eHsZwZLn3SEFHfWn66cA42hrG9tJz0M2uueUmIL7pd7ob4?=
 =?us-ascii?Q?hQnvjulVHQ7qAmknvU/W9eBn8rH29J/wZsb/SHwXBQUtQ0ayCUkpXr17C0V5?=
 =?us-ascii?Q?AWWTvXES+MgnURppNgFtW5VDUnCFMTS3rH1OkWw2xfAMYOh83kknL3qphwkw?=
 =?us-ascii?Q?QW/rx78hgOjHd9CH0bwYvlAvCByFF2M/NWuBp0ErPAkWOUXQHzHiADGleAsB?=
 =?us-ascii?Q?N4SBDGGq5BNS67TdGs44EbyHcDUHvR00Pv6U7edjsDojLR7wF4adoTXviUiO?=
 =?us-ascii?Q?tKb02PoqMBufSUjaPGkNKMdDKp+LfiNnn3A4jXuEbPVlis2pttx6KB94pgDq?=
 =?us-ascii?Q?4/ym3dZqF+qTHdBii+sBxRLoOzJruCnBONrRJ3Y2EZEb/ENRO0jp/Klpe2Ww?=
 =?us-ascii?Q?UXV2E8/bAZWzT/yaEmaUkTAraGEziZWdetvhr3rJ1406g3qtNo4s0Oc5ikbX?=
 =?us-ascii?Q?Ke0PSk+kDoPBIESrYn/Mpi+H1DBVULaMmspjzkQU+uWFr/phMUOuecIbEgdK?=
 =?us-ascii?Q?UO99CFj5TabtTjYt2YLvCBgUK6Y+OGHRj9nmpW508DnUQG2gJh5YOf+u2Bfj?=
 =?us-ascii?Q?QwBDg96p1qHCSWxmsqY4Gv+absca0Ef8bNtbpUP9Cr/jMJXWEzTq6SQWe+Sd?=
 =?us-ascii?Q?H/qJ6iwrkQXHP+ll5LxVGDqcxAu6c4gx0BP4QWjPxkLwmjRMb3j1U03eGUM5?=
 =?us-ascii?Q?aVLJAI71xUBIr4UIOMy6M2AivzM1fvJF3ku6sgM/9OGbtvnCcmxEOqbNQedE?=
 =?us-ascii?Q?MgX/tjxXwInSXii4n+khCHParMMve5o0G1Q6astRoFMAw4WuWX6Zz4i+OJeE?=
 =?us-ascii?Q?xihAyqQAIuuYxzay9OKyHJ2lr6wFbKjUxUR6Y1Zt0umE52CewD10W/ZLmDqC?=
 =?us-ascii?Q?vQ7FrzOrRoKUP7zHY6IfTS6WpOLSeeaTI0ERjMb8QBjfvDq5QbxBRBLZAm+S?=
 =?us-ascii?Q?oimZBPPEF3un6fo5fiBwwvhckr4ZCap5qi8wlidEVoJVyMdF8ExWcDcO3Mrt?=
 =?us-ascii?Q?IbCaNw3LGTZwf8KCj7aqh4A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <906BC76BF497B6488795BE9F690655CF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43aa14aa-9208-4e48-3697-08d9e73a335e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 17:25:40.5098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lZESoGQGr1P1mmd2LCtBvbmA0pL6MVJQekNdHZ6KcSznzhTiClefVgUnNMtYJLHW/YGU3UXWC5ATqB7tPQzXRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1394
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10247 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202030105
X-Proofpoint-GUID: d3NLBc1Rp3XsxFbDsmswcRPjVc8Cdtrg
X-Proofpoint-ORIG-GUID: d3NLBc1Rp3XsxFbDsmswcRPjVc8Cdtrg
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mark Hemment <markhemm@googlemail.com> [220203 07:08]:
> On Wed, 2 Feb 2022 at 02:43, Liam Howlett <liam.howlett@oracle.com> wrote=
:
> >
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >
> > Replace any vm_next use with vma_find().
> >
> > Update free_pgtables(), unmap_vmas(), and zap_page_range() to use the
> > maple tree.
> >
> > Use the new free_pgtables() and unmap_vmas() in do_mas_align_munmap().
> > At the same time, alter the loop to be more compact.
> >
> > Now that free_pgtables() and unmap_vmas() take a maple tree as an
> > argument, rearrange do_mas_align_munmap() to use the new tree to hold
> > the vmas to remove.
> >
> > Remove __vma_link_list() and __vma_unlink_list() as they are exclusivel=
y
> > used to update the linked list
> >
> > Drop linked list update from __insert_vm_struct().
> >
> > Rework validation of tree as it was depending on the linked list.
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  include/linux/mm.h       |   5 +-
> >  include/linux/mm_types.h |   4 -
> >  kernel/fork.c            |  13 +-
> >  mm/debug.c               |  14 +-
> >  mm/gup.c                 |   2 +-
> >  mm/internal.h            |  10 +-
> >  mm/memory.c              |  33 ++-
> >  mm/mmap.c                | 518 +++++++++++++++++----------------------
> >  mm/nommu.c               |   2 -
> >  mm/util.c                |  40 ---
> >  10 files changed, 264 insertions(+), 377 deletions(-)
> ...
> > -static inline int
> > -unlock_range(struct vm_area_struct *start, struct vm_area_struct **tai=
l,
> > -            unsigned long limit)
> > -{
> > -       struct mm_struct *mm =3D start->vm_mm;
> > -       struct vm_area_struct *tmp =3D start;
> > -       int count =3D 0;
> > -
> > -       while (tmp && tmp->vm_start < limit) {
> > -               *tail =3D tmp;
> > -               count++;
> > -               if (tmp->vm_flags & VM_LOCKED) {
> > -                       mm->locked_vm -=3D vma_pages(tmp);
> > -                       munlock_vma_pages_all(tmp);
> > -               }
> > -
> > -               tmp =3D tmp->vm_next;
> > -       }
> > -
> > -       return count;
> > -}
>=20
> Trivial: Comment in exit_mmap(), for oom-victim case, has a reference
> to this removed function (unlock_range()).
>=20

Thanks, I will update the comment too.=
