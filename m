Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7D750C343
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiDVWt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbiDVWs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:48:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A65239A073
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 15:08:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97F8D6209A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 22:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2E3C385AB;
        Fri, 22 Apr 2022 22:07:36 +0000 (UTC)
Date:   Fri, 22 Apr 2022 18:07:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     <mingo@redhat.com>, <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH v3 2/2] tracing: make tracer_init_tracefs initcall
 asynchronous
Message-ID: <20220422180734.225718b7@gandalf.local.home>
In-Reply-To: <20220323152257.7871-3-mark-pk.tsai@mediatek.com>
References: <20220323152257.7871-1-mark-pk.tsai@mediatek.com>
        <20220323152257.7871-3-mark-pk.tsai@mediatek.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2022 23:22:57 +0800
Mark-PK Tsai <mark-pk.tsai@mediatek.com> wrote:

> +static __init int tracer_init_tracefs(void)
> +{
> +	int ret;
> +
> +	trace_access_lock_init();
> +
> +	ret = tracing_init_dentry();
> +	if (ret)
> +		return 0;
> +
> +	INIT_WORK(&tracerfs_init_work, tracer_init_tracefs_work_func);
> +	if (!eval_map_wq)
> +		tracer_init_tracefs_work_func(&tracerfs_init_work);

Why go through the bother of doing the INIT_WORK if eval_map_wq is not
created? Just do:

	if (eval_map_wq) {
		INIT_WORK(&tracerfs_init_work, tracer_init_tracefs_work_func);
		queue_work(eval_map_wq, &tracerfs_init_work);
	} else {
		tracer_init_tracefs_work_func(NULL);
	}

But that's just a nit anyway.

-- Steve



> +	else
> +		queue_work(eval_map_wq, &tracerfs_init_work);
>  
>  	return 0;
>  }
