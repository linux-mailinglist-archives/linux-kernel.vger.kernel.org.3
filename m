Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179A3534DDD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345686AbiEZLKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235938AbiEZLKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:10:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6789CFE00;
        Thu, 26 May 2022 04:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CfT2Lwk4hWuGqyUZJE8VVEJLWvV00bhgRCBYd7o8DX8=; b=A+EgxRRc2M8bxF77SWMQlIQMGo
        +UgaLhHqmA226kX7uWD1zI3iXQ7FHR4cygPJvmW3k1CziNIjCIX39j9UsjBTSo+IIxwiKJY+bsPVs
        yh8rjACu6Kz0p2ZSwzkrDWKRF9tNPWupatXgJy+QBwaMtNstTe70vZNA7Cwmedcwb1KJaP9q6IjU7
        E7bgsXxEgXfiK3ih+l7dEvW5yNqL8oavFKXnf7Sgv5/RNGHvylLHCg+XbXGQngt7p94LwglB4Fm3P
        d22ph/exa4akQq0EAgHWwGpQZC8SXESRnQ1p4vhIdedKzsiVpJjUxAkKqTd077mlnQBoBd9xCFk/x
        QLa+sLqQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuBNF-001sax-6V; Thu, 26 May 2022 11:09:50 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4EAE5981124; Thu, 26 May 2022 13:09:47 +0200 (CEST)
Date:   Thu, 26 May 2022 13:09:47 +0200
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
Message-ID: <20220526110947.GQ2578@worktop.programming.kicks-ass.net>
References: <20220525093938.4101-1-ravi.bangoria@amd.com>
 <20220525093938.4101-7-ravi.bangoria@amd.com>
 <Yo4RSY2L80N5muJ9@hirez.programming.kicks-ass.net>
 <e10c3d1b-90a9-2f14-987b-9c0d2471ee53@amd.com>
 <20220526095633.GO2578@worktop.programming.kicks-ass.net>
 <91e7651e-6937-ab20-2b1c-01f8be7933e1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91e7651e-6937-ab20-2b1c-01f8be7933e1@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 04:29:22PM +0530, Ravi Bangoria wrote:
> On 26-May-22 3:26 PM, Peter Zijlstra wrote:
> > On Thu, May 26, 2022 at 02:16:28PM +0530, Ravi Bangoria wrote:
> >> On 25-May-22 4:51 PM, Peter Zijlstra wrote:
> >>> On Wed, May 25, 2022 at 03:09:31PM +0530, Ravi Bangoria wrote:
> >>>> IBS_DC_PHYSADDR provides the physical data address for the tagged load/
> >>>> store operation. Populate perf sample physical address using it.
> >>>>
> >>>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> >>>> ---
> >>>>  arch/x86/events/amd/ibs.c | 26 +++++++++++++++++++++++++-
> >>>>  1 file changed, 25 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> >>>> index b57736357e25..c719020c0e83 100644
> >>>> --- a/arch/x86/events/amd/ibs.c
> >>>> +++ b/arch/x86/events/amd/ibs.c
> >>>> @@ -986,13 +986,35 @@ static void perf_ibs_get_data_addr(struct perf_event *event,
> >>>>  	data->addr = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCLINAD)];
> >>>>  }
> >>>>  
> >>>> +static void perf_ibs_get_phy_addr(struct perf_event *event,
> >>>> +				  struct perf_ibs_data *ibs_data,
> >>>> +				  struct perf_sample_data *data)
> >>>> +{
> >>>> +	union perf_mem_data_src *data_src = &data->data_src;
> >>>> +	u64 op_data3 = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA3)];
> >>>> +	u64 phy_addr_valid = op_data3 & IBS_DC_PHY_ADDR_VALID_MASK;
> >>>> +
> >>>> +	if (!(event->attr.sample_type & PERF_SAMPLE_DATA_SRC))
> >>>> +		perf_ibs_get_mem_op(op_data3, data);
> >>>> +
> >>>> +	if ((data_src->mem_op != PERF_MEM_OP_LOAD &&
> >>>> +	    data_src->mem_op != PERF_MEM_OP_STORE) ||
> >>>> +	    !phy_addr_valid) {
> >>>> +		data->phys_addr = 0x0;
> >>>> +		return;
> >>>> +	}
> >>>> +
> >>>> +	data->phys_addr = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCPHYSAD)];
> >>>> +}
> >>>
> >>> perf_prepare_sample() will unconditionally overwrite data->phys_addr.
> >>> There is currently no facility to let the driver set this field.
> >>
> >> Thanks for pointing it Peter. Would you mind if I add:
> > 
> > I think it's best if you extend/mimic the __PERF_SAMPLE_CALLCHAIN_EARLY
> > hack. It's more or less the same problem and then at least the solution
> > is consistent.
> 
> I've one more identical optimization in my list. IBS_OP_DATA3[IbsDcPgSz]
> can provide PERF_SAMPLE_DATA_PAGE_SIZE. I hope consuming two more bits
> for internal purpose is okay.

Yeah, I suppose so.. we'll need to hunt for bits once we run out, but
that's how it is...
