Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284F24C28E0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 11:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbiBXKJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 05:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiBXKJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 05:09:06 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DF3277909
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 02:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1645697316;
  x=1677233316;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sYEoKm7dQb0+rGbVfxkxm4VUPTLb9rvL7TEm6KoFzK4=;
  b=f2qBt1ys7bm6WsxHAvPIV3fDzjmlPHpUqyf7F6H655oDMrEChyqVob7Y
   vWnY+OH7GIrV3Axsb867K2gSBK8Adt7PBLFr7Iwf+GT6LYMmK7tiNuyy3
   MNqiPoVpznDxg6glKvMm9g5IA+ZhHRcv1FnFCI+MQ7tnNduyzM+ByWgA4
   pkPX1CZzUGhZydAtpk/08T5+TVCwFPc+llTrPBd6kty0w2ELLC9baNnb5
   yl60+Hiipg9pV8pcISr4CiNVh3EO4Fug4PmgdAW0X40Jakoo0Gogbh/VB
   wxVygkWdmpoyqhpphOuTnh29N0JqMmN5X4F2JE38lfZYoQu84uaZUAZby
   A==;
Date:   Thu, 24 Feb 2022 11:08:33 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>, kernel <kernel@axis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] char: ttyprintk: register console
Message-ID: <20220224100833.GA3807@axis.com>
References: <20220215141750.92808-1-vincent.whitchurch@axis.com>
 <YhPZeDBlrHjLcgPh@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YhPZeDBlrHjLcgPh@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 07:27:04PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Feb 15, 2022 at 03:17:49PM +0100, Vincent Whitchurch wrote:
> > Register a console in the ttyprintk driver so that it can be selected
> > for /dev/console with console=ttyprintk on the kernel command line,
> > similar to other console drivers.
> > 
> > Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> > ---
> >  drivers/char/Kconfig     |  3 ++-
> >  drivers/char/ttyprintk.c | 16 ++++++++++++++++
> >  2 files changed, 18 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> > index 740811893c57..c553a8a50d03 100644
> > --- a/drivers/char/Kconfig
> > +++ b/drivers/char/Kconfig
> > @@ -18,7 +18,8 @@ config TTY_PRINTK
> >  	  The feature is useful to inline user messages with kernel
> >  	  messages.
> >  	  In order to use this feature, you should output user messages
> > -	  to /dev/ttyprintk or redirect console to this TTY.
> > +	  to /dev/ttyprintk or redirect console to this TTY, or boot
> > +	  the kernel with console=ttyprintk.
> 
> Why do you want to use this tty device as a console?  What benifit
> does that provide?

I run Linux on a secondary processor on my SoC.  This secondary
processor doesn't have any output peripherals of its own, so it uses
pstore to put its kernel messages at a fixed location in memory from
which the primary processor can read them out.

In order to access logs from the secondary processor's userspace, a
simple way is to use ttyprintk.  Userspace logs to the console as normal
and the primary processor can read the unified kernel+userspace logs
from the pstore area.

There are similar uses in other cases not involving multiple processors.
I had mentioned on the lists a couple of years ago that I had this patch
(without posting it), and last week I received a request (off-list) for
it from someone who was looking to use it to debug userspace
initialization in postmarketOS on an Android phone (they only had the
ability to retreive the kernel's logs after a reboot using pstore).
