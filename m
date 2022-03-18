Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7974DD9B6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 13:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236234AbiCRM2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 08:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiCRM2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 08:28:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9181CCAC3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 05:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eD8tHWmaTx8P3KCt4/NT+8IXDEPFOlKb/XA8R7/3lFQ=; b=sD9r9ejmX3ReiEsAx5vVRKxbu7
        ZA+L7FENoatLkfcIySOgzFLthOn4EYhE9TuB46R/BSsm0S/At7NT7/1nqJnOcylT+hzrfNe5O8Rsy
        k0e+kMm4INgIpE4o5GGvcfWby/IgVC6zQv/Z7EJL4hEBE2pD+NQX0MqG/Z28jO9aqHWW2m/c3H4Ym
        2FFQ/ohRAmVgBa6Q/woubnW6GvweG9jdDdn1e2lZAhXpdJko04sMUKqsHty8DsckMkpdQtqi65xuR
        iQUgy/iJCSWbKDQ58YkoyxRieyZER2PRwW/0wKoVLZmATsn9Xx2zSsyYNorRA3SPD7PJOqUgnZRWv
        Wg8mH7Vg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nVBh6-007vr7-Kh; Fri, 18 Mar 2022 12:27:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 14D003001C7;
        Fri, 18 Mar 2022 13:26:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A2F9920D9D81E; Fri, 18 Mar 2022 13:26:56 +0100 (CET)
Date:   Fri, 18 Mar 2022 13:26:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sathvika Vasireddy <sv@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, aik@ozlabs.ru, mpe@ellerman.id.au,
        rostedt@goodmis.org, naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [RFC PATCH 3/3] objtool/mcount: Add powerpc specific functions
Message-ID: <YjR6kHq4c/rjCTpr@hirez.programming.kicks-ass.net>
References: <20220318105140.43914-1-sv@linux.ibm.com>
 <20220318105140.43914-4-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318105140.43914-4-sv@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 04:21:40PM +0530, Sathvika Vasireddy wrote:
> This patch adds powerpc specific functions required for
> 'objtool mcount' to work, and enables mcount for ppc.

I would love to see more objtool enablement for Power :-)


> diff --git a/tools/objtool/arch/powerpc/include/arch/elf.h b/tools/objtool/arch/powerpc/include/arch/elf.h
> new file mode 100644
> index 000000000000..3c8ebb7d2a6b
> --- /dev/null
> +++ b/tools/objtool/arch/powerpc/include/arch/elf.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#ifndef _OBJTOOL_ARCH_ELF
> +#define _OBJTOOL_ARCH_ELF
> +
> +#define R_NONE R_PPC_NONE
> +
> +#endif /* _OBJTOOL_ARCH_ELF */
> diff --git a/tools/objtool/utils.c b/tools/objtool/utils.c
> index d1fc6a123a6e..c9c14fa0dfd7 100644
> --- a/tools/objtool/utils.c
> +++ b/tools/objtool/utils.c
> @@ -179,11 +179,29 @@ int create_mcount_loc_sections(struct objtool_file *file)
>  		loc = (unsigned long *)sec->data->d_buf + idx;
>  		memset(loc, 0, sizeof(unsigned long));
>  
> -		if (elf_add_reloc_to_insn(file->elf, sec,
> -					  idx * sizeof(unsigned long),
> -					  R_X86_64_64,
> -					  insn->sec, insn->offset))
> -			return -1;
> +		if (file->elf->ehdr.e_machine == EM_X86_64) {
> +			if (elf_add_reloc_to_insn(file->elf, sec,
> +						  idx * sizeof(unsigned long),
> +						  R_X86_64_64,
> +						  insn->sec, insn->offset))
> +				return -1;
> +		}
> +
> +		if (file->elf->ehdr.e_machine == EM_PPC64) {
> +			if (elf_add_reloc_to_insn(file->elf, sec,
> +						  idx * sizeof(unsigned long),
> +						  R_PPC64_ADDR64,
> +						  insn->sec, insn->offset))
> +				return -1;
> +		}
> +
> +		if (file->elf->ehdr.e_machine == EM_PPC) {
> +			if (elf_add_reloc_to_insn(file->elf, sec,
> +						  idx * sizeof(unsigned long),
> +						  R_PPC_ADDR32,
> +						  insn->sec, insn->offset))
> +				return -1;
> +		}

It appears to me that repeating this code 3 times doesn't really scale
well, how about we introduce a helper like:


int elf_reloc_type_long(struct elf *elf)
{
	switch (elf->ehdr.e_machine) {
	case EM_X86_64:
		return R_X86_64_64;
	case EM_PPC64:
		return R_PPC64_ADDR64;
	case EM_PPC:
		return R_PPC_ADDR32;
	default:
		WARN("unknown machine...")
		exit(-1);
	}
}

		if (elf_add_reloc_to_insn(file->elf, sec,
					  idx * sizeof(unsigned long),
					  elf_reloc_type_long(file->elf),
					  insn->sec, insn->offset))
			return -1;

