Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF57472E48
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237591AbhLMN6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:58:00 -0500
Received: from foss.arm.com ([217.140.110.172]:55750 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233782AbhLMN57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:57:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 817131FB;
        Mon, 13 Dec 2021 05:57:58 -0800 (PST)
Received: from [10.57.7.82] (unknown [10.57.7.82])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 217533F73B;
        Mon, 13 Dec 2021 05:57:55 -0800 (PST)
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
Message-ID: <34713bd7-1464-95a3-b9ba-c27a56948560@arm.com>
Date:   Mon, 13 Dec 2021 13:57:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211213070956.15119-1-linmq006@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This message appeared in my client as a separate thread, but it seems to
be a reply to a message from a different thread:

"In-Reply-To: <864ad02d-6afe-791c-f742-56582b633482@arm.com>"

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
