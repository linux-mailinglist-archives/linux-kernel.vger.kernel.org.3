Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374E24F7C54
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 12:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244096AbiDGKHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 06:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236536AbiDGKHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 06:07:21 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2127.outbound.protection.outlook.com [40.107.215.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E0A6D4E7;
        Thu,  7 Apr 2022 03:05:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNGCbNWgeIatCM6UgJGMcPxiWVnWxi8x3yCjTKJoQC/xe8OK2cdjBNe0ze98pEU6X1miADl6RMUJ57oNDBhUHww1lC3gDAzl3sMa3C8tB2NITLc7/hhY1o9ex1AAtbvHiFeVNGkA1GBdH7pzFnwuSu/EDi4OLuIreG2EC8/HujBQxutYdC9A3TzOE0KXUooFVvK6ZSz7NQTK4V6RSgnisWQTYiKml1CtnD4/ymd4qVkadOcQytZM6PNHT+VV87qxqd2Uwo+37oUFYP31xHuHOWivO1oItyRHLN2JE74TxZEbsKdDulGyZXKrAZIvIKnh1ycJ+SFMSf0AwT/MPkd7UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZeszF2QANFCSqCoPN3KfdHFDuGAAVgUHz06A/VxFGY=;
 b=oJtG9le9ZLNI1CxRXdjDL+mKhJVjvg182zit+w9J2SB9eomB62lPhIRm1Vgt2lqII+CCV+MzfHH4UAAL+Y5NuP2hEUrRWO5QcOQup9MUYuMymx9f0zRkapNxXNiWnWKGDtkr7Tt8zeH176DPsKXmG0rZldSCoyn4cHRwfsGiabaBtjZj7Ttkxpt/P8R472aG//MEg7vqrbqGRM4+mRnWBG/GZp+gYQBfdyv84kLde8bmYxGw6ZVbGPJCzKdBVWYAsHf0v4xKEVF/3LPtm3aeKORY1Iog+4OlGyybDqWl7xDS9J40xXqPlf0U+3O4UXHH2OMAGHIeNtW2rTLbqLncHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZeszF2QANFCSqCoPN3KfdHFDuGAAVgUHz06A/VxFGY=;
 b=dmLs/BOG5dR50Yc88eaMfcsoU8xYPiIP9HKXGvTBYov8OXDPWW039SRKT9y3jP2ksI1u53z9Q9fSCgKa5PHrK7nIWAxuKtBd29VcgkHzlB48Otj7ox/9Ewovmpcl55j5uc1kJYq9pynE6r1nr6yFj+hm9dx8OP58AKioojspD9Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PS2PR06MB3493.apcprd06.prod.outlook.com (2603:1096:300:63::20)
 by TYAPR06MB2400.apcprd06.prod.outlook.com (2603:1096:404:17::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 10:05:14 +0000
Received: from PS2PR06MB3493.apcprd06.prod.outlook.com
 ([fe80::98bc:c4d6:61e2:f84]) by PS2PR06MB3493.apcprd06.prod.outlook.com
 ([fe80::98bc:c4d6:61e2:f84%5]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 10:05:14 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Colin Ian King <colin.king@intel.com>,
        linux-usb@vger.kernel.org (open list:USB GADGET/PERIPHERAL SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     zhengkui_guo@outlook.com
Subject: [PATCH] usb: gadget: net2280: use swap() instead of open coding it
Date:   Thu,  7 Apr 2022 18:04:52 +0800
Message-Id: <20220407100459.3605-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0065.apcprd04.prod.outlook.com
 (2603:1096:202:14::33) To PS2PR06MB3493.apcprd06.prod.outlook.com
 (2603:1096:300:63::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 479d4c59-ec20-4cdd-f311-08da187e1be0
X-MS-TrafficTypeDiagnostic: TYAPR06MB2400:EE_
X-Microsoft-Antispam-PRVS: <TYAPR06MB24004863375C2C986B160C94C7E69@TYAPR06MB2400.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 30fjpkUbGI7N/ZEk69OzPyBNEvbt58vaM8z47B6speaSGMSWCUFfW/u3fTR4TU7xnTdFwsUpU1I+r0L/hLvX4YbiHSAWTtJtJSN2idXO7U2n9WdwkxtjQZcDgIdCu6ZTM1/wPx6CmnEnqt1fRQremoctKi43ftKaje6y8SGvdaoyLm24BwmiMWGSTnZoVhN3bHIvW1SK0dRH9hl5oiLRXjvKvw6xV70XtYVWz48io4bPL42cByGNuxCErwa+kk2rdaiY5GnmvS8R2gxv6llwQzkv+uogmKfRK6sDwz6noqOfVLHez0SORtDQ/uK+ghuRdVlx4xBgMAA+z5MM8mc7MJDOhm5E9t7uLGPEFqDQzU+XRUsV1Z4EgzgUx1h2hcu5u8U9Tp7v5FN6Lsh9g9dyILz48YwmZ2S82/WURPZvaHbKipJOn1dWCrgd8DZwFHfuPdXkO9Jh3N8+w/OOkLKin0am0r2T8gtJvRVWtjfdmDnwD+52/raBLbw3kpkEV3MpR05qutmlzg2e6S8ZGbYy+VcYHU5HU/Sgljcqi87eLnx3VMn8dKOniFanCShmNpUsQbaFeFlwXqtoIifyzPk+JWGdQJyaSl4iYveluzHNOb4H+Vmg36idEBTrchPw4srRc4Blf7lLnAM1cxpQg4y0WAP68k1Qc4uNkSS+eNiv03IO+HQoFZFOnbAsuNtDGcKKjgFz4yKBijtDziBmLoJS+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR06MB3493.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(8676002)(38350700002)(38100700002)(316002)(66476007)(66556008)(52116002)(66946007)(6512007)(6666004)(8936002)(6506007)(2906002)(86362001)(6486002)(5660300002)(508600001)(36756003)(26005)(186003)(1076003)(2616005)(83380400001)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8yIE3QWByCnB4xOztJXwTQ0BTRdurVQ2Rk78ujRmft9m2wn1ys32fxHCUNjD?=
 =?us-ascii?Q?1e2JDPYoOtcaEWVgvyVsxwvlAGkHuTY9cNrUWPpYVA48yrZQVLe/7xha85Fy?=
 =?us-ascii?Q?hUNjvQiutOASgpSsro0CrpZL4cn9l9HdlrUzYqs4eLUyxfnhKFbY/H9xX5sA?=
 =?us-ascii?Q?TMBDlbFdzv0ckFm7TtzdCoN2Yq77AoBJ3+drTPct6TJWV2d+6c+ni33hzOJQ?=
 =?us-ascii?Q?xmpiiXuzdNVJDeJ2BTBDRL19JF1mFKlH8Yle3v8KLoPsnCPHqLoO5s9jlm5z?=
 =?us-ascii?Q?bHLeyuHX4F9PWXdp0KyoFyVErx0nrQtIgv0siR/7WCivrK2LoDRan+H53Dt9?=
 =?us-ascii?Q?FqGQe6Jhj0StIs4kNB4oamKur5n3by2EyuT8NSV4cRLTR4rSQbCqSTRtW6D0?=
 =?us-ascii?Q?/Lj7RfC5ufJzqnAc6G8N58h/H0jH28SZZ1HfSFGmyhnSGZbSBdHHBbrkoWTd?=
 =?us-ascii?Q?jJbNm37wO4C4vdd+1cx4AQusJyck3+rwn/BsIOznjn3q/2TFDjUziQcwkKoQ?=
 =?us-ascii?Q?0MxVX6Q3J69LhgI7XtTAi7BByC59O4LMPTqBoZsrOEuC8EUUx9HYnDK7L3kE?=
 =?us-ascii?Q?4MteLyqWNQLXCDCLLl8Chegi/srLpOXy7IvIeX9XeRpTEZIr0zuFg+g4j85/?=
 =?us-ascii?Q?TUODsjHB2i7BK35OTXb2qfgSBJXuhESEhvwsyPvD9ufInfIEFbIVxT3ncVgM?=
 =?us-ascii?Q?nCo7cxndW78WIlIfxXMeO6/0isJ0xym1SauevUy6dNbEXNWAJM2esRTvFPG0?=
 =?us-ascii?Q?TgahBue+YIS1ShxSCYCJrjrz8oY+qW4Efu6psLRY/flzMrtN9NAb63ubwHau?=
 =?us-ascii?Q?xt1x54jpcKn7A3+IDxRstAjD5ZJrXQt89iirqW1upIvMQ4AwVbIDp1wnJ6Ev?=
 =?us-ascii?Q?NB+J3lyLolmZJvKynYaRG8uhxz8Vs7U/Sd6dzqsWSIFXn6R3UXffvl2mt6Bi?=
 =?us-ascii?Q?qzvBfcFbYLNUNT9kGw4Myjjd0fl96TDJ6VRVfzI+b/ywbnQkZM1GftUpUWuh?=
 =?us-ascii?Q?oErK40RHCg09ya+QGPg8y3YLUqwr+qEJXU13jMaBZAmQxBU5Q1m4WC3jDZMr?=
 =?us-ascii?Q?/IHEnHyvXwtni3o4PMqf3XdR57CiudCpdz92jF2IzUjedhmaEFdHG/LfjYxf?=
 =?us-ascii?Q?PNlhIi5tY+1D1/afKgms6sqjgjf9cKsPivGj7AHTHidB7Dzyy79nct1koWau?=
 =?us-ascii?Q?zjm6dMA7HFpvfXPfo85X/QbGrAvD7iodB/y8kCFmLkHkUQQ3gn+9s/vLdJvh?=
 =?us-ascii?Q?+fAB300zHNZWi6SWJ/Ur5l097Fl7EYsTT7E9uWzgJSiyBWuKbbO+9VdIO/RW?=
 =?us-ascii?Q?6bamePRAGfi5zSFoaq24fd5sIA4tthUA01Nz+bI+Y+Bp/AeH71CQgKrgKzQp?=
 =?us-ascii?Q?iFrMhYdDU1yYWKX9MMp2+FIzlWfTNCuwx7l9djoSG3FJzC5/XZPADVixZFme?=
 =?us-ascii?Q?7fsx2ub0z1f9ZHD18h+Vy1+HQI4ry9QkOkCzYLiEO5d9MJt8QY1yecAn2tUo?=
 =?us-ascii?Q?RDZvqUvowIie2582l5jscOD5vBNa11iDs9qajytXbrK6tjmMqeZwdKZs7oFv?=
 =?us-ascii?Q?+jqbX4t4TS9K+HKPmi5/fuE3q4oKHevX5U+XXuHEaednknww5rdXDuCVWKWD?=
 =?us-ascii?Q?uP1yGkGXcSl16RUTOGSpC1Sq4wpp7LmrL2ZghqyLczdKSEQuvtcINFdBnyG1?=
 =?us-ascii?Q?b/e39qkOlIcCYLEoZ9+OfzWkoAs0NUXMm1iA/w112Rcpnr3T2wxWkJ2WXOPL?=
 =?us-ascii?Q?NrM2KyzXPw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 479d4c59-ec20-4cdd-f311-08da187e1be0
X-MS-Exchange-CrossTenant-AuthSource: PS2PR06MB3493.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 10:05:14.0894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IO6UdP0QHLDlz8Xv7a4q5hVFtc3UBAdmPuTaTzyLBgPOiuuhCMdxVICl5H/HH75wsl+k32m+4RnsPDOsPGbtoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR06MB2400
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Address the following coccicheck warning:
drivers/usb/gadget/udc/net2280.c:940:20-21: WARNING opportunity for swap().
drivers/usb/gadget/udc/net2280.c:944:25-26: WARNING opportunity for swap().

by using swap() for the swapping of variable values and drop the tmp
variables (`tmp` and `end`) that are not needed any more.

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 drivers/usb/gadget/udc/net2280.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/gadget/udc/net2280.c b/drivers/usb/gadget/udc/net2280.c
index 051d024b369e..d6a68631354a 100644
--- a/drivers/usb/gadget/udc/net2280.c
+++ b/drivers/usb/gadget/udc/net2280.c
@@ -932,19 +932,11 @@ static void start_dma(struct net2280_ep *ep, struct net2280_request *req)
 static inline void
 queue_dma(struct net2280_ep *ep, struct net2280_request *req, int valid)
 {
-	struct net2280_dma	*end;
-	dma_addr_t		tmp;
-
 	/* swap new dummy for old, link; fill and maybe activate */
-	end = ep->dummy;
-	ep->dummy = req->td;
-	req->td = end;
-
-	tmp = ep->td_dma;
-	ep->td_dma = req->td_dma;
-	req->td_dma = tmp;
+	swap(ep->dummy, req->td);
+	swap(ep->td_dma, req->td_dma);
 
-	end->dmadesc = cpu_to_le32 (ep->td_dma);
+	req->td->dmadesc = cpu_to_le32 (ep->td_dma);
 
 	fill_dma_desc(ep, req, valid);
 }
-- 
2.20.1

