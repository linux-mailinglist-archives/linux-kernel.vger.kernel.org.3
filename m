Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536AC50D0D5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 11:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238865AbiDXJh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 05:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbiDXJhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 05:37:54 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2136.outbound.protection.outlook.com [40.107.255.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BAF205DE
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 02:34:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mf9nWUegVXEKw290C5vH3TT4WLS/qCdxSFxo03IoNZNBXcmJeqkSD6vdeQI9u5tAIayJ7GFoTADoTsCaXpgzOxrLWd3HicZiiqSLcoFNIwTzv7go/bWWr2yLl13z2EMXQetGIIEpHWYq15ZlYWcMwDmPZ2uVfsTbNZ4DAqzJwv8rQ7x5VCQBdRKpwBedoLzv6cQO5KJWmvOXEUEp5HADULe/L/7zk5qy49JZYt7toUL2AC4/cFZ9sU1qcTQ16LScq0DErbC9JQyFANyj6UNQYUDdgj3n7Df37/bDXr0QW434EtjZSmkWIG+njiy28i0ZfEsfqiIOxwjFlgrRJBqFbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7Xm4piBEcxho0DpT/YOvOb7d/WIfaoLAlrD4oP2OpQ=;
 b=MH+QnG9QxhIEkMJWFg82HLfd4gbpnc/VZBrbNXOvvQMxC5+h/QpYc1X6lW02PeEODKBNilmxnGgNIB0okkOO+d2JHQSUUHYf2B/133aa8RMjAH8b5U4ibgXvUzmyCB1XTvilvLCHw1w1aGQGPnmJ45UbXnL1DaVMlywGMgBu04ZWrA5z0+FFEEoLta8ng4dW2kpBg3n7dijtmLEvAfDBqre+hr5uswaQTg1yK/jXtoGQ5KWxhQH9HSpxOPwsz9FpwQ5G1Co1nbNWaYQwrhIyMxeoKLupDlA3Ulb693yFFw8fQZzUzHX0jl8+XtAlAYKBVtzTc5FmBB6kO3qYKxuPqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7Xm4piBEcxho0DpT/YOvOb7d/WIfaoLAlrD4oP2OpQ=;
 b=aNUI90j3lzKPQWIuHfOJQwKrjrwZnYSQYpONQOMFMe6wxBBLU2dOlt4FK2mLlOTdkjMwRZSrPw2K8hxx1317Wt7LiVYfsxxKM3OpSEKzxFNi/MCnFV3Bs19IAlzELhuxlIrM/j35as6siMW+VwukX74G0Lzmn/4G5eiElv59KKU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 TYZPR06MB4335.apcprd06.prod.outlook.com (2603:1096:400:74::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.13; Sun, 24 Apr 2022 09:34:50 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c%7]) with mapi id 15.20.5186.019; Sun, 24 Apr 2022
 09:34:50 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] ring-buffer: simplify if-if to if-else
Date:   Sun, 24 Apr 2022 17:34:41 +0800
Message-Id: <20220424093442.102230-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:202:2e::28) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a062de4-3a3b-4f22-aade-08da25d5aded
X-MS-TrafficTypeDiagnostic: TYZPR06MB4335:EE_
X-Microsoft-Antispam-PRVS: <TYZPR06MB4335CB10B717FF125B49BD9CABF99@TYZPR06MB4335.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SoSvpeetuRn8+pp3qroF2ijwIyYFi9wWMfJOYUHow5Qlt5B3YS5j6bSUPaxIv/tm5NdsLYclqWzGce4l62qUMPAnGXcDtPoTe1hdpG3wgxikUjv4vhGLD0rkiMA9mge4WF7SLUJfmzxrOSfgpEaDCu9aPb8oov4VgiRbFOOON5DloWJ+B0xQLxBKHvMF+GFQkWFGLYBc6l1VHCBJy/aHrl49MIt1Ho67N8eFMIs4eP2NmCxpS7hgO1ra9C+oWHj6yqY+4faMWK++w20q/j7HvEGoeD3PL7bnL0FxCpB8DDyfzhvQ7JOpV5y+h0ne5sl76GhnUvD6EvIPda/FRyKM32LZ4x8ny9QudsOEvF9bMBBzlRRCGVv+TiKj+kvOP//w5B28RXdORJmvHbASbo9d0xRBNu9rIALUtDfdgY0Lw0Hjq9AGICxM8zImgr6vGCzvvk1E7Vf26Zk9AETeO8o5T8G38T6NZ9OY4XzFZ1kZS98qySMlzKHWW5znvMVrnynVPw8D4YiCJhn6Qjp0j6lx2y4SqpcV7NiM36FW36idbihQ0UKsiH8BP5Yfrk6h02YXw3Vj3GnWwnnJwXORvN/rZpM/7yxn+JhSkRmo4q2Ors1rRElJGd3/3dp4/ncjwNi07lrzouMVYZUnjTJWgUF1X5RhfHaXcboeyXQ996f8Nafv7mNgC6stjkEvjaT55jHfAwZgornHPi+/g6bs+FWnJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(86362001)(2616005)(107886003)(83380400001)(1076003)(4326008)(508600001)(66556008)(8676002)(4744005)(186003)(66476007)(52116002)(8936002)(6486002)(6512007)(26005)(6506007)(316002)(6666004)(66946007)(38100700002)(38350700002)(5660300002)(110136005)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xyChDSW3MaF9gQJhtJ61Q09bCdjOcuWx9fyqYwmm5kI4U+P9ePPHpJqEtDEY?=
 =?us-ascii?Q?z6GKyOX5jUzElcHamCNk+FT+djpOwcTXAjAxYivobdt9glLRjLaFILbpMYyL?=
 =?us-ascii?Q?FwJQZ51NduyhPKAQVbOaB4xavIcwg8lD+D+fb+PPDJfFY30llpB1R8CcW3pO?=
 =?us-ascii?Q?mMrNkF9imxRY/B7+8zjkJNrCXy2mhXnH3rOEE8LK0W7x2gA4V8fRabewLVIW?=
 =?us-ascii?Q?GsNz7pmqtLuPKM/NL7/8/hAnNGcuOLV9YPJlkYS/VSOvoWoOmrDPZcmhtzCF?=
 =?us-ascii?Q?wCovGZDjK2X2qValcezQJ5vpqdJ9MXmp+21oatDm4FPl57m4EGjJrs+oaREI?=
 =?us-ascii?Q?9eVN468RyOrItY+jRUc8c7wuI+1u24G5vNf34E8VOTIQjia/YVxi68G1gYwb?=
 =?us-ascii?Q?K5tx8Qu+4dBeSnPA0qOPzjNKaGfWZcQU/hqyFK0qpB44BTyhhb41ow/9tUrP?=
 =?us-ascii?Q?H+WT+dgSnMvBd4cL5xXVxIyH8CXLdWDqhSy7SBRnEppQ0U9o87V7hK+8CduP?=
 =?us-ascii?Q?zxhaT+Sh+EZKsddWnRd2NXzwezX+h+iORe/tJ6kImFIZ4asEwS1kWuqt13hO?=
 =?us-ascii?Q?Rv7Jb7J5RJ0AnfcZG/g5ZkiqK6r0Ps7kFtjmt55uwsQ95vvQ2Y306xhnqxdn?=
 =?us-ascii?Q?XvIBL21UJbO+Qpz0vT5VEpFUJGrDL0WWMVDoQ+iPc3LrHWjtwP645vRF+jba?=
 =?us-ascii?Q?+EiOJ88TxUbh64wnLsUiG71AEvDT23g1ilvrTueiKFRkb2EucHndT9ZKTxEn?=
 =?us-ascii?Q?haRww5ZIhd6gnMhV/curZ9K0f/NHtDfm+pGYZ5bawj3kRBtB+mT5dh84fjqb?=
 =?us-ascii?Q?HbqO+veS1uDFIIaXHShef6FgkiC6P6Jvi9rtQYcs6G8cRki1Ef/yUHOhvm0t?=
 =?us-ascii?Q?xzjrCN/WENyF+eDbwWE6ZcglF12h0JBGfN4Ke0qaCsou6vjMu9brp8gxxCC+?=
 =?us-ascii?Q?iqKHdWBzobj8yZdw/AatAK7ZVYTwoP59SBdiJOMiaPsGuuixciEK1if9XBKx?=
 =?us-ascii?Q?pMnnqp29m+cUAKvzN1VPRYpaeOiiVuGDSQk4z5G6DUcJ7ZVBzC6wvlmEH2Mv?=
 =?us-ascii?Q?LD3nMWxNY3bJvI8OnuYeFgBFGnK9YOqx6B0CpOPB8Rna7jlMiAE+ozq5uNu1?=
 =?us-ascii?Q?3HuGaiHGtEwCAwWHbkacoJAxlOoRENt/GbRpZMZuZapptRyttUJ02HpvScr7?=
 =?us-ascii?Q?E/7Qk0BauHD9aNDUIFvXXT3kUhX4kcpwBjjZMoG/nH2JvNhRd6OkWYz7mLZI?=
 =?us-ascii?Q?TSRSoUeKFFTTzcrNDHZDHSkOYUerz6+ok3fK8yTLpvXULEEh/bY6H9ZQI8Zb?=
 =?us-ascii?Q?lvZTft2+fvZPC6qC110/lJaPtYOUxZDf/YJcg3Wr+Kkvim5I9W1F8uCGExuU?=
 =?us-ascii?Q?k3nwEsqt3Inzk7LBToVbNzmb4Kd/bFEULAWaPvlj1bY0nE//JsP2OhcTM8Yk?=
 =?us-ascii?Q?HZkqiVFFv+PwZDqXO6t9RlyI/Dq3PQc/osaLBPDs8dMG3OjKPB4iB1s/3UfB?=
 =?us-ascii?Q?hrLlJdhXuHHauQk7kfXTjgBUP35XOGL0fURBRqX2hXGJVNQGC/HUi6Tvxqyq?=
 =?us-ascii?Q?uCWhn/xa8alzpT4P6E5y9UbF2mRtrMCXjL846RQyzvtSpt4/19/VhpDw+8L1?=
 =?us-ascii?Q?k3Ilo74K2NpgwUsjOukYrbBwCjs438zc7Le/UPXYJOD07UzSyOALxVf1UhJ6?=
 =?us-ascii?Q?o4CSLFB9Lxn2bAwO76KFbE1eu/59XFHcXRaCi6PyIdzw5WNyAntGAuDa/nkW?=
 =?us-ascii?Q?K44zPRdOsw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a062de4-3a3b-4f22-aade-08da25d5aded
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2022 09:34:50.5142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LXon5KOUEMw6BUrP3CiPxjvh+iWJSrZhH1udAAaDGsJxGfUYwC3eXNtK1OKpMBZIK20UM0zt1pUNBvWlwTk9Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4335
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use if and else instead of if(A) and if (!A).

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 05dfc7a12d3d..0fa21bd1a1e9 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6014,7 +6014,7 @@ static __init int test_ringbuffer(void)
 		if (total_lost)
 			pr_info(" With dropped events, record len and size may not match\n"
 				" alloced and written from above\n");
-		if (!total_lost) {
+		else {
 			if (RB_WARN_ON(buffer, total_len != total_alloc ||
 				       total_size != total_written))
 				break;
-- 
2.35.1

