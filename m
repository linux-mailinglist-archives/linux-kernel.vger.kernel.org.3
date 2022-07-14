Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D4D575227
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 17:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbiGNPo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 11:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiGNPo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 11:44:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A982AE4E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 08:44:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8AD5D34825;
        Thu, 14 Jul 2022 15:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657813492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XQWaVdLD70toOI+SR3wOUg+mBWXwEMBEZLfRcTC1fD4=;
        b=eSEpnnGxLoQoppy4ZF4AWBkl01L7v147/n6GDqO20lzvHFLaw0Cq9Ii88MkiKJN333Pfud
        B8mQQnffJ/UJoZ2iSs4jbM267vhxBEIM5BPZxIZ379oCAoFLiDGJEA8G7VQ35+z79SqnXL
        mHxg1642pmQlZ1aqcHrqJ4yX1rTrq4w=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3FDCA2C141;
        Thu, 14 Jul 2022 15:44:52 +0000 (UTC)
Date:   Thu, 14 Jul 2022 17:44:52 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: design: was: Re: [RFC PATCH v2] printk: console: Allow each
 console to have its own loglevel
Message-ID: <20220714154452.GB24338@pathway.suse.cz>
References: <YoeQLxhDeIk4VSmx@chrisdown.name>
 <YshL2M8VdIEONDdc@alley>
 <Ys7bb8+/G0iMWfzb@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys7bb8+/G0iMWfzb@chrisdown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-07-13 15:49:19, Chris Down wrote:
> Petr Mladek writes:
> > IMHO, this makes things too complicated. A better solution is to do
> > not allow to set any log level below this limit in the first place.
> 
> Hmm, how should we then handle the case that you have set the per-console
> loglevel to 3 and minimum_console_loglevel later gets changed to 5?
> 
> We had this problem when designing cgroup v2 as well, for example in cases
> where a child requests a higher memory protection than can be afforded by
> the parent, or where a child sets a higher memory limit than a parent
> specifies. We went back and forth and eventually settled on allowing these,
> because the alternatives seemed difficult to reason about or unnecessarily
> inflexible.

I see.

> From the per-console loglevel side, one option is to return ERANGE or EINVAL
> on values we know won't be honoured when setting the per-console loglevel.
> The problem with that is that it doesn't allow to specify a "desired" limit
> in case the external factors (in this case, the minimum loglevel) change.
> This is even more difficult to reason about in our case because the minimum
> loglevel may be changed dynamically outside of user control.
>
> Another is to disallow setting the minimum loglevel without first resetting
> consoles which are above the value that is desired to be set, but this seems
> really cumbersome, and again it doesn't account for cases like panic() and
> elsewhere where we blindly change it anyway.
>
> Maybe you have another idea about how it should work in the case that the
> minimum loglevel would take precedence over an existing loglevel?

minimum_console_loglevel is currently used only in syslog interface.
It is ignored when the levels are set using sysctl.

IMHO, the reason is that sysctl might eventually get called even with
 less privileged user.

I would keep this behavior. I mean that a change of
minimum_console_loglevel would not affect other values immediately.
It will be used to crop the value when anyone wants to change
the global loglevel via syslog later.

Well, it would make sense to crop the global or per-console
loglevels even when they are later changed via the new sysctl
or sysfs interface. It would be a limit for less privileged
users.

Maybe, it is over-engineered. I wonder if anyone really uses
the minimum level in practice.

> > > +    * ``ignore_loglevel``: ``ignore_loglevel`` was specified on the kernel
> > > +      command line. Restart without it to use other controls.
> > > +
> > > +* ``enabled`` (r): Whether the console is enabled.
> > > +* ``loglevel`` (rw): The local loglevel for this console. This will be in
> > > +  effect if no other global control overrides it. Look at
> > > +  ``effective_loglevel`` and ``effective_loglevel_source`` to verify that.
> > > 
> > > +Deprecated
> > > +~~~~~~~~~~
> > > +
> > > +* ``syslog(SYSLOG_ACTION_CONSOLE_*)``: This sets
> > 
> > Why does it use "_*"? It looks like the entire syslog interface is
> > obsolete. But this patch affects only three actions: ON, OFF, LEVEL.
> 
> Not totally sure I know what you mean -- SYSLOG_ACTION_CONSOLE_* limits it
> to those, no?
> 
>     % git grep -ho 'SYSLOG_ACTION_CONSOLE_[A-Z0-9]\+' | sort -u
>     SYSLOG_ACTION_CONSOLE_LEVEL
>     SYSLOG_ACTION_CONSOLE_OFF
>     SYSLOG_ACTION_CONSOLE_ON

I see. I missed that the other SYSLOG_ACTIONs do not have the
"_CONSOLE". Forget about it.

> > > +  ``kernel.force_console_loglevel``. It is unaware of per-console loglevel
> > > +  semantics and is not recommended. A warning will be emitted if it is used
> > > +  while local loglevels are in effect.
> > 
> > Do we really want to obsolete it? It might be enough to say
> > that it works as force_console_loglevel.
> 
> That's also fine -- my only concern with syslog() is that it's not very
> explicit about what will happen to consoles with a per-console loglevel set.
> 
> That said, once this is merged I suppose we can make it more clear in
> downstream consumers like `dmesg -n`, so not a big issue either way. :-)

Honestly, I consider syslog as a legacy code. It supports only one
reader. A better way to read the messages is /dev/kmsg and dmesg
uses it be default now.

I am not sure if people/admins really use dmesg to change the console
loglevel. IMHO, sysctl or sysfs should be the preferred way.

I think that it is enough to make the behavior clear in
the documentation.

Best Regards,
Petr
