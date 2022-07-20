Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B24057BB13
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 18:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbiGTQHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 12:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGTQHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:07:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B9DC2BB23;
        Wed, 20 Jul 2022 09:07:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 648981570;
        Wed, 20 Jul 2022 09:07:05 -0700 (PDT)
Received: from [10.32.33.51] (e121896.warwick.arm.com [10.32.33.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57D5B3F766;
        Wed, 20 Jul 2022 09:07:03 -0700 (PDT)
Message-ID: <c7e0acdf-61d8-e442-50aa-9cf7e8a71c0e@arm.com>
Date:   Wed, 20 Jul 2022 17:07:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 11/13] perf: cs-etm: Handle
 PERF_RECORD_AUX_OUTPUT_HW_ID packet
Content-Language: en-US
To:     Mike Leach <mike.leach@linaro.org>
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        quic_jinlmao@quicinc.com, suzuki.poulose@arm.com,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220704081149.16797-1-mike.leach@linaro.org>
 <20220704081149.16797-12-mike.leach@linaro.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220704081149.16797-12-mike.leach@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/07/2022 09:11, Mike Leach wrote:
> When using dynamically assigned CoreSight trace IDs the drivers can output
> the ID / CPU association as a PERF_RECORD_AUX_OUTPUT_HW_ID packet.
> 
> Update cs-etm decoder to handle this packet by setting the CPU/Trace ID
> mapping.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>  tools/include/linux/coresight-pmu.h           |  14 ++
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c |   9 +
>  tools/perf/util/cs-etm.c                      | 167 +++++++++++++++++-
>  3 files changed, 185 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
> index 31d007fab3a6..4e8b3148f939 100644
> --- a/tools/include/linux/coresight-pmu.h
> +++ b/tools/include/linux/coresight-pmu.h
> @@ -7,6 +7,8 @@
>  #ifndef _LINUX_CORESIGHT_PMU_H
>  #define _LINUX_CORESIGHT_PMU_H
>  
> +#include <linux/bits.h>
> +
>  #define CORESIGHT_ETM_PMU_NAME "cs_etm"
>  
>  /*
> @@ -40,4 +42,16 @@
>  #define ETM4_CFG_BIT_RETSTK	12
>  #define ETM4_CFG_BIT_VMID_OPT	15
>  
> +/*
> + * Interpretation of the PERF_RECORD_AUX_OUTPUT_HW_ID payload.
> + * Used to associate a CPU with the CoreSight Trace ID.
> + * [63:16] - unused SBZ
> + * [15:08] - Trace ID
> + * [07:00] - Version
> + */
> +#define CS_AUX_HW_ID_VERSION_MASK	GENMASK_ULL(7, 0)
> +#define CS_AUX_HW_ID_TRACE_ID_MASK	GENMASK_ULL(15, 8)
> +
> +#define CS_AUX_HW_ID_CURR_VERSION 0
> +
>  #endif
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index 31fa3b45134a..d1dd73310707 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -611,6 +611,8 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
>  	return resp;
>  }
>  
> +#define CS_TRACE_ID_MASK GENMASK(6, 0)
> +
>  static int
>  cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
>  				   struct cs_etm_trace_params *t_params,
> @@ -625,6 +627,7 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
>  	switch (t_params->protocol) {
>  	case CS_ETM_PROTO_ETMV3:
>  	case CS_ETM_PROTO_PTM:
> +		csid = (t_params->etmv3.reg_idr & CS_TRACE_ID_MASK);
>  		cs_etm_decoder__gen_etmv3_config(t_params, &config_etmv3);
>  		decoder->decoder_name = (t_params->protocol == CS_ETM_PROTO_ETMV3) ?
>  							OCSD_BUILTIN_DCD_ETMV3 :
> @@ -632,11 +635,13 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
>  		trace_config = &config_etmv3;
>  		break;
>  	case CS_ETM_PROTO_ETMV4i:
> +		csid = (t_params->etmv4.reg_traceidr & CS_TRACE_ID_MASK);
>  		cs_etm_decoder__gen_etmv4_config(t_params, &trace_config_etmv4);
>  		decoder->decoder_name = OCSD_BUILTIN_DCD_ETMV4I;
>  		trace_config = &trace_config_etmv4;
>  		break;
>  	case CS_ETM_PROTO_ETE:
> +		csid = (t_params->ete.reg_traceidr & CS_TRACE_ID_MASK);
>  		cs_etm_decoder__gen_ete_config(t_params, &trace_config_ete);
>  		decoder->decoder_name = OCSD_BUILTIN_DCD_ETE;
>  		trace_config = &trace_config_ete;
> @@ -645,6 +650,10 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
>  		return -1;
>  	}
>  
> +	/* if the CPU has no trace ID associated, no decoder needed */
> +	if (csid == CS_UNUSED_TRACE_ID)
> +		return 0;
> +
>  	if (d_params->operation == CS_ETM_OPERATION_DECODE) {
>  		if (ocsd_dt_create_decoder(decoder->dcd_tree,
>  					   decoder->decoder_name,
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index df9d67901f8d..ffce858f21fd 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -217,6 +217,139 @@ static int cs_etm__map_trace_id(u8 trace_chan_id, u64 *cpu_metadata)
>  	return 0;
>  }
>  
> +static int cs_etm__metadata_get_trace_id(u8 *trace_chan_id, u64 *cpu_metadata)
> +{
> +	u64 cs_etm_magic = cpu_metadata[CS_ETM_MAGIC];
> +
> +	switch (cs_etm_magic) {
> +	case __perf_cs_etmv3_magic:
> +		*trace_chan_id = cpu_metadata[CS_ETM_ETMTRACEIDR];
> +		break;
> +	case __perf_cs_etmv4_magic:
> +	case __perf_cs_ete_magic:
> +		*trace_chan_id = cpu_metadata[CS_ETMV4_TRCTRACEIDR];
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static int cs_etm__metadata_set_trace_id(u8 trace_chan_id, u64 *cpu_metadata)
> +{
> +	u64 cs_etm_magic = cpu_metadata[CS_ETM_MAGIC];
> +
> +	switch (cs_etm_magic) {
> +	case __perf_cs_etmv3_magic:
> +		 cpu_metadata[CS_ETM_ETMTRACEIDR] = trace_chan_id;
> +		break;
> +	case __perf_cs_etmv4_magic:
> +	case __perf_cs_ete_magic:
> +		cpu_metadata[CS_ETMV4_TRCTRACEIDR] = trace_chan_id;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +/*
> + * FIELD_GET (linux/bitfield.h) not available outside kernel code,
> + * and the header contains too many dependencies to just copy over,
> + * so roll our own based on the original
> + */
> +#define __bf_shf(x) (__builtin_ffsll(x) - 1)
> +#define FIELD_GET(_mask, _reg)						\
> +	({								\
> +		(typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
> +	})
> +> +/*
> + * Handle the PERF_RECORD_AUX_OUTPUT_HW_ID event.
> + *
> + * The payload associates the Trace ID and the CPU.
> + * The routine is tolerant of seeing multiple packets with the same association,
> + * but a CPU / Trace ID association changing during a session is an error.
> + */
> +static int cs_etm__process_aux_output_hw_id(struct perf_session *session,
> +					    union perf_event *event)
> +{
> +	struct cs_etm_auxtrace *etm;
> +	struct perf_sample sample;
> +	struct int_node *inode;
> +	struct evsel *evsel;
> +	u64 *cpu_data;
> +	u64 hw_id;
> +	int cpu, version, err;
> +	u8 trace_chan_id, curr_chan_id;
> +
> +	/* extract and parse the HW ID */
> +	hw_id = event->aux_output_hw_id.hw_id;
> +	version = FIELD_GET(CS_AUX_HW_ID_VERSION_MASK, hw_id);
> +	trace_chan_id = FIELD_GET(CS_AUX_HW_ID_TRACE_ID_MASK, hw_id);
> +
> +	/* check that we can handle this version */
> +	if (version > CS_AUX_HW_ID_CURR_VERSION)
> +		return -EINVAL;
> +
> +	/* get access to the etm metadata */
> +	etm = container_of(session->auxtrace, struct cs_etm_auxtrace, auxtrace);
> +	if (!etm || !etm->metadata)
> +		return -EINVAL;
> +
> +	/* parse the sample to get the CPU */
> +	evsel = evlist__event2evsel(session->evlist, event);
> +	if (!evsel)
> +		return -EINVAL;
> +	err = evsel__parse_sample(evsel, event, &sample);
> +	if (err)
> +		return err;
> +	cpu = sample.cpu;
> +	if (cpu == -1) {
> +		/* no CPU in the sample - possibly recorded with an old version of perf */
> +		pr_err("CS_ETM: no CPU AUX_OUTPUT_HW_ID sample. Use compatible perf to record.");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * look to see if the metadata contains a valid trace ID.
> +	 * if so we mapped it before and it must be the same as the ID in the packet.
> +	 */
> +	cpu_data = etm->metadata[cpu];
> +	err = cs_etm__metadata_get_trace_id(&curr_chan_id, cpu_data);
> +	if (err)
> +		return err;
> +	if (CS_IS_VALID_TRACE_ID(curr_chan_id) && (curr_chan_id != trace_chan_id)) {
> +		pr_err("CS_ETM: mismatch between CPU trace ID and HW_ID packet ID\n");
> +		return -EINVAL;
> +	}
> +
> +	/* next see if the ID is mapped to a CPU, and it matches the current CPU */
> +	inode = intlist__find(traceid_list, trace_chan_id);
> +	if (inode) {
> +		cpu_data = inode->priv;
> +		if ((int)cpu_data[CS_ETM_CPU] != cpu) {
> +			pr_err("CS_ETM: map mismatch between HW_ID packet CPU and Trace ID\n");
> +			return -EINVAL;
> +		}
> +		return 0;
> +	}
> +
> +	/* not one we've seen before - lets map it */
> +	err = cs_etm__map_trace_id(trace_chan_id, cpu_data);
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * if we are picking up the association from the packet, need to plug
> +	 * the correct trace ID into the metadata for setting up decoders later.
> +	 */
> +	err = cs_etm__metadata_set_trace_id(trace_chan_id, cpu_data);
> +	return err;
> +}
> +
>  void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
>  					      u8 trace_chan_id)
>  {
> @@ -2433,6 +2566,8 @@ static int cs_etm__process_event(struct perf_session *session,
>  		return cs_etm__process_itrace_start(etm, event);
>  	else if (event->header.type == PERF_RECORD_SWITCH_CPU_WIDE)
>  		return cs_etm__process_switch_cpu_wide(etm, event);
> +	else if (event->header.type ==  PERF_RECORD_AUX_OUTPUT_HW_ID)
> +		return cs_etm__process_aux_output_hw_id(session, event);

This shouldn't need to be handled here because of the peek at the beginning. Although
it's probably harmless to do it twice, it can make deciphering the flow quite difficult.

>  
>  	if (!etm->timeless_decoding && event->header.type == PERF_RECORD_AUX) {
>  		/*
> @@ -2662,7 +2797,7 @@ static void cs_etm__print_auxtrace_info(__u64 *val, int num)
>  	for (i = CS_HEADER_VERSION_MAX; cpu < num; cpu++) {
>  		if (version == 0)
>  			err = cs_etm__print_cpu_metadata_v0(val, &i);
> -		else if (version == 1)
> +		else if (version == 1 || version == 2)
>  			err = cs_etm__print_cpu_metadata_v1(val, &i);
>  		if (err)
>  			return;
> @@ -2774,11 +2909,16 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
>  	}
>  
>  	/*
> -	 * In per-thread mode, CPU is set to -1, but TID will be set instead. See
> -	 * auxtrace_mmap_params__set_idx(). Return 'not found' if neither CPU nor TID match.
> +	 * In per-thread mode, auxtrace CPU is set to -1, but TID will be set instead. See
> +	 * auxtrace_mmap_params__set_idx(). However, the sample AUX event will contain a
> +	 * CPU as we set this always for the AUX_OUTPUT_HW_ID event.
> +	 * So now compare only TIDs if auxtrace CPU is -1, and CPUs if auxtrace CPU is not -1.
> +	 * Return 'not found' if mismatch.
>  	 */
> -	if ((auxtrace_event->cpu == (__u32) -1 && auxtrace_event->tid != sample->tid) ||
> -			auxtrace_event->cpu != sample->cpu)
> +	if (auxtrace_event->cpu == (__u32) -1) {
> +		if (auxtrace_event->tid != sample->tid)
> +			return 1;
> +	} else if (auxtrace_event->cpu != sample->cpu)
>  		return 1;
>  
>  	if (aux_event->flags & PERF_AUX_FLAG_OVERWRITE) {
> @@ -2827,6 +2967,15 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
>  	return 1;
>  }
>  
> +static int cs_etm__process_aux_hw_id_cb(struct perf_session *session, union perf_event *event,
> +					u64 offset __maybe_unused, void *data __maybe_unused)
> +{
> +	/* look to handle PERF_RECORD_AUX_OUTPUT_HW_ID early to ensure decoders can be set up */
> +	if (event->header.type == PERF_RECORD_AUX_OUTPUT_HW_ID)
> +		return cs_etm__process_aux_output_hw_id(session, event);
> +	return 0;
> +}

I couldn't see the relationship between the two peeks and why they couldn't be done together
in one pass. I changed it so cs_etm__process_aux_hw_id_cb() is also called on the peek
to queue the aux records and it seemed to work. At least just opening the file and glancing.

If there is some dependency though, I don't think two passes is excessive.

> +
>  static int cs_etm__queue_aux_records_cb(struct perf_session *session, union perf_event *event,
>  					u64 offset __maybe_unused, void *data __maybe_unused)
>  {
> @@ -3109,6 +3258,14 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>  	if (err)
>  		goto err_delete_thread;
>  
> +	/* scan for AUX_OUTPUT_HW_ID records */
> +	if (hdr_version >=  CS_AUX_HW_ID_VERSION_MIN) {
> +		err = perf_session__peek_events(session, session->header.data_offset,
> +						session->header.data_size,
> +						cs_etm__process_aux_hw_id_cb, NULL);

This no longer works at all with piping because of this line in peek_events:

   	if (perf_data__is_pipe(session->data))
		return -1;

So we should change the warning message to an error and exit earlier:

  	if (!etm->data_queued)
		pr_warning("CS ETM warning: Coresight decode and TRBE support requires random file access.\n"
			   "Continuing with best effort decoding in piped mode.\n\n");

And then we can also remove all the now dead code and variables related to piping like:

   etm->data_queued = etm->queues.populated;
   ...

   if (!etm->data_queued) {
      ...
   }

   
> +		if (err)
> +			goto err_delete_thread;
> +	}
>  	err = cs_etm__queue_aux_records(session);
>  	if (err)
>  		goto err_delete_thread;
