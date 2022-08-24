Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EDD59F08B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 03:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbiHXBJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 21:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbiHXBJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 21:09:01 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575CA80B6E;
        Tue, 23 Aug 2022 18:09:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDKHgIHDHGqyW2YFJHpAydgd7ZuAMTJklWmRJQbtHghzEVNhX7C7aKYVQUyB0ipZNxKhs8vCaKO3UPpgzxI8QOH6gd39BkKrXLujWElOsahdDFTJHXb1t1VWJ4R52zM7VB2Kck7VX9ATNv0UQ6imz2POZs+vb27yqGfOUygbHyZ3JEU3wE1NbqWQOmCJZqTyup+SU8l6QCmyIgBQliV/1dVIayzqNRSCoKYol5bwdTc5H21WKTmR/m62eejjslLFLzqanwNMKuBSNkw723WU7ZXZukmn8Zuapgu16iTpdB+yuPR8iPSeHiaJvgmoVF9y9VDivlaygxU/5qUSJ4oXhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYRBLRGVmW0aYEp0yM/gTOlzfxHZDMvloKUpivAqNLM=;
 b=dXiaHWBMk7Mo27v0WJdcCh4Z45oDny+es/QptQBEwM/dDD0aAe0Akp2gq9cpIxPP4NT2ujo7aZtiGiUEWKYcKiIlnjcPweSn/F8Ou5l8Cs+5r+n0DoA3WvkUfVYCgF3ew0jvAlsOm6oW0smRG087l80pp44MjmW4BrSwhIgJDEOQaikka4LsMXaC+m9+IRu3jB9RT/oACMISLRVlZ6itfi5CUad1Qtxd/NzTT/cfvzghw4Z44M9xv/TrHuJisON1MOC/h+PIEbGM01ze1tBTCgQzRDBqnpGCQre6zU//AEYHqrEBrs8lbGePowBCwd11Hl89/Zot91ygTpUqus54HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYRBLRGVmW0aYEp0yM/gTOlzfxHZDMvloKUpivAqNLM=;
 b=I2gW1V8WHyHw2NWR2LDLTCH3s239C5a8YmIczKcq31G+cpOHOIladzKDyx7D6JGcyHYr5alkgItwb1C3qZg7aRdNAqFlEgXiCkwkWrdz0eZGFjthFrog6UPFXcDT9sVU/Ey0UgB4XsQHsFllwy6WOMPohs62hT7txiNYVqXgP9c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6182.eurprd04.prod.outlook.com (2603:10a6:20b:bb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 01:08:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5546.023; Wed, 24 Aug 2022
 01:08:57 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@kernel.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH V5 2/6] dt-bindings: remoteproc: imx_rproc: support i.MX8QM
Date:   Wed, 24 Aug 2022 09:10:19 +0800
Message-Id: <20220824011023.1493050-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220824011023.1493050-1-peng.fan@oss.nxp.com>
References: <20220824011023.1493050-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0192.apcprd06.prod.outlook.com (2603:1096:4:1::24)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe1b704b-dcc6-4fba-fdc1-08da856d3842
X-MS-TrafficTypeDiagnostic: AM6PR04MB6182:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WwPmKS9MUckGzCWSfSNWCazMODF3FPBKfcFvYiSLe7LfOarVD8d0e6sZQPEE2gFiT9T4X0wgDIBKitqdW0IinsKUhEL9K3ZGlC0iSoheIPeb7ghPC8dXsR2RLwesjXP+26VXaeO54CUsM/akuxSVNmjnhEmzAASnQVcZuvgzaV6iC7NZe7Re+TAfYBc7W0CgD/3b/yANDnwtuVq/Qlxmzac10FbJcLKZdpeeX/hruyDCqnr48cfn/o8bS1HfRlEDLIRK3hKm+RmriaQ/9lkXaI+SGtZryrNsgJurTKOL5Ii7W+AGJCbg0RlQUarS3QDckoKbN15BeapBEJVdS6J6LJDcnHO/wq41de8SnBrPnkwrqLSpAN7BN3VONnyUXBcqylVu6YXlfpCOwfNqsfrwOMtyVp/bYwWXML0HtUEnGPQPYjLW1JA+9Mwbov5oIukChHQ7ahKrHGp47nOuXpr5soVHWGpwhN0isWd8xXsrF3cXZfkavmE0TUCUbDe4Uka1mIXdXnn75Iqs+OXAEkkNqcrQss1thM4ijxskg3h15aWI0pcVaAh4afF9d+hetbg1ltJQqMBLq784hWsDrbvZS4qMykNo767rmf+OLrtuuiZiDRtQBpr9iygLOl7RAxBjcUYfJFvhscBxNm/rRog59lkYjFpuK0SWZWoXCsOBN4XmJrAhjvPT8ed6hMdOVeEDmjuR74nw+hYVjZzesbf01TXIriM1MoNm1+BlCUBrrBfTxxGwMEuUapfkHS0p/vIxJFfvaGAwZYNZDy9Waipl6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(38100700002)(316002)(38350700002)(41300700001)(6486002)(66476007)(8676002)(4326008)(66556008)(66946007)(6666004)(478600001)(5660300002)(4744005)(7416002)(26005)(6512007)(8936002)(86362001)(6506007)(2906002)(52116002)(1076003)(186003)(2616005)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vxFIo9mj6ckvHIKObV0ygdWIQksUspZoZa73+eClQirXrunJNV4U/E8sicIS?=
 =?us-ascii?Q?o0U65ccveGSVc62Nb0z5itMhpfkufytww9irmLgvIXeftrmYhcQCf/htwyoD?=
 =?us-ascii?Q?5mTTVCMIyDfVGit8hXGTRT2e9UX7UJgBHQzWxFnnOVo4CfYIVzrEcd8lRO+7?=
 =?us-ascii?Q?L9ICnpO3RvgwWW29eeWO2Ub0pbv1qz+/A8wIsvpDbdyXbK/P0XBSBQzJN212?=
 =?us-ascii?Q?kLdN7Mq+nMp3fFQwdJ0lGB2t3qh92LQP7WQWs8Sj0C7xN1KIlLOzP4bwWnb6?=
 =?us-ascii?Q?vUBHN0tvPLOYv4iwnCfAUODQS7bbeqzphe2DPMabm2a9D3IuPzLNewDsTlpU?=
 =?us-ascii?Q?qk/AHIVAar7gsQlZZ8Hioy4q97pOL3Os0vWH1E0KVgMPu2s5wa4XVwIX/X1W?=
 =?us-ascii?Q?ipOFTaQ1LVnDjJN6kHumjtv/gZZFE21FtnVMOhOd5odmB6Rhvl5/THtgUOex?=
 =?us-ascii?Q?UXe6qE0tLFh3MaG7arn/iJIDjNJKthJvDmTiojWsyxeU05saqmYtsz7cqlWG?=
 =?us-ascii?Q?erVl0W2JwHW+vRCyAGeYOusASm/JRiLijIw8VbUgSyPvizw3WTi61KbZS1Og?=
 =?us-ascii?Q?5dt8EkPeW5F0RbT5UgSrLIWYfyGbHS8ccEI+vkFw60v3Ap6ZWxTVydXr2wfz?=
 =?us-ascii?Q?QU1xaUf3UMcGpfQk7A7bOSHjRch4qPFDsm3me4T6XMwco0jD+KLgqlEtaE63?=
 =?us-ascii?Q?TiEc6OYwTiIYwrRD4DJ+nRAWY+fziQ7MUuhUyBy0jyk8f0/jy+7GJXMDKaNA?=
 =?us-ascii?Q?OH2G+x2jPLgk+QsZlSTvGBU3c5mAdbAaEJV+8KQzrQtHIWeEwzVioQbMCXuE?=
 =?us-ascii?Q?ulGuZQUThqnLs3UU/GAAAlJhUOdd31fusKOrJjWsIA7ASika1Rq6pjwEfWKQ?=
 =?us-ascii?Q?lZuBYMRnlgWXWCPwWffE6v9J/DpmQArtGLUj9SCb5A2O3WzPMW7tGxspY5c3?=
 =?us-ascii?Q?BKkZDE+OkevtjsWKXUAwbKtCHtsUzeohE5Q8iWEjkAvY1Q68MxJLndh8GBp+?=
 =?us-ascii?Q?voRPwVtSBbe0udNJvgjT/bl7LS7HhUA1jasfvyN/8+cMJa+diiQdsN7Xexcs?=
 =?us-ascii?Q?hB0CELOHP1cZNShILgXmxDxqRyS27ar5NHefFZ4Ka8rBfJQYQzXfLW6OHKiQ?=
 =?us-ascii?Q?4T1QqoVaUwi+pSZv7slOCVyK6iV/DqZifG90VCKKT7aU2+remxL24W7DqNbH?=
 =?us-ascii?Q?2Jap4a0RNKVYit0bFiHif02eATA3KPg1r3uOXalkN18/sr3m3rs7GBODw/ed?=
 =?us-ascii?Q?9jBVrZUNujVrPYjrwtZG66bNwbS0vuWE6NL/nvvQubCpjJmvpTWtQ7BNOgb8?=
 =?us-ascii?Q?m9C7uhM9SD+rQbfZNgWUejtrl9cDbavhnYCHMX841lqEDq8IpdV2hhVvXj5z?=
 =?us-ascii?Q?6BeVd2psTwapirSwv45GBpxAK/IgbqIbQ6SPgD/CYMzDaS5mzzEugoRkmsbj?=
 =?us-ascii?Q?v000iEQrGVQqyKMnyXDCWLePLxJ6UYTRGg1ZUS21sClaITbuucLwNHnaXg7H?=
 =?us-ascii?Q?4Ti1J7XprtWkYrrIiwdYANnffzct1M/6pVDLFJUm4ybsCz0/yLPxzXK3fwUp?=
 =?us-ascii?Q?eDm84LMBHoMp+UeDjHpgbBSfwEiwJb3R/GWgEy0p?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1b704b-dcc6-4fba-fdc1-08da856d3842
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 01:08:57.1157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: voGll9OABums7ykQVQfkm+D/LTqHyV06T4oli80w1MBZa1wWRb/Jl9KFn56IPSoIZc2Tb4991hHwHqibqzq6dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6182
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

Reviewed-by: Rob Herring <robh@kernel.org>
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
2.37.1

