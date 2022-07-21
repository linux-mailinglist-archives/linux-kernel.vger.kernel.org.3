Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2E857C74D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 11:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbiGUJPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 05:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbiGUJPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:15:35 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879572BB0D;
        Thu, 21 Jul 2022 02:15:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUEtxnr/J+XNuMRDFuPknR7h+SUaSvCkfIjYs+lwdfSPPKsvSxR1I3uRZuLhAQZEtNmy3GYqePmy8ExivVI/2/ftCnRzW3fnv0jyBlSGpIAJmn8HKMLbfN5z4YKEge9wkMjLKjsRPgidl2HjfjWtZjWxDek5j8uKm4erwMEOeoBLMCFM5+t/l0NY07ZXSRyHtVX9ftPzYbw1noW0aIe2dgNHW4Hk3JX0r+HjzoQQaAgHOl6qGiIvtDN08fl3Tmqs1KwCilsCG9kEOP19Bm/c/X+VCGjBGPdZuynV8ewUeSkAttKS+RAh3Z9T6wsbCZ7dv22kWEqdF7Zd05pBghbPLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGM2rYGM6AOkfgczEwteq+PvgGtjfQIR/Xw1jagO1xk=;
 b=d4wTUcIjkiV97dhw3HGRP2nebBXqSRpUFxUNUXqU3oEVdkHS2xaXubgYfuXPGcC1C2hjEwGArSC8xZBMrDcby/Wn3SQIxq7Q5wqGKbBR+wMdCUYHs8nCGizrNgIYHEguCoRR6C5G29/egpkdAgi5l6Unr4rlL9QQBglvk6jgji6Z/Kl2G8NfFCucSQJ9qWExkDoKGaXR/C/QC9EaU0kALF98fbDunJpz+HmsH6gXBhk61D5GgYpNV2Pbta/vPKEr3YDeZN1F3sywCrgfH2k3Qd6NuyJ+LIqeXrIfa50v0VXI0JqdLBWuj0T8aFnYPPqkghTYlw67sF7ILZFe7tzStA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGM2rYGM6AOkfgczEwteq+PvgGtjfQIR/Xw1jagO1xk=;
 b=uToXsiAfIxeOGFOG2a9CelQtsbGL3lkJFcFxq+7pdIAKhaopsFyLipkbHj0br3OnhusgMlx23VSd16c++ivbgdtPW8CcOqD7RWhsPY9jwC6fwYC9CwOoxGILQbSz6/peo4NwLDoz8rCNcOFJ+J2qp4ZRtcs29H2JAM8rGHxBhuA=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by DM5PR12MB2551.namprd12.prod.outlook.com (2603:10b6:4:b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Thu, 21 Jul
 2022 09:15:29 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::bd3b:532c:bc96:c60a]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::bd3b:532c:bc96:c60a%9]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 09:15:29 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Huang, Ray" <Ray.Huang@amd.com>
CC:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
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
Subject: RE: [PATCH v4 02/13] cpufreq: amd-pstate: enable AMD Precision Boost
 mode switch
Thread-Topic: [PATCH v4 02/13] cpufreq: amd-pstate: enable AMD Precision Boost
 mode switch
Thread-Index: AQHYmDJW/S+tkgXJIU2NUQanxupnxq2E4VwAgAOyAZA=
Date:   Thu, 21 Jul 2022 09:15:29 +0000
Message-ID: <DM4PR12MB5278690EC137B90714DE7C079C919@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <cover.1657876961.git.Perry.Yuan@amd.com>
 <b3db7981e407d5f111eeb27a8504a4ed7979ba60.1657876961.git.Perry.Yuan@amd.com>
 <YtX+uF/nAIG0ykHN@amd.com>
In-Reply-To: <YtX+uF/nAIG0ykHN@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-21T09:15:24Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0c10f73a-c184-460b-934e-1f7c4460bea5;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-07-21T09:15:24Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: b4f6f03f-0e70-4c39-9c31-650aeab597b8
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 027e7298-772b-46d5-bcf0-08da6af98e5e
x-ms-traffictypediagnostic: DM5PR12MB2551:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sbco1Run5ymdqotU3OWlc1bjqYSY0LH6fPy3XYSKVTuMzhX/hQQ0rkEH5omwDf7cBgi7OkmKtZ+MLQBGSlmQuLEHA4V8oPZM6+O683Em9gwef2L5o9vyO607iL/g16OMqM6RD68cYqf/pB+KVANxtgmVo3ami2MRQqwFSrEZbZMcNQmJh3S0OCr45drya3PvePSlYbyHuYY3UUZTRyc3Bl+kFfGTfmid9B5JylKZ/lEu1r6yacIVmCucluNT8d28ezLqI79X6zwu9KQKdjaFIsPI0X81FGQPPVUeHP0yO39pS5ltJLjBSost0q6BBcN2OaztM3Lo3SS/zCMzUg2lnzBYO/v9zvvDDj1UACPN5Nlg5+uXjoihwXiJtdJMFKaQjVJW29uRtl5ri9DRrw9z4iRbUc20dxv+76bvE9WXbcq0AXYUutkrPrQOLfjMeRbgEhYs1qIlZWlLaXKWvo6yWnq0tCDCtysPxZ+ZCXAin/wBqCSuppMDMuiNvUnHedHTUQyLAVFzaRJtwfFkOKvYyAnMqes1Ilxc6mcoLYTS3Uc98/dRPBrs/e72wgq/yjxUlpmoTm3QIaf6lozaoHt5D80WnwKNBLCfueGO+hSvsuBrbkBhg5Dsjgwd0ZCs8qHI/QNZ35ZIxjxLkuJnymvCG1Lqq9Y8Liis4EouR3QHUe5ZchHQnHrm5BHWaD/JPtkd7ExQd8Epihyf82tP3QRlQTv+2WZJF8OQ2WAnbCEmSyGlppukpQPOcB+T6f7U8oe6a7Ujw1iQnF/daQHpHIGbBS+8VnKfjS1OHv3ZQRs15bL6gcjnA0kMTtx33Wcio+QsBB/l/lteiM3JZWX5QcsKkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(52536014)(8936002)(6862004)(66476007)(4326008)(76116006)(55016003)(38100700002)(66556008)(8676002)(186003)(66946007)(5660300002)(2906002)(122000001)(64756008)(6506007)(71200400001)(38070700005)(33656002)(86362001)(966005)(478600001)(66446008)(54906003)(6636002)(41300700001)(83380400001)(316002)(9686003)(53546011)(7696005)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ItOZpRxvVr7OGipqutZqVMzS5p05IFXzbCB3nS36vw63hl8BiFkQ0dGzDd5b?=
 =?us-ascii?Q?dcdXzemtnH43oTUNV0acTbY/2EhOK+I20e/ekem2odik8Y94YbZUMBIpCO1M?=
 =?us-ascii?Q?6B7/UOGs1i4O2SxcUhkz20snSnGoRk5sEfemVXLT7Pjy9fJWno2eaVbaAScd?=
 =?us-ascii?Q?Yjtl6CE1enpyTSH3hxemFVdBRnTBK6jhIoVnfg8fQcX665RX5i7xJ/HJ7lsA?=
 =?us-ascii?Q?MC5Wzo0NXRERESBq2fd83JFdptn22i9/9py84w75tfJs3hx/jVGA9YCQCGOU?=
 =?us-ascii?Q?UHImm/8KqLjUNEKaSIzlVCYaDSp8Aah3D8N8MtFl8h5XP0+eOi9cQzz2J2az?=
 =?us-ascii?Q?CHKgGtlTwbcby4EYe56ihJppdat9xXWnoI5NgX4T/xceuKpIkwvr7UmnI8Zo?=
 =?us-ascii?Q?dvGZUxdFHvqU4ywfdhqtxCMigtllU1xupfil/LWaS29UxXPO+Tbrqwq49RT5?=
 =?us-ascii?Q?S3ct872sjdDFJyCWZDpwJFk9LvQlhbxR9zQ5AzwoM85eZe+oPyFxvwxsoWVR?=
 =?us-ascii?Q?ohGUe1aS1YnmUwJKfDT0blwg8XHU+As82a4gzSehsMuGmBzvkL8Rq2cup/gk?=
 =?us-ascii?Q?PhnEEsfzXq+AEoTZHVy4PukzWIrBKT5M4SElwRr+rZtQL7cDdLQ1mywcOjkr?=
 =?us-ascii?Q?Tklq7fevQUrAemfagMmRyywNe5DIU85YYD96wyjvOgylZ2sF380QyhYshMlz?=
 =?us-ascii?Q?4RHcizf505hLVCtyfOjLxDYwYUZdr/dMUYTjCT3CwDSVFHHQ2+sClGQ2f21N?=
 =?us-ascii?Q?BXjzAi3XI2Uy+Y1BcK4ZO87cEQaEdjpATmIQGmJPGtq8941/2C2pq4jZADzH?=
 =?us-ascii?Q?DWUGmeDy/TKezHoW7s/q5zwokSkR14SKfJdQWfWM5X0dqknplMD75JVE+c2Q?=
 =?us-ascii?Q?sShukuhB0MhW+j9EdfGjxuNif3eBFYEbMNgKsnSsULKvF+neqvtiiWSTUIMc?=
 =?us-ascii?Q?p7ZQ4isUexCl/E6pTS+svlCHsvrJAMxkku7FaLSJqOtNCd7487tqxipQMZTE?=
 =?us-ascii?Q?z4gLyY3HgxyfBWZyJ4ZOtSrk9u+JaLpv3n/EQcwObWMUskJ1adBeqDzfh7KV?=
 =?us-ascii?Q?R+UZczlNiPJzZ1Lqw4h1Cjdnq432ncr9JCWo3/cRVQGICL0uiv/A+5nWxHIL?=
 =?us-ascii?Q?8XMweG2Mo84JoNBqTB4Nb6oeQwdvaQJSTNYbkyrCyurIkfGAojW86j+aHo5A?=
 =?us-ascii?Q?dK4NmwANR2TGmL+GzW6SoH14nqmewaxlzArIjwQyHZoDoOp/CPuerLz5awnP?=
 =?us-ascii?Q?+d2CBWoUDnllnbkX56FZWg49coY51/ME8HXKam1vWe1Sx5ofAs47tnr0Gz4c?=
 =?us-ascii?Q?2j56qUx72A1+c2PYL3ZdPB04M80NeZQ109GzN594091CF9gzTZulv8PFjbFi?=
 =?us-ascii?Q?m155mZe1k+mOkmm9n+wZXG6NxEw6JoeFnnh3Hrh3sZisybIihJcSdWGfNNni?=
 =?us-ascii?Q?UYjCAnByQa7vGynRNc0FTHWtOluotvJ2vh/1NhSByg/Idy/iqEfMqlcStG0F?=
 =?us-ascii?Q?r8ohW29irBsNTd5/yNzQURyeaFUiDJY0fFMb9WIDlcHDgYdIYurbPyxie4uX?=
 =?us-ascii?Q?9vD73GB/QccO/OkPQO152hbrt7rvdXLMEpVjDUkW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 027e7298-772b-46d5-bcf0-08da6af98e5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 09:15:29.4008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B4TNGwmSCPyLKuWe5QMYEGQzHzu8uIjpssL02TD4Qt7eklTlBsmt1jT5pkDDAy0nzlTTETdEQxOTDP/SusebpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2551
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

Hi Ray.=20

> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Tuesday, July 19, 2022 8:46 AM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; viresh.kumar@linaro.org; Sharma, Deepak
> <Deepak.Sharma@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Su, Jinzhou (Joe) <Jinzhou.Su@amd.com>;
> Huang, Shimmer <Shimmer.Huang@amd.com>; Du, Xiaojian
> <Xiaojian.Du@amd.com>; Meng, Li (Jassmine) <Li.Meng@amd.com>; linux-
> pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v4 02/13] cpufreq: amd-pstate: enable AMD Precision B=
oost
> mode switch
>=20
> On Fri, Jul 15, 2022 at 06:04:21PM +0800, Yuan, Perry wrote:
> > Add support to switch AMD precision boost state to scale cpu max
> > frequency that will help to improve the processor throughput.
> >
> > when set boost state to be enabled, user will need to execute below
> > commands, the CPU will reach absolute maximum performance level or the
> > highest perf which CPU physical support. This performance level may
> > not be sustainable for long durations, it will help to improve the IO w=
orkload
> tasks.
> >
> > * turn on CPU boost state under root
> >   echo 1 > /sys/devices/system/cpu/cpufreq/boost
> >
> > If user set boost off,the CPU can reach to the maximum sustained
> > performance level of the process, that level is the process can
> > maintain continously working and definitely it can save some power
> > compared to boost on mode.
> >
> > * turn off CPU boost state under root
> >   echo 0 > /sys/devices/system/cpu/cpufreq/boost
> >
> > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > ---
> >  arch/x86/include/asm/msr-index.h |  2 ++
> >  drivers/cpufreq/amd-pstate.c     | 22 +++++++++++++++++++---
> >  2 files changed, 21 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/msr-index.h
> > b/arch/x86/include/asm/msr-index.h
> > index 869508de8269..b952fd6d6916 100644
> > --- a/arch/x86/include/asm/msr-index.h
> > +++ b/arch/x86/include/asm/msr-index.h
> > @@ -559,6 +559,8 @@
> >  #define AMD_CPPC_MIN_PERF(x)		(((x) & 0xff) << 8)
> >  #define AMD_CPPC_DES_PERF(x)		(((x) & 0xff) << 16)
> >  #define AMD_CPPC_ENERGY_PERF_PREF(x)	(((x) & 0xff) << 24)
> > +#define AMD_CPPC_PRECISION_BOOST_BIT	25
> > +#define AMD_CPPC_PRECISION_BOOST_ENABLED
> 	BIT_ULL(AMD_CPPC_PRECISION_BOOST_BIT)
>=20
> The bit 25 (CpbDis) of MSRC001_0015 [Hardware Configuration] indicates th=
e
> core performance boost disable flag.
>=20
> Please see the section 17.2 Core Performance Boost of PPR:
>=20
> https://www.amd.com/system/files/TechDocs/40332.pdf
>=20
> Core performance boost (CPB) dynamically monitors processor activity to c=
reate
> an estimate of power consumption. If the estimated processor consumption =
is
> below an internally defined power limit and software has requested P0 on =
a
> given core, hardware may transition the core to a frequency and voltage b=
eyond
> those defined for P0. If the estimated power consumption exceeds the defi=
ned
> power limit, some or all cores are limited to the frequency and voltage d=
efined
> by P0.
>=20
> The boost state is designed for legacy ACPI P-State function which is to =
request
> higher frequency beyond P0 State (it's equal to nominal frequency in CPPC=
), and
> we already have the operation like MSR_K7_HWCR_CPB_DIS in acpi-cpufreq
> driver. However, in CPPC, we can modify the performance hint beyond the
> nominal perf to reach the goal. That won't need this control anymore. And
> furthermore, this function for legacy ACPI P-State should not be mixed th=
em up
> with CPPC policy. We should prevent the effect for this flag in CPPC.
>=20
> Thanks,
> Ray

I did not notice that acpi_cpufreq already use this bit to control performa=
nce boost.
Seems like the patch is not needed for CPPC like you said.
I will drop the patch in V5 and use target perf to get target perf to firmw=
are.=20
That will also do the same thing to limit the perf level and power consumpt=
ion.

Thanks for your feedback. Will send V5 soon.

Perry .

>=20
> >
> >  /* AMD Performance Counter Global Status and Control MSRs */
> >  #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS	0xc0000300
> > diff --git a/drivers/cpufreq/amd-pstate.c
> > b/drivers/cpufreq/amd-pstate.c index 9ac75c1cde9c..188e055e24a2 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -122,6 +122,7 @@ struct amd_cpudata {
> >
> >  	u64 freq;
> >  	bool	boost_supported;
> > +	u64 	cppc_hw_conf_cached;
> >  };
> >
> >  static inline int pstate_enable(bool enable) @@ -438,18 +439,27 @@
> > static int amd_pstate_set_boost(struct cpufreq_policy *policy, int
> > state)  {
> >  	struct amd_cpudata *cpudata =3D policy->driver_data;
> >  	int ret;
> > +	u64 value;
> >
> >  	if (!cpudata->boost_supported) {
> >  		pr_err("Boost mode is not supported by this processor or
> SBIOS\n");
> >  		return -EINVAL;
> >  	}
> >
> > -	if (state)
> > +	ret =3D rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_HW_CTL, &value);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (state) {
> > +		value |=3D AMD_CPPC_PRECISION_BOOST_ENABLED;
> >  		policy->cpuinfo.max_freq =3D cpudata->max_freq;
> > -	else
> > +	} else {
> > +		value &=3D ~AMD_CPPC_PRECISION_BOOST_ENABLED;
> >  		policy->cpuinfo.max_freq =3D cpudata->nominal_freq;
> > -
> > +	}
> >  	policy->max =3D policy->cpuinfo.max_freq;
> > +	WRITE_ONCE(cpudata->cppc_hw_conf_cached, value);
> > +	wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_HW_CTL, value);
> >
> >  	ret =3D freq_qos_update_request(&cpudata->req[1],
> >  				      policy->cpuinfo.max_freq);
> > @@ -478,6 +488,7 @@ static int amd_pstate_cpu_init(struct cpufreq_polic=
y
> *policy)
> >  	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> >  	struct device *dev;
> >  	struct amd_cpudata *cpudata;
> > +	u64 value;
> >
> >  	dev =3D get_cpu_device(policy->cpu);
> >  	if (!dev)
> > @@ -542,6 +553,11 @@ static int amd_pstate_cpu_init(struct
> > cpufreq_policy *policy)
> >
> >  	policy->driver_data =3D cpudata;
> >
> > +	ret =3D rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_HW_CTL, &value);
> > +	if (ret)
> > +		return ret;
> > +	WRITE_ONCE(cpudata->cppc_hw_conf_cached, value);
> > +
> >  	amd_pstate_boost_init(cpudata);
> >
> >  	return 0;
> > --
> > 2.32.0
> >
