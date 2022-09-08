Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A605B2002
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbiIHOCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbiIHOBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:01:46 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C750910C980
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 07:01:38 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 288Dm1Ft015930;
        Thu, 8 Sep 2022 08:48:01 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 288Dm0t8015929;
        Thu, 8 Sep 2022 08:48:00 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 8 Sep 2022 08:48:00 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Mathieu Malaterre <malat@debian.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Joel Stanley <joel@jms.id.au>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc/lib/xor_vmx: Relax frame size for clang
Message-ID: <20220908134800.GM25951@gate.crashing.org>
References: <20190621085822.1527-1-malat@debian.org> <7cb1285a-42e6-2b67-664f-7d206bc9fd80@csgroup.eu> <87v8pyemmw.fsf@mpe.ellerman.id.au> <9a5bd7c2-13ee-2517-48f6-e61a6dc9c076@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a5bd7c2-13ee-2517-48f6-e61a6dc9c076@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 06:00:24AM +0000, Christophe Leroy wrote:
> Looking at it more deeply, I see strange things.

I'll have to see full generated machine code to be able to see strange
things, there isn't enough information at all here yet.  Sorry.

Use private mail if it is too big or uninteresting for the list :-)

> What is that frame size ? I thought it was the number of bytes r1 is 
> decremented at the begining of the function, but it seems not, at least 
> on GCC. It seems GCC substrats 112 bytes while clang doesn't.

That is the vars size + the fixed size + the size of the parameter
save area + the size of the regs save area, rounded up to a multiple
of 16.  Fixed size is 8 on 32-bit PowerPC ELF.  Frame size used by GCC
here is just the vars size.

> So it seems that GCC and CLANG don't warn on the same thing, is that 
> expected ? GCC substrats 112 bytes, which is the minimum frame size on a 
> ppc64, but here I'm building a ppc32 kernel, min frame size is 16.

I need to see the generated code to make sense of what is happening
here.  It sounds like it is doing varargs calls or similar expensive
stack juggling.  Or just saving a boatload of registers on the stack.

> And CLANG is still using stack a lot more than GCC.

Good to hear!  Well, good for GCC, anyway ;-)


Segher
