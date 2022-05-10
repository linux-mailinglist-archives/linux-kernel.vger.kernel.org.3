Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BC3522742
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 00:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237118AbiEJWwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 18:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiEJWwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 18:52:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DD320E092;
        Tue, 10 May 2022 15:52:33 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652223150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+CPl63MxUB8As/sCAVAdki8lgIaTJAnVQkLOzHxlZHU=;
        b=OtTG3bimjU3ypaFSXKGYA2Rd4mOJHtF1421UA6JbS4AsEqb1jZKIxBcUzKQ9VFhEczScnm
        gj01eBFp2osh4xiljdeLAxprI0dft7DEIcormLtGT715kDvUV/oqBZB4qBLhnv0mH7N+w+
        zAUA+EIx5GNvx+kEt9exhrmZ2h+DdVG2oAdeB/dW6c1Nr9DfgNFlRENXTzIAGcZh509MQy
        d8fg7MWh6X9md1k4EY2p+jQadHb8+45HZPDxMgk/bGM/+OaRXnPI27lMWdSgD6SSd9CiJH
        wmBUtEq/WgrOSnLyCBrW0iNedraF+PpPntPI1Flxp1WAYX/cThzINIoBjUi+xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652223150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+CPl63MxUB8As/sCAVAdki8lgIaTJAnVQkLOzHxlZHU=;
        b=POXfdVFu8B2YYSKQXyeP2b43jsvPdfGgoeJRZpIsWXdysOTazFYDC6HuksbnhKvRW0SWFV
        RAkUhVtsovE38PCg==
To:     Mark Rutland <mark.rutland@arm.com>, Lukas Wunner <lukas@wunner.de>
Cc:     maz@kernel.org, Linus Walleij <linus.walleij@linaro.org>,
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
In-Reply-To: <Ynpzb5L53iGex14D@FVFF77S0Q05N>
References: <20211026092504.27071-1-mark.rutland@arm.com>
 <20211026092504.27071-18-mark.rutland@arm.com>
 <20220506203242.GA1855@wunner.de> <YnjWvbzn8ox+f2Y2@FVFF77S0Q05N>
 <20220510121320.GA3020@wunner.de> <Ynpzb5L53iGex14D@FVFF77S0Q05N>
Date:   Wed, 11 May 2022 00:52:29 +0200
Message-ID: <87a6bpov9u.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10 2022 at 15:15, Mark Rutland wrote:
> On Tue, May 10, 2022 at 02:13:20PM +0200, Lukas Wunner wrote:
>> For gpio-dln2.c, I believe it from inspection.
>> 
>> For smsc95xx.c, I'm actually seeing it go wrong in practice,
>> unedited dmesg splat is included below FWIW.
>
> Thanks; having the trace makes this much easier to analyse.

which confirmes what I talked about before:

>> WARNING: CPU: 3 PID: 75 at kernel/irq/irqdesc.c:702 generic_handle_domain_irq+0x88/0x94
>>  generic_handle_domain_irq from smsc95xx_status+0x54/0xb0
>>  smsc95xx_status from intr_complete+0x80/0x84
>>  intr_complete from __usb_hcd_giveback_urb+0xa4/0x12c
>>  __usb_hcd_giveback_urb from usb_hcd_giveback_urb+0x118/0x11c
>>  usb_hcd_giveback_urb from completion_tasklet_func+0x7c/0xc8
>>  completion_tasklet_func from tasklet_callback+0x20/0x24
>>  tasklet_callback from tasklet_action_common.constprop.0+0x148/0x220
>>  tasklet_action_common.constprop.0 from tasklet_hi_action+0x28/0x30
>>  tasklet_hi_action from __do_softirq+0x154/0x3e8
>>  __do_softirq from __local_bh_enable_ip+0x12c/0x1a8
>>  __local_bh_enable_ip from irq_forced_thread_fn+0x7c/0xac
>>  irq_forced_thread_fn from irq_thread+0x16c/0x228
>>  irq_thread from kthread+0x100/0x140

So what happens here:

 interrupt
    -> wakeup threaded handler

 threaded handler runs
    local_bh_disable();
    ....
    schedules tasklet
    ...
    local_bh_enable()
      do_softirq()
        run_tasklet()
          urb_completion()
            smsc95xx_status()
              generic_handle_domain_irq()

That interrupt in question is an interrupt, which is not handled by the
primary CPU interrupt chips. It's a synthetic interrupt which is
generated from the received USB packet.

+	/* USB interrupts are received in softirq (tasklet) context.
+	 * Switch to hardirq context to make genirq code happy.
+	 */
+	local_irq_save(flags);
+	__irq_enter_raw();
+
 	if (intdata & INT_ENP_PHY_INT_)
-		;
+		generic_handle_domain_irq(pdata->irqdomain, PHY_HWIRQ);

This __irq_enter_raw() is really wrong. This is _not_ running in hard
interrupt context. Pretending so creates more problems than it
solves. It breaks context tracking, confuses lockdep ...

We also have demultiplexed interrupts which are nested in a threaded
interrupt handler and share the thread context. No, we are not going to
pretend that they run in hard interrupt context either.

So we need a clear distinction between interrupts which really happen in
hard interrupt context and those which are synthetic and can be invoked
from pretty much any context.

Anything else is just a recipe for disaster and endless supply of half
baken hacks.

Thanks,

        tglx
