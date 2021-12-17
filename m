Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38DF4785C0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 08:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhLQHxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 02:53:15 -0500
Received: from mail-sn1anam02on2049.outbound.protection.outlook.com ([40.107.96.49]:64639
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229449AbhLQHxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 02:53:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2VSGqYlx8/KAhixqR/C4C4/hYUMCnUxoXP/OC7g6dIFLmd7FeUQavp3b71HmikTvPT+M66MgCC2PSvh2sN9q+2sK8Fcb2NZm3i5Wk5c5/vwcvvmGbHabCfKdQuxmXO9JHKrCvsJgLKQJ743IULfU4ygUdpmU+j4RNFnCTKdp3xHvMWfmWkilZKIFG/zPCfWIBwCBWFwW2JP07Xs3k5bUjw2reR+7uuCYh93V4/qncH9U7K0uMfYZWoqUoxuAr/ungAbehIR0Hf4L0DNblwjUOUhEpKurH7S1qKEaucZzt4WszYu+ze0BvfTuksGL8BnUbahnFvAwMbzrCsmFd9zNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjAGgKvxDkV73+DlVchEpTo0bzHoD/w7nOaoVsluxcw=;
 b=bJP4Ry4qpjPYSGrNvb3xiEGK7sqrXo2B9Kgf4VPHYg4b6Kg0ElKx8wiTRvTqwU0jTgEgs6STUdI6YsRwLn9Ktzu6TcBf7hYvfvXxav1Rp2uhTFtMKdxwMYmUdwscvWYwhpgWm8IR1+8rjlRJ25x028/CjN4sC/weqzRawF1Ex27RkjjRkafQMywoe/sinlpS21RvuWn81Em1ZIj2he5jOuij+r/W9NwH0GJG7CxVWdY3QpVczXE3w8brf+BhSCT7yLUwCWi8+JG9yr50tymzepZu6s5Hi6YQyolCFN1hh5C5ofZwDOo0jUmgV2BMcc3/hrnUElFBJOCigIMlMslGHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjAGgKvxDkV73+DlVchEpTo0bzHoD/w7nOaoVsluxcw=;
 b=cNRsk9mHqroytkDrO20QwplRcEbFWVIqOsOQpDwdJOKB5nKJfzH2jQVotT8Tr03z6D3r+W3B6Oo3EJt1BuoqdtH8jAKBvY8JvfJmcdwaGrCtVruhfcDOIgSrtgSXngHg9c3/hCOyXNfQXK20B4ADyIEdFoqjf4kQyfdmqwow2UQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.14; Fri, 17 Dec 2021 07:53:09 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::5d07:e475:316c:d187]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::5d07:e475:316c:d187%5]) with mapi id 15.20.4801.015; Fri, 17 Dec 2021
 07:53:09 +0000
Date:   Fri, 17 Dec 2021 15:52:40 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmins.org>
Subject: Re: [PATCH v5 09/22] cpufreq: amd: add trace for amd-pstate module
Message-ID: <YbxByF9dEGrkR6Kr@amd.com>
References: <20211130123641.1449041-1-ray.huang@amd.com>
 <20211130123641.1449041-10-ray.huang@amd.com>
 <CAJZ5v0jbSC1Q1gn2+Hu6bJQN20uDDSbStdM3zHZ+UBR+YKsWQA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jbSC1Q1gn2+Hu6bJQN20uDDSbStdM3zHZ+UBR+YKsWQA@mail.gmail.com>
X-ClientProxiedBy: SG2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:54::15) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92891c40-79b6-4d7e-2971-08d9c1324471
X-MS-TrafficTypeDiagnostic: DM5PR12MB1163:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB116352C87251DD26A9D9269DEC789@DM5PR12MB1163.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qz3sF+Or5QK/059DheF9Ugde+RNx6oUsNP6/cE9Oxj0jqKHSx7YEA1lxGMleiq12UP/FzMWLTdNna9/RHtskfuIEen4EuZXxGW8ZC+iAlcmIjNo5CpNXO4+vE63r5WSkUuWpztskhyTRxJlfzkhv6qEdOCfXEMIaJIPAUeD9eUASyTjXvAnaNZKJno07VvYOujQripF2t5O9nxZXyfP8+mwOb7Rllno5lWyJs2DqkhnQBPeBcLpaoGz2yaSyZb+Rt3MWTTruWhnLEobTTOLLVWrk6tdbqTmb8pekzFVGQcAxQDqhR2R5NefOKj6vVrYnS6fr54plCP9zZ+PzLPr7RNRfn9Z5Eo4thZ/Ony2Y+67Br4z0t8Q6SRJ5jjaQnuZaoMfmEB/NoHW1lDhT/bXPAN0MfQla+KvXgFcjg4ZrhRkkt3RKYsjNKr0jmCSktpQagOTqy7axzShVIo01ZdoXc3t/7vSOe3zWdtSQRIymHcLjvMdc9GqTlXN0/VB1kp9/rpzejub3FTWRW6BjgMolA0AMqOpk+T5Mmvxmjr2nhCJXK8QW8FupQh7Tvwlne4nTlUFRy2kZHX5YqHsmDyPmytitT2EIM1mWlgsjsJw7C5bluACZXpBi+RKpmYeZ++alCul9EiGzOHZ3cNSIqCrKSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(2616005)(508600001)(66476007)(66556008)(66946007)(6486002)(86362001)(5660300002)(36756003)(186003)(8676002)(54906003)(316002)(2906002)(8936002)(53546011)(6916009)(6506007)(6666004)(83380400001)(38100700002)(4326008)(7416002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GONSO/PC1Iob8farB4ogi25YhNSbi5lvbDuXVsT2v1nAC0blIwnWjJe+us+x?=
 =?us-ascii?Q?5txcNWboTKFcPUPdnaQZQ0VxF+ztUsIkHxcEmIUmayeRcE/QK9r8yeBOq/CH?=
 =?us-ascii?Q?TA4Dk9mh1u6Cdru2g9zoedJpunbz3HFPtrsBtizTWPVKSOaitcUV399IniSB?=
 =?us-ascii?Q?Cr7XbC4dJtyTa+L4UuWqfAQl8iEaGK7cd6ZyxsnB3/Bo9l0euaRwQaKEZztT?=
 =?us-ascii?Q?MoFw0DrVeXY3iHbe+HZ8R5YD/jdB1T4ZvVtaroWgcxMnZs9htSGoH2H01zqP?=
 =?us-ascii?Q?rBGCzeJ4ub5XeSHU7ZAtltBuDkrirsd3zE+4GoW4rgUJ0TXX/qEGnPKb9w1e?=
 =?us-ascii?Q?OmzqVWASTmF+tdqJUthRd3W/RV9NsMXaEGhu2Npu6IDtrXvlTHiFr8bBGlzM?=
 =?us-ascii?Q?vf/WS9grwTp+UJsL5H7OZcnb0K7riAhorETaHJPjyDYNpJ9EoFMLgmbp/mTh?=
 =?us-ascii?Q?MbpDMNeTiWVbWgf3vp+L7BnQAql6O+Gjpzutjl1BS3bSfwSCenqgHNjX9ZE6?=
 =?us-ascii?Q?sbfkQcpaRdIA/bKHekoEnBrSkFz2jSsJz2vBrWgqhruyc82qmF28xuzl9G/F?=
 =?us-ascii?Q?5LpnViIhnTOafqn6KMioMVtw2ezcxYrvGxCBTSOBXc3fIqGfs+JbD6HD8z45?=
 =?us-ascii?Q?BN29EU1lhfdsE4hB3KjyaDBwrbTJX6RBZyAWY2LZzUXjx9uJlhH1GVOp7QOZ?=
 =?us-ascii?Q?zRT2VAX4GxRmANKgUcCkvIdKkUQcLffz0p+6HfNakqskjOCy/s6zG5yYkkvf?=
 =?us-ascii?Q?OoaA4T3O4Y+yEgQDogcQUbcoC9FjMxjcysImOFyJZQmxQsmmwPRv6TbGr3jb?=
 =?us-ascii?Q?5vqWDrzPmJs/FvXXdLRzDmizxBnZJkvHSgSX9pNJrNXGAV7Otcf68HPNPgDo?=
 =?us-ascii?Q?gBvvI2vp4p6FBm2u3UvlFKBvbchh4+zLnHbBJ31QUzaukknqan1QlQqDrh90?=
 =?us-ascii?Q?AAFB+8b0KWNtH17WnJJxq8TPsM2hAnMERSURcmSzxDh6z3cixHnS4rPbBr9+?=
 =?us-ascii?Q?W6Z++1CVgLN1l+ewo1+Dup8d7oVg6c4PaC1rXfAx+SGgjqC/sb73LC63qVYI?=
 =?us-ascii?Q?g9X83a38lndP+r7NnBqBi1DTCDuomSUGAAq5LNpNt3cfRBlg0IwwIA3MYD7a?=
 =?us-ascii?Q?f7vDgD/H0899YZFCYsZtV2Cu5Dt3uNvlbJ+eXvvjBbXY/R/a0KO701kKCcjd?=
 =?us-ascii?Q?1q9WUEbW8/+XO36cKqeOQ82ffFGH0tpOBpNHG6aEHZwolParI//jo8k0dy16?=
 =?us-ascii?Q?APk0lHNY6w4gLslHy9zLd261YF9dZRLa9lCSt6/mlY7kyz4Gd7qBtYuhT7lS?=
 =?us-ascii?Q?glH249oYRSvmsUAK9JAn5sA97E3xgQAaQJ9rpVtZiRTPkeJ86ldailTApFM4?=
 =?us-ascii?Q?04ei/UZvXhyIW9RbRcVmRgDVRMkzfORrmF7uyAmZfOVE02/n1Pvj8/10q1Bj?=
 =?us-ascii?Q?wm/A9Qi0n6VmTkk3Cy/ll3NjEEHU4HGHcHVUKUTWrFpKJtDfXg8hJPGnh+mF?=
 =?us-ascii?Q?R/1qdHx0OWxY5+BVrxzHidQtASRhtTdtSay4Q/HiIbTzrfLnrYOJ3C02lwmK?=
 =?us-ascii?Q?yb4PthLyUVLtEicO5rS4onDkqkOBump2NMvpH74O6jgcdRITGPrqJwKTV7Pb?=
 =?us-ascii?Q?hp6GfE2O9h+QflvTOx8/imw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92891c40-79b6-4d7e-2971-08d9c1324471
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 07:53:09.4646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ki2kwVpHWPqWwhP1ZV0XX/SavVEsgCxD35jBdwLiMT7MEtccIS2XiFXH+SRdYQUrASaARzYk0rJqwvw6Y3pSDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1163
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 02:12:41AM +0800, Rafael J. Wysocki wrote:
> On Tue, Nov 30, 2021 at 1:38 PM Huang Rui <ray.huang@amd.com> wrote:
> >
> > Add trace event to monitor the performance value changes which is
> > controlled by cpu governors.
> 
> This would need an ACK from Steve.
> 
> >
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >  drivers/cpufreq/Makefile           |  6 ++-
> >  drivers/cpufreq/amd-pstate-trace.c |  2 +
> >  drivers/cpufreq/amd-pstate-trace.h | 77 ++++++++++++++++++++++++++++++
> 
> Why are these two extra files necessary?

Please see below answer.

> 
> >  drivers/cpufreq/amd-pstate.c       |  4 ++
> >  4 files changed, 88 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/cpufreq/amd-pstate-trace.c
> >  create mode 100644 drivers/cpufreq/amd-pstate-trace.h
> >
> > diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> > index c8d307010922..285de70af877 100644
> > --- a/drivers/cpufreq/Makefile
> > +++ b/drivers/cpufreq/Makefile
> > @@ -17,6 +17,10 @@ obj-$(CONFIG_CPU_FREQ_GOV_ATTR_SET)  += cpufreq_governor_attr_set.o
> >  obj-$(CONFIG_CPUFREQ_DT)               += cpufreq-dt.o
> >  obj-$(CONFIG_CPUFREQ_DT_PLATDEV)       += cpufreq-dt-platdev.o
> >
> > +# Traces
> > +CFLAGS_amd-pstate-trace.o               := -I$(src)
> > +amd_pstate-y                           := amd-pstate.o amd-pstate-trace.o
> > +
> >  ##################################################################################
> >  # x86 drivers.
> >  # Link order matters. K8 is preferred to ACPI because of firmware bugs in early
> > @@ -25,7 +29,7 @@ obj-$(CONFIG_CPUFREQ_DT_PLATDEV)      += cpufreq-dt-platdev.o
> >  # speedstep-* is preferred over p4-clockmod.
> >
> >  obj-$(CONFIG_X86_ACPI_CPUFREQ)         += acpi-cpufreq.o
> > -obj-$(CONFIG_X86_AMD_PSTATE)           += amd-pstate.o
> > +obj-$(CONFIG_X86_AMD_PSTATE)           += amd_pstate.o
> >  obj-$(CONFIG_X86_POWERNOW_K8)          += powernow-k8.o
> >  obj-$(CONFIG_X86_PCC_CPUFREQ)          += pcc-cpufreq.o
> >  obj-$(CONFIG_X86_POWERNOW_K6)          += powernow-k6.o
> > diff --git a/drivers/cpufreq/amd-pstate-trace.c b/drivers/cpufreq/amd-pstate-trace.c
> > new file mode 100644
> > index 000000000000..891b696dcd69
> > --- /dev/null
> > +++ b/drivers/cpufreq/amd-pstate-trace.c
> > @@ -0,0 +1,2 @@
> > +#define CREATE_TRACE_POINTS
> > +#include "amd-pstate-trace.h"
> > diff --git a/drivers/cpufreq/amd-pstate-trace.h b/drivers/cpufreq/amd-pstate-trace.h
> > new file mode 100644
> > index 000000000000..647505957d4f
> > --- /dev/null
> > +++ b/drivers/cpufreq/amd-pstate-trace.h
> > @@ -0,0 +1,77 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * amd-pstate-trace.h - AMD Processor P-state Frequency Driver Tracer
> > + *
> > + * Copyright (C) 2021 Advanced Micro Devices, Inc. All Rights Reserved.
> > + *
> > + * Author: Huang Rui <ray.huang@amd.com>
> > + */
> > +
> > +#if !defined(_AMD_PSTATE_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
> > +#define _AMD_PSTATE_TRACE_H
> > +
> > +#include <linux/cpufreq.h>
> > +#include <linux/tracepoint.h>
> > +#include <linux/trace_events.h>
> > +
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM amd_cpu
> > +
> > +#undef TRACE_INCLUDE_FILE
> > +#define TRACE_INCLUDE_FILE amd-pstate-trace
> > +
> > +#define TPS(x)  tracepoint_string(x)
> > +
> > +TRACE_EVENT(amd_pstate_perf,
> 
> Could this be added to include/trace/events/power.h ?
> 

Actually, that is my original idea, but once I move the trace into
include/trace/events/power.h, the amd-pstate driver cannot build as "ko"
anymore. This is the early stage, "ko" is friendly and flexible for us to
switch and compare between amd-pstate and acpi-cpufreq. I can move it into
"power" trace events once we address the performance issue on shared memory
solution.

Thanks,
Ray
