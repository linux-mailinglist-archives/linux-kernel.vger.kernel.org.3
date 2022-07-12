Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E942571C04
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiGLOOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiGLOO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:14:28 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6B1033A0B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:14:23 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 26CEB93o025896;
        Tue, 12 Jul 2022 09:11:09 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 26CEB7M3025895;
        Tue, 12 Jul 2022 09:11:07 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 12 Jul 2022 09:11:07 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Michael Ellerman <michael@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc: e500: Fix compilation with gcc e500 compiler
Message-ID: <20220712141107.GM25951@gate.crashing.org>
References: <8D562851-304F-4153-9194-426CC22B7FF2@ellerman.id.au> <20220704103951.nm4m4kpgnus3ucqo@pali> <CAK8P3a2tdny8SA7jcqhUZT13iq1mYqjFueC-gnTUZA1JKCtfgg@mail.gmail.com> <20220708171227.74nbcgsk63y4bdna@pali> <CAK8P3a3YMqGEjRr+ZD4Enm4pnuNNZOaeXqpY=PDXAP7w3P7y4A@mail.gmail.com> <d9339bb9-2410-bea5-7502-1c7839707f4e@csgroup.eu> <20220711161442.GD25951@gate.crashing.org> <2552726a-cca4-ecd4-6fca-4f73bbf7942e@csgroup.eu> <20220711214840.GJ25951@gate.crashing.org> <aab87b89-3518-f13e-995a-cbe48892e200@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aab87b89-3518-f13e-995a-cbe48892e200@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 09:22:12AM +0000, Christophe Leroy wrote:
> Le 11/07/2022 à 23:48, Segher Boessenkool a écrit :
> > I believe the eieio instruction is disabled on some e500 models, because
> > it does not work correctly, so EIEIO_EN=1 cannot work, something like
> > that?
> 
> Don't know.
> 
> It is also disabled on 405 and 440.

BookE does not have the eieio insn.  Instead, it reuses the same opcode
for mbar, which has similar but different semantics.

e500 has that EIEIO_EN thing which makes the insn behave like eieio.

> That's new with GCC 12.

Yup.  In the past we used -many, but that just hides problems in the
best case, and causes more problems itself :-(

There are many mnemonics that cause a different instruction to be
emitted on different targets, and that causes a lot of wasted time
trying to find and fix the problems this causes.

If you hit any remaining problems related to this, please let me know!


Segher
