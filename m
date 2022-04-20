Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E55507FA3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 05:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359297AbiDTDxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 23:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242857AbiDTDxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 23:53:39 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEE62612E;
        Tue, 19 Apr 2022 20:50:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9leljPHFZFqrGJ2Ec4iyMxJGW0ee9RU7PmcRYwfrwoTczfZ86xlXWPPuAHKciQvNWieLCPJR7zPEjplLwKMCSr2Gwy81nfnAAt+MxtWYVxvafhgOzfntneEzoRvJ/IACBwpsPHmMWgIMhvEFPVPWltzolFhwe1yn7anGHH8MhtAMM0oA5PGAFwt5bd0olzJ0/+csSb0SynR25P8eYKMeCb+djX1bN9Y3o+3JcM/uF44l90OYcAEjJiACmigOuh2Jt+jRpEcGKnFaN8gqukDMq8GEY0WGrFOAo5fOsGBU+mhhGzP6bjMFMEJQqBrFPPa9QzzIHpNIuyPpeQKvnWb7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnCe52Sq4XspF8/bw8Q1GZRFbuP3BqWrvcwQB9BibGs=;
 b=TqyOvKYItoDsc9+l+vhsymZUzvmqqHlh/3liwWpDhrvHIyfOqnS1flYXIzITQvtyrOsDTZArxpKdhU69Mr9NWfVWYtg2R9LciqHsmMRurZi6Yv+gJq7EUmzFbARy4MT0WmefbJm6EYvHlGDJKchtX5l9sLuon+JcZfvQpwGQ20Y9xE03c3aC9PbroTAUxfyYpNNoJcF7Gnrh0WLDYJNJ8MFomu+SSfAZ/ytFEtmlh7Tt0O7ZhbAlNMDeU049nG5NBtw/QRZYQpY3Wglo15tKK0GpKVB8Nd6gKYPDPIvznq8EyPPKhREHzkM22WmhUfB5h4qCYcNlgh30qynjfAbidg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnCe52Sq4XspF8/bw8Q1GZRFbuP3BqWrvcwQB9BibGs=;
 b=M+tyeXBO1tQhkH1ks/yX/PxFojbp7I0vV/3zIfx/KTeQFXzl2vLAnLUygFklqRj1NBZuEjRmTpG/YcCSLCaxqeIRb2U8sI1aSot9Scnuntl1L4yZix2T26QH++QrfIcV5oirPA21ciX/PnLxU/oT+xcDETObz3wDd4y7Syt1fJ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com (2603:10a6:803:11e::14)
 by AM0PR04MB5025.eurprd04.prod.outlook.com (2603:10a6:208:cd::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 03:50:52 +0000
Received: from VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01]) by VE1PR04MB6477.eurprd04.prod.outlook.com
 ([fe80::60ad:e5ec:cdfd:1b01%3]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 03:50:52 +0000
From:   Changming Huang <jerry.huang@nxp.com>
To:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Changming Huang <jerry.huang@nxp.com>
Subject: [PATCH 2/2 v3] arm64: dts: fsl-ls1028a: add dspi2 support
Date:   Wed, 20 Apr 2022 11:50:45 +0800
Message-Id: <20220420035045.33940-2-jerry.huang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220420035045.33940-1-jerry.huang@nxp.com>
References: <20220420035045.33940-1-jerry.huang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:195::11) To VE1PR04MB6477.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3ef6f80-1e5d-4dfb-974b-08da2280f6e4
X-MS-TrafficTypeDiagnostic: AM0PR04MB5025:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB5025816586250C02E170A74BFEF59@AM0PR04MB5025.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zx3FRlexklirJbU7TmtexDhjWulqykT2uHG+MHu28cKTAcp4xQ5VFzwYxmQhP90+7LGv+I5alRESEimxsPKGBCTS/TznpxA47sWau5cQWI2S3q2sJpMvcfWydbZInjpL1Kvfi+pEXVNnn0Xj2eqU+OQCqHB9rIwZKD0nBOpMp8oSh9ffjowPkGgEsdAEV3H1DALwlmielPojo5mDtztNMSoJCzXY3I7Ol9WM5fNcyYxDMGqLn9abifcoYj3T+98R64IE5kGHRirm7wFMnSY1gOs+SkaCVrzfl3+WoLU5JBgS2I02PDCmSQxQmpX6XjIzzbLy/U29BboZikPjSLs2Cl0bIJ62RWcEaunGmPyhM3xfjTbuLQQMvZCPClCs6TFjxfxcRNBd7Slcq9mAn2YBdIMKq2/pkpbO8syPF3Hk2770cREeQxm2lilj8bjSyUywseOMx4C1NnsnRBzegnRJ7f5qgvdVFLwvXgyzb1C0mJYInIGNeBbqqp4aJs/xJRyOwnGzV+tyQKUWx56ZKJNau48chvpJsW831+ArKXtKsufJDsKtzMw9ySIpRtrPrnhrLGnwH/DEIpClhz08/EBuZkFQfeDdLHaztWqNrlDhYcqeM1/4941xEKK+56MJjvJ5jLSYQA5gqTA/wzRiTKttGsVU+iHB4cuA1ZK1Iv7nNowlALl/29JQjEDOadSXL5GlViLBVSdOkA3ux4NDs1WS6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6477.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(186003)(1076003)(66556008)(66476007)(4326008)(8676002)(316002)(38350700002)(38100700002)(36756003)(66946007)(5660300002)(52116002)(26005)(6486002)(6506007)(6512007)(6666004)(86362001)(508600001)(8936002)(4744005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oRKHk3ieSO4JGCvjwrowPGW5VqMTzFHWvxgK3zJuT8X47TkbS1KML0esdCzd?=
 =?us-ascii?Q?a6kF/zHdqaA7t3WgqBeyqya7K1V0lJzA5t2ENqcd6v5cM8RlhVvr1p9bBX/q?=
 =?us-ascii?Q?gaUf+JNVCI62mPOfgCrB6tSM0rrH6ABhSNNvfkWBVYfAIMwHD4huuJmB5JI+?=
 =?us-ascii?Q?6p1DClMr918Yv63AAt4QFQprYGDgL02qDQhfSbktKi5CYIRUIo2VC7NHcpdM?=
 =?us-ascii?Q?9FJmXoF/FvNOsE1lPejcY1FNZrNOvvrpbzbTcDaJlS/ozshuacHxmQv2iJ9A?=
 =?us-ascii?Q?5f6tqxYlORWonGWEfL/viHy1kBbTtClljs/ueDKfVyv4vbQWkBOF4Odi/I8D?=
 =?us-ascii?Q?XFdZthrMvevI0gzXAL1w0kmVXRWMcL47h8K9eRzi/UW2kPSi6p2mD6yh1Yd2?=
 =?us-ascii?Q?E5kWVdoEstY7khce9YlW45NNWd37areRXKtb8L/TMiegKFgKkpuC6luBO6Oo?=
 =?us-ascii?Q?/kPmgqgGq5DKOdecbQLO9CmlRVgipO5hc24KzSvuaXm4IsfnPskbBKJLSKc9?=
 =?us-ascii?Q?+Uyig7RQVthU9VDiAWaFVJCstkyL2hWqhzmp+JNiNBBigAC7MkrDCc8lRbjX?=
 =?us-ascii?Q?fvEty5EpJKPzuOL3SJKFBDBXNyB9nFRI276mOhHR6CEc010wKuvr4DyvjznZ?=
 =?us-ascii?Q?yeQIlCy+5QcjCBnfEoHuC8b63jbBbQRWHNi8LrUQ3vLf7LYz+aApyRiQKrlH?=
 =?us-ascii?Q?oH3lnasrMD4rn/VjRDKAyei5VHuekuLRZ+JkJUilnG41J7DULFrVPbHPV+Xw?=
 =?us-ascii?Q?oknxgLyPtsm48X+VSKg3wgq8FCmYxDHa/cQcpoKbCZT0YjYZw0dIq+FS8d1A?=
 =?us-ascii?Q?HQCmusIEajQgmRduLT+a4z8rIIpy3ST8nO32dk/Vzb6t2+P0NrGwRN+1zmXb?=
 =?us-ascii?Q?R9SA08KZfFA0K2KTRU0Sh8m7/R4/4PLrJVGf4GqXSguLtmXQxImmVji+IQZB?=
 =?us-ascii?Q?efYOB3zhfeR7/eG78k9Q7pOwUdrAgGZw0IP9Wf5GQilBOdoBmA4O1WxpaGws?=
 =?us-ascii?Q?qkM7RkPKQYo6JLUSs0X8nbxiAwyU+M8plXRDhtIx8idTYu1k6UptWi5ywVg+?=
 =?us-ascii?Q?HLdIjj/6JdB/yuCvduSUWPhhQIIDTG9jeA2jSLDQ3x3XR01U6wm8NYbciZm4?=
 =?us-ascii?Q?3igc+2Dqxzs8g9RIebfP1bmGNSfabbY+e2E7fq4uXK0Z0tpq5VvjdA4zQK5/?=
 =?us-ascii?Q?l9QAsCVY1xK3RQeLhN2y7OFH63VW2Hu4Anj8GR/IUNNTuJWWyM5DuSvjnZNp?=
 =?us-ascii?Q?iqauWMwvqlfaY4DL2tk2ySGqF84F7iwm0Zud1l07Aa93mrHR8JJJDUxfb6JR?=
 =?us-ascii?Q?YGi4ri5g0gElCTdClsXcME1eQz1hVCci0qE1IGxtkhLmdeFhALA1xO494N2k?=
 =?us-ascii?Q?FZXMwqezYGR4ybFkZ/MhlYtTps+tCwXbOLCIjCiaeKnre8Fnpme3eJZF1szj?=
 =?us-ascii?Q?IwB2QQfWwYFTADm7IIgnm3zJnTolkjOoOdY3ZtI7dFIFfFVc1lHAc2PQ5mfb?=
 =?us-ascii?Q?bYW8eCvyQPiIhdobAsK3v7Doh4xLGjb/mY6aPs/Ll+HNF6FVkepDRe4hphii?=
 =?us-ascii?Q?CuNpONQcgfBYAn675sZkLhibsp5n/kpPxmCiaQMrn5E5wBx/uABjNt72DCYI?=
 =?us-ascii?Q?m/PbdI9ZoXJTDMZ4ObGLqGa8z7qi63RD9uiDRqOF36PHgaZpgZUsQrANXWoP?=
 =?us-ascii?Q?U0tKz+gt7Z26AK1qi8PvunE4waf8x4VC9NTdGV3M4S+VClLZ9ugVLsPuRIfY?=
 =?us-ascii?Q?a+qIQYFKXQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ef6f80-1e5d-4dfb-974b-08da2280f6e4
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6477.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 03:50:52.2805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMGSkXGlLs5nPiyn/KHpFv8BLLAZcovdO19ymlTYe+xz7CecB2OdPnLa42YnDAAFrlMMYN/fZ/FL/NretOTH2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5025
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable MikroBUS SPI port.

Signed-off-by: Changming Huang <jerry.huang@nxp.com>
---
changes in v3:
  - add the dt-bindings

 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index 68c31cb8eead..6d0508d5abd0 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -117,6 +117,19 @@ &duart1 {
 	status = "okay";
 };
 
+&dspi2 {
+	bus-num = <2>;
+	status = "okay";
+
+	mikrobus@0 {
+		compatible = "semtech,sx1301";
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

