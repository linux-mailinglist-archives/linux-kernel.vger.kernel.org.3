Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4778657A211
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239107AbiGSOoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239727AbiGSOoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:44:03 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46851422FA;
        Tue, 19 Jul 2022 07:42:09 -0700 (PDT)
Received: from mail-ua1-f43.google.com ([209.85.222.43]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mr9OA-1nhHPV1uOE-00oJkN; Tue, 19 Jul 2022 16:42:07 +0200
Received: by mail-ua1-f43.google.com with SMTP id g12so2945884uan.6;
        Tue, 19 Jul 2022 07:42:06 -0700 (PDT)
X-Gm-Message-State: AJIora+RwN51PRsMVLOiKxs3M4VkEGy8el/EcQJ5Mw2oskYMEGFHbKoG
        fqxQQABAc4cxxFWfdYt7sNzFXzIBKnO3JPmRUW4=
X-Google-Smtp-Source: AGRyM1sQikcKoGgAT6yV2vJ17SN926DE+GHt8PDGByKcXd/T2/q6CdAznJd8BVDLz6eMRl5ZCzsdNoH8O58apFp22kQ=
X-Received: by 2002:a25:808c:0:b0:670:7d94:f2a with SMTP id
 n12-20020a25808c000000b006707d940f2amr4885533ybk.452.1658241714958; Tue, 19
 Jul 2022 07:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220706165406.117349-1-tmaimon77@gmail.com> <CACPK8Xd0n5cpsCJ6guPzEj8JfXkz_ERzU3VdXW-Xx2QX8ssNKg@mail.gmail.com>
 <CAK8P3a0Ojf1hm5Q2FJZEGLygku+qkPmKnKpBD8eAZPeRZtb=gw@mail.gmail.com>
 <CAK8P3a3Dh+wTyPYhvv5c-wsqMK24ZgqPWHw2C7xuFh9vL53XfA@mail.gmail.com> <CAP6Zq1iCai5hSWVyeMg+xcgBXj0mdq7mcQrQfNmDFh15Q2y_-g@mail.gmail.com>
In-Reply-To: <CAP6Zq1iCai5hSWVyeMg+xcgBXj0mdq7mcQrQfNmDFh15Q2y_-g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Jul 2022 16:41:37 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0N5J+jc2xL+J6bc-GD5R4f1aY3n+GMAq_7Cejc4w5Opg@mail.gmail.com>
Message-ID: <CAK8P3a0N5J+jc2xL+J6bc-GD5R4f1aY3n+GMAq_7Cejc4w5Opg@mail.gmail.com>
Subject: Re: [PATCH v7 00/16] Introduce Nuvoton Arbel NPCM8XX BMC SoC
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Olof Johansson <olof@lixom.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vinod Koul <vkoul@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Robert Hancock <robert.hancock@calian.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Qin Jian <qinjian@cqplus1.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:PNYrzzlDmg3qAHx8zGYAEK2JcwcgSuFZf2gzdx0wVncnRCBaCkM
 i8Oy58GX+zBIh9UlXw/YuQTnGkNX3PqKxyyhNwZjBqNdpW8c/XYVFp6LRnmdhIvcw4fxOv8
 6pCe9yjPDDrqVVdaJCsbegjBe4kA9hsNEh82Ei3NytAlCTiVRwQarJwawn+eJKgidQK7+QF
 HIOKs/OCh0JImqjVkb/IA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hX3CbiXRCL8=:Nsay3/HZRmMYxdmQwIxQhK
 ar20KniwvKgK7Q/nZD+LShJRpNy5MNJJAPF0YFQuMzyIKu/Ti5hVK5UHqH6JeYOVP7HDwrI6C
 ecP0LYMr4d5OqKeq1L/NP1SOvlb907saKiXkXE2uJRIYBzocNlEnMcocAP1uYODInW6vr4uvK
 v7XioEm5tzvpRkob2IBJBowMRlmJeWptBL8PLYAUOl35MUyXU0THvzjla0iu5zJ8ygSLhXJBY
 V6V1AiB80wjh8LQJvSYlD4QCOy1kCbeGn2s1utNgutMFkihNKmAPslXOKTqvJne9+hleP5bYD
 O2lsvv/qJTbxy0T4TM1SKs3Z/Zu3EIDsWQc7+Vxqf+epy7X39+h1b7D256PL+W3LR2lz1O6ns
 Sm++uMsdkVu03ELjtEQF2JabFbHt4U7GyhkXEfjNhQaewOKu4H7UwerPL8oA48HWkEa/324BY
 nAHS7fnvgN8YISvFFXxoouNA2r8j2QbjbuxjSecO2SDED7moz5ODqZAYGyj5coONoEyo/oZ5n
 jhO/0vrd5rFJnz9m4Z1sYtji0KLD8mT6IDu4IVLbxZCzOdumgW7nq4PY0I5P7ZBmYHw2K4s/L
 qYcVeAojxOzf8JcusRoeBHwnHoxUBV9bHhRo7/+Y/uRHHVFt/vRziCqFeepmg1LVJDMV1wKt1
 qNJpGLa9uyl4at6Nm7GWA1vpFeV2fBzc9ZFPu01MrSkBI0bZc9+FvwljGTIqxqBMl08UDpvfB
 OW0K6UCzp30OW1jAz/oi+3Z063Kid5F6oT9EwVNuSB3UKAFeIKlOBDNcEQyot1xcGCDcERRi8
 CR+RWRfkrcTdcHen7wx5eNcP3ykejiaKJQJgIJXSXDgjzq8qjZX0g/b2X7wTDB29HLCOoQNXQ
 l2rFZJVXDvv6ikv8ZbJQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 3:12 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Hi Arnd,
>
> Appreciate you taking care of this!
>
> Are these questions direct to me or Joel?
>
> On our side we will be happy that you will start to merge Arbel
> NPCM8XX without the clock driver, hopefully the NPCM8XX clock driver
> will ACK soon and maybe you can merge it as well.
>
> What do you say Joel?

As discussed off-list, I have now merged the series into the soc tree
as part of the arm/newsoc branch directly, with the exception of the
clk driver. No need to resend the patches I merged for future versions,
if any changes are required before the merge window, please send
them directly to soc@kernel.org.

After that, it's best to continue working with Joel so he can merge
and forward future patches.

Regarding the clk driver, please make sure this applies cleanly
on top of what I just merged. This can be applied to either
the soc tree at the moment, or the common-clk tree in the
future if it misses the merge window.

      Arnd
