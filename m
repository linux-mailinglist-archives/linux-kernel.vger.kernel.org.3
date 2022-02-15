Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E699E4B7149
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240946AbiBOPol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:44:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240315AbiBOPoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:44:18 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AC6EA363;
        Tue, 15 Feb 2022 07:38:31 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id p9so22202235ejd.6;
        Tue, 15 Feb 2022 07:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4c4uLg+6xK62uK/uIKxvl/o7vQn8X9pm3rRoIxcYStc=;
        b=hVRSoNqL5G26KGJupiMcqpIIJ6KdnEX2br5Ah4u+93CBcx13OUAYoHcTpp+gHXlTtZ
         Pwp+IBPNf5Asgg2RQmCkRE7/lkz9CKKIaLCfpfYqMWpxk+zR7r6YGKl1jaQg8OpEj7ro
         Hc9uS0htjha3XdJfKpvdXvF4M4P54Z+y1ymAPxsTq68GdiD/1R9Gf8IU2fc37Hm5fs0W
         QUK7wqnbwk6FMrL/Slbkr85sGi0OIrcPgmxui55rTRdDso9F9WrOGZvrUeOZWw5d5OrF
         NvA0iYYv4uRWI9SxzRheHl6iNMzJ2Dl2G3KVOvBA+ltg9yN7vbN1az2T7ZDOtglfYidf
         6Y0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4c4uLg+6xK62uK/uIKxvl/o7vQn8X9pm3rRoIxcYStc=;
        b=E7cQR337+T/dwSlios1cXy/HrOEu6K8t4vw2qKRnGY4rnrRt+7avOyfnFSxPLVJ2fN
         NqJ/PLopN/Ag9Ai6CHYoPVK/ZpTByytLsCFoUf2XpjngEgpbOCurD+IuhNptnnRWNCJu
         u/wJdCzK4D84dlgmRtxobmtbOuf5pRDcLu+L9x7qM0BTpnbp+quz/Np3b+3zfbHnTC9Z
         uEeTLE9WP0CncfWfvIj0DjGNbUf3eGuNyErA1E70+KgKuJ3STB49yhHf9Dp/TAjBnEMf
         a0M15DoXqlJIXjaGCLLbB12UH5f/3gY/j3pisTo1izpw1k7EM50IT1CGrwQq8FfBrQHz
         K/1A==
X-Gm-Message-State: AOAM5302nncZOJ+DicpCfQ6VEB5iAmjaKDS3FxdVZrI3MGrkak842EIz
        Twk/vPhoI8PDAG/MR+4zVASmFqNpi4lQUW0VU1o=
X-Google-Smtp-Source: ABdhPJxQGBopSj3C6s+jqyN0nrwN12siEVw8h8G+/ijRyT5ogzTJ7KsTO9W46tWw5cDOyfkQckGvDJf4RDiA7ZGISGM=
X-Received: by 2002:a17:906:99c5:: with SMTP id s5mr3466341ejn.497.1644939510133;
 Tue, 15 Feb 2022 07:38:30 -0800 (PST)
MIME-Version: 1.0
References: <20220209162607.1118325-1-maz@kernel.org> <CACRpkdYfrAexUhFV6e86QW+GSc3hM=38VNucKLhPppJ2ZdQ7fA@mail.gmail.com>
In-Reply-To: <CACRpkdYfrAexUhFV6e86QW+GSc3hM=38VNucKLhPppJ2ZdQ7fA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 15 Feb 2022 17:37:01 +0200
Message-ID: <CAHp75VdmKqViM5393w=frbX77te6X-VnMe5+VZwxY4PBw12Pdw@mail.gmail.com>
Subject: Re: [PATCH 00/10] irqchip: Prevent drivers abusing irq_chip::name
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marc Zyngier <maz@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Android Kernel Team <kernel-team@android.com>
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

On Fri, Feb 11, 2022 at 8:31 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Feb 9, 2022 at 5:26 PM Marc Zyngier <maz@kernel.org> wrote:

...

> Since ... I am mostly
> playing with a baby during the daytime

A bit of a side topic, since I need to send a PR for fixes before my
vacation starts tomorrow, should I Cc my PR to that Linus as well, so
he can accept it?
It will contain two one-liner ID patches to pin control Intel drivers
and won't conflict with anything (as far as I am aware and know).

-- 
With Best Regards,
Andy Shevchenko
