Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1F851B644
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 05:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240322AbiEEDFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 23:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiEEDFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 23:05:38 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2121.outbound.protection.outlook.com [40.107.255.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B259A1D0E5;
        Wed,  4 May 2022 20:01:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOOghiWuAxO9+l1b8QRmml6gP72tRRkNMnwzAt717IxwGJNe2n6ra4/KBeTmtZ+XSdZUXJknI38ihtufaVqHZBGJp3wRXYqauPQ9HwpEx624bSWu8utgQOc/eK7AFY/VaNlGtIxelKOvJE0N8PvimzTjRIww7PNHFoqvdZu9nw8sGlpyjGxgEtjVJW1t01rfOWF7AG5cOqYy0PRqla2AiVucmce5frc3YbpnwQZrvsURWGOfXCPV7sV3qR9CrNpMvl5F7wCT0dqVjKkXN5cJX5WWjtu852ZupGZihE+TFkm2zdlxZ2+ovrqxNv8LeAVCSBfl9T7NbsfHxhIGS5eqog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yX0dSSQZUNgIEjvGxCRKceSe4j9myGYIMDTUWLsuqdA=;
 b=Azo/RAZFWx0w+t63aHCRb2FsUAGFIBeLqNjq36dXB80xX+iHPYH11mmuBZlEkHVSpq5IjVS6Y5ldX+7KBcNEHlLuyNwPs+gw1k4afnjWDW7xM81wRC/ud66f9rAJM2VeuU12QhCdu7wiUtpfaOK6fzoCLZk41RkQFpHfAKpuq7Xbd2NhtM7FziFH9oyBwh+kqY639NNNxtjdyRXOrOmnWYC7SI/zVze4esdwXoiZYzv9LlXQTudC4sxkc9AXlu1KNOfAOBXiUzN9L0lZGSIuAIs2TBAnfDmmWOLLTSCeyGwGpiX+XztWHYApId7EMGqiYAQ5soJqWB+oXSvms+Xv5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yX0dSSQZUNgIEjvGxCRKceSe4j9myGYIMDTUWLsuqdA=;
 b=X2Het501IrJAY/AzC1/RzYfMMfl6vg0uWrbYKVNsDyjXKfKcijXuDOJhwrcGAeV4B1d362ChgOsdxnE+TiKjUYCE1Mj6JOqJ4frP3Xl4cVdan0Qr4vLEmqYr6keqc/Uaxmiw/6yDCAn7D02TEIhi60J8RixyaGWgbnuuvwLp9Fw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by PS2PR06MB3350.apcprd06.prod.outlook.com (2603:1096:300:5e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Thu, 5 May
 2022 03:01:56 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08%7]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 03:01:55 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        linux-mips@vger.kernel.org (open list:MIPS),
        linux-kernel@vger.kernel.org (open list)
Cc:     zhengkui_guo@outlook.com
Subject: [PATCH] MIPS: Sibyte: remove unnecessary return variable
Date:   Thu,  5 May 2022 11:01:14 +0800
Message-Id: <20220505030116.14371-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0186.apcprd06.prod.outlook.com (2603:1096:4:1::18)
 To HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f834b6e9-d31a-4b62-8011-08da2e439ca7
X-MS-TrafficTypeDiagnostic: PS2PR06MB3350:EE_
X-Microsoft-Antispam-PRVS: <PS2PR06MB335052517FE26212D92AE0F5C7C29@PS2PR06MB3350.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hjml15T/YKAptTNL6Sq7MzChL9E5/jYVCinbuSpLeVUD2BWkq9Sg+YIbSCbWrl/xJGqYPeMQTlXmfUx0DrpkcwYCmhZhZ8aZLMdxVj/3NREzGb18TqAH1m9jK19wNDM+fiUAnnw5E7RBnxecsPVQsqeZBwBLtyCPXBWJQtBhBjV7gC/81sCMgNum/fMeqoVOGjvNjIbT9DtVhoo7IhdXE/XatH1Frh4uMSntduvb71ZBlmg9bCz/8C+gp2OOR+krb5sOQdiEEe0sEhBXPP8xTDY9mPXPTLzVgCYdTHy+KcIvuR8YLdI/jVgf9/51xUGiXJHXBQAMr6Egj7nzrgLTLi5MLu15rtZCYQIU+0Ua5ltUDxVog63XRGzS3G8r/05K0dOlt+YYq7ZA3oRuxTy6dNcwbkXJpo90I9H2vs3VZvpLlcM0KCmVEmiP39JvjoD30uRO+vQNiPz9tFBaps52cgMixc58PKSjnXq0OcG2I8R3UD3HSwmaiz0ghv7BYvk8GgERjWp44beE4wiQJe400d11kDli5U2Y9YRTqfzk/vVjmZ0EZmw9QsLJj442P1vTM5GOs7ZXC4kbAJZdgJKQE2eu/22H/Gvpe1aryIxoXMwbga1pAYWSBHyfz44D1JGFCJGyT/lzijvqex5t8ON5XK6tSYo4eOdixgDNPlLZeJGWVAWGo8ApL5OopYaZPHlTmHELNOhf6XzvhaIxF7nqXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(6506007)(110136005)(186003)(508600001)(8936002)(6512007)(6486002)(316002)(1076003)(2616005)(5660300002)(6666004)(4744005)(38100700002)(52116002)(26005)(38350700002)(8676002)(4326008)(66556008)(66476007)(66946007)(2906002)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pIO6zJMnSjt/Zjw9RPGSwC9GfEMj3ldhPlN1kwGmUhzCtvS9FpjhZPRBVPhU?=
 =?us-ascii?Q?NL6Eb+eTUaaXsx711NsnVWYo9yB5/Tp1G1Q58EBdqQpWHdbCvOwyLu2ObQCP?=
 =?us-ascii?Q?AwrtyUWuQ4OVIR6vGV8ioD0GjjxegmPh4T4/a0/I2SJHdU/QM1qB+rhX2sNr?=
 =?us-ascii?Q?3Pitx15bFQdQDmgr2WvYYvf4a1sq6FVP9kM8U1qb+bYIoGm83XayUwzXSKLe?=
 =?us-ascii?Q?s7oGuRSaPOffWGtWNsQV/Uh6OPstp6ilpm7oTsJY3FFIKAh4ilBEI4XkdYUH?=
 =?us-ascii?Q?NjAt/Q2mgIG/WRRVctB9vOfWLEoLdLYi1o9odV47n2vFqatJzioMo3gtgCZR?=
 =?us-ascii?Q?KGECbMq4lQHJRsJhDiqPorTUtLKqL6XlLkZeDOJWiiOjKYkdZdXH0BoZ/wix?=
 =?us-ascii?Q?tfOFvhkAPlU+2UquFLwnMO6NQjM5TYWJlLdhDSz7aMjWOK5LoNpKkZHv/ANX?=
 =?us-ascii?Q?YI/NwMGnLGjg2shQfNrx0PezFBgdV9OormqnqfGdziKva4k3nMh/+Kv9V3cc?=
 =?us-ascii?Q?UIL6J/j3wTWfhXcMbCS7VwplRpaEbqrgJkd2v3vxLLSHuDhONtqHopmxT/uo?=
 =?us-ascii?Q?GmW5Aj31+Dn2MQHv9vV4fPFn0hcV/PUM1dO3FXIas4xpBdBIXXqfcCsysw/g?=
 =?us-ascii?Q?Qd/3t2swBQcCiMiLK9bH+yOqhauzBr6rjFG61oJpsmtzqwHjcxzZrXYRSIeL?=
 =?us-ascii?Q?3cZh9lKLAOnwUrvldGRWZICY3Gmw6L/M/yNH8qHodv7sX/P0D5Uj9KBo89C6?=
 =?us-ascii?Q?ozBuT8d4ScZZUXXuqvvvpv+eStoH4Wv5+AyQsJhbxXaW0CSzHjuFS8a2cLUu?=
 =?us-ascii?Q?lSRz/AnUM4vxjNHtWRI5QDtRB7IL9YzaX0/ftz1N0SRaxnGAzbsmaX6u6NSE?=
 =?us-ascii?Q?55pg04BbQDIIkWzmo0uTLVBbvS+cWtfKH9scBcKvq43acMAdH18QFn7+LSib?=
 =?us-ascii?Q?Bm5PSEoW079D42+3r2O86lQlvnbbLnzz0+Y56wkWp98a5ZuMD3g3dn2/QH00?=
 =?us-ascii?Q?ClawQVABvrgiqni+3yLqsU7Ko+dd5sfT2RV1kXDz7KQTjouTshArghHEIc76?=
 =?us-ascii?Q?BSb5uNvddRMeiQY75zGfBBpd0p8TATeD2E4YdUFwtAKP9tzFuYUgOhCATZa4?=
 =?us-ascii?Q?sd6oO2+jHJfwCcyMy64UgADR7OcyvrOjLgsUMGUeLW/0C5BLpdSN8kmc34i9?=
 =?us-ascii?Q?BwK7hjX2vLgZpZWw/TBAqyQsFXX+8lmzgaHsQYX4G8RXFLMGoidKhnxpdp+8?=
 =?us-ascii?Q?+V5oNQLau6TXpOa9geI1k9h5OEP6BrcTPNCDilFfOH+tnu6PJczZWD+if8bX?=
 =?us-ascii?Q?h9Hiui+a0Y0xQ09pbnoi15wKQo2nugXtwN5WxRn2SainK7DSvw7pJ6X1pwlw?=
 =?us-ascii?Q?Cd/lHp2fxvXERHgFHVY8olYN++0/Ebqf34EkDwdmMnThpAsnZvPZpWIRFnbx?=
 =?us-ascii?Q?aELexrUmf89XJn/Dsqt0voL9Alj6WP+ubHUeNDrqh6HmGruui7BIyk7Ufb4/?=
 =?us-ascii?Q?9zfc4JuvweqqCaHyKP0Ab24b4/yXcWRzD0vGiKE5sDVPNiRtJgAXLrQlipUr?=
 =?us-ascii?Q?G/EqVbgBs1xesX5S2r9na6QYWTB7RlmZJuZJeDeDw1u4vYTjyVH6WXpHgi/k?=
 =?us-ascii?Q?6QrnYyngfaflthoXcJGLtGbPKvZuhd7wrbSXAo2Lyz2ddVe0PW31yKxQdGEL?=
 =?us-ascii?Q?aVeytS1DGusjnghGENECmXgcr+Y/FV1VaEZ13GziciDJYUBlG/Zvr572Wkz9?=
 =?us-ascii?Q?n7MMENFHxA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f834b6e9-d31a-4b62-8011-08da2e439ca7
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 03:01:55.5224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tM9WK4mhZXcUDZBcV2HsKfbNZoyrUTckbkqAq2m6XFGLiOTPZe1223Yu+6j6AXrxrtk8Y4DT3nZxvIC+N2pYAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR06MB3350
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

arch/mips/sibyte/bcm1480/setup.c:37:5-8: Unneeded variable: "ret".
Return "0" on line 67.

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 arch/mips/sibyte/bcm1480/setup.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/mips/sibyte/bcm1480/setup.c b/arch/mips/sibyte/bcm1480/setup.c
index 6f34b871b08e..e3e807046a9c 100644
--- a/arch/mips/sibyte/bcm1480/setup.c
+++ b/arch/mips/sibyte/bcm1480/setup.c
@@ -34,8 +34,6 @@ static char *pass_str;
 
 static int __init setup_bcm1x80_bcm1x55(void)
 {
-	int ret = 0;
-
 	switch (soc_pass) {
 	case K_SYS_REVISION_BCM1480_S0:
 		periph_rev = 1;
@@ -64,7 +62,7 @@ static int __init setup_bcm1x80_bcm1x55(void)
 		break;
 	}
 
-	return ret;
+	return 0;
 }
 
 /* Setup code likely to be common to all SiByte platforms */
-- 
2.20.1

