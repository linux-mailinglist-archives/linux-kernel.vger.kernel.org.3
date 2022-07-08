Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA8C56BA4E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 15:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237952AbiGHNHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 09:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiGHNHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 09:07:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56E99FC3;
        Fri,  8 Jul 2022 06:07:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E52A62767;
        Fri,  8 Jul 2022 13:07:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B00FC341C0;
        Fri,  8 Jul 2022 13:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657285666;
        bh=pT5D8o52SniTggmD0JZqqPMw3dK/JQIRcP3v2sSX7vE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MVgM8EK8oqx9dvUTokujHZ3JI8Y0z+tU2UGKxuu2mm3ChKKQIf7Q2WwWTZUg9MFRo
         8DlbTsKzqZvbtcOzGVYjidg7TApgxq+hP6Zk3Lz+Rq6XrW2EBIynX4R33BUXmW1Hcz
         eMYWE6+AqfeztGsrIJbucdz6Vyye5+7n9aZnNGpU=
Date:   Fri, 8 Jul 2022 15:07:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] serial: Fix support for UPF_SPD_* flags
Message-ID: <YsgsH94PV/wAX0Vu@kroah.com>
References: <20220321163055.4058-1-pali@kernel.org>
 <CAHp75VddDG-ZJpbAb5ZhKaMpP0L+CMEx2pcYy3FOMiaxNydCWA@mail.gmail.com>
 <YmK7drS0XgnTQcaf@kroah.com>
 <20220707084840.jvsstvyx2ul5ltb6@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220707084840.jvsstvyx2ul5ltb6@pali>
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 10:48:40AM +0200, Pali Rohár wrote:
> On Friday 22 April 2022 16:28:06 Greg Kroah-Hartman wrote:
> > On Tue, Mar 22, 2022 at 04:29:08PM +0200, Andy Shevchenko wrote:
> > > On Mon, Mar 21, 2022 at 11:07 PM Pali Rohár <pali@kernel.org> wrote:
> > > >
> > > > Support for UPF_SPD_* flags is currently broken in more drivers for two
> > > > reasons. First one is that uart_update_timeout() function does not
> > > 
> > > the uart_update_timeout()
> > > 
> > > > calculate timeout for UPF_SPD_CUST flag correctly. Second reason is that
> > > > userspace termios structre is modified by most drivers after each
> > > 
> > > structure
> > > 
> > > ...
> > > 
> > > > (error handling was ommited for simplification)
> > > 
> > > omitted
> > > 
> > > > After calling set_active_spd_cust_baud() function SPD custom divisor
> > > > should be active and therefore is_spd_cust_active() should return true.
> > > >
> > > > But it is not active (cfgetospeed does not return B38400) and this patch
> > > > series should fix it. I have tested it with 8250 driver.
> > > 
> > > drivers
> > > 
> > > > Originally Johan Hovold reported that there may be issue with these
> > > > ASYNC_SPD_FLAGS in email:
> > > > https://lore.kernel.org/linux-serial/20211007133146.28949-1-johan@kernel.org/
> > > >
> > > >
> > > > Johan, Greg, could you please test these patches if there is not any
> > > > regression?
> > > 
> > > I'm wondering why we are still supporting this ugly hack?
> > > Doesn't BOTHER work for you?
> > 
> > Yes, I too do not want to add more support for these old flags.  If they
> > have not been working, let's not add support for them as obviously no
> > one is using them.  Let's try to remove them if at all possible.
> 
> Well, it works partially. For more drivers SET method is working, but
> GET method returns incorrect value. If your userspace application is
> written in a way that does not retrieve from kernel current settings
> then it has big probability that application works.

I do not understand, sorry, what do you mean by this?

And as you are responding to a months-old thread, I am totally lost, and
don't even know what the patch here was...

> So, do you really want to remove support for these old flags completely?
> That would of course break above applications.

I'm not saying remove them, I'm saying let us not add any more
dependancies on them in order to keep new applications from ever wanting
to use them.

> Note that usage of BOTHER is problematic and in most cases highly
> impossible if you are using glibc libc.so. BOTHER is incompatible with
> glibc header files and so you can either include BOTHER/linux termios
> file (exclusive) OR glibc header files.

I thought that was all fixed up in newer versions of glibc.  Is that
really still the case in the latest release?

> New version of tcsetattr and ioctl_tty manpages would have documented
> how to use BOTHER (it is currently in the manpages git).
> 
> Currently the only known option how to use BOTHER is to completely
> reimplement all functions from "termios.h", provide custom "termios.h"
> header file (and not use glibc termios.h nor any file which it includes)
> and statically link this reimplementation into final application.
> 
> So in most cases BOTHER is not alternative to those old SPD flags even
> for modern applications.

Using the kernel's .h file should be easy enough here for them, right?
And again, I thought glibc was fixed, what about other libc versions?

thanks,

greg k-h
