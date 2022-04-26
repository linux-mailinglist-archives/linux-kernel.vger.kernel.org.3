Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3AC50FAA9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349040AbiDZKdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349080AbiDZKbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:31:50 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CA3114F82;
        Tue, 26 Apr 2022 03:10:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqYib8/g7KbuUHzPvhUWe1fwqc3Iok6LLiIDTTQtjB6wlpD6Ql/2yYbWblCWKXTCP5/zVvTC2rskSxohdc66rdhrzI4jIxV3qRd7ehiOIfIYoMSisjRzbYoKHATNOWJ1AxXqUjtSjNKRAidSsuVf3Od9X5H2hqvwtOUhiP2/Smg/akZWJ3YZ312qaYybVYTspyWT+Ve7V5zed+Rae81ZuQ/9PSEp6bk7zZXfOqkg7O3utisR88AZhCbYNw5DoiAdBwxfCukyB1MBtGPoHj8+mbZsrFs60UM2a7Sl4mzbnribAEekdz7UaXkFe5ALEd6raz9IoQF1TS1rHdVS3Orp3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAgj1g5Plfq+RXhzrxFlwpB9TVwD+WVrjXlS/8D/6CM=;
 b=XVHCsaEUBw0hKahB/99Qn+klHfXxsAiE/Aj3+q/cqWm8NSBU8u6eBiz1YlI3Jgr1dinbOg1wIRuDFrgZyqvvVa5WADj3gzKKsPm8AayoheQxOQOacetDsKJWTQeCpvodKKIm87UFLusMS6aP40yr3JUB+ylv7yyiu9smy1jmn/VuaT5NqUpHtqqDakq/N/WsKJ/ZeoPmgYrq4kxL4NBcy7lYLhzjPgMOQnq2TDQmZU1hdn1r/NroPNUnyxBDbvx6u3Om3XeRiqaPhF5fV+SvnqBNFwIcbPLKxvREYZX5UROv/6+Kt+vxVOMHhwIkItPTHm+c79kN9bJ5MQv20bPMkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAgj1g5Plfq+RXhzrxFlwpB9TVwD+WVrjXlS/8D/6CM=;
 b=LK/fD1HsjLe1DJao8SSF7CgEmzOLEX584Tcs9WzN7B3Hzpjgr92YWVK8zvwFe47PKWpcxhXwpTUk5KecvjPUoW8bHZTQNmm7sx4yO3FI/dAJs/5stbAMNUfckQFyArk03VUoZmk8fLpw0CvLU6hE+hMhy2zzEoOOUnvTOg0HVSE=
Received: from MW4P222CA0030.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::35)
 by DM5PR1201MB0201.namprd12.prod.outlook.com (2603:10b6:4:5b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 10:10:06 +0000
Received: from CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::b) by MW4P222CA0030.outlook.office365.com
 (2603:10b6:303:114::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Tue, 26 Apr 2022 10:10:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT053.mail.protection.outlook.com (10.13.175.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 10:10:05 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 05:09:49 -0500
Date:   Tue, 26 Apr 2022 12:09:47 +0200
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
Subject: Re: [PATCH 3/6] perf/tool/amd/ibs: Warn about sampling period skew
Message-ID: <YmfE6wIA1Dbet1nX@rric.localdomain>
References: <20220425044323.2830-1-ravi.bangoria@amd.com>
 <20220425044323.2830-4-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220425044323.2830-4-ravi.bangoria@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6dd07ea0-5cb5-4a7d-a2f3-08da276cef62
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0201:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0201BB90E39931743B2679C99CFB9@DM5PR1201MB0201.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zhk+q4fD6Bj5ClEA6X85jC0/pr0II1lzEJE3s9OX4byD6Z6rkV1hvTjkWkucTw4zgH5ujY+pjzma8Va255AnkQ6Bzy+aOJF48Ob8JxeCMi6lN1BBoY1rBSKSekNbodiTXtx/9cALTTBVYGvGRZFIRHaeUFewLxzEcJcQkhmxKQNhezybHloHlPAJRXnwRrkf+qbn6Pn8WEVA0U7ypeIoE4p1wccGTGACA34mIs5FGYcNTFV7AdAzKabuGlX+O21UmvjrKo606hT95pxj4HOOBamze0i5jX8o+dX62rGkGTn8NdronnmL4+fDzbiDWPzdgKOVtcjZiJKOCWtUwaWnNQm5nyerpO6gdRLq7SYtCdC1EP/kihdmLLrPUcngC8mrIApwDgR1X2kJ6lpVPyyCAHK1GtE4o/om4XM7gf6MfEkrfs4+O8nSZG0h+RkixmgwqeezJ2GTPDc5HtsPiUQEMakD3tigqNO1qoDksLD596Iq+yZqcfFHSmyQqA8aezVzscTIE2j9vJsZgcJShuD+lGjGUWinxCz7Mc2Iwk1XP+nc+jquMQ4iYnVu9gj/6Tt0+cVGj7GO6Ae6u33PTBfdrv5+9xQNHpus2v+zskIKyZ1+c8OLkqxc9upEHAOlwp/CvqDnW8mYibifBYlE2F999ypEu0jYkIkPOadsYXCQp7dDrms2vIXGq4khlR4fmuJfgFeqeiJ9Dqwk1BRg/Vbrwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(508600001)(55016003)(316002)(82310400005)(7416002)(8936002)(36860700001)(8676002)(6862004)(81166007)(40460700003)(6636002)(336012)(426003)(70586007)(53546011)(47076005)(54906003)(70206006)(186003)(16526019)(5660300002)(9686003)(4326008)(2906002)(83380400001)(356005)(7696005)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 10:10:05.0797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd07ea0-5cb5-4a7d-a2f3-08da276cef62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0201
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.04.22 10:13:20, Ravi Bangoria wrote:

> @@ -29,3 +31,32 @@ void arch_evsel__fixup_new_cycles(struct perf_event_attr *attr)
>  
>  	free(env.cpuid);
>  }
> +
> +void arch_evsel__warn_ambiguity(struct evsel *evsel, struct perf_event_attr *attr)

Have an 'ibs_' string in the name?

> +{
> +	struct perf_env *env = evsel__env(evsel);
> +	struct perf_pmu *evsel_pmu = evsel__find_pmu(evsel);
> +	struct perf_pmu *ibs_fetch_pmu = perf_pmu__find("ibs_fetch");
> +	struct perf_pmu *ibs_op_pmu = perf_pmu__find("ibs_op");
> +	static int warned_once;
> +
> +	if (warned_once || !perf_env__cpuid(env) || !env->cpuid ||
> +	    !strstarts(env->cpuid, "AuthenticAMD") || !evsel_pmu)
> +		return;
> +
> +	if (ibs_fetch_pmu && ibs_fetch_pmu->type == evsel_pmu->type) {
> +		if (attr->config & (1ULL << 59)) {
> +			pr_warning(
> +"WARNING: Hw internally resets sampling period when L3 Miss Filtering is enabled\n"
> +"and tagged operation does not cause L3 Miss. This causes sampling period skew.\n");
> +			warned_once = 1;
> +		}
> +	} else if (ibs_op_pmu && ibs_op_pmu->type == evsel_pmu->type) {
> +		if (attr->config & (1ULL << 16)) {
> +			pr_warning(
> +"WARNING: Hw internally resets sampling period when L3 Miss Filtering is enabled\n"
> +"and tagged operation does not cause L3 Miss. This causes sampling period skew.\n");

Avoid duplicate code. You could move it to the end of the function and
early return if the config bit is not set.

> +			warned_once = 1;
> +		}
> +	}
> +}

-Robert
