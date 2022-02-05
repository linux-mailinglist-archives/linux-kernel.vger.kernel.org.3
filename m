Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E664AA823
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 11:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379717AbiBEKgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 05:36:52 -0500
Received: from mout.gmx.net ([212.227.15.18]:57637 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229907AbiBEKgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 05:36:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644057396;
        bh=XTku8DVkGtATOVS4JRruDvYd3AFKADqd1JnvizUrZt8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=IGYVM5g+r3kUICH14pLQ3fwBFV4Xd1Qfjm7oE0p3Q1g4S0U4arxwGcs/FdDFWJDN4
         yJaWTvPyQ4dnKWe+Nkub7A9JxOdEdjHnNr9/ZrJP4LjS4EvJICo1a97KFZSV+wlW35
         dNMWNaVjvg9NNx4yBFPzcSWIlJHS6JE7e+AvLYmk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhD2O-1mcGe62qmo-00eLlw; Sat, 05
 Feb 2022 11:36:36 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH v2 2/7] clk: nxp: Declare mux table parameter as const u32 *
Date:   Sat,  5 Feb 2022 11:36:08 +0100
Message-Id: <20220205103613.1216218-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205103613.1216218-1-j.neuschaefer@gmx.net>
References: <20220205103613.1216218-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pGRh6WQIF713X8QbMbvnIjz6nmTmChhBRYqVCnXMbAa28FgwIb8
 ExcOOIv9wd1tbdxdcuB1A6d51OYzqXGjPKnpPG5W7EdXUrvRHFPsont1bIwvjkmU6MNdX8w
 iKHq89FSYJ3tDTMFXT9Y3wS1k4+HI0NrknPVsADqLAV9Wz6Y14j63ezwwRoI06uxtZ2w7/Q
 CRFK/v/mGy6FilfHs1gVw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xv9S181Epmo=:erMDETCxICsrcs6+SJsBiZ
 xSqxV0SOnrr9GDIxVGbVkuK6SV/M+0oPe1sIg/PTQBXUaVQ4oRyMnzLnScDHYgKo21rvyPoO+
 7FDK6/Eisn77Ddy4eRQVpUEiKHunGArXtoBbZZi6SwccvVd3L1RbzaUvBf7kyh8Y2imNrRTqG
 e+SHDbS1jXs/MeB0ADXE3NeojqoLxMDRNuD3Bjsk0Ef3NBDCoFBKceaquw1DjTOpecqzkxohm
 /EADaHZTizK3oYbUFFtD8snbx8+39/zfnRH6mPDzShL4lqiEOT1Qdeg82g7/kPbYdPiJ25AM3
 0EeRXhcXQScdf+pdIUDvNe3AJpkGh+ie1jogirzLpaYB0e5JahCflIOODh7ZGaTBMzONe5BxB
 33w/Y2QtfxAalaiGgQmDNaxrZeQzqkgNFlKIZoQ4HcPfTqK8cdKx1Wi3x3elCoT5g/km1dCcz
 YFccUJWZf2ztGIRAI8BHRDz3JN6u9NKBQGAAphDuCdDmq3QNeQ5hxKYq7BPxJ2/+CL7U456ai
 M9IOodyNJD/5xpL3MfCKjMuDBxVEzVIqmEimAZL88qJsV3uBQ5Oy5qS8MTXsNANKNCuwq2m7M
 h++fsH26q040TeouEDMLB2sjxOi35f9X2om8QeqPq0wBBn/c0UobifbhiU//u+nJpu7p4V0Og
 gglVmm6rz5+Nxruj/XjPGaPzafYiJfCrHIo8VNwh0ue9hyd9Ff7QPgl7YDAz0rC0M6gRutyxq
 gP+V6PLOiLpHuohJ9FmLG/NPfyDxmThThV3ly2qv2G8zM8ZAJMqd5b0bjSE002+0odcvHQtYc
 tdeEMiZktP5vBBXpMra5ZOyxhTIREAp+5yx1fThRMbvQ6cuh/v53D44fIlYZf13gXNVoIfVfh
 aCGgpPEIzYJa2NFofiR/IQl53xWazPxQ7EXA1jDksXLligB9gmxFypQ/4/iUno12DXdfJi7Xd
 y0keOVcd9PYy/tFPm3Eg8T4RxLBUfTHO14HA62QxJ42VmYdtb0Hf4Yk5tuYQqAAQhflWwY+Fn
 yz+X4i+80dk0qGtsUJHgd1rE8L5ggnReKDO3nM/gZuCz2zqg5xtIGczuS5X6GAOSKQiIk3x/+
 mj5cJER/qToRhI=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lpc18xx_fill_parent_names's "id" parameter isn't used for writing, so
let's make it const.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v2:
- New patch
=2D--
 drivers/clk/nxp/clk-lpc18xx-cgu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/nxp/clk-lpc18xx-cgu.c b/drivers/clk/nxp/clk-lpc18=
xx-cgu.c
index 349eebf69ed93..c23ac463ab0fa 100644
=2D-- a/drivers/clk/nxp/clk-lpc18xx-cgu.c
+++ b/drivers/clk/nxp/clk-lpc18xx-cgu.c
@@ -522,7 +522,7 @@ static struct lpc18xx_cgu_pll_clk lpc18xx_cgu_src_clk_=
plls[] =3D {
 	LPC1XX_CGU_CLK_PLL(PLL1,	pll1_src_ids, pll1_ops),
 };

-static void lpc18xx_fill_parent_names(const char **parent, u32 *id, int s=
ize)
+static void lpc18xx_fill_parent_names(const char **parent, const u32 *id,=
 int size)
 {
 	int i;

=2D-
2.34.1

