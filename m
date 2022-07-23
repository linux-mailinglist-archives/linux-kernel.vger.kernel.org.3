Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0704757EBB7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 05:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236524AbiGWDjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 23:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbiGWDiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 23:38:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613FF10FFD;
        Fri, 22 Jul 2022 20:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658547518;
        bh=MBXn1mSzKXr07dHlRQkghNEdOJEuzq7EyPsMxlX1t64=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=HSjl2NJqaYxJrh7rjuiqICV8keiMEuUOB2RzHVdVdmcKjnElidtk5Dq5UZuHVyauz
         7JJXXsRzGBIyZsCgM32HdbrHkVzdZvD6Juv65fmAsLjLyFOCzmB0W9t59uVa8VeTox
         OKm2YOSGrWXYNZOYoW0S7MRWuQpz1X5sKxht5u34=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MeCpR-1ngJ7R2Wff-00bL4j; Sat, 23 Jul 2022 05:38:38 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] hwmon: (dell-smm) Add support for pwmX_fan_channel attribute
Date:   Sat, 23 Jul 2022 05:38:20 +0200
Message-Id: <20220723033820.22612-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220723033820.22612-1-W_Armin@gmx.de>
References: <20220723033820.22612-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wPeN1JJb3xvUYWpN4DN3qE04tkDVlsjCRc9no7P9GJpsaVHbCxW
 4/jEKKbwOfJCheuVV9Mq7Cb0PW6AiZuew6EHLqUkNLyw8GLbphPMX1J3Xf5N5F/uTGJLG1J
 0okA6crcvyJ9TktPO8CP3GvbqnHnU0tWxpDEoKcfIlwKg6CQ11zMzE4aHXt4vuyqKN/ZuzE
 Te3AHzDqEpiwBLOCwWx0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CuYyjPeY4Iw=:h0kzkYv/QDBtbjnxELLfZ4
 Rkwz/af90d2p/d+4ZsjY/+HIjoJ6/tdPffgVUbkniEBSR1umMnjC8YJ1JCs3cqc2WwayCJLSK
 U8ODHFhPyGaR/gtDMSiz3F/QxqP9OYB5NRHTgHNpwIiUVOZZc6NsLQ6LGDKDrQzzqhB70QJRG
 2+I/JGXsbh0n4z4YA+4ST71XsBdUnMo+bNLkdN2AeSrRpQOlyJt0tzDrIOnkD4wFgJqjoGzxI
 PwIp8+OiFMxp0TCETioEcw/hP8KaOiJ77aS8MFporTV3pbWmJW/wEBycPZ8rrurRYADw6Q/3t
 6iJCH+cxkTLXl9EpIxEhQYWSEk0MtsgBaDWXtFORBWPl0BlBLxC28iTQf38nylgcfyaCPT6bp
 bdUZxx5LrH0w01TzBgfzlAzb/uraAsD9g1YikC5TemgssoOtiofqMCl3ha7o1TkOU8KPQUNmv
 2M/xvO5TANFmi0mHIJ1G+DJ2p6SFUKUUPmf4iK5yakGEhv1fMcUUo7fyKNhclq4crJCPtSnQ8
 +VWbFMNDaO4mxlWfuZvC4SQLqnp5nziWq/lyWAqmkLDw8Ne4wQVWWxlrGYmPG+ewJZoTucocL
 RqDa/NxZCM1/ZJf8wQquB79HoOxK91dXA+Ha+yio+1fr2IFNY1nx7vb+ZQtdkBNOSH9WSOW5/
 mtbBE8A8fxQdVqolameJuQB79EDbJYwgU+xk30snBFy5JNXhV7gXVCJuUdY0xjQh68K7GXQ6e
 Th4XMzdyySNF9YdmBy/n9AZJsI6NXqmsqL56NYF64Cp52g+Kf0eVpwi0l3kxyKbCz0D57/B46
 9SO/YjVFbcNEoQyUW7tlCcUEVU3bWxDfv1XZehmzi9LLTHQwKxfYVrESxpaoN1a9VovHZ4w5b
 QYcWzihz9yH4xB48qTT9z7N4jltrngheaqkh67RaHF8maqVxcTDcm+MZ3IC8zxS9XqRyXtUWw
 BzS0uX6NTRX1f57B7ft6NjSFwz1KlSkr5crrSmdIrK1+7mj6IQ/FefKl/K3mfJcNuzrCwGTAt
 Hf/4+lxklyE+XzQuMFQfzTmXJ5wbkeiqpS8wifSjYf5lFLaK20AAqrp8Tdgp5cHQ6BAg3Sa2H
 TsnVkMrovJ4vz65kkle2N5sc4DBMSdaC3FhtLicIm6VaunP3+KITGLORQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SMM interface does not differentiate between fan channels
and pwm channels, so each pwmX is associated with fanX_*.

Inform userspace programs of this with the pwmX_fan_channel
attribute.

Tested on a Dell Inspiron 3505.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/hwmon/dell-smm-hwmon.rst |  1 +
 drivers/hwmon/dell-smm-hwmon.c         | 15 ++++++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation/hwmon/=
dell-smm-hwmon.rst
index e5d85e40972c..2b0651c3f7c5 100644
=2D-- a/Documentation/hwmon/dell-smm-hwmon.rst
+++ b/Documentation/hwmon/dell-smm-hwmon.rst
@@ -38,6 +38,7 @@ fan[1-3]_min                    RO      Minimal Fan spee=
d in RPM
 fan[1-3]_max                    RO      Maximal Fan speed in RPM
 fan[1-3]_target                 RO      Expected Fan speed in RPM
 pwm[1-3]                        RW      Control the fan PWM duty-cycle.
+pwm[1-3]_fan_channel            RO      Hints which PWM is connected to w=
hich fan
 pwm1_enable                     WO      Enable or disable automatic BIOS =
fan
                                         control (not supported on all lap=
tops,
                                         see below for details).
diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index 7f8d95dd2717..e6bf65d2ffc6 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -713,6 +713,11 @@ static umode_t dell_smm_is_visible(const void *drvdat=
a, enum hwmon_sensor_types
 			if (data->fan[channel])
 				return 0644;

+			break;
+		case hwmon_pwm_fan_channel:
+			if (data->fan[channel])
+				return 0444;
+
 			break;
 		case hwmon_pwm_enable:
 			if (data->auto_fan)
@@ -800,6 +805,10 @@ static int dell_smm_read(struct device *dev, enum hwm=
on_sensor_types type, u32 a

 			*val =3D clamp_val(ret * data->i8k_pwm_mult, 0, 255);

+			return 0;
+		case hwmon_pwm_fan_channel:
+			*val =3D channel + 1;
+
 			return 0;
 		default:
 			break;
@@ -943,9 +952,9 @@ static const struct hwmon_channel_info *dell_smm_info[=
] =3D {
 			   HWMON_F_TARGET
 			   ),
 	HWMON_CHANNEL_INFO(pwm,
-			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
-			   HWMON_PWM_INPUT,
-			   HWMON_PWM_INPUT
+			   HWMON_PWM_INPUT | HWMON_PWM_FAN_CHANNEL | HWMON_PWM_ENABLE,
+			   HWMON_PWM_INPUT | HWMON_PWM_FAN_CHANNEL,
+			   HWMON_PWM_INPUT | HWMON_PWM_FAN_CHANNEL
 			   ),
 	NULL
 };
=2D-
2.30.2

