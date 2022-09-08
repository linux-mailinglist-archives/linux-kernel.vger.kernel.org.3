Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098AF5B2544
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbiIHSBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiIHSBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:01:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E15F10C8
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 11:01:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90884B821DC
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 18:01:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9ED4C433D6;
        Thu,  8 Sep 2022 18:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662660078;
        bh=Eyd2f05euQSrEzSKY+ufNZEqbz628QYuj+cOfZCVgsI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N3ufNtX2TZLK5JUIePjDK/1DoHi233A3+qec1xZgYh2N7ixgnrTO4VcB4hnjvfFwj
         XV8+G/lxu0GdoLUSgUorkwnCUgQqdLOiJxRJz/NGKhA7td8zTjQOC7jgWTlHj+pJIw
         gyU/iwWIKsVY/uYiPEZSQ/JyJpu/YxNeS8m6RyOgRvj/u0sWBXdm9I4CeFg3aUJ+iO
         +V/nPDixo8kMEWsf6mEy2ag7d6SJKQxdVN9PpN29oOE5VHk1LCMtwa3Tu/Ypba4kZ6
         BU7pOZe4oe1u9Rnn/ZlAFEs4FrpBKRk4aM3y4b7ixvteaIiKG3qhyyYYC1aU4ioySJ
         m1eYt6wAH+12Q==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm/damon: simplify damon_ctx check in damon_sysfs_before_terminate
Date:   Thu,  8 Sep 2022 18:01:15 +0000
Message-Id: <20220908180116.33879-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220908021912.70481-1-xhao@linux.alibaba.com>
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

Just for a record.  Apparently Andrew has already added this in mm:
https://lore.kernel.org/mm-commits/20220907223146.C7CF4C433D6@smtp.kernel.org/


Thanks,
SJ

On Thu, 8 Sep 2022 10:19:12 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> In damon_sysfs_before_terminate() func, it need to check whether
> ctx->ops.id supports 'DAMON_OPS_VADDR' or 'DAMON_OPS_FVADDR', there we
> can use damon_target_has_pid() instead.
> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> Reviewed-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 7488e27c87c3..88f208ff235d 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -2309,7 +2309,7 @@ static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
>  {
>  	struct damon_target *t, *next;
> 
> -	if (ctx->ops.id != DAMON_OPS_VADDR && ctx->ops.id != DAMON_OPS_FVADDR)
> +	if (!damon_target_has_pid(ctx))
>  		return;
> 
>  	mutex_lock(&ctx->kdamond_lock);
> --
> 2.31.0
