Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A805154BE16
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 01:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357663AbiFNXEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 19:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiFNXEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 19:04:08 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150080.outbound.protection.outlook.com [40.107.15.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD338275EA;
        Tue, 14 Jun 2022 16:04:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzMHIDCpq3I5P0GnJpBKLomx3ZVXo9YTLnGDhX4CED5zKdrhXl37WzLGlwMmcG0h/JKz7dzegG8eWu9b3UBtuM+JUpXwlcCRa7jXXz0GisMkloEB+GZAI4H845RvHM1ks2kU4rgpD/qz5w+0cpOa9+f08dq8dc/wi1WMJQouIcY7IoXEcKK2n51wWAJkSq3K22uBzC7dojXXGQvDuuMg7pocOl2K+vowS2q3zJxt/doWiFGFDs+MzVOq90PHtl9c4dIHoRPj8M4oqD84nV2J/aSS+8rC47tVaHlb2QaT7BVhBXgeiGZI2Kx3eGcYsmh1Zhv/4X4fju4TQO/Ze2TGYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ras58qcXtbY5rjAvKbMPJilKAS8FVohnT3WAx5idtzA=;
 b=ec0y9Ai3opFNR/O/jFRDdBLlsEe2QQbUwHU8J9BtinYll7+pP0KuiKEaopSFepxpZTEUJkDx3BKZTb0+ZqCchsVaW7OX/Nzj+5yot/XRng/sFQrqGx8ZdHIlFBludU/nE/ygbbgjX9QVTRtNzN0zG0LqHXr17GwPBscf2ZsN3Eo4t0QrasX+a/e7FgDI4Zky/QDHo6vitU4Jf7LMEo5ghKvlDoXP6+UoiAf9yktm1qk+H24n8npQYEPRL8bMKO4fDnmCpSBXPW7c6aae+qNU/vgF40nr6LKbIX0pvAoRucOtWxR5nwxx+EFqwKPJu/egANS8D9s66NyA4IXTIz+Yuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ras58qcXtbY5rjAvKbMPJilKAS8FVohnT3WAx5idtzA=;
 b=lO4t/983a5a+/dfj9v5fZ3cJIa7BDQUjwEPXfUZsYi1Vkfita87BdOIVZIZ49ZGzndRpYj7eLbjxsD9dTtprPuTqIjI7MqL859C8GGsnPegI5MlVIJPaSdoRedd23UWkfHdTtBUPfP5EEMhq+iMgoG4Uv6WsEkh2plkbx8uKVhc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::22) by AS8PR08MB5926.eurprd08.prod.outlook.com
 (2603:10a6:20b:29d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Tue, 14 Jun
 2022 23:04:05 +0000
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::248c:2539:5ba5:74f2]) by AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::248c:2539:5ba5:74f2%3]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 23:04:05 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: [PATCH 1/2] arm64: dts: rockchip: enable hdmi tx audio on rk3568-evb1-v10
Date:   Wed, 15 Jun 2022 01:03:53 +0200
Message-Id: <20220614230354.3756364-1-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0099.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::14) To AM4PR0802MB2131.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e02a8a0-944d-4f34-0f1c-08da4e5a2e19
X-MS-TrafficTypeDiagnostic: AS8PR08MB5926:EE_
X-Microsoft-Antispam-PRVS: <AS8PR08MB5926DC8F26E7A01DB2473A65F2AA9@AS8PR08MB5926.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ovdTtnXTw6guzj2wTnCoVwbbe6ZRgnBirJuWZehurkc1/EdY8xehWhwvPU6IZAVzxbcNXc4RGxIBNmtAktBPWfA5qitcvETN5pUULufBAzQadDFKZkPRIH96Mo7VbFIhwiq+lAOxW4ut4H7OnT8wJEgAB+UlkywSS3LbR1GWSTlCcsXMc7tM7vAn2TjGPJq402hL4xBF2UgOXdpVlbVPs9GRYWRrHo0k4WhmaVEfUHFi5MVYoNgWeu485GzNYRQkH28D4jlDZZZYXS/umyJl6tSVUDLmtg4+0PUD5fvAS6F9cfPB/oQjLPuj4+Q3PxVlE6pApaM3gC2VhFqpTWOevJABrB6TfZtpBfuOmxJ4NdIR+Nz3yt6Uxlw5pP8H1l22NGivKHXOeVO4DCEO+RNWvvHOpO9HEgrje0ClyuuMLDeAgDlmJ0xILTeXibFIev0pKlHbeXL3s9KfbgBY0osTBNhi8CsHl2Ji9sDnNvve6G2rTULqFrpXKSSZsHPeL2jvivpW9J9mrZ7OReO2nVW8tmH1eKvyHlsWbRlviWrG5xPKQ4TmseJEBvN+sokb5wJpptZ+/yK8EgaU4agwQc18QD/RFZiMoqHjToM27vnh0+J1b8SAlaYEGqdaDOJTtqJOhte88FCpldqZKfBr0l0bpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0802MB2131.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(39850400004)(396003)(366004)(316002)(44832011)(5660300002)(508600001)(66946007)(8676002)(186003)(86362001)(66476007)(4744005)(4326008)(66556008)(107886003)(1076003)(2616005)(41300700001)(54906003)(36756003)(6506007)(52116002)(6666004)(8936002)(38100700002)(6486002)(6512007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yx/meW+BtEF4CxhchiLV2gaqaEcE1cgONoNYhAz02M7h+8N7wqeD7nYS/Ya4?=
 =?us-ascii?Q?hlvzVyONroOuPKqhovY2jO/rI721XkSDLwN9JbX9SIpX/KYdKD92KOufamNA?=
 =?us-ascii?Q?3H4A+x+a2PyDIR2aiJckXsaZExtt20vfGhNHFfl8bN/2uerCYmkL4u+mCYGt?=
 =?us-ascii?Q?YzOVIv5l93Jt9DgWtGmBMZTHBKYbOvUyTjvLiHB7gcx3D8ntV141dZKxJKaS?=
 =?us-ascii?Q?Clyk49Z0EpeFTFNLXOHFdnsY88u+ni/ez3+0doBkqmg+IVsygrtwOpnrHn2e?=
 =?us-ascii?Q?sJTjN+GO1G7GxmWbf2leWycfurTpQVU1m6BDZYmRy02I2eIeIjg2WP/PJwEo?=
 =?us-ascii?Q?+MXNVL2oH4w4Ne7ufIqyYoXSdrd+v2zV/1nYNPdIA/XWQThnTVyRH25NqUdN?=
 =?us-ascii?Q?WrSKO52RguUbpyFeinCJ1H6AvcT5dz9JlApj0eneqbbnq6V75Onh/Zsmjlu0?=
 =?us-ascii?Q?jknZoV3JXoVIuZhX+T2FZ1ggQ5gn2mY5SnIKK8gSu2EUoAUMZTmugPkGuAZJ?=
 =?us-ascii?Q?OGZC8BI3fe1o03MvbNEtV2Pz25mLASzIK45Zvu/vZZl3wp8sSwGpdyMB7Ipr?=
 =?us-ascii?Q?ql2EKeXnwAcWQtLDOWgGybtT0ftUPNvBisoyPb//djfK6QdHtTpmTW/EhfTs?=
 =?us-ascii?Q?yyfSj7Do1g1N68WqLMybqWYeRP7q/aN0tt6pUeQDWj0NUuxLgGWn6f3QgrHi?=
 =?us-ascii?Q?OCJpBGEJHGsSCNIzd/mEwsXWpE/4ruWESihQMyY40FKxj7aoI2W2Qf/+61jw?=
 =?us-ascii?Q?OHo9KKOpuEzNMSbbaYNRcNFpwh4nIXMd6hh4lQJA1b7JVEpWVGwaE4G9UtoX?=
 =?us-ascii?Q?jBFZZ8cGEoL55LnmCKLB1T0vcnPhaRxHIjxLIAVyhkPAySrrFWmrrnWyUnyy?=
 =?us-ascii?Q?NqDQCv55U4XXwRTWGtMPNxqVKS5fmlq72FCYEBthN+irvirwI/4SBaaB2dea?=
 =?us-ascii?Q?65Mqx0DKfRVY81JZcviwH+FNDLICTUlDGNmfTsylaWjox6WzQrhMmcu7DPjx?=
 =?us-ascii?Q?C+/qYJX7cDtI4Wc3zAwajpW1WzNWSN8n7oNNAoJZTfSruueifPDtW5lHKvAk?=
 =?us-ascii?Q?B8bUiMUErNpCynTmY/iHreWDNNbeIlLwkJhbpaiMOzZluM2BOvEaylWavDc3?=
 =?us-ascii?Q?a1gwwJmnW5zs38DVHCOM3HwSrHoe8qEqwBL+B/o4jvcvPvPtZXRxJe7NDcb4?=
 =?us-ascii?Q?CcKHFsgmZS031B35MsyxPxowuvLgNylZYWhc6ThzvQlRIqrvxAk56LPuLclM?=
 =?us-ascii?Q?DeQTumtweMZjKy5FglmBq+LQ8vqzwzW4QhgJyy4hpz+TwGmpDVz9gdcTF8QL?=
 =?us-ascii?Q?FgJw4FCuBx6MtUihqorRTk/l2iLMMN1JHL2dcKFVOF7nMYIcl6DK/ZihW0TU?=
 =?us-ascii?Q?XAhnubgbt77NnB3sUTd7fZG8s5VeO2Z/tgs+e2PfHl2ToH20ShaeCSreIzvf?=
 =?us-ascii?Q?xYx8WinGvBWNdTrWELYlW6vVtOyvFEOxNkSW7iV+ymepG4NCCsZkSoqbIRqh?=
 =?us-ascii?Q?Gbgvic/NAHtlj5o85Fnc4k0J+K7uqiorAoB/Ad8wr2i9HpHdHwejLEkhAYzZ?=
 =?us-ascii?Q?NW08TMkDA5ptR/KHxrtwluhZ04CNQximrnO8/CRlw0frz30Zm67DyiYJd8cH?=
 =?us-ascii?Q?1vxOaGRLuTSDyTZFe+k9dssNLUZJwLR0bAPQ9vQdDTp8svhVK09/butR3To/?=
 =?us-ascii?Q?naFmCWTjvNi2FxGsNj+hKrWgslWqOsv9EOYb6giWAWePs9oL6KanbfTxcSaX?=
 =?us-ascii?Q?Cv3Oi2hDJrbpDh7Uv4rHr+MKXhYNa1xsPKvOvenRrbq9OaODl6K42kFUNSFZ?=
X-MS-Exchange-AntiSpam-MessageData-1: wPIj0UPSWl2z7HKPgWwv8T9YX1379sIoOayaMhjPSBoCOIx3Wd/FW+CB
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e02a8a0-944d-4f34-0f1c-08da4e5a2e19
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0802MB2131.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 23:04:05.5795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Za5RPa8XmsGXyIDZF2ogPkquE7SAypn8YZrPNiH372RyfdT7JiU9mTdhHZ9OGQHAVPJxf0AIt0wfCUx82iyyRkpBH1lUScF4GKtzoTuXsLQ=
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

Enable the I2S0 controller and the hdmi-sound node on the Rockchip
RK3568 EVB1.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
index 777b1615bd08..6ff89ff95ad1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts
@@ -239,6 +239,10 @@ hdmi_out_con: endpoint {
 	};
 };
 
+&hdmi_sound {
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
@@ -496,6 +500,10 @@ touchscreen0: goodix@14 {
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

