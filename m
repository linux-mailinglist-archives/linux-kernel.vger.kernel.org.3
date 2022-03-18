Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221084DDC3B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237615AbiCROyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237231AbiCROyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:54:44 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2118.outbound.protection.outlook.com [40.107.255.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417ABF8472;
        Fri, 18 Mar 2022 07:53:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSx2cPKGL5cPwM++SHMOB+xp7f/xmEzwMQZtat9ew9xU8wVOfcdos15y8w5H9q2JmApNOLirtfck22wrrLK2Gd6PccfUzsUWJGUhgJIbSqp8nkFheAWUHz4Bb7FBvNthCh3SeAlWaNDIHA5Tp9n3sUoJu0nejpdtu5IkwDDgJMyu01t4gBJbKDMcZ3kvd33DtuGzjJbSL8DBCXme4XxPb3TgYvShIugU4BT+AktZKIgwZOW+vBTUDAr/6jmHA0det/5ww4dtdgU+poYXLTju+kXIoallp6XS81dCbMHucG4vn3jsaWW0wfAJMg/mA1KKzAJGgk+4C6aE3LZTwejZ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIEyoua8qyU/lxq2P0udYtP2K8pGJqUyWzlOAmWWvkY=;
 b=JtSWIgArqp2zv9rujeiRfJYOlQ9spgj6Zbdz6E2O17cjXnqbruShmRCkb0Iyz2l0OzH36+OXagjIRCN//u5XqfFMrpZ0jcqqmfIs+V7yLdtZPLfyP2pIf63fz61gAMFa5u1OPqdlDJl57p7CUYtAYVLLNbR4yS6QrR3rQSF6SSdRzHGrHJyhSMUb2svHBt1JBfWvNS0cHY005AMgfJxRH0VwN7ixn0QuDX1mnuQ4G5Kist5UlBX5fgbFuUccLc0Mqt3EUrqN3RvWseXNoZIa8UiIF0mPRnFzOZJvFumvTKnf51sptJB4OMbQe0Nk7gOhGc+e1zLzvKjtsKzdiceNOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIEyoua8qyU/lxq2P0udYtP2K8pGJqUyWzlOAmWWvkY=;
 b=oZthGSdSdO8edagatrH0vb4PrTgqbv4wa+XPAZ51BGxH0eAp0pftYezylvXqmShQGSx0FiTUhW/B39z54fBS82GiUB2u/gHrZehSiImGwihQI+VyJUsk4UumgNPZL1+pQSezJhJbv6qxoG6NqYNyNGufg5dtIozE7PBbOxStxaM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 SI2PR06MB4473.apcprd06.prod.outlook.com (2603:1096:4:156::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.15; Fri, 18 Mar 2022 14:53:20 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732%4]) with mapi id 15.20.5081.017; Fri, 18 Mar 2022
 14:53:20 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     James Smart <james.smart@broadcom.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Daniel Wagner <dwagner@suse.de>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: elx: efct: remove unnecessary memset in efct_io
Date:   Fri, 18 Mar 2022 22:52:20 +0800
Message-Id: <20220318145230.1031-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0154.apcprd02.prod.outlook.com
 (2603:1096:201:1f::14) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5adab59b-bb97-4a1a-5b18-08da08ef0a14
X-MS-TrafficTypeDiagnostic: SI2PR06MB4473:EE_
X-Microsoft-Antispam-PRVS: <SI2PR06MB447301CD3C79969F6BF9D6D7AB139@SI2PR06MB4473.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LlNUv7bzlFD81ar83x8ETsqVqJXzR0qJGfjKs7cnY32E42e1pGyszaPo1EYw0GSwiWzCbZzPPzZ4JFivYQwz1xpAPTOY2y6fnWtxhKpyG60ijK4rRmGy5SClyNRBCMD+En2e47bCijYRF1+0JfhDW+NbQnTChEcJwLmohDWDaGbCLCiiASVS+YGzguhLM3IHfVcCjxvyfXvapjDteuAc0wy1olEyq+W0XElwlqFfUhokA8SY4bWvInQMXcLXQRyOhbTSPGzQPBVN2dT6vXNLCtSG6UXd/fxVz+d6IadbpafG+LKcLncrVR8x6t9R4wFI+iYQjkpoDsH+nqPmtjWfNJaWBODY1doesRQlRrMH8EN8h1kixMMiLRzBdIUoZnQe4GE/daG7qNqskjmrfOpykLzWV0bJo7yv1TZlCvPpQbIl9sXSIOnKi1OY/0gSHkVf7iP01O8TLWslLhu3wNGQ1Jszo34cnMuRguR62FV/weRmECIDzhUQ/IGEknZWLi2UienKqbGtj5Mzh6XstfSb+TZhow7VYvVrpQ1sjhCXa8oV1YuCEAJuLpW5HsIzD1W0gSEkCp5PnLyTLXPMa0ibKHBmQimMrC9ROI+2a7XrIiWDazhHK3y32mJHJ724ontN+Ovt1mM6lUCsKQsvylEXyMNfOwzOA0/udmXxCB+jui57NQns/H2+R4dbfZH6UkLDBPi3pOwZAh1eB3uT1kE/Dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(4744005)(38350700002)(38100700002)(2906002)(8676002)(66476007)(66946007)(66556008)(2616005)(6506007)(316002)(83380400001)(6512007)(508600001)(52116002)(86362001)(36756003)(5660300002)(1076003)(186003)(26005)(110136005)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7H10e6MrFkWqUAi4NusPGAClIAUnXrd/TNcjgevLkqf24RzTlQKZ6De2etcy?=
 =?us-ascii?Q?p5vFFal9hRgzXct3KZRpk2jCqnDPIXi8LhPLdYwrSNrEKbLaalD2pc9vcgg5?=
 =?us-ascii?Q?zj984jHLsqG9IpftcmdnJPtSjOusQeqpb+gN9160wI1EiWTSs9RWOuJL7bhk?=
 =?us-ascii?Q?gYho0hLNNEVQAYA1elQrHA0iOmXCLGZ0gN+E85l3INM6zNAW+XXzaciX/5V4?=
 =?us-ascii?Q?EbpSAnhRLMIuPgkXmjJVTa2evphnLdmp0f7UWuItqffPpQEq7gbGH+txHoJd?=
 =?us-ascii?Q?R0cu7F9XQjeBqGT6Pc1iX6tePfZxCdupkpeOGVpBG7+1+zAX2QflErS4pBg0?=
 =?us-ascii?Q?jHd1mrvURbj5mmF826whr6vCtmQjsXu1AVmEHqLG1HLVVKfeJt3X0XaAuJ2g?=
 =?us-ascii?Q?ySNhnlRXtDIdM5PBSNcnZPYrK6WJmHTtfN5F7yMU8UecAyo+rJ+IksF3eSjX?=
 =?us-ascii?Q?ks3xUHxvD6+v/bdKwnSX6Pf0IWV6J96A8fRf9OpwWrbMq1cnPH9fvni1hyXx?=
 =?us-ascii?Q?NMwsGh/4BSC9f49QS1HTfXSui4RFKThBgcFHgEwvwWzIeq8ZM9njuFM1c7ic?=
 =?us-ascii?Q?uLKG1hE7U8Wkyx3O0XrCW1LyXZCy/VmAGecTDU+gvUd+bluw9M9gujbYJalh?=
 =?us-ascii?Q?9Vls6SqQN6yOhq7zD8o0gpD61e43SnMbiorxbi55DIumbVonH5JHNGSLg0/A?=
 =?us-ascii?Q?sM/RJ9d+UOzAO+RCq6+D0o/UChsg5btRkygB1c8RifsuL8xFxC4eYIudDqYg?=
 =?us-ascii?Q?mlrhbVIRjf4h+++Hsj83dbwWUIk6TM/Wiw3h8QXWoF6jl93oQtnlSwEKpDYs?=
 =?us-ascii?Q?eEV6S7sInXUvUdArbYHmEycHXhbzsNtHhnwCMCijipVrSUEtxrdPINww/Hxl?=
 =?us-ascii?Q?EPCyICM9VarftFNuW4J8IUWY5pwMgxEVGbcgTdAMhRGYwi8ogdpLe4745uYD?=
 =?us-ascii?Q?VEmSgorHCZpsMvOPeE1dhqkEb4HxTK03bryx2aJMdLVWBNj6b0ZqRNhg0TCE?=
 =?us-ascii?Q?vhYevHJt+tt+zas9dhVnGLZdHxMrb3WBFOwbMEZy/vf0m1y3CrNed5dHMnUt?=
 =?us-ascii?Q?H0rPpmafR7j6l6vnLoSteqVlRsJwMWeMrS6lFzRajI73OVJXZRKKZOG6UQPg?=
 =?us-ascii?Q?NeAAnAmRXqSfrwEYRQmcVbHy9FUfpA3Uj69JXq2ZU5xHlY+6PYSXXfj67S6Y?=
 =?us-ascii?Q?HyqE0VMllTxeDd4BmOs73sLFaUvKM/3WYQxdVRdemoqXLJTYDprq0hd7aahF?=
 =?us-ascii?Q?0y3V8h6QtxhXU4x63WxfHldRQ2+LTW1JylAPDgxWfRXxqkjdUFpbfU7dK/Zt?=
 =?us-ascii?Q?zU7Fy+67gNeg5ZFWVu8gRSBFGoNd21etTpaPrj9MyxV8ofxue8tNZPj61hal?=
 =?us-ascii?Q?coIGOE0j+38j9Yl2WoZQkgLjDR5u6IK9KPdtwCzj+NskVFR/i81rOLczsw47?=
 =?us-ascii?Q?WwBgRaWeeryUoP9tJ1yIRq6HAYVPK1Zq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5adab59b-bb97-4a1a-5b18-08da08ef0a14
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 14:53:18.9408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ZlqbsfBz+GhGICaRu6pvvPMLPpM2muLiY344Z1NIWQl3NqVKRhGrHsrlpedmmPDr4HlK9AC3c8SopGU4JMVLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4473
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

io->sgl is allocated by kzalloc(). The memory is set to zero.
It is unnecessary to call memset again.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/scsi/elx/efct/efct_io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/elx/efct/efct_io.c b/drivers/scsi/elx/efct/efct_io.c
index c3247b951a76..c612f0a48839 100644
--- a/drivers/scsi/elx/efct/efct_io.c
+++ b/drivers/scsi/elx/efct/efct_io.c
@@ -62,7 +62,6 @@ efct_io_pool_create(struct efct *efct, u32 num_sgl)
 			return NULL;
 		}
 
-		memset(io->sgl, 0, sizeof(*io->sgl) * num_sgl);
 		io->sgl_allocated = num_sgl;
 		io->sgl_count = 0;
 
-- 
2.35.1

