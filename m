Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6BD57A956
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 23:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240450AbiGSVsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 17:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240550AbiGSVsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 17:48:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D014193D7;
        Tue, 19 Jul 2022 14:47:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 703F91576;
        Tue, 19 Jul 2022 14:47:57 -0700 (PDT)
Received: from [10.57.42.173] (unknown [10.57.42.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 413A23F70D;
        Tue, 19 Jul 2022 14:47:55 -0700 (PDT)
Message-ID: <830a67cd-2d3a-b1ea-66cd-5a44ee357bbb@arm.com>
Date:   Tue, 19 Jul 2022 22:47:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v2 06/13] coresight: etmX.X: stm: Remove unused legacy
 source Trace ID ops
To:     Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com
References: <20220704081149.16797-1-mike.leach@linaro.org>
 <20220704081149.16797-7-mike.leach@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220704081149.16797-7-mike.leach@linaro.org>
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

Nice diff stat !

Also minor nit on subject:

coresight: source: Remove trace_id() call back


On 04/07/2022 09:11, Mike Leach wrote:
> CoreSight sources provide a callback (.trace_id) in the standard source
> ops which returns the ID to the core code. This was used to check that
> sources all had a unique Trace ID.
> 
> Uniqueness is now gauranteed by the Trace ID allocation system, and the
> check code has been removed from the core.
> 
> This patch removes the unneeded and unused .trace_id source ops
> from the ops structure and implementations in etm3x, etm4x and stm.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>   drivers/hwtracing/coresight/coresight-etm.h   |  1 -
>   .../coresight/coresight-etm3x-core.c          | 37 -------------------
>   .../coresight/coresight-etm4x-core.c          |  8 ----
>   drivers/hwtracing/coresight/coresight-stm.c   |  8 ----
>   include/linux/coresight.h                     |  3 --
>   5 files changed, 57 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
> index 3667428d38b6..9a0d08b092ae 100644
> --- a/drivers/hwtracing/coresight/coresight-etm.h
> +++ b/drivers/hwtracing/coresight/coresight-etm.h
> @@ -283,7 +283,6 @@ static inline unsigned int etm_readl(struct etm_drvdata *drvdata, u32 off)
>   }
>   
>   extern const struct attribute_group *coresight_etm_groups[];
> -int etm_get_trace_id(struct etm_drvdata *drvdata);
>   void etm_set_default(struct etm_config *config);
>   void etm_config_trace_mode(struct etm_config *config);
>   struct etm_config *get_etm_config(struct etm_drvdata *drvdata);
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> index 273f37be322b..911d961dd736 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> @@ -455,42 +455,6 @@ static int etm_cpu_id(struct coresight_device *csdev)
>   	return drvdata->cpu;
>   }
>   
> -int etm_get_trace_id(struct etm_drvdata *drvdata)
> -{
> -	unsigned long flags;
> -	int trace_id = -1;
> -	struct device *etm_dev;
> -
> -	if (!drvdata)
> -		goto out;
> -
> -	etm_dev = drvdata->csdev->dev.parent;
> -	if (!local_read(&drvdata->mode))
> -		return drvdata->traceid;
> -
> -	pm_runtime_get_sync(etm_dev);
> -
> -	spin_lock_irqsave(&drvdata->spinlock, flags);
> -
> -	CS_UNLOCK(drvdata->base);
> -	trace_id = (etm_readl(drvdata, ETMTRACEIDR) & ETM_TRACEID_MASK);
> -	CS_LOCK(drvdata->base);
> -
> -	spin_unlock_irqrestore(&drvdata->spinlock, flags);
> -	pm_runtime_put(etm_dev);
> -
> -out:
> -	return trace_id;
> -
> -}
> -
> -static int etm_trace_id(struct coresight_device *csdev)
> -{
> -	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> -
> -	return etm_get_trace_id(drvdata);
> -}
> -
>   int etm_read_alloc_trace_id(struct etm_drvdata *drvdata)
>   {
>   	int trace_id;
> @@ -731,7 +695,6 @@ static void etm_disable(struct coresight_device *csdev,
>   
>   static const struct coresight_ops_source etm_source_ops = {
>   	.cpu_id		= etm_cpu_id,
> -	.trace_id	= etm_trace_id,
>   	.enable		= etm_enable,
>   	.disable	= etm_disable,
>   };
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 3f4f7ddd14ec..b7c7980cc71c 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -228,13 +228,6 @@ static int etm4_cpu_id(struct coresight_device *csdev)
>   	return drvdata->cpu;
>   }
>   
> -static int etm4_trace_id(struct coresight_device *csdev)
> -{
> -	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> -
> -	return drvdata->trcid;
> -}
> -
>   int etm4_read_alloc_trace_id(struct etmv4_drvdata *drvdata)
>   {
>   	int trace_id;
> @@ -998,7 +991,6 @@ static void etm4_disable(struct coresight_device *csdev,
>   
>   static const struct coresight_ops_source etm4_source_ops = {
>   	.cpu_id		= etm4_cpu_id,
> -	.trace_id	= etm4_trace_id,
>   	.enable		= etm4_enable,
>   	.disable	= etm4_disable,
>   };
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index 9ef3e923a930..f4b4232614b0 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -281,15 +281,7 @@ static void stm_disable(struct coresight_device *csdev,
>   	}
>   }
>   
> -static int stm_trace_id(struct coresight_device *csdev)
> -{
> -	struct stm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> -
> -	return drvdata->traceid;
> -}
> -
>   static const struct coresight_ops_source stm_source_ops = {
> -	.trace_id	= stm_trace_id,
>   	.enable		= stm_enable,
>   	.disable	= stm_disable,
>   };
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 9f445f09fcfe..247147c11231 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -314,14 +314,11 @@ struct coresight_ops_link {
>    * Operations available for sources.
>    * @cpu_id:	returns the value of the CPU number this component
>    *		is associated to.
> - * @trace_id:	returns the value of the component's trace ID as known
> - *		to the HW.
>    * @enable:	enables tracing for a source.
>    * @disable:	disables tracing for a source.
>    */
>   struct coresight_ops_source {
>   	int (*cpu_id)(struct coresight_device *csdev);
> -	int (*trace_id)(struct coresight_device *csdev);
>   	int (*enable)(struct coresight_device *csdev,
>   		      struct perf_event *event,  u32 mode);
>   	void (*disable)(struct coresight_device *csdev,


Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
