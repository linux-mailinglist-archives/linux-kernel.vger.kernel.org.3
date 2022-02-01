Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371D54A5933
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 10:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbiBAJ3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 04:29:35 -0500
Received: from mail-mw2nam10on2084.outbound.protection.outlook.com ([40.107.94.84]:43778
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235939AbiBAJ3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 04:29:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTezJeuOecXV2Z/E6/q0wLpAzW10MqTLlqQNZSmedVTls48mgTGnOzMPoAow6fDoaiE1O9aI3VHh/QdjqCra4NlIRJB+wNi53eqWVuEzzc6Xuv29xzKf6N1ICu+irtZ4r38H8yoVwH2kTueDV49z6ubJJuEI9BLiFbOrpWv0YNBoVP4rz99iYk40pn0mdD4y0WpsvIPBrXUhlWNCiuLXwNKV6DH3e7jbHUiEBxeYJwOeZMlnppCjoFA8LwROGpebkHKkDdMjPJ86EuiVRAFT2bHbeGQhD91iu8uVL80DokvXORYd1UGGFbDq4/4RBxbw6qnoQyaLxoerm/JVnk2tsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dp7Lf7CcFFHeQkJCd96mrAXaOoKuLu9nm4YyJaleUn0=;
 b=K+9bP/NQpPoyO4MveLQvStZkjJesBDEFi+//MdMkQmzUH1IAoqg8HleJs08Fb8hzoR7KED7q1WcDxDyDf+r8RA/pQEx/gd9o8WhhbwI9xy5SpYoJ8E86pcRXy1+vu07DfCmd7BKS0TGfDdrlLheQfL/KaK+RlE61kMjzDx0jnVH5N9zWNYsK5rXlEOibEPZM4IBPpbvAkNXL4PeYdmzRYE0+DVybjzK6KGiPIDfYRvTgTB/i2XKsaX/eP2tc0FHo921g5NbRqhqKqA7xWoWM2bp3FCUJIemT8PjkcFBPpwbD0WYS8Y6XfxnwMcZhuwkdTPuj4jzk9zYYcAH2qmA8bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=de.ibm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dp7Lf7CcFFHeQkJCd96mrAXaOoKuLu9nm4YyJaleUn0=;
 b=rhy0/WmF+6XjcyJGOD++oWiPzHZubTSy4exFRf1IueJdpldLl6U2/0if5dbZM/k/zwdysSSZI/IIwA/+qg6YQ0B9za46oynK+hjKxHSKFX+4JKI2qQtp8Rf2Fx1S6Aclj4r0xgvrQMHhccWD2OqX6H+zFhuH7EQnm1rJPOYkzRw5BRVgFJMCetYO4yIPgM5tLALkq8lPXLnvFy88Si+pHGRdYRvmLXIZJ3cGwnYXHqDODOjwEciIvayrlS06kYNg3vaxEiJdEzJanBbEMEwNmf04cfn3BJ17cIm4J3Gkf2XPAIjp49vFykbCrXAO2j7y7urQPNpVA+3oDRZVaZFdIw==
Received: from CO2PR06CA0063.namprd06.prod.outlook.com (2603:10b6:104:3::21)
 by BN9PR12MB5035.namprd12.prod.outlook.com (2603:10b6:408:134::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Tue, 1 Feb
 2022 09:29:33 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:3:cafe::11) by CO2PR06CA0063.outlook.office365.com
 (2603:10b6:104:3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Tue, 1 Feb 2022 09:29:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Tue, 1 Feb 2022 09:29:31 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 1 Feb
 2022 09:29:31 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 1 Feb 2022
 01:29:30 -0800
Received: from sandstorm.attlocal.net (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 1 Feb 2022 01:29:30 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Will McVicker <willmcvicker@google.com>,
        Minchan Kim <minchan@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Heiko Carstens" <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Subject: [PATCH] Revert mm/gup: small refactoring: simplify try_grab_page()
Date:   Tue, 1 Feb 2022 01:29:27 -0800
Message-ID: <20220201092927.242254-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82f158c9-1209-4abb-dfad-08d9e5655a3d
X-MS-TrafficTypeDiagnostic: BN9PR12MB5035:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5035AC32910600F2A4FBFAD3A8269@BN9PR12MB5035.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6nxch0jEMzrhVn4752CzISFJyFRlio9AZQ0FAdoYa2ErUmfyslwLZu7+ntV2wAkB0jz2C1FRNbcp8kMFsnf51x27N9EQgBNR11MTHvHwMR/UmWT5AiGSzDWmQtuDve+ciqG3rT2LsXr1Qd1HWgFHgwXSqj611TjsUWPhRy5bcda8YlZd1KM1mO7x3fcrOkjPUK56LpLSNP4XPxn0rU0JDBMIGTjb6Ou3lHvRhVyuvIz89van43gowKAOV0t8Cww0sI9KMGTy9c1LXIF5fdcElJQlbeKi9wkK8qQGYL422393bBOeeO+kbdkIQo8ezZ7uDNtbnzpYOMkNi+e6TYYfm0ZUnm+QcOeDEczCvEGrti0OHbfUVa7x9DPsUrEMup2ZFV2lM2egDYTt7y6BmhIsnOBdhORju0kQ8eRtSS4mw08ASeiPTdMi29oG8QQ36YbANZHKnHx5hky9WfIROpe5jHDQn1PA+2P6Krh3gTccJmkzAd3RPKYLeUbCUWYry9OhFLxhZloY5glw3WkBEFuadK8U789/lS041Oy0kR723aNmlMYHeAZhf/ASf28xKZySxCDSjkB7ljgZyxX1BzaJrB451tJTMtjKNzKuulQYi6LguZtmB0RLnWO0LTCTv+Q+8dbo2snOyRXLUG02AA62e8EhyNrpPbgm2GBN2NosXjA7ecSv6FoJgeYE/G2741Et4R7XkWWIRxPShewybi2AT6RgwRX7CG/cEP5uWxBYG3INXAG62M70bbN9pqZBKC0Lo2rJhZ+NhPJU8BQSxXuMfORNFIQI8ZnvK2C7e9XTHT8=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(426003)(7416002)(5660300002)(2616005)(186003)(1076003)(26005)(83380400001)(336012)(36860700001)(82310400004)(2906002)(40460700003)(966005)(47076005)(86362001)(316002)(8936002)(54906003)(6916009)(508600001)(6666004)(4326008)(356005)(70206006)(70586007)(36756003)(8676002)(81166007)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 09:29:31.7004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f158c9-1209-4abb-dfad-08d9e5655a3d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5035
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 54d516b1d62ff8f17cee2da06e5e4706a0d00b8a

That commit did a refactoring that effectively combined fast and slow
gup paths (again). And that was again incorrect, for two reasons:

a) Fast gup and slow gup get reference counts on pages in different ways
and with different goals: see Linus' writeup in commit cd1adf1b63a1
("Revert "mm/gup: remove try_get_page(), call try_get_compound_head()
directly""), and

b) try_grab_compound_head() also has a specific check for "FOLL_LONGTERM
&& !is_pinned(page)", that assumes that the caller can fall back to slow
gup. This resulted in new failures, as recently report by Will McVicker
[1].

But (a) has problems too, even though they may not have been reported
yet. So just revert this.

[1] https://lore.kernel.org/r/20220131203504.3458775-1-willmcvicker@google.com

Fixes: 54d516b1d62f ("mm/gup: small refactoring: simplify try_grab_page()")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Will McVicker <willmcvicker@google.com>
Cc: Minchan Kim <minchan@google.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index f0af462ac1e2..a9d4d724aef7 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -124,8 +124,8 @@ static inline struct page *try_get_compound_head(struct page *page, int refs)
  * considered failure, and furthermore, a likely bug in the caller, so a warning
  * is also emitted.
  */
-struct page *try_grab_compound_head(struct page *page,
-				    int refs, unsigned int flags)
+__maybe_unused struct page *try_grab_compound_head(struct page *page,
+						   int refs, unsigned int flags)
 {
 	if (flags & FOLL_GET)
 		return try_get_compound_head(page, refs);
@@ -208,10 +208,35 @@ static void put_compound_head(struct page *page, int refs, unsigned int flags)
  */
 bool __must_check try_grab_page(struct page *page, unsigned int flags)
 {
-	if (!(flags & (FOLL_GET | FOLL_PIN)))
-		return true;
+	WARN_ON_ONCE((flags & (FOLL_GET | FOLL_PIN)) == (FOLL_GET | FOLL_PIN));
 
-	return try_grab_compound_head(page, 1, flags);
+	if (flags & FOLL_GET)
+		return try_get_page(page);
+	else if (flags & FOLL_PIN) {
+		int refs = 1;
+
+		page = compound_head(page);
+
+		if (WARN_ON_ONCE(page_ref_count(page) <= 0))
+			return false;
+
+		if (hpage_pincount_available(page))
+			hpage_pincount_add(page, 1);
+		else
+			refs = GUP_PIN_COUNTING_BIAS;
+
+		/*
+		 * Similar to try_grab_compound_head(): even if using the
+		 * hpage_pincount_add/_sub() routines, be sure to
+		 * *also* increment the normal page refcount field at least
+		 * once, so that the page really is pinned.
+		 */
+		page_ref_add(page, refs);
+
+		mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_ACQUIRED, 1);
+	}
+
+	return true;
 }
 
 /**

base-commit: 26291c54e111ff6ba87a164d85d4a4e134b7315c
-- 
2.35.1

