Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA89571B55
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbiGLNcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiGLNcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:32:21 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B35B6285;
        Tue, 12 Jul 2022 06:32:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=biTzxlkgqLFq5N3UaZdI/vInnML3Cwafs5dcLRKc0v04MuYgV83ehIGB2IrYA5P1zPKGA7FHOhALMCKKuU39MopuJEvcT5Ew5DtENgHhtECGNYFdhZF+7aXUMvCTlN0slar3jSujJLIGf6Axr61xBmbZr/h7mV3FCuU9R1lT4sJQz7CjAmsNsoOx27d8cJrvKaWOVMoB7MMwT3cjeVIjNR1BGaIEK1CKNy+VYz9o2n2ycjwn09XrhcwgqgTxV6AtWATnJlcBR8p2zKOHK2VcHSs5n5jyG+JK9EuQCrIyHHAJCPprptgEYvtKSrZdnYVUWkdwel3/cZP04oEedim3kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6n2CfwSZBHMO8/Au/I+BG4gcMtjZgGGhQc8yo6CWpY0=;
 b=crprU+ZTs8uasMrfkGWS1gQohL7DQHI2SvD5/iRC41FZ9xGefijdn0Qr2fWItw+TEKaGfS6He3M2n+GHV912C7epBnqHAFlj6Kac42PYqhmVDKPZZvsvcFWEzhpcoinDfpV11m2DhuAPZZkvWuOhy7UcM5DSdZMqPCW9ZxfCrqVf5TvfRFbKDYxMkTlHopvF03D3hFMQM0c1/z4fX6C3yuNxYZk7WtWN2OwFR55zLrCAiLKdyraoXqX6S2ULjHDZFVyRRwqWFyylEqd9GemmBtaOVPTthGkMpEe1msYh7biL+f3zuw96j1sBCcSu0BJw1dToQRE4mfFhqDgrfd2Luw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6n2CfwSZBHMO8/Au/I+BG4gcMtjZgGGhQc8yo6CWpY0=;
 b=Zsr1gLaDcJRVBOutD1Wy8kpZvf+7WYjv5FUNTe2DWEVIWCld59ahhqzcJ6mIvjulYSAyg3RsgrzglxXK5fZS95KrcXUAbVES6GvfZERYu5ZMO1+ixOnUq5FiI4o3RgUhwP7C84Ioz4OYjjmrRoJR5vP8Zual0NluNxNfjnJR7dk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::22) by DBAPR08MB5608.eurprd08.prod.outlook.com
 (2603:10a6:10:1a5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 13:32:17 +0000
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::dcaa:905c:ff8:1f5b]) by AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::dcaa:905c:ff8:1f5b%9]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 13:32:17 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: [PATCH 1/3] arm64: dts: rockchip: add vcc_cam regulator to rock-3a
Date:   Tue, 12 Jul 2022 15:32:02 +0200
Message-Id: <20220712133204.2524942-1-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0076.eurprd09.prod.outlook.com
 (2603:10a6:802:29::20) To AM4PR0802MB2131.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d62d637-7268-4107-affe-08da640af048
X-MS-TrafficTypeDiagnostic: DBAPR08MB5608:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 35sE7Qyfbp3/Vn60hk01tsQ4BOi4HykQqyZcip/scFT+xpiXIfp9KiwW2DXRz5A4Pjbl2vIS40CVYtrnsfqoYSH0Pob5bG0I7J72MtRBmIqgJ2exxNG0M9gmbUy+rvpZEE3STNggu9q5/dlyDRY+We7FbOC20QzkvcdVHWNISCTYAJk1/pa4qrFOX+BSiA0ISrvigw34NkEMCkdjkcRrfxXEAfCbJZJqdoxyHKgQNu4X0gQ6gvIWuy/vZ2DaQXgNJHjnSxisoA2V0ygKN0WYqmh5lvRCjlqCAFi8WuxDChjew19hgNQJhvElBV7xOaXmIn7BKtidqCxhsUvbS4QrEu2IVI3FGwQcUdn7wSrmrHQnGpbFB8bBjb8jrZquFcqe/F6MRB2BdGPcVGkWOqVob7AQtVewrqd/e0nmyiQm4W/uNU8THsUwTlpY8gv1jPZxHFSOmQuE1kowc2qoCPWcS0iUbZXpGCyYqQEIS93REO70+sG78/qjaUL5SRYyy5jil8nryOnEVDFgb0CH3vEuzb1FuTSv0BIWK5M7aOQPqNlOWCn23+DJqkKiATNaocJgAMBs4v1QvcVeJK64tpkYpAuVP3n28FF8lZcdbdbbbjw53XuQYaJwQGwIwaL7dEmxBPZHW5aXD/wyQuFjDa5lYlWmarrfnaq8syoW4FpAbGnjg+KlPEfPUe8WHdcYGL1zKFSA5XoPcsrD3wDr3Zo8rY/yIWybcmYHWwP5Oy5PRPFofecOV5XZMu8I4XSu529dWvVZYR92WZWQxBLTuoUxMvfUkPzdl4C3vcUK+iCi/nq3n9+mc0fx38tf14EQ+4fX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0802MB2131.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39840400004)(376002)(136003)(346002)(366004)(396003)(478600001)(41300700001)(6486002)(66946007)(38100700002)(2906002)(38350700002)(6506007)(52116002)(26005)(66476007)(86362001)(8676002)(4326008)(186003)(66556008)(316002)(107886003)(1076003)(54906003)(2616005)(36756003)(8936002)(5660300002)(6666004)(44832011)(83380400001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lGtZDtcCpNRH/vjrwNune9zPn1ynm4YERvPzmh1wui6IZMaIXsc3qriUpjmD?=
 =?us-ascii?Q?J3T2gquYn4Pi9BlkdvRV/nDcxcYbck/1eXTZV+xylx3HRS9bipFkC4LqkCQj?=
 =?us-ascii?Q?DbvwiklWHVCdFsKyU8y853Yh7xaYxAQz+HphaHIoAcRaXIfHivr6tuPgwPl5?=
 =?us-ascii?Q?oCZ1x2bpLd5hjWb7woDW7qVY8/MjKuj9b5spGH24eW8NJy8gwPy7+C4gtFJI?=
 =?us-ascii?Q?6jzST0zPplQA2AR0Q6lxX5XlclIVgAMOhGJjioq4sDtvIhpH8TFrVcmnpyLS?=
 =?us-ascii?Q?HuJ8Rqtnas8XDh+UngEYuKN8LW/Elem/CmKDKslgDOvLyE8WzOQ+Tddn/Pe8?=
 =?us-ascii?Q?whHm+h/plxZMA5kmgjQoDOwXpoSK7rX6KAUB2KZplmR4vInSljoOgRwlp5Pu?=
 =?us-ascii?Q?4S9fBsXBxlE90Zf5TYHi+MkFlnWBQ70nsp9VFB6wiCi9u4Ve9r2Em03eGZvR?=
 =?us-ascii?Q?0n2QhNTteRVAyJRi9n0/xp5gvJiBs+cqNLtv3aQzkEyKTcMYKRX/GIZjTGIZ?=
 =?us-ascii?Q?WLMixekui2IGuDpru2wuhAONUvvpp/phr5n8hRbuK8o2Jz7xjhk6jSEuoO79?=
 =?us-ascii?Q?r2DuQSc9RYb5FgQRE2O5U+35vNOAd7vNcNtNgcKPTxUlyvVqz4oqmK2C7gnY?=
 =?us-ascii?Q?PibkWl9PKkCh0x9GZoQidANZxPWpqJUd16oXn86yGwRiXfmT2LKU3KjFJwFZ?=
 =?us-ascii?Q?Mk0XHMsh4zDEDZjEyIMk37ehBDrHLPQdl9cG/HVCWR3G3ULvBjrq5dERNV6+?=
 =?us-ascii?Q?sqwDIm6fgZ0AYWP0hJAeowB2v1+Q8iayvKTWdUiZLHyBhBtuENLGvgOsuSO9?=
 =?us-ascii?Q?ntuDlhFwSqhzE5lAfTpwLC0GYjZULMUhFsIshyeO8gtS7q9CRC6jkCx9Z8Fz?=
 =?us-ascii?Q?N9P/4qcidp21LYTJDpxlBqH30ce6kwQ9lpSF50R0e0/9oK3IgJsNDZ/WoP3v?=
 =?us-ascii?Q?zKoGKZGbSJRyJf5zbtGnpRCPccpctqXFMOAv5hH1PqNNDEc7rtBjes4Abs8n?=
 =?us-ascii?Q?ghd9U8U9y2ktAGBpXqIc62ZadKuwlPfj2Px1G0a2HPqW5IMR6tAt3SRSj9tH?=
 =?us-ascii?Q?nhJ59GBG5WW/ujB1gSmqnYbx/8KYv6Z7MhBMrINC2q5BSGe8XDcMy/04eXuP?=
 =?us-ascii?Q?LlXQZ0qiTgz9z0Vr01u6vKAJrMopMqaQ4WBjgr1ml4gTbGvVK8degCfoYe/T?=
 =?us-ascii?Q?42MDIi72DFK0R3lFQu73NxPbRsK1YRAPynMGwoObff8WqTWIJGNYhXeOJusT?=
 =?us-ascii?Q?nO+9+o20fsjxWFpFVcqNzqBZLUd3MebQJaE6MNV7wEDGpUhUMWdbU0BRhvMr?=
 =?us-ascii?Q?mtXWQfxGed8qQV5yK82/DO+saUU/hNgtEsZ/eMxWK/W9BRn65c3v5rQOxXwB?=
 =?us-ascii?Q?2LCae85nxEA2L2mj2OQol/9gVcR4waNdcRU+F0G4xN3wkm9foRP/mQnXHnen?=
 =?us-ascii?Q?O10jK+mZyZbP6uDcrozFft+5o3UYSJl/2B0vyZPyzmJZOjv96Tjc3Y1hwZJh?=
 =?us-ascii?Q?unirUk7yLKB+Z3oePD3JJQx/3kjoGRyxjjN3IXzSqVmoe5DtnTQoG7jCXSQ7?=
 =?us-ascii?Q?6GEfdX0RL2QOg+GYJIdTBs/CocvVhnjG4FH0z5cmtyA6WJOnJa/e3dVeMGJo?=
 =?us-ascii?Q?v9FEOzKNf1zqYU47xs+qaPU=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d62d637-7268-4107-affe-08da640af048
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0802MB2131.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 13:32:17.0873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EvfBZ6uLw4ixF0nEAYp/MpU0nzldzk2uW2NkN0lQiw7RF9oDowYlrRv2C1vpRUk6BeVfRwBxmVbmritQF1YztywXru9LNlpvMCIP0E2ibCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5608
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Radxa ROCK3 Model A features a voltage regulator that provides
a 3V3 supply to the MIPI CSI connector. Add this regulator to the
device tree of the board.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 .../boot/dts/rockchip/rk3568-rock-3a.dts      | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
index da2ef705ce29..821f9b96914b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
@@ -131,6 +131,22 @@ vcc5v0_usb_otg: vcc5v0-usb-otg-regulator {
 		regulator-max-microvolt = <5000000>;
 		vin-supply = <&vcc5v0_usb>;
 	};
+
+	vcc_cam: vcc-cam {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio1 RK_PB1 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc_cam_en>;
+		regulator-name = "vcc_cam";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc3v3_sys>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
 };
 
 &combphy0 {
@@ -454,6 +470,12 @@ rgmii_phy1: ethernet-phy@0 {
 };
 
 &pinctrl {
+	cam {
+		vcc_cam_en: vcc_cam_en {
+			rockchip,pins = <1 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	ethernet {
 		eth_phy_rst: eth_phy_rst {
 			rockchip,pins = <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
-- 
2.30.2

