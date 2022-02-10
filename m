Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C874B0849
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237419AbiBJIaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:30:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbiBJIaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:30:10 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2105.outbound.protection.outlook.com [40.107.255.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3307A1096
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 00:30:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bI5S5ZIonnQEoEqFTw67AeT3GUdAFizld5wgNZ7Ko2m6KBG/u+ERL06GghB7/BtmnZbrIMPZV8FH1Ohwkie+UWkVs8vXhcvUZzPDyK4GxRAkm4Zw6tlfL4DNM+TDcucDBn41WqN0HkGRc2qJe1SNzNggZCBztQ09T1W5Ehmx8gDMUPh9r8CELi7NDrYUGx19p4rNDJO+MBDwgklWYAHlz/sVTCAIAYZUZcPDzxXhOxVwcbSw6MtyTJmXgrK96/1s5lZAUDmdo7jOD/UjVR6EjKxkPlqT95CzB8Q8GD2MYwwHvlrJVnB2KzFeTvgc6Le9fB99bg4r7kBytK0FvZXZ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiISIcM9l7paF91m3S6xkLnSA3s7jSVELqVf3j8YRkI=;
 b=QTSpxU/UeYmT8Y9MK3SqiD2nL6gYQZ+Z/uHxq3XTnOez2j0pWvFGyCWf1RlsXNt9HBi0KN/bUdOxqCaxrj5WkkLzMN/fSfP2B6H9DnnxJUc2v6Js3IXSwi0JLYeAk454tXPXUPu3hj9ww7Ea6adaono2daAFLlxBLB94uJK5m2KZadah8b1QYPs7KSYqpWwYic1Lk+cHFezY/loBb9oZBlfiKtKk5NMQelRPTgr0jMvgJl/EztU5LKq2IEpSJP7NRUkVmK/iTC33OS6ukDm7+dtwVlBl0EsJ2hJUhSN5pjeeoDDHsiDA+cT7ff2MD+80YY7AIWob2NODLvy3p7MPwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiISIcM9l7paF91m3S6xkLnSA3s7jSVELqVf3j8YRkI=;
 b=UMBY/jdp1sCF/a/oOx20AUNYoQmxAOkt8awmECMrj7rdjyTU9s7DRMsvEM3hjgwCIEURoCoTCYxsdEgKtn3A/4UyTiY1dbKlOs+A65IpqNdNKLmjRCmrutCJMxAj+DUKII+etFU6y0e639okD7lCFJQRjeYJF0X7xNiOJMDp0qY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by PSAPR06MB4005.apcprd06.prod.outlook.com (2603:1096:301:3a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 10 Feb
 2022 08:30:10 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb%4]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 08:30:10 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] gpu: drm: i915: use time_after_eq() instead of jiffies judgment
Date:   Thu, 10 Feb 2022 00:30:01 -0800
Message-Id: <1644481802-14578-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0401CA0014.apcprd04.prod.outlook.com
 (2603:1096:3:1::24) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7adf405f-997a-4272-6559-08d9ec6f8cbf
X-MS-TrafficTypeDiagnostic: PSAPR06MB4005:EE_
X-Microsoft-Antispam-PRVS: <PSAPR06MB4005F0E8F455B96DBC52FA67BD2F9@PSAPR06MB4005.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z7IQA1rH4swEDgY3h8WU4Ou/0ObQtWe4TENrrzlT9llBD3VVJbSqAhXn5SZtgdwPbm2E6Zrjq/IvLWUS+M36DxIA2pgQqZScSmWU4joXX1wm/GZdNiDUW5RIObJJejOi8JfzwkeyjRjicOrqQGxnZfhyRQFPL9uTt6AewvsN8adK+2canWEqa1KM5Rwl8iiyq8uNsNqbBlhJaPSyN0egH/Cj3Zf/buBlE2TN0gF5zi9x7ZImL9VYG28qEoUfhKTKKgCtF8O7tmf84us/6RsN8Dw3MYxobUta/oaD7aT+zD1BdAwbhTo9WOBTFY2uQHP9bcUeJHzAUEarediL79e4g8uYi/BPfVlkfdG/YuelsRRuraD0WOrjoSdSx6Kj5B9nzVAUeSTfa4V4X0ylX/KciLO+uchJ8YgWdgIhLjFkrAn+yBrpshqW9nuBcGexWT7dvryoN1bZE8rk7NlunVNw/D8bTxQht6tjWtezFpj1mYTtnXLctldvn3ic6LNB/SQkxOK8zbGA/jKHFjHONkM5WGhufvSM7qcJladMpY0ER4LbgrP0JZbgv0ZOZd9gnOSlKXEQR2Px6racFIK+DavmzsNvD2LF878mJGB/jnYFWuyFdc7ZRCYwTtDlubLzA0bmFXwVZUtdXB38fgZvfcX+sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(8676002)(66946007)(5660300002)(4744005)(52116002)(8936002)(38100700002)(38350700002)(66556008)(6666004)(6512007)(6506007)(4326008)(6486002)(316002)(186003)(2616005)(110136005)(36756003)(86362001)(508600001)(83380400001)(107886003)(26005)(66476007)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JTmvbm++szbCu4a+JmZYIcesiBRul9VNTEumJbadKqOqSKlzoGGwM30tfpgKKb8lCW9mFCk2Cz1HQN1W9dZWQLFUwKixS8u+pKBDv3Abvavau10OHcbPUvcxZ6/MRcLlrLSXqz2q5lJJXpV9w6aWwd1ikFaNcMwB45aAwPN5/iqmAxmW4aUktWwQ5U0UwMlbmN2KQgkjR0P+Ef8oJqeVHSmGZzrYFk1xwY6nbhj6o/GxxK7/jNNVxRCV6BauBxjUEla7B14i0zHZSSSsTw2InIDKoq+ypcWyZQszxPaBSwr0FIW8nUP9ItoR5nnW+n3cOH8E8bgS6QnVUOmez/avVXXEjI4wPscrReRJTc7e4yegYiDbZZfP+PCXhAjMgdlhj4PXMEG+iGHAkvZw/4WQAbQGFmNJ7g14iK0rPek6uMdvqBsAWqwFQN7WEQpzZ9HQ
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7adf405f-997a-4272-6559-08d9ec6f8cbf
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 08:30:09.9951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FU6EYrE5aFREXPh9DQpZyTtJ2mLx3hEwbeQsQCiW8M+xOeg3yir5MBQ6Sp0jqFCGbHIes/72HpTyGzkLc2m5jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4005
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

It is better use time_xxx() directly instead of jiffies judgment
for understanding.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/gpu/drm/i915/gt/intel_gt_buffer_pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_gt_buffer_pool.c b/drivers/gpu/drm/i915/gt/intel_gt_buffer_pool.c
index 9db3dcb..b289abb
--- a/drivers/gpu/drm/i915/gt/intel_gt_buffer_pool.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt_buffer_pool.c
@@ -56,7 +56,7 @@ static bool pool_free_older_than(struct intel_gt_buffer_pool *pool, long keep)
 				node = list_entry(pos, typeof(*node), link);
 
 				age = READ_ONCE(node->age);
-				if (!age || jiffies - age < keep)
+				if (!age || time_before(jiffies, age + keep))
 					break;
 
 				/* Check we are the first to claim this node */
-- 
2.7.4

