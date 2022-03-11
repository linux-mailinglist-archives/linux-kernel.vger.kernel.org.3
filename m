Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5D74D585E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 03:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345728AbiCKCym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 21:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbiCKCyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 21:54:39 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D34E190B4E;
        Thu, 10 Mar 2022 18:53:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4970DCE26D2;
        Fri, 11 Mar 2022 02:53:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75830C340E8;
        Fri, 11 Mar 2022 02:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646967212;
        bh=wT1pcZUk18cONswKQpNOup0p0atYyhyj3O67QRngiQA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=iTxvmR7zQv03MaVyuVhejaSp5W8iKYpXm/lRwqfUimTnbOY5xVBbFmHJSIMV29poE
         eYthba0KWKwMJKdfrEmO+gUuyFgf0VButOcG0I0P3BD4Ch1SRYDm4itJLOcxwrecky
         w2VZOJkQcsvdOEu/aFUcKOdBwGIihbIfz+0CZkL+6fPT22/bAPQm34FiEV0bSDv5dW
         0Y5s9dd7CrTY964+E2iMD1kRCbQkTyu4OC8d4Y0YUgOvZLDGcgemA+NsePIWqzoPCq
         oly+1Nn0yemvFVAK4gGXC0vUMdqsBNg4BMR5pr5+7rBGlh9C13UBZXb5sLCQnISQKm
         FEPgpRjgdoS8A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220126173953.1016706-2-kernel@esmil.dk>
References: <20220126173953.1016706-1-kernel@esmil.dk> <20220126173953.1016706-2-kernel@esmil.dk>
Subject: Re: [PATCH v1 1/7] clk: starfive: jh7100: Don't round divisor up twice
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Fu Wei <tekkamanninja@gmail.com>, linux-kernel@vger.kernel.org
To:     Emil Renner Berthing <kernel@esmil.dk>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Date:   Thu, 10 Mar 2022 18:53:30 -0800
User-Agent: alot/0.10
Message-Id: <20220311025332.75830C340E8@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Emil Renner Berthing (2022-01-26 09:39:47)
> The problem is best illustrated by an example. Suppose a consumer wants
> a 4MHz clock rate from a divider with a 10MHz parent. It would then
> call
>=20
>   clk_round_rate(clk, 4000000)
>=20
> which would call into our determine_rate() callback that correctly
> rounds up and finds that a divisor of 3 gives the highest possible
> frequency below the requested 4MHz and returns 10000000 / 3 =3D 3333333Hz.
>=20
> However the consumer would then call
>=20
>   clk_set_rate(clk, 3333333)
>=20
> but since 3333333 doesn't divide 10000000 evenly our set_rate() callback
> would again round the divisor up and set it to 4 which results in an
> unnecessarily low rate of 2.5MHz.
>=20
> Fix it by using DIV_ROUND_CLOSEST in the set_rate() callback.
>=20
> Fixes: 4210be668a09 ("clk: starfive: Add JH7100 clock generator driver")
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> ---

Applied to clk-next
