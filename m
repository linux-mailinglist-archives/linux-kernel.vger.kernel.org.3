Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EF359B469
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 16:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiHUOWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 10:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiHUOWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 10:22:22 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2055.outbound.protection.outlook.com [40.92.53.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B0517075
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 07:22:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irCldg5WksIO3r+5MGfC7GytyvNqmjt4vomM8GwEhglUMMDtfgPX+XetUyjeBz5iveIUi3TFpkc5r3gYPIC8lkzbma2/b1PdXkSLh1oOpxpyTvJJPvIJmVugS+a+RAawl+kPQZ4r4iULDZsZvRfP9OyBW26nyq4Svpf970/XQiw/MAPEhYPOWJuitVoIF0s4R7VAHLiMtGIcnWPbwytLoUZEGeqKKbItE9wtU6xX4EsxCvdkHdvLVY4F4FnHkOQU3+/hDKasmCFGYUbjDVMkRNt5QuQQsEQriQ0ce9pnPUsEraJ5gEo3rkQ/F7X6kMoHqdydMqBAF1CTTkAOV5YuKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5zGZqLPEnZ3kuGiFOMmtYs/LQ+JIEc5cJ0mdGNetoc=;
 b=f48hOfBvZt5GhViMN5zq/NBXVTNjz3M9groEAQX2QxnM+upy1fjyCVdKv3dFNk54f0EyvGX2zr+PlBWd4VNhZ+WZ5541CgpAOlo4i4QsHz5Oq0vXhzkHMj+crwsv/zNTcJvHAsGdOKBMk3v/twkC/UvB0zTJFloeJ7kQKwM73efPY3Vm2ieN6kLHsp4U2NwOIbI7n0s+NnNOw9o3h0qkBFonAC+XgZzuUOMuAp5TWj5wEuSK8e2vQCoNvWs2jUNpOxHjpIW0HVp023PPFdFdxag9R0AFNg3lZUOeMZ6cTv43oU/SO1agRYk0AkoFktWKakLIy3MS3+e35RPQ2IsKxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5zGZqLPEnZ3kuGiFOMmtYs/LQ+JIEc5cJ0mdGNetoc=;
 b=iRfzh7p9BGIpKE+OfYyo78ulJ/NBPNEGJesFnoFlTXDGulr1sc0QnEZq/OVRw1ekk1tdvKCQ/xzRU2Wsya2BukYapl11ezLss1Bf6IZT/wJLHwzcD535SlCWW0kejwMB7y1EFZYSLNGehtsIEde80duYu8ftfalt5rXSYlpnRkLsICrx89ei+4UOGBu2wv3WLKALCK1kEWeX4vKpIqcV8Fv9sZtqVdP6IjgK3YD/rH84O6KEDTgkQxiMee8JWIuFeQBNHIOmuvAFXMiv6iECZ/KT1nXywfSx5fOIimMIlnipMTCEJrgNJy9O+wlO2LxYUZRR5RJkhu/YCp/xdWl0HQ==
Received: from TY0PR03MB6275.apcprd03.prod.outlook.com (2603:1096:400:143::9)
 by SG2PR03MB4535.apcprd03.prod.outlook.com (2603:1096:4:80::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.13; Sun, 21 Aug
 2022 14:22:18 +0000
Received: from TY0PR03MB6275.apcprd03.prod.outlook.com
 ([fe80::f1f0:3648:9853:968a]) by TY0PR03MB6275.apcprd03.prod.outlook.com
 ([fe80::f1f0:3648:9853:968a%9]) with mapi id 15.20.5566.012; Sun, 21 Aug 2022
 14:22:18 +0000
From:   Ecronic <ecronic@outlook.com>
To:     paul@paul-moore.com, eparis@redhat.com, ecronic@outlook.com
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH next] audit: printk before dropping logs in audit_log_end
Date:   Sun, 21 Aug 2022 22:21:55 +0800
Message-ID: <TY0PR03MB627527D223A19E65A5DA14E8A36E9@TY0PR03MB6275.apcprd03.prod.outlook.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [pLmispgIn//yvfoAOSH00lYcxqLS2dw7]
X-ClientProxiedBy: SG2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:54::13) To TY0PR03MB6275.apcprd03.prod.outlook.com
 (2603:1096:400:143::9)
X-Microsoft-Original-Message-ID: <20220821142155.7385-1-ecronic@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e6b4771-4b09-4c98-f4f5-08da83808d20
X-MS-Exchange-SLBlob-MailProps: Vt1MYR2q4Omjz9ND6GtvUm7Ce6URWvk5RsRU3CXJbeW1ZyfNZKPuT59LxEhdQHq1voM0y0hgifIejxl12Z4HpZioOrUwGzxfovgCgd/7y2Bg4+QmJt0GK95GBRlvPvUE6oPp1CZQLGm1rfGAet/NUd9XTLOqHOaPQrE8j4+mcgPm4ML+JNaUuVZ4JaUCMEOijYZobxqQrhNHk4ePDmvuc4VN5qCLPa7/JAIzbUxc7nAcsweIrso1vPxGcEbdTd/2kydL9LJ0+U3ugsZZQF+eggdwhkX09iYwR8XNWF8D7x2RjL9DryNDyABJJ1+vGmLXqGRkDVFBS7W68CBu+vKlTEGqKoYOuc673pTr3P+QUxZhMMIxcdQ8NduXvckDSVfw4yAukLYJj532v115r5U70qq+q5Q9oASHShf5wncJMNJg06zncI97uiJy2P+uMrKFH4IKewb88Et/Q0/xbh48sI0yBTzT705ietRuB0IZXhIO71KVq3hR1uImYXxsjuuKQJMTUU2D48kg9T3KWSLU5787VuwDqoF5F0i+z6iuVvAGYX0oykvHEnPzzPqiD5rGD4XhkQCYIev+vp92ucPPD+HE+XAdgvxF0HBo9kNhjK+QPxHyCHZ6Wsrs9C5abKEEM/HA9mIhz8mU8jubo4QfAJBPnhgVamOWHY4JBDMOLkJUNFiED8lZiLmze/YIazrbdQgGSuXlvWTwQvj9hb0/590xcgnUpmDg
X-MS-TrafficTypeDiagnostic: SG2PR03MB4535:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x6/23avhi853y/MMwl7F9Sti6kcaCCd864MSfk0mYdfxEqd7x0NYquNv43+jD+CbDN1O7U1cU0B3FLiVBoAnLiKlq7sNrS+hYA+fk1bob4Al77u5vEYoXJhJT6jEwkb2weK4MInNKVPQ5y6+jjhfrB7S7rFwbDljH1S29Pkx/fIyQX6M6IHGXUTmjJtp+Z6GbNXovc2sR7eqMX5bDFvDjazlF2xTSqWPw4dT+GYcrUMHlBxKCgfwrNa5t+g7AQsEnZ3YCzR2/qgyrYzD1mjyjpHA4G/TzKbF8rwjv5i0b+jTMK1E9TeHIRJQ/gIlC8Zw/56BCM2I/wSyzZNgJoMR98WjoUnfAbSBVTwqtYdvLT9TQFU/HoNIX+0KeKH56rqe1fvgLF/PN5JVXWcP/E6D2Wl+Ip/+Tg8iovx90P1I6nWV6ZyygIQmyQ0r9jz+QJRnxtzivTIYhQ3Z0ibdN8RBwUQa0LaU42m+5VMcPLavm7F3Mg9Fh0gOb7U4nbilVKwEtDe9g+u6C4I5MwKFFoocXNt2jsZLHWQh33m3jaLYt7mIbWlCAJ8nrMWkISxZyfEW5KiXJNrlSefMok3zy3OLvz21UjlR0Vjp8ZmYkWyQp/5ablBFBjSQZAagJmp9GGtsk9Dc59f5QZMaGp91KEVibg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h0tAuev6exzfna7JpE3nfyUurZTb87+hkjIwkOvfGhN3k4x+YgWRSgizC2XA?=
 =?us-ascii?Q?bMH554i3yHa81FYyFNgIaJA8T+nDOeIPtWbt0WJRAvwVoOijUwn9CUQeStyj?=
 =?us-ascii?Q?o161wKPA7YMRQAwsyefd6QPeNyS53DBNZ66K3RnRVEVtLgkydC1gQF8M4jRj?=
 =?us-ascii?Q?8KyRCAz1m5VqYlt72ZasuRsy2dRAtjzpMa8QDyvdkUMHL9y3hIZmD/r3q/16?=
 =?us-ascii?Q?VVWYdYKQnH0eku3dac9T1irKeuu0GA1i2i1tQd5p01f50aFSfz4xNjgaFZ2i?=
 =?us-ascii?Q?TzfJeo9l7gq2orDsEY4OhtC7rrPgBmi0E1dM6sf8QPNA4/xePf28CwyFq5Jb?=
 =?us-ascii?Q?l5xh6LzFO5+OpIxONWACf9eDo3qDlLGG04zwJpfS6EVT/AkASrBYh8jUhUls?=
 =?us-ascii?Q?jaXWUVen1Pk6hgQau1ypPGZslJqrnA1rxxzFwNBtQA56oriSAHxcPPm3QpEl?=
 =?us-ascii?Q?RpgLDCY+jak+XkcBMSPZ69bw0BphZReBG3vac0wmUFgsNBCKzGHqEFPPcl2b?=
 =?us-ascii?Q?WHDRHvlCHPYA+cgs7Zk76KUum4jsrdgmHwlyMuEy6K6rzjaktYbKNBaxriyB?=
 =?us-ascii?Q?TcNTFTtafNrp35srbxExN7nH0MCmvPJ/fcQ9l5UhPkjgcpaNwBI7x8WMojbl?=
 =?us-ascii?Q?mN6BSfu1zsrRqCH9Z/Ga787cjQorRv9LrWTQcCBMf3Sw1sMTUyp5MCuGwSeQ?=
 =?us-ascii?Q?D5LYyR8nYkGMzOsmw4xa28dboFy0UmjKfQDyi/WPy2ZNQUn28qOvgkjc2q5x?=
 =?us-ascii?Q?pd3T4J5H4RSYW2pje3pPURRdJlHBj6Xh3gezAlGSyVuM0lhFdSVkvts784bG?=
 =?us-ascii?Q?Fn0zHPPDi+dRKi+0M4RZ2WbC1H+eR5oLA5iU5eB1F3i0ZoermCLRS9jEUy0E?=
 =?us-ascii?Q?sAbRzQHYYh+V1DRbSZITan4C5xBXWyUT5S6HEf6dt0AUR6KQsqGkEuzBAJUh?=
 =?us-ascii?Q?4YZJI37xNIq2avVAIviqqm8frKKqUG8WVTYjDlz9PwcTbCugJBi84HVLFuU8?=
 =?us-ascii?Q?CQ3u9PwdOjywMiJ5/avpLTNwEi1TwOvy8N2wMIhKRxqwwHN4V5EsARKXg5YR?=
 =?us-ascii?Q?VKnCVkuF0tcexUiyFmTba04mB5IzjZOJGlRitybryHAX3Nr9hHEsUfgE2qLE?=
 =?us-ascii?Q?MSfwWYR1+F2d0pA0HJM0Wxc5fHLm5XjWsOk7arhwpPGnip7KSpW/gI/bD6YI?=
 =?us-ascii?Q?RSdBQcQkkgirz2JRNeYOc8ZuQQTb1Q8Y+px63W2ijFFR+t357BCncwYoP4Wr?=
 =?us-ascii?Q?nyWKUbXzsEO5nJguX/weznqx34egbHf/vY1iU/DYZA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6b4771-4b09-4c98-f4f5-08da83808d20
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6275.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2022 14:22:17.7364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB4535
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the log rate of audit exceeds audit_rate_limit, audit_log_end
will drop the audit logs. Printk before dropping them may be a
better choice.

Signed-off-by: Ecronic <ecronic@outlook.com>
---
 kernel/audit.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index a75978ae38ad..3f5be93447cb 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2415,10 +2415,10 @@ void audit_log_end(struct audit_buffer *ab)
 	if (!ab)
 		return;
 
-	if (audit_rate_check()) {
-		skb = ab->skb;
-		ab->skb = NULL;
+	skb = ab->skb;
+	ab->skb = NULL;
 
+	if (audit_rate_check()) {
 		/* setup the netlink header, see the comments in
 		 * kauditd_send_multicast_skb() for length quirks */
 		nlh = nlmsg_hdr(skb);
@@ -2427,8 +2427,11 @@ void audit_log_end(struct audit_buffer *ab)
 		/* queue the netlink packet and poke the kauditd thread */
 		skb_queue_tail(&audit_queue, skb);
 		wake_up_interruptible(&kauditd_wait);
-	} else
+	} else {
+		kauditd_printk_skb(skb);
+		kfree_skb(skb);
 		audit_log_lost("rate limit exceeded");
+	}
 
 	audit_buffer_free(ab);
 }
-- 
2.30.0

