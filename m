Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A5B559985
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 14:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiFXMRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 08:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiFXMQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 08:16:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADB281247
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 05:14:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 691F3618D7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 12:14:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A8BC34114;
        Fri, 24 Jun 2022 12:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656072882;
        bh=xhGH3Wz8p7oTkxs71Kvl5+Ftr3WjejW+fhXwoTAZErg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BnFj/+tI2rN6E50L3pzmFrvZuHP9PsI+ztV78DurHdUYbfUFxDWvGBqF6OLGKKLSW
         Pkw0GwiRt2sQLZJ544eBZMldJquZtNJiZQNPQpwCc4Ajhj6ILuZ6+nfy6qmDT0VfUO
         ObNE2FnE23jLEksq/4lygxD+bmMjxqWL9U1L3lLHgCVC6YIjTGui9LXz22g7ta1Fhm
         PwOcHNoUGKVhhrjdvTU3KqhdWXjJhFd9vGa9vrUx4X4zhmBxAgwzrK/SDAqtAZWPI9
         OSejtB2T+KZGGcwTl342x3XZ/qGW9vCJwHrmJtFcQ6po6qdRv/UqOCqbL8NmrAD6mz
         IkP4NugwXtO9g==
Date:   Fri, 24 Jun 2022 13:14:35 +0100
From:   Will Deacon <will@kernel.org>
To:     Tanmay Jagdale <tanmay@marvell.com>
Cc:     mark.rutland@arm.com, robh@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sgoutham@marvell.com, lcherian@marvell.com, bbhushan2@marvell.com,
        amitsinght@marvell.com, james.morse@arm.com
Subject: Re: [PATCH RESEND] perf/marvell_cn10k: Add MPAM support for TAD PMU
Message-ID: <20220624121435.GA18561@willie-the-truck>
References: <20220527185647.3138084-1-tanmay@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527185647.3138084-1-tanmay@marvell.com>
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

On Sat, May 28, 2022 at 12:26:47AM +0530, Tanmay Jagdale wrote:
> The TAD PMU supports following counters that can be filtered by MPAM
> partition id.
>     - (0x1a) tad_alloc_dtg : Allocations to DTG.
>     - (0x1b) tad_alloc_ltg : Allocations to LTG.
>     - (0x1c) tad_alloc_any : Total allocations to DTG/LTG.
>     - (0x1d) tad_hit_dtg   : DTG hits.
>     - (0x1e) tad_hit_ltg   : LTG hits.
>     - (0x1f) tad_hit_any   : Hit in LTG/DTG.
>     - (0x20) tad_tag_rd    : Total tag reads.
> 
> Add a new 'partid' attribute of 16-bits to get the partition id
> passed from perf tool. This value would be stored in config1 field
> of perf_event_attr structure.
> 
> Example:
> perf stat -e tad/tad_alloc_any,partid=0x12/ <program>
> 
> - Drop read of TAD_PRF since we don't have to preserve any
>   bit fields and always write an updated value.
> - Update register offsets of TAD_PRF and TAD_PFC.

It would be great if you could document some of this under
Documentation/admin-guide/perf like many of the other PMU drivers have
done.

> Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
> ---
>  drivers/perf/marvell_cn10k_tad_pmu.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_cn10k_tad_pmu.c
> index 282d3a071a67..f552e6bffcac 100644
> --- a/drivers/perf/marvell_cn10k_tad_pmu.c
> +++ b/drivers/perf/marvell_cn10k_tad_pmu.c
> @@ -18,10 +18,12 @@
>  #include <linux/perf_event.h>
>  #include <linux/platform_device.h>
>  
> -#define TAD_PFC_OFFSET		0x0
> +#define TAD_PFC_OFFSET		0x800
>  #define TAD_PFC(counter)	(TAD_PFC_OFFSET | (counter << 3))
> -#define TAD_PRF_OFFSET		0x100
> +#define TAD_PRF_OFFSET		0x900
>  #define TAD_PRF(counter)	(TAD_PRF_OFFSET | (counter << 3))
> +#define TAD_PRF_MATCH_PARTID	(1 << 8)
> +#define TAD_PRF_PARTID_NS	(1 << 10)
>  #define TAD_PRF_CNTSEL_MASK	0xFF
>  #define TAD_MAX_COUNTERS	8
>  
> @@ -86,23 +88,32 @@ static void tad_pmu_event_counter_start(struct perf_event *event, int flags)
>  	struct hw_perf_event *hwc = &event->hw;
>  	u32 event_idx = event->attr.config;
>  	u32 counter_idx = hwc->idx;
> +	u32 partid_filter = 0;
>  	u64 reg_val;
> +	u32 partid;
>  	int i;
>  
>  	hwc->state = 0;
>  
> +	/* Extract the partid (if any) passed by user */
> +	partid = event->attr.config1 & 0x3f;

[...]

>  PMU_FORMAT_ATTR(event, "config:0-7");
> +PMU_FORMAT_ATTR(partid, "config1:0-15");

This doesn't seem to match the mask used above?

Will
