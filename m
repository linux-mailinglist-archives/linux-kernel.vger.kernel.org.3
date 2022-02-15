Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1FE4B5FF9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 02:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbiBOBXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 20:23:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiBOBXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 20:23:33 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58049CC529;
        Mon, 14 Feb 2022 17:23:24 -0800 (PST)
Received: from kwepemi100004.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JyNXP6pc7zZffQ;
        Tue, 15 Feb 2022 09:19:01 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi100004.china.huawei.com (7.221.188.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Feb 2022 09:23:21 +0800
Received: from [10.67.101.67] (10.67.101.67) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 15 Feb
 2022 09:23:21 +0800
Subject: Re: [PATCH 2/2] perf jevents: Add support for HiSilicon CPA PMU
 aliasing
To:     Qi Liu <liuqi115@huawei.com>, <will@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <zhangshaokun@hisilicon.com>,
        Linuxarm <linuxarm@huawei.com>, <mingo@redhat.com>,
        <acme@kernel.org>, <linux-perf-users@vger.kernel.org>,
        <peterz@infradead.org>
References: <20220214114228.40859-1-liuqi115@huawei.com>
 <20220214114228.40859-3-liuqi115@huawei.com>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <e8360562-4e09-c2ed-9584-054a0b3d01bf@huawei.com>
Date:   Tue, 15 Feb 2022 09:23:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220214114228.40859-3-liuqi115@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.101.67]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



+CC perf tool list and maintainers.

Qi

On 2022/2/14 19:42, Qi Liu wrote:
> Add support for HiSilicon CPA PMU aliasing.
> 
> The kernel driver is in drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c
> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> ---
>   .../arm64/hisilicon/hip09/sys/uncore-cpa.json | 81 +++++++++++++++++++
>   tools/perf/pmu-events/jevents.c               |  1 +
>   2 files changed, 82 insertions(+)
>   create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-cpa.json
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-cpa.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-cpa.json
> new file mode 100644
> index 000000000000..35c90da7f54b
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-cpa.json
> @@ -0,0 +1,81 @@
> +[
> +	{
> +		"ConfigCode": "0x00",
> +		"EventName": "cpa_cycles",
> +		"BriefDescription": "count of CPA cycles",
> +		"Compat": "0x00000030",
> +		"Unit": "hisi_sicl,cpa"
> +	},
> +	{
> +		"ConfigCode": "0x61",
> +		"EventName": "p1_wr_dat",
> +		"BriefDescription": "Number of write ops transmitted by the P1 port",
> +		"Compat": "0x00000030",
> +		"Unit": "hisi_sicl,cpa"
> +	},
> +	{
> +		"ConfigCode": "0x62",
> +		"EventName": "p1_rd_dat",
> +		"BriefDescription": "Number of read ops transmitted by the P1 port",
> +		"Compat": "0x00000030",
> +		"Unit": "hisi_sicl,cpa"
> +	},
> +	{
> +		"ConfigCode": "0x3",
> +		"EventName": "p1_rd_dat_64b",
> +		"BriefDescription": "Number of read ops transmitted by the P1 port which size is 64 bytes",
> +		"Compat": "0x00000030",
> +		"Unit": "hisi_sicl,cpa"
> +	},
> +	{
> +		"ConfigCode": "0x4",
> +		"EventName": "p1_rd_dat_32b",
> +		"BriefDescription": "Number of read ops transmitted by the P1 port which size is 32 bytes",
> +		"Compat": "0x00000030",
> +		"Unit": "hisi_sicl,cpa"
> +	},
> +	{
> +		"ConfigCode": "0xE1",
> +		"EventName": "p0_wr_dat",
> +		"BriefDescription": "Number of write ops transmitted by the P0 port",
> +		"Compat": "0x00000030",
> +		"Unit": "hisi_sicl,cpa"
> +	},
> +	{
> +		"ConfigCode": "0xE2",
> +		"EventName": "p0_rd_dat",
> +		"BriefDescription": "Number of read ops transmitted by the P0 port",
> +		"Compat": "0x00000030",
> +		"Unit": "hisi_sicl,cpa"
> +	},
> +	{
> +		"ConfigCode": "0x83",
> +		"EventName": "p0_rd_dat_64b",
> +		"BriefDescription": "Number of read ops transmitted by the P0 port which size is 64 bytes",
> +		"Compat": "0x00000030",
> +		"Unit": "hisi_sicl,cpa"
> +	},
> +	{
> +		"ConfigCode": "0x84",
> +		"EventName": "p0_rd_dat_32b",
> +		"BriefDescription": "Number of read ops transmitted by the P0 port which size is 32 bytes",
> +		"Compat": "0x00000030",
> +		"Unit": "hisi_sicl,cpa"
> +	},
> +	{
> +		"MetricExpr": "(p1_wr_dat * 64 + p1_rd_dat_64b * 64 + p1_rd_dat_32b * 32) / cpa_cycles",
> +		"BriefDescription": "Average bandwidth of CPA Port 1",
> +		"MetricGroup": "CPA",
> +		"MetricName": "p1_avg_bw",
> +		"Compat": "0x00000030",
> +		"Unit": "hisi_sicl,cpa"
> +	},
> +	{
> +		"MetricExpr": "(p0_wr_dat * 64 + p0_rd_dat_64b * 64 + p0_rd_dat_32b * 32) / cpa_cycles",
> +		"BriefDescription": "Average bandwidth of CPA Port 0",
> +		"MetricGroup": "CPA",
> +		"MetricName": "p0_avg_bw",
> +		"Compat": "0x00000030",
> +		"Unit": "hisi_sicl,cpa"
> +	}
> +]
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index 1a57c3f81dd4..159d9eab6e79 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -277,6 +277,7 @@ static struct map {
>   	{ "CPU-M-CF", "cpum_cf" },
>   	{ "CPU-M-SF", "cpum_sf" },
>   	{ "UPI LL", "uncore_upi" },
> +	{ "hisi_sicl,cpa", "hisi_sicl,cpa"},
>   	{ "hisi_sccl,ddrc", "hisi_sccl,ddrc" },
>   	{ "hisi_sccl,hha", "hisi_sccl,hha" },
>   	{ "hisi_sccl,l3c", "hisi_sccl,l3c" },
> 
