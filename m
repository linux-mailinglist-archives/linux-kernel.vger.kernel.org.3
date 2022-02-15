Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0A74B6F18
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238653AbiBOOeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:34:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiBOOem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:34:42 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C6610216F;
        Tue, 15 Feb 2022 06:34:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8B337CE200E;
        Tue, 15 Feb 2022 14:34:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD06C340EB;
        Tue, 15 Feb 2022 14:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644935666;
        bh=mUg2TmmDqG6AdurTXvq5gyO2FdCxW5AfJa3PFKAhnxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NcGM22dSh4dPsTdb26zZJgkv9RFg+XbFsZSLkNlzte8J17a+btQYtiRNPnFyfbX8e
         uzlThkzymDL9AVB19//WDhoGfLQBLktX4HU9uE8wMmf+pTxdHwa/RsZ8OEWy7NtRV2
         GmJ6OQrn4CiWBXZXFbbZwG1BBAdvak0gM4829BA29vU0Rq40jVezPGJ1aL5vzNbFlq
         HfAF4LJcOKGrpMecOOJYiW2ydQMIQykh+d3CjYU1rrbJ5vI1S37cSDxVMpj4RKQj/t
         PL0Ms+CaB19AS4Ym8IIjarsmR/Li7n3nEW5861LfOyNjJsQTwZHDPPYAER8kmGwLC0
         2UORWZZ2UlNUA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D29DD400FE; Tue, 15 Feb 2022 11:34:24 -0300 (-03)
Date:   Tue, 15 Feb 2022 11:34:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 12/54] tools/perf: replace bitmap_weight with
 bitmap_empty where appropriate
Message-ID: <Ygu58J67Il0KuPYq@kernel.org>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
 <20220123183925.1052919-13-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123183925.1052919-13-yury.norov@gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jan 23, 2022 at 10:38:43AM -0800, Yury Norov escreveu:
> Some code in builtin-c2c.c calls bitmap_weight() to check if any bit of
> a given bitmap is set. It's better to use bitmap_empty() in that case
> because bitmap_empty() stops traversing the bitmap as soon as it finds
> first set bit, while bitmap_weight() counts all bits unconditionally.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  tools/perf/builtin-c2c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 77dd4afacca4..14f787c67140 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -1080,7 +1080,7 @@ node_entry(struct perf_hpp_fmt *fmt __maybe_unused, struct perf_hpp *hpp,
>  		bitmap_zero(set, c2c.cpus_cnt);
>  		bitmap_and(set, c2c_he->cpuset, c2c.nodes[node], c2c.cpus_cnt);
>  
> -		if (!bitmap_weight(set, c2c.cpus_cnt)) {
> +		if (bitmap_empty(set, c2c.cpus_cnt)) {
>  			if (c2c.node_info == 1) {
>  				ret = scnprintf(hpp->buf, hpp->size, "%21s", " ");
>  				advance_hpp(hpp, ret);
> @@ -1944,7 +1944,7 @@ static int set_nodestr(struct c2c_hist_entry *c2c_he)
>  	if (c2c_he->nodestr)
>  		return 0;
>  
> -	if (bitmap_weight(c2c_he->nodeset, c2c.nodes_cnt)) {
> +	if (!bitmap_empty(c2c_he->nodeset, c2c.nodes_cnt)) {
>  		len = bitmap_scnprintf(c2c_he->nodeset, c2c.nodes_cnt,
>  				      buf, sizeof(buf));
>  	} else {
> -- 
> 2.30.2

-- 

- Arnaldo
