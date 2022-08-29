Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABE85A449D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiH2IJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiH2IIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:08:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A875D52E53
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=whIFzUNn2x7iARS4Q2Ru0lB06BgW8fnFGxV1bucuo5g=; b=TNp53cZumHIZt7P1mtvKkMpfZP
        SDra78XTm+4oPzPywZBCkcfr/mM6m4OoCIlsf+DtjV9Hhq3dyUhV4mm/xPhAfot1oMowQohvUr6UJ
        mrfXQgTnsG1Dx9okgUm/tAvIz9iEtvnwn4zy78F4PZghA5TdQPX83N/URrK6aocuZ7GRtV3Xbcjco
        34X6+lOkEL9nS4PVGL6FUpXFMmpMsJnFTJVhen2lbRjEyf8jNDpYkuY2ALOD+7X8njsWEd00UylOv
        +77Noc9ko65aZVrV3z93KcP/ECizrSWV9mzDyyQc0Oaaup5LRFCYVbwQs5rNX3im+EbB/I2yEceQX
        FKMDdIwg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oSZoe-007RYV-6j; Mon, 29 Aug 2022 08:08:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 709CD3002C7;
        Mon, 29 Aug 2022 10:08:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 502E3207FBF75; Mon, 29 Aug 2022 10:08:13 +0200 (CEST)
Date:   Mon, 29 Aug 2022 10:08:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Jian-Min <Jian-Min.Liu@mediatek.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] sched/pelt: Introduce PELT multiplier
Message-ID: <Ywxz7cuR+/+1CFMR@hirez.programming.kicks-ass.net>
References: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
 <20220829055450.1703092-2-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829055450.1703092-2-dietmar.eggemann@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 07:54:50AM +0200, Dietmar Eggemann wrote:
> From: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> The new sysctl sched_pelt_multiplier allows a user to set a clock
> multiplier to x2 or x4 (x1 being the default). This clock multiplier
> artificially speeds up PELT ramp up/down similarly to use a faster
> half-life than the default 32ms.
> 
>   - x1: 32ms half-life
>   - x2: 16ms half-life
>   - x4: 8ms  half-life
> 
> Internally, a new clock is created: rq->clock_task_mult. It sits in the
> clock hierarchy between rq->clock_task and rq->clock_pelt.
> 
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

> +extern unsigned int sched_pelt_lshift;
> +
> +/*
> + * absolute time   |1      |2      |3      |4      |5      |6      |
> + * @ mult = 1      --------****************--------****************-
> + * @ mult = 2      --------********----------------********---------
> + * @ mult = 4      --------****--------------------****-------------
> + * clock task mult
> + * @ mult = 2      |   |   |2  |3  |   |   |   |   |5  |6  |   |   |
> + * @ mult = 4      | | | | |2|3| | | | | | | | | | |5|6| | | | | | |
> + *
> + */
> +static inline void update_rq_clock_task_mult(struct rq *rq, s64 delta)
> +{
> +	delta <<= READ_ONCE(sched_pelt_lshift);
> +
> +	rq->clock_task_mult += delta;
> +
> +	update_rq_clock_pelt(rq, delta);
> +}

Hurmph... I'd almost go write you something like
static_call()/static_branch() but for immediates.

That said; given there's only like 3 options, perhaps a few
static_branch() instances work just fine ?
