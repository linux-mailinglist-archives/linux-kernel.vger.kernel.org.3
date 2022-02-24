Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DD34C23F3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 07:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiBXGNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 01:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiBXGNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 01:13:01 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5180423400B;
        Wed, 23 Feb 2022 22:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645683134;
        bh=z3PgjpSeI45p8e/Kj/ULmEws1DrF6f9e5OhfTUmeyrs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=LArIAWTPOrSw33/npDGbYQYcSBa1u6FQnZLZZPz5k/Erv8E2uEmjPQx9FGmOc6QF3
         BlVR2cIIrwYNZxMeKHRPZqBRzzINkV73dQ/uBmpcqT4NW41Th7pq7zWTA8xcqzhCcQ
         eEG8JKaXwFqD4oXSr3GGpffNZw6+xdhVH+P+heEI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MlNtP-1o63Pf36qL-00lmSA; Thu, 24 Feb 2022 07:12:14 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] hwmon: (sch5627) Add pwmX_auto_channels_temp support
Date:   Thu, 24 Feb 2022 07:12:10 +0100
Message-Id: <20220224061210.16452-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220224061210.16452-1-W_Armin@gmx.de>
References: <20220224061210.16452-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6LzVNnlmx1VGAgyWfxK4fWce312xtxahIHUVXlu4cZNAV/3H0ZO
 BCFSfpp61O621PjFeFqR5LGPvg4J++3E41dq+6qpcWVSJ1R45SoZrp8sA55LUYbtDDVHWLv
 XN+AdfcpbccRf1xHPrp3RVoR3wFg0Lwd2TNsxM/cotVdriFDtsbMiUODzegABlhiDIbyyA4
 aNz0+l4rx5LnVnOZ0vhHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b7sw0nFPI0Q=:LTs5LGlmNBU7Gkp47C0ttd
 TuQGI5/CuGtGErgqXll2u9y+j2N4uzFrmlHFDq+b11mlxfwQgJ1aM2bK5Q57Io5j4S/ubB+fy
 8fLMupuawEPLFSno2sg+mf/wMBWrmCi8SyC5pSascsq/0vWmQE6ZqogZr+sMQNGXaLWZf2vgw
 S5r8aNy4NCHh7+hUyh+F/VJV49CRoIdnrU7Ai9ov2kvBJPWr2hdR4qy5XE88bKUDtGxqKemRK
 S4JxGzMdkCMqeDNZQrlVmlmC1DEV08KvSBi0s4oEq7nWPoWwcFenIB00KN6777eozKZIcmabi
 Fp4y4LBujyMi/6GoSzqWFJrPLqGHGJclV/5vxUR2z5CoX9JF9aBmgTOkmZsmE1/sxY0dLrlfD
 ol4PWkOwK9KYRtfnJ9pV61uiIusJQMCSykWSeS7OD/M3eRkWCINzG/WnmpmVARXYKV/UyCGsq
 j4tQjnWDvYArFlbZZVA27u8ZWDMwWYK3Io/htAfyWfmCQ4wo6EQkLTwLW/YiJXVsIP+exwjO7
 /sB9iJKQ/YhDEwaIemnFWliikHXo3G7lBH3AVsTfgoCcbfHGjaVhvFVLqA7l6oJBCw2zlyxDz
 CWda8N+5s6UgoOlp8grDe2uuvdi7o7W/UV7JzCtXCSLJvpuGN5ShSjg5qNFWECqiytxNSU0i4
 dWgj2Wy7KKfRVSJL11jHP/Iy2e1OEtmQSHztvrETF2o544ZUVKi70Qf5JuYdJsKNLYzmfTQPK
 hdVtz/t+UohDbYMi1Wo2pWLhigZa2x1ucTCiI8SaxxxGieqsVi4+KaPN1YDDDehn3LwXy5AFe
 QasTuR19j0oyXVN7aQIB46DGvXfhT5ynn5oorklgmtub9cEDMgXKropQBDuZsiHUr/uEdCNa0
 vrehp6Q5rMSqU1TM7kRMEbY+203451W82zwxtAemqk91Rvui/PfaF3BAYqCYZpq4fYSE+o2Nq
 e39OXik77Z6PmrSUxGV3F+oMHe0B4sW33qm2e9ohTiOodd46LNpFweglCjSAuX88rpXlZj6k2
 +yLlmCa30xxl2g+ciAXHtDs1jlHS7elw7z/khk8ZSc9pwnXJEZvkwYGc0uTnukJC73GkM5bu7
 xJzNSpz8HF/tpA=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After doing some research, it seems that Fujitsu's
hardware monitoring solution exports data describing
which temperature sensors affect which fans, similar
to the data in fan_source of the ftsteutates driver.
Writing 0 into these registers forces the fans to
full speed.
Export this data with standard attributes.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/hwmon/sch5627.rst |  4 +++
 drivers/hwmon/sch5627.c         | 61 +++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/Documentation/hwmon/sch5627.rst b/Documentation/hwmon/sch5627=
.rst
index 187682e99114..ecb4fc84d045 100644
=2D-- a/Documentation/hwmon/sch5627.rst
+++ b/Documentation/hwmon/sch5627.rst
@@ -20,6 +20,10 @@ Description
 SMSC SCH5627 Super I/O chips include complete hardware monitoring
 capabilities. They can monitor up to 5 voltages, 4 fans and 8 temperature=
s.

+In addition, the SCH5627 exports data describing which temperature sensor=
s
+affect the speed of each fan. Setting pwmX_auto_channels_temp to 0 forces
+the corresponding fan to full speed until another value is written.
+
 The SMSC SCH5627 hardware monitoring part also contains an integrated
 watchdog. In order for this watchdog to function some motherboard specifi=
c
 initialization most be done by the BIOS, so if the watchdog is not enable=
d
diff --git a/drivers/hwmon/sch5627.c b/drivers/hwmon/sch5627.c
index 72c3f6757e34..25fbbd4c9a2b 100644
=2D-- a/drivers/hwmon/sch5627.c
+++ b/drivers/hwmon/sch5627.c
@@ -52,6 +52,9 @@ static const u16 SCH5627_REG_FAN[SCH5627_NO_FANS] =3D {
 static const u16 SCH5627_REG_FAN_MIN[SCH5627_NO_FANS] =3D {
 	0x62, 0x64, 0x66, 0x68 };

+static const u16 SCH5627_REG_PWM_MAP[SCH5627_NO_FANS] =3D {
+	0xA0, 0xA1, 0xA2, 0xA3 };
+
 static const u16 SCH5627_REG_IN_MSB[SCH5627_NO_IN] =3D {
 	0x22, 0x23, 0x24, 0x25, 0x189 };
 static const u16 SCH5627_REG_IN_LSN[SCH5627_NO_IN] =3D {
@@ -223,6 +226,9 @@ static int reg_to_rpm(u16 reg)
 static umode_t sch5627_is_visible(const void *drvdata, enum hwmon_sensor_=
types type, u32 attr,
 				  int channel)
 {
+	if (type =3D=3D hwmon_pwm && attr =3D=3D hwmon_pwm_auto_channels_temp)
+		return 0644;
+
 	return 0444;
 }

@@ -278,6 +284,23 @@ static int sch5627_read(struct device *dev, enum hwmo=
n_sensor_types type, u32 at
 			break;
 		}
 		break;
+	case hwmon_pwm:
+		switch (attr) {
+		case hwmon_pwm_auto_channels_temp:
+			mutex_lock(&data->update_lock);
+			ret =3D sch56xx_read_virtual_reg(data->addr, SCH5627_REG_PWM_MAP[chann=
el]);
+			mutex_unlock(&data->update_lock);
+
+			if (ret < 0)
+				return ret;
+
+			*val =3D ret;
+
+			return 0;
+		default:
+			break;
+		}
+		break;
 	case hwmon_in:
 		ret =3D sch5627_update_in(data);
 		if (ret < 0)
@@ -318,10 +341,42 @@ static int sch5627_read_string(struct device *dev, e=
num hwmon_sensor_types type,
 	return -EOPNOTSUPP;
 }

+static int sch5627_write(struct device *dev, enum hwmon_sensor_types type=
, u32 attr, int channel,
+			 long val)
+{
+	struct sch5627_data *data =3D dev_get_drvdata(dev);
+	int ret;
+
+	switch (type) {
+	case hwmon_pwm:
+		switch (attr) {
+		case hwmon_pwm_auto_channels_temp:
+			/* registers are 8 bit wide */
+			if (val > U8_MAX || val < 0)
+				return -EINVAL;
+
+			mutex_lock(&data->update_lock);
+			ret =3D sch56xx_write_virtual_reg(data->addr, SCH5627_REG_PWM_MAP[chan=
nel],
+							val);
+			mutex_unlock(&data->update_lock);
+
+			return ret;
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return -EOPNOTSUPP;
+}
+
 static const struct hwmon_ops sch5627_ops =3D {
 	.is_visible =3D sch5627_is_visible,
 	.read =3D sch5627_read,
 	.read_string =3D sch5627_read_string,
+	.write =3D sch5627_write,
 };

 static const struct hwmon_channel_info *sch5627_info[] =3D {
@@ -342,6 +397,12 @@ static const struct hwmon_channel_info *sch5627_info[=
] =3D {
 			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_FAULT,
 			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_FAULT
 			   ),
+	HWMON_CHANNEL_INFO(pwm,
+			   HWMON_PWM_AUTO_CHANNELS_TEMP,
+			   HWMON_PWM_AUTO_CHANNELS_TEMP,
+			   HWMON_PWM_AUTO_CHANNELS_TEMP,
+			   HWMON_PWM_AUTO_CHANNELS_TEMP
+			   ),
 	HWMON_CHANNEL_INFO(in,
 			   HWMON_I_INPUT | HWMON_I_LABEL,
 			   HWMON_I_INPUT | HWMON_I_LABEL,
=2D-
2.30.2

