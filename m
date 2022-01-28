Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974A54A0422
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 00:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349982AbiA1XKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 18:10:21 -0500
Received: from mout.gmx.net ([212.227.15.18]:56733 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345913AbiA1XKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 18:10:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643411401;
        bh=lfLHmjyOTilBttOWAj201No85yHq9DO6yGAMOq7BohA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=lS7AQJWQRZKabML+gOpCycsyPB2/ogg2wDFk0S8RGLPg5ZvYLEfEFgDY/5Jkzbenk
         dlfMx/b8RmmxltEHc/mQuim3ngEK6ft4u6q9scO9F4cu/HARWUM7bIIEdK+ywiXuPG
         MGuDI0u+GAYk/oX+jZivpxPNiyOA1GP9XBtnsItg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([89.0.80.162]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTiPv-1moSiz3RXR-00U3a3; Sat, 29
 Jan 2022 00:10:00 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: [PATCH 1/4] clk: actions: Terminate clk_div_table with sentinel element
Date:   Sat, 29 Jan 2022 00:09:19 +0100
Message-Id: <20220128230922.2047140-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128230922.2047140-1-j.neuschaefer@gmx.net>
References: <20220128230922.2047140-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ihzYKGpqwBqxqgDIEWeV0fy0JjgUcCO2Qw+dgurKtoDIMc6gipD
 P6gk1Wwb9boSzbceguBlI/aGm9OsaxQh/Y0hL01UWkHh+BZF6cYCOC8D2VnNZ64Ei4uMtF/
 upuDulfCWbuPNi1EmCL4QLXqQbaBQAtowTga2o9JHyf7H2OKHBMcmyYSd9haphCVsHksDO6
 trPCkcY3A7RvmukgLCUNw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rje9gfMd0VY=:Ij/RTDwVn7IjVqpCSNAQUJ
 9OHrWCQSgn9NKjTHJWt4qEhf2jvaeWOWwfywTnY98kapca5dcHKW5KRRxkgDvK2sVpVDVhdw+
 HFyX54vgANdTf6BZWWDvyQ3IwaM/Ivko2QQGuFz0UYKFIq0R+whJaUrEhtiNYS5sY37IcMmha
 hgF3ZNNUHOFsk4+0Qc7vbxA1YADfoimu9JcenNgtPbSC0/j8rzS/LNVz41C7D3NkI+IfIP3pY
 clHZ8MeiS+g6hxwSin6Szo1J9bAB0Os6tramdpb1AvB6xc1lfjEJkNYYLOcjLLLxx8ed/1Ss8
 Imf/tDIt8JQM9vBKOBXsgGhS0/s4ytr4G+gr09s+D0ky0A5KcErwav/JSqFR8orL3Gjpkq3FP
 BYIR0pzericT56GEijEIcv6BbKJwX6TeFt0npq3rekOrABJ0VxtKzSlGyNHh/uZvGBCWCZasM
 sag6/4YV+coFYEiYW5mS0jGyxcybruqWS7nZO7CtESn9Xh+T7KJsJ3ZOCymw3MuC+27IZ9tdg
 XxvKE08mys5HHuvp0Rld6APFThSyhIvHFH7krnYIL09jQucxoNkt1HrHyl3w4fbTcUN/zVs3K
 8mySM41PWcAjEsjt8Mx0wfZxBHs8uETh16xDHZvlzAthlnIhXkpC2pMcto0qaa7YADYw6r+Hd
 n6wvyTe9DSASPRKPLoy3s0g96L41YNGZv6PQxTUyr2/tdKK1Qb9ccIKY+tPX644c/Rwib62QQ
 39vL+JSzQiynQA0nZH3rGmI67VC6owIDCFxONcF0+1xcgW1FNjs2CTRe2Zag3xo1X4cZq4QYM
 GzQ/ZT2aEtnuNgPCwRV2WE3Wshy55C76n10f8YB8KlHFn3Np3r/+lRI0R9dgHDYoQc9mV9aLL
 lEgsBoTRdTcna2MG1YD69W7I08rm5rYSllrQ3jzOiwOJi0GHS57uz8ncGHe8xR/5trBil2DSV
 3rMyTr/fxAlOx1jK6Acms2B/421k5ogyCkEhiPWFeOKgYagRFaaBIQzLWnBc9SCygqP4XEJNH
 0Xawu2y3HIQ6pr34RxuOgJDjAA2oyTzoeZdpvf44niPQbnrRDm7CVbQMwH5t+6QJXqeVVHAU8
 I68fjYdWCrDhio=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order that the end of a clk_div_table can be detected, it must be
terminated with a sentinel element (.div =3D 0).

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

I'm not so sure about usb3_mac_div_table. Maybe the { 0, 8 } element was
meant to be { 0, 0 }?
=2D--
 drivers/clk/actions/owl-s700.c | 1 +
 drivers/clk/actions/owl-s900.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/actions/owl-s700.c b/drivers/clk/actions/owl-s700=
.c
index a2f34d13fb543..617174644f728 100644
=2D-- a/drivers/clk/actions/owl-s700.c
+++ b/drivers/clk/actions/owl-s700.c
@@ -162,6 +162,7 @@ static struct clk_div_table hdmia_div_table[] =3D {

 static struct clk_div_table rmii_div_table[] =3D {
 	{0, 4},   {1, 10},
+	{0, 0},
 };

 /* divider clocks */
diff --git a/drivers/clk/actions/owl-s900.c b/drivers/clk/actions/owl-s900=
.c
index 790890978424a..f6f49100a865b 100644
=2D-- a/drivers/clk/actions/owl-s900.c
+++ b/drivers/clk/actions/owl-s900.c
@@ -139,8 +139,8 @@ static struct clk_div_table rmii_ref_div_table[] =3D {
 };

 static struct clk_div_table usb3_mac_div_table[] =3D {
-	{ 1, 2 }, { 2, 3 }, { 3, 4 },
-	{ 0, 8 },
+	{ 1, 2 }, { 2, 3 }, { 3, 4 }, { 0, 8 },
+	{ 0, 0 },
 };

 static struct clk_div_table i2s_div_table[] =3D {
=2D-
2.34.1

