Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B36588EBB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 16:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237433AbiHCOft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 10:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236041AbiHCOfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 10:35:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FAB5F7F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 07:35:46 -0700 (PDT)
Date:   Wed, 3 Aug 2022 16:35:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659537344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eWJIkiBpz40U3Ov2NyZuqUQaReOFpBnaQ8aleQHUj5U=;
        b=NhPTXjn75SIGXWadZSeqbGfl2xz90GcPXc4f3J5zHfpRUD5TERVYPoTAZ+GeW7Iiqlzc09
        ZP2C+eZoCkmZMqM1lnl50fkQxO1DGcNJkGG36Ll52dPzlwOnImG0u8s+De5bN7JZP/gWYv
        eiI5P8rAlpNKzc/kfKCfnad6ano3Rb8ka4qmPTT3/2oFA/BPJZrVe1KU2+Sdjt+iVAowsP
        hOPy0lvrC/JiSusv6ieUSHVzEEYmA1g1Q9zvVcOj2SNdprPccdrK5pupXWSSa0dwv1hnoU
        3QV2NuMtwVy5tn8QJQgaGf5ycbIQnfKBu1VkRWJU0OnOW4Efs5cWZvMLeFrBhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659537344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eWJIkiBpz40U3Ov2NyZuqUQaReOFpBnaQ8aleQHUj5U=;
        b=VxLG0VE7fSrKwsCkZWXc+xW5/CuLUWpdhBPj5LGJi/f6Zd7C9YjQvl50KFRFhF3XGEY/lk
        bOkrewOFtiT+AlAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] printk for 5.20
Message-ID: <YuqHvu4zAzwq+BdZ@linutronix.de>
References: <YufsTLpighCI7qSf@alley>
 <CAHk-=wie+VC-R5=Hm=Vrg5PLrJxb1XiV67Efx-9Cr1fBKCWHTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wie+VC-R5=Hm=Vrg5PLrJxb1XiV67Efx-9Cr1fBKCWHTQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-02 20:19:34 [-0700], Linus Torvalds wrote:
> Seriously, even if you have strict RT requirements, you may also have
> strict debugging requirements, and if something goes wrong, you want
> to KNOW ABOUT IT. At that point, your RT rules may well fly out the
> window, because you have more serious problems.
> 
> End result: no way will I accept this kind of completely arbitrary and
> frankly not very intelligent patch.
> 
> If people want to disable console printing, that's THEIR CHOICE. It
> could be a new config variable where you ASK people about what they
> want. Not this kind of idiotic tying together of things.

I don't argue about the loss in debugging with disabled consoles and I
spare you the time explaining how it got there.

Petr, do you revert it yourself or do you want me to send a revert?

>                Linus

Sebastian
