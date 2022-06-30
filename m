Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2899C56235F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 21:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236919AbiF3ToA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 15:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236382AbiF3Tn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 15:43:56 -0400
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98F843AD4;
        Thu, 30 Jun 2022 12:43:53 -0700 (PDT)
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UELfEE019836;
        Thu, 30 Jun 2022 12:43:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=proofpoint20171006;
 bh=u7Vi2mbOWN3hP+t0vSbKwTLiNxsdoGA197cmR/p8CbY=;
 b=P64HqcWocRsbHQGlMgy+R5+xtRMit+mIU0nt3J4l6+JWcwXFEqaKTVSXkug8XzYj//Qt
 fzTAKbSL2rM9AuIiBJfdVRRRRGd9IMA185Ww/JJt4KftN+/NcYGFCItmiIKmgQJBr3WU
 LtPPrtavnFB8WbqTIek5INIARKwSULM3ii4kk885kRnYCwYh7nUFzpOguucPqTQBNnoX
 8IZ6Aa9TcyGEg+6rjCiN64g2fXH+Rxr6uw6gI2RHfst1oc3Q1uLriPwTAqwo6oWEmYr4
 nBdkMfZ6PZIIBndrMsEYeCGrH6HB9alkK9h2jxLdp6OVIIdtkcJZv0s03J44mXwrX9wH Zg== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3gx1pfv56c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 12:43:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bepadfDuneaeQR0L8z9iYQK9mleyQh0UhePnZCrE0WlqzAJf2aq/Pkx8sB4foydDWA1THH1q/tML+JEJt0jVHvB0K+bSNzlf10aK9wvJA9bvRUbstoP6YbN/RAkw0fJaSb94whc345o0v81+p5MYE+t9wF+halZg88lI/fVj4Ar2JQb8+1uTLt0NpqnXuBsPOgE6z2vqI9OA6YpdFIaIdxeF/wSDvWMJ85933fdl7PVx30p2YoGnTt4UeBJhhCDBrOBo2800kGva3CaIK4cdnK8D/6woU1ECBCb88hUXSra0eXAtYoZb8D2Xg0Kj8Xd5cmH1XhsYAq08i0ryA/K5lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7Vi2mbOWN3hP+t0vSbKwTLiNxsdoGA197cmR/p8CbY=;
 b=MmA9keWCJ8iaqcPS8GV60gFhbLeGYq6SpwCejmfZ8T7oAir4Ic15LtFSIMyKH/hJ6pHrZ4ycWye5XwLH7DskqjU/LLde66xyZtMljQb858cCLa6J6R1LALSC5DIiFYFrlEg8kpXi1I7widsFmgXh3/ArJVYHnhvGnkcQksSp1dxseiBYi0q/Vx90XS8tAReIZQdUUsmwzBrftq4B4pYWngO/fKat52dOBa6adxwtYXvCWnnBJZiLMJowIMRQ0lqboEzr69CTtvNjZ9DM7fJm60EatOrKx5L92aLjQhtNmDSeljF9G7be2q0+4H9XGHnTe5svMSXqijWKdlcouEAYzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from BL0PR02MB4579.namprd02.prod.outlook.com (2603:10b6:208:4b::10)
 by SJ0PR02MB7567.namprd02.prod.outlook.com (2603:10b6:a03:32c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 19:43:39 +0000
Received: from BL0PR02MB4579.namprd02.prod.outlook.com
 ([fe80::64e5:da2f:e15c:2a6f]) by BL0PR02MB4579.namprd02.prod.outlook.com
 ([fe80::64e5:da2f:e15c:2a6f%7]) with mapi id 15.20.5395.015; Thu, 30 Jun 2022
 19:43:39 +0000
From:   Jon Kohler <jon@nutanix.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jon Kohler <jon@nutanix.com>
Subject: [PATCH] intel_idle: add CPUIDLE_FLAG_IRQ_ENABLE to SPR C1 and C1E
Date:   Thu, 30 Jun 2022 15:43:09 -0400
Message-Id: <20220630194309.40465-1-jon@nutanix.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::22) To BL0PR02MB4579.namprd02.prod.outlook.com
 (2603:10b6:208:4b::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 604a03ef-b4e9-466d-4847-08da5ad0d495
X-MS-TrafficTypeDiagnostic: SJ0PR02MB7567:EE_
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fCyORe5Laq7sIWNZlVCGoFXQsW1tTr/EZVBquhUpcjT+YVLM35bK5ztUb8GkjOXy4ZVUWTrTOU5WHOhATj3ADV9m9NKzt0h10X2H/id5FfALUjNxTIM6hZSmA5f52pJiQgGEi5M8GyWAhrtzJmZbc3TsWLMHETUZTmGSSqm4XWDxK8E/zJRiqIiQZgIVrFqB4sJ28JWXjhnUW9w6yA9QuyxHpe87gtwP/V3/Vz0efzyvRaT5U4+qviyk9X0sBT3C8asiOlUMEV/WIvLxyxVa7BMU18aN3RZNpO5GQP8oSvwMb/CGL3nEYu7BexQkzk9YPQopywfHo0Y+BtGMPBZu6oipQypGBGd/rcePorHVmK/Ei/nqUUf1VWWDxyPWou3s/M0+iRhRXV94N9MV43EWVKzsl4vNuO5dOxauADGD7VTH/9/aGEo6Cvf20fMcJKy2uplS2dwjZ5xVwiGgr4Uim/b42yI5VHTNwUCM4yfcvdDxJHA7qvqLh+3hVqb876+YjepEopYRpyxnlvV49e1zMPceYZuv1v26vcg4TAPRKq2uF+S/Ed9XRNo54+texL+Wgxe9b8lRlfRPOXrlecqOQGBhNEcGwQOEBFzGkB2dYl0PLeQslrlP2F4sJZpq71t+vHjES46Kw+U6V+ASgXNCQ9CzLU15idNLotaZFBg0MvMHfGRt/4nT2Q17UBBV4yCYbw2BZ+R/oic0j7cKqOSg38LNVxTgVFcH8jSYxhjVw3PZRFJ2ioniuqjncmFZD+dE8L6njuc4f/TgtErEmmDMeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR02MB4579.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(39860400002)(396003)(376002)(346002)(8676002)(4326008)(8936002)(83380400001)(66476007)(38100700002)(66556008)(66946007)(6506007)(52116002)(5660300002)(478600001)(41300700001)(2906002)(6486002)(6666004)(316002)(186003)(110136005)(107886003)(2616005)(1076003)(6512007)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SzEh/Ugoj/j5QGhWQXN6xCBql+UgE7+UPSOvrqcrvJr+lMwrdj9OyLOaMkN1?=
 =?us-ascii?Q?W9jlTgvK1RFfXrzcGwDfHQ0AM4CuF4IO/o4oWy9qijkESat8e87yv/grZYnd?=
 =?us-ascii?Q?+dsCXoN67+pZ/GPN/IaEMArlKYfCghvX9fSbI/JuYNthZ/3YwyMeBICNvKGg?=
 =?us-ascii?Q?xxVdl8T+A1Gs1bOnUCuURqyFl9qJwto6iXLR0/M2HXGi847USd0xy2P8DL3s?=
 =?us-ascii?Q?2vQJRQOWKnpuSXeFeXIeQZrzyShoFdSZnLU/UfJIpavJcnwyGWhn8UeYTXEA?=
 =?us-ascii?Q?oaJu6vDYkkF0nUz6UAJRPAdQMh+IlGQ92ro1ADybl2vChT7qIBWUBprBebsT?=
 =?us-ascii?Q?j5axxzqJ+ANUwLlcakTLADn72poDaNJfPOXsc4WZwD5wS1X0GifXyjMX6o0a?=
 =?us-ascii?Q?4qauOVng05teAX/BzK6DilAAzQxG5hct/YysAvUz/QEsFEXDHc+6mW7pk4wM?=
 =?us-ascii?Q?qln379aGCWLFrhG9CHKeI9j9jHvoDE2rpFpXTsYsAKbLBPnFdIRoedbllJio?=
 =?us-ascii?Q?2Ki0RDRQAKr5e5qEJri+HDifQN0RH++9WcyUGV0X9jajtEoWNausezysNcg5?=
 =?us-ascii?Q?HOyD7atyr9mK0AupfF2CCShNHuwD2/kJ9DnK13jIPwhGl0BO+o/n0+MDVc9O?=
 =?us-ascii?Q?k51XO0n8fpVCN+tVSj521B8EHTGDxK4iVHHwYyN0tg9Ugx+BS6c/gPA+BJLv?=
 =?us-ascii?Q?3qUQ39vjvetSuicpTv+7jPmlupQcE8t9p1BwA2iZnHdk4l38NJIhsFVRaAqg?=
 =?us-ascii?Q?//xS9S0XBN+imz4Js4mlQ4JjUOkmd0o5lWHv1WgEl9ZDnTitHpE3uN703jgk?=
 =?us-ascii?Q?KyI9UoWr6gjnGsCHv/P2vieQzqjFK9gv2Y9DySF0Y1i9kEkvNT6mC29m9bN/?=
 =?us-ascii?Q?+GzY2XGuKIUGp6KkcoCL5EUc+GzPYcdWP5uSYgrGo39yOJHxqWp7VkmGwMf3?=
 =?us-ascii?Q?6+Bz/ElgzEaQaapWdB7JDNkxmAPrfhH9H556779tRkZIV1jLCyogXGX+DdJV?=
 =?us-ascii?Q?U/GQsPxqYjwc1TDnGjLn2sZEWeqGuPdqTNDH0VRPJfmNXf4Js1cBXoC+jtAz?=
 =?us-ascii?Q?kBbmDasnqY/1NmIjxrdPMbAxhAe3YNy0ecaia9AbCI+6auws7EkKX34X/Cw9?=
 =?us-ascii?Q?9fzr/SDxNSKsSuOhO8xMtvw2Je3YsgV6hgzsLcGwmgSp5MtO/vyQJCZB/em4?=
 =?us-ascii?Q?0JsTTnKUMP6aGw+UhMZ6F89EIDYsqptTsaF3mgKUo8JWQnALjTmno1AY0xrO?=
 =?us-ascii?Q?3IJ/5M/ytimKquJcaiSTc5naEtUs9KddkABso9cg5iskUn/Ba06NVEaSM5G3?=
 =?us-ascii?Q?QV9v9bKL+wb7/2zR6HKo+BMzSw8M8NNZ7AKRnH4ja5KHxszXaZPoCSbIaMCK?=
 =?us-ascii?Q?oS8ZNu6bQxSy6aOcg2jx8oTQ3RgaDU3fMZ1nz5hl1njhBHfJ3pIsMfRjUDoo?=
 =?us-ascii?Q?qASE1MXtdAcPPXIuaPW65WwGgxS8TSmHitvuCr6EvkvfJJtmcl4NpifPfrSk?=
 =?us-ascii?Q?ezmP2IwEg/DJoZaAQ4pyRXYO3i8J8Nzm9XngjRo1VhYkXTIdLEVqPq4H2Gtg?=
 =?us-ascii?Q?toacwbZ+RsvHQk0EUIQ1l9RYkq74dFE149Vc8dwK1VtZRaeGId5bgczq/PQ4?=
 =?us-ascii?Q?lPluV3MJTDc9zgxZhAbuyUTlh7ZVfKZn9f1OQcpe5sjEsWNPpOJ7/eOp9DWM?=
 =?us-ascii?Q?MiN9nQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 604a03ef-b4e9-466d-4847-08da5ad0d495
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB4579.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:43:39.3378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: INKcNpSVp5cKQsN5jDRg0NVfNv3Yl51UP6rVJoVATfsJ1dMKIRcXKjnwWkXDcTnMj74erfczuPABQXqIzus0ZhoLO9cebCdjahUS/4upm38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7567
X-Proofpoint-GUID: CnQnfn8WiD_YDYk2HHqoQWLpVwPISiMP
X-Proofpoint-ORIG-GUID: CnQnfn8WiD_YDYk2HHqoQWLpVwPISiMP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-30_13,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CPUIDLE_FLAG_IRQ_ENABLE to spr_cstates C1 and C1E, which will
allow local IRQs to be enabled during fast idle transitions on SPR.

Note: Enabling this for both C1 and C1E is slightly different than
the approach for SKX/ICX, where CPUIDLE_FLAG_IRQ_ENABLE is only
enabled on C1; however, given that SPR target/exit latency is 1/1
for c1 and 2/4 for C1E, respectively, which is slower than C1
for SKX, it seems prudent to now enable it on both states.

This is also important as on SPR it is possible for only C1 or
only C1E to be enabled (i.e. one of them would be disabled), so
only enabling C1 would short change C1E-only configurations.

Fixes: 9edf3c0ffef0 ("intel_idle: add SPR support")
Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 drivers/idle/intel_idle.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 424ef470223d..f51857cddf2b 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -893,7 +893,7 @@ static struct cpuidle_state spr_cstates[] __initdata = {
 	{
 		.name = "C1",
 		.desc = "MWAIT 0x00",
-		.flags = MWAIT2flg(0x00),
+		.flags = MWAIT2flg(0x00) | CPUIDLE_FLAG_IRQ_ENABLE,
 		.exit_latency = 1,
 		.target_residency = 1,
 		.enter = &intel_idle,
@@ -902,7 +902,8 @@ static struct cpuidle_state spr_cstates[] __initdata = {
 		.name = "C1E",
 		.desc = "MWAIT 0x01",
 		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE |
-					   CPUIDLE_FLAG_UNUSABLE,
+					   CPUIDLE_FLAG_UNUSABLE  |
+					   CPUIDLE_FLAG_IRQ_ENABLE,
 		.exit_latency = 2,
 		.target_residency = 4,
 		.enter = &intel_idle,
-- 
2.30.1 (Apple Git-130)

