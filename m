Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC989542C7B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbiFHKDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbiFHKCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:02:51 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7381451CF;
        Wed,  8 Jun 2022 02:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A+CyjXVi+KYsagLnxynLgPapKZafI2doGh1EpEXW+4I=; b=TpYct5GI0487LzQAlTdrSE007A
        Sa5jAYgO/UNmcTh8AyD0Z86ax39efkq0QC0bGMOOwswFnooLZ9ePviOj1F1EXNpbbg/LevKDMxUMg
        cJoctLg2AKYrmd1dkC9lo/rGo42fq++QVYxb+oT/Dg9eBzqKS5+PUcCk8dDSY+8zHL4nmNR7rhigb
        fhwj/f7n3NDigPX/Spdm1kmlg52GG/Jnd8P2wkRl49Na/85fAMDtG17ZErtT/2Q5JuiPuXa4vsU6n
        HrkTF53KHft8nDem3bVFnp9QjYRO5D9NZ3fVkxg4EuAN+W6sLAIAurJaa+oHdlDgG1itc5X7jHTCs
        J/zq9nhw==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nysDb-005zfL-LV; Wed, 08 Jun 2022 09:43:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6596C30017D;
        Wed,  8 Jun 2022 11:43:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2A9E620250966; Wed,  8 Jun 2022 11:43:13 +0200 (CEST)
Date:   Wed, 8 Jun 2022 11:43:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yanfei Xu <yanfei.xu@intel.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf/core: remove a meaningless pair of
 rcu_read_{,un}lock()
Message-ID: <YqBvMWwc1T4ZdKCg@hirez.programming.kicks-ass.net>
References: <20220608090938.2178624-1-yanfei.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608090938.2178624-1-yanfei.xu@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 05:09:38PM +0800, Yanfei Xu wrote:
> Per the codes, this pair of rcu_read_{,un}lock() protects nothing.
> Let's remove it.
> 
> Further, the variable "pmu" is safe as it is in the SRCU read-side
> critical scope of "pmus_srcu" and perf_pmu_unregister() delete it
> after calling synchronize_srcu.
> 
> Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
> ---
>  kernel/events/core.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 950b25c3f210..36b0df6feab4 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -11296,9 +11296,7 @@ static struct pmu *perf_init_event(struct perf_event *event)
>  	}
>  
>  again:
> -	rcu_read_lock();
>  	pmu = idr_find(&pmu_idr, type);
> -	rcu_read_unlock();

You're mistaken, this is required for the radix tree internal nodes.
Without it we can't safely traverse the radix tree without full
serialization against the modifiers.
