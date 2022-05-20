Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6062352EE2B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350274AbiETOaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiETOaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:30:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25A29D070;
        Fri, 20 May 2022 07:30:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D64061B07;
        Fri, 20 May 2022 14:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CB2C385A9;
        Fri, 20 May 2022 14:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653057008;
        bh=OeOgCk8EVTQhPkt9ndP9eIEJfKLKRtvt7Q6gkADqWOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LOTQ2dYAAHFkY5UX99hXF9yCuk5nnvINOVXS+kUG1GYHrTBHyQEtrztOX+QMpaz2p
         ac76gjoTXBlOrqpxS/Ldzjm4SSfQzvApTtRgppb52uE2SzuAg56YuC/rx2vCuowHQM
         O9Jer8iks/2E1iSkxyuDUE7FnqUdjE3ETBB1xT7I7YMD7xOipuwgnjJOXlX0zOXI/q
         xpZ2/Q5dtXJMuBUjZyUEE6j/Riio3aV8AoOfWW+3nBFCgpSO74gcxD0fxEjhoYoPXS
         k8V0FQaqmo5giANlo8X1DeYI9v0uec4wAC8aWX1FtDgap4xixZq2KAwlK8MPDxO6op
         ZyJzESl3jaB8Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E1C87400B1; Fri, 20 May 2022 11:30:04 -0300 (-03)
Date:   Fri, 20 May 2022 11:30:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Namhyung Kim <namhyung@gmail.com>
Subject: Re: [PATCH v2] perf/s390: Compiler error on s390 for bench/numa.c
Message-ID: <Yoel7HCdQr+uSKNA@kernel.org>
References: <20220520081158.2990006-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220520081158.2990006-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 20, 2022 at 10:11:58AM +0200, Thomas Richter escreveu:
> The compilation on s390 results in this error:
> 
>  # make DEBUG=y bench/numa.o
>  ...
>  bench/numa.c: In function ‘__bench_numa’:
>  bench/numa.c:1749:81: error: ‘%d’ directive output may be truncated
>              writing between 1 and 11 bytes into a region of size between
>              10 and 20 [-Werror=format-truncation=]
>  1749 |        snprintf(tname, sizeof(tname), "process%d:thread%d", p, t);
>                                                                ^~
>  ...
>  bench/numa.c:1749:64: note: directive argument in the range
>                 [-2147483647, 2147483646]
>  ...
>  #
> 
> The maximum length of the %d replacement is 11 characters because
> of the negative sign.  Therefore extend the array by two more
> characters.
> 
> Output after:
>  # make  DEBUG=y bench/numa.o > /dev/null 2>&1; ll bench/numa.o
>  -rw-r--r-- 1 root root 418320 May 19 09:11 bench/numa.o
>  #
> 
> Fixes: 3aff8ba0a4c9c ("perf bench numa: Avoid possible truncation when using snprintf()")
> Suggested-by: Namhyung Kim <namhyung@gmail.com>



Thanks, applied.

- Arnaldo


> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/bench/numa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
> index d5289fa58a4f..20eed1e53f80 100644
> --- a/tools/perf/bench/numa.c
> +++ b/tools/perf/bench/numa.c
> @@ -1740,7 +1740,7 @@ static int __bench_numa(const char *name)
>  		"GB/sec,", "total-speed",	"GB/sec total speed");
>  
>  	if (g->p.show_details >= 2) {
> -		char tname[14 + 2 * 10 + 1];
> +		char tname[14 + 2 * 11 + 1];
>  		struct thread_data *td;
>  		for (p = 0; p < g->p.nr_proc; p++) {
>  			for (t = 0; t < g->p.nr_threads; t++) {
> -- 
> 2.36.1

-- 

- Arnaldo
