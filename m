Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B1A527C96
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 05:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239842AbiEPD6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 23:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239828AbiEPD6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 23:58:11 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C3C101C1
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 20:58:01 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id nr2-20020a17090b240200b001df2b1bfc40so3129130pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 20:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=81zc4fqkgQwb8WIkORpKBhGcFxG3h9Urzvpiad4QCFg=;
        b=W6LddtNMiFSSJofxVZqIRxwE5VyeMZWnHVjwe/OIn02+PgdfTm416Y8Dx4dggHgh8C
         vgxt05kJFFWI49QuDa0Ojn/hduH2hjoCCNseMdbramTtwjtRN9YV/nk56X73D/+EaDRn
         pF0gSzmsQjXrQkdh5VmYmtOx0vxBcXXcqjM5nb4j9ujhDAesgNZ2exU46cuSX51nIcR0
         xxiXWnf3rzO8qRH2YGtOq5Z8pAyiBfS1sK2hrrfSLY5t1KG6lG3IQGgA1Wl9+NpksLw2
         VSas7r8Ic3zL97BH+rrvYF5JtMSn4SxcL3P5R4kURmlqT5s9Fwpw174MHKrfrslRXq2O
         QeJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=81zc4fqkgQwb8WIkORpKBhGcFxG3h9Urzvpiad4QCFg=;
        b=eznsjYUJx1VXfyGdZqEwmsHtJ5TC1IRR5S8djCDKowfTmhQy8HpWe8FAFPtIwlbRdE
         cGjFAlugsxFMBUW4K+efUNA0htegpB4EgDohtu3SSSaiwo8YucHXbb5P3en6NZOwTtz+
         mGKbQV30biXAai9YfLP9yUqu8mXzEzZKyrVCk7Zmvc+BRuZMaua+OFs8Qna52Obfn7xe
         rywIWxWtSXa94STtQYeVXCMFAXMwm4XQiQZN7PwGwFXMBSGS/1dFSyJlVP/EzEVYeRbm
         JHbmSANNNEC1B31sAiBOC60rsW9fLyCLtDESRg/mEJJtFyv99dYN3xdxYkeyhwdNPVxo
         /npw==
X-Gm-Message-State: AOAM532a4IiI4YbHyU8DfdBVx0HHUt7HgN/8Zyed3ls8Bbw/4AaZgWcu
        dXfYZ4cLf3jGqGl0tdQndh9nYQ==
X-Google-Smtp-Source: ABdhPJyg3KrEF088VNTx7elv0wOUTwpEq+w+oeu0yE6kH1FAK/ti7Jhg6b6REiH/sYNyYQAnq5j8vA==
X-Received: by 2002:a17:902:9684:b0:161:5b2b:6ea2 with SMTP id n4-20020a170902968400b001615b2b6ea2mr7540565plp.71.1652673480745;
        Sun, 15 May 2022 20:58:00 -0700 (PDT)
Received: from x1 ([2601:1c2:1001:7090:362:347a:2a38:5df4])
        by smtp.gmail.com with ESMTPSA id h35-20020a632123000000b003c14af50627sm5511128pgh.63.2022.05.15.20.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 20:58:00 -0700 (PDT)
Date:   Sun, 15 May 2022 20:58:55 -0700
From:   Drew Fustini <dfustini@baylibre.com>
To:     Marc Zyngier <maz@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: dmtimer: ack pending interrupt during suspend on am335x/am437x?
Message-ID: <YoHL/+qYs47LsnCB@x1>
References: <YniiqM0S+hwsGFni@x1>
 <YnoK+XQiargRGUy/@atomide.com>
 <4de411aa2fc8a6f185afb8bfd5da63d4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4de411aa2fc8a6f185afb8bfd5da63d4@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 09:19:51AM +0100, Marc Zyngier wrote:
> On 2022-05-10 07:49, Tony Lindgren wrote:
> > * Drew Fustini <dfustini@baylibre.com> [220509 05:07]:
> > > Hello Daniel, Tony suggested I mail you along with the list to get
> > > feedback. I'm attempting to upstream these two patches [1][2] from
> > > ti-linux-5.4.y for arch/arm/mach-omap2/timer.c:
> > > 96f4c6e2ba8a ("ARM: OMAP2+: timer: Ack pending interrupt during
> > > suspend")
> > > 7ae7dd5f8272 ("ARM: OMAP2+: timer: Extend pending interrupt ACK for
> > > gic")
> > > 
> > > On the TI AM335x and AM437x SoCs, it is possible for a late
> > > interrupt to
> > > be generated which will cause a suspend failure. The first patch makes
> > > omap_clkevt_idle() ack the irq both in the timer peripheral register
> > > and in the interrupt controller to avoid the issue.
> > > 
> > > On AM437x only, the GIC cannot be directly acked using only the
> > > irqchip
> > > calls. To workaround that, the second patch maps the GIC_CPU_BASE and
> > > reads the GIC_CPU_INTACK register before calling irq_eoi to properly
> > > ack
> > > the late timer interrupts that show up during suspend.
> > > 
> > > However, Tony removed most of arch/arm/mach-omap2/timer.c with:
> > > 2ee04b88547a ("ARM: OMAP2+: Drop old timer code for dmtimer and 32k
> > > counter")
> > > 
> > > The timers are now implemented in drivers/clocksource/timer-ti-dm.c
> > > and
> > > drivers/clocksource/timer-ti-dm-systimer.c. The function
> > > dmtimer_clocksource_suspend() disables the dmtimer and clock but does
> > > not ack any interrupts.
> > > 
> > > Tony suggested the right place to ack the interrupt during suspend is
> > > in CPU_CLUSTER_PM_ENTER inside omap_timer_context_notifier().
> > > 
> > > Do you think that would be an acceptable approach?
> > 
> > Based on what we chatted on irc yesterday, I'd suggest try resetting the
> > clockevent on suspend first for am3/4 at omap_clockevent_idle() and see
> > if
> > that takes care of the issue. If it's the timer hardware blocking the
> > deeper idle states, this should work, and GIC will lose it's context
> > on system suspend anyways.
> 
> Maybe, but the core tracking code will still know it is in the
> middle of an interrupt. I´d expect things like lockdep to shout
> at you...
> 
>         M.

Tony and Marc - thank you for your insights.

I have learned from Dave Gerlach that the occurance of suspend failures
on the downstream TI 5.4 kernel was only 1 in 10,000 prior to his
downstream patches.

I have now done 33,175 cycles of suspend/resume with rtcwake and no
failures have occurred. Thus, I have to conclude that mainline does not
exhibit the problem of late timer interrupts causing suspend to fail.

Thanks,
Drew

