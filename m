Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6A652D978
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241421AbiESPzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240863AbiESPzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:55:12 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132878FD72
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:55:11 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id r6-20020a1c2b06000000b00396fee5ebc9so2940212wmr.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MMha9YDnPw3mR5pGs4DIuaKROKDxNWOYK4oruaf1i2o=;
        b=RXIoVGnRRoM9d3gTn8wc341hXhMv9hwXRZfxF1qb2cTR4ACvDdEbFwd8oz+hHJVtkQ
         0y+7kmPKRyoC4OtnGaUdI8Z3tTWVDKlt0EA34/NJWF5nsfq8JnxDCsqCOkM38LRpIZia
         6vKegdWf5cZznNpHMf+thRVgt9O/z6Eh7ojrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MMha9YDnPw3mR5pGs4DIuaKROKDxNWOYK4oruaf1i2o=;
        b=PEy6BRevQmfpSkAciBMcgV6agRoF4emXCI64p/brenAFGlOZeSYJKE3McdE9O23owZ
         xMwx3ZQoRiqE6K2Ht7DFdGASJnMy065fC++SlhDd7QHqUeDcRw7xQYO3RYdVQlbTPYxF
         Gwy5yhwf8Xf0nPDp+C6g+EwnFhULRNe+JcAf8CW3xvaepigwO9fl0QqS5X9y0D9CkdAx
         gOfqox0w7pFmSj/7aCLWLGrq0oif34LHFt1pMiWKfxZWp7wx6qFn3Pih4oaJCKs4EwYv
         lQPAmS/WpRzZ+4DkBxEIMHmm4zeeGJxTSjh7ZhHwD4Nbg5Qg/MUIuQGgnIB4DX72gcLM
         ktWg==
X-Gm-Message-State: AOAM531rv/Wx1AtVkO4x/8IXAaUFMARNkrZ2+6ZivCw/UfhK0nIiWz9J
        xQ1rICwq7ijhcjtiHr5vgeffRw==
X-Google-Smtp-Source: ABdhPJw2twP4tVYT+HDNN5G98VVhs/tOGgHZmJJcdMZBH6LvBL4bQUGyjm6+zd3KHU5PJUjsMH4hFg==
X-Received: by 2002:a7b:c114:0:b0:394:47d3:693f with SMTP id w20-20020a7bc114000000b0039447d3693fmr5145198wmi.42.1652975709442;
        Thu, 19 May 2022 08:55:09 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::4:c1eb])
        by smtp.gmail.com with ESMTPSA id s22-20020a1cf216000000b00397369667e6sm171569wmc.39.2022.05.19.08.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 08:55:08 -0700 (PDT)
Date:   Thu, 19 May 2022 16:55:08 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        kernel-team@fb.com
Subject: Re: [RFC PATCH] printk: console: Allow each console to have its own
 loglevel
Message-ID: <YoZoXOghSuCy9Bi+@chrisdown.name>
References: <YoUBh5BSsURDO71Z@chrisdown.name>
 <YoUR6RlzkCNG7BU0@kroah.com>
 <YoVM+KbdyJm8RSSr@chrisdown.name>
 <YoVO23+fvsNPnpKh@kroah.com>
 <YoVWpZKHD7aec0CJ@chrisdown.name>
 <YoXsAkUgzIjJR90W@kroah.com>
 <YoZQQwtG12Ypr2IC@chrisdown.name>
 <YoZVvA5FP4wFLSH9@kroah.com>
 <YoZdVCfK4T8Ts2oS@chrisdown.name>
 <YoZhXe9CZE5o73fG@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YoZhXe9CZE5o73fG@kroah.com>
User-Agent: Mutt/2.2.4 (c3baa83e) (2022-04-30)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman writes:
>On Thu, May 19, 2022 at 04:08:04PM +0100, Chris Down wrote:
>> Greg Kroah-Hartman writes:
>> > >  struct console {
>> > >  	char	name[16];
>> > >  	void	(*write)(struct console *, const char *, unsigned);
>> > > @@ -179,9 +173,11 @@ struct console {
>> > >  	void	*data;
>> > >  	struct	 console *next;
>> > >  	int	level;
>> > > -	struct	device classdev;
>> > > +	struct	device *classdev;
>> >
>> > Ick, no, keep the real structure here.  It can properly handle the
>> > reference counting for the object.  Just correctly clean up in the
>> > release function, not anywhere else.
>>
>> Sorry, I'm getting more and more confused about what you're asking me to do,
>> and less and less clear on the rationale.
>>
>> Can you please clarify what "correctly cleaning up" would mean for a
>> non-pointer `struct device'?
>>
>> Is your concern that...
>>
>>     register_console(c)
>>         device_initialize(c->d)
>>         device_add(c->d)
>>     unregister_console(c)
>>         device_unregister(c->d)      console_classdev_release(c->d)
>>     register_console(c)
>>         device_initialize(c->d)  <-- classdev was not previously zeroed out
>> 				     in console_classdev_release() and bad 				     things may happen
>
>Note, you can not "recycle" a structure in the driver model.  So when
>the console is unregistered, it should be freed.  When it is registered,
>it should be created.  Perhaps that is the confusion here?

I suspect you're close to the source of the confusion. So your point is that 
the `struct console' should be freed when the driver refcount drops to 0 rather 
than trying to do it the other way around. Right?

So, just to try to come to a solution, here's the lay of the land as I 
understand it. Currently pretty much all consoles are statically defined (and 
most of the non-static cases are false positives)

     % git grep 'struct console.*=' -- '*.c' | awk '/static/ { print "static"; } !/static/ { print "non-static" }' | sort | uniq -c
          15 non-static
         105 static

These consoles are defined statically largely because they may come up early 
enough that we don't yet have the kmalloc() infrastructure ready.

One might then think we could have these early consoles use memblock_alloc(), 
but there is a problem. memblock_alloc_try_nid() inside memblock_alloc() is 
__init, so while we can still use the memory later, we can't call 
memblock_alloc() after __init data is freed up.

This is a problem because some consoles decide if they are early or not at 
runtime, not compile time:

     % git grep -E -- '->(write|read) = .*early' | wc -l
     40

So depending on runtime configuration, those consoles may either be too early 
to allocate with kmalloc(), or too late to allocate with memblock_alloc().

This and other reasons are why I am really trying to avoid changing the way 
that the `struct console' lifecycle works -- it's already extremely complex, 
and the chance of breaking something is very high, which is made even worse by 
the fact that one can only test on a very small subset of available hardware.

Maybe a driver is not the best thing to use here to expose things in sysfs? Is 
there something else you would recommend?

Thanks again for all your help and advice. :-)
