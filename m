Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9384553A0E4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351205AbiFAJlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351161AbiFAJk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:40:56 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5CA4AE13;
        Wed,  1 Jun 2022 02:40:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTxg1N3dDghIlt2UGUnligrlR8zKGWzHkiUs4m5kVLrzSpuz1JKDmEcY/+1WJXbEHnfstWCj1wPPV+3hkClEtP6p6IL1kGKV5DFaXAIaa2yQ6QOmBkroHxj6X+7nHPXaP6XL2N2T8lCrTr51vsWuaBPVBgEaUg6q9ObLiz+UOGRQPLtKKZXCfYbvujDB6mYWCnRR8AG+MsR1Ov/S/gkn0KiTH1N5q3d+dOBBaEMr9hCljmzy7CiqI6ChgCpHyi9FEwFSBjhnv8nX3qHc7pyOV39v2L12KVG2zU6y9Uo4eyqK9Yo6YDJrTTlv3cLcZzdZOtRjE3mTZ7j5fxH5mdTHQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0nkxz2CoIU0OTHUHDJW3il/+0WVfwEEaFX89A85eEI=;
 b=Z86uE9tdKEA6mOKfMncSO9KzezO0rMQqraU+SB8BEy0Bhh46pDbFLw+RF74jwE65dDDXUe3mnZz8efosJmeRtTodXNE3g7NA4RevvpeT1mxHK/rmZe9fhLiP/0EE5fuaNalXFwz6PgGgCmcI1m3bRJeZ5YT5XL09Its9SvdOculM5Pwp4/d0u2PPDfNL2sst7hjk/qV1g0zoMAnrNmx4upuyHfA2o1C//6sMYnc+MmyFFvppSburSOwX2dIGH7frFBuLz/qMZvXMqnWUHj0SIJHqbQzf0jGzdkqTBRM7bUSnxxwpjt5f9z79ksQ2EL+cIb1HGvQrSmHclUkZeUz1RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0nkxz2CoIU0OTHUHDJW3il/+0WVfwEEaFX89A85eEI=;
 b=Z6wD9v1l6vJlck82/RDT9eUlSX/gHuJ+zhZVX1v3pQtJZ66DH1esrdvT78FBC28V69uQ/xB+z4wtu9TLAllPbkiHgvIGFXtqUgkm6C5ePjPSp+QogXxSSLb55/90yojDjy0kIcIkrtfZtFPHHl3f+qWpGokYQzSbcxGwVNS3qR0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0401MB2441.eurprd04.prod.outlook.com (2603:10a6:3:7e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Wed, 1 Jun
 2022 09:40:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%9]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 09:40:50 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abel.vesa@nxp.com,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 6/8] interconnect: imx: set of_node for interconnect provider
Date:   Wed,  1 Jun 2022 17:41:54 +0800
Message-Id: <20220601094156.3388454-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601094156.3388454-1-peng.fan@oss.nxp.com>
References: <20220601094156.3388454-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0078.apcprd02.prod.outlook.com
 (2603:1096:4:90::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ec427c9-1fb5-4d06-260d-08da43b2d037
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2441:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <HE1PR0401MB244164E1AC6CD7095B745ADEC9DF9@HE1PR0401MB2441.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ro93N1e9lO883rTMWKQD+7/o6bq6XpFgEyKxO31vxIUdTgh76zJEtPy3tykhp690/+1LULgJBDajMvz6e0wZfR/JoiNUwOPRzl3rSIQv8uKAySWxl5ldcpS17exZPazP9E79bSk29rYA+Q46JgOsSFkaKsB0bHRQ5zCNB7KbINMr76RL28bhZQ+FpPKEBCxAwclAAG94QzNJe1eLU0mpvRtwbJTKmKsfg39kBxxa38nsB+D7vfbNP7/YWmwGuEbhPaqmkfmE+fVpaBrgg02Q/sxBvVAQVC+1PJm4LVKnJulsVLwn29A02X68xNhrSDy6dNv9lwzjjucmcT8urowPlmJs2vkwm5KD4vIvx0DOMZ3ghA0sVF5OYd/DDIoMwKyORk8PcT0M7k/RDDYkhfQflAii7pLF8kUmG44eBOvBiTQrp2wZ+wbiWZ7quZkjyWmdJiZE7c5wya0Nnogvy4f1a9/l01PMtwvvYBMgb8v5lusLjVb96KRN8+1fDKubM4aI2u+PA+JdU/sAbXOVQ42VBNAGz1Vve7IIkOT9ZWuxJFSYqhcv+pl56BG6xVRceq6aWi/dgG42F+eOn+8oy20pd5IszHdcBapNzr596AJXV/IHY8RmSmnCs9nPqGtFGKJ487n48oSLHMuYn6tAaFf1yjkTvF9+gGG+Ear1bjptcG9S+AceQFK59dqchhxdfZABI4ChlYjJodUbaEhgZe+Wrmttq+pLjdQa6sBvcLlmdWI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(66476007)(66556008)(86362001)(38100700002)(7416002)(4744005)(38350700002)(316002)(52116002)(1076003)(8936002)(186003)(5660300002)(2616005)(4326008)(8676002)(508600001)(6506007)(6512007)(26005)(921005)(6486002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6fExSFg2ClEwJQKcpEup9Ks5mJasc5uhZJJA3yQzZSopSdvPy6ayZL4kZS7s?=
 =?us-ascii?Q?la502YeTUgenKlTV8A4mPJSYlH0OkxrKg3rGD9S9T1UMwu5SXNI0bBcljUDm?=
 =?us-ascii?Q?anJq85SBSHQrV/NvYrOlIecUPQsNt9GcE1nuhWs8T6MCulhXcKTZUg01CQvI?=
 =?us-ascii?Q?U0629qEjfhXDVWUy/b5ayX89LldomqTCyRY7khKcwXPLfZO0/CD9ld64UwmY?=
 =?us-ascii?Q?F07j+lPwxfdvgu4mlMt92Vdbap7eJ3F1rxJcvJLBvg6H/GwirxHiaUdzutRQ?=
 =?us-ascii?Q?7IZLqiwsVfY/nrcwQZxR95ItM9pYr7CJ7nD0FJ4g7ZGOcFqKZLDqCLx6BJhA?=
 =?us-ascii?Q?iqPl0JST/Q4j+YwSsZtlM9hlvXmDj2T1iePp5bNKVMhec+UMc6I0dwn4PFzA?=
 =?us-ascii?Q?eeqL0Al/6/wwLKEqs4METHlwhdVkg1CzSJfAnQTNNipL9aJdiBZAJTcR9kBc?=
 =?us-ascii?Q?eox+2b9QrOSTd2LTwdxFTDGmKeVQCAST8llBEHguJkwoQTkRRSAgQd/gpMUT?=
 =?us-ascii?Q?fWpl3t6vDprcFE63ThQ9/sUDCedRxHRPZcfeanJVYirSVDhc1KwlQoz9CRSW?=
 =?us-ascii?Q?MkpjyTHISPp3milxxM/3pI6wETdxPbS63c1kq2K+Wmnb9I8c3I60djVc57Bs?=
 =?us-ascii?Q?/No8rMQ1fNRk7lslTgOSlketTKa6P2Pnr9KeS5RBGzeXjjyWCrOtgioDc2KZ?=
 =?us-ascii?Q?ipEwj/lp2kGw/prU95FVW7R7BCNGgNZmRim0BiJq/m/iygw2kJbBloY+YVT7?=
 =?us-ascii?Q?X6GTw+jHk9vKsKFS8pZAkkKz0keb3STG+vebAYrCIFB4ENMZZ5vTVMV4mRhL?=
 =?us-ascii?Q?9cWtPWOQeGKLqMOYzq39FAFFfE5CUP3eWT4pcx6RW7zmzgPY4LfRwpdaW040?=
 =?us-ascii?Q?gNsbqtq/A8me7QGeOeWsZglL/xOwEqg/1NDBw83HIjS/DCyGdG94N1L1/JZj?=
 =?us-ascii?Q?IaWD6CO6QuRUpiDwRNsOidncEqil4Mx5uK7pehDKIDvfCUI+qCwcj7dbk5Al?=
 =?us-ascii?Q?Anj1Vuk42HzRD+W8Rqy6ujVm8mH8dT2lnfTUQDzGxc3AEr51/qwgWjq+DsFO?=
 =?us-ascii?Q?Q966qCM91MpburCuS/Mrb9fZIj2cWfKdfUi5iQrOA2bK7TqTiL5azljfDj4A?=
 =?us-ascii?Q?sGFn+9XEaI28+CIEnzHHmXFZcivrT/thd6jLir8bPA2GvlMc3Z1AI03SQdGV?=
 =?us-ascii?Q?6rIORVT4m+n/Honh/GdMxjMAjS9MrVV7C/RZVNaCNWdrXV7augByQOKWwUwW?=
 =?us-ascii?Q?xcu4MvatZn1sX0RA2/OAPV3251j5N2DcOxCEf/f6OPracehnxk1OD4lSRIHu?=
 =?us-ascii?Q?6ww4oX293/syclwoK8XfXjNw6N2fgwZEgtFBIynDGypz653I3kgNSDLjEVy2?=
 =?us-ascii?Q?K5xf/tRtfXFjLooytI7j9QmW7dnvVzALEgxVaCRZ+g5eJ+E0iROS/1pDQcT2?=
 =?us-ascii?Q?i/Tb6opFcPZ6hpig+VzEbN11OPMLXi0B6mRuWSV8zY29mdRs0ifYUEaqLrHH?=
 =?us-ascii?Q?yMUmGIwyInc/5qu00qqa5MOup7eeSZwqcgQl3vc9Ka97TGRKTUx42wtuV9yY?=
 =?us-ascii?Q?woIaP/KUXfnbIGBpoMQWHl4TWVHDbEGPEF/YqHfANlUzxK4rkxV+xBGQ1phq?=
 =?us-ascii?Q?QR7O3TbYHr/sYv+az7h3gcAhDjM4wF3fSHeiX7NolIE2cpAKzjrYnEnxaRlD?=
 =?us-ascii?Q?9FwpauB/BbuZWdky+8LfBoM/oBo5GfNCo3D9hFIbwCwUYCjCh2rBMAFfgu+B?=
 =?us-ascii?Q?KH0dgpBlNg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec427c9-1fb5-4d06-260d-08da43b2d037
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 09:40:50.6141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BgpnYc4VZmvZ6UsnDJuevC7+Srv6N23hsPV9qcUavHjgHmiYgpRc35uBooDIgB/JaM7C62wzg4a48DXZw4fpjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2441
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The provider device is created using platform_device_register_data in
imx-bus driver, which not has of_node. With of_node set, it will be
easy to support QoS settings.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/interconnect/imx/imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
index f381697fb23e..08e3a91d2543 100644
--- a/drivers/interconnect/imx/imx.c
+++ b/drivers/interconnect/imx/imx.c
@@ -264,6 +264,7 @@ int imx_icc_register(struct platform_device *pdev,
 	provider->xlate = of_icc_xlate_onecell;
 	provider->data = data;
 	provider->dev = dev->parent;
+	provider->dev->of_node = dev->parent->of_node;
 	platform_set_drvdata(pdev, imx_provider);
 
 	ret = icc_provider_add(provider);
-- 
2.25.1

