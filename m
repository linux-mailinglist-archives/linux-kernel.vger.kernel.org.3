Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF40651D888
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392278AbiEFNNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392269AbiEFNNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:13:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C3262A32
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 06:09:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5035D62032
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 13:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BF3C385A8;
        Fri,  6 May 2022 13:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651842560;
        bh=av2TWNM7gyVKoyAwNAEuM/KHH6D5tpzNWI0funNeu9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lhLWC8K4yjaTqwEyukspC7h8WJ19tyHh1LU9CviNuscKBOz2kg8rBIkx2E/dByRDx
         CAaZ/y67a/9wG5c7/Be+JfZNlbUhIR7fEBeFnTrY9Af5SmvURt329iueZSdlX6tPto
         n7b1BStnCCwORDH5UGiZ5+C48kclyUoyuMOh1bZgfCa4TtmjULEPB2sz5SF0tbMM2v
         GzyVFEEiyPdoauZCCVhbJca3Thjxx57kTrqTpIc7JVVbai5Mj1pmeSTDBrIcWIk4jg
         ZAPrmyNnh7e1fNFgK6GkFZtXg6ZchoF/WvKv/SpCroRHevMR/oyp+Ds7m2QXwTyv1M
         eFRsKWgYsgdWg==
Date:   Fri, 6 May 2022 14:09:15 +0100
From:   Will Deacon <will@kernel.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mark.rutland@arm.com
Subject: Re: [PATCH v2] perf/arm: adjust hwevents mappings on boot
Message-ID: <20220506130915.GD22892@willie-the-truck>
References: <20220324181458.3216262-1-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324181458.3216262-1-eranian@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 11:14:58AM -0700, Stephane Eranian wrote:
> The mapping of perf_events generic hardware events to actual PMU events on
> ARM PMUv3 may not always be correct. This is in particular true for the
> PERF_COUNT_HW_BRANCH_INSTRUCTIONS event. Although the mapping points to an
> architected event, it may not always be available. This can be seen with a
> simple:
> 
> $ perf stat -e branches sleep 0
>  Performance counter stats for 'sleep 0':
> 
>    <not supported>      branches
> 
>        0.001401081 seconds time elapsed
> 
> Yet the hardware does have an event that could be used for branches.
> This patch fixes the problem by dynamically validating the generic hardware
> events against the supported architected events. If a mapping is wrong it
> can be replaced it with another. This is done for the event above at boot time
> and the kernel will log the remapping:
> 
> armv8_pmuv3: hwevent HW_BRANCH_INSTRUCTIONS remapped  from 0xc to 0x21
> 
> And with that:
> 
> $ perf stat -e branches sleep 0
> 
>  Performance counter stats for 'sleep 0':
> 
>            166,739      branches
> 
>        0.000832163 seconds time elapsed
> 
> Signed-off-by: Stephane Eranian <eranian@google.com>
> ---
>  arch/arm64/kernel/perf_event.c | 41 +++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index cab678ed6618..d438f5a46bdc 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -39,7 +39,7 @@
>   * be supported on any given implementation. Unsupported events will
>   * be disabled at run-time based on the PMCEID registers.
>   */
> -static const unsigned armv8_pmuv3_perf_map[PERF_COUNT_HW_MAX] = {
> +static unsigned armv8_pmuv3_perf_map[PERF_COUNT_HW_MAX] = {
>  	PERF_MAP_ALL_UNSUPPORTED,
>  	[PERF_COUNT_HW_CPU_CYCLES]		= ARMV8_PMUV3_PERFCTR_CPU_CYCLES,
>  	[PERF_COUNT_HW_INSTRUCTIONS]		= ARMV8_PMUV3_PERFCTR_INST_RETIRED,
> @@ -1222,6 +1222,42 @@ static void armv8_pmu_register_sysctl_table(void)
>  		register_sysctl("kernel", armv8_pmu_sysctl_table);
>  }
>  
> +static void armv8pmu_fixup_perf_map(struct arm_pmu *cpu_pmu)
> +{
> +	int i, code;
> +	unsigned *map = armv8_pmuv3_perf_map;
> +
> +	for (i = 0; i < PERF_COUNT_HW_MAX; i++) {
> +retry:
> +		code = map[i];
> +		if (code == HW_OP_UNSUPPORTED)
> +			continue;
> +
> +		if (test_bit(map[i], cpu_pmu->pmceid_bitmap))
> +			continue;
> +		/*
> +		 * mapping does not exist,
> +		 * let's see if we can fix it
> +		 */
> +		switch (i) {
> +		case PERF_COUNT_HW_BRANCH_INSTRUCTIONS:
> +			if (code == ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED) {
> +				map[i] = ARMV8_PMUV3_PERFCTR_BR_RETIRED;
> +				pr_info("armv8_pmuv3: hwevent "
> +					"HW_BRANCH_INSTRUCTIONS remapped "
> +					" from 0x%x to 0x%x\n", code, map[i]);
> +				goto retry;
> +			}
> +			break;
> +		default:
> +			pr_info("armv8_pmuv3: hwevent %d not supported\n", i);

If a CPU supports neither ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED nor
ARMV8_PMUV3_PERFCTR_BR_RETIRED, won't we get a funny series of messages
here? I think I'd prefer to drop the prints altogether.

Will
