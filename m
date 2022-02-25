Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1A04C45B1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239292AbiBYNRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241041AbiBYNQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:16:55 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344921FE574;
        Fri, 25 Feb 2022 05:16:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBnRjVMQcdBKqOzu8IVQIs5iaEBpcbYBd6UkAjn21Fk86OU6+M6awW1mIETmBmHH7uJHfF3ele5hwuyMCAbnDCH3IY32gqQpNfWHfwF8Hz9muxpEjcIZc7AysKbcCQtFNQNKPZPjFVRKFz3FGu9yIROp4DDe0qJVctpNFtPBiWcGoxP9HK8tMNA3CDoMT6ONr/FkEuAeruYQ9VSpafpUnk9LtsZKYpDtQ88N3WAB5Uvu/xH6Tk7ofb3vttVjqqyH03asE+Rq+VR+4OF0wlyX1HVOrGpsYbEP0tYMfojPmclc2kFPF/hczBGykatyHk3ZZfXbQn6bdJeANFm7OUSnSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pGVEN0zFWGY7L9y9qpVcOmt9ocQFtU9+BzM7RCA4QE=;
 b=HNF56ALKegjzvKu/ZsjlDDrItYCRlkq7VK7LShY29xVTkQ9FlZGos9HCIEquQ9jDISLQyiEKOqxPvIwf1NpOQaxHPsfAHZZ/AvTtqZY/GAzpLEn+gFQTk2y4KdB5hbsMQYzyNcXucmGNBzphTqltPGF9JcaFV+qtVqkDIg5/zniqqjRogjRmVdyj6ivo9hQrpaE+OaEhC2XDkNwHCT+3OxPdHn5Ex4yNAPwUJ7q8yX3IpjUWTjpJaym00RbAxC69NqVBOCS6hlOowfehsMfmw3H2pTZKzJpESWj5nLRgSJmyOZCYsN3AI4nT/et1UaQCoHc0rPIlWMIBfWb6aKKIPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pGVEN0zFWGY7L9y9qpVcOmt9ocQFtU9+BzM7RCA4QE=;
 b=0kordkK9r2Os5wcXi4IVRwqKM3ML9/ID6o2nCObJEbziBJkl0+oHrJWFt7dHamMJCWkJs+em1Ew1KrtA/xCwiOmOwuIhesQkIK5fiew3IwIVaQ/imwmaQ2+tY/8X7NsNcN0UoCqEHdP+nP8Lc7eX8h6NVC+wlQa6tDaV1QLIWJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by PAXPR08MB6591.eurprd08.prod.outlook.com (2603:10a6:102:150::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Fri, 25 Feb
 2022 13:16:22 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049%4]) with mapi id 15.20.4995.028; Fri, 25 Feb 2022
 13:16:22 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Simon Xue <xxm@rock-chips.com>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Subject: [PATCH v2 4/4] arm64: dts: rockchip: add usb3 support to rk3568-evb1-v10
Date:   Fri, 25 Feb 2022 14:16:02 +0100
Message-Id: <20220225131602.2283499-5-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220225131602.2283499-1-michael.riesch@wolfvision.net>
References: <20220225131602.2283499-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0109.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::6) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b45d79c2-dfe8-41bb-aa5d-08d9f8610477
X-MS-TrafficTypeDiagnostic: PAXPR08MB6591:EE_
X-Microsoft-Antispam-PRVS: <PAXPR08MB65916E0CF66D79424EE39C2AF23E9@PAXPR08MB6591.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GEnslCrQJNsCfQ6ED0+v5Xn2XkQvtF0+fMuS8fGRL0BkSMaSGhFqJBJu/BN1kBscgNEpBt2JqehJ66PtjQ6ulLPA0Jgd1Q6YFkjlEg25kh3Qp5J+0dmGYZkOzH9WJYyG9P5FCVXL0DRKg2Rik5ATzXlTKkdrgTBYIJ2P7tXI3BCwGOVKliDIh2b86214xnQFrgyQzC2A27KtXv8e65aRow3bCTDWJ0M2h/IwwF/480l2mnlBiP1axKx+moh04Hr8CnMSI+0eZNV2NHkS2HC218z+Noe/KWUCmglcjcxKCOdTLZP+avHLnLX5xfhLLGhsNzg92x06PUxEQR5IPJoajF3+lLmLNSPiG1MXdJqQB8FMVmHBtxycTeIHir/UZsMw1H7xy4gn9Pxj89Xx5lSgIgoOo94V/k6J8WE+E+0/B/snrvRzacdjQPw5L64TDNqHPCHE+inLafFLW+QfgUKE2JDD/PC6+vaeJV/o/3NtCL7wvrP4mSn3TvxIS0O6FBl3odDgAfQLLthqi4VT/udmDzhKldzOpaZenGEX+WxsSwqGAFA9FYB8zu/DQBU58WkvKWLhOmZeq0gP0ykd8gyKtPPDx6OuW5w6q0dGGc9rN1TqhrEokMdoeGeez13W0Tzv4LrqObIodz8LKyP7R0+Xzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(39850400004)(346002)(396003)(376002)(136003)(186003)(44832011)(6506007)(36756003)(83380400001)(1076003)(2906002)(8936002)(86362001)(8676002)(316002)(7416002)(4326008)(2616005)(52116002)(6666004)(508600001)(6512007)(38100700002)(66556008)(54906003)(5660300002)(66946007)(66476007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CukEJ/6ueZTEM1+Sxl/t+rSleoHQubHVeefBJ85uz7VOjk8ZHBRSylJ0McKO?=
 =?us-ascii?Q?0XN4mwsuyTtG9pF/IEaBunQ5JFez6H1FTsw8DPwvqS0UcAmltSATGusiVS5E?=
 =?us-ascii?Q?n31/POnRu1npQDcM14ojMWOvApD3buwmeDN2OjQZcwC4vDZ06eKFyox2kzSI?=
 =?us-ascii?Q?xr4beI1jvdWmvcFqSbPdUVm6jpJ+bbK1TPCdR8A43Hq6/KY4Ze5pZIFakft3?=
 =?us-ascii?Q?GZAsbFDuuLTapAcIM3Q8vIrwHSgKss+CC3YSr24uAprs0L7ETn5ynV1njj8s?=
 =?us-ascii?Q?PIxrPAQY66D9U3rDYF+GPl+o1cqj2PzwQsUC55jXaOJwUgHz76qSkozhoMl2?=
 =?us-ascii?Q?YIEFQ92uI2THpNwuXJKPfy+tl+ZciKAYa3rAH2FJDZ9QoO2oAZgb8SyMaAgB?=
 =?us-ascii?Q?HB0wA/cGaqU7b8roFTTovqZjK3BRLBSGQ0Jq6Ahs4GNK2S/xzn6h/GOkLZa9?=
 =?us-ascii?Q?oaAoBC0x+dBJd8xmvdDG5tP6dsNzG9kavgnkGEmuVuM3ITeTQiO1DFlL0oDI?=
 =?us-ascii?Q?8TAdl9TA7fSd59UX9iGqjT4FCdanANkuRunTOGkFlLlr8ZTFmoZISARnjkvx?=
 =?us-ascii?Q?uFcwQ3PRbiABZIiz43LrBJdifdQ22/nqaFEGG/0o7N3ewW7H9HHsXnF9sz98?=
 =?us-ascii?Q?SgQrFXMfIQFYUcypTHLvkjugBSsD/A85ATYaouue51laGaWXHDbhJUQiA4Lp?=
 =?us-ascii?Q?6i5Un8ruU2hdXwNAsvlRcYjxtOsOuWtIl1a+TQslsLilpSskpbXfJGU4be57?=
 =?us-ascii?Q?ajCNlEdmCDoVnvJm6J0zsv+LZFIW7d/iJgVmzXULDZOujDrdWCPvDBOb5CCO?=
 =?us-ascii?Q?VtuDErTatMy+NVDSDqOCAQhWacxpUwNEe0w0ga/O15UVq1Q6j2dyLbHTjubh?=
 =?us-ascii?Q?qwUeboZk5Nv/kW85ingbeLr65IXdSbERy5T5uI81+xuCwHS/m2+rKVQCBJKs?=
 =?us-ascii?Q?vR0ZvBxPO3MPeRTG+1Ue56GE7+V/5HBL04pFzkYX8fAeKoT61tfyKGavNyXR?=
 =?us-ascii?Q?m1ueq3ztU6hTlI7JZi9dhiULdP/4LEquiJ2oXVhBnRJGGXDRo+GLN/Zxlubh?=
 =?us-ascii?Q?7XKYzdk1Rjkzbg5KOmBbCzbEivB5996m2pvETJ0dZG9HdwjPA9e+DcTCTZF9?=
 =?us-ascii?Q?rw6W7aVxz+uKL4AlC7nPtXolAbnJ1Q4w0b67/LrWbcCHxCz59DiIAj8aaO2a?=
 =?us-ascii?Q?9Czoqn3UvGY9J2mK3mu7O8CMO0nHPXasOivVDTONJnGkK6ldUhAtBeN8W8eR?=
 =?us-ascii?Q?zYMWaNqSCuK2DaB+B3UAldWIySJoC2GhLuDI++dyjaHS50tPmhawL89NEQR9?=
 =?us-ascii?Q?n5cuSL7HWwJ2ToCLDqq0RbZ3xYzbCI3H6sJCH/y44qB8x1fzaTFHVBdfMmBj?=
 =?us-ascii?Q?pVTasuCuXlCgkDgDrp+ZkOgvvKux+uzHZuJ52wcVddpbqjSNcgKzus6v4kE2?=
 =?us-ascii?Q?fQ5hXhd+tgiWYnyFJasCL2EyH/TNUhEKWZXiSscq0QcVccZhEL/Wy7QeH+DN?=
 =?us-ascii?Q?fojG6mMUFwv8k4JhP4+ns+FP90maM15PDbb90ONpyZX+WxHloK59EyqWKMq7?=
 =?us-ascii?Q?WWXLdz9jkzxano0PC4TMsY3bidf5SazipxBlqHl3NDeGnI5d/7nB/zbSg4FF?=
 =?us-ascii?Q?7cnqR6+ie9Z3kDsj7EkGfgAbeJK6yTTfd9/Dz67NSyC1G0awQUxo0jeVIsgp?=
 =?us-ascii?Q?WtBPdvZIMKP1tDk9FS9HzhEwfD+65BvMy8TzwS473Qvzxphfkiw1qb/gbTdr?=
 =?us-ascii?Q?qG9aGQaGbd9/A8xoywRD7wYK0ys/vls=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b45d79c2-dfe8-41bb-aa5d-08d9f8610477
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 13:16:22.1196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q9ZCfdjkuigHxbW/aT9M6VdP/vvCZm+Yco8MoaFm/tR/s/dzfsv/ZrVgF0vBm384OClidvnO/jOy+WUFmmkKKgdUOuCJ439ccWin84QM+b4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6591
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Rockchip RK3568 EVB1 features one USB 3.0 device-only
(USB 2.0 OTG) port and one USB 3.0 host-only port.
Activate the USB 3.0 controller nodes and phy nodes in the
device tree.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 .../boot/dts/rockchip/rk3568-evb1-v10.dts     | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
index a794a0ea5c70..622be8be9813 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
@@ -103,6 +103,18 @@ vcc5v0_usb_host: vcc5v0-usb-host {
 		vin-supply = <&vcc5v0_usb>;
 	};
 
+	vcc5v0_usb_otg: vcc5v0-usb-otg {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc5v0_usb_otg_en>;
+		regulator-name = "vcc5v0_usb_otg";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_usb>;
+	};
+
 	vcc3v3_lcd0_n: vcc3v3-lcd0-n {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_lcd0_n";
@@ -136,6 +148,14 @@ regulator-state-mem {
 	};
 };
 
+&combphy0 {
+	status = "okay";
+};
+
+&combphy1 {
+	status = "okay";
+};
+
 &cpu0 {
 	cpu-supply = <&vdd_cpu>;
 };
@@ -507,6 +527,9 @@ usb {
 		vcc5v0_usb_host_en: vcc5v0_usb_host_en {
 			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
+		vcc5v0_usb_otg_en: vcc5v0_usb_otg_en {
+			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
 	};
 };
 
@@ -568,6 +591,11 @@ &usb_host0_ohci {
 	status = "okay";
 };
 
+&usb_host0_xhci {
+	extcon = <&usb2phy0>;
+	status = "okay";
+};
+
 &usb_host1_ehci {
 	status = "okay";
 };
@@ -576,6 +604,24 @@ &usb_host1_ohci {
 	status = "okay";
 };
 
+&usb_host1_xhci {
+	status = "okay";
+};
+
+&usb2phy0 {
+	status = "okay";
+};
+
+&usb2phy0_host {
+	phy-supply = <&vcc5v0_usb_host>;
+	status = "okay";
+};
+
+&usb2phy0_otg {
+	vbus-supply = <&vcc5v0_usb_otg>;
+	status = "okay";
+};
+
 &usb2phy1 {
 	status = "okay";
 };
-- 
2.30.2

