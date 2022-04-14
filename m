Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D44501713
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 17:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiDNPTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347709AbiDNN7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:59:30 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4259BB0A8;
        Thu, 14 Apr 2022 06:51:56 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id l7so10218372ejn.2;
        Thu, 14 Apr 2022 06:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VkVkOAS9A0MIQPbsfpNua8Mc2ZR7CENLAnkVniIdPoc=;
        b=CXFcqAASxG+Z7VaPl8afDddAJZU3KVfQsH4a1JGZ1EjQwUWtZOh58dCXqu1CRt0nRH
         GbroBEhSONj1yEyS1nlMjO2dTZs5iIHj3amuNDroTKV8vuWjGlUxmp6N8l0rJzVuL9iS
         SK1pfqweFFp8qNmsy1ouvojo1qwb0OkgYbmw5cI1wWa07tZDoFoyAqHiu63K1oCpvGXv
         JCFOxbvoB1FH365GTO/MeElQ0rQQ182PE1dbIz0Nw0J7NGFvquCeeFsdv6sqLOE6QIn0
         C7C+hEmjvWZeIfvuZm9FyH27VeOaKjraYed4fP9gI2wtI0kf1Yw8FEPqUkn+IykqKHnl
         lMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VkVkOAS9A0MIQPbsfpNua8Mc2ZR7CENLAnkVniIdPoc=;
        b=mvf5AbjI6CIGozSsows67t6PVUnH9LUF6Nvvzx4ISOXuYWk01KyRSSLcNt0grvSB9h
         PYDjR314Oor82yrhW2EJGLVGn3hUZVcLOPDJA/q4L3LE+q5xcv99NrUT9oj6KJfLZSZA
         0tnkqcrUKPOBvIpwdvYb57vBtxowwtV7G82I+hJSzF9JsxC+D3PSXy6W13eKw7S8Oups
         EhGuOkrAUpKwbc4On0+xJL9NUKgSuFoINI0ifp0bucTpFANArCZn6xJsZmzw7FMMjXcI
         LQHDqCpzGUPXZcTRpCllo1rZ0np/lUbQd8D0aQP/Mjc6eF3NV2uRGlm/AZuWvM/t5lY8
         2KCA==
X-Gm-Message-State: AOAM530WlAdB4kBkghUgnW2cZ2eaReGhhVfc6HLYf3E06ENVULtSbzhi
        rZRr7nMdAeq1nx6mkJcG9VKqDWLr/ApmEZ+HFdc=
X-Google-Smtp-Source: ABdhPJxL5jFoyaZVlB5dK/sqGFzMiTnpEAX7i3HpaSvcMs3Sr81F+WGQbyWSGSsYbk2dWKrwQ76KhtaYazmSqwcH7pQ=
X-Received: by 2002:a17:907:628e:b0:6d9:c6fa:6168 with SMTP id
 nd14-20020a170907628e00b006d9c6fa6168mr2412944ejc.132.1649944315429; Thu, 14
 Apr 2022 06:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220401103604.8705-1-andriy.shevchenko@linux.intel.com>
 <CGME20220414063849eucas1p126e41b53ff0d342f5c48408994b704e9@eucas1p1.samsung.com>
 <20220401103604.8705-12-andriy.shevchenko@linux.intel.com> <3a24ef01-3231-1bee-7429-dce5680c5682@samsung.com>
In-Reply-To: <3a24ef01-3231-1bee-7429-dce5680c5682@samsung.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 14 Apr 2022 16:51:19 +0300
Message-ID: <CAHp75VfMPpfeMpawRyLo_GtLR8+gVGgm8zW-fatp6=9a9wK18A@mail.gmail.com>
Subject: Re: [PATCH v4 11/13] pinctrl: meson: Replace custom code by
 gpiochip_node_count() call
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Qianggui Song <qianggui.song@amlogic.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>
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

On Thu, Apr 14, 2022 at 12:44 PM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> On 01.04.2022 12:36, Andy Shevchenko wrote:
> > Since we have generic function to count GPIO controller nodes
> > under a given device, there is no need to open code it. Replace
> > custom code by gpiochip_node_count() call.

...

> This patch landed in linux next-20220413 as commit 88834c75cae5
> ("pinctrl: meson: Replace custom code by gpiochip_node_count() call").
> Unfortunately it breaks booting of all my Amlogic-based test boards
> (Odroid C4, N2, Khadas VIM3, VIM3l). MMC driver is no longer probed and
> boards are unable to mount rootfs. Reverting this patch on top of
> linux-next fixes the issue.

Thank you for letting me know, I'll withdraw it and investigate.

-- 
With Best Regards,
Andy Shevchenko
