Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E56510B61
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355517AbiDZVfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355527AbiDZVfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:35:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E3547541;
        Tue, 26 Apr 2022 14:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651008719;
        bh=4y7a+bBwn4/79Epm4BmNa0CGyOh0yDIBQXKqeowWuy0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=PfoUYFISApB2yTYv8FbqQEKSYpktQUDodGhZIfSK5HFLrVjfOP0wp3nZasFIdikxo
         HXzDfRSFVf+HdF4OeoewBdWcJFqyILUXao6wLm4/aJoGl5zEvhUQK4WQuOmgK8lrEK
         ppWURzPaEV9kUP895Lb8dxdYFFXOJE0+WhNvxfEk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MrQEx-1oGIye2IER-00oYam; Tue, 26 Apr 2022 23:31:59 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] hwmon: (dell-smm) Cleanup init code
Date:   Tue, 26 Apr 2022 23:31:53 +0200
Message-Id: <20220426213154.724708-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220426213154.724708-1-W_Armin@gmx.de>
References: <20220426213154.724708-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+JjRYaQ1wf4drNrV3gpAZdx6dXsyvQ7a53cqXy8CHhEYlXiceAX
 B//clXO+aANIYU5MJ6kArIoGHoMrbzNPxWzwXFDTx4qRtfQaT1/0HDmV7FIMncsJVOSej0y
 DO9KrY0ulEtKrjYEWgKyUoRnOwloZoqZv8ioL9W2ReTa2gIxxPDc9IVvfSyKGEFIqbwiEyh
 hMaoXGMZal6CFbz17ewQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CZRFBoBFI3E=:FDqNUMi+CQuDZFnvk0l8BA
 PIAO8d/4+ZHPhoWWe4ZiqAhlxCb1icaOwbPW8cQdQ1A2NJGOFPprAQufg+E6eXBmUTk7e04ze
 k5Pe1d6enn2w0UUNYy21R1SwwQJGpMp5IPa83plZVDBxyzeo2tkuhioqUAaa78jVA8xbX88h2
 jUXvH64IBykZ0/91s+3qdw3ZX6nFGBmjq5rjoxgQqwlon27fZpUbiulE42QhE4vVjVXznCesc
 blAhVYQbxnaAk5FWpedpxdj7RwLT9NARQ6Ij2lrS8tE14qMx5R2oHP87YIhGx/aLzBRA9YwUV
 nb+entTcscoaK7PKCqE2Bx6XOX8CKoAyTFR7H8hP0x7xnrkXFYiWKHZVHe1qR5zl6hEEc64Ey
 oirtqnpEoVXZzl6y6JGh9c1F42gGA66B1+LG2ovWdjhGwSzuQ7F15C9+JxjOGfHGoT8GYNEPQ
 UnjWmJyh2A+dMPs0oHSs2QZ/ktW6rPjxWMTbV3oNx1WaWUb/ioA594l/bnsso3FqUxdK+aYww
 N2N18fqqSlcHufgKSWTMlULp8EHrAym1xrVSJvpvc7ChFmqt/HuJcjVToPZMLIJxZnmwo/2VE
 E8WN/BldB6zcmI2hMDELJ0EZotfrqH2FcqdHKjSARVwcKmaA2xrfme1yrLrL/qyE+QetbUzOF
 VDrUTHzY1FmX9cscnd33Ply6XkHamniHBJnSIK2VQWIaFBJmzJu2K7FXK6jEgIC2wsC4Fp2+D
 AgdFNcw3z+J9733FnU/bMYZeL0GcoXd++M1CL3f3VA1EzkHJo7lw8uYm/xr8r9GPgq2RPdEJp
 9qINGXUWsz3lK2mTJPAfzvDxuj06zGQoEe++OJBLIrft/EZoGO5T68eIhJFiC2uqzqGlimSuE
 lcodqKeE49+uXgGPrVOb+qvYceS381PIrrkWLC8LbMISTgHrHDLDZToKY4kgK4n+UDbrPuUDg
 aWYRh4H+XlgZSukuk3JQDbXNIIaXS1KjjYfXuTTFaCHrQHnhwNfOWYrMmrCfo4smsLropPZFT
 bs7BXr7g9nSU5ybK/lEeWezcK6C/Po32RsTZiuSTMYTPecvW6JSmYp24l39OHMtw5P5+IVxdD
 KH0gnJl6qrurXE=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default values for i8k_fan_mult and i8k_fan_max
should be assigend only if the values specified as
module params or in DMI are invalid/missing.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index 202ee884de9e..f13902414615 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -1373,8 +1373,6 @@ static int __init dell_smm_probe(struct platform_dev=
ice *pdev)
 		return -ENOMEM;

 	mutex_init(&data->i8k_mutex);
-	data->i8k_fan_mult =3D I8K_FAN_MULT;
-	data->i8k_fan_max =3D I8K_FAN_HIGH;
 	platform_set_drvdata(pdev, data);

 	if (dmi_check_system(i8k_blacklist_fan_support_dmi_table)) {
@@ -1409,7 +1407,9 @@ static int __init dell_smm_probe(struct platform_dev=
ice *pdev)
 			fan_max =3D conf->fan_max;
 	}

-	data->i8k_fan_max =3D fan_max ? : I8K_FAN_HIGH;	/* Must not be 0 */
+	/* All options must not be 0 */
+	data->i8k_fan_mult =3D fan_mult ? : I8K_FAN_MULT;
+	data->i8k_fan_max =3D fan_max ? : I8K_FAN_HIGH;
 	data->i8k_pwm_mult =3D DIV_ROUND_UP(255, data->i8k_fan_max);

 	fan_control =3D dmi_first_match(i8k_whitelist_fan_control);
@@ -1421,9 +1421,6 @@ static int __init dell_smm_probe(struct platform_dev=
ice *pdev)
 		dev_info(&pdev->dev, "enabling support for setting automatic/manual fan=
 control\n");
 	}

-	if (fan_mult)
-		data->i8k_fan_mult =3D fan_mult;
-
 	ret =3D dell_smm_init_hwmon(&pdev->dev);
 	if (ret)
 		return ret;
=2D-
2.30.2

