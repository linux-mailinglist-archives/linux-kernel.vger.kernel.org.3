Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB18C472CD7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237171AbhLMNIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbhLMNIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:08:54 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CBEC061574;
        Mon, 13 Dec 2021 05:08:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7DB65CE1025;
        Mon, 13 Dec 2021 13:08:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EEA2C34602;
        Mon, 13 Dec 2021 13:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639400930;
        bh=kA8WYL7HDd9N7LxzJvbTR/JzuMaZNOP8xCfj2QVjNP0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FdGH+0GNmTitFJ2dqbUofH2JnZQbQLMvkZzq2xROWGp8CVdCiNaKmhClSuZATjewT
         MInwA5w0qY+31+n833X5klztNYOBuGxjok63U2Mge/XpcykSqYQBZ914wag75WOYxS
         tjLL69MD9Onm49TLFd8wkI6+nPz6oJTcN/weeKc0lMxwQnt8W8JcCnOxxI+H6JGIE+
         8RK479knzqndnOyZ8GsKzFdyKS9PwTJJuxuU/jmFqDDjwzclQj0RtKG8Aux8x2lzsO
         xYOB0+5aq/PxtYMcgvbp7VYEjxiZy3cQiGcJUNPUrJcOAHLJUyPSBxk9PhQ8I+MJLs
         7Xs8NQdo3ErhQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D50CE405D8; Mon, 13 Dec 2021 10:08:48 -0300 (-03)
Date:   Mon, 13 Dec 2021 10:08:48 -0300
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
Message-ID: <YbdF4FtPY77Y6faW@kernel.org>
References: <20211212062504.25841-1-linmq006@gmail.com>
 <YbdFOvHedDCVZ04A@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YbdFOvHedDCVZ04A@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 13, 2021 at 10:06:02AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Sun, Dec 12, 2021 at 06:25:02AM +0000, Miaoqian Lin escreveu:
> > The hashmap__new() function may return ERR_PTR(-ENOMEM) when malloc
> > fails, add IS_ERR checking for ctx->ids.
> > 
> > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> 
> Thanks, applied.

I take that back, kfree()? Are you compile testing this?

  CC      /tmp/build/perf/util/expr.o
util/expr.c: In function ‘expr__ctx_new’:
util/expr.c:302:13: error: implicit declaration of function ‘IS_ERR’ [-Werror=implicit-function-declaration]
  302 |         if (IS_ERR(ctx->ids)) {
      |             ^~~~~~
util/expr.c:303:17: error: implicit declaration of function ‘kfree’; did you mean ‘free’? [-Werror=implicit-function-declaration]
  303 |                 kfree(ctx);
      |                 ^~~~~
      |                 free
cc1: all warnings being treated as errors

I had to fix it applying this on top, please compile test your patches.

- Arnaldo

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index c94c9ea30d1abd6a..254601060b392c42 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -12,6 +12,7 @@
 #include "expr-bison.h"
 #include "expr-flex.h"
 #include "smt.h"
+#include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
 #include <ctype.h>
@@ -300,7 +301,7 @@ struct expr_parse_ctx *expr__ctx_new(void)
 
 	ctx->ids = hashmap__new(key_hash, key_equal, NULL);
 	if (IS_ERR(ctx->ids)) {
-		kfree(ctx);
+		free(ctx);
 		return NULL;
 	}
 	ctx->runtime = 0;
