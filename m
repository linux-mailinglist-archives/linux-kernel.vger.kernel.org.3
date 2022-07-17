Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2FA5775ED
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 13:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiGQLam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 07:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGQLak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 07:30:40 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9E613E8E
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 04:30:39 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ez10so16543439ejc.13
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 04:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschuetter-com.20210112.gappssmtp.com; s=20210112;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=UYLgzmwQ3mswywLI0ANNamr/kYqFy4glMlF3d7pnLQc=;
        b=rzp2GSXU43wAI9LLKpwc9qlPKOfRtDxrBtTCuXglNM5EKco9iaYEdfJqH1VU96z7g5
         gmEsqF96DEas0rzHjuNWJSII6fgCtIJ55+agiXcZraEfGv8HWiKHfdd8Ab5oK4oX5B6k
         UHpxpgEmnq+UpR+vrgW5MsV3Hli2yB3ATY15Z06J+I2gytNCVWojVCPk/cMZ2UL7as6Q
         +Ez0GvjIWhMJjHPBz8Kh4bs+HkfeYBe87kQdntBO8bZfA91i0pMVhddGqPHW0DqW0Aqt
         JYLvrDdnnOsEfcr/+wYE0qctva1rnr3S/zevCH+a09vHI3zBaG06kKRoUfxD9AT0ofzD
         shCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=UYLgzmwQ3mswywLI0ANNamr/kYqFy4glMlF3d7pnLQc=;
        b=OQVmHNQyYW+jzF+4draM87/RTu9PHb3n1HQFFD0xcMl8OgLy4i3yaRKlIeMBW6eanI
         TcWXYqTwzPmS1fvExo9E3otYjVL3h0+xgQI6Ch8KYwsHzbX3yJcUAFJzzJLTxwbzX8Ml
         4XOJ7rzvSDA9PeWPFzVcLMsmMdcEx6HMDKVhtRTR+8IaYaMlGDQBEA4vmNdkhGTvwo8o
         BQnyjaRli/dQk5WM6cWBwfkPG3f7v/8IU9xOewonXz8o3pKot7oGvGb7Tt0lvJcG/v1X
         xWw9EgqpfdKWLoLJM5tN+BgcBXzP/LRUirMBaoOjImazfjOGNAxMpt3zsKx/ERtf68Pu
         dt6A==
X-Gm-Message-State: AJIora9mfdj9Nj1GFZ6pc77ezQ+Y/ZI6iz1IdQqcFwSmwvqc9Od4qKsY
        9j6eOlWs17LVciIq+enZcMrVJQORL6apfA==
X-Google-Smtp-Source: AGRyM1u69RqVUtlR6Q9tq0V6CB3UxAYGNgvKixpKXgsrt6IGbPmRNXJA+B9y8DfNJXGhoJMbDCS7EA==
X-Received: by 2002:a17:906:4fd3:b0:72f:2306:32a6 with SMTP id i19-20020a1709064fd300b0072f230632a6mr2592634ejw.83.1658057438293;
        Sun, 17 Jul 2022 04:30:38 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id g21-20020a1709061e1500b00722f8d02928sm4314699ejj.174.2022.07.17.04.30.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jul 2022 04:30:37 -0700 (PDT)
From:   Christian Kohlschuetter <christian@kohlschuetter.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: [PATCH] regulator: core: Fix off-on-delay-us for always-on/boot-on
 regulators
Message-Id: <E25D6465-6475-42B4-90EB-3D2C3CAF3B20@kohlschuetter.com>
Date:   Sun, 17 Jul 2022 13:30:36 +0200
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regulators marked with "regulator-always-on" or "regulator-boot-on"
as well as an "off-on-delay-us", may run into cycling issues that are
hard to detect.

This is caused by the "last_off" state not being initialized in this
case.

Fix the "last_off" initialization by setting it to the current kernel
time upon initialization, regardless of always_on/boot_on state.

Signed-off-by: Christian Kohlsch=C3=BCtter <christian@kohlschutter.com>
---
 drivers/regulator/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index c4d844ffad7a..48ed33ad48c8 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1522,6 +1522,9 @@ static int set_machine_constraints(struct =
regulator_dev *rdev)
 		}
 	}
=20
+	if (rdev->desc->off_on_delay)
+		rdev->last_off =3D ktime_get();
+
 	/* If the constraints say the regulator should be on at this =
point
 	 * and we have control then make sure it is enabled.
 	 */
@@ -1549,8 +1552,6 @@ static int set_machine_constraints(struct =
regulator_dev *rdev)
=20
 		if (rdev->constraints->always_on)
 			rdev->use_count++;
-	} else if (rdev->desc->off_on_delay) {
-		rdev->last_off =3D ktime_get();
 	}
=20
 	print_constraints(rdev);
--=20
2.36.1


