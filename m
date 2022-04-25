Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A3B50D96A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 08:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbiDYGaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 02:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiDYGaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 02:30:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A875C64F
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 23:27:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 71012210F3;
        Mon, 25 Apr 2022 06:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650868037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QOnKlAHRJyRZh6UTpzLqlrkzZwi4pUejGOJI+FgSH1M=;
        b=TkM+ckAIkflSnwvJTgnOGO3a95nO9NarZAJ6TJosfV58gJ69hE+wbR1ci0u3R4dfBitSo2
        Ps4ohRYff7nxZkkwh+DCyzVsyKyG6tHRZY6rpkAKFLlsoYpj9G8gdRTl19cdZ4Veb2OQ7P
        oq1Yn5xO3s+c0mG513ZlMHggQzwtMeo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650868037;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QOnKlAHRJyRZh6UTpzLqlrkzZwi4pUejGOJI+FgSH1M=;
        b=hnG7m/7l7EV0wMdRJvVFE/G6qqbPbmjrE5uP2daOHr9LJmtSt834+h1G6t3dO7jtk7aQnX
        3Vjwhb9vlqGKEUAw==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 53DA72C141;
        Mon, 25 Apr 2022 06:27:17 +0000 (UTC)
Date:   Mon, 25 Apr 2022 08:27:17 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/25] objtool: Rework ibt and extricate from stack
 validation
In-Reply-To: <20220422105037.GV2731@worktop.programming.kicks-ass.net>
Message-ID: <alpine.LSU.2.21.2204250826540.25526@pobox.suse.cz>
References: <cover.1650300597.git.jpoimboe@redhat.com> <fd1435e46bb95f81031b8fb1fa360f5f787e4316.1650300597.git.jpoimboe@redhat.com> <alpine.LSU.2.21.2204201755580.1205@pobox.suse.cz> <20220422105037.GV2731@worktop.programming.kicks-ass.net>
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

On Fri, 22 Apr 2022, Peter Zijlstra wrote:

> On Wed, Apr 20, 2022 at 07:25:16PM +0200, Miroslav Benes wrote:
> > A nit and it was there even before this patch...
> > 
> > > -static struct instruction *
> > > -validate_ibt_reloc(struct objtool_file *file, struct reloc *reloc)
> > > -{
> > > -	struct instruction *dest;
> > > -	struct section *sec;
> > > -	unsigned long off;
> > > -
> > > -	sec = reloc->sym->sec;
> > > -	off = reloc->sym->offset;
> > > -
> > > -	if ((reloc->sec->base->sh.sh_flags & SHF_EXECINSTR) &&
> > > -	    (reloc->type == R_X86_64_PC32 || reloc->type == R_X86_64_PLT32))
> > > -		off += arch_dest_reloc_offset(reloc->addend);
> > 
> > here...
> > 
> > > +static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn)
> > > +{
> > 
> > ...
> > > +		off = reloc->sym->offset;
> > > +		if (reloc->type == R_X86_64_PC32 || reloc->type == R_X86_64_PLT32)
> > > +			off += arch_dest_reloc_offset(reloc->addend);
> > > +		else
> > > +			off += reloc->addend;
> > 
> > it looks kind of strange to have arch_dest_reloc_offset() and still 
> > reference arch-specific relocation types here. On the other hand it seems 
> > difficult to achieve complete arch-agnostic code, so take it just as a 
> > note and maybe someone porting objtool to a different architecture will 
> > split the code, make it all arch-independent and all will be nice and 
> > shiny.
> 
> Something like so perhaps? Seems to build and boot x86_64-defconfig.

Yes, that looks good. Thanks.

Miroslav
