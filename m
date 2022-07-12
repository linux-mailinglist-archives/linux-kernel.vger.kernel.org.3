Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DA3571C0E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbiGLOQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbiGLOQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:16:14 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30059.outbound.protection.outlook.com [40.107.3.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF8B60538
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:16:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQwm1HYfnh8uWfGBLxQQYzcXW1eMXTFham3cG+sZ4OMphEIqG9uZ3tH9tt00xb4aYXAY4B5LijBvYDvN4rBDRWLqTkZyF3jDYmQcVxC7wHgRHeoHUNvwlIojgJg2BrufgJwXnadiCGd+e6YPexGQLv7qCf1ludzaVLL+VIZJJjjLeuK0wUiMIdYO7EAnpX7dyZPs2Fay1o8jHDUxdg0coSY7AKDxY0yQCpblxx0QkshY+0euLDqizyY/nbnqYJH3a+GSdAyOLYXqGBZ+YvkM9AnjPanlkZyRUFsnmHqkbZ0WLQoid4qmI2oS75kr5HNx1V3URMSVvOGgIh0k1HBF3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ceLa9D+Qpb6/lc8AwdiIW4+4rAWVx19NDFBb8oegG9I=;
 b=Bl+fGNJ8VI9sRzrTMVPYZX0mDJ9tBLHbXhLYnXelzF+4Civ9/ZYsiytNocebzyKln/mxbQfMUI64NJd+8LMQ39D970RQGNjaGpqq95U07h80tEj47phc65mmanM8X+R5+GxX6+V7B737Rquio+r9o9kIcMm2Lc7Ed7QDiWNcbdSR4nwtlzcbUni0ZKAtm+9Z5Q88Y4f9LkA/wtR1EpgrN5pRbAoQ1WrDW7bwh/cI+y2dzvO6AprJu94p46JHQE/0+OT6XwNPTai7AXJ7I/QlOKRErJ0fNEKiMqSXTjobKjuXOJME9oj0qHzQUpeth9zOCdGW/qW2dAEDIHC3PC2UNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceLa9D+Qpb6/lc8AwdiIW4+4rAWVx19NDFBb8oegG9I=;
 b=S6PvqDLPyX25LiNNIPYtw6fkxu2CwhXHM8q22AZx1ZOHyWCjlfC06fkBMApKLMqopPldhtLwwFn5i1xkcuK5LGpvYJvCupoTTwhBGMuf4fnhbwydYF7xBDP3wU8sY+PVBO3w6Qwag8qd2aSY9snwQMQY44DK4Y1ZPjSFL6HV9AQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5140.eurprd04.prod.outlook.com (2603:10a6:208:ca::21)
 by PA4PR04MB7885.eurprd04.prod.outlook.com (2603:10a6:102:ce::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 14:16:10 +0000
Received: from AM0PR04MB5140.eurprd04.prod.outlook.com
 ([fe80::15ba:4274:2df4:8928]) by AM0PR04MB5140.eurprd04.prod.outlook.com
 ([fe80::15ba:4274:2df4:8928%5]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 14:16:10 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     daniel.baluta@nxp.com, linux-imx@nxp.com, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        yc.hung@mediatek.com, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 4/4] uapi: sof: abi: Bump SOF ABI for ext_data_length
Date:   Tue, 12 Jul 2022 17:15:31 +0300
Message-Id: <20220712141531.14599-5-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220712141531.14599-1-daniel.baluta@oss.nxp.com>
References: <20220712141531.14599-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR07CA0141.eurprd07.prod.outlook.com
 (2603:10a6:207:8::27) To AM0PR04MB5140.eurprd04.prod.outlook.com
 (2603:10a6:208:ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36cf0971-e77f-441d-d103-08da641111e9
X-MS-TrafficTypeDiagnostic: PA4PR04MB7885:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N6WezHId6XyD0T2MCAYHG95Tjgw2/y7lK6RLPP2aDM45I4JKhEcncoMGMUC4GGteMBv4bXdN2Tf5eZ8K3rs9tlW05P/YAvH1RbZudzcksVc0paDFkgi82fbVDOoSPfwM+7gzserhYn6Yh+/ZGQ+zTYte+7hijixu0kx9CWR9LjUgdIitzVnttJCw1yms54MutY1PKfwLut6gXxf9iprondk3n/4eyB5KBVH7aR42vXtjYttJHs/oaWjmL3ajuO9xzaQCvwYsFkgSZJTKGBkkG8t12MX+41WNFofAe76a5sdWUuNCNKcnwWKJyxXLYDaTkPvq/c8a9KDw55bL8c7DMqEYXeWkfuiZaE+9h8GTAVHl4N5OutIVxMUK0ueVoZ+YkAhzAvhdWAIXxUb4LjhcseCRlXiCCyUGR9TXBzNIknHH+yquBtyxmGQWLV46rj8vqeGgZ5W7KrDL/SVaHkQFw0c45v70o7b8cJ2H0S9f8P4CrbzzLup+fCqUYKXfSFtGz3thmaN4mcpwVwRE+CkolMdN5++Th+IbrPNeBABLHaCUeJ1joSLDaowC9pKhi1IMvHUTUJEudZNbIf/9G+t7X31zK9r2hWWwtoU2chfmQ1d487gbo7d5iZL+s5tKFgHutNGZPrOUxdmvN7Xum68lC9ioKmdTJTZAGS/cyhRBFDyCTzO24nx9So70d1nKgRxKLYga4EwZ4wHZ4OGuUq5weYc1XSPeXA/CiO+IF+PEwqkqpY/ptqRaH/2cpDpYW4TtO6ZQ8ybqZ8UJGj3CQJ+Nmk0InNvAQoSWtCGIYKr+omGwYZXZdu3FySjPTFMMOqq+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5140.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(39860400002)(346002)(366004)(316002)(38100700002)(478600001)(6486002)(8676002)(38350700002)(2616005)(66946007)(4326008)(186003)(66556008)(66476007)(66574015)(1076003)(26005)(6666004)(86362001)(6506007)(44832011)(41300700001)(5660300002)(8936002)(7416002)(6512007)(52116002)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzBnYXgzL0pjOGZ5U2ZuK3BRcWpSZ0pWaDZ6WlpyOWd1RXpuRkZKRXJrTlpC?=
 =?utf-8?B?Q2l2TU13a25mRmEyUUVieUYzZXdNZHExMGdpRGNEVzFWOTlmTldQZ2NIOHVt?=
 =?utf-8?B?a1VkY25Uei9PdlR4QmFBdzd1ZjNuSUFqcE5LS1RkQkFVT0JqcHJEL0lXVVBG?=
 =?utf-8?B?TmowalNOZ1VsQkRqY1JvTk9SVS9NQVZOSHFKdEs5S0c1SGY4Y2RDTWhpV0Q4?=
 =?utf-8?B?VSsvaFBaeW91TWhIN045S3pPUy9BR1lUWlFEVXoza0VCQi9qSWsxWjhIS1dR?=
 =?utf-8?B?S3VncHkvNDdJRFZKVjh6c2dybHJ1L0s5ZGdUVHdLeHpGT2JEdnc2blJsUUFX?=
 =?utf-8?B?ZXBMWUN6emwyb2tFWHpjRElWZGZnbm5oSGJlVm9xNGt1MWljT211dTEyUmp3?=
 =?utf-8?B?eXdWY1QrS05PWWNvMUozRWpKVkJnYWJKM1J1SVFsS01CSUExUEo3TlpoWHgv?=
 =?utf-8?B?ckFaMjVBRTVUYmJyZUo0TmhTeU9aeEFiUERJK3RKVEhHdDRQVXJ6V3gxUnJl?=
 =?utf-8?B?MVF1WUxLVzdoSzhZZko2Sjc3Uk5vd09MekZZWEZCWmk4bkVpSnFzZ3EzRXdt?=
 =?utf-8?B?VWhKY1I5cjlsb2w3eWxSZ2R6RHpBVDhHNTdSQk1wb1ZSWlh4c0ZjQUFKWGxH?=
 =?utf-8?B?cWlKbTNYUGVxTmlDbXFYM2ZvUWh2RlY1aGFSeXhmc2o1djl1bjJEbmF2VG5a?=
 =?utf-8?B?NkdUS2RJYmFINEVZSEwrbEJyY0tjU0RuOG5MVk41eVNEYVhLL3o2cUI3dmtj?=
 =?utf-8?B?azB4cTR6TE5pYUR0eGhQWWZVbEhuTGJxaEhvbUoxbFJxeG9kOWxEN21EWEgz?=
 =?utf-8?B?Zkp3VkUxdW5JY2M4MjRYaFBUclJiT2VSbUM1ZlF3QnR2N0szaXphV2lBeWNt?=
 =?utf-8?B?Q1c2S3B3NVkrWFEvVFloZjREWlF5K01KcUl6VHdNdmVQSHlkeEdDaXJzcnpQ?=
 =?utf-8?B?ekVUeHozcGMrWUxDbEJJQmRmemsyYWVOZTlBT3ZXMGMwWEgrd00vNXFJSzRa?=
 =?utf-8?B?ditGTWpocjJxd3JPMDRkbGFlVTJUVzBSTEY0ZjM1ZURTTTRmaDdqUmtmNU5K?=
 =?utf-8?B?bGZKZ0ZPOU9iNDE3ZmtkSmdkVGtvVGZ6cjdNTkFYclYwMFl6OG1RZnNxZzVo?=
 =?utf-8?B?S0RUeUlkNFo4VUxCZTgzek1HY3p6bWtOOTEveTFwVWszTGcvSDdnbkhuUHZJ?=
 =?utf-8?B?K3BOSWpDSmFrOTlqU1M4UTRtZVJFM1IvbDRHdzNVcFo2ck5xODRWZU9RZ08w?=
 =?utf-8?B?Wm4ybXNlcit4bkhVUTl2YW1DbHFQc3U0NU1CWUdMbEZFMTd3bmlUNmFVREdO?=
 =?utf-8?B?S0ZDWTc2Z0xsTWJta1kwNFMwcENJWDhzRjlNSUNPa0dxNEtLSUJ5aFN0VDUv?=
 =?utf-8?B?aXpsVEFtNW83ZVkxTk1PaVhYZXJuMWZlajFIdDdZK3EwQTdsOEZQK1FtcnRI?=
 =?utf-8?B?RVRFZ296MUFzb1VGTURhN1VEWjFBYTBnSEVLZGdPWjNJaEZmc0Z4VklMeFpE?=
 =?utf-8?B?dTg3ZXRnRW5Ldm9ZNGNkMDgzT3I4ellGYWwybjNDWTRHd3YvUGdvbDhjSWJ1?=
 =?utf-8?B?dk1qS3VuQm5oLzNDMUhCek5JQllOaDlsSjVrVnVDTlVzcEEzTEd6Smw0WXJr?=
 =?utf-8?B?cnA3dFNtMi9XdmJSUTBJSGZpTXl6ejhqSU9QbFRoWE5pUEl3Ym1xVlFIdXZS?=
 =?utf-8?B?NnVVS2pRVVhzL2d3NE1xanNrTUJIRHU2R25IazBvSXpHcmNJL3ljaGl0eldX?=
 =?utf-8?B?T05QR0ZFcHFXdHFpOHk0OXJaZ09vVDlzOThBenpzOWp4SHRuaDlzTnhIUXE3?=
 =?utf-8?B?cHpaUlhFSW94SEYyOFVXaXNiMnMveTlmaTJLOTJvcHltYmN1czllUWNpMWY3?=
 =?utf-8?B?R2JpQTJESGRaeXRWeDlXTEVwMGRtcy80TVJYeTdQK2dQaHB6UHZRanp0MjJs?=
 =?utf-8?B?eVZVcnNqMDMwVFJHeUNSUDM1TEZKU2Y1K0NUMWx3d1F5dC9zdXRTSngwRDly?=
 =?utf-8?B?N3BHSzA0RjVHTVZOK3ZXNHRzR211Vy9HZS9kTHg5TmVsbEhkN216QmhVeGNi?=
 =?utf-8?B?RHp1bnlEK2RNMUlRVGpsNlRTekxpMWZqZTRhR0hEUlNsbytROUtrMUlsUnVG?=
 =?utf-8?Q?D3bMext8OTKBZWiM7KYgnGlCW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36cf0971-e77f-441d-d103-08da641111e9
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5140.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 14:16:10.5979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sIOIDLCdtVFW/niuQeYxntybwOHzYsmfkZRar3vD4h9gIRAFp2rlReJxb5tPU0MGCvhEy/VtSHJkiooFqm9XrQ==
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

Add new field to sof_ipc_stream_params in order to extend
stream params struct with extended data to store compress parameters.

Older kernel will still work this as they ext_data_length will always be
zero.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 include/uapi/sound/sof/abi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/sound/sof/abi.h b/include/uapi/sound/sof/abi.h
index c88f467374ae..b7dce4df7ecd 100644
--- a/include/uapi/sound/sof/abi.h
+++ b/include/uapi/sound/sof/abi.h
@@ -28,7 +28,7 @@
 
 /* SOF ABI version major, minor and patch numbers */
 #define SOF_ABI_MAJOR 3
-#define SOF_ABI_MINOR 21
+#define SOF_ABI_MINOR 22
 #define SOF_ABI_PATCH 0
 
 /* SOF ABI version number. Format within 32bit word is MMmmmppp */
-- 
2.27.0

