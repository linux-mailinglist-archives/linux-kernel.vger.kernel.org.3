Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A7C5A3A61
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 00:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiH0W7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 18:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiH0W7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 18:59:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18694054E;
        Sat, 27 Aug 2022 15:59:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B08E60EC5;
        Sat, 27 Aug 2022 22:59:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794B5C433C1;
        Sat, 27 Aug 2022 22:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661641179;
        bh=0wKh1+suBHOHM0x8NCY0MJqyrQ71HC2Hlr27mRJ5BOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S0/6c+dZgq5SPHEs8no7mHkj7cXoctmlthAFdclJj4MrbTlRbIHW18ojPOW5eYgzj
         sWvGCmp/waOmKDADhFh5RpuR4Oak5JhY7Hi0lxWCZRh565171FXfvHKq/VtpngvHMo
         m3HptsN83Br2cz0b8q7rSLlgvSXbpvgJ60LRhwUjy1UfkLtQbMyx16U+bF5U3Ox4I/
         vtOIhIqvZMA/2+wrpzp8O+pICXPJG/KdJi0dDVLdaGnsGXk5BWEMsqumM0EfxJg3tH
         2caLeMjagFZtWsPLSj9Qh7dwVKfXz3/IGzFFo3AMOcZkBVwBtRz8JW5E7N8UsnsRyn
         sU2aJDBMydTRQ==
Date:   Sat, 27 Aug 2022 15:59:37 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: Re: [PATCH RFC] s390: Fix nospec table alignments
Message-ID: <20220827225937.b2mcmvxs7kbrtjda@treble>
References: <8719bf1ce4a72ebdeb575200290094e9ce047bcc.1661557333.git.jpoimboe@kernel.org>
 <YwphFXr+pHxf4PGT@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YwphFXr+pHxf4PGT@osiris>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2022 at 08:23:17PM +0200, Heiko Carstens wrote:
> On Fri, Aug 26, 2022 at 04:55:44PM -0700, Josh Poimboeuf wrote:
> > Add proper alignment for .nospec_call_table and .nospec_return_table in
> > vmlinux.
> > 
> > Fixes: f19fbd5ed642 ("s390: introduce execute-trampolines for branches")
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > ---
> > This is RFC because I don't know anything about s390 behavior for
> > unaligned data accesses, but this seemed to fix an issue for me.
> > 
> > While working on another s390 issue, I was getting intermittent boot
> > failures in __nospec_revert() when it tried to access 'instr[0]'.  I
> > noticed the __nospec_call_start address ended in 'ff'.  This patch
> > seemed to fix it.  I have no idea why it was (only sometimes) failing in
> > the first place.
> > 
> > The intermittent part of it is probably at least partially explained by
> > CONFIG_RANDOMIZE_BASE.  Except now I can no longer recreate it :-/
> > 
> > Regardless, this patch seems correct.  I just can't explain what I saw.
> > Any ideas?
> > 
> >  arch/s390/kernel/vmlinux.lds.S | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
> > index 2e526f11b91e..5ea3830af0cc 100644
> > --- a/arch/s390/kernel/vmlinux.lds.S
> > +++ b/arch/s390/kernel/vmlinux.lds.S
> > @@ -131,6 +131,7 @@ SECTIONS
> >  	/*
> >  	 * Table with the patch locations to undo expolines
> >  	*/
> > +	. = ALIGN(4);
> >  	.nospec_call_table : {
> >  		__nospec_call_start = . ;
> >  		*(.s390_indirect*)
> 
> On s390 labels must be at an even address due to instructions like
> "larl" (load address relative long), which generate a pc-relative
> address adding the number of words encoded into the instruction to the
> current IP.
> 
> With commit e6ed91fd0768 ("s390/alternatives: remove padding
> generation code") I managed to reduce the size of struct alt_instr by
> one byte, so it is now only 11 bytes in size. So depending on the size
> / number of members of the __alt_instructions array nospec_call_table
> starts at an uneven address, which would explain this.
> 
> Unfortunately I was unable to let any compiler generate code, that
> would use the larl instruction. Instead the address of
> nospec_call_table was loaded indirectly via the GOT, which again works
> always, regardless if the table starts at an even or uneven address.
> 
> This needs to be fixed anyway, and your patch certainly is correct.
> 
> Could you maybe share your kernel config + compiler version, if you
> are still able to reproduce this?

I think the trick is to disable CONFIG_RELOCATABLE.  When I compile with
CONFIG_RELOCATABLE=n and "gcc version 11.3.1 20220421 (Red Hat 11.3.1-2)
(GCC)", I get the following in nospec_init_branches():

 2a8:   c0 20 00 00 00 00       larl    %r2,2a8 <nospec_init_branches+0x30>     2aa: R_390_PC32DBL      __nospec_call_start+0x2

That said, I still haven't been able to figure out how to recreate the
program check in __nospec_revert(), even when the nospec_call_table
starts at an odd offset.

BTW, I only discovered this when testing with my pending patches which
propose getting rid of -fPIE for CONFIG_RELOCATABLE, so that more than
64k sections can be supported.  But that's a separate topic :-)

-- 
Josh
