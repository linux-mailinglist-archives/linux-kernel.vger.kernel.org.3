Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35504BAE26
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiBRAKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:10:17 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiBRAKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:10:13 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9E7580ED;
        Thu, 17 Feb 2022 16:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645142968;
        bh=wt9/1XJrDEv+FVM99z+mQinXFm9ziBeumOFNRTwleAA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=aw6eiErcVFFWoV7PJKR5+LQwKAxcFq9haeCduTLDu8pj13uzK3AqDIlkZ59lqZC+Y
         pdabs/6+xZEk+AiFP6nLhFm/vIby8gP0/11JFpB9mnSqdA/ns+OG9dcZRIlU/X5jR5
         R3WHnsrcJm5BJq16mQawPLzOP/iMqXETUk2aU6UI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7b6l-1nMFsQ3f6T-00830u; Fri, 18
 Feb 2022 01:09:27 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Parthiban Nallathambi <pn@denx.de>,
        linux-actions@lists.infradead.org
Subject: [PATCH v4 1/5] clk: actions: Terminate clk_div_table with sentinel element
Date:   Fri, 18 Feb 2022 01:09:17 +0100
Message-Id: <20220218000922.134857-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218000922.134857-1-j.neuschaefer@gmx.net>
References: <20220218000922.134857-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ccvl6Oeh7q8kpL7QBoZl1wLbOVhzeyaIoxS+30Ubfg9GXk7903n
 R+XXcUv/MdK66FB34bWKytSVc+Hy2j7o8RJgpYsbrCzwIUHwQdOQ7DIsyg9iAhLfXsWsZH1
 ScXVl/kUe7B++gkJUk9LtrXhM321XCHmGrX9+eGztvxi9iIsTPf8DDKfllb0ZIe8u39T/Y8
 JgVOIUcMBso2DL3JoErYA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ubipob5irMg=:EYZEsKU8MbiLHMtKdHwqeX
 68FZYBID70+j5RLLnWO86Rf5jGK2h4zKabOUR9a/3/pnF3BW2GZq41u52YBkEQr6aBjmeodIC
 vTBZ2AICAv1EcaOsXEke5GGQutxWdt/8PTzha72aBb1VfYtfGUlfaF0QpN2t483v1S66J2D9f
 lkDVuaoOHBkIGuMU0H69UnpU0v5ZBdoSYU1hK8jpJ72rqSAf4zmqUQw7Ai7C1j8knnurkinSq
 eL2WwSo4TbdgKaZqdHQ4eJbkaYzsUPZSpwviLAmWBfk61PBcCPc3l4bVlc+ezxMgmfNYjuPoN
 HHLdrvOSMNc8sugJNqjFSdLp6SZdxxYHOav3dbBlpOMNwq/Ygaq4LrPf2OnhBJyw+A/jftEwD
 aZuO+AqqJscyBegObkobqlylZTXUSMpkTwe9cwwF1ZyWFRznjAYwe/av2RNCe6E0Y6IEKi3Eh
 FsjiATJxZ37a+9VkOhJomgbNDOT1IOXwNfil5omNe8X8x8Cc2iNhpeG6wT7tdPxNJgRmteidC
 qbCh4nfmoiJUhWEdbUkx+5Z1h4zhgnpPA7Opn6WYDR+u5aMYniCKqONhuw3xCS0rtnWGzhtZt
 lay+Io0ZpJN1AY4tL4Lst570eVSOUz6uVs5GyjYIE6aCnPyN/RouXSkPC1jLDIzBh9g8qg6gY
 U7e2Nv/E+e69yd8kw/XACGgX+QTuHpaTm65RdgIzPwEcw/Qf/PQkgwAmEam0QIc+smPqPSoGL
 329xm9867xG+9XKZ4NIrNwZ8z4tUCFMJ/rEXjHzBtSXqHhjn0thmKqUolLE54mLQcJI+kZZYO
 4DzF3s7L84WjU6FkD9kOZ1CQf8UCQEWph03lgRC62N6+p15uRXxSq19wP5pHMVbiBHsJ9XmFr
 c87j9AB7t7WfCpgXAZ2rgjeJ5I70yKbGV0QSPDu5gt62cV05PEKS+TA7jrKOYLEsUlNClBGm1
 yXgfUF3eaEggQB619bfJQ+XMcvdnq6KR2x0NELvmEeuq4oGS+bQN/BNt8XPUk0ef0PFOs1q3l
 6rB9vlw7EKpq3P8tiS4DTuQqAseTCbRlQzwKlRkVXHcIYy2jyQ7ltyyZw7xjK9DmPKFVHNbog
 fi+fFTFmPKY9ZY=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

v4:
- Remove trailing commas

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
index a2f34d13fb543..6ea7da1d6d755 100644
=2D-- a/drivers/clk/actions/owl-s700.c
+++ b/drivers/clk/actions/owl-s700.c
@@ -162,6 +162,7 @@ static struct clk_div_table hdmia_div_table[] =3D {

 static struct clk_div_table rmii_div_table[] =3D {
 	{0, 4},   {1, 10},
+	{0, 0}
 };

 /* divider clocks */
diff --git a/drivers/clk/actions/owl-s900.c b/drivers/clk/actions/owl-s900=
.c
index 790890978424a..5144ada2c7e1a 100644
=2D-- a/drivers/clk/actions/owl-s900.c
+++ b/drivers/clk/actions/owl-s900.c
@@ -140,7 +140,7 @@ static struct clk_div_table rmii_ref_div_table[] =3D {

 static struct clk_div_table usb3_mac_div_table[] =3D {
 	{ 1, 2 }, { 2, 3 }, { 3, 4 },
-	{ 0, 8 },
+	{ 0, 0 }
 };

 static struct clk_div_table i2s_div_table[] =3D {
=2D-
2.34.1

