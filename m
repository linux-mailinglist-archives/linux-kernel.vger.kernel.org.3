Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3BA570D01
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbiGKVwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbiGKVwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:52:06 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1896764E0A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:52:04 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 26BLmgGA018033;
        Mon, 11 Jul 2022 16:48:42 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 26BLmeGc018032;
        Mon, 11 Jul 2022 16:48:40 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 11 Jul 2022 16:48:40 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Michael Ellerman <michael@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc: e500: Fix compilation with gcc e500 compiler
Message-ID: <20220711214840.GJ25951@gate.crashing.org>
References: <20220524093939.30927-1-pali@kernel.org> <20220702094405.tp7eo4df7fjvn2ng@pali> <8D562851-304F-4153-9194-426CC22B7FF2@ellerman.id.au> <20220704103951.nm4m4kpgnus3ucqo@pali> <CAK8P3a2tdny8SA7jcqhUZT13iq1mYqjFueC-gnTUZA1JKCtfgg@mail.gmail.com> <20220708171227.74nbcgsk63y4bdna@pali> <CAK8P3a3YMqGEjRr+ZD4Enm4pnuNNZOaeXqpY=PDXAP7w3P7y4A@mail.gmail.com> <d9339bb9-2410-bea5-7502-1c7839707f4e@csgroup.eu> <20220711161442.GD25951@gate.crashing.org> <2552726a-cca4-ecd4-6fca-4f73bbf7942e@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2552726a-cca4-ecd4-6fca-4f73bbf7942e@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Mon, Jul 11, 2022 at 05:32:09PM +0000, Christophe Leroy wrote:
> Le 11/07/2022 à 18:14, Segher Boessenkool a écrit :
> >>     CC      arch/powerpc/kernel/irq.o
> >> {standard input}: Assembler messages:
> >> {standard input}:3535: Error: unrecognized opcode: `wrteei'
> >> {standard input}:5608: Error: unrecognized opcode: `wrteei'
> > 
> > What -mcpu= did it use here?
> 
> -mcpu=powerpc64
> 
> > wrteei is not a PowerPC insn (it is BookE, instead), so it is not
> > recognised without an appropriate -mcpu=.
> > 
> >> If I select the e5500 (without altivec) or e6500 I get:
> >>
> >>     CC      arch/powerpc/kernel/io.o
> >> {standard input}: Assembler messages:
> >> {standard input}:381: Error: unrecognized opcode: `eieio'
> > 
> > Same question.  eieio is a base PowerPC instruction, so this one is
> > "interesting" :-)
> 
> -mcpu=e500mc64 (for e5500)
> -mcpu=e6500 (for e6500)
> 
> I had to replace 'eieio' instruction by 'mbar' instruction.

I saw some patches fly by...  you have it all fixed with that?

> Seems like binutils added 'eieio' to e500 in 2010 via commit 
> e01d869a3be, but it seems it is only for the 85xx, not for the others.

I believe the eieio instruction is disabled on some e500 models, because
it does not work correctly, so EIEIO_EN=1 cannot work, something like
that?


Segher
