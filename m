Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FEC579F68
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 15:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238984AbiGSNS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 09:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239896AbiGSNSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 09:18:05 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38541A833
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 05:35:14 -0700 (PDT)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LnJ9d5MjBz67VCj;
        Tue, 19 Jul 2022 20:31:49 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Jul 2022 14:35:12 +0200
Received: from localhost (10.81.209.49) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 19 Jul
 2022 13:35:11 +0100
Date:   Tue, 19 Jul 2022 13:35:09 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <will@kernel.org>,
        <mark.rutland@arm.com>, <baolin.wang@linux.alibaba.com>,
        <yaohongbo@linux.alibaba.com>, <nengchen@linux.alibaba.com>,
        <zhuo.song@linux.alibaba.com>
Subject: Re: [RESEND PATCH v2 1/3] docs: perf: Add description for Alibaba's
 T-Head PMU driver
Message-ID: <20220719133509.00006ee9@Huawei.com>
In-Reply-To: <20220715151310.90091-2-xueshuai@linux.alibaba.com>
References: <20220617111825.92911-1-xueshuai@linux.alibaba.com>
        <20220715151310.90091-2-xueshuai@linux.alibaba.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.209.49]
X-ClientProxiedBy: lhreml749-chm.china.huawei.com (10.201.108.199) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 23:13:08 +0800
Shuai Xue <xueshuai@linux.alibaba.com> wrote:

> Alibaba's T-Head SoC implements uncore PMU for performance and functional
> debugging to facilitate system maintenance. Document it to provide guidance
> on how to use it.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
I'm far from an expert on this, but looks good to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  .../admin-guide/perf/alibaba_pmu.rst          | 100 ++++++++++++++++++
>  Documentation/admin-guide/perf/index.rst      |   1 +
>  2 files changed, 101 insertions(+)
>  create mode 100644 Documentation/admin-guide/perf/alibaba_pmu.rst
> 
> diff --git a/Documentation/admin-guide/perf/alibaba_pmu.rst b/Documentation/admin-guide/perf/alibaba_pmu.rst
> new file mode 100644
> index 000000000000..11de998bb480
> --- /dev/null
> +++ b/Documentation/admin-guide/perf/alibaba_pmu.rst
> @@ -0,0 +1,100 @@
> +=============================================================
> +Alibaba's T-Head SoC Uncore Performance Monitoring Unit (PMU)
> +=============================================================
> +
> +The Yitian 710, custom-built by Alibaba Group's chip development business,
> +T-Head, implements uncore PMU for performance and functional debugging to
> +facilitate system maintenance.
> +
> +DDR Sub-System Driveway (DRW) PMU Driver
> +=========================================
> +
> +Yitian 710 employs eight DDR5/4 channels, four on each die. Each DDR5 channel
> +is independent of others to service system memory requests. And one DDR5
> +channel is split into two independent sub-channels. The DDR Sub-System Driveway
> +implements separate PMUs for each sub-channel to monitor various performance
> +metrics.
> +
> +The Driveway PMU devices are named as ali_drw_<sys_base_addr> with perf.
> +For example, ali_drw_21000 and ali_drw_21080 are two PMU devices for two
> +sub-channels of the same channel in die 0. And the PMU device of die 1 is
> +prefixed with ali_drw_400XXXXX, e.g. ali_drw_40021000.
> +
> +Each sub-channel has 36 PMU counters in total, which is classified into
> +four groups:
> +
> +- Group 0: PMU Cycle Counter. This group has one pair of counters
> +  pmu_cycle_cnt_low and pmu_cycle_cnt_high, that is used as the cycle count
> +  based on DDRC core clock.
> +
> +- Group 1: PMU Bandwidth Counters. This group has 8 counters that are used
> +  to count the total access number of either the eight bank groups in a
> +  selected rank, or four ranks separately in the first 4 counters. The base
> +  transfer unit is 64B.
> +
> +- Group 2: PMU Retry Counters. This group has 10 counters, that intend to
> +  count the total retry number of each type of uncorrectable error.
> +
> +- Group 3: PMU Common Counters. This group has 16 counters, that are used
> +  to count the common events.
> +
> +For now, the Driveway PMU driver only uses counters in group 0 and group 3.
> +
> +The DDR Controller (DDRCTL) and DDR PHY combine to create a complete solution
> +for connecting an SoC application bus to DDR memory devices. The DDRCTL
> +receives transactions Host Interface (HIF) which is custom-defined by Synopsys.
> +These transactions are queued internally and scheduled for access while
> +satisfying the SDRAM protocol timing requirements, transaction priorities, and
> +dependencies between the transactions. The DDRCTL in turn issues commands on
> +the DDR PHY Interface (DFI) to the PHY module, which launches and captures data
> +to and from the SDRAM. The driveway PMUs have hardware logic to gather
> +statistics and performance logging signals on HIF, DFI, etc.
> +
> +By counting the READ, WRITE and RMW commands sent to the DDRC through the HIF
> +interface, we could calculate the bandwidth. Example usage of counting memory
> +data bandwidth::
> +
> +  perf stat \
> +    -e ali_drw_21000/hif_wr/ \
> +    -e ali_drw_21000/hif_rd/ \
> +    -e ali_drw_21000/hif_rmw/ \
> +    -e ali_drw_21000/cycle/ \
> +    -e ali_drw_21080/hif_wr/ \
> +    -e ali_drw_21080/hif_rd/ \
> +    -e ali_drw_21080/hif_rmw/ \
> +    -e ali_drw_21080/cycle/ \
> +    -e ali_drw_23000/hif_wr/ \
> +    -e ali_drw_23000/hif_rd/ \
> +    -e ali_drw_23000/hif_rmw/ \
> +    -e ali_drw_23000/cycle/ \
> +    -e ali_drw_23080/hif_wr/ \
> +    -e ali_drw_23080/hif_rd/ \
> +    -e ali_drw_23080/hif_rmw/ \
> +    -e ali_drw_23080/cycle/ \
> +    -e ali_drw_25000/hif_wr/ \
> +    -e ali_drw_25000/hif_rd/ \
> +    -e ali_drw_25000/hif_rmw/ \
> +    -e ali_drw_25000/cycle/ \
> +    -e ali_drw_25080/hif_wr/ \
> +    -e ali_drw_25080/hif_rd/ \
> +    -e ali_drw_25080/hif_rmw/ \
> +    -e ali_drw_25080/cycle/ \
> +    -e ali_drw_27000/hif_wr/ \
> +    -e ali_drw_27000/hif_rd/ \
> +    -e ali_drw_27000/hif_rmw/ \
> +    -e ali_drw_27000/cycle/ \
> +    -e ali_drw_27080/hif_wr/ \
> +    -e ali_drw_27080/hif_rd/ \
> +    -e ali_drw_27080/hif_rmw/ \
> +    -e ali_drw_27080/cycle/ -- sleep 10
> +
> +The average DRAM bandwidth can be calculated as follows:
> +
> +- Read Bandwidth =  perf_hif_rd * DDRC_WIDTH * DDRC_Freq / DDRC_Cycle
> +- Write Bandwidth = (perf_hif_wr + perf_hif_rmw) * DDRC_WIDTH * DDRC_Freq / DDRC_Cycle
> +
> +Here, DDRC_WIDTH = 64 bytes.
> +
> +The current driver does not support sampling. So "perf record" is
> +unsupported.  Also attach to a task is unsupported as the events are all
> +uncore.
> diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
> index 69b23f087c05..823db08863db 100644
> --- a/Documentation/admin-guide/perf/index.rst
> +++ b/Documentation/admin-guide/perf/index.rst
> @@ -17,3 +17,4 @@ Performance monitor support
>     xgene-pmu
>     arm_dsu_pmu
>     thunderx2-pmu
> +   alibaba_pmu

