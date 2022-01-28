Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E894E49FB0F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243076AbiA1Nul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:50:41 -0500
Received: from mail-db8eur05on2127.outbound.protection.outlook.com ([40.107.20.127]:18368
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236497AbiA1Nuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:50:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aK2QyIJZ7WSp83/ezAgNU3oe0ju2ojdj1zFV7ya5OPuGlgV6nCnP9UP+HhdcPkJ0TbP7nXII4LsFAhtiB3/X8VrxPaKtaDF3xwjnvthhwEJiugDNOzd2oNl2BBKXE3sNl4mMZC5WH+p2+qiiwG9j3Gpx1ZdrMvDT/xEeNAdfetN/trgcqO8PZDxQfU/sfNVEmI/kjGmcIAakUFu5B3kKP7+QA33Fd93NOulWu65ycZi5sJj3UA7Si2YIlWw3q37FFQGR5p07FxdW8DYZDG1wrQ4hYZnXT3Ykloqs8w8rcxU/yY/fyOFTNbF9qRdNobjqeQHClcLZfpZq8Cldokz87w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xn1jHAIEAchzovuvuO0ffAC0y73Af6z9jQa8ClpwsUQ=;
 b=S7G2chKoTA3Tj5SnQoHZvPneKqU3vklPz5LJIkBxMVMkNzRV75cOrwpIjIhcwWI+qvrz/uU97ZM+KIv8lTSA5HdxSK3fUvskFuUu/KYFtyW28dw4vi6eeijq0KqHUq1vCbB2+6BhHo+QXAKKXgDSU+om7yTQgvhkd1FlYZhqpthg+M8Bnwmx4e7+Lhp54XM0RtHwZuxCaIX6cX17ij3w1iBeBtlOjv889jVCf8sbazzry6b+l7uZvlJklTx6f4zExk784vw6QLM/K5MjB4jqw3qjLe7yNkRYuQisudn0JtdqQSdtXdb/nfBOHtlGBlt6jIvYDEzNYk7ZAdub6jxfHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xn1jHAIEAchzovuvuO0ffAC0y73Af6z9jQa8ClpwsUQ=;
 b=i3gDEag2Hvp+XjTDKLvM+HMiHyn1UxpkwZzVIc4fcZK72vBTFGkSzUe2Wo4xD48/D2aDVpPpFKN5d+Y4MXI0ni+N7Q7e6a0IOKs0fKfP2Xsvk11GjM3Y8REmRRxN0sRt5N0N8alVYOv4AU0A8oQ8htB+bqWSU4+50IYhTp9SGS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from DU2PR07MB8110.eurprd07.prod.outlook.com (2603:10a6:10:239::15)
 by DB7PR07MB4571.eurprd07.prod.outlook.com (2603:10a6:5:32::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.6; Fri, 28 Jan
 2022 13:50:39 +0000
Received: from DU2PR07MB8110.eurprd07.prod.outlook.com
 ([fe80::adfc:7f91:31e5:f103]) by DU2PR07MB8110.eurprd07.prod.outlook.com
 ([fe80::adfc:7f91:31e5:f103%6]) with mapi id 15.20.4951.006; Fri, 28 Jan 2022
 13:50:38 +0000
Date:   Fri, 28 Jan 2022 14:50:26 +0100
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
Subject: [PATCH v2] arm64: move efi_reboot to restart handler
Message-ID: <YfP0osb45uJldtM9@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH0PR03CA0446.namprd03.prod.outlook.com
 (2603:10b6:610:10e::35) To DU2PR07MB8110.eurprd07.prod.outlook.com
 (2603:10a6:10:239::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb0a705f-9ddd-485a-dafa-08d9e2652a5f
X-MS-TrafficTypeDiagnostic: DB7PR07MB4571:EE_
X-Microsoft-Antispam-PRVS: <DB7PR07MB4571CB3A57CB5818FDA50759EF229@DB7PR07MB4571.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /C3QncFK70j8i8HVY1IsHfKi3kZDbtFIlNacOPb5olX1TjmKsgNL+kfLZrxq+NPk4GnuPZQy4KVpIANEZK7irvte8jNddm2/PNjApeDqkP86jYiSdCF+17a7urh1Zps6pXcaeDgMguXI8DbcaHh0I8E0vmm9FOgjnYooH3rqjIrX6Ei3cnKPNBKZNbk2Z9zMFQcEneypvvmID6lpbpuGAvkjGk4vgCyi/OSb53pOKTpfHf7xYJ1Xj8XrilEKVvpXAAKW7K1ZcKgedR51yhy2EzMV7pjQdtvy3hxbfvuoqCr79a/JM/AxKAdlrNUtWkbKNLj9zpYtwauk7V0T7jmjNtTZQfaU9oOprqIopPpez8l7oAo4TZi1DdAfL/r85E8rcqQXDxUAgp75edE/3QkhC+cw4ghx96CMd1Vp0cFByZ9oFqMgWrWiqb2G020D0XZ2/S6JBlU6qpmas3+z3fu7a2qPgqt8w4Yo/69uLSeX29hBRSvEz9eDkN7Mj3ngGAf7wPUmTol4WjHfoPSJH63hQxSioJL14EIxsqCmyAXpnVB4QHiiFBQuS8uPUS7tysvHu/Z4Ym1BVW0AexlmFWpedPjMidR10ihFXKThpSJFn37jY1y2AEavH/cjBGhvsTE2iiUwD7qraldoCcE1PVCHCJm8WEdIEafXXpfEZYkDASbWCM/i4L09Z9WxQaW84tT5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR07MB8110.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(186003)(5660300002)(2906002)(82960400001)(44832011)(86362001)(26005)(38100700002)(508600001)(38350700002)(9686003)(6512007)(4326008)(6506007)(8936002)(8676002)(66946007)(66556008)(316002)(66476007)(6486002)(54906003)(110136005)(52116002)(6666004)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Vylt7QnJvfygzxNZQ5bbNJ2klqhQQPPhdET3PVAxHlVilZKMimzgDX4sQ/l?=
 =?us-ascii?Q?t8G0TuX8MAdq5kkr7uxx4rSijs3gJ8W1MjW9z+Vesl/F8CxLSm+w6n8wlw4r?=
 =?us-ascii?Q?RuPZxXPS9XU8iOw7Ux1mo0VlE2nGjAevqrWBoMVT4X24vI4RfEFNxatgarvR?=
 =?us-ascii?Q?rWHHAtDb9hopNnjXUI80D16QanF6zZDww4VHF92WqOlQoFI3gHey6lqHC/FM?=
 =?us-ascii?Q?t9A/Ll8RUqCSwsXDXXt7QiXstodmMGVOizCN/VTSuaQRsreK6Q4EYhtcoG1m?=
 =?us-ascii?Q?ob5oH9sbwrShKQZtSICvrAjCwiIBFDN4qgaQAroQH5RIChSnsHJWF95LqV7X?=
 =?us-ascii?Q?5bJi+Vw4LkVCxUJ2i6prxBUcCZDescgLLqKxXqZyH0UsZMlbo+VZy/xiQMMw?=
 =?us-ascii?Q?wD4hQonjOBKQsNYTHpoPMjKbhHEFAQXg1irGUC0MdYPwQqIYSMwPs//Gyhai?=
 =?us-ascii?Q?4OhQZZv2XrKgB959MvQ7qTQVi1oOgdF4NiXc+K6S8KMB8Wl85n1lR63m1K2g?=
 =?us-ascii?Q?qz7g3QfuURkkCQNTHKlPHaTSBRw5f3P/wHGrDNLfe0ZMumgo80YGAqSlVpWR?=
 =?us-ascii?Q?R85sN0m5PPI1IpzPIO9qTqClv/NH9/c9+nzdE0F5OQU67wrhkNBCI7NHvA7O?=
 =?us-ascii?Q?KU104h8Jm2Sy+i0vbTf0+AQM19To/8UauxE56DwVNux43cqpQPCitbMDRA4T?=
 =?us-ascii?Q?UWy3vQ/w1oquz03dAKvgRNIG6zkQL4qBZJFWCzrYGaEdGDd9JOd7v9eKhhxa?=
 =?us-ascii?Q?jko2a6IbnDful6RBNlXvW0sQI4UBY13JgqCMKOEWA1WWSLCuf0AuZo5tb0tU?=
 =?us-ascii?Q?2TZzXNxt9qovirayGo0wIAHFCFdHWd/NGq0AfG+GLytL/xvLHeAz1zzfaQnb?=
 =?us-ascii?Q?b8tw5C+5F/HevCxITFNyKFiKYhKleFqTt1Lj/5uZ/IdFoxtAZGAt+/0cKWFN?=
 =?us-ascii?Q?oOrP32bqcAxsJ2GjJReHtOvy4yLlGus99hkXZD3Nrv/8Pm48X2BKYx2szBDn?=
 =?us-ascii?Q?F5oM3GDXaj4cwX6M+na/dVxGMZH2BkyYikuH1rbfOVTmKuEIxVVMmssnGE++?=
 =?us-ascii?Q?7/OyunQAYQFs0+GxsjwgbsR+F0ityW/6A/euC5JpYR0LrA7Lh0bskS83eSG+?=
 =?us-ascii?Q?dX8iT1EtP2TykGlEQgvERpJ/OfqNzTeOqiEeVH/B0JeBGgbOe7GGdR2r/rbf?=
 =?us-ascii?Q?qsU/nzyoub8d1vaSxdmSSUB4RMkK+kLYldm1G/Ay4jWt6A88AVsyChLzdmJl?=
 =?us-ascii?Q?4LsvmB6hGrjlWdavnL8zvVRCN1Tzt92DKndmO2BYrNcoL7TlFjokZ3L2lips?=
 =?us-ascii?Q?I2KvMQHUSMUMDog3CZqorDeKjtJ6yMu462oea6hWpbnm/p5CjRUGNfRi2iQK?=
 =?us-ascii?Q?3mCRaKOCp+zvyyESdbxFDG/VuK0hr/h5MTa8ye7gQ0D7mFoTwtxqDAljzh5f?=
 =?us-ascii?Q?TvYMCL7wwcB0XFKsMCAxtrO3pv9XBvE5U2jpsfAgn2SuoGdswFk7vf2gkNmG?=
 =?us-ascii?Q?+KzDH5pf/qoVCQnoY3hq33LLytOVsd8W9ANMg/xyJbAa8WAGrxIopFLP950y?=
 =?us-ascii?Q?+SuaiSVHWWHYICUa5XjK5xNXjVPtrP220w4BoikZuADc1d/WB/H1UQI1FLhl?=
 =?us-ascii?Q?a1M7xB/g0QC0FXG3Q0zQcjJuCZGA8M/FatUHI/iNxYRRyXqUKIUSOuDZqXl1?=
 =?us-ascii?Q?bJKT/g=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0a705f-9ddd-485a-dafa-08d9e2652a5f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR07MB8110.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 13:50:38.7209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iiDE6EKRuaWvdVZ1jAI0XULEfDhFvSXu8tQi9Qh8OAeo4ISBGE8k25tBlRJFfdDAD6HPJhptGxSRJOteOR5QjDSSOOq+2ZFjC92ZsYezZQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR07MB4571
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

The priority 130 is one higher than PSCI, to overrule that but still
allow to easily register higher prio handlers, if needed.

Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
---

Changes in v2:
  - Register the handler in EFI code, instead of arm64 setup.c
  - Remove the contdition from the handler - it should be run in all
    cases when it is registered
  - Bump the priority to 130 to make it completly obious this should be
    run before PSCI (which has priority of 129)

 arch/arm64/kernel/process.c        |  7 -------
 drivers/firmware/efi/arm-runtime.c | 21 +++++++++++++++++++++
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
 
diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 3359ae2adf24..b9a2cdbe80b4 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -80,6 +80,24 @@ static bool __init efi_virtmap_init(void)
 	return true;
 }
 
+static int efi_restart(struct notifier_block *nb, unsigned long action,
+		       void *data)
+{
+	/*
+	 * UpdateCapsule() depends on the system being reset via
+	 * ResetSystem().
+	 */
+	efi_reboot(reboot_mode, NULL);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block efi_restart_nb = {
+	.notifier_call = efi_restart,
+	/* We want this to take priority over PSCI which has priority of 129. */
+	.priority = 130,
+};
+
 /*
  * Enable the UEFI Runtime Services if all prerequisites are in place, i.e.,
  * non-early mapping of the UEFI system table and virtual mappings for all
@@ -148,6 +166,9 @@ static int __init arm_enable_runtime_services(void)
 	efi_native_runtime_setup();
 	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
 
+	if (IS_ENABLED(CONFIG_ARM64))
+		register_restart_handler(&efi_restart_nb);
+
 	return 0;
 }
 early_initcall(arm_enable_runtime_services);
-- 
2.34.1

