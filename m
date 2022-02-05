Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F704AA532
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 01:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378849AbiBEAxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 19:53:07 -0500
Received: from mout.gmx.net ([212.227.15.18]:47755 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378839AbiBEAxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 19:53:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644022364;
        bh=ZInuevHBm/8PJjzn5I6mzT63DgQSEcCynm0dez446Vg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=AFz3bz4QsMm6Q8r7kpvkF8bX4FRk/27eEhF8rfJRqe1Aw0hVzblMbWhFgIbGBqvq7
         Zg75sYU6LwWfwyVkKdD+OqzZblIdr/H5c8xQnLLg7PyXORU1oTW8Hd8PkHTw3TPTS1
         rbggH0RnhAubbq4mTHkrheWClibrAg3wXZ0njvyU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRCK6-1mt0G008Pc-00NEYx; Sat, 05
 Feb 2022 01:52:44 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>
Subject: [PATCH v3 3/4] clk: hisilicon: Terminate clk_div_table with sentinel element
Date:   Sat,  5 Feb 2022 01:52:30 +0100
Message-Id: <20220205005232.772726-4-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205005232.772726-1-j.neuschaefer@gmx.net>
References: <20220205005232.772726-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rbb1pSAhHyuR9YMzqKSJwi5YfC4B+oFbWbLzs/81XvNGTiL1Vc/
 qfxvUqUqbPYSYk5cwhkIH9R4ek6xxjxKvybtFfrQwgIqod3C2BN+lGGTMykeCOuCYK0peiR
 UbmrBs8eury762fSp/gjZgBb3+Ojuvjxv1epvl2kwPbW1nT5hTNGG3wOc/RwjVSc/H/3s/W
 Ag3osKQrhvh28/z/kjnAg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qqoEMsfYPY4=:7LfRaRTn0/26RCs4FHsHbH
 PWn6fBf23npbfUbMJYDbr2viP1SEddfUCLW4qKgG4ZiOwXGD+siuSvEayjDdW/Yz9jRnARqXC
 XjMzVC3DALcabtOu03SO3F0jg4uK/XTq6/XloFr1TONIQgTPOT2jLcnFlbOOQVHsxbj15E9bu
 fxK102qIycpREeeaDSYGbDXGp6BiiLHyA/LmiVs9TiJM+oRTTgFOXWMJ9zaUHdJGFlsDmxbEG
 b93TiPssh/uTl0CNad6ne+nB6xvcezFYDMHC57MV/WuIY1UXPY97OlMhcT2/E3lGd86ZeXKM+
 aI6CbMISYH0fw1wnlhMOOvpPc07GzoBH9t2i9rbSv1J1uiWgEOQIOz9N/pRQdw3EBj9LUa949
 cZZNbb+B7aVcC3zLSgkGfnfQRl4AqO9TmxuewC9u59yEYJjuDeJyQjwcBiaTFPnFzq6n2/FNw
 FHGSCdvJ/W1HzejFpLXcaoDU+5SWISLDD3xI6gYqz4tNjiYZFWp7j29fijrPNUv0tx7Ra5pT/
 miTqTjAn6LbTsErKZPcWfCvlfOh2Liw4YzlDeJtLIVouEjj90D9fXcmBY4fkB1CZL3j+OaD5o
 KzGscaGDCFjnE+CX1iTbaNfWcb9OK3URZHHiKRRzy8qWdIv0NYtbYtoQ4PM2GFHlGa8nfhs+t
 eYmg3GNsjY4tpaGq+EQXdN/YS/L7yBsqNz9riwTMHt23ZYxg5+Mnxl53vQtvNnz6INFEs06rg
 HEzaEBD+8MN7lRBnY55FSDi2sdC6u/T0U7vV2nyTR6ZPLrYMpTBvGeZ3qR+XmPI87h/t3gmQs
 QE6ZHXSnqhHtAd6Ebi448RZNHxn/jG+n9tTVVxpf32mQSLoU9u27BQjivHj+cbmooAsohUP/8
 Pn6pFaC0SKNjWJtcAvs5fQKW/lLgksRKuv1q+fCozuJUuFQ8sRKgWT6r+lM6DVkiv2+Z/4o9F
 pKisDSTsDa+tAw76DBXjF0P3S0mixK+V/eMNtwQtEUTkKmJLI/casqFSsoW7e9u1E9kPvQxtI
 dcfN9+OeP6CTYjPY6FGrB8AA68qBokrZmLsiDcu0r2eRZ6nR+lNa99lubDRUt/zukVyFOn2RT
 JfynFZRhPllCRI=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order that the end of a clk_div_table can be detected, it must be
terminated with a sentinel element (.div =3D 0).

Fixes: 6c81966107dc0 ("clk: hisilicon: Add clock driver for hi3559A SoC")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v3:
- no changes

v2:
- Add Fixes tag
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

