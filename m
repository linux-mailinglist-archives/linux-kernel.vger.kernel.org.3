Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F227F50DE63
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 13:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241653AbiDYLF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 07:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241630AbiDYLFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 07:05:05 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4B2AFAD7;
        Mon, 25 Apr 2022 04:02:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3/KH1MOaP2QjhQNAnwhrXKUWg6v62hjypUV8Gqelgt0GItoypyLTnOp3M86r7ihUPsVvQZvEjBE3RMPW4UMrri8L3ZAgqPZlvcc9VAU6Gai2gKg+dPOZsUJpLfJ/l3nKT573D6oV+wzARaLz+FOAcjuCkDg8t7DP6gjcjhN02E+gdbppV4DOqRvUNs0fSzseaFtv3UP023kV27WbjemeB7rz01GLclfuLuRendqZr/zGWJTlJ65BSXuG9a3kC0HUFUD4vkH1fGDTK3nNJNUH6CXaxzdJERRUsLk94O6QzlswaGB1MEyogfPk3I0KrZuIjZFOZfCyMb3TlREop9+gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPY/V6k44ELk+zBpkdbcmnptX4qG+hepx7vz5imGeUw=;
 b=PoY4ZPZzbc879PAKv6B9gsu9zn6P+9OpBH8DJ2XsbhmE0V5wjMtV0xz/caYQPorWXbmhVDe6z4sXDNUKCuGrWKmOWRJdP/DHKAWkjg426nd4wloWU9AzHFoJ+vuzAatg+gGE674shPNuh9lsMRypWetDkro8jS0chDN5ONfN7HnxhbzUEg5BZnTAleSttabEq4hJJjuE+ISPFSiCXSfRzzjFBAEt7IoNXC4Osor7p8bZj+HwkMJRwzqJEghA0bxbjhnZxRTsyjHZREf7nzfsV0N/0GSqT1in112w5WqW8wtGGFZ4aHFu3+QinX0vWlnNf8rDemlTMgmyriWY3jjRTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPY/V6k44ELk+zBpkdbcmnptX4qG+hepx7vz5imGeUw=;
 b=G1C5oWDxrYs7N4VSmTKWKlnMiU30sO8GvfVIMhZwk+5oky7Q06MKjU6cKXyER67iRRUFZlpma0k9X9vtUCrYMUEFgROzRGJIiZlaTrIgWvVlbxiTM0adyUwHfUsD2l56M/m/2/1FIKWtAVQg2VN23b/8RtpA8vhDh++5BGKbCk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8420.eurprd04.prod.outlook.com (2603:10a6:20b:3fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Mon, 25 Apr
 2022 11:01:59 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6%8]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 11:01:59 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/3] arm64: defconfig: enable i.MX93 clk & pinctrl
Date:   Mon, 25 Apr 2022 19:03:30 +0800
Message-Id: <20220425110330.1630984-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220425110330.1630984-1-peng.fan@oss.nxp.com>
References: <20220425110330.1630984-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0051.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::20)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 526934ce-f75a-4502-0fa9-08da26ab051c
X-MS-TrafficTypeDiagnostic: AS8PR04MB8420:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB8420385499D857C6612ED207C9F89@AS8PR04MB8420.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ROt3a4him/3CS/On5fenfAnOCOXq6OGL7RbixKcSqswmUaS+UlgOdkuFK6tjYq9Q/JR3zIQp8KYsUUsPhnKY+Z+uE4U2xcRq9lPN++WNOk6QHEOWdhFRKqm75ijd4MudAoUZtfejpja1zLlGQrBVMIhZ3UlsZXEIIojfcxpqF+zCfH3aMZ0ge+LQqpQmp/X51dMZl3MHpd6XwUr9JsPBcWc9yM5HLpPZfzbqnS/1CHCG7yLq1pzwAxvoc8ir29Fh8RAeN/Y/0BiN2/25mlGsY2vxE45WMfiA4XUDXasR1rdjvYL467F5/RR0FYwJV614wM1i8OQNOO1/YzOgabmGByRpSQi5T3kvuYEonCOq2uqdTurJNlilc4Fn+nzOGKIMIfE9v5MA/3FLDpL6r6yooptpHnCyuO5rmwcnNKZTymzzwY0nxngHcJYdUFctCZ1bB26Hp4e/KjXHUmvKur5I0I4/YdMEAo1xiUQ81R7+7f+MNg/YbZJUOwvbGr+Zu27I+HAYvnisDUJnU3wjoXsTzGDRjLkdARpaApa4WtoF6mZpo/su6cULrE0XqINIRSveoz4Kw3i9eZfX9vAya+f4M69dg1b6mKff9gDGNUfRbh83nKBHnN37HJnToiG1SMe5GjO/yJ9qDW+f5OF+T7RCISlaHv3UlEgmwnwPUoR86W2MPHt7cYKJdlhhxR1lOFlxf5ExZkJy2E9nPjRIJiBTJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(5660300002)(2906002)(316002)(38100700002)(86362001)(8936002)(66476007)(4326008)(4744005)(66946007)(8676002)(66556008)(6666004)(52116002)(2616005)(6506007)(26005)(186003)(6512007)(1076003)(6486002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8gcxghxzrOt1KeFs3/ei3d0UrbLcBST6lhgLZuxJuA17Jl/yUwqOnhLbmEEk?=
 =?us-ascii?Q?PAYgRUC2atvHPRVDRkUNidbrDdrcuK5YQ+LgPHoSX/Vuh7PtjUcDmlPleN0Z?=
 =?us-ascii?Q?neP/BHSrSh8yfrqDOilSIM0dZD2LVpI37U+rofo+IRztuTa4wtH/QKCDONFe?=
 =?us-ascii?Q?w6lgWotMHwrmPc3qnpOfhRhLH218ofDsp5T94EjPTnKw0MI8ingPHwagSF0E?=
 =?us-ascii?Q?5TBu+cQFA3VQ0Rw0z4qtIL6tEV38GsDl7PmiWqEgkB9D46nq8Mr2hPL1piS2?=
 =?us-ascii?Q?FAwFWOQ0KcthwNL6LDuFDylvPKC/nxlC9nvk7HgV8OKsSjL8SY/ePLWwgrOI?=
 =?us-ascii?Q?20fQTOnbR/BFQ85mobT4AUUSsNt741DePQeF/0NG/i72PA0g1jmne9laAqh0?=
 =?us-ascii?Q?YDCKeASroGlzuTKzE3edtCsgyg5a/pNeqWC0/V594q9wPzuQSJ3cVi5GeyR/?=
 =?us-ascii?Q?/PSTklb7brRR/Z/ZR+hGnZD2OG/r9ziWqAJf8k/VHwklt2P+fcvUwPGckxob?=
 =?us-ascii?Q?nriKxnNxCwwL7QGJfd4IQTrMSHMmrUl6rPOpvSj1M/oUljSfdtWHNbXpOqej?=
 =?us-ascii?Q?5vVgQscelLBkIzJXE5U0VzM8afoIUrp33rtBceX/2p0dTRvJ89G+6ii93gK4?=
 =?us-ascii?Q?aOOd859rBt55KFw3ThRjmGQZBSBAK3F09OW2nxRh6f/Q9c1zM1VZUUqPHFHr?=
 =?us-ascii?Q?CH/tTwXU6tUT8vg/jkPwEDH4fEcEdheEKIGlXWwVnLLeRdTrjZ5Fc0toiSkM?=
 =?us-ascii?Q?v6ObDGDhKmSAywXbGqxwlZxxMGLuMRmE1hIRnaEG59WUdNtPYTdnduFa/0Ph?=
 =?us-ascii?Q?2gwNkvwN9NyACS+92UgI/gyaCnr50hAyOlJFIL/bHgZY4pXELoyN6q3xh4Qp?=
 =?us-ascii?Q?dtQRAI52ytNcDoSYc+zUlhngXhFWXZi+Rsjc4rPsOKq+Dee74wpH7v6EJLwo?=
 =?us-ascii?Q?tzyBNm20jvos/zlMcDEnBdJXM6dI/sGkT1fKP77fJHQKBjtCtUCNokrZzkGy?=
 =?us-ascii?Q?NeEjmYrSFV/GLbB8/USODPCfI+9IPyixDy58lT2XZP7o7UaPZKeYNuEmn3LO?=
 =?us-ascii?Q?Lbh0xz+P5fSN9B44qfGaf1a7+5MDMI77DfvwCg86EoCl3pIhF+fHtomcjnWV?=
 =?us-ascii?Q?6DmVmN4Ugsa0/YrVfDnbPa72chQnIKsWYsUZ2tBhHMjcQtzJK7MqXRNo28xi?=
 =?us-ascii?Q?8XtG3roZUHGxXK0Kr+kfhlxsiY0y68uFN7atn3AOmkaulf6Xi5sBWQqFrqRT?=
 =?us-ascii?Q?B3haDMwcRfgQreQpR9CX5CzA1Zxupt+HLYu1lGYzUr8CX0rCA3+aqscyX3IM?=
 =?us-ascii?Q?q8RZijQrWI/+JPoFBmLyO1fQrTbLzj82pXlVFQDa2x0pEAx9vo0Y10Wg12Sp?=
 =?us-ascii?Q?hcfc8M/OOkY7gUhLQbAYc6nMjKNvSk6sh7V3En/pMrMNLeoKSukRFz016sZ4?=
 =?us-ascii?Q?FgqCyfesVfWKusWT0ygysVVokGVnn2ABLez6PqLOWNPcB7QiixmtbwfP2pW7?=
 =?us-ascii?Q?YLJi/p3A7fIRmThD4oWzYRrHzQ5FPb+PTmq62zBnRuwcewBqR1uz6Ib+eJjY?=
 =?us-ascii?Q?GBYSHxeAhlGRWFDaKAXUmkmgrgDZLvU6SSbpNMp4UMdonss1ncP4dSl6/6EG?=
 =?us-ascii?Q?VJIfDVLXyspqZHdsGAxGAUoOtc4VjuH9C+rBFpNWczUAxpexLoics/oQKAsH?=
 =?us-ascii?Q?NZTu5C3FVSfGKX+HoO8VadM638CrWGQYVYvsrJQof9Omh/5GeYP0wPX4IuN9?=
 =?us-ascii?Q?1RZPaLBrxw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 526934ce-f75a-4502-0fa9-08da26ab051c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:01:59.6302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qigtweJXV+/r6Pb5Q5SxstejhVlUqpGu4cuMIxKHPZ9W2tuR4k5BItpcVWFOYPimAdyCxs+QfrHuclo1akW9/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8420
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Enable i.MX93 clk and pinctrl driver for booting the system

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6906b83f5e45..8205f9ffa200 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -525,6 +525,7 @@ CONFIG_PINCTRL_IMX8QM=y
 CONFIG_PINCTRL_IMX8QXP=y
 CONFIG_PINCTRL_IMX8DXL=y
 CONFIG_PINCTRL_IMX8ULP=y
+CONFIG_PINCTRL_IMX93=y
 CONFIG_PINCTRL_MSM=y
 CONFIG_PINCTRL_IPQ8074=y
 CONFIG_PINCTRL_IPQ6018=y
@@ -1017,6 +1018,7 @@ CONFIG_CLK_IMX8MP=y
 CONFIG_CLK_IMX8MQ=y
 CONFIG_CLK_IMX8QXP=y
 CONFIG_CLK_IMX8ULP=y
+CONFIG_CLK_IMX93=y
 CONFIG_TI_SCI_CLK=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_QCOM_A53PLL=y
-- 
2.25.1

