Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62E8574C22
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238524AbiGNLcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiGNLcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:32:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B1F9206
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:31:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9561013D5;
        Thu, 14 Jul 2022 04:31:59 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.85.183])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33CBC3F792;
        Thu, 14 Jul 2022 04:31:58 -0700 (PDT)
Date:   Thu, 14 Jul 2022 12:31:54 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kees Cook <keescook@chromium.org>, peterz@infradead.org
Subject: Re: [PATCH] lkdtm: cfi: add test for HW landing pad CFI
Message-ID: <Ys/+qghGmH4kK4DN@FVFF77S0Q05N>
References: <20220713151815.295520-1-mark.rutland@arm.com>
 <Ys7vRTThFVNz7moO@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys7vRTThFVNz7moO@sirena.org.uk>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 05:13:57PM +0100, Mark Brown wrote:
> On Wed, Jul 13, 2022 at 04:18:15PM +0100, Mark Rutland wrote:
> > Some architectures have coarse-grained HW CFI schemes where indirect
> > branches must target a "landing pad" instruction (e.g. BTI on arm64,
> > ENDBR on x86). These prevent gadgetization of arbitrary portions of
> > functions.
> 
> > Add a test which checks these work as expected.
> 
> > For example, on arm64 HW with BTI this should result in a BTI exception
> > being taken:
> 
> > +/*
> > + * This tries to call an indirect function with an address which is not a
> > + * function entry point. This should be caught by architectures with "landing
> > + * pad" instructions (e.g. BTI on arm64, or ENDBR on x86).
> > + */
> > +static void lkdtm_CFI_FORWARD_LANDING_PAD(void)
> > +{
> > +	void (*func)(int *);
> > +
> > +	func = (void *)((unsigned long)lkdtm_increment_void + 4);
> > +
> > +	pr_info("Calling gadget address ...\n");
> > +	func(&called_count);
> > +
> > +	pr_err("FAIL: survived gadget function call!\n");
> > +}
> 
> Incrementing the address by 4 here is the right number for arm64 and it
> looks like it's also right for the x86_64 ENDBR64 instruction but are we
> guaranteed that it'll do the right thing for other architectures,
> especially those with variable length instructions - couldn't we just
> get an illegal instruction exception due to ending up pointing at
> something that isn't the start of an instruction even if CFI isn't
> active?
> 
> Not sure that worrying about that at this point isn't making perfect the
> enemy of good though, it could be dealt with later.  Perhaps just put
> the offset behind a #define to make it a tiny bit more discoverable?

How about I just add a comment for now? e.g.

	/*
	 * Skip past a landing pad instruction.
	 * On arm64 all instructions are 4-byte aligned, and x86's ENDBR is 4
	 * bytes.
	 */

Thanks,
Mark.
