Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB334A8613
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351205AbiBCOWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:22:31 -0500
Received: from mout.gmx.net ([212.227.15.18]:56005 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351158AbiBCOWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:22:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643898128;
        bh=5x3pHxlLl71DgoSFcmjLP8kuMLdBgGXQRD4L2C0Fmqg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=f5/8YdQ+ifAou0fOsIDW3+pcUfjOaWGnuNgq2rrX/wxIDTvJMADSDxjfOwzqNoxy1
         YZ/r/nOo5ZMr7QS/NKe4EYoL0M0mT8xp94Qb+RLtZhNyXA6o/RX3VqmxA66byhDKvE
         tuTlirnr/pKIS+S1zmgdR1J09nozU1zy/QdlTdp0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([185.66.193.41]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mj8mV-1mcjLB0OLV-00fAMz; Thu, 03
 Feb 2022 15:22:08 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>
Subject: [PATCH v2 3/4] clk: hisilicon: Terminate clk_div_table with sentinel element
Date:   Thu,  3 Feb 2022 15:21:52 +0100
Message-Id: <20220203142153.260720-4-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220203142153.260720-1-j.neuschaefer@gmx.net>
References: <20220203142153.260720-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sR+ZINOmGT6bpT/qa+XgvVT6K3G0USPH84cYE6Zln9QEMBD4w5I
 WiJH9nPZQ8s0k9V1IJynvsBn1KQggumwBo9Ks0RpiEN/EXjzMc7pJep3pATQUvXLyjwYCwz
 6hZXRKPNbxrixNCMEzhn6YpA1a/0UI3bIf+tNX4oblGaBHB3UJSi8wpZ4liikfxEfONZtNC
 zcLM85edG2eDjKzQyzSzg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:A9oeZwvV0xw=:W/5CkOXPNEYWRecl4/NwRc
 +JYRzVCEI72+bd5FXOxWewXOe0TPNBl8BuKN7Ll9VrdLYrTUE8I8rbZUER9AcnbA/dQzq9fFe
 akXeA4uRvhfo6988AUzhLwSVohyfy6fcmiDdLZGVQck3FEztyrt+C/Vvzqc0RFriTiecsVH+f
 Y/06oXTleOpo1iTdu90hW0Ttcs8Fyq/OEbFkyOqckeFJPoGV33jV9s/ujeTlbC2O8DcwFdPS4
 c2m43KZZV3MmjJrcpb1iJnoUzKvACdSrf1IyxuO9J4cPUdY2i1TvYefhkAOdouv787m2DjoHo
 Z4SMDKE2gXNsSZESxSR/3CEeAIO3BrXDcyGYR2GCKP+X3hH/I44sWy1kzgoWCaCo+DR/mwAm1
 st0ohQj1TFL51tlMGXjhRwwE9VwGZnxMzKI07BoOO0QYiPT/lCNnXzQcVjWPHr2yXUyku7UQg
 rKglxSJCbLYcyjqRIPfz4T4R5vGRG6stIH1RH7rmMd8oOQF1A+Stie7q1oGTh/HrYacEznsxR
 ymvW3s5gAjQcTxnH7duHGNT48x5ZS2YbmGdYlIRRefKnh9ABuWY9R671/77Ghlsn7vmxi/687
 lTsEMuYZJcnDM8O5DpCpBmSkNCLRKmlg10h3hnButbIBdJ7daD7uqZurXBz+6JFzQ7agZ+gQO
 ESAniDQNT1bU4b4Fbnjxa/0y+g7of2XpjfDhtDYJMw7M8CNxVcgeDnEDoVmxCH0LImasCksnl
 J9tknL/LJqJrQnJgRyGJ1ihbPdZ5MM3w6SxVgtqMX16pSGFkGDwKlxssh6LbrnAgj5sOTjq33
 /nQArrO6gAgEIazvKMSxTD2xOoreknloX0sDAcizFwI+CvUbl2AHt4tm+cUBPETwCCg1+oC0K
 /4lk1o0/tgVqmI3ZQ+naEZYxaelGASMJ4N2mEg6xe2Kddp2IRZTeJCGYhfOWBw1SyfPhEiR9o
 yefaAizcrhXEgF3mW/spAIFmz9SSedreqOC2/JmNp3vs6JC4spGPlM1VsbyZJwaGYHC4EGXwq
 JxA5yNal6yW2+MB3rJL5HJilKa00MgaPJQGdHZozYCnRUIA1lN/HRf6Irs8VPjVkD+xuh58uF
 hzYQ72C02We6WM=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order that the end of a clk_div_table can be detected, it must be
terminated with a sentinel element (.div =3D 0).

Fixes: 6c81966107dc0 ("clk: hisilicon: Add clock driver for hi3559A SoC")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

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

