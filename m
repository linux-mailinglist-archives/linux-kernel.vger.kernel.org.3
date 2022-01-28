Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5821749FF83
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236331AbiA1RWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 12:22:51 -0500
Received: from foss.arm.com ([217.140.110.172]:55398 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344068AbiA1RVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:21:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C20AE113E;
        Fri, 28 Jan 2022 09:20:59 -0800 (PST)
Received: from [10.57.86.104] (unknown [10.57.86.104])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 916063F793;
        Fri, 28 Jan 2022 09:20:54 -0800 (PST)
Subject: Re: [PATCH 2/2] perf arm-spe: Parse more SPE fields and store source
To:     Ali Saidi <alisaidi@amazon.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     benh@kernel.crashing.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>
References: <20220125192016.20538-1-alisaidi@amazon.com>
 <20220125192016.20538-3-alisaidi@amazon.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <b1b3697d-4a0a-d041-5cbd-e08fec9e658c@arm.com>
Date:   Fri, 28 Jan 2022 17:20:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220125192016.20538-3-alisaidi@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ali,

On 25/01/2022 19:20, Ali Saidi wrote:
> Decode more SPE events and op types to allow for processing by perf
> scripts. For example looking for branches which may indicate candidates
> for conversion to a CSEL, store exclusives that are candidates for
> conversion to LSE atomics and record the source information for memory
> ops.
>
> Signed-off-by: Ali Saidi <alisaidi@amazon.com>
> ---
>  .../util/arm-spe-decoder/arm-spe-decoder.c     | 18 ++++++++++++++++++
>  .../util/arm-spe-decoder/arm-spe-decoder.h     |  8 ++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> index 5e390a1a79ab..177bac0f7128 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> @@ -191,6 +191,20 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
>  					decoder->record.op = ARM_SPE_ST;
>  				else
>  					decoder->record.op = ARM_SPE_LD;
> +				if (SPE_OP_PKT_IS_LDST_ATOMIC(payload)) {
> +					if (payload & SPE_OP_PKT_AT)
> +						decoder->record.op |= ARM_SPE_LDST_ATOMIC;

In "utils/arm-spe.c" we check "if (record->op == ARM_SPE_LD)" so this
ORing could break some of the generated samples.

> +					if (payload & SPE_OP_PKT_EXCL)
> +						decoder->record.op |= ARM_SPE_LDST_EXCL;
> +					if (payload & SPE_OP_PKT_AR)
> +						decoder->record.op |= ARM_SPE_LDST_ACQREL;
> +				}
> +			} else if (idx == SPE_OP_PKT_HDR_CLASS_BR_ERET) {
> +				decoder->record.op = ARM_SPE_BR;
> +				if (payload & SPE_OP_PKT_COND)
> +					decoder->record.op |= ARM_SPE_BR_COND;
> +				if (SPE_OP_PKT_IS_INDIRECT_BRANCH(payload))
> +					decoder->record.op |= ARM_SPE_BR_IND;
>  			}
>  			break;
>  		case ARM_SPE_EVENTS:
> @@ -218,8 +232,12 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
>  			if (payload & BIT(EV_MISPRED))
>  				decoder->record.type |= ARM_SPE_BRANCH_MISS;
>  
> +			if (payload & BIT(EV_NOT_TAKEN))
> +				decoder->record.type |= ARM_SPE_BR_NOT_TAKEN;
> +
>  			break;
>  		case ARM_SPE_DATA_SOURCE:
> +			decoder->record.source = payload;
>  			break;
>  		case ARM_SPE_BAD:
>  			break;
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> index 69b31084d6be..113e427afe99 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> @@ -22,11 +22,18 @@ enum arm_spe_sample_type {
>  	ARM_SPE_TLB_MISS	= 1 << 5,
>  	ARM_SPE_BRANCH_MISS	= 1 << 6,
>  	ARM_SPE_REMOTE_ACCESS	= 1 << 7,
> +	ARM_SPE_BR_NOT_TAKEN	= 1 << 8,

Can you rename it to ARM_SPE_BRANCH_NOT_TAKEN for consistency?

>  };
>  
>  enum arm_spe_op_type {
>  	ARM_SPE_LD		= 1 << 0,
>  	ARM_SPE_ST		= 1 << 1,
> +	ARM_SPE_LDST_EXCL	= 1 << 2,
> +	ARM_SPE_LDST_ATOMIC	= 1 << 3,
> +	ARM_SPE_LDST_ACQREL	= 1 << 4,
> +	ARM_SPE_BR		= 1 << 5,
> +	ARM_SPE_BR_COND		= 1 << 6,
> +	ARM_SPE_BR_IND		= 1 << 7,

I'm not sure if we should keep everything in one enum/bitmask. I'm also
looking at adding more of the data from the packets to the record, and
considering refactoring the record structure. I'll share here when I
have something.

Thanks,
German

>  };
>  
>  struct arm_spe_record {
> @@ -40,6 +47,7 @@ struct arm_spe_record {
>  	u64 virt_addr;
>  	u64 phys_addr;
>  	u64 context_id;
> +	u16 source;
>  };
>  
>  struct arm_spe_insn;
