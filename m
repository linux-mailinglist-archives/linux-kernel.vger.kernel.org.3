Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EFC55C24C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbiF0KwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 06:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbiF0KwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 06:52:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD48644C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 03:52:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A375061359
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 10:52:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0052BC3411D;
        Mon, 27 Jun 2022 10:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656327138;
        bh=gswl8VXoSaynFC5hVjucevy2klG2JzBobBOLT+yU1BY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MwgGtUpbNJiP6ZRVdVnG9fyiBv+cXXkr60sIvEc+pRvGu1Lo/b73vWC2FDvd4joOI
         EdLqYn+SKuMn9bbp5YhKLe8Byi2JlOtuSrUgGDXytLHiXXax60VXbgRybJ2FV254c4
         Wl3a15MKrqDNUtH4rfmknJn1JQzHWpkpvq6U/BhaEp46tp8bq5LQ/m0zjMVfgsYJAc
         o25/eERdI4TkkLF3iyEyjVf6Wb0TqMYM04B47xVfWM6t2qe5SateKA0mMsFnC7txef
         xBveRnw/srJWZz9kjSTQEIfYYBrvwUiR6oRimuENWxulJzTZBJMX23IyRvH+nfOOLh
         O+OrQAFi5BBgw==
Date:   Mon, 27 Jun 2022 11:52:12 +0100
From:   Will Deacon <will@kernel.org>
To:     Guangbin Huang <huangguangbin2@huawei.com>
Cc:     john.garry@huawei.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, liuqi115@huawei.com,
        zhangshaokun@hisilicon.com, f.fangjian@huawei.com,
        lipeng321@huawei.com, shenjian15@huawei.com
Subject: Re: [RESEND PATCH V7 2/2] drivers/perf: hisi: add driver for HNS3 PMU
Message-ID: <20220627105211.GD22095@willie-the-truck>
References: <20220525005211.57059-1-huangguangbin2@huawei.com>
 <20220525005211.57059-3-huangguangbin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525005211.57059-3-huangguangbin2@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 08:52:11AM +0800, Guangbin Huang wrote:
> HNS3(HiSilicon Network System 3) PMU is RCiEP device in HiSilicon SoC NIC,
> supports collection of performance statistics such as bandwidth, latency,
> packet rate and interrupt rate.
> 
> NIC of each SICL has one PMU device for it. Driver registers each PMU
> device to perf, and exports information of supported events, filter mode of
> each event, bdf range, hardware clock frequency, identifier and so on via
> sysfs.
> 
> Each PMU device has its own registers of control, counters and interrupt,
> and it supports 8 hardware events, each hardward event has its own
> registers for configuration, counters and interrupt.
> 
> Filter options contains:
> event        - select event
> port         - select physical port of nic
> tc           - select tc(must be used with port)
> func         - select PF/VF
> queue        - select queue of PF/VF(must be used with func)
> intr         - select interrupt number(must be used with func)
> global       - select all functions of IO DIE
> 
> Signed-off-by: Guangbin Huang <huangguangbin2@huawei.com>
> Reviewed-by: John Garry <john.garry@huawei.com>
> Reviewed-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
>  MAINTAINERS                       |    6 +
>  drivers/perf/hisilicon/Kconfig    |   10 +
>  drivers/perf/hisilicon/Makefile   |    1 +
>  drivers/perf/hisilicon/hns3_pmu.c | 1662 +++++++++++++++++++++++++++++
>  include/linux/cpuhotplug.h        |    1 +
>  5 files changed, 1680 insertions(+)
>  create mode 100644 drivers/perf/hisilicon/hns3_pmu.c

This mostly looks good to me, but I have one niggling concern with the ABI:

> +#define HNS3_PMU_FILTER_ATTR(_name, _config, _start, _end)               \
> +	static inline u64 hns3_pmu_get_##_name(struct perf_event *event) \
> +	{                                                                \
> +		return FIELD_GET(GENMASK_ULL(_end, _start),              \
> +				 event->attr._config);                   \
> +	}
> +
> +HNS3_PMU_FILTER_ATTR(event, config, 0, 16);
> +HNS3_PMU_FILTER_ATTR(subevent, config, 0, 7);
> +HNS3_PMU_FILTER_ATTR(event_type, config, 8, 15);
> +HNS3_PMU_FILTER_ATTR(ext_counter_used, config, 16, 16);
> +HNS3_PMU_FILTER_ATTR(real_event, config, 0, 15);

How does perf tool deal with overlapping fields like this? It seems like
quite a bad idea to allow things like "event=0xffff,subevent=0" when they
are no longer distinct and I don't _think_ any other drivers do this.

Can you remove 'event' and 'real_event' for now, or are they needed?

Will
