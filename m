Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D96254664A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 14:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344987AbiFJMIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 08:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347985AbiFJMIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 08:08:37 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808C13F8BF;
        Fri, 10 Jun 2022 05:08:36 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id v25so35001541eda.6;
        Fri, 10 Jun 2022 05:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=slGf5UPUJD+FOJ5RtcL7DyYXgDFT+Di1f0bhg6krmAc=;
        b=CnEadAgdEmDcZdmcLbtXm+FSi2GttAp63gibCxB07vUHVPX2bVaCLw+fSI/ZESBCql
         E4BmgKYXSLBKAY2MMQRl6Vdz4PDJcXZBi4orN+JNWnZd9IR7dtX1Tk/xuYDyvITeh4CS
         5BwEl/EaZkIgGnSllRLU9O4vczCAqg0zwJQFbemV9gnR2pS4zu0+RTbw+tzYROW2gyP4
         WIS8X1Na+iVcBztKZCvMLe8eWYJDtlbWnaK17S7K2qfsvs4RuhR33D2tp+1LieXBUCEe
         xocsb8eSZ398w/MYOme0cHzHQafXCV7yG0ZDq+8Yd4pYWBsCPfjD2plp4f8kfRrdb8jd
         JVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=slGf5UPUJD+FOJ5RtcL7DyYXgDFT+Di1f0bhg6krmAc=;
        b=4F1nCiURFXYbWanaocmFfTUs5GitvZUPAOtJYGnK2+OxsWclKiA/dGbAMjsGva5Vfr
         NRbiM9ed4GthAxoc2NWzdX9oLdbnqFiJ3d+ldWmLguombsBgF/cs6k5XsKmVkmKQxrTV
         mPXpP6tHa/8WoJBCH2RJ+PPJ3OvdSeGc7yA/+WWu5LJz8IH4XRbJKigUlHhSYYc1vOFj
         Cmue/Qx8MaADZlDVf/FfZQK1vEeo3O2hDReb7BTQe9csRS1qfYlyidVdtN8csrbh9Mgd
         cairRSv1wptQ6D0KqpfFiD3zZdTGkor7VjN4cCTIJnUoAE3VNa7egrpMib0TdqHFxMeI
         /8Bw==
X-Gm-Message-State: AOAM530RqyGi0U//rRdiaUjVdY6hjLRxFdQu5VM8j0XLjJtNZx4TgLfb
        kb+1Xj0pZBAIxrY9KNAsXUQaIYMczNokLYKgXbw=
X-Google-Smtp-Source: ABdhPJwcbsm+AWZqmlcmPp6nYdIM/hwB+m1xykYTiv4bhON4DleRXkrUlagPv9jHx05IEUJzM86JgTIAr+qtNpGl+eo=
X-Received: by 2002:a05:6402:4390:b0:42e:b7e:e9ac with SMTP id
 o16-20020a056402439000b0042e0b7ee9acmr49789045edc.97.1654862914889; Fri, 10
 Jun 2022 05:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220610001609.276220-1-j.neuschaefer@gmx.net>
In-Reply-To: <20220610001609.276220-1-j.neuschaefer@gmx.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Jun 2022 14:07:55 +0200
Message-ID: <CAHp75VcLn5Ue0efoH_3kKJJqrD5OMbvetPh13FCQFshG9hnN9w@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: nuvoton: wpcm450: Convert irqchip to IRQCHIP_IMMUTABLE
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 2:24 AM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:
>
> Commit 6c846d026d490 ("gpio: Don't fiddle with irqchips marked as
> immutable") added a warning for irqchips that are not marked with
> IRQCHIP_IMMUTABLE.
>
> Convert the pinctrl-wpcm450 driver to an immutable irqchip.

...

> +       gpiochip_disable_irq(gc, d->hwirq);

> +       gpiochip_enable_irq(gc, d->hwirq);

Can you use the helper (*) as stated in the documentation?

*) irqd_to_hwirq(d)


--=20
With Best Regards,
Andy Shevchenko
