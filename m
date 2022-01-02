Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E70482D0A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 23:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiABWiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 17:38:55 -0500
Received: from mail-eopbgr60132.outbound.protection.outlook.com ([40.107.6.132]:64423
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230493AbiABWit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 17:38:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkbTZIVWa0oFBw9Fa6SWZFtxNHkePVWlw26RTOpAP02tZuYgF9zKIR4+bDx+DeoqmVGfxoa4PnSmIvQBIjLT9532RPHKrQQjkk+A9BARk7GP538y6OpO1zE6Vl/bd0+qf4/R10HMZxxkVcDL7xS2SVGyx3RLbVxhFxetzYzv5fP2GWKoafbpN223evUaXUVUoPzb9iZZ97ymUJa0RXvYblvJiCWckLtFG/MGLgdFGhzsE7Xz/TmkLWzJLzcBnDpWYOFyVfP3Ovt19b8a7VGRNwDluDCuA62X/b3LLD+1shPD7OCE7jLMOIeQ+gFLQcsjkEVHLqoTCkojyRAsjWJZPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlX9hOwXPecOWSSZ5NuAYbofkDvqnDDxm3aAiF6GZPU=;
 b=TTXwPM+N1/25ag/NKjRmwci44O6Kre5GJ9BXqG2ssBLm102ClqFNWflTAlnXhQ7wvSctUdE0Cj2yzID+3yXB+Vb5nd8ZkBXXnWqDT4LvNGWcAkbKuMQxViiFoly2Xdx7OZl4LRIAXW5SMFQY9RoBy37J/DKTUmSTUOjaN8wCKbnY6r9vSMbb+lfe9OjN2ex0BDxJFc4sx0t2PsornQ5tRNHGOdhchikfGvLz6vRRAVkpz8E8XlD5WUJdo63Zp8fLjjM02D1MYptZOzpejSO+hVWnQ9bE+VhSLc0kRnn3CTYIWYV/npdOJ42n0hF678WpG+9z+hxcRCFBrqsRZzodpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlX9hOwXPecOWSSZ5NuAYbofkDvqnDDxm3aAiF6GZPU=;
 b=mFAAGOghHZY4QIVRf9BGYq2wq6SVNYW+bf5jo8FcpWX1k0eETUP0KSw5m4IDuPC/kesdyrSIrLHqaxMg3qq6Da8wXljVhsNhUWFfcnWYAZ4MzeJfW9FaA0OrxsutJUWYkcO9pfv0Cit2gBos36100lCbn/jNhyDh5pWJhkFsEvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR0202MB2920.eurprd02.prod.outlook.com (2603:10a6:4:ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Sun, 2 Jan
 2022 22:38:48 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745%4]) with mapi id 15.20.4844.016; Sun, 2 Jan 2022
 22:38:48 +0000
Message-ID: <9f501a7c-47b4-783a-5519-75440fe488b0@axentia.se>
Date:   Sun, 2 Jan 2022 23:38:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: sv-SE
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH 5/6] mux: fix grammar, missing "is".
Organization: Axentia Technologies AB
Cc:     Aswath Govindraju <a-govindraju@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <94ab71e1-2e68-def2-95b8-33162172f65c@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0083.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::11) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14684e0a-753a-4762-d744-08d9ce40a42c
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2920:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0202MB29206D3989F0A421C844C446BC489@DB6PR0202MB2920.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mJxY1uJFMNQhdXASRayqfNEiAPKLb//hi3oFpA1aA3OrhdS3WCx5q13yi9nBTVRA5v0cYD3uyt4lBtcUqnnhaGoiX/v2DTC4jb3TZQ9txZ6xWPP6dk1EaZ/LHxOW8HDXScSdc7SBH3JL7ubr/LHjrM7mZYO11PXE3WeLBcEnz2BshHh/DR4HvMK4xWtXab/taoxV09xRpqWsBBW0reS5/Z68r1r7rZpv9QvSimaPBVBpwphIuZ4zEbCj+SBdHoRP/6v+Bg5Rsb4Kbj/KsXkY3XlNNjLF9BySDfUbwLCAHB0hHEuryxTdIH1uda2R0U9t3eTBgc9g3KIkcZynDT3UsZSKqoTJTogP79uR2I3tBOMV19O5dIeiYofNK09ZZz4opl+VWHlysP7a9/VTz/DG7Bni+L8+5TQlobo0iivIn3+d/oFdzN3TfJNPkHQl4jyU6jgHI7riW9QOxGe+ArEdLmOX6veApDNZhFeu/y+NDNpp02fv//yMYNkhP3KcSfP99J+Cw2FaVUS4snPWD/uM1RlpHWQpDgRTXbekguCcyLRTM802mvNKoI+94Ol4frH+7jJR7Rq6VXvU1LoDDWMjwf7WA2URiLuj0au2mZTbQLgGK4/2XCdYKcLny6ECjdxulaH+rQcv202vupqfE59H6fIqYrwf+NHi7LVRXtAJd3jFwlWcbjn5At48wL/AD+Ha+enhfL15qntlGKK6pd99RU1Ql3IoeceHmjouzDdMfe0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39830400003)(136003)(376002)(396003)(38100700002)(508600001)(4326008)(36916002)(31696002)(54906003)(2906002)(83380400001)(2616005)(66946007)(316002)(5660300002)(8676002)(66476007)(66556008)(4744005)(6916009)(6666004)(86362001)(36756003)(6506007)(26005)(6486002)(8936002)(31686004)(6512007)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2J0QVEwVS9rd2N4VndaSTgwVnZrOGQ2aVRQb3BERFBBdXFiL2FUWnJkRkRa?=
 =?utf-8?B?UjM1S25rMlJibXZ3SXFPcnVwYjVLdGhUT0oxYnJqQXkxQUNmZ2xKeXNrb1NM?=
 =?utf-8?B?RURURCtZVXJDSTdEbXoxWnpqUlUyWW5GOUQvYmtjV1Y2V29DMkc2MTNtVEc5?=
 =?utf-8?B?N3dBdVZDQmdROHVHTTdBY1lDN0QyUFRrRHQ1WThOMkVlbjUrenN0c0xaK0ha?=
 =?utf-8?B?dDNPR2lCWnhTeVFGNlBtRjhzci9nNHJFZUg0dU1BOTB4TWNsc1lpNHg2Nzgx?=
 =?utf-8?B?WDZZZU5qZERGMjdIVG1KK2RTcUlhQXVRUmVub011b3dsUXU1Wm9jeExyMlBx?=
 =?utf-8?B?MFV3WFNycDNwbUtaZXRoUEFISDBjdER1TzVLMGIrcnhva2VMZDhkcUMxcXVo?=
 =?utf-8?B?dno0RnhlT2lHM0h3NnFFcEF4d01tSVFsUmgzRjd2UzNhODlDRlBPQmRsRUJx?=
 =?utf-8?B?dE44R2FhVG1JN1N1bmlnZ2NScXAzZXNBWnZSbjdpWTNUMFVYNHdGWmtkYzBK?=
 =?utf-8?B?dU9HQVZyMng4ZVVXUXpZeTE3a1RaQjVuOHMzU0phUlpyTjB5L1ZHQ0pvMnQr?=
 =?utf-8?B?TjloRnV3N0E1c2VQY1RzSDNFNWVlTTRsSjY5SGZURFRLNjlTTkhEMWtNU0NB?=
 =?utf-8?B?bGJiNzZSTExzdm02Q0pHZjEyNXdWMGVzYkY0UElHcUdCdXl4K01ranJ5K2lm?=
 =?utf-8?B?UU04STlYaEJ6c3pxd25EOEJLNEtZckVndjdpT3d0b0U4cUo1TlYwaG5OTDBa?=
 =?utf-8?B?cE9MajZsTE5ObldIQkZsTThhZVV4ZjByZjVyR2FUOXRvbXQ3K2FrRkV1ZjRi?=
 =?utf-8?B?UmNFeVp0Z3FScXJVZ3hkcWt6N3R5a3YzVUFkTFM1MEpVcDgwTFk1TVJqMG9P?=
 =?utf-8?B?NGU4MTFkaUtKWXlSOU5EajB5c0szNlhWQVRDVTFkVUZVbG9hYjlCM3VaZDVM?=
 =?utf-8?B?MEZDTWV4N1JLRm94Yk0xTmhsQnd1SzJORHFGMzc2bTJkT21UZkF3S0Nhb3FN?=
 =?utf-8?B?ZnpWZkc4QXFHWU4xTUQwV1ZORUw1UXRKQUxPZXVqaDFXdlVoY3RkUFR1TXhQ?=
 =?utf-8?B?aEN5UVVqL0xLbzlWWjdjVFhKam9tcDdSMEc0REtZOVQ3MUorZjhRSlE1Nllw?=
 =?utf-8?B?Y2Y3UzAxNEkzTzhFY0hYWUFLcmtrVVB4SC9kY1BhMFB3K3RyWmRTdHhVRUw0?=
 =?utf-8?B?N2RsVnFmeTBReW1hWS94cDgweVNQcmdacU9iaEczZGgzZ0svTVFZaGhMNFV0?=
 =?utf-8?B?b054bCszb2ltYVVkRXdaclQreFAzWTJjWkRGNkdJdUFzOGZVSjg2RnJwSVFp?=
 =?utf-8?B?d3BpZXN4L3djWGs0d1JyY3p0dHRYK3JjaVFCZUszak9xeGZwaExzeUJwYTgz?=
 =?utf-8?B?Q1NodE5mYVZvQmNNdmxaRzNBK2hmNGduYll5SmVHTENGanJPdit4NlA1MG9R?=
 =?utf-8?B?UEVWeGtBOUF6YmNyaTdtTWxCYjBEREZpRXJQWDJ2QWpxSTJJdEdMcUpLMUtn?=
 =?utf-8?B?V0Q4a2lUN1NRZldqRy93VjB0VGlMVnFYcGxFVDRITUQxQjdDY0RqRlhyZk1i?=
 =?utf-8?B?K2V4U3ZIVUZhbzFSZTU3MTgyRmx0MTNzLzBsRGZpZWdjNzRwTCtJdnNkTml5?=
 =?utf-8?B?NkxqMndWbnplaDA3NHgwc3JINlpDQndXblVGQnI1ZlFKUEpIb0FqT3diZnB6?=
 =?utf-8?B?SXRaZDhBTzBuUmUzUU9JYUhWRzRsMnkwUzlnN3FZRGZuSWE2QjRObG1vYlpT?=
 =?utf-8?B?dEpEWjhjY1Jsb0VKRTI5R0RSTm0zR3ZOQ1M1T0JxMmNNMWdYWCtnTS9NeS9m?=
 =?utf-8?B?Wmg1dmQ2RjRsWVdsd1BpQTNWVmJ0cm9JUGNwOE1JODBnT0RyNHcyY0pFbGNH?=
 =?utf-8?B?VWo1bnVGeFc2K1hCWkJReWNkdER1cnV2QUxBTXFyLzFPbFR2aktUZDg2LzFh?=
 =?utf-8?B?WFJrT2RjeStGTzA4L3EwdU9xZmtpOEU4SjF6UURTS04vM2dYK3hHTjVOVUtD?=
 =?utf-8?B?cERsYUN2aUZIc3kvVmo3dVlwNUVHblY1dU9lT1hGUVRaY2JJdnh1b3lUdkxu?=
 =?utf-8?B?ZloyaDEvSFg5ZXhBbnEzSnNKQjgvTHMwalVsbzJMa3pwSm5iUUVvQktRaUp0?=
 =?utf-8?Q?PuDU=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 14684e0a-753a-4762-d744-08d9ce40a42c
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2022 22:38:48.0391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQs4rjr88fejiPVubpfjSOr62oYylL/+zjCLVOo/X1vulYMO6Z7I2LjYpKSP3Kvl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2920
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/mux/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mux/core.c b/drivers/mux/core.c
index 90073ce01539..fc339b0064e9 100644
--- a/drivers/mux/core.c
+++ b/drivers/mux/core.c
@@ -416,7 +416,7 @@ EXPORT_SYMBOL_GPL(mux_state_select_delay);
  * @delay_us: The time to delay (in microseconds) if the mux state is changed.
  *
  * On successfully selecting the mux-control state, it will be locked until
- * mux_control_deselect() called.
+ * mux_control_deselect() is called.
  *
  * Therefore, make sure to call mux_control_deselect() when the operation is
  * complete and the mux-control is free for others to use, but do not call
-- 
2.20.1


