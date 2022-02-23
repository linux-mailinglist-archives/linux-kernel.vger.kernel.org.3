Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1400E4C1FC0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 00:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244813AbiBWXfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 18:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244692AbiBWXf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 18:35:28 -0500
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C20B59A6A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 15:34:59 -0800 (PST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 21NNReM1024539;
        Wed, 23 Feb 2022 17:27:40 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 21NNRd3Z024538;
        Wed, 23 Feb 2022 17:27:39 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 23 Feb 2022 17:27:39 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Gabriel Paubert <paubert@iram.es>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/32: Clear volatile regs on syscall exit
Message-ID: <20220223232739.GJ614@gate.crashing.org>
References: <28b040bd2357a1879df0ca1b74094323f778a472.1645636285.git.christophe.leroy@csgroup.eu> <YhadiVbwao/p2N7o@lt-gp.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhadiVbwao/p2N7o@lt-gp.iram.es>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 09:48:09PM +0100, Gabriel Paubert wrote:
> On Wed, Feb 23, 2022 at 06:11:36PM +0100, Christophe Leroy wrote:
> > +	/* Zero volatile regs that may contain sensitive kernel data */
> > +	li	r0,0
> > +	li	r4,0
> > +	li	r5,0
> > +	li	r6,0
> > +	li	r7,0
> > +	li	r8,0
> > +	li	r9,0
> > +	li	r10,0
> > +	li	r11,0
> > +	li	r12,0
> > +	mtctr	r0
> > +	mtxer	r0
> 
> Here, I'm almost sure that on some processors, it would be better to
> separate mtctr form mtxer. mtxer is typically very expensive (pipeline
> flush) but I don't know what's the best ordering for the average core.

mtxer is cheaper than mtctr on many cores :-)

On p9 mtxer is cracked into two latency 3 ops (which run in parallel).
While mtctr has latency 5.

On p8 mtxer was horrible indeed (but nothing near as bad as a pipeline
flush).


Segher
