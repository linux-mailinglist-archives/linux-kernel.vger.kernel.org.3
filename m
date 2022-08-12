Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA87590CC1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 09:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237476AbiHLHoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 03:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237118AbiHLHof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 03:44:35 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70073.outbound.protection.outlook.com [40.107.7.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B500A61EC;
        Fri, 12 Aug 2022 00:44:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lci85DSFOgJw9JoXgWFMBe1lYi2djMok0TjeizESm6eRdBDDS0gx9qCj0DqIeUxrZSu0TiXNeiXt9cQbekkTUJgpQP379NGsnXn/6sIK1ULXSFk4n+pId4DjM2ReR3OAA+JNNg9Sd+ME+m60LGXlfmNXJUs9kJzESnCUVIN8FLL9/GeQl7PQ5rcWeJAe1rkeqTONUOEDhlQLr2HtJLoziAzv31eNfWDX8yjYucPM07FbcYPX61ZJlq75tTzK8WURq9Mk/rXEIezD/GKJD+bTcrg0e1GxNHmeSkueS6pKxkYOAZPcMX7dSvLq7Bbo/1cxL7PaNgRGdQziJDjFccSfaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFJkioRPlV0qxXgEz5VsXa6pyWtLZZjxjR7IihdMpyA=;
 b=NMj+C4KbC/QsmavbUb9rS80yW1IQFkIWWMIH/dTFteWxSaABmy86WQ9iOpUaeyrKFZowCBFBAmqX/c8sHLapiszaSNv0iMEXGVt8XTotwcgJs/BLdCGKwEhwkNkcDODGMi3We/79uJDesIzkf0GwfQj2eKSvVyMONcYn4g2rIF257sO75IP8Ikg1dHQaagvOsOO/AVaj6QdGpeAPAAU7WjxsCwKs+9ZyCP1YVAhZuQFaZVLyyg2T3a9GV/dg6d0Gldi9mx5c5shkYSMrvA4CvLvGVDdJ2iPrFEVKuR1i7N8JJylCHQPJ8ISKNoHYT2/eb9waBOH5jYXQMKtu88zAOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFJkioRPlV0qxXgEz5VsXa6pyWtLZZjxjR7IihdMpyA=;
 b=eVXPMfTm1Jojs1RzRlWR2vasbosB1blNqNHjaqMZIhrUQZ/Js/BF8tLZnujf7enm8XBzVsTgb+fUIStmsv5oJs1DhV7CjN+X9XoiMXeB+barnXfSD3OkOb00IsqG8QW9cClabwQBLqNZ5LY1YaV3XmhKH7acA/Mq+U6xl1Ciqks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8750.eurprd04.prod.outlook.com (2603:10a6:102:20c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 12 Aug
 2022 07:44:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 07:44:30 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/7] arm64: dts: imx93: add several nodes
Date:   Fri, 12 Aug 2022 15:46:02 +0800
Message-Id: <20220812074609.53131-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f965c1e4-56fc-4330-d978-08da7c367d5d
X-MS-TrafficTypeDiagnostic: PAXPR04MB8750:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uZrwMW9/BMX9+aI2ZfsZ8AGvl7mz5QEQiontSiD1UqwMzIWT4e/xZu+ONzL//ZyiLo6bBLUGropA4A99CuxZbSt2oucQG67jvwpVh/iZJOF/XYqzZDFaRk2EoYZ/C7Oc/VWFeoOkFUMHMVxKTkJqm1dz7XUp6ei+0wb5r4TBwhYSjvm9jvDJbpUjg/v3Yqgjh1dexLlZfAxy4RRuVf5kg43DXcBir1dedP7/V+gwLr+YqNz2EC1S/wMkJdiODxrIp4bcC8L8Xm9rj8c9u32Q2Jy0efPPSkJy+pkcJHJJVFBLwitwvebwADDIVE6z0RTsAThQ3v4ucUBmC5Z+rzxnenMLVZ6UsTnfCeVr8Jsw54AWkwyHN6h5hTsbOjEYfg5iC/lPPHiOdnsKLDhBTr5337JwQsoSgbnuJ9TNxHujNtxX3V3zCuY7PURxxusXzXAoltCOOWE/x3QGwnMWAbYBRTivaQluVfxg0EO8vpPKoQrDe+IsM7yDA28k+OpjYTwk62kWhe2IBrjyXdkG6p//+RYGhTbm5tiFpB4TXAYmebFFFr33q43m45sxOOsxyE2IGkc7y7Z9xGdTQJaeaHiQlFDDqNiIQGuOAn2r2uXppjJfJ/eVIzpSN80fVDRsXV81f8TrDA0Vr75vpk6f8M47bJDm8JL5LM5t7BVh0TpFvzaCvQTPbVQpVNYZ3/bVKVcRa5MmyZZV5iCuu4lB7/Ckxdo4E574fkbnFJMqH1R0KdXY9SXBWqUcAcz1yHjEnh/xzYcVsG5GxkuuwAbvSZCZeX7X8PmLUIhHK14cBPN3W6NujSRcY8sLYoqykdKbSMfx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(6506007)(478600001)(6666004)(86362001)(6512007)(41300700001)(26005)(83380400001)(2616005)(186003)(1076003)(6486002)(52116002)(66946007)(5660300002)(66476007)(8676002)(4326008)(66556008)(316002)(38350700002)(38100700002)(8936002)(2906002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0kqUOUwQFvF/5zTsLHYx9kRnBYmZ97S/DDMuXCQ9zm46xr1vPTl3mRnO/p/7?=
 =?us-ascii?Q?ZE+CG/C2ZYB/MHzweYfpr9jv7S/7h5oK/4/22LeFT47nU4Q/R9usEcsVW+En?=
 =?us-ascii?Q?0ZdvMPD340jW6I1X7uNPDHn5YVSxQUazxRkNoCsqGyaOhrynF7F8+RrzT2yQ?=
 =?us-ascii?Q?ALdt4siYl0NrKRsQ68PFOl+06fnI7jj3VqOTRphgGInPVcyMIUZ0f5iaQEtS?=
 =?us-ascii?Q?TiA17C8ak7jt3R2n0GSSZoGxkmdUID3hXFZZdKRIL+hzsR3jAxnX1iB5/ubH?=
 =?us-ascii?Q?D6H+o4M8QVZJum3jUWRW8v/pW0Pg3lo/pkWPk1s1dnc3FaZu2ay4Hf+EaFcE?=
 =?us-ascii?Q?a36/4ad3Bw/4wiV16pipIrso/ddp75ViPratL2KYvPCdehjlNcdzEfzGaD+m?=
 =?us-ascii?Q?fOv/UYfctfnukmowxaMyRsq9r0juWtn5AJ8ijiOCg/CMCj/QxBsZP9w/XJ0r?=
 =?us-ascii?Q?GrUXCuiYe7ZGcwJp0CstqlMNcuhFRot4PifQZeBU4luETcUQCKqQLSyEsTPU?=
 =?us-ascii?Q?A4yFd+xqFk8u1LG6avLUHPe2YeNZ3PmG8wITWmaVJyttg7qSFLxTtM6mvpOc?=
 =?us-ascii?Q?g3ucQm3bnv50ItJhQ7r4lOFqqyC2JNJSRqLF27uO5dBXyADd9+FtBaSxrZRk?=
 =?us-ascii?Q?2UFWGIKXTyJtKOCNEZ1Tk5towr2wsG87U31t4FkxWaXBSLgXZsYB0CAOZN/L?=
 =?us-ascii?Q?s+FMQqGCDqxIzGuJeEMWwWjfHjwpKEJAeYPCh0fJvifXgUNSaclP68JKuOrA?=
 =?us-ascii?Q?ZWArInZTDDDRao3DqKUtCDUP0Uu21hk8yzZw9RazIkMuazJisqPG6P4+QOFr?=
 =?us-ascii?Q?2jSWlWSn2SGckUkcpA5gQjnq0+EIXA9mWSc7xSsYqvGK7c81XAh/QtMxIZ1b?=
 =?us-ascii?Q?WdBHmyRS9xUYIdG/ycqBKgujzIx0DTyuBrbSr54d6jDg+xC22pgLHUKbQylP?=
 =?us-ascii?Q?d7QxyRgv/9/yAZOD7TB/sud4V91uepPu+IjGlwjFOmEar8Nge+dTd93ad7W0?=
 =?us-ascii?Q?cEk9aKd77ZbEj3mN1ay9Qd+xrYacn/tit4cYuOcNPadYCWMEzGD+9syCxMQg?=
 =?us-ascii?Q?2CYz+agWS9g4dQ4S6UFcMa9KDlJRE5bBoZzUtyKkRVSg5ysy6wuxfZ2dB5bk?=
 =?us-ascii?Q?/umImQoKXrU0S1e0vMt0SDyWLATrIH8edeatRkQ/jUqBe+ECoMJKwlJ4I4QD?=
 =?us-ascii?Q?SHS2Fbom+/o9vc8fu9DPHGjF0MCoqMYxMevGWdqHACPHrH288bDK0qO+UodA?=
 =?us-ascii?Q?k0pNufyor12BCjQ8xrkh4Ph9DHmE/2ZmbE0pvFO0VaufmkugXZ4Cq1dKXCiz?=
 =?us-ascii?Q?7p2QdF0QcOKIseobmZfx10OOgJ0qiB5LYUjMolvQ2y7y/EsQSOCetTDjBPH3?=
 =?us-ascii?Q?zHpLsho9jo3AD9+LZ1M4VCvluCQHGcIg/OSn7YckWLsJz1pJRKUgaWG6JCBX?=
 =?us-ascii?Q?AZSJqLlHB/IRqpj4sEtjbFc0i7iB7X+eqfsBouXqWYR+qhTIqU7LAX8cmISS?=
 =?us-ascii?Q?Dg1NtIOA2bvrb44yxpZ6MvgrNoeyKmJa7D12O1DhyvyyT1gdVTGuIl6InLni?=
 =?us-ascii?Q?SgsB4X7Szaq54Z0mzzE48XfUiRHYV5VTU1K3BI63?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f965c1e4-56fc-4330-d978-08da7c367d5d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 07:44:30.2851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /nUI2RfvkHmS093PPHS2DvUM/ho5lO3VW1kPB2YxhB4vWWqtnNKbyqeQ9M1KCm0VSiF0b0FFuWAID4+SYojdaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8750
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add S4MU, BLK CTRL, PMU, LPI2C, LPSPI nodes.
Add GPIO clk entry.
Correct SDHC clk entry

Peng Fan (7):
  arm64: dts: imx93: correct SDHC clk entry
  arm64: dts: imx93: add gpio clk
  arm64: dts: imx93: add s4 mu node
  arm64: dts: imx93: add blk ctrl node
  arm64: dts: imx93: add a55 pmu
  arm64: dts: imx93: add lpi2c nodes
  arm64: dts: imx93: add lpspi nodes

 arch/arm64/boot/dts/freescale/imx93.dtsi | 162 ++++++++++++++++++++++-
 1 file changed, 156 insertions(+), 6 deletions(-)

-- 
2.37.1

