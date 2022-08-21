Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09F459B4F7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 17:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiHUPRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 11:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiHUPRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 11:17:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6816C22BE5;
        Sun, 21 Aug 2022 08:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661095041;
        bh=en7w682FC7Y6FJWxYUFaDykyxS5US63bp0vKvCbq3Rs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fyGN4ZUn4WV+7elwTy/v5IHqACeQuX5dUVMEpAGv2m6ChEcVTorGAQL5rNt/bb5kS
         PkFVw3ym6IBjNAIjLw/0b6uQi07lXAQ0icCtBcLtJjdI6x7x8q86bezLlXTdXisb6m
         ZUDsbsUAGHakAX9PdSKzV/2G2M9jfs7gfKizUtvo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1McH5a-1p2PF63tz2-00cjxc; Sun, 21 Aug 2022 17:17:21 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] hwmon: (dell-smm) Fail probing when cooling device registration fails
Date:   Sun, 21 Aug 2022 17:17:11 +0200
Message-Id: <20220821151713.11198-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220821151713.11198-1-W_Armin@gmx.de>
References: <20220821151713.11198-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SRoUDshao4ff5gMfwaYqJmJd4r9daDJMSgAIDGFWLOCyPfO+pMl
 HTUPIAVA1/b4YiayzHyY+mT2ceOID7D+ZZYR1KaVW0FE/yRrmvNDu850hxliZzemiPL59kZ
 HCr2p1PcLeGLjyYEzHqxzjbj8AiincD0f5HnirST8H+bts+D4fPGjP7faYixDjjKDlUcQU4
 EExn0dRhIMwSCZIXzMjqQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:42C14LqFIMY=:JmdXi8kACUkI5kxNxDvC+m
 zqDz3dSEW7RTiEZDYwnPCELoAe++r+OmSAJpnkQ1SwOJtFgm6t+++gki57ey6CarLJ0xuYc+A
 sY7xDprLuuxZ7TqFQp0pUNSBxMAqGtxju2xvOHzO3+SvJUyYw0MusuRV/13I502JVZlbcZC/y
 a96HUPlA42oVl79Bbmk0dLSkqNda1EnRW/S/UAY3QGZCCMiHyeXIRIGdMSKDPcVfEIa5MJ+Zj
 d6HsFb6qaGqWhvOXedPauEX7aSfBBkscn4fHu9VlEuxeD8ROKt/PDLUVuC6+lKLqQi5oacEPI
 EhMVqgFfIVJ5XCvaqno1Br4dp799aXmmKdbxoQukzrXh/svgMpUjfmlsChTy9dRMPAnb0EyHX
 u8vHalBxgwWBBx5wP27d5G05v1HWJ8b+FGw6+k+4/n+rT3RrqwOgorYUizSkBuCYusD/zmj+5
 irUbAnnMm76AXOGYICKYAzIKlYaUcQ7RLJ3B8lmYT1MV/kDx/0Trfvw8wCdvfCAqeG9pQoLYO
 EhC2MmSX+tR3aToCqw9fS2662krwwLT0YqW1R6jU2sTuoqzM4YxhONPFamR7jr3Z7esSbvc3D
 EWQ4nlw79eImr5iqUZOrx+zMxWRGxIXWB70HJNsmwV8B/nJFVeXrKnmafWsJOy0mWPD3b+zdY
 WgLv1OpqBp/PnM3pH46HaOfJUyNZcvxuyZC2Z4TYkDumVywaQff0YHXypAxR8mrh9thsDCisj
 O+ZN+OYHK1yoYu7COVSNdla+IxHQqRR8bsmZqr3Iwey3FGz3EkE8BstsaJMyT++d1CpN5Zt6Z
 JjbRFsmt96vRBBWPJenOx4OfQP3x3KbE8DNMkNY60Stc5omHHhEQQRu9bufve5BwRBecXbnj0
 /M7evJSOyUbwxKBfgNpG84WETmZ80Ho0s/t00lgM6Kem6qrfeuTkcDouYjdoMmmhUSYsSI1ac
 SQPWxPc5KAG1dIEQr8JJq/YWVfR3O6m+Wzyjzkud1ynItCIfjbiF5ZKcsqXnGNbpJCQPwn67K
 51S5nyQ/KPcDMnzqpBsgT+AMZcsQuaixn1zmioZKYlkNAyqKO02KrSDq75HZnJHo8ypOOzgDY
 W6/u1fEzXTwQkWcWR7z0bjq6xAjs6uoaN1OPhgwlmtvsKFLgNoAW/ttEg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, it was thought that failing to register a cooling device
would not be critical, so the probing was not aborted in such a case.
This however would lead to userspace being unable to rely on those
cooling devices, since they might not represent all fans being present.
Fix that by failing probing when cooling device registration fails.

Tested on a Dell Inspiron 3505.

Fixes: e0d3f7cb2606 ("hwmon: (dell-smm) Add cooling device support")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index 7f8d95dd2717..1dab7591576a 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -1013,12 +1013,10 @@ static int __init dell_smm_init_hwmon(struct devic=
e *dev)

 		data->fan[i] =3D true;

-		/* the cooling device is not critical, ignore failures */
 		if (IS_REACHABLE(CONFIG_THERMAL)) {
 			err =3D dell_smm_init_cdev(dev, i);
 			if (err < 0)
-				dev_warn(dev, "Failed to register cooling device for fan %u\n",
-					 i + 1);
+				return err;
 		}

 		data->fan_nominal_speed[i] =3D devm_kmalloc_array(dev, data->i8k_fan_ma=
x + 1,
=2D-
2.30.2

