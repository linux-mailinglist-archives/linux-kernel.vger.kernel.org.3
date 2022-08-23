Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5F259D105
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 08:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240471AbiHWGGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 02:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239875AbiHWGGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 02:06:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9408A5F21C;
        Mon, 22 Aug 2022 23:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LV4bxumI+vK3fc/0MRDnOmmxXRYWHIYMbRz3zuQBKIc=; b=qnanjZ6fTwjqR7DgFGNwbwZx2s
        PfavNZy32n86p2aVvcoVXQqc2aIsas3Cz0b+jgK7UCu1q3IX0KoA5Qxh5O9gTeAqG/i6IGRztabh8
        tMm6xuoqkxvHAQUkaKnD9L0jhOxMWhRFjCtBHoc2h3gD1ZlMGyUfZBbs/LXA7y1zkWPo5OtAapdb7
        bBi/DxOAuEseO7LnubF907TPakpi2+GPukkqE6qw968aiegpreUmRkDWWJLJMxJsoaAeU+EObZ8Wt
        LzkrhvrQqqCQORDlb0qDaGlDv/U0CDSWt0CaP/Fh7JqSGdOIBhdlirizJj1IocYNNg8Yqtl0ulx0K
        OgdHM/DQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQN3J-00F0f6-2L; Tue, 23 Aug 2022 06:06:17 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E3579980403; Tue, 23 Aug 2022 08:06:15 +0200 (CEST)
Date:   Tue, 23 Aug 2022 08:06:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Fangrui Song <maskray@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3] kbuild: add debug level and macro defs options
Message-ID: <YwRuVywxTxPiIKbM@worktop.programming.kicks-ass.net>
References: <CANXV_XwgZMCGXijfoUyZ9+KyM6Rgeqiq-sCfubyj_16d-2CN=A@mail.gmail.com>
 <20220815013317.26121-1-dmitrii.bundin.a@gmail.com>
 <CAKwvOdnnSAozX8bQ9HeSw12BV9OjpzyDmXk_BGczjVVQNN+7tQ@mail.gmail.com>
 <CANXV_Xw2wzwDdJkyV1nHPQm2JTt48SLrNc7YwrfcxOwuFA-z3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANXV_Xw2wzwDdJkyV1nHPQm2JTt48SLrNc7YwrfcxOwuFA-z3w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 20, 2022 at 01:52:04AM +0300, Dmitrii Bundin wrote:
> On Fri, Aug 19, 2022 at 8:42 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > Is any of this really necessary?
> 
> Consider the case if CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y.

Can I just say I *HATE* that thing? It uesd to be I could do:

../scripts/config --enable DEBUG_INFO

and I'd get a debug-info build, now I gotta use that horrible piece of
crap you just mentioned which I mis-type at least once every single
time.
