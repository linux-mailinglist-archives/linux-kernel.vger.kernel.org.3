Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D915138EC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349548AbiD1Pqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349500AbiD1PqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:46:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF289B1A9F;
        Thu, 28 Apr 2022 08:42:57 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651160576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rnMkrEHxL7tcsjFuW+K1zq3QhquJH/R43AmLLdfMdcA=;
        b=N03I2ddNLi7GD8ZRfz7/TYFT7DjtoZwLgZyUF99N6VXg67ZN0AMXE4ZuPZuM1vUlPde+xS
        M+4bQyMFz1vMqXVzlGMBli7O1rAQ9XHqThXNEA9W/v/A6+cNyNQTzD0zJy3/x1VJy+v3dI
        aOUr7hfJl5KZrnGQIT9+ArBjnjDRH7YDuqEPwnnT2NYdXUyNMUPbcGX3ofjOYWVUVM6AAj
        nxMhiQR4W7d95fdreCxkPrnAMdyDRQ0/BNYNKcDl3Jecez4l7bg3EnhkVny2RTivqjJZeZ
        nMimq+4Brfb76LsSY4p/ydMYnz3QqGVmAE4yG+inox8BzE9v8f7ZFprmLMkRDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651160576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rnMkrEHxL7tcsjFuW+K1zq3QhquJH/R43AmLLdfMdcA=;
        b=tN+6DcJDG5jxKhXmlZP3w7aojECgAsZzh5xQxkfjPkSG4DjF9uGLVyGP9vsl9e2NNZXzIi
        v3BhvEsCActT/GAg==
To:     Thomas Pfaff <tpfaff@pcs.com>, linux-kernel@vger.kernel.org
Cc:     linux-rt-users@vger.kernel.org, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] irq: synchronize irq_thread startup
In-Reply-To: <f18798-9e66-66e7-8c9d-cb8eeda364c4@pcs.com>
References: <f18798-9e66-66e7-8c9d-cb8eeda364c4@pcs.com>
Date:   Thu, 28 Apr 2022 17:42:55 +0200
Message-ID: <87r15huscg.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,

On Thu, Apr 28 2022 at 12:49, Thomas Pfaff wrote:

please always Cc maintainers when sending patches and please also have a
look at:

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#patch-submission-notes

> While running
> "while /bin/true; do setserial /dev/ttyS0 uart none;
> setserial /dev/ttyS0 uart 16550A; done"
> on a kernel with threaded irqs, setserial is hung after some calls.
>
> setserial opens the device, this will install an irq handler if the uart is
> not none, followed by TIOCGSERIAL and TIOCSSERIAL ioctls.
> Then the device is closed. On close, synchronize_irq() is called by
> serial_core.
>
> If the close comes too fast, the irq_thread does not really start,
> it is terminated immediately without going into irq_thread().
> But an interrupt might already been handled by
> irq_default_primary_handler(), going to __irq_wake_thread() and
> incrementing threads_active.
> If this happens, synchronize_irq() will hang forever, because the
> irq_thread is already dead, and threads_active will never be decremented.
>
> The fix is to make sure that the irq_thread is really started
> during __setup_irq().

Right. Nice detective work.

> @@ -127,6 +129,8 @@ struct irqaction {
>  	unsigned int		flags;
>  	unsigned long		thread_flags;
>  	unsigned long		thread_mask;
> +	atomic_t		thread_is_up;
> +	wait_queue_head_t	wait_for_thread;

I don't think we need any of this extra ballast per irqaction.

irqaction::thread_flags is already there and can be used as indicator.
There are enough bits left.

irq_desc already has a wait queue, which is used for synchronize_irq()
to wait for threads to complete. That wait queue is unused at the point
where an interrupt is set up, so there is no reason to introduce a new
one which is only used once.

This is not a problem in the rare case that the interrupt fires and
wakes the thread which then in consequence might wake the waiter via
wake_threads_waitq().

> -	if (new->thread)
> +	if (new->thread) {
>  		wake_up_process(new->thread);
> -	if (new->secondary)
> +		wait_event(new->wait_for_thread,
> +			   atomic_read(&new->thread_is_up));

Please stick this into a helper function.

Thanks,

        tglx
