Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D1D57082C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 18:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiGKQSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 12:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiGKQSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:18:11 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 485D47AC26
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:18:10 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 26BGEhJX006415;
        Mon, 11 Jul 2022 11:14:43 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 26BGEhND006414;
        Mon, 11 Jul 2022 11:14:43 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 11 Jul 2022 11:14:42 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Michael Ellerman <michael@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc: e500: Fix compilation with gcc e500 compiler
Message-ID: <20220711161442.GD25951@gate.crashing.org>
References: <20220524093939.30927-1-pali@kernel.org> <20220702094405.tp7eo4df7fjvn2ng@pali> <8D562851-304F-4153-9194-426CC22B7FF2@ellerman.id.au> <20220704103951.nm4m4kpgnus3ucqo@pali> <CAK8P3a2tdny8SA7jcqhUZT13iq1mYqjFueC-gnTUZA1JKCtfgg@mail.gmail.com> <20220708171227.74nbcgsk63y4bdna@pali> <CAK8P3a3YMqGEjRr+ZD4Enm4pnuNNZOaeXqpY=PDXAP7w3P7y4A@mail.gmail.com> <d9339bb9-2410-bea5-7502-1c7839707f4e@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9339bb9-2410-bea5-7502-1c7839707f4e@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 09, 2022 at 09:26:11AM +0000, Christophe Leroy wrote:
> If I select the GENERIC_CPU or e5500 (with altivec) I get:
> 
>    CC      arch/powerpc/kernel/irq.o
> {standard input}: Assembler messages:
> {standard input}:3535: Error: unrecognized opcode: `wrteei'
> {standard input}:5608: Error: unrecognized opcode: `wrteei'

What -mcpu= did it use here?

wrteei is not a PowerPC insn (it is BookE, instead), so it is not
recognised without an appropriate -mcpu=.

> If I select the e5500 (without altivec) or e6500 I get:
> 
>    CC      arch/powerpc/kernel/io.o
> {standard input}: Assembler messages:
> {standard input}:381: Error: unrecognized opcode: `eieio'

Same question.  eieio is a base PowerPC instruction, so this one is
"interesting" :-)


Segher
