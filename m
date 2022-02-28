Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358604C61A9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 04:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbiB1DP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 22:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbiB1DP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 22:15:27 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300105.outbound.protection.outlook.com [40.107.130.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0433442A3A;
        Sun, 27 Feb 2022 19:14:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/skoICyKsJklN6lpptYI0ThbIAQEjTUxka7HgTAzrbYFAR+43qxemHqM2YIFpkaOI2iqN9DFrT8jl1botpKz/a+PA+azavFPsTrEQn+Ahjj3kSWmvlT5wjZfBHVkiTgBSjborsN+5N90n6mqN6VU9urdHbCzGfnh/y8jzTZG8ed/j7cIqKRIHEVrb8S7PVXNxdd5h6bZoq0MnwjtvmtzVwrkH9pvvjJI/0bRRzoTSDbfnICjJ9iFrGpEeAz0wWBCTOpDNsfO7Iu504unHcS3aAnIkXWHQm1B0gnIbzPtqgf2P3hxH8Xoh1HJReSDXnkwTS2iUp9xQIJibah9fPWNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DIunlOKZ7xnX+jKC9TibBPSsJYjDz2RS/GfaLBd/uI=;
 b=iykODSbERHuQfV11Kc8QC8m38RnIB30WK3y1fP8wArjG7Sh4zAktBraPKM6HWmFDmGEHQMOrnAr1OVEAwsAAYhENZ+IG5wvEelfjw9h8VKVzD0yWKUCzyajmWfOlq3I9ZYcdlkCTaEOvwP6TfzNmxILJqkU02ZAsEin7cEK/sd6DBO7zw8tyjy64U3CCBPPgy+BnSbgPAWCxwF4SffnE8j2/cwpYsLmHJt289s9G7ZhYShCJ5c6sOEm2UirC+9/JnpfHLTAl1wdADd1AvVsumlNENHsC4ESnL14iQ8KumfJW/zwfkzWqdUHpA+cMMc8Q2F1FUTP3zOWqE3OAsTB8EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DIunlOKZ7xnX+jKC9TibBPSsJYjDz2RS/GfaLBd/uI=;
 b=KmQE1yxiPcJpNlzdMxcPwJHGCbuSLDDmxSmAIXLetZS2fEUA6SwvYbEsJ4GAX7THwmDx+aMxyf1I4NkYXT8O1J+Y4TrGme6tb9kWR6yY/3nAY5JwLFS59KXhxpYBWKJhkqxNnJnn2iEFl1uWCdk5bRkz1Lmu8YjuYhq2S2MaZRo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by PS2PR06MB2454.apcprd06.prod.outlook.com (2603:1096:300:45::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Mon, 28 Feb
 2022 03:14:47 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::49ef:baa:8c3b:cb3d]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::49ef:baa:8c3b:cb3d%5]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 03:14:47 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] scsi: bfa: use time_is_before_jiffies() instead of open coding it
Date:   Sun, 27 Feb 2022 19:14:35 -0800
Message-Id: <1646018075-61321-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0176.apcprd06.prod.outlook.com
 (2603:1096:1:1e::30) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13b59f91-547b-4e6d-8480-08d9fa68796e
X-MS-TrafficTypeDiagnostic: PS2PR06MB2454:EE_
X-Microsoft-Antispam-PRVS: <PS2PR06MB2454712F552576B2C87B0D9BBD019@PS2PR06MB2454.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qpt1EaH0n4Zr3WisLTkbLJaeFY1gf6T+g7Dbv8sxKZed7Z1+CW/78aQ/Ex8AdwwUGb0vMYi8OXkHqGjEzNc9Wxk62j95Kn1dfXOMBo8KIaXQQtpzKH54TkuZPuN8r3MJdi7s391BqOCzAopbLpQb8QLu1ZYhYxc7ZQF3swFktZhIPZezCZZMoDqfHnZPvb2L+zzOQz4wg/fHSUDMZJhLWSSqowfKmcKS5pfjsOG6Q/N/K5TWkQlKbVE/l/F4Xeia81UOS2GFVpYzyskEKxaRbp9ffYEmuinu++V1DFIkCyD4V2RcB2JE6sBPKv3zD9bGpq+RfZNYjbuFVGsW+1kSlVM8cm4HbDEqB2haZkFkVD0FNO4Cspp9yQsq1Fb7hMTp1JY4gbQWKrCjJlvuR05rqpDkzbF+KADY5t7LDqLf4U8cGa+UrACvvGK56UdYZ3zBIDKdb7Y8D4lib+OovIcN2wXw3MIIsDLf82P+vLOXARdppfxVZVC4tj2PyVFSpfZ/ZHSfI6RybvJvV7IWW6J6oI7984k0aOgIAI/gVblx2DzCRX30QCH7WNhjszz89IIr1WP/yr/WWqAQ8ZsNrDweVPGsDjQAOE+0SOr+8UK3lunmRIz36d37NthCxZs2G3IR67wGUNlDefs02VWx5qQ7R9ESaCZkkT1KBOJt6DI/RIL3xxn/oQBbGylYfrKSaSHHghPA64rkGE6dXB6LKkzyGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(66556008)(66476007)(66946007)(316002)(4326008)(2906002)(86362001)(38100700002)(38350700002)(8936002)(52116002)(6506007)(6512007)(8676002)(186003)(26005)(107886003)(2616005)(83380400001)(6666004)(110136005)(6486002)(508600001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VP26WbaaOyeqIpx/1lHRqZ4FTeApAQuujihtiKZMkqAjAAH1Bv/aKd5GxZiI?=
 =?us-ascii?Q?D/gVS4U/j4v3T6vEq4L74wMwnY2NwkMPxVnVN5U1KI/Q8SjZSxcPhh7Mhaug?=
 =?us-ascii?Q?2xdpv66rMn8iGGhuVGlW70gD52PPr8sPlgp2YgAawiiGsBVaMwZVkd2TfdDH?=
 =?us-ascii?Q?wtRCxdxiNIfvGUeiQqzqoWcOHLgthNBFHm4kFAjpUkj846TGOeO90y0seBKj?=
 =?us-ascii?Q?maRQD+/dEE2bSeJSpHCNdRInP6pW1ekx/eGqiOVs0IsR0Sz8+3ixmjTSjwVJ?=
 =?us-ascii?Q?XLzuD827nvr8SoIys9NNJuSB1LmQ3UDAU+a3C/oBPSOBv8FL2Rj+0NOckXe0?=
 =?us-ascii?Q?ogihJaC3+QVpzvPHDtAwvHmyxWlWnaX2KR2U6ONqSpoRCovtL8ELgQdsih8n?=
 =?us-ascii?Q?E9+xTY0iMo0ycxlgZqV2YhxbMcwikVXgcpJuk2GiA0GNDUbqBBmMxXXn3CSZ?=
 =?us-ascii?Q?2eBbbIllVtXjIwU7f9korOeGicr1xLsmTuaIAu8iV9+tP2bip+tVhdMfzOJA?=
 =?us-ascii?Q?xvnYL5xX8g/DF1jNQn0Sqtwz/hdanNfFqdd18d9PA4+nj1UBRvDrAJ0QoiFe?=
 =?us-ascii?Q?j5SRA4AH17QQY7X3J/5eHTZP//G+u0Fz9PqHVVhzRlVR7dtrhL4C5CBiRgyY?=
 =?us-ascii?Q?CQUQf+QwOTHWo5+VRJP2O7HDpIN/hSDPqrUxRoj1kKapqGFGF2miSYgLEVdI?=
 =?us-ascii?Q?VRuEUJ1i2XHTi0SbLkmuCfaoic+kL45LB9t3w3geGmyMAUlL4YQCcjCKMpDM?=
 =?us-ascii?Q?MRMGMpR8dr+owslCY+1vH7xBGg2EVx+Uz8Leh2YX130LdjR3FdwY4sqYlPIM?=
 =?us-ascii?Q?c40KYcSwCw9cbOaXhDFFMOI+wQxe65O21+Kr1WTktYX7SKvi+I8KLkgLiTxi?=
 =?us-ascii?Q?Cif5uLEfsOWlE/9zTIjdz1YGnndfUqtx2fUjCExCB7FP38NuFAwZQpYOgPyG?=
 =?us-ascii?Q?4Z/VWwdGxg3C/PKy3ehV31LTXCc0RxP8bSmqir/6t2mjonpiHb2IClZAObZT?=
 =?us-ascii?Q?aggN+4cbf9HBeQ3Io3fX08aBJeJ7hmDaUBYXPetMs95sjLwliFncNtZhE7ov?=
 =?us-ascii?Q?g+rhmyMDAmYTFb/pOBKGVPDyHNsVNU8cyMEXGOdM/ksx+0YFz6qxZGX0ljdu?=
 =?us-ascii?Q?utFasBZQxqsmHeMAy4eSRV0wrUy/FFYwNq41PX6pwCCSojriMXvMKcxbltCj?=
 =?us-ascii?Q?mZsD+ahralU6jMUB/ixglfdBOdlVwzTQxfztRbsleHykVtCKpirg+cQYVU9Y?=
 =?us-ascii?Q?JCiWpCBUgl5YdHpK4+tnOzaX3ocJ6VEnnDqshTeBuGpfPDQ79TiIxQos8Ic+?=
 =?us-ascii?Q?y/JLQN02rpuw0M2jUQd4Njb9p4HyiaVOkcgHcgBSARbtObkCpkLN/2vZF2Ur?=
 =?us-ascii?Q?nt9yXM6cC0g3AgGEs7GjkUM/biiYWeobddKgJHUBg3r+NV/rJlxPvjkv7p/v?=
 =?us-ascii?Q?qHxW6cXTptGKmuxL7+45sCVcfXFpbW9UoV0n81F9NgkYUwYw9try72E+Om7b?=
 =?us-ascii?Q?11BAFH8wVcG14pq90GeVUP7SN/k/ej/qVSnWLLL5upKgoKl/gx4ZfGKwe+Jj?=
 =?us-ascii?Q?Jnw+D3fYfygp69b2JMVboBgxFDNz5/IfKwUiF8B2J/pjRWJePoVaFNZKBkHD?=
 =?us-ascii?Q?I0+cEde5Ol8XLCWkwk0jFYQ=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b59f91-547b-4e6d-8480-08d9fa68796e
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 03:14:47.2339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWHRmduPfb5+LO9mjX0Vis0h+nfGplZClpB//D8eARTEBiCY9sq5KMFdDBMa967DyCR3RS5XP4Mq8kF0fvDN+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR06MB2454
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

Use the helper function time_is_{before,after}_jiffies() to improve
code readability.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/scsi/bfa/bfad_im.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/bfa/bfad_im.c b/drivers/scsi/bfa/bfad_im.c
index 759d2bb..41f49f5f
--- a/drivers/scsi/bfa/bfad_im.c
+++ b/drivers/scsi/bfa/bfad_im.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/export.h>
+#include <linux/jiffies.h>
 
 #include "bfad_drv.h"
 #include "bfad_im.h"
@@ -870,9 +871,9 @@ bfad_ramp_up_qdepth(struct bfad_itnim_s *itnim, struct scsi_device *sdev)
 {
 	struct scsi_device *tmp_sdev;
 
-	if (((jiffies - itnim->last_ramp_up_time) >
+	if (time_is_before_jiffies(itnim->last_ramp_up_time +
 		BFA_QUEUE_FULL_RAMP_UP_TIME * HZ) &&
-		((jiffies - itnim->last_queue_full_time) >
+		time_is_before_jiffies(itnim->last_queue_full_time +
 		BFA_QUEUE_FULL_RAMP_UP_TIME * HZ)) {
 		shost_for_each_device(tmp_sdev, sdev->host) {
 			if (bfa_lun_queue_depth > tmp_sdev->queue_depth) {
-- 
2.7.4

