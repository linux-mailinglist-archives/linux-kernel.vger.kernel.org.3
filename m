Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B612E50FBF1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 13:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiDZLac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 07:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349536AbiDZLaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 07:30:25 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2051.outbound.protection.outlook.com [40.107.102.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654505A5B5;
        Tue, 26 Apr 2022 04:27:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiUOowCKm4ulM34eCnRW2SDVonD30EtapAbhfh+Egd45lH1Ij4+bBTMrIRKF3yDW4T7owj2i9eUUs8yuy1sLTK4NETetCKv7QRtKb3rU0Oi8jjM18j+qPWDkSaapnfcltBPHUWyp1zC9UTQPMYp6++nhwRzhBwiW1kTKDEUumhgihsKTwgK43CcJz5oyLXTffiApJU0djFzmicrhBUNIEMwNQlKJmXFZGsVHdknTAvSX2nhxp4O7A8Nf5X9tsym1bRcvCn/osP8+ztNKG6ozW3WlNnMyVMlXoEkUiM5xWfdzXpolO2aUyTyxztDqaBsVQZ0Fqv8aPxCQrveSYLsLxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIJuVIhoLcMxOfvppmmSSKkYNXK4RRNCzOE6mcchtUA=;
 b=WFIvjn8vVAevtHCpYyfYvliUpSK+9Ak6xaV+ZM3n6oHXro04tiui4zavtOsWjrQgsSqaTo497NgzwcJ57J3RKvsVvAZhGgXZAdjxdFPdZ5chGAF+CFQa85gmD1b9OrPUABCa3FZZQMLnkM59Ant9X82rUBSeGiPLibh5GshG1le9CtqDkLR42I/mcG/m1qKdLLjnShyJvIeu/GMtEJ+JuITWYennpIMYy2lemk7BaWIZpeHs6AbAAfGUVZhzELqC9bjayBJFWQDH+/ewTVvDPUUBF1lvV3O01UVNPEmUP4Or8fa1MpH8DcuE3ne8L0G4Crlf21IXElHdpCHooiA5Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIJuVIhoLcMxOfvppmmSSKkYNXK4RRNCzOE6mcchtUA=;
 b=TfGHa+sfko5fu2rtMz6dvdEsOX5nR45G1RakQuXbRT+WBlhzBjlBv37Bu9zfgoS2IropIrqWGlBPK7z0YZWN7YmMaUoxWZjxW5AGD7qWOjI5f2FPA+ZnGc1evnWD6ykSDpGEq2G76byrCZxk1kCSBLkbX8VsV9Dmkt3p2bjkg1g=
Received: from MW4PR04CA0295.namprd04.prod.outlook.com (2603:10b6:303:89::30)
 by CY4PR12MB1669.namprd12.prod.outlook.com (2603:10b6:910:3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 11:27:14 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::41) by MW4PR04CA0295.outlook.office365.com
 (2603:10b6:303:89::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Tue, 26 Apr 2022 11:27:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 11:27:14 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 06:27:10 -0500
Date:   Tue, 26 Apr 2022 13:27:07 +0200
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
Subject: Re: [PATCH 5/6] perf/tool/amd/ibs: Support new IBS bits in raw trace
 dump
Message-ID: <YmfXC9KrsM0xTqY9@rric.localdomain>
References: <20220425044323.2830-1-ravi.bangoria@amd.com>
 <20220425044323.2830-6-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220425044323.2830-6-ravi.bangoria@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70d6e362-d0ea-46c3-9398-08da2777b694
X-MS-TrafficTypeDiagnostic: CY4PR12MB1669:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1669B889B61B74A22E05318E9CFB9@CY4PR12MB1669.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FWY853fx/yk7Adhqe+QkWCwNUkR+WCgytxsq9B8DrezdBfZHMtd0FRTBPbC/CDU77RVtqVwy6ak7m5KLI0HT0z4VVKT3eQ2UET/CmUAnp4MU0f6MKYXsmEEnNwEAsv/Y7b6gGcVuhcuvTqDYnZkWsURU+YUlCTpM9ptFEMWTH/V8sHK3oy/D5e4tWhKf0mTbSc6kX0/EnSN5/b9y/FvdNqTKjMzfUA1gIXIrRoMsgT40hrI1PDLrWk3AXJNBUKaqXUAjnNsW6gXCcKRk0FW57AjzX7jHXCayvuOiVJOTG7/iKj/HtHGUX2Uszgsa1VZd/4o/C5f0bitvJPke1mOw8y7acQ3YmSIrmOB2HmpecG+cpWBAbpzsWFYKOHiTDxckCgXKlGAEkPNAHYkcvT3WiKWSyTN05FY0Ru9/WO37hEyrW3W/lR4XZ0zJvOonfpU7gsZRctNvhQdX6sHfpQNlE/k4zR9BcBDSh7/7fwwlrBoLsMEBObt8ftCdPhkOavsI65sWa5VH/SO8lyz/uJt+iRgIBJqt9xbrxHU596gqWOrxT2hFf+08/zPMbKkIZdC63MTO/9QhGONk59CgC1cwQlPPV30JTAT55MTJIcydo2yhqCX2xcVW9TJw9lH4wDuVYX09DX9Cs/e4rqVGVmxfw3Y2t1F8HSGFyOcx8NWKmD+u40EDw7tzFcY+kakPT1jlSCDVlypz+cPZUpCs37dC9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(7696005)(6666004)(70206006)(70586007)(4326008)(8676002)(6862004)(36860700001)(6636002)(4744005)(8936002)(9686003)(508600001)(186003)(26005)(53546011)(40460700003)(82310400005)(5660300002)(2906002)(16526019)(7416002)(81166007)(54906003)(316002)(47076005)(426003)(356005)(336012)(55016003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 11:27:14.2253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d6e362-d0ea-46c3-9398-08da2777b694
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1669
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.04.22 10:13:22, Ravi Bangoria wrote:

> @@ -71,11 +74,12 @@ union ibs_op_data {
>  union ibs_op_data2 {
>  	__u64 val;
>  	struct {
> -		__u64	data_src:3,	/* 0-2: data source */
> +		__u64	data_src_lo:3,	/* 0-2: data source low */
>  			reserved0:1,	/* 3: reserved */
>  			rmt_node:1,	/* 4: destination node */
>  			cache_hit_st:1,	/* 5: cache hit state */
> -			reserved1:57;	/* 5-63: reserved */
> +			data_src_hi:2,	/* 6-7: data source high */
> +			reserved1:56;	/* 8-63: reserved */

Good catch, bit 63 was not defined before.

>  	};
>  };

> @@ -279,6 +328,9 @@ bool evlist__has_amd_ibs(struct evlist *evlist)
>  		pmu_mapping += strlen(pmu_mapping) + 1 /* '\0' */;
>  	}
>  
> +	if (perf_env__find_pmu_cap(env, 0, "ibs_op", "zen4_ibs_extensions"))
> +		zen4_ibs_extensions = 1;
> +

This caps check should be moved to ibs_op and ibs_fetch pmu specific
code. Use the env of the specific pmu respectively in the sample
decoding.

-Robert

>  	if (ibs_fetch_type || ibs_op_type) {
>  		if (!cpu_family)
>  			parse_cpuid(env);
