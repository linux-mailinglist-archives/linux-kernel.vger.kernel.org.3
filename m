Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE3F5603B2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 17:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbiF2PA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 11:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbiF2PA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:00:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C833D1EAC5;
        Wed, 29 Jun 2022 08:00:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A4BFB824F6;
        Wed, 29 Jun 2022 15:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDF3C34114;
        Wed, 29 Jun 2022 15:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656514825;
        bh=C99oNYplt1WvYeLmndjR6iicXGPvkgfMnkOoPBfW4/I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nGmcLvwbijS2KPQumHseuOPhSqO1YMl1BcDwtmKkgJSaPZcQKn32Gn2Cjtvt/Zvjq
         qNbZXxCeptg8Hlwi9wGYTD5tOJuKS7o/YgdFx9WRS74YEFdvfz31x+bpWw10Q//OEW
         I42QcXHM5mvQPh4rIqVgDZqBKJEf4vDCcUpKCv7d88JZZnnNDEMJlFzloe9QG/iikx
         hRQZkOwMKOycuIeOk7ZBjvtOB7BnQE5xlD6pN4q/x59Ipw+Jlo34A1R1cjEQtNTAB4
         8NQwJdWZWX0r3ycvK0GM0d1ewI86lr/uAjvmF4iFcblBrbudcS16YOPp+jcqoBVuJb
         fdgmcTkN4rlhg==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1o6ZB0-0046Na-LB;
        Wed, 29 Jun 2022 16:00:22 +0100
MIME-Version: 1.0
Date:   Wed, 29 Jun 2022 16:00:22 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 2/2] irqchip/sifive-plic: Add support for Renesas
 RZ/Five SoC
In-Reply-To: <20220629134147.GA16868@duo.ucw.cz>
References: <20220626004326.8548-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220626004326.8548-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <87wnd3erab.wl-maz@kernel.org>
 <CA+V-a8tcxj_N0sBHhgAZAN8WSJ12JnDzAvUUnCXto3wHLqNVwg@mail.gmail.com>
 <87v8snehwi.wl-maz@kernel.org>
 <CAMuHMdVt9FjCtvMgJcCh=g2b+8b-fgabGbOLDcXNrrPMpC+3jQ@mail.gmail.com>
 <CA+V-a8uLzLJ=wB6oUu0b2oZO=FPSCTSrqb=3m9=BJxATFKmjMw@mail.gmail.com>
 <CAMuHMdUWC_7MPnP6LcOqi96FAhrAENC4iwtv2ksZVnvR8BC4ww@mail.gmail.com>
 <0fdbfdd0ee1c7ca39f8d3e2f86af1194@kernel.org>
 <CA+V-a8u8X+bne_a3LY13zGTKr-hOWhm=R9gGX1JyE8PzWRNXpQ@mail.gmail.com>
 <20220629134147.GA16868@duo.ucw.cz>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <632a70d4d9b434cb126cecb015c69797@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: pavel@ucw.cz, prabhakar.csengg@gmail.com, geert@linux-m68k.org, prabhakar.mahadev-lad.rj@bp.renesas.com, tglx@linutronix.de, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, sagar.kadam@sifive.com, palmer@dabbelt.com, paul.walmsley@sifive.com, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, geert+renesas@glider.be, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, biju.das.jz@bp.renesas.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-29 14:41, Pavel Machek wrote:
> Hi!
> 
>> > >> +#define PLIC_QUIRK_EDGE_INTERRUPT      BIT(0)
>> > >>
>> > >>  struct plic_priv {
>> > >>         struct cpumask lmask;
>> > >>         struct irq_domain *irqdomain;
>> > >>         void __iomem *regs;
>> > >> +       u32 plic_quirks;
>> > >>  };
>> > >>
>> > >> What about something like above?
>> > >
>> > > LGTM.
>> > >
>> > > Marc suggested to make this unsigned long, but TBH, that won't make
>> > > much of a difference.  PLICs are present on RV32 SoCs, too, so you
>> > > cannot rely on having more than 32 bits anyway.
>> >
>> > But it will make a difference on a 64bit platform, as we want to
>> > use test_bit() and co to check for features.
>> >
>> Ok will change that to unsigned long and use the test_bit/set_bit 
>> instead.
> 
> Is there good enough reason for that? test_bit/... are when you need
> atomicity, and that's not the case here. Plain old & ... should be
> enough.

On any save architecture, '&' and test_bit() are the same thing.
Only RMW operations require atomicity.

'unsigned long' is is.

         M.
-- 
Jazz is not dead. It just smells funny...
