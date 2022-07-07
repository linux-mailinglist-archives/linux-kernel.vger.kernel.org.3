Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EDB56A301
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbiGGM6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236004AbiGGM53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:57:29 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58D32C64B;
        Thu,  7 Jul 2022 05:57:27 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id r21so3479283eju.0;
        Thu, 07 Jul 2022 05:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KEZPgqeDgtzj5a59iDB4r6txgycqbLaS/+hhTY6yo/E=;
        b=hUzjdrfFoZ91Am5wglBX21YfetM2+1ysldPIiIS+lmAqEa7A1wP8Ff7WRTeMQDxWCv
         KDwCvIyDoAkvQd4DyQJVo0Fq+3DDO8Kd0/baKqN/H1qct5CMOaqcml50YBuoAoF9mlJH
         OVBTZsAKhi+KDhCj26GLZ8adXR15IUWOY1pK+CINH2N6hhPuAD/uNKLYZT9KQjlqjVjt
         zf+B2047Z9fQTQk+ZBmqvgDE1xrjX1Tp7blD3opttFSexDI7Y9us8q/8BYXnN3wadZqf
         IqYRg1gEdP0VA8Qpp8g0DLBvEgN1y8d5irGm3Q1Vtvu4N93X5VI2/O9wCxSUKygqYNrN
         QdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KEZPgqeDgtzj5a59iDB4r6txgycqbLaS/+hhTY6yo/E=;
        b=TN3YvfvTalZuEVI5B94S9fE8VjIIPtcm1T9u/aq3kHtp3l05OKgVBGa7oQziHi7Qln
         n1eRSBtXAYC8vp8H1RoQUvXOuucbTPr/m+Fiu28iTFugkG1fHHLK3ZGZpMzDVMhZWfeU
         5rxC2qTu/7Izb3VU1RnUbRvZUfvlVjDtLUvCch7O0krryd5iviEyFum19ZQ9zrZ2qp52
         i5/Q86I97C2JEyVZmhDowU/fPvg2Bkp6dJwsSBDgMMSjdIbuJ5mbGpD9eowKlO1qLh/z
         XYkNC6AI2h5XW+VwzaVJDHjZ/bcUyPCJ6SKwPnLn2KlWSEHLPrRQd99c0VBAjGO+q/LK
         L63w==
X-Gm-Message-State: AJIora9W8J0wMk7/qLPO/eaoZIye0u/VlixzYvVQeT8rIiZC6m3Vw8HL
        iAihgNgLunNg6HxsMA2zgkhafiK4eZWrJHlvSb0=
X-Google-Smtp-Source: AGRyM1t+B1QDdpsvS/YLlcQXZ/JsSjGh+c/ssItH8udnGIfSa9299unBMqhsFG2p1Ux36SWqLBojAFnD51h21krtMUc=
X-Received: by 2002:a17:907:75e8:b0:722:e8c5:ee96 with SMTP id
 jz8-20020a17090775e800b00722e8c5ee96mr31910449ejc.147.1657198646310; Thu, 07
 Jul 2022 05:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220702190705.5319-1-olek2@wp.pl> <3c9a032edd0fb9b9608ad3ca08d6e3cc38f21464.camel@svanheule.net>
 <87fsjen2kl.wl-maz@kernel.org> <20220706081901.GA10797@alpha.franken.de>
 <CAFBinCAsj=RNvitj2tXJU6pTLSbanRXdKM9H4vyF=N9N=PP06g@mail.gmail.com> <20220707100630.GC9894@alpha.franken.de>
In-Reply-To: <20220707100630.GC9894@alpha.franken.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 7 Jul 2022 14:57:15 +0200
Message-ID: <CAFBinCBn3+MbKFE84Y0KjW4qG_88+HuBTzRhPQSDqzqGhyhhZw@mail.gmail.com>
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

On Thu, Jul 7, 2022 at 12:11 PM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
[...]
> > - why can MIPS CPU interrupt 6 and 7 be enabled unconditionally while
> > 2-5 cannot be enabled unconditionally?
>
> 7 is timer interrupt and is usually wired for 34K cpus and 6 is
> performance counter hopefully handled as well. And I agree that
> this still isn't the best approach here
Thanks for this explanation!

> > - seeing that there's also a mips_gic_present() check in the opposite
> > case of what Aleksander's patch modifies: does this indicate that
> > unmasking CPU interrupt lines for VPE 1 is not handled by the MIPS CPU
> > interrupt controller driver at all at this point (and if so: do you
> > have any suggestions how to properly fix this)?
>
> I haven't checked how GIC is integrated. Iirc it does something similair
> to Lantiq's irq controller and hides all CPU internal interrupts behind
> it.
>
> So I see two solutions for your problem.
>
> 1. Add "mti,cpu-interrupt-controller" to the DT and wire it up
I think this is the preferred way. I tried this before (if you are
curious, see [0] and [1]) and it didn't work.
Are you aware of any MIPS SoC with upstream drivers which do have
working IRQs on VPE 1? Or can you point me to the code in
drivers/irqchip/irq-mips-cpu.c that's responsible for enabling the
interrupts on VPE 1 (is it simply unmask_mips_irq)?

> 2. Create your own struct plat_smp_ops using vsmp_smp_ops as
>    a template and overload .boot_secondary
This would work, but: personally I would like to remove as much Lantiq
platform specific code as possible so it's easier to maintain.


Best regards,
Martin


[0] https://github.com/xdarklight/linux/commit/0e5a5dda0e999a3a2e5a81324fef15405d8c6b4a
[1] https://github.com/xdarklight/linux/commit/97ec4689d2016606442577988d28fef6728c3bbf
