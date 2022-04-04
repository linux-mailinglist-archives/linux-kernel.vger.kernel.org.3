Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4B74F1805
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 17:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378403AbiDDPOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378450AbiDDPN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:13:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0C03B3F0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 08:12:03 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649085121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g4qpBtfBpRV9+sYYTLKcPsW2aHhtZIHLbdXJYuan7xs=;
        b=FF+ghTrcFh7nCF26TMHsl6eQ8yDsB84O8NcRizr7XGSzHSrJnoi9aDYKx8M21VMUhYKEwn
        RjIC4vRzNmMeEJZ2SPWYikZu5ZPAeZEQ3Vz1MlEl4vp6OWgcjFX09PKidrEuZPbcoZO8vY
        wLw/vCcK4xropcX1kudGVe/io8rrukx6kdKyUc/bpioxDbiXfco8FCAqwbmwxTbWaqXgcT
        QNP6SZ6WhMilKodw2G87HI3OMG0rQipQNEbZEny0b4a64TuoEuexm3+hDdtq/CwYyLIOIp
        gsc95VZHMN+t8zQpbhlxoKYDGcPgzOwPwYVtMWnCr+1r4/WZLRJxkOn7cuWHcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649085121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g4qpBtfBpRV9+sYYTLKcPsW2aHhtZIHLbdXJYuan7xs=;
        b=Xp6zglkLekmbbzNgaazqdz5IJ0Q4woe8gnmHLB3ZOuQPDnMup/r7ezqo9inSN6d+jv7s46
        2CVJ8Dv0FThB4FBA==
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH] highmem: fix checks in __kmap_local_sched_{in,out}
In-Reply-To: <20220403235159.3498065-1-jcmvbkbc@gmail.com>
References: <20220403235159.3498065-1-jcmvbkbc@gmail.com>
Date:   Mon, 04 Apr 2022 17:12:01 +0200
Message-ID: <878rskj326.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03 2022 at 16:51, Max Filippov wrote:

> When CONFIG_DEBUG_KMAP_LOCAL is enabled __kmap_local_sched_{in,out}
> check that even slots in the tsk->kmap_ctrl.pteval are unmapped. The
> slots are initialized with 0 value, but the check is done with pte_none.
> 0 pte however does not necessarily mean that pte_none will return true.
> e.g. on xtensa it returns false, resulting in the following runtime
> warnings:
>
>  WARNING: CPU: 0 PID: 101 at mm/highmem.c:627 __kmap_local_sched_out+0x51/0x108
>  CPU: 0 PID: 101 Comm: touch Not tainted 5.17.0-rc7-00010-gd3a1cdde80d2-dirty #13
>  Call Trace:
>    dump_stack+0xc/0x40
>    __warn+0x8f/0x174
>    warn_slowpath_fmt+0x48/0xac
>    __kmap_local_sched_out+0x51/0x108
>    __schedule+0x71a/0x9c4
>    preempt_schedule_irq+0xa0/0xe0
>    common_exception_return+0x5c/0x93
>    do_wp_page+0x30e/0x330
>    handle_mm_fault+0xa70/0xc3c
>    do_page_fault+0x1d8/0x3c4
>    common_exception+0x7f/0x7f
>
>  WARNING: CPU: 0 PID: 101 at mm/highmem.c:664 __kmap_local_sched_in+0x50/0xe0
>  CPU: 0 PID: 101 Comm: touch Tainted: G        W         5.17.0-rc7-00010-gd3a1cdde80d2-dirty #13
>  Call Trace:
>    dump_stack+0xc/0x40
>    __warn+0x8f/0x174
>    warn_slowpath_fmt+0x48/0xac
>    __kmap_local_sched_in+0x50/0xe0
>    finish_task_switch$isra$0+0x1ce/0x2f8
>    __schedule+0x86e/0x9c4
>    preempt_schedule_irq+0xa0/0xe0
>    common_exception_return+0x5c/0x93
>    do_wp_page+0x30e/0x330
>    handle_mm_fault+0xa70/0xc3c
>    do_page_fault+0x1d8/0x3c4
>    common_exception+0x7f/0x7f
>
> Fix it by replacing !pte_none(pteval) with pte_val(pteval) != 0.

Oops. Sorry.

> Fixes: 5fbda3ecd14a ("sched: highmem: Store local kmaps in task struct")
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
