Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B13452C601
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 00:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiERWK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiERWKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:10:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1B011A2B
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mAr+xOmPUpatPCsQEvvtVuA3lNcGb0ypfwN80fV79Fs=; b=j2e34UkPXU8jsfY5u4yxYT50Ex
        B3+HdDt7erkE/L/86lgiyQKu1KSEg0OEhUiSPK0vHtrirNwPH8C8rW3rNIycDBkk+V4RxhLmWEy/W
        fbLpqc0WAxXU9Ug4ku1AI8vZO9s6aglmY6sBLAsCo0kvno4lMolAvCY9NWwKACMHLa0nG+KCXaw+9
        x6WkfwOPBwHz2g7AernbWmrYQF0i37wsDbJXCJGjjbDCLeNrQ998Q1W8N1uGJOjyTlGb7/GIE2vRQ
        3HotHqdT5Hc5cIx6MdvXRoeOnqpEgGesKesyqwDE3J0EBwthrcMzwiluz30NYFfnlj9KNN/b7Fcs3
        +ZwEpLtA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrRry-001fUb-Uz; Wed, 18 May 2022 22:10:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9020D3002BF;
        Thu, 19 May 2022 00:10:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7837D20757B47; Thu, 19 May 2022 00:10:12 +0200 (CEST)
Date:   Thu, 19 May 2022 00:10:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH] objtool: Fix symbol creation
Message-ID: <YoVuxKGkt0IQ0yjb@hirez.programming.kicks-ass.net>
References: <YoK4U9RgQ9N+HhXJ@dev-arch.thelio-3990X>
 <20220516214005.GQ76023@worktop.programming.kicks-ass.net>
 <YoPAZ6JfsF0LrQNc@hirez.programming.kicks-ass.net>
 <YoPCTEYjoPqE4ZxB@hirez.programming.kicks-ass.net>
 <20220518012429.4zqzarvwsraxivux@treble>
 <20220518074152.GB10117@worktop.programming.kicks-ass.net>
 <20220518173604.7gcrjjum6fo2m2ub@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518173604.7gcrjjum6fo2m2ub@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 10:36:04AM -0700, Josh Poimboeuf wrote:
> On Wed, May 18, 2022 at 09:41:52AM +0200, Peter Zijlstra wrote:
> > +static int elf_update_symbol(struct elf *elf, struct section *symtab,
> > +			     struct section *symtab_shndx, struct symbol *sym)
> >  {
> > -	Elf_Data *data, *shndx_data = NULL;
> > -	Elf32_Word first_non_local;
> > -	struct symbol *sym;
> > -	Elf_Scn *s;
> > -
> > -	first_non_local = symtab->sh.sh_info;
> > -
> > -	sym = find_symbol_by_index(elf, first_non_local);
> > -	if (!sym) {
> > -		WARN("no non-local symbols !?");
> > -		return first_non_local;
> > -	}
> > +	Elf_Data *symtab_data = NULL, *shndx_data = NULL;
> > +	Elf64_Xword entsize = symtab->sh.sh_entsize;
> > +	Elf32_Word shndx = sym->sec->idx;
> 
> So if it's a global UNDEF symbol then I think 'sym->sec' can be NULL and
> this blows up?

Oh indeed, sym->sec ? sym->sec->idx : SHN_UNDEF it is.

> > +	for (;;) {
> > +		/* get next data descriptor for the relevant sections */
> > +		symtab_data = elf_getdata(s, symtab_data);
> > +		if (t)
> > +			shndx_data = elf_getdata(t, shndx_data);
> > +
> > +		/* end-of-list */
> > +		if (!symtab_data) {
> > +			/* if @idx == 0, it's the next contiguous entry, create it */
> > +			if (!idx) {
> > +				void *buf;
> 
> Could just do the "index out of range warning" here to reduce the
> indentation level.

Sure.

> > +	/* setup extended section index magic and write the symbol */
> > +	if (shndx >= SHN_UNDEF && shndx < SHN_LORESERVE) {
> 
> > +		sym->sym.st_shndx = shndx;
> > +		if (!shndx_data)
> > +			shndx = 0;
> 
> I think this '0' is SHN_UNDEF?
> 
> Also shouldn't 'sym->sym.st_shndx' get the same value?

This is when there isn't an extended section index. Specifically
gelf_update_symshndx() requires that when @shndx_data == NULL, @shndx
must be 0 too.
