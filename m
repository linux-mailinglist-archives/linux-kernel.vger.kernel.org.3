Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C7B4AA52B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 01:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378816AbiBEAwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 19:52:51 -0500
Received: from mout.gmx.net ([212.227.15.18]:36931 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350118AbiBEAwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 19:52:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644022356;
        bh=bNE6pRrvW/lByIQfeio7tmgaO8jbzpK19L2S4Wf+yzA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=EJL+mReaW/eSx3Cuh5x7yxTDgxN0DfJh83nWMRhE1JVuCnR/FfKgB7GStCBD4LxNX
         KZu9hvsarI1ZhsZx0AHgdPrLfZiHkDBG7aCHH9cQFMCFxXW7WRUmOla7nDJZXDYC+m
         zs7NQyZzhx1en9a1owRujLtwey3FV5EFPD3cQ5WY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHXFr-1n2jBa3y5Z-00DVQT; Sat, 05
 Feb 2022 01:52:36 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Parthiban Nallathambi <pn@denx.de>,
        linux-actions@lists.infradead.org
Subject: [PATCH v3 1/4] clk: actions: Terminate clk_div_table with sentinel element
Date:   Sat,  5 Feb 2022 01:52:28 +0100
Message-Id: <20220205005232.772726-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205005232.772726-1-j.neuschaefer@gmx.net>
References: <20220205005232.772726-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lWVU1QY4iL7zbP59K2Z5/VwFCPSTMIpDxTlewpinjNOdWGn74bX
 OyRJPuI7puZW4YId70tyT0RbCscju9EAJQzbR2d2YgfaNp3GumlR8u+/jO4eXNfB/7dNc21
 qXJpa/tZvYCVUBastIDMLNSkAd/Q0sY+/dptS286vrquqmg+xjm0OCzz5k4JaVp0clmbTNb
 I+XEfy6+WHJuNnVrJc6uA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EMUgfROemOs=:kWBjNP4+Hsq/myGcoYCtEt
 1UxFDcUlTkgKTkXV+9/zpoI2J5Pu2FfMI/iJ9t5paVypkeplGPOABbna/5jBsiUlpXRijl2GU
 SnpghPbxEJAR3JGQKlhGaWkH0Dnq3hoKZ/QoK0AtJsrftZ59NnuWzHGduwxA2lhdNAvCrVPIy
 Uml/WXT6pI43kB7+/IFqd2BF6qy3FqlNIGpE6EhtZntH8aHeQjdtlmhNFQK1oLdKkFufqMknX
 6SeI+bZdQlmTeg0KEGIVl3OteEWrWRNTtaYFypBH2FbepSuRRXPpZ7Xa4TjemWvuv5jwSI2oP
 VP2f4hm5MZ+A8eI57CBwX8QLdBrWj/o9gPfpOcFKD/JPU8qm88aTIapwnYBK5th8hQDPJX73l
 1E1GQiCKO0p/yTSKSwX1/swHFQnZTLDR7kzxBPTs50CBYtIeXpBUAU6nQyjn/M0Vb7uIOo5EH
 bSHUgCsr2z9wNu85KfBhpgFRjufkiqeIn6Ol8fvh9z9qypjEaGH++mmH+F1Ze/jE4GtroP05P
 0ley/2WyfGhut2mBXjU9KdBAc2yU5gciI1z421OD0H+heZCOl3qUrsAjYRYkYxwH5qU7peEAM
 24gV96kD1Td8KdPA/K63E3fbQzCRg4SqXWuAo7kWOvrMhiOTAfj76PNEle8OnqO4xjc4gTMOZ
 Wd22GaIc/ph6Aum88FryFAMI8Tg6Eke6ByoLLkgH6mOxQnUIHpCtgTicIrpC2UInM+GS0i5k6
 jxgs1fobCOa5uuA2ulvDP4H0R90mFDyXmHo5xaofzWDuFMlyCPFj8+YnKMk6s9F6JFaQvU95B
 MUYhPrNbvCC6a/DfETNoY9lPeTTOmDxgW4wlvsgLCn7KoETfx7ACuTHBuO8W6n97EbRZFAHwB
 wGbiGnUmonBhv747KtvYNRudbVR38iYxdPL0COxis+BPmhi50fqkin3bgGFcP4nOvXeyA4Q3P
 sQKBEuhuHlNyUOjjXEGQIKg0Sfu13dlvBL1zuejad/Dr4n9T0G01TC4vIummhmiuwHxUNLA4y
 e+qZakg82aCgaBIFkUCsJZCnzkC/ufn/2mwIR1OMBTCt79j2UL7jg8IbrDuU6gnJNihkfj2lh
 /h/2AuJEwEbkF0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order that the end of a clk_div_table can be detected, it must be
terminated with a sentinel element (.div =3D 0).

In owl-s900.s, the { 0, 8 } element was probably meant to be just that,
so this patch changes { 0, 8 } to { 0, 0 }.

Fixes: d47317ca4ade1 ("clk: actions: Add S700 SoC clock support")
Fixes: d85d20053e195 ("clk: actions: Add S900 SoC clock support")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
=2D--

v3:
- Interpret { 0, 8 } as a typo of { 0, 0 }, the sentinel element
- Add R-b tag

v2:
- Add Fixes tags
=2D--
 drivers/clk/actions/owl-s700.c | 1 +
 drivers/clk/actions/owl-s900.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

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
index 790890978424a..63c4097c07ac7 100644
=2D-- a/drivers/clk/actions/owl-s900.c
+++ b/drivers/clk/actions/owl-s900.c
@@ -140,7 +140,7 @@ static struct clk_div_table rmii_ref_div_table[] =3D {

 static struct clk_div_table usb3_mac_div_table[] =3D {
 	{ 1, 2 }, { 2, 3 }, { 3, 4 },
-	{ 0, 8 },
+	{ 0, 0 },
 };

 static struct clk_div_table i2s_div_table[] =3D {
=2D-
2.34.1

