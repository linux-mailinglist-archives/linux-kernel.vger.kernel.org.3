Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA414A8618
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351149AbiBCOWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:22:24 -0500
Received: from mout.gmx.net ([212.227.17.21]:39987 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235184AbiBCOWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:22:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643898130;
        bh=s5TWocQnifuLlbQy45UKIXlTdxwlmwlpmSTvwvw0mHA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=jwL/VB9p0i/TJeBbTULlhzQtUe7cCb/q8Q0+dhgiUeMeJ93pW3pZZEpUGChzc7UOs
         wE0uVJglnRuPoZm0I0F+We4Go5kbK389qariL+nQhdKOTb+vKamFZU5l9HetBkHIUW
         9ukZ8Vgitpzvgc6n5z4vvQcLd7M1w1DmnYV9/9FQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([185.66.193.41]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8hVB-1nAyA432wL-004gDk; Thu, 03
 Feb 2022 15:22:09 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Mike Turquette <mturquette@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 4/4] clk: clps711x: Terminate clk_div_table with sentinel element
Date:   Thu,  3 Feb 2022 15:21:53 +0100
Message-Id: <20220203142153.260720-5-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220203142153.260720-1-j.neuschaefer@gmx.net>
References: <20220203142153.260720-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gAyEM69PgyfCPiDmJpqcef8sPklrNOg9HX/TNXJYBajcoyyfSlR
 oaOfjeh1k04n9IrDpnlxQZOxkxBy8bQ+0myStyQAxPoNOtRUdwSdiF2HxqtQ/HQ/NkoVgAd
 3ldCOrL7hThoCn9+iVHbKojNnprr4lEk79+t8quGzZxegUkSfglg1UNs0GWEjgI6PI6OhCM
 eX5lmhsQh2nz4PWUVOkHQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NYPg6mR/Ibw=:G80UHyYLkZ1XwFVfIMd3SU
 UoqmN52WNUhvx4VIJ9UeIOC6z4RArx/p2Z/Qrip5EZOlHxI0sAIkVLyzVTGdHjgrwbBIyilLN
 Pw1z8TmSel5wC63jASogVNsIrtfaxk2hJmeorMf/sUssppnH328utO/K4Zs03q2MNJJrElz0J
 x5jTvIMYCz6IUP1e/1NP8mYWJ/5pABN3fDxXXzz665a39qH/1iKlGH9WaCqNQrHd9TF/VWVOf
 7YCQRBLddY+bq8uVcLaB3jIScGgYqpt6lEd10kcmPPoXrTjTbRCszA8TQ0v7Y5I/nBmjQvEfV
 xPTPL5pRAE0NIAvM7yrxpU7b3aisnou7vCmM1p9rMKGpmj8ZcxiZ2hgCIq7/gES8VyB4FWWtW
 AE8RUQ59QpzYRjwj0YnD7N9jISJYOXHZT3ure7AM1Cvfeqy35/bGX0/XKjdjy/MITHF4+LyKB
 sMcHoE+wh+AGxL1YOT5nH4vtVRz8oLrtNgJkKOpwl3Yj3b8UugS2ZN8wQJOJbPPPsRdIagcl6
 HKpagFutWiPYE1Rb/05iUg3+Tg1RXLrVhAFgBkKjVvJKB/L9LyMN+kVb46Ta2KXn/lcP1AdDk
 5EVwkionVVKctSEXZscyuyqAEiSU2j4fKR5S/kdrHwc/I5bpox2U0afpX8luVRKFkRvBVyUV4
 tO+l6/XbrKH9qCUGIU7yQJsgcy9PSbt76QW757oGJn/jJbjvT3jHcgEN6QzOkT7rA9DYSSyIt
 RWldb5MVm/3+u5qt3KlUqZALu4ZRu5zP6Vr5Th7YVf1nawZ6dWHEH+YH51CqWuxOMqUDgQ3GT
 LH8V5lkQmIIMMl2C8vvPF1kM8DvEuMZ0AEWWu6xMd8YzA4L4waGeMYAdBqJHbtlyVi7uiVEzh
 OUyfQy2cWn/RzkOPQN9NSXk+6bJ7Gr2mpz/oqRYClxA3j3+JZpDmUA61cr/idEe7VePWSlZf/
 zbI5N6ZUwBcTkHeDUUXdWEyRwYw8hd0ZLnla/YdHcN4PAFJ0qbGcY1oWApu8RtYGm9gzU1Pw2
 uhaJxxTF6PjzKAjydWq0C32OHgVcdHmlGvmCJFkyXSP6dCDBkgqQKZEpZMdrkMI5qkC49F/on
 joLyE6dXBBXcog=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order that the end of a clk_div_table can be detected, it must be
terminated with a sentinel element (.div =3D 0).

Fixes: 631c53478973d ("clk: Add CLPS711X clk driver")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v2:
- Add Fixes tag
=2D--
 drivers/clk/clk-clps711x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/clk-clps711x.c b/drivers/clk/clk-clps711x.c
index a2c6486ef1708..d96d96c8752c7 100644
=2D-- a/drivers/clk/clk-clps711x.c
+++ b/drivers/clk/clk-clps711x.c
@@ -28,11 +28,13 @@ static const struct clk_div_table spi_div_table[] =3D =
{
 	{ .val =3D 1, .div =3D 8, },
 	{ .val =3D 2, .div =3D 2, },
 	{ .val =3D 3, .div =3D 1, },
+	{}
 };

 static const struct clk_div_table timer_div_table[] =3D {
 	{ .val =3D 0, .div =3D 256, },
 	{ .val =3D 1, .div =3D 1, },
+	{}
 };

 struct clps711x_clk {
=2D-
2.34.1

