Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B854D6B2C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiCKXez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 18:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiCKXex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 18:34:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F1D17F6B0;
        Fri, 11 Mar 2022 15:33:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD48160EED;
        Fri, 11 Mar 2022 23:33:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A910C340E9;
        Fri, 11 Mar 2022 23:33:45 +0000 (UTC)
Date:   Fri, 11 Mar 2022 18:33:43 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     mhiramat@kernel.org, anders.roxell@linaro.org,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: Re: [PATCH] user_events: Use alloc_pages instead of kzalloc for
 register pages
Message-ID: <20220311183343.4d8c94a5@gandalf.local.home>
In-Reply-To: <20220311223028.1865-1-beaub@linux.microsoft.com>
References: <20220311223028.1865-1-beaub@linux.microsoft.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2022 14:30:28 -0800
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index 2b5e9fdb63a0..59c900789757 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -1587,16 +1587,20 @@ static void set_page_reservations(bool set)
>  static int __init trace_events_user_init(void)
>  {
>  	int ret;
> +	struct page *register_pages;

The int ret should come last.

>  
>  	/* Zero all bits beside 0 (which is reserved for failures) */
>  	bitmap_zero(page_bitmap, MAX_EVENTS);
>  	set_bit(0, page_bitmap);
>  
> -	register_page_data = kzalloc(MAX_EVENTS, GFP_KERNEL);
> +	register_pages = alloc_pages(GFP_KERNEL | __GFP_ZERO,
> +				     get_order(MAX_EVENTS));
>  
> -	if (!register_page_data)
> +	if (!register_pages)
>  		return -ENOMEM;
>  
> +	register_page_data = page_address(register_pages);
> +
>  	set_page_reservations(true);
>  
>  	ret = create_user_tracefs();
> @@ -1604,7 +1608,7 @@ static int __init trace_events_user_init(void)
>  	if (ret) {
>  		pr_warn("user_events could not register with tracefs\n");
>  		set_page_reservations(false);
> -		kfree(register_page_data);
> +		__free_pages(register_pages, get_order(MAX_EVENTS));
>  		return ret;
>  	}
>  

I tried it slightly differently. Why waist bits if MAX_EVENTS is greater
than the order. That is, make MAX_EVENTS depend on the order, not the other
way around.

-- Steve

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 4febc1d6ae72..6941d0794347 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -30,9 +30,10 @@
 
 /*
  * Limits how many trace_event calls user processes can create:
- * Must be multiple of PAGE_SIZE.
+ * Must be a power of two of PAGE_SIZE.
  */
-#define MAX_PAGES 1
+#define MAX_PAGE_ORDER 0
+#define MAX_PAGES (1 << MAX_PAGE_ORDER)
 #define MAX_EVENTS (MAX_PAGES * PAGE_SIZE)
 
 /* Limit how long of an event name plus args within the subsystem. */
@@ -1606,41 +1607,25 @@ static int create_user_tracefs(void)
 	return -ENODEV;
 }
 
-static void set_page_reservations(bool set)
-{
-	int page;
-
-	for (page = 0; page < MAX_PAGES; ++page) {
-		void *addr = register_page_data + (PAGE_SIZE * page);
-
-		if (set)
-			SetPageReserved(virt_to_page(addr));
-		else
-			ClearPageReserved(virt_to_page(addr));
-	}
-}
-
 static int __init trace_events_user_init(void)
 {
+	struct page pages;
 	int ret;
 
 	/* Zero all bits beside 0 (which is reserved for failures) */
 	bitmap_zero(page_bitmap, MAX_EVENTS);
 	set_bit(0, page_bitmap);
 
-	register_page_data = kzalloc(MAX_EVENTS, GFP_KERNEL);
-
-	if (!register_page_data)
+	pages = alloc_pages(GFP_KERNEL | __GFP_ZERO, MAX_PAGE_ORDER);
+	if (!pages)
 		return -ENOMEM;
-
-	set_page_reservations(true);
+	register_page_data = page_address(pages);
 
 	ret = create_user_tracefs();
 
 	if (ret) {
 		pr_warn("user_events could not register with tracefs\n");
-		set_page_reservations(false);
-		kfree(register_page_data);
+		free_page((unsigned long)register_page_data);
 		return ret;
 	}
 
