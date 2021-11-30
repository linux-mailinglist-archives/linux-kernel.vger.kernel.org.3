Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16484636F0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242296AbhK3OpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:45:17 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41948 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbhK3Oo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:44:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14C9FB817C0;
        Tue, 30 Nov 2021 14:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E32AC53FC7;
        Tue, 30 Nov 2021 14:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638283297;
        bh=Ouj+XDtVgzgbk0sY9IFub0J8BvaA2jvIyNSF0SOcSj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SsyFzsD15+xk8uOcAye3QD3RZXaz7mfbR9L4uegn5dC5LcHn5Ave1Kg7pEg5IU2cS
         3hupVxqKep78pHo630sOaimf1MaUdPKIVvsrk+id3KB2qpq/5OFJzCMR9Rz6A88OWO
         h4UwUULOpXZ3ALrcMZnG34Q2XP9e86Vj0WJAmQNUce9TQ5RsTKEtmpjXD5w+kADIUM
         wiCIXLh97KTmt7DiJ9cm2j1MXxxI3l/eR5ptWhyZ53+czYUYSA0DIfjFDFRJXupbhG
         1Vc39L53ZRNDj/IpDHzjzwhAWEfXVxRDyVYSDbuAJtsPkS3FPFWcgmgVA0oms0vM2j
         /Ud16eg0ZlbOQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 65A8640002; Tue, 30 Nov 2021 11:41:35 -0300 (-03)
Date:   Tue, 30 Nov 2021 11:41:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, svens@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, hca@linux.ibm.com
Subject: Re: [PATCH v2] tools/perf: Fix perf test 7 Simple expression parser
Message-ID: <YaY4HwSEJHszy64Y@kernel.org>
References: <20211129112339.3003036-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129112339.3003036-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 29, 2021 at 12:23:39PM +0100, Thomas Richter escreveu:
> Some platforms do not have CPU die support, for example s390.
> Commit fdf1e29b6118 ("perf expr: Add metric literals for topology.")
> fails on s390:
>  # ./perf test -Fv 7
>    ...
>  # FAILED tests/expr.c:173 #num_dies >= #num_packages
>    ---- end ----
>    Simple expression parser: FAILED!
>  #
> 
> Investigating this issue leads to these functions:
>  build_cpu_topology()
>    +--> has_die_topology(void)
>         {
>            struct utsname uts;
> 
>            if (uname(&uts) < 0)
>                   return false;
>            if (strncmp(uts.machine, "x86_64", 6))
>                   return false;
>            ....
>         }
> 
> which always returns false on s390. The caller build_cpu_topology()
> checks has_die_topology() return value. On false the
> the struct cpu_topology::die_cpu_list is not contructed and has zero
> entries. This leads to the failing comparison: #num_dies >= #num_packages.
> s390 of course has a positive number of packages.
> 
> Fix this and check if the function build_cpu_topology() did build up
> a die_cpus_list. The number of entries in this list should be larger
> than 0. If the number of list element is zero, the die_cpus_list has
> not been created and the check in function test__expr()
>     TEST_ASSERT_VAL("#num_dies >= #num_packages", \
> 		    num_dies >= num_packages)
> always fails.
> 
> Output after:
>  # ./perf test -Fv 7
>   7: Simple expression parser                                        :
>   --- start ---
>   division by zero
>   syntax error
>   ---- end ----
>   Simple expression parser: Ok
>  #
> Cc: Ian Rogers <irogers@google.com>
> Fixes: fdf1e29b6118 ("perf expr: Add metric literals for topology.")
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/expr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> index c895de481fe1..9356d90bf8db 100644
> --- a/tools/perf/tests/expr.c
> +++ b/tools/perf/tests/expr.c
> @@ -169,7 +169,8 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
>  	TEST_ASSERT_VAL("#num_dies", expr__parse(&num_dies, ctx, "#num_dies") == 0);
>  	TEST_ASSERT_VAL("#num_cores >= #num_dies", num_cores >= num_dies);
>  	TEST_ASSERT_VAL("#num_packages", expr__parse(&num_packages, ctx, "#num_packages") == 0);
> -	TEST_ASSERT_VAL("#num_dies >= #num_packages", num_dies >= num_packages);
> +	if (num_dies)
> +		TEST_ASSERT_VAL("#num_dies >= #num_packages", num_dies >= num_packages);
>  
>  	/*
>  	 * Source count returns the number of events aggregating in a leader
> -- 


I'll add a comment for the casual reader:

+	if (num_dies) // Some platforms do not have CPU die support, for example s390
+		TEST_ASSERT_VAL("#num_dies >= #num_packages", num_dies >= num_packages);
