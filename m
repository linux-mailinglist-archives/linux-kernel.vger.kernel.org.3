Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1428557A958
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 23:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240312AbiGSVuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 17:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbiGSVt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 17:49:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 816B11145D;
        Tue, 19 Jul 2022 14:49:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C67741576;
        Tue, 19 Jul 2022 14:49:57 -0700 (PDT)
Received: from [10.57.42.173] (unknown [10.57.42.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99F6F3F70D;
        Tue, 19 Jul 2022 14:49:55 -0700 (PDT)
Message-ID: <1c9e4aa4-a619-0614-54ef-0ac77117759d@arm.com>
Date:   Tue, 19 Jul 2022 22:49:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v2 07/13] coresight: perf: traceid: Add perf notifiers for
 Trace ID
To:     Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com
References: <20220704081149.16797-1-mike.leach@linaro.org>
 <20220704081149.16797-8-mike.leach@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220704081149.16797-8-mike.leach@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 04/07/2022 09:11, Mike Leach wrote:
> Adds in notifier calls to the trace ID allocator that perf
> events are starting and stopping.
> 
> This ensures that Trace IDs associated with CPUs remain the same
> throughout the perf session, and are only released when all perf
> sessions are complete.

The patch looks fine to me. I think it would be good to add the
definition of coresight_trace_id_perf_{stop,start}() in this patch.

> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>   drivers/hwtracing/coresight/coresight-etm-perf.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index c039b6ae206f..ad3fdc07c60b 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -22,6 +22,7 @@
>   #include "coresight-etm-perf.h"
>   #include "coresight-priv.h"
>   #include "coresight-syscfg.h"
> +#include "coresight-trace-id.h"
>   
>   static struct pmu etm_pmu;
>   static bool etm_perf_up;
> @@ -228,6 +229,9 @@ static void free_event_data(struct work_struct *work)
>   		*ppath = NULL;
>   	}
>   
> +	/* mark perf event as done for trace id allocator */
> +	coresight_trace_id_perf_stop();
> +
>   	free_percpu(event_data->path);
>   	kfree(event_data);
>   }
> @@ -314,6 +318,9 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>   		sink = user_sink = coresight_get_sink_by_id(id);
>   	}
>   
> +	/* tell the trace ID allocator that a perf event is starting up */
> +	coresight_trace_id_perf_start();
> +
>   	/* check if user wants a coresight configuration selected */
>   	cfg_hash = (u32)((event->attr.config2 & GENMASK_ULL(63, 32)) >> 32);
>   	if (cfg_hash) {

Suzuki
