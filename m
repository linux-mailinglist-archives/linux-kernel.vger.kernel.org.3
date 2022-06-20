Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EBA552468
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 21:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243937AbiFTTKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 15:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbiFTTKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 15:10:41 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E2715FE8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 12:10:41 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id e2so5472759edv.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 12:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kUp+PNGmopa6wjJCCYe5rc5X0y2p8CQaDjakccGgBqc=;
        b=P1LdsubHPnGb+GxDamKofLnsHDYsAiklGk2GhwXCbH99SXMUBreN61DHgfRC6PtBO4
         CG1xa4VYDygLjA2F7wWoioMY1rgP1CVzghmtfY7nvfyiXel2ZOSbCLhmmulUO1H/FgBs
         KgGYJXizbcsHWriiYd2cYjnksf3rafSYimv50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kUp+PNGmopa6wjJCCYe5rc5X0y2p8CQaDjakccGgBqc=;
        b=NgY4xKi9zm4dBGuL4BWUGwupUcCjWY3CsL78GXygDT6BlluOqz+Rsu56MVVznpghIF
         n3VRUTpL651d3FFgT6kRd2+zS6VEXDyuBV59hdpYo+EjBgGCmK2CKTB/z87pj5YJuPT2
         rgxitLa6YUDtYpf8dhu73KdkxrXs/paEotf6NAKmZi1RXFMu0r3U5qz6APCJI8TsOK0U
         1T4UuwsrTNMqNNex1CYmTQQVgqP3CUm40NtYgYyxjudifHXIXxXR62SdSRwmRy9nP7ia
         Iid+e7v1UJcq3yLklajmejHDejtENyOur9qdC0TXTBCag+5hGwLmB8FeGmUMJm2igDMO
         yUUA==
X-Gm-Message-State: AJIora8dfsMn9QnK6mOXEb9WGQQ2nqUfnU88Vu2Co6cbL6n0MVMQhr8M
        dNAfAWT1Wje7tsx2uAsb3M84UtAqrncdPrSc
X-Google-Smtp-Source: AGRyM1sfAuQmUBE64vvd5n4mrB+Z82HCmrw7zCs8K49DooO+6CFvPmJECYzYRBSdq37NfM/b7LEcNQ==
X-Received: by 2002:aa7:de1a:0:b0:435:7d11:9717 with SMTP id h26-20020aa7de1a000000b004357d119717mr10530774edv.148.1655752239358;
        Mon, 20 Jun 2022 12:10:39 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id s15-20020a056402520f00b004358243e752sm3016411edd.5.2022.06.20.12.10.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 12:10:38 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id z17so6318041wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 12:10:37 -0700 (PDT)
X-Received: by 2002:a1c:5418:0:b0:39c:3552:c85e with SMTP id
 i24-20020a1c5418000000b0039c3552c85emr36938022wmb.68.1655752237024; Mon, 20
 Jun 2022 12:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220619204949.50d9154d@thinkpad> <87r13kwawb.fsf@jogness.linutronix.de>
 <20220620112936.48fcb2a4@thinkpad> <YrBdjVwBOVgLfHyb@alley>
 <CAHk-=wgdquXVVE37CZooVK4X+YdSa7XoGtjr71CEYh8UsdKUow@mail.gmail.com>
 <YrCDNqsPrY+Hs9ju@alley> <YrCO04oNncE1xF5K@alley>
In-Reply-To: <YrCO04oNncE1xF5K@alley>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Jun 2022 14:10:20 -0500
X-Gmail-Original-Message-ID: <CAHk-=whBSrixcBVoWGnU0eoaksp82gnQ9_1jMNZsCzhLXEgEpw@mail.gmail.com>
Message-ID: <CAHk-=whBSrixcBVoWGnU0eoaksp82gnQ9_1jMNZsCzhLXEgEpw@mail.gmail.com>
Subject: Re: [PATCH] printk/console: Enable console kthreads only when there
 is no boot console left
To:     Petr Mladek <pmladek@suse.com>
Cc:     =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 10:14 AM Petr Mladek <pmladek@suse.com> wrote:
>
> The console kthreads uncovered several races in console drivers.

I really want to make it clear that this was NOT some kind of "races
in drivers".

Console drivers may very well  have intentionally avoided taking locks
for console output, since the printk output was supposed to be
serialized by printk.

Don't try to make this some kind of "buggy drivers" thing. This is on
printk, not on anything else.

Assuming this solves all issues, I'm ok with this approach, but I
really want this to be clearly about printk being buggy, no "blame the
drivers" garbage.

And if there are other issues coming up, we revert the whole thing entirely.

Because printk is too important to play games with, and too important
to try to blame drivers.

               Linus
