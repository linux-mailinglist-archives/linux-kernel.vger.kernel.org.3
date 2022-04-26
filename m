Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B56510970
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354380AbiDZUHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354360AbiDZUHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:07:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2A2D0A84;
        Tue, 26 Apr 2022 13:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651003413;
        bh=4y7a+bBwn4/79Epm4BmNa0CGyOh0yDIBQXKqeowWuy0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=TwYIhOsb2Y/j2NgniRB/kad1ApCnPPxJ2P+gFbRY39Q7CmvklJs7XkmwxIJQNIhOh
         yQpJLFF4Zc9aO0zEEaJnFgrqvR5AP2MDP08rDsxrnf+k8SiZkTvHOS6b9R/GeqXJ9k
         f+etfW/fPRVy4LZJEWYjwptQ4KJoYRfY+MAws8Ec=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MacSe-1oH8bG432Y-00cAoJ; Tue, 26 Apr 2022 22:03:33 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] hwmon: (dell-smm) Cleanup init code
Date:   Tue, 26 Apr 2022 22:03:19 +0200
Message-Id: <20220426200320.399435-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220426200320.399435-1-W_Armin@gmx.de>
References: <20220426200320.399435-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OrM8TIIArC8cx/RIVY+mTjYUJR1mkdJJxuMTfFUCG657uKIXT3K
 jKTGrkq/jfOAQy6Jm9VhUioM/zFk5piwO1ipISdwHAHCxVWvkW6bzL+UF8L+AmREqXzQU0w
 fnbTMNJpJPRWXytlqXpCpP6R4XolwkEr4H1oOv3mUQP3yKNd+4lW5ME3iDlt+OCwW2w7jwm
 OYyEU/7XltrRXiQAjHNqQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R5xHMep9C80=:8XZmPFdG+vtlId2Jh55crI
 HHul3s4dc7z7vA07i61nwZ8Eq5eWPp6TaudxY2yAtwE2Bp+0CLA/OP+pLgPyXJu/FFkmTDGZX
 F+h7wjsSxDdZaw6l6GqWkUo8Osxc+/k0TaVjPlmMmC5cO7HgMdcyuRqvxPuFxVt3v1isONGCa
 5dqmzmVU5G93MEzI32WTTtsKrxEMjhYcTmTXX6umOkK/sZTcHjm4Kh2gO1O9w+dv8yRiPaVj9
 pjhzMKXx85BSWiVrUiZVVG062vRX0YtJpOVzuf9y+IvNpEEwVJnRmAgAbdAkuOMIBhdTry4kE
 ZYZtwGT6Mvk25FCiLW4A7aBLPuJvArxIV/0wUA97tWePPhEL2fr8i7UQtaEkh2x5MIB6DznAs
 qNIx882M5gYLH5A4HkRkmfYw0L2JfAsyKp1qbxo2RkooIwv6PKHV905VukrtRiQCsGKBZiuWp
 UQvlCJ0w52VBbPhJGA6th+b0PyNZSHy+hatzBBFgRr3mH96bx7kf3QnUWrW93Q5zLPtNBX1xa
 aEygBgvLgZERUijdLRb5jcaWKxb1L7Y4AtxJeI1ahbFdXWk1EwTZq0nnPfylGzuuapZyiO/tE
 uvdqYyx1jbm/Bl5SX8L1AiBJ8aUGk2o+bRexK/8YjGYL12BdoraJxXaqWyey+Xvu51lqN6J7G
 wPBlkLJgqM1cy4a1tLsDU08ACPRYyg78KoYys5LEHYxgRo/PIzgIII4SGUWTkJV19i+tc77gX
 mzHNcDQge1VHWlt2osvJx+1JRSkNefKqa5LIk1itHhV7m4bBpvf0KCAxFZ5CIEUHK8GW849Wu
 LzQ+W0L3xuym6M8/2xnvizH4ztC3vTbS2LFKns3vNRg+yKKZ4GVpFPKXDWDjSOebdty10ZlKf
 H9rJ1OxVvnvJ+/dB13HSWqHbC1GTCvrOIHi/BxCkXbcbl0gXJlS6DQ778xzk2wOS/s3qc94mw
 NJ3mXgjmZAciEvvQuO2JJz2LHYtj6FLzZmv30iFGarzmoufm8dcwmOpjn1CWYmB6ImPlbFvQ0
 5KxwxncrXVlGSu97qsSnCBTowgWa4hA4CIVUqSF471hGD2Or/GnCVtArpqVKIjp9Wtwc0iaoQ
 CpeAad187Euv7A=
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

