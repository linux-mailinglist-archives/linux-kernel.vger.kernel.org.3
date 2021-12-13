Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FAE472CF4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237253AbhLMNOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:14:05 -0500
Received: from foss.arm.com ([217.140.110.172]:54580 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232266AbhLMNOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:14:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA8881FB;
        Mon, 13 Dec 2021 05:14:03 -0800 (PST)
Received: from [10.57.7.82] (unknown [10.57.7.82])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 755A53F793;
        Mon, 13 Dec 2021 05:14:01 -0800 (PST)
Subject: Re: [PATCH] perf expr: Fix return value of ids__new
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <864ad02d-6afe-791c-f742-56582b633482@arm.com>
 <20211213070956.15119-1-linmq006@gmail.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <d0fabb42-399f-2b72-412b-4f5ba6b9eea4@arm.com>
Date:   Mon, 13 Dec 2021 13:13:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211213070956.15119-1-linmq006@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miaoqian,

Fails to build due to missing import: "#import <linux/err.h>".

Could you please verify?

Other than that, it looks good to me. I shared the testing below:

On 13/12/2021 07:09, Miaoqian Lin wrote:
> callers of ids__new() function only do NULL checking for the return
> value. ids__new() calles hashmap__new(), which may return
> ERR_PTR(-ENOMEM). Instead of changing the checking one-by-one.
> return NULL instead of ERR_PTR(-ENOMEM) to keep
> consistent.
>
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  tools/perf/util/expr.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index 1d532b9fed29..aabdc112300c 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -65,7 +65,13 @@ static bool key_equal(const void *key1, const void *key2,
>  
>  struct hashmap *ids__new(void)
>  {
> -	return hashmap__new(key_hash, key_equal, NULL);
> +	struct hashmap *hash;
> +
> +	hash = hashmap__new(key_hash, key_equal, NULL);
> +	if (IS_ERR(hash))
> +		return NULL;
> +	else
> +		return hash;
>  }
>  
>  void ids__free(struct hashmap *ids)
Before this patch, perf-test was segfaulting instead of a graceful fail.
I think this could have been an issue in the perf tool as well.

(I forced hashmap__new in "tools/perf/util/hashmap.c" to always return
the error for the purposes of the test).

  $ make DEBUG=1 NO_LIBBPF=1 # builds with tools/perf/util/hashmap.c
  $ ./perf test 7 -v
  Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
   7: Simple expression parser                                        :
  --- start ---
  test child forked, pid 1953536
  perf: Segmentation fault
  Obtained 16 stack frames.
  ./perf(dump_stack+0x31) [0x559222b3ae48]
  ./perf(sighandler_dump_stack+0x33) [0x559222b3af30]
  /lib/x86_64-linux-gnu/libc.so.6(+0x4620f) [0x7ff81df6220f]
  ./perf(hashmap__size+0x23) [0x559222bf9f47]
  ./perf(ids__union+0x5f) [0x559222be1f0e]
  ./perf(+0x2d9ba8) [0x559222ac7ba8]
  ./perf(+0x2da223) [0x559222ac8223]
  ./perf(+0x2a5fe9) [0x559222a93fe9]
  ./perf(+0x2a6119) [0x559222a94119]
  ./perf(+0x2a6de7) [0x559222a94de7]
  ./perf(cmd_test+0x25f) [0x559222a95686]
  ./perf(+0x2e4d25) [0x559222ad2d25]
  ./perf(+0x2e4faa) [0x559222ad2faa]
  ./perf(+0x2e50fd) [0x559222ad30fd]
  ./perf(main+0x29d) [0x559222ad3500]
  /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xf2) [0x7ff81df430b2]
  test child interrupted
  ---- end ----
  Simple expression parser: FAILED!

After the patch:

  $ make DEBUG=1 NO_LIBBPF=1
  $ ./perf test 7 -v
  Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
   7: Simple expression parser                                        :
  --- start ---
  test child forked, pid 1960026
  FAILED tests/expr.c:16 ids__new
  FAILED tests/expr.c:16 ids__new
  FAILED tests/expr.c:73 ids_union (-1 != 0)
  test child finished with -1
  ---- end ----

  Simple expression parser: FAILED!

so with the missing import fixex:

Tested-by: German Gomez <german.gomez@arm.com>
Reviewed-by: German Gomez <german.gomez@arm.com>

