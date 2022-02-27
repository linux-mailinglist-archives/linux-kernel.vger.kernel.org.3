Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171544C5EFE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 22:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiB0VPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 16:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiB0VPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 16:15:04 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDCA54FA6
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 13:14:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSHiJmaCx+YgB5vlG6bA5xlXl/LKu0IcG+ctpKysVzoU2H89CxAb6CN93SC5jMwMHyZufoB2OxLaQp032Enue2/jrvcMWLKUB3S/lY/0EV5q+i+4kMEDPjmUXI61YK03uYt2Sq6UG2r1S7PsJO0XYbfdCzRX1IGTMDEr9LHu9nQNjfUC/Zn2xYJpzc97ijTJZdX0PmylBRMIeTH5T9lrnzX3U9/FB2iqYWJBiiiGSwPVIkE/7F1p8ufM4Hp33DkGP1gNi5dDgyH2AYnLDA6mwraaDRtD7tVwxsDAYUnKLNY3LeIRqSK+2nkVvuKvDv1IQSCYyAB3OVoFkKJ3XJxvgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMYVp8TSF6inOK0TmpUJbSCZPx+nHTjDUV7lXeJjHsY=;
 b=mtgVZskbJxeBb6S6yLJ+UGN016Eg/OcOlJDsoqBbg6ntTM7ZiU2tOnce3EHNgI5d4hojiCzOF/bzIcRTA7w3ANBZSDDdr0qTcHk/u9UommubDUAtmu1Vgn7rU4acikm8onhzTXRs806bKcKjl3U6acPjy2JNPWGmDbLcKFcaQYLvLUVYs17dEpK443d0Af/tHH3tR732Gru7D9BA3SBVJ+KjnNrB2lOLyC06ewx+5jSHd1IxoYAMCWOXnXdNN+KRS00V6qTSkFQ5j1zzwUxi1gxEBhSbXwpu9jl5ozcSCPsUVN/yeqbgUXA2JZxB/Z41GldQIMd5GTA4vD7MKDeaIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMYVp8TSF6inOK0TmpUJbSCZPx+nHTjDUV7lXeJjHsY=;
 b=BN6pT3Zrh2kc7Ux+e3Bhym68f9einvEWsCrj/mluFxa14b2J9gwxDykATWaoaR3LzZOYdx7yXLia76ja+aW2kZdhio73Z5I9rvP8PGUXQA5R30gxd4tQl9jhe50Ya7encV+8RrCKT+rUNZ1FaDNTowH+b7OERocuUfmtUXaIug8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BY3PR05MB8081.namprd05.prod.outlook.com (2603:10b6:a03:366::15)
 by CO1PR05MB8102.namprd05.prod.outlook.com (2603:10b6:303:db::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.10; Sun, 27 Feb
 2022 21:14:21 +0000
Received: from BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::283c:d671:e4e5:31f8]) by BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::283c:d671:e4e5:31f8%9]) with mapi id 15.20.5038.013; Sun, 27 Feb 2022
 21:14:20 +0000
From:   Jorgen Hansen <jhansen@vmware.com>
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     gregkh@linuxfoundation.org, pv-drivers@vmware.com,
        bryantan@vmware.com, rjalisatgi@vmware.com,
        Jorgen Hansen <jhansen@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>
Subject: [PATCH] VMCI: Update maintainers for VMCI
Date:   Sun, 27 Feb 2022 13:05:39 -0800
Message-Id: <20220227210539.19665-1-jhansen@vmware.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0104.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::19) To BY3PR05MB8081.namprd05.prod.outlook.com
 (2603:10b6:a03:366::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6aa0c4d9-b80f-4fef-218f-08d9fa361f06
X-MS-TrafficTypeDiagnostic: CO1PR05MB8102:EE_
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <CO1PR05MB8102CAE373B96E355C0FCB32DA009@CO1PR05MB8102.namprd05.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rbaktQLfJvwF/+pbXi2Qo7K+R6cGKe+cq0D4ExPOkB50f+xkOlKgvFssrN8pEt6ZXGGofzjy1OD+zX0qTVPgOx0YqEgQ3BRuAckbcCfESsrGZmnOlWlGfN3yW3OhqS/D4iUi/KbCj/7s0xDYDvl5PBzog11y1cXxE+tXcoKa3+iLh3AaAr0MD2sBQFqaqckOFTBAtqSMYu8CS+QrMbaCCoMJTwSeypMiwXEPsQqhlBpf3VkbT0ztjtaf0jEKExxI+A/eT3OBx9DdI7zaDP934e/HK80Bx0BTKscH7wcmn4SeTP4/OKH+5jayWjXmvdTIyxT6A0aK7hlZIUQyT857UpSJPngjqkZLonkkEOjy6JzD5RK3caGLexZyj9zLEFS5dFD7j5fTGdGzMttZHFXCz55xeR+31tZkK6DTxo9AIymTln8M7wUTjfUr2m1Lfdga1FS/a9GCr+ryFkv1aMCk3c270vghHGSMnmwZBcsAIWY1TOdPHWtsBZ44e9H0u7feFjc1OwX7esOgQtrodQnac8oFWlMjthIV6tAZU4C7IvXZbCZgqYdLNmakWzx+XDefBsWB64/E8IGDnbctj9TzlAiMsN2pUE48jqFCnHTk1qXZxnMs9bYW9/3MpzVjQNlZURIrQSIDggO0eamIqZH9KnGRvhviPoOZW7x73NzIpk8fvmEMnZcQ8yYXMzR65VLSJ0o1hbBptewHnh50h4cnLswRZoLjFCWBw/jnCuRN6uzeAyG7ImycOoRyc3xHdjud
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8081.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4744005)(316002)(66946007)(8936002)(54906003)(508600001)(6486002)(38100700002)(86362001)(4326008)(1076003)(2616005)(83380400001)(38350700002)(26005)(186003)(8676002)(107886003)(2906002)(6506007)(66556008)(6512007)(66476007)(5660300002)(52116002)(6666004)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fW3AWyo21+gAlwO2h5wdLhtyKe3FsFjsj1L1VKm3vLyd1JHDdsT9OTeEOHoJ?=
 =?us-ascii?Q?8fUNUHqdn2W5A/q9EuRuOuTB36a33LFNJDMb1ritHO/dUNtzAWmf7l6S+qtr?=
 =?us-ascii?Q?D4p5bnpJxVTNLIqDUXF1Dj59knC1LOLDPg+jAOrDcMoO8z7aVizfalWuSmYd?=
 =?us-ascii?Q?QoyTDQTfU2hQrm85/zF3fqYl3AqgomiNloyZmCYETAaDnwcy6Xla1ixSR5yC?=
 =?us-ascii?Q?s4MOsq4eoJ2hSVmPh+Shr60Rm2HchIQBcHt08gNt7Ka+YhyzrpmRK8DDUxGS?=
 =?us-ascii?Q?UgcK6ScTd2dTzh3fL1WtIDuKR8hHbC049hfli6EKJtwNcDJJp4sBiFiFq5gm?=
 =?us-ascii?Q?kst7vGIOtNRJXIan1fT4wDVy9TbRaAGRMv7/BODueXfeE2CbwXBKgorb1Lg7?=
 =?us-ascii?Q?NxQjeqVEt8XZajcDJzq09b+9N1zWHxmB5tmn3jm4s0kFklKCn6FNzMEJ730s?=
 =?us-ascii?Q?k5L9EE9JZ/55gTeGfKwrREhgltLq40HEJzh+qjQ+wh2HOfgVIJ+4ahKRyJAM?=
 =?us-ascii?Q?XxfWKkW5g+TRCoVJbOPS70eEuFGPAoV+kn4lKF7rixPkjDRDFRmOacX00sP5?=
 =?us-ascii?Q?T7G7gonxz2J6YfbdvlXXDsVJPBxTjJb+w9YMt4IuO5Z/bKXf7je1HVOJ+/NQ?=
 =?us-ascii?Q?0sFcuERndKoPVnrL+3/UQJCRn2q8erLkk+ioWFICcFaLEMxFGC0pCeVGpxrp?=
 =?us-ascii?Q?AO9wXWJ9w9Pt9tUgAdVF9WpY0sJR48x2p8xMrGkSr5PyqStKUKpyyu5AbOtV?=
 =?us-ascii?Q?qbiuriCoB7MniGOh0/ZwsMHJi/Jdpe7QV6F5aFrhpofrojw6XEuwlgV7EjHR?=
 =?us-ascii?Q?zBhZ5SyrAu2RxxAM7q3Pupxe4ugzBzELDGSmHP8YLL/8+UrHOb7BJ2YT9LEQ?=
 =?us-ascii?Q?+8zM0W5lmTO03uCSgE1ub+DkIFJhAYuqJsxm8zH9oP0AwxJtkSePra7LRY8L?=
 =?us-ascii?Q?Lqo1FMEcyDumRB49FPYOzwU9PkXPfG7DWXFbWnmgR/9DOGhE7lZZfV9pMDom?=
 =?us-ascii?Q?juziV7v6tDH/l12/n26Fl52VEwX6v9o6oDhFNVvU3xNWUCV/hdxRi4+ASV0u?=
 =?us-ascii?Q?dbFBrawaZ6JtvKL3/GNm5r47YWRag3zTvHRW1cJ8tbUMZ/NFJm4C4pdaiPI2?=
 =?us-ascii?Q?TYJwb02ZX4zFqLKhk6m0wqKYj9Z2jZMkOVKNiSmCPe1Oj1pj2B/XvEBZEg53?=
 =?us-ascii?Q?gJ/BfV3UsJniEH/A8sf2S4znM/6kG/3QasKfm8xuxqdFaAdxBd38+RIGeB2V?=
 =?us-ascii?Q?+KtXg2GAQjd4FmtqqNaVU0ryVqdeNiW7QDPXiDv/vlXQqHSRiW9mEgAB9gEz?=
 =?us-ascii?Q?aWPasa9wB26TQDcobb0G4+BF6f+irKiDu2WbQ+63B1M49BOyCD06+vOhRlg4?=
 =?us-ascii?Q?S/2ni7FwQW9GC0lsg5nQ6IQAo9PF8KwsAHQQiC7lnMbx5+/Lnb1wy9kRcb+/?=
 =?us-ascii?Q?6kj4CEUMbRmdMtIyFAVGebHkDJWgTRJt+RDdoDygp5Un8ZlnaM3RCAgGGixI?=
 =?us-ascii?Q?c1SKLl9DhKsYM2nk0GGxkGG5f/0x7rbnA/Qurvy+YeVkKQu1mMfWO+gxrCLO?=
 =?us-ascii?Q?4F/y6ONrFUuDIxGFiJD6GFyTSWiB1gxYcE6dOIwRpB1wvmQbAIokXcWrT7ja?=
 =?us-ascii?Q?RlFuZnlXrg1J+evZvJqfgZg=3D?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa0c4d9-b80f-4fef-218f-08d9fa361f06
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8081.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2022 21:14:20.8121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2TQiwBDcYELVbWOp6+zLYYGGM1nkra/pFSkHoHSmqDnKmKIGCuYl1tlG+tufEWZLoabXMND5Sqjayiip5j+T3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR05MB8102
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove myself as maintainer for the VMCI driver, and add Bryan
and Rajesh.

Acked-by: Rajesh Jalisatgi <rjalisatgi@vmware.com>
Acked-by: Bryan Tan <bryantan@vmware.com>
Acked-by: Vishnu Dasa <vdasa@vmware.com>
Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bb6c9b5a3253..ecf22b62161e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20717,7 +20717,8 @@ S:	Supported
 F:	drivers/ptp/ptp_vmw.c
 
 VMWARE VMCI DRIVER
-M:	Jorgen Hansen <jhansen@vmware.com>
+M:	Bryan Tan <bryantan@vmware.com>
+M:	Rajesh Jalisatgi <rjalisatgi@vmware.com>
 M:	Vishnu Dasa <vdasa@vmware.com>
 L:	linux-kernel@vger.kernel.org
 L:	pv-drivers@vmware.com (private)
-- 
2.25.1

