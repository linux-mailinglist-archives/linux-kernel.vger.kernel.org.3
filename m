Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE36B56587D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbiGDOUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbiGDOUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:20:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72D7FF1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=jc10IQJyl7R9z2Pi3/7y2+bfFKI3NYUFP6i+uQTAp2Y=; b=Bt1weozMWS50R4n+lfqxMxazHF
        TveNDLTmiJEHKNHvQREVGPIKfrQGk3q9doqq/ABlctXEH2yoTOZr4BVCQ86p+X6CoJLJIhig2O5iZ
        OeOaV1ZastaIdZ+ZIAKQji7p1zTeulZ35laz2ctdBLRr/zVAfIbZWSNQUarTzPe5y+SZC1yYTqW73
        0ORHHqoORwfPsQ1r28ZMFDDIQxxpsec0odV3wyLtsOF7/DViK/0wpzxfxhnmnO4bdGVDc1T9u8E0Y
        zN4W2azWNbDIpI4ERMla+djJ3+o1Il+7ALvE/YlMp9zKcFeoD+MRSCuL2hdE4REvqBjXRWhJYou7H
        RcCHYwLw==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8MvM-00H9iI-Rf; Mon, 04 Jul 2022 14:19:41 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0FDEF980057; Mon,  4 Jul 2022 16:19:43 +0200 (CEST)
Date:   Mon, 4 Jul 2022 16:19:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Sathvika Vasireddy <sv@linux.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>
Subject: Re: [RFC PATCH v3 11/12] powerpc: Remove unreachable() from WARN_ON()
Message-ID: <YsL2/uwU6j8jbzpP@worktop.programming.kicks-ass.net>
References: <20220624183238.388144-1-sv@linux.ibm.com>
 <20220624183238.388144-12-sv@linux.ibm.com>
 <70b6d08d-aced-7f4e-b958-a3c7ae1a9319@csgroup.eu>
 <YsLXkCMtQpxmDhVM@hirez.programming.kicks-ass.net>
 <1d0c5ebc-3f66-f6cb-998f-072bceb41c5c@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d0c5ebc-3f66-f6cb-998f-072bceb41c5c@csgroup.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 12:44:30PM +0000, Christophe Leroy wrote:
> 
> 
> Le 04/07/2022 à 14:05, Peter Zijlstra a écrit :
> > On Sat, Jun 25, 2022 at 06:46:54AM +0000, Christophe Leroy wrote:
> >>
> >>
> >> Le 24/06/2022 à 20:32, Sathvika Vasireddy a écrit :
> >>> objtool is throwing *unannotated intra-function call*
> >>> warnings with a few instructions that are marked
> >>> unreachable. Remove unreachable() from WARN_ON()
> >>> to fix these warnings, as the codegen remains same
> >>> with and without unreachable() in WARN_ON().
> >>
> >> Did you try the two exemples described in commit 1e688dd2a3d6
> >> ("powerpc/bug: Provide better flexibility to WARN_ON/__WARN_FLAGS() with
> >> asm goto") ?
> >>
> >> Without your patch:
> >>
> >> 00000640 <test>:
> >>    640:	81 23 00 84 	lwz     r9,132(r3)
> >>    644:	71 29 40 00 	andi.   r9,r9,16384
> >>    648:	40 82 00 0c 	bne     654 <test+0x14>
> >>    64c:	80 63 00 0c 	lwz     r3,12(r3)
> >>    650:	4e 80 00 20 	blr
> >>    654:	0f e0 00 00 	twui    r0,0
> >>
> >> 00000658 <test9w>:
> >>    658:	2c 04 00 00 	cmpwi   r4,0
> >>    65c:	41 82 00 0c 	beq     668 <test9w+0x10>
> >>    660:	7c 63 23 96 	divwu   r3,r3,r4
> >>    664:	4e 80 00 20 	blr
> >>    668:	0f e0 00 00 	twui    r0,0
> >>    66c:	38 60 00 00 	li      r3,0
> >>    670:	4e 80 00 20 	blr
> > 
> > Per this construct you should do as x86 does and assume twui terminates
> > control flow and explicitly annotate the WARN case. That is, given the
> > fact that BUG as no instructions following it, you can't very well
> > annotate that.
> 
> That exactly the problem I guess. I'm fine with replacing the 
> unreachable() by __builtin_unreachable() with our __WARN_FLAGS() and 
> BUG() but we will still have a problem with some of the unrachable() 
> that are in core parts of the kernel.
> 
> Even the ones in arch/powerpc/, they are valid and should remain. The 
> point seems that the generic annotate_unreachable() is wrong for powerpc 
> as is, and activating CONFIG_OBJTOOL lead to bad code generation.

Right; I'm not against making that depend on yet-another OBJTOOL_$config
thing.

> By the way, for which functionnalities of objtool is that analysis 
> necessary ? I understand it is not necessary to mcount accounting, so 
> maybe the not empty annotate_unreachable() should be limited to those 
> those functionnalities ?

For all the things where it needs to follow control flow, so stack
validation, ORC generation, unreachable instruction validation etc..

I'd need to double check code-gen on x86, but the way
__builtin_unreachable() makes code-gen stop dead, I'm not entirely sure
it's right for us either.

> > Alternatively, you can teach objtool to look at __bug_table to
> > distinguish these cases.
> 
> Isn't it enough to tell objtool that execution never go past twui, using 
> INSN_BUG ?

That should work I suppose.

> By the way, for __WARN_FLAGS, we use the __extable for the continuation. 
> Is objtools able to follow __extable ?

Yes.
