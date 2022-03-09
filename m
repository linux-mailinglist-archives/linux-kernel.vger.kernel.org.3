Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501FE4D265D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiCIBY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiCIBYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:24:54 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0707C31220;
        Tue,  8 Mar 2022 17:23:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTXIXQ2HoILj9GYFZ6PDxAOJL2EbH+n37i87vryEmLGW40Rb8yn1YMrHWjA52faSOwWyrLQ98jhmuV8Kj5ZYSvBmZD/PoxvdkhnQRwPTvZPvCN1mzK54akNOlr9Dlerco/4O5tgdfUT7J3DfcFNp/YFYJVHj8PeBWWh5xUloi5y6H7uzektGQVemJyqeFsbCotwgmw0pKgU6Dy3hMOefvZFaTBBOV9uxPK0s/aJfAqco5tsq1bUeTB7FahExL2aCRpbI69O4FyJJvTcwUKegqo3OgDZ4ByQqmJVlrhRRb9CIpjFezx8AITmf2c0Xi5d7jqcR2E6GRjK0FBkcV+d6fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXNdwgYnAiMAKDOxw/vFMoETq++I5ugfAkpmf9FvpnY=;
 b=cmoK1dtG/w6QFGhtFedywSbRW56wA7oYj25mICGP+4pr21T5MtXK0sLvh1x4jv9hH+Le4BI01d7FdEcJGi8ZuHMyyHWmq8l2CZ4z9FPDegoLVSt0XZQ6BypwmOwcgYbzFHTASHJAztCyC5dtzCiwBcJ1O9XsWL8RdpvaSaBhfsWG1JQhAvyl2FDORinPFj2mcS+1bavkkZ47MVFwZPQScWWrlCIYs8tf5mMfb6FItlLhVW+XK5LzMuwC30l77Zc/XCt+98Q5w/BJo5Lotw4FBTEXNJJqWKOYGvFCTzhfwZHWsbN0hLsMW/wsBMshLqfoQuyGGaUtHuu4HXYl8sxLPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXNdwgYnAiMAKDOxw/vFMoETq++I5ugfAkpmf9FvpnY=;
 b=cVAq2wHHzIlnD14pY8jWXOF3xZnsRjrGbHsy/brfdAC2kVVjg6+tgy6LlXOLsYhq1zyk7KAk2o7AyN8hY7PZ4pizCfDe492m/F1NGBF8Xo4TluulwLFEh7UVMPBebM1oZz5z2fUMmgxHvmkjXrQzCVJq02MxmWh1PGPPqX5tYCA=
Received: from MWHPR1201MB2494.namprd12.prod.outlook.com
 (2603:10b6:300:de::20) by MN2PR12MB3725.namprd12.prod.outlook.com
 (2603:10b6:208:162::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Wed, 9 Mar
 2022 01:23:39 +0000
Received: from MWHPR1201MB2494.namprd12.prod.outlook.com
 ([fe80::5c3f:ea0c:6ecb:db68]) by MWHPR1201MB2494.namprd12.prod.outlook.com
 ([fe80::5c3f:ea0c:6ecb:db68%10]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 01:23:39 +0000
From:   "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>
To:     "Huang, Ray" <Ray.Huang@amd.com>
CC:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "dsmythies@telus.net" <dsmythies@telus.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "todd.e.brandt@linux.intel.com" <todd.e.brandt@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>
Subject: RE: [PATCH V2 1/4] cpufreq: amd-pstate: Add more tracepoint for AMD
 P-State module
Thread-Topic: [PATCH V2 1/4] cpufreq: amd-pstate: Add more tracepoint for AMD
 P-State module
Thread-Index: AQHYL45l9/a26gHh9UOHYockdnvA46yuxswAgAd+DGA=
Date:   Wed, 9 Mar 2022 01:23:38 +0000
Message-ID: <MWHPR1201MB2494A689835082F711CC13C1900A9@MWHPR1201MB2494.namprd12.prod.outlook.com>
References: <20220304060724.314582-1-Jinzhou.Su@amd.com>
 <20220304060724.314582-2-Jinzhou.Su@amd.com> <YiG0uqa+Ho7XyuHJ@amd.com>
In-Reply-To: <YiG0uqa+Ho7XyuHJ@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=b503da3b-065f-4292-8fe2-c36a881645cd;MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP
 2.0;MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-09T01:06:59Z;MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fbac694b-094b-427c-5da7-08da016b70db
x-ms-traffictypediagnostic: MN2PR12MB3725:EE_
x-microsoft-antispam-prvs: <MN2PR12MB37253B9F320D15C7AC26CC03900A9@MN2PR12MB3725.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SxG5Sy3HPsJkAag+oED70R58yCQYTgayj/XMgmEBKcX5WQpcCZFdTpH6ugo77GTBSDUCSUa8rfbslYVCE9Y0YTEdt66XOPcpf4HDll0sEo/6Vl5knGJQIfXr9/XkYY4IXiBwty8Wwa1WWtOrq8Np2NaRZ23ElVHfZxvNEJNHAGJ+qydDHtRfpE9L/EaS0knSJ6cnXUOBHF6MTOYKFhoxhqQ43J7PLEv99bO5jEOMJ1joOOZtdh1iZiCtSEG4VBpcjidDRIP9t6oN6YrhuMe6scLRTwbiGwwvappJDqkf89Z9fjmqlmzXVkh60BSx623QrcBi17BVrvccPHNgXRkioRl9YS4BHxErKM2lPsifKQblTkAofYgByzsI7OyA+UDjrJFV1sd4MXi4w5c0EZMJk7o9LZ3IxlY5UKXfsn0ZwGcr6LrwnLWKIMq/OFH7L4Betl7VEVLyP9xAmYlEPPuudnPnmwEqCAtj8RbjELdpAWTsbN1afHARtBSLtIaU6IbCQnyFnrdDabSZ0/yA6VDBtbEHP//tqqBWEQ1291GivQIE9ubogo+YSAi2I269lRwzXu7cSvtqdhroGVEI4gan7nzu3S55j5BOJBm1gFVrX+M9dBPZaqs2ncujGfWYbXw4DAjEgs7pHt3MdlBnXoOdlHporgZojUsky7voAeAV/S5pNjyMb1UFusT45dqmX/C3UL3yT8GbD0Kyj7LzW7j/cw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1201MB2494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(83380400001)(7696005)(6506007)(6636002)(71200400001)(26005)(53546011)(66446008)(8936002)(4326008)(76116006)(6862004)(66946007)(86362001)(8676002)(64756008)(66556008)(52536014)(66476007)(38100700002)(5660300002)(55016003)(9686003)(33656002)(38070700005)(2906002)(508600001)(186003)(54906003)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h9GMpjRLmmDvT5S2FTf5DFqnnLtMivxrOx00XtWbpTB9CvX8KmMxnwNAtgFX?=
 =?us-ascii?Q?gDJ20rtZd+sLxvYBYW2zut6xS5J+CjL8usP29I/RukPLFXT5mL+sREexMQIf?=
 =?us-ascii?Q?dFgARzGU06XXb99Y8vw01WaIes5xRw1AhqsALWmCbdbAKVsk4UDDBeI4RtVX?=
 =?us-ascii?Q?5QG/pxw7pBe4LjA+V1GomxpxKKmR6j5EEiqyQCYjns6iAGHgrjaVmT6/n/2Z?=
 =?us-ascii?Q?e3hDhpnKdfe4qUC1zI74zb1A6MzFPcDIuCwpDlyMheuqjCX1YfNOyq2aOAxX?=
 =?us-ascii?Q?5jvA47t3zGgQR26lj20JKMkvMXwga4bmQlzGMKImWnYHR3klO/1QMwC3/G9T?=
 =?us-ascii?Q?WWEG0v7h6MiVYpV2PYkesFPY0mTRdiiTFBAn50Gtoy/t4pACtCKUTZjWHl4E?=
 =?us-ascii?Q?YYAvQnwzJCov7QIFTKk5XiM4d68TrSRk9nk0jlrKQkHjuWyyl72xM5WrMig9?=
 =?us-ascii?Q?dnKm1ZRcHACcgWUaQCdhKVdOO7pMjYScOsaKjrkJzrq391XAaaeXPlfNc3bX?=
 =?us-ascii?Q?hCuEjGD8dnlTuuTce9iQTkrFHe4EVH2woQQGVQTW3WweMkYQu5IPrXMeoRIn?=
 =?us-ascii?Q?k3fEtPbmtGAn28B7HEs4nlvTmidQnKOTcrzxIK0sWgDrGxGxnmG4m1W433bu?=
 =?us-ascii?Q?Tww1i76D1fQavFLnSbgy7LxcQEVmY659lnCPL3c/YKISdyCZNPRiHUYHxBHK?=
 =?us-ascii?Q?IZT9yzCbb79GX+L/hq7EPjC5ky4qQ7htnCkqbYr7T7mQtRL9FKTJSRaBff37?=
 =?us-ascii?Q?Ctc2JMB+WIxb3xuv97uWhVIDoqftYwmN2yPju2So/6ersOHzR0jTe5pP08ns?=
 =?us-ascii?Q?ZVeLW9msk0k1UMVpgzqOZyDCH10GEoJF00+Kko5FO/fxrZkwNFTeN5TxnlNy?=
 =?us-ascii?Q?uuxKUHhY6f9DEsj9ux+TMtaOZqmgoOQJJK9RKcoExgRUtCMbLAeJJM0LFAZw?=
 =?us-ascii?Q?8kcAlyDqu3chHydyIYplJJVvRws2Iieh7UmIGmM29F4AWFpyFNP7enZe3ERa?=
 =?us-ascii?Q?JmuR+AjpxAbYo1yc/VmnoWPpisOBKsh8mrD429GaPYK1B6dBYUJ1iT5NLmX5?=
 =?us-ascii?Q?QFZfYQyzBy1scmF9KNEAzo9PUz2Dpl2bQuFi1yQYyOYRvyTtshKDTMW1PCrX?=
 =?us-ascii?Q?MnY8rFYOolva8P3uE6qg4zW/wZaPqW/vJ75/iEuEGt9uyN8KKMQyB8c67lUB?=
 =?us-ascii?Q?XwbCQnv6GfCEJqzuqeI/NOYdKipc4kcJt2ER3Prf2hlJkQWmvFHLkj2SwZFI?=
 =?us-ascii?Q?glYoUGLCA0cBXISurqgRkhlPDZQ033fEGCNXed1OoDm1UO3b/G8Qj+SxCY0y?=
 =?us-ascii?Q?OS11EmAmcaDHfjUm7cOlq/aI5nAM6z/sysIGgRaEB5JPi41VfgMQArJAFXsi?=
 =?us-ascii?Q?M/Vdlf3BI55B3S4C+5Lyw+ZPDNXIVJyLKgxDJVJtL05q3DripZ2qYPyZKwJq?=
 =?us-ascii?Q?VF2SmsGOceqZ3YKzs48QoDk7RhP7UighI3UePTlv4Dvfkv2S4s1CeV/Tpf7P?=
 =?us-ascii?Q?OFBuyEsg6e1SifmoB2K/yvu8tJPB5MlWgh1V6i5NkHdNPDIlm7WbrIV3AaZK?=
 =?us-ascii?Q?gADaG4HpuTDbCgs0f9kJhydcMZjuLVqhDXMby3bPBYl/zzoA6vzO+tGjWidU?=
 =?us-ascii?Q?GY3prJMkDgOM2I7IFTMRtV8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB2494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbac694b-094b-427c-5da7-08da016b70db
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 01:23:38.9149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t13KSTkz+XYC/1IficYZDJiIq5v5YKa4DDWEsrOEzCVrL0AGOYFFPYqroahVtZEGY/D85uNr4x4vtzRzJTXPPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3725
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only]

> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Friday, March 4, 2022 2:42 PM
> To: Su, Jinzhou (Joe) <Jinzhou.Su@amd.com>
> Cc: rjw@rjwysocki.net; linux-pm@vger.kernel.org;
> srinivas.pandruvada@linux.intel.com; dsmythies@telus.net;
> viresh.kumar@linaro.org; todd.e.brandt@linux.intel.com; linux-
> kernel@vger.kernel.org; Sharma, Deepak <Deepak.Sharma@amd.com>;
> Deucher, Alexander <Alexander.Deucher@amd.com>; Du, Xiaojian
> <Xiaojian.Du@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>; Meng, Li
> (Jassmine) <Li.Meng@amd.com>
> Subject: Re: [PATCH V2 1/4] cpufreq: amd-pstate: Add more tracepoint for
> AMD P-State module
>
> On Fri, Mar 04, 2022 at 02:07:21PM +0800, Su, Jinzhou (Joe) wrote:
> > Add frequency, mperf, aperf and tsc in the trace. This can be used to
> > debug and tune the performance of AMD P-state driver.
> >
> > Use the time difference between amd_pstate_update to calculate CPU
> > frequency. There could be sleep in arch_freq_get_on_cpu, so do not use
> > it here.
> >
> > Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
> > Co-developed-by: Huang Rui <ray.huang@amd.com>
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
>
> Let's remove "Signed-off-by" of me, just leave "Co-developed-by".
>
> > ---
> >  drivers/cpufreq/amd-pstate-trace.h | 22 ++++++++++-
> >  drivers/cpufreq/amd-pstate.c       | 59 +++++++++++++++++++++++++++++-
> >  2 files changed, 78 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate-trace.h
> > b/drivers/cpufreq/amd-pstate-trace.h
> > index 647505957d4f..35f38ae67fb1 100644
> > --- a/drivers/cpufreq/amd-pstate-trace.h
> > +++ b/drivers/cpufreq/amd-pstate-trace.h
> > @@ -27,6 +27,10 @@ TRACE_EVENT(amd_pstate_perf,
> >     TP_PROTO(unsigned long min_perf,
> >              unsigned long target_perf,
> >              unsigned long capacity,
> > +            u64 freq,
> > +            u64 mperf,
> > +            u64 aperf,
> > +            u64 tsc,
> >              unsigned int cpu_id,
> >              bool changed,
> >              bool fast_switch
> > @@ -35,6 +39,10 @@ TRACE_EVENT(amd_pstate_perf,
> >     TP_ARGS(min_perf,
> >             target_perf,
> >             capacity,
> > +           freq,
> > +           mperf,
> > +           aperf,
> > +           tsc,
> >             cpu_id,
> >             changed,
> >             fast_switch
> > @@ -44,6 +52,10 @@ TRACE_EVENT(amd_pstate_perf,
> >             __field(unsigned long, min_perf)
> >             __field(unsigned long, target_perf)
> >             __field(unsigned long, capacity)
> > +           __field(unsigned long long, freq)
> > +           __field(unsigned long long, mperf)
> > +           __field(unsigned long long, aperf)
> > +           __field(unsigned long long, tsc)
> >             __field(unsigned int, cpu_id)
> >             __field(bool, changed)
> >             __field(bool, fast_switch)
> > @@ -53,15 +65,23 @@ TRACE_EVENT(amd_pstate_perf,
> >             __entry->min_perf =3D min_perf;
> >             __entry->target_perf =3D target_perf;
> >             __entry->capacity =3D capacity;
> > +           __entry->freq =3D freq;
> > +           __entry->mperf =3D mperf;
> > +           __entry->aperf =3D aperf;
> > +           __entry->tsc =3D tsc;
> >             __entry->cpu_id =3D cpu_id;
> >             __entry->changed =3D changed;
> >             __entry->fast_switch =3D fast_switch;
> >             ),
> >
> > -   TP_printk("amd_min_perf=3D%lu amd_des_perf=3D%lu
> amd_max_perf=3D%lu cpu_id=3D%u changed=3D%s fast_switch=3D%s",
> > +   TP_printk("amd_min_perf=3D%lu amd_des_perf=3D%lu
> amd_max_perf=3D%lu
> > +freq=3D%llu mperf=3D%llu aperf=3D%llu tsc=3D%llu cpu_id=3D%u changed=
=3D%s
> > +fast_switch=3D%s",
> >               (unsigned long)__entry->min_perf,
> >               (unsigned long)__entry->target_perf,
> >               (unsigned long)__entry->capacity,
> > +             (unsigned long long)__entry->freq,
> > +             (unsigned long long)__entry->mperf,
> > +             (unsigned long long)__entry->aperf,
> > +             (unsigned long long)__entry->tsc,
> >               (unsigned int)__entry->cpu_id,
> >               (__entry->changed) ? "true" : "false",
> >               (__entry->fast_switch) ? "true" : "false"
> > diff --git a/drivers/cpufreq/amd-pstate.c
> > b/drivers/cpufreq/amd-pstate.c index 9ce75ed11f8e..7be38bc6a673 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -65,6 +65,18 @@ MODULE_PARM_DESC(shared_mem,
> >
> >  static struct cpufreq_driver amd_pstate_driver;
> >
> > +/**
> > + * struct  amd_aperf_mperf
> > + * @aperf: actual performance frequency clock count
> > + * @mperf: maximum performance frequency clock count
> > + * @tsc:   time stamp counter
> > + */
> > +struct amd_aperf_mperf {
> > +   u64 aperf;
> > +   u64 mperf;
> > +   u64 tsc;
> > +};
> > +
> >  /**
> >   * struct amd_cpudata - private CPU data for AMD P-State
> >   * @cpu: CPU number
> > @@ -81,6 +93,9 @@ static struct cpufreq_driver amd_pstate_driver;
> >   * @min_freq: the frequency that mapped to lowest_perf
> >   * @nominal_freq: the frequency that mapped to nominal_perf
> >   * @lowest_nonlinear_freq: the frequency that mapped to
> > lowest_nonlinear_perf
> > + * @cur: Difference of Aperf/Mperf/tsc count between last and current
> > + sample
> > + * @prev: Last Aperf/Mperf/tsc count value read from register
> > + * @freq: current cpu frequency value
> >   * @boost_supported: check whether the Processor or SBIOS supports boo=
st
> mode
> >   *
> >   * The amd_cpudata is key private data for each CPU thread in AMD
> > P-State, and @@ -102,6 +117,10 @@ struct amd_cpudata {
> >     u32     nominal_freq;
> >     u32     lowest_nonlinear_freq;
> >
> > +   struct amd_aperf_mperf cur;
> > +   struct amd_aperf_mperf prev;
> > +
> > +   u64 freq;
> >     bool    boost_supported;
> >  };
> >
> > @@ -211,6 +230,39 @@ static inline void amd_pstate_update_perf(struct
> amd_cpudata *cpudata,
> >                                         max_perf, fast_switch);
> >  }
> >
> > +static inline bool amd_pstate_sample(struct amd_cpudata *cpudata) {
> > +   u64 aperf, mperf, tsc;
> > +   unsigned long flags;
> > +
> > +   local_irq_save(flags);
> > +   rdmsrl(MSR_IA32_APERF, aperf);
> > +   rdmsrl(MSR_IA32_MPERF, mperf);
> > +   tsc =3D rdtsc();
> > +
> > +   if (cpudata->prev.mperf =3D=3D mperf || cpudata->prev.tsc =3D=3D ts=
c) {
> > +           local_irq_restore(flags);
> > +           return false;
> > +   }
> > +
> > +   local_irq_restore(flags);
> > +
> > +   cpudata->cur.aperf =3D aperf;
> > +   cpudata->cur.mperf =3D mperf;
> > +   cpudata->cur.tsc =3D  tsc;
> > +   cpudata->cur.aperf -=3D cpudata->prev.aperf;
> > +   cpudata->cur.mperf -=3D cpudata->prev.mperf;
> > +   cpudata->cur.tsc -=3D cpudata->prev.tsc;
> > +
> > +   cpudata->prev.aperf =3D aperf;
> > +   cpudata->prev.mperf =3D mperf;
> > +   cpudata->prev.tsc =3D tsc;
> > +
> > +   cpudata->freq =3D div64_u64((cpudata->cur.aperf * cpu_khz),
> > +cpudata->cur.mperf);
> > +
> > +   return true;
> > +}
> > +
> >  static void amd_pstate_update(struct amd_cpudata *cpudata, u32
> min_perf,
> >                           u32 des_perf, u32 max_perf, bool fast_switch)
> { @@ -226,8
> > +278,11 @@ static void amd_pstate_update(struct amd_cpudata *cpudata,
> u32 min_perf,
> >     value &=3D ~AMD_CPPC_MAX_PERF(~0L);
> >     value |=3D AMD_CPPC_MAX_PERF(max_perf);
> >
> > -   trace_amd_pstate_perf(min_perf, des_perf, max_perf,
> > -                         cpudata->cpu, (value !=3D prev), fast_switch)=
;
> > +   if (trace_amd_pstate_perf_enabled() &&
> amd_pstate_sample(cpudata)) {
> > +           trace_amd_pstate_perf(min_perf, des_perf, max_perf,
> cpudata->freq,
> > +                   cpudata->cur.mperf, cpudata->cur.aperf, cpudata-
> >cur.tsc,
> > +                           cpudata->cpu, (value !=3D prev), fast_switc=
h);
>
> How about using struct amd_aperf_mperf pointer as one input:
>
> trace_amd_pstate_perf(min_perf, des_perf, max_perf, &cpudata->cur, ...);
>
> You can refer the members of struct amd_aperf_mperf in the
> amd-pstate-trace.h:
>
>       __entry->mperf =3D cur->mperf;
>       __entry->aperf =3D cur->aperf;
>       __entry->tsc =3D cur->tsc;
>

I prefer the former way. We'd better to split the definition of struct "amd=
_cpudata" into head file and include it in the trace file with your change.=
 Will do that in the future if needed.

> Thanks,
> Ray
