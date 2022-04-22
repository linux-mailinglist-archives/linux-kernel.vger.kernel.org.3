Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B734D50C442
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbiDVWcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbiDVWcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:32:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514971DBD52
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 14:25:13 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650662711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Nz88wgU3oEnXcxHypupvVLH2XmQE+DRfM6SBgqkIg8=;
        b=tOqDYgO/0zB7wbhGQHdu9ur1jcQH0zrZjCp64dCqn7ROOmkoWTGzgkFaMpggCPWFZJEMhr
        BEMvc/FIRbna3AY0CTn0WWU1iC59ELC7VpdTXO5uWBFxFYML8m9bd6d4j3znl9Gxez/1dH
        dBpxKGxeL70cjmem0V7NLYlzbinmSA/Z1OVtFfPrLom/B63V1vhVSoXK2Ofx3s+8i/zAcV
        iKyEj0acamQWun9DQ0eWO0ZPbVqXHxKNl4uk8lkrYl3laLc5v5VHuSbBYm6KowZeAuRcLU
        ikJ11ryklnmiGEEusSFaD5HcevK5Y74ZW0P6WCjWPGShLoFqm5lAo0QYsztFfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650662711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Nz88wgU3oEnXcxHypupvVLH2XmQE+DRfM6SBgqkIg8=;
        b=puiQvk6IAPo8P/C5l0aLEDFXpDfziwVcdZrHgjtN3TvUD2Zmseqtk6/1rWUHcpBpVVASse
        rBT9WrSujlWmK4Dw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v3 14/15] printk: extend console_lock for proper
 kthread support
In-Reply-To: <YmLGfuSV5u7xp5BZ@alley>
References: <20220419234637.357112-1-john.ogness@linutronix.de>
 <20220419234637.357112-15-john.ogness@linutronix.de>
 <20220421124119.GB11747@pathway.suse.cz>
 <875yn2h5ku.fsf@jogness.linutronix.de> <YmKnp3Ccu7laW3E4@alley>
 <87o80tp5lv.fsf@jogness.linutronix.de> <YmLGfuSV5u7xp5BZ@alley>
Date:   Fri, 22 Apr 2022 23:31:11 +0206
Message-ID: <877d7gu7yg.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-22, Petr Mladek <pmladek@suse.com> wrote:
> Another problem is that the ordering is not stable. The console
> might come and go.

The console list is protected by @console_sem, so it wouldn't be an
actual problem. The real issue is that lockdep would not like it. A new
lockdep class would need to be setup for each register_console().

>> Anyway, I will first look into the nested locking solution. That
>> seems more promising to me and it would go a long way to simplify the
>> locking hierarchy.
>
> Please, do not spend too much time on this. The solution must be
> simple in principle. If it gets complicated than it will likely
> be worse than the current code.

Sure. The goal is to simplify. The only complexity will be doing in a
way that allow lockdep to understand it.

> Alternative solution would be to reduce the number of variables
> affected by the race. I mean:
>
>    + replace CON_THB_BLOCKED flag with con->blocked to avoid
>      the needed of READ_ONCE()/WRITE_ONCE().
>
>    + check con->blocked right after taking con->lock in
>      printk_kthread_func() so that all the other accesses are
>      safe.

Honestly, I would prefer this to what v4 is doing. The only reason
CON_THD_BLOCKED is a flag is to save space. But we are only talking
about a few bytes being saved. There aren't that many consoles.

It would be a very simple change. Literally just replacing the 3 lines
that set/clear CON_THD_BLOCKED and replacing/reordering the 2 lines that
check the flag. Then all the READ_ONCE/WRITE_ONCE to @flags could be
removed.

John
