Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1ACC55E60C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346992AbiF1Oi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346102AbiF1Oiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:38:55 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5232873F;
        Tue, 28 Jun 2022 07:38:54 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7626510000E;
        Tue, 28 Jun 2022 14:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656427132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WsNOELfNmIxzQ7L2JBSj8agbCQSyUjW6SfWZR6bYZWA=;
        b=mGygbv+Beb+GbEw5LbZy//jxGsgoZZ9PrMfy6SH6QiLzOpVhEf1cCZbYpcj7lRU4ftC1QY
        qe25Dqe754qKebRkedmmxMqFxiiWV/Vcp1+KDif21GKvgtsr9h7WgtK9Qpf0Dkp/YdwqUq
        8KhOm/c9ljtLFqAHfHZz9qu/vH/ICLODzjnqCxkaK1qsRwIgsH1foh35qAXdIuWmVpwyYI
        SctsafuGYgLaZfFKjzi8yr+stqR6Ma/mwt7yTtqQFszxBQDTP76gdYKpw500xCXG/2MZV9
        OSDUiBaEI1bou1zGrOBYw/y1KvcdB+sP+6oJLQEGehErmvx6p65lKDHa1UKjCw==
Date:   Tue, 28 Jun 2022 16:38:50 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tlanger@maxlinear.com,
        rtanwar@maxlinear.com, richard@nod.at, vigneshr@ti.com
Subject: Re: [PATCH RFC v1 0/8] intel-nand-controller: Fixes, cleanups and
 questions
Message-ID: <20220628163850.17c56935@xps-13>
In-Reply-To: <20220628112731.2041976-1-martin.blumenstingl@googlemail.com>
References: <20220628112731.2041976-1-martin.blumenstingl@googlemail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

martin.blumenstingl@googlemail.com wrote on Tue, 28 Jun 2022 13:27:23
+0200:

> Hello,
>=20
> I am trying to replace the xway_nand driver (which is still using the
> legacy NAND API) with the intel-nand-controller driver. The Intel LGM
> IP (for which intel-nand-controller was implemented) uses a newer
> version of the EBU NAND and HSNAND IP found in Lantiq XWAY SoCs. The
> most notable change is the addition of HSNAND Intel LGM SoCs (it's not
> clear to me if/which Lantiq SoCs also have this DMA engine).
>=20
> While testing my changes on a Lantiq xRX200 SoC I came across some
> issues with the intel-nand-controller driver. The problems I found are:
> 1) Mismatch between dt-bindings and driver implementation (compatible
>    string, patch #1 and patch #4) and hardware capabilities (number of
>    CS lines, patch #1).
> 2) The driver reads the CS (chip select) line from the NAND controller's
>    reg property. In the dt-bindings example this is 0xe0f00000. I don't
>    understand how this can even work on Intel SoCs. My understanding is
>    that it must be read from the NAND chip (child node).

Yes

> 3) A few smaller code cleanups to make the driver easier to understand
>    (patches #5 to #8)
> 4) I tried to understand the timing parameter calculation code but found
>    that it probably doesn't work on the Intel LGM SoCs either. The
>    dt-bindings example use clock ID 125 which is LGM_GCLK_EBU. So far
>    this is fine because EBU is the actual IP block for the NAND
>    interface. However, drivers/clk/x86/clk-lgm.c defines this clock as
>    a gate without a parent, so it's rate (as read by Linux) is always 0.
>    The intel-nand-controller driver then tries to calculate:
>      rate =3D clk_get_rate(ctrl->clk) / HZ_PER_MHZ
>    (rate will be 0 because clk_get_rate() returns 0) and then:
>      DIV_ROUND_UP(USEC_PER_SEC, rate)
>    (this then tries to divide by zero)
>=20
> Before this series is applied it would be great to have these questions
> answered:
> - My understanding is that the chip select line (reg property of the
>   NAND controller's child node) refers to the chip select line of the
>   controller. Let's say we have a controller with two CS lines. A NAND
>   flash chip (which a single chip select line) is connected to the
>   second CS line of the controller. Is my understanding correct that
>   the NAND chip device-tree node should get reg =3D <1> in this case?

Yes

> - Who from Maxlinear (who took over Intel's AnyWAN division, which
>   previously worked on the drivers for the Intel LGM SoCs) can send a
>   patch to correct the LGM_GCLK_EBU clock rate in
>   drivers/clk/x86/clk-lgm.c? Or is LGM dead and the various drivers
>   should be removed instead?
> - Who from Maxlinear can provide insights into which clock is connected
>   to the EBU NAND controller on Lantiq XWAY (Danube, xRX100, xRX200,
>   xRX300) SoCs as well as newer GRX350/GRX550 SoCs so that I can make
>   the intel-nand-controller work without hardcoded timing settings on
>   the XWAY SoCs?
>=20
> Due to the severity of issues 2) and 4) above I am targeting linux-next
> with this series. In my opinion there's no point in backporting these
> fixes to a driver which has been broken since it was upstreamed.

The changes look good to me, please resend with the bindings file name
fixed and we should be good.

Thanks,
Miqu=C3=A8l
