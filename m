Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B589518D08
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240293AbiECTSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 15:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiECTST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:18:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59F63FBC5
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 12:14:46 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651605285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q6tI8vR0YuSpmVwH6PHCfJgGfXuGMuhIaoQrWI4CdGw=;
        b=nJKRf3Pj9dvK/EarBtS+yl7zuJVIGKBafsjSHGSfGV6ooXPgHTjjoLW2YwmX0bqScFTCMt
        GtwhyTQmf9gaNKGTK2bZnJi1OQHJ2u3IZfNpjlVvWelgS5jcE/WHWCujpupa9sYhzdUH8s
        FL16iFJUMBGxlbcE/slkl9sVLTJ8g/ydgaVlgbz6wljgg7AI7k4N9MAD/mYpREI3PMhZ1p
        bkknx+tkcF0XpC7aAmSjzIAJhdn0Cd0eD3SABQDy4LopbL+NnwU1LO/Kw0paoXc4oft1wf
        3/Pdo737DoNtTAeiTDPBLMNigNkjYgs7Vds7cig7Zdo5kI6Opo1rb3P2m5XXnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651605285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q6tI8vR0YuSpmVwH6PHCfJgGfXuGMuhIaoQrWI4CdGw=;
        b=lIcRAQpKhjnsR49SdKQ/d3gXD31jILuoQ9RGrLkFWGDx96L1Vgfyk3UgaUWy0jE8mW7cKj
        2eFnA50g7UBtIICA==
To:     Marco Elver <elver@google.com>, elver@google.com,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Johannes Berg <johannes.berg@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH -printk] printk, tracing: fix console tracepoint
In-Reply-To: <20220503073844.4148944-1-elver@google.com>
References: <20220503073844.4148944-1-elver@google.com>
Date:   Tue, 03 May 2022 21:20:44 +0206
Message-ID: <87r15ae8d7.fsf@jogness.linutronix.de>
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

On 2022-05-03, Marco Elver <elver@google.com> wrote:
> One notable difference is that by moving tracing into printk_sprint(),
> the 'text' will no longer include the "header" (loglevel and timestamp),
> but only the raw message. Arguably this is less of a problem now that
> the console tracepoint happens on the printk() call and isn't delayed.

Another slight difference is that messages composed of LOG_CONT pieces
will trigger the tracepoint for each individual piece and _never_ as a
complete line.

It was never guaranteed that all LOG_CONT pieces make it into the final
printed line anyway, but with this change it will be guaranteed that
they are always handled separately.

I am OK with this change, but like Steven, I agree the the users of that
tracepoint need to chime in.

Acked-by: John Ogness <john.ogness@linutronix.de>

The ongoing printbuf/seq_buf work [0] will hopefully someday do away
with LOG_CONT altogether.

John

[0] https://lwn.net/Articles/892611
