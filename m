Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529654A041D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 00:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346637AbiA1XKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 18:10:10 -0500
Received: from mout.gmx.net ([212.227.15.19]:52127 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344400AbiA1XKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 18:10:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643411401;
        bh=YkOgAasWKFL5PqtYuaKrziNPA6t6TWtBGIK2VpojFBc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=NeQc2ECq2cHbOnMXrFqejqxN/NKTFpRX+cKNFon3hcPl949QQqGWVYo4m1hZ9/fyB
         MrvcIMJZHPjFgcsQki2e/N+s+F72jTRgutb/BnI33duHgmnFRRDzfT1h1TfQd6Sqe0
         q4ad6Xo/nOX2L1+rd3ZlG70gKUtkzetLruJzGL/k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([89.0.80.162]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7sDg-1n9iV12kUc-0050it; Sat, 29
 Jan 2022 00:10:01 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-mips@vger.kernel.org
Subject: [PATCH 2/4] clk: loongson1: Terminate clk_div_table with sentinel element
Date:   Sat, 29 Jan 2022 00:09:20 +0100
Message-Id: <20220128230922.2047140-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128230922.2047140-1-j.neuschaefer@gmx.net>
References: <20220128230922.2047140-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nZ8SJq7BpTEcPnWOM9Te0gkmF9e9dOoAILUHTJNguPc7Cnm2RHV
 O6GUWmUGaAbvxy+K7YZl5sWP0MjdV6Xhl1TSew/MYhEAEmNZtNfy/XFHJWFGlGMlIYQEt1S
 5HqmtxNaRvgIGiT0PM1Fs0SLFY432NiA68lQB7hAWnzolA3GMZcO3hlCgMZB91VgDLvgpZN
 tjNSR6nWwfL0MUH3KjOBw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yao6eQGl4PM=:eCZ3r7lvohoK7z/DrboGgN
 FQmgyNEGsQ7zCH+uXNy74kQVHGOUyefs9QbM2Or2oxbXWQ84oXNPq0+jasQ2Tv1HzrIqLmxT6
 Ce3LlyVmiUoYP/i+oS0bTq7sc1vRXs5X/dJ1lsVzhcFraETxQd8JxAT9AbL9G95+DSCBmZb5V
 HRVIav7jqNGjlcK+3/e9ihgVm1VCRZSqAUOw71htg8JFOflJMIPiA1Dyf9z2mcjTb1XRHOfsu
 2RO/xryeg9xZdU6cLHGLz03CEMo3JAffS/HvnneXggPyRuDLsBIRGYLX6g/a+zsfatM7fXj9O
 W7BKlTJISF7EyllHlBJ8nHPp0/ZuCWB3ZUYcehX8qog25vPWzLXNzkX2pDWSqkVNbxtMTmgw/
 6QJc1Q5XQb1nr31jy0Bs1imumR9p7VEtIZWB75IWEj4Yhw6vk2tTRxdS4NSguUksqU+UIBsd/
 tF346EqQWheWZ+6a+BA5DH8bWZ23zSZ4a+RQd26vFOpwO9eWCkn1Qer0FeVO76pqteRenRhsd
 v+13sHdY/1gFaQk+epiMRc7ikU4lPyE9St/RXa5LFAl8eq06nssH4Vw7j8SfLon33XxBkCapc
 TBSJ34hBk6NtD299fOfNDvhXvMkYge3r2atUdLQURUHdvR4hN62UXjcL+mr/gfVR4+LVp/ZnI
 CwV4aI2nRAe80lv027NUr+3hBSakX1wnzPwRc/TLPxQaZgcVsPgMNP4uUWuxJC3qHzzUCgxBS
 DAmnAxxeLmT4F6hCdwAsYYSKp/4dXGjgTSL8sDcvXpYxyfn/ViSoOO5fr2yDvxfQot8WA1tlH
 lAFJfKmGU1bNIeO0W5tzLGv44qC38IEeX1c3FddSHsZPWFf+2Tm3P82j565qASdPK4987qy0L
 D4c1mpmL86FzfVq51m3aX60xlgXthNUwK+/WVdNUY8qYrx7l5NDCvBqGZnUIAcCJxPB2MC7F4
 T58s27HK1WG6e/P+ZAzLMJEy02Y6Ax/tpX2pep7cxLQH6i3U/B4Lcv0UNBvYOFM3qtSWKSsIc
 aMQx6QlEGzNj/FdZl96aYY1uusS5NXXgFkKhOdin/T3A5EOtj2fS486fldWN6Lm134YHe0EYC
 Tn6NHSTBHJT3nc=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order that the end of a clk_div_table can be detected, it must be
terminated with a sentinel element (.div =3D 0).

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/clk/loongson1/clk-loongson1c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/loongson1/clk-loongson1c.c b/drivers/clk/loongson=
1/clk-loongson1c.c
index 703f87622cf5f..6b29ae9ede3e5 100644
=2D-- a/drivers/clk/loongson1/clk-loongson1c.c
+++ b/drivers/clk/loongson1/clk-loongson1c.c
@@ -37,6 +37,7 @@ static const struct clk_div_table ahb_div_table[] =3D {
 	[1] =3D { .val =3D 1, .div =3D 4 },
 	[2] =3D { .val =3D 2, .div =3D 3 },
 	[3] =3D { .val =3D 3, .div =3D 3 },
+	[4] =3D { .val =3D 0, .div =3D 0 },
 };

 void __init ls1x_clk_init(void)
=2D-
2.34.1

