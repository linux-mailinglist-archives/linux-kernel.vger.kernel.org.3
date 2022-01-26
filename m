Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8F649C8B0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 12:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240743AbiAZLcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 06:32:02 -0500
Received: from mail-ma1ind01olkn0140.outbound.protection.outlook.com ([104.47.100.140]:29588
        "EHLO IND01-MA1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240740AbiAZLcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 06:32:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mm5HngDf0ybYQsaiTaq/WbYIsB7ZR3rplhSVBJxQQ6JdIcXlg62Xo3ZEv6FFxSayqOJtM7/cfBAlJ0FHdPlNQ8V1pyu+KgL2lYY5aZllnqYL/jLHswWLqxcximFGGuX0LBVc58lh7azUDNU2tzYpGeXD5KuI+ak8hsTbGpJzvnUtjsnMeKmNpKJcqgxi0ncq5gVlGuBdwRyzYH1ZDbx5/QNuPJnp4aqsGsxZ1T1VLzphj0+CGiD5UGxJSaTGl1thkTnARKOEtxpTDjYfXzss7ZYY2TAy0Nn/fKv43B1LdgXyQUfskEjLxtg0KL99KUaeG8hFwpE2mjaq1RYMTI/1SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVXkYUdn61OI7VmNeupfiHJuRYIQRw9gflew86sCwH4=;
 b=KcRLRj0iUx/hYqGVraHI2TUc7nNxrInIqZJOWMGSd9GEIbBhxEFq3L4JLnkxwr4iHfEZvPJT77SjEOOM+oWHon1TMyc7MX+Ts4aqo0b0NwgxB6jKzJHwTjDkq3bwp2Irq6PkFwz/qbZBUnuesOWRDTMIImB/ChN3+IQMa//oDJofD/h5BBz1oudUH54tlQX2WfOO8VubfoNi+qNOG9ZcTfhCVAfLOGhDYywSif2rpLh0ODGyuGKR7M+u7uixopXxMF5LbiqrKh/QP+leQ+dMg69CZblvYKbu4ajmoJKmGd1/Xm3strTvRG5ImNjgfoAnGwxQfhSSpG6bcVuU5V6JRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVXkYUdn61OI7VmNeupfiHJuRYIQRw9gflew86sCwH4=;
 b=g3N0HVNFInjkCXS2W1YaMdgxfxbiOf58K37T57ELd0/SQmrPawKvo7CVhzBM1Fi6/7LypTs9f7I80IOsGOEWVfbUwe18HaCJ0xEhgoHXGJxOJ6DOKOTyUR+Wk7dSiB85Eqh69qk1M9qLKdk/RSC58jgdGyAusC6sao6O8WipVTS/SAVjkzdK8EG9bpBVk68nwdEfdZ3Erxqtxv13w8gCbk7s1P8foKIqpHkM5w5csfetW2w2MVZM1ERrMYxCUXokrVio2NQ+RhVbxCFJRadwjb9GoAetAb6u/YMPG5nyQWjNAt+o5zfErAcl9H7kaxupWTCS7RDtLY3G6kdAo9ioVQ==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PN2PR01MB4715.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Wed, 26 Jan
 2022 11:31:53 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055%9]) with mapi id 15.20.4930.015; Wed, 26 Jan 2022
 11:31:53 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     "harry.wentland@amd.com" <harry.wentland@amd.com>,
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
        "pavle.kotarac@amd.com" <pavle.kotarac@amd.com>
CC:     Orlando Chamberlain <redecorating@protonmail.com>,
        Aun-Ali Zaidi <admin@kodeit.net>
Subject: [PATCH RESEND] drm/amd/display: Force link_rate as LINK_RATE_RBR2 for
 2018 15" Apple Retina panels
Thread-Topic: [PATCH RESEND] drm/amd/display: Force link_rate as
 LINK_RATE_RBR2 for 2018 15" Apple Retina panels
Thread-Index: AQHYEqhRbhPidmHk70e5iPJFVYdDUw==
Date:   Wed, 26 Jan 2022 11:31:53 +0000
Message-ID: <139A7689-463E-4AD9-A2D1-A9969C3958D0@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [09VpzFUvzCXwsv2lu5RDe5MwJIKbajcLz3NxaepIMqnjq8YhBAFrDhn4u9ZeFwCk]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d49276bd-bb04-4332-a2d8-08d9e0bf739a
x-ms-traffictypediagnostic: PN2PR01MB4715:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pxk0DW4g3HS/+izdrxAry50cjQNpRby+RIMgWwNkPy2CKxD70NJ7N57LS1q6JBieBTVSXSOLcnXNvXL4VvtVHOLj6k+fngz4i4HnsInN+8tgFT2sbT/j6co8tPVSUHrMpghUju47zL7xJOhYxFbBv4v0OvA2L7Wk08oNSZ4NRBk/O6C9G82QsR0PIp1R4Qy+ViruRY1QZ3Z01BmMQYfL6sKvOD6F/rIDlC0mHssARJ/kd897MYkHn3IWgblZ4Fxn6woBD74GI1dqCV+lKx5in7wF6CjiuHiv5A/oIVhLkW/kWU+kyAR5P9PcrRn2wPwWsGFBgTnv1wQWU3bhho43h16PcdWHwfeAVfqJsOWqxur35tcwucUd9edH7Oc85NkUwiZqQ6poA9WuVnos1rmKBeMkXLv3hcDvAuo8clRVM/h/Vh8wH3a3OA9A3a9GGEZruFPA18kj4cN5q06hGDkUkcr8rhTKq371v9PcJck+prW39jkdJEz06M1GXzpA5uSi/9N5OuOqQbbXAMTMobVGIBlX34XJk95U/FV9FWIYTQ7QgNITP3qx0m/CWhGHUPs7Ql0vKet6jTvHjRPFdEVHrQ==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HZPZ4wUOAt5cTJ8sMtzwCN+c+Ud3jwFcj0jA5OHD4Rq2TrvS3Bl85oVg2CZ/?=
 =?us-ascii?Q?MXXNMSbbeKX7HY4EyQKNNfiHDGmEwzZTbyICAayp5bYrWodpIRJK1lQIJF6P?=
 =?us-ascii?Q?a2NcgfbESng8hWB6shcjW3ZCe9LGdRJUbQB97Plecld0GpPkO0PmmhdI9vzi?=
 =?us-ascii?Q?Sz/1Hwc7hlXt7dM4oL7vnItCwInlSx63Li4MyybL55/RSvVxf4KD1+Ra5xzi?=
 =?us-ascii?Q?o/7Ftcjp9nlBjl2JzpkGLCjUHllkkf0210nWChCYwPvy3YTooMLYmAPJZCQ1?=
 =?us-ascii?Q?MGwncyqFkExsHYoUmBWSobuEcsA6RJOM4t+Muj+RSE6Rvduh5xnxdEVho6qA?=
 =?us-ascii?Q?oofTLYgRycMFzdwgh/5wiXPXHhjA5KeBmMaKxv/W8gvUFlImxe3Iu0+wxyh0?=
 =?us-ascii?Q?5qXn+JgI2//To106aYbSX0Ps0IzY3tEbSAp+B09qCwKMAiBmMujiOR3KexW4?=
 =?us-ascii?Q?wj8Lh18KAdhuGhwFR7qfb+E8nUZDg3BVxC/E7HFWB+e34oqIWvIexCjfMhNl?=
 =?us-ascii?Q?gGNc1kbnTEZ2/avRiLPxb1sMXWUbwyQc/DKPj4Rdy9PniClYSJiIrXeeTN4h?=
 =?us-ascii?Q?JGRNBKRG/ZwrdIXO/ol1fMyjp4y/TIRpwdWoKhye3aes8ym8wvYul2qs+CIc?=
 =?us-ascii?Q?qCquNIUvh66GjPlpYPV9lN52bV6lfx3ibWo6KO9cRuqhVqb4Cua30jTOgtoU?=
 =?us-ascii?Q?4f/gul8HF1BIJv3Rxl51W/mZMpzTJndnDaM8fe46dYB5RDw5irywKv40IuNs?=
 =?us-ascii?Q?PrLjO8URsQQvLoXGQF5qbfX+PjzjPzhz6x1r0RQSXlHCM5Fc7wDaS6ZHY7ES?=
 =?us-ascii?Q?FBednZtqlGEPUkkvCYJQZBQvhUgRGG5jIuhVtZAAjIxQXnIiwBJDv7krb4Nd?=
 =?us-ascii?Q?iIfCuYzyOAhZDGKzj6ga88vKdOt7xbNvLA0diuuudH6uN4WdPC56QybEKk6m?=
 =?us-ascii?Q?jOZJKOHzuXO2o467xKiMMr+v+PwV/rum5MtQDbQXGnvGuPCrY3WdaNOGepI9?=
 =?us-ascii?Q?Rq4iZQZhFwOEHuFoSWvHWqt0ZA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <05B1B5ED5A72154CB70314A69DE12DFD@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d49276bd-bb04-4332-a2d8-08d9e0bf739a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 11:31:53.1900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB4715
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


