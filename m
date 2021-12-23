Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB9447DDAD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 03:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345791AbhLWCWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 21:22:33 -0500
Received: from mail-bn8nam11on2059.outbound.protection.outlook.com ([40.107.236.59]:6400
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229788AbhLWCWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 21:22:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FofPb83btGyxrlAuj1iUkg0ecPSPDliozm2ZydeGAvOdZXM/g8G8xBa69OjOuko/xBtFEsXj4xz8FCdBSL2PjOJryM3z/bsVmntITxhr+IsUtO1tiI2sKfZmGjowyyvMH1awerdBKdtr2aOiVgzPWDfzoTDUKyVXrPUvsRCOdNbcmqy1DJ1MphS2bu3lCWO+aNP+pYAEYPvcWQ67TWMabNXF0HEoVz4yXy6zvnPhibVKfsbFHYPfdjILrbyHcKaySMrsWnYiHh2OWurKtwAC/2AhS3s4cAYltxUpAt6OZj0YifGrCqATPJS8Gk7fpj55nETPgIIDzf3uCuADEbPgwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKMd/PDv32DPgT822AQuROSZc1yBFeubRrXXhe6dt3A=;
 b=Pe9taEY1CpR1akGVQNEYIUhd/m1F5PmsxDThP9nKsjSDMWohYWe412/3gaViDu8E2UOihEkBoNJBotE9g7oSeVLaG/cOjKr9ko1A/V8zVmu2yOCW0yR03Pu5ODpyvGl8DzH/0bDj6eQLoKxNgWcfxhqM4CoUCjYo4Y+Z6uibyoIjn7P/sAB8iHN6wdkMwK3OR4FlQzikD7TYp79pCiTm6ML9mDIpofvkkCp4N/N1/SQYAJSORuCEJr/+6OUztP3o595aRsDHqUhxzVAa8kJ8b2VUVJAS7X2QZnA7uv/UDg8pQuhA4NUp90fBfmazH8giLBhqOg9EPtya9Q+2gcyLKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKMd/PDv32DPgT822AQuROSZc1yBFeubRrXXhe6dt3A=;
 b=FjUPlKtF6TJ+xVxzBD3Hk1AiKLRuUyfcc+GN38OPOQ1g6TWi+CRWHFmRyVNenbb3QwQaS0VhpQs0HEIWHkK8wz/VDgiqh9mpx5WEkmoPRDuXCmNXOnifom7RQNEhsXoGqe7IT7kKoVvFg1Mb8rHg6BseBd4GIfH7bkRD//tPo0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM5PR12MB1161.namprd12.prod.outlook.com (2603:10b6:3:73::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.16; Thu, 23 Dec 2021 02:22:29 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::5d07:e475:316c:d187]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::5d07:e475:316c:d187%5]) with mapi id 15.20.4801.024; Thu, 23 Dec 2021
 02:22:29 +0000
Date:   Thu, 23 Dec 2021 10:22:01 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Borislav Petkov <bp@suse.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 02/14] x86/msr: add AMD CPPC MSR definitions
Message-ID: <YcPdSRDBBclfKB1D@amd.com>
References: <20211219163528.1023186-1-ray.huang@amd.com>
 <20211219163528.1023186-3-ray.huang@amd.com>
 <YcH2hYJN9+NudhH4@zn.tnic>
 <YcJulhgWUj6kmQEw@amd.com>
 <CAJZ5v0gA+FNh9EQWm0urtzFLgvzuakGydmKXG1pqakqrmDg18w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gA+FNh9EQWm0urtzFLgvzuakGydmKXG1pqakqrmDg18w@mail.gmail.com>
X-ClientProxiedBy: HK2PR0401CA0020.apcprd04.prod.outlook.com
 (2603:1096:202:2::30) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a9f32e3-aed4-4c4b-4964-08d9c5bb1186
X-MS-TrafficTypeDiagnostic: DM5PR12MB1161:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB116135D2A08570F5E78B0494EC7E9@DM5PR12MB1161.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7QSP+nd/+8EkYs9C0blzFgZ9A4unMk9c63rSAHRpcIEFXy9xS+6IBY+OMnOacP6th4k7qp10G3TmpB8l6XByUAo9EhBgDFgWLheXNaGyBg9V7omXcMkHyd+BQjV4F3t7cRKLiD3ftYS4XC1KAFxQkx4zOML1BJQ935K0ZOnhbxv/XfwjViAVkjr/gWuRWVTgBGrKaL23ohG1aceH8t6SMk5f9TV7iF8BzAZTBFdQRKp8rJm1sMZmW3zH8kbqH7lj4+qXJWuSKCDEQllLOSTag8kARy6yBxSqGA6ZChQXm0oI4DZB6hwdMnmVtFYP82S+aZRl9qyrzA9oDA9u9jqYAof3nVMFkIAWaE8oe8If/Iyr8V3E0kHN9GwmsSUvnYYhUzHAkloP13VKkfdZ015FCIo4UZsElgP6iHURlb0p5mMax3yOW2OkE9XHtxMsw3mFTg9B+VKdrHoBdt4m1bEwwjOVJhbP6IgI8aBVuXU7ZIbwldiMSkthIx2stu6hkFKpEcq6g7Sod6gfaM6rLP0xy+2G5k5X3B9A+bE9AvusD1gZTI4B69ixkzWVrCMs1yygZP1DFROJ0FpfL7Wh3imLuHtt/I+2tEiGvmzF55xKkGo6yHUo7NM+rykfuLJbcRYV9GZBK/RM81zkfOkzCrMepw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(6512007)(2616005)(86362001)(36756003)(8676002)(4326008)(6666004)(6486002)(6916009)(186003)(6506007)(7416002)(38100700002)(2906002)(66946007)(66556008)(53546011)(8936002)(5660300002)(26005)(83380400001)(54906003)(66476007)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BIFG4XXVPgDJREQEHvv95irKs1r8+UhspJlvdD0jQG66Fb0YU1EPNgsAttL4?=
 =?us-ascii?Q?6jDovDU7MiKLiUmiVFCdYJploQxxqJLuBRXthLe+S9NpXAw2RFwjSZOhiwx4?=
 =?us-ascii?Q?tHhXgRRzJSx8S+pPyNjKVaGSKvGvR3nsNCcMnABNU80kRh9rnXfLAq2RlBXs?=
 =?us-ascii?Q?6Uy2iDHX4ft19xU8midyQDxu+w97dm9HGXJtD/Kfd7JPy2gbU9s2xyWk/Nv2?=
 =?us-ascii?Q?y9BS4WRz7M6zs0wN0dOa3qRewEd484iR/O5oDV7KHhhnX9YsBXFC84Wg0aQP?=
 =?us-ascii?Q?Ygu/o4Vu/cskOGatjphs/yT5CcLL4Ula3YPwZ80sTEA7WEXoV2i2BEyED1cb?=
 =?us-ascii?Q?8/S0pPEq2+A+XYttl1WnCiiDEZQBIfVYsQndphKWw84IGj7jD9Rf8yjjJoBj?=
 =?us-ascii?Q?NfPPXPM3fk242J45jYq8VVMoAMQXeEopEZ5AJeIwGr84IfgK7iV8ZLsI743S?=
 =?us-ascii?Q?kwCmX+Pj7eThMRw4I8F+sAsrjndW0C2UGkogOMj+4s1mij95agaRxO7eglt+?=
 =?us-ascii?Q?NNEtCEQXSEuLRzSFy2fcbTk3Nm/tLJM8201Qv6anCShCsvptHQT3+jM1pgzi?=
 =?us-ascii?Q?Z9r8D4y1DhdF6m7bajVcIR7NBFwMhRdVqXABtUAJc6yEkdDpUAJ8aSiBzcMQ?=
 =?us-ascii?Q?O9+kOa3xBrPRzqMNXDhgxkNeTDZAAZFfbel744qrG7I62ksugoSUQ6yReB2e?=
 =?us-ascii?Q?6gB58metqCMA46MUAnUsycvaymyiqnlnZA8gp7I0sf9unmUNEg2aIQNfDDR/?=
 =?us-ascii?Q?/D0xA54B3dFiXXzkumSGGGZyBoKcro7dELgPPZlDyGM/QQSz0nn8thiKpbET?=
 =?us-ascii?Q?x5kQgMPUCUUJcK9mNICxgjXjm0d+e4QqibndnzgA9Jz7s+qDRV9zy9iydhOo?=
 =?us-ascii?Q?FSDHLWLGUEw2NL/YmPJXPMKut4dCdwGusEhgWipLmydK7XfUT+Mm/6ifGPPf?=
 =?us-ascii?Q?33F4BJkMOv54+f391HxwvHnuAROa3l0KBCQ/fOrWCq90wDTDAQiNwNE7a+fT?=
 =?us-ascii?Q?cHfSIrdrEsYR9CgzLhCdebFsSS89lRDAvXac4hLw4rPZUSfvyAn4TcrYgMLq?=
 =?us-ascii?Q?bPABGZwLMUqsiYHdLX4Sijgpmj8ekMQKgGXizbejDS5QUWSDEtjCLGuXhoOe?=
 =?us-ascii?Q?rWv1egt6zjWLWUmIarVCkm7QIUo53w9G2OfHvR0w8i6pMWwYD+EjBC/FoBxb?=
 =?us-ascii?Q?02YHzOmXBFaNFGeotaiNje+O/rufi8p8LzT+8ZBv7q2rIZyh14jR6iDd748W?=
 =?us-ascii?Q?qUN8zvj8R/tlq34uruf9eY2rsNZsvpGpaEsdFFsPYXLkFW/TaQ2kEmrZ0HAg?=
 =?us-ascii?Q?xPmdp68MnNasg0m75PqJx+Pe0pr5NdgZmVKV21YGdqXf8Mdum1UqTUUPSj4h?=
 =?us-ascii?Q?sb/zyQLNMJutXhlokwYHr16xHeaYK4dkr8d3uY48rsHAzeFT4oM/wXCNVqYO?=
 =?us-ascii?Q?ryOKJy+/Oe48MO1cfCAFO66yoCMBYZYey1u3T4/5TpGy/492xRc5o+gW2F2u?=
 =?us-ascii?Q?AMr+rhs7bNkDkX/kb5PJ7t4dYZgkW9sbFjc/qTmdyOXd/f5uUaOlfW/WtmCn?=
 =?us-ascii?Q?dQG20VEtpMT9l1hsJ5bOg80G4s6QS/R+XsLr3Z4uoGH5aZZWgOztyfR5Xgzf?=
 =?us-ascii?Q?dKckU65kii8KkxD24w8cCms=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9f32e3-aed4-4c4b-4964-08d9c5bb1186
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 02:22:29.5861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9NnvR5aFDKqTFErEKhXjHhExpk8Sv+4ee3Tiy9pFs5nbWgWbVCvsAE5MpdnnWKCj6qKY3KhzLQPs8TOM8nXsPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1161
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 02:05:40AM +0800, Rafael J. Wysocki wrote:
> On Wed, Dec 22, 2021 at 1:17 AM Huang Rui <ray.huang@amd.com> wrote:
> >
> > Hi Boris,
> >
> > On Tue, Dec 21, 2021 at 11:45:09PM +0800, Borislav Petkov wrote:
> > > On Mon, Dec 20, 2021 at 12:35:16AM +0800, Huang Rui wrote:
> > >
> > > Capitalize subject's first letter:
> > >  [x86/msr: add AMD CPPC MSR definitions]
> > >  [x86/msr: Add AMD CPPC MSR definitions]
> >
> > Thank you for the reply! Updated.
> >
> > >
> > > > AMD CPPC (Collaborative Processor Performance Control) function uses MSR
> > > > registers to manage the performance hints. So add the MSR register macro
> > > > here.
> > > >
> > > > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > > > ---
> > > >  arch/x86/include/asm/msr-index.h | 17 +++++++++++++++++
> > > >  1 file changed, 17 insertions(+)
> > > >
> > > > diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> > > > index 01e2650b9585..e7945ef6a8df 100644
> > > > --- a/arch/x86/include/asm/msr-index.h
> > > > +++ b/arch/x86/include/asm/msr-index.h
> > > > @@ -486,6 +486,23 @@
> > > >
> > > >  #define MSR_AMD64_VIRT_SPEC_CTRL   0xc001011f
> > > >
> > > > +/* AMD Collaborative Processor Performance Control MSRs */
> > > > +#define MSR_AMD_CPPC_CAP1          0xc00102b0
> > > > +#define MSR_AMD_CPPC_ENABLE                0xc00102b1
> > > > +#define MSR_AMD_CPPC_CAP2          0xc00102b2
> > > > +#define MSR_AMD_CPPC_REQ           0xc00102b3
> > > > +#define MSR_AMD_CPPC_STATUS                0xc00102b4
> > > > +
> > > > +#define CAP1_LOWEST_PERF(x)        (((x) >> 0) & 0xff)
> > > > +#define CAP1_LOWNONLIN_PERF(x)     (((x) >> 8) & 0xff)
> > > > +#define CAP1_NOMINAL_PERF(x)       (((x) >> 16) & 0xff)
> > > > +#define CAP1_HIGHEST_PERF(x)       (((x) >> 24) & 0xff)
> > > > +
> > > > +#define REQ_MAX_PERF(x)            (((x) & 0xff) << 0)
> > > > +#define REQ_MIN_PERF(x)            (((x) & 0xff) << 8)
> > > > +#define REQ_DES_PERF(x)            (((x) & 0xff) << 16)
> > > > +#define REQ_ENERGY_PERF_PREF(x)    (((x) & 0xff) << 24)
> > >
> > > All those bitfield names are too generic - they should at least be
> > > prefixed with "CPPC_"
> > >
> > > If an Intel CPPC set of MSRs appears too, then the prefix should be
> > > "AMD_CPPC_" and so on.
> > >
> >
> > The similar function in Intel names HWP (Hardware P-State), and related MSR
> > registers names as "HWP_" as the prefixes like below:
> >
> > /* IA32_HWP_CAPABILITIES */
> > #define HWP_HIGHEST_PERF(x)             (((x) >> 0) & 0xff)
> > #define HWP_GUARANTEED_PERF(x)          (((x) >> 8) & 0xff)
> > #define HWP_MOSTEFFICIENT_PERF(x)       (((x) >> 16) & 0xff)
> > #define HWP_LOWEST_PERF(x)              (((x) >> 24) & 0xff)
> >
> > Hi Rafael,
> >
> > Can we use the "CPPC_" as the prefixes for AMD CPPC MSR bitfield name?
> 
> Well, what about using "AMD_CPPC_" instead of "REQ_" in these names?
> The names of the analogous Intel macros start with "HWP_" which
> basically stands for "INTEL_CPPC_".

Fine for me, updated it in V7.

Thanks,
Ray

