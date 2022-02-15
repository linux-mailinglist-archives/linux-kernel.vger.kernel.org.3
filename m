Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9167A4B6D85
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 14:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238268AbiBONd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 08:33:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiBONdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 08:33:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385B0EF79A;
        Tue, 15 Feb 2022 05:33:13 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644931990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8cywgUur44ULKnZ+xJI0fUY9a++UJX4o2ooMJkUK5y4=;
        b=2Ilr8ugtsic77/WeY9XhAMjCKAi5wvkK+HKFM6zxywO6G8JERK/7jvrmv2vss/C/vDbeN7
        I7KP3R0uSzlRmfE3Gm+dnj1VXPMmtZc2aloJaCsD5wR8wWu6IzgJztOI+2BiQ4KQbhrZZA
        uHKEYDTnKzMolSBEGnhqpVQF3nXVovnaee9JgxouYgqsh+kkZMeG0jNmONgTswxNj4YOYm
        KlQwhIBW++8FbNWHKdgsSIqrx4vuUrCxYOIGT8vqBQ+7iQ4PSjnjXKXN3V/YvLjgTVYgHr
        hkXBhetyDD7aAfWnziL0HzrmU4Y79e52mnzCqP+kI7zI3oaqHlzfodNqOlilXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644931990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8cywgUur44ULKnZ+xJI0fUY9a++UJX4o2ooMJkUK5y4=;
        b=eL82VujvHibE/xA7u7NFvubjCi0sbq+twCVJ4q3TbnJLq+JCEykxUyhfTMTsngw4OpnXcn
        q87UrOhOPXyTfJDw==
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: Re: [RFC V2 12/21] rv/reactor: Add the printk reactor
In-Reply-To: <45179cdb-2391-207a-2f7b-2dea828d1606@kernel.org>
References: <cover.1644830251.git.bristot@kernel.org>
 <fad2d358d57dfffc084d482684ecc1d13b62b262.1644830251.git.bristot@kernel.org>
 <10cf6003-6d2b-056b-11bb-3ae9c342a369@linuxfoundation.org>
 <c1657d1c-0d2b-4aa3-c1ed-2ae6fdfcda86@kernel.org>
 <87v8xg30qc.fsf@jogness.linutronix.de>
 <45179cdb-2391-207a-2f7b-2dea828d1606@kernel.org>
Date:   Tue, 15 Feb 2022 14:39:09 +0106
Message-ID: <87r1842r1m.fsf@jogness.linutronix.de>
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

On 2022-02-15, Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
>> I suggest using printk_deferred() for this reactor for now. With
>> printk_deferred() the message and timestamp are immediately and
>> locklessly stored in the buffer, and the printing is performed in a
>> separate context. printk_deferred() is safe for all contexts.
>
> Question: Does it always postpone or only postpone when in a
> particular contexts, like, with irqs disabled?

printk_deferred() always postpones printing.

> Note: do not use this reactor with rq_lock taken, it will lock the
> system until printk can handle that.

Perhaps you could explain thi comment in your commit message?  printk()
should never lock the system.

John
