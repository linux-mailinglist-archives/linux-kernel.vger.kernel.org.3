Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFAB5A30C5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 23:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345048AbiHZVAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 17:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbiHZVAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 17:00:44 -0400
Received: from mailrelay4-1.pub.mailoutpod1-cph3.one.com (mailrelay4-1.pub.mailoutpod1-cph3.one.com [46.30.210.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826F5E193A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 14:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
         message-id:subject:cc:to:from:date:from;
        bh=myF4XsVKC9nbxvlkJR9K0wlD583A6JFQxHsVq1970Xk=;
        b=TqfYYyvR9dXFmEBf8PbuiJpavrxrig0INxGFgTp+vZbOVyFAtKrATGV+En1p24XkjpOWooS9dt+OE
         jFkvOyEotn1p6QeSVfn13EDzkWeF4YNrcg6VQfhR6fbt5Y7aDD5hHPp7OqkuW5Y2u7teqNO0jQh9V6
         EUqd/qnxsqS2hJYsZ9LUHqCqiSnSRErSFPj+8LQcs9Z7bc5JBkoiuiLrdg/woYW6qZ2Kz9Safk3JrL
         ppKzpavLQ2RzVVwxwS0vUbgYPsIAA93G+2c5lZLrItLOiCXZHVsLgmLQXL/JB7YRFnLTIzy3y+T9RC
         7DNUpSG4XipHD6tGZ9iuYGTLfgo+e4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
         message-id:subject:cc:to:from:date:from;
        bh=myF4XsVKC9nbxvlkJR9K0wlD583A6JFQxHsVq1970Xk=;
        b=3W9l3EbuTKr49ESV+jKgqXjRAOG0JFQkW7ZcDW7d9D4mev1qLo+Jwpku0XELpCML+9Q01VGRtAPmD
         jj0wW+BDQ==
X-HalOne-Cookie: d1f4ea6dcbb9f14bad97218b6c931d32a5291b7c
X-HalOne-ID: 2150669c-2582-11ed-8249-d0431ea8bb10
Received: from mailproxy2.cst.dirpod4-cph3.one.com (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 2150669c-2582-11ed-8249-d0431ea8bb10;
        Fri, 26 Aug 2022 21:00:35 +0000 (UTC)
Date:   Fri, 26 Aug 2022 23:00:34 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Yangxi Xiang <xyangxi5@gmail.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Xuezhi Zhang <zhangxuezhi1@coolpad.com>,
        nick black <dankamongmen@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] tty/vt: Remove printable variable
Message-ID: <Ywk0cq2k7Nhyygyy@ravnborg.org>
References: <20220826202419.198535-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220826202419.198535-1-daniel.vetter@ffwll.ch>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Fri, Aug 26, 2022 at 10:24:19PM +0200, Daniel Vetter wrote:
> Every since the 0.99.7A release when console_register() was introduced
> it's become impossible to call vt_console_print (called
> console_print() back then still) directly. Which means the
> initialization issue this variable protected against is no more.
> 
> Give it a send off with style and let it rest in peace.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
> Cc: nick black <dankamongmen@gmail.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Yangxi Xiang <xyangxi5@gmail.com>
> Cc: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
> ---
>  drivers/tty/vt/vt.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index ae9c926acd6f..4d29e4a17db7 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -157,7 +157,6 @@ static void set_palette(struct vc_data *vc);
>  
>  #define vt_get_kmsg_redirect() vt_kmsg_redirect(-1)
>  
> -static int printable;		/* Is console ready for printing? */
>  int default_utf8 = true;
>  module_param(default_utf8, int, S_IRUGO | S_IWUSR);
>  int global_cursor_default = -1;
> @@ -3085,8 +3084,6 @@ static void vt_console_print(struct console *co, const char *b, unsigned count)
>  	int kmsg_console;
>  
>  	/* console busy or not yet initialized */
> -	if (!printable)
> -		return;
>  	if (!spin_trylock(&printing_lock))
>  		return;

Speaking on locks - it the printing_lock necessary. Or will the caller
serialize the calls to write()?

	Sam

>  
> @@ -3537,7 +3534,6 @@ static int __init con_init(void)
>  	pr_info("Console: %s %s %dx%d\n",
>  		vc->vc_can_do_color ? "colour" : "mono",
>  		display_desc, vc->vc_cols, vc->vc_rows);
> -	printable = 1;
>  
>  	console_unlock();
>  
> -- 
> 2.37.2
