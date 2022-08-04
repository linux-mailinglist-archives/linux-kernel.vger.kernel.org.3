Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659D5589641
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 04:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236415AbiHDCqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 22:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiHDCqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 22:46:18 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD581EC48
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 19:46:17 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id t21so7755319uaq.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 19:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=7AamRdppKvDSQrc9DYTmow3W1DdARJPLLdADy2Ps/Tk=;
        b=aLRkbAjrkTiOBwngiAXaGfPz9SlT8CVBeBLb3a8Oh0vFnpsY2UxyXdJKhBcO6J9+Hj
         a+r0mX0vqT/JtsYSki4zIvGzFh/tbvxKchIZDlxk/SQ+mHOEft011MDpqWjN8u4Q2urS
         lsQUIbA+K4Rueo7ipWyuJmcHN8AjN/v4mlOj3porzVa2zC5G9jJpYjrBWhnkOAKCFkVw
         /h1xGQFgTmUmh4mmV1mB9TAzdpZNkXTRoNQAEFI+exbyGilGp1kkWNNbJRQZyWR08XvS
         kJYsbS+bxol3Ifu0+SoJrFNLs5fjn+3CTF0xyd0uM56R5JbbzH1VTIlK8Dhdkj0Yo0O6
         qTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=7AamRdppKvDSQrc9DYTmow3W1DdARJPLLdADy2Ps/Tk=;
        b=j89NlsDa/D5Kf6KyqPpR7wl30e+rEDWauNw+l4u3rAcShS3xBBd7WKpjwhs0GvnWtR
         ZRjjqlSwr/JdZaVXFgKyZM1ls7znTeiNo9agBk5ygvTWJU5aQ6ZZAVSmryC+sEtLNSde
         Wh2NmCy8T0QPPcM80XS7zFB71Y3dfgYDIrjx7Qmah5Q7IHYM9A91s/vgu3tcPoV5O0CM
         GRIPqku+C0VJN3xcwtV95FMzaA0T/ccO/c6tdv0+R6yocoQ2ZvivTxbqR/L9Oar/KqoB
         e/XMI5iSG5+CQBj+QYZAn+9oGdA3b7ue8RyNSkZUYhQItgULij3f/s9NFw5RIxwR6QKw
         bkcQ==
X-Gm-Message-State: ACgBeo3oYDDPYHgpoxaYiGAsL435+oANxfm8ts6aBwkFN0SAzSMJ7d5p
        pquHvW5Q4KwSv+xwCWgj4YNvmMsQlQFJ9qsNYq8=
X-Google-Smtp-Source: AA6agR7PV3JeH+wI46Djao6jul7KY04JcQQpbD0zC1OQG5gyUQi/7KDG1mTLMU9JnUA72jB8n9KlfMkalDTUKzsGbhc=
X-Received: by 2002:ab0:65d6:0:b0:385:f6e1:83ef with SMTP id
 n22-20020ab065d6000000b00385f6e183efmr11690820uaq.23.1659581175594; Wed, 03
 Aug 2022 19:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220803042728.3230346-1-chenhuacai@loongson.cn>
 <87r11xbxox.wl-maz@kernel.org> <CAAhV-H5d20zj+vnrEYRYW1h7FwRJpGYtJDc1q4hRdPh3KbXruw@mail.gmail.com>
 <97d33f58-6a15-3a94-f9c0-42ebd48cf562@loongson.cn>
In-Reply-To: <97d33f58-6a15-3a94-f9c0-42ebd48cf562@loongson.cn>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 4 Aug 2022 10:46:00 +0800
Message-ID: <CAAhV-H6hYu5vdpPar_8nMKMWUgD3MLzNBFLkHJyHKfjvCRJJ4w@mail.gmail.com>
Subject: Re: [PATCH 1/2] irqchip/loongson-eiointc: Check hwirq overflow
To:     Jianmin Lv <lvjianmin@loongson.cn>
Cc:     Marc Zyngier <maz@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 3, 2022 at 7:59 PM Jianmin Lv <lvjianmin@loongson.cn> wrote:
>
>
>
> On 2022/8/3 =E4=B8=8B=E5=8D=883:33, Huacai Chen wrote:
> > Hi, Jianmin,
> >
> > On Wed, Aug 3, 2022 at 3:20 PM Marc Zyngier <maz@kernel.org> wrote:
> >>
> >> On Wed, 03 Aug 2022 05:27:27 +0100,
> >> Huacai Chen <chenhuacai@loongson.cn> wrote:
> >>>
> >>> Check hwirq overflow when allocate irq in eiointc domain.
> >>>
> >>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> >>> ---
> >>>   drivers/irqchip/irq-loongson-eiointc.c | 7 +++++--
> >>>   1 file changed, 5 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip=
/irq-loongson-eiointc.c
> >>> index 80d8ca6f2d46..f8060e58ee06 100644
> >>> --- a/drivers/irqchip/irq-loongson-eiointc.c
> >>> +++ b/drivers/irqchip/irq-loongson-eiointc.c
> >>> @@ -241,8 +241,11 @@ static int eiointc_domain_alloc(struct irq_domai=
n *domain, unsigned int virq,
> >>>        struct eiointc *priv =3D domain->host_data;
> >>>
> >>>        ret =3D irq_domain_translate_onecell(domain, arg, &hwirq, &typ=
e);
> >>> -     if (ret)
> >>> -             return ret;
> >>> +     if (ret < 0)
> >>> +             return -EINVAL;
> >>> +
> >>> +     if (hwirq >=3D IOCSR_EXTIOI_VECTOR_NUM)
> >>> +             return -EINVAL;
> >>
> >> How can this happen? Also, you're allocating a *range*. Surely the
> >> upper boundary should matter too?
> > Do you know the exact reason? Please give some information, thanks.
> >
>
> In our internal repo, we don't have middle domain in pch-msi driver, so
> no check for hwirq as in alloc of middle domain. When hwirq is assigned
> failed(negtive value), the wrong hwirq will be passed to parent
> domain(eio domain)'s alloc, so we add check in eio domain's alloc there.
>
>
> But here, it seems that the check is unnecessary, because in pch-msi driv=
er:
>
> static int pch_msi_middle_domain_alloc(struct irq_domain *domain,
>                                             unsigned int virq,
>                                             unsigned int nr_irqs, void
> *args)
> {
>          struct pch_msi_data *priv =3D domain->host_data;
>          int hwirq, err, i;
>
>
>          hwirq =3D pch_msi_allocate_hwirq(priv, nr_irqs);
>          if (hwirq < 0)
>                  return hwirq;
>
>
>          for (i =3D 0; i < nr_irqs; i++) {
>                  err =3D pch_msi_parent_domain_alloc(domain, virq + i,
> hwirq + i);
>                  [...]
>
>
> If pch_msi_allocate_hwirq failed, pch_msi_middle_domain_alloc will
> return, and pch_msi_parent_domain_alloc(will call eio domain's alloc)
> will not be called.
OK, then this patch can be removed and I only need to send the 2nd one. Tha=
nks.

Huacai

>
>
> >>
> >> And for the umpteenth time, please add a cover letter when sending
> >> multiple patches. This is a hard requirement for me.
> > OK, I will add a cover letter, even for simple fix patches. Sorry.
> >
> > Huacai
> >>
> >> Thanks,
> >>
> >>          M.
> >>
> >> --
> >> Without deviation from the norm, progress is not possible.
>
>
