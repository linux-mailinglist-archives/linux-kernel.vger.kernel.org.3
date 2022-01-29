Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D542E4A2C08
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 06:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238244AbiA2FuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 00:50:04 -0500
Received: from mail-ma1ind01olkn0146.outbound.protection.outlook.com ([104.47.100.146]:18296
        "EHLO IND01-MA1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230162AbiA2FuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 00:50:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gv6Dl/zq0WbTa/zcw4C6BAxpvsjYHt5VKDiiPneemaHyLljNAvRbu5m1MLybM8xbsTMEia+P6BbKtS09jLCWWBEHKNmE2iAqcVaOkWFG86OPB8LWe/KLHvhUd7tBm7pmckZSJ293Xnf5yWoVLf5t7bWE0Mrc1GmB3wAzmtxjHYqtX2Hv6G7ifrCQQHXS7PMV6zh7eTm6HJhfNGyVi5CQp8QB+tracxtRM/mLDoXpo3d8Yb67n4wvPkxToXzVBjFgojLo+Ghv6BVrNb9WciikOPF+X/tD/dKc0/Zokne590KHl3cNJjUXAWIjizsbbQt2tn3ZpKns4l9c7HYJO+u8mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMmZTJLAlrn3eCXae8bHXHX/bhxK45LbDFmo8crayOg=;
 b=HfoVpXFYL/eIFXJgJ8+xQnF4I66nP08MCDVumYnGsiam3g7Vq42BU6G7E6pDJROPBkK0bxxwmOu3KjiGeTqI85Noyv0UifuB1Qmoz0giMu9pEOQE0bemlwjHWtKHBC+oxVX4w7JULkQVb44aYqv6z2BQCYANVCDed2blUUc2N/VrKYh8mCQ7+EFOIFMh9qOYjyv9TgtvDe6TXRiKHCsXbKFcU/ufV1UPcsqVVBJ0R40IjriAd28uvye/ikmzS2ELT5GZUx4J6KBS2tGZGMSYS9QPjInIgp42yD4sB+BPYJKNL2gEkE56nC6Z1XhxaYzPwgJ9xZd9iCkzE65iJA7HRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMmZTJLAlrn3eCXae8bHXHX/bhxK45LbDFmo8crayOg=;
 b=tkhaTY9Kt4E5dyKbsxvPRrtA+81ajd1JbuV27PoIJC+Xy5DkIV1aoehuzkOkM3TR7m3nhc5GjlYjioSKhenrULuHZ6IguYE4MqCQ52GVO/Nqph8RaRCWjZC0Bi8cDlm1FrcVhtsSCMZEeJovp6DoSQRBY3amoM0XLQMk3SFwlBLGY8p+QZ7aDJbEIbZtJk1XncIH3oL/NGc9x0m45Ol0ZXq2SHWwGzDOTuvyYd/nAFl3M2dG0NBc5heCMjDIVOZN0zvHM3t4sc1EVdPJ8JsvdynXayO23HKCtgxb/20AulbjICh0w1bR8qMZzNu/srmMR0TjZ/u9gcbhiZRGHpYcpQ==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by BM1PR01MB4084.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:75::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Sat, 29 Jan
 2022 05:49:55 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055%9]) with mapi id 15.20.4930.020; Sat, 29 Jan 2022
 05:49:55 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Harry Wentland <hwentlan@amd.com>
CC:     Alex Deucher <alexdeucher@gmail.com>,
        "harry.wentland@amd.com" <harry.wentland@amd.com>,
        "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
        "Rodrigo.Siqueira@amd.com" <Rodrigo.Siqueira@amd.com>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "evan.quan@amd.com" <evan.quan@amd.com>,
        "stylon.wang@amd.com" <stylon.wang@amd.com>,
        "wesley.chalmers@amd.com" <wesley.chalmers@amd.com>,
        "qingqing.zhuo@amd.com" <qingqing.zhuo@amd.com>,
        "George.Shen@amd.com" <George.Shen@amd.com>,
        "roman.li@amd.com" <roman.li@amd.com>,
        "solomon.chiu@amd.com" <solomon.chiu@amd.com>,
        "Aurabindo.Pillai@amd.com" <Aurabindo.Pillai@amd.com>,
        "wayne.lin@amd.com" <wayne.lin@amd.com>,
        "mikita.lipski@amd.com" <mikita.lipski@amd.com>,
        "Bhawanpreet.Lakha@amd.com" <Bhawanpreet.Lakha@amd.com>,
        "agustin.gutierrez@amd.com" <agustin.gutierrez@amd.com>,
        "pavle.kotarac@amd.com" <pavle.kotarac@amd.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Orlando Chamberlain <redecorating@protonmail.com>
Subject: [PATCH v2] drm/amd/display: Force link_rate as LINK_RATE_RBR2 for
 2018 15" Apple Retina panels
Thread-Topic: [PATCH v2] drm/amd/display: Force link_rate as LINK_RATE_RBR2
 for 2018 15" Apple Retina panels
Thread-Index: AQHYFNQKKjkLQ8kjBEmXIwGdXWWYkA==
Date:   Sat, 29 Jan 2022 05:49:55 +0000
Message-ID: <5CC8BCC9-176A-4478-B03B-3E4B4D7D88E6@live.com>
References: <139A7689-463E-4AD9-A2D1-A9969C3958D0@live.com>
 <CADnq5_OLpgEJjpN5y9b3gNwCmvdfNTA=puUv8UjOCDH96JgvOQ@mail.gmail.com>
 <58B7B0D4-BA3B-43EA-9F54-06CCEB7EF833@live.com>
 <0932bbf6-409e-0d3e-2824-b33914033f81@amd.com>
In-Reply-To: <0932bbf6-409e-0d3e-2824-b33914033f81@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [FnFkFRD4vfqpbJR9pEyk01Fy3FxCKY75]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9a2837f-ff22-4fc4-880c-08d9e2eb2d3c
x-ms-traffictypediagnostic: BM1PR01MB4084:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0EEmseEIJldAbczeF2jPh2JjEGM0LkEv4Fqd9HZDFLrz2tsyNbFMcNC1szraBuUZxnf7mfG9KJQ5DUoO9XYKSmYNzOPh8E8qaOV4PNBAGR2cfJSnKnz6gcM7xfPI2jS4iL4ucxG/jPvP/s1JDkar1yUItS9SMW3LPK5YEei434W0ZToXDJsbFGeVh81CWUtV/8r/aPJudpbkvwQ0nbARHtXNVPKWpPqw7hkxOWhjka7L8XCOMR0gBqmYjyZ3W/OmepyZtjePIhsKqvWX4EK+4Rt4zQwxHhkX6RtGDhloynHFm8trUlNs76TUIsFS1OOiVFRPFSGQXdk/YYG363/+N3gKAPKEqBnsjhdd0OpL/hFS2c8upH6zcYiCNnG7kU3BmDrNdDujbkhzeTjcJNuiEmn2EiDh+3E7MP8CwXjg70zmZEzJ+5UZ7lpTj1bqvyIOMKeB34ghzHAV7IFEv5e3xT7aX/jTueSjBqdqBngZp83kxq2Ta57H8I3GLwHy64n1hOzTAzQT9X7YwZmdv3ri4rRr0sTaShKmnAqxbmFgLicas8zNF1Hhe50Nnib5/k89Tigj3aCOJ4/rzfv7nFk+vw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wGSqrOkHr7Du7nGgPtztR/6FCj4ItdvEw3zSbu0NrZA156rNaHC5XJAIkidx?=
 =?us-ascii?Q?KBry+Lq8wFPRqtvMEJXBKD4lH6VTh7JILxN2MQeeDTcaWOANdhnc43efC2Lf?=
 =?us-ascii?Q?cL2MXLd4cxsQP2aUIitfoPWpsFvuiVu0HRzF6pHFb7zARoU03etBqogKuIpr?=
 =?us-ascii?Q?o7pSX5rd0EXuXJdpbU1GnGXhDduouCfbdzv8sJl3QkmOiLpi64fl87wzG0zO?=
 =?us-ascii?Q?XKoi2E+M4Nz/LXkTwMsSxWFUHDwi4JF+aMW6DwtxfB/k/jssLmbe/Vhpk9HQ?=
 =?us-ascii?Q?3OEJ/5IMDTTCi/PDeINYZBsOsZdW74WxTPszP7pSzICNredjnneWYKNI36VI?=
 =?us-ascii?Q?s1+Lk1h8iUduxPCohM2XrsCvcwhxLP6a2FwiSE3OoIVosLwC07fHV63IXWhr?=
 =?us-ascii?Q?6QbS1txVHFj5BqcK56irpd6HV0DfRZiXq0+2CxWep7ZLglJcrYwDaKqehhAb?=
 =?us-ascii?Q?/95l+NAIw6Z1nar0xQC54q8zGl2XdH6+3TPGZ+ifoKnQhiHWPIBjeotsH+H5?=
 =?us-ascii?Q?eKQXc0484xQYexdbHpLDVsx9M+q0F88kKlcIcplUKKF+bPZxaRU//imvAITK?=
 =?us-ascii?Q?Po0yn/Rbt4UIazxZNY0sCSn0alm09gigrLU4utaAwykjjyN9FXkXOElKnR1I?=
 =?us-ascii?Q?/Mzt4QjEUktlM/UF4NGcHj0o8+0qQCWcexOViTqKQ2yJ8tlYpTQtBTppIohe?=
 =?us-ascii?Q?UUh3LARdwCvLUwaHdpUvgdqjkqoJXJbN70GolX3GEHc6+Z1xnApOwpYup4Oo?=
 =?us-ascii?Q?wFGbusk6nWRJ3Ch43fudf3l4JYi9X8GSqb129ntKVAQmtT8aXHMDcNvrNUN8?=
 =?us-ascii?Q?w4ekbG8IO4bm/W1kuSo0RqgtzLZfpYUKz+H/nZpKtlidX4m5ocRkN6YqwqyU?=
 =?us-ascii?Q?zHX9QWA5VVCAH1n6pOVohtALvkN6EAhqNWqonQUL02eG1kz+LrBWGqnjge0y?=
 =?us-ascii?Q?kmkroJiZvn6xYuMwrIH31w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E438EB1A13B6E74C9994CAEA0565AFF5@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a2837f-ff22-4fc4-880c-08d9e2eb2d3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2022 05:49:55.3300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BM1PR01MB4084
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aun-Ali Zaidi <admin@kodeit.net>
=20
The eDP link rate reported by the DP_MAX_LINK_RATE dpcd register (0xa) is
contradictory to the highest rate supported reported by
EDID (0xc =3D LINK_RATE_RBR2). The effects of this compounded with commit
'4a8ca46bae8a ("drm/amd/display: Default max bpc to 16 for eDP")' results
in no display modes being found and a dark panel.

For now, simply force the maximum supported link rate for the eDP attached
2018 15" Apple Retina panels.

Additionally, we must also check the firmware revision since the device ID
reported by the DPCD is identical to that of the more capable 16,1,
incorrectly quirking it. We also use said firmware check to quirk the
refreshed 15,1 models with Vega graphics as they use a slightly newer
firmware version.

Tested-by: Aun-Ali Zaidi <admin@kodeit.net>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Aun-Ali Zaidi <admin@kodeit.net>
Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
v2 :- Use C styled comments
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu=
/drm/amd/display/dc/core/dc_link_dp.c
index 05e216524..086f7ee2c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -5597,6 +5597,26 @@ static bool retrieve_link_cap(struct dc_link *link)
 		dp_hw_fw_revision.ieee_fw_rev,
 		sizeof(dp_hw_fw_revision.ieee_fw_rev));
=20
+	/* Quirk for Apple MBP 2018 15" Retina panels: wrong DP_MAX_LINK_RATE */
+	{
+		uint8_t str_mbp_2018[] =3D { 101, 68, 21, 103, 98, 97 };
+		uint8_t fwrev_mbp_2018[] =3D { 7, 4 };
+		uint8_t fwrev_mbp_2018_vega[] =3D { 8, 4 };
+
+		/* We also check for the firmware revision as 16,1 models have an
+		 * identical device id and are incorrectly quirked otherwise.
+		 */
+		if ((link->dpcd_caps.sink_dev_id =3D=3D 0x0010fa) &&
+		    !memcmp(link->dpcd_caps.sink_dev_id_str, str_mbp_2018,
+			     sizeof(str_mbp_2018)) &&
+		    (!memcmp(link->dpcd_caps.sink_fw_revision, fwrev_mbp_2018,
+			     sizeof(fwrev_mbp_2018)) ||
+		    !memcmp(link->dpcd_caps.sink_fw_revision, fwrev_mbp_2018_vega,
+			     sizeof(fwrev_mbp_2018_vega)))) {
+			link->reported_link_cap.link_rate =3D LINK_RATE_RBR2;
+		}
+	}
+
 	memset(&link->dpcd_caps.dsc_caps, '\0',
 			sizeof(link->dpcd_caps.dsc_caps));
 	memset(&link->dpcd_caps.fec_cap, '\0', sizeof(link->dpcd_caps.fec_cap));
--=20
2.25.1


