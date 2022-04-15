Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F38502B5E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 15:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354198AbiDON7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 09:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237509AbiDON7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 09:59:17 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2107.outbound.protection.outlook.com [40.107.215.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A614B3B3CF;
        Fri, 15 Apr 2022 06:56:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7T6f5alnfhZM8Cf3I81XC7xPIbfJI3jrox0XEvL8jc+Qn0/Iib1Okm/rnci0ObPtmuYgZdD1/+tv6pUO+4KF/+62PW6JQbbftTCrLTF5TtNr++EWtZkWNMuS5AxYBIesg0O3sLzN7Q8HqDPR4mk1y8JdmlHKyx6+9O4v1R2aeiDQ0EgJX2iJs9Teybl9MXMTw40I3tDi8V+KSIb8YVqT8biv0ocsynC3HGcGE7UJ5NkbeJjFqQhmYgiNkTNvJSaZzP0Hr+vZOpniKNod6JWy8AblBsuuWFYATO46JKuVS8Jrqorh5E8eqOfzLcr9TgLJIrMD5tptCLE4yMFH4iH/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDKAql1ylDNNspwqVW4QQRDxaEihZc22yK9P5S+mxI8=;
 b=mJDLPbZpqP6J9B+vZFCQlmC5YCS7t53wKchm3YUrm40De3PnRXqz86/OIR6gtVEATXNuDeiXz8M3fwsAoCfde27awdLDx32gxB/Z+hjBbYZ23BJapGZty0N8jZaLcjYECIgyr9zRskEMdgVtNHurCcO26fOkB4Q2OjSZaiqn8Zatrur7OCjcWV3WuM6gtxquKmehIP3p38NuMhmN8+1OUCa160IURw2bvwLH1uDWzTyPRWKOtN+c/jSbjvSX9vnsMxgbznIbx9CcKj/ZFcazD62PwkPFug2WwzfT2mLDaW3OIJGXChmu9C1gDaifoJ6XQsEtY2isrzoigawhVk2WRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDKAql1ylDNNspwqVW4QQRDxaEihZc22yK9P5S+mxI8=;
 b=FuGY8kka6IXz02bTo/1MJVQSPjJFA6yrrqHDqcTBpcbKUO1ewOSALaiIDTsloTa6CglVv0Wo8QarK21WhC2/YXCTNRnWX19W/zt/DEQ02ostyAeABu7IOelPgexESNY+uxOP/onmmm/Wp57k5HmqVmarEQU02azFhQtXD5rQh9E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by SG2PR06MB3015.apcprd06.prod.outlook.com (2603:1096:4:75::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.29; Fri, 15 Apr 2022 13:56:44 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::d4bd:64f4:e1c0:25cb]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::d4bd:64f4:e1c0:25cb%4]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 13:56:44 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Yihao Han <hanyihao@vivo.com>, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com
Subject: [PATCH] sparc: kernel: Add missing put_device() calls
Date:   Fri, 15 Apr 2022 06:55:43 -0700
Message-Id: <20220415135609.87538-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0063.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::27) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9550f7a1-d644-4e60-51c3-08da1ee7c660
X-MS-TrafficTypeDiagnostic: SG2PR06MB3015:EE_
X-Microsoft-Antispam-PRVS: <SG2PR06MB3015EB9950C889BF3C61FC19A2EE9@SG2PR06MB3015.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yDm8mpFUUw/D6rWVp9DvX5R3mEOrbgjGfd5Pg/Pskoq7WoycJAKg8LnUeWAJQZw5yXO5kgCUfbyzYLtjIppc0Mk0hcN5dMI8v71njs/zkaSHpX7c5xu6VXqq1sGjXQfK7OqmRBglMpYJXlIM4StuePfhiKETewme2chrP7khC7Dchl0ZY1uwQ3TlImCkvLKGi4I10Jx9BnRdLZEWPVgO4bPe78TaND3Rc7utNeF0n4S8w0IDyw0QEZzvwAhDcJfzHQqTx32SpS776wBEOXmvrSjeLQrb7Op8v8MTWTCNL0dtd3Yp8VmddeD2JKfKnRSDMjAjPIDb+ZyWUG1TyEeEaApqhjMSlMp8papaDBivfrOtziRLkUg+lUugDDcJAXOom6+Ng3WNXy61fy7q4KMScW4ZOwhlqTscSvB2JDt2e8KkQO7cnl7i2y0LWI4UJ0qk2dKK55ZWdCspx2mLxVcW7fD8eh19795VDhyycqzh+xvJ5NdvkfTRQSVt9ApivR/RawEFkBWWx1CSRLxLwoHsRt13ApMLJharqz+NGnAQou8Rmp0CxqnwZeOsaxqB15fEIAM+4++65zS09xFXcGke7aR55MFBMzGWupFwFv7bUv67inDAfWbQ7yE1UaiCMc0EJ01ijRruh/ub4z6xvQ1SuES6LLil/vlsZK3XhplCCOQyQmqBqbVMOHn4NjbhPzvhrm0LovFuY9yotiho62gpgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(2616005)(52116002)(107886003)(316002)(36756003)(6506007)(1076003)(8936002)(5660300002)(6512007)(38350700002)(38100700002)(508600001)(6486002)(110136005)(2906002)(26005)(86362001)(83380400001)(8676002)(66556008)(4326008)(186003)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7o1SzhWAtY3lPtjrwcn3PbQIYEMp0aKKMVL63ZYQqhns/x9EejzRAjwXzZ6J?=
 =?us-ascii?Q?Lm9iJAj1xkCTJMmPQcQkXl8iLcScnVVv/E3lMApFr1KFR9aOT+0DxFVRdEJG?=
 =?us-ascii?Q?oft4+A+gX9hMYkHBt0lV4Cy/b1Y1Cgv55S0UCBfZwTsXm/dKWijeoNhk0UL+?=
 =?us-ascii?Q?ICMEZLBmGa0Ne7eaO9sSEdcSb/49BSZw6GgyxjeG/9cakBEHqCCSjmwpS/9D?=
 =?us-ascii?Q?dP4gMlSEvADk07Mt4XfSgen9vOifstXv/OJRebVjo6c0y8oAPZvMxmKAamRw?=
 =?us-ascii?Q?Nhdw8r3GVtuOnAArFBj3E3O9rpASFS7qchpaBFjfRJ+Z+xrMJ6MsHme9E+Ld?=
 =?us-ascii?Q?mMGTRKrjk9CDoQ6qHp8uXbnkKuTka08ZJMph+sMLNg9CtPf8TOwXG4aCDjRy?=
 =?us-ascii?Q?frTMVq7P0+eQUcfry852PjHM5mkFX1c9QMrFcpiJPQBMn5sIjh6yVeytG6xk?=
 =?us-ascii?Q?5pWxg0FGP5UZmS4X/15DenENS6LRuWzNKHExF4vqQDRMLbNlH3+KAr09cspI?=
 =?us-ascii?Q?4DA13kQpYYy5KRZcTdDGyrpYwfajgAAkLDc1Az66KVyW3EW0jvZhss6ICQL8?=
 =?us-ascii?Q?EwRq4mlYMH1tMpVge+i+g+Sr5wlPILPcFn6Ylg77jCynQtrB2lIFqtEF7Q2q?=
 =?us-ascii?Q?0RZQb8eN1Fjxu5TVckhQA0xrjnX+V+/yB7slm5E9rq1758Qivk+v7EOAR8OC?=
 =?us-ascii?Q?c9T0F8uwhE+hr90936IeUrIxF8qqqI71kx6wKyapNJoNQG2+MLO4Hu9XJP29?=
 =?us-ascii?Q?WndR5mt1VcSi1MguVkgFOpMDpeFigiX3HVLQNXo7TTuZ+nbUz7XQvej8HtJ4?=
 =?us-ascii?Q?o3KsXrCxdywQTjbq0ehBbSNKHoL+RL0xkvt8UGZFSYcKrtZovUMMWMKQrKBP?=
 =?us-ascii?Q?m3Etr+gFpKFgJybAjLsN8QUlPJxvepJ2Gjmv+RAWkUS6N+heGTzUpZ8zNelW?=
 =?us-ascii?Q?yR3gOauIMQP3VaFYc6xfypY49RjcFmtjVcS2etknZYUJwTpf9GNPv/tPblZr?=
 =?us-ascii?Q?Lr5LZo651rp76BZzQuWbiQczttxFPZRYq2sCJTRfOVHkW+hATrC27/2NpJy6?=
 =?us-ascii?Q?nNqNvEGo0joxhKOyAxW629bXHyFGpYQHWzRBw3watMku0f4hmPgyYSHuELNP?=
 =?us-ascii?Q?ZkUx91l78gThphEJkLOjujV4EvjEnGgQhf+QllDZnyIQ4PxSnBTeXfZSD+d8?=
 =?us-ascii?Q?gu558fVLVyfgtwQgiEa0JaugEqWKBcJPRx6BLdxJzFPAzqwv1NF+DEQs0hdG?=
 =?us-ascii?Q?etEtyeFfwFlx8Cmzft0ovdiypStvbFfXbC2wS5CXDK2ho/WPvaE+vb+MNghd?=
 =?us-ascii?Q?4/UbEUpmyI2aM0OcmQBHHSsS9IuiJFHMnB44jmBVCGK6nWXufay28/KQRisv?=
 =?us-ascii?Q?8c8O/lrrBl1HKgGF7dVaSwZwnKMexEps8rNCX3nfCwIeGUrFw1OuZWubuy4P?=
 =?us-ascii?Q?bW48C57okBx3Va/BgxjNywNMfPj39oPP5W0iHy8WWCOF6bqkiPjiCr0iuvAt?=
 =?us-ascii?Q?oyuKLQAa7o9iXwMAqljO+6SOkS2by2KQdCNKhLeKrHxd9TkRKqTP0vSzmxSO?=
 =?us-ascii?Q?aBGLFoyF2lQRVFDey48RT6gXoEoMRkgaBVPY4B76s0guJ9hRdD4d5DWqF8q+?=
 =?us-ascii?Q?4TT0BT2BZqHUsAILRb3oD8fzeaLdexMcMAyzPyPvu+ivvWDywmuj0Qkqp4OH?=
 =?us-ascii?Q?85n0g4+6E8ei0HeFagXXeB4yHDXyV/g6To3ckoh5PN8XEIkKqijSYYQ0GiRt?=
 =?us-ascii?Q?SIko21oP2auZIe9gi8JM2+qycElcx8Q=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9550f7a1-d644-4e60-51c3-08da1ee7c660
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 13:56:44.2231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9PEmdTWYaM2LwVDdmuJJ61Rj2y0hYG4UIfDhedFVjYHnFkmCp+eDn3wnoN18nQOl/pUVNP7vgsspB8mMSAgGHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3015
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A coccicheck run provided information like the following.

arch/sparc/kernel/pci_sabre.c:335:2-8: ERROR: missing
put_device; call of_find_device_by_node on line 324, but
without a corresponding object release within this function.
arch/sparc/kernel/pci_sabre.c:369:0-1: ERROR: missing
put_device; call of_find_device_by_node on line 324, but
without a corresponding object release within this function.

Generated by: scripts/coccinelle/free/put_device.cocci

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 arch/sparc/kernel/pci_sabre.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/pci_sabre.c b/arch/sparc/kernel/pci_sabre.c
index 3c38ca40a22b..5d0d13840ac3 100644
--- a/arch/sparc/kernel/pci_sabre.c
+++ b/arch/sparc/kernel/pci_sabre.c
@@ -331,8 +331,10 @@ static void sabre_register_error_handlers(struct pci_pbm_info *pbm)
 	 * 2: CE ERR
 	 * 3: POWER FAIL
 	 */
-	if (op->archdata.num_irqs < 4)
+	if (op->archdata.num_irqs < 4) {
+		put_device(op);
 		return;
+	}
 
 	/* We clear the error bits in the appropriate AFSR before
 	 * registering the handler so that we don't get spurious
@@ -366,6 +368,7 @@ static void sabre_register_error_handlers(struct pci_pbm_info *pbm)
 	tmp = upa_readq(base + SABRE_PCICTRL);
 	tmp |= SABRE_PCICTRL_ERREN;
 	upa_writeq(tmp, base + SABRE_PCICTRL);
+	put_device(op);
 }
 
 static void apb_init(struct pci_bus *sabre_bus)
-- 
2.17.1

