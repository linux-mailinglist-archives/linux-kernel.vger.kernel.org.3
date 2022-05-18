Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AA452C170
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240731AbiERRPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 13:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240720AbiERRPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 13:15:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AA417EC24
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 10:14:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 735606176F
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 17:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1A0C385A5;
        Wed, 18 May 2022 17:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652894098;
        bh=DjL0pfE9hgVf4gbXU7TI41U63++YFNAG705cDBjMhVA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S/QHbpzTZGX2r3peroCT3HOUPOoMZhrTllorZ+Uqd06sQzWrcCnIDBK5RWaZTQiPq
         dPpLRMS8IsS/i4v3OkUhqvqX1HlsSdQcEDXC/ApxMDewBBR0AORrtdGHKBsjTXEERD
         vSWbXVMule11lVtFKgyGqwGW3YOQHD4DX0tkXcoIzPcGFqdpXBW/XGrjP9tWPtGOpk
         Fc7NuYCRlhCKex4/773E6+RYwF7qTA0LcRIrccqdFCljruCYD1YyFHAYIaugNwjTQe
         Q+7fx72jGlBq6BCR9Ev5RC+0j26ga7J/STURMmNoUFv7gkzFY29EBY+YWQdGgnCmr6
         hdZkOMCk25KqQ==
Date:   Wed, 18 May 2022 10:14:56 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: objtool "no non-local symbols" error with tip of tree LLVM
Message-ID: <20220518171456.tao6lmum4a2cpvs5@treble>
References: <YoK4U9RgQ9N+HhXJ@dev-arch.thelio-3990X>
 <20220516214005.GQ76023@worktop.programming.kicks-ass.net>
 <YoPAZ6JfsF0LrQNc@hirez.programming.kicks-ass.net>
 <YoPCTEYjoPqE4ZxB@hirez.programming.kicks-ass.net>
 <20220518012429.4zqzarvwsraxivux@treble>
 <YoSEXii2v0ob/8db@hirez.programming.kicks-ass.net>
 <20220518161725.2bkzavre2bg4xu72@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220518161725.2bkzavre2bg4xu72@treble>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 09:17:27AM -0700, Josh Poimboeuf wrote:
> On Wed, May 18, 2022 at 07:30:06AM +0200, Peter Zijlstra wrote:
> > On Tue, May 17, 2022 at 06:24:29PM -0700, Josh Poimboeuf wrote:
> > > On Tue, May 17, 2022 at 05:42:04PM +0200, Peter Zijlstra wrote:
> > > > +	for (;;) {
> > > > +		symtab_data = elf_getdata(s, symtab_data);
> > > > +		if (t)
> > > > +			shndx_data = elf_getdata(t, shndx_data);
> > > >  
> > > > +		if (!symtab_data) {
> > > > +			if (!idx) {
> > > > +				void *buf;
> > > 
> > > I'm confused by whatever this is doing, how is !symtab_data possible,
> > > i.e. why would symtab not have data?
> > 
> > Elf_Data *elf_getdata(Elf_Scn *scn, Elf_Data *data);
> > 
> > is an iterator, if @data is null it will return the first element, which
> > you then feed into @data the next time to get the next element, once it
> > returns NULL, you've found the end.
> > 
> > In our specific case, we iterate the data sections, if idx fits inside
> > the current section, we good, otherwise we lower idx by however many did
> > fit and try the next.
> 
> Ok, I think I see.  But why are there multiple data blocks to begin
> with?  It's because of a previous call to elf_newdata() right?
> 
> If so then I don't see how it would "fit" in an existing data block,
> since each block should already be full.  Or... is the hole the one you
> just made, by moving the old symbol out?
> 
> If so, the function seems weirdly generalized for the two distinct cases
> and the loop seems unnecessary.  When adding a symbol at the end, just
> use elf_newdata().  When adding a symbol in the middle, the hole should
> be in the first data block.

Then I went for a bike ride and realized that if adding enough section
symbols to a file which didn't have very many non-locals, the hole might
occur in a later data block.

So yeah, this looks fine :-)

Another idea I had was to forego elf_newdata() entirely in favor of just
rewriting the original data block every time.  But this is also fine.

-- 
Josh
