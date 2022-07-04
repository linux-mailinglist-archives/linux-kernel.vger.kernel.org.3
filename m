Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0AB5565AF3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbiGDQQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbiGDQQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:16:26 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0BCBE2C;
        Mon,  4 Jul 2022 09:16:25 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id c143so9116328ybf.3;
        Mon, 04 Jul 2022 09:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6xFkniXGF5vICWa6x302C3+4JBqKaRAScVn9xWniJRE=;
        b=gxM92HZ4njr9Z5mLNP8JumPapHbUNh/LCwY7+45zu6hLWxStNHbG7qoYgqsObHDptE
         cIiUKMUPuDj2R1QkYyDx3fPNCY0H2bYYmOgGuhl1ei1AxyoNYkWq7Mv4E+bQVN70TEsb
         0H78JCHH0CgWIUvxIs/BJ3UnxswETE2ilblVF6epl+HKPnpq2wCODFQ0q4islKKrZaEV
         LHSEi2QBY6xxnqjx81EMZom5sCyh95/gStDlKbahOUfnSsjTDCOVPkGTbHtTPFquCfBj
         YYatziYtGuC4EhL+/6HdCilollpTXwhTmf8uwq6vOMNO5hNjpiBQ4EqeX6a+rFQjxLp7
         BLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6xFkniXGF5vICWa6x302C3+4JBqKaRAScVn9xWniJRE=;
        b=RtO/HlViLDN0zIK2keB0h1cxnkfo+J3Ebdndl/cycOUKswGt9lCj25bqyRwhbL615t
         cu7+YOOr5eqQDG3GbwJOG3ExAGVpKXv/jAEEWL6YwD6MnNiIJY0oYnp3QeIdyYras8j+
         dm2Yt2+9J2CJQRWqb0qiX4mcNNAew8+tJMI2tLFJbpfs/QExp/o4UawOSZpvvQAZVJxG
         mPPKExicMYOCHCykxCnoVfGLDq71ZICGP86r1D8fU+rEtV5BR2Cs8kSbyL7m4nxKYcR7
         ogTtP4fGPkscv1wlGev5tUVipEhBDpmtJiGxxRiA1kDcQ1fhbGL8Gt7CMNAQ3rxuu3tX
         7/6Q==
X-Gm-Message-State: AJIora84x3VmqGQWq0dKv1K4V77pYwuWfT+ovS2yzUY9k2N402ZQVpfq
        AQldwvBC2l6tRinSdrnp/wPhXLHYti8KE48nNP9DuCUL9oQyC9en
X-Google-Smtp-Source: AGRyM1vg69LqUqPq1YlKWrUAomNKokyEW1mjXxhrblqClb6chH1lObTFk0hleFx62rwA0zgJ28hlB/Dih1kVBDmwCb0=
X-Received: by 2002:a25:858e:0:b0:66e:4898:63e2 with SMTP id
 x14-20020a25858e000000b0066e489863e2mr7181616ybk.296.1656951384394; Mon, 04
 Jul 2022 09:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220703194020.78701-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220703194020.78701-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220703194020.78701-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Jul 2022 18:15:47 +0200
Message-ID: <CAHp75VfFZ146p1sZ2=Ec-F-9zYJZHPWyvgYQeVsG=2TzssaPmA@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] gpio: gpiolib: Allow free() callback to be overridden
To:     Lad Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On Sun, Jul 3, 2022 at 9:43 PM Lad Prabhakar <prabhakar.csengg@gmail.com> wrote:
>
> Allow free() callback to be overridden from irq_domain_ops for
> hierarchical chips.
>
> This allows drivers to free up resources which are allocated during
> child_to_parent_hwirq()/populate_parent_alloc_arg() callbacks.
>
> On Renesas RZ/G2L platform a bitmap is maintained for TINT slots, a slot
> is allocated in child_to_parent_hwirq() callback which is freed up in free
> callback hence this override.

Hmm... To me this sounds asymmetrical. We alloc something in another
callback, which is not what this free is for. Perhaps it should be an
optional

free_populated_parent_arg() or alike?

-- 
With Best Regards,
Andy Shevchenko
