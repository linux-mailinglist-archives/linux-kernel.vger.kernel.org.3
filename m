Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A46656BDB0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238847AbiGHPXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 11:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237631AbiGHPXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:23:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED96570E7C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 08:23:09 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 92B6D220F5;
        Fri,  8 Jul 2022 15:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657293788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K0/+PBjYZTCjYM+SWBeX+Ff/AU/wk0TGbzmKwx+ewX4=;
        b=VfEJ0LRVVsivkuhO1OsfUFozVxteUZdDbmHf7PkXVyqAumj9ga2ayQHHe2dBKJQ3H8Llrq
        xQr3JGYC5K4fvcSUmGkA2TisYmqnJ077mFtzPXWbmbzzqEM0Nflglx46L0fCO/Tn3meRJF
        nRXVjCaztY1rbtysdGuH0fsf+O0E3GM=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2CF582C141;
        Fri,  8 Jul 2022 15:23:08 +0000 (UTC)
Date:   Fri, 8 Jul 2022 17:23:04 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: design: was: Re: [RFC PATCH v2] printk: console: Allow each console
 to have its own loglevel
Message-ID: <YshL2M8VdIEONDdc@alley>
References: <YoeQLxhDeIk4VSmx@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoeQLxhDeIk4VSmx@chrisdown.name>
X-Spam-Status: No, score=-0.9 required=5.0 tests=ADVANCE_FEE_3_NEW,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-05-20 13:57:19, Chris Down wrote:
> --- /dev/null
> +++ b/Documentation/admin-guide/per-console-loglevel.rst
> @@ -0,0 +1,116 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. _per_console_loglevel:
> +
> +Per-console loglevel support
> +============================
> +
> +Motivation
> +----------
> +
> +Consoles can have vastly different latencies and throughputs. For example,
> +writing a message to the serial console can take on the order of tens of
> +milliseconds to get the UART to successfully write a message. While this might
> +be fine for a single, one-off message, this can cause signiifcant

s/signiifcant/significant/

> +application-level stalls in situations where the kernel writes large amounts of
> +information to the console.
> +
> +This means that while you might want to send at least INFO level messages to
> +(for example) netconsole, which is relatively fast, you may only want to send
> +at least WARN level messages to the serial console. This permits debugging
> +using the serial console in cases that netconsole doesn't receive messages
> +during particularly bad system issues, while still keeping the noise low enough
> +to avoid inducing latency in userspace applications.
> +
> +Tunables
> +--------
> +
> +In order to allow tuning this, the following controls exist:
> +
> +Global
> +~~~~~~
> +
> +In order of authority:
> +
> +* ``ignore_loglevel`` on the kernel command line: Emit all messages. Cannot be
> +  disabled without restarting the kernel. All other controls are ignored if
> +  this is present.

It actually can be enabled/disabled at runtime by

	echo 0/1 >/sys/module/printk/parameters/ignore_loglevel

> +* ``loglevel=...`` on the kernel command line: Equivalent to sysctl
> +  ``kernel.default_console_loglevel``.

This does not fit the 'In order of authority' because it can be
overridden with per-console loglevel or force_console_loglevel


> +* ``kernel.minimum_console_loglevel`` sysctl: Clamp all consoles to emit
> +  messages beyond this loglevel.

This is a limit. It does not really set any loglevel.

> +* ``kernel.force_console_loglevel`` sysctl: Force all consoles to the given
> +  loglevel. If this value is lower than ``kernel.minimum_console_loglevel``,
> +  ``kernel.minimum_console_loglevel`` is respected. Can also be set to the
> +  special value "unset" which removes any existing forced level.

> +* ``kernel.default_console_loglevel`` sysctl: The default console loglevel if
> +  there is no local loglevel for the console, and

"local loglevel" is confusing. Better might be "console-specific loglevel".

> +  ``kernel.force_console_loglevel`` is unset. If this value is lower than
> +  ``kernel.minimum_console_loglevel``, ``kernel.minimum_console_loglevel`` is
> +  respected.

Hmm, "default" is a bit confusing. My view is that default is
the built-in value defined as CONSOLE_LOGLEVEL_DEFAULT. Any value defined
on the command line or at runtime is not default.

I see, "default" has another meaning here. It means that it is the
loglevel that will used when there is no explicit console-specific
loglevel.

See below for another proposal.


> +* ``kernel.default_console_loglevel`` sysctl: The default console loglevel if
> +  there is no local loglevel for the console, and
> +  ``kernel.force_console_loglevel`` is unset. If this value is lower than
> +  ``kernel.minimum_console_loglevel``, ``kernel.minimum_console_loglevel`` is
> +  forced.

``kernel.default_console_loglevel`` description is repeated twice.

> +* ``kernel.default_message_loglevel`` sysctl: The default loglevel to send
> +  messages at if they are sent with no explicit loglevel.
> +
> +The default value for ``kernel.default_console_loglevel`` comes from
> +``CONFIG_CONSOLE_LOGLEVEL_DEFAULT``, or ``CONFIG_CONSOLE_LOGLEVEL_QUIET`` if
> +``quiet`` is passed on the kernel command line.
> +
> +Console attributes
> +~~~~~~~~~~~~~~~~~~
> +
> +Registered consoles are exposed at ``/sys/class/console``. For example, if you
> +are using ``ttyS0``, the console backing it can be viewed at
> +``/sys/class/console/ttyS/``. The following files are available:
> +
> +* ``effective_loglevel`` (r): The effective loglevel after considering all
> +  loglevel authorities. For example, if the local loglevel is 3, but the global
> +  minimum console loglevel is 5, then the value will be 5.
> +* ``effective_loglevel_source`` (r): The loglevel authority which resulted in
> +  the effective loglevel being set. The following values can be present:
> +
> +    * ``local``: The console-specific loglevel is in effect.
> +    * ``global``: The global default loglevel
> +      (``kernel.default_console_loglevel``) is in effect. Set a console-specific
> +      loglevel to override it.
> +    * ``forced``: The global forced loglevel (``kernel.force_console_loglevel``)
> +      is in effect. Write "unset" to ``kernel.force_console_loglevel`` to disable
> +      it.
> +    * ``minimum``: The global minimum loglevel
> +      (``kernel.minimum_console_loglevel``) is in effect. Set a higher
> +      console-specific loglevel to override it.

This is confusing. It might be because I am not a native speaker. It
sounds like a higher console-specific loglevel might update (override)
the minimum value.

A better explanation is that it is a limit. Neither the global nor the per-console
loglevel could be set below this value.


> +    * ``forced_minimum``: The global minimum loglevel
> +      (``kernel.minimum_console_loglevel``) is in effect. Even if the local
> +      console-specific loglevel is higher, it is in effect because the global
> +      forced loglevel (``kernel.force_console_loglevel``) is present, but is
> +      below ``kernel.minimum_console_loglevel``. Write "unset" to
> +      ``kernel.force_console_loglevel`` to disable the forcing, and make sure
> +      ``kernel.minimum_console_loglevel`` is below the local console loglevel
> +      if you want the per-console loglevel to take effect.
> +      console-specific loglevel to override it.

IMHO, this makes things too complicated. A better solution is to do
not allow to set any log level below this limit in the first place.

> +    * ``ignore_loglevel``: ``ignore_loglevel`` was specified on the kernel
> +      command line. Restart without it to use other controls.
> +
> +* ``enabled`` (r): Whether the console is enabled.
> +* ``loglevel`` (rw): The local loglevel for this console. This will be in
> +  effect if no other global control overrides it. Look at
> +  ``effective_loglevel`` and ``effective_loglevel_source`` to verify that.
>
> +Deprecated
> +~~~~~~~~~~
> +
> +* ``syslog(SYSLOG_ACTION_CONSOLE_*)``: This sets

Why does it use "_*"? It looks like the entire syslog interface is
obsolete. But this patch affects only three actions: ON, OFF, LEVEL.

> +  ``kernel.force_console_loglevel``. It is unaware of per-console loglevel
> +  semantics and is not recommended. A warning will be emitted if it is used
> +  while local loglevels are in effect.

Do we really want to obsolete it? It might be enough to say
that it works as force_console_loglevel.

> +* ``kernel.printk`` sysctl: this takes four values, setting
> +  ``kernel.force_console_loglevel``, ``kernel.default_message_loglevel``,
> +  ``kernel.minimum_console_loglevel``, and ``kernel.default_console_loglevel``
> +  respectively. The interface is generally considered to quite confusing, and
> +  is unaware of per-console loglevel semantics.


OK, I know that you made it according to the proposal that I sent you
in a private mail. I think that there are several good ideas. But some parts
are still too complicated or weird.

The main principle must be really simple so that people could
understand it.

I have one idea. A big difference might be replacing
"force_console_loglevel" value with "ignore_per_console_loglevel" parameter.

I propose the following:

--- cut ---
Each kernel message has defined a log level. It defines the purpose
and importance of the messages. The log levels are:

    + 0 emergency - system is unusable
    + 1 alert -  action must be taken immediately
    + 2 critical conditions
    ...

    (the above is based on include/linux/kern_levels.h)

Consoles can have vastly different latencies and throughputs....
(explanation why people want to see only the most important
messages on consoles.)

The limit for messages that reach the console is defined by a global
console loglevel value. It might be optionally overridden for a particular
console by a console_specific value.
--- cut ---

The above is the explanation of the basic approach. Especially the
last paragraph is important. It describes the basic logic a very
simple way. Anything else are details.

The description of the details:

--- cut ---
There are many ways how the console loglevels can be modified.
The global value might be set by:

  + CONFIG_CONSOLE_LOGLEVEL_DEFAULT at built time.
  + "loglevel=" or "quiet" kernel parameters at boot time.
  + sysctl kernel.console_loglevel at runtime


The console-specific loglevel might be set by:

  + "console=device,options/loglevel" kernel parameter at boot time
  + echo <level> > /sys/class/console/<console>/loglevel at runtime


The console loglevel parameters might also be ignored by:

  + "ignore_loglevel" kernel parameter allows to ignore both the global
    and console specific loglevel values. As a result, all messages
    are shown on all consoles.

  + "ignore_per_console_loglevel" kernel parameter allows to ignore
    console specific loglevels. The global loglevel is used instead.

  Both parameters might be switched also at runtime by

    echo <0/1> >/sys/module/printk/parameters/<parameter>


There is also a hard limit that prevents setting either the global
or the console specific loglevel below this value. It can be
set by:

   + CONFIG_CONSOLE_LOGLEVEL_MIN at build time
   + sysctl kernel.console_minimal_loglevel at runtime
--- cut ---

The main logic difference is that we do not have 4 loglevel values
(global,per-console,minimum,forced) and complicated rules which one
will be used in the end.

Instead we have only two values: global, and optional
console-specific. 2nd one is used when and only when defined.
Plus one or both might ignored when the "ignore*" parameter is used.

Everything else are ways how to set the values at build/boot/run time.

How does it sounds, please?


PS: I am sorry for the late review. I needed some bigger window to
    be able to think about it. All the previous attempts made
    the logic really hard to understand. The following
    table from your code shows it nicely:

static const char *const loglevel_source_names[] = {
	[LLS_GLOBAL] = "global",
	[LLS_LOCAL] = "local",
	[LLS_FORCED] = "forced",
	[LLS_MINIMUM] = "minimum",
	[LLS_FORCED_MINIMUM] = "forced_minimum",
	[LLS_IGNORE_LOGLEVEL] = "ignore_loglevel",
};

   It looks scary. Just imagine a system administrator that sees one
   of these values and want to change it somehow. They would need to
   understand what it means and how to move the state into
   the desired one without breaking other consoles.
