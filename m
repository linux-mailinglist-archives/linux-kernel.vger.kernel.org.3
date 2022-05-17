Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61551529AED
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236693AbiEQHfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241549AbiEQHek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:34:40 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2082.outbound.protection.outlook.com [40.107.20.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0689548E4B;
        Tue, 17 May 2022 00:33:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+kV7yP23xXGjImGqZP0WqfnbhV1TpzdfUSK5b8g9Dd7oWqbq2GI0tPmGwxyyVczRaBdtUaXZ6ycrs8JYcJud1vqlhQf7ajBa7mUdGNlkhAb9sxcS6frpGOQcaJdDIW+zFqZ/4/4q+Iso31BEl1mz2fiuPWb2Dva04SZvtuw3c3fk9zbymv9gGLNtl3cZ3GZBKNaXUVgS+ChQ8qVV2ICZWxdVQBcP/QFmVHqTn+Y1nhW+lmuP6oFFBRuMKuSlJxVigYbezgvJI/x/yxctPe2XaCkuoQvrrkzocwHkzVQdfoTnpW/J7pgh0cJRT55NQbTY9l9nPlhl+r1YF0WQNmanw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCNzBSA+4yMm2IZFGg8RQ9pMyLVDPzqwD0eE9Uo/3GU=;
 b=BlttlGVTpvVKTcWdPrQ0VAkcK1f5rIOqPTJI+TrnMoRYMDs5ZL3558b+bdf7m8XClgFd2MeDcHe3w+fMLiTEL8fX58M2vST9QAwNfTNpT+E7FlUOP0EiO1eCiC2CKq2zUWF+FvrKIdvXVLqTgm65XQz4UyozsXD3GlM1LgsuTFoa7Hvn8s8SYFZdmohgWiuKc2/t7iTHuEWyHxbVYJU8VtactxrNUfnrWDXQRx1kd10SxUn/2nTz4q3SBvi1OGbYrThHLfYALgtm5+32iDM9P6zfAxDh8IWjHmL6PIErnRFD3Fh/p9SQrBcIJ4Z96wYma4Odx7J9VvyKQ1CRzWlUBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCNzBSA+4yMm2IZFGg8RQ9pMyLVDPzqwD0eE9Uo/3GU=;
 b=WH8XOTtd/5zxJ+eajvJw6992qdI23l6v2MsVqYdqJvF6B3/+fyBO5R6b5SU7jBenB9DFeQPLmdnqx5BHzQiFezQMQxu3kjIxlECv0D776w1f9b+fJ1ATxR3DElB5WBsmN3OciEWVEGaQ3fgU2/wziM2sJNduUgr0WxKNPxa1ly4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB4375.eurprd04.prod.outlook.com (2603:10a6:20b:20::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 07:33:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5250.014; Tue, 17 May 2022
 07:33:32 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/2] mailbox: imx: support RST channel
Date:   Tue, 17 May 2022 15:35:16 +0800
Message-Id: <20220517073518.34474-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 436d4fbd-e220-4ecb-7f80-08da37d78afa
X-MS-TrafficTypeDiagnostic: AM6PR04MB4375:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB43756084B1DE29F6A146311CC9CE9@AM6PR04MB4375.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FIMTGwCtmDhFrDo4AFlxZDB2CsHGD08v0O9JumyF1rcCz90dZnjCBZLb1OB4nhJM4dX99m+B/Gxi4rGwjFt5mUH5fsUC6S0RzXWEHr6SQ9uCwEs3zx1azTEn5HZOlYim3SXPq/SdHMqeaS21JddYQSyqwGmQiv1filMI2BhL5uvvh7HvVQvvBA4wW/2AtyVMn/UaLXfBBp6I7fgfd49vrXK2BxvRaeV40J9bPz785Rwmvr0ZEdcX1//EM4M5sT0C2WOwcgI1LKH/GoQpc98i+R8BYyJgZ6UoDHpgzCOtAXT8lVSzY4fHwzLXL0JVq5bZTVmF3VSwbrgHLOcn/BijkHuvZhFwmLlIOg4k0XoJVqJi6HFzHVfNdLKdLW671gEYKu3mboklFD9FqLc6yc690VNZRoc6Ob2GsesEGeRdH1tFP7D9uhqubLQQkEgfzG2KK8wcQrO8qOS2XnJ0lhTQ0RPPP2VJB5FyR69mE/gF/VbU7/NoY+zMJPkMF7rjtsNls9AXTK7Ajk2OcUbwucLPzCNskx7OrmN1kEyvoBQy7LL9fa0PrLxYNRDIX3mwii1Kghj+rZGI95+Stz2W7Bi4iXD++9kPcZIy4MgMWEFRwtVyD1PnzTbL1pKmAmQqD2Bqlkgug/sormuX8ajQfglmbU7CkVMsd6x6FMZ9czRsImzbreT+WWPmRl3Vm2k1gQaiK8uZVAbsQ8/AyMiqG4A5QA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(8676002)(4326008)(66556008)(66476007)(2616005)(6666004)(15650500001)(316002)(38100700002)(38350700002)(86362001)(4744005)(83380400001)(8936002)(5660300002)(186003)(6506007)(26005)(6512007)(6486002)(2906002)(52116002)(508600001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oF64U2xS0XHJ+YoLACKw+qh43eee7Apn2wHmZoMylU3rh4vFfudel8b3ZQX/?=
 =?us-ascii?Q?zKSey+EcFXHvqG/Ns0KsA6sA3MO6wVM4AEV9Fb3mW3COvvEOioXxtMtfTXOs?=
 =?us-ascii?Q?RgArZnq9Vur1RX69t8zcOnRf6Yum3NyOOYk+nkB6A82j72phX+65g4moBPYl?=
 =?us-ascii?Q?DfTMeecE9VrOcwBnbzvaXCDwcih0db5pWGi0T5RKf6hvtazA5QA+ADiemUw2?=
 =?us-ascii?Q?5ZXCUvHQTfUDf4H0xQReSuum2eNfnjVOLULo3InP5+hejANnacXIyQNjEFFR?=
 =?us-ascii?Q?MzjVTgDgJ82ZXeyxwi+nhq7AD43xAMeHmK89IstcTX2Adw+EMJkmbVw8Kxsd?=
 =?us-ascii?Q?NWqNazuAl8MyCvER1jvsRXK5sIg7QkYdOR4SwHmZVlrB04FoPo3+U+lI+vD7?=
 =?us-ascii?Q?ItZcB/MibIKuAsRcbdeZALR3w72itemj6wuLZx093t61ypSja8A/Fj0V+J+l?=
 =?us-ascii?Q?ypv2Giyo6zmfXsbnUkx2qSh/K24trzJjLNA+PdWTDlLSfMgqk82RDCct52O8?=
 =?us-ascii?Q?9BOJClgXSz9lPsgyLxKSxsV0p048eAs3hVPqeow06+avKX/mzRocTJ3x3AOO?=
 =?us-ascii?Q?waDqMnIHelWMoNzV8f0i9bc5SFx2qzPC31/MHWJ4ArwCw3P31JXBx1iewkmN?=
 =?us-ascii?Q?x7dwh4Vq0iy2n55BTLJkKizjtW0lD0p87v2bc/k7xc+jn0bCrDLKK/fSmcy/?=
 =?us-ascii?Q?Q8ZKJ3QM0ppWlEXzpNNCxQipPT05YrRJW2dnUCks80IBrqHJ5eyHQ7jHelJP?=
 =?us-ascii?Q?WJ6hOORCXWfWEFs3ccTx7y8CK8v4Qns6BwuhvfMDOzlNFqi7dNE1/PKv01l6?=
 =?us-ascii?Q?eKdNb6z5T1OPuaqnYIhT10QlZmdmclEdLr7YDSyh8SjpprXV78Ln0Du0M0EP?=
 =?us-ascii?Q?D0Tfoof/wr5h8OmFGEhd3mKSSBGHThGpfV8GRRItas2WJ6JlRUeBJp7JsgPM?=
 =?us-ascii?Q?Xc0PcNM/fK6+IrePX87FDBPtYzfjWsPKYFjl5ruBJaBMFgX9Vyk4Bv+ekmXI?=
 =?us-ascii?Q?63ILV73bx0KVqjgBSXP3S0t5TG+9n9qcFuA30UQZl1kzJB4FDud9KxICniXp?=
 =?us-ascii?Q?8vFBiCMR3VW3htFIIwr6llTk0keibjn1OpaSiUhabKrQ2VSfKVbhPzSOEzCm?=
 =?us-ascii?Q?6LBZT3WsRSemuWL+fS3nzjOF2YPK7a4+ZsBBWjmN0GYTUh33ueplx3+z8Eg6?=
 =?us-ascii?Q?r3NVMt4PM+osJcOobdwTe/pbpUEnXx9IePR4iw6pZWtmewBJyH5l8Hzb4e4R?=
 =?us-ascii?Q?8DlBl2jtYYULvtrFZwTohSKSww9jWaasIo/mgApO3qZMGNPdR3hC+RpPQYpz?=
 =?us-ascii?Q?dW97n4KPNigcyPOLiqAJq5lW4GvcCcG8+mYT7N/l1xZSS4BKDj2bUlD74AQp?=
 =?us-ascii?Q?p63pBkhybDURINaaxn/KRRUHUz4SIVw7Vo8TeFlMxSpqh7C38wW3SbCQz+Fx?=
 =?us-ascii?Q?VFWtlhut0nl9/cQypbRbvglBPVq371VuuA+4yNeepyc2LEmez4PNRtkTKgBI?=
 =?us-ascii?Q?vbRbkPmLSmU89cPw/6PRv/ClClbyY7orMGBiqtEh7bEzU5kSwO6acLDRMU4v?=
 =?us-ascii?Q?OGKaoICgmx15IdF13NsM3okwMxjg35G0UNm95IfAnQGrsQbn9MS1ILMspxTP?=
 =?us-ascii?Q?wCp4AWGYUk9TVcD+ZR3sFo5/4kyPGscZLPWcwe2zu5mGHDBUnqM8ipUAGsFi?=
 =?us-ascii?Q?gSZdcyhevUvzZQQLrw+z1DhWenWq4LQN9z8QZfi/ixu4EMIVoZYpEqfTU5fg?=
 =?us-ascii?Q?jHg+91CM2w=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 436d4fbd-e220-4ecb-7f80-08da37d78afa
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 07:33:32.0358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jLUluCrd+FFXCo1s2S6XyLgvTumfMWmM0/16wj+EH5FME3pxtWKpghFW+/ag1ii4HGbu8fI9I9WeAuQjNp8BMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4375
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

To i.MX generic MU, when linux stop remote core, the MU-B side is not
reset because of hardware design, so MU-B contains valid configuration
when remote core stops. Then when linux start remote core again,
linux may notify remote core before remote core is ready for incoming
message. So we need make sure MU is in reset state before remote core
start. So add a RST channel which is only to reset MU when shutdown
the RST mbox channel.

Peng Fan (2):
  dt-bindings: mailbox: imx-mu: add RST channel
  mailbox: imx: support RST channel

 .../devicetree/bindings/mailbox/fsl,mu.yaml   |  6 ++--
 drivers/mailbox/imx-mailbox.c                 | 29 +++++++++++++++----
 2 files changed, 27 insertions(+), 8 deletions(-)

-- 
2.25.1

