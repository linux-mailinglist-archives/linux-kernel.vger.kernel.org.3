Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61833589C35
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239395AbiHDNJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiHDNI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:08:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A2315738
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 06:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659618537; x=1691154537;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DV18pRnBkOGNyZoj7ljenhIMWBigwzdW1xP9MCz/TIY=;
  b=AdR/+PMKIHagK0v6cMjSESQOUZaviUmIG4UrpSk6N709HX5xUusfL5/r
   geaDE0+uTDzrOFMGHJNZdy+Qr9IIoCwZibxyCkB/gerLdMdXvvAIKIhOE
   fe4P7NXP6ikn6Q43FfIPIi2jTeDtlBVkNkvSvGg1Oeug1l9E7JQJZ0EcH
   QOKt0ZlskfhI1cI7CytqNhxsoN8yoXv/2Gs0tGVHQaclpOrnR4oCdc8mm
   nGCR9SrKxwyRM1WWscO28xwIaqH4x8Ed217NJnnANZZc+7PlfUGOYVKXj
   e8UyISD2rdoTHB8kDZnlAU2eOGX7+V/4jQTBkG7R1bNxwyqGPyAGLKEFi
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="289938419"
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="289938419"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 06:08:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="603212287"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 04 Aug 2022 06:08:56 -0700
Received: from [10.252.210.126] (kliang2-mobl1.ccr.corp.intel.com [10.252.210.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id D80165804E8;
        Thu,  4 Aug 2022 06:08:55 -0700 (PDT)
Message-ID: <4cad9f06-f24d-a6e6-477b-5a00f64600ed@linux.intel.com>
Date:   Thu, 4 Aug 2022 09:08:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH] perf/x86/intel/uncore: fix broken read_counter() for SNB
 IMC PMU
Content-Language: en-US
To:     Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kan.liang@intel.com, ak@linux.intel.com,
        namhyung.kim@kernel.org, irogers@google.com
References: <20220803160031.1379788-1-eranian@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220803160031.1379788-1-eranian@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-08-03 12:00 p.m., Stephane Eranian wrote:
> Existing code was generating bogus counts for the SNB IMC bandwidth counters:
> 
> $ perf stat -a -I 1000 -e uncore_imc/data_reads/,uncore_imc/data_writes/
>      1.000327813           1,024.03 MiB  uncore_imc/data_reads/
>      1.000327813              20.73 MiB  uncore_imc/data_writes/
>      2.000580153         261,120.00 MiB  uncore_imc/data_reads/
>      2.000580153              23.28 MiB  uncore_imc/data_writes/
> 
> The problem was introduced by commit:
>   07ce734dd8ad ("perf/x86/intel/uncore: Clean up client IMC")
> 
> Where the read_counter callback was replace to point to the generic
> uncore_mmio_read_counter() function.
> 
> The SNB IMC counters are freerunnig 32-bit counters laid out contiguously in
> MMIO. But uncore_mmio_read_counter() is using a readq() call to read from
> MMIO therefore reading 64-bit from MMIO. Although this is okay for the
> uncore_perf_event_update() function because it is shifting the value based
> on the actual counter width to compute a delta, it is not okay for the
> uncore_pmu_event_start() which is simply reading the counter  and therefore
> priming the event->prev_count with a bogus value which is responsible for
> causing bogus deltas in the perf stat command above.
> 
> The fix is to reintroduce the custom callback for read_counter for the SNB
> IMC PMU and use readl() instead of readq(). With the change the output of
> perf stat is back to normal:
> $ perf stat -a -I 1000 -e uncore_imc/data_reads/,uncore_imc/data_writes/
>      1.000120987             296.94 MiB  uncore_imc/data_reads/
>      1.000120987             138.42 MiB  uncore_imc/data_writes/
>      2.000403144             175.91 MiB  uncore_imc/data_reads/
>      2.000403144              68.50 MiB  uncore_imc/data_writes/
> 
> Signed-off-by: Stephane Eranian <eranian@google.com>

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>  arch/x86/events/intel/uncore_snb.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
> index ce440011cc4e..1ef4f7861e2e 100644
> --- a/arch/x86/events/intel/uncore_snb.c
> +++ b/arch/x86/events/intel/uncore_snb.c
> @@ -841,6 +841,22 @@ int snb_pci2phy_map_init(int devid)
>  	return 0;
>  }
>  
> +static u64 snb_uncore_imc_read_counter(struct intel_uncore_box *box, struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	/*
> +	 * SNB IMC counters are 32-bit and are laid out back to back
> +	 * in MMIO space. Therefore we must use a 32-bit accessor function
> +	 * using readq() from uncore_mmio_read_counter() causes problems
> +	 * because it is reading 64-bit at a time. This is okay for the
> +	 * uncore_perf_event_update() function because it drops the upper
> +	 * 32-bits but not okay for plain uncore_read_counter() as invoked
> +	 * in uncore_pmu_event_start().
> +	 */
> +	return (u64)readl(box->io_addr + hwc->event_base);
> +}
> +
>  static struct pmu snb_uncore_imc_pmu = {
>  	.task_ctx_nr	= perf_invalid_context,
>  	.event_init	= snb_uncore_imc_event_init,
> @@ -860,7 +876,7 @@ static struct intel_uncore_ops snb_uncore_imc_ops = {
>  	.disable_event	= snb_uncore_imc_disable_event,
>  	.enable_event	= snb_uncore_imc_enable_event,
>  	.hw_config	= snb_uncore_imc_hw_config,
> -	.read_counter	= uncore_mmio_read_counter,
> +	.read_counter	= snb_uncore_imc_read_counter,
>  };
>  
>  static struct intel_uncore_type snb_uncore_imc = {
