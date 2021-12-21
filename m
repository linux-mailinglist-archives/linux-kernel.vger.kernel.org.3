Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C127547C158
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 15:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238404AbhLUOUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 09:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238398AbhLUOUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 09:20:02 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE424C061574;
        Tue, 21 Dec 2021 06:20:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 41E93CE17AD;
        Tue, 21 Dec 2021 14:20:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C1BC36AE9;
        Tue, 21 Dec 2021 14:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640096398;
        bh=w+0W4nazN2afM86/V/3t4u41Se18DBzL91myJaMCIXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N5DzwXYvjIUHQ4NKGXFKmXQ3Gd5ieCrivd3hXeP0bYbG5FyfLC5UhI/ovQIXoDq3S
         CXKv+QEWPQAky7OhnG2lbSd9njlFYgFapqaW7xtr2TSlfos3upLy+OKqvyu1qfiFYZ
         iTJe3xq/ZSBy3jTwsPacvhiF0q8GtUZQ4qSmfurhIkmLM6lXd4pojUCpUz8fZMpGi4
         eBoD8/daxaneuaXln2Hr/FG6eOFPuwr3Q+tTw/+lGXa6bk5PW/vLumSJ2gupKYgdAM
         jblozaZLU0x/iA3UZcO3oV48BGuGHcqpSAszKx8u5nUxG8K3wTEeih8PKgKdJKt4zX
         dockSPk4juyqw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B055A40DC5; Tue, 21 Dec 2021 11:19:55 -0300 (-03)
Date:   Tue, 21 Dec 2021 11:19:55 -0300
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
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf expr: Fix return value of ids__new
Message-ID: <YcHii0u6dusZFt6E@kernel.org>
References: <20211214011030.20200-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214011030.20200-1-linmq006@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 14, 2021 at 01:10:27AM +0000, Miaoqian Lin escreveu:
> callers of ids__new() function only do NULL checking for the return
> value. ids__new() calles hashmap__new(), which may return
> ERR_PTR(-ENOMEM). Instead of changing the checking one-by-one.
> return NULL instead of ERR_PTR(-ENOMEM) to keep
> consistent.

Please don't use --- as a separator inside the commit message, it breaks
scripts that expect it to be a separator from the commit log message to
the diffstat + patch.

Applying after fixing this.

- Arnaldo
 
> ---
> Changes in v3:
> fix compilation error and add tags.
> ---
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> Tested-by: German Gomez <german.gomez@arm.com>
> Reviewed-by: German Gomez <german.gomez@arm.com>
> ---
>  tools/perf/util/expr.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index 1d532b9fed29..f225247acc01 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -12,6 +12,7 @@
>  #include "expr-bison.h"
>  #include "expr-flex.h"
>  #include "smt.h"
> +#include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/zalloc.h>
>  #include <ctype.h>
> @@ -65,7 +66,12 @@ static bool key_equal(const void *key1, const void *key2,
>  
>  struct hashmap *ids__new(void)
>  {
> -	return hashmap__new(key_hash, key_equal, NULL);
> +	struct hashmap *hash;
> +
> +	hash = hashmap__new(key_hash, key_equal, NULL);
> +	if (IS_ERR(hash))
> +		return NULL;
> +	return hash;
>  }
>  
>  void ids__free(struct hashmap *ids)
> -- 
> 2.17.1

-- 

- Arnaldo
