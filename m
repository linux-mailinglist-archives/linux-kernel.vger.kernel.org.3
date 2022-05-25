Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D4A533B9E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 13:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbiEYLWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 07:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237919AbiEYLWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 07:22:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28A694192;
        Wed, 25 May 2022 04:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lBqTvM37qa5QwDSH0zAe/Ok6RZNYZNqn9M00r89ZmCs=; b=A5MVree/RhUP7cbrxn7PCjd3M+
        XMHUrYYX1DYjS/qdD7suruVXF7IPO0lZFTISR395BwIDbDJHaqH3EfKgPmgdkasxr1imcvYZTV+I2
        QpdI6QV9Qb+JdddYk4ItqwmzuYrkuR9I69rEwKIQ+u3QSG+l6YFGa8vbio9/hvvtX3dL6o2bow39N
        Vx0cMywPURzQUjTJgsdwN/Mw8G/gk02XICeiORqKe3jQ376uIKlvf2IPfc9piLKjSIlFAbzzENVgc
        prSC1Lb3vt0omLJ1YfNP/zB9KSvbnYRmSr8EtnjqW3aLYiBUg4SKXFiuS3eThr0tBwEJoO4pcdm9E
        AwQ96b1Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntp5G-001bCs-CU; Wed, 25 May 2022 11:21:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C1F1E300222;
        Wed, 25 May 2022 13:21:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A9D90207688F7; Wed, 25 May 2022 13:21:45 +0200 (CEST)
Date:   Wed, 25 May 2022 13:21:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, jolsa@kernel.org, namhyung@kernel.org,
        eranian@google.com, irogers@google.com, jmario@redhat.com,
        leo.yan@linaro.org, alisaidi@amazon.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH 06/13] perf/x86/amd: Support PERF_SAMPLE_PHY_ADDR using
 IBS_DC_PHYSADDR
Message-ID: <Yo4RSY2L80N5muJ9@hirez.programming.kicks-ass.net>
References: <20220525093938.4101-1-ravi.bangoria@amd.com>
 <20220525093938.4101-7-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525093938.4101-7-ravi.bangoria@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 03:09:31PM +0530, Ravi Bangoria wrote:
> IBS_DC_PHYSADDR provides the physical data address for the tagged load/
> store operation. Populate perf sample physical address using it.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  arch/x86/events/amd/ibs.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index b57736357e25..c719020c0e83 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -986,13 +986,35 @@ static void perf_ibs_get_data_addr(struct perf_event *event,
>  	data->addr = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCLINAD)];
>  }
>  
> +static void perf_ibs_get_phy_addr(struct perf_event *event,
> +				  struct perf_ibs_data *ibs_data,
> +				  struct perf_sample_data *data)
> +{
> +	union perf_mem_data_src *data_src = &data->data_src;
> +	u64 op_data3 = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA3)];
> +	u64 phy_addr_valid = op_data3 & IBS_DC_PHY_ADDR_VALID_MASK;
> +
> +	if (!(event->attr.sample_type & PERF_SAMPLE_DATA_SRC))
> +		perf_ibs_get_mem_op(op_data3, data);
> +
> +	if ((data_src->mem_op != PERF_MEM_OP_LOAD &&
> +	    data_src->mem_op != PERF_MEM_OP_STORE) ||
> +	    !phy_addr_valid) {
> +		data->phys_addr = 0x0;
> +		return;
> +	}
> +
> +	data->phys_addr = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCPHYSAD)];
> +}

perf_prepare_sample() will unconditionally overwrite data->phys_addr.
There is currently no facility to let the driver set this field.
