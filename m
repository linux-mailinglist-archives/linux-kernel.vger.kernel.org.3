Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88ACD4EBD17
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244532AbiC3JCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242106AbiC3JCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:02:35 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CFB2CE33;
        Wed, 30 Mar 2022 02:00:50 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id p25so16104097qkj.10;
        Wed, 30 Mar 2022 02:00:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5TjfE/nqlbc8hvQ5iunfZ0y6JZjtbfEsmjFPKu69VzU=;
        b=qhtqvAwfDgLx4p9j8e4I5cXlQOgpS5TPrPyf1S5h+jLn7KurXaJ5DGiKkOGqlU/yAF
         sTVpjTLsP5vO3ACdIH/sPeKLkesVOueizl2GF+d088XMhF+oFIkWBMlSoNrcKGDj4Knd
         yfGaOPeOdmJRa7knzt5PQQ1MH4IsK4EC4viG6CHR0JJkwqB5oCNqcfFOlPmOgdxKkHB2
         hwR0F4OsoWx0hUUDeaQ728Y5TYyLXErn535eS8/Bz42ol3DzhL4FZW9ec0IBf73l64FK
         yFr7/eMQBznxgS58ZLnp1m/2FVekPouzev065ZbcTe959uCIxDEfwXT0KBqdjYZXKMAu
         NSIw==
X-Gm-Message-State: AOAM531cCT214caUvfN5qktHXIKdTR9jv+7z/trZdo6suNhgPPoCNPA5
        HUKXDMN9UMPJzZBv8vRQDPJxJqbXe15L7A==
X-Google-Smtp-Source: ABdhPJyeqOvmmNrOV6cTBKdL2Wcz3z1sTxLa0T85dSo7nTYnX0L8/lKGsCvhNjloWKC+8EY/HBTo3Q==
X-Received: by 2002:a37:44ce:0:b0:67e:c957:a9cc with SMTP id r197-20020a3744ce000000b0067ec957a9ccmr22468060qka.210.1648630849527;
        Wed, 30 Mar 2022 02:00:49 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id u21-20020ae9c015000000b0067d4b2e1050sm10446655qkk.55.2022.03.30.02.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 02:00:49 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id f38so35875074ybi.3;
        Wed, 30 Mar 2022 02:00:49 -0700 (PDT)
X-Received: by 2002:a81:c703:0:b0:2d0:cc6b:3092 with SMTP id
 m3-20020a81c703000000b002d0cc6b3092mr34737611ywi.449.1648630500868; Wed, 30
 Mar 2022 01:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220329152926.50958-1-andriy.shevchenko@linux.intel.com>
 <20220329152926.50958-10-andriy.shevchenko@linux.intel.com>
 <94e888fe-d8fc-5379-302f-66d64f2ae10b@baylibre.com> <YkM22GwhxV+YKl8l@smile.fi.intel.com>
In-Reply-To: <YkM22GwhxV+YKl8l@smile.fi.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 30 Mar 2022 10:54:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWVA834tkeag=WOnHFGuhwZ93PkrgO24OV69Fye1hruLw@mail.gmail.com>
Message-ID: <CAMuHMdWVA834tkeag=WOnHFGuhwZ93PkrgO24OV69Fye1hruLw@mail.gmail.com>
Subject: Re: [PATCH v2 09/13] pinctrl: meson: Rename REG_* to MREG_*
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Qianggui Song <qianggui.song@amlogic.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        openbmc@lists.ozlabs.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linus Walleij <linus.walleij@linaro.org>,
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
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Mar 29, 2022 at 6:47 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Tue, Mar 29, 2022 at 06:13:19PM +0200, Neil Armstrong wrote:
> > On 29/03/2022 17:29, Andy Shevchenko wrote:
> > > Rename REG_* to * as a prerequisite for enabling COMPILE_TEST.
> >
> > What error do you hit ?
>
> arch/x86/include/asm/arch_hweight.h:9:17: error: expected identifier before string constant
> 9 | #define REG_OUT "a"
>   |                 ^~~

Perhaps REG_{OUT,IN} in arch/x86/include/asm/arch_hweight.h should be
renamed instead, as this is a generic header file that can be included
anywhere, while the REG_{OUT,IN} definitions are only used locally,
in the header file?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
