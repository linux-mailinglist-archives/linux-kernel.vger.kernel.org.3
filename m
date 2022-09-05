Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988535AD1AC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 13:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237713AbiIELgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 07:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiIELgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 07:36:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D9DF24F0C;
        Mon,  5 Sep 2022 04:36:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15C1CED1;
        Mon,  5 Sep 2022 04:36:52 -0700 (PDT)
Received: from [10.57.16.151] (unknown [10.57.16.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63E0F3F7B4;
        Mon,  5 Sep 2022 04:36:44 -0700 (PDT)
Message-ID: <cad6b3c2-f78f-a6c4-25fd-3402b02a4944@arm.com>
Date:   Mon, 5 Sep 2022 12:36:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 11/13] perf: cs-etm: Handle
 PERF_RECORD_AUX_OUTPUT_HW_ID packet
Content-Language: en-US
To:     Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        quic_jinlmao@quicinc.com
References: <20220823091009.14121-1-mike.leach@linaro.org>
 <20220823091009.14121-12-mike.leach@linaro.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220823091009.14121-12-mike.leach@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/08/2022 10:10, Mike Leach wrote:
> When using dynamically assigned CoreSight trace IDs the drivers can output
> the ID / CPU association as a PERF_RECORD_AUX_OUTPUT_HW_ID packet.
> 
> Update cs-etm decoder to handle this packet by setting the CPU/Trace ID
> mapping.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---

[...]

> -	/* before aux records are queued, need to map metadata to trace IDs */
> -	err = cs_etm__map_trace_ids_metadata(num_cpu, metadata);
> +	/*
> +	 * Map Trace ID values to CPU metadata.
> +	 *
> +	 * Trace metadata will always contain Trace ID values from the legacy algorithm. If the
> +	 * files has been recorded by a "new" perf updated to handle AUX_HW_ID then the metadata
> +	 * ID value will also have the CORESIGHT_TRACE_ID_UNUSED_FLAG set.
> +	 *
> +	 * The updated kernel drivers that use AUX_HW_ID to sent Trace IDs will attempt to use
> +	 * the same IDs as the old algorithm as far as is possible, unless there are clashes
> +	 * in which case a different value will be used. This means an older perf may still
> +	 * be able to record and read files generate on a newer system.
> +	 *
> +	 * For a perf able to interpret AUX_HW_ID packets we first check for the presence of
> +	 * those packets. If they are there then the values will be mapped and plugged into
> +	 * the metadata. We then set any remaining metadata values with the used flag to a
> +	 * value CORESIGHT_TRACE_ID_UNUSED_VAL - which indicates no decoder is required.
> +	 *
> +	 * If no AUX_HW_ID packets are present - which means a file recorded on an old kernel
> +	 * then we map Trace ID values to CPU directly from the metadata - clearing any unused
> +	 * flags if present.
> +	 */
> +
> +	/* first scan for AUX_OUTPUT_HW_ID records to map trace ID values to CPU metadata */
> +	aux_hw_id_found = 0;
> +	err = perf_session__peek_events(session, session->header.data_offset,
> +					session->header.data_size,
> +					cs_etm__process_aux_hw_id_cb, &aux_hw_id_found);
> +	if (err)
> +		goto err_delete_thread;
> +
> +	/* if HW ID found then clear any unused metadata ID values */
> +	if (aux_hw_id_found)
> +		err = cs_etm__clear_unused_trace_ids_metadata(num_cpu, metadata);
> +	/* otherwise, this is a file with metadata values only, map from metadata */
> +	else
> +		err = cs_etm__map_trace_ids_metadata(num_cpu, metadata);
> +
>  	if (err)
>  		goto err_delete_thread;
>  
> @@ -3124,13 +3342,14 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>  
>  	etm->data_queued = etm->queues.populated;
>  	/*
> -	 * Print warning in pipe mode, see cs_etm__process_auxtrace_event() and
> +	 * Print error in pipe mode, see cs_etm__process_auxtrace_event() and
>  	 * cs_etm__queue_aux_fragment() for details relating to limitations.
>  	 */
> -	if (!etm->data_queued)
> -		pr_warning("CS ETM warning: Coresight decode and TRBE support requires random file access.\n"
> -			   "Continuing with best effort decoding in piped mode.\n\n");
> -
> +	if (!etm->data_queued) {
> +		pr_err("CS ETM: Coresight decode and TRBE support need random file access.\n");
> +		err = -EINVAL;
> +		goto err_delete_thread;
> +	}

This error message is never hit because the peek that was added is
followed by:

  if (err)
      goto err_delete_thread;

Peek will return -1 in pipe mode so then you get this output instead:

  ./perf record -e cs_etm//u -o - -- ls > stdio.data
  cat stdio.data | ./perf report -i -

  0x1464 [0x168]: failed to process type: 70
  Error:
  failed to process sample

It would be simpler to add this new check to the very beginning of
cs_etm__process_auxtrace_info() and print the message/quit there instead:

  if (perf_data__is_pipe(session->data))
      return -1;

Then etm->data_queued can also be removed because it's always true.

Apart from that issue:

Reviewed-by: James Clark <james.clark@arm.com>

Thanks
James

>  	return 0;
>  
>  err_delete_thread:
