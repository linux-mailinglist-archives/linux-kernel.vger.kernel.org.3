Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503C352D77B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240948AbiESP0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241000AbiESP0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:26:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D949F33E0E
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:26:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99A0CB824E6
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 15:26:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9ABC385AA;
        Thu, 19 May 2022 15:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652973968;
        bh=sjj+mlnWDG2Xdrw+/4hBO5MRvw9CHxqz/fuaCtwbXyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i/dsq4N7kRmTcuUlDgj7DS/wfYh6C7TjvTKmCbKHG6YD9WsbuAU6HpAFkhwqXRw+0
         ekPV/lqa+IabiiJgCl644gN/Th+kgSwQvTpnGW0qbx9iudnK0gepFqiGL2iay4iuBD
         vVt2ZdqLONtp01j+zY4isC4gn9Pi/OEG6YHcBrr8=
Date:   Thu, 19 May 2022 17:25:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        kernel-team@fb.com
Subject: Re: [RFC PATCH] printk: console: Allow each console to have its own
 loglevel
Message-ID: <YoZhXe9CZE5o73fG@kroah.com>
References: <YoUBh5BSsURDO71Z@chrisdown.name>
 <YoUR6RlzkCNG7BU0@kroah.com>
 <YoVM+KbdyJm8RSSr@chrisdown.name>
 <YoVO23+fvsNPnpKh@kroah.com>
 <YoVWpZKHD7aec0CJ@chrisdown.name>
 <YoXsAkUgzIjJR90W@kroah.com>
 <YoZQQwtG12Ypr2IC@chrisdown.name>
 <YoZVvA5FP4wFLSH9@kroah.com>
 <YoZdVCfK4T8Ts2oS@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoZdVCfK4T8Ts2oS@chrisdown.name>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 04:08:04PM +0100, Chris Down wrote:
> Greg Kroah-Hartman writes:
> > >  struct console {
> > >  	char	name[16];
> > >  	void	(*write)(struct console *, const char *, unsigned);
> > > @@ -179,9 +173,11 @@ struct console {
> > >  	void	*data;
> > >  	struct	 console *next;
> > >  	int	level;
> > > -	struct	device classdev;
> > > +	struct	device *classdev;
> > 
> > Ick, no, keep the real structure here.  It can properly handle the
> > reference counting for the object.  Just correctly clean up in the
> > release function, not anywhere else.
> 
> Sorry, I'm getting more and more confused about what you're asking me to do,
> and less and less clear on the rationale.
> 
> Can you please clarify what "correctly cleaning up" would mean for a
> non-pointer `struct device'?
> 
> Is your concern that...
> 
>     register_console(c)
>         device_initialize(c->d)
>         device_add(c->d)
>     unregister_console(c)
>         device_unregister(c->d)      console_classdev_release(c->d)
>     register_console(c)
>         device_initialize(c->d)  <-- classdev was not previously zeroed out
> 				     in console_classdev_release() and bad 				     things may happen

Note, you can not "recycle" a structure in the driver model.  So when
the console is unregistered, it should be freed.  When it is registered,
it should be created.  Perhaps that is the confusion here?

thakns,

greg k-h
