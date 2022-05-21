Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2D352FEDA
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 20:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344920AbiEUSwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 14:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344798AbiEUSwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 14:52:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4BD5C341
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 11:51:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 872DE60DDE
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 18:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F2EC385A5;
        Sat, 21 May 2022 18:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653159117;
        bh=4a11RXV/P0yTS0XIaPt7J8rctdIFw3mOzT4l99BkB0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TGGJ08U2YoVpVz6bP4IuS3N0lk9D+F6jMSBCYAzPoJGK0bl0vDsEkaNh8kysOALN9
         Ee0JDpBIkxnBIPD1Reyf7d1STteYJSsTdGKLq1VYMF1kQPtCBW93zL9TtX2s4O8646
         kKj4uHRAWMBSmAr6iWfpWQKzK9Fe+FTqQWIDtZGo=
Date:   Sat, 21 May 2022 20:51:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: [RFC PATCH v2] printk: console: Allow each console to have its
 own loglevel
Message-ID: <Yok0yjx0aKvlgoIL@kroah.com>
References: <YoeQLxhDeIk4VSmx@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoeQLxhDeIk4VSmx@chrisdown.name>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 01:57:19PM +0100, Chris Down wrote:
> [Once the goals of this patch are generally agreed upon, it can be split
> out further with more detailed changelogs if desired.]
> 
> Consoles can have vastly different latencies and throughputs. For
> example, writing a message to the serial console can take on the order
> of tens of milliseconds to get the UART to successfully write a message.
> While this might be fine for a single, one-off message, this can cause
> significant application-level stalls in situations where the kernel
> writes large amounts of information to the console.
> 
> This means that while you might want to send at least INFO level
> messages to (for example) netconsole, which is relatively fast, you may
> only want to send at least WARN level messages to the serial console.
> Such an implementation would permit debugging using the serial console
> in cases that netconsole doesn't receive messages during particularly
> bad system issues, while still keeping the noise low enough to avoid
> inducing latency in userspace applications. This patch adds such an
> interface, extending the existing console loglevel controls to allow
> each console to have its own loglevel.
> 
> One can't just disable the serial console, because one may actually need
> it in situations where the machine is in a bad enough state that nothing
> is received on netconsole. One also can't just bump the loglevel at
> runtime after the issue, because usually the machine is already so
> wedged by this point that it isn't responsive to such requests.
> 
> In terms of technical implementation, this patch embeds a device pointer
> in the console struct, and registers each console using it so we can
> expose attributes in sysfs.
> 
> The lifecycle of this classdev looks like this on registration:
> 
>     register_console(con)/printk_late_init()
>       console_register_device(con)
>         device_initialize(con->classdev) # refcount++
>         device_add(con->classdev)        # refcount++
> 
> At stable state, the refcount is two.
> 
> Console unregistration looks like this:
> 
>     [con->classdev refcount drops to 0]
>         console_classdev_release(con->classdev)
>             kfree(con->classdev)
> 
>     unregister_console(con)
>         device_unregister(con->classdev)
>             device_del(con->classdev) # refcount--
>                 device_remove_class_symlinks()
>                     kernfs_remove_by_name_ns()
>                         kernfs_drain()
>                             kernfs_drain_open_files() # wait for close()
>             put_device(con->classdev) # refcount--
> 
> We also deprecate the kernel.printk sysctl as it doesn't know about
> per-console loglevels, and is generally pretty confusing.
> 
> For information on the precedence and application of the new controls,
> see Documentation/ABI/testing/sysfs-class-console and
> Documentation/admin-guide/per-console-loglevel.rst.
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>
> ---
>  Documentation/ABI/testing/sysfs-class-console |  50 +++
>  .../admin-guide/kernel-parameters.txt         |  18 +-
>  .../admin-guide/per-console-loglevel.rst      | 116 ++++++
>  Documentation/admin-guide/serial-console.rst  |  17 +-
>  Documentation/core-api/printk-basics.rst      |  34 +-
>  Documentation/networking/netconsole.rst       |  17 +
>  MAINTAINERS                                   |   3 +
>  include/linux/console.h                       |  23 ++
>  include/linux/kern_levels.h                   |   2 +
>  init/main.c                                   |   2 +-
>  kernel/printk/console_cmdline.h               |   2 +
>  kernel/printk/printk.c                        | 352 ++++++++++++++++--
>  kernel/printk/sysctl.c                        |  95 ++++-
>  13 files changed, 680 insertions(+), 51 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-console
>  create mode 100644 Documentation/admin-guide/per-console-loglevel.rst

You forgot what changed from v1 :(

Anyway, the driver model interaction looks good to me, nice work, no
objections at all.

gre gk-h
