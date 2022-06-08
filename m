Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028C75431A1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 15:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240387AbiFHNlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 09:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240463AbiFHNlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 09:41:09 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E861DBBE7;
        Wed,  8 Jun 2022 06:41:00 -0700 (PDT)
Received: from mail-oo1-f48.google.com ([209.85.161.48]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MryGj-1nMYIk1R5R-00nxEP; Wed, 08 Jun 2022 15:40:55 +0200
Received: by mail-oo1-f48.google.com with SMTP id u8-20020a4ae688000000b0041b8dab7f71so1205941oot.7;
        Wed, 08 Jun 2022 06:40:54 -0700 (PDT)
X-Gm-Message-State: AOAM5302eYUEfDQ3Wpn9KvsmqaoXF0oIpS+KC9c9a6ZvOV8bXtEA+gLK
        9D31RD6/LQEFi4shgu+ugq6d2ug4+wjrI7e6HFw=
X-Google-Smtp-Source: ABdhPJz2BHOurRsFwYT1sdgDudW8hbqZLiFh5uJabIpaTujJq1RW87W9w/ToAVhsqJUdCedezsMu54m6sw5pKiza1Ac=
X-Received: by 2002:a25:69c4:0:b0:65c:ed2b:9106 with SMTP id
 e187-20020a2569c4000000b0065ced2b9106mr34390555ybc.394.1654689677569; Wed, 08
 Jun 2022 05:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220608095623.22327-1-tmaimon77@gmail.com> <20220608095623.22327-4-tmaimon77@gmail.com>
In-Reply-To: <20220608095623.22327-4-tmaimon77@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 8 Jun 2022 14:01:01 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1fDDk2kWMoxFjxoZT6dD5vfNzmNO+sMhV-GrZkpGkPow@mail.gmail.com>
Message-ID: <CAK8P3a1fDDk2kWMoxFjxoZT6dD5vfNzmNO+sMhV-GrZkpGkPow@mail.gmail.com>
Subject: Re: [PATCH v2 03/20] tty: serial: 8250: Add NPCM845 UART support
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
X-Provags-ID: V03:K1:NAE0evcWmhCM4sQtUtiGMC4rBO2GvE7dD7PfOBca+heddEKrvUW
 LcDx7+T6ldJe81P3a2NwFHSAAPro3U23pDJATTvn78e9/L8CiHai/lMDDFAVM9CC8t2Z4xm
 KQ+qzkaOlMjAR8qLDr4JfYL0rtYR+kYcMIfRPBOBdkvmOc9PiIUUfCvGpz5hP1K8eBoO4Im
 EGhyIA6m6UMM0Gi/GleCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c93BJOoNeY4=:pfVvJjbxtkNNAoaiSjg+ZP
 Bmt9cUKnrtQeFMX2snOtQFW763OTb8cIpsbimqSZLJwyg38PfDey6KvSdjqYD+T45S1z4b9/k
 8EenCapdY2bMqArpo9rdA+q8Vp3AVEsmaUmso3M58KRHZhHR2ecFSe/XkMDA7CrSiIwfKvUT7
 QPo0FUFdXajLKCfjgfb0YpoEUZCm4wWlE4SpBg0xk9e53mmu3lTFjTbbHjsivvCY2Ydg3siRu
 bXACkW0+1ag0kbYy7wVTZVeGpo27TIx6FvzpDhm5o03Cuxzvrsn7rRghe4nUa7tdY6I/Sg9aV
 Tu3gQPY5H18X6v8B242Tldz7gHumWGO3xqgBSh4b5GL/nFU+dKtR1TUT5+Bl+cjN0oVLNHAUK
 7Bcum3DU9tCa7x3QsGwOfIRIldLTciqBrc95visGA4SgFIDlMN7ZgTgeMonc4lL1oTqbKDJHk
 /vNocX5zFz13/HoEif4Jcso6i94/3k6u9JVK2h/WkZHp8RQXFmNhxrts1WLHlN5iOJdjBAw9D
 ELGXKrtKy8NzvRAyxp0+dASqOBhSHve8OYml+YfsvYFs/98Vb6wbq2ey297M0m05Syg8GNzYC
 pjScGEgB0e4imaJa5j40Wz0e29DDJoA7HdbOo5oEd8K9ArepuBRAge/qEpyrPv8lc/I3bmh/b
 aMZ2yq4qcAvgRI2XYDc1sodJgjuNSuUr8G0bU6q37w9yctjRuPIr//WbBC9uKclLPSFej5pce
 G82i22/O39T5zbp/MFcHytLXLMKHeiaOacWNBSfoiw6u0KeWof0pHBXdKHbGSqQAicTtxolfH
 vYHfdNCG3tD7g10vxsEevP2KVICK+RGowentPPlw+wsNtXvEMo8JphJG5Po2YXv6rVnNk3Wyr
 XbpCDJetmpgkwBqQ8ISA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 8, 2022 at 11:56 AM Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Add Nuvoton BMC NPCM845 UART support.
> The NPCM845 uses the same UART as the NPCM750.
>
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>


This one should no longer be needed if the timers are compatible with the
old ones and correctly described in the DT.

      Arnd
