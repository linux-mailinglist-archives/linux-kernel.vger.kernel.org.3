Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DC74C6955
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 12:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbiB1LGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 06:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiB1LGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:06:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1320E27170
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 03:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dz6qK9THBXNx47QlkmlmkFdR+PsiS+lbm9R8dnl18zI=; b=MNgflNy3N5H2WGSa7oyZa8vSbR
        /46FugsmNbOyiuQNkk5ECP6piunzZF++xCDMQ3c6AUGxXtvTa30VhuWqQI93ytHFE/DzGfOdcvFva
        0/ky/ok+OIep0XLy2Ah4GmlnRmM706D2Ziq3VtXJmfMawc0gtc5r8KX+jDDhYf6/pAOgkUaFF3710
        zltxspiNZMBvXWTyec6eDZV/TWzGtSXE0T2eodASRT98LEDLoYRipnxST5xkpArZwxfEUdgCbLFjG
        cnoosGVfsYwyy/sDbPbdLewo5mUgGVhCeTRRLrbrv8a5tAB4GZmsTIoW7lk7Dg0RDVV9e256KUE4x
        aZBlBhjQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOdq1-008Qxo-R8; Mon, 28 Feb 2022 11:05:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 27BB93001C3;
        Mon, 28 Feb 2022 12:05:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 62D6F307D8483; Mon, 28 Feb 2022 12:05:06 +0100 (CET)
Date:   Mon, 28 Feb 2022 12:05:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: Re: [PATCH 21/29] objtool: Rename --duplicate to --lto
Message-ID: <YhysYkcfwLr68Job@hirez.programming.kicks-ass.net>
References: <20220218164902.008644515@infradead.org>
 <20220218171409.814392411@infradead.org>
 <20220226194209.bvv3t65hhtnwltmk@treble>
 <20220226214802.4chmsrtstlerefmu@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220226214802.4chmsrtstlerefmu@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2022 at 01:48:02PM -0800, Josh Poimboeuf wrote:
> On Sat, Feb 26, 2022 at 11:42:13AM -0800, Josh Poimboeuf wrote:
> > > +	OPT_BOOLEAN(0, "lto", &lto, "whole-archive like runs"),
> > 
> > "--lto" is a confusing name, since this "feature" isn't specific to LTO.
> > 
> > Also, it gives no indication of what it actually does.
> >
> > What it does is, run objtool on vmlinux or module just like it's a
> > normal object, and *don't* do noinstr validation.  Right?

How about --whole-archive, much like the linker then?

The distinction is that we run objtool *only* on vmlinux and modules and
not also on the individual .o files.

There's 3 models:

 A) every translation unit
    (module parts get --module)

 B) every translation unit + shallow vmlinux
    (module parts get --module, vmlinux.o gets --vmlinux)

 C) vmlinux + modules
    (modules get --module, vmlinux.o gets --vmlinux
    --duplicate/lto/whole-archive, pick your poison).


objtool started out with (A); then for noinstr validation I added a
shallow vmlinux pass that *only* checks .noinstr.text and .entry.text
for escapes (B). This is to not unduly add time to the slowest (single
threaded) part of the kernel build, linking vmlinux.

Then CLANG_LTO added (C), due to LTO there simply isn't asm to poke at
until the whole-archive thing. But this means that the vmlinux run needs
to do all validation, not only the shallow noinstr validation.
--duplicate was added there, a bad name because it really doesn't do
duplicate work, it's the first and only objtool run (it's only duplicate
if you also run on each TU, but we don't do that).

Now with these patches I need whole-archive objtool passes and instead
of making a 4th mode, or extend (B), I chose to just bite the bullet and
go full LTO style (C).

Now, I figured it would be good to have a flag to indicate we're running
LTO style and --duplicate is more or less that, except for the terrible
name.

> > It's weird for the noinstr-only-mode to be the default.
> > 
> > BTW "--duplicate" had similar problems...
> > 
> > So how about:
> > 
> > - Default to normal mode on vmlinux/module, i.e. validate and/or
> >   generate ORC like any other object.  This default is more logically
> >   consistent and makes sense for the future once we get around to
> >   parallelizing objtool.
> > 
> > - Have "--noinstr", which does noinstr validation, in addition to all
> >   the other objtool validation/generation.  So it's additive, like any
> >   other cmdline option.  (Maybe this option isn't necessarily needed for
> >   now.)
> 
> It just dawned on me that "--noinstr" already exists.  But I'm
> scratching my head trying to figure out the difference between
> "--noinstr" and omitting "--lto".

If you run: "objtool check --vmlinux --noinstr vmlinux.o", it'll only do
the shallow .noinstr.text/.entry.text checks. If OTOH you do: "objtool
check --vmlinux --noinstr --lto vmlinux.o" it'll do everything
(including noinstr).

Similarlt, "--module --lto" will come to mean whole module (which is
currently not distinguishable from a regular module part run).

(barring the possible 's/--lto/--whole-archive/' rename proposed up top)


