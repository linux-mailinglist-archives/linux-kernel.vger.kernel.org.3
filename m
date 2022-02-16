Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B7A4B8785
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 13:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbiBPMZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 07:25:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiBPMZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 07:25:00 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1073E27AA09
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 04:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KwpwEmg3Ay1xR1OpUdJFEpmOJDMHbZm34VOni0D55fE=; b=bxlC7Hk92JLtUG4P6uFvkF7ZwT
        vV5rij/EihMTPNuwhQTsQAced9u7zDEOR0fWZpIPvIIvrQj34YxJ165OYQeezvzA2OyHHwr1u4LPD
        2YDycurAhC69LeI7uOc7aUsrNn1ACcbOpIjL3AgPwTecM99I1r/0iNCo2zm4QYOC4dAJ0SJse8CV8
        Cl2J4CZhJzSMEHdke3Ez9Zf2AO6gPBgzAq5qnVDIpGSkD3KadBZqlloUf/huUnvlOQlnSAiXGgmOL
        9NXiA4XzKLSYk0o+ZDFfqv9extucWJOaiZq9tcqIHKApT2yei6Fbc9AzeUcwt5POhEElpYxowOLpm
        +oD0CeBg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKJMH-00AIir-8L; Wed, 16 Feb 2022 12:24:33 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 08BA9986ACA; Wed, 16 Feb 2022 13:24:30 +0100 (CET)
Date:   Wed, 16 Feb 2022 13:24:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        X86 ML <x86@kernel.org>, hjl.tools@gmail.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        andrew.cooper3@citrix.com, LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Subject: Re: [RFC][PATCH 6/6] objtool: Add IBT validation / fixups
Message-ID: <20220216122429.GB86719@worktop.programming.kicks-ass.net>
References: <202202081541.900F9E1B@keescook>
 <ad6c2633f39e39583bc5c5eaf7ccbe52@overdrivepizza.com>
 <202202082003.FA77867@keescook>
 <9ea50c51ee8db366430c9dc697a83923@overdrivepizza.com>
 <20220211133803.GV23216@worktop.programming.kicks-ass.net>
 <CABCJKuciRBnz4JxBDJC=+kuJn4pU2uBkWPBov7-VL2o2j0F4SA@mail.gmail.com>
 <20220214222550.GB23216@worktop.programming.kicks-ass.net>
 <CABCJKuf-wouSCh4u43GPQHPPgG=mqOGboSoHPQRfmgQSBkFrMg@mail.gmail.com>
 <202202151129.1A5C5FE42@keescook>
 <20220215210550.GD23216@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215210550.GD23216@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 10:05:50PM +0100, Peter Zijlstra wrote:

> > Peter, is there a reason you want things in the specific order of:
> > 
> > cmp, je-to-call, trap, call
> > 
> > Isn't it more run-time efficient to have an out-of-line failure of
> > the form:
> > 
> > cmp, jne-to-trap, call, ...code..., trap, jmp-to-call
> > 
> > I thought the static label stuff allowed the "default out of line"
> > option, as far as pessimizing certain states, etc? The former is certainly
> > code-size smaller, though, yes, but doesn't it waste space in the cache
> > line for the unlikely case, etc?
> 
> Mostly so that we can deduce the address of the trap from the retpoline
> site, also the above has a fairly high chance of using jcc.d32 which is
> actually larger than jcc.d8+ud2.

Also; and I think I mentioned this a few emails back, by having the
whole CFI thing as a single range of bytes it becomes easier to patch.
