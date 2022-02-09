Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49DA4AF0A2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiBIMDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiBIMDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:03:15 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886AAC03E965
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 03:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Cg3BreKapOWrcjA/myDb7wb6nkioNEwwwkcLOSzaG3k=; b=CYwBPHV/nGZpvtuFaGg+bEeYQG
        hjGXpURWA6SOjdPDsNmd3ETz4Q9TgGovkE3yWIinrS2M/PEhx26FrnFQTJOQPXUK1+MP5VFXe+znC
        jgPhycUFHU1/W1tRYvtz/Ee/kRs1h5lfzEqcOC1KCO+NbbF4DspBCO79AI1qw+8tf5unUqJOxAm3q
        oRWQGCm7TjvZbDa/udWLZMCVCMnDo6tGGUbbMgr13bH5/THtCYk6ZO6YaR956cLlKjoVjGsE/7Ys3
        GwVCnItq1oAaciY6vIRr2J0damNtPvNrW74CdGY9yiSO6dmGilidP8KgRDLvCCTs2uYLud7sGw9kK
        eTMyKSlQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHlLy-008Pay-Ka; Wed, 09 Feb 2022 11:41:42 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3DB0A9853C7; Wed,  9 Feb 2022 12:41:41 +0100 (CET)
Date:   Wed, 9 Feb 2022 12:41:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, samitolvanen@google.com
Subject: Re: [RFC][PATCH 6/6] objtool: Add IBT validation / fixups
Message-ID: <20220209114141.GN23216@worktop.programming.kicks-ass.net>
References: <20211122170301.764232470@infradead.org>
 <20211122170805.338489412@infradead.org>
 <20211124193037.nu7q4pa3sianzqtc@treble>
 <202202081542.F685EC23@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202202081542.F685EC23@keescook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 03:43:27PM -0800, Kees Cook wrote:
> On Wed, Nov 24, 2021 at 11:30:37AM -0800, Josh Poimboeuf wrote:
> > On Mon, Nov 22, 2021 at 06:03:07PM +0100, Peter Zijlstra wrote:
> > > +static int validate_ibt_reloc(struct objtool_file *file, struct reloc *reloc, char **name)
> > > +{
> > > +	struct instruction *dest;
> > > +	struct section *sec;
> > > +	unsigned long off;
> > > +
> > > +	sec = reloc->sym->sec;
> > > +	off = reloc->sym->offset + reloc->addend;
> > > +
> > > +	dest = find_insn(file, sec, off);
> > > +	if (!dest)
> > > +		return 0;
> > > +
> > > +	if (name && dest->func)
> > > +		*name = dest->func->name;
> > 
> > I think these checks can be further narrowed down by only looking for
> > X86_64_64 relocs.
> > 
> > > +	list_for_each_entry(insn, &file->endbr_list, call_node) {
> > > +		if (ibt_seal) {
> > > +			elf_write_insn(file->elf, insn->sec,
> > > +				       insn->offset, insn->len,
> > > +				       arch_nop_insn(insn->len));
> > > +		}
> > 
> > Like the retpoline rewriting, I'd much rather have objtool create
> > annotations which the kernel can then read and patch itself.
> > 
> > e.g. have '.ibt.direct_call_sites' and '.ibt.unused_endbr_insns'
> > sections.
> 
> Why have the kernel do that work at every boot when it can be known at
> link time?

I have patches that write a 4 byte #UD there instead of a nop. That
would make !IBT hardware splat as well when it hits a sealed function
(and in that case actually having those extra ENDBR generated is a
bonus).

Anyway, I have some newer patches and some hardware, except it's a NUC
and working with those things is a royal pain in the arse since they
don't have serial. I finally did get XHCI debug port working, but
there's no XDBC grub support, so now I managed to boot a dead kernel and
the thing is a brick until I can be arsed to connect a keybaord and
screen to it again :-(

KVM/qemu has no IBT support merged yet, so I can't use that either.
