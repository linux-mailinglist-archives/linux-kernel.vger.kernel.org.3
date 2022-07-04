Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438C856531F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbiGDLQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiGDLQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:16:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D75101F1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 04:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SbHD1n8XqP8wGQ3XxCknC9EbZ1/NABCZiXDwJDXdcag=; b=j16v+wZXZzVjoqO5IBM8tZyzfm
        r3aWHwyq5XtDLX0xcR+zPinVx62H/w9KWuLDJwe0iZFQlSHqC2oJW408VYD5BBeQU1Zub19ahPFKa
        x2epAN7Roi7fM2acJLCrusgayQB385AUZXJQ7Mqg1EDOX53arvHhpLw2Ul7OEAtOWcHGJCltD6qWM
        UxUdyzqm7Htiv/7oK7FzBGJ+yyQkt+XdENwO+80QHW8nzf4DlcE6tjDyXnISjD2G9zFR6hvvMfAPm
        TyWKPfxI5O8PHRIIwafFI+jo8Psau8XPcuONAaW77dd/r+Zh0J6n7ZpgawaV0yzr4eoErGWHJ5pok
        MAm2hViA==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8K2e-00HCvW-1b; Mon, 04 Jul 2022 11:15:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1E33830033D;
        Mon,  4 Jul 2022 13:14:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E19402028F029; Mon,  4 Jul 2022 13:14:56 +0200 (CEST)
Date:   Mon, 4 Jul 2022 13:14:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sathvika Vasireddy <sv@linux.ibm.com>,
        g@hirez.programming.kicks-ass.net
Cc:     linuxppc-dev@lists.ozlabs.org, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        christophe.leroy@csgroup.eu, mingo@redhat.com, rostedt@goodmis.org,
        naveen.n.rao@linux.vnet.ibm.com, mbenes@suse.cz,
        benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [RFC PATCH v3 07/12] objtool: Use macros to define arch specific
 reloc types
Message-ID: <YsLLsE2oajICIYmq@hirez.programming.kicks-ass.net>
References: <20220624183238.388144-1-sv@linux.ibm.com>
 <20220624183238.388144-8-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624183238.388144-8-sv@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2022 at 12:02:33AM +0530, Sathvika Vasireddy wrote:
> Make relocation types architecture specific.
> 
> Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
> ---
>  tools/objtool/arch/x86/include/arch/elf.h | 2 ++
>  tools/objtool/check.c                     | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/objtool/arch/x86/include/arch/elf.h b/tools/objtool/arch/x86/include/arch/elf.h
> index 69cc4264b28a..ac14987cf687 100644
> --- a/tools/objtool/arch/x86/include/arch/elf.h
> +++ b/tools/objtool/arch/x86/include/arch/elf.h
> @@ -2,5 +2,7 @@
>  #define _OBJTOOL_ARCH_ELF
>  
>  #define R_NONE R_X86_64_NONE
> +#define R_ABS64 R_X86_64_64
> +#define R_ABS32 R_X86_64_32
>  
>  #endif /* _OBJTOOL_ARCH_ELF */
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 98e869721bc4..88f68269860e 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -834,7 +834,7 @@ static int create_mcount_loc_sections(struct objtool_file *file)
>  		memset(loc, 0, size);
>  
>  		if (elf_add_reloc_to_insn(file->elf, sec, idx,
> -					  R_X86_64_64,
> +					  size == sizeof(u64) ? R_ABS64 : R_ABS32,
>  					  insn->sec, insn->offset))
>  			return -1;
>  

Given cross compiles, should this not also be elf dependent?
