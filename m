Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37AB4B0841
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbiBJIau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:30:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiBJIas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:30:48 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2091.outbound.protection.outlook.com [40.107.255.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE43610B0;
        Thu, 10 Feb 2022 00:30:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/p3XGAkGytFnyOpgHmpeTnBblrTBDmB6LEiZcospGqsDjc7NtZn0n6JImi2AQyUopzZxTqO9I3oiX5T4sxpmFOw+us/rfHe2URuvRhSsoW/TAoQp+JHE152H5lCE/Q76SJuQ6SBYXV4uZomeE3f0gorRhwdf70cVfoWGH1IVJbYDXdjznIXgVdVr899hgHXciJdNEe1lbvTI6Em7LRwCVFE+/kRtvZqbdB15AA7VXwZ5XDI5Lm6VE2QS0AEK0mvUi/4USwQam3e+zrqliNr/1ZxPKN4y6mUXehX4ajxXtXQez7tqT3/07lDUoUcgKDaAmcHDjlmDSYdivIJCShY6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGA7faf5kLkUcG9mSGaAuI1o6DTi+kOMDKr1jYMxkxA=;
 b=jveaKxlLiD4WI2j32Ghr8BGkHg0CA5u2nfr/nZtUa7+/kJmQdsHo+eH23ZXxQIXiFKpJ9Hg5bHHeVBmeRvTidZx+BG+LXLYedD16rpm93gZW6Nhs4ZLSyPPIc51i8xDfkvbWmVKiVjYSBL4on4dlLGykqSK+LHSJAkgIj8M7Kj+FQmBQJ3LaiJTgANKjFjuaKGL/28M8SN3tcINO4Yin2f0Wjg2NMaQLv/EdO4lULaS1Q/iQRiyGlATeIsBSnTah8SrO/Y+wLQm1/eqqtV1qJ8BZFUSTZstgvnBNfvyXJskkZ7XkdWG5dS/WjyTanHDHTtn6FycH2bT+TcO/VzcxqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGA7faf5kLkUcG9mSGaAuI1o6DTi+kOMDKr1jYMxkxA=;
 b=dNvPzXLzrmKmTOvU+c98Bfi8bGfUiGR8pbvtvRcWP49kw4RzKuPaTtPsJi5EKbtR2hOSqbxvQXpGffbGOWus8eVMnL9X58/5bkrNhwYnFO4cCunRm9Nb6jxNZyXp/QSWtPrbrQNSUWgWLkC06tz/3C3fgD978bQ2ddHMpWF5RSQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by PSAPR06MB4005.apcprd06.prod.outlook.com (2603:1096:301:3a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 10 Feb
 2022 08:30:48 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::80b4:e787:47a9:41bb%4]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 08:30:47 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] hid: use time_after_eq() instead of jiffies judgment
Date:   Thu, 10 Feb 2022 00:30:34 -0800
Message-Id: <1644481834-14677-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0145.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::25) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e507f42-95b1-4520-93f6-08d9ec6fa2f0
X-MS-TrafficTypeDiagnostic: PSAPR06MB4005:EE_
X-Microsoft-Antispam-PRVS: <PSAPR06MB4005A4634664329E6E6722E2BD2F9@PSAPR06MB4005.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nqXZofaPRsRbxwKnieUqXElgPQ3Gxz0XCZpxEzwdgRdmBiik+aLBgu4uErZuloVFE0vwvifsLIxhWnkdF/zcCMCRfkElPyu86RhMtsblpjqhiRtuN4JT/WaXmPJHTCpJ6k9lJSzNQIcVJRD3J82wq0HjMV6r2ACjotV5IFHsR0GXbsPys1j9hMfX+q4lRbJUeM30vpHbbL8NSxsVgIoKCFKUoRExXCGSDuPLu+O8IIfJKFmRJGBPMMjf7AzZqIq4IFwJfJ2PxtBbxUXTS6CV6ebacEiINgoK/cjOBl2wtgTWKQWwTn1wEy7BRYc3eiescn9M6pV2NNao+IXAg+IoEz0wYY+4xwDgzdhebvP21a3Fuffuey65MgEc/oGAZVL5jOSCpEo6iuZrWYblgdG3aF4s3Csiqr6oUBcYvOC1Sj07L+5NVtiBwsszIT2foiDy+JR5CJoSahm0SUkQDpL1sHma6kJI5W9Gri3o3Q4fvufHaaX7kwOgCJ2Zexw6aTB9VqBTJpeQ3TrjhBpi6mY1ecDRMcVMHzgtvJPnvAEfq5NcwHJsDDJXKAhbZ85ixcGtfmRKS2HqZhxmhU3NYa5lTnqECtQUo/wB2/JadO18SDk3Win2zrtL1EP2H3ykVhDhoUzEbbrojckUGQnqHy3C3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(508600001)(86362001)(316002)(6486002)(110136005)(186003)(2616005)(66476007)(26005)(83380400001)(107886003)(38350700002)(66556008)(52116002)(8936002)(38100700002)(6666004)(6512007)(6506007)(2906002)(8676002)(4744005)(5660300002)(66946007)(4326008)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: e+uT/eqs2P3qbpKeAJz1YLM6wBRppwMP+VJ7mWb6U04pWuh7ZKA5NkSOtt5jrw1sWR3/RFXZbmNahe8yreiI9N18KkKDWBHwxpBtj1D+6nCh9L2mUaJMlPEYx9Kp9rFmYsnt/GrXpiWqwpMyuBK9SzXVRt/jf2RqRCEjSVOOPYkvG+hyLe3nO2RxSKC+22XHN+w0a7sda8cHqMxGl/7CeI16ehWjw0m9jxcrHYN4JWQIjjzMem+1qOlMn0YjVr1v9toL3qsNlCdJVhfpgScZhVcqoDyM71fCQM4vqpDbh4WiqqiJ5GFHIrWWEiXAe4jkemyLz8sils1U0Dt/Bah86EhRg9SjSS4mhsyYyKuvhUiqiCCw2fO2PupKTzUvoQYS6niCKr7gRVWOb7eOAE2kmLTSit/KGaDus8yeKYdqHVfjfQtwnsybGNzToWiVFngf
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e507f42-95b1-4520-93f6-08d9ec6fa2f0
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 08:30:47.3367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XeEy0/UXdIMlScQRHNxYpNdk1sPatbn1fLtEDJmCEucoFQxe7fi+cxwZQB5WXFkhlEiWBdsr6qxqgq9AOi6D4g==
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

It is better to use time_xxx() directly instead of jiffies judgment
for understanding.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/hid/intel-ish-hid/ipc/ipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/ipc.c b/drivers/hid/intel-ish-hid/ipc/ipc.c
index 8ccb246..15e1423
--- a/drivers/hid/intel-ish-hid/ipc/ipc.c
+++ b/drivers/hid/intel-ish-hid/ipc/ipc.c
@@ -578,7 +578,7 @@ static void _ish_sync_fw_clock(struct ishtp_device *dev)
 	static unsigned long	prev_sync;
 	uint64_t	usec;
 
-	if (prev_sync && jiffies - prev_sync < 20 * HZ)
+	if (prev_sync && time_before(jiffies, prev_sync + 20 * HZ))
 		return;
 
 	prev_sync = jiffies;
-- 
2.7.4

