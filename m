Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532F44C65A8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbiB1J12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbiB1J1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:27:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C095E692B4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9GUIxRnltrXjuaQ/3p0qt1giCs5VdgcEInwflG8m5kU=; b=Y8a3X/8UkwvsEeSnWGj509vc/R
        ofszaIf/4wVocPWa8RbRAoIyXFKJ6IJhVOO8TjiZEaNB2Kq07jSraMvLms/ern8uifOOQmDlB5zOC
        ogqiYr9YDpkmBKlR3PUNvTLuVuXd9DIZI4smvYfaUwpz9XY8sWNRqNpvPnXQTfNwO3q7CKKjoAe+k
        ORqXU0mKmPNpnVjaTR6MlFVa81Sy0gRRltY99oaX4FdJRr/XiNopz9N/LvmcBQC1lO7xRn54rSHeT
        Gkc4jNy96jNrfmmcVhBvRax1twm5CnFvfmyfNCtLTEN1BnhdKlTK64iqk+ggvTs4HErs3yvpKSdoC
        /cu9JZtg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOcID-008M6N-Gg; Mon, 28 Feb 2022 09:26:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B3A3D3001C3;
        Mon, 28 Feb 2022 10:26:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6136823944372; Mon, 28 Feb 2022 10:26:07 +0100 (CET)
Date:   Mon, 28 Feb 2022 10:26:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 34/39] objtool: Validate IBT assumptions
Message-ID: <YhyVL9SbeC2bd942@hirez.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
 <20220224151324.018939604@infradead.org>
 <20220227031348.drbmkcmoqur53aay@treble>
 <20220227170003.GE11184@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220227170003.GE11184@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2022 at 06:00:03PM +0100, Peter Zijlstra wrote:
> On Sat, Feb 26, 2022 at 07:13:48PM -0800, Josh Poimboeuf wrote:
> > > +static struct instruction *
> > > +validate_ibt_reloc(struct objtool_file *file, struct reloc *reloc)
> > > +{
> > > +	struct instruction *dest;
> > > +	struct section *sec;
> > > +	unsigned long off;
> > > +
> > > +	sec = reloc->sym->sec;
> > > +	off = reloc->sym->offset + reloc->addend;
> > 
> > This math assumes non-PC-relative.  If it's R_X86_64_PC32 or
> > R_X86_64_PLT32 then it needs +4 added.
> 
> Right; so I actually had that PC32 thing in there for a while, but ran
> into other trouble. I'll go try and figure it out.

Things like .rela.initcall*.init use PC32 but don't need the +4. If we
get that wrong it'll seal all the initcall and boot doesn't get very
far at all :-)

How do you feel about something like:

	sec = reloc->sym->sec;
	off = reloc->sym->offset;

	if ((reloc->sec->base->sh.sh_flags & SHF_EXECINSTR) &&
	    (reloc->type == R_X86_64_PC32 || reloc->type == R_X86_64_PLT32))
		off += arch_dest_reloc_offset(reloc->addend);
	else
		off += reloc->addend;


hmm ?
