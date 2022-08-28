Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541C55A3C92
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 09:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbiH1H4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 03:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiH1H4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 03:56:35 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9B45004B
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 00:56:34 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id jm11so5227294plb.13
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 00:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc;
        bh=Fscr3yDSTCrKpIskBWHyMmfx02XwJ+/i8/DKwPjr0pQ=;
        b=jgVBttfNU+gJKDgqPH/QKWnNkal+DUl+bpC5ZDYKtWcwLYQH30QA/8iA7ZSwTcYyge
         /+mvXj40GPeziZdC09A3RAqsrOz0a2AicEXzX+YWFLMyYeUE4OB/nc/bQwvJTMkCb075
         eyIpoJ5XXDGE8EQ+pBVv1o0qwxPvQb29R5GF+h8WCPrqroyyNzrpWNwpaGObC7QvEOaF
         yBzlXRNF5AGupiiw8E9/tz8jZXDGaD35pAJr92rv8v4VPmSU6J90AXfqR2APZ2crO1rt
         +lryYVOkvZfCJexXbjm8TwpYK6hKvtW/TWW7gQgkRTQ2+GWvfe2r+IYDpzbB6oJ4bcDJ
         w8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Fscr3yDSTCrKpIskBWHyMmfx02XwJ+/i8/DKwPjr0pQ=;
        b=vG0MV5wRKrEwvKNpCD/i/cBAal0yqXVwy4lBv3S1zgZjxwEeX7MmRoz2+nc23RP2ho
         W7J7VEXIDjK75LgxUQpaPeXJsXzv/+LeWB0hsYnnQmZYV2NmpFYY2WAzfJSeORWk2fce
         +U1UXZITamXPWlh/9tWtfXqLZSsGkdw7Cu9Ff2BBBllJbMWyIea4jvOqp6sXdu32tLqr
         IxHiO9c88yEgfVI1voPwvdcE2qx7qE2pCuA2BUlxtqOT5ajmHTXOA6A5uC8XeZ/xBIXc
         gupf2hEvmxd6z8sCoCjjwkVSID2kDmOdlOacQEHYtwGeYabGcv1lzCMhuqWpPazl/I2T
         14uQ==
X-Gm-Message-State: ACgBeo2XBXUekwrsEKnCKwEL5KIlkfkho85rycVMpjTwb0DYhcYmqzWU
        oIqFItxJd1nT3cXU5ND+rPM=
X-Google-Smtp-Source: AA6agR5WesEDb7pdMqeOP5Cgg+NIjlW6cGCjszEbRIQ4qtICkx8ew1TNMknKFdT+/kjr70QEN7rWYw==
X-Received: by 2002:a17:90a:d484:b0:1fd:7c5b:8fdb with SMTP id s4-20020a17090ad48400b001fd7c5b8fdbmr8543431pju.151.1661673394012;
        Sun, 28 Aug 2022 00:56:34 -0700 (PDT)
Received: from lu-N56VJ ([113.88.93.173])
        by smtp.gmail.com with ESMTPSA id q37-20020a635c25000000b00421841943dfsm4124307pgb.12.2022.08.28.00.56.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Aug 2022 00:56:33 -0700 (PDT)
Date:   Sun, 28 Aug 2022 15:56:23 +0800
From:   Puyou Lu <puyou.lu@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Robert Richter <rrichter@cavium.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip/gic-v3: do runtime cpu cap check only when
 necessary
Message-ID: <20220828075610.GA30202@lu-N56VJ>
References: <20220827051328.GA18042@lu-N56VJ>
 <87wnatra83.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wnatra83.wl-maz@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2022 at 04:13:00PM +0100, Marc Zyngier wrote:
> On Sat, 27 Aug 2022 06:19:27 +0100,
> Puyou Lu <puyou.lu@gmail.com> wrote:
> > 
> > Now cpu cap check is done every exception happens on every arm64 platform,
> > but this check is necessary on just few of then, so we can drop this
> > check at compile time on others. This can decrease exception handle time
> > on most cases.
> > 
> > Fixes: 6d4e11c5e2e8 ("irqchip/gicv3: Workaround for Cavium ThunderX erratum 23154")
> > Signed-off-by: Puyou Lu <puyou.lu@gmail.com>
> > ---
> >  drivers/irqchip/irq-gic-v3.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> > index 262658fd5f9e..3f08c2ef1251 100644
> > --- a/drivers/irqchip/irq-gic-v3.c
> > +++ b/drivers/irqchip/irq-gic-v3.c
> > @@ -237,9 +237,11 @@ static void gic_redist_wait_for_rwp(void)
> >  
> >  static u64 __maybe_unused gic_read_iar(void)
> >  {
> > +#ifdef CONFIG_CAVIUM_ERRATUM_23154
> >  	if (cpus_have_const_cap(ARM64_WORKAROUND_CAVIUM_23154))
> >  		return gic_read_iar_cavium_thunderx();
> >  	else
> > +#endif
> >  		return gic_read_iar_common();
> >  }
> >  #endif
> 
> You realise that cpus_have_const_cap() results purely in a couple of
> branches once the caps have been finalised, right?
> 
> Please provide data showing that it actually "can decrease exception
> handle time on most cases", because I'm pretty sure you cannot measure
> the difference in any meaningful way.
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

Hi Marc,
Thank you for the reply. Actually I did no test, just from the disassemble
code of vmlinux, I saw about 6 instruction generated by
cpus_have_const_cap, and about 36 by gic_read_iar_cavium_thunderx, which
is useless for most CPUs. I think this will waste some cpu cycles, as
exceptions can occur hunderds or thousands times per second. Also
(6+36)*4=168 bytes of icache is wasted, and icache misses increase
somewhere else.
If I got things wrong, please correct me.
