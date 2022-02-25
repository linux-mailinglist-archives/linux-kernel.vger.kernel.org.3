Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD874C4F07
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 20:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbiBYTkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 14:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbiBYTkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 14:40:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1833B1AC2AA;
        Fri, 25 Feb 2022 11:39:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0B656159E;
        Fri, 25 Feb 2022 19:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB53C340E7;
        Fri, 25 Feb 2022 19:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645817988;
        bh=dr/LGzwnPRuzXSbna0Y4wy8djYkycn55PlWvYXXUX9E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cdSpauPh2MiuI/1MI8HjLstVTqjjSyRpak6c+qCOD+bNuFn1wFe+xaUQQOtsRQ3RI
         Xqvj25eez31AcfmW3z/yo6AnqTScwSGvxzXyy2TPDrv8dDgEYYDk40blWV9VylxceO
         Wmwvw1gb9FS4wOfnK5I9D3PYpK1PR23uq8xOIM1K3cQHqXzqpfyBwX2Sdc+KgsQZIn
         hKBn6DvLCWdOJjwv929EdkkdpQi90s4pqlFs72P3XeRz2SYYSLIRo8dsk6fibGtXzY
         c5I9p0AW+SXm5BohN+VpHLZaNoxZhGv5+aOtN/XMkOPjxKnj4Cc/UjMzx9tfUHj+52
         dR1zY5QxMrp/w==
Date:   Fri, 25 Feb 2022 20:39:42 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 0/6] serial: mvebu-uart: Support for higher baudrates
Message-ID: <20220225203942.43b9db04@thinkpad>
In-Reply-To: <20220225193229.f7uiv4o6br5xmyis@pali>
References: <20220219152818.4319-1-kabel@kernel.org>
        <20220225193229.f7uiv4o6br5xmyis@pali>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Feb 2022 20:32:29 +0100
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> On Saturday 19 February 2022 16:28:12 Marek Beh=C3=BAn wrote:
> > Pali Roh=C3=A1r (6):
> >   math64: New DIV_U64_ROUND_CLOSEST helper
> >   dt-bindings: mvebu-uart: document DT bindings for
> >     marvell,armada-3700-uart-clock
> >   serial: mvebu-uart: implement UART clock driver for configuring UART
> >     base clock
> >   dt-bindings: mvebu-uart: update information about UART clock
> >   serial: mvebu-uart: implement support for baudrates higher than 230400
> >     Bd
> >   arm64: dts: marvell: armada-37xx: add device node for UART clock and
> >     use it
> >=20
> >  .../clock/marvell,armada-3700-uart-clock.yaml |  59 ++
> >  .../devicetree/bindings/serial/mvebu-uart.txt |   9 +-
> >  arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |  14 +-
> >  drivers/tty/serial/Kconfig                    |   1 +
> >  drivers/tty/serial/mvebu-uart.c               | 596 +++++++++++++++++-
> >  include/linux/math64.h                        |  13 +
> >  6 files changed, 671 insertions(+), 21 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/clock/marvell,arm=
ada-3700-uart-clock.yaml
>=20
> Hello Greg! I think that this patch series has now all reviews.
> Could you look at it if you can finally take it? Or is there still
> something missing?

It was taken into tty-testing today 10:29.

Marek
