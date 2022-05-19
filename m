Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E6E52CC11
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 08:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbiESGjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 02:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiESGjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 02:39:31 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150077.outbound.protection.outlook.com [40.107.15.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B40B82C6;
        Wed, 18 May 2022 23:39:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2cs8VHu7utd8HrG5R4rmnVjvQrRFAqo2uF9XSWdMy9WzDz1Sy3NOTL9EMGUpiKSINsP6iC6zrt2lmSHFZ3gh/AxERQNlhmBi7jy5CQ82lObkIwejNC3Wcw53o98jQxOtwgHTBGNAdN+r3bmXP20GdQLueiix6qQMeb35mfZX743DBpC/2YEWopoUk5AP2bV+l0Zg/dmzASJS3OWgfWPXETTqSxU6T/VF/C3qJEVJ8xX6ZvtwxlT5G4RiR50siO9KqBFply4Yv0DC2SslEGobyPXpsX9LOdz1BNm8PFEZax0fJNTian3gpJLrMx4/QoiAODNFyo15usF+oA5+XD+RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgm07U7rGrxbOLw3krhIg92fieYUEvKat+9YFstpE18=;
 b=R2xvXQXEslnaxDsq7JD1uBvyaZl/0XmTFeN+r8rJxnqZuASZBlmbbSiw61vDN1fKojjkEW118blOswkssi5NXQkqP9aKQsLKubkAfYwL8ZYT4zkLgiDQ2R8CnHF9q5hZl4uVBHgh16mtQSbvwJ9VtePNAlTNiLlI4YEYG4ol8kZJudUj2ip9Sbr3hmTq9xctmrsAJbeY1hdVNFs2uPX3LgWeiR4EwDgk6aYWORXK37h+xXZ6HDoGxkKh6nv/nrB3m+x0DMdpPy/yxWqy/RIE4C8KGs1EKFgNlbxUhjXmfXKmvJYmucRDkO/LkJsBaPU8U1+tBNsGN1oYDL9kVQwzDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgm07U7rGrxbOLw3krhIg92fieYUEvKat+9YFstpE18=;
 b=ZLHjqBq7aTczvLiQST9U0GqTG/KHFS5JO7SQRuf6G6ydGQpN14wvJLndFsnj2dETzg2Rf9fmWW0q43iS4fZxyT/dW5sI9Avrc37e4lMze4kXRbsrrY0HUfey0vyjOMwRpkErMKaKRoHcYWpkOFs2gTuhQsO7Rr9cWGIDACbo7qo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB5932.eurprd04.prod.outlook.com (2603:10a6:10:ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Thu, 19 May
 2022 06:39:24 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5250.014; Thu, 19 May 2022
 06:39:24 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] remoteproc: core: check state in rproc_boot
Date:   Thu, 19 May 2022 14:41:11 +0800
Message-Id: <20220519064111.3244079-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0025.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::12)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b5fcb41-ec0c-4d90-1264-08da3962503c
X-MS-TrafficTypeDiagnostic: DB8PR04MB5932:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB593297A4440DBB5253285E5DC9D09@DB8PR04MB5932.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nHGX5oc4goBBjvl0CGaCy3MS7CRqXmxe3dopJm2RxzyeKyj0JmvmFtVwKRZqVNLityJKYHMNvHyGgWvcqWJQFceh6I5/GEC2CWxNj88WyxSZpizovwdVkpNRRr9NCxBcubmjSWfFgwBwXPzuKKz59wLhdQ2YoJgu4pwcwbXes8Cia56VV0RqvH23EYmpsPhrVNUNLC49MzXX617cbRCH+bUNicRhV0u6qJCeUkeN5Mfno65FGJjhaG+n/3BP86vcpBi2brLdB4NtlJQHlo7Ib7zC/3YbHjo89rjMlZfC4oHCSHylL9fIlLWwC5sBy2ZQf9G8cyfN0WE3W/LNan/RBcyilH2j0PEOeaPlMT8y+QXUXfhozw9zcTB5fZ/eEWQL/aVpNTlC9FEA+gaInEzNVKQxQI0S2ugadWkuuNY23lmzIxhg8xdhh9NJeI8nGGFkikq3ODv+JCOuSWUAeBokmU5L6+vj0H541bfV5a7BtK4EY2nomoNaJJ+1FBmnaWHy5bTdqw1VHALWXAEfwyFKfxJ3LjxlpmLQmmJGhXjMx4Mp+gzzPmyvgTnmkcqglWi4wunNk259gY4IjVB7i/eWRQ9cGDhDSCMwPkIgdB1IT8PWhPT37Qd1tDDd1SzYS2FqrdKGg/i3ZdSqTvhpsAOK3+lHid7pknau+PSTEL0zRKGh075eXoR+cwC+IzXd5RweGoZi6PcCc36EpgJlhf7ivA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(83380400001)(66556008)(4326008)(8676002)(66946007)(86362001)(8936002)(186003)(508600001)(6506007)(6486002)(26005)(316002)(1076003)(52116002)(2616005)(6512007)(38100700002)(6666004)(5660300002)(38350700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VGp7bBooPh1S0WYHHlgu4bQmxEQUzxVXQLXqrChZnXEVF5pBter1R9A3kpUA?=
 =?us-ascii?Q?EqsCGiIFdFnhMuJlPZXRALeo7aAjefTeee/4U1n/TMvWwvB9Q85nogDfuD3N?=
 =?us-ascii?Q?Eah0/zIGr9qha9GjWIvvZIfgRIiTVTPVydRweNxu5hJGNj+wigjeDvx4J0Co?=
 =?us-ascii?Q?OALtb0O0cKx5bj2EoDvhp6BaLKPsWUklOFzO+/PMBzYSasQIZ3aIy9+0PyMU?=
 =?us-ascii?Q?K1hsX0W2uvUkOEyE8eWONu8JObU11HSyOMRVcXKbGAAsincL+uWOyJiCpeCZ?=
 =?us-ascii?Q?UN7Y2FnwCbfso1ZC1XUwJ1pEUnv8grP/gELiDfOuBXkpjp/dxWP9HGtsU0MV?=
 =?us-ascii?Q?QOUg7CrGPmTpBURpn3cO3Xul3EkI7r8x2WIpKPW4Tnd7FuHpjupIm27QkUwA?=
 =?us-ascii?Q?Th2/T4Q7YPDlQnWu5CJqvbQzWj/J9XBM678dF3R6zm/3uKqnBS41D3Vix8Cr?=
 =?us-ascii?Q?s82Yr+/Yunr+ROhC3GUYUnkjEBycX5R5aWQ8ywjwVM08coyGDsEmcXZbp+zz?=
 =?us-ascii?Q?1vg3AIhLM0pk3I9IdLyMAjZz+WQUqw0rg66B8SI7KiVADTVQtbAmYKeoJRUf?=
 =?us-ascii?Q?1GBQqAYSLG5zv2uLe9YJzTvA7XOo/K6p/mwdCfCPFdz53DD3YtZ80MltSbhN?=
 =?us-ascii?Q?04WDC0LPdL+FZjc+XI0Ia2NR7wO5y0Nly/zcBrKHJyA07tTjqdtlFdKOHrsC?=
 =?us-ascii?Q?tDocTutIiz4l7l0aTmB+szejFf3GR0XdXHYURHwFaX7NrfusUjhaf5dQvjZJ?=
 =?us-ascii?Q?cuSOxtm0607uRANcVjcM1WOCNBT774FfSuIrxM3H1WrLKa/gO68IcmgygBLN?=
 =?us-ascii?Q?FTeTQZYyDyllsqCOYW6x8hxW5ra3e1E2iaZWlZ/w3Pk5g4iVLK9bhFjaBh97?=
 =?us-ascii?Q?CCKT7gq9PgVnjSdIpBT1bF1Q8MMue4KWC6CRezfl+CJTvi52V7WdISdHK98C?=
 =?us-ascii?Q?JUUp8IZMH9ck/lBVWlw9aUrgXNxY0Cfz3bhqsH+bA4tuMMhzUjFo/2Y63ACr?=
 =?us-ascii?Q?iUXX0mN40uHWpfwXEg84TLVxGHK2UYB2cET09l7vftZx5mMZYk4eDbJ+HWqH?=
 =?us-ascii?Q?MWNCZaqIKMff2i9D/YKq7fXHrfOqP+KD2dtH8BnhHg7UJi2pAj3986Rwb9vi?=
 =?us-ascii?Q?7BLBsw9KZHtSV6tLjiWGL92dpHTxwVgPA5xfn+P/9JLymv5A0utgNjVmhb78?=
 =?us-ascii?Q?Nt0ztTBf11tp8hoy3nKdGtACT7x1E5FIMA4sKmok1RK/7fBdexTQrp5r1iET?=
 =?us-ascii?Q?6cL+2kxOKL32fkOAB6eIs+OIplMFmY1pMSHwhscKKW5T3bKqo2LDApyN74OU?=
 =?us-ascii?Q?p4yb71vfqZawoJ5IyFJgt82ftnPHePVpeDLoyQyr3rYi+vDVLalkcEvLBfLc?=
 =?us-ascii?Q?2fQOAggmY5x1xTfl8Z3lttILqWmNw9Cbs8KeNR75E+bwtGo70hcuBB7jO0wN?=
 =?us-ascii?Q?UORxxHPjjL26K0GIPanqD6P1YKt/8kqtjbsBb+vdAESXQV+VLlGIr4FxQgdz?=
 =?us-ascii?Q?b0IzWXVdHeHALL1p0H/2vrwIAEMKV+edKGM1zBAb+J+zQHdKvYoFwZL83gPn?=
 =?us-ascii?Q?DHdTPyV86d5stusbSodzj+lXVI95tJJt3u/E7Ob+JRrFWC/1twrC1gENwaeC?=
 =?us-ascii?Q?lkuo4Q6UsOFXJI5AAQF5vw5Pg9S/H9JX/tzE3K3UCGCqlSepjx/1CrK5j6fF?=
 =?us-ascii?Q?d2yxO4mVj1GZQfZon9QwTYUf0McjSS0a8y9v0TtBoVXxIfpzGra3qh0In4lu?=
 =?us-ascii?Q?lTndFWtvqg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5fcb41-ec0c-4d90-1264-08da3962503c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 06:39:24.5933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+0ZWWYm6iR0wZuu5MyqVD4d8l0csIFl6oYjflUtL+GEWlbQ+o+7eLvuWw/Ki8yheLJ/McbpuJiNAwVi1k4Kdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5932
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

If remote processor has already been in RUNNING or ATTACHED
state, report it. Not just increment the power counter and return
success.

Without this patch, if m7 is in RUNNING state, and start it again,
nothing output to console.
If wanna to stop the m7, we need write twice 'stop'.

This patch is to improve that the 2nd start would show some useful
info.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

Not sure to keep power counter or not.

 drivers/remoteproc/remoteproc_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 02a04ab34a23..f37e0758c096 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2005,6 +2005,12 @@ int rproc_boot(struct rproc *rproc)
 		goto unlock_mutex;
 	}
 
+	if (rproc->state == RPROC_RUNNING || rproc->state == RPROC_ATTACHED) {
+		ret = -EINVAL;
+		dev_err(dev, "%s already booted\n", rproc->name);
+		goto unlock_mutex;
+	}
+
 	/* skip the boot or attach process if rproc is already powered up */
 	if (atomic_inc_return(&rproc->power) > 1) {
 		ret = 0;
-- 
2.25.1

