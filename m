Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A48505B24
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345265AbiDRPfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240365AbiDRPfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:35:38 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B8131221
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 07:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650293573; x=1681829573;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oVGtE8Lj81Yo544G680aS27GfDw6ODS5zIIAjioKPIw=;
  b=lDU8zLDiUSWHx34yIO0CI/9SbgrP0rBbqpsVJDMVNYiu5MC0bvfwVh6h
   opoUnquLfF/dhB3KkbuJzGoa6WadCBU4YfNsqR5nixFNDX+nMZMDZRA4y
   5CWlkGZwwX8xFj3Nfy9vVRbASvSS5bKQlMEyVvps/8JXAIx8mnxMZLSxN
   qzugGapgb0MNbp5SURXhdZLcMc9njZIaOb7SGm+4pd3vPdcv2peRPkKQ8
   Wsm0zuI4gMDaIBIDrbWU/9ukVukrR4H+yPSLRTLpZuT8yAV0AVvAuOl6J
   e6U0+Q3x5Xsbxl/VlTFcZ3LLMBDUG6x+eL+WvcdM4/1CarMdEejtS864r
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="262391954"
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="262391954"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 07:52:52 -0700
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="554260430"
Received: from dsanford-mobl.amr.corp.intel.com (HELO [10.212.126.249]) ([10.212.126.249])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 07:52:51 -0700
Message-ID: <9ad57247-36df-cb3d-d50f-feb3c80f17e6@intel.com>
Date:   Mon, 18 Apr 2022 07:52:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] ntb_perf: extend with burst/poll/doorbell latency
 measurement
Content-Language: en-US
To:     Alexander Fomichev <fomichev.ru@gmail.com>, ntb@lists.linux.dev
Cc:     linux@yadro.com, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20220417235517.26865-1-a.fomichev@yadro.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220417235517.26865-1-a.fomichev@yadro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/17/2022 4:55 PM, Alexander Fomichev wrote:
> From: Alexander Fomichev <fomichev.ru@gmail.com>
>
> The ntb_perf test provides a tool for NTB hardware performance
> evaluation. For software impact elimination the test uses a simple method
> (let's call it 'burst' mode), when the local system sends to the remote
> system a data set and counts time interval until hardware completion
> report, without the remote side confirming, nor data integrity check.
> The measured metric is a 'burst' throughput bandwidth of NTB connection.
>
> The proposed change extends ntb_perf with 3 new metrics. The resulting
> test is fully backward compatible.
>
> 1. Burst latency. It's a delay between start to send 1 byte to the
> remote system and hardware readiness to send another byte. The
> measurement performed within bandwidth test procedure. The DMA Engine is
> off. Data integrity is not checked. This mode can be disabled by
> 'perf_latency=N' module parameter.
>
> 2. Poll latency. It's a delay between start to send 1 byte to the
> remote system and receiving the confirmation. The remote system needs to
> be run in server mode beforehand. Then the server polls the input buffer
> and on receiving data immediately sends confirmation.
>
> 3. Doorbell latency. It's a delay between start to ring an NTB doorbell
> and receiving the confirmation. The remote system needs to be run in server
> mode beforehand. Then the server waits for a doorbell event and immediately
> rings self doorbell to confirm.

I don't see any major issues with the code. However, is it possible to 
break the introduction of these 3 metrics into 3 different patches for 
easier review?


>
> Signed-off-by: Alexander Fomichev <fomichev.ru@gmail.com>
> ---
>   drivers/ntb/test/ntb_perf.c | 820 +++++++++++++++++++++++++++++++++++-
>   1 file changed, 804 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index 65e1e5cf1b29..c106c3a5097e 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -6,6 +6,7 @@
>    *
>    *   Copyright(c) 2015 Intel Corporation. All rights reserved.
>    *   Copyright(c) 2017 T-Platforms. All Rights Reserved.
> + *   Copyright(c) 2022 YADRO. All Rights Reserved.
>    *
>    *   This program is free software; you can redistribute it and/or modify
>    *   it under the terms of version 2 of the GNU General Public License as
> @@ -15,6 +16,7 @@
>    *
>    *   Copyright(c) 2015 Intel Corporation. All rights reserved.
>    *   Copyright(c) 2017 T-Platforms. All Rights Reserved.
> + *   Copyright(c) 2022 YADRO. All Rights Reserved.
>    *
>    *   Redistribution and use in source and binary forms, with or without
>    *   modification, are permitted provided that the following conditions
> @@ -65,6 +67,22 @@
>    *
>    * root@self# echo 0 > $DBG_DIR/run
>    * root@self# cat $DBG_DIR/run
> + *-----------------------------------------------------------------------------
> + * Eg: start latency test with peer (index 0) poll-waiting and get the metrics
> + *
> + * Server side:
> + * root@self# echo 0 > $DBG_DIR/poll_latency/run_server
> + * Client side:
> + * root@self# echo 0 > $DBG_DIR/poll_latency/run_client
> + * root@self# cat $DBG_DIR/poll_latency/run_client
> + *-----------------------------------------------------------------------------
> + * Eg: start doorbell latency test with peer (index 0) and get the metrics
> + *
> + * Server side:
> + * root@self# echo 0 > $DBG_DIR/db_latency/run_server
> + * Client side:
> + * root@self# echo 0 > $DBG_DIR/db_latency/run_client
> + * root@self# cat $DBG_DIR/db_latency/run_client
>    */
>   
>   #include <linux/init.h>
> @@ -76,6 +94,7 @@
>   #include <linux/dmaengine.h>
>   #include <linux/pci.h>
>   #include <linux/ktime.h>
> +#include <linux/jiffies.h>
>   #include <linux/slab.h>
>   #include <linux/delay.h>
>   #include <linux/sizes.h>
> @@ -85,7 +104,7 @@
>   #include <linux/ntb.h>
>   
>   #define DRIVER_NAME		"ntb_perf"
> -#define DRIVER_VERSION		"2.0"
> +#define DRIVER_VERSION		"2.2"
>   
>   MODULE_LICENSE("Dual BSD/GPL");
>   MODULE_VERSION(DRIVER_VERSION);
> @@ -106,6 +125,9 @@ MODULE_DESCRIPTION("PCIe NTB Performance Measurement Tool");
>   
>   #define PERF_BUF_LEN 1024
>   
> +#define LAT_MIN_TRIES	20
> +#define RESCHEDULE_RATIO	10000
> +
>   static unsigned long max_mw_size;
>   module_param(max_mw_size, ulong, 0644);
>   MODULE_PARM_DESC(max_mw_size, "Upper limit of memory window size");
> @@ -122,6 +144,22 @@ static bool use_dma; /* default to 0 */
>   module_param(use_dma, bool, 0644);
>   MODULE_PARM_DESC(use_dma, "Use DMA engine to measure performance");
>   
> +static bool perf_latency = true;
> +module_param(perf_latency, bool, 0644);
> +MODULE_PARM_DESC(perf_latency, "Also measure latency");
> +
> +static unsigned long lat_time_ms = 1000; /* default 1s */
> +module_param(lat_time_ms, ulong, 0644);
> +MODULE_PARM_DESC(lat_time_ms, "Time (in ms) to test latency");
> +
> +static unsigned long lat_timeout_us = 500;
> +module_param(lat_timeout_us, ulong, 0644);
> +MODULE_PARM_DESC(lat_timeout_us, "Timeout (in us) to wait for server reply");
> +
> +static unsigned long peer_timeout_s = 60;
> +module_param(peer_timeout_s, ulong, 0644);
> +MODULE_PARM_DESC(peer_timeout_s, "Timeout (in s) to wait for peer link");
> +
>   /*==============================================================================
>    *                         Perf driver data definition
>    *==============================================================================
> @@ -138,7 +176,21 @@ enum perf_cmd {
>   	PERF_STS_LNKUP = 6, /* link up state flag */
>   };
>   
> +enum run_mode {
> +	RUN_PL_CLIENT,
> +	RUN_PL_SERVER,
> +	RUN_DBL_CLIENT,
> +	RUN_DBL_SERVER,
> +};
> +
>   struct perf_ctx;
> +struct perf_ext_lat_data;
> +
> +struct perf_ext_lat_ops {
> +	int (*init)(struct perf_ext_lat_data *data);
> +	int (*run)(struct perf_ext_lat_data *data);
> +	void (*clear)(struct perf_ext_lat_data *data);
> +};
>   
>   struct perf_peer {
>   	struct perf_ctx	*perf;
> @@ -178,12 +230,30 @@ struct perf_thread {
>   	void *src;
>   	u64 copied;
>   	ktime_t duration;
> +	ktime_t latency;
> +	u64 tries;
>   	int status;
>   	struct work_struct work;
>   };
>   #define to_thread_work(__work) \
>   	container_of(__work, struct perf_thread, work)
>   
> +struct perf_ext_lat_data {
> +	struct perf_ctx *perf;
> +	ktime_t latency;
> +	u64 tries;
> +	int status;
> +	struct perf_ext_lat_ops ops;
> +	struct work_struct work;
> +
> +	union {
> +		void *src;
> +		int db;
> +	};
> +};
> +#define to_ext_lat_data(__work) \
> +	container_of(__work, struct perf_ext_lat_data, work)
> +
>   struct perf_ctx {
>   	struct ntb_dev *ntb;
>   
> @@ -192,6 +262,12 @@ struct perf_ctx {
>   	int pcnt;
>   	struct perf_peer *peers;
>   
> +	/* Ext latency tests interface */
> +	enum run_mode mode;
> +	struct perf_ext_lat_data pldata;
> +	struct perf_ext_lat_data dbldata;
> +	atomic_t running;
> +
>   	/* Performance measuring work-threads interface */
>   	unsigned long busy_flag;
>   	wait_queue_head_t twait;
> @@ -239,6 +315,8 @@ static struct dentry *perf_dbgfs_topdir;
>   
>   static struct workqueue_struct *perf_wq __read_mostly;
>   
> +static const u8 stop_word = 0xFF;
> +
>   /*==============================================================================
>    *                  NTB cross-link commands execution service
>    *==============================================================================
> @@ -501,6 +579,15 @@ static void perf_link_event(void *ctx)
>   	}
>   }
>   
> +static inline void perf_dbl_pong(struct perf_ctx *perf)
> +{
> +	struct perf_ext_lat_data *data = &perf->dbldata;
> +
> +	ntb_db_clear(perf->ntb, BIT_ULL(data->db));
> +	data->tries++;
> +	ntb_peer_db_set(perf->ntb, BIT_ULL(data->db));
> +}
> +
>   static void perf_db_event(void *ctx, int vec)
>   {
>   	struct perf_ctx *perf = ctx;
> @@ -509,7 +596,11 @@ static void perf_db_event(void *ctx, int vec)
>   		ntb_db_vector_mask(perf->ntb, vec), ntb_db_read(perf->ntb));
>   
>   	/* Just receive all available commands */
> -	(void)perf_cmd_recv(perf);
> +	if (perf->dbldata.db >= 0 &&
> +				BIT_ULL(perf->dbldata.db) & ntb_db_read(perf->ntb))
> +		perf_dbl_pong(perf);
> +	else
> +		(void)perf_cmd_recv(perf);
>   }
>   
>   static void perf_msg_event(void *ctx)
> @@ -664,6 +755,8 @@ static int perf_init_service(struct perf_ctx *perf)
>   		return -EINVAL;
>   	}
>   
> +	perf->dbldata.db = -1;
> +
>   	if (ntb_msg_count(perf->ntb) >= PERF_MSG_CNT) {
>   		perf->cmd_send = perf_msg_cmd_send;
>   		perf->cmd_recv = perf_msg_cmd_recv;
> @@ -783,7 +876,7 @@ static void perf_dma_copy_callback(void *data)
>   }
>   
>   static int perf_copy_chunk(struct perf_thread *pthr,
> -			   void __iomem *dst, void *src, size_t len)
> +			   void __iomem *dst, void *src, size_t len, bool use_dma_)
>   {
>   	struct dma_async_tx_descriptor *tx;
>   	struct dmaengine_unmap_data *unmap;
> @@ -794,7 +887,7 @@ static int perf_copy_chunk(struct perf_thread *pthr,
>   	void __iomem *dst_vaddr;
>   	dma_addr_t dst_dma_addr;
>   
> -	if (!use_dma) {
> +	if (!use_dma_) {
>   		memcpy_toio(dst, src, len);
>   		goto ret_check_tsync;
>   	}
> @@ -940,7 +1033,7 @@ static int perf_run_test(struct perf_thread *pthr)
>   
>   	/* Copied field is cleared on test launch stage */
>   	while (pthr->copied < total_size) {
> -		ret = perf_copy_chunk(pthr, flt_dst, flt_src, chunk_size);
> +		ret = perf_copy_chunk(pthr, flt_dst, flt_src, chunk_size, use_dma);
>   		if (ret) {
>   			dev_err(&perf->ntb->dev, "%d: Got error %d on test\n",
>   				pthr->tidx, ret);
> @@ -1018,6 +1111,65 @@ static void perf_clear_test(struct perf_thread *pthr)
>   	kfree(pthr->src);
>   }
>   
> +static int perf_run_latency(struct perf_thread *pthr)
> +{
> +	struct perf_peer *peer = pthr->perf->test_peer;
> +	struct ntb_dev *ntb = pthr->perf->ntb;
> +	void *flt_src;
> +	void __iomem *flt_dst, *bnd_dst;
> +	int ret;
> +	u64 stop_at = ktime_get_real_fast_ns() + lat_time_ms * NSEC_PER_MSEC;
> +
> +	pthr->tries = 0;
> +	pthr->latency = ktime_get();
> +	flt_src = pthr->src;
> +	flt_dst = peer->outbuf;
> +	bnd_dst = peer->outbuf + peer->outbuf_size;
> +
> +	while (ktime_get_real_fast_ns() < stop_at) {
> +		ret = perf_copy_chunk(pthr, flt_dst, flt_src, 1, false);
> +		if (ret) {
> +			dev_err(&ntb->dev, "%d: Latency testing error %d\n",
> +				pthr->tidx, ret);
> +			pthr->latency = ktime_set(0, 0);
> +			return ret;
> +		}
> +
> +		pthr->tries++;
> +		flt_dst++;
> +		flt_src++;
> +
> +		if (flt_dst >= bnd_dst || flt_dst < peer->outbuf) {
> +			flt_dst = peer->outbuf;
> +			flt_src = pthr->src;
> +		}
> +
> +		/* Avoid processor soft lock-ups */
> +		if (!(pthr->tries % RESCHEDULE_RATIO))
> +			schedule();
> +	}
> +
> +	/* Stop timer */
> +	pthr->latency = ktime_sub(ktime_get(), pthr->latency);
> +
> +	if (pthr->tries < LAT_MIN_TRIES) {
> +		dev_err(&ntb->dev, "%d: Too few steps to measure Latency. "
> +				"Increase test time\n", pthr->tidx);
> +		pthr->latency = ktime_set(0, 0);
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(&ntb->dev, "%d: made %llu tries, lasted %llu usecs\n",
> +		pthr->tidx, pthr->tries, ktime_to_us(pthr->latency));
> +
> +	pthr->latency = ns_to_ktime(ktime_divns(pthr->latency, pthr->tries));
> +
> +	dev_dbg(&ntb->dev, "%d: latency %llu us (%llu ns)\n", pthr->tidx,
> +		ktime_to_us(pthr->latency), ktime_to_ns(pthr->latency));
> +
> +	return 0;
> +}
> +
>   static void perf_thread_work(struct work_struct *work)
>   {
>   	struct perf_thread *pthr = to_thread_work(work);
> @@ -1043,11 +1195,280 @@ static void perf_thread_work(struct work_struct *work)
>   	}
>   
>   	pthr->status = perf_sync_test(pthr);
> +	if (pthr->status)
> +		goto err_clear_test;
> +
> +	if (perf_latency)
> +		pthr->status = perf_run_latency(pthr);
>   
>   err_clear_test:
>   	perf_clear_test(pthr);
>   }
>   
> +static int perf_init_pl(struct perf_ext_lat_data *pldata)
> +{
> +	struct perf_ctx *perf = pldata->perf;
> +	struct perf_peer *peer = perf->test_peer;
> +	u8 *bp;
> +
> +	pldata->src = kmalloc_node(peer->outbuf_size, GFP_KERNEL,
> +				dev_to_node(&perf->ntb->dev));
> +	if (!pldata->src)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Prepare random data to send, guaranteed exclusion of 0x00 (unreceived)
> +	 * and 0xFF (stop_word)
> +	 */
> +	get_random_bytes(pldata->src, peer->outbuf_size);
> +	for (bp = pldata->src; bp < (u8 *) pldata->src + peer->outbuf_size; bp++)
> +		while (*bp == 0 || *bp == stop_word)
> +			*bp = (u8)get_random_int();
> +
> +	memset(peer->inbuf, 0, peer->inbuf_size);
> +
> +	return 0;
> +}
> +
> +static int perf_poll_peer_reply(volatile u8 *cur)
> +{
> +	u64 wait_till = ktime_get_real_fast_ns() + lat_timeout_us * NSEC_PER_USEC;
> +
> +	while (ktime_get_real_fast_ns() < wait_till) {
> +		if (*cur == stop_word) {
> +			*cur = 0;
> +			return 1;
> +		}
> +		if (*cur != 0) {
> +			*cur = 0;
> +			return 0;
> +		}
> +	}
> +	return -EINTR;
> +}
> +
> +static int perf_run_pl_client(struct perf_ext_lat_data *pldata)
> +{
> +	struct perf_ctx *perf = pldata->perf;
> +	struct perf_peer *peer = perf->test_peer;
> +	struct ntb_dev *ntb = perf->ntb;
> +	void *src = pldata->src;
> +	int ret;
> +	u64 stop_at = ktime_get_real_fast_ns() + lat_time_ms * NSEC_PER_MSEC;
> +
> +	dev_dbg(&ntb->dev, "poll_lat: client started.\n");
> +
> +	pldata->tries = 0;
> +	pldata->latency = ktime_get();
> +
> +	while (ktime_get_real_fast_ns() < stop_at) {
> +		memcpy_toio(peer->outbuf, src, 1);
> +
> +		/* Avoid processor soft lock-ups */
> +		schedule();
> +
> +		ret = perf_poll_peer_reply(peer->inbuf);
> +		if (ret < 0) {
> +			dev_err(&ntb->dev, "Timeout waiting for peer reply on poll latency\n");
> +			pldata->latency = ktime_set(0, 0);
> +			return -EINTR;
> +		} else if (ret == 1) {
> +			dev_warn(&ntb->dev, "Server terminated on poll latency, stopping\n");
> +			break;
> +		} else if (!atomic_read(&perf->running)) {
> +			dev_err(&ntb->dev, "Poll latency client terminated\n");
> +			return -EINTR;
> +		}
> +
> +		pldata->tries++;
> +		src++;
> +
> +		if (src >= pldata->src + peer->outbuf_size)
> +			src = pldata->src;
> +	}
> +
> +	/* Stop timer */
> +	pldata->latency = ktime_sub(ktime_get(), pldata->latency);
> +	/* Send stop to peer */
> +	memcpy_toio(peer->outbuf, &stop_word, 1);
> +
> +	if (pldata->tries < LAT_MIN_TRIES) {
> +		dev_err(&ntb->dev, "Too few steps to measure poll Latency. "
> +				"Increase test time\n");
> +		pldata->latency = ktime_set(0, 0);
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(&ntb->dev, "poll_lat: made %llu tries, lasted %llu usecs\n",
> +		pldata->tries, ktime_to_us(pldata->latency));
> +
> +	pldata->latency = ns_to_ktime(ktime_divns(pldata->latency, pldata->tries));
> +
> +	dev_dbg(&ntb->dev, "poll_lat: latency %llu us (%llu ns)\n",
> +		ktime_to_us(pldata->latency), ktime_to_ns(pldata->latency));
> +
> +	return 0;
> +}
> +
> +static int perf_run_pl_server(struct perf_ext_lat_data *pldata)
> +{
> +	struct perf_ctx *perf = pldata->perf;
> +	struct perf_peer *peer = perf->test_peer;
> +	struct ntb_dev *ntb = perf->ntb;
> +	void *src = pldata->src;
> +	int ret = 0;
> +
> +	dev_dbg(&ntb->dev, "poll_lat: server started.\n");
> +
> +	pldata->tries = 0;
> +
> +	while (ret != 1 && atomic_read(&perf->running)) {
> +		ret = perf_poll_peer_reply(peer->inbuf);
> +		if (!ret) {
> +			/* Pong to client */
> +			memcpy_toio(peer->outbuf, src++, 1);
> +			if (src >= pldata->src + peer->outbuf_size)
> +				src = pldata->src;
> +
> +			pldata->tries++;
> +		}
> +
> +		/* Avoid processor soft lock-ups */
> +		schedule();
> +	}
> +
> +	if (pldata->tries < LAT_MIN_TRIES)
> +		dev_warn(&ntb->dev, "Poll latency test terminated too early. "
> +				"Increase client's test time\n");
> +
> +	dev_dbg(&ntb->dev, "poll_lat: server stopped, had responded %llu times\n",
> +		pldata->tries);
> +
> +	return atomic_read(&perf->running) ? -ENODATA : -EINTR;
> +}
> +
> +static void perf_clear_pl(struct perf_ext_lat_data *pldata)
> +{
> +	struct perf_ctx *perf = pldata->perf;
> +	struct perf_peer *peer = perf->test_peer;
> +
> +	memset(peer->inbuf, stop_word, 1);
> +	atomic_set(&perf->running, 0);
> +	wake_up(&perf->twait);
> +	kfree(pldata->src);
> +}
> +
> +static struct perf_ext_lat_ops perf_pl_client_ops = {
> +	.init = perf_init_pl,
> +	.run = perf_run_pl_client,
> +	.clear = perf_clear_pl
> +};
> +
> +static struct perf_ext_lat_ops perf_pl_server_ops = {
> +	.init = perf_init_pl,
> +	.run = perf_run_pl_server,
> +	.clear = perf_clear_pl
> +};
> +
> +static int perf_init_dbl(struct perf_ext_lat_data *data)
> +{
> +	struct perf_ctx *perf = data->perf;
> +
> +	data->db = get_bitmask_order(ntb_db_valid_mask(perf->ntb)) - 1;
> +	dev_dbg(&perf->ntb->dev, "DB bit for latency test: %d\n", data->db);
> +
> +	if (data->db <= perf->gidx) {
> +		dev_err(&perf->ntb->dev, "No spare DoorBell found\n");
> +		data->db = -1;
> +		return -ENOSPC;
> +	}
> +
> +	return ntb_db_clear_mask(perf->ntb, BIT_ULL(data->db));
> +}
> +
> +static int perf_run_dbl_client(struct perf_ext_lat_data *data)
> +{
> +	struct perf_ctx *perf = data->perf;
> +	struct ntb_dev *ntb = perf->ntb;
> +	u64 stop_at = ktime_get_real_fast_ns() + lat_time_ms * NSEC_PER_MSEC;
> +
> +	dev_dbg(&ntb->dev, "db_lat: client started.\n");
> +
> +	data->tries = 0;
> +	data->latency = ktime_get();
> +
> +	if (ntb_peer_db_set(perf->ntb, BIT_ULL(data->db)))
> +		return -EIO;
> +
> +	while (ktime_get_real_fast_ns() < stop_at) {
> +		/* Avoid processor soft lock-ups */
> +		schedule();
> +
> +		if (!atomic_read(&perf->running)) {
> +			dev_err(&ntb->dev, "DoorBell latency client terminated\n");
> +			return -EINTR;
> +		}
> +	}
> +
> +	/* Stop timer */
> +	data->latency = ktime_sub(ktime_get(), data->latency);
> +
> +	if (data->tries < LAT_MIN_TRIES) {
> +		dev_err(&ntb->dev, "Too few steps to measure poll Latency. "
> +				   "Increase test time\n");
> +		data->latency = ktime_set(0, 0);
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(&ntb->dev, "db_lat: made %llu tries, lasted %llu usecs\n",
> +		data->tries, ktime_to_us(data->latency));
> +
> +	data->latency = ns_to_ktime(ktime_divns(data->latency, data->tries));
> +
> +	dev_dbg(&ntb->dev, "db_lat: latency %llu us (%llu ns)\n",
> +		ktime_to_us(data->latency), ktime_to_ns(data->latency));
> +
> +	return 0;
> +}
> +
> +static void perf_clear_dbl(struct perf_ext_lat_data *data)
> +{
> +	struct perf_ctx *perf = data->perf;
> +
> +	data->db = -1;
> +	ntb_db_set_mask(perf->ntb, BIT_ULL(data->db));
> +	atomic_set(&perf->running, 0);
> +	wake_up(&perf->twait);
> +}
> +
> +static struct perf_ext_lat_ops perf_dbl_client_ops = {
> +	.init = perf_init_dbl,
> +	.run = perf_run_dbl_client,
> +	.clear = perf_clear_dbl
> +};
> +
> +static void perf_ext_lat_work(struct work_struct *work)
> +{
> +	struct perf_ext_lat_data *data = to_ext_lat_data(work);
> +
> +	if (!data->ops.init || !data->ops.init || !data->ops.init) {
> +		struct perf_ctx *perf = data->perf;
> +
> +		data->status = -EFAULT;
> +		atomic_set(&perf->running, 0);
> +		wake_up(&perf->twait);
> +		return;
> +	}
> +
> +	data->status = data->ops.init(data);
> +	if (data->status)
> +		return;
> +
> +	data->status = data->ops.run(data);
> +
> +	data->ops.clear(data);
> +}
> +
>   static int perf_set_tcnt(struct perf_ctx *perf, u8 tcnt)
>   {
>   	if (tcnt == 0 || tcnt > MAX_THREADS_CNT)
> @@ -1068,7 +1489,10 @@ static void perf_terminate_test(struct perf_ctx *perf)
>   	int tidx;
>   
>   	atomic_set(&perf->tsync, -1);
> +	atomic_set(&perf->running, 0);
>   	wake_up(&perf->twait);
> +	cancel_work_sync(&perf->pldata.work);
> +	cancel_work_sync(&perf->dbldata.work);
>   
>   	for (tidx = 0; tidx < MAX_THREADS_CNT; tidx++) {
>   		wake_up(&perf->threads[tidx].dma_wait);
> @@ -1082,9 +1506,10 @@ static int perf_submit_test(struct perf_peer *peer)
>   	struct perf_thread *pthr;
>   	int tidx, ret;
>   
> -	ret = wait_for_completion_interruptible(&peer->init_comp);
> -	if (ret < 0)
> -		return ret;
> +	ret = wait_for_completion_interruptible_timeout(&peer->init_comp,
> +			msecs_to_jiffies(peer_timeout_s * 1000));
> +	if (ret <= 0)
> +		return ret ? ret : -ETIMEDOUT;
>   
>   	if (test_and_set_bit_lock(0, &perf->busy_flag))
>   		return -EBUSY;
> @@ -1114,6 +1539,63 @@ static int perf_submit_test(struct perf_peer *peer)
>   	return ret;
>   }
>   
> +static int perf_submit_ext_lat(struct perf_peer *peer)
> +{
> +	struct perf_ctx *perf = peer->perf;
> +	int ret;
> +
> +	ret = wait_for_completion_interruptible_timeout(&peer->init_comp,
> +			msecs_to_jiffies(peer_timeout_s * 1000));
> +	if (ret <= 0)
> +		return ret ? ret : -ETIMEDOUT;
> +
> +	if (test_and_set_bit_lock(0, &perf->busy_flag))
> +		return -EBUSY;
> +
> +	perf->test_peer = peer;
> +	atomic_set(&perf->running, 1);
> +	perf->pldata.status = -ENODATA;
> +	perf->pldata.tries = 0;
> +	perf->pldata.latency = ktime_set(0, 0);
> +	perf->dbldata.status = -ENODATA;
> +	perf->dbldata.tries = 0;
> +	perf->dbldata.latency = ktime_set(0, 0);
> +
> +	switch (perf->mode) {
> +	case RUN_PL_SERVER:
> +		perf->pldata.ops = perf_pl_server_ops;
> +		(void)queue_work(perf_wq, &perf->pldata.work);
> +		break;
> +	case RUN_PL_CLIENT:
> +		perf->pldata.ops = perf_pl_client_ops;
> +		(void)queue_work(perf_wq, &perf->pldata.work);
> +		break;
> +	case RUN_DBL_SERVER:
> +		ret = perf_init_dbl(&perf->dbldata);
> +		dev_dbg(&perf->ntb->dev, "db_lat: server started.\n");
> +		goto submit_exit;
> +	case RUN_DBL_CLIENT:
> +		perf->dbldata.ops = perf_dbl_client_ops;
> +		(void)queue_work(perf_wq, &perf->dbldata.work);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		goto submit_exit;
> +	}
> +
> +	ret = wait_event_interruptible(perf->twait,
> +				       !atomic_read(&perf->running));
> +	if (ret == -ERESTARTSYS) {
> +		perf_terminate_test(perf);
> +		ret = -EINTR;
> +	}
> +
> +submit_exit:
> +	clear_bit_unlock(0, &perf->busy_flag);
> +
> +	return ret;
> +}
> +
>   static int perf_read_stats(struct perf_ctx *perf, char *buf,
>   			   size_t size, ssize_t *pos)
>   {
> @@ -1142,6 +1624,18 @@ static int perf_read_stats(struct perf_ctx *perf, char *buf,
>   			"%d: copied %llu bytes in %llu usecs, %llu MBytes/s\n",
>   			tidx, pthr->copied, ktime_to_us(pthr->duration),
>   			div64_u64(pthr->copied, ktime_to_us(pthr->duration)));
> +
> +		if (perf_latency && ktime_compare(pthr->latency, ktime_set(0, 0))) {
> +			if (ktime_to_us(pthr->latency) < 10) {
> +				(*pos) += scnprintf(buf + *pos, size - *pos,
> +						"%d: latency %llu ns\n",
> +						tidx, ktime_to_ns(pthr->latency));
> +			} else {
> +				(*pos) += scnprintf(buf + *pos, size - *pos,
> +						"%d: latency %llu us\n",
> +						tidx, ktime_to_us(pthr->latency));
> +			}
> +		}
>   	}
>   
>   	clear_bit_unlock(0, &perf->busy_flag);
> @@ -1149,7 +1643,7 @@ static int perf_read_stats(struct perf_ctx *perf, char *buf,
>   	return 0;
>   }
>   
> -static void perf_init_threads(struct perf_ctx *perf)
> +static void perf_init_workers(struct perf_ctx *perf)
>   {
>   	struct perf_thread *pthr;
>   	int tidx;
> @@ -1158,6 +1652,14 @@ static void perf_init_threads(struct perf_ctx *perf)
>   	perf->test_peer = &perf->peers[0];
>   	init_waitqueue_head(&perf->twait);
>   
> +	perf->pldata.perf = perf;
> +	INIT_WORK(&perf->pldata.work, perf_ext_lat_work);
> +	perf->pldata.status = -ENODATA;
> +
> +	perf->dbldata.perf = perf;
> +	INIT_WORK(&perf->dbldata.work, perf_ext_lat_work);
> +	perf->dbldata.status = -ENODATA;
> +
>   	for (tidx = 0; tidx < MAX_THREADS_CNT; tidx++) {
>   		pthr = &perf->threads[tidx];
>   
> @@ -1169,7 +1671,7 @@ static void perf_init_threads(struct perf_ctx *perf)
>   	}
>   }
>   
> -static void perf_clear_threads(struct perf_ctx *perf)
> +static void perf_clear_workers(struct perf_ctx *perf)
>   {
>   	perf_terminate_test(perf);
>   }
> @@ -1313,6 +1815,193 @@ static const struct file_operations perf_dbgfs_run = {
>   	.write = perf_dbgfs_write_run
>   };
>   
> +static ssize_t perf_dbgfs_read_run_pl(struct file *filep, char __user *ubuf,
> +				   size_t fsize, loff_t *offp)
> +{
> +	struct perf_ctx *perf = filep->private_data;
> +	ssize_t ret;
> +	ssize_t pos = 0;
> +	ssize_t size = PERF_BUF_LEN;
> +	char *buf;
> +
> +	if (test_and_set_bit_lock(0, &perf->busy_flag))
> +		return -EBUSY;
> +
> +	buf = kmalloc(size, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	pos += scnprintf(buf + pos, size - pos,
> +		"    Peer %d test statistics:\n", perf->test_peer->pidx);
> +
> +	if (perf->pldata.status != -ENODATA) {
> +		if (perf->pldata.status) {
> +			pos += scnprintf(buf + pos, size - pos,
> +				"poll latency: error status %d\n", perf->pldata.status);
> +		} else {
> +			if (ktime_to_us(perf->pldata.latency) < 10) {
> +				pos += scnprintf(buf + pos, size - pos,
> +						"poll latency %llu ns\n",
> +						ktime_to_ns(perf->pldata.latency));
> +			} else {
> +				pos += scnprintf(buf + pos, size - pos,
> +						"poll latency %llu us\n",
> +						ktime_to_us(perf->pldata.latency));
> +			}
> +		}
> +	} else {
> +		pos += scnprintf(buf + pos, size - pos, "Test did not run\n");
> +	}
> +
> +	ret = simple_read_from_buffer(ubuf, fsize, offp, buf, pos);
> +
> +	kfree(buf);
> +
> +	clear_bit_unlock(0, &perf->busy_flag);
> +
> +	return ret;
> +}
> +
> +static ssize_t perf_dbgfs_write_run_ext(struct file *filep, const char __user *ubuf,
> +					size_t size, loff_t *offp, enum run_mode mode)
> +{
> +	struct perf_ctx *perf = filep->private_data;
> +	struct ntb_dev *ntb = perf->ntb;
> +	struct perf_peer *peer;
> +	int pidx, ret;
> +
> +	ret = kstrtoint_from_user(ubuf, size, 0, &pidx);
> +	if (ret)
> +		return ret;
> +
> +	if (pidx < 0) {
> +		switch (mode) {
> +		case RUN_PL_SERVER:
> +			dev_dbg(&ntb->dev, "poll_lat: kill server\n");
> +			if (test_bit(0, &perf->busy_flag)) {
> +				peer = perf->test_peer;
> +				/* Send stop to client */
> +				memcpy_toio(peer->outbuf, &stop_word, 1);
> +			}
> +			perf_terminate_test(perf);
> +			clear_bit_unlock(0, &perf->busy_flag);
> +			return size;
> +		case RUN_DBL_SERVER:
> +			dev_dbg(&ntb->dev, "db_lat: kill server\n");
> +			perf_clear_dbl(&perf->dbldata);
> +			clear_bit_unlock(0, &perf->busy_flag);
> +			return size;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (pidx >= perf->pcnt)
> +		return -EINVAL;
> +
> +	peer = &perf->peers[pidx];
> +	perf->mode = mode;
> +
> +	ret = perf_submit_ext_lat(peer);
> +
> +	return ret ? ret : size;
> +}
> +
> +static ssize_t perf_dbgfs_write_run_pl_client(struct file *filep,
> +					const char __user *ubuf, size_t size, loff_t *offp)
> +{
> +	return perf_dbgfs_write_run_ext(filep, ubuf, size, offp, RUN_PL_CLIENT);
> +}
> +
> +static const struct file_operations perf_dbgfs_run_pl_client = {
> +	.open = simple_open,
> +	.read = perf_dbgfs_read_run_pl,
> +	.write = perf_dbgfs_write_run_pl_client
> +};
> +
> +static ssize_t perf_dbgfs_write_run_pl_server(struct file *filep,
> +					const char __user *ubuf, size_t size, loff_t *offp)
> +{
> +	return perf_dbgfs_write_run_ext(filep, ubuf, size, offp, RUN_PL_SERVER);
> +}
> +
> +static const struct file_operations perf_dbgfs_run_pl_server = {
> +	.open = simple_open,
> +	.read = perf_dbgfs_read_run_pl,
> +	.write = perf_dbgfs_write_run_pl_server
> +};
> +
> +static ssize_t perf_dbgfs_read_run_dbl(struct file *filep, char __user *ubuf,
> +				   size_t fsize, loff_t *offp)
> +{
> +	struct perf_ctx *perf = filep->private_data;
> +	ssize_t ret;
> +	ssize_t pos = 0;
> +	ssize_t size = PERF_BUF_LEN;
> +	char *buf;
> +
> +	if (test_and_set_bit_lock(0, &perf->busy_flag))
> +		return -EBUSY;
> +
> +	buf = kmalloc(size, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	pos += scnprintf(buf + pos, size - pos,
> +		"    Peer %d test statistics:\n", perf->test_peer->pidx);
> +
> +	if (perf->dbldata.status != -ENODATA) {
> +		if (perf->dbldata.status) {
> +			pos += scnprintf(buf + pos, size - pos,
> +				"doorbell latency: error status %d\n", perf->dbldata.status);
> +		} else {
> +			if (ktime_to_us(perf->dbldata.latency) < 10) {
> +				pos += scnprintf(buf + pos, size - pos,
> +						"doorbell latency %llu ns\n",
> +						ktime_to_ns(perf->dbldata.latency));
> +			} else {
> +				pos += scnprintf(buf + pos, size - pos,
> +						"doorbell latency %llu us\n",
> +						ktime_to_us(perf->dbldata.latency));
> +			}
> +		}
> +	} else {
> +		pos += scnprintf(buf + pos, size - pos, "Test did not run\n");
> +	}
> +
> +	ret = simple_read_from_buffer(ubuf, fsize, offp, buf, pos);
> +
> +	kfree(buf);
> +
> +	clear_bit_unlock(0, &perf->busy_flag);
> +
> +	return ret;
> +}
> +
> +static ssize_t perf_dbgfs_write_run_dbl_client(struct file *filep,
> +					const char __user *ubuf, size_t size, loff_t *offp)
> +{
> +	return perf_dbgfs_write_run_ext(filep, ubuf, size, offp, RUN_DBL_CLIENT);
> +}
> +
> +static const struct file_operations perf_dbgfs_run_dbl_client = {
> +	.open = simple_open,
> +	.read = perf_dbgfs_read_run_dbl,
> +	.write = perf_dbgfs_write_run_dbl_client
> +};
> +
> +static ssize_t perf_dbgfs_write_run_dbl_server(struct file *filep,
> +					const char __user *ubuf, size_t size, loff_t *offp)
> +{
> +	return perf_dbgfs_write_run_ext(filep, ubuf, size, offp, RUN_DBL_SERVER);
> +}
> +
> +static const struct file_operations perf_dbgfs_run_dbl_server = {
> +	.open = simple_open,
> +	.read = perf_dbgfs_read_run_dbl,
> +	.write = perf_dbgfs_write_run_dbl_server
> +};
> +
>   static ssize_t perf_dbgfs_read_tcnt(struct file *filep, char __user *ubuf,
>   				    size_t size, loff_t *offp)
>   {
> @@ -1344,15 +2033,76 @@ static ssize_t perf_dbgfs_write_tcnt(struct file *filep,
>   	return size;
>   }
>   
> +static ssize_t perf_dbgfs_read_lattrs(struct file *filep, char __user *ubuf,
> +				    size_t size, loff_t *offp)
> +{
> +	struct perf_ctx *perf = filep->private_data;
> +	char *buf;
> +	ssize_t pos, ret;
> +	size_t buf_size = min_t(size_t, size, PERF_BUF_LEN);
> +	int tidx;
> +
> +	buf = kmalloc(buf_size, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	pos = scnprintf(buf, buf_size, "    Peer %d latency try count:\n",
> +			perf->test_peer->pidx);
> +
> +	for (tidx = 0; tidx < perf->tcnt; tidx++) {
> +		struct perf_thread *pthr = &perf->threads[tidx];
> +
> +		pos += scnprintf(buf + pos, buf_size - pos,
> +				"%d: made %llu tries\n", tidx, pthr->tries);
> +	}
> +
> +	ret = simple_read_from_buffer(ubuf, size, offp, buf, pos);
> +
> +	kfree(buf);
> +
> +	return ret;
> +}
> +
> +static ssize_t perf_dbgfs_read_inbuf(struct file *filep, char __user *ubuf,
> +					size_t size, loff_t *offp)
> +{
> +	struct perf_ctx *perf = filep->private_data;
> +	char buf[32];
> +	ssize_t pos;
> +	u64 *value;
> +
> +	if (!perf->test_peer || !perf->test_peer->inbuf) {
> +		pos = scnprintf(buf, sizeof(buf), "NULL\n");
> +	} else {
> +		value = perf->test_peer->inbuf;
> +		pos = scnprintf(buf, sizeof(buf), "0x%llx\n", *value);
> +	}
> +
> +	return simple_read_from_buffer(ubuf, size, offp, buf, pos);
> +}
> +
>   static const struct file_operations perf_dbgfs_tcnt = {
>   	.open = simple_open,
>   	.read = perf_dbgfs_read_tcnt,
>   	.write = perf_dbgfs_write_tcnt
>   };
>   
> +static const struct file_operations perf_dbgfs_lattrs = {
> +	.open = simple_open,
> +	.read = perf_dbgfs_read_lattrs
> +};
> +
> +static const struct file_operations perf_dbgfs_inbuf = {
> +	.open = simple_open,
> +	.read = perf_dbgfs_read_inbuf,
> +};
> +
>   static void perf_setup_dbgfs(struct perf_ctx *perf)
>   {
>   	struct pci_dev *pdev = perf->ntb->pdev;
> +	struct dentry *burst_lat_dir;
> +	struct dentry *poll_lat_dir;
> +	struct dentry *db_lat_dir;
>   
>   	perf->dbgfs_dir = debugfs_create_dir(pci_name(pdev), perf_dbgfs_topdir);
>   	if (!perf->dbgfs_dir) {
> @@ -1363,11 +2113,10 @@ static void perf_setup_dbgfs(struct perf_ctx *perf)
>   	debugfs_create_file("info", 0600, perf->dbgfs_dir, perf,
>   			    &perf_dbgfs_info);
>   
> -	debugfs_create_file("run", 0600, perf->dbgfs_dir, perf,
> -			    &perf_dbgfs_run);
> +	debugfs_create_symlink("run", perf->dbgfs_dir, "burst_latency/run");
>   
> -	debugfs_create_file("threads_count", 0600, perf->dbgfs_dir, perf,
> -			    &perf_dbgfs_tcnt);
> +	debugfs_create_symlink("threads_count", perf->dbgfs_dir,
> +				"burst_latency/threads_count");
>   
>   	/* They are made read-only for test exec safety and integrity */
>   	debugfs_create_u8("chunk_order", 0500, perf->dbgfs_dir, &chunk_order);
> @@ -1375,6 +2124,45 @@ static void perf_setup_dbgfs(struct perf_ctx *perf)
>   	debugfs_create_u8("total_order", 0500, perf->dbgfs_dir, &total_order);
>   
>   	debugfs_create_bool("use_dma", 0500, perf->dbgfs_dir, &use_dma);
> +
> +	debugfs_create_file("inbuf", 0400, perf->dbgfs_dir, perf,
> +			    &perf_dbgfs_inbuf);
> +
> +	/* burst_latency subdir */
> +
> +	burst_lat_dir = debugfs_create_dir("burst_latency", perf->dbgfs_dir);
> +
> +	debugfs_create_file("run", 0600, burst_lat_dir, perf, &perf_dbgfs_run);
> +
> +	debugfs_create_file("threads_count", 0600, burst_lat_dir, perf,
> +			    &perf_dbgfs_tcnt);
> +
> +	debugfs_create_file("tries", 0400, burst_lat_dir, perf,
> +			    &perf_dbgfs_lattrs);
> +
> +	/* poll_latency subdir */
> +
> +	poll_lat_dir = debugfs_create_dir("poll_latency", perf->dbgfs_dir);
> +
> +	debugfs_create_file("run_client", 0600, poll_lat_dir, perf,
> +			    &perf_dbgfs_run_pl_client);
> +
> +	debugfs_create_file("run_server", 0600, poll_lat_dir, perf,
> +			    &perf_dbgfs_run_pl_server);
> +
> +	debugfs_create_u64("tries", 0400, poll_lat_dir, &perf->pldata.tries);
> +
> +	/* db_latency subdir */
> +
> +	db_lat_dir = debugfs_create_dir("db_latency", perf->dbgfs_dir);
> +
> +	debugfs_create_file("run_client", 0600, db_lat_dir, perf,
> +			    &perf_dbgfs_run_dbl_client);
> +
> +	debugfs_create_file("run_server", 0600, db_lat_dir, perf,
> +			    &perf_dbgfs_run_dbl_server);
> +
> +	debugfs_create_u64("tries", 0400, db_lat_dir, &perf->dbldata.tries);
>   }
>   
>   static void perf_clear_dbgfs(struct perf_ctx *perf)
> @@ -1494,7 +2282,7 @@ static int perf_probe(struct ntb_client *client, struct ntb_dev *ntb)
>   	if (ret)
>   		return ret;
>   
> -	perf_init_threads(perf);
> +	perf_init_workers(perf);
>   
>   	ret = perf_init_service(perf);
>   	if (ret)
> @@ -1517,7 +2305,7 @@ static void perf_remove(struct ntb_client *client, struct ntb_dev *ntb)
>   
>   	perf_disable_service(perf);
>   
> -	perf_clear_threads(perf);
> +	perf_clear_workers(perf);
>   }
>   
>   static struct ntb_client perf_client = {
