Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28342528916
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238592AbiEPPlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbiEPPlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:41:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD72127B36
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AyJBqgpz73uaiM8oXDPx2MhxDsj8LgRWS3TNA7ATI6M=; b=K0O3qejpmE2QUjNiIa/ko4USJv
        KGzQxmKT0v8gaONRuBtau+H4FeHVKT9U67qUAXhtBQHhEpDJMcJbyvX8GKSGV/d3bfL6/VPfdOoeP
        1WShfjajJbPX1ar/mzAo7Frr3rmQx8uGd5t7q0cCf3aF70mr6AFjB3J4OQAjRCapX/ho3Z32f3q4C
        IOcYg4GS6p3QvP2MvOfHrym5ygBAjkiy9vOM0TJY45y6BqscPlpupjMvJJBAQKKjxjmXLecHiJJwk
        v9IT0o5+uMcXj+wKx/xvnQg7uGYz2cRCfi3/zQpg6mP1+n6z6xMHJJ4NvwhWdSnihMwWXIEbfK3Dt
        1Gqab9vA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqcqs-000yQs-NB; Mon, 16 May 2022 15:41:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 705B830023F;
        Mon, 16 May 2022 17:41:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 501B920225E5F; Mon, 16 May 2022 17:41:40 +0200 (CEST)
Date:   Mon, 16 May 2022 17:41:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: fix objtool regression on x32 systems
Message-ID: <YoJwtCeVzYUm6Uhg@hirez.programming.kicks-ass.net>
References: <alpine.LRH.2.02.2205161041260.11556@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2205161041260.11556@file01.intranet.prod.int.rdu2.redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 11:06:36AM -0400, Mikulas Patocka wrote:
> The patch 4abff6d48dbc ("objtool: Fix code relocs vs weak symbols") makes
> the kernel unbootable.  The patch c087c6e7b551 ("objtool: Fix type of
> reloc::addend") attempts to fix it by replacing 'int' with 'long'.
> 
> However, we may be running on a system with x32 ABI and 'long' on x32 is
> 32-bit, thus the patch c087c6e7b551 doesn't really change anything and we
> still end up with miscompiled kernel.  This patch replaces 'long' with
> 'long long', so that the 64-bit kernel is correctly compiled on a x32
> system.

Hurmph.. you're building a 64bit kernel on a x32 hosted machine? And
this is the *only* thing that goes sideways?

I suspect quite a bit of objtool assumes LP64 and won't quite work right
on ILP32 and we've just been lucky so far.

> Index: linux-2.6/tools/objtool/elf.c
> ===================================================================
> --- linux-2.6.orig/tools/objtool/elf.c	2022-05-16 16:20:49.000000000 +0200
> +++ linux-2.6/tools/objtool/elf.c	2022-05-16 16:22:21.000000000 +0200
> @@ -546,7 +546,7 @@ static struct section *elf_create_reloc_
>  						int reltype);
>  
>  int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
> -		  unsigned int type, struct symbol *sym, long addend)
> +		  unsigned int type, struct symbol *sym, long long addend)
>  {
>  	struct reloc *reloc;
>  
> Index: linux-2.6/tools/objtool/include/objtool/elf.h
> ===================================================================
> --- linux-2.6.orig/tools/objtool/include/objtool/elf.h	2022-05-16 16:07:54.000000000 +0200
> +++ linux-2.6/tools/objtool/include/objtool/elf.h	2022-05-16 16:22:45.000000000 +0200
> @@ -73,7 +73,7 @@ struct reloc {
>  	struct symbol *sym;
>  	unsigned long offset;
>  	unsigned int type;
> -	long addend;
> +	long long addend;
>  	int idx;
>  	bool jump_table_start;
>  };
> @@ -135,7 +135,7 @@ struct elf *elf_open_read(const char *na
>  struct section *elf_create_section(struct elf *elf, const char *name, unsigned int sh_flags, size_t entsize, int nr);
>  
>  int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
> -		  unsigned int type, struct symbol *sym, long addend);
> +		  unsigned int type, struct symbol *sym, long long addend);
>  int elf_add_reloc_to_insn(struct elf *elf, struct section *sec,
>  			  unsigned long offset, unsigned int type,
>  			  struct section *insn_sec, unsigned long insn_off);
> 

I think I much prefer s64 there instead of 'long long'. But really I
think all of objtool needs a bit of an audit to see what types need be
used.
