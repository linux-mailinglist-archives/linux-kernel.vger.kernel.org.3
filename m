Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A58E5B299C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 00:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiIHWwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 18:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiIHWwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 18:52:05 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 698BEFCA09
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 15:52:04 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 288Me86X019587;
        Thu, 8 Sep 2022 17:40:08 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 288Me5E7019584;
        Thu, 8 Sep 2022 17:40:05 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 8 Sep 2022 17:40:05 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Mathieu Malaterre <malat@debian.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Mackerras <paulus@samba.org>, llvm@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH] powerpc/lib/xor_vmx: Relax frame size for clang
Message-ID: <20220908224005.GN25951@gate.crashing.org>
References: <20190621085822.1527-1-malat@debian.org> <7cb1285a-42e6-2b67-664f-7d206bc9fd80@csgroup.eu> <87v8pyemmw.fsf@mpe.ellerman.id.au> <8afc110f-641e-40f0-9bf9-b7b2ca3df6a1@www.fastmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8afc110f-641e-40f0-9bf9-b7b2ca3df6a1@www.fastmail.com>
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

On Thu, Sep 08, 2022 at 05:07:24PM +0200, Arnd Bergmann wrote:
> - if the XOR code has its frame size explode like this, it's
>   probably an indication of the compiler doing something wrong,
>   not the kernel code.

On the contrary, it is most likely an indication that the kernel code
wants something unreasonable.  Like, having 20 variables live at the
same time, but still wanting nicely scheduled machine code generated.

But I suspect GCC unrolled the loops here, even?  Best way to prevent
that here is to put an option in the Makefile, for these files.  We
don't want any of this unrolled after all?  Or, alternatively, remove
all the manual unrolling from this code, let GCC do its thing, without
painting it in a corner.

>   The result is likely that the "optimized"
>   XOR implementation is slower than the default version as a
>   result, and the kernel will pick the other one at boot time.

Yes.  So it's self-healing even, of a sort :-)


Segher
