Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D5158DDCB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 20:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344162AbiHISGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 14:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344672AbiHISFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 14:05:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF2827CEA;
        Tue,  9 Aug 2022 11:02:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 649EEB81722;
        Tue,  9 Aug 2022 18:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D78C433D7;
        Tue,  9 Aug 2022 18:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660068148;
        bh=lJgNFnKBAD3W6+nMLS3KtRGHN5jjeaSLik2catrtBLQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=EVR37ynfgVxGgjgEcwtYqTtzrPixXH1kEcatTawE2JTaQLXiYyQYFS0BBFgeu+h8v
         EZPPjLlL/PYOBVCfiH6txoSdeeTnHfasPst7YWKv2JM/YJ4GYmcU3rR37gYXoG6T8G
         tP3gn/ge/WhxnN44ArX0nXU7HFUhS3tkP4Zx6HylJl5+wXPeC49Wp/ofPrRlTGdNNQ
         CUQ1VOZ0EcrHZIDDngG6IXDCLZo9KD7Y73NN7nfVNkqbmKCVH7EvYpfFwnsb1DQ10F
         j2JbGFZ3NV0Bqz36vvyXli++/yhGzj4O+GzL4xloblwzImWisqCTTFFhT3W0ST4dWB
         IuAaqtX+CtyuQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAP6Zq1ib==k_E3XaS2bZB3m=yn0B_3hL2XuaHe1UiyM670snoA@mail.gmail.com>
References: <20220711123519.217219-1-tmaimon77@gmail.com> <20220718191454.5B5D3C341C0@smtp.kernel.org> <CAP6Zq1ju08GSjNnEG+zDUC8W6aQMJxd5He7QJxy9++hTy0Dc7A@mail.gmail.com> <20220723030226.8E43CC341C6@smtp.kernel.org> <CAP6Zq1gUvMFG9BNObVNLpVgbMRpV7e--HFxknP8kvL4nGk8Hsw@mail.gmail.com> <20220729225603.12528C433D6@smtp.kernel.org> <CAP6Zq1hOxG+2X-qTbvPkrVHQ5zf04GO21m1n328Jiqgzns2CMA@mail.gmail.com> <20220804200549.60512C433C1@smtp.kernel.org> <CAP6Zq1j2r9df0CpT7pi32JuVLQBDjt7cCK7LmDJehtufG8M4-Q@mail.gmail.com> <CAP6Zq1ib==k_E3XaS2bZB3m=yn0B_3hL2XuaHe1UiyM670snoA@mail.gmail.com>
Subject: Re: [PATCH v8 04/16] clk: npcm8xx: add clock controller
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Avi Fishman <avifishman70@gmail.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Olof Johansson <olof@lixom.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Robert Hancock <robert.hancock@calian.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Tali Perry <tali.perry1@gmail.com>,
        Thomas G leixner <tglx@linutronix.de>,
        Patrick Venture <venture@google.com>,
        Vinod Koul <vkoul@kernel.org>, Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Nancy Yuen <yuenn@google.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        SERIAL DRIVERS <linux-serial@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Date:   Tue, 09 Aug 2022 11:02:26 -0700
User-Agent: alot/0.10
Message-Id: <20220809180228.22D78C433D7@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tomer Maimon (2022-08-08 06:08:08)
> On Mon, 8 Aug 2022 at 15:37, Tomer Maimon <tmaimon77@gmail.com> wrote:
> > > Using platform APIs means using platform_*() functions, not of_*()
> > > functions, which are open-firmware/DT related. Regmap can be used to
> > > operate on registers mapped as __iomem, which is different from platf=
orm
> > > APIs.
> > I will use platform_get_resource() and devm_ioremap_resource()
> > functions in the next version.
> I will use platform_get_resource() and ioremap() function next
> veriosn, is it fine?

As stated earlier it will work for now but eventually you'll get patches
from janitors trying to convert to a devm based API that reserves the
register region. Can you ioremap the register once and register an
auxiliary device and driver for the reset (or clk) part so that the
driver can be moved out to the drivers/reset/ path?
