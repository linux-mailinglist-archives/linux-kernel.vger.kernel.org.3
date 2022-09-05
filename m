Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BB35AD8F6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 20:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbiIESU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 14:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiIESUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 14:20:25 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE10421E01
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 11:20:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 49C25CE137E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 18:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A42C433D7;
        Mon,  5 Sep 2022 18:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662402020;
        bh=v7P6Uw4HRJRP4lWIfQcjoKQy75gM4zEUpDlPO/DPqz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CHC0kzZF/ex5uMQxHHasuue1Hxlvx0zNLHDfvhPxdjZEtkmrsZ9BTrGMP6qC9yK2+
         a9r0j8RRkVKNMSTOfc+15y1xhFDC2Y913HuDJhCnihSiLU/Bk/ahw1b0YceOSmTjYX
         KmEDIQCPKk9heFzQSjJRG1EcXR+1KPZEuaHfA+HonRemofBwJoVYlhTH9TDYwAC6dk
         jZUYY7cI2WRsehHRV45ROVUSjlfV42c+6lTdg3WgwrCQH7aj5LgYxBLnfYAtn5IUCn
         tfwaJt8xSTkLiyjCCFjOmffjKxAIgbnBSs9rwhiHcYUvVlAo7L5/eSU6ZIISNPWmNW
         yqxvy/mQWEHJg==
From:   SeongJae Park <sj@kernel.org>
To:     xiakaixu1987@gmail.com
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH] mm/damon/sysfs: simplify the judgement whether kdamonds are busy
Date:   Mon,  5 Sep 2022 18:20:17 +0000
Message-Id: <20220905182017.50625-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1662302166-13216-1-git-send-email-kaixuxia@tencent.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kaixu,

On Sun, 4 Sep 2022 22:36:06 +0800 xiakaixu1987@gmail.com wrote:

> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> It is unnecessary to get the number of the running kdamond to judge
> whether kdamonds are busy. Here we can use the
> damon_sysfs_kdamond_running() helper and return -EBUSY directly
> when finding a running kdamond. Meanwhile, merging with the judgement
> that a kdamond has current sysfs command callback request to make
> the code more clear.
> 
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  mm/damon/sysfs.c | 25 +++++++------------------
>  1 file changed, 7 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 7488e27c87c3..fe6c6870cf86 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -2657,23 +2657,18 @@ static void damon_sysfs_kdamonds_rm_dirs(struct damon_sysfs_kdamonds *kdamonds)
>  	kdamonds->kdamonds_arr = NULL;
>  }
>  
> -static int damon_sysfs_nr_running_ctxs(struct damon_sysfs_kdamond **kdamonds,
> +static bool damon_sysfs_kdamonds_busy(struct damon_sysfs_kdamond **kdamonds,
>  		int nr_kdamonds)
>  {
> -	int nr_running_ctxs = 0;
>  	int i;
>  
>  	for (i = 0; i < nr_kdamonds; i++) {
> -		struct damon_ctx *ctx = kdamonds[i]->damon_ctx;
> -
> -		if (!ctx)
> -			continue;
> -		mutex_lock(&ctx->kdamond_lock);
> -		if (ctx->kdamond)
> -			nr_running_ctxs++;
> -		mutex_unlock(&ctx->kdamond_lock);
> +		if (damon_sysfs_kdamond_running(kdamonds[i]) ||
> +		    damon_sysfs_cmd_request.kdamond == kdamonds[i])
> +			return true;
>  	}
> -	return nr_running_ctxs;
> +
> +	return false;
>  }
>  
>  static int damon_sysfs_kdamonds_add_dirs(struct damon_sysfs_kdamonds *kdamonds,
> @@ -2682,15 +2677,9 @@ static int damon_sysfs_kdamonds_add_dirs(struct damon_sysfs_kdamonds *kdamonds,
>  	struct damon_sysfs_kdamond **kdamonds_arr, *kdamond;
>  	int err, i;
>  
> -	if (damon_sysfs_nr_running_ctxs(kdamonds->kdamonds_arr, kdamonds->nr))
> +	if (damon_sysfs_kdamonds_busy(kdamonds->kdamonds_arr, kdamonds->nr))
>  		return -EBUSY;
>  
> -	for (i = 0; i < kdamonds->nr; i++) {
> -		if (damon_sysfs_cmd_request.kdamond ==
> -				kdamonds->kdamonds_arr[i])
> -			return -EBUSY;
> -	}
> -
>  	damon_sysfs_kdamonds_rm_dirs(kdamonds);
>  	if (!nr_kdamonds)
>  		return 0;
> -- 
> 2.27.0
> 
> 
