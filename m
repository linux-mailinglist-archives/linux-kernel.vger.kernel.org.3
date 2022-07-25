Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50F957FF50
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 14:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbiGYMvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 08:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbiGYMvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 08:51:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6EB65B9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 05:51:38 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658753497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+DLSbK+uqqfR9tgBy7PVplOD816TsUxhQgdpTNoL8a4=;
        b=SHP1mc3QcooOL8oEqqaq7tVM2b2zDSro9NXni6e0b0/z8oR33P7bymSraNtTllU4PtJwFh
        gR1/1rimJtiQyaNiHTAe9ssU5Hb3GrMDwcyBxE3oRAsXSYcydAhlbAvH1dxht9I4iYV7fa
        47LkzGYbtPpaMJNHnf9LU7mPeOiIUSY+N9uUzrdAVjeCL6Si5QuUlDxn1Fn1kiyF1fx87h
        erepK/AyjPUNfHztmZYEFDeRTvxA/VtnRY2Ue9b+74T/N4yn7FC+QuKza4+liQIsqekPug
        5Bloe2qSEAJ9ZqEuTDR22Z/rzrqVxsUfR5vpIsI+k1iF7KC0ZNjpsT7hoCj3ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658753497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+DLSbK+uqqfR9tgBy7PVplOD816TsUxhQgdpTNoL8a4=;
        b=m8e/Nt2TA/yLOa6we65bLhaa41UXA9Z18cYiXyazITlq4etMLAf4XZ/07dJxsJMh39Dm1M
        ZxZV2D5IgcNLVJAA==
To:     Petr Mladek <pmladek@suse.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] printk: Skip console drivers on PREEMPT_RT.
In-Reply-To: <Yt6MzEEFfpyTBIIj@alley>
References: <YtgjtfjYVMQrzFTK@linutronix.de>
 <87y1wn3g3g.fsf@jogness.linutronix.de> <Ytgu17hATM8iqdGC@linutronix.de>
 <87ilnrn06u.fsf@jogness.linutronix.de> <Ytj3PisFjOfS9L0Y@linutronix.de>
 <YtqakGJAQzw/IPul@alley> <YtrYdXWGb0NQLKNA@linutronix.de>
 <Yt6MzEEFfpyTBIIj@alley>
Date:   Mon, 25 Jul 2022 14:57:36 +0206
Message-ID: <87zggxgxt3.fsf@jogness.linutronix.de>
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

Hi Petr,

On 2022-07-25, Petr Mladek <pmladek@suse.com> wrote:
> From my point, this patch does not make much sense. IMHO, it will
> not make mainline usable with PREEMPT_RT. Any serious RT user will
> need to revert it and apply a better printk solution from
> the out-of-tree RT patchset.

The problem is that direct console printing cannot work with
PREEMPT_RT, even in a panic situation. And it never will (using "normal"
console drivers).

PREEMPT_RT is basically mainline now except for the kthread printers and
atomic consoles. But these features will not be available in mainline so
soon. (Atomic consoles have not gone through the LKML review process at
all yet.)

We see value in allowing PREEMPT_RT to be available now, even if it
means no console printing. You claim "any serious RT user" needs console
printing, but for production RT systems, the console is probably
disabled anyway.

We could solve this with kconfig tricks, making console kconfig options
depend on !PREEMPT_RT. But that would cause the console config of users
to be disabled, making it more inconvenient for them to turn it back on
once these features are available.

A software switch (as implemented by Sebastian's patch) may provide the
simplest transition. A 5.20 PREEMPT_RT would not have console printing,
but a later version (using the same config) would.

John
