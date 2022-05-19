Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5405052D634
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 16:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239844AbiESOfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 10:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbiESOfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 10:35:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DCFC72
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 07:35:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D6AE61968
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:35:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA85C385AA;
        Thu, 19 May 2022 14:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652970942;
        bh=txyDqxHnLr967LUH/PkRPHTEXJ47uC5wTvkjxVnQSyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YROcSI+sNZ2lD7VyG3SQxcEtlM+urfO3Sy+Oyo5MddwkAXLd6jGkUjIqXmxrlP4+4
         nQWN67j022CFu/7Qy/FBZJZTeXejld55xxQKFZqluWjejVbPERCx4nuDqll+0tlXfF
         juHei5Re65xWsw4dgVEB/8yV5Bbh4ZEmvajmhKTY=
Date:   Thu, 19 May 2022 16:35:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        kernel-team@fb.com
Subject: Re: [RFC PATCH] printk: console: Allow each console to have its own
 loglevel
Message-ID: <YoZVvA5FP4wFLSH9@kroah.com>
References: <YoUBh5BSsURDO71Z@chrisdown.name>
 <YoUR6RlzkCNG7BU0@kroah.com>
 <YoVM+KbdyJm8RSSr@chrisdown.name>
 <YoVO23+fvsNPnpKh@kroah.com>
 <YoVWpZKHD7aec0CJ@chrisdown.name>
 <YoXsAkUgzIjJR90W@kroah.com>
 <YoZQQwtG12Ypr2IC@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoZQQwtG12Ypr2IC@chrisdown.name>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 03:12:19PM +0100, Chris Down wrote:
> Greg Kroah-Hartman writes:
> > The two stanzas in my reply do NOT refer to the same thing.
> > 
> > The first one is for the device that is assigned to the class.  That
> > must be freed and properly reference counted and handled as that is a
> > dynamic object that can come and go as people add and remove consoles.
> 
> Ah, I see. So to be clear, this change would fix what you're concerned
> about, right? :-)
> 
> If so I'll do this in v2. Thanks!
> 
> ---
> 
> diff --git include/linux/console.h include/linux/console.h
> index ce5ba405285a..408dd86be8eb 100644
> --- include/linux/console.h
> +++ include/linux/console.h
> @@ -156,12 +156,6 @@ static inline int con_debug_leave(void)
>   */
>  #define CON_LOGLEVEL	(128) /* Level set locally for this console */
> -/*
> - * Console has active class device, so may have active readers/writers from
> - * /sys/class hierarchy.
> - */
> -#define CON_CLASSDEV_ACTIVE	(256)
> -
>  struct console {
>  	char	name[16];
>  	void	(*write)(struct console *, const char *, unsigned);
> @@ -179,9 +173,11 @@ struct console {
>  	void	*data;
>  	struct	 console *next;
>  	int	level;
> -	struct	device classdev;
> +	struct	device *classdev;

Ick, no, keep the real structure here.  It can properly handle the
reference counting for the object.  Just correctly clean up in the
release function, not anywhere else.

thanks,

greg k-h
