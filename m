Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70064B754B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbiBOR62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 12:58:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiBOR61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:58:27 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC51CB90F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 09:58:16 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1F0061F37B;
        Tue, 15 Feb 2022 17:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644947895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PWnIgritZWDbPqJt4NsgSR71vtgK2UWzhthhnP5o4N8=;
        b=ANXyuW7pa1fRxyk4Wi82kyjZCJBuqKX1zYvsPJuG/UniPdAKijCFcYg1yLlU+7XXtpIhMv
        0CfdkivBt3YJc2YGKg4twu+MOatTDOXUrcl3jlvvw25cHxsarePAEQsuZz0UOWD5x7EPgY
        rGuJDycszjodPi/gitL3YyXISA8J4vU=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CC322A3B89;
        Tue, 15 Feb 2022 17:58:14 +0000 (UTC)
Date:   Tue, 15 Feb 2022 18:58:14 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andre Kalb <andre.kalb@sma.de>, john.ogness@linutronix.de,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v2] printk: Set console_set_on_cmdline=1 when
 __add_preferred_console() is called with user_specified == true
Message-ID: <YgvptpD/g4hj0bsp@alley>
References: <YgKSbe9d3haHKMid@alley>
 <YgpXWQqjfJBISG1v@pc6682>
 <Ygsa7gfqlhZVWdDb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ygsa7gfqlhZVWdDb@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-02-15 12:15:58, Sergey Senozhatsky wrote:
> On (22/02/14 14:21), Andre Kalb wrote:
> > +static void set_user_specified(struct console_cmdline *c, bool user_specified)
> > +{
> > +	if (!user_specified)
> > +		return;
> > +
> > +	c->user_specified = true;
> > +	console_set_on_cmdline = 1;
> > +}
> 
> In original code we always set c->user_specified. Is it guaranteed that
> ->user_specified is properly initialized to 0? Maybe can do something like:

It is guaranteed. console_cmdline is a static array initialized with
zeroes. The 2nd set_user_specified() call is done for a not-yet-used
slot in the array, so it must be zero.


> static void set_user_specified(struct console_cmdline *c, bool user_specified)
> {
> 	c->user_specified = user_specified;

This will change the behavior for the 1st set_user_specified() call.
It happens when the same console is added more times by device tree,
SPCR, and/or command line. c->user_specified must stay "true" when
at least one __add_preferred_console() call added it from the command line.

> 	if (!user_specified)
> 		return;
> 
> 	console_set_on_cmdline = 1;
> }

I agree that it is not obvious. It would make sense to add a comment
into the code. I am going to propose something in a reply to the
original post.

Best Regards,
Petr
