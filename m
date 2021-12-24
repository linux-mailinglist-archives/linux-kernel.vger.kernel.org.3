Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A020347EAA2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 03:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350989AbhLXCsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 21:48:41 -0500
Received: from mail-sgaapc01on2130.outbound.protection.outlook.com ([40.107.215.130]:52578
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350885AbhLXCsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 21:48:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRhUS1FEZnEXIRIGUAa7GVnsKS8lc9HOHOc/Y4zjTjQxISqMeOZn7yf+yyvpYjYfAjUP/da516BhyakAx6vmTa7PuxqzPo2RHwcJwq0FCBIUNpOlkj+yEiFjZHfODxaSKRmK3sM2bAWLkHCYIqnmv8Htnnxa2Tm6Fvp9HWIgfXuCucTKsrQrj2NvP0a+EduPDhJMCTANv7tqVUSm/KN2Ae6BH4RWUl9LIXPRFJEjdFHYrRTHVlFerudJ3KCW3kfbI8css1hmAFQmzM95vv42h5B24djnYz71xfFtDQd6q05jn3pzXlHIJs4StsHU+HuE4nHphZAkQqDXULYPo4FTQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+xcfH47mJScbGJeOWTKygOLld5p8fHdRCIASCaRvxQ=;
 b=hvjzjRtHMt7b1yqREBs9+Rj+Pbk2C+giQKEgIQrKou4sataFj5Z+6i0rBlKQha0GVS1fqSyKrzu/yKo5aBRsVlOXkW7FCmL5O6qYGKhjkYu+RkRNO+5TPnOHr8IL6QJpWx7XxV3W63JH5mo/2mwOQ0LrblCKGt2qzz78Lm59/1UQ5e9PIumzD6TbkrudimVeZWcwedwOP0a7cIKfQbDlK1qbkEkGazoz1/YOs6yPeOye9p8Em6j5Iy4+t0CVyBzkiS9uNSJ1wyG0OGE1JkYkpl4R2iAnk0Q3sSEhHvUhXY7mf9pQxl5EIdXgCuxL/iW1VBWyhgIXZ5JjdD9sFt0o7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+xcfH47mJScbGJeOWTKygOLld5p8fHdRCIASCaRvxQ=;
 b=Eh5yf6YQpmevxENtBlKYvYuVKRfKSqZWU/eBQqFcP2yb+Un5eM4/sqiSd+V+0IZlqpLCagTKjIMim8OiV+RkoOaACzaUvxPt1XR9hzUzfsnlz2+TvgbJe6gVp7iCT6Iio2VSczuk8rp3anWzSRE+hVz/34zxyzT51ZSnxDDiaVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by HK2PR06MB3284.apcprd06.prod.outlook.com (2603:1096:202:31::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Fri, 24 Dec
 2021 02:48:36 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::8986:b885:90d7:5e61]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::8986:b885:90d7:5e61%3]) with mapi id 15.20.4823.021; Fri, 24 Dec 2021
 02:48:36 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-um@lists.infradead.org (open list:USER-MODE LINUX (UML)),
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Cc:     kernel@vivo.com, Guo Zhengkui <guozhengkui@vivo.com>
Subject: [PATCH] um: remove a duplicate include
Date:   Fri, 24 Dec 2021 10:46:35 +0800
Message-Id: <20211224024635.7497-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0024.apcprd06.prod.outlook.com
 (2603:1096:202:2e::36) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bb0e4dc-cb97-467a-f42a-08d9c687e1e9
X-MS-TrafficTypeDiagnostic: HK2PR06MB3284:EE_
X-Microsoft-Antispam-PRVS: <HK2PR06MB3284822F9D21767B8364DF03C77F9@HK2PR06MB3284.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GzP2wtRgc0O6A5fy2hnWqhznAlIMD5THcEXuMt268BStYOcPionOjEr29DjhcAkF1dMG11wzSFDUkGd/aEoyJfiW7J90BEzgQ47KCpGk6YxPhi2DvqFTXns+rg5WvuFyFH+o2eu+6bDjkXUQvPmJ8QZOgG6ZR0yie9DwFRirwjzbaEnCjzVD6MvbZpSN08BiWLDJDZEGdgi5jjDXtjxmuxtxsmQg9sVl+h5v4gU+Cl8zoDeEqfTHNrv9aURkoEgaHeA/JcuhzkXwbPvjqcVf/C+BMo7NT8UTPbvgrYpiajkZHfvM8HtDT3BOMQxIIH0qHEKGgLayyLaoQyofDi3b6SjQqMjxT9qHq1olhxIP17eGxpWIW8HqeURZ6xMQaLQfiRD+Edi3iUHL4RutOCoVpnIX/grtEHL5ajJ6uO1tHU2UKfDMAISZwoILbf1Jj7lgvUgWl8wfrTk9qRbxhz+W+pAoUfP1dVlk97jpl9+2wwb0bZeSb2ospreB67t1Er/R7s80GKagrR4IcJcvVUI3GiLk9e4KvhSvWorUnew0MuEIVpZEUSPWO7T6PQ17PyZodi31ISczvHr8joqwnPijTS9lqMcjw60XKGROPpZX/Xj21dbrzD8kUrvh8pXTn4j2Ad8pWVPfq/9kPf73Es6Y65IZrHKCgsMRxTrcxA4iNn5YPlZL9HVQ5wFmAYxSMEbbFQ2pJEuc7xnZ7pIGvURz+C2nfoZybwFj88hbdjfG+cFGTQ48T07x/4aVtb/quZg2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(8936002)(2906002)(38100700002)(36756003)(66476007)(8676002)(2616005)(52116002)(38350700002)(83380400001)(66556008)(6512007)(6486002)(66946007)(107886003)(186003)(921005)(26005)(86362001)(4326008)(4744005)(1076003)(316002)(7416002)(508600001)(110136005)(6506007)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?odOPJQZzHMuvt4k7PrOJaj4P4UuqGOPa7YfMAsOcX2kJF8L27LBAc0VPWsFm?=
 =?us-ascii?Q?qyzj5EY68fg/Tf+UEcYQfBjvxM8vqY29bf2f0em2McXJVg6VOJYECNyQo82r?=
 =?us-ascii?Q?KTJI3jq2ST/xovq1YEIYPsaMcF05+uFEff2odgU5W0WdRTGtgHQVgXfTA0Ma?=
 =?us-ascii?Q?kNb+X6zHpRDsRRPCrYzIpelWiTlkbrGxCWNnEtZe8tXjlz+4/ezKkC5hsviO?=
 =?us-ascii?Q?myn/M6HfD1En4rR3ZRNerZ9IXxXbSAmmOeF2DF4r9XMG6CIvFMFAwdvSdN0B?=
 =?us-ascii?Q?8F0ABWU23ill7YyuEK9Ue36MGvxKemVZgd2hilTKv8JvlcPrWtjPbZxVzHQN?=
 =?us-ascii?Q?qCxZ3TCTOtZabZFKvbOL7tS6YygBnnEgSx5rXWus2jzV+zy2PoVrJeddV9mG?=
 =?us-ascii?Q?aEkpD6hnQaSPajucMHB2WrnCCSfcDKLWuE64k/PkOTXK2zviE6SOT42tofdx?=
 =?us-ascii?Q?Ji+omOw6jDTXYB5BTeuqFr+gXguVgciMZJ+3bq4ABLHXLA+XMVppSr8gnNen?=
 =?us-ascii?Q?dEmxUJowQJ0Cahipufr+g1XsIm6+1S7oSHqHyH5vju1roCIgt8g/+UVM9ob+?=
 =?us-ascii?Q?unyHpBJV9WzYAn8v4W0uPKiNsV6jha9vTFZUSX4I1/GOxyOVEBtIg4yGJUmk?=
 =?us-ascii?Q?6hMAEb7o996LtDvUg/SzkU+bCZRsDoPGAXApSgNjQC2S8nnXfT3loJV1wkR2?=
 =?us-ascii?Q?5q2zo5rtGmKBQrKM08Nt0hWYrNC8Xp6bsJwS0j2VrIVAuNFzchYX+WDtzSbV?=
 =?us-ascii?Q?dfaITg87Vz2MbKx1jKGjLBil48Cn5wQ84/273bOQvfxJQCMFLlM3dGdY7Ia1?=
 =?us-ascii?Q?be54SPh8DahnmgT66w8fNCCxTVhR7MCLk+NO1ee/8OtAJiICDDGBrzTK+azI?=
 =?us-ascii?Q?k6xIJT874vgjFhbgNjAo7JOK6xV6JyS6iA0wYZZ+QaHRVLVMXg92UVjdsexP?=
 =?us-ascii?Q?+L8MjQxbI1359oj1QfX0I0FBAPB0TEM/ugKzmy8Q+p4Gj5Gx4FOMUHukgEYI?=
 =?us-ascii?Q?xebQ9h9AWeboeAfVJl1mHhDiGhRjqLeiN8i0Fj5nS0HcQ1gCPx/BCy5GJWvb?=
 =?us-ascii?Q?MniWpz6PKjRiU42qol5QOfzkG3fza+cyQCbt2/NjPhHhzDIRhj8yBvO1PnRY?=
 =?us-ascii?Q?XmEnZ0VjZVRhHMaAcwrPdKsVmNWfQvu5OxDHUYFBVLC1vOHfrE5iIYXwntNw?=
 =?us-ascii?Q?2MV4s4T1DiYiOhtbibyAhrKjO93+6j77zmYPmDKpmVgx8IpQNrO0MeZBbuls?=
 =?us-ascii?Q?PoOfljPjPymr79qa+tkcugzpyppeThNdcEDYm6qoMhfCSfELqFAaqgUqJCp1?=
 =?us-ascii?Q?RkG7n7xST95kihytBgZ5nzCUQLIbXoIRdp7KPlAPcoGhp1X1BNDRgcKHwpSn?=
 =?us-ascii?Q?tePGD0V5ioUO0cU3HZiSLbubRRTvZ17WL6ySpjDUaTYPuwc1rFRXNA2PbJ0t?=
 =?us-ascii?Q?UPS51/j0wPXl7kiFKPuSm5pXLrm8J3HnRqlf+/OUqvHSV5lPO4zPHe2iER7O?=
 =?us-ascii?Q?FqIyLnC5svkSncohGjcJfq5x87wxXdrJ1/3e97xTnsoYiY4ntgXF22zpYggj?=
 =?us-ascii?Q?S+stk9fbQmY38eNA2AzA0O1SlSBoakzTW/CljqxWfaz9dpJNf+ZYn3wcWIcX?=
 =?us-ascii?Q?NcAGinV0kdzPAb/Da5oWCq4=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb0e4dc-cb97-467a-f42a-08d9c687e1e9
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2021 02:48:36.5851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tZsm8cw4w6ACZ7kuzIvSZt3dSLWjJXGCm76VVmCu6llkXHfN9aOhQ0N0Dwtx/3fg76FGrpzNWZx4CQ4LTDTzBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR06MB3284
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a duplicate "#include <registers.h>" in line 15.

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 arch/x86/um/syscalls_64.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/um/syscalls_64.c b/arch/x86/um/syscalls_64.c
index fe5323f0c42d..27b29ae6c471 100644
--- a/arch/x86/um/syscalls_64.c
+++ b/arch/x86/um/syscalls_64.c
@@ -12,7 +12,6 @@
 #include <asm/prctl.h> /* XXX This should get the constants from libc */
 #include <registers.h>
 #include <os.h>
-#include <registers.h>
 
 long arch_prctl(struct task_struct *task, int option,
 		unsigned long __user *arg2)
-- 
2.20.1

