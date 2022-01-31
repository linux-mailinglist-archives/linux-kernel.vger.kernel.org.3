Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572664A468E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 13:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348422AbiAaMF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 07:05:57 -0500
Received: from mail-bmxind01olkn2062.outbound.protection.outlook.com ([40.92.103.62]:17633
        "EHLO IND01-BMX-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242781AbiAaMFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 07:05:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIncfS9klTf7ajbhtGEkEE69PAQeXFip7G1VBpiywzAvguv5iCv/06QE9iyNA2G5MU0YPIQnAROax1Aetr5Gj6rzJpzs0avIO6NfMjFmDRwvseLggvyUALbgchMpHM000Lo5XW0RwWP/IcDUa2wc2mhCwBLKC2nYMDsjEPLVdXmEMY+7Fhb1XujcMyFS/pCc7B/fZ+vmqe/p5C0WuSJDqz3YtFljTkeoNJUkgco8h0yrslKz+cMp+ANuCdcYhUT4GTeFonr3I0b5zVG85/ZNDU6ZR3o0GIPH5KNFUd9ids2gQvWpNxFbmY2rOU2NGhTQTcIPxebl//iRCqeYkDCeIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7S8cBl4m+P2fuG7ZDOTZJsrJG7Pu+oZvHyMg0F8p/s=;
 b=CKYkJyUUxPB5iTFC19XVi3MZjUXzM1Q/BAPhM/BcdpkZ1bn9i/ZvW4wlGk/CrHwN8MMSLA28wqKgzSJSrBPVhONfGl8efkMOX1uOXW5StuZbJATszbN2GqiAW1EkfyiVg8+MLVUcR9xCAOvDHDzJM0ezfhT3Ave8636ODm7nrrxnGP44LpnSZXqzbK6biC4jiEbV2Gjx9rcu3pHt1Y8Xl4y0Cnw5euuzs87RdBMuuUGLBvMfMDWZ9RtHDFmRFLcD34ZZzV4qMVsYDGTxD4RUe6J9aPMBLVkYZX6FIBjS+gjUVZ4ZBEx5tLvjMepw8ZNiecmnL5eJbBuCQEBXBdNuEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7S8cBl4m+P2fuG7ZDOTZJsrJG7Pu+oZvHyMg0F8p/s=;
 b=Xqhi1nq9pRXWK5xrDO6fGRoXzkR5yKWhkVMIKa9LqWfHdZ2CAJ/4f3jlw3RU+7ezmfW9cw/1Nk0h40ywk9NmAjoGwO7UPzNkrKyJJ/B0pazKp9UdrdnjMz7r6pY5msF/m8784o0Dh0sN6ab5G+dVHyrqSbcoi0vtvt+l3A6YOOVbffA+Vt0mO5PjbMTkY89AFEf/zBRZaroIVjnfWIQX5pBYr4hpAOWy3XIU/gtuNu46PrDEjNW6oX9GifTN4aL32VX7UnL61Mm0QUzHlPuDsKVFG/WnJSzOUMSxfpx+j60RIQAtdX3+U4/e2Q9GVdDnJ1yIWx+sT19lEVvQpOYaUg==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PNZPR01MB4557.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:30::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.21; Mon, 31 Jan
 2022 12:05:43 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055%9]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 12:05:43 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     "jkosina@suse.cz" <jkosina@suse.cz>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "alexhenrie24@gmail.com" <alexhenrie24@gmail.com>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC:     "paul@mrarm.io" <paul@mrarm.io>, Aun-Ali Zaidi <admin@kodeit.net>,
        Orlando Chamberlain <redecorating@protonmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/3] HID: apple: Add support for keyboard backlight on
 certain T2 Macs.
Thread-Topic: [PATCH v2 1/3] HID: apple: Add support for keyboard backlight on
 certain T2 Macs.
Thread-Index: AQHYETQ7eA8f8fgzvkGVPkQueNltWax9E1WA
Date:   Mon, 31 Jan 2022 12:05:43 +0000
Message-ID: <9B28205B-24B2-449F-A6B9-BE87C1B9A39E@live.com>
References: <67E7EA8B-CF21-4794-B7B4-96873EE70EF6@live.com>
In-Reply-To: <67E7EA8B-CF21-4794-B7B4-96873EE70EF6@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [gJw+anag5RT5s8uJ9o5gixvnzzHRkuCF]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8ae8241-9dd3-49d4-fb4f-08d9e4b201f0
x-ms-traffictypediagnostic: PNZPR01MB4557:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ec3bAXlI5td0DLtKbZ3kcKP40BVRB6QwKmGk4BtT+A8VcoqorbpKgu5aE8vmqR/3v98BJPOdVnK5Un6YGZywy7SgkT0d6xq5sqgxuBqxvMrXbHXa04fattdmRzk+BNqKXeVt7YzuSGEsOCExPEuRlz1peACyd7Qvgl/0yEYPfhp5RsJbSHbR0sBiZ/Mn8BiBKxpfSegMiaPMg9ahxb3V6bXIoyOGjY/Jy1ROjjj8uYCox/pI3PM4TexToTY8NBXnhmao565iz2LxItJFi+S7x/sDRi6KzU3qsDidYvSqDRog4I/JOQZiJ0enXLkqj8XgJMA2n2WlMLggkz0IM3+RwKjizJMjLq3I7t9nfAylN32wQz03Qs0o+ztbmiMxoJWcYOfJwnmJlV0X5Gi4Cq0HRBMonuIGXPxS/p+xiSZxcjTfC8LvhTnF43A6uQke4gghav21+bScdDDTQ8aVRO+N7C9YuMqVt9eHUkrinvdYHxdNS1nXyb2bPR+i0nnetO6u9pYyvmzDGsmM+SEvCVKuNhL1uZLrmMNDtkN8IzB9/+ZjK6YhUuAYAtCdFBtlC2tc/maMHMcW2ofz9lTgQ+CloA==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MxGI4jc0OnzcqgbboO3459T5ioTaMIJLMGpFrzTN6d7Y0rjhmUC2vY3GzHKL?=
 =?us-ascii?Q?KpcIwJj1RiPnSO8yQXRj2Kgu4Ynzmc+BGME0PybVBPPWyBLCi+yVVj6KZSJP?=
 =?us-ascii?Q?9fBxusj3VgOtj/BWeq4J3XdgwKzLL8LdC+T2nK0BWWTJmZ53zaLzDYBe0TJM?=
 =?us-ascii?Q?TsHnGHHjb602IguQvSRBJm1rlvmvRox+3guipGwOprejfMUjkoZ4HZ5zSvVN?=
 =?us-ascii?Q?V1dKjRI9kq2JlJpcpwR6o7n9Vy9cK05CWl255/dtGN8TlLRxMiqcw/bOUcNa?=
 =?us-ascii?Q?Q/+o56jYlLfT8lfPD/u3+35fXxKDqJeosbOnTY/r8PMtQY+IdO6nZ4MPqbZP?=
 =?us-ascii?Q?PF0y5HNs4+7+dgeiz6KeV8ZnGu+qf8IX4V5Zz08b+Q8ZsF6Ws+369BzCPCHK?=
 =?us-ascii?Q?zwGt5talU4PmVr+fRU5cWTFUnD/LC/FXctmd6YEOpk2UBVSPwxwACmpVJHg8?=
 =?us-ascii?Q?XGfFukr69KFaSVPSRSFNw7E+L2Cw3ELaQxYfjqPMBsZKF8eO4FaS65fVwbkW?=
 =?us-ascii?Q?si0KAkVig05SQSEqrv9jeFeqtdv3T8dthjKwIgOBvkNjB35/AkYrLSw8M6jn?=
 =?us-ascii?Q?KrXu5w18xEA/kPbe0rCElGjrZ75veBXLUQAdR61Heu7mMlJO1Bz1hXc+18LE?=
 =?us-ascii?Q?6dccsEnZUe6rhOkBeGctq6qRAsKPGG2A++KzLBDrcPRUFWazGpA22OJ5AsWo?=
 =?us-ascii?Q?6mSbmQyrimH4TQa8GVQ0NsomWEhaN6A2V4/zYpVnPLmEXY9BBpdGXGUBrUqG?=
 =?us-ascii?Q?1w6xSbtGwi0woqKKMYsgSdaZXGb5hy0qmG3hTdC32kAmETsfDAfTDFYPfasf?=
 =?us-ascii?Q?/WqZpPhlkGXrRV/Ui8vynzgbquv1XQXhTJAoOTT5x/1xL5gsBAWp+5uXxMvR?=
 =?us-ascii?Q?BL2/MCxARXEx2a7mLCs2BIuyQ2d1AF2X5WgOg+0oPwJGgkYqh7DHClAyFq79?=
 =?us-ascii?Q?X+UgZGvf+dwi27KQSS4Rbw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <262CEAC55F06204B93EBAA11E2A63EA0@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ae8241-9dd3-49d4-fb4f-08d9e4b201f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 12:05:43.6892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZPR01MB4557
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

It has been a week since I have sent this series of patches, but I haven't =
got a reply yet. Before that, I had sent a v1 of the same, on which I wasn'=
t contacted as well. May I have an update on this series. No reply for a lo=
ng time is something which doesn't sound good.

Regards
Aditya

> On 24-Jan-2022, at 8:38 PM, Aditya Garg <gargaditya08@live.com> wrote:
>=20
> From: Paul Pawlowski <paul@mrarm.io>
>=20
> This patch introduces the requisite plumbing for supporting keyboard
> backlight on T2-attached, USB exposed models. The quirk mechanism was
> used to reuse the existing hid-apple driver.
>=20
> Signed-off-by: Paul Pawlowski <paul@mrarm.io>
> Signed-off-by: Aun-Ali Zaidi <admin@kodeit.net>
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
> drivers/hid/hid-apple.c | 125 ++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 125 insertions(+)
>=20
> diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> index 24802a4a6..c22d445a9 100644
> --- a/drivers/hid/hid-apple.c
> +++ b/drivers/hid/hid-apple.c
> @@ -7,6 +7,7 @@
>  *  Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for Concept=
2, Inc
>  *  Copyright (c) 2006-2007 Jiri Kosina
>  *  Copyright (c) 2008 Jiri Slaby <jirislaby@gmail.com>
> + *  Copyright (c) 2019 Paul Pawlowski <paul@mrarm.io>
>  */
>=20
> /*
> @@ -33,6 +34,7 @@
> /* BIT(7) reserved, was: APPLE_IGNORE_HIDINPUT */
> #define APPLE_NUMLOCK_EMULATION	BIT(8)
> #define APPLE_RDESC_BATTERY	BIT(9)
> +#define APPLE_BACKLIGHT_CTL	0x0200
>=20
> #define APPLE_FLAG_FKEY		0x01
>=20
> @@ -61,6 +63,12 @@ MODULE_PARM_DESC(swap_fn_leftctrl, "Swap the Fn and le=
ft Control keys. "
> 		"(For people who want to keep PC keyboard muscle memory. "
> 		"[0] =3D as-is, Mac layout, 1 =3D swapped, PC layout)");
>=20
> +struct apple_sc_backlight {
> +	struct led_classdev cdev;
> +	struct hid_device *hdev;
> +	unsigned short backlight_off, backlight_on_min, backlight_on_max;
> +};
> +
> struct apple_sc {
> 	struct hid_device *hdev;
> 	unsigned long quirks;
> @@ -68,6 +76,7 @@ struct apple_sc {
> 	unsigned int fn_found;
> 	DECLARE_BITMAP(pressed_numlock, KEY_CNT);
> 	struct timer_list battery_timer;
> +	struct apple_sc_backlight *backlight;
> };
>=20
> struct apple_key_translation {
> @@ -76,6 +85,20 @@ struct apple_key_translation {
> 	u8 flags;
> };
>=20
> +struct apple_backlight_config_report {
> +	u8 report_id;
> +	u8 version;
> +	u16 backlight_off, backlight_on_min, backlight_on_max;
> +};
> +
> +struct apple_backlight_set_report {
> +	u8 report_id;
> +	u8 version;
> +	u16 backlight;
> +	u16 rate;
> +};
> +
> +
> static const struct apple_key_translation apple2021_fn_keys[] =3D {
> 	{ KEY_BACKSPACE, KEY_DELETE },
> 	{ KEY_ENTER,	KEY_INSERT },
> @@ -530,6 +553,105 @@ static int apple_input_configured(struct hid_device=
 *hdev,
> 	return 0;
> }
>=20
> +static bool apple_backlight_check_support(struct hid_device *hdev)
> +{
> +	int i;
> +	unsigned int hid;
> +	struct hid_report *report;
> +
> +	list_for_each_entry(report, &hdev->report_enum[HID_INPUT_REPORT].report=
_list, list) {
> +		for (i =3D 0; i < report->maxfield; i++) {
> +			hid =3D report->field[i]->usage->hid;
> +			if ((hid & HID_USAGE_PAGE) =3D=3D HID_UP_MSVENDOR && (hid & HID_USAGE=
) =3D=3D 0xf)
> +				return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +
> +static int apple_backlight_set(struct hid_device *hdev, u16 value, u16 r=
ate)
> +{
> +	int ret =3D 0;
> +	struct apple_backlight_set_report *rep;
> +
> +	rep =3D kmalloc(sizeof(*rep), GFP_KERNEL);
> +	if (rep =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	rep->report_id =3D 0xB0;
> +	rep->version =3D 1;
> +	rep->backlight =3D value;
> +	rep->rate =3D rate;
> +
> +	ret =3D hid_hw_raw_request(hdev, 0xB0u, (u8 *) rep, sizeof(*rep),
> +				 HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
> +
> +	kfree(rep);
> +	return ret;
> +}
> +
> +static int apple_backlight_led_set(struct led_classdev *led_cdev,
> +	enum led_brightness brightness)
> +{
> +	struct apple_sc_backlight *backlight =3D container_of(led_cdev,
> +							    struct apple_sc_backlight, cdev);
> +
> +	return apple_backlight_set(backlight->hdev, brightness, 0);
> +}
> +
> +static int apple_backlight_init(struct hid_device *hdev)
> +{
> +	int ret;
> +	struct apple_sc *asc =3D hid_get_drvdata(hdev);
> +	struct apple_backlight_config_report *rep;
> +
> +	if (!apple_backlight_check_support(hdev))
> +		return -EINVAL;
> +
> +	rep =3D kmalloc(0x200, GFP_KERNEL);
> +	if (rep =3D=3D NULL)
> +		return -ENOMEM;
> +
> +	ret =3D hid_hw_raw_request(hdev, 0xBFu, (u8 *) rep, sizeof(*rep),
> +				 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
> +	if (ret < 0) {
> +		hid_err(hdev, "backlight request failed: %d\n", ret);
> +		goto cleanup_and_exit;
> +	}
> +	if (ret < 8 || rep->version !=3D 1) {
> +		hid_err(hdev, "backlight config struct: bad version %i\n", rep->versio=
n);
> +		ret =3D -EINVAL;
> +		goto cleanup_and_exit;
> +	}
> +
> +	hid_dbg(hdev, "backlight config: off=3D%u, on_min=3D%u, on_max=3D%u\n",
> +		rep->backlight_off, rep->backlight_on_min, rep->backlight_on_max);
> +
> +	asc->backlight =3D devm_kzalloc(&hdev->dev, sizeof(*asc->backlight), GF=
P_KERNEL);
> +	if (!asc->backlight) {
> +		ret =3D -ENOMEM;
> +		goto cleanup_and_exit;
> +	}
> +
> +	asc->backlight->hdev =3D hdev;
> +	asc->backlight->cdev.name =3D "apple::kbd_backlight";
> +	asc->backlight->cdev.max_brightness =3D rep->backlight_on_max;
> +	asc->backlight->cdev.brightness_set_blocking =3D apple_backlight_led_se=
t;
> +
> +	ret =3D apple_backlight_set(hdev, 0, 0);
> +	if (ret < 0) {
> +		hid_err(hdev, "backlight set request failed: %d\n", ret);
> +		goto cleanup_and_exit;
> +	}
> +
> +	ret =3D devm_led_classdev_register(&hdev->dev, &asc->backlight->cdev);
> +
> +cleanup_and_exit:
> +	kfree(rep);
> +	return ret;
> +}
> +
> static int apple_probe(struct hid_device *hdev,
> 		const struct hid_device_id *id)
> {
> @@ -565,6 +687,9 @@ static int apple_probe(struct hid_device *hdev,
> 		  jiffies + msecs_to_jiffies(APPLE_BATTERY_TIMEOUT_MS));
> 	apple_fetch_battery(hdev);
>=20
> +	if (quirks & APPLE_BACKLIGHT_CTL)
> +		apple_backlight_init(hdev);
> +
> 	return 0;
> }
>=20
> --=20
> 2.25.1
>=20
>=20

