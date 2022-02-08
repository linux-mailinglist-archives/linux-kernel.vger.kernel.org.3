Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BC74AD76E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbiBHLdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349098AbiBHLII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:08:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F675C03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 03:08:07 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644318484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o5MD6xc3wwbgInMsdmlTlr0ItvXqNelSbNX5p3wAhxs=;
        b=Wj4RFg8r4U5Wvq7S1lY2cf2ALXTBAiTr4v2qubwkpJMcb7/2nWDWLwHk4AlbWM9aEH388C
        IpTFdO4zPYDLqIc4Vz5KGQhDfSk46rn0bC4D87VKgn0SHxXh7f+6njZYDv7LU1//BMxO2J
        0af892WKkfD3TZmRnUPITkrtJsJ8wVvIXGNPW3DwF/fhN+REbBzUJVY0IRH4HbHJkRDfgU
        JxPgAwmwzQf+qr3Y5PvVO2w8jeGRQY9JJdLNlTi+21wxnroKHDPPB1DsGFM97WHviaUyX1
        RyNaZa3YFp+msM79qLm7XzHtnmDKe/tiI+flv6173gLKkGRnD+0Jp0hf9OZ06Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644318484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o5MD6xc3wwbgInMsdmlTlr0ItvXqNelSbNX5p3wAhxs=;
        b=xpm9uE2KgSevyeWZ1zX0NtBDZYGapp4sNV5rlmJl3V4WWzPWZU564P2M1w8E2fW4oRdYkq
        Yd0eFsrhgKPN5mBQ==
To:     Hillf Danton <hdanton@sina.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH printk v1 10/13] printk: add kthread console printers
In-Reply-To: <20220208083620.2736-1-hdanton@sina.com>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220208083620.2736-1-hdanton@sina.com>
Date:   Tue, 08 Feb 2022 12:14:04 +0106
Message-ID: <87v8xpmx9n.fsf@jogness.linutronix.de>
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

On 2022-02-08, Hillf Danton <hdanton@sina.com> wrote:
> On Mon,  7 Feb 2022 20:49:20 +0106 John Ogness wrote:
>> Create a kthread for each console to perform console printing. During
>> normal operation (@system_state == SYSTEM_RUNNING), the kthread
>> printers are responsible for all printing on their respective
>> consoles.
>
> The code becomes simpler if the kthread is replaced with a workqueue
> work, given the system workers.

We do not want multiple console printers blocking each other. We also
would not want the consoles blocking non-printk work items for extended
periods of time. So we would likely need a dedicated worker per
console. I'm not convinced the code would look simpler just by changing
the deferred work API. But perhaps the kernel community wants to get
away from manual kthread management in general. (??)

I am now pondering if there is some technical advantages to
workqueues. I suppose with dedicated workers, you could still easily
adjust CPU affinities and scheduling policies/priorites from userspace,
like with kthreads. But is there some advantage over kthreads?

John Ogness
