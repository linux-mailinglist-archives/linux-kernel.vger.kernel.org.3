Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7BA4ED961
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbiCaMLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbiCaMLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:11:18 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2104.outbound.protection.outlook.com [40.107.255.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5D6483A0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:09:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glC3wqCUzwaLBBs1dmoSAieMxfRcF7TManOMxNe8YJMKMtX11ciUqlq4avwJySm0VnmjHvCjQzc2g9LHGI+wUqEC0LRz9NJthyRVcDohVM4JaFVyEPXlfzZuUJB5BKYafaitM3Ay0vkN0jXx7olzGprxXbDnn2rfjWVgHSjqVt6PxUBTP5fvpfXpZ4T6gtcrv9H2XnwG96GZn0udqrNA8INpDx7YVjgDiWHmJdtdZyzKwCjh5JeuHTPlQEM8AYVAypgznumV1sQIMZReJjz+xryBtcz/2KxMsjEesB+M8BwHo8S3+/C973974huuqoB/UsfNgwaIdYGs7zmcw4vq7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txjU7uhhjsovw2BtJhWsDauiti7Q7qWq3YtpqmvuvGA=;
 b=YooGMzSm2OGhSJ0o6vtvagWwfd0UdRk0aYpBN975/1oeOzJSYouUpvNj24ayAafgdgYiqGZi4Y283ntGXJz62IXfm6WzLw3TIZmVdFHOA81vR9Ji6yfGZglIiZBXNSYVDZGzONpm1m/9iL+PPmYM4it/6Tc4GOFylPly7tR9Dcpsi3m4o/732CXVV7ZAXEmPDAPW8coE1J2GCtObe9EdWXjZuIrcxE4Bw5VEvf+91FwpzHq20x5tqpPJaERBkIicBIMU2FIEJiJf7Z0zOiOeg3+ZVDoVgH689Y4QlRTI7wf0M5IM+H8ceyk4A3r1t/l4SveUNMN4bHrfZfpaXn1r/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txjU7uhhjsovw2BtJhWsDauiti7Q7qWq3YtpqmvuvGA=;
 b=aaZPxo/ylOMr1fyDYHfDwY5jGCv9yPGbBfI+UbbP3ORElZGGFP9nNVWmSm3zEeaBLBDbkH0EBf/sN28G2mSkYgR4qJcbtW/WDWL1UL3LdNC0SOdd5MwVYfM1vQRmNRuNNYpEjqQ3ID0xtE0GT6uedzdYT0V8G4n+hBSamAEFGIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SI2PR06MB3882.apcprd06.prod.outlook.com (2603:1096:4:ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.23; Thu, 31 Mar
 2022 12:09:27 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::6c6e:d8af:2d3c:3507]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::6c6e:d8af:2d3c:3507%7]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 12:09:26 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] ti: use of_property_read_bool() instead of of_get_property
Date:   Thu, 31 Mar 2022 05:09:13 -0700
Message-Id: <1648728553-37485-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0059.apcprd03.prod.outlook.com
 (2603:1096:202:17::29) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7263a6cb-c8c3-4563-01b8-08da130f4d36
X-MS-TrafficTypeDiagnostic: SI2PR06MB3882:EE_
X-Microsoft-Antispam-PRVS: <SI2PR06MB3882D5A98C3CFF803ECBE2E3BDE19@SI2PR06MB3882.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YaZldWwZr+GdOA48/CpH8RshseKms0LZfjz2Mm4rWB7k30pWHj3fWch5p0WwLWccDZnPBCIWmmUMWDaimUT4POp9KRpMeGoC9OYQvECA1NXcjG7A8ul4jQISdZpJ8Ak32f4vnmPK5rXIvsMjNOYhmB/xu3bmllmwg4d0CyOyo7CeNE/oH8pkOzyOH11TPSupR3irFab+l6AG/mKGkMCMRTGrMdS4DbnewArYZ0Ij1rUqpY3bkWQ9B52pJH43iAf8YDQ8lghf86CmQvNvTBMIoUDQNwl2xlvt2FjfIE+qjsVRsKj54foJPgyOFcBOne0P5Fqb+aj4y3oQt4uiN6e6CEG3FnfroTNLH9x7KZgkl796iqkicJsVFOq06uMOfnWRSglz8/i5ZdppvItQDVPIuJGCBeYoBeNP+QBwX0Y79UXqW3C5Yr+7tBwB0xjbhPhfw3ve0VEVgRSVHFVbJeScYgUJmW2bsmYxJ8FVJh7e0jTOEQdmOwYKzJeyRAMJGxDuTgL7t/3CaLpw/Q+ltyaDiR/1rv3iC60v63fQocOxk0YvHYuksLIrcJ8CSJWyxokbsJOAnI1tjPX/u9h/QEyySHgcTPnA6hXOU+iRGWl6IMMsVXL+409x19nqpcJuAyVf//lC8tiksjCK6fECBU80eBQF4u/92K64KrHcTZOkWgStO6PzGLV6hv5wYR6bVqOasBbUfIhi1W8vDAQsC+bEyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(38100700002)(86362001)(316002)(8936002)(4326008)(66946007)(66556008)(66476007)(8676002)(107886003)(2616005)(26005)(186003)(83380400001)(6666004)(508600001)(6486002)(6512007)(52116002)(6506007)(36756003)(4744005)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9jNmJsLs0jTpUi0XDhS5mX5jjA/DTN2pSTDCzqY2yMPViSLz0PElrWd7vlWq?=
 =?us-ascii?Q?7CZYB8B3ky057eadeA/hRFGSwxCtCVigT8AXMM/H7ierI3eudgTb3ZjCfHd7?=
 =?us-ascii?Q?hxQGTLzkSBfdV6THdAOEukdKxE2K4cySUaS33fS53VxJfWdVTAAbbvvaCYAk?=
 =?us-ascii?Q?VHS6MaQ7w1QNNcrXswQeEqlZ6hxI0Sg4cdCNnm0K0HaytIMdsuA6Mc2JjxJo?=
 =?us-ascii?Q?IqzLs8Of1sx9UcJ/UQhn3RodTQwv2v1ujNVE27CHCxtXsn8IcWPQS+gzVzhk?=
 =?us-ascii?Q?5RAKpcOfiwL8aqvKa7qMzVm8XC0aX8P6w26xKEW76usqJbCSxsvfPo7m866m?=
 =?us-ascii?Q?WEOsaXae4zMvQmcWgOFskR1baE9pjgH9vSuciQntFVhhb7Qoxk1DZDWOCTta?=
 =?us-ascii?Q?fHqMEyVU2NkdUatuAYz0nI2ozJlHhLfZ5eyQlLle0jaSmD3QhbTyJkn1MaSd?=
 =?us-ascii?Q?YxX15fMAB4VogF3CwYaw+8egG7IiBpCuJo1hLVqVzxExHe7DRri9IKh3RIYD?=
 =?us-ascii?Q?O+wt9tsMhwQ34HHePO8czkV5rC3tPIg+DtXqvzULj25i8zX/orW2MYHYZLRf?=
 =?us-ascii?Q?E/iplPxfjUEujl+NguoScy37JaJZLFDcIC9k3yjX7OjyhHOUnV0NH8QSjR7C?=
 =?us-ascii?Q?z7NE6eNaeRNFlvAwlvVI0mXvjXcIrWW9GgAh1PQZGU7+OP22+WYZoWvW2j5k?=
 =?us-ascii?Q?ZZtdxThbzWGGmKRyoDpV4O+NyEqy6ksbkWYeMHY72eSWf1XWeydAAqah4qMZ?=
 =?us-ascii?Q?H/Vvk+GkYqQfMCeCR7ZvrTihuDiNpCwQaLvPKeyHEMTE6OedJkfEUa5DofmH?=
 =?us-ascii?Q?uBOFnwULzJc7sy4AgzKJDFL26kUKF5U5slKBiGgrTNEPt4llMFGlNfpXCEq2?=
 =?us-ascii?Q?nFfTjhN2J5uhlhZ9k3oIOrE79oY6fHwS0u6Wqrl8jmOJxfZqC4/T+AXWA2l6?=
 =?us-ascii?Q?OM7LsIxPpDpzp/1NIUt/Umn8jUCEPyOUY3BGyOr3D02s8S2A4gEaF8ag66p/?=
 =?us-ascii?Q?lNwQ1WFjYugK3CvBBiP/oPOKk/jqEFGIUD/P/o89+tEz1pUIp1gfIeajOcSS?=
 =?us-ascii?Q?dtxmeWJBAm/GC9+g05BgHzkK8b1UUGHjxQioJZdd7WV15VFcAYhbikC+QGgv?=
 =?us-ascii?Q?onkjpc6jFAGQgey0JLoQXZ+9npxqNl1FFCVTr4VAFg11upJw9lhgda9p/TMf?=
 =?us-ascii?Q?mG6o3M2qdDqPIewAAm2pzzT/UhnHMCwp/U9Xbpy9S3fI9Sa4smm7AynuQ/xy?=
 =?us-ascii?Q?j/+dDBP4ffGJLmZyEeYqRyM+XNLAkEDzYPTtIurxA1xanZVpaWHT0La8flAP?=
 =?us-ascii?Q?L5sgIpf+6Y8oupR2NlOcrx8tAHpQpsQadWT1rzCzyr3uB7T/YKtGNV/vhfCe?=
 =?us-ascii?Q?GiI8VtMI4+0hfd97f19BMEld+5vsgrGq3lt/ttETVKnyT/Mh/SvaCBfVJoUY?=
 =?us-ascii?Q?ipXxOxM3ChB4AmdOotLcIi/Rrj+Z37/asddCVxhrsaLdTmKfmNSdfr+ZF9Wm?=
 =?us-ascii?Q?CuuST3TOopuvonPZEyz2pd8u4CnV9fsyf08cuwk0tTcg63Z7hyr+k/KJlzno?=
 =?us-ascii?Q?bryBiBwe8QwPJmV1GTYuUuUouQjgbLBbK2gDC5FWBJknqPlps+FvzUhJV9rK?=
 =?us-ascii?Q?PIYyxbn3/ogvSny6v2gSJvaE7GIBNWAdILdczNiBFgTDWKGvMJ568TWv8DSK?=
 =?us-ascii?Q?J+GtxNzXwcXXIYE2MBCMnDvqTlx30YClR1scdNQ3NGSUIi2H7HiC0/7SVT2y?=
 =?us-ascii?Q?aZzlB5epyQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7263a6cb-c8c3-4563-01b8-08da130f4d36
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 12:09:26.8731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: naY10iY4XxX3Z76z/VUl2Ujh2TLJ2mCEHDthpbwI7TsaU/o6JKRWhkSHDEiYmf2+kX4gIU0tdfS0tj/punALIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB3882
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

"qalloc-by-id" has no specific content, use more helper function
of_property_read_bool() instead of of_get_property()

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/soc/ti/knav_qmss_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 2ac3856..d385f63
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -1266,7 +1266,7 @@ static int knav_setup_queue_range(struct knav_device *kdev,
 	if (range->num_irqs)
 		range->flags |= RANGE_HAS_IRQ;
 
-	if (of_get_property(node, "qalloc-by-id", NULL))
+	if (of_property_read_bool(node, "qalloc-by-id"))
 		range->flags |= RANGE_RESERVED;
 
 	if (of_get_property(node, "accumulator", NULL)) {
-- 
2.7.4

