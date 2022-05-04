Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F5D51B231
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 00:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379234AbiEDWqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379088AbiEDWqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:46:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4176A53726
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:42:32 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651704149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bIg1HscWN1tvVWMSh8fcrYwHSnmqdBrRg0rNnb5YAr4=;
        b=B6aIpuDJHUxIAuuxMW19vF2YskBMeJJY1RaYy1313Uyk1P/Z3GVoSvY0AbQFxrYcX1l0Az
        2/+LxzzMrc1k1ZWkIqwQ8W3k4ne/1w5GJuxZvSBg2nx92EhrCkYuJ2wCRUN7EiSMXMzYDd
        l1zVlr9+kWhZ1O7tHnfvpUy6/izefbTfP7q2LCkJgKbaY4KB4Mig6HzKfJE6CZIwC6h8bu
        vBvgOPtqmZ+JYem07KSOyh4vmjnHfcNrTUIhwocHTXrKf9CbgBxcjyD2Ul+RpraPyBVlBj
        55XhJKVhvDEXyxGfxU+jB6XLkv8B4/eKL61MRBrXnIptEUAYhLuU+qKkxUksGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651704149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bIg1HscWN1tvVWMSh8fcrYwHSnmqdBrRg0rNnb5YAr4=;
        b=m98oYRuoP7rXD4qoKzjZfEYooVQPaQUBsEyWbXMrczs81p1HFw9GRfR/HRpjmTjK8iPQCm
        sjWxzDfchSYoCEBQ==
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH printk v5 1/1] printk: extend console_lock for
 per-console locking
In-Reply-To: <87pmktm2a9.fsf@jogness.linutronix.de>
References: <Ymfgis0EAw0Oxoa5@alley> <Ymfwk+X0CHq6ex3s@alley>
 <CGME20220427070833eucas1p27a32ce7c41c0da26f05bd52155f0031c@eucas1p2.samsung.com>
 <2a82eae7-a256-f70c-fd82-4e510750906e@samsung.com>
 <Ymjy3rHRenba7r7R@alley>
 <b6c1a8ac-c691-a84d-d3a1-f99984d32f06@samsung.com>
 <87fslyv6y3.fsf@jogness.linutronix.de>
 <51dfc4a0-f6cf-092f-109f-a04eeb240655@samsung.com>
 <87k0b6blz2.fsf@jogness.linutronix.de>
 <32bba8f8-dec7-78aa-f2e5-f62928412eda@samsung.com>
 <Ym/Z7PYPqvWPEjuL@alley>
 <45849b63-d7a8-5cc3-26ad-256a28d09991@samsung.com>
 <87pmktm2a9.fsf@jogness.linutronix.de>
Date:   Thu, 05 May 2022 00:48:28 +0206
Message-ID: <87a6bwapij.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-04, John Ogness <john.ogness@linutronix.de> wrote:
> I can reproduce the apparent stack corruption with qemu:
>
> [    5.545268] task:pr/ttyAMA0      state:S stack:    0 pid:   26 ppid:     2 flags:0x00000008
> [    5.545520] Call trace:
> [    5.545620]  __switch_to+0x104/0x160
> [    5.545796]  __schedule+0x2f4/0x9f0
> [    5.546122]  schedule+0x54/0xd0
> [    5.546206]  0x0

I believe I am chasing a ghost. I can rather easily reproduce these
strange call traces, but if another sysrq-t is sent afterwards, the call
trace is OK. Also, I added trace_dump_stack() into the printk-kthread
main loop to dump the stack on every iteration. There I never see any
corruption, even though the timestamps are near the sysrq-t dump showing
corruption. Moving trace_dump_stack() into
amba-pl011:pl011_console_write() also showed no stack corruption at very
near times when sysrq-t did.

And it should be noted that the console-hanging issues reported in this
thread _cannot_ be reproduced with qemu.

So I will stop focussing on this "corrupt stack" thing and instead
investigate what the meson driver is doing that causes it to get
stuck. Since interrupts do not even fire, I'm guessing that the RX
interrupts are not being re-enabled (AML_UART_RX_INT_EN) for some code
path. This bit is only explicitly set once, in
meson_uart_startup(). Whenever the bit is cleared, later the previous
value is restored. This is assumed to mean the interrupt gets
re-enabled. But if there is some code path where multiple CPUs can
modify the register, then the interrupt could end up permanently
disabled.

I will go through and check if all access to AML_UART_CONTROL is
protected by port->lock.

John
