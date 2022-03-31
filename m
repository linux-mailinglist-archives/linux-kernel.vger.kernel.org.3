Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC8B4EDB99
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbiCaOVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237487AbiCaOVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:21:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD62F1BE4D3;
        Thu, 31 Mar 2022 07:20:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B5C81576;
        Thu, 31 Mar 2022 07:20:03 -0700 (PDT)
Received: from [10.57.8.37] (unknown [10.57.8.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 256FC3F73B;
        Thu, 31 Mar 2022 07:20:02 -0700 (PDT)
Message-ID: <77fa14e8-6630-c0e9-21fc-2603f7383f5f@arm.com>
Date:   Thu, 31 Mar 2022 15:20:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] perf session: Remap buf if there is no space for event
Content-Language: en-US
To:     Denis Nikitin <denik@chromium.org>, acme@kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     jolsa@kernel.org, alexey.budankov@linux.intel.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220330031130.2152327-1-denik@chromium.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220330031130.2152327-1-denik@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/03/2022 04:11, Denis Nikitin wrote:
> If a perf event doesn't fit into remaining buffer space return NULL to
> remap buf and fetch the event again.
> Keep the logic to error out on inadequate input from fuzzing.
> 
> This fixes perf failing on ChromeOS (with 32b userspace):
> 
>   $ perf report -v -i perf.data
>   ...
>   prefetch_event: head=0x1fffff8 event->header_size=0x30, mmap_size=0x2000000: fuzzed or compressed perf.data?
>   Error:
>   failed to process sample
> 
> Fixes: 57fc032ad643 ("perf session: Avoid infinite loop when seeing invalid header.size")
> Signed-off-by: Denis Nikitin <denik@chromium.org>
> ---
>  tools/perf/util/session.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 3b8dfe603e50..45a30040ec8d 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -2095,6 +2095,7 @@ prefetch_event(char *buf, u64 head, size_t mmap_size,
>  	       bool needs_swap, union perf_event *error)
>  {
>  	union perf_event *event;
> +	u16 event_size;
>  
>  	/*
>  	 * Ensure we have enough space remaining to read
> @@ -2107,15 +2108,23 @@ prefetch_event(char *buf, u64 head, size_t mmap_size,
>  	if (needs_swap)
>  		perf_event_header__bswap(&event->header);
>  
> -	if (head + event->header.size <= mmap_size)
> +	event_size = event->header.size;
> +	if (head + event_size <= mmap_size)
>  		return event;
>  
>  	/* We're not fetching the event so swap back again */
>  	if (needs_swap)
>  		perf_event_header__bswap(&event->header);
>  
> -	pr_debug("%s: head=%#" PRIx64 " event->header_size=%#x, mmap_size=%#zx:"
> -		 " fuzzed or compressed perf.data?\n",__func__, head, event->header.size, mmap_size);
> +	/* Check if the event fits into the next mmapped buf. */
> +	if (event_size <= mmap_size - head % page_size) {
> +		/* Remap buf and fetch again. */
> +		return NULL;

Hi Denis,

I tested this and it does fix the issue with a 32bit build. One concern is that the calculation to
see if it will fit in the next map is dependent on the implementation of reader__mmap(). I think it
would be possible for that to change slightly and then you could still get an infinite loop.

But I can't really see a better way to do it, and it's unlikely for reader__mmap() to be modified
to map data in a way to waste part of the buffer so it's probably fine.

Maybe you could extract a function to calculate where the new offset would be in the buffer and share
it between here and reader__mmap(). That would also make it more obvious what the 'head % page_size'
bit is for.

Either way:

Reviewed-by: James Clark <james.clark@arm.com>

> +	}
> +
> +	/* Invalid input. Event size should never exceed mmap_size. */
> +	pr_debug("%s: head=%#" PRIx64 " event->header.size=%#x, mmap_size=%#zx:"
> +		 " fuzzed or compressed perf.data?\n", __func__, head, event_size, mmap_size);
>  
>  	return error;
>  }
