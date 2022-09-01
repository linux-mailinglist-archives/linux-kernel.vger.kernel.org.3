Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325F95A9EBB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 20:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbiIASOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 14:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiIASOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 14:14:07 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB06246DAE
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 11:14:05 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 281I7qru032240;
        Thu, 1 Sep 2022 13:07:52 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 281I7phS032237;
        Thu, 1 Sep 2022 13:07:51 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 1 Sep 2022 13:07:51 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Gabriel Paubert <paubert@iram.es>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2] powerpc: Fix irq_soft_mask_set() and irq_soft_mask_return() with sanitizer
Message-ID: <20220901180751.GH25951@gate.crashing.org>
References: <c0b486e782b6695092dcdb2cd340a3d44c8c266d.1661272738.git.christophe.leroy@csgroup.eu> <CMJ3VICKD1CI.SVFJOKYJPKZQ@bobo> <e022754d-b4d3-bc9f-cc79-2cf556180459@csgroup.eu> <CMJ8P06JA9OY.1S8VDV2XRU3W5@bobo> <7c11b659-5b8e-256c-508e-39395041fccb@csgroup.eu> <20220831224522.GX25951@gate.crashing.org> <ad5ebb37-6b6f-372c-dd07-fc4cfc5f5fe5@csgroup.eu> <YxBhRtTuJ4Ut7wUt@lt-gp.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YxBhRtTuJ4Ut7wUt@lt-gp.iram.es>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 09:37:42AM +0200, Gabriel Paubert wrote:
> On Thu, Sep 01, 2022 at 05:22:32AM +0000, Christophe Leroy wrote:
> > Le 01/09/2022 à 00:45, Segher Boessenkool a écrit :
> > > I would have used real assembler code here (in a .s file).  But there
> > > probably are reasons to do things this way, performance probably?
> > 
> > We changed it to inline asm in order to ... inline it in the caller.
> 
> And there is a single caller it seems. Typically GCC inlines function
> with a single call site, but it may be confused by asm statements.

"Confused"...  It might estimate the assembler statement to be
significantly more expensive than it really is.  The compiler has to be
somewhat conservative, to be able to generate code that can be assembled
without errors.  It counts instructions by counting newlines and semis
and that kind of thing.  Since GCC 7 there is "asm inline", to make the
compiler think for inlining purposes that the asm outputs minimum size
code.  You can use asm_inline in the kernel for this.

> > I also find that those operand names make it awull more difficult to 
> > read that traditional numbering. I really dislike that new trend.

Yup.  All the extra markup it needs doesn't benefit readability either.

> > And same with those // comments, better use meaningfull C variable names.

I wrote:

> > > Comments like "// Inputs" are just harmful.  As is the "creative"
> > > indentation here.  Both harm readability and do not help understanding
> > > in any other way either.

This is a comment trying to explain (GNU) C syntax.  I certainly agree
that variable naming is very important, but this was meant as commentary
on a worse comment offence :-)


Segher
