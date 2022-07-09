Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D5656CB67
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 22:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiGIUl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 16:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGIUlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 16:41:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED61DE92;
        Sat,  9 Jul 2022 13:41:24 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657399282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7XCPZYdFJvPl/+Lq/KH22t+YauCj8En8BB2tojor6b8=;
        b=HeLcSAxQmEJQcC6GvlmkZDTH5ZtG49b3ykeV2EIVRUeI2rxgNIyKXJKs9ryRVK7rXZmH88
        wKwSW37aO9U+f6rLRLzBhwuMmyjG4xfQ81koAon7+3SscTt6TLu21zzU9CCEGtGzDnps44
        2AtxdanRGr/145a5chmNqB4ThE6VXAUtKZYd00n1Q2bDHbXoVmeIaU6q3SHcc+IxqKZ4K5
        +Dw7hjQjyNikDpbTrKqx8qoiK+qncNhRdj+UdzosVyE+6i1eA+mif4cuIR2nqQ/2isQu2e
        L94b7sxYxgmULo5UTSz4wob6xvkKWQBffqKWAxlXH41mTncZYDFX2j6gqXHFKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657399282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7XCPZYdFJvPl/+Lq/KH22t+YauCj8En8BB2tojor6b8=;
        b=CDcPk9JxNXrHs6qzr3ETW9n1LgZiKi2wz+2s6K3eAe0PAiq/G1DNqmZcGJ089Wa6piWAla
        INv1+CdxaMjuJEDQ==
To:     todd.e.brandt@linux.intel.com, pmladek@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        senozhatsky@chromium.org, rostedt@goodmis.org
Subject: Re: PNP0501 serial driver takes almost 2 seconds to suspend/resume
 (printk issue)
In-Reply-To: <045ebee30af2b80aaeace1dab18ecd113e3f17c7.camel@linux.intel.com>
References: <12fb98fe27e23e3f74a139e5e8eb83a97a343372.camel@linux.intel.com>
 <51b9e2cc3baf61a604bd239b736ec2d12f1f6695.camel@linux.intel.com>
 <87czegxccb.fsf@jogness.linutronix.de>
 <045ebee30af2b80aaeace1dab18ecd113e3f17c7.camel@linux.intel.com>
Date:   Sat, 09 Jul 2022 22:47:21 +0206
Message-ID: <87tu7qvx1q.fsf@jogness.linutronix.de>
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

On 2022-07-08, Todd Brandt <todd.e.brandt@linux.intel.com> wrote:
> The dmesg logs are in the html timelines themselves, just click the
> "dmesg" button in the upper right hand corner. The log button shows
> all kinds of system info as well.

Since the beginning of the kernel log is missing, I still do not see
information about which serial driver you are using. But since it is
x86, I'll assume it is an 8250.

Looking at freeze-5.19.0-rc1-bad.html, at 3431.221039 we see that
suspend_console() was called. The additional 1-second delay you are
referring to would be 3432.436187, where serial is suspended. pr_flush()
would have been satisfied when the message at 3431.221039 was
printed. So the question is, why is there still printing going on?

@Todd: I assume you actually see all the messages up to and including
3431.506391 when it suspends? But the next message does not appear on
suspend?

I wonder if the console_lock()/console_unlock() within __pr_flush() is
allowing extra printing to occur, for example if another CPU was calling
printk.

@Todd: Could you build your kernel with CONFIG_PRINTK_CALLER enabled?
Also, please provide the last line you _see_ after a suspend. And
finally, please make sure you are using the latest 5.19-rc. Thanks!

John Ogness
