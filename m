Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F084157BEB1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbiGTTgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236244AbiGTTgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:36:41 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C726392D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:36:40 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id b7-20020a17090a12c700b001f20eb82a08so3044369pjg.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j+rbnmIVttFmz/uuShV8y1jg3drpXSzAEs8pdF4t6As=;
        b=hcyVGQqH/qxwqhCq/lVqNZAlqOACilKr+0G2pQqrCX/SercLmJnbXLSAY5ypWfLg5j
         a59eub7SkrFb7g3s0HWIm1Ikjuw21iznx3UuZCbIKhIVXtxp3CLwy9rrzlIzOG22Rciy
         nTVslGl78duDRWDIw+wC+z0roIBt7pm5KtCds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j+rbnmIVttFmz/uuShV8y1jg3drpXSzAEs8pdF4t6As=;
        b=A9ksIcmy6rJif/k2DkyrFPvwR0FKrCOMZn+3CjXWUy4dwhHTDyW/2ij5n9/hcBU5tl
         Qg7HXyyAbdZabCm2gxtlV6lfIVUBTaa1aaBIhK6lQy2N3je4vCvWQQaJjmKCdacE+Bx4
         aoln9Rgj5ipuQn0h65PSeznpUrQwOiZr7azlyTLu8OLIxBmus6kOqdo4zbwKFkUlORUt
         WPsQl1Tybt8aD7sgVV/3s/tM7I1VvqHx2Ojg+sus8r0UPLNyZt58q/pXqctxCukAuXVk
         f4W02QNKYXnqM11WsxLpw/Nw8wNAQDQc/11nF2yQFu8koY8UVAqeZyYQVwNWvz31sUQF
         sVcQ==
X-Gm-Message-State: AJIora875x49JVFdfQBegzC+Ts3aVL1cQtE7BfEx41H36MUS2UhpTAku
        g7Wq91SW9BRuyyJto3+SZMz4iQ==
X-Google-Smtp-Source: AGRyM1sf5sbpu023/Byq7O8KWjtma+4og+RS9AgyOLGCQQXsSH+0i9wnKbn3wOJRkAQ5cd0P2FaY2A==
X-Received: by 2002:a17:902:b7c4:b0:16b:e3d0:c0fe with SMTP id v4-20020a170902b7c400b0016be3d0c0femr39897632plz.98.1658345799713;
        Wed, 20 Jul 2022 12:36:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ru6-20020a17090b2bc600b001f229f8d7bdsm192698pjb.16.2022.07.20.12.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 12:36:39 -0700 (PDT)
Date:   Wed, 20 Jul 2022 12:36:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
Message-ID: <202207201219.8EA905372@keescook>
References: <20220716230344.239749011@linutronix.de>
 <20220720125736.48164a14@gandalf.local.home>
 <CAHk-=wh=Yjy=DmGzzGj-ivyx_w45AHh35eDkpGtajaiO+TX38A@mail.gmail.com>
 <Ytg6UD+0F6zv981o@worktop.programming.kicks-ass.net>
 <20220720135016.3178ffc6@gandalf.local.home>
 <CAHk-=wjdQbdQGKkQxxEcWoUp4SRmBWm=3bS20SbaVe8cLgKLgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjdQbdQGKkQxxEcWoUp4SRmBWm=3bS20SbaVe8cLgKLgg@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 11:07:26AM -0700, Linus Torvalds wrote:
> On Wed, Jul 20, 2022 at 10:50 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > [    2.464117] missing return thunk: lkdtm_rodata_do_nothing+0x0/0x8-lkdtm_rodata_do_nothing+0x5/0x8: e9 00 00 00 00
> 
> Well, that looks like a "jmp" instruction that has never been relocated.

Peter, Josh, and I drilled down into this recently[1] and discussed
some solutions[2].

This test is doing what's expected: it needed an arch-agnostic way to do
a "return", and when the way to do that changed, it also changed (which
would normally be good, but in this case broke it). It's been happily
being used as part of the per-section architectural behavior testing[3]
of execution-vs-expected-memory-permissions for quite a long while now.

I'd rather not remove it (or do it dynamically) since the point is to
test what has been generated by the toolchain/build process and stuffed
into the .rodata section. i.e. making sure gadgets there can't be
executed, that the boot-time section permission-setting works correctly,
etc. Before the retbleed mitigation, this test worked for all
architectures; I'd hate to regress it. :(

-Kees

[1] https://lore.kernel.org/lkml/Ys66hwtFcGbYmoiZ@hirez.programming.kicks-ass.net/
[2] https://lore.kernel.org/lkml/20220713213133.455599-1-keescook@chromium.org/
[3] e.g. https://linux.kernelci.org/test/plan/id/62d61ee8ef31e0f0faa39bff/

-- 
Kees Cook
