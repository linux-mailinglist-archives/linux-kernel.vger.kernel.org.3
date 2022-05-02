Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBF4516D15
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 11:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383818AbiEBJLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 05:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384185AbiEBJLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 05:11:24 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2029.outbound.protection.outlook.com [40.92.52.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24CA5A088;
        Mon,  2 May 2022 02:07:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKiEo55vDBMemvZU0ulG64jfWbSGsDdfflYetJ/EAwxBmMd8G9Nml5Uxlenckjte/bBZDBu5CBWW5l4ZITRob1Zt7fcNt1LT82MHkpu0NTrjaGMGvZq5pkvkE7Oa8x69RXDQy9gtYIeq4wBXw+9bvyNQ6c0R8jh4J97z73FwVkXMPSPX7b4kXclxKOGU1VkTkDts5MEEKnw2qy180rwyCR9yXNfA26Hu++MC5AbpjpX7/qqxxm5Wb/FnFXj9Ufdx1srJ4KrgeBp9VXITk8Xw87oBl0I96betsAmxyDiKsdngJWxwoKgLpZXQ3lKH4zl+1ZhOyGoUlbaZ9PIHu8FGPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEJQeWOx7H6YnhE7sB2cOl+TwxIJdTRy8biMrlznbfI=;
 b=GRYZPti0GjHjLMvAGFBHx1rADd0iHIeK/dPJULVrBR6xwgHzMeGXNCgW/Qfdd/5k3TFYuaD4In4plDKW1PiQoTbaAq6nX2wOLzCA+4Fu9EyGNc1qRm59QI8pNNCHlz1EI3UUu618PiGQTA1o5l9xmC9KZp1rWVL5iBhC+HdEzmvCME78K3nhx9EpsYiof+VFD2uuF2HPIvOqry0a4UFk8eQViVxgj/z9UHDe8Ykn31vwxkQStp77yqDQWmyDap4oIE3z+bU92wTBjf36AvFVJhfIYiVrJzIoYR1Fan0+IOQTJsyqprKsyKWSojaKHQ3ZtAtp+jMBTcup9ncFruw4/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEJQeWOx7H6YnhE7sB2cOl+TwxIJdTRy8biMrlznbfI=;
 b=lYJEC7wWmsIocWQi96gMc9fr15u8kN0kdvQwlXkeHNsjXvvGIcA+Ag6OC45tZuaLaouG/YtBU+BHhAaDCDxTPr7escdeb/UseorsWmQ9ztdt1SVd9GU5zPKQXcy0s6u82Fc3u2o/JSZ4QG8QQXEACy7r63VoZmteAHViv/2M9EvessbbQMPwwhSNLIsCZyXxr+XrguWepUVAEpP3J0drjnRcLlYxQfet12ZpJ3ryB3aXCdSuxIyXbtX8zOfttsble+mozHFAJ4uL03dUE/5CWBIVqlpluxIZZYkL+PbSMMnTE6YuC3VaXyE9wKnjJ6PqsMadBme0axls3xytaAVkEw==
Received: from SI2PR01MB3929.apcprd01.prod.exchangelabs.com
 (2603:1096:4:106::5) by TY0PR0101MB4468.apcprd01.prod.exchangelabs.com
 (2603:1096:400:21c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Mon, 2 May
 2022 09:07:20 +0000
Received: from SI2PR01MB3929.apcprd01.prod.exchangelabs.com
 ([fe80::441b:82dd:2ef1:8c3a]) by SI2PR01MB3929.apcprd01.prod.exchangelabs.com
 ([fe80::441b:82dd:2ef1:8c3a%5]) with mapi id 15.20.5206.024; Mon, 2 May 2022
 09:07:20 +0000
Message-ID: <SI2PR01MB392926A7AFB821410770D7CFF8C19@SI2PR01MB3929.apcprd01.prod.exchangelabs.com>
Subject: [PATCH] USB / dwc3: remove a possible unnecessary 'out of memory'
 message
From:   Kushagra Verma <kushagra765@outlook.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 02 May 2022 14:37:14 +0530
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
Content-Transfer-Encoding: 7bit
X-TMN:  [r3M3L+xDtjbc5ZSuQYysv/CThY1U0HvxoJUXODnXPJ++81TvYqIOR22uFR0fjf1WbwAmLJnwBIY=]
X-ClientProxiedBy: BMXPR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::32) To SI2PR01MB3929.apcprd01.prod.exchangelabs.com
 (2603:1096:4:106::5)
X-Microsoft-Original-Message-ID: <8c129f50aeaf996c64edd99516d961032e75a3d3.camel@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 051ccc04-f09a-4dc7-0562-08da2c1b2999
X-MS-TrafficTypeDiagnostic: TY0PR0101MB4468:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OeOYfgnaVGTceskXQLFE8aF7Z3dDHZc2LiSu4AcUR3K5lPyfiJkGFzCHyQEyhTlp0yTEcMz12bs58tcTWZjjSu5gcXaLEjtJ0pslY3xR+5YN9Hs4yimlKCia/9uT7XoFqq7n6FyGDMnaFHGXkSNNcYjqNRJIHB57qqikBThSK/apyUVt5cs1gevu+9krBksWAPvYzxrG9cMkybQ8j7g9eTxXLF+BVx1PtrnoUjIlAIQGQ+aSO8F6d4kEy3ecC9rS6g83Q0sdIEuepUCFbEKmL1CMHj+/7Pddp21MEHZR5I692Cq2YL/297qPjly4hU3x3kTATa8OLzzymnh8AtlhMQ7RiRmj7vDg8wHoFwLsuDvh6MlO5iOJAM9LLCP2tQFUOhG09l02jZCBRQyn7X17mwbgksP5gDj8GAotcPDe9c46sSD0rS6JQESFT6e7CD62S62DpcyHm3lxkotItjxFRbAozO5yWXhKQ4tII2mg9/WVBC42bpd9GWGkK3NBqJd6UPhqKqI8ZRkPSQQbiVTCbx/9O4ACZQ/JaCYV1GJWgEWZB4rI238OXRPA8jIBFrZbZTR5KRbhUGSMeLBGj3cDew==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3hpbzRieCszWDFHZ0ZhUkE2ZSsxNjZwdlJpRksvbGZQZFliOXRjOHNkemJp?=
 =?utf-8?B?L1RncTdZZTB4V3pYb203dUwvNHUzdnQ3T0FvQmVvOCtCenRra1dNd3E4bTY4?=
 =?utf-8?B?b0JFQXZ6TWpxZjhhYWJTTUdzR3hJcHV5a0hZTHBKSTZXRERmRUxPSko3MGpP?=
 =?utf-8?B?a2t2WWtIVm1QU1c2dFdqcmxzTjJTY1BEZzEyVE1WMFRJZTcxMjJrcjJTWGsz?=
 =?utf-8?B?WUwyeW5uM3RTdVd6OGZlRmlDMnhKZkk5WXRaZTJxRkN0N3pzRDIxV0MxTk9l?=
 =?utf-8?B?UUhZV2oyRFF5bUt3Wjk0VVNyNHd3QjFtOWtYdklUVmNWUUNTVlRNeVUwekVI?=
 =?utf-8?B?QlhwY3JEamZTQ3U2VUJ0bFRaMGdGWUg5ejZFWWN3R2pUKzFNWTZoN3B5UmNF?=
 =?utf-8?B?R2lNVWcvbGxOczNoSzA5RFlOSHJnVGhzNEM0VGFhMmMrTzFwN21mT3RWLzYz?=
 =?utf-8?B?LzFwN1lHVTJodGpzRFgvcmtnZ1UzOFFHeE5uWk9RTlJCYjhYNm1BeEFqaGlv?=
 =?utf-8?B?cVM4eEJjbWxGZVpxQTBFUTVmSkZ4YkdzaENiZlJQTHQrZk1xTGVRUEUzQ2Ns?=
 =?utf-8?B?Q0EyM3J3eUlUb1dkdTk1OGZ6Y2FwVGZMOWluUjZNQTBPQkpRUDRnbmNYc2wz?=
 =?utf-8?B?VmdwVTFSNkNoQmtPZFd6UFU3Uk9qcmhZWng2ZFVLSHhiU0pvNUpWZWV5eVZ1?=
 =?utf-8?B?VDJrQVRPQXRPL0VxZjJTYWtFUHJlSElGRUNDMWFLYlJSSHgzSGc2SjliM0l6?=
 =?utf-8?B?MkF5Qmp2QWFReEJYd2RySzV4YmFxVHlsQW9UdExnNDlFT29jaDEvZTl1Z1lw?=
 =?utf-8?B?V1hieVpkT0hhK2wxMHRGMEZmM1l5MXV2bFlVeVRabEdEdi9DRTc1cFFmbWFv?=
 =?utf-8?B?cVBweDgybW5nU25HUnJwZWhBQW1jNEhJeXJaV2JqK243Q0RZdHRwclBWY1FG?=
 =?utf-8?B?Um4rVldMbWZ2TTJ3ZTVsV2ZaajU3VFUrMXNZQWlBM0pWQi9nNVU2blUwbWJS?=
 =?utf-8?B?eU43K0R2dlR6TW8zczlPa2h1OElNZFp5OG40S3l2T1EvbWZDTkE2aG9xUGNR?=
 =?utf-8?B?V2VsWTBIRzRCL3dYVHJVMjlYcGVXa0d6M2NFa3o4T29mbDVpNS9MclVXaDkv?=
 =?utf-8?B?bjNCQ0FDdlNjYmpYcmZ1NlVtbVFsZlVCalFWVWdJN0IrZXYvWXdZTi9STHFQ?=
 =?utf-8?B?c2hYNFQ5QVc2bzNlSUlPbmswZlhCN0Vud3pBUVh0MDJJdzluR2ZjdUpCT1RU?=
 =?utf-8?B?TE5Ndy9FLzd4UHlIVHBaOUxSeklXVjdEQ2VmenVPSm83dVUySW1wOEFIR25i?=
 =?utf-8?B?dWVXUVVnQWFvcHdNeEZPYVpXcU03QVhiNjZiaUtzS1VZSVZWencxbkVSaXV0?=
 =?utf-8?B?d0RpT0FORldxajhhZGdxcm1Yb3FxN3F4ZTJIaHczTkNoN0w1Yk9VdERwekZv?=
 =?utf-8?B?TVdwY2VSbGZzUTZiQWcvV0lrSW1kdEp0ZFNnaTlWU3Rta21JTDZ5QW9Nd2NH?=
 =?utf-8?B?Skdrdk9tQ3JKNnA1ZTJQOVFwK2RteUlMSXBsbGM5OGxVdHhjMzBGRUxqcnRD?=
 =?utf-8?B?TlVkY0N0UklTOUQ1dFhSNVJMcDdWS3pnZVlWVDlPT2Q1U25CWGt0MlVWUFh2?=
 =?utf-8?B?elkvSm9CUFFwNnAyTHhpK1pEUjZvdHFEVEwxNXdhakM1S0FpVlRRL1pOVjd6?=
 =?utf-8?B?cTlRUnlWSk1zVVlNVVBDa2Y5MFFJK3FVN1BtTmg5YzVxcWkwTlovM0Z6dWJX?=
 =?utf-8?B?UEVpZFBmN3ZDM2hzV1dmRDVxdjlnL0RMNCszUjVtOVJyWDJLS3U2NE8xREll?=
 =?utf-8?B?aHZYbDl0SkpjbzN1OEVLUzQyNlIwakFCY0VCSzkzUDFEemg0VllEMnVUYVp0?=
 =?utf-8?B?SUpBak9aajhMb0FmVER0czMvdFRWRjFJM0twa3h5ajJjTzVNTDh2VGs5QnhC?=
 =?utf-8?B?Q3oyVU9reldRbWY2YU50ODMwS2R2U2pTdlRXcUlNOVcvUFVMSHk2RVR1Ukpt?=
 =?utf-8?B?YzNVREFRNnFpUDJ5czRIYVROK3BZMFAxSU52SDRZWWZlQ1FLSEN3OTN4WlQy?=
 =?utf-8?Q?/42zSF?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 051ccc04-f09a-4dc7-0562-08da2c1b2999
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB3929.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 09:07:20.1385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR0101MB4468
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes a possible unnecessary out of memory message from
core.c as reported by checkpatch.pl:
   WARNING: Possible unnecessary 'out of memory' message

Signed-off-by: Kushagra Verma <kushagra765@outlook.com>
---
 drivers/usb/dwc3/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 25c686a752b0..4ee787de2956 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -844,10 +844,8 @@ static void dwc3_set_incr_burst_type(struct dwc3 *dwc)
 		return;
 
 	vals = kcalloc(ntype, sizeof(u32), GFP_KERNEL);
-	if (!vals) {
-		dev_err(dev, "Error to get memory\n");
+	if (!vals)
 		return;
-	}
 
 	/* Get INCR burst type, and parse it */
 	ret = device_property_read_u32_array(dev,
-- 
2.32.0



