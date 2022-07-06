Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53E3568470
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbiGFJ5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbiGFJ5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:57:01 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD9B248F4;
        Wed,  6 Jul 2022 02:56:59 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u12so26118876eja.8;
        Wed, 06 Jul 2022 02:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pwJw4iG5MmI5M9vOBxQQYYpW8UUcING3fwN/HsK0A3s=;
        b=kwC8kbk09dEP3xxP68XAwezdx0WWeSATpNwDyuveZbSAKEhQfUiJDiqz+lD0kC2D8T
         /4s3G+fLP/bdfGJffrfO6D75PfYz2GTlVYOK/zzkLDcI4bQAS3qt2CKbv04NdchLcptz
         nGIksdX+jtnhYF9CJDfhpvzxgdejmUl1Go9leBsD+iX4Nfjc1yNGRYkXW6CI8Jn+5ZDz
         1Bp6wkqSaAUZ5Psx1d9Pn9V05e0NP48eNvJreUEwmTUGRLRsyF/H80rNVLOE3hIDoXSz
         5cSBKg9Ixk2kMWU6i9w93rRHjUP7AZ/L2F2uTxdehnjJUgziQjlwg9Mhrvi72cfXQVUL
         lI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pwJw4iG5MmI5M9vOBxQQYYpW8UUcING3fwN/HsK0A3s=;
        b=KML6z8IvvqSh0H1vqTt/TPEHi8EhEaXlTugStllfNtiYn7YUdDTTbL5TYUrDXvYNs9
         bwomXhY2YC67cOVR0qjRsQH5X1tX6j0qXTD82tnw6GIQNT6Et36XNrfUaGTeZsiMq2ys
         0CAZdKxISkWrb87LACYFdny4JGH2XETWYOJZI3NOg4dlArXK+cvFxAlh1MdU8l3vSvHv
         DELybNkKpOgKSdmMs6+712smH3rcmHqhKaxYA0kK7Q7dRSLrQJUaanZZv+K4eZNr/gha
         0u54qCDzxhsQO60IrEiBAUjOHOgXwwlu5uUkHClhgzZ0h8hov7Asw9Bqc2DdF6FjdP8h
         pIOQ==
X-Gm-Message-State: AJIora/hrtB0NLBBpkCuY5dj7tc3HSR7ytOKRxKvP63KMCNmbCzhXBJg
        58N2NHTaxwl7K/ayEKKU6MFdBgbAFPfkSoRoAdzAx5vcBnQ=
X-Google-Smtp-Source: AGRyM1sW8fKdWhuNAv1+5imcPo58CW4Wc6VxQSXaW7+SCoFr2m+aku0YGzrMlbLoFs7Iw1xRvCzGf6aAY/BVvDIozWI=
X-Received: by 2002:a17:906:3f51:b0:712:3945:8c0d with SMTP id
 f17-20020a1709063f5100b0071239458c0dmr38267927ejj.302.1657101417852; Wed, 06
 Jul 2022 02:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220702190705.5319-1-olek2@wp.pl> <3c9a032edd0fb9b9608ad3ca08d6e3cc38f21464.camel@svanheule.net>
 <87fsjen2kl.wl-maz@kernel.org> <20220706081901.GA10797@alpha.franken.de>
In-Reply-To: <20220706081901.GA10797@alpha.franken.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 6 Jul 2022 11:56:47 +0200
Message-ID: <CAFBinCAsj=RNvitj2tXJU6pTLSbanRXdKM9H4vyF=N9N=PP06g@mail.gmail.com>
Subject: Re: [PATCH] MIPS: smp-mt: enable all hardware interrupts on second VPE
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Marc Zyngier <maz@kernel.org>,
        Sander Vanheule <sander@svanheule.net>,
        Aleksander Jan Bajkowski <olek2@wp.pl>,
        Hauke Mehrtens <hauke@hauke-m.de>, git@birger-koblitz.de,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Wed, Jul 6, 2022 at 11:42 AM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
[...]
> > But this is only enabling interrupts at the CPU level, right? And the
> > irqchip is still in control of the masking of the individual
> > interrupts?
>
> in the Lantiq case yes
>
> > If both assertions are true, then this patch seems OK. If it just let
> > any interrupt through without any control, then this is wrong.
> >
> > So which one is it?
>
> if there isn't an additional irqchip connected to the cpu interrupt lines,
> this patch will cause problems.
on Lantiq xRX200 SoCs (34Kc with two VPEs) we basically have:
  cpu_irqc: interrupt-controller {
      compatible = "mti,cpu-interrupt-controller";

      interrupt-controller;
      #interrupt-cells = <1>;
  };

  &icu {
      compatible = "lantiq,icu";

      interrupt-parent = <&cpu_irqc>;
      interrupts = <2>, <3>, <4>, <5>, <6>;

      interrupt-controller;
      #interrupt-cells = <1>;
  }
meaning: the Lantiq ICU interrupt controller provides 5*32 interrupt
lines through 5 MIPS CPU interrupt lines

Without this patch all interrupts are fine on VPE 0 and with SMP disabled.
The ICU interrupt controller can route interrupts either to VPE 0 or VPE 1.
Routing to VPE 1 is the problem: only the upper-most 32 interrupt
lines (connected to MIPS CPU interrupt line 6) are working, all other
interrupts never arrive on VPE 1. This is because MIPS CPU interrupt
line is enabled, even before Aleksander's patch.

With Aleksander's patch all 5*32 interrupts (at least all the ones I
have tested) can be routed to VPE 1 as well.
I understand that this doesn't mean that Aleksander's patch is
automatically correct. My two main questions are:
- why can MIPS CPU interrupt 6 and 7 be enabled unconditionally while
2-5 cannot be enabled unconditionally?
- seeing that there's also a mips_gic_present() check in the opposite
case of what Aleksander's patch modifies: does this indicate that
unmasking CPU interrupt lines for VPE 1 is not handled by the MIPS CPU
interrupt controller driver at all at this point (and if so: do you
have any suggestions how to properly fix this)?


Best regards,
Martin
