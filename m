Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24A254F86D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382284AbiFQNkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381935AbiFQNk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:40:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03ADC3F30C;
        Fri, 17 Jun 2022 06:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zDpXDuqpvgzFWjIbNlcO+gbKjzhBODohTr3+PF/LVl4=; b=FxYZ47ZIOZ1WA+g/I4/tSaO7Xe
        3ysEJ7+2R/wI9vsqiRGfQaj9lnENjMIH2p2msSDcu768oYrmXlqg2N7wo+R4tlvKBKLlcgE+520Bq
        Njom2JorsnWaR8vuuqrTrsy5KPV3OAf1TeQdYgLeYqWU9VF7/LbGCQacHzGt0J19tBygNEkt9d2ud
        nP3gGNeXsFSGnJNEuyjC82J31PWPKnpGCDsfQNzTCuwndU4E6eFZKOLADh3LcFL3DhdA2m7XZ3s0V
        U8Pzi6+amx1m5gRzPpC9bJMOp2VIBTrkhwRLDg3b7ANYaLScwQgpOJT/DTzn4cCzkYwXi0ButxeBD
        ztAFC6/A==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2CD0-002s0x-Hi; Fri, 17 Jun 2022 13:40:22 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A799E9816B5; Fri, 17 Jun 2022 15:40:20 +0200 (CEST)
Date:   Fri, 17 Jun 2022 15:40:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        "open list:S390" <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] jump_label: make initial NOP patching the special
 case
Message-ID: <YqyERLVg45bi0pCJ@worktop.programming.kicks-ass.net>
References: <20220615154142.1574619-1-ardb@kernel.org>
 <20220615154142.1574619-4-ardb@kernel.org>
 <CAMj1kXFfVi8sYXR0z42v72XfTBaQ9jaDAzuLuK=TBKHUqKkEPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFfVi8sYXR0z42v72XfTBaQ9jaDAzuLuK=TBKHUqKkEPA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 01:25:02PM +0200, Ard Biesheuvel wrote:
> On Wed, 15 Jun 2022 at 17:41, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > Instead of defaulting to patching NOP opcodes at init time, and leaving
> > it to the architectures to override this if this is not needed, switch
> > to a model where doing nothing is the default. This is the common case
> > by far, as only MIPS requires NOP patching at init time. On all other
> > architectures, the correct encodings are emitted by the compiler and so
> > no initial patching is needed.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  Documentation/staging/static-keys.rst |  3 ---
> >  arch/arc/kernel/jump_label.c          | 13 -------------
> >  arch/arm/kernel/jump_label.c          |  6 ------
> >  arch/arm64/kernel/jump_label.c        | 11 -----------
> >  arch/mips/include/asm/jump_label.h    |  2 ++
> >  arch/parisc/kernel/jump_label.c       | 11 -----------
> >  arch/riscv/kernel/jump_label.c        | 12 ------------
> >  arch/s390/kernel/jump_label.c         |  5 -----
> >  arch/x86/kernel/jump_label.c          | 13 -------------
> >  kernel/jump_label.c                   | 14 +++++---------
> >  10 files changed, 7 insertions(+), 83 deletions(-)
> >
> 
> This needs the following hunk as well, as spotted by the bot:
> 
> --- a/include/linux/jump_label.h
> +++ b/include/linux/jump_label.h
> @@ -220,8 +220,6 @@ extern void jump_label_lock(void);
>  extern void jump_label_unlock(void);
>  extern void arch_jump_label_transform(struct jump_entry *entry,
>                                       enum jump_label_type type);
> -extern void arch_jump_label_transform_static(struct jump_entry *entry,
> -                                            enum jump_label_type type);
>  extern bool arch_jump_label_transform_queue(struct jump_entry *entry,
>                                             enum jump_label_type type);
>  extern void arch_jump_label_transform_apply(void);
> 
Done, Thanks!



