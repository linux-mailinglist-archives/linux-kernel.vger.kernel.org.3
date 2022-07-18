Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440E2578848
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 19:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbiGRRYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 13:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbiGRRYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 13:24:41 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345852A964
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 10:24:40 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id m13so6102622edc.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 10:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschuetter-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+hbugQr5+xNPcE0KtdqTuT7ZIKW9UcGohbgYVXC1mXM=;
        b=mgjl4exBkj2C9P1C05JKKFa1xlvC0ovcZMNVjdbwrD2/r0QrPyejExJMG/143DitfE
         CWCJEFyJPgJy6QldEvEtSxcvVHbt7W16g1298auHLcEJuuC3ahp1WTRn+qCnwcMm19aY
         E3jZ1ce3EdDVfl/GTBXR3FDdf18hF24uDhbGn89mbDDUdrAbpaGvdtw/ZsY/iCTsQYoB
         iVUgopKuOdcQJ4N0E+tJ+4aAnxYcAunOBQg03wEnklbYmf9DIppLbESqsYZmELMV4HBW
         IzB/Zx5xFdAc3j5mSGQRAEZhc5mb/YKMb5h0uQpuYosmcJj6WmmxtFKJeWig0aE+9P3A
         BsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+hbugQr5+xNPcE0KtdqTuT7ZIKW9UcGohbgYVXC1mXM=;
        b=erNi1Bw83Pxc9ruZcdcdlOnHrlcuEeQ8XkWhiUeJnHvvSyw2c9Th1cJeT+ZkdLcz4K
         qXqLyMMTnUCooLXUCkiw9i7GX+Z53LqjkXILIkgvg2qmJpOaTL5fyAkbZrgKcHNjqJga
         ntaMzE6YbURfp5153eFbrjUt6GrVyVZ1lz3BKgDSyktdjmb3v5Z3GgIbHsUIvW5HK+S5
         jMYyHEOdKMGGKmqR61uky7TH6wIJSG+Yok9kYDqGsgOPNZ44Xdaje4enzggxUc5HgT2D
         TfpBuIz6Qe0QK4fTHdHdCRAklXkzCwE5qWxlqU8psKNMlKPAx7mGgVN6DT1aYRdrutaD
         h1+g==
X-Gm-Message-State: AJIora8Kl/084zwEJk1Im60jWSdDEaYnuw1c0NPaKys6Y8dcR+Jg8BH6
        iDSqLQIdp39ia/JFLvak5bC6VQ==
X-Google-Smtp-Source: AGRyM1v1jf9sqx4v/fI8EV6Xoh8Y0tBagpBVwZOBj0TX56wGd1GEqhkAGtdVHa4D4KM21sexXqQTwQ==
X-Received: by 2002:a05:6402:26d5:b0:43a:bf2a:c27b with SMTP id x21-20020a05640226d500b0043abf2ac27bmr38886541edd.61.1658165078758;
        Mon, 18 Jul 2022 10:24:38 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id l12-20020a056402028c00b004355d27799fsm8877769edv.96.2022.07.18.10.24.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jul 2022 10:24:38 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: [PATCH REBASE] regulator: core: Fix off-on-delay-us for
 always-on/boot-on regulators
From:   Christian Kohlschuetter <christian@kohlschuetter.com>
In-Reply-To: <YtVTyzLREdkzYiKS@sirena.org.uk>
Date:   Mon, 18 Jul 2022 19:24:37 +0200
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3270C618-E361-4BC1-B63A-917AE09DA60E@kohlschuetter.com>
References: <E25D6465-6475-42B4-90EB-3D2C3CAF3B20@kohlschuetter.com>
 <YtVTyzLREdkzYiKS@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>
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
index 1e54a833f..398c8d6af 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1565,6 +1565,9 @@ static int set_machine_constraints(struct =
regulator_dev *rdev)
 			rdev->constraints->always_on =3D true;
 	}
=20
+	if (rdev->desc->off_on_delay)
+		rdev->last_off =3D ktime_get();
+
 	/* If the constraints say the regulator should be on at this =
point
 	 * and we have control then make sure it is enabled.
 	 */
@@ -1592,8 +1595,6 @@ static int set_machine_constraints(struct =
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


