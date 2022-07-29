Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D273585702
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 00:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239566AbiG2W4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 18:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239413AbiG2W4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 18:56:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E741E89A7C;
        Fri, 29 Jul 2022 15:56:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8905BB82A02;
        Fri, 29 Jul 2022 22:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12528C433D6;
        Fri, 29 Jul 2022 22:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659135363;
        bh=zk29gmNkOWKkDPAyPj1KjLUZzxwFt6lvMvWIi2eO2Lc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=QfcqUVGobKwRR3DAPC3w8Y/kVCpprAGZdplH6sAVBNMroIEmwLYn9rQ2TUd+lg4x7
         jkTqCFSFnU+THaJGobcDJ0gav0im3GXsUM5hrG4Z3UaD2HfBBLT5LENuAs3gkYFCKd
         MqO3B7iD1p5gxL9cGRphF5rzi27JXEErT+flJzx+vlX0XjXx2dUmFeFVZdsmNO4dAr
         7o+GXFViDrxwcDMM19aeb8JVsHTNFl+vjJzIQxdKbsBz8+CY+0wX7T4BolRiNJ0c3p
         /FJ6w6TBUItx3/TaF1kitcByu4ufl2RUZUJasoEBGlx/IvP2/nADsB7hMGK3b5VaAK
         7o68VE9qS5kpg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAP6Zq1gUvMFG9BNObVNLpVgbMRpV7e--HFxknP8kvL4nGk8Hsw@mail.gmail.com>
References: <20220711123519.217219-1-tmaimon77@gmail.com> <20220711123519.217219-5-tmaimon77@gmail.com> <20220711195544.70A30C34115@smtp.kernel.org> <CAP6Zq1ie_RgJ_9S3ftoVJ=eJHX1xR4_O_czKZghNPKVEFOzC8Q@mail.gmail.com> <20220718191454.5B5D3C341C0@smtp.kernel.org> <CAP6Zq1ju08GSjNnEG+zDUC8W6aQMJxd5He7QJxy9++hTy0Dc7A@mail.gmail.com> <20220723030226.8E43CC341C6@smtp.kernel.org> <CAP6Zq1gUvMFG9BNObVNLpVgbMRpV7e--HFxknP8kvL4nGk8Hsw@mail.gmail.com>
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
Date:   Fri, 29 Jul 2022 15:56:01 -0700
User-Agent: alot/0.10
Message-Id: <20220729225603.12528C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tomer Maimon (2022-07-24 02:06:54)
> On Sat, 23 Jul 2022 at 06:02, Stephen Boyd <sboyd@kernel.org> wrote:
> > Furthermore, in DT, reg properties aren't supposed to overlap. When that
> > happens it usually indicates the DT is being written to describe driver
> > structure instead of the IP blocks that are delivered by the hardware
> > engineer. In this case it sounds like a combined clk and reset IP block
> > because they piled all the SoC glue stuff into a register range. Are
> > there more features in this IO range?
>=20
> No, this range only combined the reset and clock together, but it
> combined in a way that we cannot split it to two or even three
> different registers...

Because it is jumbled in some range?

>=20
> I do see a way to combine the clock and the reset driver, the NPCM
> reset driver is serving other NPCM BMC's.
> Should we use regmap to handle the clock registers instead of ioremap?

Sure? Using regmap or not looks like a parallel discussion. How does it
help use platform APIs?
