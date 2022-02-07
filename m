Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9BC4AC007
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388888AbiBGNuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387563AbiBGNh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 08:37:59 -0500
X-Greylist: delayed 661 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 05:36:02 PST
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF18C03E92D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 05:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1644240960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gYKhBCFcjdqHqYpQIDFOhQmzEsP9zP0KPqmM/XMv7bk=;
        b=OKzBWoqgdZRNOaNUnij27JuasQOxioe+iNeeJNKXtr951Rxgpwj4kDLBoNEDSQ++Ow/U1o
        8A1xlegjuiNDY7waNqnUscxtxNXREjD6EyvBpm9WBQshu7PuRaR8JQZ67ufqDKgjWQ5VnR
        E3Retr83xCbscREd+yK2Fhto185vDws=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2057.outbound.protection.outlook.com [104.47.10.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-40-l5Lqx1ZcOwSK2uW8IDg00w-1; Mon, 07 Feb 2022 14:25:11 +0100
X-MC-Unique: l5Lqx1ZcOwSK2uW8IDg00w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCSvt82U6C6bJkql7v9bNMtFaOQPtnWjG7crb5bT8maU/LuJtspVsLQ4hnvZRSLPKwZV3ttvDNw30gdbXjfRHJk1g7+GlSUQIKIC5LIWm/pzuIB7h/RcByIx4eT5e3WHDBdX6DWn7/oMexHmjj8BRvFPY4sxjA9OfATsDC+WaoujoqUFQwmA7YRRsotXH+5o+PcKRle3jSelgCv/WHim+jzUY6cSjTjvkCAADJrzo5wdqfa9MRCfMujMeyLkssIkfL8s09Uslhmbs2MEKDlXVPdVCEsk6slH3AkybLGIzHn5ur8ZX9nXbibYQqsV8kUbEvYPsjPm3Ojl8cv7KQyXxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DbOz9q/IIebwBsvZjApZimPKKCr5fLccGW6lEdzFNE=;
 b=fW9/AT+Mt/GzdyAtwhPF0jQEfjL2u8h07tI6SwIbi8ta3n/2p/8rI47ZHmmmYZqrHCVbRmvUULC0Xb0vW3ETek91Bsyc2rbWr53Mll9UMtRvZx+Yc0v7iBClh+tcSgEDq57diSO/QawUDEu9kFRBJiPcTlN4nUl6raEfYQqBRrcdjfiW2beKMc+UjRXAjceo1oEB9LIV6Z/O6gecu+2dLaIQQEXyHmM1DJw0clVOz5RvWlMrdAuytPunxxtyguHpaxN/QvwXWzAwO/L7ty+tI4ppfxhIiVT+exSXWmdPh1Q086KoZNHifKrvJ1qtDlczK8TwC8GSeW1QIkL7sSjs9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by PA4PR04MB9248.eurprd04.prod.outlook.com (2603:10a6:102:2a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 13:25:10 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::e14a:7928:ecd6:f233]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::e14a:7928:ecd6:f233%4]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 13:25:10 +0000
From:   Chester Lin <clin@suse.com>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        Radu Nicolae Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Costin Carabas <costin.carabas@nxp.com>, s32@nxp.com
CC:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Ivan T . Ivanov" <iivanov@suse.de>,
        "Lee, Chun-Yi" <jlee@suse.com>, Chester Lin <clin@suse.com>
Subject: [RFC PATCH 3/3] arm64: dts: s32g2: add USDHC support
Date:   Mon,  7 Feb 2022 21:24:44 +0800
Message-ID: <20220207132444.3653-4-clin@suse.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220207132444.3653-1-clin@suse.com>
References: <20220207132444.3653-1-clin@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM6PR01CA0072.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::49) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be424502-4583-423d-76d0-08d9ea3d4409
X-MS-TrafficTypeDiagnostic: PA4PR04MB9248:EE_
X-Microsoft-Antispam-PRVS: <PA4PR04MB92488E4859EE2F1809017978AD2C9@PA4PR04MB9248.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:404;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Def9apkmNp47w2YSFyZAt+3Yykr6cvz+qO2Jwpm5rBd7uvinFah2Pu6sAZ0Ac/JCM05pTgF5TtPFaFMmXa4JTt1q9uvdmP/z6ZF2R679XzDggW/vM+zJ1lfEPDy88yCeWFCIv4OOTMTSOcQMtTCkzgp+iWPIJXQV+rBKonazvOfoPWlT0a0TZ5y8k5o4Zq0AgMndZTlRFuanQVIvhDE+7qo/H+k+zqxcuXi0/psv9BDUYLL2J1I4+kbKseEmmDa1ktASFFFuHKlyy4nEK22NlfZtaQ47tc62xj5f7l7w8ug9ydkx9+oDhlPu5ZC/u1nukl56mIK/7ViMt7J8CR0VHWYo7UQyKq60dOwQH/xlf/Qe32CiwpvEbh/lroeg4UbClIZ5IsmnmxUeIw7G2VBY1FL713UKEYlt3k+rBJICyjKrHvYAyTq0oGe55LTv7amiFzqUARHhQhhQ6CWzjETCUSR3Ry9VLOVs/j1UQV573bhTtl8tUViw1uLNB9SBpt3oVaUJmazBEcCiPt/0AisRxUSuHBddwUi48QJty5Uxtq1TDSV59Rqe+qgt83yhvs9jmsjhqQSZhwbGCD2GcRZ//+EJI7BpHJO9fbOdjFuKTIPpTDbhwTav+vUf3xUa8Zdh96kmWaPNrEbmZ2aFLMGR2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(66556008)(8936002)(66946007)(5660300002)(6512007)(66476007)(4326008)(6506007)(8676002)(83380400001)(6486002)(36756003)(2616005)(1076003)(26005)(86362001)(110136005)(2906002)(54906003)(508600001)(38100700002)(107886003)(316002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pKImq3ET/2UfPbN+cVd4aKIvS3v0BI4gY8kc/m1zQQ9c7PHSOOrGMgQutwa8?=
 =?us-ascii?Q?bTSaXnEXXNp9Rn3mVinuutLdYZlV19ppwlSpMXTym8Iy6e7DMjt4f4eS0gys?=
 =?us-ascii?Q?oUZHEfDUzqQBaPZyJftc+xlF1wUUgpoAy8sc41QxbnBSr9AEI2DqUiUrRuvh?=
 =?us-ascii?Q?NP+hPnTOrmAmm7H4hbV+mAaXJT+3qyhgzXmZbFsNInDchkVR7E+A2oNCnonK?=
 =?us-ascii?Q?5S7vtLEw7iTrPOy2O5sjsAgUCiCl1QuvqK1SyJHk8DOkmLhDHYq76Z9bqllx?=
 =?us-ascii?Q?7wexblx5GsFg0U6VLvuO71clzpN57hY8zZ61CXk3aH1Kw/e+WXFd7bNRF0AE?=
 =?us-ascii?Q?tCCHrxbpqahf6qedWDL/1VgTQp6XIcigJJ6WkSthc0oiPb2IEyHAt38yu+bR?=
 =?us-ascii?Q?C5TTFhd/kU8LyH2TWsYbwN4FZh6vpNzRNZ+Ql+mXjaHyP9OjffOKs0KvYCnf?=
 =?us-ascii?Q?rmo7wZot1H9vCUO1jLWZlkrN6at5cUrbyCSZJbZE85PbZvWzWPbkvJd1cbeu?=
 =?us-ascii?Q?y/j1kHcTrqzzTce10gLcHrKGzuhIdgjp/jhQyJs4FEdyNgAo531F+6DgU32c?=
 =?us-ascii?Q?LNewUhjNuuXNvJj8DRUOhEq1bRmDNNG39ar25cWbxK0sb4Hs16CISuuTCMfn?=
 =?us-ascii?Q?eCj0bYcq16Jblc7vd2v517Dn3Xy+ZmTeqm+OsEz/N032GLoshYYmKgzR8JXk?=
 =?us-ascii?Q?PofjvxcFn9yxN6XMXaxbZiSIcR3TT6k7Qd6RxIKF5ZiSA2qJY4t0JGBWU2jP?=
 =?us-ascii?Q?KAaQJkyx7u0tMGxJFYi5d3qpT8ajbTppLD4giSRARh+KKAtowGkDvHAxcKqR?=
 =?us-ascii?Q?3Q5k8y5uoPIiw/oRQ5EkEOfGX7ak8cb/HwjOtFT9uNsxGL38hsiWKb1Tc5Tq?=
 =?us-ascii?Q?s6Jn7UvDFZrXHryqjhG88TRGNuQlDVtDsyeahlbbvt4kRzi8SKM+FaBelwEY?=
 =?us-ascii?Q?0VwtvLI55S6k9zCGB4hEZQbeuNoRYtgiT8nxc+wPwdSQ7u/LHaTUQMxBsf+8?=
 =?us-ascii?Q?46fj8SoiKPEGJdUXIawOLeh/InT8v5MTc6hhCOBbzfLS1SC84nHpd4XoLRmH?=
 =?us-ascii?Q?sptjqFfQmULkQfB6oJEGr4JdBYtB4X4vRycE/474L/8m6bbYlIhLXT+dEf+v?=
 =?us-ascii?Q?b+Qs/eFb26Ok/MotBd8lUC9YgZG6jpPcMnwFda/rjUAfl+vwspSztvBR/ZsJ?=
 =?us-ascii?Q?ijGAn8cDcE4GsQyC3g6MLv1aOrzrEoatsWT5ABuXPGEuKxs/oMd6pRxgdeiK?=
 =?us-ascii?Q?ikWLzo8Qrl0OTbQIiWsTbCQn3BQUcepRo36+upn/A8z+TlHCk5M8eq4rkB43?=
 =?us-ascii?Q?EnuxhNMQjTnkqvNefjsCld9ee3Fhuj1tiog0F2sL78OxA7xiH0gcuLlSaZkP?=
 =?us-ascii?Q?UY9f1F92WqljJKaIc7GRkmIe1G1E063IL13coV7PTi13Oho1LjhGXWtdMeVw?=
 =?us-ascii?Q?oXL9/tBAKNSbxV2ac0RUBD491LarBOLKchA7Lj3/M7x3lHGNnQcx99QwmWDW?=
 =?us-ascii?Q?2k3tTwzOHloPX2KekSgubEVWhy0egYwN3iCKzQg61QDkpHDQHNUrj9alLCnY?=
 =?us-ascii?Q?CGrE0yoBsEATqNyRpk0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be424502-4583-423d-76d0-08d9ea3d4409
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 13:25:10.6261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P2wETHnWOclzNHDdkULDpNkPVyshHBSybNNONCc7X+erJHDhQOReiUgrk/YPV1gu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9248
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a mmc node to support USDHC on NXP S32G2 platforms.

Signed-off-by: Chester Lin <clin@suse.com>
---
 arch/arm64/boot/dts/freescale/s32g2.dtsi        | 14 ++++++++++++++
 arch/arm64/boot/dts/freescale/s32g274a-evb.dts  |  4 ++++
 arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts |  4 ++++
 3 files changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts=
/freescale/s32g2.dtsi
index 34652d36a9f1..fd073654d6f6 100644
--- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -7,6 +7,7 @@
  */
=20
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/s32g2-clock.h>
=20
 / {
 	compatible =3D "nxp,s32g2";
@@ -135,6 +136,19 @@ uart2: serial@402bc000 {
 			status =3D "disabled";
 		};
=20
+		usdhc0: mmc@402f0000 {
+			compatible =3D "nxp,s32g2-usdhc";
+			reg =3D <0x402f0000 0x1000>;
+			interrupts =3D <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			bus-width =3D <8>;
+			clocks =3D <&scmi_clks S32G2_SCMI_CLK_USDHC_MODULE>,
+				 <&scmi_clks S32G2_SCMI_CLK_USDHC_AHB>,
+				 <&scmi_clks S32G2_SCMI_CLK_USDHC_CORE>;
+			clock-names =3D "ipg", "ahb", "per";
+			no-1-8-v;
+			status =3D "disabled";
+		};
+
 		gic: interrupt-controller@50800000 {
 			compatible =3D "arm,gic-v3";
 			reg =3D <0x50800000 0x10000>,
diff --git a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts b/arch/arm64/bo=
ot/dts/freescale/s32g274a-evb.dts
index 9118d8d2ee01..89428f1883d9 100644
--- a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
+++ b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
@@ -32,3 +32,7 @@ memory@80000000 {
 &uart0 {
 	status =3D "okay";
 };
+
+&usdhc0 {
+	status =3D "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts b/arch/arm64/b=
oot/dts/freescale/s32g274a-rdb2.dts
index e05ee854cdf5..30eae51121de 100644
--- a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
+++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
@@ -38,3 +38,7 @@ &uart0 {
 &uart1 {
 	status =3D "okay";
 };
+
+&usdhc0 {
+	status =3D "okay";
+};
--=20
2.33.1

