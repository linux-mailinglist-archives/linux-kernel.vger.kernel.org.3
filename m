Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33A1509FD3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 14:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382562AbiDUMnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 08:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiDUMnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 08:43:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964E72ED53
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:41:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53023B8245D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:41:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBAEDC385A5;
        Thu, 21 Apr 2022 12:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650544859;
        bh=xkTQja7+LerFcAfv+h4EcoXiBpBwuV21oqU53tUIV8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rD1FimIorOOdZCo7roNu4NSIBAY7tJROF6cmsXeuuo/xuSZjMgDzb3XEpYTZjVr+R
         WIP6eORivB4ZFMLtKTBQhU4evtpXpaxv9GGVEhE/aMH70fo5wszHcDyzaK5RfrZ+/a
         +S3MJASoo5gDa9Gx+i4AWRPWyzw54uUlzX1+YMB7TednGk2Tr13VwgvYm7PXYLHswI
         j2q2MhJYlctrmsZiZCsk+dTe1fJrivSYt75Izj7bPUBOJY/sgIey0y3smSzGdfCpNi
         QNCvkU9z8tl0GQOvi+PItuQ3pMSFaHxxbyb+W0xhw0XgKCcxhE4hEJFrA1lI+zm7yS
         Kt/K7Ku7lLp+Q==
From:   SeongJae Park <sj@kernel.org>
To:     Hailong Tu <tuhailong@gmail.com>
Cc:     akpm@linux-foundation.org, sj@kernel.org,
        torvalds@linux-foundation.org, gregkh@google.com,
        surenb@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, tuhailong@oppo.com,
        lichunpeng@oppo.com, aaron.qiu@oppo.com, fanguoze@oppo.com,
        wangdesuo@oppo.com, lizhihua@oppo.com
Subject: Re: [PATCH V4] mm/damon/reclaim: Fix the timer always stays active
Date:   Thu, 21 Apr 2022 12:40:55 +0000
Message-Id: <20220421124055.493710-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421100523.689294-1-tuhailong@gmail.com>
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


On Thu, 21 Apr 2022 18:05:24 +0800 Hailong Tu <tuhailong@gmail.com> wrote:

> The timer stays active even if the reclaim mechanism is never enabled.
> It is unnecessary overhead can be completely avoided by using module_param_cb() for enabled flag.

As commented to the previous version[1], let's wrap the line at 75 columns.
checkpatch.pl is also complaining.

[1] https://lore.kernel.org/linux-mm/20220421084806.72553-1-sj@kernel.org/

> 
> Signed-off-by: Hailong Tu <tuhailong@gmail.com>
> ---
>  mm/damon/reclaim.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index e34c4d0c4d93..e573e3f50064 100644
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
> @@ -358,11 +357,34 @@ static void damon_reclaim_timer_fn(struct work_struct *work)
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
> +
> +static const struct kernel_param_ops enabled_param_ops = {
> +	.set = enabled_store,
> +	.get = param_get_bool,
> +};
> +
> +module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
> +MODULE_PARM_DESC(enabled, "Enable or disable DAMON_RECLAIM (default: disabled)");

I'd prefer 80 columns limit.  Could you please put the string in the next line,
like below?

    MODULE_PARM_DESC(enabled,
    		 "Enable or disable DAMON_RECLAIM (default: disabled)");


Thanks,
SJ

> +
>  static int damon_reclaim_after_aggregation(struct damon_ctx *c)
>  {
>  	struct damos *s;
> -- 
> 2.25.1
> 
