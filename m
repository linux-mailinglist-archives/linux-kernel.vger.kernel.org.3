Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5013F472CC9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbhLMNGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:06:08 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57194 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbhLMNGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:06:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7AB5DB80ED6;
        Mon, 13 Dec 2021 13:06:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2521FC34601;
        Mon, 13 Dec 2021 13:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639400765;
        bh=+8QV3ssbLjJ6PLFyld96El6tbCiuqTlpLLPNHyWp1iU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bbOWbLy1/rPUKNn/J8VCDYjsHrtf40bMrrPwO91Pz5LfS9jHIT19wgloW6IGKxO7r
         KpFQDCJdQu70Guu+hxyGfAPg0bk8PXJMEGdrIBqzmSl/ViiGL0Zq2vwwB6kpkm8o/+
         RXFUOxT/3AhyjvndKWzD+lx62ZYRuCM9oWriBx0Rot9camrYH91CdggPUANjWKeqOg
         xMhhebFqknmYI/e1LboWN7zvT6VqHrErGT37McDzZVrdgNyhPuZ60T5NMpCJ0La6cp
         BjLlyZxf6hQWG1+z/siSxaBX2ja8wMuHnUzitp/h4x1nTX5MJVRzXHIds3lr3fol/h
         uQ2sO+BainYbw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 92D90405D8; Mon, 13 Dec 2021 10:06:02 -0300 (-03)
Date:   Mon, 13 Dec 2021 10:06:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf expr: Fix missing check for return value of
 hashmap__new
Message-ID: <YbdFOvHedDCVZ04A@kernel.org>
References: <20211212062504.25841-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211212062504.25841-1-linmq006@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Dec 12, 2021 at 06:25:02AM +0000, Miaoqian Lin escreveu:
> The hashmap__new() function may return ERR_PTR(-ENOMEM) when malloc
> fails, add IS_ERR checking for ctx->ids.
> 
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Thanks, applied.

As a follow up you may consider using ids__new() instead:

struct hashmap *ids__new(void)
{
        return hashmap__new(key_hash, key_equal, NULL);
}

And I noticed that the users of ids__new() are not using IS_ERR() on its
return in tools/perf/tests/expr.c, e.g.:

static int test_ids_union(void)
{
        struct hashmap *ids1, *ids2;

        /* Empty union. */
        ids1 = ids__new();
        TEST_ASSERT_VAL("ids__new", ids1);
        ids2 = ids__new();
        TEST_ASSERT_VAL("ids__new", ids2);

This needs converting to TEST_ASSERT_VAL_IS_ERR() probably after
introducing it, I haven't checked if this variation exists.

- Arnaldo

> ---
>  tools/perf/util/expr.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index 1d532b9fed29..c94c9ea30d1a 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -299,6 +299,10 @@ struct expr_parse_ctx *expr__ctx_new(void)
>  		return NULL;
>  
>  	ctx->ids = hashmap__new(key_hash, key_equal, NULL);
> +	if (IS_ERR(ctx->ids)) {
> +		kfree(ctx);
> +		return NULL;
> +	}
>  	ctx->runtime = 0;
>  
>  	return ctx;
> -- 
> 2.17.1

-- 

- Arnaldo
