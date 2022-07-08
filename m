Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3354056BA9C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 15:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237866AbiGHN02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 09:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiGHN00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 09:26:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5802BB16;
        Fri,  8 Jul 2022 06:26:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A7746278F;
        Fri,  8 Jul 2022 13:26:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95466C341C0;
        Fri,  8 Jul 2022 13:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657286785;
        bh=YeK2rKgYFw9Z5YIp50Bq4SLxx44Pw1F77wqhyYgPROk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dxi1rh6EyOB3L6/haaLSSSigqOR9JTRr6G70kpzktPFZiEaVhlJGkSQ5e7qA+O/8a
         +sxayvKXskGqMp/h4GVJFpXrUwPwx3+AHqrdZjDLiOJyXhNoOMiyjlwrRns8CGbNFI
         /kcs0rmAsjL6dV2N7+nsRpDPIru+SySEhnnQ7+TrA9CjwxIq/eu500MXmc/Km0o5tR
         dfZqvFXG8Yo6DvR6588IrjAenFnztf6Yh2HArLlxExS71gqVX7iuBwWWcngxwZkxj6
         jYPvIPLZqHiSYMvUd1LS7gyCyLAtv/suL1mFnRETaaj+zWWEL618664p/bCubkusLK
         0W9yzEQMI9taA==
Received: by pali.im (Postfix)
        id 592A87D1; Fri,  8 Jul 2022 15:26:21 +0200 (CEST)
Date:   Fri, 8 Jul 2022 15:26:21 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] serial: Fix support for UPF_SPD_* flags
Message-ID: <20220708132621.4v2es73h52aq3izn@pali>
References: <20220321163055.4058-1-pali@kernel.org>
 <CAHp75VddDG-ZJpbAb5ZhKaMpP0L+CMEx2pcYy3FOMiaxNydCWA@mail.gmail.com>
 <YmK7drS0XgnTQcaf@kroah.com>
 <20220707084840.jvsstvyx2ul5ltb6@pali>
 <YsgsH94PV/wAX0Vu@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YsgsH94PV/wAX0Vu@kroah.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 July 2022 15:07:43 Greg Kroah-Hartman wrote:
> On Thu, Jul 07, 2022 at 10:48:40AM +0200, Pali Rohár wrote:
> > On Friday 22 April 2022 16:28:06 Greg Kroah-Hartman wrote:
> > > On Tue, Mar 22, 2022 at 04:29:08PM +0200, Andy Shevchenko wrote:
> > > > On Mon, Mar 21, 2022 at 11:07 PM Pali Rohár <pali@kernel.org> wrote:
> > > > >
> > > > > Support for UPF_SPD_* flags is currently broken in more drivers for two
> > > > > reasons. First one is that uart_update_timeout() function does not
> > > > 
> > > > the uart_update_timeout()
> > > > 
> > > > > calculate timeout for UPF_SPD_CUST flag correctly. Second reason is that
> > > > > userspace termios structre is modified by most drivers after each
> > > > 
> > > > structure
> > > > 
> > > > ...
> > > > 
> > > > > (error handling was ommited for simplification)
> > > > 
> > > > omitted
> > > > 
> > > > > After calling set_active_spd_cust_baud() function SPD custom divisor
> > > > > should be active and therefore is_spd_cust_active() should return true.
> > > > >
> > > > > But it is not active (cfgetospeed does not return B38400) and this patch
> > > > > series should fix it. I have tested it with 8250 driver.
> > > > 
> > > > drivers
> > > > 
> > > > > Originally Johan Hovold reported that there may be issue with these
> > > > > ASYNC_SPD_FLAGS in email:
> > > > > https://lore.kernel.org/linux-serial/20211007133146.28949-1-johan@kernel.org/
> > > > >
> > > > >
> > > > > Johan, Greg, could you please test these patches if there is not any
> > > > > regression?
> > > > 
> > > > I'm wondering why we are still supporting this ugly hack?
> > > > Doesn't BOTHER work for you?
> > > 
> > > Yes, I too do not want to add more support for these old flags.  If they
> > > have not been working, let's not add support for them as obviously no
> > > one is using them.  Let's try to remove them if at all possible.
> > 
> > Well, it works partially. For more drivers SET method is working, but
> > GET method returns incorrect value. If your userspace application is
> > written in a way that does not retrieve from kernel current settings
> > then it has big probability that application works.
> 
> I do not understand, sorry, what do you mean by this?

I mean that SET methods are working, GET methods not. In this case SET
done via ioctl(TIOCSSERIAL) and GET via ioctl(TIOCGSERIAL).

> And as you are responding to a months-old thread, I am totally lost, and
> don't even know what the patch here was...
> 
> > So, do you really want to remove support for these old flags completely?
> > That would of course break above applications.
> 
> I'm not saying remove them, I'm saying let us not add any more
> dependancies on them in order to keep new applications from ever wanting
> to use them.

Last time you wrote to remove them. Now saying not to remove them. So I
do not understand you now.

> > Note that usage of BOTHER is problematic and in most cases highly
> > impossible if you are using glibc libc.so. BOTHER is incompatible with
> > glibc header files and so you can either include BOTHER/linux termios
> > file (exclusive) OR glibc header files.
> 
> I thought that was all fixed up in newer versions of glibc.  Is that
> really still the case in the latest release?

In which version you though that it was fixed? Last time when I checked
it (half year ago) all these issues were there still present. Now I
briefly grepped glib git source code and seems that nothing was changed,
no support for BOTHER and neither ABI changes. I also looked into
changelong of last 3 released glibc versions there is neither no
information about it.

> > New version of tcsetattr and ioctl_tty manpages would have documented
> > how to use BOTHER (it is currently in the manpages git).
> > 
> > Currently the only known option how to use BOTHER is to completely
> > reimplement all functions from "termios.h", provide custom "termios.h"
> > header file (and not use glibc termios.h nor any file which it includes)
> > and statically link this reimplementation into final application.
> > 
> > So in most cases BOTHER is not alternative to those old SPD flags even
> > for modern applications.
> 
> Using the kernel's .h file should be easy enough here for them, right?

No. Because structures and defines conflicts with glibc structures and
defines. That is why (ABI incompatible) reimplementation is needed.

> And again, I thought glibc was fixed, what about other libc versions?

musl does not support BOTHER too. And I do not know other libc versions
which are used in production.

> thanks,
> 
> greg k-h
