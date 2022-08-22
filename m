Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B5E59C4F2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 19:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237237AbiHVRYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 13:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbiHVRY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:24:28 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F97BF68
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:24:26 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MDA5Mh019745
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:24:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-id : mime-version
 : content-type : content-transfer-encoding; s=facebook;
 bh=e4B2/kb039nR3VI7mECyd5wYO5OK60LgZ7BkDZOZAIA=;
 b=UyOfYfw05BBvZQbP2T/aIy1Elll+e04jQZ1Xf8Vzwa3va9PlZSmyhMYu/IR27lozyXJN
 zkcyzL0/rJYEMLsvJSEifxN0QUl5rV24jJxcro6jeTNvjjTeJ/k2ipIRLKJSG60rwHsz
 EoLMTHHDa0pxnAL80YbGelhQ0HuZscKyHi4= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j4aedhy02-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:24:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoXhoQ4Ue7HjxPlvMQrESJwVXiZEznwYdOVI4SDfe3/Pi5Mf3UfHOr1HjS0xO2sYoh63dXlgKo0+jjDz5uBCv3z7jAdrRdCqR4lCeNOvDThovaijs+QzgwQj6MC37oTxS55KceMdhDiL3j8BvdULwTgji9jfD6/SCVhQOHgN7T5WtteiP+cr2bzjdGRzBD3y834DmAqAut2gy8f6lPiAMviMNT9heregAOo42ipDT3tvjnRqjvUDyK3KLIXyEA6T0TdmcDkgflg4HkExHHjoKAneVHseOfFLuBrZe/hFBvom08s1M8A7TUXK7mlcoOQAO7YM3dvBw7z6BFtbHEW16g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTAJFF3MrVISIXl0rBYLWaUZsCCVSTwu+X8UhgzT6CE=;
 b=KK3mnGwFJ9C3iIOSLy6Z86KJAGVxxqFHqc3ytlXdEao0cc+YiFhAO31IGzwXZkPXB9iC/1VKi3o6Kd1uaFK3DZCPWg5oTDGEpOwTN4yIJrqHN26SUEBtdNfhnB/fAe83kN2LHFVd5RR7HX+2hRP2QKT4IUnwK1nJmzCOOTaR4xiTWF28pwJ1dwy22TMkLpHSI0nq9CstO45NlYXSw9hQ3NyPqeqVN6xX/WJHiLgCWf3ZNYz1E14MlS0f0dLa6W0LSaac01fLwj5tNlldDpNaqq7tpL6+NFTV3ycgdHVfnUsQZ5b/vu/MWrN+R5QWImvNJuKPH+sNu74K8hgVdo6NCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from CY4PR15MB1781.namprd15.prod.outlook.com (2603:10b6:910:1f::13)
 by DM6PR15MB3116.namprd15.prod.outlook.com (2603:10b6:5:143::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 17:24:23 +0000
Received: from CY4PR15MB1781.namprd15.prod.outlook.com
 ([fe80::351d:e6bc:a9e4:4118]) by CY4PR15MB1781.namprd15.prod.outlook.com
 ([fe80::351d:e6bc:a9e4:4118%12]) with mapi id 15.20.5525.019; Mon, 22 Aug
 2022 17:24:22 +0000
From:   "Alex Zhu (Kernel)" <alexlzhu@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] mm: add thp_utilization metrics to debugfs
Thread-Topic: [PATCH v3] mm: add thp_utilization metrics to debugfs
Thread-Index: AQHYspWmjjoEfkQDpEicyOTjiMWdEq24XToAgALVoQA=
Date:   Mon, 22 Aug 2022 17:24:22 +0000
Message-ID: <3F4CC516-21B5-4E9F-8427-E54B4D0F2E41@fb.com>
References: <20220818000112.2722201-1-alexlzhu@fb.com>
 <20220820150712.53ec2dd281dfe894ad3fe2df@linux-foundation.org>
In-Reply-To: <20220820150712.53ec2dd281dfe894ad3fe2df@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ce20b76-47ed-402a-22e0-08da846327b1
x-ms-traffictypediagnostic: DM6PR15MB3116:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q74pFUeYJulpzxO8UdsDgHfbhUTXiCmQpGmITIQRZOow7ombQwJQoeZ/NbdXH8eZ3pZKgz1EhHVWCTuMH5qMpnv3F2pFWrs3Mys8xSao+av2pRBjKaA40ry+m9Ny8njTL4sEcspKWoc6MZ8aCC4D0dzz7IbGdeQiA0QTbUIBkEFWtPrZ+Br1zQivdy9NfpmKBcySUa63tT/vC8O2VFAuuphUL5lAAHw9/31/a6ekMwuIMg9pGMeYO1MO6qTWtHtZMnqmwmwPDAVfh2/uSo8sf0IhqFzw9o8o8yZ+F9H0NGcAC2UMXMmfOgkHuy2Hb+oxbo8ihYiKC/RDJPhAy+tPXixDSmXWGOXwFr2GdkcGVMfGmsoUdOdfgK/PvVUqnGBgNvMN8eiHE1/PTyaetIPHPnPxUF+Hx7v502KwNwB9QskliY/P4NMpMWCafWHTqD3h9Mo83UhX3fKR9H7nAUhouTrKOreXJF3M0PgF+OfEJJNX+gfmHFYPproArk0Uml+/vhmkGUM4P2HYA2IBjjPpIaCQNX8uvkLocSKa0o0/6zD/8N420+co/IvkScM1C6a1u7DauOt3PmPvaaCoWnJsIyO8npjNrOaDEqVL3loTujjbYJ1qYePkk2M/Ebg6dUCxxAPsUVf5ncNR1YhqJppIPw5Bxwz58F7/jTBEKEHpdqdJmatAsWdCnXKIcJc6ogQqVzY70xOlyqEsgWrlzdkSu0LWAgADLjrzfa1xzTWvvKXPRQpmW65DRt/eOPQ72hd6bvUqm/DHQxyHrHmI2Vk/NqpxCcosz7W3ruYB5cN34s0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR15MB1781.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(83380400001)(36756003)(38070700005)(38100700002)(122000001)(64756008)(33656002)(4326008)(66446008)(8676002)(66476007)(66556008)(66946007)(76116006)(91956017)(71200400001)(5660300002)(8936002)(6506007)(6512007)(478600001)(6486002)(316002)(6916009)(41300700001)(54906003)(86362001)(186003)(2906002)(2616005)(53546011)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aQuhqoFprVyZ/8TtWQ9TAc4i7JmynE7maZGIOoBUHw9vItpqWlNHQQkVRQHI?=
 =?us-ascii?Q?M8KPFKdK7L4RkW7ckrwlQ3Z6IAtlAF0s6oZ3Jkh0krDCalvT71lCvO2c3MZ0?=
 =?us-ascii?Q?/A2Qwq30wMJoOKRyH5yQKDj1MFQvsnlpohCD7slO1maqvGW8TOSnhqXSOO91?=
 =?us-ascii?Q?BWNJlu3WpVuzo782CPB+gs08w89HZz3+fJmsZy+q6ev+nse6S6Pn4GuZZrJt?=
 =?us-ascii?Q?mwvPPoxc8uAXe9urCKSeBFtTB0ZAToyETggL5iE++7fxxZE5wC1Xd8CXOPpU?=
 =?us-ascii?Q?laMVaHfRKlA0Ha3bNvvGl1OHMYuVlRiN0WdQivbJ/1nPPXDkSw0vxkJ0N4C/?=
 =?us-ascii?Q?ZbUCrnO7NFGBtx5VjIt7ExrLU+FhRSXJNAh8PR+b8xKWP8fwz5tNB6wVdEQq?=
 =?us-ascii?Q?8/noVYv1PhkROacwztgv1Y/PIkgUS+3jLWtxriaCd9m2vnvdr/1oS5kwGP9w?=
 =?us-ascii?Q?lOUOozOUdUK3l3bsTFesmhAtDQwZhAZBCcxrSP/2CGBTfeLkZ4aBAsnv69NR?=
 =?us-ascii?Q?CeC+17P+kE9ygT3LdHh6as8ZXSATn11qChYMKR/qXQmZni2RQblvFCKLUP52?=
 =?us-ascii?Q?5RseV6hrIfsFiVJYhae2gusgz+9t0U5HRF30VBfJptYfnf9G+ovWwjslR9nd?=
 =?us-ascii?Q?AYTQADOlVeUiL0AyM1lmHark/61gP1qWthkAAU5t+HM7i6M3r1GN6iVcn1rp?=
 =?us-ascii?Q?GaemGX5vo2L8EIukKEyIe+2nIU8qht7JYtZzNGlrixH2qVOD4MOSP/CJtWmV?=
 =?us-ascii?Q?bInURdLBbw0MYu5iyTrUz8IWe9qHpdwnKhHzA7EpjC+nFo8sRpfjvmCOsxoh?=
 =?us-ascii?Q?Q033dqoJeU7rG16o5HEv8vmtT81uMeFfa4nfFH+MsETeflroZntL5sWa0gfq?=
 =?us-ascii?Q?Q4bc2VB/dIzteeMw2WzdyrYoiDqsKCWbOnsW+s42dmgcMB3wfGtXbM5xLWns?=
 =?us-ascii?Q?tAQT3RhuY5wI+KUiNK2y0dLuov7qgiRhcj/ZADqsWA2v/+Rxuzc0blfHzJnm?=
 =?us-ascii?Q?sGiCTutNVtpmDbfVGVWaQPtg+hb0A1A84xHR8ADR4ok0DBDKtQwC0xKuzHsm?=
 =?us-ascii?Q?Q2jGPdZzDJUcX7xEikzxX0G9t6KDw1rM4k3Zlu+swJlAz3rvtrMGEeMujfVg?=
 =?us-ascii?Q?d9HaWtA3qDSYbl1lb7XEhz4EVg+7gWJ6HpMTJcIMnFltpXemo2WWG/yCaP8c?=
 =?us-ascii?Q?6S3kgsLCKpHg6d4k1MR15T4pbuoyoP2cMvJvbRqhE6Ceec3dCCw4ogOttfYE?=
 =?us-ascii?Q?lLRybdUCeuyPxSqNSxCnI3O8XSEW5m5v8Q700nqzohoH/y1Isv5Mi1YE+Nwy?=
 =?us-ascii?Q?xAuhM6VcQQhpptgNOuuSnPjwlLNoajotqx8KJG2ykkXbl35FHp07tVOrAPsq?=
 =?us-ascii?Q?XZVU7zNoALQhvTRHUP1NJ3mxCDa/PVVLF4Z2DEP/il/eC3N8mauxDnxte6EL?=
 =?us-ascii?Q?ACH+I3O+ibyQnCuG2ZW+AimWPM9Eb3Gfv/72l3eWzQod45nkS0dBikt+9et/?=
 =?us-ascii?Q?lyaneZnKtrNULn79NPK55ceMSPN+mbG/mqJkCiiQvvFiVT0xnvyNUY2G2Lsr?=
 =?us-ascii?Q?bgD92vosmHax7U245uzO8XCmTIm30eda9emGSjjlJh2pxOrhi7dXV1rJ3U8d?=
 =?us-ascii?Q?ihQegntWF/E7EfrlDW02Rts=3D?=
Content-ID: <20A6CBFA7011D04B88EDF666D135213B@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR15MB1781.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce20b76-47ed-402a-22e0-08da846327b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 17:24:22.8582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z/NglPiuU/9TTcRdouasZzE6728qB53vKpv86JqxbkTXsI7Eacymft4gXA+jZTJa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3116
X-Proofpoint-GUID: QN-cgt0C_WPc3-IH1P_BP73T5jBpIZ2i
X-Proofpoint-ORIG-GUID: QN-cgt0C_WPc3-IH1P_BP73T5jBpIZ2i
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_10,2022-08-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 20, 2022, at 3:07 PM, Andrew Morton <akpm@linux-foundation.org> wr=
ote:
>=20
> >=20
> On Wed, 17 Aug 2022 17:01:12 -0700 <alexlzhu@fb.com> wrote:
>=20
>> THPs have historically been enabled on a per application basis due to
>> performance increase or decrease depending on how the particular
>> application uses physical memory. When THPs are heavily utilized,
>> application performance improves due to fewer TLB cache misses.
>> It has long been suspected that performance regressions when THP
>> is enabled happens due to heavily underutilized anonymous THPs.
>>=20
>> Previously there was no way to track how much of a THP is
>> actually being used. With this change, we seek to gain visibility
>> into the utilization of THPs in order to make more intelligent
>> decisions regarding paging.
>>=20
>> This change introduces a tool that scans through all of physical
>> memory for anonymous THPs and groups them into buckets based
>> on utilization. It also includes an interface under
>> /sys/kernel/debug/thp_utilization.
>>=20
>> Utilization of a THP is defined as the percentage of nonzero
>> pages in the THP. The worker thread will scan through all
>> of physical memory and obtain utilization of all anonymous
>> THPs. It will gather this information by periodically scanning
>> through all of physical memory for anonymous THPs, group them
>> into buckets based on utilization, and report utilization
>=20
> I'd like to see sample debugfs output right here in the changelog, for
> reviewers to review.  In some detail.

I should have included that in the description, sorry about that. A sample =
output:=20

Utilized[0-50]: 1331 680884
Utilized[51-101]: 9 3983
Utilized[102-152]: 3 1187
Utilized[153-203]: 0 0
Utilized[204-255]: 2 539
Utilized[256-306]: 5 1135
Utilized[307-357]: 1 192
Utilized[358-408]: 0 0
Utilized[409-459]: 1 57
Utilized[460-512]: 400 13
Last Scan Time: 223.98
Last Scan Duration: 70.65

This indicates that there are 1331 THPs that have between 0 and 50
utilized (non zero) pages. In total there are 680884 zero pages in
this utilization bucket. THPs in the [0-50] bucket compose 76% of total
THPs, and are responsible for 99% of total zero pages across all
THPs. In other words, the least utilized THPs are responsible for almost
all of the memory waste when THP is always enabled. Similar results
have been observed across production workloads.=20

The last two lines indicate the timestamp and duration of the most recent
scan through all of physical memory. Here we see that the last scan took
70.65 seconds.=20
>=20
> And I'd like to see the code commented!  Especially
> thp_utilization_workfn(), thp_util_scan() and thp_scan_next_zone().=20
> What are their roles and responsibilities?  How long do they take, by
> what means do they scan?
>=20
> I mean, scanning all of physical memory is a huge task.  How do we
> avoid chewing vast amounts of CPU?  What is the chosen approach and
> what are the tradeoffs?  Why is is done within a kernel thread at all,
> rather than putting the load into the context of the reader of the
> stats (which is more appropriate).  etcetera.  There are many traps,
> tradeoffs and hidden design decisions here.  Please unhide them.
>=20
> This comment, which is rather a core part of these tradeoffs:
>=20

> +/*
> + * The number of addresses to scan through on each periodic
> + * run of the scanner that generates /sys/kernel/debug/thp_utilization.
> + */
> +#define THP_UTIL_SCAN_SIZE 256
>=20
> isn't very helpful.  "number of addresses"?  Does it mean we scan 256
> bytes at a time?  256 pages?  256 hugepages?  Something else?

256 hugepages. We scan through physical memory 2MB at a time with the
alignment at 2MB. For the moment, we have observed that scanning 256 PFNs p=
er second
with a kernel thread does not produce any noticeable side effects on x86_64.
>=20
> How can any constant make sense when different architectures have
> different [huge]page sizes?  Should it be scaled by pagesize?  And if
> we're going to do that, we should scale it by CPU speed at the same time.
>=20
This sounds very interesting. I would be happy to hear any suggestions for =
how=20
we can scale this value more systematically. The way we decided on this val=
ue
initially was as a value that should be small enough that there are no noti=
ceable
Side effects, and then we could tune it later.=20

> Or bypass all of that and simply scan for a certain amount of *time*,
> rather than scan a certain amount of memory.  After all, chunking up
> the scan time is what we're trying to achieve by chunking up the scan
> amount.  Why not chunk up the scan time directly?
>=20
> See where I'm going?  I see many hidden assumptions, design decisions
> and tradeoffs here.  Can we please attempt to spell them out and review
> them.

I will send out an RFC patchset including this one, split_huge_page, and th=
e shrinker
later this week. Will add more description and include any suggestions in t=
hat. Thanks!
>=20
> Anyway.  There were many review comments on previous versions.  It
> would have been better had those reviewers been cc'ed on this version.=20
> I'll go into hiding and see what people think.

