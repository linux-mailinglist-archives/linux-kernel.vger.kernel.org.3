Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4D459B2AD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 10:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiHUIE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 04:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHUIEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 04:04:52 -0400
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2043.outbound.protection.outlook.com [40.92.103.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1198C19297;
        Sun, 21 Aug 2022 01:04:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9wmJoQ5Dk058G9i4LCUwj7NxytyODkBXKBl2tt+jzJTafJtQYfTddXBHzzYO4fo5TxkmUEewbnbCQMdwg4QkmcOUhz8dmfEpcuDXN3P0vKii1fUxFr1XNKzqgJjxiIHkkJYa4cqzqZWWItGgWEDYsjR0RJuU1bgZbbAbhMOysR/ZOaFTtELe1WgsMQD1vKnPqGpNMNgzq9CR43tnPdVn1kJ9udAc1Jos4niFjRlhpdGQVcHf53FzDNTmIF7yxFVaRBhi5MvzIvxgY703P2EMVV8DWlbMh/nDC08dykuSpHzQ9uupCzy4Xlyo1FPIeRXy8AGEzCqGPZk/aM14M4AYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V45qjMYj3h9KxIOG0T+8wSKEzObPX5v4mVeIRKWyZss=;
 b=gY9aRZdDuo0ch2IDeiWY5CyvA/n+xGDgdggtzy6Oj4ULZET6TRN88pRatrc9s5aMvlxkw5RgZMy4iKRhrX0qgVNXFMtFyUwWiAX2Hve19AiTJu8EDoATGM6MTt0QI9GISZlGYc2JbgwMWOV/vOMrt7CXZX/yUABKvdit3zZsW2GmPGtb8rd3HIHdiuSBM+kkwzQHYkt1A/UqpDqVP0AdoDUdym3b/EfifhKYQ9PPlTUK1Y8XCKveNxUJ1CkMXCKqnaWgFieRUO3/6QVmY9AHPax4qTbzd4tFFmfj6XeGOOq7YkBOatRc3KFfljhpnVSEupNvZw94mZNNb1zZWpl04g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V45qjMYj3h9KxIOG0T+8wSKEzObPX5v4mVeIRKWyZss=;
 b=qVKdleNSdhfB/xNITGQ0t4OZfzMclSuWE3vkK1+rATvP+YDAxYu53uwEtYHHAM7MY2Cjpdrk0WTcChCIpQcOpvrF9AC6pXiOAjfUhFej0iN46pHW9cbmzNaj0PMUcfi05QmE1dsFu8aas68qHohAQshmANmbFZllmrHQI9bKluYTre4ONMDr3rl5SShjfxdEfzAibOrsnS0ykQl2GN7c2vQnWGpx4Xi/UA8CK6qPORpJnCxUxZR75LsMdzFtliKAo831T2zZ7q/HaAOlAoqWFhcxc+JcPcwdNWQQyFgSuinS3HrG/Yv5hgKxCnpRo54SLQMoukLKSqTQDfZZ/8QogA==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by BM1PR01MB2947.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:46::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Sun, 21 Aug
 2022 08:04:45 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cc2c:fa62:8825:6b97]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cc2c:fa62:8825:6b97%6]) with mapi id 15.20.5546.021; Sun, 21 Aug 2022
 08:04:45 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Jiri Kosina <jikos@kernel.org>,
        "jkosina@suse.cz" <jkosina@suse.cz>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
CC:     Orlando Chamberlain <redecorating@protonmail.com>
Subject: [PATCH] HID: Add Apple Touchbar on T2 Macs in hid_have_special_driver
 list
Thread-Topic: [PATCH] HID: Add Apple Touchbar on T2 Macs in
 hid_have_special_driver list
Thread-Index: AQHYtTStFWCRoLFmPEqV8QD4Wsg3WA==
Date:   Sun, 21 Aug 2022 08:04:45 +0000
Message-ID: <30CA04A0-4F49-400F-A684-2C65B15E4431@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [5pNxUAJkx8s9mdIWHMN+iG7SGSb+t07P]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc3568aa-d967-4731-b164-08da834bcf93
x-ms-traffictypediagnostic: BM1PR01MB2947:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2iLqCw7l8/dAsB9xpoctiB51x7iAT+R6vpgCy6kZ8QZVdhGZ7AmQ+ERQuBt8PgUuDxPHVHlUkGIEL8cTJFvv32tTpsU9YfmnuWi9UnUIorjd/nRxmJeV69Xo1Utmme3m7zaKxVn22DeNV9muAs/wmiS/JA/2KATPeU+GGiGy9LSGHBKAILPO99iY9M7q/tv6CA4Vr+NQh51H+v0NaE6vOXnghaWI8lnNkfX+qwODb0CUuNIxN6HSJjrP7HINUfLN2D66tpoqs81YttfZB7798tgER72/9Rt9gmm4KdORm7Yt9yvJmuKGUuJN9IhUE3nz4AAfFlr7a8OgOf51ppKorIYGKbgXFuxHIKeEC6DZxMhPfeyx3CrmoAMl/7e8yYOPI/bAoneJf4C33t6DS8/m5VJ785hw0EFcRn3CdiR2IOKXabqK/m/OE8IZcUpJfVxXG4KD88Mj6iXzjJ8nVEU3RGIcO6LXi0+LqeDAzeqMrDOUHb/HGNujDNg15+gCyzkuRFu3k0z0HaxOGffxFMTpH3H89diydnqlV+bgxPCradMBbpKgtifQBa5j+5dcZC4vYNCdAn0NbzvVorS4TzWY7CEQujHPYI8KgbY6A0rd3k6ZpjpRe4+06vEfxBqTGAYK
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wnMUyXb70hkANHR/odiJoktJX4YL8iPxlEB4kshbxocCOQEhhH2XDLdy0qCU?=
 =?us-ascii?Q?CQk2BXgl9U2sLRC2LAaeHxggKyd73yPYq9MeMfxb5JLXqJRq+rSL1V6R/fQi?=
 =?us-ascii?Q?3ZG9WChW3LLNYK6ZmgmKSkYHTmDQ7vWIQdYEz8WLqhgzSvL3cnL87NHIoNJ4?=
 =?us-ascii?Q?jS4hARak5u4pv9dPNbbYoP24T7pGYNF0b8MW5A+AB0Dg8qyciyAoLYWZ/Nq2?=
 =?us-ascii?Q?J5AfW+tAQZTe3T9ue0o0440NNzSE1pohEg5mgWVyUC4OAveY7/h/kEQSzWKH?=
 =?us-ascii?Q?15cJekkyVJvQKrl0K23ymMrHRxsTtec1U7/5L51pJwoLrZudaYmyx7WrrQqK?=
 =?us-ascii?Q?ASfmMA6amn7kuy5Baj7Oj88hzEd7sdQK8lM9VhCG8I9AJw9E2SpSnhfua1b0?=
 =?us-ascii?Q?YbBsxyJoXSQvkJWCPVwCruXjxtZlBOAH6FU/5kxedZWYeqo2I8K6+ItPtg+N?=
 =?us-ascii?Q?wx7X2pAc6a7gOQuHI9jEBa7K1zm7AnmhtAHjl3QUJjAspg1TC111sMURc++6?=
 =?us-ascii?Q?cF/8tDMM0uQ0u+KqCBUE0JAj5LpC/3EG33etCDxvO7K0p2VyeJKKheRIQCn1?=
 =?us-ascii?Q?+Zh0AEOmmCpzB0i5DQj4RLn4ca8jhtQVy9VyiXKmU7dn+3E12YRtE59wW1Bo?=
 =?us-ascii?Q?0EH8F179Zmpo1YqrT6dG4K/CAUrnngufDVUMioQOIUqlBT154SC7gUT8hsJ5?=
 =?us-ascii?Q?9cTwKSS3SWlTnjOfpnNaqjBTx37DPG5FpyK67q5s85A10oHNEAxjgGLcCVTj?=
 =?us-ascii?Q?ovFPZo6Ey+2aKXkr7/eQamiyd8D5O4xh0Vo1SnvigDULYDrVbk9e5IKYdGro?=
 =?us-ascii?Q?Mb7/HTOAZiR0xS+xnpyGs7US75ML4r5dWwEp0NvLhUfWsz1jx17SUOHcS5g0?=
 =?us-ascii?Q?Wo6JTZLUAOIbtBkbo3HY9g0YE+Z+aL9Z+yUvZqm7jdjiYKXd6dKv92EirLIS?=
 =?us-ascii?Q?PlsClWrV1dvlgZPnrDsidYZdQrrs+7YE5UG3OPatY6crZL9YIy+w8CgkfmyV?=
 =?us-ascii?Q?fYlRgHkxI5tUouC9Mb8rVrOOiFDXiOd5Bz0KhIpNZG6ONU6M732YbNfCM7LF?=
 =?us-ascii?Q?17I2AT42zHV28+jRxJIBmoVf4bJhXG6ZsxNb5LgALjGvuqI+rI7BMtPmeUHD?=
 =?us-ascii?Q?4feVzFfknnMMFSUVbSAxG65ipZjgiRlOtdBuihoNeUmCi3RWjKh6I+zsqaKR?=
 =?us-ascii?Q?wp/X14HiWX4I5NXNN9215re82UjmUeENmsTN2D7v5eleN7xlgkqskYg1Yhb8?=
 =?us-ascii?Q?PmHfu233a5Ar5CWgitVYOZ9jpgENAfQYkJ8LUWZJOg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B91BAC671E2F7B41801AFBC86E55DFC4@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3568aa-d967-4731-b164-08da834bcf93
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2022 08:04:45.4070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BM1PR01MB2947
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Garg <gargaditya08@live.com>

The touchbar on Apple T2 Macs has 2 modes, one that shows the function
keys and other that shows the media controls. The user can use the fn
key on his keyboard to switch between the 2 modes.

On Linux, if people were using an external keyboard or mouse, the
touchbar failed to change modes on pressing the fn key with the following
in dmesg :-

[   10.661445] apple-ib-als 0003:05AC:8262.0001: : USB HID v1.01 Device [Ap=
ple Inc. Ambient Light Sensor] on usb-bce-vhci-3/input0
[   11.830992] apple-ib-touchbar 0003:05AC:8302.0007: input: USB HID v1.01 =
Keyboard [Apple Inc. Touch Bar Display] on usb-bce-vhci-6/input0
[   12.139407] apple-ib-touchbar 0003:05AC:8102.0008: : USB HID v1.01 Devic=
e [Apple Inc. Touch Bar Backlight] on usb-bce-vhci-7/input0
[   12.211824] apple-ib-touchbar 0003:05AC:8102.0009: : USB HID v1.01 Devic=
e [Apple Inc. Touch Bar Backlight] on usb-bce-vhci-7/input1
[   14.219759] apple-ib-touchbar 0003:05AC:8302.0007: tb: Failed to set tou=
ch bar mode to 2 (-110)
[   24.395670] apple-ib-touchbar 0003:05AC:8302.0007: tb: Failed to set tou=
ch bar mode to 2 (-110)
[   34.635791] apple-ib-touchbar 0003:05AC:8302.0007: tb: Failed to set tou=
ch bar mode to 2 (-110)
[  269.579233] apple-ib-touchbar 0003:05AC:8302.0007: tb: Failed to set tou=
ch bar mode to 1 (-110)

Add the USB IDs of the touchbar found in T2 Macs to HID have special
driver list to fix the issue.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 drivers/hid/hid-ids.h    | 2 ++
 drivers/hid/hid-quirks.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 0fb720a96..78cd2a62b 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -185,6 +185,8 @@
 #define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_2021   0x029c
 #define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2021   0x029a
 #define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2021   0x029f
+#define USB_DEVICE_ID_APPLE_TOUCHBAR_BACKLIGHT 0x8102
+#define USB_DEVICE_ID_APPLE_TOUCHBAR_DISPLAY 0x8302
=20
 #define USB_VENDOR_ID_ASUS		0x0486
 #define USB_DEVICE_ID_ASUS_T91MT	0x0185
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index dc67717d2..70f602c64 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -314,6 +314,8 @@ static const struct hid_device_id hid_have_special_driv=
er[] =3D {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY=
) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_=
2021) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_=
FINGERPRINT_2021) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_TOUCHBAR_BACKLI=
GHT) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_TOUCHBAR_DISPLA=
Y) },
 #endif
 #if IS_ENABLED(CONFIG_HID_APPLEIR)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_IRCONTROL) },
--=20
2.34.1


