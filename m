Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1545D52C189
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241052AbiERRgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 13:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240955AbiERRgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 13:36:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4472C138
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 10:36:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B831B81EBF
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 17:36:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D27C385A9;
        Wed, 18 May 2022 17:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652895366;
        bh=0dwfVWukexxHxku7pFl5/kJsgPAuwTnKAQ2sO8fT70s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gcq+AsyWRlWY6EkOaKJm5ct5ucagrpx08LO98QYPxM4b/OdgeY4MkEPKMwOhlX7Hd
         oRbZf2bQr1fyZ1JnZuDJx5ialOCjDdsEJkvcXvF6Zsw366nZbtRU4yMzhAAfGC6Mqu
         BtMNO5WAxb8F8shhwfEDgohge8+HEey2PE6OY1JZhTgnxs89hMj1khLC57Wd8dtgVH
         ZNrE4VUzmRngyxPUiz5lKMIsmeQqtmBZr2OHHLrFdthvwzf3zB9kTohn5Oob+LHVNW
         VidV5CAB/vnph4yO0RbTtnUtCtUQGOHkByP0RadqTLQ970si7uWZtPSqbbPBtDWRjd
         tuDtKmcVnynPQ==
Date:   Wed, 18 May 2022 10:36:04 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH] objtool: Fix symbol creation
Message-ID: <20220518173604.7gcrjjum6fo2m2ub@treble>
References: <YoK4U9RgQ9N+HhXJ@dev-arch.thelio-3990X>
 <20220516214005.GQ76023@worktop.programming.kicks-ass.net>
 <YoPAZ6JfsF0LrQNc@hirez.programming.kicks-ass.net>
 <YoPCTEYjoPqE4ZxB@hirez.programming.kicks-ass.net>
 <20220518012429.4zqzarvwsraxivux@treble>
 <20220518074152.GB10117@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220518074152.GB10117@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 09:41:52AM +0200, Peter Zijlstra wrote:
> +static int elf_update_symbol(struct elf *elf, struct section *symtab,
> +			     struct section *symtab_shndx, struct symbol *sym)
>  {
> -	Elf_Data *data, *shndx_data = NULL;
> -	Elf32_Word first_non_local;
> -	struct symbol *sym;
> -	Elf_Scn *s;
> -
> -	first_non_local = symtab->sh.sh_info;
> -
> -	sym = find_symbol_by_index(elf, first_non_local);
> -	if (!sym) {
> -		WARN("no non-local symbols !?");
> -		return first_non_local;
> -	}
> +	Elf_Data *symtab_data = NULL, *shndx_data = NULL;
> +	Elf64_Xword entsize = symtab->sh.sh_entsize;
> +	Elf32_Word shndx = sym->sec->idx;

So if it's a global UNDEF symbol then I think 'sym->sec' can be NULL and
this blows up?

> +	for (;;) {
> +		/* get next data descriptor for the relevant sections */
> +		symtab_data = elf_getdata(s, symtab_data);
> +		if (t)
> +			shndx_data = elf_getdata(t, shndx_data);
> +
> +		/* end-of-list */
> +		if (!symtab_data) {
> +			/* if @idx == 0, it's the next contiguous entry, create it */
> +			if (!idx) {
> +				void *buf;

Could just do the "index out of range warning" here to reduce the
indentation level.

> +	/* setup extended section index magic and write the symbol */
> +	if (shndx >= SHN_UNDEF && shndx < SHN_LORESERVE) {

> +		sym->sym.st_shndx = shndx;
> +		if (!shndx_data)
> +			shndx = 0;

I think this '0' is SHN_UNDEF?

Also shouldn't 'sym->sym.st_shndx' get the same value?

-- 
Josh
