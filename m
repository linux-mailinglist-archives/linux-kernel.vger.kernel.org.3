Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EAA5215A8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241911AbiEJMnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241909AbiEJMni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:43:38 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80040.outbound.protection.outlook.com [40.107.8.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234AF2B2762;
        Tue, 10 May 2022 05:39:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6OpEwkXMrUJxkEV6RfvunDEeUH68Bs9NpKjQX4CF2mI6rKEW0dXMIwkNPRlsxBUH6zfNbzwUrGkHDu1+BjHaH2bBLTa/sLS+PdZNfOaV9WJrvmRbCMv6/03J5ktlPaG2G9WN/s6p5WP2XMfILCVjkC8lbf7Gd49GWhMD1dwQui+R0VfGysBdLfiDPBCCOt7oZSJZQ8pdDY51xicK2XACP1eHoqHHoJQ9agJEpt5JbVnDhJ5NRIw1hJnKdBPybfBQiSYgCfF3TJN18zhv8dCPPOPjuJB/Ewa+O9MQKeReUoAjvNE0pVQx5m039BTm99m0VL06oBuiiBXCaVLkIFCvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeZHd6gAGQXBin3WoV3PxnViKEVNdTe2/MpTBxxr77w=;
 b=KkW5k/TvPAmXDe/pjchq236gwP4V+ELu10VXwwtraJ6UMfnTEQsv8Bv/rYBjRorxYwHglOHmbfqCIVHYqLIIyMiAXzD8a9izYcTo9kv/nhjXdXH2x9xRjm9lOTzK/gY1SzfzjuMi9BLso2PiFsJR3/V5L3Y470a+nUOfLKAYwsPQAROrWVzLREDzegxF/cRzcUV1p1GA3A9vIb4bqp5yAoMv4B4bU6np3GxTE5iCh0YoBIERs9FaXGfZyWj2q5+kpYFLS0g8sXrLdVxyGhm1i/aFzdveTjKFJ04nnW9MoQVdFBcSBtqBYgClxv1TY9+NJcCpyC/mGd5Wfjme0bczhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeZHd6gAGQXBin3WoV3PxnViKEVNdTe2/MpTBxxr77w=;
 b=iBjcGuYje4JZ13gPDLo66HeQF6VkdIUMYkKfWG7znfxEuI+VK36J1ly97+xgpgc5O34S/aDKVp0iDyN3kY7Ti5K+X7qvdp+kHmd3VcCKSkj0kAfCtBxaFde5qq8Pf0piebT8dcRm19Tw+PXrrMA5/XIu4/G9tMEcAWFuf4+J3hg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by AM9PR04MB8937.eurprd04.prod.outlook.com (2603:10a6:20b:408::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 12:39:25 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::c9b8:325d:8250:4fed]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::c9b8:325d:8250:4fed%4]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 12:39:25 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V6 4/4] arm64: defconfig: enable i.MX93 clk & pinctrl
Date:   Tue, 10 May 2022 20:40:50 +0800
Message-Id: <20220510124050.398891-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510124050.398891-1-peng.fan@oss.nxp.com>
References: <20220510124050.398891-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:3:18::17) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cde25bb-6cdd-4036-af65-08da32821dde
X-MS-TrafficTypeDiagnostic: AM9PR04MB8937:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM9PR04MB893723D0291172D09F72F9BDC9C99@AM9PR04MB8937.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iyqTj5RKn9ChXvB44S/85t5qn0+rEqIjxgNzymn0VECGNbCcW824hNhHPDM0Gd2glqAXihnG+EBlGUHSomm+Ttankc8n92A8qglbnmr0/xk5qz6/veXfJAJF1a8pN9E9vkF7uFJ1LdSalBcLlBYiC59AMgaa+Fd/6CFfTznpj7B4B206MLJ37KBWpVd6B8aqYSxAhdBMPzfKEMrwwxuBJAjG+0F3hPSo4qxoTiLm5GaeRNfajZYJZNnOeMv3f4/W4gEicuFSfwAdzomcKUJ3ERw7PFqRiBvh+cpk+ICc2dfd9zy+HnLTrFNPExlzERYUo4MNTySowY/GISym+a0XOCYJ/aLwAGVNqWl8jjm5XUBMf6Rm3dZZz8Am8Xge1e3x6vn60oSJEAahK46vNWWYYcu4fbUVC87CR0N2j63TxMtQnEmlt+XwQjKajGwMKR0kIBTjLLuk+z67HKA41RgI+a0pdgdfD4s2kFUJDvNAv2EW0BaahnO1q27Yahy4tue+DvLsIBq0HkpAnoC1jLSdXpACa2D5Fn6FoH7h59MQsIGhr/7Z77JDVzzx4iuKEQVbCaFrt26iV2IkkRNXfnERhjT01KQy2woT1434L1RCcmJuZxmH79jq9/3Z6MpKIYeKtdpvY70f/27GVsoEfC4x8jnJ9Yv95ZQ+k48L5xiChiNV0c3CCQrGbmipB/mVUjF9DF4iUZirlN6tI9+fC4JR3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(4744005)(2906002)(38100700002)(38350700002)(5660300002)(6506007)(1076003)(4326008)(186003)(508600001)(66556008)(66946007)(2616005)(8676002)(66476007)(316002)(54906003)(52116002)(6512007)(26005)(86362001)(6666004)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N3r4GL1vZ1Fm3Sy7QZybDpXOE7+Yvm66tCwBXrA3P9eAC4C+52AVyatHsVqk?=
 =?us-ascii?Q?3Zfp32eRtjjnBEXwhh5shxzQmQ1myZh4qsRdxvLweuhnPwtgv3koxBBPptXc?=
 =?us-ascii?Q?K/G4XeM9mQ7HI+2+flgjOS/oGtIW5rknB8qDHJMPnR9hZr0/f1weX1qxNrT9?=
 =?us-ascii?Q?Ij7j1NU10GjrI+nhNeXYqoHExdtFoVA+Y/XdhEdQvgVsRWmtYBhoxEfTKwIC?=
 =?us-ascii?Q?X3kG+lYhDCFdMKlPN8IDdlyERXH7sR8Ck2gBd4S6OfLP8vn73hCiFlbSPPws?=
 =?us-ascii?Q?seo9qNaYfRADbZw2KQb4ZLStk2XPYUfvQsWCbKrxfvrndCT5ytmZi4bTLkVE?=
 =?us-ascii?Q?O5ETANRcKRs3vX4ZL0KLJsuSfY07zGjhQl4kE406efVWPmVPtVNjIjvL3z1z?=
 =?us-ascii?Q?Lj8ANN+wcWCilJR5dtNcw65Rdvcevvlxvu9xvM3iDYiE5EsKIbkYf/eUPTcm?=
 =?us-ascii?Q?t15lZhAAGWDfmXS6g8Bpzjr13sgyGoOX/sMCSuGU/+W0CxcnpQIsNcFnvcqj?=
 =?us-ascii?Q?nzyyI73WMRDh4HoTk8/7Pi3RjbQ80xwVTEpvDpuCv56tGSfEDxEVvkT4bBol?=
 =?us-ascii?Q?WstAqwvHaWrC7/+6sTayOf7jDSFNB59ozvglDsPW+SQ8VgplQs9I1RLroWwX?=
 =?us-ascii?Q?HxhIx0FqV9z3l7W0bXO/MaWGebSl+OEYtMYPcYdN1D8b/Q5Y75XgfZ0mYOQc?=
 =?us-ascii?Q?vL9LlfCgdZR+fOGJFR6Qc2gneVVvTIe0dEk7qzqwUiedJVgvZSEat4O8nf6c?=
 =?us-ascii?Q?KbQrBlzBFI7HgzkfF4CEwimJWYFW9jaVlkyAEYqJk33/Us/PhW9/kdkdgTXO?=
 =?us-ascii?Q?+UA7/IKLsCRPFIC1Hop3ir70nwfs6latIKdEge3iD3aTNDl3nlmNQcYI6Vu7?=
 =?us-ascii?Q?IsFzDs28OBKyjgBEKii4dNuLVcfYkhI31xg/1Yn4nvVfKQIWpZkTKTNNeGCq?=
 =?us-ascii?Q?JNQtO+GN8v02uKHhRjagP5g9LOEhGLb21PhwrIUyVVHINvwKbaG6maZKI+oN?=
 =?us-ascii?Q?3GRJRCez0Yqix6nn//pLcMvK01sZlQmBcjw/4xPDRZ6j2hN65wh40xuLjW2m?=
 =?us-ascii?Q?CQVzF58BDPbxZi0bLv8gt192JRS7heOGIV0Djzmd4AoF5YM+wUy5RsUKGQ7+?=
 =?us-ascii?Q?0n0dbyNTQaegoHY55W95nYuyWMUtXnxEEVVV+DTLqvdXBnHrKZQ/J91pWGQ5?=
 =?us-ascii?Q?KAf09uMtPqqyddYZtdUwET/ikcjbSZbcQAml0UWdHysSBWEjCn29rtgarIYW?=
 =?us-ascii?Q?CAKOjHTxFPG29G6VFfic42xChVuHssO5+R5Zpyoqb4kCcSd/c2hVIPf+/Oj5?=
 =?us-ascii?Q?/z0KSshay7Lpc8zlhyrA2ZbwX693teyR5w778/S5eBNHksLh5DGSzX4LILuS?=
 =?us-ascii?Q?ahSE7liv9ytzM26IGF+cd0h+HLlA9ZemMs3sUbSdSxT3UKx0t2eWxegKwPOF?=
 =?us-ascii?Q?8CGNeofw9QlUCs9wYiQJMlUAGW4zi5xIx1jDC4k3DJZ2wtdWtokTMsfHIhfq?=
 =?us-ascii?Q?hDreg0Cb6GTKchIc/p0n4FZ/D6il+O5nr8S2e8mpRmWG6i/MrJq4Cdyfe+u/?=
 =?us-ascii?Q?g86ysy2CXfvRAXrecH7W+ROfNQEDk9U0rjhwkecHWbvVWoZjsTdXX71IPNBw?=
 =?us-ascii?Q?vF2fhYLo3fUKIq4eL92JkhwyEwQ8g/uiVrq5H6WkSMEaM3BaTCuZyEse4Jgk?=
 =?us-ascii?Q?0JeuTPquRvSRn8JCRlWs5aBZVWWdspNUf9zs+Gf1umQXpulawDJyDEwidZji?=
 =?us-ascii?Q?H9rDeAyJyw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cde25bb-6cdd-4036-af65-08da32821dde
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 12:39:25.7585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XFgj6uX+h1aBv0Q0ClpviRCIOgn0altxTV+h1Uk8TMeL6d/P/tKj6MkE6x85g/V1Ffvaj9WEe2pvDrsLcPWM7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8937
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

