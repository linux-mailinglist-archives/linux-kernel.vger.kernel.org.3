Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C584D8897
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 16:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242789AbiCNPyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 11:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242794AbiCNPyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 11:54:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AADE2717B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 08:53:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 36DD7210FE;
        Mon, 14 Mar 2022 15:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647273202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dnNDnNAqONnn6uwApx2pqp90mxjL2lETMh2FT+KkTPI=;
        b=pHof8q1TT4VjXX68Bq+lVVV4XTM3ebtUllc6m/VYbKEaI9e820mJw7oDR9ye34lhP8Ld4g
        gRM3SvAM6KMgoCjlKBI5MiNjYsd0/UAJr/elqoTZwzTkSxpPpHix4XYPUYKkm6mtKDRGoD
        oNTIaNGThvI78ejjYNlvLd1SEreJTxc=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E6D2FA3B88;
        Mon, 14 Mar 2022 15:53:21 +0000 (UTC)
Date:   Mon, 14 Mar 2022 16:53:20 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 11/13] printk: reimplement console_lock for
 proper kthread support
Message-ID: <Yi9k8Eke3yfUJEb8@alley>
References: <YhYKP/UuSKENGwfj@alley>
 <87tuc7xma0.fsf@jogness.linutronix.de>
 <YioMcSe0P0Z7ksiW@alley>
 <87wnh14wp9.fsf@jogness.linutronix.de>
 <Yisj2PEtjZfHMe6N@alley>
 <87czisbotz.fsf@jogness.linutronix.de>
 <Yit2LN1nCaiUo5y4@alley>
 <87tuc4yvsw.fsf@jogness.linutronix.de>
 <Yi9MWKt+PByLsi6Y@alley>
 <87h780y4pw.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h780y4pw.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-03-14 15:49:39, John Ogness wrote:
> On 2022-03-14, Petr Mladek <pmladek@suse.com> wrote:
> > My intention is to keep the logic as simple and as clear as possible:
> >
> >        + if we need lock then use lock
> >
> >        + if we need trylock then use trylock
> >
> >        + if we want direct mode then block kthreads and try enter
> > 	 the direct mode ASAP.
> >
> >        + if kthreads mode is allowed then do nothing in
> > 	 console_unlock() and leave the job to kthreads.
> >
> >        + console_lock() temporarily blocks kthreads but
> > 	 it handle messages only when direct mode is enforced.
> 
> Thank you for your examples, detailed analysis, insight, and summaries.
> 
> This particular review became quite complicated because offline you sent
> me a heavily revised version. Several of your comments are criticizing
> your version and not the actual series I posted. For v2 we need to
> handle it better so that the list has a chance at following our
> discussion. ;-)

I am really sorry for this. And some my mails also were a bit
misleading because I missed something in the code.

One small plus is that most of the new names were mentioned
in the public https://lore.kernel.org/r/YhYKP/UuSKENGwfj@alley
But I agree that I probably made it more confusing than needed.


> I will post a v2 that attempts to address your concerns and try to frame
> the naming and structures to align with your suggestions.

Yes, sending v2 and continuing the discussion sounds like a good idea.

Best Regards,
Petr
