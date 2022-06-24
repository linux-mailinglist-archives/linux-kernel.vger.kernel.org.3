Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B18559993
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 14:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiFXMSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 08:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiFXMSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 08:18:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94E81168;
        Fri, 24 Jun 2022 05:18:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5722461655;
        Fri, 24 Jun 2022 12:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E3EC34114;
        Fri, 24 Jun 2022 12:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656073112;
        bh=Vrl/35KfEA8EXbn5hdEP2XvtFH/JWegI4kprxqGCvz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=st/AuHrEZ7YjHPn6RpxtJT00QhQHgZJ+TSKJnaNAs5PUD6P85zteMKnXkL/XYZ0aE
         6dO2FhsmutMlCQZ7DTR4Pc5jDCW0Sz57NUR4Cs40idy550oMTVJolVulYAfwPEcFyw
         a8xA+085x65qFaFO1EPKtSv0gdvH1enSUjJ0ZOgrWwXyITAugCEFN6SRWSMN5k08ix
         P2y9iHInJp73O1dblnRM2Z5ALsUas5k9O0VJrqZLr8Dj4n6Nis+C+Ah8hOz/C24mqc
         0m1G5d+8wn8ec0SUXrFz6BL3Cc4bLEI8je+6SvQCwfvlzYRefVnSmm5qCtFMNgzXld
         YZSqZ00OTTkYg==
Date:   Fri, 24 Jun 2022 13:18:26 +0100
From:   Will Deacon <will@kernel.org>
To:     Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
Cc:     mark.rutland@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6] arm64: perf: Make exporting of pmu events configurable
Message-ID: <20220624121825.GB18561@willie-the-truck>
References: <1654779589-19937-1-git-send-email-quic_c_spathi@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1654779589-19937-1-git-send-email-quic_c_spathi@quicinc.com>
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

On Thu, Jun 09, 2022 at 06:29:49PM +0530, Srinivasarao Pathipati wrote:
> The PMU export bit (PMCR_EL0.X) is getting reset during pmu reset,
> Make it configurable using sysctls to enable/disable at runtime.
> 
> Signed-off-by: Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
> ---
> Changes since V5:
> 	- removed configuring with kernel parameters.
> Changes since V4:
> 	- Registering sysctls dynamically for only arm64 as suggested by Will
> 	- Not removed the code to configure with kernel parameters 
> 	  as the sysctl's kernel parameter(sysctl.kernel.export_pmu_events)
> 	  is not working at early bootup. pmu_reset() getting called before 
> 	  sysctl's kernel parameter is set.
> Changes since V3:
> 	- export bit is now configurable with sysctl
> 	- enabling export bit on reset instead of retaining
> 
> Changes since V2:
> 	Done below changes as per Will's comments
> 	- enabling pmcr_x now configurable with kernel parameters and
> 	  by default it is disabled.
> 	
> Changes since V1:
> 	- Preserving only PMCR_X bit as per Robin Murphy's comment.
> 
> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 11 +++++++++++
>  arch/arm64/kernel/perf_event.c              | 13 +++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index ddccd10..c2ecd84 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -267,6 +267,17 @@ domain names are in general different. For a detailed discussion
>  see the ``hostname(1)`` man page.
>  
>  
> +export_pmu_events (arm64 only)
> +==============================
> +
> +Controls the PMU export bit (PMCR_EL0.X), which enables the exporting of
> +events over an IMPLEMENTATION DEFINED PMU event export bus to another device.
> +
> +0: disables exporting of events (default).
> +
> +1: enables exporting of events.
> +
> +
>  firmware_config
>  ===============
>  
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index cb69ff1..a8c32a0 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -298,6 +298,7 @@ PMU_FORMAT_ATTR(long, "config1:0");
>  PMU_FORMAT_ATTR(rdpmc, "config1:1");
>  
>  static int sysctl_perf_user_access __read_mostly;
> +static int sysctl_export_pmu_events __read_mostly;
>  
>  static inline bool armv8pmu_event_is_64bit(struct perf_event *event)
>  {
> @@ -1047,6 +1048,9 @@ static void armv8pmu_reset(void *info)
>  	if (armv8pmu_has_long_event(cpu_pmu))
>  		pmcr |= ARMV8_PMU_PMCR_LP;
>  
> +	if (sysctl_export_pmu_events)
> +		pmcr |= ARMV8_PMU_PMCR_X;

I think we need to do this in armv8pmu_start() rather than armv8pmu_reset(),
otherwise any changes to the sysctl at runtime won't take effect unless you
do something like re-online the CPU.

Will
