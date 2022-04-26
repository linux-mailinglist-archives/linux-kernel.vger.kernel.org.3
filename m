Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E9950F945
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243330AbiDZKAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348223AbiDZJ77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 05:59:59 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910C243AC7;
        Tue, 26 Apr 2022 02:18:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlA7Ya2qxh5ll0X2mIQw7by0LBK1DGG55UrnY1xBzruRByPzL8amQj4MGBgeq+k0b96db72iBqIyfxz5DftbGR6m/yZ0+hAjbJefxaQ/SOmZh8spcdQCNaQPWZfjD1PkCpnHN2EBbt+JxRUNUfJunZYzzGzftL1paZrlx/Bxk2Y8mpSpWJU3tK6libG8qUO0G+RJMw0GAQ4y+iIXwrnEOzKZRawFb7YBKYRVUDpWUOOhTnuaRDYVR+1rTxqY4ty5jRyfXEIgCcCOfCkOvef+0d0qozDC7gMtQWFhzn1HA28+MsoPQQABeWZsw6NrtahWsCnSepSLTQfeN2ovXG1D9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clZOEyd5mGPu48DgfKTO763lXp1b3kcHNw3vqh94gZQ=;
 b=QlvByKtcVnXZ8AJxfzY0a8Uf8ZAs8E+eYgF90kWpxBjQcU7SDJsUbYdzjYkkggeYdiEarD61hwPHpeJThqOpEOInTgU9T45w5nXRxE9ZrTwhLH3BlvosDABcA8CWo+ytDg1o8vd33HqQbYL0POG7/K/kaum9RJUmWa6QgLpAcpramuLOKq1dbsWmAkc+Yfg95NdJt2SLhkw8zYzvYMVAx4gw248PaTJ1BwEHzpJCAvshkjQfitQrtnrw4CshDK6lEnlrFQX96CBmcqWSqIegV+4wni+oqfJ3kY3S3gtB5tfIFmDKMNBWJSrTpBE/Q9P/+ed1jt60XyYwYEel+1pprw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clZOEyd5mGPu48DgfKTO763lXp1b3kcHNw3vqh94gZQ=;
 b=tSZb06794OjtmZBbyM1+6Gz5YU4oA67mMmyB9oQ0SHQUl6kJGHEBBtnIBhAdEcCMVUARyRCCtnko/9C13AwzUSV8DTNN6ECe/qnqYTh474TQK+PioxrHOox5qWs6KSYfYcc96jEvq7z82KBw7Sir1iT4HxqP8Lc6QrW2bzCYcpM=
Received: from DS7PR03CA0124.namprd03.prod.outlook.com (2603:10b6:5:3b4::9) by
 BL0PR12MB4994.namprd12.prod.outlook.com (2603:10b6:208:1ca::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 09:18:16 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::5c) by DS7PR03CA0124.outlook.office365.com
 (2603:10b6:5:3b4::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Tue, 26 Apr 2022 09:18:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 09:18:15 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 04:18:11 -0500
Date:   Tue, 26 Apr 2022 11:18:08 +0200
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
Subject: Re: [PATCH 1/6] perf/amd/ibs: Add support for L3 miss filtering
Message-ID: <Yme40JIJzdVTsC1h@rric.localdomain>
References: <20220425044323.2830-1-ravi.bangoria@amd.com>
 <20220425044323.2830-2-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220425044323.2830-2-ravi.bangoria@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee6afc1f-8887-424c-f089-08da2765b229
X-MS-TrafficTypeDiagnostic: BL0PR12MB4994:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB4994A5F8C617785CFA7A57159CFB9@BL0PR12MB4994.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V0camWokpeShMNiZ85BJ3VpNh4ZFMXKfP7LrkV0263IURE7AF57inhGKH9646SyT27uu6ihAED3Hhj1KcKaguPxoZBSJeZmOstsR9ISpoVGbKdeEqxMhg7Mmnc4PQUAAwfOBfw7YuOwGv7kffAGMhAI+FyrY/crVH97tVDueE8E1cc6KzGAM5IIyfVVtGnm7JJx6/yehaQ/PjFceILoqePNmtZSu3f6c7VrEDyNu+H0FbrcdoXVDV0ipGfA5USpdDJbskmGy0LynSXo6yVWoPaq+Q5/DqvBprRD4jwwuBZi+APvmWDIXcbZk5I/3BtHkqMWGFBZhWREtv9u43FfiWeRIXPmTNWBlgN6ZN+muSKbl36A29CLedEBuLT0dncSPYtzrAJWTYb3LQMZMv0M9eIWKyOHEKBXLWv8w6qJYrOrmrrkHiPvv19XIkxqHsxYwMHGdoT4M1y0Sl+uezvX1+4MK6BiARx6H+1iJswnzzg6PHtH9XDlzAOTJoeK8utqJySXkwspShEeVcA4Wd4QJMfBB43yCeK7aKAifqYNkvFhAoVuriEmOM7OZXrfo1NK7RvSxjvpzYfEi3CH7r6MFncXENIkC5gLs3I3ZbJm8OzgbhxNtVQ3ip4fy7p9ssmEwWdfHLiSwRrSaOIeZh7jsHIzDKTea5KYz2q7WnHehz7wT8gqcVPHX7fZfbwDipWZKEBZfrO6Dg7aPSMeQOxx61A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(426003)(336012)(47076005)(16526019)(186003)(6862004)(70206006)(70586007)(316002)(83380400001)(9686003)(508600001)(8676002)(4326008)(7696005)(26005)(6666004)(82310400005)(5660300002)(53546011)(356005)(2906002)(6636002)(8936002)(54906003)(7416002)(36860700001)(55016003)(40460700003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 09:18:15.9682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee6afc1f-8887-424c-f089-08da2765b229
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4994
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.04.22 10:13:18, Ravi Bangoria wrote:
> IBS L3 miss filtering works by tagging an instruction on IBS counter
> overflow and generating an NMI if the tagged instruction causes an L3
> miss. Samples without an L3 miss are discarded and counter is reset
> with random value (between 1-15 for fetch pmu and 1-127 for op pmu).
> This helps in reducing sampling overhead when user is interested only
> in such samples. One of the use case of such filtered samples is to
> feed data to page-migration daemon in tiered memory systems.
> 
> Add support for L3 miss filtering in IBS driver via new pmu attribute
> "l3missonly". Example usage:
> 
>   # perf record -a -e ibs_op/l3missonly=1/ --raw-samples sleep 5
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  arch/x86/events/amd/ibs.c         | 42 ++++++++++++++++++++++---------
>  arch/x86/include/asm/perf_event.h |  3 +++
>  2 files changed, 33 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index 9739019d4b67..a5303d62060c 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -520,16 +520,12 @@ static void perf_ibs_read(struct perf_event *event) { }
>  
>  PMU_FORMAT_ATTR(rand_en,	"config:57");
>  PMU_FORMAT_ATTR(cnt_ctl,	"config:19");
> +PMU_EVENT_ATTR_STRING(l3missonly, fetch_l3missonly, "config:59");
> +PMU_EVENT_ATTR_STRING(l3missonly, op_l3missonly, "config:16");
>  
> -static struct attribute *ibs_fetch_format_attrs[] = {
> -	&format_attr_rand_en.attr,
> -	NULL,
> -};
> -
> -static struct attribute *ibs_op_format_attrs[] = {
> -	NULL,	/* &format_attr_cnt_ctl.attr if IBS_CAPS_OPCNT */
> -	NULL,
> -};
> +/* size = nr attrs plus NULL at the end */
> +static struct attribute *ibs_fetch_format_attrs[3];
> +static struct attribute *ibs_op_format_attrs[3];

Define a macro for the array size.

>  
>  static struct perf_ibs perf_ibs_fetch = {
>  	.pmu = {
> @@ -759,9 +755,9 @@ static __init int perf_ibs_pmu_init(struct perf_ibs *perf_ibs, char *name)
>  	return ret;
>  }
>  
> -static __init void perf_event_ibs_init(void)
> +static __init void perf_ibs_fetch_prepare(void)

Since this actually initializes the pmu, let's call that
perf_ibs_fetch_init().

For low level init functions it would be good to keep track of the
return code even if it is later not evaluated. So these kind of
function should return an error code.

>  {
> -	struct attribute **attr = ibs_op_format_attrs;
> +	struct attribute **format_attrs = perf_ibs_fetch.format_attrs;

I think we could keep this short here with 'attr'.

>  
>  	/*
>  	 * Some chips fail to reset the fetch count when it is written; instead
> @@ -773,11 +769,22 @@ static __init void perf_event_ibs_init(void)
>  	if (boot_cpu_data.x86 == 0x19 && boot_cpu_data.x86_model < 0x10)
>  		perf_ibs_fetch.fetch_ignore_if_zero_rip = 1;
>  
> +	*format_attrs++ = &format_attr_rand_en.attr;
> +	if (ibs_caps & IBS_CAPS_ZEN4IBSEXTENSIONS) {
> +		perf_ibs_fetch.config_mask |= IBS_FETCH_L3MISSONLY;
> +		*format_attrs++ = &fetch_l3missonly.attr.attr;
> +	}

You should also write the terminating NULL pointer here, though the
mem is preinitialized zero.

> +
>  	perf_ibs_pmu_init(&perf_ibs_fetch, "ibs_fetch");
> +}
> +
> +static __init void perf_ibs_op_prepare(void)
> +{
> +	struct attribute **format_attrs = perf_ibs_op.format_attrs;
>  
>  	if (ibs_caps & IBS_CAPS_OPCNT) {
>  		perf_ibs_op.config_mask |= IBS_OP_CNT_CTL;
> -		*attr++ = &format_attr_cnt_ctl.attr;
> +		*format_attrs++ = &format_attr_cnt_ctl.attr;
>  	}
>  
>  	if (ibs_caps & IBS_CAPS_OPCNTEXT) {
> @@ -786,7 +793,18 @@ static __init void perf_event_ibs_init(void)
>  		perf_ibs_op.cnt_mask    |= IBS_OP_MAX_CNT_EXT_MASK;
>  	}
>  
> +	if (ibs_caps & IBS_CAPS_ZEN4IBSEXTENSIONS) {
> +		perf_ibs_op.config_mask |= IBS_OP_L3MISSONLY;
> +		*format_attrs++ = &op_l3missonly.attr.attr;
> +	}
> +
>  	perf_ibs_pmu_init(&perf_ibs_op, "ibs_op");
> +}

Same for this function: *_init(), error code, attrs, terminating NULL.

> +
> +static __init void perf_event_ibs_init(void)
> +{
> +	perf_ibs_fetch_prepare();
> +	perf_ibs_op_prepare();
>  
>  	register_nmi_handler(NMI_LOCAL, perf_ibs_nmi_handler, 0, "perf_ibs");
>  	pr_info("perf: AMD IBS detected (0x%08x)\n", ibs_caps);

The function is now small enough to be squashed into amd_ibs_init().

-Robert
