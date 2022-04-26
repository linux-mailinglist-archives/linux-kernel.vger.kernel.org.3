Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C95F50FA50
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244809AbiDZK0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349191AbiDZKYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:24:40 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637E14B42A;
        Tue, 26 Apr 2022 02:58:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1GmJrAGXHx43x42rJRU7TdSKGcr58kGpGhpftgsWoy64TwXsE1LjGkeL2w8fwwUK7rBZ8oc3OjZjd4e2J2wgAiKCEGEsfIsd2ASjhHLr+H/pQFB1g/7IJaeKMh9kme9jqPLbeu67TxIFwZf+C2a3moS5EY+CGmCJ/XP92w5yis6TZCJWxot4lL2VSRvr7NQpNLaBP2o2nLanKvKMTCAW1pD6F+f7YXSK4152hRWai2WwsY+grgoRbMUgQZ5Sm02bMlmxu5X9+4oRVmwBaLAOMebA0lc/v0ZI53AKuBf90eALfHLcu7uOV61DmBhZzyT3+X0CxnjdlFd2Y5AKEiMvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQn6jW+TNZ2JgtKlv47i0Mg0uuWuQUo/0RyZ49fqGqk=;
 b=E6P1QXgOwqDWd5HMCLFa9mFhjJ0x9v1olGA4xHfah2qDSeUvn3j6rP/QlWNuR4db2plm5Qis4oc9MtUwEUVOd4Vfu7wIz0V9PZhi+hdC9Ug4USm7gvlhZdtOIB1gS+z7p+mPxfSxP9p38twrGcRroQNEFSl4bZEpfUcDjnkNqbl/2t8XCeo8FbHo+mfRxWlZqzVEjbPiACWGU4vRLfxXfEIbovygxVWU3p1SVn086siwS4aZlqowv/hNb8RbXo9egI2eZ6n/PpBkP8UjFFoo1qUZOTyfmUeatDVuxeL5KYVSoyuZJD/lWdoo7jHUnaT8620AyCqoz17v4GrCHrwJgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQn6jW+TNZ2JgtKlv47i0Mg0uuWuQUo/0RyZ49fqGqk=;
 b=MWytItJ3ophQR4jYdOFMaiOkHygbG/ahpwGl+EnAglyVcvr7GTFMToDfcUgMme7N8OdUWdxjoPL04uMeCAU7MZmr7Cl6qXyH7pAvZsjW6nTIPJwvOiSKxTy89BhqVO5IeLcxdkGuDdKIC0MdiOh12Q4FCTetNkOeJi7rTmcHMI4=
Received: from DS7PR03CA0010.namprd03.prod.outlook.com (2603:10b6:5:3b8::15)
 by MWHPR12MB1757.namprd12.prod.outlook.com (2603:10b6:300:111::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 26 Apr
 2022 09:58:00 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::ed) by DS7PR03CA0010.outlook.office365.com
 (2603:10b6:5:3b8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Tue, 26 Apr 2022 09:58:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 09:58:00 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 04:57:55 -0500
Date:   Tue, 26 Apr 2022 11:57:52 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
CC:     <peterz@infradead.org>, <acme@kernel.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <tglx@linutronix.de>, <bp@alien8.de>, <irogers@google.com>,
        <yao.jin@linux.intel.com>, <james.clark@arm.com>,
        <leo.yan@linaro.org>, <kan.liang@linux.intel.com>,
        <ak@linux.intel.com>, <eranian@google.com>,
        <like.xu.linux@gmail.com>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: Re: [PATCH 2/6] perf/amd/ibs: Advertise zen4_ibs_extensions as pmu
 capability attribute
Message-ID: <YmfCICT+nbdvohw3@rric.localdomain>
References: <20220425044323.2830-1-ravi.bangoria@amd.com>
 <20220425044323.2830-3-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220425044323.2830-3-ravi.bangoria@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5778bf79-c77a-40c2-398c-08da276b3f3b
X-MS-TrafficTypeDiagnostic: MWHPR12MB1757:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB175763F69F42B156295C59B59CFB9@MWHPR12MB1757.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qab2cXGFFIi15yZIbIw8FhYEB9nkZvPlCkKrv3qhBK7HSr3oSzNzjvS2eU3+o7mapjay1grt/3iBWjFex6L3jZRiY0tos1GYBph0LFRsD3QwOeI9gR5W516CK13/M1XJmFWXqUf9skjw9FUDVkya2M/9I34VBpKWEVwxl1mzNRQ7svCmvmfP06XbcpeHE642SCCBZ6GolYJzyoC9IbZTiC00NwscZ72o9uhq5KDL1rILGTdfulZR5GD11AzBa4fq/egq02tU3C4N8UWdH93Q6y7X7baZvX7unwL+fD/R/U1XBbmzAniLMaHNBLury/wUu1wz9GY3x6KtEo13ImY8U4RaTZCvn0Hz7MhVlQrvx0qZn8/u8UpX+iB3KfvgsqEJvurqFIZeBlbwglCAlkEZspWyrIOGgV0rz8e2MIGnJQuOm2QxTRit0a0xJqRq/VEHAHY2I2mqqbr4rKJZqQS2vDr/HirKEzBvBVLMSpHTBIPQFwDvoHl2Z1iSdmtRRdmoFllJJxDVROyutEeg8xhvZNwQtIF8wuGSyL8s2Tu8zuJW815H8BpuDCDZWacRBrRgoXrdIiTK+0wQ2fvFx5BjbbXrQumZavPD92ciFN4uhMJ3Mqrx6sX6QVrAoP6Vo7uuyrlueeWZkstY35QVjAIGI10cPRbzbMqVQSG5OnTVBmS84h8bhlcA5yVShwXTI3+KEP9BHgMwT6WJikPZd0pUyln00PjbAYDSg6Rvnmc3/fs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(8676002)(83380400001)(16526019)(70206006)(70586007)(82310400005)(36860700001)(8936002)(6636002)(81166007)(6666004)(9686003)(40460700003)(26005)(2906002)(5660300002)(7696005)(7416002)(53546011)(186003)(336012)(47076005)(426003)(54906003)(55016003)(4326008)(316002)(6862004)(356005)(508600001)(67856001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 09:58:00.1082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5778bf79-c77a-40c2-398c-08da276b3f3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1757
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.04.22 10:13:19, Ravi Bangoria wrote:
> PMU driver can advertise certain feature via capability attribute('caps'
> sysfs directory) which can be consumed by userspace tools like perf. Add
> zen4_ibs_extensions capability attribute for IBS pmus. This attribute
> will be enabled when CPUID_Fn8000001B_EAX[11] is set.
> 
> Without patch:
> 
>   $ ls /sys/bus/event_source/devices/ibs_op/caps
>   ls: cannot access '/sys/.../ibs_op/caps': No such file or directory
> 
> With patch:
> 
>   $ ls /sys/bus/event_source/devices/ibs_op/caps
>   zen4_ibs_extensions
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  arch/x86/events/amd/ibs.c | 34 ++++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index a5303d62060c..54e12bd7843e 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -95,8 +95,10 @@ struct perf_ibs {
>  	struct cpu_perf_ibs __percpu	*pcpu;
>  
>  	struct attribute		**format_attrs;
> +	struct attribute		**caps_attrs;
>  	struct attribute_group		format_group;
> -	const struct attribute_group	*attr_groups[2];
> +	struct attribute_group		caps_group;
> +	const struct attribute_group	*attr_groups[3];

Also add a macro for max groups.

>  
>  	u64				(*get_count)(u64 config);
>  };
> @@ -522,10 +524,13 @@ PMU_FORMAT_ATTR(rand_en,	"config:57");
>  PMU_FORMAT_ATTR(cnt_ctl,	"config:19");
>  PMU_EVENT_ATTR_STRING(l3missonly, fetch_l3missonly, "config:59");
>  PMU_EVENT_ATTR_STRING(l3missonly, op_l3missonly, "config:16");
> +PMU_EVENT_ATTR_STRING(zen4_ibs_extensions, zen4_ibs_extensions, "1");
>  
>  /* size = nr attrs plus NULL at the end */
>  static struct attribute *ibs_fetch_format_attrs[3];
>  static struct attribute *ibs_op_format_attrs[3];
> +static struct attribute *ibs_fetch_caps_attrs[2];
> +static struct attribute *ibs_op_caps_attrs[2];
>  
>  static struct perf_ibs perf_ibs_fetch = {
>  	.pmu = {
> @@ -548,6 +553,7 @@ static struct perf_ibs perf_ibs_fetch = {
>  	.offset_mask		= { MSR_AMD64_IBSFETCH_REG_MASK },
>  	.offset_max		= MSR_AMD64_IBSFETCH_REG_COUNT,
>  	.format_attrs		= ibs_fetch_format_attrs,
> +	.caps_attrs		= ibs_fetch_caps_attrs,
>  
>  	.get_count		= get_ibs_fetch_count,
>  };
> @@ -574,6 +580,7 @@ static struct perf_ibs perf_ibs_op = {
>  	.offset_mask		= { MSR_AMD64_IBSOP_REG_MASK },
>  	.offset_max		= MSR_AMD64_IBSOP_REG_COUNT,
>  	.format_attrs		= ibs_op_format_attrs,
> +	.caps_attrs		= ibs_op_caps_attrs,
>  
>  	.get_count		= get_ibs_op_count,
>  };
> @@ -728,6 +735,7 @@ static __init int perf_ibs_pmu_init(struct perf_ibs *perf_ibs, char *name)
>  {
>  	struct cpu_perf_ibs __percpu *pcpu;
>  	int ret;
> +	int i = 0;

'group'? Use a pointer to iterate over groups here same as for attrs?

	struct attribute_group **group = &perf_ibs->attr_groups;

>  
>  	pcpu = alloc_percpu(struct cpu_perf_ibs);
>  	if (!pcpu)
> @@ -736,16 +744,26 @@ static __init int perf_ibs_pmu_init(struct perf_ibs *perf_ibs, char *name)
>  	perf_ibs->pcpu = pcpu;
>  
>  	/* register attributes */
> +	memset(&perf_ibs->attr_groups, 0, sizeof(perf_ibs->attr_groups));

With a termination below this could be dropped.

>  	if (perf_ibs->format_attrs[0]) {
>  		memset(&perf_ibs->format_group, 0, sizeof(perf_ibs->format_group));
> -		perf_ibs->format_group.name	= "format";
> -		perf_ibs->format_group.attrs	= perf_ibs->format_attrs;
> +		perf_ibs->format_group.name = "format";
> +		perf_ibs->format_group.attrs = perf_ibs->format_attrs;
>  
> -		memset(&perf_ibs->attr_groups, 0, sizeof(perf_ibs->attr_groups));
> -		perf_ibs->attr_groups[0]	= &perf_ibs->format_group;
> -		perf_ibs->pmu.attr_groups	= perf_ibs->attr_groups;
> +		perf_ibs->attr_groups[i++] = &perf_ibs->format_group;

So this could be:

		*groups++ = &perf_ibs->format_group

>  	}
>  
> +	if (perf_ibs->caps_attrs[0]) {
> +		memset(&perf_ibs->caps_group, 0, sizeof(perf_ibs->caps_group));
> +		perf_ibs->caps_group.name = "caps";
> +		perf_ibs->caps_group.attrs = perf_ibs->caps_attrs;
> +
> +		perf_ibs->attr_groups[i++] = &perf_ibs->caps_group;

Similar here.

> +	}

Add a terminating NULL pointer for groups here.

> +
> +	if (i)

	if (perf_ibs->attr_groups[0])
		...

> +		perf_ibs->pmu.attr_groups = perf_ibs->attr_groups;
> +
>  	ret = perf_pmu_register(&perf_ibs->pmu, name, -1);
>  	if (ret) {
>  		perf_ibs->pcpu = NULL;
> @@ -758,6 +776,7 @@ static __init int perf_ibs_pmu_init(struct perf_ibs *perf_ibs, char *name)
>  static __init void perf_ibs_fetch_prepare(void)
>  {
>  	struct attribute **format_attrs = perf_ibs_fetch.format_attrs;
> +	struct attribute **caps_attr = perf_ibs_fetch.caps_attrs;

Now I see why it was renamed, ok.

>  
>  	/*
>  	 * Some chips fail to reset the fetch count when it is written; instead
> @@ -773,6 +792,7 @@ static __init void perf_ibs_fetch_prepare(void)
>  	if (ibs_caps & IBS_CAPS_ZEN4IBSEXTENSIONS) {
>  		perf_ibs_fetch.config_mask |= IBS_FETCH_L3MISSONLY;
>  		*format_attrs++ = &fetch_l3missonly.attr.attr;
> +		*caps_attr++ = &zen4_ibs_extensions.attr.attr;
>  	}
>  
>  	perf_ibs_pmu_init(&perf_ibs_fetch, "ibs_fetch");
> @@ -781,6 +801,7 @@ static __init void perf_ibs_fetch_prepare(void)
>  static __init void perf_ibs_op_prepare(void)
>  {
>  	struct attribute **format_attrs = perf_ibs_op.format_attrs;
> +	struct attribute **caps_attr = perf_ibs_op.caps_attrs;
>  
>  	if (ibs_caps & IBS_CAPS_OPCNT) {
>  		perf_ibs_op.config_mask |= IBS_OP_CNT_CTL;
> @@ -796,6 +817,7 @@ static __init void perf_ibs_op_prepare(void)
>  	if (ibs_caps & IBS_CAPS_ZEN4IBSEXTENSIONS) {
>  		perf_ibs_op.config_mask |= IBS_OP_L3MISSONLY;
>  		*format_attrs++ = &op_l3missonly.attr.attr;
> +		*caps_attr++ = &zen4_ibs_extensions.attr.attr;
>  	}

Also add a termination for caps here.

-Robert

>  
>  	perf_ibs_pmu_init(&perf_ibs_op, "ibs_op");
> -- 
> 2.27.0
> 
