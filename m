Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459754AA52E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 01:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378829AbiBEAwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 19:52:55 -0500
Received: from mout.gmx.net ([212.227.15.19]:33393 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378804AbiBEAwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 19:52:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644022357;
        bh=lym5STbBzaJGlQM8oAKh6+HRTeRDIEflWWq3ZRpveqA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Hz/patMlWit9iSO4qIwoDtKnDyrt9JtB4Vf06FOsXWYIbAdbI+DFomvXsaT/2IeaO
         8FUmTxFPm2uSg3QMWvYXWpsxt+e0CPAkTW50CCIySv4l0c7j+4BvsvZgoY4B3Jjvyx
         44zVpStWgHXnzEWrsdjkR/jaiTEocSzXyvOd9nxU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVvPD-1moLZJ46tR-00Rr9g; Sat, 05
 Feb 2022 01:52:37 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Yang Ling <gnaygnil@gmail.com>
Subject: [PATCH v3 2/4] clk: loongson1: Terminate clk_div_table with sentinel element
Date:   Sat,  5 Feb 2022 01:52:29 +0100
Message-Id: <20220205005232.772726-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205005232.772726-1-j.neuschaefer@gmx.net>
References: <20220205005232.772726-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:npiPhZZ/O3sp6o2Yhb9joakGAZKVj+KAXxOrYSF0XvLjcWIJzmt
 aiZPe/C6G1f8GX/qmelbAao26MSb63BJ/FIid7cHUtBVsi3tRIJiw0O1o3ZvbtG1tUL8TMX
 YsGiqFCLiIlMSY/QX1iD3xSDGkm647F/J7CBp0BhtUi3knyOe3zxVViQL/ABcy6RM8kJd8Z
 XWqmzoURL8yJTIheuPqOg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mCDPUqM3rCU=:YmUKPe5K+VBUDhkb6htAUh
 l6HPEyc+V8ecrFnALrs3Ih3ylMNFfGc2XX4ofyJXPlQeGgvIQrvDNBNEqxcu5gjXmvbwoomO4
 dC5jNPszJDcz3hfAJ62snarX7hAujVMwMhnl6cYXzKqUh9dU7Dqu8PhTdouUwiCvHL4Fk/n/B
 aL6gYlW4b1OyvnAMFyVqNFG6mEiZnNxsN6SklEoEhjZJYkdjXDKvhHGX6ugqvzn/62cFIl3To
 rOKnuqj6FdjD0UIck5hCjJ4yueIrUmr+0BZ4A7y84CZNjKPb1hZP1deiaMvuqKH5CX2fi6uy6
 mpoJmBdurE1N4WcjfM9Xd/NOOuh8H1jXivgvWpsHuKH+svMWSao7lOiQbZr0u66VaY8NIz7AB
 sc3U9ba6hvkBG/hZBxPVnwoj85YuSjjT/b8aXGqlEyy5wmkfxPsA81SbICE4XyTNNH1jptB5y
 MccgmzzKSecIKrVzaOVV7fcZHYiqnkm37ro7Cl/GcWFNySNUto2c8K9MNhLiPchm8COoodjp6
 lVpJsmMP6fvo/e30RuBY5Jj+fqQ+hkFAhBtuFdz1ZeSn4ZZ8z+ztYS1jZz8BJdE+BoMNqr/9B
 EYKyuYvsBXqnzsC08FryeQkQ86VVmcyraF50+7BHkjARGSj2qZ9kMSd9Mv2GQrmiWtn46Y9Ve
 c/ZbXpxBVjAyOGTL4/dtvfM86Pb9edUpiAgqFmF/g14LICPeWR1Ag1ijplrASmAJJ24Coxuwh
 tVCqfXPv+J+qHQavu7cZ0l6D3a5EX8DY2sxRoXa2BOSRJ26ML/iii+6F2vGsGxF7hc7n8AaOr
 uUPbuar8hMbGHepBe8AhPXG45FtpcuYCviVA2Lq2Zi1hLJl94LpHT27RcAUu+WWt0oXX09sya
 G4JK4Nl1WRXeNacOXAEWLiGawzQQEAo6Pn2JcvyvE4TEYvgN1FdmOWxDhfX/LKC9uhOBD13FH
 GqEFX//Inyy0SzslcrDAvQxamZcZAr42heDoQpZrf3dnJyW3psy/+PwqRsMp7cLA00G8W60dC
 exDdw50XGtujN7j/hy0d2Ru030nfPg6e+gOCSz6wIls2F2+nyDC7Rn/ipO9o3csSs6VoOFY3C
 RVBsDrIBIuJrV8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order that the end of a clk_div_table can be detected, it must be
terminated with a sentinel element (.div =3D 0).

Fixes: b4626a7f4892 ("CLK: Add Loongson1C clock support")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
=2D--

v3:
- no changes

v2:
- Add Fixes and R-b tags
=2D--
 drivers/clk/loongson1/clk-loongson1c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/loongson1/clk-loongson1c.c b/drivers/clk/loongson=
1/clk-loongson1c.c
index 703f87622cf5f..a6f9f20fc8b99 100644
=2D-- a/drivers/clk/loongson1/clk-loongson1c.c
+++ b/drivers/clk/loongson1/clk-loongson1c.c
@@ -37,6 +37,7 @@ static const struct clk_div_table ahb_div_table[] =3D {
 	[1] =3D { .val =3D 1, .div =3D 4 },
 	[2] =3D { .val =3D 2, .div =3D 3 },
 	[3] =3D { .val =3D 3, .div =3D 3 },
+	[4] =3D { /* sentinel */ },
 };

 void __init ls1x_clk_init(void)
=2D-
2.34.1

