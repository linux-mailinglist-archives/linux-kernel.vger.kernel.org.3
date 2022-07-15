Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE031576216
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 14:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbiGOMtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 08:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbiGOMtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 08:49:39 -0400
X-Greylist: delayed 75885 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Jul 2022 05:49:38 PDT
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DEC1CB27
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 05:49:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7925034D92;
        Fri, 15 Jul 2022 12:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657889376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3SZjjm4GYKG35pso1ukOUvEhXJUwH5J2gDyR1sXUx/4=;
        b=R0MtUe/hEJB9BskOjEkhPkBu+6cLXX4dBu72zDMAQpPEmFsBXIcOLg1WRq9MwV0qdrbFEl
        A3WrXX4WvXuaB+92ars8L8bXW4H7AsnMYTbuQKGzE9eZLQ5qs1M7dZxFETys7dOko0pxSk
        O84JGpHVoHuaghwtwi4LlzrWGdOncaA=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 253F32C141;
        Fri, 15 Jul 2022 12:49:36 +0000 (UTC)
Date:   Fri, 15 Jul 2022 14:49:35 +0200
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
Message-ID: <20220715124935.GE2737@pathway.suse.cz>
References: <YoeQLxhDeIk4VSmx@chrisdown.name>
 <YshL2M8VdIEONDdc@alley>
 <Ys7bb8+/G0iMWfzb@chrisdown.name>
 <20220714154452.GB24338@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714154452.GB24338@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-07-14 17:44:52, Petr Mladek wrote:
> On Wed 2022-07-13 15:49:19, Chris Down wrote:
> > Petr Mladek writes:
> > > IMHO, this makes things too complicated. A better solution is to do
> > > not allow to set any log level below this limit in the first place.
> > 
> > Hmm, how should we then handle the case that you have set the per-console
> > loglevel to 3 and minimum_console_loglevel later gets changed to 5?
> > 
> > We had this problem when designing cgroup v2 as well, for example in cases
> > where a child requests a higher memory protection than can be afforded by
> > the parent, or where a child sets a higher memory limit than a parent
> > specifies. We went back and forth and eventually settled on allowing these,
> > because the alternatives seemed difficult to reason about or unnecessarily
> > inflexible.
> 
> I see.
> 
> > From the per-console loglevel side, one option is to return ERANGE or EINVAL
> > on values we know won't be honoured when setting the per-console loglevel.
> > The problem with that is that it doesn't allow to specify a "desired" limit
> > in case the external factors (in this case, the minimum loglevel) change.
> > This is even more difficult to reason about in our case because the minimum
> > loglevel may be changed dynamically outside of user control.
> >
> > Another is to disallow setting the minimum loglevel without first resetting
> > consoles which are above the value that is desired to be set, but this seems
> > really cumbersome, and again it doesn't account for cases like panic() and
> > elsewhere where we blindly change it anyway.
> >
> > Maybe you have another idea about how it should work in the case that the
> > minimum loglevel would take precedence over an existing loglevel?
> 
> minimum_console_loglevel is currently used only in syslog interface.
> It is ignored when the levels are set using sysctl.
> 
> IMHO, the reason is that sysctl might eventually get called even with
>  less privileged user.
> 
> I would keep this behavior. I mean that a change of
> minimum_console_loglevel would not affect other values immediately.
> It will be used to crop the value when anyone wants to change
> the global loglevel via syslog later.
> 
> Well, it would make sense to crop the global or per-console
> loglevels even when they are later changed via the new sysctl
> or sysfs interface. It would be a limit for less privileged
> users.
> 
> Maybe, it is over-engineered. I wonder if anyone really uses
> the minimum level in practice.

I checked the history:

1. The possibility to change "console_loglevel" was added in 0.99.13k,
   1992. The syslog syscall was the only way to change the value
   at runtime at that time.

2. MINIMUM_CONSOLE_LOGLEVEL was added in 1.3.37, 1995
   It was hardcoded at that time.

3. minimum_console_loglevel was exported via sysctl in 2.1.32, between
   1996-1999. This version added the sysctl interface for all 4 values:
   console_loglevel, minimum_console_loglevel, default_console_loglevel,
   default_message_loglevel. Before it was possible to change only
   console_loglevel via the syslog syscall.

   sysctl allows to set all four values to any value. It does not
   check if they make any sense. And it does not check if
   console_loglevel is above minimum_console_loglevel.
   Only the syslog syscall checks minimum_console_loglevel.

   I guess that nobody really though how the interface could be used.
   It just made the four "configurable" values accessible.


IMHO, it confirms the theory that the minimum value should prevent less
privileged users to change the loglevel below this minimum. And I
would do it as I suggested. I mean that minimum_console_loglevel
will be used only when anyone tries to change the global
or per-console loglevel.

It would make sense to return -EINVAL when anyone wants to set
loglevel below the minimum value via sysctl or sysfs interface.

I suggested to just crop the value yesterday. It is what the syslog
sycall does. But I think that it is actually quite ugly and we could
do better in the new (more modern) interface.

Best Regards,
Petr
