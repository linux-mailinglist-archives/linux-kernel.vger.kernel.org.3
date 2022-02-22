Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167874BF526
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiBVJxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiBVJxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:53:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213D7D10BD;
        Tue, 22 Feb 2022 01:53:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E262B8196F;
        Tue, 22 Feb 2022 09:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA03CC340E8;
        Tue, 22 Feb 2022 09:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645523602;
        bh=OnZcoGRyx5ne7WbzoVcMoT8X+32SVf+MsXCe4fPWrwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=pYMdQVZ9bNBt2ie3VUyBv7oBFvHnVklEhjKZXF4Jx07Bx/qPsv7YnMYcenlzPNgKc
         ZQcKFWUgx4UuXsk06/ziK6VJaAhxWMKIMjiVyUBsDyFMcqRVnCeOudlvcMI74onZ3G
         TPF2RxqCbEwMxpm2u+T0qwKHqfmLAGMbrRsf5HYm/m2la12+7B8gt93wnDi9khYr7y
         lFoD6q0lWt2iNzzbtQc/nIGESuGEZd71nn954NREz7Rn7Qvrmt7/j3qqYqMSEx601w
         MGKKsrJD3YqacsqlaldYJObBGpQyPndMR8B5/g8wXzIAqWgXfENfurX+5m5h7NUmyL
         sqT/Myl/gtkZg==
From:   SeongJae Park <sj@kernel.org>
To:     Jonghyeon Kim <tome01@ajou.ac.kr>
Cc:     akpm@linux-foundation.org, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/3] mm/damon: Rebase damos watermarks for NUMA systems
Date:   Tue, 22 Feb 2022 09:53:17 +0000
Message-Id: <20220222095317.7911-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220218102611.31895-2-tome01@ajou.ac.kr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jonghyeon,

On Fri, 18 Feb 2022 19:26:09 +0900 Jonghyeon Kim <tome01@ajou.ac.kr> wrote:

> For NUMA systems, there is a need to allow damos to select watermark
> options for monitoring each NUMA node or whole system free memory. Even
> if we do not use NUMA, since the default NUMA node number is 0, we can
> monitor the whole system memory without any configuration.

Some users using NUMA machines but don't do NUMA-specific memory allocations
and therefore assume memory free rate in each NUMA node will be similar might
want to monitor only global free memory ratio, to limit number of kdamonds for
reducing CPU overhead.  In the case, this patch would make them monitor only
the first node.

How about leaving DAMOS_WMARK_FREE_MEM_RATE to work as is, and adding a new
metric type, say, DAMOS_WMARK_NODE_FREE_MEM_RATE?


Thanks,
SJ

> 
> Signed-off-by: Jonghyeon Kim <tome01@ajou.ac.kr>
> ---
>  include/linux/damon.h |  2 ++
>  mm/damon/core.c       | 14 ++++++++------
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 49c4a11ecf20..c0adf1566603 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -170,6 +170,7 @@ enum damos_wmark_metric {
>   * @high:	High watermark.
>   * @mid:	Middle watermark.
>   * @low:	Low watermark.
> + * @node:	NUMA node for the watermarks.
>   *
>   * If &metric is &DAMOS_WMARK_NONE, the scheme is always active.  Being active
>   * means DAMON does monitoring and applying the action of the scheme to
> @@ -186,6 +187,7 @@ struct damos_watermarks {
>  	unsigned long high;
>  	unsigned long mid;
>  	unsigned long low;
> +	int node;
>  
>  /* private: */
>  	bool activated;
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 82e0a4620c4f..290c9c0535ee 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -179,6 +179,7 @@ struct damos *damon_new_scheme(
>  	scheme->wmarks.high = wmarks->high;
>  	scheme->wmarks.mid = wmarks->mid;
>  	scheme->wmarks.low = wmarks->low;
> +	scheme->wmarks.node = wmarks->node;
>  	scheme->wmarks.activated = true;
>  
>  	return scheme;
> @@ -951,14 +952,15 @@ static bool kdamond_need_stop(struct damon_ctx *ctx)
>  	return true;
>  }
>  
> -static unsigned long damos_wmark_metric_value(enum damos_wmark_metric metric)
> +static unsigned long damos_wmark_metric_value(struct damos_watermarks wmarks)
>  {
> -	struct sysinfo i;
> +	unsigned long nr_total, nr_free;
>  
> -	switch (metric) {
> +	switch (wmarks.metric) {
>  	case DAMOS_WMARK_FREE_MEM_RATE:
> -		si_meminfo(&i);
> -		return i.freeram * 1000 / i.totalram;
> +		nr_total = node_present_pages(wmarks.node);
> +		nr_free = sum_zone_node_page_state(wmarks.node, NR_FREE_PAGES);
> +		return nr_free * 1000 / nr_total;
>  	default:
>  		break;
>  	}
> @@ -976,7 +978,7 @@ static unsigned long damos_wmark_wait_us(struct damos *scheme)
>  	if (scheme->wmarks.metric == DAMOS_WMARK_NONE)
>  		return 0;
>  
> -	metric = damos_wmark_metric_value(scheme->wmarks.metric);
> +	metric = damos_wmark_metric_value(scheme->wmarks);
>  	/* higher than high watermark or lower than low watermark */
>  	if (metric > scheme->wmarks.high || scheme->wmarks.low > metric) {
>  		if (scheme->wmarks.activated)
> -- 
> 2.17.1
> 
> 
