Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CDD588E0B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 15:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238173AbiHCN45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 09:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238764AbiHCNzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 09:55:52 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446002F4
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 06:55:41 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id l14so12618382qtv.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 06:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=lQmTwuH19noXU8KpeeAnN5wF6xxdpiMxXJOzXODGwqU=;
        b=0k7nUrbpXLcaPeWPf60nz1yNFjZ/YkPDFzWTlv1KmmrFzIm2f1cMvivgKSu1u7TEZj
         2/sbX9+byvfdjE8wK0tdzxTYiK9YqK0GqsDv3ZaJyUgmRpW/TDs25YzEqrKcMRorAeg5
         LiokXNEF0dr/rKiTJ4Zfg6MK37m6TDHh54mrkeWee6VD1B+Rqi11t/5jN7REjUJ7xY4s
         qk5npgwTzDiP0tc6ngdQKBYVXNW4nTWseViEXG/GTiHT2/jR9tEz9XjLjRoAFqIEZBi+
         w6PIhKBI8RBsl0tVVG8jKY6bRweyNTxw+0N3M/4feZe2Bg8zPMnKsg+6n3cJTZtAJS2d
         zAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=lQmTwuH19noXU8KpeeAnN5wF6xxdpiMxXJOzXODGwqU=;
        b=q47UoaJkqdxE8lp1u9Qr5p2qjMwsYv08Cy6Ij24aXpNZ1I9oVfIn4jJniowGNIHoXM
         65B0bI94CuSOz+wgYXINttxDcn3XqZFuhEQt4pcj3yMk6pyakYHYHs1xgajaNcv8oMo1
         3cik2afZKWtkEAQHPBj12IftXUG3nHBY33pNY7mj19CytSMhRNlWwzrhjgiSgsydbKZq
         GigBI8GZ8GlR+o1jPYn8iC/avUng9bF0Ugxo78miZZYbwU1lBRDwahsdVgHPhBL85w7Z
         cCisb9bXac7GW8hw/R9OfW8s5ScMvcD/UbRxg94mPbQTEdZJwh6tLZipUgYmJJ+voXTc
         7/XQ==
X-Gm-Message-State: ACgBeo2++op3Tzb5imAX+X4Dg56qdzb+YHtc55ZQYbVXBKP6NYnZc7Al
        S1Fmif7SAPDY/z5cuuwVtloNhA==
X-Google-Smtp-Source: AA6agR55ZUMakwR8gOPEEriFgNS65we8TZqR5lyXHTta3pfmlHq7HU0LVG3E/Eq2e/cr6AkfR2Y4IQ==
X-Received: by 2002:ac8:7396:0:b0:33f:4f21:59d6 with SMTP id t22-20020ac87396000000b0033f4f2159d6mr1194652qtp.453.1659534940438;
        Wed, 03 Aug 2022 06:55:40 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-00ea-7f88-5fd9-01cd.res6.spectrum.com. [2603:7000:c01:2716:ea:7f88:5fd9:1cd])
        by smtp.gmail.com with ESMTPSA id do54-20020a05620a2b3600b006b5e1aeb777sm3106801qkb.43.2022.08.03.06.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 06:55:40 -0700 (PDT)
Date:   Wed, 3 Aug 2022 09:55:39 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     cgel.zte@gmail.com
Cc:     akpm@linux-foundation.org, tj@kernel.org, axboe@kernel.dk,
        vdavydov.dev@gmail.com, ran.xiaokai@zte.com.cn, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgel <cgel@zte.com.cn>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 1/2] psi: introduce memory.pressure.stat
Message-ID: <Yup+W/EFzkfSqRnW@cmpxchg.org>
References: <20220801004205.1593100-1-ran.xiaokai@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801004205.1593100-1-ran.xiaokai@zte.com.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 12:42:04AM +0000, cgel.zte@gmail.com wrote:
> From: cgel <cgel@zte.com.cn>
> 
> For now psi memory pressure account for all the mem stall in the
> system, And didnot provide a detailed information why the stall
> happens. This patch introduce a cgroupu knob memory.pressure.stat,
> it tells the detailed stall information of all memory events and it
> format and the corresponding proc interface.
> 
> for the cgroup, add memory.pressure.stat and it shows:
> kswapd: avg10=0.00 avg60=0.00 avg300=0.00 total=0
> direct reclaim: avg10=0.00 avg60=0.00 avg300=0.12 total=42356
> kcompacted: avg10=0.00 avg60=0.00 avg300=0.00 total=0
> direct compact: avg10=0.00 avg60=0.00 avg300=0.00 total=0
> cgroup reclaim: avg10=0.00 avg60=0.00 avg300=0.00 total=0
> workingset thrashing:   avg10=0.00 avg60=0.00 avg300=0.00 total=0
> 
> for the system wide, a proc file introduced as pressure/memory_stat
> and the format is the same as the cgroup interface.
> 
> With this detaled information, for example, if the system is stalled
> because of kcompacted, compaction_proactiveness can be promoted so
> pro-compaction can be involved earlier.
> 
> Signed-off-by: cgel <cgel@zte.com.cn>

> @@ -64,9 +91,11 @@ struct psi_group_cpu {
>  
>  	/* Aggregate pressure state derived from the tasks */
>  	u32 state_mask;
> +	u32 state_memstall;
>  
>  	/* Period time sampling buckets for each state of interest (ns) */
>  	u32 times[NR_PSI_STATES];
> +	u32 times_mem[PSI_MEM_STATES];

This doubles the psi cache footprint on every context switch, wakeup,
sleep, etc. in the scheduler. You're also adding more branches to
those same paths. It'll measurably affect everybody who is using psi.

Yet, in the years of using psi in production myself, I've never felt
the need for what this patch provides. There are event counters for
everything that contributes to pressure, and it's never been hard to
rootcause spikes. There are also things like bpftrace that let you
identify who is stalling for how long in order to do one-off tuning
and systems introspection.

For this to get merged, it needs a better explanation of the usecase
that requires this information to be broadly available all the time.
And it needs to bring down the impact on everybody else who doesn't
want this - either by reducing the footprint or by making the feature
optional.
