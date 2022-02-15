Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7E14B7652
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243498AbiBOTRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:17:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243505AbiBOTRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:17:09 -0500
X-Greylist: delayed 314 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Feb 2022 11:16:58 PST
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4423C106CB2;
        Tue, 15 Feb 2022 11:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644952616;
        bh=tp7ExVq/J/C90XkeUkPS2VDs7PMAhC+GVzL+RwvH1n4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YXIBEUYzlYlo9/1aphmsLc0KAvag3JNYE+8+5saYispQMYz9cuPRmoO833fBIXfKN
         gWk94Zpb982EwplTwN7HgZPG5ZOUB1Yviwfl6hxLXRovBXyKwF8r2y1z3/jTHUVbTr
         srLuVrNE2aWxW4vG3YEvSEwjrLjs2HZ0JCbiPz4E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MIwzA-1nYovU1vUg-00KNAs; Tue, 15 Feb 2022 20:11:26 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] hwmon: (dell-smm) Add additional fan mode command combination
Date:   Tue, 15 Feb 2022 20:11:08 +0100
Message-Id: <20220215191113.16640-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220215191113.16640-1-W_Armin@gmx.de>
References: <20220215191113.16640-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o90PSutAs/awx5saEpSNSLj0PikxcEFlNKeIpZZFNqDgIBODrAO
 Fhs4dgg37MG4ewHLco3wnHqwUIEzi0gVjMT7etKdclgwPcqd38zucuywQVoqq2QUlGoq/EJ
 KVkEWV/jhL1FmYk5i9Ka29tzAWEgIp2m/JbZMk4y1R28CY1zE8ezZk4Z67NV5p+zni6fX0Y
 YNVOe+IdFXilxYE14YBkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lfT7JC6ogGQ=:YUflaUCxJBN+j/tu00UBdj
 1BLa3NxaYz3RrTg7ApkbauJbNjn6d7wZio7NUJmK63XG+NmFu1xgXLtuRdyaeSgIM2M07BCfN
 b6AqnQvBKc+pRipzGwqMMNpU2POHO6dYmaeUb58fV4Tfet6svLIp2oiPfJSQWLmMPnzSgpSom
 2GP4nmeq3uj71RqN6ickIF15RpOYfyhsWlg3jvOpFViGP5yB6c5EwlsFQYhDaXRpKyrBZLgUK
 Kslkm7JO9WNqarcIQ1vvLgcX5+f0PyobGOPClI8bB9Jb3inlJhNVl93d8SWoapzGg5klKBSMV
 X4PWCqM8Tct8OZ6CWuOyTJPvBo2rG6gGfmJiHzne2vnTRR6eXvYchfs0gEo2JBr6SjIV2Yt3m
 ghgtwWb/2V36MJWn6l3McGhvkwVl4e+iaBIvhe66AzxnCX60LbqjNpUnWgPjdiSTNkjYy68Ag
 Xfa19Jqx+EF2sw9sGCOOJMShm4Rn4I/5e5i3BccV2ogLwRNOPkqcjGZbFrp+vf1BpwprQCdW9
 CGba3ZNCEfwUCB4dvYbTciVLH+dGplfFBnxAchC28JDUuMG9MeDmTCslu7MAGQI6bgeGKa3Qc
 jsYRZQf/5n82KUKtrSqNUBFJfjOXGrPaXS4/KjkihGGIDzQtFTsAGUKWYqUOgbp461PbXuYsP
 yrNLruXvap9GGz1AFiIQZiKodUE1lsPghxFBrYchhOC73wn7/8hRzudjz710j7/R35Ee/l33k
 fULw+zV6QDtg0YQjYfAexVy9X0IUcnNKF1MyUHjbfgA6Qo3sVov8FIWfWR+rzav+XXkNmArDJ
 Cw8i1a3fn/Hl+6Y8cYg+t1jmyH4j4QNzRnO47EcpRnLQVsDe6C3jPT6G5Pj/HqWdqFfNGxEY5
 qUw43F9IVDHHFziy6ihzci5SE61psFzSEeZ7IHJc+OLmvsvbLcFYkUm1QYR5Iz3XwFzH2NZwn
 /dYp2m3QnIRGfz+ZUxSVNysogSOogUJsUMtOT/6bVzVDwpMWDT0tHIboO77vUwu6htP+A6BIJ
 xD0CM5bDtTOsHkcurR8WP6IiospC7Chg7Y2HPHL5/BraG7qjGyP7BoJ4DUGz2hn5XuJpLYF6e
 E2y0YmohK726kY=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This data was retrieved from the dellfan utility
(https://github.com/clopez/dellfan).
The combination is currently not used by default
on any models, but users can still select it for
testing purposes.

Tested on a Dell Insprion 3505.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/hwmon/dell-smm-hwmon.rst | 7 ++++---
 drivers/hwmon/dell-smm-hwmon.c         | 5 +++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation/hwmon/=
dell-smm-hwmon.rst
index 564d99cda869..cfaee682a245 100644
=2D-- a/Documentation/hwmon/dell-smm-hwmon.rst
+++ b/Documentation/hwmon/dell-smm-hwmon.rst
@@ -68,14 +68,15 @@ laptops actually work for yours as well, or that you h=
ave to discover
 new codes.

 As a first step, you can load the module with the module parameter
-``fan_mode_method`` set to 1 to test if your hardware works with
-an already know method for disabling automatic BIOS fan control.
+``fan_mode_method`` set to 1 or 2 to test if your hardware works with
+already know methods for disabling automatic BIOS fan control.
 If ``pwm1_enable`` is now present and works (i.e., you can
 manually control the fan speed), then please submit your finding
 as a kernel patch, so that other users can benefit from it.
 Just add your model to the list ``i8k_whitelist_fan_control`` in
 file ``drivers/hwmon/dell-smm-hwmon.c`` in the kernel tree and use
-the already known code pair.
+the already known code pairs (number of method equals the number of
+entry in ``i8k_fan_controls``).
 Please read
 :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
 for information on submitting patches.
diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index 1c4cc516c8b2..3b49e55d060f 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -1182,10 +1182,15 @@ struct i8k_fan_control_data {
 };

 enum i8k_fan_controls {
+	I8K_FAN_30A3_31A3,
 	I8K_FAN_34A3_35A3,
 };

 static const struct i8k_fan_control_data i8k_fan_control_data[] __initcon=
st =3D {
+	[I8K_FAN_30A3_31A3] =3D {
+		.manual_fan =3D 0x30a3,
+		.auto_fan =3D 0x31a3,
+	},
 	[I8K_FAN_34A3_35A3] =3D {
 		.manual_fan =3D 0x34a3,
 		.auto_fan =3D 0x35a3,
=2D-
2.30.2

