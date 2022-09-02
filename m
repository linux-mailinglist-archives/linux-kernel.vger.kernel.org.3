Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC59F5AB3E2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237022AbiIBOnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236995AbiIBOnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:43:09 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7B77159A7C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 07:04:14 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 282CeGbE005773;
        Fri, 2 Sep 2022 07:40:16 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 282CeEKR005772;
        Fri, 2 Sep 2022 07:40:14 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 2 Sep 2022 07:40:14 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Tom Rix <trix@redhat.com>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc/math_emu/efp: Include module.h
Message-ID: <20220902124014.GM25951@gate.crashing.org>
References: <20220831152014.3501664-1-nathan@kernel.org> <efd56f3e-bc8c-5da5-559d-e0bc6b21fa5b@csgroup.eu> <20220901194705.GI25951@gate.crashing.org> <ae2ee2d8-ec0a-d0ab-2c5a-b9a8c7579093@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae2ee2d8-ec0a-d0ab-2c5a-b9a8c7579093@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 08:43:49AM +0000, Christophe Leroy wrote:
> Le 01/09/2022 à 21:47, Segher Boessenkool a écrit :
> > On Thu, Sep 01, 2022 at 05:41:33AM +0000, Christophe Leroy wrote:
> >> I think it would be worth a GCC bug report.
> > 
> > We need a stand-alone testcase for this.  When you have created one, at
> > least 98% of the time you discover the bug is in user code after all.
> > 
> > Which is a very good thing, it means the problem can be fixed simpler,
> > cheaper, and a lot faster :-)
> 
> Easy to reproduce with a .c file that has a single line:
> 
> non_existing_macro(xxx);

That was fast (and cheap and simple) :-)

> Apparently that's due to the -w option in arch/powerpc/math_emu/Makefile:
> 
> 	ccflags-y = -w
> 
> Was introduced by commit d2b194ed8208 ("powerpc/math-emu: Use kernel 
> generic math-emu code")
> 
> If I understand correctly it means 'ignore all warnings'. Then it seems 
> CLANG doesn't honor that request.

'-w'
     Inhibit all warning messages.

GCC's initial commit has this already (1992).


Segher
