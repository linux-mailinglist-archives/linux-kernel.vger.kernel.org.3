Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA314A3F48
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 10:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237067AbiAaJej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 04:34:39 -0500
Received: from mout.gmx.net ([212.227.17.20]:35521 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231674AbiAaJeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 04:34:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643621659;
        bh=JpB5EeGsjEKA7C7A6LOk7832eX0tDl/y70K+UIb+d8I=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KjWRrrz1sczRuvggC8OOTPGY2jrtcydXdkOZDHau+YRwo1Z2YvF/KK79zH3/x+QKl
         T8zmKESeU+TkymzbbuzIvHmSfHEMRVVDcHfoWJ/JOh53beMc8oV+OncCDKFiHI8UVc
         7rgE4hE6k5qY2zzLZ72nd1+6O20OFMMvVtxyIRSA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M7sDq-1n9XOD0fcw-0053u8; Mon, 31 Jan 2022 10:34:19 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] hwmon: (sch56xx) Autoload modules on platform device creation
Date:   Mon, 31 Jan 2022 10:33:52 +0100
Message-Id: <20220131093355.4151-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220131093355.4151-1-W_Armin@gmx.de>
References: <20220131093355.4151-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YBqp8P0wkVbVB7v6/1o8rlRTjltXrwcyC5K9gGgphwLXgRFYSKj
 g3ujGfuFTo2wQo0xNBfSTMMI6KUkrEbwrd4QExH1uO8vdk9bWcSUbZ5fnApjolZyDzto9J5
 TxNAPVAtcECuGbZ7MpMJLJkZgY2KBIXBXW/wz/AjLZVVwV1i+Y0pVnoSC0ZEMHniDt7hQT1
 q4z9gxNAXt5rxn5SHQB6w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IIQKrkXR5Hw=:Rt15BVE14eKtMQtqeSXIoP
 pmNcwMFC0ymvGtHM1bp38TlmyPK77/qkTMkL4Yf+4GQE+vtqVmficRUv3fhfNHSkSuzbsnMMc
 dRdb3fOyi/HnoheWEyVuUyETrXjalzJLw6ghrQPKnEVCqbng3SO4dnOS5erK25yjwND4qVYAm
 y7amLjqC5TmdhZIeD8KQDNhJ7hJkWa9PzEqODopCvZ6O/IVVqpQDlixASIhnDoeg0fiufT9YG
 NqaGn7ZNISTLCG2pvUPirNRU4VFX1Y8nXTH66gK7aaGT/qHLqNwDvA2s2pl2qd22fFn5Ep6vu
 LvOjTTxk4SHJ6ysKM3jA1UmQpmmmu1GenGlvKM7toy08rzEMTVHaT86WUglNQhx8Y194n80eD
 rh5HLKTAG48Er00eUqVjDDFnfyRyhmJW4KsNCWNsmXvRODRhtYqPIPHG2pz7fZHa4JkAkhCeH
 9Kpw+d34OZodAgaX4R7fSVYemhj4j2mcRKQ7aTbUOwx5oJzdElibGP9D98CbBL+8blXTZGME6
 ez1wFZ2Jc0FOwz5GfQN2AOVRn/vLvYjS3OLRu/4H81g7MZmouqDBOXH69H6HHzBUwRdd+Qqrw
 cyBpq147VvsktUSVUQYH2OXlGTiXYqX0SV9C8Jt/kr9zLQbqAyg1nCgisCLfcyVNmH3i21UTf
 yBx8YNuNifqBcRBzhx6hWRdYQ2TcccAF6kTy3b58h85SJlJG77yAuNKyEu1w9qFUnyeyB+sVj
 f4vcGIBDBwTTS2sNEg/5FE0caxvy1KFmGFR5uWIBnKwrpiKmipOhoo/I2/AAEW5Laso5+Cjdy
 8A9sqIZZwEg0q/4BerSJnD1dWMUUsfpNDo/u2MvrulM9JdfPnzMZkWWay2YRjDaTqdTLLDAVG
 lITvN024efiBbNaOEfNHi+WAnKDMcHE5uTWXVllDYmDEV1e6Ar4RfCbQTTNn1QabrzEFTT+hH
 QYYrQtBv4VwSNNv3XgMaFm6UZplMuuGn/5P+8UYK4MXFBjjUthWj+lWKUTMkGfQt7Raf90t0C
 uYbNI42HfG0tcR1T2QCphw5akTvODVtJkbCNDiGzbke7M+daju0Q5DamjjX1EgeZ7vQ/S9oaR
 RSdHDb6cY+6m3Q=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, when sch56xx-common has detected a SCH5627/SCH5636
superio chip, the corresponding module is not automatically
loaded.
Fix that by adding the necessary device tables to both modules.

Tested on a Fujitsu Esprimo P720.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/sch5627.c | 9 +++++++++
 drivers/hwmon/sch5636.c | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/hwmon/sch5627.c b/drivers/hwmon/sch5627.c
index 8f1b569c69e7..bfff27d6c736 100644
=2D-- a/drivers/hwmon/sch5627.c
+++ b/drivers/hwmon/sch5627.c
@@ -7,6 +7,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
@@ -456,6 +457,14 @@ static int sch5627_probe(struct platform_device *pdev=
)
 	return 0;
 }

+static const struct platform_device_id sch5627_device_ids[] __initconst =
=3D {
+	{
+		.name =3D "sch5627",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, sch5627_device_ids);
+
 static struct platform_driver sch5627_driver =3D {
 	.driver =3D {
 		.name	=3D DRVNAME,
diff --git a/drivers/hwmon/sch5636.c b/drivers/hwmon/sch5636.c
index 39ff1c9b1df5..9ef43cbfc830 100644
=2D-- a/drivers/hwmon/sch5636.c
+++ b/drivers/hwmon/sch5636.c
@@ -7,6 +7,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
@@ -501,6 +502,14 @@ static int sch5636_probe(struct platform_device *pdev=
)
 	return err;
 }

+static const struct platform_device_id sch5636_device_ids[] __initconst =
=3D {
+	{
+		.name =3D "sch5636",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, sch5636_device_ids);
+
 static struct platform_driver sch5636_driver =3D {
 	.driver =3D {
 		.name	=3D DRVNAME,
=2D-
2.30.2

