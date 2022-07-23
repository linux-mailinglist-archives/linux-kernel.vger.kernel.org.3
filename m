Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6A757EBB6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 05:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbiGWDjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 23:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiGWDix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 23:38:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E3F30F57;
        Fri, 22 Jul 2022 20:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658547517;
        bh=jsCktH2Bn26ZwcZVYKiIPsFC09HYGgUmcICp35CE6wQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CBRkdoBK5jzSCVG6bMPZWjf3/fyN6F98O7XvkYO738MZcWfsWQqWPH/bEeQG5ajaF
         PxJ/KDlodzuG6RmeCv6Le8MPxnFsprR8F3Kub074V93qAWROVIX7iSoUSd9crYEhrb
         pS3UsKc4WtXUnLh58puxM6flcgRG7LCWU5FBSLpM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MjS5A-1nm2o311Ra-00kz5s; Sat, 23 Jul 2022 05:38:37 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] hwmon: Add pwmX_fan_channel attribute
Date:   Sat, 23 Jul 2022 05:38:19 +0200
Message-Id: <20220723033820.22612-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220723033820.22612-1-W_Armin@gmx.de>
References: <20220723033820.22612-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S7Bt8qp8QA4dr1j9OOvFH4ZHB6y1Qr5NU1MRcLWLCNk8rvNLVCN
 uFFr6E7dObsy46Z8hKXVbm171kKgfI8oNIsIW7zsk8VhfZEKaWnc95Lg55WiDDBmXaSn+mE
 6nR4snVh+bvNRTPkTxva7Xq37g+4RxwXOpjJWBGgzPAnDUyfOp2WWd4W8yJk/9B6o9W6W40
 DfAlMxLSDmY/bVJfZfDvg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9u+4JG1hZX0=:wjyk+/3VWYoPCGK6WS9kuZ
 RI3U7QCijcnZF1R36/5Mq756LPZvl62QVN/T8g9sptoWbgTvalojmfLgvmHKYkkqTfQn/6cCq
 roinfBoVBl6KMdTpzwUzJRekmV2i2difFYakuN1BUWfGevGBp5stHFzRz1S4JQUsoMa85eQjB
 QzXNNacq2wAm9+xctk7M+hei/hztM37fydVsP/Kagmv247RL+tT39VyFNoRc4X03PvKjq8G82
 ZHjVJ2JG79PA0UZQLkzS/jbC6MuVksaE4vsl3ZRfIKyrW49xHTJh3qqgASQfcw4FSmLKuYfL8
 SXs3vGLJ9AYANpHJSewYD/FoVhXXnW+zDmZvmRCosPeR3IgDO14HADaO4Ez0UaZ7RJv8OGes0
 EvYyjU8NgjNTrP51bxP4NzxcQYXK9TxhzKR6JzdQ8F7HKKnhD3DxPPWjHbQaHo//uhuVrAiRb
 3qOFtoGLtQqNgTQb5EfRrrn7rKiQ/4fNODB9mAL9JW0QnJ2/UyQLVOXL9OebKifUiwJmBW/3M
 GOAiS7JFL414OBVwu91UAK4WFWoE+SK2POxt36NnCC/+P2THfqxgcqI5hWXOGuR94w8jk3zyA
 Kp6bhtu1KJpkoZm4J64kvo/aJNvpdMIkauVFPsM9NIphtkPEjCtBf+y6odMD6EGLt+5DHVBuF
 oQCy+8CrNTKkudfSJhXvYeGrb+mMQ1ZzFVATj9sdIc4BaVa5gHNTAArjXXgCiTKtZAtRMCwcs
 TWeUxSgDOEJOHt2EG0Bx0/a3LkylKDO4LGzMysFQoKH6YWiDlo4MzKYNp8HpCDD7T2E2eidM0
 OSvwSC+D6E2aN4XC/4XJWXCtoWbHF3/K9Z4Ccs0d88gjIy1UBAfFUN9k7lyBJ88+z+TXhQQTy
 KVx2qbcwfXXCmL1HmPxdNvo8su2hjpdNT+4Xqvu+gbDhYOLobeU40Y6ZZqiipC5fE1Vco9dF/
 x17F88FuWu5geFYeH0oezUoiE8hjWopi7YgPYxRlCa/aol9MNP6aDbxFxu8p5rC+fsh2A1E31
 rsrThaORJ/Pn6OO9VzSgMRUb799z/qqssIYmrOwNFfSzN6IZXAJHaow54mDLWsl4kNRuvk7sc
 Ro0Ounci07E4KWZMfsOBZceQ1TDrCtK/567KyavFgec+tTjcNjIfj0iXg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now, userspace software needs to guess which
PWM channel is associated with which fan channel by
probing each PWM output and watch for fan speed changes.
This proccess is error-prone and unreliable.

Some hwmon chips, especially firmware-based ones, already
know which PWM output is associated with which fan channel.

Allow such chips to export this knowledge to userspace.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/ABI/testing/sysfs-class-hwmon | 8 ++++++++
 Documentation/hwmon/sysfs-interface.rst     | 3 +++
 drivers/hwmon/hwmon.c                       | 1 +
 include/linux/hwmon.h                       | 2 ++
 4 files changed, 14 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-hwmon b/Documentation/A=
BI/testing/sysfs-class-hwmon
index 7271781a23b2..f3d653bcf736 100644
=2D-- a/Documentation/ABI/testing/sysfs-class-hwmon
+++ b/Documentation/ABI/testing/sysfs-class-hwmon
@@ -315,6 +315,14 @@ Description:

 		RW

+What:		/sys/class/hwmon/hwmonX/pwmY_fan_channel
+Description:
+		Select which fan channel is controlled by this PWM output.
+
+		Valid fan channel/PWM output combinations are chip-dependent.
+
+		RW
+
 What:		/sys/class/hwmon/hwmonX/pwmY_auto_channels_temp
 Description:
 		Select which temperature channels affect this PWM output in
diff --git a/Documentation/hwmon/sysfs-interface.rst b/Documentation/hwmon=
/sysfs-interface.rst
index 209626fb2405..17fcec03d3c5 100644
=2D-- a/Documentation/hwmon/sysfs-interface.rst
+++ b/Documentation/hwmon/sysfs-interface.rst
@@ -209,6 +209,9 @@ PWM
 `pwm[1-*]_freq`
 		Base PWM frequency in Hz.

+`pwm[1-*]_fan_channel`
+                Select which fan channel is controlled by this PWM output=
.
+
 `pwm[1-*]_auto_channels_temp`
 		Select which temperature channels affect this PWM output in
 		auto mode.
diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 2e2cd79d89eb..8c2d7574c461 100644
=2D-- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -604,6 +604,7 @@ static const char * const hwmon_pwm_attr_templates[] =
=3D {
 	[hwmon_pwm_enable] =3D "pwm%d_enable",
 	[hwmon_pwm_mode] =3D "pwm%d_mode",
 	[hwmon_pwm_freq] =3D "pwm%d_freq",
+	[hwmon_pwm_fan_channel] =3D "pwm%d_fan_channel",
 	[hwmon_pwm_auto_channels_temp] =3D "pwm%d_auto_channels_temp",
 };

diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index 14325f93c6b2..9d40cc1e520f 100644
=2D-- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -332,6 +332,7 @@ enum hwmon_pwm_attributes {
 	hwmon_pwm_enable,
 	hwmon_pwm_mode,
 	hwmon_pwm_freq,
+	hwmon_pwm_fan_channel,
 	hwmon_pwm_auto_channels_temp,
 };

@@ -339,6 +340,7 @@ enum hwmon_pwm_attributes {
 #define HWMON_PWM_ENABLE		BIT(hwmon_pwm_enable)
 #define HWMON_PWM_MODE			BIT(hwmon_pwm_mode)
 #define HWMON_PWM_FREQ			BIT(hwmon_pwm_freq)
+#define HWMON_PWM_FAN_CHANNEL		BIT(hwmon_pwm_fan_channel)
 #define HWMON_PWM_AUTO_CHANNELS_TEMP	BIT(hwmon_pwm_auto_channels_temp)

 enum hwmon_intrusion_attributes {
=2D-
2.30.2

