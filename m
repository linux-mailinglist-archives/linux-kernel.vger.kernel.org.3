Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFA34A0424
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 00:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351785AbiA1XK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 18:10:26 -0500
Received: from mout.gmx.net ([212.227.15.19]:33977 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348632AbiA1XKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 18:10:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643411408;
        bh=XTOsqOf/WkGgWaJmFVDvq2fS2L0XA1LpZOg14b+J6aU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YygBBZ5iScRMA4AoV+o8J1pCELgFolYTdMG0CXcTGMyp8/+ubYh3kbQ9k36F3UcKP
         KCN1BNRJ5iegdnG04f6lllXOAkttkbQC+55yf2za2x4oVHjcT01gbyURNwyTYsfZ3X
         RtgRouHJbEBmtM6muTqziQ9Oo4jJiTBAf6MqfCBY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([89.0.80.162]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUXpK-1mn5Hc0zMO-00QU3d; Sat, 29
 Jan 2022 00:10:08 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>
Subject: [PATCH 3/4] clk: hisilicon: Terminate clk_div_table with sentinel element
Date:   Sat, 29 Jan 2022 00:09:21 +0100
Message-Id: <20220128230922.2047140-4-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128230922.2047140-1-j.neuschaefer@gmx.net>
References: <20220128230922.2047140-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kONIbwxFhEejB7eJDZdPACNkE1PmoNbMHGkDDbM7hjzeR9BZCnw
 HeWjmYbc2kqd+twNi5vIC1S4pneVR3PUqxtyQJxQKsjfrBlEmAkySZ3fJFcHHq/wnCeXBom
 CCH7rgkIvsYUpfXTbgNq3m/LRkuCUWahy1w9srDTICMSOzVZlsTCp9exjVsc5GF3jWCepv+
 ARL1GfZNlgsMSl+S2Aulw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nZ/aFuC7uE4=:OGCoIazl94MmvwSxlI+Oc1
 QiuIsuRNCfBh9ItVQVQOQiHhNaxBWGrosw806SpSd+llxe03npVOFKBmnmBqazWq2EivnHWsI
 Uc5ZY/jwPPyn6Rzu0HJcZh8t5DAerYvQsi+2TQbTvYvymkf/4a+GJxxRJU0gcd8ip3kaczkWl
 lH5YCYrjdVMS2v5lDT9aVOLA/O35oM79ahgg39F61Sqe3EhFwT/mHSKSX695AYBAt9mmFFTvb
 jAo7kfLdO3bavKHsT1xOiP4DN79Bw97PF60wWjCfl+eoF1cUuNNg9iOYQaWSlhyU/NXxiAdM9
 noRqCT8eT95t+9/+Cj1uZdcxkobcwMHkc5sFHf4ccOarZXkk98YyhMcawn8pZ7eig82I+xQ57
 zfOVbjXIg8VUPFCIapdcu49fGhiFdLz1jYlpS9UjSCJT2OLfgks5XYtH/FIWVWxYj0ZZd8ATW
 LEjbRayw/nHDnHXFNfTkwOm9gObvUFQJ/UW/TdLXMKKVzPPaTWWb2QjG3E3VGlgC6Mi2NEAR+
 Ei8b6xKSNxABVR+GbNmFJq5zGXLuS1qcSAytM2XkOe8O86NVpuk0Xr49g8IpE+fWdtCwpAbRF
 7087BSIiO865SyvapTBhOlnsOlqbPZE+GcHtGJCjjd2B+KO/Mhd8juu8OPE+OxJUS8iGGzMTH
 YN1qX2SbizsacCmoTsVHpvJ0tCIuOp17YtCaHv/eYub2JVXVhZFWQiYhZpsxkr2chq90i0ltO
 SQL6vXsh+zlUzipXyfZJt8339GilzA7DY0re+s88J9digLdK5e3f7yXpzBUeRmeFsb6JYqCh6
 HFbGz9LtgzsXXX+eTLmvI1ycNWn/Q07WDkbNCOql+zl59yWhWpLgyVnheHK72xTxxlaSwizUL
 ASyxUzpDr2R5E+rF2DhTnkkYMleJWOzWXAHWPqJiZmY1TB2S5rCMpjwCiHg0DtAGYXDGpIOey
 6mO3pT0ryPKf0n2OgbNVTs8rWJC2ZxJD7qaerpKF63utBiSDaBdtpMCpll9R4K4ygimzaPcq8
 0Aj3nuEBR0pGBS9/Alh/OV+8tqkHfPbWEZMMmahEySeonRYmCMBgE50N0XUYQs2IFAadoIcdv
 nhQp9PQTdWC+ao=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order that the end of a clk_div_table can be detected, it must be
terminated with a sentinel element (.div =3D 0).

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/clk/hisilicon/clk-hi3559a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3559a.c b/drivers/clk/hisilicon/c=
lk-hi3559a.c
index 56012a3d02192..28c2a0630474d 100644
=2D-- a/drivers/clk/hisilicon/clk-hi3559a.c
+++ b/drivers/clk/hisilicon/clk-hi3559a.c
@@ -611,8 +611,8 @@ static struct hisi_mux_clock hi3559av100_shub_mux_clks=
[] =3D {


 /* shub div clk */
-static struct clk_div_table shub_spi_clk_table[] =3D {{0, 8}, {1, 4}, {2,=
 2}};
-static struct clk_div_table shub_uart_div_clk_table[] =3D {{1, 8}, {2, 4}=
};
+static struct clk_div_table shub_spi_clk_table[] =3D {{0, 8}, {1, 4}, {2,=
 2}, {}};
+static struct clk_div_table shub_uart_div_clk_table[] =3D {{1, 8}, {2, 4}=
, {}};

 static struct hisi_divider_clock hi3559av100_shub_div_clks[] =3D {
 	{ HI3559AV100_SHUB_SPI_SOURCE_CLK, "clk_spi_clk", "shub_clk", 0, 0x20, 2=
4, 2,
=2D-
2.34.1

