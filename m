Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C960515EEF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 18:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359063AbiD3QDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 12:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237621AbiD3QD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 12:03:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE96C1E0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 09:00:04 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651334402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qg1MCgJs2GcRC2WuVMspd/xJnQOLWy76IzXScV+vSNk=;
        b=IqVNzG6jeHs2vRnqXL9KedXJ5Nneq6PU2Es22DQIRToeG6DxaGNtLE3alDyeUYg1NNXbOG
        tZ5XcIkOHripIzsDCl40gvjVoeCYFnsv3kIVTij3HVhFSbNAgA/OHxPOKwZ7QiSfsMRYY/
        AKhmpUiowRf81wz2OqN2Nn8wIhdctPHZNGBoxbkYoAwaA9/I/AluFXejieBz+3KlM4g/Z2
        iKRS2FZRwUrkL3wils42n513HmsViL/r2SDCbL7F2dBAwdVytWoLh/B69hWiiNosVfG2Qh
        qJJWhS3AfrCTqxEasuJKpNEnLt4tU06cLpUriIUxCouOwCQS9hu0CqIV3Q1SGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651334402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qg1MCgJs2GcRC2WuVMspd/xJnQOLWy76IzXScV+vSNk=;
        b=lMdtoPUqqUTWycR9kLDoc1fYvtjsVvRXJ59N0pmRiF9K6BpLaSHO3eFzBjunfsjoOtlmtm
        8nTsnQ0RomQDUrCQ==
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
In-Reply-To: <51dfc4a0-f6cf-092f-109f-a04eeb240655@samsung.com>
References: <20220421212250.565456-1-john.ogness@linutronix.de>
 <20220421212250.565456-15-john.ogness@linutronix.de>
 <878rrs6ft7.fsf@jogness.linutronix.de> <Ymfgis0EAw0Oxoa5@alley>
 <Ymfwk+X0CHq6ex3s@alley>
 <CGME20220427070833eucas1p27a32ce7c41c0da26f05bd52155f0031c@eucas1p2.samsung.com>
 <2a82eae7-a256-f70c-fd82-4e510750906e@samsung.com>
 <Ymjy3rHRenba7r7R@alley>
 <b6c1a8ac-c691-a84d-d3a1-f99984d32f06@samsung.com>
 <87fslyv6y3.fsf@jogness.linutronix.de>
 <51dfc4a0-f6cf-092f-109f-a04eeb240655@samsung.com>
Date:   Sat, 30 Apr 2022 18:06:01 +0206
Message-ID: <87k0b6blz2.fsf@jogness.linutronix.de>
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

On 2022-04-29, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> The same issue happens if I boot with init=/bin/bash

Very interesting. Since you are seeing all the output up until you try
doing something, I guess receiving UART data is triggering the issue.

> I found something really interesting. When lockup happens, I'm still
> able to log via ssh and trigger any magic sysrq action via
> /proc/sysrq-trigger.

If you boot the system and directly login via ssh (without sending any
data via serial), can you trigger printk output on the UART? For
example, with:

    echo hello > /dev/kmsg

(You might need to increase your loglevel to see it.)

> It turned out that the UART console is somehow blocked, but it
> receives and buffers all the input. For example after issuing "echo
>  >/proc/sysrq-trigger" from the ssh console, the UART console has been 
> updated and I see the magic sysrq banner and then all the commands I 
> blindly typed in the UART console! However this doesn't unblock the
> console.

sysrq falls back to direct printing. This would imply that the kthread
printer is somehow unable to print.

> Here is the output of 't' magic sys request:
>
> https://pastebin.com/fjbRuy4f

It looks like the call trace for the printing kthread (pr/ttyAML0) is
corrupt.

Could you post your kernel config?

John
