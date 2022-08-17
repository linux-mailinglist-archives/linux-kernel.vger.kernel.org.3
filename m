Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABB3596AF2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiHQIF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiHQIFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:05:55 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60060.outbound.protection.outlook.com [40.107.6.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3853D3D5A4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:05:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7VEKbNahl2MVgJk6VTrhoVMZCXfdUJfF+gqR+Y9yBHWPVjdsnGxNydXR5FgqDR1CDPbooalvNKGkzxDzYSG08APdLCOjvU8PRQmh1mxRXfPLvXRUiKceBFJVeFVm7X7LLQV3r52WRPm3lUr+pA15zLMiE0dUnpV5Lyocp+IXNVufMwk2YJCjKEf7bUEZ7W8DCRdNb4j9JO6Uo0la3eMvY/UhnyIGDvMdZ4A2++bLjPUFetKNT9lFo5FbekSzb3QV6a9pGrA8/6r/gx9cKMxJSrXGQqUBmFdJ1gJU2QD6Azw1bnLGzSAJhKAvlT1RJYDpdc7npSDejTanlPyM0DWAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NG39sixHT/VtiPIj09X5GfsAWVD+xnGUiYFdDkV16M0=;
 b=ZoPtYcLofnH4m4q/XxEz666KMKChYhkPACowg28x52s7BDl/akCwagyVGp3VQxl1wmiJXqJzc86YT4bnW9E7ndlDF/BluasgbtDM26XZ/b/32frXGcFkWjujfbW8ltR/JkwA+IqpsRooQDFb0DriNcgSdDFA2lVsWiTB3fTuzMIKR8L3KD8NLiKxYG48XRpi4YzQttFPcxVEFNc0sushzMo42lpdXe8sNGamj4rChPYCJkJYrgZXIEAsRh1nZTZ9owpGCJdUcWHLoP1i2IMAQP3zA5oa+pUbe0p5HZ2+ouctUPq8FGeABRejzeDJc0YFAKeBAKenfK+AMl2EbhuTug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NG39sixHT/VtiPIj09X5GfsAWVD+xnGUiYFdDkV16M0=;
 b=YlDtK6MB5GVFWI8v8t4oRrsFMLsqNcGbT4DWkWcIy102xC2DfisxcNENGj5vWiD2Twxvqwk9spgXSdP+D1fDxPS2UGC4kazqouKWaqYbc/WpDr7ACRGZ9zSgYWdJIJPahTYmveC1EDHYxMDC/YRVg45SJtD0t75WxxTAZBlt+3A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by AM9PR04MB7617.eurprd04.prod.outlook.com (2603:10a6:20b:286::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 17 Aug
 2022 08:05:51 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::68e3:e10a:8232:10e5]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::68e3:e10a:8232:10e5%5]) with mapi id 15.20.5525.019; Wed, 17 Aug 2022
 08:05:51 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, lgirdwood@gmail.com,
        pierre-louis.bossart@linux.intel.com, daniel.baluta@gmail.com,
        laurentiu.mihalcea@nxp.com, Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 0/4] Enable timestamp support for SOF compress driver
Date:   Wed, 17 Aug 2022 11:05:25 +0300
Message-Id: <20220817080529.10864-1-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::18) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a45bf736-7bbe-49c2-1133-08da80274cc6
X-MS-TrafficTypeDiagnostic: AM9PR04MB7617:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZDL0u5TmD197LAvUjt68kEI127ZFuJeLDcKpkwPIwKuWZpbbILOfEWiG2fqsbphh+bW8JnvycyMc1AIaoWELTeoNao8lLy5PTAext+TvX+6+kQ/FgBiGaeIKBmgO80aKp/CRkCVNN5Wnx5uV/e7fgPsxoteKdv8GScTaSYpsP9bWKu+/iDOaKgdNb3BmZoGvsuxIdi/HoIRqdbsZCpwoPYEl53HN9IbTSbO0kGWrcpNxwecmRFw78HTJR3cifVPVW0O0SvYvw/6DhvVif7hBvHDFK92+h3fD0zBQkamzbiX95nrc1SX1CDe///MVC+lpv1VmdDBL4rW4VP8GE8GpdPHMUheNrmEoT1HPvPMYZ1LX2JqdAEb2AhO0A5DW2jgQKgqba4gcVX0sh8AWsqGaXqZEMmZydDvW41abBE2/uziLtdPYVEGQeu9Ty30wtcI5RPaOmlHhQ6B7Xi//LQ1pn6D5GsXhHQX2SSf3Ovjl7h9HPhXX5Q7SQ1xj1ZxTmHSu4Z0sPgJyk1lxJXDYO+uBtZ8g6KNNCGYfWO6B5MG4I+yMjDDq0PFVZz7ir6BfceWP4rYyr2COHFEv6soRcWM5aX6PBPmwE9jiigDlVejMk20u0901cvBB1f3c5tq7Tm4QI0GgwS0fmvTaoLqgZgBR2FEWvV022xrExvQANlDWAxaaOtWPA20/MZF+VnJ37r6Ci8lSr1tq/CFZu+yTp7P5L4ynbC1jEatx79EOCG7Tk5m3IvtM5VU6sZ9eAh8o+RzOHv2+G/Alo2QSbcp4wSvxPydg/YMZy4OniQb93D1Tj0Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(8676002)(316002)(4326008)(66476007)(4744005)(66556008)(66946007)(2906002)(44832011)(7416002)(8936002)(38100700002)(5660300002)(38350700002)(86362001)(186003)(41300700001)(6486002)(6506007)(52116002)(6666004)(26005)(6512007)(1076003)(83380400001)(478600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aJQqsNJY54ieNRUUUzTDuBXeS99y7rCjZk5BhFdQKGNtpIwy1Ohl0tTXmfuW?=
 =?us-ascii?Q?OZz52di9CgMSpyKhj/TF0T9NaM7RoHayV0svMm6WXWxQD5AahYP8BB6aCFF0?=
 =?us-ascii?Q?TbrcHXq2ZcSdUKmTI3A+aYEBexIR6H8zsPfTzxBlOBL7EUDX6a1lK/8eU0ZE?=
 =?us-ascii?Q?9+A8Q0BXozqUT2o2KcjiRODan9FKerIzRY8WT+XsCm6b+MXdANHWC3Jt4jFQ?=
 =?us-ascii?Q?NKin7CUa8PnUG7xQpxz23r3YiHA0UA4at/qrNS1GgiC6quPQ7nE8d4XaxquS?=
 =?us-ascii?Q?E+ICTSVMVljrxo+otvqGKlm4qNKNanNPHIzAp3vQ3xxnnwk53LJ1JjjvMfO7?=
 =?us-ascii?Q?2ag+QlAu7qsp5D0q0qQHJ7PQY4l+SKqCqVAjyrtoorC2JPleQjTFeqQ/BZbX?=
 =?us-ascii?Q?CN8NC/NTys0lnNzXsPj7SAFvqhsBI/unRknckmOoY0BtJe8OndDsHkkpHisQ?=
 =?us-ascii?Q?ndCOJX9USW7zoLZkhhLOOoZtIeaDr0/oj6P2Zn6tqcRrLpyYZ1pZYnWd/7Zp?=
 =?us-ascii?Q?FXiI/KmLYjtjaMwe1vBJl7YV6sRIW/holr+UJF6CcuPCbl23+xbBd0TRpX4k?=
 =?us-ascii?Q?cg5aWWcnGKyvBTPOuXzHGW/genOGFFg06Lu4x5vq867XXthpJsy/IgBpiyu6?=
 =?us-ascii?Q?5CAnYVmUEm/ktmg4dPwoBU8spynw/bbiwbV8F5IyDBzgHVyijPyV8gz9e17E?=
 =?us-ascii?Q?LdZ69adX2X5j/tNzWiH122zM4ywiLvCEBBZv3bosOaSd6eMN5SP/AGYpY1fY?=
 =?us-ascii?Q?/TleECwBHRzFcCgKh00aO4LY783kub4env/PKsCUn3tm+osWzU2x+zJHx5mk?=
 =?us-ascii?Q?xPYmmVh4tv1QIZsTyyMXR+mK9vrpe+tWfYeng+wXOPSpmf1jvNceRMthZWSp?=
 =?us-ascii?Q?V2PoqiXs6aGUHy02OvebrKBJB/ubcmqTCNe/SyaJ/uvOcOyLXdtJVuv8Eblm?=
 =?us-ascii?Q?WRPkst7i416tIPTMqPHL0arb8VdK9MJ89JK11Z48BYevmIoj2qcTL3xSbB8s?=
 =?us-ascii?Q?epTZGzvJRSqJ//emd75Rjd9qvWhOLygsOdqs0T+PNuqErFhN9exKg1qM96S9?=
 =?us-ascii?Q?DzR5Xg+l1ezLnx17MV2WvsnpzmOPPrnZm8Z0EShQcYlP3bZCk4Hrmov9LNCN?=
 =?us-ascii?Q?RmwedTArSxwgHSV5DryjIOzy7Nhz9oP8Q5ZKZTFmAgtzCi7V5OdmL98a84LP?=
 =?us-ascii?Q?fZnDNjW6Imwvfd9Zbhy48GkAdz8xY+maHdT0SHorG4DsCMjnHyoqo2HEUYB4?=
 =?us-ascii?Q?J/jsSwbfhWQoerpGwrzISLv4XKB0OV3vb20oD+aNNkC64SWZtjU6HEstwJ2Q?=
 =?us-ascii?Q?8kowyNpnarvy3OZ3dGBQ5kSJ3y7Rv7sCHbVmWcuFaG2tLJoBvQE9bSzOQNIf?=
 =?us-ascii?Q?QT8OHVrQrZYtR2bEY6vBFUSqypKfSAuArVqsPUuFfEQCphWpcoyIXXrg0rk/?=
 =?us-ascii?Q?cau8XxE9NFqN8IMO2YFWGWhty/WQs+ZjqznJ2WRpoUR/OG+e4X7DE4yVH99x?=
 =?us-ascii?Q?T9tvRp7/bF0eC7mSrtn4wpRvM9XA+1aZbU8lnFMNlevjV4EGrVjyn0KIvJ85?=
 =?us-ascii?Q?NX7YcwzriAQ/zkMDPhT0jduuMaJxKYVZTwhlBC9r?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a45bf736-7bbe-49c2-1133-08da80274cc6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 08:05:51.1162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lsm9pelLR+ALOVD2hBvAcoXgLAORYUWb7G1gAtFIjiP/d+CFd9nRgqaQp9OJdWIx9SYIF7IHQ4ukTVAy8Yz6Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7617
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

This patchseries computes pcm_io_frames from the DAI position reported
by SOF firmware.

Using pcm_io_frames userspace applications can later compute timestamps
for compressed stream.

Daniel Baluta (2):
  ASoC: SOF: compress: Remove byte offset computation
  ASoC: SOF: compress: Introduce sof_compr_stream

Laurentiu Mihalcea (2):
  ASoC: SOF: compress: Save channel count and sample bytes
  ASoC: SOF: compress: Add support for computing timestamps

 sound/soc/sof/compress.c | 54 ++++++++++++++++++++++++----------------
 sound/soc/sof/sof-priv.h |  7 ++++++
 2 files changed, 40 insertions(+), 21 deletions(-)

-- 
2.27.0

