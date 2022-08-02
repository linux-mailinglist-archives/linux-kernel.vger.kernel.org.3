Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32DE5877F8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbiHBHhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235987AbiHBHhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:37:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C588FB86E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 00:37:33 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 573EA203AE;
        Tue,  2 Aug 2022 07:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659425852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I/fg8txpSAtyJTnoIbKN0qFtAj2rAgtTdzaptbHxtuM=;
        b=Ru6r0D+lF4I/Kh4I/7Y6rPWQemGjTV8up7B6jv+mB2WhLw5B5kEFCFOCRuq+Wq8h0zl3t9
        R3zPpL1gwaSj1mMENZHQZJMURoZBbR9jc9c775mt7SUrr5BLsGKAtcQjTUjimSBembgUyI
        Hr32aOx6OyqL7WVZ/HgJTvaolMGR2w0=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 713092C141;
        Tue,  2 Aug 2022 07:37:31 +0000 (UTC)
Date:   Tue, 2 Aug 2022 09:37:28 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] printk for 5.20
Message-ID: <YujUOEVXYpZBq5jz@alley>
References: <YufsTLpighCI7qSf@alley>
 <16ef8dbc4bdf4120b046ebacaf1f3cf2@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16ef8dbc4bdf4120b046ebacaf1f3cf2@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-08-01 15:45:13, David Laight wrote:
> > - Completely disable printing on consoles with CONFIG_RT. They break
> >   RT guarantees. They are too slow to be called with raw spinlocks.
> >   They can't be called with normal spinlocks in an atomic context because
> >   RT spinlocks might sleep. It is going to get fixed by the kthreads and
> >   atomic consoles. In the meantime, the debugging of CONFIG_RT kernel
> >   will be possible only by the user space kernel log readers.
> 
> SYSV used to be like that if you were running syslogd.
> Used to make debugging some issues completely impossible.

Sure. My understanding is that this is how RT guys want it in
4.19. There is no quick magic solution. Either printk() would break
RT guarantees or messages will not be seen on consoles. The blank
consoles were chosen as the least bad solution. Of course, we
are still working on the printk kthreads and atomic consoles
that would allow debugging using consoles on RT again.

Best Regards,
Petr
