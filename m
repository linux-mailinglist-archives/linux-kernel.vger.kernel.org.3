Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B31535731
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 02:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiE0AnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 20:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiE0AnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 20:43:15 -0400
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBE25F8CF;
        Thu, 26 May 2022 17:43:13 -0700 (PDT)
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24QIsu6j028966;
        Thu, 26 May 2022 17:42:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=0z+9WEwGGZKtjwm/mjKK4RLPCESsdpz1MhVG1yL0NyY=;
 b=OJBC2dL8MVnMljSwKCpHrufgELXsxQ5L9rn0wT76crs8SMp+noBm3lEx/d425TVJs+bn
 TL4D83wr2t9rCy3zWOsdca/PMAcoDOoymuUNLrTQ8tmKcmyA3rLe/ct+e1ZMGowIeWam
 1DS8U5oQW6qMZvPQGDtXoNHdHJrHcef0Rf0nxaHI2jD8Z1pNtb9KGU71nPfU1J3s+VK2
 TBC4KQeAHnzUlaElgBhjRobjrYBT6TlYjz8jMlbauKNf1XsjvvBZc4hUWo6SkQLbOw8Q
 lhC5MrL3nhwRp1vxiyHtoGSGdlf+IsHcB36+yLJf9hTtW6Yrqhz+27UF1tptniduhkRM 4Q== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3g93uanu3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 May 2022 17:42:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U83JNhd2TmQsjXqymPTlQf1Zrbb6a0v+3A3tsc1XinBcc1Ii+0r39FUlc1Zv76Wk34P1Bcl59CK7+6+nbbUuTa9VR1A7M94uH7ajXfEn/+a8Ye4n431dEpZCxD9iGmTbIBLPjvoNMZDS7WLs59475i+E9ZYl+ymRqpsyRxXEsh7tJkfKMiIc80QgbJIx4SNdov+7FYA8wM1RF3YlUsml7yHVY4iQJRT5NGgq0eTckbv/3yQ7nYwc5UKFyOo4nqJw+0PDpQ7NSrys2tSm/rsjf8SVmvlsBCvXfqsOA/Yvx6aZsAhWwBQTEdHgfT1OSfd4AyQKdxfLDFVPirWRUclRwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0z+9WEwGGZKtjwm/mjKK4RLPCESsdpz1MhVG1yL0NyY=;
 b=mDw15zHmRoMxKOLDlmxTabNGnxcP6qsWo21JMmBJ3eONkUgbIxzu+v9a9mUXomrTt/h/fnKnJ9mSLzpVlmFVcEym7lSW6hXYeyNBwUYVkxkwtRnIaUUMSq/3bfGDHJJsS99dJVzLhckYBXZRvqaKgycKk1K7iX+73IiK+wTQkHpvNt61jSuwYCk29Mecjx7n/9oEMJe+StsLWBbzfndw9SJKIv6YYHOl4MnXyhdXdEc4T5337lPFK6bjYj2isdUSusd03+RL2d5UE0GU17LpDQZbw1PyzcX1ebzzQkX+WpRAzMlzO+v0dUPy2EpUtcIAEuffZ14GultrkDZmqJUb6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by MN2PR02MB6720.namprd02.prod.outlook.com (2603:10b6:208:1db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 00:42:56 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::7576:8a10:f7ae:9397]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::7576:8a10:f7ae:9397%6]) with mapi id 15.20.5293.013; Fri, 27 May 2022
 00:42:56 +0000
From:   Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>
Subject: Re: [PATCH v2] cpuidle: haltpoll: Add trace points for
 guest_halt_poll_ns grow/shrink
Thread-Topic: [PATCH v2] cpuidle: haltpoll: Add trace points for
 guest_halt_poll_ns grow/shrink
Thread-Index: AQHYbwBVMVcdSUyOvkKa597s5rjAfq0v3IiAgAIK3gA=
Date:   Fri, 27 May 2022 00:42:56 +0000
Message-ID: <043BFE84-A38F-4301-965E-C3AA762AB464@nutanix.com>
References: <20220523235332.162966-1-eiichi.tsukata@nutanix.com>
 <Yo5n8TsSuU9/IxEh@fuller.cnet>
In-Reply-To: <Yo5n8TsSuU9/IxEh@fuller.cnet>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c252968-ad7d-4858-594d-08da3f79d778
x-ms-traffictypediagnostic: MN2PR02MB6720:EE_
x-microsoft-antispam-prvs: <MN2PR02MB6720094E4C4893F1368C29EB80D89@MN2PR02MB6720.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q/eHmogEeyn+a1EXQ/JchGizYlcG4BZW5sXvNHblaawiesU6WS1c0kiKOkEVi5L0lgSRRRk6kXtacdawCen4fgQbvetNJvZHnM9ZEu9VFm1429fm/BarDWeNOucLhDdn90mubXCyBs+l5Zwx/0b4aAQ4is0X38S5NL77mTqKyy7p/ueY4gElOXXArJq6+w46F4F4yiHId9niRxAj7GIjg8a3A0ulkdVYmFV0NRNWF7mvAiHd8POnB0+aqMLhx2oCQh/2g114OZqNdTBRFSiwj8mxkfEh2JZoIKHPxo1v9TgNAjwsVDB+h/L62TzuHTQrA0ZOSrradm2M/BUU7DjFymyJBp82ry1z0FSMRinMFo6KQG5JhA5ApMg1MIIKRDyRKxDfPI0mU+7klkeXiHL1uaj4sA461WRXvV8963bbFbXXaXlIFUSOrLj7ZxG+z7jvnKmca2n4+M6x1/u9UdBaCwvJEDdqkqYtMpgnQCVLxwet/Y6G7UdTJT5EVFF9m9AHkKCR0JFT6aKHaBPZciwz8+9q57DIyVfLhPOyWivuxQhzn3oA0RkOWSN64EL3B0liDMdIebb+ae7leY1j1t13pH8EFZI7PtCx0oIdS6YobonVScV3pHETPaa30UZpmOe/6C1ER9PNt3rhY/8VggimGIvpB70fsh6RIkivXPNCAvpp9W9xX0ADHkwmleA5b4npP4beC1AwBgmFctUbfZ6T1aPn7RDIda+6qGb26BiUBI0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(54906003)(44832011)(2906002)(83380400001)(86362001)(186003)(6916009)(38070700005)(2616005)(53546011)(26005)(8936002)(4326008)(5660300002)(38100700002)(76116006)(66946007)(66556008)(6512007)(91956017)(64756008)(66446008)(66476007)(8676002)(71200400001)(6506007)(316002)(122000001)(6486002)(33656002)(508600001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aTc6sWE9HSTU9Oc+WD/ZEAhkn0Yh1l6f17dlYb465euejzWy9fM9MjhWjsmP?=
 =?us-ascii?Q?CjRRCqmrY4crLsdri45M6UjxY01rJaLJMDhrf3ZzSW/AftAyuvLN3+tEk9BL?=
 =?us-ascii?Q?Urb8m/KvqjCleppB5y6DCwwhHbxsYL/hK75JrT2/eDpyavohOrxhyB9x/hxV?=
 =?us-ascii?Q?LEsF+sKsiaYHww8jpC1zETyuTnn7tryV2kng/M8SwQPIfrfePYvl3RADpwG8?=
 =?us-ascii?Q?EchDd4FHdnn6ov0TXWMe0ihCEdplc822rjKfZo2LKzuBWp3RhmkB2uAlPloG?=
 =?us-ascii?Q?b0c8BXYWAvLh6FRm14pR6to/LMpaMgdjlLjUMSBD95v7yB5MLaKV+fGcpNnY?=
 =?us-ascii?Q?CqoojeQixraipeps3DpZuk0JsKVwQP0wSjvG0FwOKRFet1PymAyIEpfFhx8b?=
 =?us-ascii?Q?kCg3GOjzXmOg3iocUXdKEC8un/uiRm3dROrxwsLyn34vnwHM7lbzVJ3JgJTZ?=
 =?us-ascii?Q?peNpr1eeaLdhkRjD+sxPW1gTHiy5tytS2M/PSUCZQzRBKdR791Qwq+9LGOV9?=
 =?us-ascii?Q?5WrIoMirZXqek5sUz2nxEV6zUCFgq6huVx+y91j7b5XI5VGvewQMNzip9evQ?=
 =?us-ascii?Q?0Rg9mWlGKz2gEIIhmyipNLFf2BoudXQg+kYghKSbdmRVH2NSfw5Oo26+Fp1F?=
 =?us-ascii?Q?D/RmT7Fgm8IyX5uawvajygdrhCzLUg68OGvyunTPVhGZg5WKtAgO/KDL+VK0?=
 =?us-ascii?Q?N4B1JPXVwU7YHn8IpnuIl158Uxgg17Fa9ZhscZj9NuspXvgahIKu5YGq3a/o?=
 =?us-ascii?Q?XXy0ta5yTLssGAtIlGiLL78ZQky/2DcVKJrADa3npBzzTyBE8ogwZZYdgsn8?=
 =?us-ascii?Q?S7JKBMloGWgjvke5pAaW8kzz4FhZABYHRevL4qrX899F+Fc5CmJawIrgHWTE?=
 =?us-ascii?Q?iP8srDPuc133Do5zV6TbQB3xrmX5rVMaw9zIoskSbUAcqgft31lxcb41FyJu?=
 =?us-ascii?Q?OFeELFeGDFnGC+nOCwTWclMB2OmZPdq/iyoK7S9YWlqAg3pYzFhfD/uUMvpZ?=
 =?us-ascii?Q?pgSGkiJmzZ8D0dIkhS31zdfIyVT/X3W6IUcHu8bFgYqs6NAFfPOX9HKU9md4?=
 =?us-ascii?Q?oZIOxZLO1GlMGWJnCBmL+Fv4eKHKVyjBew59X4sWYhHd97IvnAJGhLcGKrEe?=
 =?us-ascii?Q?G0mvde8oKNxLaVtOLtNYLom3ptLy0FEsQhCGTOnF/HyYzA2guJ5bspfxTHeO?=
 =?us-ascii?Q?dHLMaMfzJ0BX68GIGrygA83g9/LEisRCLaGYlqmzM5VnzxcPrLk0aRU5VyiB?=
 =?us-ascii?Q?sue2aE1Tp+ReaE5HkMuX4spzos7hqbXIvmFK6ToEXe56xvQwUUX89PigVfYW?=
 =?us-ascii?Q?4ebqBNmxtJOqARDhQvSnguCUb3HDd543LtxBZNr3ucfutzQVyN37J7FQLEhq?=
 =?us-ascii?Q?NGLp1wf2r/IWS/5EhqpLDZ/KiRFjcFcv9KlWl3Ky5qPRzoNh3wnZZTBvL/Z2?=
 =?us-ascii?Q?2aD7aCpEFKaPERhfTmdFw4EEEwX2Rfxx7XAe47/j3IEi9e8vddwwBM5V43NR?=
 =?us-ascii?Q?CdAoQfJZeJ4CLFwb1SJ/d2UjVI1nGhbws+xlke448+obNinWr84EYC3109OK?=
 =?us-ascii?Q?14Lv/vSISvRgXMdYJ0BDW43ACDNdk/dTzxI079vYRi563tFJdjXwUT+z77lz?=
 =?us-ascii?Q?dnvrSy/hs8KPywtfXpbXxasPIubdOgY9dnthL5LZaUGqBwckrTW/loPOOpGI?=
 =?us-ascii?Q?lK5qVj67WjOKDbjOpejp4+Idl3xp0TCVkNxYWEmc0DSBreRbrhDTIGCPzQEO?=
 =?us-ascii?Q?XQDFg7JdYM/IOxY3WO0tNK6YQO1yzEw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <507BB6D5D3E2CF4DB644415804FE1461@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c252968-ad7d-4858-594d-08da3f79d778
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2022 00:42:56.4302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RAbZalCqqrivIEvW/Z0xJrMEiAIi2XV0T4LGvLmyLNA9OSAa3Fee8b0dHKLQYta1cJFQh/eRMs+jXFCN+Gz0J/jPR2Q+SrYpl4ba0xgmGLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6720
X-Proofpoint-GUID: LUHKtQBn76IYWt5D_9Gy7wvjlwHFpOos
X-Proofpoint-ORIG-GUID: LUHKtQBn76IYWt5D_9Gy7wvjlwHFpOos
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-26_12,2022-05-25_02,2022-02-23_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo

> On May 26, 2022, at 2:31, Marcelo Tosatti <mtosatti@redhat.com> wrote:
>=20
> On Mon, May 23, 2022 at 11:53:32PM +0000, Eiichi Tsukata wrote:
>> Add trace points as are implemented in KVM host halt polling.
>> This helps tune guest halt polling params.
>>=20
>> Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
>> ---
>> drivers/cpuidle/governors/haltpoll.c | 15 ++++++++-----
>> include/trace/events/power.h         | 33 ++++++++++++++++++++++++++++
>> 2 files changed, 43 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/drivers/cpuidle/governors/haltpoll.c b/drivers/cpuidle/gove=
rnors/haltpoll.c
>> index cb2a96eafc02..a5b6ad32956c 100644
>> --- a/drivers/cpuidle/governors/haltpoll.c
>> +++ b/drivers/cpuidle/governors/haltpoll.c
>> @@ -19,6 +19,7 @@
>> #include <linux/sched.h>
>> #include <linux/module.h>
>> #include <linux/kvm_para.h>
>> +#include <trace/events/power.h>
>>=20
>> static unsigned int guest_halt_poll_ns __read_mostly =3D 200000;
>> module_param(guest_halt_poll_ns, uint, 0644);
>> @@ -77,13 +78,16 @@ static int haltpoll_select(struct cpuidle_driver *dr=
v,
>>=20
>> static void adjust_poll_limit(struct cpuidle_device *dev, u64 block_ns)
>> {
>> -	unsigned int val;
>> +	unsigned int val, old;
>>=20
>> -	/* Grow cpu_halt_poll_us if
>> -	 * cpu_halt_poll_us < block_ns < guest_halt_poll_us
>> +	val =3D dev->poll_limit_ns;
>> +	old =3D val;
>> +
>> +	/* Grow poll_limit_ns if
>> +	 * poll_limit_ns < block_ns < guest_halt_poll_ns
>> 	 */
>> 	if (block_ns > dev->poll_limit_ns && block_ns <=3D guest_halt_poll_ns) =
{
>> -		val =3D dev->poll_limit_ns * guest_halt_poll_grow;
>> +		val *=3D guest_halt_poll_grow;
>>=20
>> 		if (val < guest_halt_poll_grow_start)
>> 			val =3D guest_halt_poll_grow_start;
>> @@ -91,16 +95,17 @@ static void adjust_poll_limit(struct cpuidle_device =
*dev, u64 block_ns)
>> 			val =3D guest_halt_poll_ns;
>>=20
>=20
> Can do it before the assignment:
>=20
> 		trace_guest_halt_poll_ns_grow(val, dev->poll_limit_ns);


Sure. Will fix it in v4.
Thanks

Eiichi=
