Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8478B508E62
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381039AbiDTR2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243846AbiDTR2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:28:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4CAE0EB
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:25:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3430021115;
        Wed, 20 Apr 2022 17:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650475517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=beOjjz8wjPVhCvHg8uOnVQKum2lXeuiW4masHsPOdQQ=;
        b=bGx1CePCrWIifOZZocpsdLrRHb3bgZQRw2KTWM0IxQsNVFcswYWm9Nl50qP6Y05eVFzfD5
        flUscuZHsRgFKEGkpjCu3qdhQPkzQZkGEyiOmu7JpkmwheL5ba8VYSpuEEAqFAmFxLaxhx
        mNAo0jTWrBdIUx+5Wy+4Pe+dQM1Gu3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650475517;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=beOjjz8wjPVhCvHg8uOnVQKum2lXeuiW4masHsPOdQQ=;
        b=aFwBWj2uAWyjKcRIkbMSkBNkU0gAhBlMgpYJSL2wiqvVxkkTtlIc9+q4CnbbNyaAJPF2GH
        kT0LqluDjAW5jWBA==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 19D502C142;
        Wed, 20 Apr 2022 17:25:17 +0000 (UTC)
Date:   Wed, 20 Apr 2022 19:25:16 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/25] objtool: Rework ibt and extricate from stack
 validation
In-Reply-To: <fd1435e46bb95f81031b8fb1fa360f5f787e4316.1650300597.git.jpoimboe@redhat.com>
Message-ID: <alpine.LSU.2.21.2204201755580.1205@pobox.suse.cz>
References: <cover.1650300597.git.jpoimboe@redhat.com> <fd1435e46bb95f81031b8fb1fa360f5f787e4316.1650300597.git.jpoimboe@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A nit and it was there even before this patch...

> -static struct instruction *
> -validate_ibt_reloc(struct objtool_file *file, struct reloc *reloc)
> -{
> -	struct instruction *dest;
> -	struct section *sec;
> -	unsigned long off;
> -
> -	sec = reloc->sym->sec;
> -	off = reloc->sym->offset;
> -
> -	if ((reloc->sec->base->sh.sh_flags & SHF_EXECINSTR) &&
> -	    (reloc->type == R_X86_64_PC32 || reloc->type == R_X86_64_PLT32))
> -		off += arch_dest_reloc_offset(reloc->addend);

here...

> +static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn)
> +{

...
> +		off = reloc->sym->offset;
> +		if (reloc->type == R_X86_64_PC32 || reloc->type == R_X86_64_PLT32)
> +			off += arch_dest_reloc_offset(reloc->addend);
> +		else
> +			off += reloc->addend;

it looks kind of strange to have arch_dest_reloc_offset() and still 
reference arch-specific relocation types here. On the other hand it seems 
difficult to achieve complete arch-agnostic code, so take it just as a 
note and maybe someone porting objtool to a different architecture will 
split the code, make it all arch-independent and all will be nice and 
shiny.

Miroslav
