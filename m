Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71A35007A0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 09:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240559AbiDNHzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 03:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237045AbiDNHzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 03:55:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DF6396A8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 00:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Mv+7Iz1BPKhhq+LK+IQAxPAtVwGoSMM8gimzeO1IWrg=; b=H0d3UeW3Z13qFzf+tl0XxP2tww
        XauJ1sLV8QWB5Q0eZiXF/gwqEEyHLWMyK0Gd0NC/jNTIHJ43igUnIjJK63yft9nY2r8nr0HCFfumI
        D8e+z/0R8+DOwmKaZrd0DxIKqKrLAak0zHxghuRwd4xunGrkfkhZ/M8LnAGpSUpmhOiq0UlJqI8BK
        4V0pa/SvaeUzrVVaASAyDRkTvway8a7QJj/pweJoyBlio/5sPJMdekxMn4F5kopVQfwQOHgTgkDtJ
        t8dsmyJ7CXU14fBl82hzN9BqvmmQ7D/+P/Np+6vjpwq3qMEY3s6/pdUj3tZNirgOqtrAIbseElAl2
        fcfD55Lw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1neuI3-004wtA-0l; Thu, 14 Apr 2022 07:53:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9924C3000E3;
        Thu, 14 Apr 2022 09:53:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8277C2C5BC385; Thu, 14 Apr 2022 09:53:18 +0200 (CEST)
Date:   Thu, 14 Apr 2022 09:53:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 10/18] objtool: Extricate ibt from stack validation
Message-ID: <YlfS7twQVCHGgtCV@hirez.programming.kicks-ass.net>
References: <cover.1649891421.git.jpoimboe@redhat.com>
 <44a73f724b51c4a994edc43536b7a7ee5e972b40.1649891421.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44a73f724b51c4a994edc43536b7a7ee5e972b40.1649891421.git.jpoimboe@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 04:19:45PM -0700, Josh Poimboeuf wrote:
> Extricate ibt from validate_branch() in preparation for making stack
> validation optional.

It does a bit more..


> -		/* already done in validate_branch() */
> -		if (sec->sh.sh_flags & SHF_EXECINSTR)
> -			continue;
>  
> -		if (!sec->reloc)
>  			continue;
>  
> -		if (!strncmp(sec->name, ".orc", 4))
> -			continue;
>  
> -		if (!strncmp(sec->name, ".discard", 8))
>  			continue;
>  
> -		if (!strncmp(sec->name, ".debug", 6))
>  			continue;
>  
> -		if (!strcmp(sec->name, "_error_injection_whitelist"))
>  			continue;
>  
> -		if (!strcmp(sec->name, "_kprobe_blacklist"))
>  			continue;
>  
> -		is_data = strstr(sec->name, ".data") || strstr(sec->name, ".rodata");
>  
> -		list_for_each_entry(reloc, &sec->reloc->reloc_list, list) {
> -			struct instruction *dest;
>  
> -			dest = validate_ibt_reloc(file, reloc);
> -			if (is_data && dest && !dest->noendbr)
> -				warn_noendbr("data ", sec, reloc->offset, dest);
> -		}

So this iterates all sections and excludes a bunch, and only reports
fail for .data/.rodata.

> +static int validate_ibt(struct objtool_file *file)
> +{
> +	struct section *sec;
> +	struct reloc *reloc;
> +	struct instruction *insn;
> +	int warnings = 0;
> +
> +	for_each_insn(file, insn)
> +		warnings += validate_ibt_insn(file, insn);

So I specifically didn't do this because I wanted to reduce the amount
of loops we do over those instructions. But yeah, if you really want to
allow --ibt without --stack-validate (but why?) then I suppose so.

Esp. for the vmlinux.o case, iterating all insn can quickly add up to
significant time.

> +	for_each_sec(file, sec) {
> +
> +		if (!strstr(sec->name, ".data") && !strstr(sec->name, ".rodata"))
> +			continue;

But this only iterates .data/.rodata.

That's not the same, specifically, it'll not iterate stuff like ksymtab
that contains the EXPORT_SYMBOL* crud. The result being that we can now
seal EXPORT'ed symbols, which will make modules really sad.

There's also the .initcall sections, sealing initcalls typcally ends really
badly.

And there might be a few others I forgot about.

> +		if (!sec->reloc)
> +			continue;
> +
> +		list_for_each_entry(reloc, &sec->reloc->reloc_list, list)
> +			warnings += validate_ibt_data_reloc(file, reloc);
> +	}
> +
> +	return warnings;
>  }
>  
>  static int validate_reachable_instructions(struct objtool_file *file)
> -- 
> 2.34.1
> 
