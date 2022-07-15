Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F6B576716
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 21:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiGOTFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 15:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiGOTFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 15:05:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9CD2F032
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 12:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=SjCYBzdIHyWl+MmwXDpkkcdU/10oryhvtNiCSmdRblk=; b=ScTd7genGS+kkgnQz+yra1AmXM
        l9cpDTd8q/jxfgvPJ/f+lx5O+ISnan1VUIVwbjohqfkNMBgTTerVL28fiAAsHwuaQPkLmX7g6d9SU
        6CXqGdg1yaCbPnVksrXvSD71U8NxhcIzVQr672EIjvp/WQ6AKjFEpWujDKbCO0ZV6uB2X4hB509on
        xQgZNghY9kMbL2iuBn/h7bkWUj4j5EAvOGY1UhBTH54KokcNZBqZ1CknWdSO2e2eRojr8YppLLQm+
        3LSqM6vLY+1i3vAG3P4HZenUm9fFPduEuWj0/1il+N1XlXOYRJIaW36YOVzClxsmls7IctlOqyIwq
        WUVT0NBQ==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oCQcg-009cTH-6l; Fri, 15 Jul 2022 19:05:10 +0000
Message-ID: <9da48b8e-adbb-9223-5687-549c66526c47@infradead.org>
Date:   Fri, 15 Jul 2022 12:05:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH v2 2/3] drivers/perf: add DDR Sub-System Driveway
 PMU driver for Yitian 710 SoC
Content-Language: en-US
To:     Shuai Xue <xueshuai@linux.alibaba.com>,
        Jonathan.Cameron@Huawei.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org, mark.rutland@arm.com
Cc:     baolin.wang@linux.alibaba.com, yaohongbo@linux.alibaba.com,
        nengchen@linux.alibaba.com, zhuo.song@linux.alibaba.com
References: <20220617111825.92911-1-xueshuai@linux.alibaba.com>
 <20220715151310.90091-3-xueshuai@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220715151310.90091-3-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 7/15/22 08:13, Shuai Xue wrote:
> Add the DDR Sub-System Driveway Performance Monitoring Unit (PMU) driver
> support for Alibaba T-Head Yitian 710 SoC chip. Yitian supports DDR5/4
> DRAM and targets cloud computing and HPC.
> 
> Each PMU is registered as a device in /sys/bus/event_source/devices, and
> users can select event to monitor in each sub-channel, independently. For
> example, ali_drw_21000 and ali_drw_21080 are two PMU devices for two
> sub-channels of the same channel in die 0. And the PMU device of die 1 is
> prefixed with ali_drw_400XXXXX, e.g. ali_drw_40021000.
> 
> Due to hardware limitation, one of DDRSS Driveway PMU overflow interrupt
> shares the same irq number with MPAM ERR_IRQ. To register DDRSS PMU and
> MPAM drivers successfully, add IRQF_SHARED flag.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Co-developed-by: Hongbo Yao <yaohongbo@linux.alibaba.com>
> Signed-off-by: Hongbo Yao <yaohongbo@linux.alibaba.com>
> Co-developed-by: Neng Chen <nengchen@linux.alibaba.com>
> Signed-off-by: Neng Chen <nengchen@linux.alibaba.com>
> ---
>  drivers/perf/Kconfig                  |   8 +
>  drivers/perf/Makefile                 |   1 +
>  drivers/perf/alibaba_uncore_drw_pmu.c | 793 ++++++++++++++++++++++++++
>  3 files changed, 802 insertions(+)
>  create mode 100644 drivers/perf/alibaba_uncore_drw_pmu.c
> 
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 1e2d69453771..dfafba4cb066 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -183,6 +183,14 @@ config APPLE_M1_CPU_PMU
>  	  Provides support for the non-architectural CPU PMUs present on
>  	  the Apple M1 SoCs and derivatives.
>  
> +config ALIBABA_UNCORE_DRW_PMU
> +	tristate "Alibaba T-Head Yitian 710 DDR Sub-system Driveway PMU driver"
> +	depends on (ARM64 && ACPI)
> +	default m

Why should this driver be automatically built?
I.e., why is the "default m" here at all?

Thanks.

> +	help
> +	  Support for Driveway PMU events monitoring on Yitian 710 DDR
> +	  Sub-system.


-- 
~Randy
