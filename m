Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4A248D3AD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 09:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiAMIfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 03:35:25 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:54398 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiAMIfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 03:35:24 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id ED85D1F3A3;
        Thu, 13 Jan 2022 08:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642062922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3+acst920SK3qzTnoBwJe+3mbyuBsbHiwAYWkKKVkus=;
        b=ttyrgBrp0/sdEzOUgEVjmF1MyTAiniGDsD7Yv4z2jMNv28rD2ZDHN7v3Guc5QAQNBaN5qV
        BFdaZy56mQt5YSGsGsCJsXruAUUKbZAcxCFco7wAiSY2MN+fW+OpUPWk27lZwje60S6FJu
        PxVR2tZtC8qJy+R+OzLkw7ZRuRCg/0Y=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 736C0A3B85;
        Thu, 13 Jan 2022 08:35:22 +0000 (UTC)
Date:   Thu, 13 Jan 2022 09:35:21 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     jim.cromie@gmail.com
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Chris Down <chris@chrisdown.name>,
        Marc Zyngier <maz@kernel.org>,
        Andrew Scull <ascull@google.com>,
        Will Deacon <will@kernel.org>, Jason Baron <jbaron@akamai.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [RFC 1/2] printk/dynamic_debug: Remove cyclic dependency between
 printk.h and dynamic_debug.h
Message-ID: <Yd/kSVaFyn2/huaf@alley>
References: <20220111143046.14680-1-pmladek@suse.com>
 <20220111143046.14680-2-pmladek@suse.com>
 <996a7cf5-b047-5038-c86b-f10820364465@rasmusvillemoes.dk>
 <Yd7Fq6V1/Ynff6Qx@alley>
 <CAJfuBxzKZYBf_CGzHGjL_Jn2M=x_NH_j89kFX2UGxr8Sr4=fVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfuBxzKZYBf_CGzHGjL_Jn2M=x_NH_j89kFX2UGxr8Sr4=fVw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-01-12 20:38:57, jim.cromie@gmail.com wrote:
> On Wed, Jan 12, 2022 at 5:12 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Tue 2022-01-11 17:01:35, Rasmus Villemoes wrote:
> > > On 11/01/2022 15.30, Petr Mladek wrote:
> 
> 
> > > >  static inline int dynamic_debug_exec_queries(const char *query, const char *modname)
> > > >  {
> > > > -   pr_warn("kernel not built with CONFIG_DYNAMIC_DEBUG_CORE\n");
> > > > +   /* Use raw _printk() to avoid cyclic dependency. */
> > > > +   _printk(KERN_WARNING "kernel not built with CONFIG_DYNAMIC_DEBUG_CORE\n");
> > > >     return 0;
> > > >  }
> > >
> > > And for this one I think the solution is even simpler, as I can't find
> > > any in-tree callers. Perhaps just nuke it entirely?
> >
> > Adding Jim into Cc whether he still has any plans to use this API.
> >
> > Best Regards,
> > Petr
> 
> This EXPORT can go.

Does it mean that the entire function might be removed or just
EXPORT_SYMBOL_GPL() macro, please?

I am especially interested whether we could remove pr_warn()
from the header file. It would help us the get rid of the
cyclic header dependency an easy way.

Best Regards,
Petr
