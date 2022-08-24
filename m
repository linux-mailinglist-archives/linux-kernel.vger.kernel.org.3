Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4465A02F1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 22:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240480AbiHXUpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 16:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240513AbiHXUpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 16:45:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1296CD0C;
        Wed, 24 Aug 2022 13:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eqQWDjHaQuGpWOa4CnuXI4KbaNFs6ksNSVJf2o0PQfE=; b=BYcBMBIR6pOmIKMGUumetL0QM/
        xQZN603yYDYaGKWIbzF6nv+ixe5XhStf3F6RD/P6rXC4kzDjKIB3tUjo8Zwh/IHHT9myA5TEvjpdG
        x2dtBTlWlP5SoI+oBUuk0KqRt3akOTDxCYVi1XnSYZ0QYzKwtIK7OcWUp39x1YGlAp3JNqlRlWpZY
        YvSPAEgGPdWEBVgD1ePH7s5jslkDlJLCROhnp+8329NEBbH+xdihcFxQSEbLsHSjddZU5ONnVU4CF
        /3MmF7kEiC8jsqrf4R3PNdDquCCtwsrhQVa/9el9BrkfLjFOF8j4STsT5UGL9f/zQjRGd/JsTCz61
        x59QT5UQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQxFT-00GfYq-59; Wed, 24 Aug 2022 20:45:15 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7A083980403; Wed, 24 Aug 2022 22:45:12 +0200 (CEST)
Date:   Wed, 24 Aug 2022 22:45:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Michael Matz <matz@suse.de>, linux-toolchains@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/sev: Mark snp_abort() noreturn
Message-ID: <YwaN2HtMyM0YEdSB@worktop.programming.kicks-ass.net>
References: <20220824152420.20547-1-bp@alien8.de>
 <20220824172929.GA25951@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824172929.GA25951@gate.crashing.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 12:29:29PM -0500, Segher Boessenkool wrote:
> Hi!
> 
> On Wed, Aug 24, 2022 at 05:24:20PM +0200, Borislav Petkov wrote:
> > Mark both the function prototype and definition as noreturn in order to
> > prevent the compiler from doing transformations which confuse objtool
> > like so:
> > 
> >   vmlinux.o: warning: objtool: sme_enable+0x71: unreachable instruction
> 
> Would -Wmissing-noreturn have caught this?  It sounds like you need this
> (and then fix all resulting warnings) to not upset objtool?
> 
> It is nice to have this anyway (if there aren't a zillion false
> positives), but it seems objtool is very fragile.

Well, just like gcc has noreturn heuristics so has objtool, it just
turns into pain when they don't agree with one another.

Ideally noreturn would be reflected in the object file so we don't have
to guess at it. STT_FUNC_NORETURN would do I suppose, except then all
the tools will need to be taught how to deal with that, which is also
very painful.

Another options is something like .symtab.noreturn which is another
symbol table explicitly listing the noreturn functions. Since it's an
extra section tools that don't know about it can freely ignore it and
carry on as usual.
