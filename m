Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C34052AB3C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352378AbiEQSxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245048AbiEQSxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:53:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54513BA5E
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:53:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FF2AB8182C
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 18:53:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727CEC385B8;
        Tue, 17 May 2022 18:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652813584;
        bh=fByl9pfdaNvhQc+16AHfxnAyMA07zzkUJbvT+offdtU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nn3siSFSOFDm796GrRsXYVqwPLk4FSJzlVDfJztuWcGHsScTp6LswUrBFrCLNyz7y
         pDP1JeG0vZ/ov7jfqlLmbGT/hofPPMxa/kpSyO05uvgt/JOkELasnurgz7oZeHbpuH
         /iByZusRlQzK4G5U5HGnNW2pAk67zcB/AzM/gIYkDYJkIU0vhDUCVBSNkoR0CgSb4b
         JRMM+oKuKeLnr5aw6jl8ekyeffLwqsKeLUpwQS9w0jb5N0Q6S95xDiYd+Z0VQYQ1W3
         0ZqKBS76SGUY8iOiI7Zu9Z8+qoOVrK4RAFL07XWFXQFfByWQhGQcIpcM8WVfsrweuY
         BFemIAZyY6l5A==
Date:   Tue, 17 May 2022 11:53:02 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: objtool "no non-local symbols" error with tip of tree LLVM
Message-ID: <YoPvDn0Nb2fBtJCs@dev-arch.thelio-3990X>
References: <YoK4U9RgQ9N+HhXJ@dev-arch.thelio-3990X>
 <20220516214005.GQ76023@worktop.programming.kicks-ass.net>
 <YoPAZ6JfsF0LrQNc@hirez.programming.kicks-ass.net>
 <YoPCTEYjoPqE4ZxB@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoPCTEYjoPqE4ZxB@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 05:42:04PM +0200, Peter Zijlstra wrote:
> On Tue, May 17, 2022 at 05:33:59PM +0200, Peter Zijlstra wrote:
> > On Mon, May 16, 2022 at 11:40:06PM +0200, Peter Zijlstra wrote:
> > > Does something simple like this work? If not, I'll try and reproduce
> > > tomorrow, it shouldn't be too hard to fix.
> > 
> > Oh, man, I so shouldn't have said that :/
> > 
> > I have something that almost works, except it now mightly upsets
> > modpost.
> > 
> > I'm not entirely sure how the old code worked as well as it did. Oh
> > well, I'll get it sorted.
> 
> Pff, it's been a *long* day.. here this works.

Thanks a lot for the quick fix! It resolves the error I see on 5.17 and
I don't see any new issues on mainline.

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  tools/objtool/elf.c | 191 ++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 125 insertions(+), 66 deletions(-)
> 
> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index ebf2ba5755c1..a9c3e27527de 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -600,24 +600,24 @@ static void elf_dirty_reloc_sym(struct elf *elf, struct symbol *sym)
>  }
>  
>  /*
> - * Move the first global symbol, as per sh_info, into a new, higher symbol
> - * index. This fees up the shndx for a new local symbol.
> + * The libelf API is terrible; gelf_update_sym*() takes a data block relative
> + * index value. As such, iterate the data blocks and adjust index until it fits.
> + *
> + * If no data block is found, allow adding a new data block provided the index
> + * is only one past the end.
>   */
> -static int elf_move_global_symbol(struct elf *elf, struct section *symtab,
> -				  struct section *symtab_shndx)
> +static int elf_update_symbol(struct elf *elf, struct section *symtab,
> +			     struct section *symtab_shndx, struct symbol *sym)
>  {
> -	Elf_Data *data, *shndx_data = NULL;
> -	Elf32_Word first_non_local;
> -	struct symbol *sym;
> -	Elf_Scn *s;
> +	Elf_Data *symtab_data = NULL, *shndx_data = NULL;
> +	Elf32_Word shndx = sym->sec->idx;
> +	Elf_Scn *s, *t = NULL;
> +	int size, idx = sym->idx;
>  
> -	first_non_local = symtab->sh.sh_info;
> -
> -	sym = find_symbol_by_index(elf, first_non_local);
> -	if (!sym) {
> -		WARN("no non-local symbols !?");
> -		return first_non_local;
> -	}
> +	if (elf->ehdr.e_ident[EI_CLASS] == ELFCLASS32)
> +		size = sizeof(Elf32_Sym);
> +	else
> +		size = sizeof(Elf64_Sym);
>  
>  	s = elf_getscn(elf->elf, symtab->idx);
>  	if (!s) {
> @@ -625,79 +625,120 @@ static int elf_move_global_symbol(struct elf *elf, struct section *symtab,
>  		return -1;
>  	}
>  
> -	data = elf_newdata(s);
> -	if (!data) {
> -		WARN_ELF("elf_newdata");
> -		return -1;
> +	if (symtab_shndx) {
> +		t = elf_getscn(elf->elf, symtab_shndx->idx);
> +		if (!t) {
> +			WARN_ELF("elf_getscn");
> +			return -1;
> +		}
>  	}
>  
> -	data->d_buf = &sym->sym;
> -	data->d_size = sizeof(sym->sym);
> -	data->d_align = 1;
> -	data->d_type = ELF_T_SYM;
> +	for (;;) {
> +		symtab_data = elf_getdata(s, symtab_data);
> +		if (t)
> +			shndx_data = elf_getdata(t, shndx_data);
>  
> -	sym->idx = symtab->sh.sh_size / sizeof(sym->sym);
> -	elf_dirty_reloc_sym(elf, sym);
> +		if (!symtab_data) {
> +			if (!idx) {
> +				void *buf;
>  
> -	symtab->sh.sh_info += 1;
> -	symtab->sh.sh_size += data->d_size;
> -	symtab->changed = true;
> +				symtab_data = elf_newdata(s);
> +				if (t)
> +					shndx_data = elf_newdata(t);
>  
> -	if (symtab_shndx) {
> -		s = elf_getscn(elf->elf, symtab_shndx->idx);
> -		if (!s) {
> -			WARN_ELF("elf_getscn");
> +				buf = calloc(1, size);
> +				if (!buf) {
> +					WARN("malloc");
> +					return -1;
> +				}
> +
> +				symtab_data->d_buf = buf;
> +				symtab_data->d_size = size;
> +				symtab_data->d_align = 1;
> +				symtab_data->d_type = ELF_T_SYM;
> +
> +				symtab->sh.sh_size += size;
> +				symtab->changed = true;
> +
> +				if (t) {
> +					shndx_data->d_buf = &sym->sec->idx;
> +					shndx_data->d_size = sizeof(Elf32_Word);
> +					shndx_data->d_align = 4;
> +					shndx_data->d_type = ELF_T_WORD;
> +
> +					symtab_shndx->sh.sh_size += 4;
> +					symtab_shndx->changed = true;
> +				}
> +
> +				break;
> +			}
> +
> +			WARN("index out of range");
>  			return -1;
>  		}
>  
> -		shndx_data = elf_newdata(s);
> -		if (!shndx_data) {
> -			WARN_ELF("elf_newshndx_data");
> +		if (!symtab_data->d_size) {
> +			WARN("zero size data");
>  			return -1;
>  		}
>  
> -		shndx_data->d_buf = &sym->sec->idx;
> -		shndx_data->d_size = sizeof(Elf32_Word);
> -		shndx_data->d_align = 4;
> -		shndx_data->d_type = ELF_T_WORD;
> +		if (idx * size < symtab_data->d_size)
> +			break;
>  
> -		symtab_shndx->sh.sh_size += 4;
> -		symtab_shndx->changed = true;
> +		idx -= symtab_data->d_size / size;
>  	}
>  
> -	return first_non_local;
> +	if (idx < 0) {
> +		WARN("negative index");
> +		return -1;
> +	}
> +
> +	if (shndx >= SHN_UNDEF && shndx < SHN_LORESERVE) {
> +		sym->sym.st_shndx = shndx;
> +		if (!shndx_data)
> +			shndx = 0;
> +	} else {
> +		sym->sym.st_shndx = SHN_XINDEX;
> +		if (!shndx_data) {
> +			WARN("no .symtab_shndx");
> +			return -1;
> +		}
> +	}
> +
> +	if (!gelf_update_symshndx(symtab_data, shndx_data, idx, &sym->sym, shndx)) {
> +		WARN_ELF("gelf_update_symshndx");
> +		return -1;
> +	}
> +
> +	return 0;
>  }
>  
>  static struct symbol *
>  elf_create_section_symbol(struct elf *elf, struct section *sec)
>  {
>  	struct section *symtab, *symtab_shndx;
> -	Elf_Data *shndx_data = NULL;
> -	struct symbol *sym;
> -	Elf32_Word shndx;
> +	Elf32_Word first_non_local, new;
> +	struct symbol *sym, *old;
> +	int size;
> +
> +	if (elf->ehdr.e_ident[EI_CLASS] == ELFCLASS32)
> +		size = sizeof(Elf32_Sym);
> +	else
> +		size = sizeof(Elf64_Sym);
>  
>  	symtab = find_section_by_name(elf, ".symtab");
>  	if (symtab) {
>  		symtab_shndx = find_section_by_name(elf, ".symtab_shndx");
> -		if (symtab_shndx)
> -			shndx_data = symtab_shndx->data;
>  	} else {
>  		WARN("no .symtab");
>  		return NULL;
>  	}
>  
> -	sym = malloc(sizeof(*sym));
> +	sym = calloc(1, sizeof(*sym));
>  	if (!sym) {
>  		perror("malloc");
>  		return NULL;
>  	}
> -	memset(sym, 0, sizeof(*sym));
> -
> -	sym->idx = elf_move_global_symbol(elf, symtab, symtab_shndx);
> -	if (sym->idx < 0) {
> -		WARN("elf_move_global_symbol");
> -		return NULL;
> -	}
>  
>  	sym->name = sec->name;
>  	sym->sec = sec;
> @@ -707,24 +748,42 @@ elf_create_section_symbol(struct elf *elf, struct section *sec)
>  	// st_other 0
>  	// st_value 0
>  	// st_size 0
> -	shndx = sec->idx;
> -	if (shndx >= SHN_UNDEF && shndx < SHN_LORESERVE) {
> -		sym->sym.st_shndx = shndx;
> -		if (!shndx_data)
> -			shndx = 0;
> -	} else {
> -		sym->sym.st_shndx = SHN_XINDEX;
> -		if (!shndx_data) {
> -			WARN("no .symtab_shndx");
> +
> +	new = symtab->sh.sh_size / size;
> +
> +	/*
> +	 * Move the first global symbol, as per sh_info, into a new, higher
> +	 * symbol index. This fees up a spot for a new local symbol.
> +	 */
> +	first_non_local = symtab->sh.sh_info;
> +	old = find_symbol_by_index(elf, first_non_local);
> +	if (old) {
> +		old->idx = new;
> +
> +		hlist_del(&old->hash);
> +		elf_hash_add(symbol, &old->hash, old->idx);
> +
> +		elf_dirty_reloc_sym(elf, old);
> +
> +		if (elf_update_symbol(elf, symtab, symtab_shndx, old)) {
> +			WARN("elf_update_symbol move");
>  			return NULL;
>  		}
> +
> +		new = first_non_local;
>  	}
>  
> -	if (!gelf_update_symshndx(symtab->data, shndx_data, sym->idx, &sym->sym, shndx)) {
> -		WARN_ELF("gelf_update_symshndx");
> +	sym->idx = new;
> +	if (elf_update_symbol(elf, symtab, symtab_shndx, sym)) {
> +		WARN("elf_update_symbol");
>  		return NULL;
>  	}
>  
> +	/*
> +	 * Either way, we added a LOCAL symbol.
> +	 */
> +	symtab->sh.sh_info += 1;
> +
>  	elf_add_symbol(elf, sym);
>  
>  	return sym;
