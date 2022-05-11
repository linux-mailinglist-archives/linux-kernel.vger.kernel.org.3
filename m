Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8020B522ED4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbiEKI5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244051AbiEKI5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:57:47 -0400
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1C96C0F9;
        Wed, 11 May 2022 01:57:43 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 2373B2800167D;
        Wed, 11 May 2022 10:57:41 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 16B0612B669; Wed, 11 May 2022 10:57:41 +0200 (CEST)
Date:   Wed, 11 May 2022 10:57:41 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, maz@kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org,
        Octavian Purdila <octavian.purdila@nxp.com>,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        catalin.marinas@arm.com, deanbo422@gmail.com, green.hu@gmail.com,
        guoren@kernel.org, jonas@southpole.se, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        nickhu@andestech.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        tsbogend@alpha.franken.de, vgupta@kernel.org,
        vladimir.murzin@arm.com, will@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 17/17] irq: remove handle_domain_{irq,nmi}()
Message-ID: <20220511085741.GA6558@wunner.de>
References: <20211026092504.27071-1-mark.rutland@arm.com>
 <20211026092504.27071-18-mark.rutland@arm.com>
 <20220506203242.GA1855@wunner.de>
 <YnjWvbzn8ox+f2Y2@FVFF77S0Q05N>
 <20220510121320.GA3020@wunner.de>
 <Ynpzb5L53iGex14D@FVFF77S0Q05N>
 <87a6bpov9u.ffs@tglx>
 <YntynKK5Jjw2Q1rX@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YntynKK5Jjw2Q1rX@FVFF77S0Q05N>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 09:23:56AM +0100, Mark Rutland wrote:
> On Wed, May 11, 2022 at 12:52:29AM +0200, Thomas Gleixner wrote:
> > +	/* USB interrupts are received in softirq (tasklet) context.
> > +	 * Switch to hardirq context to make genirq code happy.
> > +	 */
> > +	local_irq_save(flags);
> > +	__irq_enter_raw();
> > +
> >  	if (intdata & INT_ENP_PHY_INT_)
> > -		;
> > +		generic_handle_domain_irq(pdata->irqdomain, PHY_HWIRQ);
> 
> Agreed. IIUC everyone agrees the __irq_enter_raw() usage is a hack,
> but what's not clear is what we *should* do
> 
> I suspect that given we have generic_handle_irq_safe() for situations
> like this we should add a generic_handle_domain_irq_safe(), and use
> that in this driver?
> That way we can keep the `WARN_ON_ONCE(!in_hardirq())` in
> generic_handle_domain_irq().

Thomas applied 792ea6a074ae ("genirq: Remove WARN_ON_ONCE() in
generic_handle_domain_irq()") tonight:

http://git.kernel.org/tip/tip/c/792ea6a074ae

That allows me to drop the controversial __irq_enter_raw()
and thus unblock my smsc95xx series.

generic_handle_domain_irq_safe() would merely be a wrapper for
generic_handle_domain_irq() which disables local interrupts.
Then I wouldn't have to do that in smsc95xx.c.  IMHO that's a
cosmetic improvement, though I'll be happy to provide a patch
if desired?

Thanks,

Lukas
