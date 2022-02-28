Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDE04C6CD1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbiB1Mmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiB1Mmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:42:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA52506E0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TYfrVKkHEOeWThZ1HPoCRjuHgbWI1WpuStectqDw4HU=; b=U4cidNZcZV4cORMh092OsDh5Mf
        3yXKQ3TuRuNejtbgj5fEEQSHsMrt85wafB8/7S+bBGltJnTi5WvXo3SDqdGPXWo3410aLckqYv2yJ
        uXg+G7z8Ne7hvQdoicdFlO7n9NWdoCLSqpiKBWAI8KS0ktUQCUJAlNKHHz30ziO6UXEDTykV3R3HN
        185ADZ0PtEP5Sa8nu9DYGaD6e6QkUNCGCDSMwW9xZHuRnieiY/p7/Mw+hB5sDExcOoCrxXZ/AZTZU
        h8rB/r/9ZLf0t+01la2ELVw/pPavrKiXeB/lFmzQxjhHO+q1u1n578upIUVLjbE7I9BqZjzKX0TuS
        W+683v4Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOfL1-008WI6-Q1; Mon, 28 Feb 2022 12:41:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2E6F53001D0;
        Mon, 28 Feb 2022 13:41:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DF99C30855E94; Mon, 28 Feb 2022 13:41:13 +0100 (CET)
Date:   Mon, 28 Feb 2022 13:41:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 36/39] objtool: Find unused ENDBR instructions
Message-ID: <YhzC6RmRZs6U4wvG@hirez.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
 <20220224151324.137868984@infradead.org>
 <20220227034613.a5ejjey5agxlympd@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220227034613.a5ejjey5agxlympd@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2022 at 07:46:13PM -0800, Josh Poimboeuf wrote:
> On Thu, Feb 24, 2022 at 03:52:14PM +0100, Peter Zijlstra wrote:
> > +#ifdef CONFIG_X86_KERNEL_IBT
> > +	. = ALIGN(8);
> > +	.ibt_endbr_sites : AT(ADDR(.ibt_endbr_sites) - LOAD_OFFSET) {
> > +		__ibt_endbr_sites = .;
> > +		*(.ibt_endbr_sites)
> > +		__ibt_endbr_sites_end = .;
> > +	}
> > +#endif
> 
> ".ibt_endbr_superfluous" maybe?  It's not *all* the endbr sites.

Since I like seals, I'll make it .ibt_endbr_seal :-) Also goes well with
the option at hand.

> > +
> >  	/*
> >  	 * struct alt_inst entries. From the header (alternative.h):
> >  	 * "Alternative instructions for different CPU types or capabilities"
> > --- a/tools/objtool/builtin-check.c
> > +++ b/tools/objtool/builtin-check.c
> > @@ -21,7 +21,7 @@
> >  
> >  bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
> >       lto, vmlinux, mcount, noinstr, backup, sls, dryrun,
> > -     ibt, ibt_fix_direct;
> > +     ibt, ibt_fix_direct, ibt_seal;
> >  
> >  static const char * const check_usage[] = {
> >  	"objtool check [<options>] file.o",
> > @@ -50,6 +50,7 @@ const struct option check_options[] = {
> >  	OPT_BOOLEAN(0, "dry-run", &dryrun, "don't write the modifications"),
> >  	OPT_BOOLEAN(0, "ibt", &ibt, "validate ENDBR placement"),
> >  	OPT_BOOLEAN(0, "ibt-fix-direct", &ibt_fix_direct, "fixup direct jmp/call to ENDBR"),
> > +	OPT_BOOLEAN(0, "ibt-seal", &ibt_seal, "list superfluous ENDBR instructions"),
> 
> s/list/annotate/ ?

Done :-)

> Not sure "ibt-seal" is the appropriate name since the "seal" is done at
> boot time.

It allows sealing; it finds the locations to seal, whatever :-)

> Do we really need a separate option anyway?  To get the full benefits of
> IBT you might as well enable it...  And always enabling it helps flush
> out bugs quicker.

Are you asking about --ibt and --ibt-seal or about the existence of
X86_KERNEL_IBT_SEAL here?

The Makefiles will only ever use --ibt and --ibt-seal together for the
reason you state. The reason they're two separate objtool arguments is
because it's stictly speaking two different things being done. Also
--ibt as such is invariant, while --ibt-seal causes modifications to the
object file (which can be discarded using the new --dry-run I suppose).

The reason X86_KERNEL_IBT_SEAL exists is because that requires objtool
while X86_KERNEL_IBT does not -- you seemed to favour not hard relying
on having objtool present.


