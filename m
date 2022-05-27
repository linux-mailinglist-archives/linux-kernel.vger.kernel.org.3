Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE578536300
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 14:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245513AbiE0MwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 08:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240235AbiE0MwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 08:52:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7AF19F8F
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 05:52:08 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EEB6D21AE2;
        Fri, 27 May 2022 12:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653655926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pQ2DKk5IHkynOR8e5jLoYbzHCwqFj+Z4QfsRW0lOHSs=;
        b=b1TTUjRgwaJcmvkgb6zrAEtmxX62OS6WQMMWBaRQ8aEvA+G6VYn9Bxa/hv714VPf/yTHMs
        iwozs0FvmI2QolIMPmEBxW2DkD58DI0oW/naFAcVXXOREdLsIgZuBsQKBpIYBLiEOaPtPA
        sdmU5HsWkb8pTp5iZX61GLWEhKFsAnQ=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9F1A92C141;
        Fri, 27 May 2022 12:52:06 +0000 (UTC)
Date:   Fri, 27 May 2022 14:52:06 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "printk: wake up all waiters"
Message-ID: <YpDJduWln8D8Or6y@alley>
References: <20220526203056.81123-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526203056.81123-1-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-05-26 22:36:56, John Ogness wrote:
> This reverts commit 938ba4084abcf6fdd21d9078513c52f8fb9b00d0.
> 
> The wait queue @log_wait never has exclusive waiters, so there
> is no need to use wake_up_interruptible_all(). Using
> wake_up_interruptible() was the correct function to wake all
> waiters.
> 
> Since there are no exclusive waiters, erroneously changing
> wake_up_interruptible() to wake_up_interruptible_all() did not
> result in any behavior change. However, using
> wake_up_interruptible_all() on a wait queue without exclusive
> waiters is fundamentally wrong.
> 
> Go back to using wake_up_interruptible() to wake all waiters.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

The patch has been committed into printk/linux.git, branch
rework/printk.

I am going to create the pull request the following week
after it gets at least one spin in linux-next.

It is trivial patch so that it might be sent directly.
But it does not affect the functionality and is is not
urgent either.

Best Regards,
Petr
