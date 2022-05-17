Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C0452A73F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 17:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240468AbiEQPn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 11:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350608AbiEQPnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:43:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCEB50B3B
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 08:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C8bFBcYQ8gfp+jZZiMampXlgPGTpsfmScw6kMFrgs3U=; b=UWuNvE0x8LsLtL/c7YtTLBqfmp
        mjTcSO2ASvIM2tNUw3mLFqt8evsaGid/2l2LFDysiimrcSduyHp/uHz8mxA6UIXAite02w5iexLtE
        +lcWMFycrvlSjqVrVyO9YDZ+3kPJupACACj3jLSfaUe6TssTo77o1r5phFw58WQBxX2rKcpCPoEQV
        ddf5FVH41IUvFfiyaVwgKwq6ZbyJo30xAcALAh4Qp/0jQac4i1CDanEJqi5r0ADqxGL7Wvd/2pimO
        2zAUEHI6D93D1A2xnRQpe3NYXqHnOnDPgDBRHmXMegGtednF88HANYe/LCmvvtdrhilClDCvkkLZK
        Ed16ySRQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqzKo-001H0b-MG; Tue, 17 May 2022 15:42:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7B57D3003AA;
        Tue, 17 May 2022 17:42:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6036A2040ACD7; Tue, 17 May 2022 17:42:04 +0200 (CEST)
Date:   Tue, 17 May 2022 17:42:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: objtool "no non-local symbols" error with tip of tree LLVM
Message-ID: <YoPCTEYjoPqE4ZxB@hirez.programming.kicks-ass.net>
References: <YoK4U9RgQ9N+HhXJ@dev-arch.thelio-3990X>
 <20220516214005.GQ76023@worktop.programming.kicks-ass.net>
 <YoPAZ6JfsF0LrQNc@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoPAZ6JfsF0LrQNc@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 05:33:59PM +0200, Peter Zijlstra wrote:
> On Mon, May 16, 2022 at 11:40:06PM +0200, Peter Zijlstra wrote:
> > Does something simple like this work? If not, I'll try and reproduce
> > tomorrow, it shouldn't be too hard to fix.
> 
> Oh, man, I so shouldn't have said that :/
> 
> I have something that almost works, except it now mightly upsets
> modpost.
> 
> I'm not entirely sure how the old code worked as well as it did. Oh
> well, I'll get it sorted.

Pff, it's been a *long* day.. here this works.

---
 tools/objtool/elf.c | 191 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 125 insertions(+), 66 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index ebf2ba5755c1..a9c3e27527de 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -600,24 +600,24 @@ static void elf_dirty_reloc_sym(struct elf *elf, struct symbol *sym)
 }
 
 /*
- * Move the first global symbol, as per sh_info, into a new, higher symbol
- * index. This fees up the shndx for a new local symbol.
+ * The libelf API is terrible; gelf_update_sym*() takes a data block relative
+ * index value. As such, iterate the data blocks and adjust index until it fits.
+ *
+ * If no data block is found, allow adding a new data block provided the index
+ * is only one past the end.
  */
-static int elf_move_global_symbol(struct elf *elf, struct section *symtab,
-				  struct section *symtab_shndx)
+static int elf_update_symbol(struct elf *elf, struct section *symtab,
+			     struct section *symtab_shndx, struct symbol *sym)
 {
-	Elf_Data *data, *shndx_data = NULL;
-	Elf32_Word first_non_local;
-	struct symbol *sym;
-	Elf_Scn *s;
+	Elf_Data *symtab_data = NULL, *shndx_data = NULL;
+	Elf32_Word shndx = sym->sec->idx;
+	Elf_Scn *s, *t = NULL;
+	int size, idx = sym->idx;
 
-	first_non_local = symtab->sh.sh_info;
-
-	sym = find_symbol_by_index(elf, first_non_local);
-	if (!sym) {
-		WARN("no non-local symbols !?");
-		return first_non_local;
-	}
+	if (elf->ehdr.e_ident[EI_CLASS] == ELFCLASS32)
+		size = sizeof(Elf32_Sym);
+	else
+		size = sizeof(Elf64_Sym);
 
 	s = elf_getscn(elf->elf, symtab->idx);
 	if (!s) {
@@ -625,79 +625,120 @@ static int elf_move_global_symbol(struct elf *elf, struct section *symtab,
 		return -1;
 	}
 
-	data = elf_newdata(s);
-	if (!data) {
-		WARN_ELF("elf_newdata");
-		return -1;
+	if (symtab_shndx) {
+		t = elf_getscn(elf->elf, symtab_shndx->idx);
+		if (!t) {
+			WARN_ELF("elf_getscn");
+			return -1;
+		}
 	}
 
-	data->d_buf = &sym->sym;
-	data->d_size = sizeof(sym->sym);
-	data->d_align = 1;
-	data->d_type = ELF_T_SYM;
+	for (;;) {
+		symtab_data = elf_getdata(s, symtab_data);
+		if (t)
+			shndx_data = elf_getdata(t, shndx_data);
 
-	sym->idx = symtab->sh.sh_size / sizeof(sym->sym);
-	elf_dirty_reloc_sym(elf, sym);
+		if (!symtab_data) {
+			if (!idx) {
+				void *buf;
 
-	symtab->sh.sh_info += 1;
-	symtab->sh.sh_size += data->d_size;
-	symtab->changed = true;
+				symtab_data = elf_newdata(s);
+				if (t)
+					shndx_data = elf_newdata(t);
 
-	if (symtab_shndx) {
-		s = elf_getscn(elf->elf, symtab_shndx->idx);
-		if (!s) {
-			WARN_ELF("elf_getscn");
+				buf = calloc(1, size);
+				if (!buf) {
+					WARN("malloc");
+					return -1;
+				}
+
+				symtab_data->d_buf = buf;
+				symtab_data->d_size = size;
+				symtab_data->d_align = 1;
+				symtab_data->d_type = ELF_T_SYM;
+
+				symtab->sh.sh_size += size;
+				symtab->changed = true;
+
+				if (t) {
+					shndx_data->d_buf = &sym->sec->idx;
+					shndx_data->d_size = sizeof(Elf32_Word);
+					shndx_data->d_align = 4;
+					shndx_data->d_type = ELF_T_WORD;
+
+					symtab_shndx->sh.sh_size += 4;
+					symtab_shndx->changed = true;
+				}
+
+				break;
+			}
+
+			WARN("index out of range");
 			return -1;
 		}
 
-		shndx_data = elf_newdata(s);
-		if (!shndx_data) {
-			WARN_ELF("elf_newshndx_data");
+		if (!symtab_data->d_size) {
+			WARN("zero size data");
 			return -1;
 		}
 
-		shndx_data->d_buf = &sym->sec->idx;
-		shndx_data->d_size = sizeof(Elf32_Word);
-		shndx_data->d_align = 4;
-		shndx_data->d_type = ELF_T_WORD;
+		if (idx * size < symtab_data->d_size)
+			break;
 
-		symtab_shndx->sh.sh_size += 4;
-		symtab_shndx->changed = true;
+		idx -= symtab_data->d_size / size;
 	}
 
-	return first_non_local;
+	if (idx < 0) {
+		WARN("negative index");
+		return -1;
+	}
+
+	if (shndx >= SHN_UNDEF && shndx < SHN_LORESERVE) {
+		sym->sym.st_shndx = shndx;
+		if (!shndx_data)
+			shndx = 0;
+	} else {
+		sym->sym.st_shndx = SHN_XINDEX;
+		if (!shndx_data) {
+			WARN("no .symtab_shndx");
+			return -1;
+		}
+	}
+
+	if (!gelf_update_symshndx(symtab_data, shndx_data, idx, &sym->sym, shndx)) {
+		WARN_ELF("gelf_update_symshndx");
+		return -1;
+	}
+
+	return 0;
 }
 
 static struct symbol *
 elf_create_section_symbol(struct elf *elf, struct section *sec)
 {
 	struct section *symtab, *symtab_shndx;
-	Elf_Data *shndx_data = NULL;
-	struct symbol *sym;
-	Elf32_Word shndx;
+	Elf32_Word first_non_local, new;
+	struct symbol *sym, *old;
+	int size;
+
+	if (elf->ehdr.e_ident[EI_CLASS] == ELFCLASS32)
+		size = sizeof(Elf32_Sym);
+	else
+		size = sizeof(Elf64_Sym);
 
 	symtab = find_section_by_name(elf, ".symtab");
 	if (symtab) {
 		symtab_shndx = find_section_by_name(elf, ".symtab_shndx");
-		if (symtab_shndx)
-			shndx_data = symtab_shndx->data;
 	} else {
 		WARN("no .symtab");
 		return NULL;
 	}
 
-	sym = malloc(sizeof(*sym));
+	sym = calloc(1, sizeof(*sym));
 	if (!sym) {
 		perror("malloc");
 		return NULL;
 	}
-	memset(sym, 0, sizeof(*sym));
-
-	sym->idx = elf_move_global_symbol(elf, symtab, symtab_shndx);
-	if (sym->idx < 0) {
-		WARN("elf_move_global_symbol");
-		return NULL;
-	}
 
 	sym->name = sec->name;
 	sym->sec = sec;
@@ -707,24 +748,42 @@ elf_create_section_symbol(struct elf *elf, struct section *sec)
 	// st_other 0
 	// st_value 0
 	// st_size 0
-	shndx = sec->idx;
-	if (shndx >= SHN_UNDEF && shndx < SHN_LORESERVE) {
-		sym->sym.st_shndx = shndx;
-		if (!shndx_data)
-			shndx = 0;
-	} else {
-		sym->sym.st_shndx = SHN_XINDEX;
-		if (!shndx_data) {
-			WARN("no .symtab_shndx");
+
+	new = symtab->sh.sh_size / size;
+
+	/*
+	 * Move the first global symbol, as per sh_info, into a new, higher
+	 * symbol index. This fees up a spot for a new local symbol.
+	 */
+	first_non_local = symtab->sh.sh_info;
+	old = find_symbol_by_index(elf, first_non_local);
+	if (old) {
+		old->idx = new;
+
+		hlist_del(&old->hash);
+		elf_hash_add(symbol, &old->hash, old->idx);
+
+		elf_dirty_reloc_sym(elf, old);
+
+		if (elf_update_symbol(elf, symtab, symtab_shndx, old)) {
+			WARN("elf_update_symbol move");
 			return NULL;
 		}
+
+		new = first_non_local;
 	}
 
-	if (!gelf_update_symshndx(symtab->data, shndx_data, sym->idx, &sym->sym, shndx)) {
-		WARN_ELF("gelf_update_symshndx");
+	sym->idx = new;
+	if (elf_update_symbol(elf, symtab, symtab_shndx, sym)) {
+		WARN("elf_update_symbol");
 		return NULL;
 	}
 
+	/*
+	 * Either way, we added a LOCAL symbol.
+	 */
+	symtab->sh.sh_info += 1;
+
 	elf_add_symbol(elf, sym);
 
 	return sym;
