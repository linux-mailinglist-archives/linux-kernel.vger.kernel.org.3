Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B3147CA2D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 01:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238299AbhLVAR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 19:17:57 -0500
Received: from mail-bn8nam08on2052.outbound.protection.outlook.com ([40.107.100.52]:59905
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229555AbhLVAR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 19:17:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXXqYvaOl3f22BFBubx2/o6vkmS/mgio64neFc00UQzn6YsB7z5eKaNDteeOeEbxlLn6lVyvQh+z2thtuiwAUGJqRElPj7FOpfmHoNXMLb9xWjFSr+e3XORUnXKM5tFMNmHjSiStuvDwyZB5/PLvzmJou/uoXnmWvvAA6v1ame2OFfPFhl1RjeDvAJFSEDVvKHRToq6lkemR5WAtQiOIxE24WUoyKKQMcKgqzAR94g2T7b9ZCipopTqqH5+b3BvXJkO2G76nS7IhFqO8AEmp5kbZsEkjIyvCNc+5xM6RvIsaqzGXEQAMiHr4EW3X+0DeyaMVJ8l3yvGSGXCBx+Twfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HltBOsOsfDYpwcZACZNCJKyt5IeQQ1iYCayWPTGnCCw=;
 b=B/prDySEXON0DvjDOoMtvZyj4gT69H5HqeB4C2BKGkszmwFNwaRJ0PLbxEJwPWqgaym6dHExrg1lNs3xs5UbsokIQ4cnOsP5Bkn6MkGvaOSNd137PHjaoJ068Jmx/RsQcNdiZyEC4wHBmdxb8RPNYIIxhWX4UMr5BKTrE09RVkHxz8wa1WTY1lauYBP0SDQ98we1AG2EZJ9Ehx1J1qic0EFru0SFWnkL+jSFT6XatFA1JqlS8iVpwwppyBzh46YgNO+YTVzRMhujbTzezXNYkXh54X/FLrFdzc0DMeHkjX0QmpgEyna14IILaewAVI2MeKgmAYa7B1/579LJgGspMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HltBOsOsfDYpwcZACZNCJKyt5IeQQ1iYCayWPTGnCCw=;
 b=shzVpe8/P4SesODNgprN/hcFkB7AATxxYN1M4mFOU+lDzKFB3JBOEVanxc5X3b3tQ965J7dgQs+Ud1FaH8vdSpQpybk0VmPh4gcbhLQF93ILX/y9mhLK0P57olpP0m1bdOr6ZubDYvBoWMJiQmMf0NF+ASldVaPY9uGMOJnmQRs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.20; Wed, 22 Dec 2021 00:17:51 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::5d07:e475:316c:d187]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::5d07:e475:316c:d187%5]) with mapi id 15.20.4801.020; Wed, 22 Dec 2021
 00:17:51 +0000
Date:   Wed, 22 Dec 2021 08:17:26 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
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
Message-ID: <YcJulhgWUj6kmQEw@amd.com>
References: <20211219163528.1023186-1-ray.huang@amd.com>
 <20211219163528.1023186-3-ray.huang@amd.com>
 <YcH2hYJN9+NudhH4@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcH2hYJN9+NudhH4@zn.tnic>
X-ClientProxiedBy: HK2PR03CA0060.apcprd03.prod.outlook.com
 (2603:1096:202:17::30) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94f8bbf9-aa30-44ee-5d7a-08d9c4e07dce
X-MS-TrafficTypeDiagnostic: DM6PR12MB4124:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4124B1BE082FFDC51A8BED1EEC7D9@DM6PR12MB4124.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iijLCI2NAZb8Tlyk5BILnt4MRAvAr4y0bKuEyevur4sYWb9D3Bbe1HPoKK0x6FpKgVGWCnCaKvgtjopZc1uS4sJN/x6DQT0uMpgvZ3OinVkIoI6nCoxyJRLPppLAcjay1ND4u2dHpu0RLJzngam2vDHzRCB5hWX4AIrNGQP8rsWwTZjY8+l/LXjVG5tPVcR++v78myhSkYkTr9ltumztKqnupmFUXI6rb8Ed6NfEAAXvuaN+cAhDoR/HPXDJ8jRL9wmqAQ9qdQ1uQi0rnew8gA50c2jvUfcYaNP9w83ZX3sdY1SieBYgnlqJiecqQHIe/DHKFxqouM+96+uE48n5SVcDuh0Ab1emHx1TcsOLSEleyjplPjBFsTsCjaR/IfEMU+KyW2DuKfrXLXQalXn8pjw8GqlLyOMl32Ms0h6jp/UM/is9ZSAV+4skkukzJIdf8J0gbXc6/WfjuSdegOyeXB1eVCxklSN7FW7nraXxoh/IJWHmImJm+T8/JdQtabQOqvWhUSp0Nv4OBPReEmVqWjXLhegn8Byn4oV2+Ed0Jjtl9Y2apIHNbRgDIRvaAqyboGnW5Ux/vupnsjph5smvSyQrI/eKoWJYXrnlT4P2f/yoF6gqkm2eMj4VUJJp7XtW3n2+7dOdu9CdzIr65euQ5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(26005)(2616005)(66556008)(5660300002)(66476007)(6506007)(8936002)(7416002)(508600001)(86362001)(6486002)(316002)(38100700002)(66946007)(2906002)(6512007)(4326008)(6666004)(36756003)(186003)(54906003)(83380400001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?smJkjMWGfKUOB3XKhUAs9cs3GItPxeLfdYP/Bhvpn3UfTtZKwCOdlHC50+kQ?=
 =?us-ascii?Q?ijzIzGS81FfvVa7mSIMvZ8XjPYU0ft137sBnxG8HlYdcVuFdJy5u1GWch/PL?=
 =?us-ascii?Q?nWaoqGaf4VYSD2rNcPsiE8p69jmRtkPOVsagqN8iQ+NuVBGl19YOCC1c2r+M?=
 =?us-ascii?Q?hd6s7DsU1KTMmx6aGuFsfSwwhc4MU/9x2cMqASH5qUiviqm8ZSa501kMnHNn?=
 =?us-ascii?Q?GtTJN/79WcBNDvJFf25GO5lOvci9iX9bsBKS71j8px81V0NlB9OlTUDysZqU?=
 =?us-ascii?Q?0/oXvQa6EB8Bj1o1XZmS5Mni9skWAgsEZS6UkDdICGRYpNlbymFE6nwUDeHO?=
 =?us-ascii?Q?shPkWX6tiIr336KAptCUJhqLx5UtjyhjeQVmmPQ8lCADge3RJXaTuJZHkeHj?=
 =?us-ascii?Q?rwRZd6QL2meHPvBduQeRO3zmwOGccX6trccV2eDOD7ozfHSqI2s8CUbBFWTC?=
 =?us-ascii?Q?rQbxHWvEWFuw9puT36TRGR/EyRf4141knhijpLTY8q2mkn3hpFo56OvWh7DX?=
 =?us-ascii?Q?Ii1FTDbdPqQ8J8rG1nDEhcx4AIfsaS70GbxM3Z0pQsWNiRmnNXmsn2mnPM+k?=
 =?us-ascii?Q?iPdmLxaPHDc1su19HzpxL2xEBMuloi9KxYmEJnp9KXfO7BmQMJox9EiCKDEw?=
 =?us-ascii?Q?71r1z7qNET+UJWEU6p4+9nTWsStI83WwfUAHL47eD67OI/zu5pjmKAuhPDaY?=
 =?us-ascii?Q?gnPd6CQx5aeAocJc+lWVjTuzx+Ckj6UFf/nyxTCFMhDZtJfUN1GvDNyo6ECD?=
 =?us-ascii?Q?gR0qbr7dhdJcJkHNvRRFpXB4OiOhNyy5ZBHC2ipKNdNNrkrLDuiruHiUgoVr?=
 =?us-ascii?Q?8VdqjCXJgmqjsod+dOezsMk/nHHo1Wb38FI7TRpH9sJ6NpgYm7AYGTd8uhDZ?=
 =?us-ascii?Q?sqE1MXg20txaenuHsa7I5/L7TaMwANsB5kSWyu7AL3PnSmLjGtrVZcN5Mm1Z?=
 =?us-ascii?Q?1cL2xf+km0XPdCUZI3jKV2THguUcNZRHDKzZlM01xoRz79gJduELW3Tek9C0?=
 =?us-ascii?Q?53pWVIEQbeH47fJUAPIo/IK19BFBL+dqZe6imTJQLO10D47VV4hCQ6YwJcM6?=
 =?us-ascii?Q?uI/cS/5v64xRaRuIDxq58LIE2qkGMSZfcgwdb0wWEkNuMz5vfJohcObYnvtN?=
 =?us-ascii?Q?8o2uvRWmUv2w0cGQDJwTZ6jOq3H0pJ1+603tlATshrm0OHSAtnDxYqyW/XtE?=
 =?us-ascii?Q?c4mfp39aLBlrlLJPJwipd9efdOXujJrXrUoDIhsnAzth9P5RmVOccLmV5Zdb?=
 =?us-ascii?Q?pwPUmTv+f6M/thUBH/mREeqa5NHVeHV+MLtiZv7CjC0Yr/yCEJ3B9WJzCWcK?=
 =?us-ascii?Q?ZoComkn8bkSvWwQ356U+U299mKpQkQ7B6IkIS/LkcI+SGaSQYDEga08bq/13?=
 =?us-ascii?Q?BBYUMczqxJRx8FCzwGAQzyneddx5Vl5y2LAn89/mWry260Iy/ddyHEo0KHbx?=
 =?us-ascii?Q?W6nrXDVNV2/fa4J1ThqQyau7KolD20aJRO7OOeH7Qnnys21VnZHhPYWMGjpP?=
 =?us-ascii?Q?AgmXXI9w3PjTMzcK9vA3Zk5qjq1kjiB0PPZh8DaR5LDuBqLdOSyg3l1sA+mx?=
 =?us-ascii?Q?7wBLoZJfo0fA0RMB662oJoeEF/RbWLxCjfFCGNZG9pqSCvMbtHK1c2g8LRwM?=
 =?us-ascii?Q?yCxol3tkFSpBKprtE0KOqw0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f8bbf9-aa30-44ee-5d7a-08d9c4e07dce
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 00:17:51.6405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZpQpXzqEMrFiqA3676Le6QbB/4HMBLp+D49NPmjnkGJaYjxxhx47yGEMnAVqaG48XTeablutdz0tEDE/TyE1fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Tue, Dec 21, 2021 at 11:45:09PM +0800, Borislav Petkov wrote:
> On Mon, Dec 20, 2021 at 12:35:16AM +0800, Huang Rui wrote:
> 
> Capitalize subject's first letter:
>  [x86/msr: add AMD CPPC MSR definitions]
>  [x86/msr: Add AMD CPPC MSR definitions]

Thank you for the reply! Updated.

> 
> > AMD CPPC (Collaborative Processor Performance Control) function uses MSR
> > registers to manage the performance hints. So add the MSR register macro
> > here.
> > 
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >  arch/x86/include/asm/msr-index.h | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> > index 01e2650b9585..e7945ef6a8df 100644
> > --- a/arch/x86/include/asm/msr-index.h
> > +++ b/arch/x86/include/asm/msr-index.h
> > @@ -486,6 +486,23 @@
> >  
> >  #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
> >  
> > +/* AMD Collaborative Processor Performance Control MSRs */
> > +#define MSR_AMD_CPPC_CAP1		0xc00102b0
> > +#define MSR_AMD_CPPC_ENABLE		0xc00102b1
> > +#define MSR_AMD_CPPC_CAP2		0xc00102b2
> > +#define MSR_AMD_CPPC_REQ		0xc00102b3
> > +#define MSR_AMD_CPPC_STATUS		0xc00102b4
> > +
> > +#define CAP1_LOWEST_PERF(x)	(((x) >> 0) & 0xff)
> > +#define CAP1_LOWNONLIN_PERF(x)	(((x) >> 8) & 0xff)
> > +#define CAP1_NOMINAL_PERF(x)	(((x) >> 16) & 0xff)
> > +#define CAP1_HIGHEST_PERF(x)	(((x) >> 24) & 0xff)
> > +
> > +#define REQ_MAX_PERF(x)		(((x) & 0xff) << 0)
> > +#define REQ_MIN_PERF(x)		(((x) & 0xff) << 8)
> > +#define REQ_DES_PERF(x)		(((x) & 0xff) << 16)
> > +#define REQ_ENERGY_PERF_PREF(x)	(((x) & 0xff) << 24)
> 
> All those bitfield names are too generic - they should at least be
> prefixed with "CPPC_"
> 
> If an Intel CPPC set of MSRs appears too, then the prefix should be
> "AMD_CPPC_" and so on.
> 

The similar function in Intel names HWP (Hardware P-State), and related MSR
registers names as "HWP_" as the prefixes like below:

/* IA32_HWP_CAPABILITIES */
#define HWP_HIGHEST_PERF(x)             (((x) >> 0) & 0xff)
#define HWP_GUARANTEED_PERF(x)          (((x) >> 8) & 0xff)
#define HWP_MOSTEFFICIENT_PERF(x)       (((x) >> 16) & 0xff)
#define HWP_LOWEST_PERF(x)              (((x) >> 24) & 0xff)

Hi Rafael,

Can we use the "CPPC_" as the prefixes for AMD CPPC MSR bitfield name?
And any other comments on the other patches of these series?

Thanks,
Ray
