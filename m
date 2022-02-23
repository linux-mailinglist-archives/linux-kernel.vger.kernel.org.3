Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984E04C1E4D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 23:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243425AbiBWWOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 17:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbiBWWOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 17:14:30 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CFD5047F;
        Wed, 23 Feb 2022 14:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645654423;
        bh=Mb3YF6LNh1Tn63N2V2L8UfDPfSHx3GY0TsdhMMwZ8Uc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=T4G6WFaM0xbC2DdABjzPM0GTOyv51GPNkzt4xN0TqpYHQLax6iaESkStuML1b/yDN
         1iPa0FtfAX5lsmnMS/I7v70W7qCZL3aFjvdYBWjf5BdMkg9k9Xr6czKunXDjF1CAva
         GeFxIX12ARLDTCBlxDlLM5ADljeVQ9JAjEtNy9ts=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MryTF-1nzaEc1pSf-00nwqx; Wed, 23 Feb 2022 23:13:43 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] hwmon: (core) Add support for pwm auto channels attribute
Date:   Wed, 23 Feb 2022 23:13:33 +0100
Message-Id: <20220223221334.3993-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220223221334.3993-1-W_Armin@gmx.de>
References: <20220223221334.3993-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xmvWvg7Ay7fwmz99F4ohQDSVOeKFj9/4fu2gxKwiGOGrmZE+1zE
 2K53k5ZwZev8U2xW9hQSn1Asq3VzIdaQOseldcCZRa8Iy/DiRlqYyuCICyuqmY+6kKFMAd/
 SKQ7jWMYnqamA42QiXCasXduoaR1kj6jBAcWyxELVAqfcWizCtVeLwYLVW+5JpQCErHS1ZJ
 VKeNvadD8GgSlEqFI77mA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DQ0nGXG2fnw=:gobnGMRbiGa55k2XSHhr9A
 JGZdy8/MfYKF5PHIjBtkk/hkSsSnqJ0vrOL0dEhS2MrxEErbO6MTX3PJHwLjr1qQ018Kks1ZO
 J8js0YVzXH1R8/+z8FymAgeVVi1CQ6Zl97ukczAI8Ba5ev0yxohBs9ZMJCiWNEhlD7wdmOx8B
 lsqHyfka6T5DGnBUOAAjiS2GmHFTNduZxoMZIizLopNbb1Xyskbc6SPVW9qOAUi/2C4O2tSWy
 xSqak9wohYYfCIh92y4gGc+C8g912Ij/2b9QF5DPNpdkTwJsCOe35Fjrcy6nowKxosav8TyB+
 w0SVzBE+TwRlNUPooflNBLds7OVa369q6sQPPLtd2jWQKNJT6b2GgbztUasoYo+gPsQzrziHy
 WvMQLDkbfECOPm5smbK0cFA58I3ehK9lJIP2ykL6THpA85wO1YNuWLKdSf8nYsmf+MR3+up3t
 7Qkpoi6lhpQj/Ez6eVnVq6Ges6UpMVi6W4cYW5froOPSuX6nE5eJLx8sers89iIcKXWIK8fQD
 +BVmRrLLpzBn6u7n8Ou9Jlu2k5hW8gP2efc/YYhfK61VcJnWXIE9OLPqoDQNZ3sZ8LJDEtzXi
 EZV1oE11cFkO7M9BDSuYObLZY4O/LEDnp14uyDwyNMTxRy5S/yQVIie1K0cIkn2750+UcevVv
 c1We53G2U6iTeytZlTq3694fzCvaxk7VUV+C4+IlkpmEW7mdmR+/1unvmIo7nsVcmXxwY1ZjP
 6ucOW7wojw2sO1uw8EaIePr0tBwxeOQTNWG2SK9zuvjWttVQVeVDlCWpAPiu3VtnNrWtPwrrV
 r+4+HPqE4h7X1ZyKpV9nfbNiZtdfVR4Tl/Q4iDn+iVdWEl+eTKMs2srY7xUz6ayOzvWZu0QGb
 EYEA3tWU8pzBbE++01qyK2l9uUDtIQyAYdOVi19IDVRJgTVOtQUdKXlieN6O6oJOX/f+yIE+K
 VqxCjXLwCMRitxg5xNRbo513D7X/ZbUkkkOk8RImRDEcYPegUVGupeTxZdxPjt8J/3QYKNbKU
 dgRk2NGgAIMz6FFMOi5ExztVjv8Gysqfa4noAFKrMMhUUQg8pYBu8b/7g52V5BA65ttHdergB
 /5im1bZNmqBS/g=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pwm[1-*]_auto_channels_temp is documented as an official
hwmon sysfs attribute, yet there is no support for it in
the new with_info-API. Fix that.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/hwmon.c | 1 +
 include/linux/hwmon.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 0d6c6809f26c..989e2c8496dd 100644
=2D-- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -604,6 +604,7 @@ static const char * const hwmon_pwm_attr_templates[] =
=3D {
 	[hwmon_pwm_enable] =3D "pwm%d_enable",
 	[hwmon_pwm_mode] =3D "pwm%d_mode",
 	[hwmon_pwm_freq] =3D "pwm%d_freq",
+	[hwmon_pwm_auto_channels_temp] =3D "pwm%d_auto_channels_temp",
 };

 static const char * const hwmon_intrusion_attr_templates[] =3D {
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index fad1f1df26df..eba380b76d15 100644
=2D-- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -332,12 +332,14 @@ enum hwmon_pwm_attributes {
 	hwmon_pwm_enable,
 	hwmon_pwm_mode,
 	hwmon_pwm_freq,
+	hwmon_pwm_auto_channels_temp,
 };

 #define HWMON_PWM_INPUT			BIT(hwmon_pwm_input)
 #define HWMON_PWM_ENABLE		BIT(hwmon_pwm_enable)
 #define HWMON_PWM_MODE			BIT(hwmon_pwm_mode)
 #define HWMON_PWM_FREQ			BIT(hwmon_pwm_freq)
+#define HWMON_PWM_AUTO_CHANNELS_TEMP	BIT(hwmon_pwm_auto_channels_temp)

 enum hwmon_intrusion_attributes {
 	hwmon_intrusion_alarm,
=2D-
2.30.2

