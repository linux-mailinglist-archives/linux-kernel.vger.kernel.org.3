Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323514F16C0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376868AbiDDOHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376901AbiDDOHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:07:01 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2045.outbound.protection.outlook.com [40.107.100.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DA82E6A8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:05:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhGDABpGmBnzgeIIlhS0nW5kqq6dMMuvEiBXhhp75jHKe3Q+y8YzbcZh8hu4igOK3eKsD5Xm38soR0LWQaQK8wHxAQbAwVT1aOeTr46txg5Bj6UoR/SNDiroN+pWqZZwZmg0tGtpEnzzwujZxWCgXQSPQ8CRzX6dTncPYgtTEOSOcACFfaxHfdcpOibrR0Q7rZWDcIpPJsqv38F2CxZtQrtnZP9lbMix/vm0Uci983JhRlEvNh26Ivlgn8rH9CraeYySsLRqNIHT9h2YBWVF4JA9+JjW6RpTEAcosCuxmjEaAiVDjzzwrDteSgXsvthGxpXnRXudwxboISQkhXix8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76+E4O68Lm7iA8QdBLlhSNA3dT1vbmCJz+Z3ih+gQfU=;
 b=MBpRkxDLMZoQQ72ncffJ7UW/dWVrKz3aMvWMegBZNd3JBT6F1Jo2g0CNe+9C2FHoMAP7duHX6hbOlwf+meJ6uxuqW2OWqE6FJ2BJkbYnmSsMtl7duaf8o2s6DttFj9n7rUAp5x+XtzvsdSjTxTeECws3q8oIIrTtqiZrdnpxpw8ofNa6FwtCpIuAVEGpG392e1fSgcvRyE2nSZkvE4LCyVmDjSncN5UdKVKbCKIkqdOX5Wmg6qC646nNhiG7QfskqG9CQ3KN0KP4R+ZdC2PtsRku8yamSnMyjxWTR8JTJTl9pH4zTdX4fsEWKILF+u27MtkGVYNQ9hAir3eehSPt8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76+E4O68Lm7iA8QdBLlhSNA3dT1vbmCJz+Z3ih+gQfU=;
 b=AoHjG7tZe9sf/0++EtMDwWzy+OVPceB0Bmz7N+sGxyKVt10/+FcOJFmWsivhRwGGIIggunjQDCFNTvgdWY3lObf8IH7nTdJpTM4IqvstpNpKpO8RxjiNJEgUY3TWZhEd2M/3e5mrOs7s5CexxUdgqlz8U7C0ReEPchhkEn1iFCQ6zVxJjA8RZ4w30h9/SouGWE1OYIX+37YgFtTbSAYVF2ibkLkexERKhGFk8fp36QDIonTsz0DJcsVDuNke22DjsIbzJ5jU4/k2ixAMlIp9VoieDE9d2kjx9mkA5h/w7vgJMxFG0StVbEYjRquaHT8YJFdi0NfoRi3WTw430jaJ1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BL0PR12MB4660.namprd12.prod.outlook.com (2603:10b6:207:34::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:05:02 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c%5]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:05:02 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Subject: Re: v5.18-rc1: migratepages triggers VM_BUG_ON_FOLIO(folio_nr_pages(old) != nr_pages)
Date:   Mon, 04 Apr 2022 10:05:00 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <F3E3F1AE-B421-4463-B032-3F58DF89A5E2@nvidia.com>
In-Reply-To: <20220404132908.GA785673@u2004>
References: <20220404132908.GA785673@u2004>
Content-Type: multipart/signed;
 boundary="=_MailMate_72C46116-BF28-4CCB-B805-AD7645D1D1C5_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:208:fc::15) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9822071-3571-4608-14c9-08da16441ce9
X-MS-TrafficTypeDiagnostic: BL0PR12MB4660:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB4660A72A93CF82489A575391C2E59@BL0PR12MB4660.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Ug+kyZm003jD8GVZucvTv8laR7H+jJYaoOHnH3UQDWN1ZjaR7yqfoEu8HXo2q+wdMX8I97bUZri7uxsn6OrAcpCrwDPQ3c1/yjloHA2wXHMoSsOjbBmNU0/8QwKKDDs7yybEELopXSVThm7O919T8BPlu6GC/1zsVu9efCi+JDlR6XuSIQYItGfUfFjwLB9hxGHj3/7NFU/D2zTdvj9U08+p8aM5BXEX8ca0WHarRRwFRXOWBCzuH4fcfiOlnix7mnE4k0ZgnDtI4ZwPwo+2iSEsf93ZmqS1uvYZOUnyumtpoIj/Eh//ZJV3YatOvGuk1/rQePLfMw0f3O7T9YHOYg7R3AAIZrDNiDollWYptZ1qX7MzB9jzDZOSNOD22QoDkYuOo6Y+KK5vdcoSRuzJaVq9b94gaeOPf7LCpPPoWrk5fx4gJ2iMsfSPesKIukgp1x9j1tKvQO7W3IJllJAzkKA25M6g5OTtK+HwjkSikVd+RPibcEdWZaXv/QV3d/4LFb1/I4pNSCTXZPjwQ4iV5eHXEoK+CB81S072F210pC6JUVN8eG8lEZtgoMqW9pVwdqc9TLsAId+JYqQpZyd9H6N7X+4QkvnzzS4GMwRd8HPXCXFau0hI4KQCAwazlfic9CR3WnkKuXagvgRfTX5lF5jEtyoRfiAs/sGDeUolZU8U87vKUXdZJ5t18YLlQPEzHweieZ4Hi4S3yDGUTqpjnMGdGfYZHwfJvt2pvFqt5M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(66476007)(6506007)(66556008)(38100700002)(6916009)(54906003)(8936002)(2906002)(186003)(66946007)(26005)(36756003)(53546011)(8676002)(6512007)(86362001)(508600001)(21480400003)(235185007)(5660300002)(33656002)(83380400001)(316002)(2616005)(6486002)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lWTHy0y2iU5JExptvr+broBv7p099CvsgR0BfVI8KF17avrWW5HKT4kmnwMt?=
 =?us-ascii?Q?hKy3X1el0leZBz3EWHw/U8Qz/5oT8lEjmcbKFZWwifroI8tS8F0jDyViSgl1?=
 =?us-ascii?Q?7vq2f6isGtYHkvy98BbxuuQDfa2VtIHMSCYXvl8LCSXrXcDS2idQFc5t210/?=
 =?us-ascii?Q?tHYMkqhaIMK7H/6GZpSIVud+FbU/AjrDUXq4XLyW0DiOboqCYwYe/66iJv+1?=
 =?us-ascii?Q?C/RYzAwiuco98NLoO6Lqnufrk6B1CY+o254H1dZPYs+l8V5CG90KEp8GW9Oj?=
 =?us-ascii?Q?oS8sZ50udzM1QEszpKsnlgK6FS1CArhbK/VFeMXxFYoHtX3Kkk/oG6uhceFC?=
 =?us-ascii?Q?u5/1nOXP8pI2VJzRyGhT5cbPzA2VlshkiYjbb8KF4ojjApS8s6gjZEhIrfSO?=
 =?us-ascii?Q?KvOHXLe+eHy5WADQref/LlAf3CkmOEhUzVXm3SWnBTGtgEPbOhWYoxyTcRzC?=
 =?us-ascii?Q?DlmB++e1oRi1tHUvkj2e8MaOd7Rte11YEkkR1vfSvIHbbLqwMPw+4avDbKRR?=
 =?us-ascii?Q?G8HrYZlNUqepcoQIXSgYrsO+a0SdtGHNar8NSTGLH2BLtEUov0mLH73CGmDr?=
 =?us-ascii?Q?pRDgYMaIOPTagV+lXfgqHnDx34uAeFIdI+aMZaUMb02RtknL/q9JmO5X1ryy?=
 =?us-ascii?Q?XfJZd2bMN+EXOelHZAMtpnsu6uEZ6tTGjhaw03Nr4em0KlYk8EgQTbUOkpri?=
 =?us-ascii?Q?lO+gmuhCebGhddU0JTw4J+TM2RIPJRNPfaFUFmypyGra+n6OLbBI8j9u9Zqn?=
 =?us-ascii?Q?uKjSRsjg84pwr3Av1C7OTB2MY1UH5CznSzgP4MW4kT9BFwYH5gd/y4fqhsJC?=
 =?us-ascii?Q?NBWddMgr0378x3mZe19BAlo/gctMTLM0IO+4EIxYYQu7U+j+0ksntvd0rrLs?=
 =?us-ascii?Q?1VOk44mMrYGD018KVE+DY8R0ejIBXZsu17Qh5p4KfmLBDYFeez5wnf7AMpYw?=
 =?us-ascii?Q?KrdnhMqinm//65k7bYNERS9BOdCtxl9GqwgnQmazwv2HGgB8rr79LmSIjWnU?=
 =?us-ascii?Q?ovExOXtqjcw3JUB5EMuc0qiTnx3tbtJcgReWpDSv51fczkON8jGHK+xpDs+q?=
 =?us-ascii?Q?0PRnE+y9dgmX69m91ZMBViXhBUTQO1oAnxM9QnIfQYj4NZuoaQUdUp+I01eT?=
 =?us-ascii?Q?tBzumb6OPvMafw0ywGCE6ZE8MwlRUw6ryjdn7yZ542INE2rR4rfz/PXijSVZ?=
 =?us-ascii?Q?n/e1L6+N/HgnCIa8lc74q6itzCptzs53s6P0erRFwWUQX3F5cZ8gSgf1t0/n?=
 =?us-ascii?Q?WxVsAo/KH7lYPojy/4N0Up5o2mprkuHpH1FYfB3zfmkag/btIDF5QtsDpi51?=
 =?us-ascii?Q?30E4ATuADXSl47xfOh3kXZE8lbb0uIa8uEAEESfB0DIDvcV5roTIFBsFDl2w?=
 =?us-ascii?Q?SnLJ4mP+9TDfaHfKl+T3aFYk9/ojGbyQGvctQLw1eew/jvSBAJC45PMKFZHi?=
 =?us-ascii?Q?iSzqMHvAyMyJRsl2LVaqvJBnIXbS14Ri2XhY1haKmG2vRjSy1vRRPOqsPTC+?=
 =?us-ascii?Q?hafFqMA86OOY+9H+6Svm0d64l1buJDGcMm6UYBCjnPTw35/vzB3l4HJ81Qg2?=
 =?us-ascii?Q?AzXVQav+dGfJuhcTYJ7h/sIkcck2Is/cIk+qNTfn2wAL1EaxX5yxjzT4EYCy?=
 =?us-ascii?Q?9CHUHdPMMSEtNzDVffkhy0iQU0qahzXZNUC1Iyke/CiH1/0vYaAISAaepRiw?=
 =?us-ascii?Q?skAKKpVAO7Ga7Ffx86KWJ2ksO0mXYfPyVADiDjkUPQaBaJDzBp2bcNYYGwbj?=
 =?us-ascii?Q?ZqdBSH4XnQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9822071-3571-4608-14c9-08da16441ce9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 14:05:02.7939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VqgeyNXgWbNalf/7XaBo1ZlH18015IsjUm6iUbviwr5Ngu7GcPkw6keKyttvuzUY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4660
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_72C46116-BF28-4CCB-B805-AD7645D1D1C5_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 4 Apr 2022, at 9:29, Naoya Horiguchi wrote:

> Hi,
>
> I found that the below VM_BUG_ON_FOLIO is triggered on v5.18-rc1
> (and also reproducible with mmotm on 3/31).
> I have no idea about the bug's mechanism, but it seems not to be
> shared in LKML yet, so let me just share. config.gz is attached.
>
> This easily reproduces (for example) by calling migratepages(8)
> command by any of running process (like PID 1).
>
> Could anyone help me solve this?
>
> Thanks,
> Naoya Horiguchi
>
> [   48.206424] page:0000000021452e3a refcount:6 mapcount:0 mapping:0000=
00003aaf5253 index:0x0 pfn:0x14e600
> [   48.213316] head:0000000021452e3a order:9 compound_mapcount:0 compou=
nd_pincount:0
> [   48.218830] aops:xfs_address_space_operations [xfs] ino:dee dentry n=
ame:"libc.so.6"
> [   48.225098] flags: 0x57ffffc0012027(locked|referenced|uptodate|activ=
e|private|head|node=3D1|zone=3D2|lastcpupid=3D0x1fffff)
> [   48.232792] raw: 0057ffffc0012027 0000000000000000 dead000000000122 =
ffff8a0dc9a376b8
> [   48.238464] raw: 0000000000000000 ffff8a0dc6b23d20 00000006ffffffff =
0000000000000000
> [   48.244109] page dumped because: VM_BUG_ON_FOLIO(folio_nr_pages(old)=
 !=3D nr_pages)
> [   48.249196] ------------[ cut here ]------------
> [   48.251240] kernel BUG at mm/memcontrol.c:6857!
> [   48.253896] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> [   48.255377] CPU: 5 PID: 844 Comm: migratepages Tainted: G           =
 E     5.18.0-rc1-v5.18-rc1-220404-1637-000-rc1+ #39
> [   48.258251] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS 1.15.0-1.fc35 04/01/2014
> [   48.260535] RIP: 0010:mem_cgroup_migrate+0x217/0x320
> [   48.261914] Code: 48 89 ef e8 5b 2c f7 ff 0f 0b 48 c7 c6 e8 64 5b b9=
 48 89 ef e8 4a 2c f7 ff 0f 0b 48 c7 c6 28 65 5b b9 48 89 ef e8 39 2c f7 =
ff <0f> 0b e8 12 79 e0 ff 49 8b 45 10 a8 03 0f 85 d2 00 00 00 65 48 ff
> [   48.268541] RSP: 0018:ffffa19b41b77a20 EFLAGS: 00010286
> [   48.270245] RAX: 0000000000000045 RBX: 0000000000000200 RCX: 0000000=
000000000
> [   48.272494] RDX: 0000000000000001 RSI: ffffffffb9599561 RDI: 0000000=
0ffffffff
> [   48.274726] RBP: ffffe30f85398000 R08: 0000000000000000 R09: 0000000=
0ffffdfff
> [   48.276969] R10: ffffa19b41b77810 R11: ffffffffb9940d08 R12: 0000000=
000000000
> [   48.279136] R13: ffffe30f85398000 R14: ffff8a0dc6b23d20 R15: 0000000=
000000200
> [   48.281151] FS:  00007fadd1182740(0000) GS:ffff8a0efbc80000(0000) kn=
lGS:0000000000000000
> [   48.283422] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   48.285059] CR2: 00007fadd118b090 CR3: 0000000144432005 CR4: 0000000=
000170ee0
> [   48.286942] Call Trace:
> [   48.287665]  <TASK>
> [   48.288255]  iomap_migrate_page+0x64/0x190
> [   48.289366]  move_to_new_page+0xa3/0x470
> [   48.290448]  ? page_not_mapped+0xa/0x20
> [   48.291491]  ? rmap_walk_file+0xe1/0x1f0
> [   48.292503]  ? try_to_migrate+0x8e/0xd0
> [   48.293524]  migrate_pages+0x166e/0x1870
> [   48.294607]  ? migrate_page+0xe0/0xe0
> [   48.295761]  ? walk_page_range+0x9a/0x110
> [   48.296885]  migrate_to_node+0xea/0x120
> [   48.297873]  do_migrate_pages+0x23c/0x2a0
> [   48.298925]  kernel_migrate_pages+0x3f5/0x470
> [   48.300149]  __x64_sys_migrate_pages+0x19/0x20
> [   48.301371]  do_syscall_64+0x3b/0x90
> [   48.302340]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   48.303789] RIP: 0033:0x7fadd0f0af3d
> [   48.304957] Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa=
 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f =
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d bb ee 0e 00 f7 d8 64 89 01 48
> [   48.310983] RSP: 002b:00007fff5997e178 EFLAGS: 00000246 ORIG_RAX: 00=
00000000000100
> [   48.313444] RAX: ffffffffffffffda RBX: 0000556a722bf120 RCX: 00007fa=
dd0f0af3d
> [   48.315763] RDX: 0000556a722bf140 RSI: 0000000000000401 RDI: 0000000=
00000034a
> [   48.318070] RBP: 000000000000034a R08: 0000000000000000 R09: 0000000=
000000003
> [   48.320370] R10: 0000556a722bf1f0 R11: 0000000000000246 R12: 0000556=
a722bf1d0
> [   48.322679] R13: 000000000000034a R14: 00007fadd11cec00 R15: 0000556=
a71a59d50
> [   48.324998]  </TASK>

Is it because migration code assumes all THPs have order=3DHPAGE_PMD_ORDE=
R?
Would the patch below fix the issue?

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index a2516d31db6c..358b7c11426d 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1209,7 +1209,7 @@ static struct page *new_page(struct page *page, uns=
igned long start)
                struct page *thp;

                thp =3D alloc_hugepage_vma(GFP_TRANSHUGE, vma, address,
-                                        HPAGE_PMD_ORDER);
+                                        thp_order(page));
                if (!thp)
                        return NULL;
                prep_transhuge_page(thp);
diff --git a/mm/migrate.c b/mm/migrate.c
index de175e2fdba5..79e4b36f709a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1547,7 +1547,7 @@ struct page *alloc_migration_target(struct page *pa=
ge, unsigned long private)
                 */
                gfp_mask &=3D ~__GFP_RECLAIM;
                gfp_mask |=3D GFP_TRANSHUGE;
-               order =3D HPAGE_PMD_ORDER;
+               order =3D thp_order(page);
        }
        zidx =3D zone_idx(page_zone(page));
        if (is_highmem_idx(zidx) || zidx =3D=3D ZONE_MOVABLE)


--
Best Regards,
Yan, Zi

--=_MailMate_72C46116-BF28-4CCB-B805-AD7645D1D1C5_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmJK+w0PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU05kQAIbY/0qQiTX93pp4ik43AwomG/1kTneihPLN
o1pH9i2RjAWOUnj4FXxemQ7YSI1eSwwArxfEb4JCYX/7v0uc/pc64uCU/i8/kIZ0
qQ5Bldx8ssOFsWOzqPxUYeuMAf29rxmaHKP3v7ot8AJSU85CsARVV3m2Y5hXlnEY
jR2PnM2p2g9FXodox1feVlNA9iae4W8HZIK7NYIr+nvT1utj3MCblPKbhjv1yacz
KW/HTJu/wmCFsn2s1l5Wlvqm2kaGm75LsDL5fjgbpn2iB6BDpQueJLbPS0PJJopq
uA/spZUdIIiiBNDzgIs1/ZtB7uiIH1DnDWbZta73n1cRno5RzGWsMWPD/Ds1b9JD
YbELj8f1Sl3z033cYxHUM5kZILe/gQ0fkxHof7s1tBPC39M+EU3XVar3hehkokmS
4kdpEnd1l61mEspWVmmkRf2F4RalKDqZ/Z1uphrKWF1q/YoXuf5XG41+sRGWRpoh
EjFayBL7CZoMMcjl0zng29kDxgxDbDUgJqMSpUfZ7n7Wc5mRnJzKRLg8mzgIhsot
YYcAHtLrJwDDAsKR602vhNqRyhvFxX3033wIUaEKOpg12smVPYieqBBNUh2P53mZ
7wL4ZAfua4SojZXEOQEJWC2h37HHDU/85AjhqryJ834KD3YGFY353MPEXz9yu+e/
gFgI8hqu
=653O
-----END PGP SIGNATURE-----

--=_MailMate_72C46116-BF28-4CCB-B805-AD7645D1D1C5_=--
