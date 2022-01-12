Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9037248C34D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 12:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352927AbiALLiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 06:38:22 -0500
Received: from mail-ma1ind01olkn0158.outbound.protection.outlook.com ([104.47.100.158]:20562
        "EHLO IND01-MA1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240126AbiALLiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 06:38:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXHxtAd6p+rP5D9g6s3+/kksyvp0ZSdI1gd4gZ9MnFTL8tjWSjwQDLSYmEVwhGikttSUyDI7Ea4LEce3Pg1G4gNFb+bIYIZn0SxfyumbOK3/3pnsD4/mtHObKBmEiwznznsq3CN/Yg8nwO5N4R4C8rADkXTQJp663aOTsPmeSJ1SH3NVhrEiGQcICrkAXTgnzUE/cLUk8WEzzRY1sIE/0h5wBHvLYZEl0VmPgionE+smqBxRH77v60gbJtW6iCnhhh5Z533HqOs+ZcaGWcvY5QFLGXuyKww0qx5Q5d3J0rK78v18Yyw7peSo0bubm0NPgl8G5o0qhp8qTIX7v/VhtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVXkYUdn61OI7VmNeupfiHJuRYIQRw9gflew86sCwH4=;
 b=eEHuSt+vFW33taN4IOjndnMWnXDKlsvDEDC/Ub09ONMeP2ZPFC6ggOM/kdCJEySHmmgRlN1yPaVme/1z8AnYEsFLITkD37FbjdMiiC81sgiQ+oI9Mo5T8FqALIF8AZAr/IZoMwtx7xTqAzlx7W0IQ7eHSgb+L6vHYHbsI5z6Ng43iVMz3UojjMg1gB6bUqQcqYZZy5Nla11GynKQ4DR3wFA9eUAIDFL02aQHHzlKt2eumvC4L9H9zSCT0Lwr9DZuxACoXxK9mIaWEQnewCw9Gv6bqJ825r0Ii7rT4srBtPhc1s3VXiQr5VnLHWzLASEVpeCGpuBbwWSp7hUZGMGF6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVXkYUdn61OI7VmNeupfiHJuRYIQRw9gflew86sCwH4=;
 b=tC0p/7TI5DWv68ZXjRqgYrRXQsOQmDKnULUWBKgXot66S48X7o21JqQFuALa6fGc0JwR8y0Mp6uvylPPAxyZ8aASRyrkCHfoTE4JKRJD/qpn4krZx0PHFGaf2U07/45nZXLJyIB/5cYFaN11IB1O/ubS4+aXXtViQL4tFY79olGkSm5q2BLrN1zrpFFvJY8EOWQpvaqjMLQnDesMphSuAlWWZ6Q4PPVSG85Zyx3dKrWgK9/IHRKnZlRjVv0RVaIGJZjAYHcsWf1uJ3EJO3KE1617ydqZMm/hNln2qhXtv59mtfxhTcidxmvYQi5u9uF+pSIiX2eEGX7pXV4qIxaZ3Q==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PNZPR01MB4687.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:33::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Wed, 12 Jan
 2022 11:38:16 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7ca6:9165:19ec:4cd7]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7ca6:9165:19ec:4cd7%8]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 11:38:16 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     "harry.wentland@amd.com" <harry.wentland@amd.com>,
        "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
        "Rodrigo.Siqueira@amd.com" <Rodrigo.Siqueira@amd.com>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>
CC:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Orlando Chamberlain <redecorating@protonmail.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/amd/display: Force link_rate as LINK_RATE_RBR2 for 2018
 15" Apple Retina panels
Thread-Topic: [PATCH] drm/amd/display: Force link_rate as LINK_RATE_RBR2 for
 2018 15" Apple Retina panels
Thread-Index: AQHYB6jjF2GESjF2oUG76i0mYHGKrg==
Date:   Wed, 12 Jan 2022 11:38:15 +0000
Message-ID: <1A00E804-5390-415D-B6D8-2551C8954DFA@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [hNn/Sb7Kt6rzonYPDuTVqRmFBLYfPtDZLND5yiZtCgdtdVlVEcRQBVs08rHfR0SC]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15dd377a-8e5e-483f-c6fb-08d9d5c005f6
x-ms-traffictypediagnostic: PNZPR01MB4687:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yMfKSXK0QZmzzVawypKOCdIbPJBdHaEoirlXwn9Fup0orBUOg07KO9Sk5EQ1Q0SFOeiiAELfNnG4gylEdGgsh2n3sI8kDdMmcfdg4cjD7XizS/To+pSrzzDsmZUtnpoKivz4uFuLw4yySus8lzpEC3sTgS3hogpMm/pJ9ngkCXSf+yAYDHK6Pky1QjBjDShljIlGo1vpPp+ScyQNx4YiIjU2ybFv+0EdvA6FVuH2R27EHSDXuLLplwudA+uMPIg3v6B5yGJ/bLD9E3+7K2PkNrNPpAtEGMxerlFt//MaE75SEOEBEDUmqcKEuwsqjJ9opbhKnHmm+k0RHJGfbtdsfbWZVPCAiPvbgDBrTCJ5Eq5c1BNXZJ3yzaL/7GCpLCl8vv610xO9MVfrft6qJZStNLSC2gJX7ftX3Arcz1nfKO23c/4QFOhUH+GMA2wriV0wdUPAorGjOCcxVOA5oyHngdfZPFsox3AOBIgmyU7mzGpYfJi5osuOBl8qyUraSveWM7IgBNGzPp2suZ+GeU8ed+ap99juMfUJm7lGsjtNDH78O9HRrUb2WZPqjniKeK+jaI56qIU97jyo/A+vsusIEQ==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hOn3gmDU6I5InvfTTJrRIexZ7AkvKtDbJZuB1M1SbKM7M6/P+ZpMJXjp/UqA?=
 =?us-ascii?Q?/MQK29RwB6iHeieMfkyP3pin3sq6OzFxczyHuQMTd/ogijSBpDWP4jJc4197?=
 =?us-ascii?Q?TQt2ny4D3CxyTk5Uy6ciWP9FPyoILBseBlEt2Y2R8HqGSHYi/3c4tHdhAULa?=
 =?us-ascii?Q?5nIe0QApZDaEODAhEbdgXgvFtfJE3yP8w5U9s5C9p3ZDPdzMfCVVbfSy833T?=
 =?us-ascii?Q?lNuLNwQuAgVWb+Je74x5oQYKco1cFj4MkYiWE9mDKtW+80i3fDO2QjYicSAu?=
 =?us-ascii?Q?5yUj3EM4+R0VyXRuaUTcNSH5AANoIjMuYhcmYQL3TQheyvgOUv98kU9BeXjY?=
 =?us-ascii?Q?Tj9zJ5W68DsZqCt36XHzWbC6X7pxu42e9MeC35jO5/gkDuliHS6PO/WuPIPI?=
 =?us-ascii?Q?3ihYVp9oa3427lh7qMYhyFAYzO+GLKu/HPwr9AFvhSiWM5k8M13z9DN1D4PP?=
 =?us-ascii?Q?ehUY/pc9M1mCavmPFsxw6L+mcQJl45NHRR6GS28zUgwR5mNMwSMJ8CP7rqi+?=
 =?us-ascii?Q?pBC4sBT5wKlexyW7QvECueVaU18CzIVQVe8G3jwpBT4vhb3MVBborE00oq5W?=
 =?us-ascii?Q?0lh6P7iMF/tkzkbfJ9bQMo/Xp2pZdsCDGUzZv66Xai7jTHpYUXiCqYl6kQ24?=
 =?us-ascii?Q?wwYX6NtCFMY8/P34zdtC30wKM47RBU7wbqdTU17PebWbuBkIScJELH1rWD/L?=
 =?us-ascii?Q?skpZo2N0L7Bd1s7MWXur8N718vb0nim5w4WuX1aexJWob2rEuXbBby2su0MD?=
 =?us-ascii?Q?ZfutH7CXffr8H7DJFestdaBkYpQz35RXQk7hIxomoKedg34j1vTLVRaRKoF1?=
 =?us-ascii?Q?tDPv1Nb/zq1ih+zQSijuYx2Zs0xGsfCKF4fJFc59eTGq/WgfnbOy9Gsvm/yU?=
 =?us-ascii?Q?Mnds23BEM9iOu6783Jj6PtbTCSN8+XZmu65WWHV2jQqndxgHHgIkISDEGoje?=
 =?us-ascii?Q?GGYVsUBlXGxXgkC98Y+ffPQz3nPIjBr2yrXlsaKaqcN/Hf3bYLPXzEYZBaFP?=
 =?us-ascii?Q?1Tzf3r/xlgw45KfFLOrMbrlFDg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1EB580D66CB3AA4399B90B391C3531AF@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 15dd377a-8e5e-483f-c6fb-08d9d5c005f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2022 11:38:15.8897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZPR01MB4687
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
Signed-off-by: Aun-Ali Zaidi <admin@kodeit.net>
Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu=
/drm/amd/display/dc/core/dc_link_dp.c
index 05e216524..17939ad17 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -5597,6 +5597,25 @@ static bool retrieve_link_cap(struct dc_link *link)
 		dp_hw_fw_revision.ieee_fw_rev,
 		sizeof(dp_hw_fw_revision.ieee_fw_rev));
=20
+	/* Quirk for Apple MBP 2018 15" Retina panels: wrong DP_MAX_LINK_RATE */
+	{
+		uint8_t str_mbp_2018[] =3D { 101, 68, 21, 103, 98, 97 };
+		uint8_t fwrev_mbp_2018[] =3D { 7, 4 };
+		uint8_t fwrev_mbp_2018_vega[] =3D { 8, 4 };
+
+		// We also check for the firmware revision as 16,1 models have an
+		// identical device id and are incorrectly quirked otherwise.
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


