Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37161471574
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 19:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbhLKSpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 13:45:12 -0500
Received: from mout.gmx.net ([212.227.17.20]:59981 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230468AbhLKSpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 13:45:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639248292;
        bh=TNaxw9F5mdkBVD8JV4tQ5Gi+bPFXfvjPAHwyHGpOTts=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=GwyLThNv1+O34J3F3gjuZbHgB3RtNfJDQAHthPQRNyBIACOUPw7l2XR9hjVWDrgSM
         ZhHZ/2YXxhasX5AH+KWM/ZBG4t6wQykmIdv6uD5kSqgcQvTOu8e3zZvd2TYV2kPljx
         yVeUEw2iv6NeeM35yj51RA8EgRCxtkPSygUTP1Qg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mq2jC-1mA5EE28uI-00nCDt; Sat, 11 Dec 2021 19:44:52 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (raspberrypi) Exit immediately in case of error in init
Date:   Sat, 11 Dec 2021 19:44:49 +0100
Message-Id: <20211211184449.18211-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e1ZayIrRzfNtRAPi4vAeLu3OQ15DNYjst+ZKvGyY91ddBPfDadf
 oKwlAwSx31P/qbhx4DzCrwzt3zHu93SJUk0ENxIcTiNhGkMGq3zIscfxahYJgDj+p9PNepW
 n/t/+77UmbVrDyPWmYUaAkscfpdi5MMQjd3FTL/ioOLgNRs2lDxAYaBvpL5WZ/O2X3jWxEf
 JlIglgQKVbjnxb625cAow==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:w2yVm3JTnxc=:Cq2IgundaWCWQW+uEfFBDd
 iGxcBSPwKQtVihLuMYXAXtcPZt9vm1wnasjwnfqR//Qu3xS/BGXQFk7/JwM6mAXn74lyXolFl
 fpKJe5VqUnrNgjQjncbyLQ75BnMVf+Xsj60MN0Yk3KcRV2VHi4+O5hTYB30aMMGBbTOad68L5
 KTi1p6USXixd88xwUggf/cpbVIqH0BUX8wnKNFXWegwzxjJuZ851692qJ2TvQlIUk0sgUFA/E
 e5kdKAvd8FLRLEnHdIuTZp7y4vXu3bTUFFlfrS/47ZZvciuAnb+rJOhhttzTT/piOmSWdATl4
 gkp6cHjmeYZJ/dvvc5EteMCYJEskdwdm8+glTlIqQkzZl51e3pkYTJ72yfInKDqhfCy9xju62
 mUWY/0D+lGdFcSo/PnETypQoy0y9qQwFv4MgJiMESyl+d7ZaPYAxu/Qbt2/9gTZ/TfheRWUit
 R87AoFqdw+RZeZCOagEoqcDxWwq6iSw84jw22zRIB1hm0/44cii5uVYOO+lnE3napTmm0s9pj
 khXRhZXIXQKE7sddrtPIkg9WmsRPC2jBtrlfD5rjU3MXwIWiQTfjEKU7QfS91oTfL8NMMdinX
 2Irz//8mp8JNea45HN2RO7PlHJDsyQMNe8lQfBr90Y84lMVHfU/rbceAsVy5NSqjLTeD575zV
 kZkZvZyMrS4566yENO0mclhcB938isGH0I8XVdREm/EA6P85Ng+DpPZv6VK4dAuPRD5tU0SVl
 VbwJRBtMNLzIvmt8kqEiRbP3OgPF35Fy4QN6mN2PwZOyyf/QvzG1SL1GQhT+sG4qx3YpdLCeU
 ldQg6BbSGZWesMzR6ggDe9HgJCsqh1/twHHpWF0wzPV7FXlWo7jNDRTntEoHS9rUyBVZvtqKj
 S53qDKQAkl/lu+zKE7KAnKkVYwrSLbgHTxAroliC75mKapObx3SGQUpbeGssyy3VbKZrGDhnX
 PjBZghD0vd+fNEj1awZBcX0efJ+4+lh+BzcchOAIF+1T52iqrt1Oq0WVsmkLyn3O1QQG/ZGYN
 2hQjo3BTiVPqY+YvvdJr3dFuwVWojKYAoYbneeWkaFmjvyAWrdjMJWhN8tdksqioIK4pBsLFT
 3cfeoH6z3zo4Tk=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exit immediately if devm_hwmon_device_register_with_info()
fails since registering a delayed work whould be useless
in such a case anyway.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/raspberrypi-hwmon.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/raspberrypi-hwmon.c b/drivers/hwmon/raspberrypi=
-hwmon.c
index 573f53d52912..1650d3b4c26e 100644
=2D-- a/drivers/hwmon/raspberrypi-hwmon.c
+++ b/drivers/hwmon/raspberrypi-hwmon.c
@@ -120,6 +120,8 @@ static int rpi_hwmon_probe(struct platform_device *pde=
v)
 							       data,
 							       &rpi_chip_info,
 							       NULL);
+	if (IS_ERR(data->hwmon_dev))
+		return PTR_ERR(data->hwmon_dev);

 	ret =3D devm_delayed_work_autocancel(dev, &data->get_values_poll_work,
 					   get_values_poll);
@@ -127,10 +129,9 @@ static int rpi_hwmon_probe(struct platform_device *pd=
ev)
 		return ret;
 	platform_set_drvdata(pdev, data);

-	if (!PTR_ERR_OR_ZERO(data->hwmon_dev))
-		schedule_delayed_work(&data->get_values_poll_work, 2 * HZ);
+	schedule_delayed_work(&data->get_values_poll_work, 2 * HZ);

-	return PTR_ERR_OR_ZERO(data->hwmon_dev);
+	return 0;
 }

 static struct platform_driver rpi_hwmon_driver =3D {
=2D-
2.30.2

