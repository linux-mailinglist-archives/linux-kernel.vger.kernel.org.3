Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E044D2D42
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 11:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiCIKly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 05:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiCIKlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 05:41:47 -0500
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2092.outbound.protection.outlook.com [40.107.23.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFF955496;
        Wed,  9 Mar 2022 02:40:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUEAF85u3gJ2uzS+53BUrMsyTt+atHUBgBqsoBfVJdItJ1hHc7v3/u4BhyatNQlHkCaBNegw62xurxX0p3fNmEwy3rfzoSnXMvBYWMe2YOVmUKC2Nx6xNw5KK3pdheIRfwWz2NYaSx9SaCPGhZryvnMmMFYR/RTIibnegzNlpS2ViIgksH+TQTXfHCDcweP9kt673PtrE86QxIpW6MF3OClJ0Ap6B3GRk4wU03KA513Z8kY1c4GVNG/NxjQy3nsS3SncwUs2MOksLh7x0GXPkt7g9k1zPgZgpP3TbptBUV1zV8rh1f+2w73YwWZbF2Fj25BJlWrB+jgjP4BkcpH7Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQOKRwLjqXPqhRwsOispLy3pSzNNAfZ6UzW3WfsKQQA=;
 b=WA6unZl8bFyMxaprQiayWozC0OuCIlackx9+8L58rw4dg9qiduiK1HAkaUOqDAQBGXlYUbyHst8cRfcH7XJuvvd3UKi+cmpM+qjsaV4fo0IRzf3bbMiK9FLlSrLwOhbu6JOttpTt661MmK1bpU5z2ngq3Z/FEM5RnPbo/GkFnsaifcHy3YkjLyu5PXihE9FjylkmmDhAyyAhoyG7JzN+ZD6Ma9m4Yqs7qtO8CkKOHBPU5JW11V0VBkLOEdXcQSyGwK8KCjLQDW2gNlXcobCza+dWJffvWHp/IDQvF8Gw3SSZN/VLGDCz9vDRmWbc7vCMGZDT/a79q8SOoT8hDmitbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netmodule.com; dmarc=pass action=none
 header.from=netmodule.com; dkim=pass header.d=netmodule.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netmodule.onmicrosoft.com; s=selector2-netmodule-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQOKRwLjqXPqhRwsOispLy3pSzNNAfZ6UzW3WfsKQQA=;
 b=MNza4WyTNUfUmPylj270yROQnRYCzMBOLYDYAiNavm1jSVs4MpFYFhDBajVx+tSjxP1JbEZ894aY9pp70BjwqjoGz0vmocUM9wKMaSPFxur8JSw8aAWN6pPEODJNLxm9VlZa+T4MvJzeIhNGnZ5zXEZhF1WX9wxjxou+OXMBPT8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=netmodule.com;
Received: from ZR0P278MB0027.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1a::12)
 by GV0P278MB0949.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:54::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 10:40:44 +0000
Received: from ZR0P278MB0027.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1132:a401:5946:ee88]) by ZR0P278MB0027.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1132:a401:5946:ee88%5]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 10:40:44 +0000
From:   Marc Mattmueller <marc.mattmueller@netmodule.com>
To:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marc Mattmueller <marc.mattmueller@netmodule.com>
Subject: [PATCH 0/2] mmc: update life time and rel write on sysfs read
Date:   Wed,  9 Mar 2022 11:40:19 +0100
Message-Id: <cover.1646820083.git.marc.mattmueller@netmodule.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0185.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::18) To ZR0P278MB0027.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0122f5dc-88e1-4f0d-76c3-08da01b943ad
X-MS-TrafficTypeDiagnostic: GV0P278MB0949:EE_
X-Microsoft-Antispam-PRVS: <GV0P278MB094950A8CEFBD6329EA53A0A850A9@GV0P278MB0949.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QsBszAQaAsQwmBoiTtWVKoFmvnMSeJqeiZZYLU+PTA8Tl8KkSLcUYX4cSJT4ohHfWjQ6AzhFNo2zpEUTmTbqlSSbwt4TAcv9ZzaTth3tPDGGw5BeJYGWGphwJtElmGOAQl4hbfJkDlz+mJ/NiCdiRRiAeHTi1tXHfnwFbb5yqZcR9rpY0FtLWD9StC5W8r8Ow9mHaEvjs2UB1pHyjvSAJzG/xkhS5OaUZvNHEPIYxFomkcX6BVwgj+9zjQHPgyCXVsmWnQ2xc/ZkisCjuHHQMLvXxO3DzLI3stXQvcrFR52wRwSJ2FeWldglyLxTFC/iZbDeTaEeHvvMalwjde/4nG9lnh0T3Vk6sgXQM85Na9R9stIL0OMqBYghmR9akYx8ABAv5EmppxgV+jG7XOTOMyQQMJOpp8rfnN7nfwU6YBcS3JAGF6+5YKJJheIHEDv+XQeHZnRMZH7jmjCX3xWZpls2R1LSh4WfK33J95uF+L1MdI7EkwocBx5va5m9PpMPH2BYrQusoPJb2kwZi4vua+khZbR8LzeHxsYU4r4PXcrj0ZIwYZhxOPEg4XnbP/RTSEecjqg0j6Z/pPHkM34Zc8+FozrpJknJXpGB1nuGiEm2fQ2Ja73l4ncK4Ml1tkwMkmUWa1aAB7tNw/S9d32KHZ/aO023Se/IU5Ub/UfIZLo0LMCn6P7hO6MgPQSVvE3kAMuPJ1Q4ZxAXfr9IdcYf365V7vndz97xOHGLnmuWY1NqI0Ok7KTfyhhh1lJBD52PsBfZiWlS+V+zD6TDmSS2762vZlg/LV0QyO0uAudIQeU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0027.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(346002)(376002)(136003)(39830400003)(396003)(366004)(52116002)(107886003)(508600001)(2616005)(186003)(26005)(316002)(83380400001)(6512007)(966005)(36756003)(6486002)(6506007)(6666004)(2906002)(66476007)(66556008)(5660300002)(8676002)(4326008)(38100700002)(66946007)(38350700002)(44832011)(4744005)(15650500001)(8936002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vKtfIPQzdgGmU4dFHLEGVa8PvsAX4IHl/URFaNOKc9MRHYSZvwieaXiASXyO?=
 =?us-ascii?Q?b2t3fhsz8X3ECJVEp+HbPdRkQCBQ80KDBM+TLwZop5+IxcK7YcQoI8TfSwWl?=
 =?us-ascii?Q?9IFoVLQeKLOJ+OjzPW1bi8ULPKu6sHZX8Wo+PqRXP2Op5aY4Pw7BQj3+jsiT?=
 =?us-ascii?Q?9EXWjjSBtnfDO8SG7SSTdPBIBAdNhaNJg46QuejB9i+pkEz6YuzxPh1RxrK1?=
 =?us-ascii?Q?+M6CHibR6S12KwyWHujnkVfiYQrNPPOjGNUscIqrGiU3f1SYd6NkIVkUNvHN?=
 =?us-ascii?Q?B3uY5qsloJv9Ktre2UHOXy0Lrr/LIhD+nJ9/uT4CtwPcEph/+01WEeESxZqM?=
 =?us-ascii?Q?c3tbwohAhrqo6EvxC0h8HGSq6I0YZ4FMfd1PZREtQxP1hpq8FFgEH45/dmnO?=
 =?us-ascii?Q?Ijcys+p0ac0BvtBxg+1VE/Opw9020dweVaJ9+W5CQZxhbH68JYa3FuEZO2+b?=
 =?us-ascii?Q?NvbcijH9pqZ6mIx3fbiJLqEJx7E8yZI6x43GFdx986QO5BYjjP8k9dXBsw23?=
 =?us-ascii?Q?R2uuxh2WgpSM6lfcCkbRgOA5f/5O/Mfrvm14UqV38kaNPeMXNmCVVSBVigpN?=
 =?us-ascii?Q?fV+FXDgXmCCMAoH2BdnJeEk0maIBZBoW9rfQDNZTq3U04WlsXVJYf909Ou0D?=
 =?us-ascii?Q?hRm+XuR7y6nm5+zBxfS3ZKmIgTEoemEtt0iw3Sl1VoRfe2k/R4/ZTrJeR46+?=
 =?us-ascii?Q?m0c6s+9GQGVKH/nTH9SFHnuJU30cnRtPpJF4eBy87sZOYQzE0SbFsH92kF1b?=
 =?us-ascii?Q?C3/z7rKjnjEEQf7nYDHN6q+80LiHG81iVuPXdNWRCMzL8+4b+f/dC1hbZGqg?=
 =?us-ascii?Q?RGUeIKBIXmmnEDGLyU0kZKgBqzuJ3iVdqBHm8J9PScfil27uM7RxP2kg4hSn?=
 =?us-ascii?Q?tbw6zkRTeeabTqdnVHQfsLjm8SGp4/iATWm7Vol4v9J4MF9VFp1WsKQhIKfQ?=
 =?us-ascii?Q?pg4C/Y4paU9YR/CrO/2XO87k8C5bfsoJpYi3cP6Qsk+drDkJM45ABVYpYIxO?=
 =?us-ascii?Q?kccbdGOmN52PEyDfyiGvtwhmvTfK1AAEs+SX3/vm5Aux2n1GLy78v8rZbJd2?=
 =?us-ascii?Q?2egLTWqTEZkZ60+46w5VTPJVSeQe/kSKqxvEAqeWRuhW4H3vLYcjr7Ctl7Uq?=
 =?us-ascii?Q?1DTSS152c8vLFril4szQmJh36vqfymwXUftAk3N2Wq9FAQywPALRILgkUW83?=
 =?us-ascii?Q?vopemiZKqeGiCsQby9PT4xi36rJj18cWuTxJvdioyFia6cxQ1z3UjZcjOtz5?=
 =?us-ascii?Q?DYcWc1WbxliZyn41ZdvmDCDqGeXwjlUL0G8lE+Z5hG/JiZ87VSu0NUdM5KvA?=
 =?us-ascii?Q?mnCanh6IgwFUx2Hh6G1BeOfGTs5rIDtcsL8+5DFg0K7vk/x5WKXqPbh2ZGsF?=
 =?us-ascii?Q?lDQLRVi82o96QUDU4hY+a7i8YMmDaA3janKAkh0NZnQ39/Wfxe8dim5vrYF5?=
 =?us-ascii?Q?2rQHu4QS6fzvxV2MUotK5CsDgpmP0S6iwtE1DoG/8f8GRbLBVToyBILFkI+r?=
 =?us-ascii?Q?eNPP8s6ZoAp6rnvumthXUuMN9eqVY3v78qjrKQ5QTNvrXOLIBWs2kWWSKFT4?=
 =?us-ascii?Q?QDOCt56aB2+jak14E8nM3ts1OG6iRBm5KjHkjhG215RrhN6NPgMBiMUW+W+Q?=
 =?us-ascii?Q?qJl2b2/Hh4ZOLhfjlv3KySinkD3pTzaeyCnMu1yfNRKwZpDnZw5PUn2FF9LZ?=
 =?us-ascii?Q?PXGNNw=3D=3D?=
X-OriginatorOrg: netmodule.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0122f5dc-88e1-4f0d-76c3-08da01b943ad
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0027.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 10:40:44.4240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: dcdfa962-340b-405e-be0c-5bfcc8a0841e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +w/DYRmQreBRFmyvvb/OktDbz0qljmXZG73VqPourOMJRWfbda+7jV2rkQyhugJgS3Tjg5oAk6Qq1uoAqoTIotQNDVxekHwv4afQjtVJOfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0949
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the update of the ext_csd structure when
reading the estimated life time, pre-eol info or reliable
write setting from sysfs. Based on
 https://www.spinics.net/lists/linux-mmc/msg56424.html

The reason for this patchset resides in devices running 24/7.
The mmc estimated life time values, pre-eol info and reliable
write setting values were only read at start-up and were not 
updated on sysfs read. Thus, these patches add the rel_param,
rel_write_set to sysfs and perform an update of the EXT_CSD
structure when reading form sysfs one of the values 
device_life_time_est_typ_a, device_life_time_est_typ_b,
pre_eol_info or rel_write_set.

Marc Mattmueller (2):
  mmc: core: update life time and pre eol info values on sysfs read
  mmc: core: add reliable write setting to sysfs and update on read

 drivers/mmc/core/mmc.c   | 116 +++++++++++++++++++++++++++++++++++++--
 include/linux/mmc/card.h |   1 +
 include/linux/mmc/mmc.h  |   1 +
 3 files changed, 114 insertions(+), 4 deletions(-)

-- 
2.20.1

