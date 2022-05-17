Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFA25299C6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 08:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240343AbiEQGsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 02:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240284AbiEQGsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 02:48:05 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140041.outbound.protection.outlook.com [40.107.14.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293934506C;
        Mon, 16 May 2022 23:48:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4NwxJ1bE7ayqMeEHOqpQ0FpGUGOlzwPt5gS9g3eRww6+qRT5ZWjKqnXI2LsCb5FKBKLM3IDMNSJNKlwZIoJvPWWJecpBfgDBbjogdqDLAziZ9hjfVHLLd82ftKZwltlrOQIdiVy0s2/b5sUfTzVpAnX/jCnKgNX40YhhMm4fiPlxATur1qzD2GAjcKeRh3Chs4VRq6v+98LLhh35eAu4dl7aIgTlnjBbOxMRQxZjgMyJ1+7Acx9bDIh7p68uDVFxqeZQCq4nVxLyoUKyD038BfMaBMm981yRj8ITGGX6SC88LCjwoVCuqThDmWuYhR7NjHXudxN3gs0MoevV4NCtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LTRmW3FdXQ9htHY7wyw2zraFCLcc7fpw4cOPtZaCS0=;
 b=FaN68tej/rcpSqz+iUYoQl7b+FZJ3e8bncXijzWY+oG9ByGHPjPper6QGO8C+BOKBptj6Uj2yKKJUbytDsW06MLXQgbu4GD5SscCkTYowDxw16/3PZbiBpJpiwddiywW8MYYwncY1vxkFHDSiLhZS5TCz4/tvAEiJoEcINGT2V+A/BNz9K5XwXKs+nmZw8zu1IeeMY44zDDPUVSRG2yB8oriHPbMaW6TNsROqb/0plaJIsyCTctt2alufsVXTuw8PuEvMlTjCt/Ca5jT8nyjLHzWkJ+0g6YzncczY3BdVwfMvSX0xONEHeASt9SotpO9lgktYaQSeICNxGsNVlh2aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LTRmW3FdXQ9htHY7wyw2zraFCLcc7fpw4cOPtZaCS0=;
 b=g1KSZkJwFMCmpqcSxAXvjcuarf+0VWpqwiAJ8TztGRdRltiRA6l+IC7/1zVCzi9Q36Aq/P2m6farQCYt/kcioBSMfHuCtvaUbtpmYg341DLGuq6BZVJBY1T5J3gf/0xPuogHccXXnOHrUzJP4bTgb9WOF/YDbtJimtisVQpy9tA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB6PR04MB3157.eurprd04.prod.outlook.com (2603:10a6:6:f::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.18; Tue, 17 May 2022 06:48:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5250.014; Tue, 17 May 2022
 06:48:00 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 2/6] dt-bindings: remoteproc: imx_rproc: support i.MX8QM
Date:   Tue, 17 May 2022 14:49:33 +0800
Message-Id: <20220517064937.4033441-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220517064937.4033441-1-peng.fan@oss.nxp.com>
References: <20220517064937.4033441-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3b7b591-c186-4e43-1960-08da37d12edc
X-MS-TrafficTypeDiagnostic: DB6PR04MB3157:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB6PR04MB3157578D7221D7E2C60BEFA3C9CE9@DB6PR04MB3157.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ulf7B5DrqWmC4bg7QmNPRF3P2zpFX8oSa1i+iripXNii1vZ7M+8Asd+YuLhKZws1+k814K4wSapLcHQikrB1wxitPF3dlG1WtSt32rFqg24X4gKnDao47QDs1aoj9ESxCQECd11YOtUe99uFHpP9o5A2Z+kyChhit/0yOTwilWfHCPX0jK6+/Nb9UpcQpRJISlh/QBP9Shb/otXpmZobBiFj/8U4rdRZbgtFBcWSmueDIF4CdB5Ue3JWEqaILfwZ7TSLoYozkyF7KQlLgfjzWtHit0ZuH97wE4BOFFnfoW7trZiHvplZS/PaiS2qT+Iar73w3iKrV/P6tv3ahpOPSVO6Et9I+GM4/HrWsI2227vZw2ZV2FryiNuPVbETGrZqFJbygjVLu1ST5dxoZvu3f+6pZUH+pIlRxNeslXUq6Bbc1XmgHwIzfcRYQYpyX7NCl1FVpERNDhwSW+HkcwJm12hf7A3d7yHnGNcsG9gbUHt6gYf9DXpNVGMcKH4CF6JwgyHVptyzdkf2E9NZZioAcXhex3k9597w50XT4UN1ifW3dqavYOn+sA4RboA3tgkW8MuYldIn5jVLAaukRyRgCqHQ6GHgMuuHgm1an/UZW8Riiw6/kz+8m6YNT4TY6hSuXgrMgup0sTZt39f5EKwsTtv4uOR8NpCDfm4gQNlx/kZ3eg1AMu0Ep3s5wCBHOTigOIOHcs5toh89UmcV4zJnpr49dSFg6/E9ejBmDQSD8yc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(86362001)(66946007)(66476007)(6666004)(52116002)(1076003)(6486002)(2616005)(186003)(7416002)(38100700002)(66556008)(2906002)(8936002)(921005)(508600001)(38350700002)(4744005)(316002)(26005)(6512007)(6506007)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qfcB2pSXOKOCniSF1lVsCi9iup4LmWAyBklIbegKRAXRXglLX4kKPfML8ynd?=
 =?us-ascii?Q?9yqwyaNjezRUK2Yn019TYNaz4zpJcxM1eGO2EbQR0jkP0+NyjM3JVTij8j0B?=
 =?us-ascii?Q?GcrZwYNSgtiIBBFr6eWiszhPuQDT69QIdxQ0GClAvDRdZ72PR59z7L9M6J5H?=
 =?us-ascii?Q?4os8vTrFxFW7xyHQS/rYQEDMsC+u/EvcblQe5IMfv6+s41JS2Cj8Kkn4EhOX?=
 =?us-ascii?Q?f3fhZpEAoN+YkfdoimwYXr3QVX3xe0pQUv/rh6Vi4tsPq7GiHaO57pn2axU/?=
 =?us-ascii?Q?HVMu3lxZwfraqOlO1VvNrodIEMQxeewNzao6nR/qLO5++eGpowk8lZqMSaqc?=
 =?us-ascii?Q?9GtuoN0GTQrTUpJ/ubCjLv+FBBn+7Vs0uzmQs8ntAwlR0siym3JbwFb5v3Lk?=
 =?us-ascii?Q?+Ybk3+mPuUIxdCOvaK7DAbYiBj3qWXs1OYdcLSkWPV+/pgE4jxK/H/A8lH+A?=
 =?us-ascii?Q?YDEoyMJYKPZ1mNCfSYExuz8/fmHmRlQSaeQCZCmQDcLcTP0O4pT+NV8wtcRa?=
 =?us-ascii?Q?EHe4TxzQ2kGPFdGjDu9foG+ZmlVcSn9JEeVIu+nBpbTIx5kciQ3avtpiC6Vd?=
 =?us-ascii?Q?uSTC0QmORNGQnHJ8cftaA3yikIdU+TDKzVysFblD4haJl0i8pI0bGZ3nR92B?=
 =?us-ascii?Q?mcoopfuMNOF/rYXdepu9hMDj9v9rWWOzjVc1NE33rr0cjdMYcTOvrR3ec70G?=
 =?us-ascii?Q?wrKG1mD5gNn0CSOpdq2YgNzZ6qK8yEFly+THCp+qGquvdXA2VVt0r8oMPyF+?=
 =?us-ascii?Q?GEsvRmkK4baBdGyMphBut1KPzYvbCoS2xdYKzlp+6WnHav8O2YWmUpf5CVxA?=
 =?us-ascii?Q?ZBByqAukuGcAhvsDElsxcfuj1QgZq66hDoL7rvRh7kgb84vhi6rwVoHQPVVI?=
 =?us-ascii?Q?tI3HzrkUQiyUwE6dqkFe28RGgsb8Yg4A594rX/yzg8GV/Y2DdE9YExY66Fw0?=
 =?us-ascii?Q?lxb0qhdgckayy0aIsWGIbO4NrrfRgP9Fm0ce26i0aI97hiGcVotS98c3Q+T+?=
 =?us-ascii?Q?v1+a3YSJnIBgj2B3yNbb5mkxFEL17LU3t3B3FjXUgt97N9QOnmHDiorzLrCr?=
 =?us-ascii?Q?0CytAwjRVoXuebK87wXln79yPNEtHzXpEt09ErITSflQ7mdjS+d/l8SItjrU?=
 =?us-ascii?Q?XKF6gcsLKP73EvBGVryvwEWKThk6nakKIo45Ps7x3a5Ut5zn5xr4MUny/76l?=
 =?us-ascii?Q?mbieI6kJ8BjfjbTpB5xANXuhk8MEmcz1aEogOcsbSFS5Q5VZ3wg99DBf6hcC?=
 =?us-ascii?Q?+WP5+5HyJTlT8oWL169Il6Xae5sX1YwKG6F3cr6YinI3tSgCgnGowQ7SxIGs?=
 =?us-ascii?Q?GLY+k34E3127wVC3PSKROoicmlLREkT2VnMpPCFOFlKABvsSA4xhTL915ap/?=
 =?us-ascii?Q?jhEIKWcX6mRzlpqz4HVl9bk2cPhvN1yjLTWkPIEgmsxQZR1c/8Ev5bWTiqOE?=
 =?us-ascii?Q?s5U9jk3zgi034K+YNoj4dhtF0PZTW2mjClG5bI+SLsZUfRze10dHOMfsU6/M?=
 =?us-ascii?Q?o6/nEjQVgkDhLWFogkX2l7Elr7l8qQH6PEJFxjDr6N+jzXu5jSrUkQff4cRG?=
 =?us-ascii?Q?PAdHvhVv99cbDM3lvOJHYS30/UIuRsBf9R/pdOMKKlc1HWvNE3tLcK8c3h5+?=
 =?us-ascii?Q?TBL1mC8mkv9OJ2HRdmPRaYpX6O4ONDQIhiGaQyHGiew+2IThuZXktcXbp2SB?=
 =?us-ascii?Q?+UP5r4OWswonV3Nr8ou2YevXodQnD2dfH8J4uF1Y/RavUojJXq5pzip+PFPJ?=
 =?us-ascii?Q?Ao2TSwIT+Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b7b591-c186-4e43-1960-08da37d12edc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 06:48:00.3496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6JvAF13BB6NkN/jUxEZ4aNm+3lO6q8LHA0nE/bsJqoN9c5kN1ZumpWwOWWznhrvQgqWhZIKpw1Jx/nyQvW5p/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3157
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8QM compatible

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
index 70322e57b6ff..64e783234e38 100644
--- a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
@@ -23,6 +23,7 @@ properties:
       - fsl,imx8mp-cm7
       - fsl,imx8mq-cm4
       - fsl,imx8qxp-cm4
+      - fsl,imx8qm-cm4
       - fsl,imx8ulp-cm33
       - fsl,imx93-cm33
 
-- 
2.25.1

