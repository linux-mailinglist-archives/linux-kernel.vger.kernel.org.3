Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C040E4D6BCE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 03:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiCLCLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 21:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiCLCLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 21:11:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF4F4FC7F;
        Fri, 11 Mar 2022 18:10:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB21AB82C0F;
        Sat, 12 Mar 2022 02:10:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F6EC340E9;
        Sat, 12 Mar 2022 02:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647051008;
        bh=bp069JGN4ocK6yuNHpcDkHggg5EUw4G/koG2EZ6uGZw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WHcMISdP/M7cIEW7D6QoAw8quonpsAfRVpqaRZBmAv397rAdx1X+wHl570R8VKrEX
         UW+98a/5yJAImtgEfXqqhZ5IDrPSVYfji9B7fLD0/TkF2XUcBsw0J/vilNlz8zAAHl
         oBR3cHjp5zHzrx4YZIe+Z7vwvmuuGMUdl6RrsaRA6WXTI3WJh7NQLGLm5EoJy0OTAi
         AUFFzXEtUqIRb5VUjKedWir4xliYOECFrn+psx+cs+dG/naS76omeJFqIa0vUUoF88
         wfe5Tj5191F2WV4JKjgJDhYxSrHcs/C8TbXBSkhrxjyvI5EZAxmS6vKdj+vN1v1JAL
         T0VyjeuBXdpnA==
Date:   Sat, 12 Mar 2022 11:10:04 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>
Subject: Re: [PATCH] tracing/user_events: Use alloc_pages instead of
 kzalloc() for register pages
Message-Id: <20220312111004.a199b41e036fe79da05b84f6@kernel.org>
In-Reply-To: <20220311190457.0345eeb2@gandalf.local.home>
References: <20220311190457.0345eeb2@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2022 19:04:57 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> kzalloc virtual addresses do not work with SetPageReserved, use the actual
> page virtual addresses instead via alloc_pages.

Indeed. kzalloc allocates a slab object, we need a page.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> 
> The issue is reported when booting with user_events and
> DEBUG_VM_PGFLAGS=y.
> 
> Also make the number of events based on the ORDER.
> 
> Link: https://lore.kernel.org/all/CADYN=9+xY5Vku3Ws5E9S60SM5dCFfeGeRBkmDFbcxX0ZMoFing@mail.gmail.com/
> Link: https://lore.kernel.org/all/20220311223028.1865-1-beaub@linux.microsoft.com/
> 
> Cc: Beau Belgrave <beaub@linux.microsoft.com>
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events_user.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index 4febc1d6ae72..e10ad057e797 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -30,9 +30,10 @@
>  
>  /*
>   * Limits how many trace_event calls user processes can create:
> - * Must be multiple of PAGE_SIZE.
> + * Must be a power of two of PAGE_SIZE.
>   */
> -#define MAX_PAGES 1
> +#define MAX_PAGE_ORDER 0
> +#define MAX_PAGES (1 << MAX_PAGE_ORDER)
>  #define MAX_EVENTS (MAX_PAGES * PAGE_SIZE)
>  
>  /* Limit how long of an event name plus args within the subsystem. */
> @@ -1622,16 +1623,17 @@ static void set_page_reservations(bool set)
>  
>  static int __init trace_events_user_init(void)
>  {
> +	struct page *pages;
>  	int ret;
>  
>  	/* Zero all bits beside 0 (which is reserved for failures) */
>  	bitmap_zero(page_bitmap, MAX_EVENTS);
>  	set_bit(0, page_bitmap);
>  
> -	register_page_data = kzalloc(MAX_EVENTS, GFP_KERNEL);
> -
> -	if (!register_page_data)
> +	pages = alloc_pages(GFP_KERNEL | __GFP_ZERO, MAX_PAGE_ORDER);
> +	if (!pages)
>  		return -ENOMEM;
> +	register_page_data = page_address(pages);
>  
>  	set_page_reservations(true);
>  
> @@ -1640,7 +1642,7 @@ static int __init trace_events_user_init(void)
>  	if (ret) {
>  		pr_warn("user_events could not register with tracefs\n");
>  		set_page_reservations(false);
> -		kfree(register_page_data);
> +		__free_pages(pages, MAX_PAGE_ORDER);
>  		return ret;
>  	}
>  
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
