Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2CE50B691
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 13:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378406AbiDVLy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 07:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbiDVLyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 07:54:54 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2116.outbound.protection.outlook.com [40.107.215.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86B65641A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 04:52:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RX3U8CovdUi3+ko2/w0gLHWz3KLuRJixmGjww9yV5x3zD9OaskfHhgG/kh2HBE5qF458f/nia0aNMYZ5FAWiGyIWYtRsDN1x+mwLVsrRS7dybpwZx9DAfXmzUnA9fbrXJSjMxQApgVNdD+BVb9LGGQUnG2xvJ44WeJQEU1RhYJ/kJC82zxTYfe6dD+qrj2HZ5l5rpnSFVjGMq054Jg+q4rCT5u+sq1+fjM1YS9vnvvVEfiCiRXnzr53UDbQ2gjj1Z6tyU++n+6E5vu0Vf/yiNd4vkuXSEUzRJWuLEwenckUGCrAmgoaT1QUQHOS7DhI6+AuFSBCXIJwVc7f97FclPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7Ujik/ooAuD/GkoVwxWFtJaphTT0YV+EaihNC7QnmY=;
 b=m6euAHVUJzQG3UUEysIt8nWH2ZwKFhkHl4XP9vJ90V4ADILb/Yu9IRsoutp6dPXWXykTy8oCKPd/Sn6ySXM65Rs9Kd7NQYxUPjfFR5OXO07yKK8qlbYcdsPB07FpClMwEcWbjD3H6Cnsx8WB+5M7jCEwsVmqR85vZO+HU88UJ/Sg0CYu53CIjC08J4ce8Hc6JT0SeKMZcQiv+Gwm7oo7gjFXEO6nk8Fl4et1SIVTP+S/rx+oQjUeFSsy2U/uDMZVgry8hfuSn7miTkk2J28+djRpZdBmNQHudvuWomlw/VCFPWpaEJpZs6wdBWeXayG17FlqXD3j7Xm/UpgSjXriBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7Ujik/ooAuD/GkoVwxWFtJaphTT0YV+EaihNC7QnmY=;
 b=cblnl1M3JBXuV6Kvp0zauJGXrT0gqHlmL61FZSQSRkUP0jZYDFSl6OTbdjQinIuQotnWJeogIM3Ta2UMC+Qd6q7/uiaST3s61G3aI92aS7WKVawdsyrh4WWZ+N7vf5UfFfArwIemZfJuQKHF1Nsi2gcFk5Vooce8WLqSuUzrG1k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SG2PR06MB3726.apcprd06.prod.outlook.com (2603:1096:4:d2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 22 Apr
 2022 11:51:58 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc%6]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 11:51:58 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        Wang Qing <wangqing@vivo.com>
Subject: [PATCH V2 0/2] Add complex scheduler level for arm64
Date:   Fri, 22 Apr 2022 04:51:24 -0700
Message-Id: <1650628289-67716-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0112.apcprd03.prod.outlook.com
 (2603:1096:4:91::16) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32a68742-96ee-4d04-2764-08da24568117
X-MS-TrafficTypeDiagnostic: SG2PR06MB3726:EE_
X-Microsoft-Antispam-PRVS: <SG2PR06MB3726B6C6486746A58EE1CC8CBDF79@SG2PR06MB3726.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v0PfygclxXW8NpDy8I0sdIaEyxXuln9h+0uK0BjnJAxyCwNqVF6pOXjMr146GsbX4RLiK3EK/nHrG/0v0I3IIcRy1FXABVgSu83qpYC556EC2mN5ABwUgA2OaCode4a01CGnGOdPE6w8z+QbE108X2m63Tbdy2WwWRIMxqWH0E/O311kHFJ8VV2dkTno8dC9XMu/B6uhbvcdU5TAdCYJtN6BW1lPKb8BPQBytOuqk0EYq0N2oebvQOPLuR746Nxvd7/OvleRKtKWcIfuvJHxbIs+8d1fmrfambUilwqBNZWnn/SPviLOPhQP7GRz9rUEMzejCYPNXzjPHNW5o5vwTbR2AQ5/cGfDQ9rAtOd7oKiQI1gFjJD7ixEU4YrVSai5+vaWQgo1HA+lAHEhvn47CHBfEa8oK8RDwBDevPRD3qqVms+EB3rlzTpVmy8gA0u0ZuvA31S+G/coB3g8dRBtpcbHC39GMqqkBMyulEA8zgp2XXrFZH/OMAgUNPbg0JLzwoPQAHUdXONnm5jY/JzsLqwg3kEESnSSYHXlWYMRSzkMDt6HpNGU2aTRvyN+WMLSktxlv/x7JeVQxq71nA7GMnOL3g6tPJY7ONx0cDhIGohbJwGxfXUDnUTZ08GF2qukFvVXCMfhXdy8UPOkrrkBtBV8MNACGX+WJX3FC6na/Bh5/9W+4SUzLj10nglHq0vVxCeS5Whsp0YIoyLl0yp/3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(107886003)(66946007)(83380400001)(5660300002)(316002)(26005)(6666004)(6506007)(6512007)(6486002)(52116002)(508600001)(36756003)(4744005)(66556008)(66476007)(86362001)(2616005)(110136005)(8936002)(8676002)(38100700002)(38350700002)(2906002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rx0Rh4+Wv5jziUqRMHTJy6BTjwdj65VZh3ellRqUus0T7B2I4xmUp3DjpQ3z?=
 =?us-ascii?Q?A70D4onkfaetCLdbIviDk+VsqeOMmYoHLbjMzW6qhShxxk3qbzatdA8Ns1+d?=
 =?us-ascii?Q?ujSS20syF2U9oZFt61IJebUN5eRkKes5J2xHhIkLjT2zswG+VuLtsnVUvbf7?=
 =?us-ascii?Q?eyv5Ni9lVHI8pp4arWrbm1Q95TyRKsnTuX0fBYtGrSHsgbsBlZLQvzO38Zyn?=
 =?us-ascii?Q?qRwaopESnk5ZtrShkOsbUuNgQKMYiFUHQ2Ojla71VwUzHovifIgXITYfi3uM?=
 =?us-ascii?Q?VZNyscA3oeMSRTzpnqBc8qTxKbqTMqXlZN6IZcYjsB3pp+s0EIn5HYZmSTmM?=
 =?us-ascii?Q?0uSX2JbR+S8I/FWZHaq+0jgK9mmBKYV1iA3APtkWzkhYoGpr+HN4G36CoWxl?=
 =?us-ascii?Q?1SX2XmynIqmr+FDdOGgRzYsRFXNwtVkrraXawlHuDhxR9oGVkqdmRJ0Oy3rx?=
 =?us-ascii?Q?w4Ey7YSgCBq53C6QGthgcvDGJFj1nbo5Hb1gbZv2PK7ulnPFk+SuWPmx809k?=
 =?us-ascii?Q?00rYHcxufYzrNg1E7J8dxfXIct1fzRFzkCmlrD0yvzHg9s9s8+u5MWbHGtcO?=
 =?us-ascii?Q?Gd+7TatJKgr0miOoqZrN8D3XQIenNXMCicAfln5aThs+DFGL+yswZ72AF0hx?=
 =?us-ascii?Q?QMg+kse6JCW3gxXWE0Qvwc4eg+Xj5nWby5Jbdyo6NMK5l+2E+gcvfHZBcs3u?=
 =?us-ascii?Q?YJ4Z3yDMKibX6cYjANP0U6+0A+1bXgNjZxxo3lqo8pjQr/0NwtUagkrtiNia?=
 =?us-ascii?Q?yNaWsXcNBd1rJXwBpjZwvoWL9qf4pa6CNDshK5a4Uuq1HSr+8pcVYrhNCCR/?=
 =?us-ascii?Q?zna4/muHZlEb8XkH1MzW94xZwjIIFZn7B8PBUPl8knYx3kLz76k7K5UNNsnw?=
 =?us-ascii?Q?5xYbmHZ2yP7VX+dWA38pt83hFMYRY11JzP6FudX1ziGr+E7gcbVUIqHuhP6k?=
 =?us-ascii?Q?SPgyGTLUMU11MQzULCOeATpuR2PMal00tReEfasM1K4YFbURzfk4KvZ7a62+?=
 =?us-ascii?Q?hOhim+OwqMMwguesoGAkOb7XU3jErumbk6X7lIY1I48EM1Oi8qBH6OVfVf3z?=
 =?us-ascii?Q?1HST07z/g9m4vVoqAmWl9B4hbO5sp7TRyrt7xgxeIF/OQDJ3lg9u8s639GIY?=
 =?us-ascii?Q?r/jFjxyatob0jjScEMX2wGFZ6rNx5t+efQZt1voYxzdwJ0rW/ct+1fa2NgSO?=
 =?us-ascii?Q?PiOt0kAH9EdZKQYj26NhHGPfeEPIfarxwW/PTpymzXLwTvirIpvL4soqU2kI?=
 =?us-ascii?Q?cbg7uBBhX/yG60MLiQU6b/zu27KFEybx0AK4rsLFGc7Mp+q8YSKey8EmakxA?=
 =?us-ascii?Q?cwEaCcJYDtczkzShPyhCCqGJUFKM5IDizDr4cU1dvzlLdts1FhTDl1zrZU99?=
 =?us-ascii?Q?cb93NPMFKASMMH1j9pZEeAT590a6lrameOoSvYiXkWqO3s6PKDa5MvRuWXaS?=
 =?us-ascii?Q?wDhTucZCjOI7nH6ZHR7W++MVtgCPQG+BUhT0u52RcAUs54QS/n2Uk/F2Bxck?=
 =?us-ascii?Q?LupLu6gEe8zwEyUypUhmo5aN+idVvWbcPiosnwjJEelp7yV8fMLAytesJ6B0?=
 =?us-ascii?Q?QjTW/MGzQz6yJb6CzHAikENQlfRohnUz89L999w5dqFURWJbSFtiRu/EEHx/?=
 =?us-ascii?Q?/fERaEpOLAjGGnrlxg4T6HJxJ7U3+6M81KIZ3ikG37M3pA1k2K5xXWGTLPXP?=
 =?us-ascii?Q?39QbGk99y4aAR/75jbdZiheevbQvSgKC2AL0RFjr4ejPpGelIHiIHJIelWrC?=
 =?us-ascii?Q?YhTf3AN3IA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a68742-96ee-4d04-2764-08da24568117
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 11:51:58.0880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oZHYIl3TuHgPCk5nZwYgIO1Pqydi40/WHw+JRFQozDdO5qJ6DhKf0zDAJppGewUi25jzqZdur1oNc28+kFrHgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3726
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

The DSU cluster supports blocks that are called complexes
which contain up to two cores of the same type and some shared logic,
which sharing some logic between the cores can make a complex area efficient.

Complex also can be considered as a shared cache group smaller
than cluster.

This patch adds complex level for complexs by parsing cache topology
form DT. It will directly benefit a lot of workload which loves more
resources such as memory bandwidth, caches.

Note this patch only handle the DT case.

V2:
fix commit log and loop more

wangqing (2):
  arch_topology: support for describing cache topology from DT
  arm64: Add complex scheduler level for arm64

 arch/arm64/Kconfig            | 13 ++++++++++
 arch/arm64/kernel/smp.c       | 48 ++++++++++++++++++++++++++++++++++-
 drivers/base/arch_topology.c  | 47 +++++++++++++++++++++++++++++++++-
 include/linux/arch_topology.h |  3 +++
 4 files changed, 109 insertions(+), 2 deletions(-)

-- 
2.7.4

