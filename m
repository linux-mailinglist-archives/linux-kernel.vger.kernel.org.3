Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6238553217A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 05:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbiEXDKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 23:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiEXDKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 23:10:40 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2117.outbound.protection.outlook.com [40.107.95.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AE87A47A
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 20:10:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTN/kBHn45rZ283IWMrT+ANXZIevdP8wsTLwihPie0sQXz3PMa9JwmpiQhGZRaft7i2b1NCKAgdml7XltTHv4gMxaClzvcZ1s45SO6cAPObOoxeYr33C2W+Slh5qa8ALUNwAqXTA/5ceooyhBsrSe/00Ogi9I1N1pKnmlGu6Rbm+4lE0kdawPmxDZqutFh6qglimvYUFzdP7xHnr2kuRXKZ/AsVT6bvijuhuBcsSnJ3xaMvDQQs5Ab7SXIe9JIBPjPLB9OkkI0nNIBJQKhk0u02YVoqAwVRYuDYfqTrRobDHLR5lGshC4VvejMsePvIt0sG02xF+qqWZKaJFQypRUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vj7bL6AP1PWyEUXKIktvcMSfTddRQqYiL/oOYGLTxsE=;
 b=REm1O6GDPOgSEKyiyYa99DeAa7c7jlAkS4ZGiGjmnJiMo0V50LsUC4VwEJa1mDGLlLl40usKJfs2T9GYqSZ0ZK2FSF5NuXmCiWhWBwpznPCMgMHWPHs/5v8WBe1imVeb1vdFCZCJ2bDPVPindlN85cTi4oosBbbTCvkkxpiV9IMzkWQrDjU4A+VYDKDCrp1v82M8MaL4oe7P6LVXoEhl/3EeCd2GtK0oVwfzyVT8RDIrYFi/2Z5XESjgje+g/0NxujEPCmQkinDc3SZTZZFCfQnOTzgolhw2Z8eXWgFOZDQvf4U3zfL71GeNbePJd4hCzkPBa/z6Ow2Iw1eOBFEMNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=purdue.edu; dmarc=pass action=none header.from=purdue.edu;
 dkim=pass header.d=purdue.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purdue0.onmicrosoft.com; s=selector2-purdue0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vj7bL6AP1PWyEUXKIktvcMSfTddRQqYiL/oOYGLTxsE=;
 b=fMvcC0Kanc6yRBjJFj7PZJDu6Z+LaLJFDeOzdtvhI8O0sSTA/Vxs7Lt9E7FiLwd0LP3tk+axHjiVUcWJ2ij5+p5GTKQsscoqjk1NgRQrGXqiFpiQiI/GVRZ8y9MtzfXY8TEAAs+28/NfEwP8HLTc1ClqnxE+1VojwNkQBpGY9DY=
Received: from MWHPR2201MB1072.namprd22.prod.outlook.com
 (2603:10b6:301:33::18) by BYAPR22MB2375.namprd22.prod.outlook.com
 (2603:10b6:a02:c1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Tue, 24 May
 2022 03:10:37 +0000
Received: from MWHPR2201MB1072.namprd22.prod.outlook.com
 ([fe80::a9e9:b100:2a55:23aa]) by MWHPR2201MB1072.namprd22.prod.outlook.com
 ([fe80::a9e9:b100:2a55:23aa%3]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 03:10:37 +0000
From:   "Liu, Congyu" <liu3101@purdue.edu>
To:     Dmitry Vyukov <dvyukov@google.com>
CC:     "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] kcov: update pos before writing pc in trace function
Thread-Topic: [PATCH v2] kcov: update pos before writing pc in trace function
Thread-Index: AQHYbmb5ybW7rPmroUCLD053biTbk60sJDKAgAEv7peAAAZIxA==
Date:   Tue, 24 May 2022 03:10:37 +0000
Message-ID: <MWHPR2201MB10723DDEE1492EA0BB6AEE8CD0D79@MWHPR2201MB1072.namprd22.prod.outlook.com>
References: <20220523053531.1572793-1-liu3101@purdue.edu>
 <CACT4Y+Y9bx0Yrn=kntwcRwdrZh+O7xMKvPWgg=aMjyXb9P4dLw@mail.gmail.com>
 <MWHPR2201MB1072A5D51631B60BF02E2F3DD0D79@MWHPR2201MB1072.namprd22.prod.outlook.com>
In-Reply-To: <MWHPR2201MB1072A5D51631B60BF02E2F3DD0D79@MWHPR2201MB1072.namprd22.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 97fb9dcb-d055-7325-928e-eb7bd94ddc9c
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=purdue.edu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00d8d8e5-ee7b-4817-0058-08da3d32f9a1
x-ms-traffictypediagnostic: BYAPR22MB2375:EE_
x-microsoft-antispam-prvs: <BYAPR22MB23754928B9A2354A971E0CCCD0D79@BYAPR22MB2375.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4p2zDJ2Z1uANXRQ/ZSi0a0OHCegO8g11E8M0+ID8pjlR1Kc2xDlT70MNqx71iArjBD6NqyY+pnDBwWEpv2O415TVkGrfEWB/cchE91zt+CWsdbe2nVJFZDrBosMX8S2hJ/d332oFEzYj8IemLeY2WLNKJ8MjLtRCtd2jUqukSptZQM+vLaLvtWXVYpBB9lwPe02qhmgBan0iVB0Gxw8nj5AEIvpxbeiLs1RgSv+4WBkhsjPt9zHge7NQnpFUEnObP5NB3oL19UGadzR7LkpzrAbgkdz9LCns1rA2fxf4CEJXtoovIkH4XhYIAijFFBA3W5aseuzZqSUHlusgWlTwzyfszwTuPFgI93nI1d6q4fkC1FbuNI9EiQfn7oDftasaOjIyZ97TAKRTpm7PhEDpBbCJhZL0g8IJxsCdxtxyz81nN0LN+1H0VmUGYDfQX50fYdqA9/1UKX+XbT92BzdxjWUNTwVlcP22sMuD7UQQWzWX6ycJn5hBIDhiWhFXrzyksS63IdGHKZdfM+TJuXmV2l8t2IQLMihdetLsO9NRcR2PQBKW7vfEz5uziJp/rklXi1DZKKfsPCzAFdi8vKGNI0WQnOyjJD24Qzc+ZoOJ8MMWflO2vwaoDXRlVVzKeTWxBXhCFVzl90JoxGnnDvNhnqoKr4SUJ34KK3HHla3RgAh6obs6j1D91iYBqfpnLjOVmii7YOhOkPEsymb1Tej8BaFvUKfKK6UfDmm2OldFBTsvOU3Tv9meGuHwh08bdhzc4nuvpRnJ89rgl1k47rQB0bECf9hbZWK8zKtu/T0uH1M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR2201MB1072.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(966005)(52536014)(8936002)(55016003)(2940100002)(83380400001)(186003)(5660300002)(6506007)(7696005)(53546011)(66476007)(64756008)(86362001)(26005)(15650500001)(9686003)(33656002)(66556008)(2906002)(508600001)(6916009)(8676002)(54906003)(38100700002)(316002)(786003)(122000001)(66946007)(66446008)(76116006)(38070700005)(4326008)(75432002)(91956017)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ojpk4XugF7WdlAYKdidJBr1bABZAR4e+0iy5IxTvHrAq3AGdYhh17X6N5/Kp?=
 =?us-ascii?Q?UtN383bdKkawfZeOKCIsffQknpaTY8C2xwe7SjLfuqSXjrIXw5NdUYMzeIDj?=
 =?us-ascii?Q?sRVYwp3WMBhEbgaE2ZWkUwXuU50tlLS6vxa2lKw3XGWl6TnlqitBbyXEueoA?=
 =?us-ascii?Q?/ZUrxqbUBTwiAWVwYU73GdLBOB3O7fj4gkUMovDiguICd58KfbybOxYYiJfq?=
 =?us-ascii?Q?S+HB7c0lDJVUUDUDrDqcgoOfYz5L/1eTDqjfC3bW0+g0yBmCBQJv/lu0gJoy?=
 =?us-ascii?Q?onygDqEUb4aqySq21nciHfpW80st/Tv2tZid2sO8bNSdwIOfnuYWKBEcEqOp?=
 =?us-ascii?Q?JutZw8e5TwBNlTp9tU6NIN1slTBHnEPSKbQUKQqtSylTR2nIUKf1KiFpVWYh?=
 =?us-ascii?Q?PqHKThljMh35+0a1Pprov9BepqzD1vO9LUnV3lDIbkVFzMataXC4WADK+KnO?=
 =?us-ascii?Q?pP2Gl57+HthX7CLnGxAzKn3f/bLpyp1l0icnUexo9S579DdIkObirAVNr/Yc?=
 =?us-ascii?Q?SDHoBZjFCx4p7ltrJfi2roiDoIv7APdi4VJsp0M4SCedt9nYmlFa1hGJkuZJ?=
 =?us-ascii?Q?VxstO2exAVPfMNSE/iy3WPGaqQSDi7u834Wf2A0NLP4oK5OiSQxnIldC4E0O?=
 =?us-ascii?Q?MagzHgGk7YnUvk+hE1e3hIRSCKKUL8fUsohlzL2uOVvQQa/ezFvDwCoM21jJ?=
 =?us-ascii?Q?ebGLxcXeH8V9BMWVQFWTIV5MDgObfEArNvUdblh2zEGe9ntl5se4rsA7k6ei?=
 =?us-ascii?Q?Cn9NyafUBQdoaR1myuQUtB3wkWvt4v/GOtTvzMSq4hJovZNCv0Fy910e3MHQ?=
 =?us-ascii?Q?2KFYP5PeJ27NGYsykJ5uYknq9hkdo5jsCsi0YU4OVoqvcs0nMEWig3iC4YQE?=
 =?us-ascii?Q?2OCk23DeU7+kOFvAg1wNWZ70ERDwC/aHFkG6oQJRIe5hw8ATiujlbfQUdehO?=
 =?us-ascii?Q?kaFZMBAL5EBYDHVGadLddOU5loruJTz87CBQ+cskw3rICiRWKlc4pVmtHRdU?=
 =?us-ascii?Q?gnfXBqvFnks3w7U7/NkPfJrAGnMEyG5ds19B3uoEbkagfXaORPD8FiYJrRs1?=
 =?us-ascii?Q?TPcoFNaH3Jm307Hq45mhysZto6YvHxJkgSDGVgAX8wSjQDDWuaAr81dSc8ZL?=
 =?us-ascii?Q?rkGLNowyIJ3N3PWGwrGV60WwCSMaQ7YIehCXpZYpjqP3ZQsE8HuQOGXuRt/g?=
 =?us-ascii?Q?q8miYqUWs6yt7V2wqmTTFXMill/vAI8rtA0nC+evHC4groTpCmOfmYssKapL?=
 =?us-ascii?Q?PcPMVRtfbL/WbRig22qj/+if+Y8ZNQdIS5o7K03QoF+oZL+OGk4CuNgA01oW?=
 =?us-ascii?Q?fCkwdBK2L/eOtHZycYzvYyq6F1Xz/Wh55Q4hi5JcN6KJi8AHlg9BrLmtNGnk?=
 =?us-ascii?Q?j+VwIFlDu0RmahOR2ByQpkxL4C7/CeNmvncELHeyY1wHJfWvLRT8OnQtiIbJ?=
 =?us-ascii?Q?SV1ZsAdYkpNUD1qxGQcVa1GLYwQLs+ZtHrNFBn0k0JjakXrAlneroJBDBCgp?=
 =?us-ascii?Q?HuFuIlne6Fe491RPhoFFHt3N2+l15XGQGHObzXkbbXKn6MLlZuDzfCFvN3Nj?=
 =?us-ascii?Q?tJpe4RLvf9si2gMMZYImVNrxgMTTI9IerdUcDsOvW8Wx8oma/8dvtFqTh+sC?=
 =?us-ascii?Q?+IjjAZD9E4AfWIQITd3hifv4e99GfmQGKfB15JAoDIH/eBEopW3Ynz8257bu?=
 =?us-ascii?Q?KBvNEsMnBKcFLKaqj/XPlgliFlIZwHZpgWpJoFDMKo62ZXNjnnvvo/CMJw5W?=
 =?us-ascii?Q?P79QvxmMXA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: purdue.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR2201MB1072.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d8d8e5-ee7b-4817-0058-08da3d32f9a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 03:10:37.1771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4130bd39-7c53-419c-b1e5-8758d6d63f21
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wFPgrzgXBZWrlAI0AEzWN9X9mmH5zvc93/nyw4oJgsl4NhGhkFjzC46p7oqZv33J7mwVWYCclLUZJlNhxgLX9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR22MB2375
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Andrew Morton

________________________________________
From: Liu, Congyu <liu3101@purdue.edu>
Sent: Monday, May 23, 2022 23:08
To: Dmitry Vyukov
Cc: andreyknvl@gmail.com; kasan-dev@googlegroups.com; linux-kernel@vger.ker=
nel.org
Subject: Re: [PATCH v2] kcov: update pos before writing pc in trace functio=
n

It was actually first found in the kernel trace module I wrote for my resea=
rch
project. For each call instruction I instrumented one trace function before=
 it
and one trace function after it, then expected traces generated from
them would match since I only instrumented calls that return. But it turns
out that it didn't match from time to time in a non-deterministic manner.
Eventually I figured out it was actually caused by the overwritten issue
from interrupt. I then referred to kcov for a solution but it also suffered=
 from
the same issue...so here's this patch :).

________________________________________
From: Dmitry Vyukov <dvyukov@google.com>
Sent: Monday, May 23, 2022 4:38
To: Liu, Congyu
Cc: andreyknvl@gmail.com; kasan-dev@googlegroups.com; linux-kernel@vger.ker=
nel.org
Subject: Re: [PATCH v2] kcov: update pos before writing pc in trace functio=
n

On Mon, 23 May 2022 at 07:35, Congyu Liu <liu3101@purdue.edu> wrote:
>
> In __sanitizer_cov_trace_pc(), previously we write pc before updating pos=
.
> However, some early interrupt code could bypass check_kcov_mode()
> check and invoke __sanitizer_cov_trace_pc(). If such interrupt is raised
> between writing pc and updating pos, the pc could be overitten by the
> recursive __sanitizer_cov_trace_pc().
>
> As suggested by Dmitry, we cold update pos before writing pc to avoid
> such interleaving.
>
> Apply the same change to write_comp_data().
>
> Signed-off-by: Congyu Liu <liu3101@purdue.edu>

This version looks good to me.
I wonder how you encountered this? Do you mind sharing a bit about
what you are doing with kcov?

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

Thanks

> ---
> PATCH v2:
> * Update pos before writing pc as suggested by Dmitry.
>
> PATCH v1:
> https://lore.kernel.org/lkml/20220517210532.1506591-1-liu3101@purdue.edu/
> ---
>  kernel/kcov.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index b3732b210593..e19c84b02452 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -204,8 +204,16 @@ void notrace __sanitizer_cov_trace_pc(void)
>         /* The first 64-bit word is the number of subsequent PCs. */
>         pos =3D READ_ONCE(area[0]) + 1;
>         if (likely(pos < t->kcov_size)) {
> -               area[pos] =3D ip;
> +               /* Previously we write pc before updating pos. However, s=
ome
> +                * early interrupt code could bypass check_kcov_mode() ch=
eck
> +                * and invoke __sanitizer_cov_trace_pc(). If such interru=
pt is
> +                * raised between writing pc and updating pos, the pc cou=
ld be
> +                * overitten by the recursive __sanitizer_cov_trace_pc().
> +                * Update pos before writing pc to avoid such interleavin=
g.
> +                */
>                 WRITE_ONCE(area[0], pos);
> +               barrier();
> +               area[pos] =3D ip;
>         }
>  }
>  EXPORT_SYMBOL(__sanitizer_cov_trace_pc);
> @@ -236,11 +244,13 @@ static void notrace write_comp_data(u64 type, u64 a=
rg1, u64 arg2, u64 ip)
>         start_index =3D 1 + count * KCOV_WORDS_PER_CMP;
>         end_pos =3D (start_index + KCOV_WORDS_PER_CMP) * sizeof(u64);
>         if (likely(end_pos <=3D max_pos)) {
> +               /* See comment in __sanitizer_cov_trace_pc(). */
> +               WRITE_ONCE(area[0], count + 1);
> +               barrier();
>                 area[start_index] =3D type;
>                 area[start_index + 1] =3D arg1;
>                 area[start_index + 2] =3D arg2;
>                 area[start_index + 3] =3D ip;
> -               WRITE_ONCE(area[0], count + 1);
>         }
>  }
>
> --
> 2.34.1
>
