Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC9650C501
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbiDVXYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 19:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiDVXYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 19:24:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF53D3465
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 15:59:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4DE96149C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 22:59:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5951CC385A4;
        Fri, 22 Apr 2022 22:59:24 +0000 (UTC)
Date:   Fri, 22 Apr 2022 18:59:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: Re: [PATCH v2 1/4] tracing: Remove usage of list iterator after the
 loop body
Message-ID: <20220422185922.15fe4614@gandalf.local.home>
In-Reply-To: <20220402103341.1763932-2-jakobkoschel@gmail.com>
References: <20220402103341.1763932-1-jakobkoschel@gmail.com>
        <20220402103341.1763932-2-jakobkoschel@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  2 Apr 2022 12:33:38 +0200
Jakob Koschel <jakobkoschel@gmail.com> wrote:

> In preparation to limit the scope of the list iterator variable to the
> traversal loop, use a dedicated pointer to point to the found element
> [1].
> 
> Before, the code implicitly used the head when no element was found
> when using &pos->list. Since the new variable is only set if an
> element was found, the head needs to be used explicitly if the
> variable is NULL.
> 
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>  kernel/trace/trace_output.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index 8aa493d25c73..733a4d6c20e2 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -692,7 +692,7 @@ static LIST_HEAD(ftrace_event_list);
>  
>  static int trace_search_list(struct list_head **list)
>  {
> -	struct trace_event *e;
> +	struct trace_event *e = NULL, *iter;
>  	int next = __TRACE_LAST_TYPE;
>  
>  	if (list_empty(&ftrace_event_list)) {
> @@ -704,9 +704,11 @@ static int trace_search_list(struct list_head **list)
>  	 * We used up all possible max events,
>  	 * lets see if somebody freed one.
>  	 */
> -	list_for_each_entry(e, &ftrace_event_list, list) {
> -		if (e->type != next)
> +	list_for_each_entry(iter, &ftrace_event_list, list) {
> +		if (iter->type != next) {
> +			e = iter;
>  			break;
> +		}
>  		next++;
>  	}
>  
> @@ -714,7 +716,10 @@ static int trace_search_list(struct list_head **list)
>  	if (next > TRACE_EVENT_TYPE_MAX)
>  		return 0;
>  
> -	*list = &e->list;
> +	if (e)

Technically, if e was NULL, then next would be too big. But as that's very
subtle with the algorithm, I'm fine adding this.

-- Steve


> +		*list = &e->list;
> +	else
> +		*list = &ftrace_event_list;
>  	return next;
>  }
>  
