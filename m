Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85ED4908BC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239905AbiAQMcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:32:00 -0500
Received: from mail-eopbgr150095.outbound.protection.outlook.com ([40.107.15.95]:24832
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231537AbiAQMb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:31:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lthlrqE5Y7CcpeXlFcDE0PCkJW0plXujOt4hMgk8ZlzXdBlczIl2o4j0HfQj1NSRl81HT9KsSI+wWM/KDwkKy9MjHhqkDMWqyPEhSAT7WqF/abDUqqvEKJPtiJSIG7RGqIBF1TzzCd6KxqTYm3LYvFlY7hYlmiGVdU/yV6XvKPVXJBFoE0FmSH65T/+SsWmMIPiaej92iddRewyeLjbkE95mXphzf/GU3R0rUMl2C+/DSrxcCCzgHQk2UbZfwziKlaqIASbpmftD7K8EVrUNCCvAJ0Tl8kfXGiWg9o2F/bXoaMk2DCa6TXpqxt4NfTT5vdWgldzmHw37ZoUoxvBwXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+kEUzMyFSNYAqmM/r4OPnrALCI2DqAOoZADFyWoQCw=;
 b=iuCpADTGnP+fIiwGSSPm2HEaw9FDTv1kqORbngtJ0qYCkrVXDCIojxW0gSaX57jqGvQMEw0nWuxIQ8QwdDBTXOVQUKf5EgyAymqshf0JujvrgfLrLQdrvCcgBFVFT5J2DT/w3YKXscLj5cxgXvQY3/i5Lq8xa+S6RPNuGEjBX6/iPwKQPBajljenc/fUJu75wcxgXW0coHx/PobpYNEVwqgEtmI7e/9BSr8OO1snWcG7k6fU5g2elkQDciRGBsElrhf0Lm2b5eESnw9jAGAthubPuA9FGV5o0JwKLPsIHcXwmwoVqgI23vJa2qV463j1JmR5MzqgbMIjTsiIdG6HsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+kEUzMyFSNYAqmM/r4OPnrALCI2DqAOoZADFyWoQCw=;
 b=wDGM26sowF5HC1ce6wJ+H/yuBlCH0fBMEsJ+B9ni7IALEkmyqbdkwDl/3I5wzG0OlS678slRpZz+BfSGKWkhLkBpsA6Noj6zQykLwlfbr2q6GFdDzy2kk8S6dNg5ZsGve+txY/iEm6Ao2tn2zNDwq3pixPPfG/KPJskBuLv9Sp8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from DU2PR07MB8110.eurprd07.prod.outlook.com (2603:10a6:10:239::15)
 by AM6PR0702MB3733.eurprd07.prod.outlook.com (2603:10a6:209:6::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.5; Mon, 17 Jan
 2022 12:31:56 +0000
Received: from DU2PR07MB8110.eurprd07.prod.outlook.com
 ([fe80::9d2:7ba2:9045:2acf]) by DU2PR07MB8110.eurprd07.prod.outlook.com
 ([fe80::9d2:7ba2:9045:2acf%5]) with mapi id 15.20.4909.007; Mon, 17 Jan 2022
 12:31:56 +0000
Date:   Mon, 17 Jan 2022 13:31:48 +0100
From:   Krzysztof Adamski <krzysztof.adamski@nokia.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Matija Glavinic-Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: move efi_reboot to restart handler
Message-ID: <YeVhtL2gCLkhTPdv@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: HE1PR05CA0249.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::25) To DU2PR07MB8110.eurprd07.prod.outlook.com
 (2603:10a6:10:239::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 439ddfb7-a3bc-48e4-9181-08d9d9b55954
X-MS-TrafficTypeDiagnostic: AM6PR0702MB3733:EE_
X-Microsoft-Antispam-PRVS: <AM6PR0702MB3733FA93AA493EEEC4BE5B8AEF579@AM6PR0702MB3733.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AslyZjrF0dpWvrKltpzKPWM1UKJZqXfnOtJRrUv85qZe0jrR4r4FpPMF3Xq0a/NBI9phja7Sho+xCJ64krcXwJYyNoieo7UuAj+EM2u4ea//HD42/Hd25ukGX6jOpHmKhzeu3BGI0cci7PNQEPvAlMclfIx2egmsApRTg5GjqQHpjtDa1IL3d5b8dcjlz1ABMmSo69SPhkueRVA7UU5yOA/WXMBDOKxTeX5i7jBIh1YmObDfFi4LZ8I/ER4NIy0TRzWPu11T+IZsXg/b66KHQpplu3cJm9RONN/THXXzxtGcRJVPoqV+5Sdm63PHba6F2r6SBUxYMtRlyZ/XOP4UQ2UnBhjkrThUJjUht0Y86qIL+sCj0E/cKB3PyFaetC27eDkasGw9tmhhjMRJteR1jYMFKtqlQiVcvMHH/2tJGeN/QPuLDxCUcMV4GNmvMcAYTvXXsp3vxnGs5MIpoJUVcyIha/idbzOeUw9Xp4PEJ20QIK8gUmnG7D2f1B6OVPzRUN1cXmYALS0ngq21KXJO0bkLiw3fWZe8giSbFhxzVsUGJ8yYX0wHeXUcvbO8rGamCzMVEAOXK6mtrUfZcbpg6/+lX5H33neO12BY4G2Xub+J8IrkZShDaFbRjgThlSqMiUQ7vxgEy9cc/118isQ+NfZ23X+IYKBITsyvPZmZmM6XM3vWB9aXpBXDp/Tv/QBUhtd6nxpjLq4FS7mlMYep8TW6vKXkE0BBRnYVUPrcO+eBkyQpRULIsR/YN6+aQrz8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR07MB8110.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(8936002)(110136005)(54906003)(4326008)(44832011)(8676002)(82960400001)(38100700002)(38350700002)(66946007)(6486002)(316002)(66476007)(66556008)(5660300002)(6666004)(6512007)(52116002)(26005)(186003)(6506007)(508600001)(2906002)(9686003)(83380400001)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zh/7goIifNe4V+qcypBkJ+eRwJyzWMKRho0TPrMtTLvdPkA9qR07mnf7O7Kq?=
 =?us-ascii?Q?pY4d4iBGgSSR6MfiWFanhRynmIwticGiHmkcIadQLQtBek+8FEqqwutHN4Xr?=
 =?us-ascii?Q?hyMgWyp/hge3F7sfBbqMhObcByBZCYGtJo5tYcZgdsXz7V0sqwUCFTttjk+A?=
 =?us-ascii?Q?h8ql9xAfGWQJOQtSYiber5dhAsGrzJQ9XLOcVQEZalxhDkY7Nz17kIWk6L52?=
 =?us-ascii?Q?6V9k62gVC9AalBRcs78m+fhpoM32UB0D2CEfVx03HyjNVo8Fcg2NOhWHkYBD?=
 =?us-ascii?Q?cr9/7zopa6/7fDSV/bXdtb2B2Hl37zKXqev9IuKkcteeKK4dekmnYjurcnp2?=
 =?us-ascii?Q?GdQH9jcw5zi2iP2oOiuDB2QyCdgCx+iZ89ME1I1OxA6Xm7GTCZMnG4zq3hjk?=
 =?us-ascii?Q?2YHkDaU95Gk1UmOYbloK2Fx+4Cq/P8ZRDPljU9+8ds9cHcZiElBpUpcS9MDg?=
 =?us-ascii?Q?R5IQexvKO3KuIqX9bRjMpiHQko1/NMBgXH6+EtgC4hib3p4Ei+yQiBJsSPzX?=
 =?us-ascii?Q?FejvxJMhlpeloz4QbI/0ziiM0EG4CikaVlg+y21RPLV6/6JChajXYzyS9We9?=
 =?us-ascii?Q?gypfMldysKaYE/shgmyxuPbNE5fNJTPnhoUTNSZyzXYzcHb2JTMpIwzgw9Zu?=
 =?us-ascii?Q?WGGY2eY2cwlFv9cMqKeHlH7ML9IcM+TzBs6FCiNKO98jq/P7ex5yjLERVzIE?=
 =?us-ascii?Q?NqEyi94DFaHMuRY1Xup4VajBTxYxT5EW2qsbAfmUlwX7d473ehQ+SQTYRUt9?=
 =?us-ascii?Q?ab7kVY3X+FBkIc0nFKkrVsQhFMVJL+kSU+K+4u2o7tqyJDX1uzZRwlkUozU9?=
 =?us-ascii?Q?2mqWcXRmihnWh0MPgLyjzfkiSJh3pwSUGkT3jqQ/KtfL56pHI9VaMRY4BgHx?=
 =?us-ascii?Q?z6Ac+ZJwOECw4o3tHOVp/MzbkUGV0MLJf2fgrIE6TC6UmP86xZCxFpLANuod?=
 =?us-ascii?Q?842GKcDbc3GV1GuEmumAEKVIWQozAFrN3R/ykbw2mjbIXY20U0gfRPnYWYvg?=
 =?us-ascii?Q?VrnCrcDaoNj+x7rGfnUgpxsRz46uB2Vkjy9B7wcYfbpVGCMiVgDGzu676fTA?=
 =?us-ascii?Q?LMRIISV4yGMqhPdchFlfKHCXntbij9yMtvf2rThJv7PnnA9lJpvzRKXax+rk?=
 =?us-ascii?Q?B5qvfQdiamDx4eyM8yKBldwB9bG+KRBjcTlsntGYRKIs5NXDM4WnMQi8CdPl?=
 =?us-ascii?Q?B7fwudU9Hgk9ITOJHOF02pLYjrUWxlGaXqMJGrV6GCXmvg1A6dHKlEkBkIfB?=
 =?us-ascii?Q?MVDddlC2WkC9N12SIxvFEG5bbb/ql44jHDYJ3Q1OOEbSPa3Mzi1kxkRXu5gx?=
 =?us-ascii?Q?PUPYYstJj1jalMg4uv+LKQlUHFBLYBtLIxL55SzouK0bQ+edxOOo9zBAOe2C?=
 =?us-ascii?Q?rrMI/62GFjrqhqw0OAPuOofZb04DhIhXpX8enLqtE3Wl74SXcV7vqfDaveLM?=
 =?us-ascii?Q?atOJxUbzBlhTVq0PasL1FahJo6GfyBoifLGiXJY/vbothCRGOMJEuCS0Iipx?=
 =?us-ascii?Q?FqQmtnRhLbYyDdUod8gYYeK0WITU9lmS+c8otooSin0xJYyLW1SDZ+WD0Sd7?=
 =?us-ascii?Q?1AwAtLRdzIiOvj6y35VQTgn1lW8yIcZDhIuvwmBv/vLPgA3ZcrD3rJTNM7FC?=
 =?us-ascii?Q?SQKaauogRCeiR4ALkNUMlAMjjLWVyocjMl9caPV6XmjlRaGv1LrnnTCkm+4e?=
 =?us-ascii?Q?KYWGRw=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 439ddfb7-a3bc-48e4-9181-08d9d9b55954
X-MS-Exchange-CrossTenant-AuthSource: DU2PR07MB8110.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 12:31:56.3314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: frZxoZlsMeD5Ku2X59xTlLegN2A75ggAF7Jv/Z2E4u3yv1LSvpWGhO1x6dkUAqIcw20CunUKLYbp9RoktJK/4mxbXQk16+UsHSZua7m4/tY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0702MB3733
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On EFI enabled arm64 systems, efi_reboot was called before
do_kernel_restart, completely omitting the reset_handlers functionality.
By registering efi_reboot as part of the chain with slightly elevated
priority, we make it run before the default handler but still allow
plugging in other handlers.
Thanks to that, things like gpio_restart, restart handlers in
watchdog_core, mmc or mtds are working on those platforms.

The priority 129 should be high enough as we will likely be the first
one to register on this prio so we will be called before others, like
PSCI handler.

Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
---
 arch/arm64/kernel/process.c |  7 -------
 arch/arm64/kernel/setup.c   | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 5369e649fa79..b86ef77bb0c8 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -130,13 +130,6 @@ void machine_restart(char *cmd)
 	local_irq_disable();
 	smp_send_stop();
 
-	/*
-	 * UpdateCapsule() depends on the system being reset via
-	 * ResetSystem().
-	 */
-	if (efi_enabled(EFI_RUNTIME_SERVICES))
-		efi_reboot(reboot_mode, NULL);
-
 	/* Now call the architecture specific reboot code. */
 	do_kernel_restart(cmd);
 
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index f70573928f1b..5fa95980ba73 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -12,6 +12,7 @@
 #include <linux/stddef.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
+#include <linux/reboot.h>
 #include <linux/initrd.h>
 #include <linux/console.h>
 #include <linux/cache.h>
@@ -298,6 +299,24 @@ u64 cpu_logical_map(unsigned int cpu)
 	return __cpu_logical_map[cpu];
 }
 
+static int efi_restart(struct notifier_block *nb, unsigned long action,
+		       void *data)
+{
+	/*
+	 * UpdateCapsule() depends on the system being reset via
+	 * ResetSystem().
+	 */
+	if (efi_enabled(EFI_RUNTIME_SERVICES))
+		efi_reboot(reboot_mode, NULL);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block efi_restart_nb = {
+	.notifier_call = efi_restart,
+	.priority = 129,
+};
+
 void __init __no_sanitize_address setup_arch(char **cmdline_p)
 {
 	setup_initial_init_mm(_stext, _etext, _edata, _end);
@@ -346,6 +365,8 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 
 	paging_init();
 
+	register_restart_handler(&efi_restart_nb);
+
 	acpi_table_upgrade();
 
 	/* Parse the ACPI tables for possible boot-time configuration */
-- 
2.34.1

