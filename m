Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C4D5B0AD1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiIGQ5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiIGQ5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:57:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6242CBD1DF
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 09:57:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 932CCB81CAE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 16:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A21C433D7;
        Wed,  7 Sep 2022 16:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662569849;
        bh=zTO/JfNwKwxbPNU1PGY3F5bXy5SfDDKgvFHJFPd1TEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ILOjycA43nB7oJr1Us0s8EOOx5f9vtBZsyQt/FuiKrWGfVI2LQnI2si7Nf/7PG7Vf
         opEOd+hUtUzDwlw4npYwrkyFd3MJ3rYcSbyT70zifnLIghl849odWL/53zZwZOufw0
         3wrNYRdoDqbndbYwc8OYZxFekoIqxaWpjgi+IA04ZB8wKVQBeQfkVlleEMKGJ91yrl
         kj43j2v9rdVG/C0I0P8Fw2V3WBAyUqRBYptEwerMnTP0rG+oUB/LQ3Ta4h6dkAFscV
         qCkrnYjq67WvBUdtL0s9bG+q2g7NgvVXcT2Ev9Pwcxo+Nro+T62xnaXi2JkM1v7V5i
         Huxf4iafbOX+g==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: Simply damon_ctx check in damon_sysfs_before_terminate
Date:   Wed,  7 Sep 2022 16:57:26 +0000
Message-Id: <20220907165726.52151-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220907084116.62053-1-xhao@linux.alibaba.com>
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

Hi Xin,

Nit: I'd suggest to 's/Simply/simplify/' in the subject.

On Wed, 7 Sep 2022 16:41:16 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> In damon_sysfs_before_terminate() func, it need to check whether
> ctx->ops.id supports 'DAMON_OPS_VADDR' or 'DAMON_OPS_FVADDR', there we
> can use damon_target_has_pid() instead.
> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>

Other than the above trivial nit,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

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
