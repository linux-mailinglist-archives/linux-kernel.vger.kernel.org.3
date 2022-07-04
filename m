Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819EA56582E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiGDOCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbiGDOB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:01:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F4FCE2B;
        Mon,  4 Jul 2022 07:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=piYqBJeFz7D47ap3/7x8Zet4UDXF1mtxAPCnP4s0dzE=; b=GFDrlTaniO6lVyB2FKMvwa+SVf
        jJ2V9XKZikOZ2YZsn3ZEbSIdq5cxpOfEFF16XlM8t9RImmj5r6dZiu/cJjLtenOaqLWGahIZxOlsY
        YTFMfgE6avgD+O7TCQt/FEe5nTgRj3z+EMr3ZcmHygQhZVBsEMKzIzS0OhRTva8WoSusU1l0Bq1xb
        onsQAO+Z8sLNHG24ay/3aYI/5y8lymwSor915ccm7RukhyYdSGzDxMq7qK/crSIHRjrMie4cHiGel
        M1qqFpyMumUP0YmQKHg+mfEr95KpQ5fTo7UD4pXrT1x4UvN07pQA5x5WUqqRnRtcIRQmtxu2WxFCz
        fpQuM6RQ==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8MdW-00H9PD-J5; Mon, 04 Jul 2022 14:01:15 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 60ADB980057; Mon,  4 Jul 2022 16:01:15 +0200 (CEST)
Date:   Mon, 4 Jul 2022 16:01:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bill Wendling <morbo@google.com>
Cc:     "Jose E. Marchesi" <jemarch@gnu.org>,
        Ruud van der Pas <ruud.vanderpas@oracle.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Vladimir Mezentsev <vladimir.mezentsev@oracle.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>, Yonghong Song <yhs@fb.com>,
        Wenlei He <wenlei@fb.com>, Hongtao Yu <hoy@fb.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-toolchains <linux-toolchains@vger.kernel.org>,
        elena.zannoni@oracle.com
Subject: Re: plumbers session on profiling?
Message-ID: <YsLyq5FUZj9NLy3V@worktop.programming.kicks-ass.net>
References: <CAKwvOdnsZekEM77axBf67MDqQVP0n6PTKH=njSyPSWTNiWAOiA@mail.gmail.com>
 <87mtf7z0rt.fsf@gnu.org>
 <6F9E9D93-3913-4022-9384-D809C8EF7715@oracle.com>
 <CAKwvOdm=_YqBpuBzouqoWHYNe6MMUE10vqF0PUkU=hcOj+UqrQ@mail.gmail.com>
 <B0A01DE7-1B50-479A-92DF-DAFAB3F06E0F@oracle.com>
 <878rpgpvfj.fsf@gnu.org>
 <Yr638aOIaaEBPICy@worktop.programming.kicks-ass.net>
 <CAGG=3QWbW-Dang49Jx3fyNExWtL8syuMkMJmcPHA7J25cHQ0zw@mail.gmail.com>
 <Yr7fMre18pUMz9rA@worktop.programming.kicks-ass.net>
 <CAGG=3QUA8BnhN9QaJao6nH6EyNks0yWO+cWWyvE0pJbOUm+cMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGG=3QUA8BnhN9QaJao6nH6EyNks0yWO+cWWyvE0pJbOUm+cMw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 11:57:25AM -0700, Bill Wendling wrote:
> On Fri, Jul 1, 2022 at 4:49 AM Peter Zijlstra <peterz@infradead.org> wrote:

> > IIRC Google has LBR sample driven PGO somewhere as well. ISTR that being
> > the whole motivation for that gruesome Zen3 BRS hack.
> >
> > Google got me this: https://research.google.com/pubs/archive/45290.pdf
> >
> Right. However, there's a chicken-and-egg issue with AutoFDO for the
> production kernel. We can't release a kernel that hasn't been compiled
> with PGO/FDO. We could only release it in a test environment, in which
> case we could use AutoFDO. However, the document says that AutoFDO
> only reaches ~90% of FDO. They list some reasons for this, but
> nonetheless I suspect that the delta would be too severe for us to
> release the kernel.

The pertinent question seems to be what's missing? Where does that 10%
go.

> As for LBR, that will work with Intel/AMD, but I thought that LBR
> doesn't exist for Arm processors (my knowledge could be out of date on
> this).

Not totally up to date on the ARM thing either; but I believe you're
right in that they don't yet have such a feature.

> What would make PGO (sample-based or instrumented) easy enough for you
> to use? What're the key elements missing?

The key piece missing is how to feed a perf.data file back into the
compile cycle, something like:

  $ make O=build/ PERF=perf.data -j$lots

would be useful I suppose.

