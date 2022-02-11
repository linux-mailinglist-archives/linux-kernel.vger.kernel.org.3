Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03794B261B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350206AbiBKMom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:44:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349788AbiBKMoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 07:44:39 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E440FC9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 04:44:39 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BDE5B1F385;
        Fri, 11 Feb 2022 12:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644583477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q+m+7SWHi1L6eYc8E3SAcCgqwilONaP2hC76KBKED8A=;
        b=gRhlkSiQoEyxiPC+sR+S6AP5Tk9mbpleZw0LQZOk1WVR4jk72YCfhNDm2Utb7BP4ljFMA/
        TnPUGgurRBVn70wmp+HIUq+hcgrcBmJDgi+LD/TR0+SIORwvPKCEYrSGPFrs6I2ikGynlJ
        ipsgzkVwtUYrhUAXprOi4Y1VopRDHpo=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 735DFA3B84;
        Fri, 11 Feb 2022 12:44:37 +0000 (UTC)
Date:   Fri, 11 Feb 2022 13:44:34 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH printk v1 01/13] printk: rename cpulock functions
Message-ID: <YgZaMkUU5Ve2GV9D@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207194323.273637-2-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-02-07 20:49:11, John Ogness wrote:
> Since the printk cpulock is CPU-reentrant and since it is used
> in all contexts, its usage must be carefully considered and
> most likely will require programming locklessly. To avoid
> mistaking the printk cpulock as a typical lock, rename it to
> cpu_sync. The main functions then become:
> 
>     printk_cpu_sync_get_irqsave(flags);
>     printk_cpu_sync_put_irqrestore(flags);

It is possible that I will understand the motivation later when
reading the entire patchset. But my initial reaction is confusion ;-)

From mo POV, it is a lock. It tries to get exclusive access and
has to wait until the current owner releases it.

As you say: "its usage must be carefully considered and most likely
will  require programming locklessly." I guess that it is related to:

    + There is a risk of deadlocks that are typically associated with
      locks. After all the word "lock" is part of "deadlock".

    + It requires lockless programming because it is supposed to be
      terminal lock. It means that no other locks should be taken
      under it.


Is there any other API using this naming scheme, please?

I have get() and put() associated with reference counting. But it has
an opposite meaning. It usually guards an object from freeing as long
as there is at least one user. And it allows to have many users.


Regarding the reentrancy. It seems that "_nested" suffix is used for
this type of locks, for example, mutex_lock_nested(),
spin_lock_nested().


It might be enough to add "_nested" suffix and explain why it has
to be used carefully (terminal lock) in a comment.

But I might miss something.

Best Regards,
Petr
