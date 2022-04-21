Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617E8509AFB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386872AbiDUIvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235734AbiDUIvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:51:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA50013E86
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:48:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7BA83B82241
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D1FC385A5;
        Thu, 21 Apr 2022 08:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650530901;
        bh=hf+uN+DOEUfJ4SXFL2ay+Ktv9zuCbZ7eg0Jv5GbHOLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AaDok+boFNahUH9LjNJUsGOxDTEOnAcirJWjZj52vBXTVijgQh6lN2oM5pokq++1Q
         f8JDpDK3MvO/5DLhMqsGkeeSF6JF1nILpbCfHUwkrZMtgrH1RWaH/2aevX+XKet5ZX
         8jyWHJCc0juJwKDwgXDVdKBK/9pyvj9j+PFhhENMsv/tiqOJ/SVQzafUljE70Y3aeV
         0vbQAhciAEqfBkcD2sR6GxCIINreBxL9N1ty9JRFfhi8kZUH2Fno9zHj0+Ej7+r1s7
         Qn5dSwpapw+cOw8z+2uuSZIEIIxgrqciCf+SIe/nCQWLk3BohKKV9aGkxZcdcgGJFa
         Rkq+tiW25g+0A==
From:   SeongJae Park <sj@kernel.org>
To:     Hailong Tu <tuhailong@gmail.com>
Cc:     akpm@linux-foundation.org, sj@kernel.org,
        torvalds@linux-foundation.org, gregkh@google.com,
        surenb@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        tuhailong@oppo.com, lichunpeng@oppo.com, aaron.qiu@oppo.com,
        fanguoze@oppo.com
Subject: Re: [PATCH v3] mm/damon: Fix the timer always stays active
Date:   Thu, 21 Apr 2022 08:48:06 +0000
Message-Id: <20220421084806.72553-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421010640.383365-1-tuhailong@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hailong,


On Thu, 21 Apr 2022 09:06:41 +0800 Hailong Tu <tuhailong@gmail.com> wrote:

> The timer stays active even if the reclaim mechanism is never enabled.

I'd like to make it clear that this change is for DAMON_RECLAIM by making the
first part of the subject 'mm/damon/reclaim:', and adjusting above sentence.

> It is unnecessary overhead can be completely avoided by using module_param_call() for enabled flag.

Let's wrap the line at 75 columns
(https://docs.kernel.org/process/submitting-patches.html#the-canonical-patch-format).

> 
> Signed-off-by: Hailong Tu <tuhailong@gmail.com>
> ---
>  mm/damon/reclaim.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index e34c4d0c4d93..46505c501cd6 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
> @@ -28,7 +28,6 @@
>   * this.
>   */
>  static bool enabled __read_mostly;
> -module_param(enabled, bool, 0600);
>  
>  /*
>   * Time threshold for cold memory regions identification in microseconds.
> @@ -358,11 +357,27 @@ static void damon_reclaim_timer_fn(struct work_struct *work)
>  			enabled = last_enabled;
>  	}
>  
> -	schedule_delayed_work(&damon_reclaim_timer,
> +	if (enabled)
> +		schedule_delayed_work(&damon_reclaim_timer,
>  			msecs_to_jiffies(ENABLE_CHECK_INTERVAL_MS));
>  }
>  static DECLARE_DELAYED_WORK(damon_reclaim_timer, damon_reclaim_timer_fn);
>  
> +static int enabled_store(const char *val,
> +		const struct kernel_param *kp)
> +{
> +	int rc = param_set_bool(val, kp);
> +
> +	if (rc < 0)
> +		return rc;
> +
> +	if (enabled)
> +		schedule_delayed_work(&damon_reclaim_timer, 0);
> +
> +	return 0;
> +}
> +module_param_call(enabled, enabled_store, param_get_bool, &enabled, 0600);

module_param_call() is commented as obsolete.  Could we use module_param_cb()
instead as suggested by the comment?

> +
>  static int damon_reclaim_after_aggregation(struct damon_ctx *c)
>  {
>  	struct damos *s;
> -- 
> 2.25.1
> 


Thanks,
SJ
