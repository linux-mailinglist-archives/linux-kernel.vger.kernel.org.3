Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30B3571C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbiGLOQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiGLOQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:16:11 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30059.outbound.protection.outlook.com [40.107.3.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834806069E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:16:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHVj8TXcsR4XbGhcStWsdVicFheXhVfftFF+5GYXpia93RJbHTCoo/mY3SZArcb5kIrWGViMGFsVG6ocbesfavmHF50EhZVbei9W9WLU1E5pZjQ/uWYzqo1K3c/jBp02Ue8HsRd3GGe3zzhB89I9IKfwsoCo3QJ0FPNXlZqnR0R7DLGO3fSFkpRuYrS3HCyZg0I/nzQSIZ77MakyjSHAFahprSwdDgRXOORpMoi3j0Y32MvnMMr8neezjOFJ9c30YPWe5jxqMlrBgnPwA7Md1f/W6NjzUj58L2f7t2fa2g5bI44GNcBm91dS91ffz9JdnOcI3wEignmqzzlmaOXHUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDmfWaqhvgQANkRWW3TzzefsrcfyMdiQ0DBxXgXmTrc=;
 b=YFnO81GLr+pRIOuyjJmcyENS/KziRX+8YEyL6EZqL/pAUqkg9Ln9Fr7FD8yMF8o1I+JRi0xqGj3wTxK7FHXuv2rtlhvlfpTG3S9puy/CKB3IOpmyEu5tsFsRUom5iqHzpg1vJu4u2Zes4D+rnqE0ranOrA9rGemex+eeL1N7c1IaKGJmdHvs6jpdv/yJu/v1dBHPl1kePWHRQIX0DeL+Sd+DHbfdFYzT9jqDSVawsHDaMFJN9dWcFD6AHGH++oEpabOfmG2cAT70/59bhNLph6URj7qvBLfwk2b/91beTLydkn+eBewUPicMi/PPDNCNtgjMmjQgENXDncpa9OYnOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDmfWaqhvgQANkRWW3TzzefsrcfyMdiQ0DBxXgXmTrc=;
 b=S3DtQBsS9ha63k2ThWu7t6UFgCcyhd2U0e/GIinG5CZbhwql+Dk+OqwlPxpkRvRFmKcw4IfzmzvERcB+u85lp0WMqTgjKQjpxBDtmfJUDEFSxU0/vxjJjE4MgYmRKKO/UpVz+I67ntaDsYtfUaTw0Rxgt5FHt7uXkfuX+tCjGZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5140.eurprd04.prod.outlook.com (2603:10a6:208:ca::21)
 by PA4PR04MB7885.eurprd04.prod.outlook.com (2603:10a6:102:ce::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 14:16:06 +0000
Received: from AM0PR04MB5140.eurprd04.prod.outlook.com
 ([fe80::15ba:4274:2df4:8928]) by AM0PR04MB5140.eurprd04.prod.outlook.com
 ([fe80::15ba:4274:2df4:8928%5]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 14:16:06 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     daniel.baluta@nxp.com, linux-imx@nxp.com, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        yc.hung@mediatek.com, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Extend ipc stream parameters sent to DSP
Date:   Tue, 12 Jul 2022 17:15:27 +0300
Message-Id: <20220712141531.14599-1-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0141.eurprd07.prod.outlook.com
 (2603:10a6:207:8::27) To AM0PR04MB5140.eurprd04.prod.outlook.com
 (2603:10a6:208:ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5d39462-3f28-483f-af07-08da64110f31
X-MS-TrafficTypeDiagnostic: PA4PR04MB7885:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eAqP0A7cdWoAZNuFsLojGZfFCFItnocfkv6mKeGeRgnJSA7BKovLMZDk0/XUPR2BkIk6G9I5H3afO9YFOXw0jQxdnL0ge+ZahKUTV9+UlCQeTWWUmDupn+cfpIWFSYyk4xtVodb+VE//sLIsQJBQKVoc3tUdZUFEhIufrc9G5jit9bWJRvdqq7Q9Z2cNcDXvgbtWwVCIbbkRx/qDJeLAfxL7IgYxw99oIub9lLX4IR6uhPRvePwOPt+DkJVHmNki/LfRfZZs9fLiGFDD0uwEN4WRkIA6y2blGcuVjWDo6SVmcvOu25ND6XgBN4sMHx1xo/ojrlNyyCPPMze/kg5eBh33gqwpEWn40rsSPDeO9HxVbBJ+XC/5t88LEHWVE0m6Sza5ZDwYAOwqH0RfUNvkt5kSXtZtwoc+8feaMAOZ5HbXWoAgwBAHOi/e1a8m3sRXvDRkCKRW0TK0NmAt6Kfkrd6XReJ9rGdABluGC8vIcC7LIpHRbU0+CVmEiI+TbrOgFAp9i8mgx6CwUEFIeb60NGU3LANf8vmoiEqFeqqELR/4nSMxOu9EBmMoGhAJ6YBkEev5RMzIThwrhrkOik9oBq+TdmpQ6ZcDlrahdUZZb2jB84D4jIRaVcfbv8hSRlarXrtQqmZy/i4t1D/BKAeqUqJvUkcBJEs+lgQyEZx7KY/zJOQ+/PT4A1lkfsGQgP+UeQskNMGo0uS4K2SBQZEcrs2QAPdeeSmFS25o3ByyxrQCmyFImzsnm0ghz0Tb02cmWLcpZuPBbgs4ynX8CGN9ey3NLwV9tiMGMjMUKmHB0DjeWhzAa6Mm9Mnh4euLG81793+KLvlD5t50tZScz2J8ng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5140.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(316002)(38100700002)(478600001)(6486002)(8676002)(38350700002)(2616005)(66946007)(4326008)(186003)(66556008)(66476007)(1076003)(26005)(6666004)(86362001)(6506007)(44832011)(41300700001)(5660300002)(8936002)(6512007)(52116002)(4744005)(83380400001)(2906002)(16251815004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?elAFcDlqHRTsEC6sqMesBCAab/GYCbkGpBvgfO6mBB4CTV610VLOj7KEBUBD?=
 =?us-ascii?Q?zPxOr2C28Ynb3QkZj3fNV8qCwmXL/OJWhX+ol202LB8xNrefen67V55X5nfL?=
 =?us-ascii?Q?AnQ0n5K8VSO28uOQNIbjljseufD6/JI3a28jQ68uJnhphZgj1s9VQVnsPWn4?=
 =?us-ascii?Q?rE2cooJmWNsOyriRIlK3KlTnh6hw0ao+jijQHISbF1su7NoQ4ZoAYZxYBKuv?=
 =?us-ascii?Q?365a4ujKWt/wQxI9XzhDS9ewOC7D4cdibFKPxWYx9thj8GeUnNQINkdTIQEv?=
 =?us-ascii?Q?DV/CKdzJ0W4mm/WtAP1+o7lMxRcii5pKhS/1LTbZwnm9iJoYJDzSsRTg06xm?=
 =?us-ascii?Q?3jRkbbJTy9kUc8g62DwpNc8P7JI81CoOxv8lQ35sbv557GPqkkIHu5Sj5V0p?=
 =?us-ascii?Q?1t57OzjBMSJwHZGCNzKeQnlZm6DFK+1hTkWogLRfRPyNffQqbWU+1ChFyzpF?=
 =?us-ascii?Q?jK5AVEsVI47/42DFuxfWtg5B6Q0b5eKVxJVdpxluQ4jHYAqQTRdGhU4yRRb9?=
 =?us-ascii?Q?n0FtK7+hhAATKAWSDrGYTzWnzB9cWOLbWTbcaMg7F31FvEVoiNTK1colyMlb?=
 =?us-ascii?Q?RqdvWKxYxTTRxyIgklc/2H13OyedU/LJuLI1E3+YngPcnz78gvvW6dYGj6e8?=
 =?us-ascii?Q?JQ9/tfy62oQCcHfEQneBs/Jy1K3KkQtJ/yOPc+7tqy8ilaIB83DKjkna8dlz?=
 =?us-ascii?Q?KU0SwLvmFYi77VYgR4LuCvEPvyojzr1fjvrcYI6KzKb2Pf6iNj7id19UNpgx?=
 =?us-ascii?Q?9i4nIdMJjKl682sYZJaTGmMeKrHd1+Ng1IP5hw6wGo8pXe9JazDos/DTeQEM?=
 =?us-ascii?Q?TOZwu4q7PVfbjANKhkoZKpjdWIRudl5f+KztYA7nGfDLQTSM7ITwlm2HiLax?=
 =?us-ascii?Q?S8JBIa9UG0QYWb8OqeWP14IcSPph9oo3pXleTyz1BJiRmvp6zfFcfz+H79JQ?=
 =?us-ascii?Q?jKrVuqXxS97GqMa0j/UWBrhYgphpAqZ80orM+GaDpWsFnaWOzha+3xqjR0oS?=
 =?us-ascii?Q?3jQ5XId9b47lzc29e0q4AVuQFP+9QyhuYMdZU3mOLBD5+VgLGiBT3Cn2pKj/?=
 =?us-ascii?Q?V0VqOxH6TB1y39Rd+SFRuj6Mnr0V4i9u5c4hR2uWTztcYkdEjRDG+x9CKEpF?=
 =?us-ascii?Q?QxV7HPqXyVPsfhwmZq3IgbBfRESxhX+nWCSoPGS4tZq8U5hV9H7fRqMhZ4rC?=
 =?us-ascii?Q?1Uodc2kIunW3vM+FOK5gXfXwfBmXKNNgmYBbgLmL7Sn4rJSvqtKGTW01JQRu?=
 =?us-ascii?Q?6z28nrKaxpFD0pYnXEiNk2I8eKeByEpzRjMlMd9tGdRGeUzDjESuKhOEJQGk?=
 =?us-ascii?Q?Tn0eSv4BqZ0C1Ufjtv+PnIJgnnHlixuuOjnO2VhbCpv9ENh0uNkXx3yboHKR?=
 =?us-ascii?Q?ZZ1DGfAggOOuIhbfSoB/pO62Z0CwfeNwvjz7/groR1Uchd3uMk7186xger64?=
 =?us-ascii?Q?/a70lFMZkBIvEC8bFCPfwEIRBC2VzlDY6aYaLd9oo8gJ+/KDyT0q/hjyHVx/?=
 =?us-ascii?Q?2Fuff4EM85jgjDdYUgu3lYWUynVDlc/d8fug+r4lX655cr2e8eZ91gTl5I8i?=
 =?us-ascii?Q?Dy0ic6OnRgS7I1IiDvuGbGP7YNH1xBJSO1N3EFSi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d39462-3f28-483f-af07-08da64110f31
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5140.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 14:16:06.1450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qqudAM261wsGvJgFHLM99aexKZggpF6edKTZH2lbdv2orc7kv6dsAs4jO31L0WXHkyuyg4YtfF5qQ70gfxLoJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7885
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We need a way to send extra parameters to DSP firmware. In order to do
this, we introduce ext_data array at the end of ipc_stream_params.

With this new addition we can send compress parameters.

This requires SOF ABI bump.

Daniel Baluta (4):
  ASoC: SOF: compress: Dynamically allocate pcm params struct
  ASoC: SOF: Copy compress parameters into extended data
  ASoC: SOF: compress: Prevent current kernel running with older FW
  uapi: sof: abi: Bump SOF ABI for ext_data_length

 include/sound/sof/stream.h   |  6 ++-
 include/uapi/sound/sof/abi.h |  2 +-
 sound/soc/sof/compress.c     | 73 ++++++++++++++++++++++++------------
 3 files changed, 54 insertions(+), 27 deletions(-)

-- 
2.27.0

