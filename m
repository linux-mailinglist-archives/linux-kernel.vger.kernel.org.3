Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBB346792F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 15:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357792AbhLCOPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 09:15:54 -0500
Received: from mail-4018.proton.ch ([185.70.40.18]:40797 "EHLO
        mail-4018.proton.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbhLCOPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 09:15:52 -0500
Date:   Fri, 03 Dec 2021 14:12:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wujek.eu;
        s=protonmail; t=1638540745;
        bh=o4WyFWh7JuWwZ/Mqq+iDh7Rd1ojXp+gx7VT03s0CIPY=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:From:To:Cc;
        b=qH59D9CnADsjHUxAuCqCyBbzx/8mNeN9PBGR9dwRlK5i6rW6BaxhjBD27FuaNwewF
         zdv0K1bb5sKZ6UuYaafy1r2VLncXrYU4yX8lTk2OVHMOFR4v10G9ODqjyq5Cwz2ZKc
         Pg7n3RCyCH1JKGyVsHsZgR3sz4tU1ymKbzg/6rll+aAcGcpZZQ3ryW8RsUE+WNYN/7
         pv0PNYUDWtNr0wCtScuNEwlB9xVy/+wC6cIvTl2DDxBTLg22+kOcBEk3P63aHoS4pY
         X0PyXfOsC5w9R2mVDN3qe/vTr2HlRiy1YBPIbp5siGX7yDchCqgJQ8rM7Lc9loiVSh
         sjJz/eZTG4TPg==
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
From:   Adam Wujek <dev_public@wujek.eu>
Cc:     Adam Wujek <dev_public@wujek.eu>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: Adam Wujek <dev_public@wujek.eu>
Subject: [PATCH] clk: si5341: fix reported clk_rate when output divider is 2
Message-ID: <20211203141125.2447520-1-dev_public@wujek.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SI5341_OUT_CFG_RDIV_FORCE2 shall be checked first to distinguish whether
a divider for a given output is set to 2 (SI5341_OUT_CFG_RDIV_FORCE2
is set) or the output is disabled (SI5341_OUT_CFG_RDIV_FORCE2 not set,
SI5341_OUT_R_REG is set 0).
Before the change, divider set to 2 (SI5341_OUT_R_REG set to 0) was
interpreted as output is disabled.

Signed-off-by: Adam Wujek <dev_public@wujek.eu>
---
 drivers/clk/clk-si5341.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk-si5341.c b/drivers/clk/clk-si5341.c
index b7641abe6747..15b1c90cafe5 100644
--- a/drivers/clk/clk-si5341.c
+++ b/drivers/clk/clk-si5341.c
@@ -798,6 +798,15 @@ static unsigned long si5341_output_clk_recalc_rate(str=
uct clk_hw *hw,
 =09u32 r_divider;
 =09u8 r[3];

+=09err =3D regmap_read(output->data->regmap,
+=09=09=09SI5341_OUT_CONFIG(output), &val);
+=09if (err < 0)
+=09=09return err;
+
+=09/* If SI5341_OUT_CFG_RDIV_FORCE2 is set, r_divider is 2 */
+=09if (val & SI5341_OUT_CFG_RDIV_FORCE2)
+=09=09return parent_rate / 2;
+
 =09err =3D regmap_bulk_read(output->data->regmap,
 =09=09=09SI5341_OUT_R_REG(output), r, 3);
 =09if (err < 0)
@@ -814,13 +823,6 @@ static unsigned long si5341_output_clk_recalc_rate(str=
uct clk_hw *hw,
 =09r_divider +=3D 1;
 =09r_divider <<=3D 1;

-=09err =3D regmap_read(output->data->regmap,
-=09=09=09SI5341_OUT_CONFIG(output), &val);
-=09if (err < 0)
-=09=09return err;
-
-=09if (val & SI5341_OUT_CFG_RDIV_FORCE2)
-=09=09r_divider =3D 2;

 =09return parent_rate / r_divider;
 }
--
2.25.1


