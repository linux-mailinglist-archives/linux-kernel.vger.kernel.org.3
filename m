Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CAB50EEB5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 04:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242287AbiDZC1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 22:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242200AbiDZC1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 22:27:36 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20070.outbound.protection.outlook.com [40.107.2.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01EDAD131;
        Mon, 25 Apr 2022 19:24:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIFa9gygNcxYPco862Vdxviefx3Z+VgNGZXnn4IL+hQWAKt8nUqNhQCrfhXEjI7B7LoEQVtdxz2AhGEzT9NKxb6F/JXRxlBkNgg/4hv4kFfcGGxWe2FMiCtEO1erf9fZKkfSU0eI0UdLMtyoBvkKZc6vAzTTQMtZdVOlOb2yb5YPqbCulz6edT1WdjjuU8Y7bYdZXkutNuzNkGe2fs7iX2ICbefxpka3K9w7rRLxKhrmI47r0mvSr91bnhsdEgkl9VgGiVIlbGzmwHytvbvLbO/jRwvkp3hIjODNtm4VFwHMxCsO/VGPgBKj2k2ZtE3bv4Z9Fz82kJ5UaLQXTZgjvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VagV6/iOpxGz48v3Yp4Z0/oiks+1AcBG8k2fEEH+RCU=;
 b=BLsaiuwNMWRnwNxzfZhjXvTomb1NGPvEPmMFMlI6O+uLL9ZfIZxRmOX0fMnY+0zWWFBP31iadjiyWDfB5/LbrwTHner8PyCmcOyeQSs4o4epW4CvaDlFfEVoyAO+/1LA4JufvHHBnth51imhEBjFKFgWy3VDIPN3393RlwFXJgYu2ZZSfCQ+AG0Wvr8E/307egQqWs6prkubG/7aeP5V4oiyh/S1QZO6ytJOXUNuAkUdh3cqA2dWo3yzKYIZlpus650l7PtZNqrkfNW51+V0ag1OgxAFP/VSNKbd3jFdKHN/9v3YrNxD0ehU3Y6zaqCu8akdKqNlGIpu6KMTKMBvfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VagV6/iOpxGz48v3Yp4Z0/oiks+1AcBG8k2fEEH+RCU=;
 b=rgLNuuWnpyKhhPTp0a4T5q3RIz0SJOa7LZtqBItseHxv6rtZOnGtkptWZj3YXHfB7MeWoJnwBjyq8A8wfeiRXSXDP8U8Qd6k7aWwZyq9rQtsnQJFUgvUHv/dCdSV1VxMTX5lRW9woZ0oJd+WOPfWgxi0Xfrr9fk0WD6r/rAXj4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com (2603:10a6:803:11e::14)
 by VI1PR04MB6127.eurprd04.prod.outlook.com (2603:10a6:803:fa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Tue, 26 Apr
 2022 02:24:27 +0000
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01]) by VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01%3]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 02:24:27 +0000
From:   Changming Huang <jerry.huang@nxp.com>
To:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Changming Huang <jerry.huang@nxp.com>
Subject: [PATCH 2/3 v5] arm64: dts: fsl-ls1028a: add dspi2 support
Date:   Tue, 26 Apr 2022 10:24:12 +0800
Message-Id: <20220426022413.885092-2-jerry.huang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426022413.885092-1-jerry.huang@nxp.com>
References: <20220426022413.885092-1-jerry.huang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To VE1PR04MB6477.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2271eff7-c80c-46e3-b522-08da272be31c
X-MS-TrafficTypeDiagnostic: VI1PR04MB6127:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB61277A0F353BCEC45A3D3B85FEFB9@VI1PR04MB6127.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9D9HdGP4fioiXdZO7Th1T+jjI8+4yGBDJ09O44SWj5655/jVhCYQ8giC3uuYTaBh6Yk4V5cMXvS0A7+7SYlxLy+KoedwqBymg9H/uS/Z/y9p64I0KArqI3w4pNyuGubx0bcVFXN0g+i47w5UHSWFvzYvMNmh1uaeXyag7MG7c2aePPZZtFR9sSv9gSoZyoBVDjRWxKpCasILdJOsipO2NK5KM7QEAyJgIkJp4lvO3PFe1j4fZzLQ09BRSMD0+P4mM1jeQFlKISIV4rXRvGrAbzb3uBSkcrgwtQvA+JntiCYZv0PnLC/YHT1Stcea/Q5nwsGe6DiWq9w3LmhEq7+7Y+fHzx3K73DdGzkG8j0/gkDMizUNTj2eaq+t34PbcmkO/fl9sYW9C6YMshiwunhFKC/7NvI/DzViweOguSGgtM61UWvtT6TXGm+i9PYNUTcUPtKx7EKQZ9JdygGHp1Cpyvqj6Nsv9KJBYkFGfOu13ek/TLA6PTqtkRdSksN7cnwLifD49LSm6mM2/AyLV+cqt83kg5JjayOAPeXjbaE7MbPcpWZimJici4lhiXn1hgbqz0FCnCx00Bkty5k317GE7rUo6jHVIQ5BP2yuNe7pSKu3CxhGtGN8ETCGwZHAj+V5TRFpsQOCBP1gyrSptzYRdBdiiOc7QSeFY0KAzN7MaaGGJllgT8U3LkWrKoQV2/Htk7o9l5moYbO//faUOE4WVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(26005)(8936002)(316002)(86362001)(5660300002)(52116002)(6666004)(186003)(2616005)(36756003)(6506007)(1076003)(4744005)(38100700002)(2906002)(38350700002)(508600001)(6486002)(8676002)(4326008)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ps9NgiflEH+vZnq/2AeARewwtIh2fg4uMsNr5FnMD822sgiHTpYeRDVTAdMB?=
 =?us-ascii?Q?HMTb1//ifj2WkXfNGop07p/fvMIxWU6LnpMYctzbBEx55BjVtQfzxxOzpIpj?=
 =?us-ascii?Q?zNL2cn4Oubo/gloZ4uhjaK/Tawx4w7TSRQMUOjIcjqoc1tmxWQaRYlBHqW/3?=
 =?us-ascii?Q?zzwifweR6l3QoqRbv4j91568TO7GJHF4w8lFQ5Mne0qdw9/8o0wp7VYBP5X9?=
 =?us-ascii?Q?HSld5qFon83gglbVe5Pi/in/C2CjM0iziY0vvKaTtBAfs9z1e0TMwur6E0By?=
 =?us-ascii?Q?bLME8cPXe048CAZ9FseBBs7Ww+BygcpkqQn1ebyd+HSJNKribLCychEdlHCs?=
 =?us-ascii?Q?k0k8V+KLW4u2/oIAxpAJ30RGMUKDSMjMvqTmr1c4I2BByZxaHWGR+fi67pSM?=
 =?us-ascii?Q?/2k/eO3wmMvhHj6Pw/W0EvZtrxekESUk02iZj5bC1/EMe5raC+HA1n/RqvmM?=
 =?us-ascii?Q?kg2hLm28x6UKQWiJ/GBZoUEV0U6hDRoEGtqHvjwMLJVOgmIeIHsZv4ghpYRs?=
 =?us-ascii?Q?Zl7KSTy7JSdz215gbthRnpPLNGqF0jKdqpQ7RDc5aq417cj+H08WB062bE6M?=
 =?us-ascii?Q?xlp7jimweknuNEW9JJaREnQ0sPCFBrp87UBH20HbP0CzdxGpBALdYMR0kI15?=
 =?us-ascii?Q?PYvt1WHmzhZXDfnYn6hUyBLF377s66hhZtWdArNaSI8f28c1KUnOJtOHd9Uu?=
 =?us-ascii?Q?/dn9HtYFajRMZ1kbB9ciJ+nC22goMdRwHkl0bqzs6pTQUTCN0UfDg4ZRc89i?=
 =?us-ascii?Q?GnDTL0ImkbedTi5Rja3EBTGx/7wrNMZHHyUjdlJ4sk5BI2MujL46K8Kd7Fxk?=
 =?us-ascii?Q?bgHh8ybz1YP7mrtRP5h0KTBkr5fr/sleSSFJakih0jkehGHWIcLguI6KxQnP?=
 =?us-ascii?Q?KroPFggr34F/gQ2SD54WtPXBh5kmLXmQQJP5B4kqsj4jsCdNZgY3MMLT6FtF?=
 =?us-ascii?Q?zzrr/HqqahGIEC9G7WcdOO7TK4yPEhoOZT45zHnWbZRyKvb1o8kntH4ZRLST?=
 =?us-ascii?Q?RX2amA/xigbxduyhQCGVWOck2CkXcsSg5+E0BNYh+UtcT1DpdZrtP0LArSM+?=
 =?us-ascii?Q?dVryqi/c4bDq35SD0TOoftZwMQ1zLeS/ELXgZeeI1UVjLKaAC3l3YtD3wzpi?=
 =?us-ascii?Q?36ihTlTFuSA2KQ+zdEyxSnpyZOnIPgh/Hv8M9N2NSQnUe2/NSYSl7ZEQql7I?=
 =?us-ascii?Q?FnMecttdH1oMoelJOdtRVDX3h4piB71deRqhmmOyJNbdsraz7wIA/qlsJ0S/?=
 =?us-ascii?Q?xaczvjs4JuwSnsl6cc4Ul5un7tHGovK1MCr9Ls98vNc7sa+A116Nho4/euT1?=
 =?us-ascii?Q?gRPyZ3B57vv5fmoVcNmbEKQP+xDktUF/lDyjQLHPbLJ8WxscbhcuzVH+590G?=
 =?us-ascii?Q?U1h4OwC8g7v7Zp+hYd5QTmt8uIUu86Hzj9M6eYbWsYMzsfNzVlzOPC/GFPyC?=
 =?us-ascii?Q?XNs1c0ZkX8xozM58tPOQrdLym4oBKl2Nbc+0ZtbzPBAvQiT4ltB8qn55X+yN?=
 =?us-ascii?Q?su7ZcJQWjn8KqX76nkdo+x3GSnqSW16ghRQdoGfas2Zi/b4eyo9Jb6FjxFo2?=
 =?us-ascii?Q?Qy+EspQeVKFHicW+V4IEQBr804iin9ju81q1hxhoqnyjeffFMLpmTbkThZO3?=
 =?us-ascii?Q?xNI/vz/x2yQjv480XRfH52S9hvZ/aRStqDdpBaT6FZXiychX6fIUoVfO/9Vu?=
 =?us-ascii?Q?9Dntbcl49FaAjx9VKR0e82bzEsqiURub042ydhl+sVoeiscW22QJRp4RE9n9?=
 =?us-ascii?Q?RalQldRmQw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2271eff7-c80c-46e3-b522-08da272be31c
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 02:24:27.6857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uYjTjJ+J6EIA599IWnwBeXd/PDYn6kEV9EaeSjNXHluHoTbF94VfiagwxJGd32WRoYUtxLkcZb3MuTZTlVEGzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6127
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable MikroBUS SPI port.

Signed-off-by: Changming Huang <jerry.huang@nxp.com>
---
changes in v5:
  - rename compatible name to mikcroe,mikcroe-socket
changes in v3:
  - add the dt-bindings

 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index 68c31cb8eead..d2cea39d4966 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -117,6 +117,20 @@ &duart1 {
 	status = "okay";
 };
 
+&dspi2 {
+	bus-num = <2>;
+	status = "okay";
+
+	/* MikcroBus1 */
+	spi@0 {
+		compatible = "mikcroe,mikcroe-socket";
+		reg = <0>;
+		spi-max-frequency = <2000000>;
+		fsl,spi-cs-sck-delay = <1000000>;
+		fsl,spi-sck-cs-delay = <50>;
+	};
+};
+
 &enetc_mdio_pf3 {
 	sgmii_phy0: ethernet-phy@2 {
 		reg = <0x2>;
-- 
2.25.1

