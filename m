Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DDA5955A7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiHPI4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbiHPIzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:55:00 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9904C7B285;
        Tue, 16 Aug 2022 00:02:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVnTxdWIsrd1YgzgFRo5exmFeF7dmfIzbDetplxi+EvJzETGCMSul3cZeWUbFJ0cu6lK7s4yZTfZRAw68gjYsHIRd/99/ArKtQLoScU98VeozCo5scC7FKGCpNEApYT9NEWJ9cCrcPJrOnMPurrtdr7vnjymQRMXCgAqO+1K3MKMtXZVXd4MLpizvC0Gqd8iATe10/j/Kx8IbTNH1NNi7Era7GwX8vbADY6N4cH1ozPuCD7lqZVtkGpaq0RLO1s8LbYfZOllMn4y3TvgzvWavxowgmaLN7n81JCj50Y8JDjFj7hBL1bSTGMbll5/tjNbl4JXMDgTm8ZdT2ztghltRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMgOXYYTq0T/n1fKZRRo5pRSD2oyI4zmIobkaiszyLg=;
 b=IoAcsdMDn3x3mApGid75Ot2AP1i1xRXBwXtaLCUQQ77T4a8K9Revi5358QhXw/VMI2Q5WySakaKHmQVeriLFIOtnP9K9/wStHtzEs2Az7Nbk1XUjhy6iLNV4a556dVwlCuJW3EwzXa11/iaaMBkW1GzNfYY3uHn3t4yBmuZxwS3+lobJLyiv38Tyj7OYN8V9qLAmXf23+6lLI5XZC8Tx/1GBsEJTAiG32T4a6X99X08+YuxvmaYRmBOxq95MqW68szgyW8Au0Kvq2ITDDv981UCwCGzcLe9fg5u6uyZUUefmLyJJPKEbOHPcVRz9AfglJn8Rk3NIyQvzxBqQuTQBNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMgOXYYTq0T/n1fKZRRo5pRSD2oyI4zmIobkaiszyLg=;
 b=nlc1uLUCjdD8jcWaPyUaKFft0gJf/rKN7D4np7UrVAQ64LqtMHKzbF2V816gAUH7BsuQYN+aGtGHwwVJsKQJaRx/lv9rKTQA5bC5r/Pq9qZzrbX1dik4Ld2EOZIjenWv6vOPQao11UUXkacv6XWN3+ks+jP2TOHmWN1zdt41p/4=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 16 Aug
 2022 07:02:27 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::a970:8eb0:b1f7:5e7c]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::a970:8eb0:b1f7:5e7c%9]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 07:02:27 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     Punit Agrawal <punit.agrawal@bytedance.com>
CC:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 6/7] cpufreq: amd-pstate: update pstate frequency
 transition delay time
Thread-Topic: [PATCH v5 6/7] cpufreq: amd-pstate: update pstate frequency
 transition delay time
Thread-Index: AQHYr/yGLKquZOGw9EeBZWlzer/+7K2wEQ0OgAEKFgA=
Date:   Tue, 16 Aug 2022 07:02:27 +0000
Message-ID: <DM4PR12MB5278E6B6EC656747AE67BFAF9C6B9@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20220814163548.326686-1-Perry.Yuan@amd.com>
        <20220814163548.326686-7-Perry.Yuan@amd.com> <87bkslim2c.fsf@stealth>
In-Reply-To: <87bkslim2c.fsf@stealth>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-16T07:02:24Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9f80329e-344f-4dd0-9115-92a29d8db499;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-08-16T07:02:24Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 4394b8e9-145c-4268-84b1-eb424c9b3795
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3bbf838-1f87-4e00-1bd1-08da7f55473f
x-ms-traffictypediagnostic: CH0PR12MB5348:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kYeqdsab92qVZVk+ZTIOUW8nT+Q2Bmn+kkmJlSsKoqD0b6K/4Na8vOzcv4X6qHDOyEd2H+qnN+945Yi8VDqKcXlIzlYBf6m0BD8mPBByufZMydrXESYmgioEaaKPg98a0KIW/IrFxZ2f48x1EinBwDcilULZCtijfXUcu9s8SuyfMmxAnAgEDlrhNshY+tMikD5NOx4EF9I0Pg2IJfXyu4ZmcEaYJRQnM5BWqTEEwC2SfiZNvuhRjqx8qriv1f0flZHcKOEELzGetabjB80RWIoybzJHMFZEtf3z6bWYrT6KC+jOcGhKcv1baT/SbdYkLJaTzVo1WkVXcUk1uNPF3FPSq7xMKfFzIGmSLbtJo3dNu0x7TkcwUsluGnPR3JW9NUbCfBRcd1d7pa5HXYBzgEI9VU3fFK5hQKvQ/LeW0pqboOh1019RpSe8cCfnLuFyXmxZLfWplj0jrzksc+Co+Oetf07JOfa6SCz2vH6URf1ytP5c40/a+yM0JzjRAHRZIz5hQO98bhbe5PAojQafAznadTbjDco0l3rkuWtxGqS03/RmS1dpHHZkip6j3+uyUdMHypVOM6GnlqNqZ+HruWz39sUYRjaptyQe3LygqiOpAfhFqLJLiiz2artzmz5MHT7WLKzg7wTOmY5iDNM9zAkZkRY4e7tphCv/rS2zKUO/JrLNJmy6eH1lYKQdODZDVywoG9egWGBhVL2zBKXLkXJJd0sr8MgVZjToBU4C2Ad4pvR5jMa964lLsX6T5OmJpMcon3kueBO4HVx3pdEQS78R/WvY45rBhAkfztu6qiTRL3r8+u7uaPi0ztZ5e8nV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(4326008)(8676002)(53546011)(9686003)(66446008)(478600001)(7696005)(26005)(71200400001)(38100700002)(41300700001)(122000001)(83380400001)(86362001)(186003)(2906002)(38070700005)(15650500001)(8936002)(52536014)(6506007)(66946007)(5660300002)(55016003)(316002)(6916009)(54906003)(33656002)(76116006)(66476007)(66556008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9w+cIxEFIYhvdAsoJhvxWRZb6M/UsNBWs8eTd/NEtcJcaaMvPqoJFXZniZCt?=
 =?us-ascii?Q?fn6ld9Rnzp1aIkz5qIKLhYMZQS5RFpb+gmzcTNlweYDYk76Ap3FWsvR0k5qH?=
 =?us-ascii?Q?5tKjH9NNT7l6nkU0oudHoXLcQEcC9oZZT16n9E+nz5GDl38tVDux+mKXtrWV?=
 =?us-ascii?Q?TzPtwqoLC5w2GswieTLT8IakOjjb55ibpJAGzom6WQzPttJI9C2Y7ZqbjhwU?=
 =?us-ascii?Q?L7UQJMYJs6EMGdGNTGbLCIopBXOjB67B5BaZ7NE8OCKdSk1AJ4VzMx6SXeIv?=
 =?us-ascii?Q?X63W4f/SFlDld+qm9dcZI0UIg6gc1ZNbQyX7px/CTEvhAsdZ5llpc3yemq6R?=
 =?us-ascii?Q?VpK5IJzx7v41b0Kv+LYlf9p+S1TdbTyToNrgCiA1JtsK3dc0T+6zvR3IoXR/?=
 =?us-ascii?Q?qE+34xtgeCUef287hs6r5oRplN0IdX4LQuC2hdtRtiyPNJleGOgxB/gjJIz1?=
 =?us-ascii?Q?Iva4eGeaeXERt2mn6DJtR7ay84k+X7bBaHyZEkeJ5EpsGhNsgbmZwEcQGCMz?=
 =?us-ascii?Q?aQbuyblNB5rqlYsX/JNjfC6fLPfwo6kzxl+HMhZPAJOLCsHYKtTaGiVDOcL1?=
 =?us-ascii?Q?V1OZWwDBuQjKN79TeOjqRrj3K7Rh+n4e/nn/a1shOeeVRcZFMhNPr2hqO+it?=
 =?us-ascii?Q?jb+L0u8DsDqFWP10Xh6TzP+XfYAMFFh14vFn52pCnBMbon6vXOGZjUk5lzfq?=
 =?us-ascii?Q?ym1UpbGbXL6RMvVriiYdcryKTgoQyPzUDlQzv5WtAB/o/sGPB+TLq9/wB84y?=
 =?us-ascii?Q?VlXocrwwLiXMyT2FnxobDTjNnhxqJ3G4zgHUKR/WLFje1XuSTpGKyv8JRn0y?=
 =?us-ascii?Q?C/Bji/uw5XJiedLKaDCV1A6G4Z+4xTguT6JZAGq5ohcC/wQMYPTIgqqXontk?=
 =?us-ascii?Q?+xFE3+4PKCwvdQg/VweNKJcNwRE2jNZt+znpSuxKXhCIej8Q1ixBc6CB7M+v?=
 =?us-ascii?Q?tzbDN4X3V+9gwFvnWjPKOwJPLiRZDL3jZFiKTE1aiBn7Sy2ZKuLU4zzT8Jvu?=
 =?us-ascii?Q?ep4OUZHJVKR/jZZM7rP65xR5zTqj+cgyx0I3wm4xchZJiAX3nODTMD8o2S6x?=
 =?us-ascii?Q?naGDpir/u0ZZKUUY49BvXWtXcXMh5ZWw2QV2jnwZteKbxXOlf1R1SX2T4k63?=
 =?us-ascii?Q?YWmPvNBQ3SM8ljUokVA/eP6Wg4srKMFIpd9AWNyIfHeq7XwLMMgjluQMe77W?=
 =?us-ascii?Q?dQhofB/16w8qsUuyCLIW9AAqgYJ3ujOY8gEI++LVTfKT59xENSJ6Bq+lPa48?=
 =?us-ascii?Q?a0XXaW7KYOl9inTMKZSyljQBfuXvqLtY360MBVGTNKYoeISqT1h6yiJt93lO?=
 =?us-ascii?Q?lmRC031/nWAWZF3rvshfAtfFJYZwIae2aMSiHFFCTrEhG3PfPuq/2pjutXEA?=
 =?us-ascii?Q?zqZXCtYXqLMMvieikMiSmSUcMW6pYhPokPHfp+a50gh1shSTKh6STR3H6JMs?=
 =?us-ascii?Q?94HYG6n0W9ZT1BcQz1uXfAzoU0s2YEI7pTjWg0KWaDpZfZAnUr+s45C0H7Lt?=
 =?us-ascii?Q?coI8i4m73MbFG8WbuWdZIZir7CV+ggZXIsG9+rwkHnrSeKK9OCwb78K+CP4z?=
 =?us-ascii?Q?Y0nfnHgXx3XSDV/F8QxoLvI4Bsa4Q24FHURAJqKE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3bbf838-1f87-4e00-1bd1-08da7f55473f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 07:02:27.0456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 26SwK2QMTKBIg57vSMjTKQuK6jSbPA/k/26VNBDgJEAYrXa60mdUEmrxlpbshOKXZs0AA1RujSZMdrgmhtU9Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5348
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

Hi Punit

> -----Original Message-----
> From: Punit Agrawal <punit.agrawal@bytedance.com>
> Sent: Monday, August 15, 2022 11:06 PM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; Huang, Ray <Ray.Huang@amd.com>;
> viresh.kumar@linaro.org; Sharma, Deepak <Deepak.Sharma@amd.com>;
> Limonciello, Mario <Mario.Limonciello@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Su, Jinzhou (Joe) <Jinzhou.Su@amd.com>;
> Huang, Shimmer <Shimmer.Huang@amd.com>; Du, Xiaojian
> <Xiaojian.Du@amd.com>; Meng, Li (Jassmine) <Li.Meng@amd.com>; linux-
> pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v5 6/7] cpufreq: amd-pstate: update pstate frequency
> transition delay time
>=20
> [CAUTION: External Email]
>=20
> Perry Yuan <Perry.Yuan@amd.com> writes:
>=20
> > Change the default transition latency to be 20ms that is more
> > reasonable transition delay for AMD processors in non-EPP driver mode.
> >
> > Update transition delay time to 1ms, in the AMD CPU autonomous mode
> > and non-autonomous mode, CPPC firmware will decide frequency at 1ms
> > timescale based on the workload utilization.
> >
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c
> > b/drivers/cpufreq/amd-pstate.c index e40177d14310..9cb051d61422 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -41,8 +41,8 @@
> >  #include <asm/msr.h>
> >  #include "amd-pstate-trace.h"
> >
> > -#define AMD_PSTATE_TRANSITION_LATENCY        0x20000
> > -#define AMD_PSTATE_TRANSITION_DELAY  500
> > +#define AMD_PSTATE_TRANSITION_LATENCY        20000
> > +#define AMD_PSTATE_TRANSITION_DELAY  1000
>=20
> How were these values derived? If from documentation, it'll be good to ad=
d a
> link to the relevant documentation. And if they were derived from testing=
,
> please mention this in the commit log (along with some details of the tes=
ts used
> to determine the value).

The values are calculated from the CPU PM firmware and hardware design.
There are some latency and delay values defined  in the PM firmware, I have=
 no documents about the detail for now.=20

Perry.
>=20
> >
> >  /*
> >   * TODO: We need more time to fine tune processors with shared memory
> > solution
