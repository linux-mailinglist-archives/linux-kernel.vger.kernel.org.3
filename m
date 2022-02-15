Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB69D4B613F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 03:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbiBOC67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 21:58:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiBOC64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 21:58:56 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2050.outbound.protection.outlook.com [40.107.95.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBC9107D95
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 18:58:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiVUe1SmTunO0ek3QiswqdJ4LAqiznNUbp5aG7jShpHLI6YHK213rTAQXolDEycnM96vAjTUeAAEwISHnf/p7CJSm7yWbsBJftv1dhJWXeM4PMeRxrKm+SrDmxZgrOxNNnOfbpK7K95i2MDeTmwHzxRC548BzQ0GoohL0ZAnZZRXeR1+aNP4F0cWwT+BCKOpXH4RyqRUQ3Do/Xjs8wi85u97Jy1S/2KMLqRYFDOGgVLzqvDBf1eGX8pwr7/QJPS3cE27TyQ5Bc2WoQ3+aQEZgBGv325bA1YukW6bKK9HU64nBu5/JEZs0dm0rMkRWOACNiKvoDsPO1rXd4ujiMhLRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=syfyykaplRR6SasaLt0dzJ6s92i4/hVgmHAYRwZDDh0=;
 b=MVadytyua3KZy4nQf5reoqQz+7uedZKjL5s2hE8cC1J5gLh6sizrDAD41ym3usQlaTjFjTAJ6rNz8oZ1x+pz6WICFtOEeOWoY4yZvxUxONEYHBOFfSpQjjR+6ALfGtKQXk5IpGSUC6CvIdihM1BMSSa9Jw/YXuejpqBQf81ybwb4saw024e+g7ZQKPMPtskC7o/RcjY8Ls5s+xXVihXTh7aZK0CizRvcs/blkovwVETAljiVdstFDE0P0AGDete1llVccEvpuikUyFCWZ9Xr+ZjP0O2RRNYXRWPYnrGNhrP4NSIJ7KHbV5eb5CH5QJp8gdfUhN4xlGkYQdJrp99N9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syfyykaplRR6SasaLt0dzJ6s92i4/hVgmHAYRwZDDh0=;
 b=MhemdCQEA7SsFH7gBFSw7OUZolGzGP/gtV1IHPSGCgBWTR1QLxMO2+EN3owPtrTkTVfUd6AsBl5PXO8gDZEaThBGy0225hnc0CbAkaMIm4tFAvCv8ZtbjXOHY4Q20qg7bt8877UeshMXkGIoyVT0u0cEZ0QnOzl+0YUq9RfVulNhFGGk3/iJPG1cbAqJjbi+d8+zeFuFaTFGlxqf9fZnAyQp5NJkHvZAolyd+NY5NGLXn/hCgasydXac2nWKaftebb6H1iVvbXKq31bxuVAATe+sWshs/SqmZWCFfvJpFR+UzzjNTei6SkQ7Pmm805JbII11aR1J4XG030nmR7+5rA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by MW3PR12MB4571.namprd12.prod.outlook.com (2603:10b6:303:5c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 02:58:45 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::1528:82a2:aa0:7aa6]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::1528:82a2:aa0:7aa6%6]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 02:58:45 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     akpm@linux-foundation.org
Cc:     jhubbard@nvidia.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ziy@nvidia.com,
        Alistair Popple <apopple@nvidia.com>
Subject: [PATCH] mm/pages_alloc.c: Don't create ZONE_MOVABLE beyond the end of a node
Date:   Tue, 15 Feb 2022 13:58:31 +1100
Message-Id: <20220215025831.2113067-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::26) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72225861-4fa1-4c09-dda0-08d9f02f14cc
X-MS-TrafficTypeDiagnostic: MW3PR12MB4571:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4571E797E08888BDE986E504DF349@MW3PR12MB4571.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gVxx0Q/mJq0RbwFMKqFiVmfuhZbhkwmmPa1KdSCc7TYWq/FPIAm7gzcKj5dZp5sEwu0He2xsxbb/gKmyB4186wMnjk+9YyB2T02hy1nGxf+bFggW83/LKzu8GZL7A3kyQlNTNsdHaXtwf0qwaeTqyFsF5gSco40ffm2zD0AE+6//TYLYTVAu/VY5TpLkTUYgGu93/0tV9LQKb3+t8cymitzSkxnGMYJs4mfhQWCRURrbxMJrKEYtBYFuvzjDpJuuuWwriSsU9UdeRY9FbuvKnH39Vw+hTkkZ5aQ6CuFMHHchQMJf7/VfISahFojeljCzI44ktA7d31vVZqHNheuvAn0lTVTfpOOf3UC+UiEJp0AVxQjtokl89s1oiUoF8C2wjRTQPADIcNv9xQQNSAteZoaLph9an3InOvpelE/cLofkwyQZZ+opq9VRWjEzvCD+8zpDdinbWxKwqRyPECNTbydHgr7+t8vu+qCeFGffTcjStwJ9l5VwZeFiWP5oWo+tbk/RqE59qPiZx4GKabRBl8OfGpVf1XRGYFftqArpOhh8tkZ7ZHt+5qQ5b5+eQWUwRcbghIK3gvVVWE1TntT2dMJcrV2FEJv/IeTyLmQA7ziPfHOn8Q61JI1ku25TIiESawWuHhyIgO39QhJlpbySJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(8676002)(66556008)(66946007)(36756003)(6916009)(107886003)(66476007)(316002)(2906002)(4326008)(83380400001)(8936002)(5660300002)(86362001)(26005)(186003)(6506007)(6666004)(38100700002)(508600001)(1076003)(6512007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K/k1w8rsjd/UqLaLe7sIffgyxq4e+J7MslS+voPv9mureE+plxNBogyPsU3A?=
 =?us-ascii?Q?DqsBb+JHkphdW9x7FIV6FmJ6XdK7gMIdpU7/pFC2McXY/zEzypHBBv0lKSbN?=
 =?us-ascii?Q?J9uljalVVc87Nur5qvk+iZUUYmtIeqr1vM41sodEk41OdYuoNtbfW9Bcr9wF?=
 =?us-ascii?Q?g8eoYz0k+cOwmu+DY/bvNQdZj9kLfTX9tjbZ79b7NIdjDSLF8RaF7vfJzTvP?=
 =?us-ascii?Q?cD9It9GlHbxsy1ZuQY7KDMFtA8sRBmUdz4wB6OqUme/EI7YIFIsE/39rOkwP?=
 =?us-ascii?Q?VgXxsGZRRtX+dQehnEUkLILeeJSIxD6jhZWNmlJSTHzn9fiub/fU4iECal49?=
 =?us-ascii?Q?uj3K4DxI9ydtXx+r+AQSn6LDtHxxGGrggQenUGPzBJnyYTObf1BAMuqIla0m?=
 =?us-ascii?Q?z2bnx+umxRc17qMkioF3MA6tjDpEdPpPUQbXYPAxaoCgFP6Ag3GmG3tIniMt?=
 =?us-ascii?Q?Dv9piplz2yCHIzILinsnnn6Hf6wODhhAs+cYsLZaUpI08o4/wpJlrCsGXlU0?=
 =?us-ascii?Q?zbPpYlGlsc03MWkQYFtnciwdIRG4b2vH5KpejaVFc3eNpCMRH4229opoBpV4?=
 =?us-ascii?Q?jKEgjgAoDcG4QNuCK3P2X4ZYR5lDyoD+Jj8skk/oRQWuMt/FjfhJYqLKv5AU?=
 =?us-ascii?Q?PFYoBTXy4TxDSHpX7Vn/GWIZHZcHbZVq2xSNzby7XuzU4QXZb10KZlKZ86l5?=
 =?us-ascii?Q?4XDbx5ZnMcJZMayMnK0wnMCs4d97WuMSb4BJBaTzvLLDcZvqZpQFJ58mOmDF?=
 =?us-ascii?Q?heNFVDHS1437LMRiric0Tr1BezQn3JazMU4LXOEKAfA6AP2QDk6OsEdYZdWm?=
 =?us-ascii?Q?QxWCsTVweKqiwqIWp65KrAg8qmuv9v+LgvK1zme2f7t7eYr2ux0R7UhKD41E?=
 =?us-ascii?Q?WTkqW1wENllYW/FBcfKmKgAB5o0DW/y8CV+hH5pZFZyAE+eVTiHITE1wdDdO?=
 =?us-ascii?Q?EufOF/KLWRmLNs1L1gowvQod6y6jsJHEDkjVkZcY8P8vLoJyJodIQ0HpW+Gc?=
 =?us-ascii?Q?WU5ZlMJW7uqlfkf0iptRM8okWsJFFxjjYxONOsInBZr/V/BAppiTAAQlajZc?=
 =?us-ascii?Q?kbhc3EzT8Mov/fbywPBaaGj49D/zD+EmBnyHC7vvilxi2roajgy+hzzdI+Bj?=
 =?us-ascii?Q?WAO7D/8Ogh9KNC6SgmeJ9B0U8hjLx94IABF8lHy4XoRvV4MCjFWmYcQKDAsJ?=
 =?us-ascii?Q?CGHFPlLr5zcs5lfiyd5KswmHzEXXWRjX8CBs/PafLpoTR8pOdGGIkgsXvR3V?=
 =?us-ascii?Q?oMCFhtOl9pUcrxP6WVVIsO5O4MBsO5QB0bvXGC8IWY8r8s/oLnujW5gpdQG7?=
 =?us-ascii?Q?qxKOR6PkdUREvYtZbuaI2xFlX+i32GcAFlfQkjlo3ZiS4YASQVrZW6m/MUu7?=
 =?us-ascii?Q?iicGRcdw71XK+ikzSwZvRtW5ZcCFx6bGjtemTFbh3oT9OzWN6ly4+oICx5+u?=
 =?us-ascii?Q?FI3FpuOe4QJ45jbirYyldm7gFwHe1bL9Gkgsm/I7XNoo9oU3FPsrMXUYGr0B?=
 =?us-ascii?Q?r346YRb+DwgOt8aG1E/4oHlymEaa0qxdlAHo5/MYQWfwH2M0CGa8992kJB+h?=
 =?us-ascii?Q?D5GI2ZtErWCMBob1TxcvKx2UvOIGqXayyl8aHTuybAVZeasFxIApBTl4nB6R?=
 =?us-ascii?Q?E0zBt+GHH824kXPUMeQz2y0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72225861-4fa1-4c09-dda0-08d9f02f14cc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 02:58:45.3985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FmuHtSKbgNBfd4pi9mVj8SnOOqNy7Vt8Ju7w3jEAj4emzfdG8v2MUfNqRTVvj/omyn5aa/a2k9CoT5nIxsR+rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4571
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZONE_MOVABLE uses the remaining memory in each node. It's starting pfn
is also aligned to MAX_ORDER_NR_PAGES. It is possible for the remaining
memory in a node to be less than MAX_ORDER_NR_PAGES, meaning there is
not enough room for ZONE_MOVABLE on that node.

Unfortunately this condition is not checked for. This leads to
zone_movable_pfn[] getting set to a pfn greater than the last pfn in a
node.

calculate_node_totalpages() then sets zone->present_pages to be greater
than zone->spanned_pages which is invalid, as spanned_pages represents
the maximum number of pages in a zone assuming no holes.

Subsequently it is possible free_area_init_core() will observe a zone of
size zero with present pages. In this case it will skip setting up the
zone, including the initialisation of free_lists[].

However populated_zone() checks zone->present_pages to see if a zone has
memory available. This is used by iterators such as
walk_zones_in_node(). pagetypeinfo_showfree() uses this to walk the
free_list of each zone in each node, which are assumed to be initialised
due to the zone not being empty. As free_area_init_core() never
initialised the free_lists[] this results in the following kernel crash
when trying to read /proc/pagetypeinfo:

[   67.534914] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   67.535429] #PF: supervisor read access in kernel mode
[   67.535789] #PF: error_code(0x0000) - not-present page
[   67.536128] PGD 0 P4D 0
[   67.536305] Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC NOPTI
[   67.536696] CPU: 0 PID: 456 Comm: cat Not tainted 5.16.0 #461
[   67.537096] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
[   67.537638] RIP: 0010:pagetypeinfo_show+0x163/0x460
[   67.537992] Code: 9e 82 e8 80 57 0e 00 49 8b 06 b9 01 00 00 00 4c 39 f0 75 16 e9 65 02 00 00 48 83 c1 01 48 81 f9 a0 86 01 00 0f 84 48 02 00 00 <48> 8b 00 4c 39 f0 75 e7 48 c7 c2 80 a2 e2 82 48 c7 c6 79 ef e3 82
[   67.538259] RSP: 0018:ffffc90001c4bd10 EFLAGS: 00010003
[   67.538259] RAX: 0000000000000000 RBX: ffff88801105f638 RCX: 0000000000000001
[   67.538259] RDX: 0000000000000001 RSI: 000000000000068b RDI: ffff8880163dc68b
[   67.538259] RBP: ffffc90001c4bd90 R08: 0000000000000001 R09: ffff8880163dc67e
[   67.538259] R10: 656c6261766f6d6e R11: 6c6261766f6d6e55 R12: ffff88807ffb4a00
[   67.538259] R13: ffff88807ffb49f8 R14: ffff88807ffb4580 R15: ffff88807ffb3000
[   67.538259] FS:  00007f9c83eff5c0(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
[   67.538259] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   67.538259] CR2: 0000000000000000 CR3: 0000000013c8e000 CR4: 0000000000350ef0
[   67.538259] Call Trace:
[   67.538259]  <TASK>
[   67.538259]  seq_read_iter+0x128/0x460
[   67.538259]  ? aa_file_perm+0x1af/0x5f0
[   67.538259]  proc_reg_read_iter+0x51/0x80
[   67.538259]  ? lock_is_held_type+0xea/0x140
[   67.538259]  new_sync_read+0x113/0x1a0
[   67.538259]  vfs_read+0x136/0x1d0
[   67.538259]  ksys_read+0x70/0xf0
[   67.538259]  __x64_sys_read+0x1a/0x20
[   67.538259]  do_syscall_64+0x3b/0xc0
[   67.538259]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   67.538259] RIP: 0033:0x7f9c83e23cce
[   67.538259] Code: c0 e9 b6 fe ff ff 50 48 8d 3d 6e 13 0a 00 e8 c9 e3 01 00 66 0f 1f 84 00 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 28
[   67.538259] RSP: 002b:00007fff116e1a08 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[   67.538259] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f9c83e23cce
[   67.538259] RDX: 0000000000020000 RSI: 00007f9c83a2c000 RDI: 0000000000000003
[   67.538259] RBP: 00007f9c83a2c000 R08: 00007f9c83a2b010 R09: 0000000000000000
[   67.538259] R10: 00007f9c83f2d7d0 R11: 0000000000000246 R12: 0000000000000000
[   67.538259] R13: 0000000000000003 R14: 0000000000020000 R15: 0000000000020000
[   67.538259]  </TASK>

Fix this by checking that the aligned zone_movable_pfn[] does not exceed
the end of the node, and if it does skip creating a movable zone on this
node.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Fixes: 2a1e274acf0b ("Create the ZONE_MOVABLE zone")
---
 mm/page_alloc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3589febc6d31..a1fbf656e7db 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7972,10 +7972,17 @@ static void __init find_zone_movable_pfns_for_nodes(void)
 
 out2:
 	/* Align start of ZONE_MOVABLE on all nids to MAX_ORDER_NR_PAGES */
-	for (nid = 0; nid < MAX_NUMNODES; nid++)
+	for (nid = 0; nid < MAX_NUMNODES; nid++) {
+		unsigned long start_pfn, end_pfn;
+
 		zone_movable_pfn[nid] =
 			roundup(zone_movable_pfn[nid], MAX_ORDER_NR_PAGES);
 
+		get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
+		if (zone_movable_pfn[nid] >= end_pfn)
+			zone_movable_pfn[nid] = 0;
+	}
+
 out:
 	/* restore the node_state */
 	node_states[N_MEMORY] = saved_node_state;
-- 
2.34.1

