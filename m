Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFF7552294
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 19:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240403AbiFTRDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 13:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbiFTRDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 13:03:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0341AD80
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 10:03:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78A5DB8125D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 17:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887B4C341C0;
        Mon, 20 Jun 2022 17:03:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="iBl6qL48"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1655744614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3hmn2g7HssnowGYTCBHg5UazGqFl6XEtNk9RGqjljOY=;
        b=iBl6qL48gai29R/Upy/GadStJLdo2n8b68QzuvIjcWOrEkTX+pmfEE3xkgJ0pCP2q33nvP
        YezeEIrOtpIjOugct4RgTEIYcExEZKjucEwCLnRk9YpzROVvAZHWIOtQe8aRHCw/i6PkBQ
        UrZtUTRiAWTnPAv+ArfGRdOJ3gbaQx0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 613e7a06 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 20 Jun 2022 17:03:33 +0000 (UTC)
Date:   Mon, 20 Jun 2022 19:03:30 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3] printk: allow direct console printing to be enabled
 always
Message-ID: <YrCoYrZy63rPJbEF@zx2c4.com>
References: <Yq+xGcBO06ILMUFy@zx2c4.com>
 <20220619233302.601092-1-Jason@zx2c4.com>
 <YrCnJTIB/7MexV3K@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YrCnJTIB/7MexV3K@alley>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On Mon, Jun 20, 2022 at 06:58:13PM +0200, Petr Mladek wrote:
> On Mon 2022-06-20 01:33:02, Jason A. Donenfeld wrote:
> > In 5.19, there are some changes in printk message ordering /
> > interleaving which leads to confusion. The most obvious (and benign)
> > example appears on system boot, in which the "Run /init as init process"
> > message gets intermixed with the messages that init actually writes() to
> > stdout. For example, here's a snippet from build.wireguard.com:
> > 
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -35,6 +35,18 @@ config PRINTK_CALLER
> >  	  no option to enable/disable at the kernel command line parameter or
> >  	  sysfs interface.
> >  
> > +config PRINTK_DIRECT
> > +	bool "Attempt to flush printk output immediately"
> > +	depends on PRINTK
> > +	help
> > +	  Rather than using kthreads for printk output, always attempt to write
> > +	  to the console immediately. This has performance implications, but
> > +	  will result in a more faithful ordering and interleaving with other
> > +	  processes writing to the console.
> > +
> > +	  Say N here unless you really need this. This may also be controlled
> > +	  at boot time with printk.direct=0/1.
> > +
> 
> I am fine with the patch except for the config option. Is there
> any particular reason why we need it, please?

It's a debug option that I'd like to be able to easily build my CI
kernels with, just like various other debug options.

Jason

> We should be careful to add new build options in general because they
> make building the kernel more complicated. People need to understand
> what each option is about and what they want.

This one doesn't, really. It'd hidden away in the debug menu.

Jason
