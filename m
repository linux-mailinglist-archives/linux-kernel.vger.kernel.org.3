Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E63563133
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbiGAKSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235404AbiGAKSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:18:09 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81001AC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 03:18:07 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id o23so2002469ljg.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 03:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cIolBCU7gcHiWTJ7Gpz8DTqiA6rqBEHvQmHzGRqousg=;
        b=Tsu50rHkMeDdYBlop1NXOkXacqld+/mROcbAkLLL9IKpVpS0O3IMeEC6FDNB9QY+Cp
         cpVOpFWBaz9xIVZjtXFyQBP4RcWq7dtN/dMivs5vyH0EiZItaddL0DTr+mlDqx4HRBcV
         gjNgyNT2mAKgIRG+ywfq4XeeqVHO4HGodUM5fPjc0rEaFB+Kw5XeQsMbbNuuC/4kLguA
         eRrc6ZZkUt6ZCDHu/b/5XUr9OJalXfaYStCIapCM2GkCXVxYKUu/sJKlGg7o18UvQQXh
         EKVzTOymN4rDUGUQPsqDOljADJSq9ZN3tOlLt3W4YJxchaCvp38lp+XkUv/tTuYyhrsw
         XGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cIolBCU7gcHiWTJ7Gpz8DTqiA6rqBEHvQmHzGRqousg=;
        b=ToHCFdkcfSQAepvrqDj1TcCITspjfwFO6B/DVVIGF6CJGWwEKLEvr/Jbx+nS+wZ2d9
         doGY415puTDpjdaGqj+rvkTrqPexWq1kc8KWrrKxSO4a0Q1xpg1lnVRb/SCJTXTJkcEu
         xJSADtgT9bzsquMgikY1qvLOo7HbpJsEG5gZJ56JiW1uuTpcl8G6HDpecMK7orQ0mRFT
         NVMmG1SxA5u2SD2OHmDzgOh7M1OyF8DraSjo9MhNQHtj1VQo2ld/vogCpr7f1+ZMsUDW
         UWlm37k9+3vgUjZOlCNxtXio27lcunOQ1CLtSp+Svhw1vu6dgeFZzIcFT+yUSMDH99Hn
         qmAg==
X-Gm-Message-State: AJIora8j7l3DuVSdZPy6utPXbnsSkFRfIIpp5Mr4aJgCQ2c8eBhWYZ94
        jHqipvbWAJr3j8nQAzvYLbthbaMps02S2ueeVOcB
X-Google-Smtp-Source: AGRyM1t3lOfOZoHXwVnMDWhboz8bguGORAaLuR/2mXXUBqIljjrfUi+TFS8tmnoskTXPHfF5tw9dISFc3NVLOay3d08=
X-Received: by 2002:a2e:8794:0:b0:25a:69cc:382d with SMTP id
 n20-20020a2e8794000000b0025a69cc382dmr7582956lji.424.1656670685813; Fri, 01
 Jul 2022 03:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdkyY9rsH3eViMK-_4iz_W_usumz5nD+3AhbNCVQ3FRCjA@mail.gmail.com>
 <CAKwvOdnsZekEM77axBf67MDqQVP0n6PTKH=njSyPSWTNiWAOiA@mail.gmail.com>
 <87mtf7z0rt.fsf@gnu.org> <6F9E9D93-3913-4022-9384-D809C8EF7715@oracle.com>
 <CAKwvOdm=_YqBpuBzouqoWHYNe6MMUE10vqF0PUkU=hcOj+UqrQ@mail.gmail.com>
 <B0A01DE7-1B50-479A-92DF-DAFAB3F06E0F@oracle.com> <878rpgpvfj.fsf@gnu.org> <Yr638aOIaaEBPICy@worktop.programming.kicks-ass.net>
In-Reply-To: <Yr638aOIaaEBPICy@worktop.programming.kicks-ass.net>
From:   Bill Wendling <morbo@google.com>
Date:   Fri, 1 Jul 2022 03:17:54 -0700
Message-ID: <CAGG=3QWbW-Dang49Jx3fyNExWtL8syuMkMJmcPHA7J25cHQ0zw@mail.gmail.com>
Subject: Re: plumbers session on profiling?
To:     Peter Zijlstra <peterz@infradead.org>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 1, 2022 at 2:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jun 28, 2022 at 07:08:48PM +0200, Jose E. Marchesi wrote:
> >
> > [Added linux-toolchains@vger in CC]
> >
> > It would be interesting to have some discussion in the Toolchains track
> > on building the kernel with PGO/FDO.  I have seen a raise on interest on
> > the topic in several companies, but it would make very little sense if
> > no kernel hacker is interested in participating... anybody?
>
> I know there's been a lot of work in this area, but none of it seems to
> have trickled down to be easy enough for me to use it.

We use an instrumented kernel to collect the data we need. It gives us
the best payoff, because the profiling data is more fine-grained and
accurate. (PGO does much more than make inlining decisions.)

If I recall correctly, you previously suggested using sampling data.
(Correct?) Is there a document or article that outlines that process?

-bw
