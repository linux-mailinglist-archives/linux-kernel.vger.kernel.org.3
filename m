Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C294C702C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237422AbiB1O6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237452AbiB1O5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:57:52 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E4580201
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:57:13 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21SDBJsn021511;
        Mon, 28 Feb 2022 14:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=eo6jr5nsbpJZPxa1yulXkP6KDaGoIcaQqgrAAGg9fTE=;
 b=wzV7pbYmZtQjoIeXjaA9T/DuQ5YVQmNkohJcxi+GkQ4cvIuy/YwfXlvYL/IN06bgfd+H
 eOKKpWCoEWSbgH1pQEUxhLQQ4w7Q1uBdOqNfhC8RfqkOYAwlY9ObNi8LR8Vq25c8Ig8B
 zZuuD11qMo+DAbpN8sP3b3tSlqJpsWMKRPPHgwF2s7eQmmUPZjfxjbjiY6taidUokT5G
 rSXcexi1p+je//VFlA9J7WbO3XrAyDgmKJ9VPVaAavWoYPVFA7POs2RAOXIRVr3/r0Et
 cGht7jnslqDqAhxmAtjc1rHtT/sy06gmwLPWwg8boywej+8jW74dAo4xSUOpNuaGfScI gw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efat1vf9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 14:56:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21SEpCag022053;
        Mon, 28 Feb 2022 14:56:44 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by aserp3030.oracle.com with ESMTP id 3efa8cm3j2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 14:56:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpyeT7GKNJbQ1l/qt6SLVKCb5sN/ggIkx8GXTxud8cucyELAAT0SA1/rysMdEVgMizkUeIhmQY81kW0qpcJdiijxFwlZD83D9Okhqlf7TgHxKrHqwftHI+yport+NzhMBBVHAJ3sCqRwjjtoYp8fQuY1FUzM+fbXLm7NQ5it+rTYTAAGTDaW/WRrAdxteup+rCwsvh3gBlXgYXMjmapbi3gcQSy+N2esDAB6jE6XUQmT03dWbUuh/jowUHLdqi/2nxC3n1+mJZ5QB3ilBKhEXOeJxL0eloakez0tWcnyciIIySlH3yKmTUhu/41Ir8/AeWmkQhhpQZf6fpd7IssDAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eo6jr5nsbpJZPxa1yulXkP6KDaGoIcaQqgrAAGg9fTE=;
 b=BgF9I4qA6vUChDj/neqKTuvdXvGhfX77C3kJelyPbA5iUyEXH/dOmxGMyC3ycyYTDY9jPvL78lArW4zDFwN/pdDOhIMLuNBS85famdwkInKoE8IaCRA/vsQNrc09FI1gEPWE3ZpqIXPNCQJ718y7r8siH1xf1ols4pFwAIv/5gXEyIwC/ax/KTez/SsZnp7jjtgsFGcuy21QNezWPpimYUFq7EkBkKQ32KTfIwjV9MEhhLTyuq8ZOuN63w52HqG6hOUZcvdYjV8FlnZkHv6b0oaj5oowsZss6ZLqel2YoHINNmpAL8+T+D7c6YS9JlvTl125RbRMlNVhFdveTobgCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eo6jr5nsbpJZPxa1yulXkP6KDaGoIcaQqgrAAGg9fTE=;
 b=w+TalKaabbZWOR/LVZ6yXQcTxHDCFqa5yhNwa1F6eTISTpSlyQZmjvjqGdSM+fqXOqnmbUFYe7etmapoWbXVTfYIm0KCpwXykUxNMLbm3mEp3lzdkIrNZIVomHIh8e5UdtYEeMtX3ouVjVRkZWD0xDnPzb1GvGOjnfFHrgZve2s=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB4039.namprd10.prod.outlook.com (2603:10b6:610:10::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Mon, 28 Feb
 2022 14:56:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a%3]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 14:56:42 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Vasily Gorbik <gor@linux.ibm.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v6 00/71] Introducing the Maple Tree
Thread-Topic: [PATCH v6 00/71] Introducing the Maple Tree
Thread-Index: AQHYInmXxzMTjmF25U+e/3QAVwcn6KymvOqAgAJk5YA=
Date:   Mon, 28 Feb 2022 14:56:42 +0000
Message-ID: <20220228145635.pebzz7nvk5q4uhqz@revolver>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <your-ad-here.call-01645928577-ext-7266@work.hours>
In-Reply-To: <your-ad-here.call-01645928577-ext-7266@work.hours>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b3db296-2aa0-4936-0692-08d9faca8846
x-ms-traffictypediagnostic: CH2PR10MB4039:EE_
x-microsoft-antispam-prvs: <CH2PR10MB4039D621E1F4C15E66D0927CFD019@CH2PR10MB4039.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iBPVpk37bLn4edkzGPdT22nNC06D+gxIv+CjvO9UTs5iYqQVP2JjYKoAjRTy5uCD6JxcqdZRVoOu6l+kePFT8klkNOxMNqG25fdGWcE63rTXJaZPYFEKirE698TOcxwFFAW1SJ7OHYVU9nWztz2Y4sSqFDXNC/tqJ/0vT5cgz+4O8yXysa1k2dnLDlZHaidlADsQGH30w6mOF5mKsikP0mn29cr4WW8kNDt8JRqOYiQjP91QU+q+rCn7/S3FFKPFsJiTJsdrCEMRAm09s1iUrK3s8w7iO1xdERjH4BznSG+xsEA+tvMewpBaCpzmv0GcZLZA+bAJKvQWZuw6I5vq8A1a28KpODQ3oQo46icoDx1gjKy6SBig+gPUuS0GmBlJ6YyJkgJbwmNf90oonRcmQdCZDzskCL765YhZ8kIh/d0Ly6m3RC6WJRjyu+Um/kDl6tstoAPW8WOs4/ck3iD+vviITWEuLQhRBl0R3Dbdfcch/nQ10KHmpY48BChcGlG8WMvibT1HCiia+eDZZ2HN6Efoemr0xk8x1sI8wXvN/iTmnzPq8qk7aUM+du9pp47r59IOxXrQN9Stna2IqTdsdPK8fBooUk097ajwr+3vqqoImGvXH9fmmmiI1LzMRBW2hCLaeJspRlY4fh+vdD/btxutd23eJwRXKnK9GI6QHLJ1CWwcOAKm/Nrv7ZD9T9cJVuPtUexzDT8cgjWB9a+cSYaZFoCyBj6Mgp0fYx3EgZL3TRBmqcNqzjtgyMyFJqRGNgib2YC32cgiuETmgu9dIq08ITnjXR3aEMVg7+J2ml2CkDRf/nF5bIn1SeN49D6fxnvDh4IkrH4wcdvy22QLng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66476007)(66556008)(64756008)(6486002)(76116006)(91956017)(66946007)(966005)(71200400001)(508600001)(66446008)(9686003)(6506007)(6512007)(38070700005)(186003)(1076003)(26005)(6916009)(316002)(86362001)(54906003)(2906002)(122000001)(38100700002)(33716001)(5660300002)(44832011)(8936002)(8676002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oneILz6HjyWgGT1N9z/5ppOtsnMRBI/4hNsZ2qN73NUc0msBP7uqH62fPi92?=
 =?us-ascii?Q?Xb2fnqZtvvtAWZkHl1ldNTFTPTIdeK115lCl0viLdIhDpGMkcsgYItoergmo?=
 =?us-ascii?Q?L5sQaZpVrdH6hU/7FNVzRXZx+8fk3xarPn09nDG+IMq6ElgJ0KDuJO03oA0z?=
 =?us-ascii?Q?CRLYk05lrWfjB3zKKCOpPLiTz5/vTZRtuA87dckmW2mYV6/FIebe4c6kk8oQ?=
 =?us-ascii?Q?Bk9sXLiWtYgPWEoWD7X7N//MTdHE0ioq5Wh6Dqitou6RyeMybpYIMLSDwgue?=
 =?us-ascii?Q?F6e4HWtGAa9NxPaZ8x0g6m0eb09WFxKFEs/vEZob9ltNkaZ0WYqfmFopY5u3?=
 =?us-ascii?Q?jQ0cr8iWZQLja+NEyhoQ/BEfqD/d+wfhPw1b9BnnGpWaTSRjDXE11STFfeyw?=
 =?us-ascii?Q?mnXDp0xYaVPUI6ryAe22k7mpvv/X/SJ+PJZjvof2xO/35Sw9K8gVAmbKlbRe?=
 =?us-ascii?Q?gMwBWjLe7+d3SVraDUW0nVRg4uJGY8wUiimnX+WnbjoAA+MqZfMEpFyWbBBo?=
 =?us-ascii?Q?WhVTKf8YUnMIi25Tyg0Dq6CevsGzf2XR2+5PGjLXP8dEwtujqTaaYf4e+85T?=
 =?us-ascii?Q?+3n/e0UJ+CdRkdDBi/nhTep5IL62lMnrJojVhUO0lKSZXV/h6UILfa0IZYeQ?=
 =?us-ascii?Q?zO7BhdafFKzdBjTsxEGCFJ5GW+bh+8oKpF5g7hkg912zNfFascLQgxLWlK3g?=
 =?us-ascii?Q?Ey4zylc31b35RQTIPQkcNWxD8+AYjDV8VR4x16b565xMysZT7RX60m/wptTO?=
 =?us-ascii?Q?hQQ2OzwPOJ5VVZ3jULhxHpKpTkdDAcaqTapqA89AU3Ahh0IxoVoAUXl9c4Is?=
 =?us-ascii?Q?QIQcYyVQOkHmdOfw/56QfxjDvezPg5d7wUj6IkgsB2oPGnWMap/Oh+MZULeU?=
 =?us-ascii?Q?36BaM808l6B8SPCLnJgmDXovEg6P81pXy8lTDwvLbjrmGXQhQh4JXVPMhwVH?=
 =?us-ascii?Q?WMkRzKbQeYk5ta3vlgB5sSBilgKoy0I50xWPeIXDo9mTVwtmTAhU6Ign8QqH?=
 =?us-ascii?Q?0VZj5VTFxQujmYNBLNUxyG6lxwmMsidmANu1Mls6CrVNmkxFhA8rrLdwika/?=
 =?us-ascii?Q?99AjAfTW2k+ooWCmYCgrOvCGb81swWgLoVAcMpQI8c7I72zN7Sg5lfRC6tRR?=
 =?us-ascii?Q?R+unuq0lirlnL8ICELHaEa0Y+z3OvNkgBsLRv1F/oXa17ee1vbgJoX/qM+Dk?=
 =?us-ascii?Q?mR7BRUn4xb9ATh+t+BV5eBCYnPEyHHan+tqrZVDoi+kVJgJNxx9qyd1k6OZ5?=
 =?us-ascii?Q?DB6s5+hYTjgv26MRo92/D0Qo7ovoz6sx6O2F5/4BxwAL0Jwak/haVWoYZm6x?=
 =?us-ascii?Q?01Tt/Hx5UqHIx6wfjpNWAwmJkFvga0r5Fb8HH3xEh/BANSxBt4SfVBzvn22M?=
 =?us-ascii?Q?f13J0pMer2m51Jkq/vZxofwzqDpuTZqTqswHk0iU2CRWGJJ1VYS+hlKJFGUc?=
 =?us-ascii?Q?uir6yrxX+i5HN4GD0fU67QtlCjflkz4P7B3ebc2mG2CEoY6ue3QabkVRDYR8?=
 =?us-ascii?Q?BXGBdm3RaxRwhSggdQNk+zPm7UzWeXJ4PDsu2PoKKLhl/WGPERK+wyehtnEf?=
 =?us-ascii?Q?tervYQp0oocwZS1nreak8d7lt7zQ62ZxK0S5a/qZq8/5tD2RGjZB6DO8TYxA?=
 =?us-ascii?Q?de+0MwCLA0lAKysa6y6Sf+Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BB878DD46DB12E4EAB45292083DC4E90@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3db296-2aa0-4936-0692-08d9faca8846
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 14:56:42.5639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NXSJSw/asmLgcKaAo1YYS7souAbH/Obo5V4UG6AABCQgvs5yV2oRZuPmqOheAhZtU1zZHm/bh9GgeEMwkr7xyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4039
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10271 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202280079
X-Proofpoint-GUID: 3xnSkEFmZCZibb8D-XRbAOQDkS8y6x2Q
X-Proofpoint-ORIG-GUID: 3xnSkEFmZCZibb8D-XRbAOQDkS8y6x2Q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vasily Gorbik <gor@linux.ibm.com> [220226 21:23]:
> On Tue, Feb 15, 2022 at 02:37:44PM +0000, Liam Howlett wrote:
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
> >=20
> > The tree has a branching factor of 10 for non-leaf nodes and 16 for lea=
f
> > nodes.  With the increased branching factor, it is significantly shorte=
r than
> > the rbtree so it has fewer cache misses.  The removal of the linked lis=
t
> > between subsequent entries also reduces the cache misses and the need t=
o pull
> > in the previous and next VMA during many tree alterations.
> >=20
> > This patch is based on v5.17-rc4
> >=20
> > git: https://github.com/oracle/linux-uek/tree/howlett/maple/20220214
>=20
> Hi Liam,
>=20
> this patch series completely breaks s390. Besides endianess issue
> in maple trees reported here:
>=20
> https://lore.kernel.org/all/your-ad-here.call-01645924312-ext-0398@work.h=
ours/
>=20
> and with this endianess issue fixed (fixup from here ^^^) we still get nu=
merous
> KASAN reports starting with
>=20
> [PATCH v6 10/71] mm: Start tracking VMAs with maple tree

Thanks for looking at this.  That commit had two issues which I was
debugging on parisc for most of last week.  The first is that I was not
actually writing the stack expansion to the maple tree in that commit -
it was added in a later commit.  The second issue which was most likely
causing your crashes was the calculation for the gap in
unmapped_area_topdown().

With the maple tree (3dea5db7fbb5), I am able to boot parisc and s390
virtual machines.  Although, the issue which Hugh discusses in detail
still exists [1].  The latest maple tree can be found on github [2].  I
am still investigating why the heap changed locations on parisc to
ensure it's not of issue.

1: https://lore.kernel.org/all/5f8f4f-ad63-eb-fd73-d48748af8a76@google.com/
2: https://github.com/oracle/linux-uek/tree/maple/mainline

Regards,
Liam=
