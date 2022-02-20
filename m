Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A154BCF02
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 15:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244010AbiBTOe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 09:34:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiBTOey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 09:34:54 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2046.outbound.protection.outlook.com [40.107.212.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB85B42EE9;
        Sun, 20 Feb 2022 06:34:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPyHqwM5lyuFXjDmFVWXdUJBgHxGUXhxg1vcgFFBbScmzy3C5gfYJsE7wSDGiRZRj2MRqV39t8G6KsccguuD0S/ZBiTv5dPnT2KIae4hwtxreuJXAa3/cvtBXvaCYQVSnO2HVzuK6ZWHFFA3XoJQb/0bWc3B/hnVtJWQ8RkOpP+4fnXucgaDqVC3+lGHo4EKzGHebN1YvD9/hGSdP35hHg6E2JdQITE8SqEwybK4L/3YTzc99qlp4baQ1HltJOuodvR62CpLZaNMkW7j1zIS9spTxZWjWnMO6Y1W0H+bYpip14a+Bn7SNoTcfG9zl6w8/LD7sN3xD+bk6It1PSEfJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+KZkZ1F8T6/CHoZ73SZeKPIDkWyHbRs4ksGR98pOCs=;
 b=Y9RD6cFKrRp0Aolr/LlN2FCtNHJAmKytGaP03riMb1xCGghhDHFTj0hLpYEZonaJmxsoK56x0QQTrcopyRHw+qSxcWcjIIvWhlzlLhhi6+PDzV04c7YGZSGOrimd9poFMYHfj7vFnOUbm8lSAKaIQgEwQsd4XJ1KOXJGudQ3OjzMdyczIyZEJfuQHBM/pBYgQPJ42/86eu3AH1qkHnkZKZdkdDIkCS7FdZrhymSl4o2ZNwLX7kq1tiQw+K/P4lZzrr3R/C6G+5oz7j1qjXKG+lWP4DB8WdfuL3uAyWR7KfAesHYgfV+KisyRInnGlHyz7N6mcKOOOT/378G1Qk8Dfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+KZkZ1F8T6/CHoZ73SZeKPIDkWyHbRs4ksGR98pOCs=;
 b=j4TV0wjwpXQ/G3zGqvOxsCRByvkGJ0Gg2Y89lbEVBj9J2At0xK/T+/bHBs6pl7rT77TlYKyyzmKhWEOVWt/RSZiV3cWf0yQqHBbw4qQ32slNFSZ4bgd3xjUsFpldYzDIaDyChKXClDf/g9fU4C51nSmm05q2KTuavaGpJzOG+eQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM6PR12MB3147.namprd12.prod.outlook.com (2603:10b6:5:11d::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.24; Sun, 20 Feb 2022 14:34:27 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::6cdc:ce39:9104:b1a1]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::6cdc:ce39:9104:b1a1%5]) with mapi id 15.20.4995.026; Sun, 20 Feb 2022
 14:34:27 +0000
Date:   Sun, 20 Feb 2022 22:34:03 +0800
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
Subject: Re: [PATCH RESEND v6 5/9] cpupower: Introduce ACPI CPPC library
Message-ID: <YhJRWyps+lwuY3q3@amd.com>
References: <20220216073558.751071-1-ray.huang@amd.com>
 <20220216073558.751071-6-ray.huang@amd.com>
 <5e7bfce4-f326-930b-4a25-15538f741167@linuxfoundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e7bfce4-f326-930b-4a25-15538f741167@linuxfoundation.org>
X-ClientProxiedBy: HK2PR02CA0207.apcprd02.prod.outlook.com
 (2603:1096:201:20::19) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fa5c12e-669d-4a85-7c80-08d9f47e1917
X-MS-TrafficTypeDiagnostic: DM6PR12MB3147:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB31476C13174A155526882656EC399@DM6PR12MB3147.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yop2cxUD4ygjJtSGfWgJsVlmOjsQ9LxE+8iYFGuTnCUfU4orZ8l+DKmimBHXgfEo7MgChj0TZkw7/8EaxVO0dNGc6sOEwQ0PG/9VYMtf8xNsHpGUtnyhCjPL97SX2C9oFL65e8MdpF8jRgg2eJ6hV+QukRoBc2rhyhaieBB6S2WIWedfRvVWykk/y9n9LUzmjTQDc4b8YCo17/3+XTWzEiDgkMvDkrgn/3MO0dS/tverC0t5uYQpFVSMxdg4WPhDlhe5V27dszhwjf4ZGaDycEU4fCavL/1IePpENHyLiiqiflQA4pfVnqv8qCArmNUoAzW74jnx35UYI/X09UQLe5ivSQtD99YW2pujzprmtqy+QMD7TbDh2WpVJDCdfT32n4yrU4aQz1iIqBvAcezq7XHZq7sDkjAKddASPaDSkAz+W+ssmYcqFi1MJPFxUJ1c1YnQ9YplU0DdHf1yFpJCB6fCDhz5Ppkw7zMM2rw1+2Zwnx13ulNmlkBLcCzKvYpuibBEqFIsBEip3MaDWKyipEnox4DWiDF5YrwZiwrgjGX5WJX8bcF+ypTEy9zgw8tajAEcSsBEhoGqd7R+CCEeUBQGmsPzseHCwVH43eHmK7MwHQTp+teTtUkAfN9ywa13pgE0cW+Kr4OP0+dV67cDXo+VdzYTzHHDnp6zr60e7vNFyPl8sfR5rA+TC+gg97b2USPLoD0xMTqcP8jBXb4BuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(54906003)(6666004)(26005)(316002)(83380400001)(6486002)(36756003)(2906002)(7416002)(5660300002)(2616005)(186003)(66946007)(86362001)(8936002)(66476007)(508600001)(6512007)(6506007)(8676002)(4326008)(66556008)(38100700002)(53546011)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sn/K2hvHe3/OB0hhxv6NlBTX3WLqJbVdU0hIGXdSJUA6Xas0z/mAfPY3dSSO?=
 =?us-ascii?Q?8Dn8N0x6rYkB/r1QcMZqv3Ak4sz3XawDD1GikQ+p01nY4Rj3KvakKIu93kAE?=
 =?us-ascii?Q?Bu8yG0Z+xN91dEwFqDLjTqw2ymjUtYmS0UXcS9DApXCRLYksIKHnHhGDlAeD?=
 =?us-ascii?Q?CBQBiyw4M11nqXypyO0YqbnEszB/IozY3KSNiSpZZIk3YP0aT6wyCavbjs19?=
 =?us-ascii?Q?V2ArECp6lXN/GNTLKb0FRAMsGekZ0KoACMe9GnV9JOjX73ofI4zsV/Id85fh?=
 =?us-ascii?Q?/1iYiMyP8givpdktIPJSFqhnUoZVRzMy/2X5Cy/HlboKNpaXHe/c+Kdlq2Yw?=
 =?us-ascii?Q?UYnIyaZgHkO0YO4hKmkiHb7+elwe/AtQw0lUlAa6VRk2PDaVgsxAuhfXUM2A?=
 =?us-ascii?Q?kP5sFQdw3QnfC2jQoBfk2U27xGspMnuExQS22PH5q1Vy7w1EhfRMQ9k4q4PT?=
 =?us-ascii?Q?mgrMASVYeXN7osAGPIYkxe0wXwo9Y1U0OG9IdKeub2pjK4IiHtPBzED7Zchj?=
 =?us-ascii?Q?a82V/2vd85bT6Z/W4LrxyfOHaUNbxRUcdRMA8hUrKbB6mLn5hTd9tabJRXNm?=
 =?us-ascii?Q?dzys+r6kTc+z4wedUA1ii8FygUxDJAIaDPXMM1TDJW1MrdtxbYwUArcvFxjj?=
 =?us-ascii?Q?215FRYhFbaVCQkLBr2WV1AErYgJRGmL46SyF/pYFsR+4Df6qf88Wgo3xp6Bl?=
 =?us-ascii?Q?EamGQa5LyNzaglN0/53W76Ybum4XYm7NXfzgYw4s233M0fk1CgoXTUlXdkMi?=
 =?us-ascii?Q?5TdRAUscqxlJ7peg0iw9CpFu8S/Ub+wqhzMn2QrrUMjBgTW9axQQIy2ffqPt?=
 =?us-ascii?Q?ZNUCUuim4lF+ZE+RTcRbgXUwnjYdaoD1Z5960GgHck4Ugj+s9KP/d+Oj8FWm?=
 =?us-ascii?Q?L8EQ+czMHN7B4Sk4WGdKuEY+6PXOCWntnA6WtJfZDjhu125e6hqvbbavR7bK?=
 =?us-ascii?Q?wERGLhxI6NXJBZxFIxI6Y/yD/PwBIbR+ri5u6yURdHK0mOZpJjmXkI9J01n7?=
 =?us-ascii?Q?aAlZ9QIRjBsttnnXhWO0QcLAvvrtwToRvpCmK3YqTmdzPvk4w53G7dIlH/cx?=
 =?us-ascii?Q?29OO47EtkXpbwa9IL1BYVMsNOzJSW9NmJv5HmXQypKu9+k+jyo2HapeEYBg/?=
 =?us-ascii?Q?kqblq5BjrxUyOTTtPb+BIeuQjOOJK1lGJsnH7FAOdmE/J4IPEV+Qhi969i/v?=
 =?us-ascii?Q?jXiCnODntlwrz6fXaVwIcD9gCaMCXC+tLh1RrnMQiXXy+6ozGrhrkbNDINSB?=
 =?us-ascii?Q?thB8iNFW16U4sRPcGSQ5uSdzsIKEHinBsasnhfV4mG5FBq9uhCrdkRefkBWp?=
 =?us-ascii?Q?2a7uR3a9BETGoYJnQ9nlAZAjDlprz6av1N0/cPdy5fZ3KOmiJSAJnViWCcIH?=
 =?us-ascii?Q?1g9tBMaQCTHp86GvfDyfrfvfjp9lmstrcaT38PwwG02AsJJ+sY+q5M455rZM?=
 =?us-ascii?Q?tQx14GBrK01TB+nqjJfPm59oLGyyKCoDZZfT84pvOeMZMnPO80/hL8p/cl1+?=
 =?us-ascii?Q?jQahBg7fq8I0eAK1IE5YNeyWUhE/La9bSzU8oRNeIND7zfO0ILukR7N7mCcm?=
 =?us-ascii?Q?L+Ych0ImKRK2s2vQADnRo4aAAWd/Jn1MLfcyg0DDOy5d9d0YS+A72ARi2Z1g?=
 =?us-ascii?Q?aOaZYiepEM3jzmWqcjHiau8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa5c12e-669d-4a85-7c80-08d9f47e1917
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2022 14:34:27.5849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WIF79biUZpijaizJ+HSA04JyMva/VCkUoVRl/l1NHkIgoziwCBXfF/GfG3M0dRfNy+2Vc2KFerebgvtj6eB0YA==
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

On Sat, Feb 19, 2022 at 07:53:52AM +0800, Shuah Khan wrote:
> On 2/16/22 12:35 AM, Huang Rui wrote:
> > Kernel ACPI subsytem introduced the sysfs attributes for acpi cppc
> > library in below path:
> > 
> > /sys/devices/system/cpu/cpuX/acpi_cppc/
> > 
> > And these attributes will be used for AMD P-State driver to provide some
> > performance and frequency values.
> > 
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >   tools/power/cpupower/Makefile        |  6 +--
> >   tools/power/cpupower/lib/acpi_cppc.c | 59 ++++++++++++++++++++++++++++
> >   tools/power/cpupower/lib/acpi_cppc.h | 21 ++++++++++
> >   3 files changed, 83 insertions(+), 3 deletions(-)
> >   create mode 100644 tools/power/cpupower/lib/acpi_cppc.c
> >   create mode 100644 tools/power/cpupower/lib/acpi_cppc.h
> > 
> > diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
> > index 3b1594447f29..e9b6de314654 100644
> > --- a/tools/power/cpupower/Makefile
> > +++ b/tools/power/cpupower/Makefile
> > @@ -143,9 +143,9 @@ UTIL_HEADERS = utils/helpers/helpers.h utils/idle_monitor/cpupower-monitor.h \
> >   	utils/helpers/bitmask.h \
> >   	utils/idle_monitor/idle_monitors.h utils/idle_monitor/idle_monitors.def
> >   
> > -LIB_HEADERS = 	lib/cpufreq.h lib/cpupower.h lib/cpuidle.h
> > -LIB_SRC = 	lib/cpufreq.c lib/cpupower.c lib/cpuidle.c
> > -LIB_OBJS = 	lib/cpufreq.o lib/cpupower.o lib/cpuidle.o
> > +LIB_HEADERS = 	lib/cpufreq.h lib/cpupower.h lib/cpuidle.h lib/acpi_cppc.h
> > +LIB_SRC = 	lib/cpufreq.c lib/cpupower.c lib/cpuidle.c lib/acpi_cppc.c
> > +LIB_OBJS = 	lib/cpufreq.o lib/cpupower.o lib/cpuidle.o lib/acpi_cppc.o
> >   LIB_OBJS :=	$(addprefix $(OUTPUT),$(LIB_OBJS))
> >   
> >   override CFLAGS +=	-pipe
> > diff --git a/tools/power/cpupower/lib/acpi_cppc.c b/tools/power/cpupower/lib/acpi_cppc.c
> > new file mode 100644
> > index 000000000000..a07a8922eca2
> > --- /dev/null
> > +++ b/tools/power/cpupower/lib/acpi_cppc.c
> > @@ -0,0 +1,59 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +#include <stdio.h>
> > +#include <errno.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <sys/types.h>
> > +#include <sys/stat.h>
> > +#include <fcntl.h>
> > +#include <unistd.h>
> > +
> > +#include "cpupower_intern.h"
> > +#include "acpi_cppc.h"
> > +
> > +/* ACPI CPPC sysfs access ***********************************************/
> > +
> > +static int acpi_cppc_read_file(unsigned int cpu, const char *fname,
> > +			       char *buf, size_t buflen)
> > +{
> > +	char path[SYSFS_PATH_MAX];
> > +
> > +	snprintf(path, sizeof(path), PATH_TO_CPU "cpu%u/acpi_cppc/%s",
> > +		 cpu, fname);
> > +	return cpupower_read_sysfs(path, buf, buflen);
> > +}
> > +
> > +static const char *acpi_cppc_value_files[] = {
> > +	[HIGHEST_PERF] = "highest_perf",
> > +	[LOWEST_PERF] = "lowest_perf",
> > +	[NOMINAL_PERF] = "nominal_perf",
> > +	[LOWEST_NONLINEAR_PERF] = "lowest_nonlinear_perf",
> > +	[LOWEST_FREQ] = "lowest_freq",
> > +	[NOMINAL_FREQ] = "nominal_freq",
> > +	[REFERENCE_PERF] = "reference_perf",
> > +	[WRAPAROUND_TIME] = "wraparound_time"
> > +};
> > +
> > +unsigned long acpi_cppc_get_data(unsigned cpu, enum acpi_cppc_value which)
> 
> unsigned int cpu
> 
> > +{
> > +	unsigned long long value;
> > +	unsigned int len;
> > +	char linebuf[MAX_LINE_LEN];
> > +	char *endp;
> > +
> > +	if (which >= MAX_CPPC_VALUE_FILES)
> > +		return 0;
> > +
> > +	len = acpi_cppc_read_file(cpu, acpi_cppc_value_files[which],
> > +				  linebuf, sizeof(linebuf));
> > +	if (len == 0)
> > +		return 0;
> > +
> > +	value = strtoull(linebuf, &endp, 0);
> > +
> > +	if (endp == linebuf || errno == ERANGE)
> > +		return 0;
> > +
> > +	return value;
> > +}
> > diff --git a/tools/power/cpupower/lib/acpi_cppc.h b/tools/power/cpupower/lib/acpi_cppc.h
> > new file mode 100644
> > index 000000000000..576291155224
> > --- /dev/null
> > +++ b/tools/power/cpupower/lib/acpi_cppc.h
> > @@ -0,0 +1,21 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +#ifndef __ACPI_CPPC_H__
> > +#define __ACPI_CPPC_H__
> > +
> > +enum acpi_cppc_value {
> > +	HIGHEST_PERF,
> > +	LOWEST_PERF,
> > +	NOMINAL_PERF,
> > +	LOWEST_NONLINEAR_PERF,
> > +	LOWEST_FREQ,
> > +	NOMINAL_FREQ,
> > +	REFERENCE_PERF,
> > +	WRAPAROUND_TIME,
> > +	MAX_CPPC_VALUE_FILES
> > +};
> > +
> > +extern unsigned long acpi_cppc_get_data(unsigned cpu,
> 
> extern prototype in .h?

Will remove "extern" in .h file.

Thanks,
Ray
