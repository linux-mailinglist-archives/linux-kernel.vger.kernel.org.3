Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2934C1E4C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 23:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243507AbiBWWOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 17:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243412AbiBWWOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 17:14:32 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5797506F4;
        Wed, 23 Feb 2022 14:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645654426;
        bh=+cTbGTbHIG9AuxX1N/8CTj6GaxahkL2vJGZG6ewkOvE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KCazj3dmDGh05/FjxirTOTB3hpBbyq23KnwwCh3yg2SymrUOVMVGV81a8QbXuyHIL
         9os3cEG9SNn7dMiinikz290kbb2Phd9k4gB3gaSvDWPJdFlO+yPlSQqvIh0NZggbPK
         XefhjEbmN2e4+fBUFt2x1vISIZ7BN9BY8gqaSPlA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N5mKJ-1oK0X43Jut-017IAI; Wed, 23 Feb 2022 23:13:45 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] hwmon: (sch5627) Add pwmX_auto_channels_temp support
Date:   Wed, 23 Feb 2022 23:13:34 +0100
Message-Id: <20220223221334.3993-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220223221334.3993-1-W_Armin@gmx.de>
References: <20220223221334.3993-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M1PgcwCpZ4QXnE7r4Zqy4DVYSeBDK0siG6XRiiwZU7aTg11P10x
 zNx01QA1Ra8XelVopZXLI0SP4iQXpWs5qe/uXaL7HxJlF+Wga99h3OLPLHel0KcBpPqyKpA
 L7JjvJh9/jo2CZb3lYdDcVff9E5d+jHRlUzM60Fd4W/qEeYwF4TG/ahgPfAEjyRGtyNPXjQ
 VHPbWj/zsWBSlbtyK+axg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k+8zKpcnUak=:Z6b1gEBgo6XTR27Xr51o9o
 7ad9x7nqhSkSAptJt53ZkqxbXjqScXXYxbTySK24LmQxjCAOLuZ+uw52m3l9A9IXAR1KrnoyU
 Wl2vzPYVAeIn0PRe0+067HFScBEp1alCcYrNAXVQlj2XJFeuGgMb4te3FF4qPmaXnYwp1yxO1
 yFBayrdNlRCoZYqwOnRW8jAfLgKZDLUM3IedKHenafC+L8SthJ/cMPYfBh9FbALbpCKIHWHb6
 tMw6hlcpGYgA3gc1w5AUCQOVrDjIGd4+UxYC+t6ehZoOiKAGr/xwmTU6zvHYi9vJgNsSWsS6E
 CetH5Rcd8FjAGgmGvRjEppyjApACieQGqhVJZwS3gpihrYtMCPKrIs4uc8X267mMiqUjdhTVV
 ExjdP170gXfPdvWObHM43Z4uNhMCKdM/5AWEe3lypK20h0yxoDi4Z/NAfeGhwBy/h3XMHmjVr
 FXZdoWzwfDydHgnVXXYignTMRgMHGZb5oBnElQzGqevRTWvEITWXQyAwP/XT+mlUCDLcfIhY1
 4B5hxycynWTUP4EquhCTmJxEw3OFzJzLPwHNH8MQeZaCGK3Qt8YW81FpBgROnqQ0yUe4D17+q
 Ka5aMgbFAUTpAAYx8sx4MehKLu/k6OsXSVoC41Iphn7+vQi/WQRIjdnUa8Y5FY8LImY809znK
 TSdbbSi+Mib1SIwiiOdvR9uRQRRjno2xPBQd/xEIYgqbrVL/P46XKvv3iZLwAzitPG3Z2+Ecy
 jiPwfJjAkj2q8mEzVuLNvr06fFwXK3rbkhNlDtZz7YBTGgGllODxMWHmDgwOctKKX23nNplDT
 KAWdYe+fU1/fEYBnFu5CnzPAO5RbM52Q8R4TJwGt38TC6vrJus1cM0JZV1mnUug2BI3RmvQza
 nGZrb0UjZU/tcgWTMNEtwUyT+YKb3tb7j6z376F6bw0IbMagHfOID8ohcZQMwpXqPMJa9v3Fv
 tthE0mYuUZB9Z0ZgFGx+nhCKzHPHO8Fx7B7R57XaQeAdNis/dVh+l4gq2IwL/jw7w5COxXyhd
 DuZ9aVafItVquTQxk4UiLpPosKP+oLLGanfsnMkSnE78Vxr6JT5hpEiSMhBe2mBWXttK1RdpD
 DsD6lZ+tuDP01Q=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/hwmon/sch5627.c         | 53 +++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

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
index 72c3f6757e34..d166b6398645 100644
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

@@ -278,6 +284,20 @@ static int sch5627_read(struct device *dev, enum hwmo=
n_sensor_types type, u32 at
 			break;
 		}
 		break;
+	case hwmon_pwm:
+		switch (attr) {
+		case hwmon_pwm_auto_channels_temp:
+			ret =3D sch56xx_read_virtual_reg(data->addr, SCH5627_REG_PWM_MAP[chann=
el]);
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
@@ -318,10 +338,37 @@ static int sch5627_read_string(struct device *dev, e=
num hwmon_sensor_types type,
 	return -EOPNOTSUPP;
 }

+static int sch5627_write(struct device *dev, enum hwmon_sensor_types type=
, u32 attr, int channel,
+			 long val)
+{
+	struct sch5627_data *data =3D dev_get_drvdata(dev);
+
+	switch (type) {
+	case hwmon_pwm:
+		switch (attr) {
+		case hwmon_pwm_auto_channels_temp:
+			/* registers are 8 bit wide */
+			if (val > U8_MAX || val < 0)
+				return -EINVAL;
+
+			return sch56xx_write_virtual_reg(data->addr, SCH5627_REG_PWM_MAP[chann=
el],
+							 val);
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
@@ -342,6 +389,12 @@ static const struct hwmon_channel_info *sch5627_info[=
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

