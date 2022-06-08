Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8540542F9E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238433AbiFHMBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 08:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiFHMBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:01:02 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B59915C888;
        Wed,  8 Jun 2022 05:01:00 -0700 (PDT)
Received: from mail-ot1-f45.google.com ([209.85.210.45]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mf0Jg-1nWjHU3Kck-00gZ9B; Wed, 08 Jun 2022 14:00:59 +0200
Received: by mail-ot1-f45.google.com with SMTP id y16-20020a9d5190000000b0060c1292a5b9so1986959otg.3;
        Wed, 08 Jun 2022 05:00:58 -0700 (PDT)
X-Gm-Message-State: AOAM533i8sFw0DRQnT7qY1cZnfXRnBzcjCpnQv96WS+A+V4f/W0aKYlX
        dg+cjTFKixlRP4VoLDIg6bbUcaGqWZA3w/ah2YY=
X-Google-Smtp-Source: ABdhPJzpBRQHOrOjRCxL6NgH9iKMT4129LgubmWT2Bck+iPxdLoQ6gKC8EUoy0gPKu/hz3e4skCIDgwhp1qkekViG9Y=
X-Received: by 2002:a81:190f:0:b0:313:43b8:155c with SMTP id
 15-20020a81190f000000b0031343b8155cmr7988991ywz.495.1654689646278; Wed, 08
 Jun 2022 05:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220608095623.22327-1-tmaimon77@gmail.com> <20220608095623.22327-2-tmaimon77@gmail.com>
In-Reply-To: <20220608095623.22327-2-tmaimon77@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 8 Jun 2022 14:00:28 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0mHk80oN_uLSif7wSY7x1ZN3bUkfz2xkdqmkxTqqXjeg@mail.gmail.com>
Message-ID: <CAK8P3a0mHk80oN_uLSif7wSY7x1ZN3bUkfz2xkdqmkxTqqXjeg@mail.gmail.com>
Subject: Re: [PATCH v2 01/20] clocksource: timer-npcm7xx: Add NPCM845 timer
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        gregkh <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vinod Koul <vkoul@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        robert.hancock@calian.com,
        "nathan=20Neusch=C3=A4fer?=" <j.neuschaefer@gmx.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:fpV+MFHVMv+0qZsZKGS/bEt/xhfSvy85PA/AFG7pA5pz/Mm0ReK
 1ulAyq86BrsIMPTYf3AGZiTGzcBdl/7sFjvMGjccovyst8Z4hwHQDwHuPsfLfTKLbbuXjKM
 obYG92npLl/v2iPVClyPLK3gmczkZgMh3geLYY3rhu9TC9CATvT54bfWeLbUOTms1kHYYYF
 iJkgb7teeMxd2VBAQZSlw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dLM3wY8LwP4=:JVyRRfBpXk4DUqhq96euV6
 EUKFs+4BMnFBFjJieQWYWRixotk7ZGBxJa3mcoaVWdmNE532ibuqQsX9in+LLwDa2PjOtxQEt
 ujKnlfIXn+0izewupSxWESUNkXG9lXS9iYbRUBofZTOefz32tPBOUb6yzNVRrSeIv2VloMaGA
 5t+pSl5CqRv9O9eVVTn7yjEpUCLuSlHovHNmEXJnY0DsLhDxxA1VHwW+HZHkzfnRJ5ffUfX74
 QMVThzj/j1FbMu3+7vlGcdpKm/pRy8aU0tZpFmDv217od6jNyPYe7loi+18BwyjlM8Ezazj6Y
 Sd3dTQTj6YPJf+WOu5z0TGizrTMP/wnNjwb/ttTSpnO39jBuoE0ZLNFpGqlbRK5a/beib6hlh
 Vj4REmF3XUM+Ot9psGqi0B/s7OvCVUUIdDWsLj7HmNiTnXkXfy7hLx6wusuGoagKmvsjquNqo
 hsli+dS8umasDQ3oYWdQDyZK93ZcbTpfmYme55li3iD5bg5eKN4ex9yLN2UOJYMs2LYo4BCwJ
 DmbNHEWliMrZzu6GjbCGJf/wbnR1LJBXxvmVWOFr8n1+ZMKm1rUFWtOkqdakc18Id9Mj0j/nC
 twVhTu6OfXvUjYdKYzdqP0l3LPG0+cPf8Q1v5/NC+Lv6xYT+9bIKYYP6J7hAMRa+pQ9Wl4XV+
 6xNOtr8AcDlVNn6HTkFpF5fIDFpega5mupRxt2OwLj3aKKIMuinHmgjBe95fD7lpbIIWj0qt4
 mhcugyqB/Bfej1POBdHgy8xQLnEEESgnd6EXbtodbwYAjPZpxIKZuJq+T+ujANvFG5xn1TfpP
 vexk/SPerAaC27CfYcTOXS455w0SQZDy6msSSgD1chQUKBk8xEanlxXm0ENoJVG2kW+rV5CrD
 e3xIbQuwezxwxRhugxlQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 8, 2022 at 11:56 AM Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Add Nuvoton BMC NPCM845 timer support.
> The NPCM845 uses the same timer controller as the NPCM750.
>
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  drivers/clocksource/timer-npcm7xx.c | 1 +

This one should no longer be needed if the timers are compatible with the
old ones and correctly described in the DT.

      Arnd
