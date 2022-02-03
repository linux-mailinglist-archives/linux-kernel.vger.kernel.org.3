Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8651F4A8612
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351127AbiBCOWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:22:17 -0500
Received: from mout.gmx.net ([212.227.15.18]:34083 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235184AbiBCOWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:22:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643898121;
        bh=IwKkj/BLwI+wmRlocvg06uGH0YZhFXktrsLGe8KkwjA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=LLWd9XRTV0wWy+0KLyKRT2c4zJazXAQVSbUFKR1+5KO69z2Si61xH2lpktrr0oo6U
         7NQNe2Yw5Wyb0hEDKlz9pG7qPgdOmoEmA5y37hXeNMZlqS8cDrjzy4bXzuvTLEwG17
         7exZ6POO6oIGXxv51H1/Uhb/FXNsltuaQyCSSLd4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([185.66.193.41]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmUHj-1mXBRR0vVx-00iTXm; Thu, 03
 Feb 2022 15:22:00 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Parthiban Nallathambi <pn@denx.de>,
        linux-actions@lists.infradead.org
Subject: [PATCH v2 1/4] clk: actions: Terminate clk_div_table with sentinel element
Date:   Thu,  3 Feb 2022 15:21:50 +0100
Message-Id: <20220203142153.260720-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220203142153.260720-1-j.neuschaefer@gmx.net>
References: <20220203142153.260720-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e3ZwD+6godoexPIgzLeyCcdjalBbysuOdI0VY61Qr+RFAhldzmQ
 mCnqsUoqmLq3aGQtbC5TVo2sdLz7VtUGBWerPZKpzetQz9qGHC2fscRftvgoy0aGeNf0tYd
 m9AR+61O+BZJ6TvvTc8DexLYIWNAFr4ET08P1EeRzhjzGEb0mbkxv5kZc4Iv9l7P4tqpBJS
 px8d5Pg6Zd/IbCBzG+aYA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xKnEVUf1jQk=:6yq0QSAGy52oBH7w9Ix3NR
 A1xZvbrsCqD2x0o3+9A7hvF/TT7DxFMMCExVMO8S7qqJh0e7aci/LqM/FR+olsYKjFz2nbu44
 NTjnJ5WcxuMDtSW64wPD2s0+wRhePYZ4buuD/4trbF9H72uGA3fsOBhjuuZaV8s4N9QZeHhNY
 hChjf20TFTjSwFvpWHSzMsokWIPLVrphaYj/bzf65TqVw51GXzfs2UjEo5kDGJuU8hGNm26I1
 iNxMPVabZHFe4NiGTNQViXJ88KyZJt2cr/UbRxslsrk5CT8v/tRnd38WiFo5d5mDwJbK/7eYT
 QHfma2BT3AA9tPpGqJMRb8yCmcVRpnydJ/UUOaAmc4BVNRE2Ws/iY9fnorjVw7B8NHK2RxYdu
 SiWgXx13TYmyaOAR4jadMVTz/Y7kNpaIzuloOnvZUrvZILz1De6QJ7NcmNCCkR9SQnnuldCbh
 kDJRd8Wkggls3o1ZTk3r2xc7nPig3VEFgtZeco8YZ2ayJDrfCpy1bS5pxp98SZs2JrYst2zMS
 QmdrBwSiNsQx8FqclYnLuGsZ6xkFxFvo1UeE+1SgGBcl7UluMUBXVsISxVxiXLcZ8Ysv15Ci3
 4nP3hE3ZEJx9XDzmxJbTBz++KntuwXEpSkp57GbVVzPMOVg98KhdwhRO3xYEkWS2ozlzbVSR1
 XggTbo9nK2DCrUHw+7WwFy5e0Esoczyedo4KfyrzSJ3qf1DJ9PvP5wJcwbLDxGZ4c7qDuK1pw
 4Ke2V1VlqkPItZcmGIzWE5/lJZgi0HL7Fci6YOP1NHYLfRY1tPVjm/KCZ/zycvJ1cQo6VkaFe
 jDnItKShn8+evQ58Vsx5Lbf8PvjsTt+KdvgjnVs61ZHIVJx/+A=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order that the end of a clk_div_table can be detected, it must be
terminated with a sentinel element (.div =3D 0).

Fixes: d47317ca4ade1 ("clk: actions: Add S700 SoC clock support")
Fixes: d85d20053e195 ("clk: actions: Add S900 SoC clock support")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

I'm not so sure about usb3_mac_div_table. Maybe the { 0, 8 } element was
meant to be { 0, 0 }? I'd appreciate if someone with access to the
datasheet or hardware could verify what's correct.

v2:
- Add Fixes tags
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

