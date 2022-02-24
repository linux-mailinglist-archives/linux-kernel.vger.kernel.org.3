Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37A14C2C40
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 13:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbiBXM5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 07:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiBXM5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 07:57:06 -0500
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 112F163F1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 04:56:32 -0800 (PST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 21OCnCdn002437;
        Thu, 24 Feb 2022 06:49:12 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 21OCnBsZ002436;
        Thu, 24 Feb 2022 06:49:11 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 24 Feb 2022 06:49:11 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Gabriel Paubert <paubert@iram.es>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/32: Clear volatile regs on syscall exit
Message-ID: <20220224124911.GL614@gate.crashing.org>
References: <28b040bd2357a1879df0ca1b74094323f778a472.1645636285.git.christophe.leroy@csgroup.eu> <YhadiVbwao/p2N7o@lt-gp.iram.es> <20220223232739.GJ614@gate.crashing.org> <YhdCAwQ+VfLTslnV@lt-gp.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhdCAwQ+VfLTslnV@lt-gp.iram.es>
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

On Thu, Feb 24, 2022 at 09:29:55AM +0100, Gabriel Paubert wrote:
> On Wed, Feb 23, 2022 at 05:27:39PM -0600, Segher Boessenkool wrote:
> > On Wed, Feb 23, 2022 at 09:48:09PM +0100, Gabriel Paubert wrote:
> > > On Wed, Feb 23, 2022 at 06:11:36PM +0100, Christophe Leroy wrote:
> > > > +	/* Zero volatile regs that may contain sensitive kernel data */
> > > > +	li	r0,0
> > > > +	li	r4,0
> > > > +	li	r5,0
> > > > +	li	r6,0
> > > > +	li	r7,0
> > > > +	li	r8,0
> > > > +	li	r9,0
> > > > +	li	r10,0
> > > > +	li	r11,0
> > > > +	li	r12,0
> > > > +	mtctr	r0
> > > > +	mtxer	r0
> > > 
> > > Here, I'm almost sure that on some processors, it would be better to
> > > separate mtctr form mtxer. mtxer is typically very expensive (pipeline
> > > flush) but I don't know what's the best ordering for the average core.
> > 
> > mtxer is cheaper than mtctr on many cores :-)
> 
> We're speaking of 32 bit here I believe;

32-bit userland, yes.  Which runs fine on non-ancient cores, too.

> on my (admittedly old) paper
> copy of PowerPC 604 user's manual, I read in a footnote:
> 
> "The mtspr (XER) instruction causes instructions to be flushed when it
> executes." 

And the 604 has a trivial depth pipeline anyway.

> I know there are probably very few 604 left in the field, but in this
> case mtspr(xer) looks very much like a superset of isync.

It hasn't been like that for decades.  On the 750 mtxer was execution
synchronised only already, for example.

> I also just had a look at the documentation of a more widespread core:
> 
> https://www.nxp.com/docs/en/reference-manual/MPC7450UM.pdf
> 
> and mtspr(xer) is marked as execution and refetch serialized, actually
> it is the only instruction to have both.

This looks like a late addition (it messes up the table, for example,
being put after "mtspr (other)").  It also is different from 7400 and
750 and everything else.  A late bugfix?  Curious :-)

> Maybe there is a subtle difference between "refetch serialization" and
> "pipeline flush", but in this case please educate me.

There is a subtle difference, but it goes the other way: refetch
serialisation doesn't stop fetch / flush everything after it, only when
the instruction completes it rejects everything after it.  So it can
waste a bit more :-)

> Besides that the back to back mtctr/mtspr(xer) may limit instruction
> decoding and issuing bandwidth.

It doesn't limit decode or dispatch (not issue fwiw) bandwidth on any
core I have ever heard of.

> I'd rather move one of them up by a few
> lines since they can only go to one of the execution units on some
> (or even most?) cores. This was my main point initially.

I think it is much more beneficial to *not* do these insns than to
shift them back and forth a cycle.


Segher
