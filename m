Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C535540A9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 04:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356114AbiFVCzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 22:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbiFVCzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 22:55:44 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081D130553
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 19:55:43 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id a14so5254527pgh.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 19:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g7aEioHOe4RTziENKn4LVSUP9Ea8R5L7LmD6aP+D5QY=;
        b=P8llVYlEeJiQRMFjXw6lIHkIN/7A4vJ/tYv2FhbqF6kUOHHzqdzsMb4ySKxX8fE66L
         ygxEbmniWyFrqaX2/SIMyIaTOtv9cbqBvL+lhHkPuGgRRSQBgU5n7j/0lnbovFKkdajS
         jmlm/UVTCLdlmnRtnN4xmOMwfug3apLxP6DRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g7aEioHOe4RTziENKn4LVSUP9Ea8R5L7LmD6aP+D5QY=;
        b=6BnaKHDoEPmzc9FqHdGGXCeKHyEpH1zMZCpKyLa1NHAKypcGernK+PkhXatsMV1r/3
         Dhl76d21lb+x8swCmaagTmV1zw7M5oW/qe+8Utblir/2eyW14Vrm+JLVCCSxtf3SwInN
         XzakXCWu7NyzdSX4vji8CIqQMCTN4TaFYismEKRGhz6SgvSMoTjbV3KY2epANWulQrr2
         PY+9TNRAwHVYiBgKrT4rd9GjULiGXCOQ2mvy0cc3jOESD6e7B41DOZ5qro+qZQgaIjT6
         EozcQ58M6E/9Yql6lTBx0AiIJuaOwcVEm1/IAjP11EYlznpjBak/DZGYfNYXgbjLinfG
         WJaA==
X-Gm-Message-State: AJIora8RcbE53LS/5oByqHtXUVAmeFwk3U7ol/x5kPFtD8aeR6jkVzcB
        Aq6b80a6jFtUnmFKCMww6Jo43Q==
X-Google-Smtp-Source: AGRyM1u8o8LTlmvz26T5UlhrMVM7IrAMnwPmoLT6tcVRWwOUjUuwDi2LoiPEZ/cP9nIaj2YQnS11QQ==
X-Received: by 2002:a63:7844:0:b0:40c:9792:5d6d with SMTP id t65-20020a637844000000b0040c97925d6dmr1021389pgc.360.1655866542512;
        Tue, 21 Jun 2022 19:55:42 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:1922:709:82a7:e4d3])
        by smtp.gmail.com with ESMTPSA id d20-20020a056a00199400b0050dc762815asm12668503pfl.52.2022.06.21.19.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 19:55:41 -0700 (PDT)
Date:   Wed, 22 Jun 2022 11:55:36 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] printk/console: Enable console kthreads only when
 there is no boot console left
Message-ID: <YrKEqB4cwFKizjCL@google.com>
References: <20220621090900.GB7891@pathway.suse.cz>
 <YrGMYk0LsbKewzPU@google.com>
 <20220621111919.GD7891@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621111919.GD7891@pathway.suse.cz>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/06/21 13:19), Petr Mladek wrote:
> > > -static int __init printk_activate_kthreads(void)
> > > -{
> > > -	struct console *con;
> > >  
> > > -	console_lock();
> > > -	printk_kthreads_available = true;
> > > -	for_each_console(con)
> > > -		printk_start_kthread(con);
> > > -	console_unlock();
> > > +	/*
> > > +	 * Boot consoles may be accessing the same hardware as normal
> > > +	 * consoles and thus must not be called in parallel. Therefore
> > > +	 * only activate threaded console printing if it is known that
> > > +	 * there are no boot consoles registered.
> > > +	 */
> > > +	if (no_bootcon)
> > > +		printk_activate_kthreads();
> > 
> > A quick question. Here we still can have bootcon which can unregistered
> > later, right? Do you think it'll make sense to check if printing kthreads
> > can be safely started and start them if so (if no CON_BOOT found and kthreads
> > are not already created) at the end of unregister_console()?
> 
> Yeah, that's my plan how to optimize it in the future. I just
> wanted to do something simple and be on the safe side for 5.19.

Sounds good.
