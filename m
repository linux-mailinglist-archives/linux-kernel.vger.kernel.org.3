Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C1852B40E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiERHlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbiERHlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:41:04 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28ADF1167
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P7RoC/DyaIBUrw0WHH4NMmGnt1nOfh1Pg+yXcFOgWnU=; b=lNeeEe/zv0xRJzXzZCgkW4nl7X
        MRkoYGewdzu4v3wqsrsRmdcllxK/gNjROyXeJ0gnj3FlxyiLIP1TbwRanSg0tG7T2nbJEwH5ODJJm
        yKdg6SpX4RHN7uyfaoBhfUsTxPmGcEczUVjpgYYtBwKvWvqieYCo31EnlRa/ZbGZfyge9MPVlLXAj
        A/hlmn8u4NKM5NLcfoV77mm4Gi+cPLmJdqCDxqLavBk2izYbzmu+ElSzhY37YoruurdIxEr61KnwX
        JGCPQ+LtEzfjwb7Xe2e2y6Bc3bDoElqdq9jSRDvUjYg6gpeLaTvSUYogQtUo6RSsO1r+TvcjJofSc
        DiHkkVig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrEIW-001Tr2-MJ; Wed, 18 May 2022 07:40:45 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 85A6098119B; Wed, 18 May 2022 09:40:42 +0200 (CEST)
Date:   Wed, 18 May 2022 09:40:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: objtool "no non-local symbols" error with tip of tree LLVM
Message-ID: <20220518074042.GA10117@worktop.programming.kicks-ass.net>
References: <YoK4U9RgQ9N+HhXJ@dev-arch.thelio-3990X>
 <20220516214005.GQ76023@worktop.programming.kicks-ass.net>
 <YoPAZ6JfsF0LrQNc@hirez.programming.kicks-ass.net>
 <YoPCTEYjoPqE4ZxB@hirez.programming.kicks-ass.net>
 <20220518012429.4zqzarvwsraxivux@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518012429.4zqzarvwsraxivux@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 06:24:29PM -0700, Josh Poimboeuf wrote:
> On Tue, May 17, 2022 at 05:42:04PM +0200, Peter Zijlstra wrote:
> > +	for (;;) {
> > +		symtab_data = elf_getdata(s, symtab_data);
> > +		if (t)
> > +			shndx_data = elf_getdata(t, shndx_data);
> >  
> > -	sym->idx = symtab->sh.sh_size / sizeof(sym->sym);
> > -	elf_dirty_reloc_sym(elf, sym);
> > +		if (!symtab_data) {
> > +			if (!idx) {
> > +				void *buf;
> 
> I'm confused by whatever this is doing, how is !symtab_data possible,
> i.e. why would symtab not have data?
> 
> >  elf_create_section_symbol(struct elf *elf, struct section *sec)
> >  {
> >  	struct section *symtab, *symtab_shndx;
> > -	Elf_Data *shndx_data = NULL;
> > -	struct symbol *sym;
> > -	Elf32_Word shndx;
> > +	Elf32_Word first_non_local, new;
> > +	struct symbol *sym, *old;
> > +	int size;
> > +
> > +	if (elf->ehdr.e_ident[EI_CLASS] == ELFCLASS32)
> > +		size = sizeof(Elf32_Sym);
> > +	else
> > +		size = sizeof(Elf64_Sym);
> 
> This should probably be called 'entsize' and I think you can just get it
> from symtab->sh.sh_entsize.
> 
> > +	/*
> > +	 * Either way, we added a LOCAL symbol.
> > +	 */
> > +	symtab->sh.sh_info += 1;
> > +
> >  	elf_add_symbol(elf, sym);
> 
> Not sure if it matters here, but elf_add_symbol() doesn't set sym->alias
> and sym->pv_target, and both of those are unconditionally initialized in
> read_symbols().  Should elf_add_symbol() be changed to initialize them?



--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -374,6 +374,9 @@ static void elf_add_symbol(struct elf *e
 	struct list_head *entry;
 	struct rb_node *pnode;

+	INIT_LIST_HEAD(&sym->pv_target);
+	sym->alias = sym;
+
 	sym->type = GELF_ST_TYPE(sym->sym.st_info);
 	sym->bind = GELF_ST_BIND(sym->sym.st_info);

@@ -438,8 +441,6 @@ static int read_symbols(struct elf *elf)
 			return -1;
 		}
 		memset(sym, 0, sizeof(*sym));
-		INIT_LIST_HEAD(&sym->pv_target);
-		sym->alias = sym;

 		sym->idx = i;

@@ -604,7 +605,8 @@ static void elf_dirty_reloc_sym(struct e

 /*
  * The libelf API is terrible; gelf_update_sym*() takes a data block relative
- * index value. As such, iterate the data blocks and adjust index until it fits.
+ * index value, *NOT* the symbol index. As such, iterate the data blocks and
+ * adjust index until it fits.
  *
  * If no data block is found, allow adding a new data block provided the index
  * is only one past the end.
@@ -613,14 +615,10 @@ static int elf_update_symbol(struct elf
 			     struct section *symtab_shndx, struct symbol *sym)
 {
 	Elf_Data *symtab_data = NULL, *shndx_data = NULL;
+	Elf64_Xword entsize = symtab->sh.sh_entsize;
 	Elf32_Word shndx = sym->sec->idx;
 	Elf_Scn *s, *t = NULL;
-	int size, idx = sym->idx;
-
-	if (elf->ehdr.e_ident[EI_CLASS] == ELFCLASS32)
-		size = sizeof(Elf32_Sym);
-	else
-		size = sizeof(Elf64_Sym);
+	int max_idx, idx = sym->idx;

 	s = elf_getscn(elf->elf, symtab->idx);
 	if (!s) {
@@ -637,11 +635,14 @@ static int elf_update_symbol(struct elf
 	}

 	for (;;) {
+		/* get next data descriptor for the relevant sections */
 		symtab_data = elf_getdata(s, symtab_data);
 		if (t)
 			shndx_data = elf_getdata(t, shndx_data);

+		/* end-of-list */
 		if (!symtab_data) {
+			/* if @idx == 0, it's the next contiguous entry, create it */
 			if (!idx) {
 				void *buf;

@@ -649,53 +650,60 @@ static int elf_update_symbol(struct elf
 				if (t)
 					shndx_data = elf_newdata(t);

-				buf = calloc(1, size);
+				buf = calloc(1, entsize);
 				if (!buf) {
 					WARN("malloc");
 					return -1;
 				}

 				symtab_data->d_buf = buf;
-				symtab_data->d_size = size;
+				symtab_data->d_size = entsize;
 				symtab_data->d_align = 1;
 				symtab_data->d_type = ELF_T_SYM;

-				symtab->sh.sh_size += size;
+				symtab->sh.sh_size += entsize;
 				symtab->changed = true;

 				if (t) {
 					shndx_data->d_buf = &sym->sec->idx;
 					shndx_data->d_size = sizeof(Elf32_Word);
-					shndx_data->d_align = 4;
+					shndx_data->d_align = sizeof(Elf32_Word);
 					shndx_data->d_type = ELF_T_WORD;

-					symtab_shndx->sh.sh_size += 4;
+					symtab_shndx->sh.sh_size += sizeof(Elf32_Word);
 					symtab_shndx->changed = true;
 				}

 				break;
 			}

+			/* we don't do holes in symbol tables */
 			WARN("index out of range");
 			return -1;
 		}

+		/* empty blocks should not happen */
 		if (!symtab_data->d_size) {
 			WARN("zero size data");
 			return -1;
 		}

-		if (idx * size < symtab_data->d_size)
+		/* is this the right block? */
+		max_idx = symtab_data->d_size / entsize;
+		if (idx < max_idx)
 			break;

-		idx -= symtab_data->d_size / size;
+		/* adjust index and try again */
+		idx -= max_idx;
 	}

+	/* something went side-ways */
 	if (idx < 0) {
 		WARN("negative index");
 		return -1;
 	}

+	/* setup extended section index magic and write the symbol */
 	if (shndx >= SHN_UNDEF && shndx < SHN_LORESERVE) {
 		sym->sym.st_shndx = shndx;
 		if (!shndx_data)
@@ -720,14 +728,8 @@ static struct symbol *
 elf_create_section_symbol(struct elf *elf, struct section *sec)
 {
 	struct section *symtab, *symtab_shndx;
-	Elf32_Word first_non_local, new;
+	Elf32_Word first_non_local, new_idx;
 	struct symbol *sym, *old;
-	int size;
-
-	if (elf->ehdr.e_ident[EI_CLASS] == ELFCLASS32)
-		size = sizeof(Elf32_Sym);
-	else
-		size = sizeof(Elf64_Sym);

 	symtab = find_section_by_name(elf, ".symtab");
 	if (symtab) {
@@ -752,16 +754,15 @@ elf_create_section_symbol(struct elf *el
 	// st_value 0
 	// st_size 0

-	new = symtab->sh.sh_size / size;
-
 	/*
 	 * Move the first global symbol, as per sh_info, into a new, higher
 	 * symbol index. This fees up a spot for a new local symbol.
 	 */
 	first_non_local = symtab->sh.sh_info;
+	new_idx = symtab->sh.sh_size / symtab->sh.sh_entsize;
 	old = find_symbol_by_index(elf, first_non_local);
 	if (old) {
-		old->idx = new;
+		old->idx = new_idx;

 		hlist_del(&old->hash);
 		elf_hash_add(symbol, &old->hash, old->idx);
@@ -773,10 +774,10 @@ elf_create_section_symbol(struct elf *el
 			return NULL;
 		}

-		new = first_non_local;
+		new_idx = first_non_local;
 	}

-	sym->idx = new;
+	sym->idx = new_idx;
 	if (elf_update_symbol(elf, symtab, symtab_shndx, sym)) {
 		WARN("elf_update_symbol");
 		return NULL;

