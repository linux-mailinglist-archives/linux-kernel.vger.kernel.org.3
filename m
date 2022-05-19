Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D81F52DB9E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243001AbiESRpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240091AbiESRpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:45:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3341A5012
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:45:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB10CB8276B
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:45:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20601C385AA;
        Thu, 19 May 2022 17:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652982331;
        bh=XTqlTDp8vpzw/d57Gk8js0SUxWL/JNoh0jjWesaOhhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iJWmZerXyVB+ZXw70rsMHe+AOM4sC3xMYx2HodoCNnUVPYpzjyCQ1yiqWPbP4adW5
         katOidFEtGfejhIz8Vvy7F/6kgSbBomwmb7TKxb6fGWg7m0/csITw7UkKagWHlDuVo
         pLRE+whzhcFyEebRO5jCgzSx5oMSJ1O/zVLn/eus=
Date:   Thu, 19 May 2022 19:45:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        kernel-team@fb.com
Subject: Re: [RFC PATCH] printk: console: Allow each console to have its own
 loglevel
Message-ID: <YoaCN+OH6cG0p1CN@kroah.com>
References: <YoUR6RlzkCNG7BU0@kroah.com>
 <YoVM+KbdyJm8RSSr@chrisdown.name>
 <YoVO23+fvsNPnpKh@kroah.com>
 <YoVWpZKHD7aec0CJ@chrisdown.name>
 <YoXsAkUgzIjJR90W@kroah.com>
 <YoZQQwtG12Ypr2IC@chrisdown.name>
 <YoZVvA5FP4wFLSH9@kroah.com>
 <YoZdVCfK4T8Ts2oS@chrisdown.name>
 <YoZhXe9CZE5o73fG@kroah.com>
 <YoZoXOghSuCy9Bi+@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoZoXOghSuCy9Bi+@chrisdown.name>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 04:55:08PM +0100, Chris Down wrote:
> Greg Kroah-Hartman writes:
> > On Thu, May 19, 2022 at 04:08:04PM +0100, Chris Down wrote:
> > > Greg Kroah-Hartman writes:
> > > > >  struct console {
> > > > >  	char	name[16];
> > > > >  	void	(*write)(struct console *, const char *, unsigned);
> > > > > @@ -179,9 +173,11 @@ struct console {
> > > > >  	void	*data;
> > > > >  	struct	 console *next;
> > > > >  	int	level;
> > > > > -	struct	device classdev;
> > > > > +	struct	device *classdev;
> > > >
> > > > Ick, no, keep the real structure here.  It can properly handle the
> > > > reference counting for the object.  Just correctly clean up in the
> > > > release function, not anywhere else.
> > > 
> > > Sorry, I'm getting more and more confused about what you're asking me to do,
> > > and less and less clear on the rationale.
> > > 
> > > Can you please clarify what "correctly cleaning up" would mean for a
> > > non-pointer `struct device'?
> > > 
> > > Is your concern that...
> > > 
> > >     register_console(c)
> > >         device_initialize(c->d)
> > >         device_add(c->d)
> > >     unregister_console(c)
> > >         device_unregister(c->d)      console_classdev_release(c->d)
> > >     register_console(c)
> > >         device_initialize(c->d)  <-- classdev was not previously zeroed out
> > > 				     in console_classdev_release() and bad 				     things may happen
> > 
> > Note, you can not "recycle" a structure in the driver model.  So when
> > the console is unregistered, it should be freed.  When it is registered,
> > it should be created.  Perhaps that is the confusion here?
> 
> I suspect you're close to the source of the confusion. So your point is that
> the `struct console' should be freed when the driver refcount drops to 0
> rather than trying to do it the other way around. Right?

When the "device" refcount, not driver.  refcounts are for data.

> So, just to try to come to a solution, here's the lay of the land as I
> understand it. Currently pretty much all consoles are statically defined
> (and most of the non-static cases are false positives)
> 
>     % git grep 'struct console.*=' -- '*.c' | awk '/static/ { print "static"; } !/static/ { print "non-static" }' | sort | uniq -c
>          15 non-static
>         105 static

ah, ok, then we have a problem, and your change to the struct device
being a pointer is correct.

That's the problem when you only see a tiny bit of the kernel in a
patch, sorry for the confusion.

But you still need to free the device structure that is pointed to by
the device in the release function.  Your release function can not be
"empty" like your original patch was.

thanks,

greg k-h
