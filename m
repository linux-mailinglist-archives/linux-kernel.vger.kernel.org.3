Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640AE53B8F7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 14:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbiFBM0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 08:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbiFBM0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 08:26:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F72F298585
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 05:26:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1ED4561751
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 12:26:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E44DC34119;
        Thu,  2 Jun 2022 12:26:03 +0000 (UTC)
Date:   Thu, 2 Jun 2022 08:25:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     sunliming <sunliming@kylinos.cn>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        kelulanainsley@gmail.com
Subject: Re: [PATCH] tracing: Simplify conditional compilation code in
 tracing_set_tracer()
Message-ID: <20220602082559.795189e1@rorschach.local.home>
In-Reply-To: <20220602022404.508144-1-sunliming@kylinos.cn>
References: <20220602022404.508144-1-sunliming@kylinos.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 Jun 2022 10:24:04 +0800
sunliming <sunliming@kylinos.cn> wrote:

> Two conditional compilation directives "#ifdef CONFIG_TRACER_SNAPSHOT"
> are used consecutively, and no other code in between. Simplify conditional
> the compilation code and only use one "#ifdef CONFIG_TRACER_SNAPSHOT".

I think you mean CONFIG_TRACER_MAX_TRACE here.

-- Steve

> 
> Signed-off-by: sunliming <sunliming@kylinos.cn>
> ---
>  kernel/trace/trace.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index f400800bc910..dc959e339512 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6430,9 +6430,7 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
>  		synchronize_rcu();
>  		free_snapshot(tr);
>  	}
> -#endif
>  
> -#ifdef CONFIG_TRACER_MAX_TRACE
>  	if (t->use_max_tr && !had_max_tr) {
>  		ret = tracing_alloc_snapshot_instance(tr);
>  		if (ret < 0)

