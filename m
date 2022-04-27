Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36263511F93
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243133AbiD0QW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243600AbiD0QTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:19:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1E051E5A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:16:18 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651076116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hL0SFvjJMATe9c/xNNoB1N/3UB9xTPkwRzwHyvMkOEo=;
        b=AQglSgvgOxwUtydaGqvaRV8wKFYWNJ5YBFXokRswfDPGPvtqovA5fe7IEUlYQrfA8A/KK4
        vhr+l3sx/bzG5dOHf+iPmNipYtStckHEv7JIIE5HNvBHm5T/Gn8/ipXhmdaHViSUtmKn+l
        /6ijh6YutZVGxD63L2Tj8820/NMLtvkUWUBO7PMpZjag8/RqsLxRM1RHOAmsr8CSBKitKv
        6MNBpflkms+etpyCPbShCWd7nWAqTAiXU+P7NhzCw4DIxFS3rl+G3nqitELh67Q/Q2sgjI
        AwUEGcKf9JrZwYtTihJWP02Qx5qhgxwgnXOfJV9oJWhFBWHJ+DUogeol4RNguA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651076116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hL0SFvjJMATe9c/xNNoB1N/3UB9xTPkwRzwHyvMkOEo=;
        b=da0NgqfyPY/ECXVc5ePxpKHwiEQm5i/p0C8aGvfMy0pAy0eKvexqsUYEauVs/uDOkAC+tD
        wxFcKLSC1SDrVZAw==
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
In-Reply-To: <b6c1a8ac-c691-a84d-d3a1-f99984d32f06@samsung.com>
References: <20220421212250.565456-1-john.ogness@linutronix.de>
 <20220421212250.565456-15-john.ogness@linutronix.de>
 <878rrs6ft7.fsf@jogness.linutronix.de> <Ymfgis0EAw0Oxoa5@alley>
 <Ymfwk+X0CHq6ex3s@alley>
 <CGME20220427070833eucas1p27a32ce7c41c0da26f05bd52155f0031c@eucas1p2.samsung.com>
 <2a82eae7-a256-f70c-fd82-4e510750906e@samsung.com>
 <Ymjy3rHRenba7r7R@alley>
 <b6c1a8ac-c691-a84d-d3a1-f99984d32f06@samsung.com>
Date:   Wed, 27 Apr 2022 18:21:16 +0206
Message-ID: <87fslyv6y3.fsf@jogness.linutronix.de>
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

Hi Marek,

On 2022-04-27, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> Here is the full serial console log:
>
> https://pastebin.com/E5CDH88L

Here are a few ideas from me:

1. For next-20220427 the printk-threaded series was slightly changed. I
do not expect it to work any different, but I would prefer we are
debugging the current version. If possible, could you move to
next-20220427?

2. I noticed you boot with the kernel boot arguments "earlycon" and
"no_console_suspend". Could you try booting without this? I expect this
will make no difference.

3. It looks like the problem happens quite late in the boot process. I
expect it is due to some userspace process that is running that is
interacting with printk (either /dev/kmsg or /proc/kmsg) and is causing
problems. If you boot with init=/bin/sh then I expect the system is
running fine. (You don't have much of a system running, but it should
not hang.) We need to isolate which userspace process is triggering the
issue.

4. Have you tried issuing magic sysrq commands on the serial line? (For
example, sending a break signal and then the letter 't' or sending a
break signal and then the letter 'c'?) That might trigger various dumps
so that we can see the system state.

5. You are not running a VT console, so the graphics driver should not
be affecting the printk subsystem at all. I expect your autologin is
also starting various services and programs. If you disable the
automatic login and instead manually login (perhaps as another user) can
you manually start those services one at a time to see at what point the
system hangs?

Thanks for you help with this!

John Ogness
