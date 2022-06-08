Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B0B543272
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241262AbiFHOXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241217AbiFHOXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:23:42 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFCD3EAA1;
        Wed,  8 Jun 2022 07:23:39 -0700 (PDT)
Received: from mail-ot1-f51.google.com ([209.85.210.51]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MFJfN-1nwzNb2gEz-00FlZo; Wed, 08 Jun 2022 16:10:58 +0200
Received: by mail-ot1-f51.google.com with SMTP id g13-20020a9d6b0d000000b0060b13026e0dso15182192otp.8;
        Wed, 08 Jun 2022 07:10:57 -0700 (PDT)
X-Gm-Message-State: AOAM533LIUmsm9H3Oclhp+0JrCNN0SnsNPvBkfUnyChgHsXTQ3vpfWxU
        tgtQLLcJcIOXrI4k0jyn0vbkfjw820R/YHO48s0=
X-Google-Smtp-Source: ABdhPJwBT4Iode5kOKhC76/FZM6vkNDd0mUj8egQXTxe3D51vB8jwlVp5dbu3aMS3GpdoWhsQFTccyumCawBGfz8KvY=
X-Received: by 2002:a25:e64b:0:b0:663:ffad:eac5 with SMTP id
 d72-20020a25e64b000000b00663ffadeac5mr3074976ybh.550.1654696033002; Wed, 08
 Jun 2022 06:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220608095623.22327-1-tmaimon77@gmail.com> <20220608095623.22327-4-tmaimon77@gmail.com>
 <CAK8P3a1fDDk2kWMoxFjxoZT6dD5vfNzmNO+sMhV-GrZkpGkPow@mail.gmail.com> <CAP6Zq1hxjDvzkwt3Jf7DVM_iB4EeYBdb3RzjjAjyr5mhD9==Lw@mail.gmail.com>
In-Reply-To: <CAP6Zq1hxjDvzkwt3Jf7DVM_iB4EeYBdb3RzjjAjyr5mhD9==Lw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 8 Jun 2022 15:46:56 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2bjvLaVTcpPNe0D72KGf7ScYAy2mwjd1YzUnEzQvFMmg@mail.gmail.com>
Message-ID: <CAK8P3a2bjvLaVTcpPNe0D72KGf7ScYAy2mwjd1YzUnEzQvFMmg@mail.gmail.com>
Subject: Re: [PATCH v2 03/20] tty: serial: 8250: Add NPCM845 UART support
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Avi Fishman <avifishman70@gmail.com>,
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
        "nathan=20Neusch=C3=A4fer?=" <j.neuschaefer@gmx.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:IvI6t25nEeC7uQyVShm8Xea/jy+s3Ia7twmziy0F3KXXxZyMY2g
 Om30T+nymXvHEE5XGhWbm3ydgVzPssF30UgMfFvwlfg1t+J+zBpKgVSqaFnHLEOsoKlDjPX
 mtrD048yFgRAXfKpGch0FgvHi4jY+2LLS67Am9ECqOsxxZ+2p7Qmgs4rVrfcOh0WBOm9oAo
 LSL9pg6m4fVati5/eGX6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4B3QsBhfvQk=:72Po+NrhmMPtafCLD97ceq
 rWExdYzhSn1FoaOxH1lI1sd3XgPWv27bi7KRxOJaMLM8LPhC/Zvkj3drYFrpFxjDxPp1cyAZW
 ijLBeJ7w94ka1j+5L0b81Xr+TTirWmisu0QiS2DxOxTmJchwNAgVMqczgHFM8ZpLZmV5KgcZ/
 YnN5ASgoV6EbEYhO0Y7xkyAY4+v8vFgwizwnge628dUTd2mLPVTEDH5/AlNExEobgAH6nkkq4
 klbyKT0GUKGabQav0i5f6ZRkCSMFSdwhve2YL9d1gQRDgKENbBfhZQ27upRuj0vuC8xi/9xzG
 W5cB3opJd7Aa8ClCrP8o8joaXVfrYdzAMJ4VTFssRDnH1jyAZMjk0XTxejnI/wF82nd9/j53u
 baqN+LKNMPlDyD4JY+CQCH2jiF+pk4UPTDz3mFj6UfFl+1sqbDlN9iEnaquJF9Npy4VCjunhN
 6rwd/9gbwZYOEZkYUmCdsNV6QeCK+aSZ0fQ/GGEFp+SBLiqWg/Vj/fOnv/WDlznc+nBaKUomM
 4/9zo8jnhRYAu+ivyHB70tliY3ICSh2jRE7JjN5IzCkqyLip8IZFLdOlZivOx88dSa60M7Pdl
 CCVYHt3RMvMldEbH+XuGOHEgLPAGiqTZryaRpSicOeTEBc/5lHhHwgvqW+P1M3vAPcmMr9axd
 paNsRB1MfgRyxDffDLp03rH9BNBdnH9QijyHRqWSvbwO7cVdgenCyXpU5KFvO6aIcgMSeNcBg
 N1lpU0wT4J2tiE4/cQ/CYDl8UNemDdCcOr4wo3hiB737MWGSukPEWGq+zKiLiSYjplwJn4uTr
 7SGlPusJGQJFpnw2J8v90s22O8bcw5RaDVZcBlZL8U2dJ8tG92jAiUurWpyc4vtz0ZDdyez5O
 giy2ak4nbaFYK1Q9NoEw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 8, 2022 at 3:40 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Sorry but Just to clarify, This patch should not be applied and the
> NPCM8XX UART should use nuvoton,npcm750-uart compatible in the device
> tree?
>
> Because I thought that in your comment a few weeks ago
> https://www.spinics.net/lists/linux-serial/msg48179.html
>
> We need only to modify the compatible string in the device tree as we
> did in V2 patchset
> https://www.spinics.net/lists/arm-kernel/msg986480.html

Yes, this is correct: with the DT file from v2, the driver no longer needs to be
changed, it will just match the fallback value.

       Arnd
