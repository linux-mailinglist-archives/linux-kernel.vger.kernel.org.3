Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4D54D6B23
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiCKX4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 18:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiCKX4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 18:56:37 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 225EFD81;
        Fri, 11 Mar 2022 15:55:33 -0800 (PST)
Received: from kbox (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id AEEBD20B7178;
        Fri, 11 Mar 2022 15:55:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AEEBD20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1647042932;
        bh=6ZrDSYmvOkJ2v9dCqiXvjF1J0+mtHZ+4Ek2KC4gi76A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LmGw75nB1upmYXQfSTaJS2g/obC5mRoX6+8DlI2WGujX4olHKXtaqL5YU5rcfXCb7
         O8UTDNYG9RoZvKlIPyV9w8wVAseYw/UDgPGdKgyCDIAD4NYWGbwVNHhw7c36XkFWaw
         iKyuvTGGv/gyxPlSg57S4R2uQtYB4EWFx+arVAuI=
Date:   Fri, 11 Mar 2022 15:55:30 -0800
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, anders.roxell@linaro.org,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: Re: [PATCH] user_events: Use alloc_pages instead of kzalloc for
 register pages
Message-ID: <20220311235530.GB2101@kbox>
References: <20220311223028.1865-1-beaub@linux.microsoft.com>
 <20220311183343.4d8c94a5@gandalf.local.home>
 <20220311184440.537e9f83@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311184440.537e9f83@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 06:44:40PM -0500, Steven Rostedt wrote:
> On Fri, 11 Mar 2022 18:33:43 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > I tried it slightly differently. Why waist bits if MAX_EVENTS is greater
> > than the order. That is, make MAX_EVENTS depend on the order, not the other
> > way around.
> 
> Here's a version that keeps the reserving part as well as some bug fixes (I
> didn't even compile the previous version ;-)
> 
> -- Steve
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

This looks good to me, I agree having the max events aligning to page
order makes more sense going forward.

Thanks,
-Beau
