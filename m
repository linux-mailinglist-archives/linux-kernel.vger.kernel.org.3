Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EDA4BCF12
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 15:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244017AbiBTOgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 09:36:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiBTOgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 09:36:39 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E37D42EE9;
        Sun, 20 Feb 2022 06:36:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JeLUqmiO0e13S4VH6/3dOAJevpsP7ZFEAXXryeSrAVFKc8AkVxXmKzgRD92bgD1ovH8wXw0LuTd7964dGx9l/3/yDKetSUj+f+YIt9Cra9gChB3uft5Deqhn0jptoTW32ZcHmgOQf606noGBnYCE/KnGnOw8anfv++HL++Q38ULFTf6w9uGiYwW9eTDgUK12lR051vuJP1NLegWlk5x/dEC9VVNxssboWqBhLQtvcOP8yxnxdzjIS9gOp5sxrTOPkT4GgYG7jqn31J+i9uQGx88w4rtbglEmQU8x8eSV7mdMLhkEjKS7hej4Ci04q41FbEVIoPep9CH0cUXZBBae8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8asMAXuHQIpRT7R0m8iGLabHNttRlNB6vvDQcfrOXE=;
 b=Nmv+40NQLykWcBcHX5T59bVVpttXiSK7HGjfKK0ekf7oMX/vxZweu9Br1gCinvA+SjkeL+O6A6M+jqF7LP6UCupsPpRpMg+c5+teJv5SkB5iduL8OpqmN88S9Y0Zc5wmgMVx70k+y1ok8OTQY3X22FqkkqYXQsXBUHrfzmeUWdlusOXlGjsj/3BN8vYPxW0aDVwBKHfxONn8G3LfkR1YC4ePHnHUAMHjUTe0knHjClfzfyD6GKJxpdPJTGN1w0JvJAnq7w/wOk0ABY/MQd/zUvh3XRFWFaP0Z0/pZVmJSxRwz7N2pAtJ13VoAQGTicsOuwoB5L/ArwhEGH7RibvKNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8asMAXuHQIpRT7R0m8iGLabHNttRlNB6vvDQcfrOXE=;
 b=1JKnitnMSKM5Hmjr9sNPvtXqsZ6DNZXhM+3FkSRCkavDocJA9rKXpAJ4n1hOHZ4jZLXo/TTVPCc33XyFVXJyqbMFDNlwhrcumH1D8XQxnSBSUdJSuhz0IZgBHYVyBRSgsK8f7oxzHznq89WQwQ94x79HELNiPxy3pZnDHjSQ0sA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM6PR12MB3147.namprd12.prod.outlook.com (2603:10b6:5:11d::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.24; Sun, 20 Feb 2022 14:36:16 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::6cdc:ce39:9104:b1a1]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::6cdc:ce39:9104:b1a1%5]) with mapi id 15.20.4995.026; Sun, 20 Feb 2022
 14:36:16 +0000
Date:   Sun, 20 Feb 2022 22:35:52 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND v6 7/9] cpupower: Enable boost state support for
 AMD P-State module
Message-ID: <YhJRyNGA+bAEXT4Y@amd.com>
References: <20220216073558.751071-1-ray.huang@amd.com>
 <20220216073558.751071-8-ray.huang@amd.com>
 <f415df0b-9320-090c-7ca9-8597c0211e87@linuxfoundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f415df0b-9320-090c-7ca9-8597c0211e87@linuxfoundation.org>
X-ClientProxiedBy: HK0PR03CA0098.apcprd03.prod.outlook.com
 (2603:1096:203:b0::14) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 452af62b-c99f-4176-88a7-08d9f47e5a0e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3147:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB31475311E6F9FEBFF1FCC64AEC399@DM6PR12MB3147.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W9ywNNG994XPR6wyfdef+j/6NSoKDPWkyWUTCcij7d6l5kPJobbG1sPntUC1XlzYF1AgHSEKdDhiKHMQTlkTEDjGWo7lSY1evOKaXWXrab/k/L9yo/QgTWLWgbbiLetUMve4O07VZ1vIlgeCYkna1uNjRQHzf3e8heGDMBSG7LucjzOgWnr5J8vuiSS4U40tRS3oas77nEhIFu47hCpUAtjcGqtnf8/28izpq9qWoPEdxcNVwR+tL/SA3iahHnejFLkl++0wz2+9mdpVZQ9Eiq+q2Yh//m4mCRrwgzzD4yPfBIePYE8z49H6Tn+GV0yJvn//Awz3tsl827ZVsQK1GkOwHot2r7LuuQRw0fbnWL3Oxk99wQmClh0Fg2CKobFeuDZzj2zXhdxR7zk8fzZH+O8ilfpQ0rWnpGdE6mDOnK6J6LcDZtk9pejg8Tb0HjhCRntibnRTcKPEdQtq+VHu+dmHlOm6j5PScJJ63fXLbRg95fwap1uvbgoyotHU9VHUSMr/+djEDuS09QspjJPB5txIwseUNzncBsBzRs+kzSPxJHSCV2sGREW3aZTr/BawSD4vX/5p3e3Qc38ul6zIeT6m7RSQrt3W6Or7i13hX8qE+e+gp5mVb1679A8mm8M7ypSyCJGDpsBWjMS+5Q57dJ/lKFya/Y76DRz0NMoCHDY3D/GJpPqHbr1EWpE/LRg8OSKN+ZtOrQzaH0Apnauqww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(54906003)(6666004)(26005)(316002)(83380400001)(6486002)(36756003)(2906002)(7416002)(5660300002)(2616005)(186003)(66946007)(86362001)(8936002)(66476007)(508600001)(6512007)(6506007)(8676002)(4326008)(66556008)(38100700002)(53546011)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?llJ9CISV9cuZ0edbaoKU8JX7LuNgheO85JyVYxuJB7n6/HAcgrbjxWIEVMz2?=
 =?us-ascii?Q?MC+3I7s4HXP9r/fO+oGcxjWP6Bvpm82GcFrWCn7gRgifmXhd+OalVMkrD6Gc?=
 =?us-ascii?Q?7esl8lOdkUDVOxU72akJ9+bbzvGEDpqffnY2fhZn6m50HdCx9STBM6rXf0bb?=
 =?us-ascii?Q?PA8Xw/26cG1KnHJ3DSWRBCenjVTQPtyET6YqzNNNmRY1uSaTrBiISqqvTw5A?=
 =?us-ascii?Q?bekLOqkUrZ7Z2aMWEa2cfe8mtErYw9p0ZnC3+9YTEznpRJt/wovbmQS008ip?=
 =?us-ascii?Q?aPcYN1+BfR8zlFW9lI/PAIK3QjnVs7pXTCGRTKFaVueHzya5Yr2sE+xzETtP?=
 =?us-ascii?Q?u98yCj/jnbX1sOMCU4EjBorFU1cphZYqeBZ+D3pz6SjwcLxPUIvzmG0LsNOw?=
 =?us-ascii?Q?sFYxSxAEkgYMXBpuLWmUlgpvQZgkTO4LDUDoJdFypo0RuuxMsOXhUowyHfhA?=
 =?us-ascii?Q?iPmXBKxeRw7IDbj87ARHHv6cF8AxdxhJP7KRJJ/q/xScTedwSOZ52wLYzlp3?=
 =?us-ascii?Q?60GslSbfKwN9CM+hYAZvIm8DTzMAB3jbK560gLJAzNbwcW64HW3tNoaU20sa?=
 =?us-ascii?Q?q6wPSJ3bWxmk9m2txTyECtkFt8g/iNjXteZw1p7KDLZgv8FLQVfCUtzPAbyI?=
 =?us-ascii?Q?PxtEzeyKH6VhyjsPBQJ995cFD7cSAaRzPQoIsRmK4BSjdu11XScYrkw/bnV7?=
 =?us-ascii?Q?Y8qJolXPIaoFINzF6hU3T5fv2fz50QPa6uF4Mi0N8Tv6C24Yh5nYYT3Sqiw2?=
 =?us-ascii?Q?MAqz1D3kDvekwk4ar5eq2yl2fPhDFYGKG4wQFxOpDZ5A0dwug8puqnWzxk9+?=
 =?us-ascii?Q?14IuXdr2NHyqJAQ8Efj3W6cgsa8WgEpachAdrhtJxDtreAMA3uw2Q/AkjJS2?=
 =?us-ascii?Q?tr53fA8WWTSr6DSXa/87sgydsftDAH5Dgh+WzlkJvKubsvSHgt6h31IZVmvt?=
 =?us-ascii?Q?hIDL62xfgDdQylIK26bGyjc3nuQETUzbckVFtooOvxMXu3vEZXUlxBN+9dD2?=
 =?us-ascii?Q?hbNbfP1WPrwYt00qhfZBs0izhW4HHh2+D+0v5HQ1am7BU6gaVZJvPhLWcn20?=
 =?us-ascii?Q?20BjXWMbGLFAwp9x88HTT2dZZalE9G5+rCSQPU3+rQfrC2mI2HXapFrKtuDA?=
 =?us-ascii?Q?s1JYf25L5sr2pkb4sfrlThVt0PXTUYBZNEe6Aj4jn2X1WYDSK3zPsjskR3cZ?=
 =?us-ascii?Q?A5GvC+ZpsfTgUlQ70p5wauRpQ6DghjsWksQUYJDj2OP2bAB9Ds6yqLALWWd1?=
 =?us-ascii?Q?bVBZRZx9gYy66RNCfeYB1zYonWWNDPy/1XrEt5uWJTBklSkNyfF4cyqf3Cdj?=
 =?us-ascii?Q?c0JStS/GlPg8CCrfH9xRQ0ARF3jH6uqi1yHmkjJZAcJa01Ed76NxlSRj9bJ5?=
 =?us-ascii?Q?FGQ5O6JQ59Fp2taP+wUJBjU9fvNRo90BCQwXAMQ2vIdkva4+P/gVCxsA/OMz?=
 =?us-ascii?Q?VJJlyv0yBCrmcAzgdUQWvszK35drwJDtaBAUPd16D74PaQgg88DG8dXuHfJs?=
 =?us-ascii?Q?dwfVDID1/dWSy44mN7LceMg3lkZPYNFF7wKEk2KrdYw/R5OCoqaBLE6obmU3?=
 =?us-ascii?Q?cMsHZBNqScsZ/a8B5ppK5x+cyLA/BNeZyzDmwIsiNSi9qPf28HY9v2eiwABg?=
 =?us-ascii?Q?d0BwLYzRPNkrt4VTnktcDiA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 452af62b-c99f-4176-88a7-08d9f47e5a0e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2022 14:36:16.5938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Et1EZk7RC08gEaOGzjDk1LxG7qhoxUn4EMVuLQhC9MIHujuvKaMv+ZGXIL+S1vLUQF1iAOcrZ7r0Xd4R2R9LZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3147
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2022 at 08:01:59AM +0800, Shuah Khan wrote:
> On 2/16/22 12:35 AM, Huang Rui wrote:
> > The legacy ACPI hardware P-States function has 3 P-States on ACPI table,
> > the CPU frequency only can be switched between the 3 P-States. While the
> > processor supports the boost state, it will have another boost state
> > that the frequency can be higher than P0 state, and the state can be
> > decoded by the function of decode_pstates() and read by
> > amd_pci_get_num_boost_states().
> > 
> > However, the new AMD P-State function is different than legacy ACPI
> > hardware P-State on AMD processors. That has a finer grain frequency
> > range between the highest and lowest frequency. And boost frequency is
> > actually the frequency which is mapped on highest performance ratio. The
> > similiar previous P0 frequency is mapped on nominal performance ratio.
> 
> Nit - similar

Corrected.

> 
> > If the highest performance on the processor is higher than nominal
> > performance, then we think the current processor supports the boost
> > state. And it uses amd_pstate_boost_init() to initialize boost for AMD
> > P-State function.
> > 
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >   tools/power/cpupower/utils/helpers/amd.c     | 18 ++++++++++++++++++
> >   tools/power/cpupower/utils/helpers/helpers.h |  5 +++++
> >   tools/power/cpupower/utils/helpers/misc.c    |  2 ++
> >   3 files changed, 25 insertions(+)
> > 
> > diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
> > index 4d45d1b44164..f5ba528dc7db 100644
> > --- a/tools/power/cpupower/utils/helpers/amd.c
> > +++ b/tools/power/cpupower/utils/helpers/amd.c
> > @@ -175,5 +175,23 @@ static unsigned long amd_pstate_get_data(unsigned int cpu,
> >   						  MAX_AMD_PSTATE_VALUE_READ_FILES);
> >   }
> >   
> > +void amd_pstate_boost_init(unsigned int cpu, int *support, int *active)
> > +{
> > +	unsigned long highest_perf, nominal_perf, cpuinfo_min,
> > +		      cpuinfo_max, amd_pstate_max;
> > +
> > +	highest_perf = amd_pstate_get_data(cpu, AMD_PSTATE_HIGHEST_PERF);
> > +	nominal_perf = acpi_cppc_get_data(cpu, NOMINAL_PERF);
> > +
> > +	*support = highest_perf > nominal_perf ? 1 : 0;
> > +	if (!(*support))
> > +		return;
> > +
> > +	cpufreq_get_hardware_limits(cpu, &cpuinfo_min, &cpuinfo_max);
> > +	amd_pstate_max = amd_pstate_get_data(cpu, AMD_PSTATE_MAX_FREQ);
> > +
> > +	*active = cpuinfo_max == amd_pstate_max ? 1 : 0;
> > +}
> > +
> >   /* AMD P-State Helper Functions ************************************/
> >   #endif /* defined(__i386__) || defined(__x86_64__) */
> > diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
> > index 557524078e94..f142fbfa4a77 100644
> > --- a/tools/power/cpupower/utils/helpers/helpers.h
> > +++ b/tools/power/cpupower/utils/helpers/helpers.h
> > @@ -140,6 +140,8 @@ extern int cpufreq_has_boost_support(unsigned int cpu, int *support,
> >   
> >   /* AMD P-State stuff **************************/
> >   extern bool cpupower_amd_pstate_enabled(void);
> > +extern void amd_pstate_boost_init(unsigned int cpu,
> > +				  int *support, int *active);
> >   
> >   /* AMD P-State stuff **************************/
> >   
> > @@ -177,6 +179,9 @@ static inline int cpufreq_has_boost_support(unsigned int cpu, int *support,
> >   
> >   static inline bool cpupower_amd_pstate_enabled(void)
> >   { return false; }
> > +static void amd_pstate_boost_init(unsigned int cpu,
> > +				  int *support, int *active)
> > +{ return; }
> 
> No need for a return here
> 

Will remove "return".

Thanks,
Ray
