Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495D45765EE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbiGORHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 13:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbiGORHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:07:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A209A13E0D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:07:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D1276226D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 17:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1AEC34115;
        Fri, 15 Jul 2022 17:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657904860;
        bh=aggAZRjimU1oJPtRHtLMPAK6iTKXIlW41DBUfmAz8qI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U19kf46l/YYlZcR9ZNwU59Pd+entD/+0E42IdwLJFyTvElEzF8tmSew0f/9PSprgT
         WeFOpO4fsrwt20+WWwEtNDGz9yLdg28CBv1BTPKrPhw9RJJn1MAdYd4quRbCadhuhJ
         qnrNzyp2dJbYeSX24E/VaPy+MIjINjRjWHqa6X3fCh3Hm/inmQueUiF4375kuWbPNF
         86Orwu7OjmZILw3eS+JHKH9Mi9io5viMs3LIOfIzM8RHMQrFwqcT1PE5+D9jFmgann
         5hpz3JW6h30aP5xnm4d0OE4P7qfm2uOXci+V9gF2nxi11cp5+xUpAfSrutjX4g1x0Y
         q961dkZXCvNJA==
From:   SeongJae Park <sj@kernel.org>
To:     Yuanzheng Song <songyuanzheng@huawei.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/reclaim: fix 'enabled' is incorrectly set because 'system_wq' is not initialized
Date:   Fri, 15 Jul 2022 17:07:36 +0000
Message-Id: <20220715170736.126498-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715061609.48463-1-songyuanzheng@huawei.com>
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

Hello Yuanzheng,


On Fri, 15 Jul 2022 06:16:09 +0000 Yuanzheng Song <songyuanzheng@huawei.com> wrote:

> The 'enabled' will be incorrectly set because the 'system_wq'
> might not initialized yet. This results in 'enabled=true',
> but the 'damon_reclaim_timer' is inactive. So fix it by moving
> the judgment logic of the 'damon_reclaim_initialized' to the
> start position of the enable_store().

Thank you for this patch!

In the case, however, 'damon_reclaim_init()' will activate
'damon_reclaim_timer', which will check the 'enabled' and start DAMON later.
So 'enabled' will inconsistently set while DAMON_RECLAIM is not really enabled
for a moment, but those will eventually be consistent.  This patch could reduce
the duration of the inconsistent state.

However, this would break boot-time DAMON_RECLAIM enabling, which adds
'damon_reclaim.enabled=true' to the kernel parameter, as this change will set
'enabled' as 'false' in the early 'damon_reclaim_enabled_store()', so that the
later 'damon_reclaim_initialized()' activated 'damon_reclaim_timer' shows
'enabled' as 'false' and therefore doesn't start DAMON.

If there is anything I'm missing, please let me know.


Thanks,
SJ

> 
> Fixes: 294928293813 ("mm/damon/reclaim: schedule 'damon_reclaim_timer' only after 'system_wq' is initialized")
> Signed-off-by: Yuanzheng Song <songyuanzheng@huawei.com>
> ---
>  mm/damon/reclaim.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> index e69b807fefe4..b13d5a02bf2e 100644
> --- a/mm/damon/reclaim.c
> +++ b/mm/damon/reclaim.c
> @@ -374,13 +374,14 @@ static bool damon_reclaim_initialized;
>  static int damon_reclaim_enabled_store(const char *val,
>  		const struct kernel_param *kp)
>  {
> -	int rc = param_set_bool(val, kp);
> -
> -	if (rc < 0)
> -		return rc;
> +	int rc;
>  
>  	/* system_wq might not initialized yet */
>  	if (!damon_reclaim_initialized)
> +		return -EINVAL;
> +
> +	rc = param_set_bool(val, kp);
> +	if (rc < 0)
>  		return rc;
>  
>  	schedule_delayed_work(&damon_reclaim_timer, 0);
> -- 
> 2.25.1
