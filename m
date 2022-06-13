Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DB9548253
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240191AbiFMIaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240133AbiFMIaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:30:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015841EEEE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 01:30:05 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655109004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6YfnLzYsqZtamSjbgNwE+1ANi1MPYoPaKZoAdpL94tw=;
        b=hMmvLEA9wdH4JtDJgIxNxkW2RXXNNGD8Lr77myJVcqgaQ63kOnywlv0jw6uxfeP46TUdI/
        1TMf8TFZiecKgBBYJe1epnQSfxYGBvuWZui8dlkAbwsGnFCtMdUSqnBo+7cpH2b9iVHec7
        fW4aymmZXiD+Y8IJbFPmg70Mqnz9p+qLrGWkO+6QxGiAfeiUpFqlw3/FBcaRGrmbJSWfWs
        zSvMNsUfOSMihPMQdWDcujqv89AVPaajgxtsEY0+aumTkEHoP6PgPqLRKkUX/UU7bqGJkL
        nfhAUb1LAvIghjXQNW1VhLZmjV6waAO+4Zr4rjZw1cT8OGNV2AsLO74pQ1Ib0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655109004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6YfnLzYsqZtamSjbgNwE+1ANi1MPYoPaKZoAdpL94tw=;
        b=2oMoKyLTPflIXvN07qwsObNwKxLTDbvA8y9Jb7G9YBK/VlwEC+s+JMYPZ/LVx/9DuoRTkC
        ckDyn8X8BQQEwCCQ==
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Subject: Re: [BUG] Threaded printk breaks early debugging
In-Reply-To: <Yqazr060OLp2Rpbk@google.com>
References: <CAMdYzYpF4FNTBPZsEFeWRuEwSies36QM_As8osPWZSr2q-viEA@mail.gmail.com>
 <87y1y48spg.fsf@jogness.linutronix.de> <YqVZ4CyWTiDgngkA@google.com>
 <8735g9mqo0.fsf@jogness.linutronix.de> <Yqazr060OLp2Rpbk@google.com>
Date:   Mon, 13 Jun 2022 10:36:04 +0206
Message-ID: <87wndlge43.fsf@jogness.linutronix.de>
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

On 2022-06-13, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
>> > Should a situation when we have only one online CPU be enough of a
>> > reason to do direct printing? Otherwise we might not have CPUs to
>> > wakeup khtread on, e.g. when CPU that printk is in atomic section for
>> > too long.
>> 
>> IMHO, no. Especially in that situation, we do not want printk causing
>> that atomic section to become even longer. If the machine has entered
>> normal operation, we want printk out of the way.
>
> At the same time printk throttles itself in such cases: new messages are
> not added at much higher pace that they are printed at. So we lower the
> chances of missing messages.

That is true if there is only 1 printk caller. For SMP systems with
printing handovers, it might not help at all. I firmly believe that
sprinkling randomness into printk (i.e. system) latencies is not the
answer. We need to keep printk lockless and out of the system's way
unless there is a real emergency happening.

This particular thread is not about missed messages due to printk not
"throttling the system", but rather the kernel buffers not getting
flushed in an emergency. This, of course, needs to be properly handled.

John Ogness
