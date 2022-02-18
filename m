Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6744BAE05
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiBRAKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:10:15 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiBRAKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:10:10 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C42B53B54;
        Thu, 17 Feb 2022 16:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645142977;
        bh=7eGr16EtJu7MHLlCPbPNeHBHVZGOv0ozkH98DlInLXw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=khDLPcAf3NBw68tmUPBH41pcl2uhT2BDYGuhWrV3Asmr6/+YIUYzSUISO6Iio+/mb
         j+G1lNDHNMSetPdDZsCDGfYmsH5N6KddY7lMJeAzGQFte80ERQgfseiaVHwGOU9yS8
         rtQRVtWOOE2h8pqnZdmpkCD3MbqhVew7s1tMX4AA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9FjR-1nNtW21w0t-006Khf; Fri, 18
 Feb 2022 01:09:37 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Mike Turquette <mturquette@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 4/5] clk: clps711x: Terminate clk_div_table with sentinel element
Date:   Fri, 18 Feb 2022 01:09:20 +0100
Message-Id: <20220218000922.134857-5-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218000922.134857-1-j.neuschaefer@gmx.net>
References: <20220218000922.134857-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NRFX+n9ilPzjHYNpL4dxDX0MPMOdDmVbjTUxzaMLjlIkoxhtuqU
 JGaQOqpoarHEHTAZBUwbUu/wIy9O+O4Oc7WbNZkVD8gddCCEjgp+OgFchs2OEvfYkVOR9E1
 Ycl47XGinH7w43QbA1c9XZMILvgU/pv8dZInRE0PFaML12VcT56+kfeacuBlcc/4YBwKUdz
 Oeev0KSEFVZ4IR8XN8CVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:11hdJyMFsoM=:In/jDiEAAkdowbLlZY5XVW
 qaOIxV73FYNbSmeTLfGKPmyAYTUMNXiuzLppIqF7FCgyx85/UUmLgo22iFxd3azDx3dBzWvMB
 F0bcCkC0dpsgAMScCIzrT+eMJW/c06dBRFR/95+yUx1OdhVVu5qlYMHgqlsUiM6lclb85z/cU
 AhRD0U1FMn/x8H9vrK5EJ3jjGQvyGSKdKnZz0VKkejKvqsFOCZRjrHRaB8d/5PsBh90wf5vwS
 VAMsWnlHL6S88Z68fNc7lXpRQpiK9PFJuYhcji0BwXCHHy4hQxl/EbYRkULpzPpf+JAQ5NS5h
 pWJzeYzz4S0e+7icBfONtlNkiLf3p5tWYdtSdceaqpPRytoe0pIUTDcdY8CW0UHHfUWVy13UP
 FoS8UGU6L3s1Jxt6d008IEL4hy38Gg8vG/6mY4JixChfF4Lih1oFkE0EtBmx0RIne+8uFIX50
 FhDftLe3Zm05jPgIbkQGZBOa+LAO5/JH2RLvnmHU3myX54Iu9QPyRiqW+TxDm4P7K6ZCllViU
 Qn7v1kKQFcmVrE68fD+qu5yghmi18KEwU5FIYWYKQjUA9LX9R+72pDG4FW+m3i0eUXBSsh7xI
 HCc/uxLaW4kkNDNmrfCNpSwIvkzYkIOkWMg0gjxdSpzTmQG1a7xQffSg88AAu8LkKAdDebg3N
 sB7JNNUlpt/vOAatPMUOwj5CoAp+tfBS3CDKM7rFHvplOkQQj7BLsV2+JbKns8qIYkh3SOMiS
 YxCnQ/ab3ZsOBakyH/ar4CLIWaXXw4U/y5OFltMI9kJpG0dv70W99K+weG/zEPB6RoSrO80xJ
 wfXZ0mNwycS3Eo/e0pYVb2ExFrD3FKXCVT1/ouoTmRH/cizHpArgh4MYX1NzMc3K78sNNtKVD
 Jx8SeJLV9cRbkgpyzDEmu0KUu7z6gTsD6Z/EVbV2iaDUV5YSCQKFP6gwDnok694hBlCWxKKkO
 GVRANSaP8fiNOVKgbG68GuUt9thqbueaSs/CXHUNtPh/dH1uLhF7wvkRyAhs1lUwQbtUo6lZX
 cbDZwjn0fio7so5XKEE2GUyLXJ31zMkPW/TRBRxmv4FDAfs4fXA5F94AA3ywEV5ZQ8vEwWpaN
 0YEeZhK+Dx2TCE=
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

Fixes: 631c53478973d ("clk: Add CLPS711X clk driver")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v4:
- Change style to { /* sentinel */ }

v3:
- no changes

v2:
- Add Fixes tag
=2D--
 drivers/clk/clk-clps711x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/clk-clps711x.c b/drivers/clk/clk-clps711x.c
index a2c6486ef1708..f8417ee2961aa 100644
=2D-- a/drivers/clk/clk-clps711x.c
+++ b/drivers/clk/clk-clps711x.c
@@ -28,11 +28,13 @@ static const struct clk_div_table spi_div_table[] =3D =
{
 	{ .val =3D 1, .div =3D 8, },
 	{ .val =3D 2, .div =3D 2, },
 	{ .val =3D 3, .div =3D 1, },
+	{ /* sentinel */ }
 };

 static const struct clk_div_table timer_div_table[] =3D {
 	{ .val =3D 0, .div =3D 256, },
 	{ .val =3D 1, .div =3D 1, },
+	{ /* sentinel */ }
 };

 struct clps711x_clk {
=2D-
2.34.1

