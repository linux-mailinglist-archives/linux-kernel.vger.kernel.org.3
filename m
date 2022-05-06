Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C7A51DA37
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 16:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442095AbiEFOQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 10:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391428AbiEFOQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 10:16:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35755F68;
        Fri,  6 May 2022 07:12:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6EBFFB835D5;
        Fri,  6 May 2022 14:12:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF88CC385A9;
        Fri,  6 May 2022 14:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651846340;
        bh=Sc+wfLcWGfJ4RZMc7taxXvG8soVS9Rxm976jpP4IOpU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=luMA3Sbi2UnRW0GqSVRQt3AxZhoxfkQkT/EbFF8XXw6n5ZRdbbsIJ9jI+b1nuQWbj
         EcAhZG4zfkiL67+iGSDhHRdl3MQ6ntxOAHVWpxk1rAM34+zWz8WE5F/wd0YT4NUTRG
         MtwoVFnp0jA0Z0MFX1bfUoJZ22K40vbroYISSTQgD9gBmktOLkyCG+NBl1BnHXqsSt
         iwNbeRYjctvSdr6WFqBgaYHUKlG33BbWyJO9+pl0CMVxOlec26uI8/zM8jB8OVIaSk
         i8lpuyH5mgY+J0q8Sjp9rGXuTq7Q7ubkwYxQ7lyPyJ+PoJE7abRI6pmy4x6HOhXm5/
         tJCcKygDDL6pQ==
Date:   Fri, 6 May 2022 15:12:14 +0100
From:   Will Deacon <will@kernel.org>
To:     Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
Cc:     mark.rutland@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64: perf: Retain PMCR.X of PMCR_EL0 during reset
Message-ID: <20220506141213.GA23485@willie-the-truck>
References: <1651231749-19565-1-git-send-email-quic_c_spathi@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651231749-19565-1-git-send-email-quic_c_spathi@quicinc.com>
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

On Fri, Apr 29, 2022 at 04:59:09PM +0530, Srinivasarao Pathipati wrote:
> Preserve the bit PMCR.X of PMCR_EL0 during PMU reset to export
> PMU events. as it could be set before PMU initialization.
> 
> Signed-off-by: Srinivasarao Pathipati <quic_c_spathi@quicinc.com>
> ---
> Changes since V1:
> 	- Preserving only PMCR_X bit as per Robin Murphy's comment
> ---
>  arch/arm64/kernel/perf_event.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index cb69ff1..532a417 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -1047,6 +1047,9 @@ static void armv8pmu_reset(void *info)
>  	if (armv8pmu_has_long_event(cpu_pmu))
>  		pmcr |= ARMV8_PMU_PMCR_LP;
>  
> +	/* Preserve PMCR_X to export PMU events */
> +	pmcr |= (armv8pmu_pmcr_read() & ARMV8_PMU_PMCR_X);

I don't think this should be unconditional. Exporting events could easily
result in additional power consumption, and potentially even hardware
lockups.

Please stick this behind something like a sysctl toggle or sysfs control,
with documentation about what it does. It should default to disabled.

Will
