Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AF0564010
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 14:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiGBMSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 08:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiGBMSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 08:18:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3B79FC6;
        Sat,  2 Jul 2022 05:18:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B09A60B70;
        Sat,  2 Jul 2022 12:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A95C34114;
        Sat,  2 Jul 2022 12:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656764321;
        bh=vHkVr3Xnp9/13ksrVIueC09gqM5BYMAMpr8ToNmwTKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=on/8bBA/BwTaAjAspsO8q7/J5LprnogcGVcpACo1kv0Y7UZFHD01cJjbpv1YBmiTF
         u9xiqp5H2TBcRGH8PTdo2QFZ7iO9ENotnp5Dfmj2WARNJF12XrhOllhNcKlXZxFtRf
         CjA3oTBkfhwXlvJmpyBRdQ+Sb+ksA5mS5Zi+YbpaFWcAcaCjdVgWwUE2WFNtaZDf7p
         LXkn4WF+HTFItJXJzqQrOPrFtQr4V9fCtWRyb6KsClGaTbMhbkuVbQk6sJzWnIj6Rz
         UxNGrWDzJxY6QUyXdlOdfO+fpq4elof7l7574PjhmqUgbMHcGa0p++iEwX09h6EErG
         kykWANvV7KE6g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7B3564096F; Sat,  2 Jul 2022 09:18:38 -0300 (-03)
Date:   Sat, 2 Jul 2022 09:18:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Ian Rogers <irogers@google.com>,
        Fangrui Song <maskray@google.com>
Subject: Re: [PATCH] perf unwind: fix unitialized offset on aarch64
Message-ID: <YsA3nmwXyLfN4OQA@kernel.org>
References: <20220701182046.12589-1-ivan@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701182046.12589-1-ivan@cloudflare.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 01, 2022 at 11:20:46AM -0700, Ivan Babrou escreveu:
> Commit dc2cf4ca866f uncovered the following issue on aarch64:
> 
>     util/unwind-libunwind-local.c: In function 'find_proc_info':
>     util/unwind-libunwind-local.c:386:28: error: 'offset' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>     386 |                         if (ofs > 0) {
>         |                            ^
>     util/unwind-libunwind-local.c:199:22: note: 'offset' was declared here
>     199 |         u64 address, offset;
>         |                      ^~~~~~
>     util/unwind-libunwind-local.c:371:20: error: 'offset' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>     371 |                 if (ofs <= 0) {
>         |                    ^
>     util/unwind-libunwind-local.c:199:22: note: 'offset' was declared here
>     199 |         u64 address, offset;
>         |                      ^~~~~~
>     util/unwind-libunwind-local.c:363:20: error: 'offset' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>     363 |                 if (ofs <= 0) {
>         |                    ^
>     util/unwind-libunwind-local.c:199:22: note: 'offset' was declared here
>     199 |         u64 address, offset;
>         |                      ^~~~~~
>     In file included from util/libunwind/arm64.c:37:

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
> Fixes: dc2cf4ca866f
> ---
>  tools/perf/util/unwind-libunwind-local.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
> index 37622699c91a..eaa8fa4b34f3 100644
> --- a/tools/perf/util/unwind-libunwind-local.c
> +++ b/tools/perf/util/unwind-libunwind-local.c
> @@ -197,7 +197,7 @@ static int elf_section_address_and_offset(int fd, const char *name, u64 *address
>  #ifndef NO_LIBUNWIND_DEBUG_FRAME
>  static u64 elf_section_offset(int fd, const char *name)
>  {
> -	u64 address, offset;
> +	u64 address, offset = 0;
>  
>  	if (elf_section_address_and_offset(fd, name, &address, &offset))
>  		return 0;
> -- 
> 2.36.1

-- 

- Arnaldo
