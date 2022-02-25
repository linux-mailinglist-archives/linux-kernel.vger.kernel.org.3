Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A3C4C4DE1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 19:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbiBYSf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 13:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbiBYSf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:35:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973C71C57D6;
        Fri, 25 Feb 2022 10:34:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CE1461E7A;
        Fri, 25 Feb 2022 18:34:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68290C340E7;
        Fri, 25 Feb 2022 18:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645814092;
        bh=TVmbNKyXM5tr3OV/MfK1q8iiXyx+5ewnxH4+yo4YrAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sfCYPwMm5KHKsjxYaH46kkEk3v6RbpCiN/dPraqbj1tQmplyraTv4HVn/l3g20Ctu
         m7J0LFPUl9uo+wy8305wlYbO7KoE1ysubMllgdKiWCXtvKSySdq6sqN39i6KS56FtL
         38kgrp/e3evOP8vVZsBOiTsg8pZzeuv5aEodknNvEzfvmlbzRgksPT09PeYKQkVJ+q
         cahevypVsrv4qm6v4rOmZDq31oh6BLePFOQg6PQeBSHFuKujIUS4JdhHpOoPQsNA1p
         4vs3RsDs1trGHAWEul8prDxvV171oCVVK2NGUGfv63WE3Q81r5iAnKG6XRWkAJoN4X
         IwM0HITTWEuJA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5901A403C8; Fri, 25 Feb 2022 15:34:49 -0300 (-03)
Date:   Fri, 25 Feb 2022 15:34:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Qi Liu <liuqi115@huawei.com>
Cc:     will@kernel.org, mark.rutland@arm.com, john.garry@huawei.com,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v2 2/2] perf jevents: Add support for HiSilicon CPA PMU
 aliasing
Message-ID: <YhkhSZp+a715Ldzr@kernel.org>
References: <20220224111129.41416-1-liuqi115@huawei.com>
 <20220224111129.41416-3-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224111129.41416-3-liuqi115@huawei.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 24, 2022 at 07:11:29PM +0800, Qi Liu escreveu:
> Add support for HiSilicon CPA PMU aliasing.
> 
> The kernel driver is in drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c

Thanks, applied the tools/perf part, the drivers/perf/ should go via the
kernel maintainer for this area. From what I see its not yet merged.

- Arnaldo

 
> Reviewed-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> ---
>  .../arm64/hisilicon/hip09/sys/uncore-cpa.json | 81 +++++++++++++++++++
>  tools/perf/pmu-events/jevents.c               |  1 +
>  2 files changed, 82 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-cpa.json
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-cpa.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-cpa.json
> new file mode 100644
> index 000000000000..7bcddec8a84f
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
> +		"EventName": "cpa_p1_wr_dat",
> +		"BriefDescription": "Number of write ops transmitted by the P1 port",
> +		"Compat": "0x00000030",
> +		"Unit": "hisi_sicl,cpa"
> +	},
> +	{
> +		"ConfigCode": "0x62",
> +		"EventName": "cpa_p1_rd_dat",
> +		"BriefDescription": "Number of read ops transmitted by the P1 port",
> +		"Compat": "0x00000030",
> +		"Unit": "hisi_sicl,cpa"
> +	},
> +	{
> +		"ConfigCode": "0x3",
> +		"EventName": "cpa_p1_rd_dat_64b",
> +		"BriefDescription": "Number of read ops transmitted by the P1 port which size is 64 bytes",
> +		"Compat": "0x00000030",
> +		"Unit": "hisi_sicl,cpa"
> +	},
> +	{
> +		"ConfigCode": "0x4",
> +		"EventName": "cpa_p1_rd_dat_32b",
> +		"BriefDescription": "Number of read ops transmitted by the P1 port which size is 32 bytes",
> +		"Compat": "0x00000030",
> +		"Unit": "hisi_sicl,cpa"
> +	},
> +	{
> +		"ConfigCode": "0xE1",
> +		"EventName": "cpa_p0_wr_dat",
> +		"BriefDescription": "Number of write ops transmitted by the P0 port",
> +		"Compat": "0x00000030",
> +		"Unit": "hisi_sicl,cpa"
> +	},
> +	{
> +		"ConfigCode": "0xE2",
> +		"EventName": "cpa_p0_rd_dat",
> +		"BriefDescription": "Number of read ops transmitted by the P0 port",
> +		"Compat": "0x00000030",
> +		"Unit": "hisi_sicl,cpa"
> +	},
> +	{
> +		"ConfigCode": "0x83",
> +		"EventName": "cpa_p0_rd_dat_64b",
> +		"BriefDescription": "Number of read ops transmitted by the P0 port which size is 64 bytes",
> +		"Compat": "0x00000030",
> +		"Unit": "hisi_sicl,cpa"
> +	},
> +	{
> +		"ConfigCode": "0x84",
> +		"EventName": "cpa_p0_rd_dat_32b",
> +		"BriefDescription": "Number of read ops transmitted by the P0 port which size is 32 bytes",
> +		"Compat": "0x00000030",
> +		"Unit": "hisi_sicl,cpa"
> +	},
> +	{
> +		"MetricExpr": "(cpa_p1_wr_dat * 64 + cpa_p1_rd_dat_64b * 64 + cpa_p1_rd_dat_32b * 32) / cpa_cycles",
> +		"BriefDescription": "Average bandwidth of CPA Port 1",
> +		"MetricGroup": "CPA",
> +		"MetricName": "cpa_p1_avg_bw",
> +		"Compat": "0x00000030",
> +		"Unit": "hisi_sicl,cpa"
> +	},
> +	{
> +		"MetricExpr": "(cpa_p0_wr_dat * 64 + cpa_p0_rd_dat_64b * 64 + cpa_p0_rd_dat_32b * 32) / cpa_cycles",
> +		"BriefDescription": "Average bandwidth of CPA Port 0",
> +		"MetricGroup": "CPA",
> +		"MetricName": "cpa_p0_avg_bw",
> +		"Compat": "0x00000030",
> +		"Unit": "hisi_sicl,cpa"
> +	}
> +]
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index 1a57c3f81dd4..159d9eab6e79 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -277,6 +277,7 @@ static struct map {
>  	{ "CPU-M-CF", "cpum_cf" },
>  	{ "CPU-M-SF", "cpum_sf" },
>  	{ "UPI LL", "uncore_upi" },
> +	{ "hisi_sicl,cpa", "hisi_sicl,cpa"},
>  	{ "hisi_sccl,ddrc", "hisi_sccl,ddrc" },
>  	{ "hisi_sccl,hha", "hisi_sccl,hha" },
>  	{ "hisi_sccl,l3c", "hisi_sccl,l3c" },
> -- 
> 2.24.0

-- 

- Arnaldo
