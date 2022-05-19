Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9578252D732
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240651AbiESPOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240712AbiESPOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:14:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C21EC33C
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:13:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E13CB8255C
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 15:13:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF83C385AA;
        Thu, 19 May 2022 15:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652973237;
        bh=/qSDeChNAv8oe7nDJtJ4OauvaBSqyoKSFNDbkvdSOko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JyruuCxe8g/67py8MJE/0LyeX0+M3b4Z5Jrzh2DF0F5Ixq5biz8JJknzvSjIzH0wZ
         coWS2N0s26CFBAP8MSciSlS4FH46JUc6jfrvwxUfsKxOASUI/gg5G3DNxNjXvYyK2x
         E7thJI5OGCnWdcKeVEBjz6Vi+WsgkoLWEiedRTwuUBJlxySeKIUnmvJdtVsukMUu8f
         hGWPvSxxmjOK0he0yrD0NKI2+WCZ11+EvdbXAQx6bpiK6TtuH8+FkFyojQPfZsitxt
         DvgxgDBu5xTFIj9B7XP4+28KA4dK38Er/lNVKLsfOAuKmYNrgzaAoeVMsGyR8rO8NR
         mIniqIA9xVD0g==
Date:   Thu, 19 May 2022 08:13:55 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH v2] objtool: Fix symbol creation
Message-ID: <20220519151355.x7j3xmkelpakw4gx@treble>
References: <YoK4U9RgQ9N+HhXJ@dev-arch.thelio-3990X>
 <20220516214005.GQ76023@worktop.programming.kicks-ass.net>
 <YoPAZ6JfsF0LrQNc@hirez.programming.kicks-ass.net>
 <YoPCTEYjoPqE4ZxB@hirez.programming.kicks-ass.net>
 <20220518012429.4zqzarvwsraxivux@treble>
 <20220518074152.GB10117@worktop.programming.kicks-ass.net>
 <20220518173604.7gcrjjum6fo2m2ub@treble>
 <YoVuxKGkt0IQ0yjb@hirez.programming.kicks-ass.net>
 <20220519090029.GA6479@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220519090029.GA6479@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 11:00:29AM +0200, Peter Zijlstra wrote:
> Subject: objtool: Fix symbol creation
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Tue, 17 May 2022 17:42:04 +0200
> 
> Nathan reported objtool failing with the following messages:
> 
>   warning: objtool: no non-local symbols !?
>   warning: objtool: gelf_update_symshndx: invalid section index
> 
> The problem is due to commit 4abff6d48dbc ("objtool: Fix code relocs
> vs weak symbols") failing to consider the case where an object would
> have no non-local symbols.
> 
> The problem that commit tries to address is adding a STB_LOCAL symbol
> to the symbol table in light of the ELF spec's requirement that:
> 
>   In each symbol table, all symbols with STB_LOCAL binding preced the
>   weak and global symbols.  As ``Sections'' above describes, a symbol
>   table section's sh_info section header member holds the symbol table
>   index for the first non-local symbol.
> 
> The approach taken is to find this first non-local symbol, move that
> to the end and then re-use the freed spot to insert a new local symbol
> and increment sh_info.
> 
> Except it never considered the case of object files without global
> symbols and got a whole bunch of details wrong -- so many in fact that
> it is a wonder it ever worked :/
> 
> Specifically:
> 
>  - It failed to re-hash the symbol on the new index, so a subsequent
>    find_symbol_by_index() would not find it at the new location and a
>    query for the old location would now return a non-deterministic
>    choice between the old and new symbol.
> 
>  - It failed to appreciate that the GElf wrappers are not a valid disk
>    format (it works because GElf is basically Elf64 and we only
>    support x86_64 atm.)
> 
>  - It failed to fully appreciate how horrible the libelf API really is
>    and got the gelf_update_symshndx() call pretty much completely
>    wrong; with the direct consequence that if inserting a second
>    STB_LOCAL symbol would require moving the same STB_GLOBAL symbol
>    again it would completely come unstuck.
> 
> Write a new elf_update_symbol() function that wraps all the magic
> required to update or create a new symbol at a given index.
> 
> Specifically, gelf_update_sym*() require an @ndx argument that is
> relative to the @data argument; this means you have to manually
> iterate the section data descriptor list and update @ndx.
> 
> Fixes: 4abff6d48dbc ("objtool: Fix code relocs vs weak symbols")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Nathan Chancellor <nathan@kernel.org>

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh
