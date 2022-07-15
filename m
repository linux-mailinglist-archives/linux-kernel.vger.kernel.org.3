Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F3F576826
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 22:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiGOUcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 16:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiGOUcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 16:32:22 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D67D186E1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 13:32:19 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id fy29so9761487ejc.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 13:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=QyhOR01DoxGCYnC4bLLESVLmV3qWJRFD3wmuOiKUM+s=;
        b=Z6VzxmO6hGDfHH8LKcLYuVI2nHVAeXPXEXU8HNTLXXfNsSamzoe7i1tvTSpIqGwnRX
         eb7uCb86aYA6r3Ymrl/fR2gyC+47oOTKX+SPPBtB3y+avXE52ROk7wcBBUrNBqtCLMlZ
         KGRP7NVaSEBG2ZRN3jrjcWJRx2mtwJT++GeRcCN381prDLZR977xf9Bi/9Qji60mBZAP
         Zi1UhzdRx3SYrHNE7l61cl/03Pe7GLS5B09Es0Ykf6YZDP8et4SjN7IOSByRn85s3ePC
         dzwy99tLcPsDy/MS9DPZu+YSExOjhogvC9DZ1TrU3sNesAfiB72SoZByHsVCfI9Rd/Rq
         JjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=QyhOR01DoxGCYnC4bLLESVLmV3qWJRFD3wmuOiKUM+s=;
        b=fUonVOFu/raEiLescnBMR61g+R19CCE3z2hD992U0Otph1/rDj9ofP3J3/S9J2JqRP
         0sk0pWNYoxT/47apaUwIGos0JSaT10tYCbpmptMsOfhLf0rDPaQPM3ak0h4Rl4QcnVE7
         ETraT0pBkFTP3LR2aiUwkvFTm4vwBfe1rzh2oIwOv0ODbxmjDQFnKlkt50/NQe2B6ytx
         Ny9uOaRigg9VlKv+x5C+yyKaSFNoUZbjZhBZU1rUdhIOYKLI7UZ+kYzqHCzmgpUK3WkZ
         FcnFtLGZtBvrX6+YPKMzc4zWlwlKj1joCHctLl+J580r4V+jeXTGEtC2+k0gniqte0LV
         APRw==
X-Gm-Message-State: AJIora9WzfHTYXXcawrQPzy9ekBhcIAB3UBUUkgox/w388v+TnMvdR6a
        hew/vbp2iHFG3g2FsPURBlxK0A==
X-Google-Smtp-Source: AGRyM1snP/L4DiOZS/0MJdzbFUPKreO0jk3IPQtyANLnH4rMZRf2ATr75Ln58SBsVbEfxUEbkunwCg==
X-Received: by 2002:a17:906:5343:b0:722:ea54:fe67 with SMTP id j3-20020a170906534300b00722ea54fe67mr15579245ejo.181.1657917138169;
        Fri, 15 Jul 2022 13:32:18 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id a15-20020a1709066d4f00b00715705dd23asm2375834ejt.89.2022.07.15.13.32.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jul 2022 13:32:17 -0700 (PDT)
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: [PATCH] regulator: core: Resolve supply name earlier to prevent
 double-init
Message-Id: <3B4AE882-0C28-41E3-9466-F8E301567627@kohlschutter.com>
Date:   Fri, 15 Jul 2022 22:32:16 +0200
Cc:     Robin Murphy <robin.murphy@arm.com>, wens@kernel.org,
        =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Markus Reichl <m.reichl@fivetechno.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, an unresolved regulator supply reference upon calling
regulator_register on an always-on or boot-on regulator caused
set_machine_constraints to be called twice.

This in turn may initialize the regulator twice, leading to voltage
glitches that are timing-dependent. A simple, unrelated configuration
change may be enough to hide this problem, only to be surfaced by
chance.

One such example is the SD-Card voltage regulator in a NanoPI R4S that
would not initialize reliably unless the registration flow was just
complex enough to allow the regulator to properly reset between calls.

Fix this by re-arranging regulator_register, trying resolve the
regulator's supply early enough that set_machine_constraints does not
need to be called twice.

Signed-off-by: Christian Kohlsch=C3=BCtter <christian@kohlschutter.com>
---
 drivers/regulator/core.c | 42 ++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index c4d844ffad7a..728840827e9c 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5433,7 +5433,34 @@ regulator_register(const struct regulator_desc =
*regulator_desc,
 	BLOCKING_INIT_NOTIFIER_HEAD(&rdev->notifier);
 	INIT_DELAYED_WORK(&rdev->disable_work, regulator_disable_work);
=20
-	/* preform any regulator specific init */
+	/* set regulator constraints */
+	if (init_data)
+		rdev->constraints =3D kmemdup(&init_data->constraints,
+					    sizeof(*rdev->constraints),
+					    GFP_KERNEL);
+	else
+		rdev->constraints =3D =
kzalloc(sizeof(*rdev->constraints),
+					    GFP_KERNEL);
+
+	if (init_data && init_data->supply_regulator)
+		rdev->supply_name =3D init_data->supply_regulator;
+	else if (regulator_desc->supply_name)
+		rdev->supply_name =3D regulator_desc->supply_name;
+
+	if ((rdev->supply_name && !rdev->supply) && rdev->constraints
+		&& (rdev->constraints->always_on || =
rdev->constraints->boot_on)) {
+		/* Try to resolve the name of the supplying regulator =
here first
+		 * so we prevent double-initializing the regulator, =
which may
+		 * cause timing-specific voltage brownouts/glitches that =
are
+		 * hard to debug.
+		 */
+		ret =3D regulator_resolve_supply(rdev);
+		if (ret)
+			rdev_dbg(rdev, "unable to resolve supply early: =
%pe\n",
+					 ERR_PTR(ret));
+	}
+
+	/* perform any regulator specific init */
 	if (init_data && init_data->regulator_init) {
 		ret =3D init_data->regulator_init(rdev->reg_data);
 		if (ret < 0)
@@ -5459,24 +5486,11 @@ regulator_register(const struct regulator_desc =
*regulator_desc,
 		    (unsigned long) atomic_inc_return(&regulator_no));
 	dev_set_drvdata(&rdev->dev, rdev);
=20
-	/* set regulator constraints */
-	if (init_data)
-		rdev->constraints =3D kmemdup(&init_data->constraints,
-					    sizeof(*rdev->constraints),
-					    GFP_KERNEL);
-	else
-		rdev->constraints =3D =
kzalloc(sizeof(*rdev->constraints),
-					    GFP_KERNEL);
 	if (!rdev->constraints) {
 		ret =3D -ENOMEM;
 		goto wash;
 	}
=20
-	if (init_data && init_data->supply_regulator)
-		rdev->supply_name =3D init_data->supply_regulator;
-	else if (regulator_desc->supply_name)
-		rdev->supply_name =3D regulator_desc->supply_name;
-
 	ret =3D set_machine_constraints(rdev);
 	if (ret =3D=3D -EPROBE_DEFER) {
 		/* Regulator might be in bypass mode and so needs its =
supply
--=20
2.36.1

