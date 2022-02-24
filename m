Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F284C4C23F2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 07:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiBXGNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 01:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiBXGNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 01:13:00 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B005E23401D;
        Wed, 23 Feb 2022 22:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645683133;
        bh=Mb3YF6LNh1Tn63N2V2L8UfDPfSHx3GY0TsdhMMwZ8Uc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hDCiTKt7CkBj/c6pcvwp8/xT3uC98wT9Dp5GoHFJGhtrOQq+gTvMORi7Y+/AelgY6
         Tpqm8esAYTqg6MTTNkw/8jHAqdPkusZZgMIfZrfqI4f+ePVdnOHTuwI/H3IuIjV6RD
         513ghLLiOhny3WwcQiMwL+kZt+mKbpTCQZay4eAs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MRTRH-1nZ2081xpN-00NPNf; Thu, 24 Feb 2022 07:12:13 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] hwmon: (core) Add support for pwm auto channels attribute
Date:   Thu, 24 Feb 2022 07:12:09 +0100
Message-Id: <20220224061210.16452-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220224061210.16452-1-W_Armin@gmx.de>
References: <20220224061210.16452-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WcR05tWVrGreQVqALpf9O/Z9KH/Jv8dfAsNh6Mnr60OjMPyUN70
 6il9QpTHTHgCtVQ2RuVBExaHgXGiIkd6q6OYU+5OvKtvO7uO4/wPboprkojedXhHl2VC4kg
 9ZoquNvz+1ww2ZnabqFbptEHE9F8aTIc544Il6vJgRN6G5CwEKDkLLUiWwzowfEAnHCRzZc
 67HEPsVt880Z/GoSH/7ag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DGm0KxSSDQM=:hcgASVxeH33O/vzeK/HAuD
 xRzbltXi7YWGdscKBPAVv8sHV3YmbxqT2wl3iszn0gvLZpFZ4PeTTLKcGbmVibk7Bv3BesLcy
 zb/ngu0IyiTT2RUk07PajgrI2apfUnCh3O0cAMaMLqDwVQ4Tj9MgefibpsZjAnZQtsmoWvoZw
 mzHp+OWju1IhrR3HUmFwJZvG/8PZGjDlFzEQpGYY57Bh/UWqRHdR+W581XMBPwBDumuOpD67K
 CrdG8Jx+PR6nEXEw4ShaAdKYsuYZkT40Lxn2b05E19y5oVx4ymWU0jQ1EyJc0H8NCybayVn9V
 xyRoun778EmFmrqitz1SrQhHdHyZSnhFMY1B/5N1CReHMtLshD/ID3s0BA9cRFAl58z1rr9UK
 TMqoOKZSF1fTHGskx/OR+HYGZLMVun55TOZdPj4F11jJ7pq8xXhB1eGMEt0qFT028Y7LD0qYY
 /jwJiibCYavWc0Pl9PPGFLnSk0OVDo9YE/BrZp3fNzt4qYJUWJFAGeRkC3zN2GaaAynoAmSpP
 SNxwA1/DSpj48SDv8G8NRz92SNVqG2Uhy/KXqAwwRTiefW4K84qmuJBRxZSRFjU1dU64yIF0I
 4Dro4t7aIqIvIl1d0FU2/9+/CEcN4JLdr7pH9TzzowZwtxsxewvqYOSzy2Wm4ofVnun6e7Ssj
 jV1S5Uqmmw3WYMfzMbehTALVE9t+LnfTr9xE6i4hT93Jk9wnXvAVhe9vF+Q3S6xG41Pp1mNIK
 GdRyWPanCJHXmxAC6FMNk55Renewc58o2r9JLFUc9Q0XnSbd+pP2ispuiwMrNQrIFPyGtkdTW
 XcJoKH6kal60Bfu8JVLXGXiB/vh49yd1SIUUYOkTYGB1Ix67KUy4Y7b+ohr1OqfM+DOsFnllQ
 ybdjEgSr5Rz23irmUmIW0NzjWOCObPmyTlYyLQAHpXujdbRsNUmAwmigwo3sYqY5wpjsx2GEv
 ah45vs2uWQ1KU5W4+PO+AQz2Wvi/w+oTSKyfSfgdrnKZ2GkjHoN8Tvs2hkq3ARCK77G2rIEeJ
 UMNr3wmynANBwdT9rdJvUFCzHSwEDTpHg1BpgsYtLWKLJiIeAO4IdMnwnn1cuXzRbJpB3BVHv
 otKPKM20zfv3II=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

