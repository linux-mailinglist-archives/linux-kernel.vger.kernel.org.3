Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFF6536D40
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 16:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236544AbiE1OJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 10:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236498AbiE1OJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 10:09:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9C3B22
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 07:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VCOHMX9jiRdAcjTcL4IDCmTODDnyqXkS7joAhw5r9+Q=; b=qaxsxjTmzF3W7GA+wVwpzxNE/F
        v7XBccB/y8g0mD924I3gALXYR9sNIhmaN4ytd1qlDXcbkVQjJjzFCbac2ttdBWZMbvVPmI2GCsMOA
        nowrtUeYzwnzJPoiXq0K1j7Cmr3tot7gT8qjN5L7W5WXYMc+A26JFvIHsCnPnOz7jKGE8t+Ht0oz/
        pvLzAe7S6D2RQivhYsOVg/MHo1x8rXHiljinMG6xEaMEvNaSb1eigHa3WmHFnzENs61RTojQFYek2
        myM1WZ5+PrXr0stzMWLRUbifEfPQIvQfpdY0JDR70G3dY8TwoTyWgDbdDBSJrLhMRMxOYJ9vuSc8c
        FxbsDZJQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nux7x-002uRu-NR; Sat, 28 May 2022 14:09:13 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5A968980DC1; Sat, 28 May 2022 16:09:13 +0200 (CEST)
Date:   Sat, 28 May 2022 16:09:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        elver@google.com, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH 2/7] objtool: Extend UNWIND_HINT based ENDBR rules
Message-ID: <YpItCeLkwme025xD@worktop.programming.kicks-ass.net>
References: <20220526105252.440440893@infradead.org>
 <20220526105957.817269865@infradead.org>
 <20220526150549.vqvggcuqmw2baslp@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526150549.vqvggcuqmw2baslp@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 08:05:49AM -0700, Josh Poimboeuf wrote:
> On Thu, May 26, 2022 at 12:52:54PM +0200, Peter Zijlstra wrote:
> > Extend the UNWIND hint driven rules for ENDBR placement. Currently
> > objtool expects an ENDBR at any UNWINT_HINT_IRET_REGS that is at +0 of
> > an STB_GLOBAL symbol, with the expectation that this is an exception
> > entry point.
> > 
> > Extend this to also expect ENDBR at UNWIND_HINT_EMPTY at +0 for
> > STB_GLOBAL symbols, with the expectation that these are also machine
> > entry points (SYSCALL et. al.).
> > 
> > This guarantees all machine entry points are covered by objtool rules at
> > the expense of a few additional false positives:
> > 
> >   vmlinux.o: warning: objtool: startup_64+0x0: UNWIND_HINT_EMPTY without ENDBR
> >   vmlinux.o: warning: objtool: start_cpu0+0x0: UNWIND_HINT_EMPTY without ENDBR
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> I can't remember if this was my bright idea, but it feels kind of
> arbitrary.  Hopefully there won't be a lot of false positives.

The existing UNWIND_HINT_IRET_REGS at +0 was your idea, I'm just trying
to cover more.

> Anyway, won't SYSCALL-type symbols typically be referenced elsewhere in
> the kernel and thus be found by the regular IBT validation?

They do indeed, and that's what we've been relying on. I just figured it
would be more consistent to have rules covering all machine entry
points.

(also all the Xen entry points are EMPTY like).

> Do you have any examples of where this warning would trigger if there
> were a missing ENDBR?

No.

Anyway, I can drop these first two patches for now.
