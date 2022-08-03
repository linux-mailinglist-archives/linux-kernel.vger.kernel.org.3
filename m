Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A8F588804
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 09:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbiHCHdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 03:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiHCHdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 03:33:43 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D05C1D31F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 00:33:42 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id m67so9431366vsc.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 00:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=iqxOdJFtC2If/ZXLHcmbp/RBxXGq4jUfEjDF0nOoWWg=;
        b=bARutheAW5JDEHlANZFIG34YL7KjyliUs3ADYEj8NB0FBVD3ex0/HAA7MWdNtbZkXS
         LMcMjXCQPsY0UVRpP118fn6cqycMatWEty3RpS/yCcj+wJplP5XU07iKaNlI1SHnyvHT
         H1h+KkDFZGj4s6uGEyJ2gv6TceB5pXYjQ073fGbsX39ujUH+MK7q4nZCknLlFtJgzkVi
         DCI4zLL9YhuJCTG4JOldcXfcIKrZIt9an9YTkv316kPSc8gHq381PYFWtQGG31nTWM7y
         4GV44xWRP3k0LuEvFomZhzmjme9QpXXjXfpa+m3kSx2TZkhTzsngaxCY2fY2fxocWryh
         21Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=iqxOdJFtC2If/ZXLHcmbp/RBxXGq4jUfEjDF0nOoWWg=;
        b=zal9sOqFVaRowFNsk4K7TIbjIc7CstmWr+lcUU5QbX/bD7Fj6DdFhG7+Z3ELjzTlKY
         NNGW92CZJ+tWVw72PKrkWJ/IS1pBelnknSaVHSlT/bs4P2LlH/0jgya2LV8CoFeIGCa3
         rJlp6t2iMSJrHTQD2GdfXiZpG+At6Tvm8i2pq7Gj0a9Qgn1VtQd/LuiUljPCqsEFl8KK
         Wl4eoX7Ffj8yg/JnSObjGBBOFBbXiEO/BBj934DK54X0/5tEE8HXy79/cP3vex27cev1
         mCQX/JdEC+s0o6pJ4bCynwB603bAFKPKF1LuLc3V+UUfxEXPaRwUb29/XD2U4o/aYp4h
         yZpw==
X-Gm-Message-State: ACgBeo3ppAINR9HUmhmNG9/sjFIVcQuGHIyu+MpgUWPYHdvHB3sdFXuK
        jz28c4wNdhPcqIuFMcbXpClHaYHE0Dq56nxZoZg=
X-Google-Smtp-Source: AA6agR72RkQdLVyS56GeQwkfOTjaNRQbprGOjzdpCGwhwGtMPqjz9TpqxYtexhsHPMiRst9DAFCqqMgC8reVJ6qeOIQ=
X-Received: by 2002:a05:6102:390d:b0:387:78b9:bf9c with SMTP id
 e13-20020a056102390d00b0038778b9bf9cmr3833027vsu.43.1659512021347; Wed, 03
 Aug 2022 00:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220803042728.3230346-1-chenhuacai@loongson.cn> <87r11xbxox.wl-maz@kernel.org>
In-Reply-To: <87r11xbxox.wl-maz@kernel.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Wed, 3 Aug 2022 15:33:27 +0800
Message-ID: <CAAhV-H5d20zj+vnrEYRYW1h7FwRJpGYtJDc1q4hRdPh3KbXruw@mail.gmail.com>
Subject: Re: [PATCH 1/2] irqchip/loongson-eiointc: Check hwirq overflow
To:     Marc Zyngier <maz@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jianmin,

On Wed, Aug 3, 2022 at 3:20 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Wed, 03 Aug 2022 05:27:27 +0100,
> Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > Check hwirq overflow when allocate irq in eiointc domain.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/irqchip/irq-loongson-eiointc.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
> > index 80d8ca6f2d46..f8060e58ee06 100644
> > --- a/drivers/irqchip/irq-loongson-eiointc.c
> > +++ b/drivers/irqchip/irq-loongson-eiointc.c
> > @@ -241,8 +241,11 @@ static int eiointc_domain_alloc(struct irq_domain *domain, unsigned int virq,
> >       struct eiointc *priv = domain->host_data;
> >
> >       ret = irq_domain_translate_onecell(domain, arg, &hwirq, &type);
> > -     if (ret)
> > -             return ret;
> > +     if (ret < 0)
> > +             return -EINVAL;
> > +
> > +     if (hwirq >= IOCSR_EXTIOI_VECTOR_NUM)
> > +             return -EINVAL;
>
> How can this happen? Also, you're allocating a *range*. Surely the
> upper boundary should matter too?
Do you know the exact reason? Please give some information, thanks.

>
> And for the umpteenth time, please add a cover letter when sending
> multiple patches. This is a hard requirement for me.
OK, I will add a cover letter, even for simple fix patches. Sorry.

Huacai
>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
