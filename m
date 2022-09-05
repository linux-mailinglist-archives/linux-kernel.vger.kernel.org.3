Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB665AD405
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 15:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238035AbiIENf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 09:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237979AbiIENe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 09:34:59 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60076.outbound.protection.outlook.com [40.107.6.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BE621E08
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 06:34:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvtBDJOXirtotqAURCOXhbcpiocZQ6CnE5Rs/lZdtVe66x/90emlhEpAitpqh9iIj0Yn7lsyx1qKzZ3V3MLm+0jxL474AqzAc58lK5bKSe+kTixk/UYUitQThOUgR9ZJMX/HSW0fY2WUU/W7AjTu/jiZtAa9U2F/ywCaeWkAVpnNvw8wxCEtm3i0NxDtFiYdi3pQChYg6mpawOUUgxlodPrYyVWYFZNqF7ysI3wy6UZCngfIFn1uEV8MKDKrJfhQnIF4kZ//HzQYcirZrwp0MuOub+6J+daP5lVsQNnQ26vOmyJvYWLsM4AD9KHlsgAgcOo3ZLlKO6mxf5fiO4ai/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GndXkJkPfORYmKcovuFi24Udklu9kGU68uV6SYGtSs=;
 b=dJVDcPiosVw9DIzQjmS91LVBzqVeAIXIGcTvL4sSaVn3HiTbJyptimIOeLqkn0zPTG5gC4319jbYi3vhDEMJvyYbuesjv4EstVKrhffvmUW8ybsT+Eoau39h5j8zAm4DkLs1ExQtnHzurf6Gqdu1w5B9eO1zRraVxS1V1sF1iVFdwRgzhuokGffEzKGIyk01161Y8NBw2knwMyz1OHVk0GYygFIqZ9t9bQW3qdRNu7mm9Xj0G88MXzbv+XYCxvZTVDHqQl1u5nYw1lPLM2dFU9HHkilsH9Bm7/e+QP3aIK22ZZAJUUXkG9c/1RgbtxKL/Kjj03TRtuFB1rGtT6vKLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GndXkJkPfORYmKcovuFi24Udklu9kGU68uV6SYGtSs=;
 b=gkbLGv8XPQ3uQVQepaoFdt5E6aaUDgnUDC3KvkwrNUyp1s0o1MhOqi62Y6UTEovJChpRdmIYg6nvIirLxMCZikTh1baNwgRYtLbBOqKqDBX2jUjXNJLNU8zjoyJFhAaIHKnC/iFJNRnr9KLLIKGn9zrKCb6Nf4PEyctMxaHpDb8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AM0PR04MB5585.eurprd04.prod.outlook.com (2603:10a6:208:133::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Mon, 5 Sep
 2022 13:34:51 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::6cde:8704:ed0a:c87b%4]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 13:34:51 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     gaurav.jain@nxp.com, sahil.malhotra@nxp.com,
        kshitiz.varshney@nxp.com, horia.geanta@nxp.com,
        linux-kernel@vger.kernel.org, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [RFC PATCH HBK: 2/8] hw-bound-key: flag-is_hbk added to the tfm
Date:   Mon,  5 Sep 2022 20:06:25 +0530
Message-Id: <20220905143631.2832-3-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220905143631.2832-1-pankaj.gupta@nxp.com>
References: <20220905143631.2832-1-pankaj.gupta@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0173.apcprd04.prod.outlook.com (2603:1096:4::35)
 To DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c6bcd7f-bca4-4467-0244-08da8f4368aa
X-MS-TrafficTypeDiagnostic: AM0PR04MB5585:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: stZd2BLZuU8T51Mf5KrKqhkyDXbNvY5UPIzsxS5pmdG+CrefRoD60AQujWbJToRFb1OCDjHOmJQncq8BTLZO1RsFQ858PWrJqfN9nhUx6/QadDHVPxkEqn+Cc6W7No+UGaOOsiwyG3S+XQU9pKAf+2BszKRD+1QeQxAanQoaekloGh+2z9sl1bArlmxJNUHGidJtmqsBVqnzOZiiMJZgAF0lHzpICJGP4KYns+jVMU0Vhx0j8L9IzJjJGpMj1CE27gU5ZSGeNElroH166U4uW9bwsck5qy0kAnZV4ghtdTP+bTGoyTRzwNi0Wg28fYhKaK1IVx5sILaIjhj7jnnYf0HGLOm4QMkv0WNonKh5D3ktCXA6MfuwNrmC+uVN0caHUtls3JBwah224SRCj4l0jqyVnpiYGyfyD0iX6I+O8zEHK5Y2EqocfmkRRdA6BoW/3OVC8FDEq3Hd19YSIjzBARQTvsnpcn9j0aIDYjTQyf9dXsUzmjKybzXJXq9XeAthqTe3IxCzV5NAJ06gfkE+Zo84w2Kgr1/+/8fV7QXmcQjU8N0giT4/9oFVVc9EczXSUx2Y20/xumtJ218ws4AZIpuJuwjrX8mEX/z2ODd5zwUeruRgXNIH84rqEjcnujI5VtSY0U361dKXrG8dkRmOOy0RClgZ/xtZFLD3T1fH5DQLPVET7nC45Cw1OpApAN6PtWASl62WU83Xo7GKXlHh+ONIhLgV8V/pM4yILHM3SB//kf/7u9VSdLX6fb9XzAxtRQx9ZP1WQtJzzV977EKOJa1fcdzIYer/GDXkySVz8K8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(4744005)(316002)(86362001)(6636002)(36756003)(2906002)(38350700002)(38100700002)(44832011)(8936002)(5660300002)(8676002)(4326008)(66476007)(66946007)(6512007)(41300700001)(6486002)(2616005)(1076003)(186003)(6666004)(6506007)(478600001)(66556008)(26005)(52116002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3sZcmoe6GOhyQY2Unr6e5lqNnVV4FFwe93dcVIrbL1EENbDoa11ihNBLICm0?=
 =?us-ascii?Q?iHIkRapcHIQsDpfEeNfj4QieWFnvkqL9gAhafQdtnVg1DHgFqrtwCBzdVLhi?=
 =?us-ascii?Q?Bxo2E6dHOKJIp84JHurUhfEE53ZmS0OdY2RLEr+495VxK00p1jHg3qNlONLG?=
 =?us-ascii?Q?ljb8nKjkxXXUmRsbyZiBO9Ads2U0AV2Vnx261DBG0qa78Tvybl0aQDXDdfTI?=
 =?us-ascii?Q?CWspPfxDLmw4Q/mb4nxIWIeywiYE6B1p2BSaT2QH5HQtnC9dDZ9BvBmG6OUm?=
 =?us-ascii?Q?HWNIkIkuIKuNyxXz0Wh96RNG2ipSDZXoDlzIJeVYdmmY/PG305NLu9c6Y7Hb?=
 =?us-ascii?Q?jSYrOP4acDz1NgJLJ8uKp1DukWwEnPDhT798b3ehYFef2gzM/5yZ7Aii6dar?=
 =?us-ascii?Q?6RepwCIYgA2xFtcfNTaf9Q7RHD4Bedh+MeueUusZPN9Wu+jF6jE9KnL6FgQt?=
 =?us-ascii?Q?IRdouFB+/n5o2f8ch5h9ssfHN3fj/uSAgOcpKhU2Vm9G3GXNknCJTDLdutLP?=
 =?us-ascii?Q?jsb/H/eWeeOBnmCIBl2rjAhX6NGCdYXvrOLC6yLnIylgvNFoum0TCvoP6MiR?=
 =?us-ascii?Q?fzjqWXhHVBwFm/3V4SI4ArJW+ty8ZZ1ki2zXoGtdyXvXnAI0ibPMqAR6IqGB?=
 =?us-ascii?Q?NQBkBYXO8IVxBz4ZJ96VmW000YJh3V0bxdlDRn+GFn/C4bPi2ZidRrAB3YbG?=
 =?us-ascii?Q?Zyd+iGcjkXQ94+PQZqqPGNjM9uopOMQ0VRFz3LwyscTaHO7Bts9ZbqnSClsM?=
 =?us-ascii?Q?VIBu+sEay+NIqtaSVaVb8g9j5i+6kk3GLgX2n3JuepB6s6UnV3ss7+8UHvd0?=
 =?us-ascii?Q?2O1lh3/r4VcONzW3oz7fgPDPdQM3eOsGjqNaXFmP+zWxVsLQ7tdpjVlYM7x5?=
 =?us-ascii?Q?/Ma0n+JsufBD2CLZA0Cw7cEZ/f9CZ49WWGdgsinw8ftvqjY5ShhQLmlN7OGY?=
 =?us-ascii?Q?tTKdFo7AcQ+dLqQwaybWquVc0x877n3q7ffPQoHaiqLgecCh/zdwKEi7LwRV?=
 =?us-ascii?Q?BCC3dKz/x6xld7cWOaedPH2wNu+OqwzsIZyWufGyiew2V7tIvQXm2iFaJ6Rt?=
 =?us-ascii?Q?7ao9VJy4OnzG5azukTFlK3W2EilRKBxOlo7Ow4vggr88JSVQ2LIUGuJlSE2o?=
 =?us-ascii?Q?CNG/8vfRbpNGor7LrpJgxZytbzrNBGfI4mEijALTuiGI6YZ118rDHqZozOIK?=
 =?us-ascii?Q?+MEipnDkgxMsCfErQ4IKC1la3Q4ShkjJi/1zmTjqdQo7oHee2ZQyLYs9AgYy?=
 =?us-ascii?Q?2MJXajbJEPKESgzT2HoBlucXeS5aFGsm+DVGSgcqybg3M59wM+oXW6YYAJS5?=
 =?us-ascii?Q?ygeZhOQT71CwdxTp3jAnho3D3KYoEjg46gk/S3RN7IJFyhOn4XS8RA62r58f?=
 =?us-ascii?Q?mnWXd6XswhObH1UFpPJScnvQq6kXY+llhR9R3JdoGiRlVEMGOKmTxQuKIYW7?=
 =?us-ascii?Q?6yI1uMZ6xSPBbgrsF5qaUdPKW0SQsFQkTaF0/aGAiLhfvNuLVdG3WqAXKhJs?=
 =?us-ascii?Q?SAu4o6qDKDGihsQdye3bWcy7AGYe8aozTiLDjE7OUwd6XskFMlO8jlnJSSEJ?=
 =?us-ascii?Q?OuI5a+UyWDa6dDIRGvJz8uu7PsVhP3CbNrJ0W9aI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6bcd7f-bca4-4467-0244-08da8f4368aa
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 13:34:51.1023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xaPA4r1HiofJ6ID17Kfize3Ce96usjq4qsCiVTxqEBcebUxWPyUbMsJTzwI/TwV991DPgcCdWezadlU6rRI73Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5585
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consumer of the kernel crypto api, after allocating
the transformation, sets this flag based on the basis
of the type of key consumer has. This helps:

- This helps to influence the core processing logic
  for the encapsulated algorithm.
- This flag is set by the consumer after allocating
  the tfm and before calling the function crypto_xxx_setkey().

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 include/linux/crypto.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 2324ab6f1846..b4fa83ca87bd 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -639,6 +639,8 @@ struct crypto_tfm {
 
 	u32 crt_flags;
 
+	unsigned int is_hbk;
+
 	int node;
 	
 	void (*exit)(struct crypto_tfm *tfm);
-- 
2.17.1

