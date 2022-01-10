Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C72B489E54
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 18:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238258AbiAJR2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 12:28:01 -0500
Received: from mail-eopbgr130053.outbound.protection.outlook.com ([40.107.13.53]:36958
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238230AbiAJR2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 12:28:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUu0xcG33CDPncBaYqS/ZraIR8+GhN1Gal8+Rl/UCipgTbTmgzAaXEmamVYJ1YyQ0Q30OFcCfKLOAR2KCJlBbm3dgzHTgHC/G4v+xGixW4iedm8zeFQdE0dCKFcqsbmbyLnL7fsfzsUb03AwSxLMQvOJsQsEK/PBLXDaposO4HmORpG5y4ztTp86lAeOo/Q3RB+MI4DuaOYdfaZpmVMo+yNSszmJiI23Kt83Xq7HZXeeKhxdDXmvQe+EfqI0MYMCt4xvUp+GQejuqf6PqaDsZmfJgbKjIgmizwSWbqtF8V2VQOkGvE9TY3UoA+mP8Ag3jqNvbEeQqOt3FC6RGHF2gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ourRemlVg5+zGuCHMvhZJiUWAeO+AlKD7yMY6z1v0S4=;
 b=e+b8DGPCKZbtXKoJczVKquTn0Mso9a78Bt67aweFQJTzINXhsP6YEom6KQjTO7iTc7nuFGX1mrQokbO9Z+YjDsWcv0md5m8IzoQp5rpulTjKYf2XTi7Vns6CPiaywVdRYq0v0AT9PTC1d4Q2vPbAyFlm4fioewr+3ZSAznXIFPfCpwvBhT8mfqzyh0BNPOVKmv5HXv377foSpDOVLXaNYIuhwHByGe/8X2Ag0NF8dechyA5av4A71MDHZvUNq3lvFVCMfO4dvP8m84nf47sX4bL3ToKMWv6cf3qoDRFzjXWKmhh1w7iYq4vJOwfO1MHWX+LYgdZymMdj2N+vR2rWQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ourRemlVg5+zGuCHMvhZJiUWAeO+AlKD7yMY6z1v0S4=;
 b=XhWLiMPrYAfpSuXO2AW9QvOlsE7JuXlGcEpfLS71q/qKWOullr3iQPB+AdGHD4VYJL9aejlkqbxtitoT6X657LjAliiAeV09PaTljwlcSQxIVmLsubH2FrnUcTJV6VpcUdiayJLHSsqcVBu1ygw9f5sKdKaOFW4UXRFJmJ491CU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com (2603:10a6:102:232::18)
 by PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 17:27:58 +0000
Received: from PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::21ff:7873:e75:7c51]) by PAXPR04MB9186.eurprd04.prod.outlook.com
 ([fe80::21ff:7873:e75:7c51%8]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 17:27:58 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        peter.chen@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, lznuaa@gmail.com
Subject: [PATCH 1/1] usb: xhci-plat: fix crash when suspend if remote wake enable
Date:   Mon, 10 Jan 2022 11:27:38 -0600
Message-Id: <20220110172738.31686-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.24.0.rc1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0217.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::12) To PAXPR04MB9186.eurprd04.prod.outlook.com
 (2603:10a6:102:232::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18c917dd-89bb-43b4-ae87-08d9d45e8aff
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_
X-Microsoft-Antispam-PRVS: <PAXPR04MB9328C4479A28D0B091074FC988509@PAXPR04MB9328.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:473;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7taq592X8M1jZyA04R/3y9HakScUf57sYI90HKPG4RRecDbVVDSoixWxj+WQtQlcPhGaWp0+MIfbz5KthPghyfCRmZ5FVKisLi6daqhFexdFzGT7legQZAuEVL/MkoOsIoUrVGKnBP7TqG6zRdx3C3lGCqUzGZouc3STmk3nZukVh/YGo4JiWnXj4FK11p6gKUPql5LVwUBFE9htZr8HmfklwDYuc2Hz4LbH94PWQYzX+Pv9GPeZj2vhFdELGIo7EHdJnEvFJqy5RkNcxBmB2lVBrkIYtB1gsFtLbfX1Q13kicC3p6K3ej98nQmcxY3jOx/PZNLiKkoJ/+TF7f9sJskgJH9b7GI5coOtR8ZwUEzJIT/Cx9EDt3HZuTgZaaiZ1LFjFXFdHfSIrZzcmLvl8QBRdfMR1zeOAzy2mrwpq6HmTov/TFjtA6LwY25KgcuwteGvcDIMBmzfsDvms6hEYJb/m3t7KNr90KuZE6KyaLYb+2ACYeYfD54itHkUvsiM+g/HAzlJEtYnrcMbtV+aQoiNZow7QiXQUbH3012kyniU/HfDvT2XjIMd4rcmcjJnfy7ZPFkGAxQZi2a+kyQLoNB8j8erA2NlqkoxmmgvD1MrjfFVyTIyF8j5mq5/5FOutbge8ecPNoWoUEZZuDwhlWQf7MDV8NyLdnHGORgVrz4Jxm7bwXV3tVlbV9Qu/Rs7qQ1M/Nz9gXl3jRfQlNcb9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9186.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38350700002)(66946007)(6486002)(66556008)(66476007)(45080400002)(508600001)(26005)(6666004)(15650500001)(6506007)(8936002)(8676002)(5660300002)(2906002)(316002)(6512007)(1076003)(2616005)(38100700002)(52116002)(86362001)(83380400001)(36756003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b/nc3V5NamyTP4Bbkf4ebnxyBR367OFKK5vwnX/uu73omkDNT/qJ4pxmMAs2?=
 =?us-ascii?Q?5389BfYU3JmX57RxYXkn1NLRfbd4tCzNIZQqQGahoZu9C8u8AoexJJrOoH1M?=
 =?us-ascii?Q?YZUOPrWjFT3gV04R+j38V2RPVGo6x5AObmyT6f0LXQivZwl3DD4pQ1eg74pc?=
 =?us-ascii?Q?xzm+tXj0KVYEP8yNf9s4y8q7/BWgKMvKIj8O5GIysdQfrHLzmgt3DITpgrDi?=
 =?us-ascii?Q?0mtw4QKnNtF3F+b8yzmDRsYFrWHkZq5/eettKeiUd70J4YKjVMMUpfoXptEa?=
 =?us-ascii?Q?Gtguh/fw8S8yfncgxn8fhNBbhOOTWKb6afeq+N85jikBxh2gjns70AYHmJ0c?=
 =?us-ascii?Q?DCQCanlbOtm5GxYGUikJcHPXvUOVEGfXEVSsbuu+Lokce6IkerZEdFQ30WC3?=
 =?us-ascii?Q?8pR2lIkgrD/hBvV98CwaG9dO/wAW9Gaqq2fXsfB6D/4mS+SyVmbpQ3rm1fXu?=
 =?us-ascii?Q?EGWzoFnWv57BrRDtJWxo5ZF85VSAXTcdnBuBvtP8MnUICHzMJfnNheBUrSbg?=
 =?us-ascii?Q?iQlfsLWQoYXe+r742tXrAs4NufysD/NHRKMhw0x/LeNiV5wUiKnMw3Un3lsI?=
 =?us-ascii?Q?HwihsNQ2Y52hbt8hzo5YD6zsjRBvM0QdQFebEnKruPvQ8z0dv8NetlJWgZ/5?=
 =?us-ascii?Q?yRUk3cwFEflJiTOBIHto9OTxCu6/2NYKJQWDwWsGzHMYFxX4PFQc9VZlfAzS?=
 =?us-ascii?Q?Oeaeq1mLS/i5IDla6TbcdeseBt2EhlSgqZiKT1a0gXdAfUpDmCUOgRyNBvL4?=
 =?us-ascii?Q?XHG61o6IcBifib0CsP/DILJ5IZ1nq/sjz+W4kszo74YpL0sErOaLht0oO+z+?=
 =?us-ascii?Q?FgWE9giMKjDDu2uLqWPx6Qts21SNgYhRK1fOP79uqIVXmqoRE5wFFduLvFLm?=
 =?us-ascii?Q?y5m4IjNLgHQMe59dj/ox2SwK2UYBFUxlNBfC982+KFH30T9kTWWGiO8U2TDe?=
 =?us-ascii?Q?Fz+iJEfHy426tRlAVNcmBSqtYhG2C2gSUdwCEC0AaGQRLxLU8f0fIObBVDMS?=
 =?us-ascii?Q?8GhwIMsy4sTQhwY987he6e+MluJ4dtk7LoHjledwAjVU7Xhco+jVtwxc30Ld?=
 =?us-ascii?Q?TCNKAp1cdwOj59AIwum0GxTdWealtA/Cc4/nEe5f4XqnTvDzTpTcy3k4Gbip?=
 =?us-ascii?Q?P48pWI0tB2sVSMz/OSKR7Teg9oGp8BX1ngJkaVWI+NE61kpBKrGDSKB2o5vm?=
 =?us-ascii?Q?SOUJOSMd8ILnFgoZRNoee+xlAclrB7OZBJbnNrygsCW3/XqVSRNE39MnqTJA?=
 =?us-ascii?Q?Q3lLKQvaAdGd+4YmO5qfbphH/cYijsH8EK68Sh1ZW3As01O2LPnH7zMEn692?=
 =?us-ascii?Q?3HqMBw1y3wlyOUwDy7FvZMmz+/KkDD0oHpT7nrTdu5XzIQszh5B41ocR2v1x?=
 =?us-ascii?Q?2qXHOSXDiiopi9sWw1XZtsTOKILv4+hbWGdIqNzHVKLn0EElJ+9C+ajIQ5vI?=
 =?us-ascii?Q?JfwEeZUc8WkchhJQHT2k2k5dq6GV7IHY29Kv8VL4mVkCDyXc8P11MYWQprIB?=
 =?us-ascii?Q?wbql50aiMxVqblRrL2kHPZupE7UTTVFa3sG+NKc9m/SlkVf6V/rAWMy97+SP?=
 =?us-ascii?Q?mshzUG9Grh5dgXpAU+ElElgAnU+spVTN8BaMpfWxQ60MoK6z51t1qiISWJ/A?=
 =?us-ascii?Q?Q/ujq3lRjl81PhznfX+lQ4s=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c917dd-89bb-43b4-ae87-08d9d45e8aff
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9186.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 17:27:57.9442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qro07vf3eLFZo6aFo1huPLxZQuNT8gOBF2z9+ELyZ0oerqqYFCaobE+7YYIjKsA80gJnmtJiLfkCbjuw+Xq+cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9328
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Crashed at i.mx8qm platform when suspend if enable remote wakeup

Internal error: synchronous external abort: 96000210 [#1] PREEMPT SMP
Modules linked in:
CPU: 2 PID: 244 Comm: kworker/u12:6 Not tainted 5.15.5-dirty #12
Hardware name: Freescale i.MX8QM MEK (DT)
Workqueue: events_unbound async_run_entry_fn
pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : xhci_disable_hub_port_wake.isra.62+0x60/0xf8
lr : xhci_disable_hub_port_wake.isra.62+0x34/0xf8
sp : ffff80001394bbf0
x29: ffff80001394bbf0 x28: 0000000000000000 x27: ffff00081193b578
x26: ffff00081193b570 x25: 0000000000000000 x24: 0000000000000000
x23: ffff00081193a29c x22: 0000000000020001 x21: 0000000000000001
x20: 0000000000000000 x19: ffff800014e90490 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000002 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000960 x9 : ffff80001394baa0
x8 : ffff0008145d1780 x7 : ffff0008f95b8e80 x6 : 000000001853b453
x5 : 0000000000000496 x4 : 0000000000000000 x3 : ffff00081193a29c
x2 : 0000000000000001 x1 : 0000000000000000 x0 : ffff000814591620
Call trace:
 xhci_disable_hub_port_wake.isra.62+0x60/0xf8
 xhci_suspend+0x58/0x510
 xhci_plat_suspend+0x50/0x78
 platform_pm_suspend+0x2c/0x78
 dpm_run_callback.isra.25+0x50/0xe8
 __device_suspend+0x108/0x3c0

The basic flow:
	1. run time suspend call xhci_suspend, xhci parent devices gate the clock.
        2. echo mem >/sys/power/state, system _device_suspend call xhci_suspend
        3. xhci_suspend call xhci_disable_hub_port_wake, which access register,
	   but clock already gated by run time suspend.

This problem was hidden by power domain driver, which call run time resume before it.

But the below commit remove it and make this issue happen.
	commit c1df456d0f06e ("PM: domains: Don't runtime resume devices at genpd_prepare()")

This patch call run time resume before suspend to make sure clock is on
before access register.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/usb/host/xhci-plat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index c6b791a83ad18..7d2f665271310 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -442,6 +442,9 @@ static int __maybe_unused xhci_plat_suspend(struct device *dev)
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
 	int ret;
 
+	if (pm_runtime_suspended(dev))
+		pm_runtime_resume(dev);
+
 	ret = xhci_priv_suspend_quirk(hcd);
 	if (ret)
 		return ret;
-- 
2.24.0.rc1

