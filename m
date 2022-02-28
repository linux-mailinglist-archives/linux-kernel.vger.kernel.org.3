Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650FF4C6EDC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbiB1OHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbiB1OHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:07:20 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2097.outbound.protection.outlook.com [40.107.215.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1AC7E0A1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:06:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3BJMP96Zl1MNDER7sRdbdPZyLor5g6ewnObtrBVcJ9DbHN0Rgmw1FOY7lf0TKTqYc/RnMUkar4iVgQ3/IXO7MbmrHvwjUd/xXZ01gsUfe2z5MT7Oc+6bWQU7QgtFq5vu8eK9ClBusBxHRlOuscOKt3M0C1O1NTLZ39zRDiXuoXuZPx/zcCJZoZJluB7qrs3sAnLzSNS853NqLNw8SprP74l/b9DmvJcaEp1cC0GUghcI+2/+pfRcbGiSLE9BxSLzIn9mGDHAVx65iyqGWRz3L/++sbQmBM46Og67L6G7Dyp848cKaM3Mi8yG1pCK+Z7J3cgpWy7gNHhj6vuftjrIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDdUB9H1ITg5LNwSZTtXV5NTOXSzWAyd+ymcIfdmcC4=;
 b=Ng2N1lm+VSo4dfgTyM7wvQSCbDxACUpgjjqw15GVLCAjF8WVjPIgQfogOjp2zxs/GPAMewJldXctqXRWh5q2HdnqZDkMt7aP3njSIb1webe5PSA5J59xaEbGjCma0N+nxvBCupVSWI0xHOFD4of+TVoP65gijHbvXhB5g+JBK/f3cZkuViqsooShpg4ASZr2ibCfvRtZgV/saZbe4wUIm2SSx6J7q/MJTYSIxXhWvkRDHHkyt/y5suadAnG1/vapxMWIly6Ol2c5uT+jRl/UvmH9N84rWIDA789dQuXT0ZxBpSWgmcLe1R87IotlAwpmuCh6f2NXjB/rFMvNK3F0PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDdUB9H1ITg5LNwSZTtXV5NTOXSzWAyd+ymcIfdmcC4=;
 b=KOj1BAQTVOedvrjFS5DHS7grGMKR0qJ3ihtr4oXyHs0aZNpsKbJBThcPTG2CbWuWRwAJm7zFKSSFJuSe48CNyKuVq6Q/ItclVp6LGcXCCvWXTb3fmhqt5YSubUlvd9pyXnUtcftlWHzPma7yGCRik2rVsmeqpp1+RqILlxASN+A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by SEYPR06MB5301.apcprd06.prod.outlook.com (2603:1096:101:82::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Mon, 28 Feb
 2022 14:06:36 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::d924:a610:681d:6d59]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::d924:a610:681d:6d59%5]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 14:06:35 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Guo Zhengkui <guozhengkui@vivo.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] lib: fix uninitialized_var.cocci warning
Date:   Mon, 28 Feb 2022 22:06:18 +0800
Message-Id: <20220228140619.17761-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0052.apcprd04.prod.outlook.com
 (2603:1096:202:14::20) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fcb1023-959d-4000-9bdd-08d9fac387c3
X-MS-TrafficTypeDiagnostic: SEYPR06MB5301:EE_
X-Microsoft-Antispam-PRVS: <SEYPR06MB530180C94700280ABA10C88CC7019@SEYPR06MB5301.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RxAo7aiRMrQVBIWomX677qQGj2pwPzoHRIHCH9JYWb5FhVrrr/5y9GWJ4GAfKVPnrpimxb7W7zowCT6FI04mgwqLnXNcV1kBsE2Hs30xJjr1yZGWCUQM0IDvrxvcISklmyxsGuKoJolO+7CxbPSP0WXBxPDCG9K1/ixsMBsLsFVIFYkAUQR90yr78eHv+7l23ZLecJluwvygoMP3+qnuIkPAa0n/tpqn6voaJ3sQzGoxJ8Xw9OEJ3yWEnVNAJ+GJb3KWbF+ie/qWioOJludpGwlVTDdsQs0k32omkjB+w3i7BjNaq8PntJ92DRLcPK6ps/e8GM0rDlGAw+HXchihgAcBH2JZY0pBwsB6clg30NaK8Prw7cjJf4MjsnoKActw304v/WPkyHNPb9c5JzKHQELT9wz/VMgNNpwToVTsrZnUkxejkrdQGzE08PVO1+Dk9rLZgw6mm4vpYd1sXkYNg2+c1Fba6WnUqiAxRgpMznZcDpe09dUDhDF4vhQ743C1h8p++CHNXwXUPW6S3HfDlOQv9ZEeuseqSK9UJCIZfDENRx2GPU38oPwkfoqJkKbrAk+v/km1eVmIccxdHKQkNH4+Kqu9MKgW4DXUPIVjMd/eClaIStS2qv+mqs3mKVzkjJNYxzdz1y7A6/Rpy0i2fhMj4H+mwHxoYW87qR9e/1L0tec6BJfyz974z16rM51q7lCKflvwy5Mw8Y+Uq7W1pLL6uELYwsRsOm9rdsfavS2WkZOvlHkEYDlXtmE8Oka6GNVT1AvlS0IKWxxc88yBTwF/2ECyJ+fLMrvj1egmtPs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(2906002)(8936002)(66476007)(66556008)(36756003)(66946007)(52116002)(5660300002)(6512007)(6506007)(6666004)(8676002)(966005)(2616005)(316002)(26005)(6486002)(83380400001)(38350700002)(38100700002)(86362001)(1076003)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Oh+9pZ2q5X0Y/WI2yIUz8l2+3X+TFqsaJz3Qqr+3catjDDwEqh8deP0OMai?=
 =?us-ascii?Q?+YpzFH2RAPvqCL/i050iJTA54lx5YElIIAeQd0QhLtHYjT6YXyAO8QkCR9JD?=
 =?us-ascii?Q?22DsxRnaZK32srFunfOa411uEZSF6tx+6L0HWOC4BDRW+Sw6K+JkB5FSkhRI?=
 =?us-ascii?Q?sy/H3q1QIZqX8cTudMEQ732k6EMxlYon2+Q1l3E/m/n/ZxUoEwU+A+SG53/J?=
 =?us-ascii?Q?KpjFPBVKgn8+vXVJTSiyfsHTvaAJOT/bSXRX9HA6a0f7Du73RawOdEHmpzbQ?=
 =?us-ascii?Q?YvzhXvZtQ/K1hnBf/FcL3SD5wobM3yqXoGAOK4HcqpzYr4rJ6Rp2ws59Q2i8?=
 =?us-ascii?Q?lri2ywzA9kY9kjTsihRQklpETPE3l+83iWMeR1rKKt8Jkw37ttW7eAWkSum7?=
 =?us-ascii?Q?etR/lwOTzvAn1FZXKNT8DTrB4TkPIoq5leCcK7kh/MDoqPLfxAJs/EFaGBSP?=
 =?us-ascii?Q?FXNtVq8Dtc5SQOLPJtUcUPsfY0m8hXF4u/JnHL+Ep/5+aPmIwh7M8HZSfFDx?=
 =?us-ascii?Q?fDiMGGM68U8X19l1pAj/njxX+qWVPjOJhp3VKY9cfYBAlt5lyrWEHhT0wbL+?=
 =?us-ascii?Q?O/qySWgdDcCd5+G6StNB/Qvl5KKKPbUnChjXnjAmNIKY1iBafggwfnQvOdKZ?=
 =?us-ascii?Q?sXgJZNOC8ss8/0FnY+rY47LnvZ93C9mv/u/e3YAtzwOawVONUDVOYReeUyi9?=
 =?us-ascii?Q?CP8lXHIk3YA6IPemv1B7fOnFKl2HRAQjPLuhyq1LfGtT08my7CQh9k3o+FPB?=
 =?us-ascii?Q?TXP66bUVpDriSMJy+WkUumLcdA5uu3q5SFjppkKQDvRPeSrttRMLYPykGgfz?=
 =?us-ascii?Q?28HMusyovonCZcONzSex/yk8f/wVtSvnsYeq87r1WkD3qsy24eq9alQD7d8h?=
 =?us-ascii?Q?vWyGDoCfYqx5otC1f8gpn2MZMGHN7x9F6/ZVEWNqh9vn6KruwahiCwVnIBzu?=
 =?us-ascii?Q?14jwz0HmVivhqH+daeGluhrL9SS6PzFQFn8AsliDXVcOti5uOBRwFs+j6xn8?=
 =?us-ascii?Q?zSEFAyAaP7LFKu3CIjNBSKvCgYYVBIVxgnJsJVuDRBNlE/oozqZlc8N3BvxL?=
 =?us-ascii?Q?h1bEBsOwGTAnwLpF99L7f++alahqXpmpfJ8aGDyFPSBgN9/JKzFSLdp/0lz/?=
 =?us-ascii?Q?PojZGkS4sYUMT66aduTo3ccJjbwqFrR1KrQ9+BvyFPItEOuka19A8Tf7TF62?=
 =?us-ascii?Q?1EA9PKFehvAEojkOsRjBUoi/Pv+cl4ysLKoeyKP4GQm1SmBpQQsXPADPT895?=
 =?us-ascii?Q?dA6QlB01K+vgikHz6YIJe9LZKUMqN83+BpoJZ+XaQaZF7/L0DWg/3xbWV7EM?=
 =?us-ascii?Q?pKqtLFE5wM7KNZEM4EjtxopMy5zZWPPO6t3KNkKuy7EH2tgUj5N2Whe6et8k?=
 =?us-ascii?Q?brtK+0hpsKUGMdP7EX1OqL9DlWKDYOAmohEo0bBBjxQ+HekDpnP16akPMVjw?=
 =?us-ascii?Q?++/XCJmUDhRwURhVBsTcgSCl+cPHdrum/i5SbY6GvLaoydokNdAW1H4d/meU?=
 =?us-ascii?Q?u8l4+Ft9AlObCilt5cqLpONwjSbMWhO3f2zph2jo58r1+WXFvD9IUnIArWjM?=
 =?us-ascii?Q?SJVBgcwxUuF0OiWhC/T3xhe0FKBBRn+OUmvB5NmN1q0lgqiQIDVnNSmZ0PKa?=
 =?us-ascii?Q?lOZumwl4F9SNWZwTW3TS5IE=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fcb1023-959d-4000-9bdd-08d9fac387c3
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 14:06:35.6227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OSEXm3Uk9kdYq0p95h737xYR9XsSEMUwSjU/37FDlKTzkHzivWe+aysA1talB+tsiqsxYmj/1Rt2YjJq94WCwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5301
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix following coccicheck warning:
lib/glob.c:48:40-41: WARNING this kind of initialization is deprecated.

`char const *back_str = back_str` has the same form of
uninitialized_var() macro. I remove the redundant assignement. It has
been tested with gcc (Debian 8.3.0-6) 8.3.0.

The patch which removed uninitialized_var() is:
https://lore.kernel.org/all/20121028102007.GA7547@gmail.com/
And there is very few "/* GCC */" comments in the Linux kernel code now.

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 lib/glob.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/glob.c b/lib/glob.c
index 85ecbda45cd8..15b73f490720 100644
--- a/lib/glob.c
+++ b/lib/glob.c
@@ -45,7 +45,7 @@ bool __pure glob_match(char const *pat, char const *str)
 	 * (no exception for /), it can be easily proved that there's
 	 * never a need to backtrack multiple levels.
 	 */
-	char const *back_pat = NULL, *back_str = back_str;
+	char const *back_pat = NULL, *back_str;
 
 	/*
 	 * Loop over each token (character or class) in pat, matching
-- 
2.20.1

