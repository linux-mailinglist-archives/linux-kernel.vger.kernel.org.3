Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24C54843A6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbiADOqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:46:31 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40826 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiADOqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:46:30 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5FA55212B8;
        Tue,  4 Jan 2022 14:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641307589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yTzDVTn5ksZWOrdG92R8By21jPJ8PhpzB9LehHRf0hg=;
        b=F6GEaiAuA/eqxm+utrQIOuIRWGkiGFkBVUdQXCcsW7IwV3GnuW9gkl4gP4frvmRp6zrMZu
        +z5JGg2JmxQszlyAr/C2HAaQ+MtsaUMPrn2AuBOdVSvXxKHsm44yYtqmmOcf6ub7B2wbU5
        tfjVeoAZm6tvPN74l0lF/Zk+SU0Ifio=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0800DA3B89;
        Tue,  4 Jan 2022 14:46:29 +0000 (UTC)
Date:   Tue, 4 Jan 2022 15:45:24 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: header circular dependencies
Message-ID: <YdRdhE9z+Yyxwrhj@alley>
References: <CAHp75Vdjp9_67xe0PeZ9LzcJ=eNxB0qVqPJqtFEvh3SDgcdODw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vdjp9_67xe0PeZ9LzcJ=eNxB0qVqPJqtFEvh3SDgcdODw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-12-22 21:08:39, Andy Shevchenko wrote:
> `make headerdep` is full of printk.h circular dependencies, like
> 
> include/kvm/arm_vgic.h:18: warning: recursive header inclusion
> In file included from linux/printk.h,
>                 from linux/dynamic_debug.h:188
>                 from linux/printk.h:555 <-- here

This one looks like false positive:

   + printk.h includes dynamic_debug.h when CONFIG_DYNAMIC_DEBUG_CORE
   + dynamic_debug.h includes printk.h when !CONFIG_DYNAMIC_DEBUG_CORE

But there seem to be other cycles, for example:

   + printk.h
     + dynamic_debug.h
       + jump_label.h
	 + bug.h
	   + asm/bug.h
	     + printk.h

I guess that it somehow works _only_ because printk.h includes
dynamic_debug.h late. It probably defines everything that is needed
by bug.h early enough.

> I'm wondering if it's a false positive?
> In either case, can we teach the headerdep not to complain by fixing
> the culprit?

I am scratching my head how to clean this up. All the dependencies
make sense. The main problem is that all headers provide a lot of
inlined functionality. The inlining is often important either because
of speed or because every caller needs to have its own data structure
(struct _ddebug, struct static_key).

I can't find any good solution at the moment. But I am still slowed
down after the holidays.

Best Regards,
Petr
