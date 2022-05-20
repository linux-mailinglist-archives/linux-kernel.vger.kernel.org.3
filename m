Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12A252EBA4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349056AbiETMLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349031AbiETML3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:11:29 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2061.outbound.protection.outlook.com [40.92.53.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB1F5A165;
        Fri, 20 May 2022 05:11:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWKsjn/We235+mpQ6tjLegx0/N7ey5OZdqL+0VdJifzzZDZ4ZNz75j5+1jwQlW5KrYFSuk8iOMYcFm0e2xTZGsZcLh3+rssXbUbQi4UsIzEQEyqJolcMHu7r3NkHsynuY3//993fA0USIXjIP3SaTJKB0dI7M5hTLtDAgK03TR2PZ6NeSh5mDgcsbjScKJMysat+fI4fj69OcwmUmrmvKCTe4FtkhZlcu8BRzxd1baWfqwt1WyTJjPubBnZHMsK259zacb0eONkdYgU73SivvZbziABXk+2QiSDOo5T8K+V7tSv/Urtv9VQFntaken+rrAWY6mTeii5CUindg54bkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NN9QdxiUtB9A3U61kYVT8XrrmhHpTh0o2HDMn0oAOOM=;
 b=WD7IaVNd1diRdkHD9ZvYgHJXVjXqgiHWZBL1NSurMs3TQL+te86RAM0pwBrsW5S0gQHnb/OuE1sXDOQO2TAd1oM79VzBvj6mnTx+SDUIBii52nvA3cQIf2hKkNm0DjA1Sy1w/H2h9XxBGqVnrKqTHC37lhurBiSBLEdyENd6XCzSe1C6gFElHddQ8zw7c9foI5hMdT4XWqDkMd20XRm99q/I9Omq2zwtUtIDxXo1hzbSsswwV/OV9CkAoA8yDRdA4MXPoTXhfU+tVd56x8KhyDpFDflp1pHsgAI8b7axdVQIkWUMEM2LVo4LvSz7LDY4IxSx5N2eVkZPc2IQGb/Djw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NN9QdxiUtB9A3U61kYVT8XrrmhHpTh0o2HDMn0oAOOM=;
 b=SkOcYSlKzUG1SulnKBBURrrDFz0w1IyilVbvFsnGrO2913XtgjDycPwb+XnKgo7utTqbUlc9s1Z6K0wV4RjNXsL0FXoo/zL0mNmiJZQ6TubZXKFllT7Hq12/+NTA4MU5UWFm2p2itsOhh5OuKIePQmAaY9I7m9byqULQlwNdOQdzvdehjsW4ffw3+YFJlSZtEqRQ2n9wbJtYNc5xLplI/JerwqQ3TEbj9sc34IRr2jNlR5YTBitDkl9Nt5lGXWtwAvkcQucLrJD0n5Sv32Rbgxm3UQ5FlCTzd9fTZXpHPEHu3yKSnGycitPFfhDQWnMlqm0haiYjnAiyvFSz37/NPw==
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22) by PU1PR01MB2092.apcprd01.prod.exchangelabs.com
 (2603:1096:803:1a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Fri, 20 May
 2022 12:11:23 +0000
Received: from HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::3022:ac4d:5d89:8c7c]) by HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 ([fe80::3022:ac4d:5d89:8c7c%5]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 12:11:23 +0000
From:   Kushagra Verma <kushagra765@outlook.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] usb: dwc3: Fix a repeated word checkpatch warning
Date:   Fri, 20 May 2022 17:40:46 +0530
Message-ID: <HK0PR01MB2801996E815208393170010FF8D39@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220520121047.21026-1-kushagra765@outlook.com>
References: <20220520121047.21026-1-kushagra765@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [C4HjeZCQvTLvRY8PEeCIS/yQ3arJJyFdJvrqq4qTzX99dWw0uCVURzVIo/HD8Odd]
X-ClientProxiedBy: BM1PR0101CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::12) To HK0PR01MB2801.apcprd01.prod.exchangelabs.com
 (2603:1096:203:95::22)
X-Microsoft-Original-Message-ID: <20220520121047.21026-3-kushagra765@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f24f806-c289-42f3-e2ab-08da3a59db05
X-MS-TrafficTypeDiagnostic: PU1PR01MB2092:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mRoWB/YxK9QbIQFCz9I2g1A2pceudsm9ja8/UAebMisE5SZl5BRcMY4PEqisZyL8o/GrY0Fqqa0hgHhDdbYXj5QWQZfT07rFR8sjiuEEiVcPjtGBMT1T/18Zj+Wk9RcnoYhMWvcRSbNJsFrDmwjwQpCGs+RmnWyN2IRes7JVqTW4SvZPLBF617trwu05hti2iD4qDoaNGgEbEpAXP+BUlUm7UQiPwI7377imGtUAG7zo7FJlAwF9q6ZRq/jerSYy0/Sg7ufY0koXW+pxK3UhD+1zK2CyE1sDG+KVIysYVYCd8VtEQoOkMT2mA4vSj5PcTIprtqZA955esnPuvdwcH+I2XNuTjbZ9yS+ICGZsgOcdeJ8prhtgMXt7eNDLcTzVUdzjCIveQgHxdFLjvlrjT0LmuVKXOQcrg9bxdVILq+3mIVLvWzuf8Q8x+5xM/t+LfFZV0Vn5h4I+PSTx4sLHn7kCfMhezLrbq2EmsTPVuEnof87FihpTAXhH6+DhDrcZwcv5ndd/BOmDRTg5ZtNMgo8H2oG0k7TTTNq59dDggrrLyHrSstCKI8NbgD/cA6l7V8cDSWztDdZKGgDP/sz5Jw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2lcSmi81HaRfOtVdsJZFlqR++OcFEsyj7AkyFE9YYZ6G6zqb1xvY3jEpqUgl?=
 =?us-ascii?Q?Zdm+j1Tp2WAXUdB4yNqBA4BDeL395pfX/VjGsE4HlCG9X6b3muWhwxq3Wouz?=
 =?us-ascii?Q?1OLcbbldo5SxUZBr4ti3SmgkZEMVd8fPLO4Ra8vMZBV2pQlQDqXSaTf4fEB+?=
 =?us-ascii?Q?kBajoADbu+FN7Mt+byA2iP1CzOAczBOnuQJTDuExhSj7Nkjt07Lmxx0e1mH8?=
 =?us-ascii?Q?DX69ZaieOBhFPkkF71WM3aQdVbDjd37jKHbKz5er1agC0FYX9m9VmvoPDB+L?=
 =?us-ascii?Q?Pc99FGA2rrnB3Qmve9KLytZenSBFHMWYN/zLpS1T6y1la2fM306WTNj+4gvL?=
 =?us-ascii?Q?PH4OZMpp0Xc1SmCS8CrbirIv+ySFS50UO1wGjGvbb131YYexfV5x8eacy+Ad?=
 =?us-ascii?Q?jqqWZHULcv0lo2oJd/dOWFh//2Qgb9RGhifH3t3B29N78NH0VrjXj79g80s3?=
 =?us-ascii?Q?ka67KN74SJ9o9zSAaJ8A3TyABc456qUKLQcHIvvB5hAPYV9EHF7hc/tplixj?=
 =?us-ascii?Q?vrmEwnqs22USBW9nnh+lUHjjNdCUzwwPrWKtmVM4htZvx+jh2mpxZ7Gv7d3D?=
 =?us-ascii?Q?/sRNuHjg4cn1rBtp6ZgL4qyN6eTpshH5npC6oWKGRkO5NzcpC+x5D703VSo0?=
 =?us-ascii?Q?BHfni74E8YIkEIORnGqlMy0Rddb/7fHsKJoazYpKnObmvEYEsItD6uwqSuyw?=
 =?us-ascii?Q?8ihW8tPxCGko1j7phhkIRTiDbUkMkpkNGnMMA9CP1WyNZA7Y7uaspqE5bI5x?=
 =?us-ascii?Q?gN25Usit1MQohGmQ2NKFyYoiEPOmzsrfQKu12Fq012vNNa7DC1lgr5L9YQIP?=
 =?us-ascii?Q?VFlBVuAOn1nKOFyaXNDoZ7L1zPQv2sIa/7zhkFUjrqiCB5L7XKTy05z4gjIX?=
 =?us-ascii?Q?3FmyFOzXH0hCGoq8opiwY1zMIrouPXC5Cgnm0FNcdqTV1CJbjZ39kNkeqkka?=
 =?us-ascii?Q?jaS+R4a4kZukqp4K1Tz9QAowUz74wPeqMDKQR6Uiv/PEDHtnVbjHasI6zk9p?=
 =?us-ascii?Q?cz60hMTdZYiut8BjBE7StO7dVR313NGFUNDqBFYqlKGEek8H9Gxzkgu9AuLH?=
 =?us-ascii?Q?nnYsvg8vrzqMWKfm5v0c4DkSf9/SnMMA8CelpXqq//QXAzbqr0MQVEywrhwI?=
 =?us-ascii?Q?hTttSTSqfkox6AeWE97WVCH3zoBOVHFhc9rjttV0QoucrQ356zyBd2ikquX8?=
 =?us-ascii?Q?rAKBcGhESDuUO6HFBL1SXhNCMLXChGpAXKl6D5iab0UfVOzOpZwefVU71/ko?=
 =?us-ascii?Q?/4tY6CNXfSRIqEo5fA8Ft6lE3+dJ/vKmeeE9VnOtE3/5hMAgtwHzLGYqFYGS?=
 =?us-ascii?Q?JtH8Ei0BgMan1niuOLG7yDjWs2OzDe6Kbs3u1EPnjks8vN+m30d+nOXNOZ9u?=
 =?us-ascii?Q?o52Lx85jK3u2r/HMMv+Ez62GG11ZNXyn/uKPxtx7C54fd/IjVrhESH7DXmY8?=
 =?us-ascii?Q?q44sCSCBl5vMQLTCJ1EHmkT6QHHvczDw+gbAewLaMmLaS5oYnFaZkEy9fBQS?=
 =?us-ascii?Q?NqxMudcINW406dgo92c+Si93QaRskM+0Pjzd?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f24f806-c289-42f3-e2ab-08da3a59db05
X-MS-Exchange-CrossTenant-AuthSource: HK0PR01MB2801.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 12:11:23.0567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1PR01MB2092
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes a repeated word checkpatch warning in ep0.c by removing the repeated
'only' word.

Signed-off-by: Kushagra Verma <kushagra765@outlook.com>
---
 drivers/usb/dwc3/ep0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 5d642660fd15..2a510e84eef4 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -473,7 +473,7 @@ static int dwc3_ep0_handle_device(struct dwc3 *dwc,
 	case USB_DEVICE_REMOTE_WAKEUP:
 		break;
 	/*
-	 * 9.4.1 says only only for SS, in AddressState only for
+	 * 9.4.1 says only for SS, in AddressState only for
 	 * default control pipe
 	 */
 	case USB_DEVICE_U1_ENABLE:
-- 
2.36.1

