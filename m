Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF6357A57B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239719AbiGSRg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239716AbiGSRgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:36:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA8B2564D2;
        Tue, 19 Jul 2022 10:36:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF6E91596;
        Tue, 19 Jul 2022 10:36:21 -0700 (PDT)
Received: from [10.57.42.173] (unknown [10.57.42.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0D243F766;
        Tue, 19 Jul 2022 10:36:19 -0700 (PDT)
Message-ID: <1019b931-4d0d-ecea-c170-29e3899acd9b@arm.com>
Date:   Tue, 19 Jul 2022 18:36:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v2 02/13] coresight: trace-id: update CoreSight core to
 use Trace ID API
To:     Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com
References: <20220704081149.16797-1-mike.leach@linaro.org>
 <20220704081149.16797-3-mike.leach@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220704081149.16797-3-mike.leach@linaro.org>
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

Hi Mike

On 04/07/2022 09:11, Mike Leach wrote:
> Initialises the default trace ID map.
> 
> This will be used by all source drivers to be allocated their trace IDs.

As per previous patch, we may not need an explicit call from here.

> 
> The checks for sources to have unique IDs has been removed - this is now
> guaranteed by the ID allocation mechanisms, and inappropriate where
> multiple ID maps are in use in larger systems
> 

And this looks like a candidate for a separate patch, as the sources do
not use the new API yet ? Once they do, in the following patches, we
could remove this code.


All said, this patch could be renamed and moved to the bottom of the 
series, with :

  "coresight: Remove obsolete trace-id uniqueness checks"

Otherwise, looks good to me.



> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>   drivers/hwtracing/coresight/coresight-core.c | 49 ++------------------
>   1 file changed, 4 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 1edfec1e9d18..be69e05fde1f 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -22,6 +22,7 @@
>   #include "coresight-etm-perf.h"
>   #include "coresight-priv.h"
>   #include "coresight-syscfg.h"
> +#include "coresight-trace-id.h"
>   
>   static DEFINE_MUTEX(coresight_mutex);
>   static DEFINE_PER_CPU(struct coresight_device *, csdev_sink);
> @@ -84,45 +85,6 @@ struct coresight_device *coresight_get_percpu_sink(int cpu)
>   }
>   EXPORT_SYMBOL_GPL(coresight_get_percpu_sink);
>   
> -static int coresight_id_match(struct device *dev, void *data)
> -{
> -	int trace_id, i_trace_id;
> -	struct coresight_device *csdev, *i_csdev;
> -
> -	csdev = data;
> -	i_csdev = to_coresight_device(dev);
> -
> -	/*
> -	 * No need to care about oneself and components that are not
> -	 * sources or not enabled
> -	 */
> -	if (i_csdev == csdev || !i_csdev->enable ||
> -	    i_csdev->type != CORESIGHT_DEV_TYPE_SOURCE)
> -		return 0;
> -
> -	/* Get the source ID for both components */
> -	trace_id = source_ops(csdev)->trace_id(csdev);
> -	i_trace_id = source_ops(i_csdev)->trace_id(i_csdev);
> -
> -	/* All you need is one */
> -	if (trace_id == i_trace_id)
> -		return 1;
> -
> -	return 0;
> -}
> -
> -static int coresight_source_is_unique(struct coresight_device *csdev)
> -{
> -	int trace_id = source_ops(csdev)->trace_id(csdev);
> -
> -	/* this shouldn't happen */
> -	if (trace_id < 0)
> -		return 0;
> -
> -	return !bus_for_each_dev(&coresight_bustype, NULL,
> -				 csdev, coresight_id_match);
> -}
> -
>   static int coresight_find_link_inport(struct coresight_device *csdev,
>   				      struct coresight_device *parent)
>   {
> @@ -431,12 +393,6 @@ static int coresight_enable_source(struct coresight_device *csdev, u32 mode)
>   {
>   	int ret;
>   
> -	if (!coresight_source_is_unique(csdev)) {
> -		dev_warn(&csdev->dev, "traceID %d not unique\n",
> -			 source_ops(csdev)->trace_id(csdev));
> -		return -EINVAL;
> -	}
> -
>   	if (!csdev->enable) {
>   		if (source_ops(csdev)->enable) {
>   			ret = coresight_control_assoc_ectdev(csdev, true);
> @@ -1775,6 +1731,9 @@ static int __init coresight_init(void)
>   	if (ret)
>   		goto exit_bus_unregister;
>   
> +	/* initialise the default trace ID map */
> +	coresight_trace_id_init_default_map();
> +
>   	/* initialise the coresight syscfg API */
>   	ret = cscfg_init();
>   	if (!ret)


Suzuki
