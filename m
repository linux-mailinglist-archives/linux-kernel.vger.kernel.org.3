Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1169A50A79E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351945AbiDUSA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391029AbiDUSAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:00:08 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60084.outbound.protection.outlook.com [40.107.6.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DB84667E;
        Thu, 21 Apr 2022 10:57:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcYaZD05TYE/r4FEscaXCtPGaegrLYV7bwQxxc5OFEZ7QYUn6XFLmLCkPaPild5jVhyx/gVNLE498fF4dn/juvKmYWFbzHY0gZNdXZTFyFqBkPvNFc73ZDfGsYTWgEpKm2tI3NRMk2lFY8MSB1QICqHHtgzdeHum2ZGSc8w+WDRhUtpSzsTwngw0dbMI2pcIoiqvXQZenYYpl5TjzBl++lIIviyZrNvLbqhBrUSYHF26tdryrgnsAfXuorXDW1/tTvDwVGafCplUDIXNQn4D58SclahN6qjjiZYFmZK8hL8vNiwaoMNmY1/NpAVCnHGBe2wXnfDa/cJzMo+qHzTXrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKtWCJ+oMHKuJx7NKMBdEqjNQftJAhInPLAmL4JBs+Y=;
 b=KOJLI0a4M/YkEaZ5P4hN65Rghol6bDXGyUtHhlPZwezXZR3VmVnwF0eVz0z6hwTapo3+AJ/grvrfu1BpXtBF0rtCyPzOF54XAUPXRI32YjK9v2UkMMHuxm711p6cEG8cWsqXvp6hLiw+y0U6uHx/eO5coQypH7S5FtkZiMOrxIUaAZkWXZ82bDeyofh9wOSe0y3zFhxqx8H0uvfqjsnFe6M9ATa2aIYda/zmC+BH/UADnDdZyXIyuNQ0kl8vIP1gyfD0hpj1Mxlv/5QEA49w9i78uWmhSbYWMKsCRAk5rBjzFWVlmM8znDK8sXGo1oqirkY/s9GQG6IVEM9pAUij2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKtWCJ+oMHKuJx7NKMBdEqjNQftJAhInPLAmL4JBs+Y=;
 b=M0IVx2WthV3LN8ryKTf1JOAOhSd9Gu8nShkh11wEEwiy6rPQpy50jMF0Xse42l1zQrS75vFIm47sU8JGXr+0Ichk6foDAkavy7ZcBGOUXathXvh2pqQxDzBMppjfoXWdFcQxOnFj+Z9MrhvvUVz9sqtOYo79e3f8dH3LBR/re705fsVs95pmlcRzt19+hRG4mVJ9BRw2JDsUggww1OOcv9Xzk5ZiuZdaCBbIGxO7Bq7dMe9WfOk/XiZO93Um+Yo3bkj1V0ybOcmY83/dlGaOc0sO5sHZRszbLI2NxMhDeUIz5GAxVtPOdK5ymPSLZozDVlo8MsfoDryI4gXNscl+KQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by AS8PR03MB8101.eurprd03.prod.outlook.com (2603:10a6:20b:444::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 21 Apr
 2022 17:57:17 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::714d:2b6:a995:51bd%4]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 17:57:17 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 5/8] arm64: dts: ls1028a: Update SFP binding to include clock
Date:   Thu, 21 Apr 2022 13:56:54 -0400
Message-Id: <20220421175657.1259024-6-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20220421175657.1259024-1-sean.anderson@seco.com>
References: <20220421175657.1259024-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:208:32e::10) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc04cf7c-2a21-40ec-30d8-08da23c05f8f
X-MS-TrafficTypeDiagnostic: AS8PR03MB8101:EE_
X-Microsoft-Antispam-PRVS: <AS8PR03MB81019C19F68D88C5E7D7BF8F96F49@AS8PR03MB8101.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uAC+2fq+B2daL7lxYsMQCCGk1w3l49x1dXABmw/QDVznkTJidwNy6gxWkB/b+BWey9atmoo3yfw4lCZMxGsX1uQc50VHgFjGbha8Bjn978hfw9jko5sk3nE+vRWChQnLdVCzvQ25vPmbCNtFpRHa4FQ1ddRToNyyuXGxUKJgmaHY/47evY8iUaeVzX6Vox5qZeMlddrHkvgzLZEJW4TylK2XcYB5NO3Pc2K7Oj3gc9KKf52HCSxSr5tjehGQTBoYjJbQpELyK59MIJy+Iouzc9/Oogp2ZFlwoOmxJyp7+qrBZ7ualRG33h6PVB0VAF+85+a/fdTBzV+L5a2sQr8ZTn/dVogumf6VI6hT/NoG/7EU4JhnK9b0RDnSErLhaYZkjEEoxX9pIv6sMNEbsDSGeK+Gv3IBafGyhaYonvr8lW4kli6vq2BWDUtdpjmJ9XuSPcy14tKaTadZhg79RKiXtKV5BJIDXxORCtPUkYczcjwrnxza29eRu+znR0xx1aG2W5vAiLHzBNogETAXrIb1Gw31LV/rYAPmxl6RKsoxwla44dgeSU2qFu1Ad/o/n4Bt4cemsUP5WgmBScx8N+0nX7gG6d7vnV4OupE2FIkRHpwOGTbGljJtUycwkvrlEyDkkXZPGYHLo3Qe2VgCzPVSAfGvN/opLnXuzbUrOHDI8FA/YrcBFTxqpBgHCoYW4IDwSJJMP8SotVmzXp6UGlgYJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(52116002)(86362001)(6512007)(2616005)(4744005)(5660300002)(44832011)(6666004)(2906002)(26005)(1076003)(107886003)(8936002)(54906003)(186003)(38100700002)(38350700002)(508600001)(36756003)(6486002)(316002)(8676002)(4326008)(66476007)(66946007)(66556008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2V6zrzSPDZk4Ij75zM6yQ0xMT5GUnmN5joICFWNlZkb7zHdDpdUFkWeleypN?=
 =?us-ascii?Q?zpvEDYMEqH/UZvONE83Mzv8UWmqIM460Bjs+nEGejMTiR867JlpTr5S5Bn72?=
 =?us-ascii?Q?9hZ5yfmaT8t12M6sPNvy15hco2FxVMeL+Za29CjnjI2lZQT0TkihK1HonUSz?=
 =?us-ascii?Q?H69GVmPQmxyslf5RnLxp+YPLfgtoQVJSO18OUZ1aM76BzZEqfi8VBLOaoNv1?=
 =?us-ascii?Q?eVcS91kIkVuXMGBBXeblWYTsjAY6YOrzkvIWsiIWGNvaE1LCuLp7XyQKrqbD?=
 =?us-ascii?Q?dRiDQLEaFi8gSMaZ+CSbQCPAWPWGd68e+rUha0iQvncuVlaOlptNeyVFO/Ch?=
 =?us-ascii?Q?SO02wyMXIAAkxp7fnlLELOwX7T53T8Ixwfd6dkQhPsSNZV0dM5YywGV9pIZT?=
 =?us-ascii?Q?Y4KXs3odcxl627Ng0XvI/8KhxjHw0VVCNBlkCreRp/SofBbWPgmKR5RpK8JI?=
 =?us-ascii?Q?jBV7aa0cb3bSevePJt2qs5iTj31RKU22csJ7mHeE1vKahFoRlqvKjXatzxeF?=
 =?us-ascii?Q?6iNl0xYaAquCO6IqTav+0OzCAwXVZ7zcmFwZovICghe0PhaQDYZE8XPrFs86?=
 =?us-ascii?Q?NtfOIqPwl611BKbe0eL+Cb+PlDXrjVJGdgcJG9UK5PPLMqgGy2C/LK2UeqXU?=
 =?us-ascii?Q?XwZfDDWknD2qaTggw7zuhPCuNMutUjiSG6srFtzMZu2W5pQaYA4L6lIo0bzB?=
 =?us-ascii?Q?zpCXLzh4NVHBZj8+gx9RCi5Q6MOPvSSWXUxdpQ9IgFtVj4d8C1PsstB29MX6?=
 =?us-ascii?Q?t97Lo1DeA4HSInnSdRQg+79HFAEMHBdWAd1/YVRfB/n3gufZ1mQZtddL1X7O?=
 =?us-ascii?Q?/TfSxp3SYOGHRg5J3SVc6MBa6eBdJPsMW4uSmF4YSnCtP5nTqBzTVt3J6PW5?=
 =?us-ascii?Q?70FeUWS8F8yfe161S2x8FUAbDgnku9ufacgm/1j2IpnD0ZgfSNTP7Pe1iD5Y?=
 =?us-ascii?Q?IrfMDc8tI3LVkpc4C1gJNVOaI0u5TkuPmSeGp3pyCLw0cAgynBDj7rn22FN0?=
 =?us-ascii?Q?hTcAulvxwLstso/qdt2mHXx/AP3UmwAIGGvt/4jK0NJFoEGeNNeGjtfuZc0E?=
 =?us-ascii?Q?kyElepHDWMyHHb4imN2ezNSYlrxSaRPk15MHhj4sTrcF1Tav6MC1AP8sC9Rj?=
 =?us-ascii?Q?cFqapeHnrNcMDa9GshB9Hqze5CaKiNIZAZO9ZZxHWpogqqGAMU2TI+9umdwD?=
 =?us-ascii?Q?nTwbZR8m00dvFZJ7iUjNAYkvfTj2MiZqPqWPZlfS7gM1swyxcsPFAHSnDUMg?=
 =?us-ascii?Q?txfY7UMSeK5+VtvFsOEY8N7P2rDx4P2DPwVvqP7B9D7vParQn5kLq1RBmDUC?=
 =?us-ascii?Q?vjSJNKrNfmDriW779DonRmTCkkjGGgr5nz3yFREDqKj6t8PMsLQPgBEfMV5x?=
 =?us-ascii?Q?tHG49FtICD7E+YeWJV4qImDXOdQmxmKRUieLV3wH8fpdwW9WvXiXwOHEftpb?=
 =?us-ascii?Q?P9FO5RSNpk7x3la80PkcPFaefC9ayPQKipisblEiYVIWkUiAwY+VsiS+LkVU?=
 =?us-ascii?Q?OK1pmihE73D0m/7RM8NCXkpVLMGJVXQv95KL1BP1i9uZHibrOTP9lK0HB9QB?=
 =?us-ascii?Q?hOjdl8aLh6YQqd/npDL0a5v+6QV88ZfVVH6Takiu4DaTN5WASNqhbEQOpgsW?=
 =?us-ascii?Q?XxfHSoiFrBeX/KpW6hPL8VmZMgrNHMWVjjb/OBPujG9V4ApjLR8Ugt1xy1r4?=
 =?us-ascii?Q?HE/Iz8yrnmbklSY7boc2vg79kIxPgfk6gYOPveEIEsIR7zOFwbfMqMq1Rjbt?=
 =?us-ascii?Q?ne2cuMWqoCDwIl+xqp50Kn+ZP29Pao8=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc04cf7c-2a21-40ec-30d8-08da23c05f8f
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 17:57:17.2602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /cBBv3t1/I3AafoEx8xkV+9BOdYg/dy1g3mp7hAsA8ZttFuJrFTRYIQtggnCW6ov+Vw5gJxX1vF8L0nhOQ9FCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8101
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clocks property is now mandatory. Add it.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 088271d49139..59b289b52a28 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -224,9 +224,12 @@ rst: syscon@1e60000 {
 			little-endian;
 		};
 
-		efuse@1e80000 {
+		sfp: efuse@1e80000 {
 			compatible = "fsl,ls1028a-sfp";
 			reg = <0x0 0x1e80000 0x0 0x10000>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
+			clock-names = "sfp";
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-- 
2.35.1.1320.gc452695387.dirty

