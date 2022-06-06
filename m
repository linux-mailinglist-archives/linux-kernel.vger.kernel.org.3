Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E806553E67F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbiFFJ6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 05:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbiFFJ6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 05:58:41 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2164.outbound.protection.outlook.com [40.92.62.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BFA2A27E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 02:58:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUQtgGccuvwtbAe9Cs+uXD3VWp+80upfkYCG9zX9yb3gRbqNv/FWJwsw8XAn26+xWKHqP1N/OQR5FER0Gj7xtLptqy1kYjHsjtzdkMRX2PdhAbwu+mgs7RNNa5FJuUiuIl9ozrWPXCpFOOFIZhntn8s3N4EqHCDk/QAxI0gPpHuOGpL5FFa7Hr9L+K00WgdIpRZozTGHfWC0CSMjKnbIB5lRaxvjX7dHCNk/UTtVradZxwiJFqKY8yUF7LPMFiN9IFRg60bB0/Fk25tilWxhy1CzIUt5ba5+RT6P2+/E0eW6r5CrzBmWZKQ07W+GtcQq+RJ5zOx6j95dbGkBLnDUFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pswtmc59qrQSCydRNRa7Q/5GhmN5mEFEKVAE95htj3M=;
 b=ms2ugAPo+tlHUBMqJtWVN/7v2u34uLOtZvWrFyVOqsmrTHjVkodGebta/hnzIVWMyLq2uIfc1zshFXzjclsQx23JxcUQwYPemlQJ5GxKiIydGamhKStRBlTBcRAhjVYkT5VsyUEmr2tPmAT9jT3AoR76CZ2TP++zN+jiDbqs/zlSfSUnrG4+kfoZ7odXiJLNfPynfnvHF/0v4zJ4VyS2xabxMGUf6lRfUlaMq4E4LCgctPviX9BGKltV2Ef1GES8rT8VXFUMkVfjxpKR9J/MiWezqYakQubP3gy6xFAAL1w5w89PT8QnshtfupQsXALFIVe+Fwt0hkW0UqlMvf3/4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pswtmc59qrQSCydRNRa7Q/5GhmN5mEFEKVAE95htj3M=;
 b=PuFU9PpgUhSGF+3BC3pl8ifsSNJleCatwD/Rf1tN7IIidgascZkLcQsowHYM2IbH8Fo0jPR1s92tNGfIjf6SsohIfhHk86pvh+VKM1GfJ3vbzxjqSptvBMmKDpVqoyrLzzOH3/wYumQRX1693uzxNz5EkzyDEerqyY70Di7YKwzHYf1nk3bEWjFEFCA2O7SCMq85jiLIvoSLJRtP64smNIDVjHSNJzFYnwGWpWVhaewDTFZlVh+0Kf3JryRIJUB5BNUPjJC5xdoqIpWdrqe0fEokvk70iMtDsV0N97GUIdEem2USINIHojDPFewl0C/N/jHfsfOoYslVYp+TN47GwQ==
Received: from SYBP282MB3478.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1b1::5) by
 SYCP282MB0400.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:81::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13; Mon, 6 Jun 2022 09:58:35 +0000
Received: from SYBP282MB3478.AUSP282.PROD.OUTLOOK.COM
 ([fe80::f832:43e3:9778:bebc]) by SYBP282MB3478.AUSP282.PROD.OUTLOOK.COM
 ([fe80::f832:43e3:9778:bebc%5]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 09:58:35 +0000
From:   Steve Lemuel <wlemuel@hotmail.com>
To:     "Bryan O'Donoghue" <pure.logic@nexus-software.ie>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: greybus: loopback: fix a spelling error.
Date:   Mon,  6 Jun 2022 17:57:45 +0800
Message-ID: <SYBP282MB347864E247D2EC70BF46F9A3A0A29@SYBP282MB3478.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [mXxHHddzlHKRUz4JNTMj8n45tXdInbuF]
X-ClientProxiedBy: SG2PR04CA0183.apcprd04.prod.outlook.com
 (2603:1096:4:14::21) To SYBP282MB3478.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:1b1::5)
X-Microsoft-Original-Message-ID: <20220606095745.1815144-1-wlemuel@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b1423ce-9d5c-438e-56ed-08da47a31f17
X-MS-TrafficTypeDiagnostic: SYCP282MB0400:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6tex61Ao7KvzgrjZ12miTMOyMmMxvI1PBj7KQDIU04iC0jh6CXEuNEYVXrGGj4V4PKaBAcBvQKqT19aAYA8RYyQZEGCeMFma7dEPbDFZwDn4DLiDOYgtzidnyFn3t+80mWDmdwWLkRab7FTp6Q5wraZp1T+touUckrrIXuyBRzSOnn5LE8pPw594tG/mmiYdb02tcHhMhdLBECSbpZbdHhCNWadmjYlb0hrLFcHWbEtsXG3DQ3fgcfmfjoCGBh416ptwEsdXZTZxNnv9DSzbkHmvkmy5bCPlC4e2xsCDw/Sb/f0Z0adSIKfaP8qiwZm7wS8QlQ6K19m5WJhpvkDDGs9pI5UvORH/2Yhj8OdCia9plWdRviB7jielJMzYYArPAcx9mcBcRG17Y69x05YoxhXER2Y8eagL9eHtGLbMw57gmUJFl63o3CZa+8ZfvNuYJXM4Nxfgh889LGZafeqRifxI+286wtjkhyIYfMWXi9TaHb3y/tgEUdZTtYjJaSGxeKQMQ6FFC3soKPlILZU65ov5fhK7753p2SmV4aQUuu5KLp4IYHgsyZ9Jtbow9D92etPTXvSoibXnA7ZIIUly+g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3ibOi+uZItYc+D9ZbCyI2Tq2GzIinek3glWZX3hsRRuVCXXP7cRQskLzfrjQ?=
 =?us-ascii?Q?0kDIC16wWruEGVFUIfrS8R9SqBfN9M70dvJUm+x8PNS+zPkKo6O/YTnIP0q8?=
 =?us-ascii?Q?qHaU/OOAkQwzOFyEMY5fPeAY0KQiOMnvT34mqgieSKCNcsGo7dfF1WyzAQFB?=
 =?us-ascii?Q?fXFKCUFzOJgiqnOpUIYpMjId01lfOGwXRxKeSEW/PbkUOqct/UxKLlwh5idv?=
 =?us-ascii?Q?iLcivYJGMftIZL9UYQ+ETgAvl0rHl344FEy4ufoEjHqcWFPJYAI1PtGI2PsG?=
 =?us-ascii?Q?bdqPOLkKllHOAXhkGHhtmIgGbYiaknocSxmr4GF5Pzdl9V7WKq/MIYbaZKpi?=
 =?us-ascii?Q?cBrbFhCsmZyZm8bYFLJokZZOaeWOpE55ludow9OJfHH74JUxO61TMDcD04nx?=
 =?us-ascii?Q?1V4k85PU6kWlvPeM2eGKOwBTfGaqCaDqCnPqB0/J1VmILYgEDnTD1wUqrCUA?=
 =?us-ascii?Q?zA2JJLUycCXmVbe2SY4bmDc4W+gOrKW2Fwybif8nkreZlbAzCGxdRrDBuoVE?=
 =?us-ascii?Q?E2mJOMDldfh+nM45/wNZ5tpaxoO8JmeQAfn7xds6l5aYEW3XaNg+Gh9F2BMO?=
 =?us-ascii?Q?dKShnYnMsAtmilBv763mTytbTct1RCEFX2VxE3c4yt/+6XkrCzuu3CbC/umO?=
 =?us-ascii?Q?Mhspo1pI4tVrUfyl5Lg6OmJ9QjJ0uUfLFvu+LhESr95GADjEvBI0QOQOes/x?=
 =?us-ascii?Q?dyKQq8sotGhL/mYKfCp7wSB1b+wmfKusKJXISAsM6AIiX2+VB6yPBT9Z3zDw?=
 =?us-ascii?Q?Qhcg79cpph+/vJ8hJi0mgaktd0Xt776Qh73QvXWpfJVuRlPIOJl3Net9DZnd?=
 =?us-ascii?Q?f5KlVd32OUSmdqDOBsKFdI0mMDNFRNRIvlBcYhvH40wU2QAo2nON/say+APv?=
 =?us-ascii?Q?VLZjJD7stpGW6Ir6M5r3CgDBggvBC7NTL2C29abXpuxhTU5F9kiOURIPkoxF?=
 =?us-ascii?Q?P9fF/GFtSbgvpnkVEVIsq4ujFqeCHGN6cvYi3gplgIy2VMT/iwfrU6IOG2nF?=
 =?us-ascii?Q?fYxXOckmeqNlDWrz0+Pa3DblKQgUuNUkDr59kOd1CggaypugFBwf8DZ0lHit?=
 =?us-ascii?Q?kvSLNCK3uUJw0eGzidFq/n2/zMXdSCqyyvidwsw2rULAnxU2F5E26D4t2lZq?=
 =?us-ascii?Q?dq6Qw7LERSWF+MKnROuppj5bFZoO7gH5lp7JlkRUwTyf2k4qeizLeYKfD/54?=
 =?us-ascii?Q?TWpvgDVu1193BwwmNu9pBOxZOl/7tGb03UQmqPsTLb/Qs9sfhyh8D7lfLXYQ?=
 =?us-ascii?Q?/muH9M/tKyLqVcXWJu84K1wSWtAH6YVX7dQRQ/ukHYkistZZ/6GeNL7wviyn?=
 =?us-ascii?Q?at+ZqwvRf5rytPb9/RsIWMwnOg/UfblMnN3KswVyuCARU0EfnFGXO4TF+Vjr?=
 =?us-ascii?Q?Ba3+9HYkLCyB729uS41oczhRuRqgCRaKYkLGVN1Bjs9RI2BX3B1mGki9LzD8?=
 =?us-ascii?Q?utO3dsrnMfQ=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1423ce-9d5c-438e-56ed-08da47a31f17
X-MS-Exchange-CrossTenant-AuthSource: SYBP282MB3478.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 09:58:35.4929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYCP282MB0400
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asynchronus -> asynchronous

Signed-off-by: Steve Lemuel <wlemuel@hotmail.com>
---
 drivers/staging/greybus/loopback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
index 2471448ba42a..1a61fce98056 100644
--- a/drivers/staging/greybus/loopback.c
+++ b/drivers/staging/greybus/loopback.c
@@ -870,7 +870,7 @@ static int gb_loopback_fn(void *data)
 		if (gb->send_count == gb->iteration_max) {
 			mutex_unlock(&gb->mutex);

-			/* Wait for synchronous and asynchronus completion */
+			/* Wait for synchronous and asynchronous completion */
 			gb_loopback_async_wait_all(gb);

 			/* Mark complete unless user-space has poked us */
--
2.36.1

