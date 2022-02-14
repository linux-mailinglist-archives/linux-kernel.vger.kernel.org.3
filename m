Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE8C4B4FA5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352460AbiBNME6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:04:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352513AbiBNMEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:04:43 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40062ADA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 04:04:27 -0800 (PST)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jy2vB2rsnz67bH2;
        Mon, 14 Feb 2022 20:04:06 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Feb 2022 13:04:24 +0100
Received: from [10.47.81.62] (10.47.81.62) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Mon, 14 Feb
 2022 12:04:24 +0000
Message-ID: <1da1252e-59d0-77d1-0419-242528739392@huawei.com>
Date:   Mon, 14 Feb 2022 12:04:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 2/2] perf jevents: Add support for HiSilicon CPA PMU
 aliasing
To:     Qi Liu <liuqi115@huawei.com>, "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Zhangshaokun <zhangshaokun@hisilicon.com>
References: <20220214114228.40859-1-liuqi115@huawei.com>
 <20220214114228.40859-3-liuqi115@huawei.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220214114228.40859-3-liuqi115@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.81.62]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2022 11:42, Qi Liu wrote:
> Add support for HiSilicon CPA PMU aliasing.
> 
> The kernel driver is in drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c
> 
> Signed-off-by: Qi Liu<liuqi115@huawei.com>

You realy should cc the perf tool list and maintainers there also.

Reviewed-by: John Garry <john.garry@huawei.com>

> +	},
> +	{
> +		"MetricExpr": "(p0_wr_dat * 64 + p0_rd_dat_64b * 64 + p0_rd_dat_32b * 32) / cpa_cycles",
> +		"BriefDescription": "Average bandwidth of CPA Port 0",
> +		"MetricGroup": "CPA",

nit: maybe this should have a more distrinct name

> +		"MetricName": "p0_avg_bw",
> +		"Compat": "0x00000030",

JFYI, I have a rewrite of the perf tool system pmu metric support that 
will not require us to add the compat here.

> +		"Unit": "hisi_sicl,cpa"

Thanks,
John
