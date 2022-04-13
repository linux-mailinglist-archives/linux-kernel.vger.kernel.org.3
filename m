Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF764FF6F9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 14:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbiDMMmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 08:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbiDMMmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:42:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79775FD7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 05:39:57 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7EE451F856;
        Wed, 13 Apr 2022 12:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649853596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oHveYnTR4O71wsHS4RHblj+dtZiwY1YycG/UmcBzgWE=;
        b=d9PRZucw/+GHfElRTeUb3qeZKy/B31oTOTTEXb92DW6lBJhCaMoUjJuCrY5bCeVxbM1cMT
        v7IgJRdKfqaeJ++OZm/EGFLxFt6cZqQbpFcyXterl0ehs2bU8qDQXMY3y94H6RF0sqoJRM
        CE8zoniFt2ivu5mqxCSaFv3PPLJEs9A=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 207F0A3B88;
        Wed, 13 Apr 2022 12:39:56 +0000 (UTC)
Date:   Wed, 13 Apr 2022 14:39:53 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk/index: Printk index feature documentation
Message-ID: <YlbEmZiGXZmhRvQs@alley>
References: <20220405114829.31837-1-pmladek@suse.com>
 <Ykw0mdX0GXZWJohH@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ykw0mdX0GXZWJohH@chrisdown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-04-05 13:22:49, Chris Down wrote:
> Petr Mladek writes:
> > Document the printk index feature. The primary motivation is to
> > explain that it is not creating KABI from particular printk() calls.
> > 
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> > Acked-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> 
> This looks great, thanks a lot for spending the time to write this up. Just
> some very minor comments.

Ah, I forgot to do the small fixup when pushing. So, I did it now are rebased.

> > --- /dev/null
> > +++ b/Documentation/core-api/printk-index.rst
> > +User Interface
> > +==============
> > +
> > +The index of printk formats are split in into separate files. The files are
> > +named according to the binaries where the printk formats are built-in. There
> > +is always "vmlinux" and optionally also modules, for example::
> > +
> > +   /sys/kernel/debug/printk/index/vmlinux
> > +   /sys/kernel/debug/printk/index/ext4
> > +   /sys/kernel/debug/printk/index/scsi_mod
> > +
> > +Note that only loaded modules are shown. Also printk formats from a module
> > +might appear in "vmlinux" when the module is built-in.
> > +
> > +The content is inspired by the dynamic debug interface and looks like::
> 
> s/::/:/

The double double dots '::' cause that the following paragraph will be
block quoting. There is only single ':' in the generated html.

> > +   $> head -1 /sys/kernel/debug/printk/index/vmlinux; shuf -n 5 vmlinux
> > +   # <level[,flags]> filename:line function "format"
> > +   <5> block/blk-settings.c:661 disk_stack_limits "%s: Warning: Device %s is misaligned\n"
> > +   <4> kernel/trace/trace.c:8296 trace_create_file "Could not create tracefs '%s' entry\n"
> > +   <6> arch/x86/kernel/hpet.c:144 _hpet_print_config "hpet: %s(%d):\n"
> > +   <6> init/do_mounts.c:605 prepare_namespace "Waiting for root device %s...\n"
> > +   <6> drivers/acpi/osl.c:1410 acpi_no_auto_serialize_setup "ACPI: auto-serialization disabled\n"
> > +
> > +, where the meaning is::

I uses only single double dot here.

> > +   - level: log level
> 
> Maybe worth noting that level may not be there if we have a KERN_CONT.

I added:

   - :level: log level value: 0-7 for particular severity, -1 as default,
	'c' as continuous line without an explicit log level

> > +   - flags: optional flags: currently only 'c' for KERN_CONT
 > +   - filename:line: source filename and line number of the related
> > +	printk() call. Note that there are many wrappers, for example,
> > +	pr_warn(), pr_warn_once(), dev_warn().
> > +   - function: function name where the printk() call is used.
> > +   - format: format string

I added few more double dots to generate bold: 'level', 'flags',
'filename:line', etc.

See the updated commit at
https://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git/commit/?h=for-5.19&id=a5c7a39f508ae1fd3288493b96dd26079bae41bf

Best Regards,
Petr
