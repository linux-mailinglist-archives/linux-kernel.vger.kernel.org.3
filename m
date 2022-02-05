Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CED4AA52C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 01:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378847AbiBEAw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 19:52:58 -0500
Received: from mout.gmx.net ([212.227.15.15]:37127 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378821AbiBEAwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 19:52:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644022365;
        bh=sih0C9j+Skh+Iygcka4TI9uLM35zlkT/bJ3P6AAoP4s=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ArCdDHDNPjq5S6JG8DwnGdtNk7/AObqFNvc/dfj+iA8wU6NQRQ3o0RX7pdEZEqMBB
         WUq4cc1EFgtOb4hASA3VVRkc2NZ8rXcwcM6PJUHApZSNiv7Via60P2t4xRGt7THyON
         1Q+rNwyQdenrA+SDQDWVROuZUjAcjzu0sHs3idmk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MF3DW-1n0nFF0aVc-00FPzJ; Sat, 05
 Feb 2022 01:52:45 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Arnd Bergmann <arnd@arndb.de>,
        Mike Turquette <mturquette@linaro.org>
Subject: [PATCH v3 4/4] clk: clps711x: Terminate clk_div_table with sentinel element
Date:   Sat,  5 Feb 2022 01:52:31 +0100
Message-Id: <20220205005232.772726-5-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205005232.772726-1-j.neuschaefer@gmx.net>
References: <20220205005232.772726-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+5sqN1NQdxdcUbRRd06FLeYyXi4FGGlmCXSn1bq0vyEbH2GQK6k
 bl1TYLc9US7ekOSTBfxcJ3rRwiaKuN6P1XkdCxlFs7D2/k7ThOpD1GLzRJIwlKsGWuk9CWT
 hChHeYaUiWwb+h04wPjv2uKl06n0mZKyJ8lZxGZv7E+seBrQPDmT2LOIbpQQxWa7aMMF45E
 GRHYH8RSlI1bS6/zbRWLg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tZkDayIuqb4=:eEicf82nMKSeBkY7O1GHXE
 HHXII8ZGGdKNnXtoqbt9PF26lxVpXOg/PkYbUFWe4KSWuNvR61ZNKAq0KFRbKEU5T81KCarHm
 pzzHEbkU8uhJWieCWamE9l2v6Ua+1r4zO7PMfpAK+d1yvAWQxGAsWuC84L8/w+6BzhM6kT9QK
 7ViRwmI/kbqihnvpRV/lCVuTdFaKq7KPhT7mPxwVtwSK3jFk3JpGOqbvh9MRSJmQKwfmcaXaL
 cHKC4oZ2HMTl4qralxvQIUwDOf+5paYJG/nijQCBS3g44bUsVEBfdXKNzjPSUHFlWPplGpi2u
 zSXLK1696aZv6kkKu2BaKmaIuBjXY/qz+B0sqeyruiHAU/XwHmjM/mv2RDh6vP0lBOBj5+ObI
 kw7CiNabv6qvD706LipeXWZr/V8nmt6D+yPL3RKIsU1LvLExsg/UloYLmz5iEmoxPLEvR8Ssr
 KMOHrT8xWaULtjOwi5xi6g11eJTAME8HlnTxMT9Jal2cVFLAVmWEMoUTndF9FCiklJCwIC/dq
 bS4odSwLxxIF0Br01gZCZuAFadk1zrzw2Hsw7OxVZVaVOCDNGsY0QwnNiTbpESSNjx4Ycm93n
 czrG7UNC7dYoFAYSxB06VkaAO15f+rSMIrhIuUt588K6zXTABbr7RBIrho+J7QC4xmA8Tl/WF
 PkpKPMdWC5Jz10cC6g/j7PAqC/pkUmFhQ6/TsVROKZ/6elZmK6mKSb+UmtlxohcCEb1Pd2cMR
 2mYV8h/Pxda6ZLzPK/LxN/mVKJ2GshShtbtWUB64jr4pndfpp06xSCU6GKa3ngzNCDWbx913Y
 KKoykqAQYMBy0FJyWzjn0kpyDzGKUBGbv0hp2TRuS6dHcsujA36A4e5ZFdKpx4/ufAiP15UHx
 JDhz1keoAWn/nIBVNwUPYpuUpKDW2XaRDvWnCxR+eIY6MdDAlJAhhFhsM/QyugM3Slg9XBqIM
 Sfs4Iw1g8HfugYOS12aojoLliPzTKXc0Gsihq4kZrqlz01sNwRQ7cWEac2Q/OqJ6f5RuoM82m
 VeCYykPRaZZyaXXyIgW7gfiv9lyMmlllgsHBMzwvjhEX9YpMy7vQ6M5TPV9wekIgF/kDwaWcN
 pSgD5qAn0l9E78=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order that the end of a clk_div_table can be detected, it must be
terminated with a sentinel element (.div =3D 0).

Fixes: 631c53478973d ("clk: Add CLPS711X clk driver")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v3:
- no changes

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

