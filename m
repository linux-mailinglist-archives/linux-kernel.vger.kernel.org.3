Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68AB54BE13
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 01:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357772AbiFNXEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 19:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239689AbiFNXEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 19:04:10 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150080.outbound.protection.outlook.com [40.107.15.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2992A96D;
        Tue, 14 Jun 2022 16:04:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJZwf2EOPHFRmoXDLOzBaN9Wo3IZEqVQYNjIhZEK/wlwXfCbh3XByUd3hhUMlZSr//1n93gJ48X0x4YOlCc5AfDWW6qVlIjp9WSzrD47WC/2UARMOvTh8+nXMOKGeeypei/FCXJ48hu9uLj0OE/Bcwcanz39bEC/hnMRt26PWGwyt1R79d3cuJ1SowEuzG/xaW+xeARscByvEYli1HjxHblzbwx+3imQQj5c4KUZnxtVrKPLYqAIU/1HEGaKEzObWxtexCjLjeyuxx1NPZ+AkZqWz5z56e3Gl0scmEpzHHanLy8unBY3DSuCsI+72u7N5uEMKk4wpF/0HlkoqlsSRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcvOMOUXzbDZy0M4vM0GbwTl7FW6sYGAj3RGByHu0bY=;
 b=Bb+zvdn0aK8VjBS3ndhq27b1pVYqKNBRxbt/v0RJsuUqtyJinYcXWn7ax0fbVMlIX0V59VMP+9Ll+gVJRRJDjQpjjTpBPl+TRirTRVOKVk1JByy5URMR0911DQSewg3cwgm+P32l/O1lB68B23+uBzd475dbA5yDllN01MB51mkK0BytDruG0RO9XTm5TGR40cghb8Atan1+xqpZW5yVG/L+JcDHFaR7jdD3znuw7yY58/RjrM76MhKHlKgyAEW5DryXQvRXLjisttFys/DxwjYE4O4xHzpbcp9mcqMvzyhfTdevk1UJJo/5Rh7aznmAkclExLrQedG0Hafo4TuebA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcvOMOUXzbDZy0M4vM0GbwTl7FW6sYGAj3RGByHu0bY=;
 b=Go/T8eOcxUErD5fYyqPo/RSTr2hcQf8qK+OTwZll0vIYVUYI9g3ASeKh5EKiKJCkctql5Ktnm0i14uP6MaJP+rVKRIftQ7xJRXVSotNnskVQHEjS0Qx6fxUK4XXlNHCBkUmvQj8QqLCBu1CUIIUGQqP1y0c/0hvaXHjw7IbVvrg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::22) by AS8PR08MB5926.eurprd08.prod.outlook.com
 (2603:10a6:20b:29d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Tue, 14 Jun
 2022 23:04:07 +0000
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::248c:2539:5ba5:74f2]) by AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::248c:2539:5ba5:74f2%3]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 23:04:07 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: [PATCH 2/2] arm64: dts: rockchip: enable hdmi tx audio on rock-3a
Date:   Wed, 15 Jun 2022 01:03:54 +0200
Message-Id: <20220614230354.3756364-2-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220614230354.3756364-1-michael.riesch@wolfvision.net>
References: <20220614230354.3756364-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0099.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::14) To AM4PR0802MB2131.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9085282-03a8-4043-49c7-08da4e5a2f5d
X-MS-TrafficTypeDiagnostic: AS8PR08MB5926:EE_
X-Microsoft-Antispam-PRVS: <AS8PR08MB5926F7CD530FB8F0CD1ED4FFF2AA9@AS8PR08MB5926.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7/T+g4yuacXX/xQjzhPM0pM45I2K8JVKUpip/8C/Qq4hvWkM+eTbVj11M3biZTZk2suQg0sLI/cZVD17ZlyEAt2Exr6qbjAUKFc5n37H6cAcWB2B/JELwInZwAgPqnscE7/GxkIraiDaznQLhVa9W8qElF9CgWQoexrSN83efiR19PV5OiPjVL1Nxrz/a0Dy0zEppKhkv+FrMp+aNYWQL9sajiA/bWDr3+aWHS1b+UIMKlDodmijHSZ9lIQSUcFwha7vPIRPMPE80KYRFBvsyzqzgsttcRl+oQzKcDFICreMntR2jokn0zXGXo+iBssw6m8zb9nm+95GbmpX5Ckm66JAdqbW2rCDNTziJk+Bu29YiNIANFwWVH4MEBW6YAD4Wsb7L8bpa0mTQzT/GhFyMojMeGtzEk76G4hn52VxS0FklE5FkLm19ztFGUqH7R4hZpo7y7l6kUSMI4f5pMn10eWjdBOWUoCHFWXUg5Gs1Ukc9xmTvmy/6RKif1f0VaazExKuq+vbA9xOXn3EXVzLHqRO60qw3ZEcJ4amfgMlQb3zewbMJBRq9BNVDCWkYSh5XZrGrkLuUZM0RLVTFUHByWMCFGAaFnKuE9enn0XcNKoegROz+IrhTyYZlml38hgXnJOLNmVVN3iAN4JoMPwECQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0802MB2131.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(39850400004)(396003)(366004)(316002)(44832011)(5660300002)(508600001)(66946007)(8676002)(186003)(86362001)(66476007)(4744005)(4326008)(66556008)(107886003)(1076003)(2616005)(41300700001)(54906003)(36756003)(6506007)(52116002)(6666004)(8936002)(38100700002)(6486002)(6512007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/YCUMimQWzH1hSkjqhirn6XOE9c3KbI1k+ouVLAriHebdbvqjg1P6TZQJaoq?=
 =?us-ascii?Q?iNjhYfTwFo13/gECdwCU15wkvWylAvTqoByhElq8xFxpm9Hga9eksoRlNtaX?=
 =?us-ascii?Q?ZkCUR6dTOGQ1Ss7GJNdotYqilgMj71aYD+XiKvHMVabEq3kJi0/HOQ5jJwMS?=
 =?us-ascii?Q?WThHa8DpX209GxjiG9bm9U5EDIFfZy5G7AKmnt3STKmhIIs8bDKRIQYGLdN+?=
 =?us-ascii?Q?LzG2SV7xMBrEqLt8Ncug/fhvC5t6bqx9uQGP1kNu4+aUhLrsa7H6n2lUST9n?=
 =?us-ascii?Q?Sl5WWbhrTIWB/QHD8pBt0OV/Q70eb2GYh6mUrSPD6q2rLoBrG6dFq6cwnsea?=
 =?us-ascii?Q?GpVKG4A36DNUqiYUpJzmtsdu226i4m2hJ+Uu0IloPS5FWA1yRKMw3gctyqoN?=
 =?us-ascii?Q?ksqSCDYVziwLp3nbtyb3zfBeiJ8oWQc3dFNxngyFj1PjrzMNqgMFCgdjwhvt?=
 =?us-ascii?Q?GUfXKw/dTCBWjSdnZHkMoBaMt5C6YpA2Vrth/tRRQima/3yyg8hkjE18MTg2?=
 =?us-ascii?Q?M8RI8dAyWRAnKVWwdRMvkNn8q73S0+zgCd02IT1mXDRikEPv82tQpLpMSjdF?=
 =?us-ascii?Q?YUICMxVrSGO0U3BvtsN7fIvN0XeGoP2//QnbqzW4lmG+HG3UhuoCi+jg7NjJ?=
 =?us-ascii?Q?NPI2GL8m/TBHmxvK/W74rQiobzaGfFsZ/W+LPns4h5kcP9/HyKaSh65mBI/P?=
 =?us-ascii?Q?tPpFdVFsxtY+/SyIyhSybu/wUVz/bzrspqfu+bxdS6qG9t9QRrWzZfdazQVC?=
 =?us-ascii?Q?tDng/+7bPL+uqkTOexBgKvNFI9K4+CGW2KXAFSudS/ThcG66wzGyJ32xW/pw?=
 =?us-ascii?Q?k1qVbxrLtp3tozDAs2ptmy6fnF9jG62a/c+6GMpPPEHSFwj+Gj1qtc9UvpVk?=
 =?us-ascii?Q?XZKsWglVgv9yF85bRZRn1nnCRgamRJBkn9AITNMYax5UPtoQI3CI7VMwqpLR?=
 =?us-ascii?Q?4vGOiHX3P4bYD7szmClKNwCRvEEvggG1phzHE+YnVHIrUFWVRfMG2RKyDxIZ?=
 =?us-ascii?Q?YD94lN1oo4g84nZqm3iEStsENPGLOKHv7D3dZ/eLhCYDt1drKHbitxvfQMxa?=
 =?us-ascii?Q?NGogDJjx2bsdJxlvFuoBNpHgXNLfkvHFD5wXLmdXcUjLgZ8ufEA6Sx9miTzM?=
 =?us-ascii?Q?gwID03tYChueaP6KonHWkZB/T+tKhcxq9H6t1E9u2g+3fl205VhqzSrdS2eD?=
 =?us-ascii?Q?VE4G3pGMVly7QU6DI0+mAgxRFC1aN15rmW1DHyTL/V/BX0xZjiqvbdej2871?=
 =?us-ascii?Q?xfIuIrKYi8+aAMBItzO3Ilv3d7BKV+Amx0CgsgP8KsmudzI9Mpv9FTjE4INF?=
 =?us-ascii?Q?KwL9+Xo+buIgb3J0jaXmm1a60S+DDen04F98R8c2sAm7wmDUyvCbvLkblp6+?=
 =?us-ascii?Q?5xPCW/6Sjuw7rbzXP7Wguu1nKio5sgDGF8a1o37g9eZJotgc0BImbvokZgkY?=
 =?us-ascii?Q?BNE4DsNasD6BWPKSdjWzqplqFWBGz6lsQscPqKD10VuKhnTrP/vrUDRitXh4?=
 =?us-ascii?Q?z5dvQ3aEO8OgdRcmwFKXUnVbyMLr27lTonWkBGcPfcMC+BrkqfQyT/6704T4?=
 =?us-ascii?Q?fUS2aHjhn9K9L6ohWi7EO8Zyk66IGM3FDMSJZSzGEwwxpbYaon0PqD7DKGEP?=
 =?us-ascii?Q?8jWQo9mdL3Cf/jIY+YsIRkMOojm8NqmpSF9+YGm6gpezRkaYPabq2o+0ZvNf?=
 =?us-ascii?Q?rAxUIbdvxpNQVo1qTFkiYrQ7+szgBH/ee18fpnOBetL36kpzp5H/2+W9ffc0?=
 =?us-ascii?Q?gMGA1P36XW4ucULXUW4dRtkNJfubj4VuUrINf0zSqexRA9GA5Z6e+rWBPqWy?=
X-MS-Exchange-AntiSpam-MessageData-1: MtoPsttJCtJgfivJFM+CplgesRTCI+UAASLV3d7LFxJOHsUj0fKWW6Wa
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c9085282-03a8-4043-49c7-08da4e5a2f5d
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0802MB2131.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 23:04:07.6418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 84BIaBDIlqKbmlPfiORPEON7zwju3fKH2sEvbdLtCy3CUpCgoana/KHp11fiO4Z813DWqMODCDp0Ug2WWCnahlxHFr/RrR3DjbUSCdPTTV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5926
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the I2S0 controller and the hdmi-sound node on the Radxa
ROCK3 Model A.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
index da2ef705ce29..6b5093a1a6cf 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
@@ -196,6 +196,10 @@ hdmi_out_con: endpoint {
 	};
 };
 
+&hdmi_sound {
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
@@ -436,6 +440,10 @@ codec {
 	};
 };
 
+&i2s0_8ch {
+	status = "okay";
+};
+
 &i2s1_8ch {
 	rockchip,trcm-sync-tx-only;
 	status = "okay";
-- 
2.30.2

