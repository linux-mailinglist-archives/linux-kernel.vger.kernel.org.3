Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550285017FA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345043AbiDNP6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358382AbiDNPll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:41:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D6AECDA4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a7zF3jN+ZuZUeKxEZxyh6BUyYjHKt2ke+Gaa4KDb6Ss=; b=JI7UTDpPYhqXfQKCuMEmYAowpM
        KIhHEIS1dFUdiL/5HF6Ars5OntlUd2gqm+jpr8egpvGlWNYIvboqCNJV5AEHMDPviYf2LtankgtO1
        aN63NIxsiNrqgH/yec/1SBUhuUGXoD2DhaigfktalJ0QviP9lT4XfmUbyBSFrbRBu46E+wkhKg29P
        S5TTuXj3ELigIDn7xfH0U6QP8z8oaktVYWwuKrTIFGTJi0OdSidmRIzUj2ESbknagmLuFJ3Tcl4l5
        JR/BZZsqY69LwJApHxjCus6gVVR/R4DXR1bg70z3O9MRZOrdswtpHtL5/LTTA5zD+Tu82Nrb7YNY7
        +kx8Q6GA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nf1Jd-00FEUn-VO; Thu, 14 Apr 2022 15:23:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 80B2C3002DE;
        Thu, 14 Apr 2022 17:23:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 434D631B56D1F; Thu, 14 Apr 2022 17:23:25 +0200 (CEST)
Date:   Thu, 14 Apr 2022 17:23:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe de Dinechin <dinechin@redhat.com>
Cc:     trivial@kernel.org, Ben Segall <bsegall@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 2/3] nodemask.h: Fix compilation error with GCC12
Message-ID: <Ylg8baQjQTkrnnD9@hirez.programming.kicks-ass.net>
References: <20220414150855.2407137-1-dinechin@redhat.com>
 <20220414150855.2407137-3-dinechin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414150855.2407137-3-dinechin@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 05:08:54PM +0200, Christophe de Dinechin wrote:

> diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
> index 567c3ddba2c4..c6199dbe2591 100644
> --- a/include/linux/nodemask.h
> +++ b/include/linux/nodemask.h
> @@ -375,14 +375,13 @@ static inline void __nodes_fold(nodemask_t *dstp, const nodemask_t *origp,
>  }
>  
>  #if MAX_NUMNODES > 1
> -#define for_each_node_mask(node, mask)			\
> -	for ((node) = first_node(mask);			\
> -		(node) < MAX_NUMNODES;			\
> -		(node) = next_node((node), (mask)))
> +#define for_each_node_mask(node, mask)				    \
> +	for ((node) = first_node(mask);				    \
> +	     (node >= 0) && (node) < MAX_NUMNODES;		    \
> +	     (node) = next_node((node), (mask)))
>  #else /* MAX_NUMNODES == 1 */
> -#define for_each_node_mask(node, mask)			\
> -	if (!nodes_empty(mask))				\
> -		for ((node) = 0; (node) < 1; (node)++)
> +#define for_each_node_mask(node, mask)                                  \
> +	for ((node) = 0; (node) < 1 && !nodes_empty(mask); (node)++)
>  #endif /* MAX_NUMNODES */

Again, less readable code :/ And why?
