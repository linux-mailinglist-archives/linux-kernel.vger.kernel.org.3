Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687FE521126
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239080AbiEJJmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239021AbiEJJmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:42:18 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDEC366B1;
        Tue, 10 May 2022 02:38:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+2hd07rwXkk8c/ccYwuIlXYKW2geahyNkWb9WaMDYaQgcMACitCNWW/X2VPmwOHNEmwVjBWCm39WWDtmW5PCn9Z6mlcsa71rkf4BhRJVRfec7f82zvo8nCn+x7RoerCZEpE7k4KUpfB9pwnrivXDfUFTrmj6jWa0guibbTxty4ujDAMGGPpwnURCrEc5iDrAguyZZ1zw1QQ4dF1AnA8hW4YX6bOTijT/Acu3nG51ty4w5IPxAEG4zkadGkb174+VCW1oTGZ+V/ValjGC5hlWFQk4PnMfuj6RWN7ro3YkKhnGHUs+J+jHyonxtf23Km52K4aLShUfgedrNwUPtwr6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeZHd6gAGQXBin3WoV3PxnViKEVNdTe2/MpTBxxr77w=;
 b=i9B+7Ul8KGFwQcs4eVj1NsDG10mtUYvcwgWH53vZQoS4E4DG7S/1SgzfjXHOxnFdu/8tAgFNRYtMgz4rt/b0A17nYo1oTujesiLlt8bVUGk8uNPMzvGJ0Cx4X8anbEd5ELDyEVYTs9n6bK1M449ItAK5rjSwX1SdNHCWtifF8bWfI2jKqmf0A3DDMUHiimV0aEK5CG+ElBQNhZqam1DV8OBn5AHfXoGJ0+OPmk2IhNqcUFthH5RZLcn+w6tTXsbRUlyisCu3xWz3VDpIz5P/t7cT19Zetz+r6klloOS6VDbF/r7PteawNveKZWgB1zcQEHEAZGV/ZJ/SsjVIAmSbdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeZHd6gAGQXBin3WoV3PxnViKEVNdTe2/MpTBxxr77w=;
 b=Chxx2DaaoJpbN67moAe7GQWOsrZ80mIQyoaf6E4Ed7sI7IOttx/aWJZb4sZ52qbpTbqQZiynKbYpqbHbf9lyfuEKR3QtdyAFN4rG69VwQpWwjhEfZrvmk1R9QOE3KlJsw9Mp+Bnm3Za7aGAHJDq2lcB9NeEjmD3tnZOWaGqUdEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6980.eurprd04.prod.outlook.com (2603:10a6:208:17e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 09:38:19 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420%6]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 09:38:19 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V5 4/4] arm64: defconfig: enable i.MX93 clk & pinctrl
Date:   Tue, 10 May 2022 17:39:46 +0800
Message-Id: <20220510093946.335036-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510093946.335036-1-peng.fan@oss.nxp.com>
References: <20220510093946.335036-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51d869d8-11ed-4eb2-aef3-08da3268d0dd
X-MS-TrafficTypeDiagnostic: AM0PR04MB6980:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6980FE6E6B5A840DED35C207C9C99@AM0PR04MB6980.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i1RPW41ADFk4oF5pnDXWxZ3ddJxb1eTMhQK3k9XkSPZOcf06/ZJhZiuM/0dR+cnBirqUAvHUYYMtsL8uMsZ3eLfg2sWuyj6lGZXlrDama0Piujl1yR5ryLQXtNbq6Ia0PwdNWCLBmEWR5t7QbUBJ6HugzGqEeo2sf7d1PHRTDDLETgi3gZTb+ZckCGdeUU98LhAPKaTMSMdHBaPkPlqP+kop6IMchswBqQTbuewdl13dWAgYtcae7j1e05Suj1bcDhfq129/wfxdKi//Qew5dueSqAM+ex+sHgN9lghLFBg+bIfQu18b0vxwZR9t6W0kpr7aSGZ21gn52h9wkFmu93l32cJDZsvnSfnR0c/UKT+awh2KjDuKPSZQoHQwEOPggmMtOZZFalrxpIqLKK0NKjl3/SstM1Ujmg0ToIJF8niFoVU4nHZskEtH+vXks+PIB6RDKezxUmLOibrKKWdGxNkRdGyw81yEGQIhvjmSDHONp2J1F9FK8z0NztmqWrYvtPsLHyJg1xwHuhvTj4rij8WLa/Bu0ldCefRLvZKXnkgFyzgTSoxWDp91d+UnsZoOiVYTBIC6S07YcnN9JKu7ezz//+pbaJozaWDAgH3dlQ2l6PPUr8UZ1ECZv6uXfDqqAHePV7z1FAva5ZDFGNXqs33ELsH0+INjpaU7tPqIDqvRJGTNNyl7UIWte3NQnI+8UGrfSv+HCR8oBEPFtl8KHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52116002)(6506007)(6666004)(38350700002)(38100700002)(508600001)(6486002)(2906002)(26005)(54906003)(8936002)(66946007)(1076003)(5660300002)(186003)(4744005)(8676002)(66476007)(4326008)(66556008)(86362001)(6512007)(316002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SaDdRl3YNbjH56CW0+v7Nc0Xwb/QtIGqeHcJBtdztLgmFnEs5VNTyKhoejyN?=
 =?us-ascii?Q?OjzhNMhNW477g779FkLCx6jIpIOJ8Bqg6DHjX9vxkBPLCbXkR+qHQWTxkpLQ?=
 =?us-ascii?Q?xsfJSdbH1pwsivZPz786d9OTvUHRrPCq0uWF+an8Ho0b7rj/EZmFu1Fz85XF?=
 =?us-ascii?Q?SbTzSkpHeLEeaC3WsOjrivrdSuSjcb787IMEZk5Wf8qpPcstU4hkexaxPqxt?=
 =?us-ascii?Q?sVkLDzoZDO9WLOyb1rDkQShQu5RKfm6dBJV8Q3JNZxbZ/BdJh+OS7mcmHld4?=
 =?us-ascii?Q?lQ94Txag8CMxpPHYkH4jJqFMDa3TDfc0RvuCxgwUrh9Ji3oqkbw63b0j/u5p?=
 =?us-ascii?Q?WdRScxcjJJUFakYn9sVJ4yIU9ZD813EppnVMvAebise+kI9NciMbYnlA4lik?=
 =?us-ascii?Q?jJRLUxD5muc0OIvJWBRHjdPyNRx4eezYMLnzovOcg7YOJ0BUksYk8U/1zZih?=
 =?us-ascii?Q?uclzZEsZNDTGZmanyhW2s6TWbO+ss9X3v4ar+85QDiiG9R3VVYm4jj7Z33Pm?=
 =?us-ascii?Q?yWwizhFq0rPv+xGwm/25MdZOxiaiazaqixI+chLSOf2hU5x5bBWtvkq0Devc?=
 =?us-ascii?Q?nKFMnjTNpF0yT3b5zdAXduzE9KVOTauVvF7PKETkqbp2W+yXRid039Blu/al?=
 =?us-ascii?Q?X82ClhpvTxKU+cjkV5afjEPFK6tHVHz9XTEE/TmjCinWZQD4vGU0s/dpeyUb?=
 =?us-ascii?Q?VAYCIQ/hNn0CDzJH4LUYj4KZ8XUkUc7XuAtiavDxiUvU8M5jVAVA0xWcU2vY?=
 =?us-ascii?Q?HR5C7+xaN4nvE3k6455apYUvo58SeTTW9i47/XAC8OKnJtBsgwAylBwITF/K?=
 =?us-ascii?Q?HOX4c8OqVTJ4+3sB0XXr9+sDELm5RX9WsNy1bcqZJlmsk1H7pr6Rj+A+p9Zi?=
 =?us-ascii?Q?k3UG4QubYH5HHkx2d05EqENq+rstdfVUMU+jINhkSZVmNau7G8b1odrXOu6P?=
 =?us-ascii?Q?EYdSVWrfmdtPqErmJSarRT88EYiO8L+Weg2YRxaKVwgTb2LM37NCvNERbHxT?=
 =?us-ascii?Q?VoR7Ky5/U2WduZkveyqCt60r5NpMUwj0WGvvB7thpYbPIyHHn7oQ/QF27E6j?=
 =?us-ascii?Q?BMPFFKmdwAugz8PQ28EB3sQjfydDwXe2MJHt2kLWBqo35Fgk4w3CV7mAb90t?=
 =?us-ascii?Q?rwrRZt2Z0Jwt1SmEM0loXHULPezXCzACIfyXaz6RTFj7ufZ3ceIamYBo2CBX?=
 =?us-ascii?Q?oz/WPswqGwAVBd93VwxGCEM/aDVMXzgo995jf94hysqGOEFEPu+yYjlMk24/?=
 =?us-ascii?Q?H8Je2XcHAd14DHO3BhKfUCr6zdE//aP2JacQlThiH62aLxUBml7XMvRXWdP4?=
 =?us-ascii?Q?pR7kp86k2O80MDEKWmH1DHq0amB9MabJ3RpWGM01vjVDN7IbamKte+mi55JE?=
 =?us-ascii?Q?jXsblWf0NeDWapBomMB6SfPaMCVyo+lnL3MQyPXyj0UZT9WOB8cwBKBQBroI?=
 =?us-ascii?Q?tSMbQm5e92eOPsr0iS5/lTmWBS4AVV+6chkkgYD2F8N2CaTkNabKrxBRWUfr?=
 =?us-ascii?Q?V/GuDcXtZdPQVGVGKMnMtkgs0kSsI2nFWUKUiGgjNgKCjS20zKuNQUfuMUHu?=
 =?us-ascii?Q?WzDA7S/z3kIGxC7NH+q628c3KvTs3OojF24whqL5tiy03P/TD0MKLBVXP+Q2?=
 =?us-ascii?Q?eyWirWphqPuOgarcR6tRx36mnXzD7M5+DE9LFEkaS9q1y4ZdL1RB3zn7ByUl?=
 =?us-ascii?Q?eIV4z/lOb8Esa9fs4B0JxS06B6uXcfTURcMFACMSSDsgFmENDTVgar82kEgh?=
 =?us-ascii?Q?n8IKl2yGOA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d869d8-11ed-4eb2-aef3-08da3268d0dd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 09:38:19.2116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 516AL06KyeOufx2BfHyWFxr6WIUacicO7dKHiimGz3/pgnBgFtMx3K1hsEgw/h/RIlYY1/x5jRs5mNky5ewIuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6980
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Enable i.MX93 clk and pinctrl driver for booting the system

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e0aa3a924eb7..148cebd0224a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -520,6 +520,7 @@ CONFIG_PINCTRL_IMX8QM=y
 CONFIG_PINCTRL_IMX8QXP=y
 CONFIG_PINCTRL_IMX8DXL=y
 CONFIG_PINCTRL_IMX8ULP=y
+CONFIG_PINCTRL_IMX93=y
 CONFIG_PINCTRL_MSM=y
 CONFIG_PINCTRL_IPQ8074=y
 CONFIG_PINCTRL_IPQ6018=y
@@ -1006,6 +1007,7 @@ CONFIG_CLK_IMX8MP=y
 CONFIG_CLK_IMX8MQ=y
 CONFIG_CLK_IMX8QXP=y
 CONFIG_CLK_IMX8ULP=y
+CONFIG_CLK_IMX93=y
 CONFIG_TI_SCI_CLK=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_QCOM_A53PLL=y
-- 
2.25.1

