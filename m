Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E554C61A8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 04:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbiB1DPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 22:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiB1DPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 22:15:38 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300113.outbound.protection.outlook.com [40.107.130.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9F44704A
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 19:15:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I00QKUGsxRh82cvZGZ06xHD9KuYJ7aM9QNNOS8aXMxiEdJg64REzd7DLqxksB+gJS7/hTYW2Q3+8ikM6w0ftU4L6SPK3miGTVUHCi/t9zI984m4JK9xyzfgVuvQIaf6COEY5nBbCqf6lVm8U+34HFkabd+x5LVPXsNR7nJvTTMcQ2sUKCh8DNKaMfssSL82cDb/87/bFyiBBR7P+PDBEBvDQEBg7GZJKm06YYhnhYNOb0TMn6upgQHOQShjRSNyswZ8ejBySBxGQiJsOsfUOto6hwc0r+Avd0Kbq3OYk0ZIXRNUhbhIIUE3WILi7gQ2ov92KncZ1lrwkPrA9/0Ewvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r66OWMp+Kk5Q8E78ZpZkb8JZ9lfma6Rk2tCGpug5uQ4=;
 b=LK9cbybJBS6p2zvO9t3Ypm62TwbXn/FoU+TnwlAG3YibB/8CkRQq3ZyoZqbeyGPcEzPmLXHyg4jvovyZI/6SRXy1hYr2eYU9rOTmE1TcDeRa6hIdwf3BUjCz6uavKLX2m+9pvH3l/O1ZLcPMPefDPL/R1gVOs95Zt8ltGMpJ+lLau2wdNNnASTQXOLvnaA0yRr1xQZTHPz4VQedWVQVaruCMFxEsVKeMzjM6FGa/wPdI09TvJKC0Rx/gbTH8D4ATR0of7bgO+WpggvJioZYNNrcpUDs631r0dSxzxBSjgL2799u92b/peF6e8wJWtfErcIUhGYcqXuVHjnEiKEZI5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r66OWMp+Kk5Q8E78ZpZkb8JZ9lfma6Rk2tCGpug5uQ4=;
 b=hEP4afSaqzPoG3/UXuCLF0IEELvh0oJ6S86LTQcWDplV3e31SoV50X3S9brpFRsjzZXswaiVn/6g3TKF7zPmJig1fqLQMMdTwlNse8n+UNGuVZMHQ8D0DAmruzsi0rx0OpQ8L845ChgtA2AurijEQ5qq5gfyxxp4vXs3GDuCXAk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by PS2PR06MB2454.apcprd06.prod.outlook.com (2603:1096:300:45::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Mon, 28 Feb
 2022 03:14:58 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::49ef:baa:8c3b:cb3d]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::49ef:baa:8c3b:cb3d%5]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 03:14:58 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] r8188eu: core: use time_is_after_eq_jiffies() instead of open coding it
Date:   Sun, 27 Feb 2022 19:14:52 -0800
Message-Id: <1646018092-61367-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0005.apcprd04.prod.outlook.com
 (2603:1096:202:2::15) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c95cd85e-bcc5-4ee8-a51f-08d9fa68803f
X-MS-TrafficTypeDiagnostic: PS2PR06MB2454:EE_
X-Microsoft-Antispam-PRVS: <PS2PR06MB2454C0934783ED63888515ECBD019@PS2PR06MB2454.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b9Zl0FLW0eI0qOeR7w5jU1/yiB1f+caGW3u4yNpilo8/tI0HRcA9pv/ZJSwfZ0k2I+3wBNLUxXjZBSe6DNKUcBMOj0k2baOzC99BC3RSj6WITGUkoF8G9RnIvKMwylhp8iR6uu9dBUIFXKbpp1ND8Qrpj7Xx8pWGtbweJkLETpAwpw3XazX8KFtdcSVxEM4eARO822iLHFyydNQ/ym6QElLXE100wWYj4Be+8nejTNCFqgB3ryMGiXA/dEs/X5fBVETQa6BjtnKxZAnwNdwfWHksIwBF/UWZDuZumxLCT6oW9ufQezcZbTX3OjVRzwjO+s2a935x8uuUko5FdhG8DrBx/GOU+dnRX1+aIspppFej3OTN80qnaotXy6UIxm2ejbOV/Z+q2twGVZXJV+3E4PA2Xs/u4q1FONVCFZSd0djGLUgPI8E8jsG1Hc7CSPVwg4ex+n8T3g7cVcM34sReQDy3EX0Lf0T2N6Bct7oHlwH4BmDInSPfY1ZpWntKSXZqtcairIWbhMCzMeYHDFlY7ubCRyRNTPe30R5WDYm9oRaErtRG0zedxSR6HffL3GpEPcAXPAQ+7/H1RJresIt9PAPfC6fGJNYQlcalXjZf+1tTFGr0pU02PVtwT5Nocq6WsMqsKP5uqpEJUgrKYyHVoXHdzD4MTwMpI7M5nYqY9aQX7sWU/G1vGDN/WNo/AhWukA36eUgEUj+o54azeKU3cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(66556008)(66476007)(66946007)(316002)(4744005)(4326008)(2906002)(86362001)(38100700002)(38350700002)(8936002)(52116002)(6506007)(6512007)(8676002)(186003)(26005)(107886003)(2616005)(83380400001)(6666004)(6486002)(508600001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HOImqriLCo77apq8jLLTSK1Zq9fPcRcqOxb1DP5PCnKl4FCnTjNnWSAwl8/R?=
 =?us-ascii?Q?50sEputjTMJAWn9TKoDISY7iNRkGmIJpGM/3ltjrrojeXybzvladGlJOT/Hg?=
 =?us-ascii?Q?ziYSCFLNexPXr1oud68rMysP8nxTqA9K6k6QzXDmYRjugrofGF7owGtifaTR?=
 =?us-ascii?Q?Ij/QrqUqMAq87Xsew6yQDKJoL/Fobm45FBscxq+vgL8XtOokoge+Qqx4yPYW?=
 =?us-ascii?Q?mkSmJyw2nnlggNyPrdOlZbOtb6itEDIgLeL4HWBR5f2e62yaSs/ZsDLOFVkr?=
 =?us-ascii?Q?7W4iKC92fQOEReIvVCPGdS0wLbvoDf9CJVi9I4NlBx5dJRaFG7bQzZ+lm465?=
 =?us-ascii?Q?Rags1YRF4NVQm8cxnvlIOsVJHqYazehwC9J2BqPQdoEsHBClUyhfh5V1Twsk?=
 =?us-ascii?Q?oscVdmAfTUv4erqZgyXHRbIJYa0/x65gAKRNyvpbPGg/ofO+6eLAKSCkfNqt?=
 =?us-ascii?Q?VOfmpNoD19XGWeR9Nwoo5UJjFInMPNysS6alyoP43pt11hPF/WputGndiwOD?=
 =?us-ascii?Q?LswLd53wS5JWLMBBqhwpAYo/jLuwsZmn4YYrfsmRXqmFGjpOQDWWEn0fcwVg?=
 =?us-ascii?Q?R1beprfI0q8tTxwYXDQzxjs6IszS9g13LQRl3Nl9PnBb+WsgfFxds7tp6yax?=
 =?us-ascii?Q?CTYtw1XgMKWepaT+vpvEXD3ib+zO9Q7cS1E2EFdofFdehvbyu7Lje13SSisj?=
 =?us-ascii?Q?2VxTvfg3JJU3OdWN5rJ2epfTQTbmRLR83as35CU6KSXhqFcdPuPmMNVOnj+D?=
 =?us-ascii?Q?W1z7/qew0Ijdgsb0qV5P8PQzE3+tzNr0W2SURCvXpqFcefFhGGinUsyARlqa?=
 =?us-ascii?Q?OMswptW1ZJU9cj8AQf1GEufuYKa3xrd8zXpOMAhySnZLKkLCmMjFPg8b6Q0o?=
 =?us-ascii?Q?jOzn7uWVQegCMFmdC0WGCW17AoNZvvEVC2Gz20efzHM0PANV/vgBmvwYUzvo?=
 =?us-ascii?Q?C6gbyRTPsZaLeeMOBBtz9e4xT1BNyqcWKKxk+UzPlRcAzjFaDZljzu0amU8a?=
 =?us-ascii?Q?e7kFgdTt+lnxc/NuHh9Rdxb+iQ184qTHux8CRRRNFYDJMr5B4T3Y2WHko5f/?=
 =?us-ascii?Q?ZRaz7anNs72m0fncFh+pW+vIwtjNDZVxZdC+Vigrz0rMpWyVxJCMYwyTuanv?=
 =?us-ascii?Q?jnkX41sIkjNPv7cA1cPO5/Nfw61hZx9Ji5uX45PQeLtp4MaUCZpkZA1EMYCV?=
 =?us-ascii?Q?ntQixuxZHB/7UCZxR6hpkwT0XIy4BQ5XdQgmyKchgLEEYnKe3dT+2JtXOrkd?=
 =?us-ascii?Q?oksPmi9YZIAsmAalrECIyIDqz0owAX92H9KNRQ7emPZJPjTTSfnHZsbADdwE?=
 =?us-ascii?Q?WvNmJ/r7XNdCDTo6YMwKW+XQ0Js9ycG3JzMYVp/8i3cWl0J58CtgvfwUMVHf?=
 =?us-ascii?Q?4+9gOAvG9XHdSo1WliDk11hwYUV52JfrLiqsZg+PUmyPb6JAFjJyjjxEcgvn?=
 =?us-ascii?Q?yc4rSH1FkVNa5X4sAYC1Oy5csfSaCLe1nnyLHXuLrkti/uXjQAIxxTvn5Ufp?=
 =?us-ascii?Q?ZC4gxXInHu6Kru5Tl6W07vu8MREWkZsLcKuV86A9EaHlGU894RxnlH+jmrgE?=
 =?us-ascii?Q?ahYqI1tbuAdcPq0UbJkip2QPQbaBsLppr3wQkWPWxN1U1OYRDHH93AeTOr5A?=
 =?us-ascii?Q?nIIE1eW30iq3aZ4JjWjj20I=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c95cd85e-bcc5-4ee8-a51f-08d9fa68803f
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 03:14:58.6551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A9VMP3hvTTjABJXvkWVbMspX4LWqU8iHGOyC/qvYTzQmlIexnVDiUrr8iYW1ftJkV3Bd8qTkt9bCWDRw72+XkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR06MB2454
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

Use the helper function time_is_{before,after}_jiffies() to improve
code readability.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/staging/r8188eu/core/rtw_pwrctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index 46e44ae..9894abb
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -102,7 +102,7 @@ static bool rtw_pwr_unassociated_idle(struct adapter *adapter)
 	struct wifidirect_info	*pwdinfo = &adapter->wdinfo;
 	bool ret = false;
 
-	if (adapter->pwrctrlpriv.ips_deny_time >= jiffies)
+	if (time_is_after_eq_jiffies(adapter->pwrctrlpriv.ips_deny_time))
 		goto exit;
 
 	if (check_fwstate(pmlmepriv, WIFI_ASOC_STATE | WIFI_SITE_MONITOR) ||
-- 
2.7.4

