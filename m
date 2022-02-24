Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A194C265A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 09:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbiBXIb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 03:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbiBXIbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 03:31:44 -0500
Received: from mx01.puc.rediris.es (outbound5mad.lav.puc.rediris.es [130.206.19.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA35627AA2E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 00:30:36 -0800 (PST)
Received: from mta-out01.sim.rediris.es (mta-out01.sim.rediris.es [130.206.24.43])
        by mx01.puc.rediris.es  with ESMTP id 21O8U0DJ022857-21O8U0DL022857
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 24 Feb 2022 09:30:00 +0100
Received: from mta-out01.sim.rediris.es (localhost.localdomain [127.0.0.1])
        by mta-out01.sim.rediris.es (Postfix) with ESMTPS id 88B8B300B952;
        Thu, 24 Feb 2022 09:30:00 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mta-out01.sim.rediris.es (Postfix) with ESMTP id 78135300C3A2;
        Thu, 24 Feb 2022 09:30:00 +0100 (CET)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta-out01.sim.rediris.es
Received: from mta-out01.sim.rediris.es ([127.0.0.1])
        by localhost (mta-out01.sim.rediris.es [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ga1OKfOOAvLI; Thu, 24 Feb 2022 09:30:00 +0100 (CET)
Received: from lt-gp.iram.es (haproxy02.sim.rediris.es [130.206.24.70])
        by mta-out01.sim.rediris.es (Postfix) with ESMTPA id F1025300B952;
        Thu, 24 Feb 2022 09:29:59 +0100 (CET)
Date:   Thu, 24 Feb 2022 09:29:55 +0100
From:   Gabriel Paubert <paubert@iram.es>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/32: Clear volatile regs on syscall exit
Message-ID: <YhdCAwQ+VfLTslnV@lt-gp.iram.es>
References: <28b040bd2357a1879df0ca1b74094323f778a472.1645636285.git.christophe.leroy@csgroup.eu>
 <YhadiVbwao/p2N7o@lt-gp.iram.es>
 <20220223232739.GJ614@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223232739.GJ614@gate.crashing.org>
X-FE-Policy-ID: 23:8:0:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=iram.es; s=DKIM; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=qlaKR81TB9uC2qecK8Ka2Y5+wlvJqCdWDbHzUcfcJ7U=;
 b=ndlmi1AQs/O8De46rNXAR9JR8GwX4uyB1QBUMFmXWqdacLOh079Mhp/eegPEMKZg954bG9hOoScg
        VcOb27Mdh41JaedY6PFZMnh+E1lVA4+WkxH+Y7v03pjbdBzUSZdbqKzySXGqABGHYW4pHelBvRwp
        UlnhV7SXcomMZRou0yHIYHvFYpYhcWiE1aJaPVVegXfMoqKfbaoLTKTWM3Zu+8lDIkHXdmmoUe2i
        PcC88D9V6X0cikzfXu1DrmE7L5xzrQbi9ilyuINsxvUnFY/725tpUxQgxDFi5mcI5M3Mr1GAyaDn
        Jh9zAHux/U9FUMGQC8wtxpNNZ0Ab8qT0e82V0w==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 05:27:39PM -0600, Segher Boessenkool wrote:
> On Wed, Feb 23, 2022 at 09:48:09PM +0100, Gabriel Paubert wrote:
> > On Wed, Feb 23, 2022 at 06:11:36PM +0100, Christophe Leroy wrote:
> > > +	/* Zero volatile regs that may contain sensitive kernel data */
> > > +	li	r0,0
> > > +	li	r4,0
> > > +	li	r5,0
> > > +	li	r6,0
> > > +	li	r7,0
> > > +	li	r8,0
> > > +	li	r9,0
> > > +	li	r10,0
> > > +	li	r11,0
> > > +	li	r12,0
> > > +	mtctr	r0
> > > +	mtxer	r0
> > 
> > Here, I'm almost sure that on some processors, it would be better to
> > separate mtctr form mtxer. mtxer is typically very expensive (pipeline
> > flush) but I don't know what's the best ordering for the average core.
> 
> mtxer is cheaper than mtctr on many cores :-)

We're speaking of 32 bit here I believe; on my (admittedly old) paper
copy of PowerPC 604 user's manual, I read in a footnote:

"The mtspr (XER) instruction causes instructions to be flushed when it
executes." 

Also a paragraph about "PostDispatch Serialization Mode" which reads:
"All instructions following the postdispatch serialization instruction
are flushed, refetched, and reexecuted."

Then it goes on to list the affected instructions which starts with:
mtsper(xer), mcrxr, isync, ...

I know there are probably very few 604 left in the field, but in this
case mtspr(xer) looks very much like a superset of isync.

I also just had a look at the documentation of a more widespread core:

https://www.nxp.com/docs/en/reference-manual/MPC7450UM.pdf

and mtspr(xer) is marked as execution and refetch serialized, actually
it is the only instruction to have both.

Maybe there is a subtle difference between "refetch serialization" and
"pipeline flush", but in this case please educate me.

Besides that the back to back mtctr/mtspr(xer) may limit instruction
decoding and issuing bandwidth.  I'd rather move one of them up by a few
lines since they can only go to one of the execution units on some
(or even most?) cores. This was my main point initially.

	Gabriel

> 
> On p9 mtxer is cracked into two latency 3 ops (which run in parallel).
> While mtctr has latency 5.
> 
> On p8 mtxer was horrible indeed (but nothing near as bad as a pipeline
> flush).
> 
> 
> Segher
 

