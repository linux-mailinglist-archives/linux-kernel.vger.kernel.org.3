Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4CA4E2E31
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351279AbiCUQjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351276AbiCUQjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:39:33 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68CF131
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:38:04 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 17so5705242ljw.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vLuZZpUnsm9KBxk/6Ba1/rk7zP3V19U4V2RRUcKnlUU=;
        b=CxLg6iI6FqAS0PFMX63IExeZr6f76g1o7l9nUfGVicC1LNk5HV1MqsTRRe9CQdmMOd
         L12XNcMd0u/oWXZrvuZ12lN0gUP/uSoxbpWa8i3E3VOJ+CG/6Swp/FYN4Mz3gKef+Fr2
         md03VSCIy+BFM1RkCswovuJY4FekLTyETX3P8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vLuZZpUnsm9KBxk/6Ba1/rk7zP3V19U4V2RRUcKnlUU=;
        b=aqUs8jylTWHKpCWPfmIQp+3jC8psRM6WSAszTe/+D9zvXmyPdZiBireaCYdjeYWY25
         5wdWtdkvJlMlFPio2/Zt6XBvzdg1VY4ziglewtYunnv1ViKLXjZK9CXtZuXm3HcVL47N
         ZJ3bryB5jqK27H56aMALfLs7vojn7sNIurfH9xoDFdXKtiVguIdrtW+XFy3fsDuJBTYY
         1lcxZBC9C4CIhBojNg2nCmDcDAEDW0UK4Efjw+f0UyHC0PPX2fGw3F5Mx6stG4Sd22o9
         hSX7lNgcaLt+/jg4ia/vKONgSH9TFXXkBeUbSCZ64ChHFllibhyWnYOnxss4CwxUdWGy
         4DGw==
X-Gm-Message-State: AOAM531CoQpglG5tPn6jYsWgN8MQ8RqxISIQ/RUg+xblrPUYIMN3HG8O
        B/5MMyS10usXrbQ6C+N/M/4aSzhQVju1FPw+
X-Google-Smtp-Source: ABdhPJy1P0wMXbA8DlMRZNr8b5AO+JCKI4ddTJhroqQYWDWGh4yJRQMROV+bkWWprCy6OiBfLvJ09A==
X-Received: by 2002:a05:651c:1501:b0:249:8d28:5659 with SMTP id e1-20020a05651c150100b002498d285659mr884101ljf.138.1647880678606;
        Mon, 21 Mar 2022 09:37:58 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id q21-20020a194315000000b0044a1e36fda4sm775823lfa.25.2022.03.21.09.37.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 09:37:55 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id h7so8053069lfl.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:37:52 -0700 (PDT)
X-Received: by 2002:a05:6512:2294:b0:448:6c86:3c78 with SMTP id
 f20-20020a056512229400b004486c863c78mr14728551lfu.531.1647880671749; Mon, 21
 Mar 2022 09:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220321140327.777f9554@canb.auug.org.au> <Yjh11UjDZogc3foM@hirez.programming.kicks-ass.net>
 <Yjh3xZuuY3QcZ1Bn@hirez.programming.kicks-ass.net> <Yjh4xzSWtvR+vqst@hirez.programming.kicks-ass.net>
 <YjiBbF+K4FKZyn6T@hirez.programming.kicks-ass.net> <YjiZhRelDJeX4dfR@hirez.programming.kicks-ass.net>
 <YjidpOZZJkF6aBTG@hirez.programming.kicks-ass.net>
In-Reply-To: <YjidpOZZJkF6aBTG@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Mar 2022 09:37:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wigO=68WA8aMZnH9o8qRUJQbNJPERosvW82YuScrUTo7Q@mail.gmail.com>
Message-ID: <CAHk-=wigO=68WA8aMZnH9o8qRUJQbNJPERosvW82YuScrUTo7Q@mail.gmail.com>
Subject: Re: linux-next: build warnings after merge of the tip tree
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        linux-toolchains <linux-toolchains@vger.kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Nick Desaulniers <ndesaulniers@google.com>
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

On Mon, Mar 21, 2022 at 8:46 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> This landing in -next only today (after having been committed last
> friday night) is another clue it should probably go next round.

I went and looked at lore to get the context that I didn't get in this
email that I was added to the participants for.

I didn't find the context there either.

Sure, I found the thread, but the whole "that x86 patch" that you
refer to was never actually specified even in the full thread as far
as I can tell. I see that there is an arm64 equivalent too of what you
are complaining about, and I have no idea about that one either..

Mind actually giving the full details so that we don't have to go
re-do the work you already did?

Because right now I know something is wrong, I know the warnings, but
I don't actually have any handle on the actual patches to look out
for.

It's presumably not in any of the pull requests I already have
pending, but it would be nice if I saw some details of _what_ you are
complaining about, and not just the complaint itself ;)

                     Linus
