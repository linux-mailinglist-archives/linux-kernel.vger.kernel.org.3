Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B4249C6C1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbiAZJp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbiAZJpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:45:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349CFC061748
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 01:45:25 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643190322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8yBk8OLXalHrHOlxvgZitP7VPxCC5qC2L1+E/Mq8jII=;
        b=pLOzjJWGEmOWER647NMm0S0oUU2o+isOxSfjnG7Lua9Gh6vC+V1LTx2Sk6GKA2Q2MsTEVL
        OAVI5DRGHDxZO/wgKru9qycRr/HxnkQBVBVTr4gYj6mJ286Yei4ZvfgxlWg5fItWtD997u
        KiqfnbW3hyiTJblKjeLUnBj39qgg6xANnk+3WsmvkzdyDXj5o7avhTS1N2yWGfNrkAG3IP
        7FIn/A9UrFtBs+TCQHE2pEN9Te6G/zw6RESsD8KHWvk57v2dCnrF2cZ+dtGc7/Fl3GTphE
        oPTwAAGzuhXWvOivPESUST7GT33qpc6okjeSJPbdEe8GlWMRXu3vwyn/+3nGug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643190322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8yBk8OLXalHrHOlxvgZitP7VPxCC5qC2L1+E/Mq8jII=;
        b=ZSMwVtwQoHbjnx+mBlRQ+1QmefqBxxYLl5/EG+5QA/01ZE+zlUsFuUQP6hLeblYGKFYtAv
        xYs8alOvIrjDLDAw==
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] printk: disable optimistic spin during panic
In-Reply-To: <YfER7tlXZZpX94c9@google.com>
References: <20220121190222.572694-1-stephen.s.brennan@oracle.com>
 <20220121190222.572694-3-stephen.s.brennan@oracle.com>
 <YfER7tlXZZpX94c9@google.com>
Date:   Wed, 26 Jan 2022 10:51:22 +0106
Message-ID: <87r18un83x.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there something that prevents panic CPU from NMI hlt CPU which is
> in console_trylock() under raw_spin_lock_irqsave()?
>
>  CPU0				CPU1
> 				console_trylock_spinnning()
> 				 console_trylock()
> 				  down_trylock()
> 				   raw_spin_lock_irqsave(&sem->lock)
>
>  panic()
>   crash_smp_send_stop()
>    NMI 			-> 		HALT

This is a good point. I wonder if console_flush_on_panic() should
perform a sema_init() before it does console_trylock().

John
