Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422914BF529
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiBVJyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiBVJx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:53:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02FFD10B8;
        Tue, 22 Feb 2022 01:53:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A6F8B81977;
        Tue, 22 Feb 2022 09:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B258C340E8;
        Tue, 22 Feb 2022 09:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645523612;
        bh=T8Wutlu7mV5B3Pw57PVCDrO+l8i4LnewrOyADEDxSaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=mRv6omeV8naZHtnpCUkhTWsGNgpIqfA3TjW0E3YplZIVa0KAA6UGvNFFZrMPqj9Ap
         ARleDEaNRR0Bj6NGAMm8c8DnW0qjjp0MAU8hT7Bo5VDACT4TSQjY7yRRsDQDy4OW20
         WL1nnyH729xq+5feCqoMVcz3b8j363aoXNQtQt5Ph5iwlfUy7BciwqjQzRB6QkmoKk
         VZUgIu1Y86yc91OQI/+fkYs1bH8OdNbHHTSTIYzgj+QSNSUPBVX5SbDcBSfKNL0non
         rP3OJEx7pUP8auNEINUcOHGC4FDoY6wXF+FdnzkyhlKzI6zhd0RgIWg7qlenLaXiZq
         pmxGOrlW3WZ2Q==
From:   SeongJae Park <sj@kernel.org>
To:     Jonghyeon Kim <tome01@ajou.ac.kr>
Cc:     akpm@linux-foundation.org, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 2/3] mm/damon/core: Add damon_start_one()
Date:   Tue, 22 Feb 2022 09:53:28 +0000
Message-Id: <20220222095328.7962-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220218102611.31895-3-tome01@ajou.ac.kr>
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

On Fri, 18 Feb 2022 19:26:10 +0900 Jonghyeon Kim <tome01@ajou.ac.kr> wrote:

> damon_start() function is designed to start multiple damon monitoring
> contexts. But, sometimes we need to start monitoring one context.
> Although __damon_start() could be considered to start for one monitoring
> context, it seems reasonable to adopt a new function that does not need
> to handle 'damon_lock' from the caller.
> 
> Signed-off-by: Jonghyeon Kim <tome01@ajou.ac.kr>
> ---
>  include/linux/damon.h |  1 +
>  mm/damon/core.c       | 25 +++++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index c0adf1566603..069577477662 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -511,6 +511,7 @@ int damon_register_ops(struct damon_operations *ops);
>  int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id);
>  
>  int damon_start(struct damon_ctx **ctxs, int nr_ctxs);
> +int damon_start_one(struct damon_ctx *ctx);
>  int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
>  
>  #endif	/* CONFIG_DAMON */
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 290c9c0535ee..e43f138a3489 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -466,6 +466,31 @@ int damon_start(struct damon_ctx **ctxs, int nr_ctxs)
>  	return err;
>  }
>  
> +/**
> + * damon_start_one() - Starts the monitorings for one context.
> + * @ctx:	monitoring context
> + *
> + * This function starts one monitoring thread for only one monitoring context
> + * handling damon_lock.
> + *
> + * Return: 0 on success, negative error code otherwise.
> + */
> +int damon_start_one(struct damon_ctx *ctx)
> +{
> +	int err = 0;
> +
> +	mutex_lock(&damon_lock);
> +	err = __damon_start(ctx);
> +	if (err) {
> +		mutex_unlock(&damon_lock);
> +		return err;
> +	}
> +	nr_running_ctxs++;
> +	mutex_unlock(&damon_lock);
> +
> +	return err;
> +}
> +

IMHO, this looks like an unnecessary duplication of code.  Unless this is
needed for a real usecase, this change might unnecessarily make the code only a
little bit more complicated.  And to my understanding of the next patch, this
is not really needed for this patchset.  I will left comments on the patch.  If
I'm missing something, please clarify why this is really needed.

Furthermore, damon_start() starts a set of DAMON contexts in exclusive manner,
to ensure there will be no interference.  This patch breaks the assumption.
That is, contexts that started with damon_start() could be interfered by other
contexts that started with damon_start_one().  I have a plan to make
damon_start() also work for non-exclusive contexts group[1], though.

[1] https://lore.kernel.org/linux-mm/20220217161938.8874-3-sj@kernel.org/


Thanks,
SJ

>  /*
>   * __damon_stop() - Stops monitoring of given context.
>   * @ctx:	monitoring context
> -- 
> 2.17.1
> 
