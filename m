Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F8A4B8A77
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 14:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbiBPNj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 08:39:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiBPNj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 08:39:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380C82AB53F;
        Wed, 16 Feb 2022 05:39:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0D82617C5;
        Wed, 16 Feb 2022 13:39:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F37C004E1;
        Wed, 16 Feb 2022 13:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645018783;
        bh=fZOgObgmg56ZT81wOV/Cmg29xsNwt6wScoUupkYUFKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L2xORViD3f7Lvsd9z6F42fZWrXWpJ0ruxfaptxIeD4trXCGvefnIK6GvLJ1m3LhK2
         IeX86mrq9t2tQqgNNXPv5Pz43u0my9zZzdtE1tew6+MPwLXM5RCPuKpdmex6ImhDOX
         fYR0X/XZZLfQZDWXlY4OADzbuJ4z0+1JWhSLBSsZRe7h4gQbGSwsWVv11jyuPo7S77
         tYBPp4xfTLq0kVCH7ueBCZgiLhZgBb+VqNNbuvfI86zWwyTw3aud5YXQ0OUZKasclS
         kKxejozS7lb1T5DfSULXkKByJ7WzNyoMpI3xD6AMDUzDZx0Jd7I+cXE1tbQcWinXhs
         db4GcfBbBJcGA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 94D03400FE; Wed, 16 Feb 2022 10:39:41 -0300 (-03)
Date:   Wed, 16 Feb 2022 10:39:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     tangmeng <tangmeng@uniontech.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] perf tools: Remove redundant ret variable
Message-ID: <Ygz+nQksMpsorTC8@kernel.org>
References: <20220216030425.27779-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216030425.27779-1-tangmeng@uniontech.com>
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

Em Wed, Feb 16, 2022 at 11:04:24AM +0800, tangmeng escreveu:
> Return value from hist_entry_iter__add() directly instead
> of taking this in another redundant variable.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: tangmeng <tangmeng@uniontech.com>
> ---
>  tools/perf/builtin-annotate.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index 490bb9b8cf17..e347b8ef088f 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -190,7 +190,6 @@ static int process_branch_callback(struct evsel *evsel,
>  	};
>  
>  	struct addr_location a;
> -	int ret;
>  
>  	if (machine__resolve(machine, &a, sample) < 0)
>  		return -1;
> @@ -203,8 +202,7 @@ static int process_branch_callback(struct evsel *evsel,
>  
>  	hist__account_cycles(sample->branch_stack, al, sample, false, NULL);
>  
> -	ret = hist_entry_iter__add(&iter, &a, PERF_MAX_STACK_DEPTH, ann);
> -	return ret;
> +	return hist_entry_iter__add(&iter, &a, PERF_MAX_STACK_DEPTH, ann);
>  }
>  
>  static bool has_annotation(struct perf_annotate *ann)
> -- 
> 2.20.1
> 
> 

-- 

- Arnaldo
