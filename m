Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2260E477D55
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 21:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbhLPUU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 15:20:28 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:36148 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241315AbhLPUUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 15:20:05 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BGIn54P025850;
        Thu, 16 Dec 2021 20:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=q0GBE8rbSHLO6USczfw1PFrUGrmQ8mGv7BbNVlM11+A=;
 b=hFWktOkJs8R9lSYEdFHDgIOvVxyAh+J5Zz3WFS0lPjEQxv231eFuGu2JFiCTJmpYH0Wx
 bTkBFxJH+OD/OtvPU1DiRiptisExmbxpjDNo3BzNa+1xDdr+YRB7sxQWYqLiK7wadG3u
 gDW/IOO0LU4+h41jabx2KUMXZKt6jNeTkbQXBEFrXBrzAh8oUtYpeWf+gvoVSXixHaG0
 D0LubNXzDYWdieSCwhVZOMW2Hsnu3Vl3EUJqJDa1IO/tTMzxxuu4svVWmyJ70bJaOMkN
 SVAreXgojD9fPfIDZhg1pSupS7J6wVZPCrgeqG0s0mFpMZU50suONCVbbwjwZvbttZlG fA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cyknp3y7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 20:19:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BGKGCTc123775;
        Thu, 16 Dec 2021 20:19:58 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by aserp3030.oracle.com with ESMTP id 3cyjuae0cy-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 20:19:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQQ6cIdhYZMN05a8zusCZ52T6i3FXdtBq6+/B7Eaf3uRM5dyu4HiyBrEZ/Ui59Odc6LLdK54wQrBRaz4B2IrZJN3txt01cGtIdB9it3uFWJk9mMVxULqxrMmIPSr1Gn6kuZ912vpkhKU+pZ07X3dcHxkZ6hytWPZmA6VhVXjuewydsoK8HzQGw5FgE1n1N9a11xJd9Ei6cE2c6byBVvVXCnkhSf6ZEmVUv6acvIo2X7HFZFjChjMU1s6xjzkgvLU+V433I7hcMa3DXTWlSs3SP03xhfZhHOg3YA2FvJLPAj/Qsk8CETGwkHuM/oSQWshQULvRV+65pPDMN7SsyzdEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0GBE8rbSHLO6USczfw1PFrUGrmQ8mGv7BbNVlM11+A=;
 b=WZkY8tjf63JAmXNTCY6Umgbj6Bqkq3c/4s3rgFzH1uMEi9FqdvOM+7hmOusZ4WhgqdlDlz5Vz/bm+OKrBgEzATfc/cSpOfxECgqYwBRotI92NWUMf58kb7IhubbEAiP14/ccwzOVARsbzsVDCiqGZwSLdJ7pX76dhdZWgYnqutX+NJp/3qdD+OPvndLlDin38tF6Il//a6o8G/5giLYu/e1vFlxBh9L/hlYpiUI7oRdE6vphRvkzklnb8s7qXea0e9DVT9GKulyDPUkGVeEJXgGVeerZdmTJaaFOHg4c1rovWHpL0B5cAhJoSWZTPM7tTN8KgwOZf43mZRn3RVeF9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0GBE8rbSHLO6USczfw1PFrUGrmQ8mGv7BbNVlM11+A=;
 b=IDnxlQ6WhSMv7v3Qagvbj72ToSnLf4WetT0W8fdQ5Fm+mRhDPD7oWrEsXFJk7LfyILRuuBBeHGkXomGUvEnmuulCVPvW9cRICo1HRELUEnmnyYNvjXRFXm24Kg0rM65ldjuwPV5/iIoVI7kZSNO96rOarqCjmM+4z/ALkmUGLNA=
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SN6PR10MB2541.namprd10.prod.outlook.com (2603:10b6:805:44::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Thu, 16 Dec
 2021 20:19:56 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::c873:a8b4:278e:939e]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::c873:a8b4:278e:939e%7]) with mapi id 15.20.4801.015; Thu, 16 Dec 2021
 20:19:56 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v7 6/7] kallsyms: add /proc/kallmodsyms
Date:   Thu, 16 Dec 2021 20:19:18 +0000
Message-Id: <20211216201919.234994-7-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.34.0.258.gc900572c39
In-Reply-To: <20211216201919.234994-1-nick.alcock@oracle.com>
References: <20211216201919.234994-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0095.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::10) To SA2PR10MB4715.namprd10.prod.outlook.com
 (2603:10b6:806:fb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f14610a-cfb6-44d0-4636-08d9c0d16d5b
X-MS-TrafficTypeDiagnostic: SN6PR10MB2541:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2541179EDD56A04EED3ADDC48B779@SN6PR10MB2541.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J9FIsUhcXgWGNXN5UVyt6NUqpoTUP1rHh3JEG9ckabIt3WN9daPz4wgLfd1sxoGhmXtqT1+weN3ljWdHp54qaO6wAwVmt0G5cnDlonP9RbJSzt4OooeCJBCQanGOtwYOrp967qSd0zjsZLn88AIhZlW9EsdnvPFX4Q+JJFUvRK1hHAxT0LOTEH9VxyAhJZy365kvYs/VGLUPEE3y252t6gdDGfr8Hznp+4hugyq+SUbwBm6DXDfauKE5+QnqpD9Q21wSJbAyaxwqQwh4bijcyTIbb5R8ha7QL4WrXnfXnOi0H7LD9Rykpwjqj7kmaYL/Xs3okEC3cLumKSj0wSTAnXWTjsGxknJPKoEQmLhfRYDXjMsv+3kJ37XzpMVrIG/c0q9zhfoQZq3IGWf2bGCrrtYOcpjoGKQe5azTmHYRqhW2mD4pHVCYSOI/DgABzbCPlITJir/B8iwzpf8fzeSa/atNOm3ZIGZrNdzv5oJGRB2JoEJNyJjjFABaimBnsffKqK5NUQT7u+DKFmyuTRn2Uea8a5Db6BSdsxhzTR+aG5pjjDIL1I+yRxXETtseVAG7nn9dZZ4Bp1Kik+LG1f0S6dpOuK4wSkY2Nw4PW8BDvxlBpLjYwIPx8bvtRCdnQ5TXWVslnHCaWo6gvLtqh7Pj3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(30864003)(83380400001)(52116002)(38100700002)(86362001)(44832011)(36756003)(5660300002)(1076003)(2616005)(6506007)(508600001)(6666004)(66946007)(66556008)(66476007)(186003)(8676002)(316002)(107886003)(6486002)(2906002)(8936002)(4326008)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EDrVF/dHt2lwAynQAs0K/Dshy7yo3gjvXP7lrnvPBtJCR0V4T85lr6ojbtZ/?=
 =?us-ascii?Q?dwAEi2ysyyLn41e8UlxoHI9a1eejtFcxRV7FaLff8Wh9c0K8YiqyabNa8sk6?=
 =?us-ascii?Q?E7V0gA9TrCY9C2Lb2uYjI5L+PgGCrFgke6+WKiYHnt9v0QUFMXvabaCGb2Kn?=
 =?us-ascii?Q?j/8AA/+hTrYogeRaK/IO2rt8PGYy4PBzxaUgT2SIPQlAb7PJOA7OSS//22FB?=
 =?us-ascii?Q?fFSokDaUeScuDJvZly1YAwcAFJKfjeKbE+/blLEVIfFByAf9o0WobCPLDnV8?=
 =?us-ascii?Q?eHhe0lx7mKjy0iRVp/tGIHr7DsnTbiTm+0PtIKhNWVcKe10nDVwNuAqej81A?=
 =?us-ascii?Q?qlzz8bjYUIZIyjYCgkRXXWyE5FmAiisVp+mk7SsPEZ1DQn3vXFSXZYO2BYxi?=
 =?us-ascii?Q?shOTDhfIebKwf8ri99UNdvQOKd/N9JTHKXNTmYBfIipdE9ZgHlblpXhfSHLf?=
 =?us-ascii?Q?HtfIgy8XmlpoLpV/nMfCq4E7LdZM/Pa2wZW1eeyKcGI6Bho0sAOD9vwPqYC/?=
 =?us-ascii?Q?MR6KljHx+8BrjCkPxWUy2V6OAEirTfB1eBtLxv5K4oTyy/hMirr8r3j4Yx8H?=
 =?us-ascii?Q?BTS5usj5Orm7tehyZ9Lq68vrDe5NvXIG9vY7rgFUSOEQRr9TrGjxU5kQ8bu6?=
 =?us-ascii?Q?AeohG2Oldx2KGaFK5nW15FJSRZcVTbBgDNEzOCfT0GQ2AzG5sEwYUtnA3ZHw?=
 =?us-ascii?Q?FIvMMPMOdvfFVK32Qv10XyAhC0DLyp3S4XZz71xywE4E8vHXVdcEwKSPphS+?=
 =?us-ascii?Q?8mMRY25Ql2nzRqS7qj0mypZKbyvou2SkqeE1R4TrlRzEefZ8irs201h+gPwT?=
 =?us-ascii?Q?ZtdKyyv7NXbDOjEJvDuGrRTHZsU9h172fHwtHK+qLY+kmfqYpa+oafretMxT?=
 =?us-ascii?Q?2WTBZrTl9XVtQeOnl5SoI3x/RCNIjoCwc5duRSUFF+SnUyRnWqAegh9/rhyr?=
 =?us-ascii?Q?peERZQ+wiNFLHHRp0108zTgSeO6PkRD01WSU3SuMU54Bh1uZ3OUwhPrb04bJ?=
 =?us-ascii?Q?JRuBnQRziSOid8wkbhcVUakrrg+GrEmKK866TjDDBF97BHnWagp/LI0PTvu2?=
 =?us-ascii?Q?lyaYNQRRJBH4aW8iussMNbOWYo/5f8jMrYQdwyiw22BvHEbVo/1juFwJKZ5y?=
 =?us-ascii?Q?qEuSX8pBDU2ka/9Lt/goQ1sxl3A7KbMWDyG8v3yp/s3pwWZc44rUn88LRcyo?=
 =?us-ascii?Q?CjimZ6iMZzwT8YB6Dui6XPEqK3ELZBJvYRV5noQZS2rb4EWelesz/foQmRjJ?=
 =?us-ascii?Q?M2p7GuwYs3rNCxlCiS3xEyobfqG9FyU1GjlUpzYQEhXaz2RKWHdPWFkYknmR?=
 =?us-ascii?Q?aljU/bXecdVAS5LifO9vcP2+2EGIx5Lk8BHf9ZZhxGhjlmNpwrpBbXmyEbI8?=
 =?us-ascii?Q?HvMijrVoAigmkWxYfP3o1hA68r/5OL+qDoGTTysIlfZcOCYEtAxYTxdTgeHg?=
 =?us-ascii?Q?pAO52j+C8supOnHfDekErs49+9jtoBpZLWySc80UWrae6/l0Fudzka9RCWlF?=
 =?us-ascii?Q?8Iz5XgvroftzIUXI4hz2W3pbi2CIinme84tgVRhpKJVPuBp5siyyo2P+AeiD?=
 =?us-ascii?Q?NynB/2WcB94At3gqjq0Vy4Xlt/qc1B8kPIlJimk1Sq9LBHlpmDxEHGYmjttL?=
 =?us-ascii?Q?Asq+oNTp+3LxPDSiQcVZKyB64KUzRbjUGPAMASbU3P4K?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f14610a-cfb6-44d0-4636-08d9c0d16d5b
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 20:19:56.7219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJomzvGvRzKrZ37poC0Q5l/PDHWku0rBNW2zkTRX3S+Y3HciZpkay8tVnqMTu2izHIBWp3i3vQX6kr2Rflhnqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2541
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10200 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160110
X-Proofpoint-ORIG-GUID: yNDcpvEZ5VgBVjb54KsuTiJ5fqXJfuf_
X-Proofpoint-GUID: yNDcpvEZ5VgBVjb54KsuTiJ5fqXJfuf_
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the tables added in the previous commits to introduce a new
/proc/kallmodsyms, in which [module names] are also given for things
that *could* have been modular had they not been built in to the kernel.
So symbols that are part of, say, ext4 are reported as [ext4] even if
ext4 happens to be buiilt in to the kernel in this configuration.

Symbols that are part of multiple modules at the same time are shown
with [multiple] [module names]: consumers will have to be ready to
handle such lines.  Also, kernel symbols for built-in modules will be
sorted by size, as usual for the core kernel, so will probably appear
interspersed with other symbols that are part of different modules and
non-modular always-built-in symbols, which, as usual, have no
square-bracketed module denotation.  This differs from /proc/kallsyms,
where all symbols associated with a module will always appear in a group
(and randomly ordered).

The result looks like this:

ffffffff8b013d20 t pt_buffer_setup_aux
ffffffff8b014130 T intel_pt_interrupt
ffffffff8b014250 T cpu_emergency_stop_pt
ffffffff8b014280 t rapl_pmu_event_init      [intel_rapl_perf]
ffffffff8b0143c0 t rapl_event_update [intel_rapl_perf]
ffffffff8b014480 t rapl_pmu_event_read       [intel_rapl_perf]
ffffffff8b014490 t rapl_cpu_offline  [intel_rapl_perf]
ffffffff8b014540 t __rapl_event_show [intel_rapl_perf]
ffffffff8b014570 t rapl_pmu_event_stop       [intel_rapl_perf]

This is emitted even if intel_rapl_perf is built into the kernel (but,
obviously, not if it's not in the .config at all, or is in a module that
is not loaded).

Further down, we see what happens when object files are reused by
multiple modules, all of which are built in to the kernel:

ffffffffa22b3aa0 t handle_timestamp  [liquidio]
ffffffffa22b3b50 t free_netbuf       [liquidio]
ffffffffa22b3ba0 t liquidio_ptp_settime      [liquidio]
ffffffffa22b3c30 t liquidio_ptp_adjfreq      [liquidio]
[...]
ffffffffa22b9490 t lio_vf_rep_create        [liquidio]
ffffffffa22b96a0 t lio_vf_rep_destroy       [liquidio]
ffffffffa22b9810 t lio_vf_rep_modinit        [liquidio]
ffffffffa22b9830 t lio_vf_rep_modexit        [liquidio]
ffffffffa22b9850 t lio_ethtool_get_channels   [liquidio] [liquidio_vf]
ffffffffa22b9930 t lio_ethtool_get_ringparam  [liquidio] [liquidio_vf]
ffffffffa22b99d0 t lio_get_msglevel   [liquidio] [liquidio_vf]
ffffffffa22b99f0 t lio_vf_set_msglevel        [liquidio] [liquidio_vf]
ffffffffa22b9a10 t lio_get_pauseparam         [liquidio] [liquidio_vf]
ffffffffa22b9a40 t lio_get_ethtool_stats     [liquidio] [liquidio_vf]
ffffffffa22ba180 t lio_vf_get_ethtool_stats  [liquidio] [liquidio_vf]
ffffffffa22ba4f0 t lio_get_regs_len   [liquidio] [liquidio_vf]
ffffffffa22ba530 t lio_get_priv_flags         [liquidio] [liquidio_vf]
ffffffffa22ba550 t lio_set_priv_flags         [liquidio] [liquidio_vf]
ffffffffa22ba580 t lio_set_fecparam   [liquidio] [liquidio_vf]
ffffffffa22ba5f0 t lio_get_fecparam   [liquidio] [liquidio_vf]
[...]
ffffffffa22cbd10 t liquidio_set_mac [liquidio_vf]
ffffffffa22cbe90 t handle_timestamp  [liquidio_vf]
ffffffffa22cbf40 t free_netbuf       [liquidio_vf]
ffffffffa22cbf90 t octnet_link_status_change [liquidio_vf]
ffffffffa22cbfc0 t liquidio_vxlan_port_command.constprop.0   [liquidio_vf]

Like /proc/kallsyms, the output is driven by address, so keeps the
curious property of /proc/kallsyms that symbols (like free_netbuf above)
may appear repeatedly with different addresses: but now, unlike in
/proc/kallsyms, we can see that those symbols appear repeatedly because
they are *different symbols* that ultimately belong to different
modules, all of which are built in to the kernel.

As with /proc/kallsyms, non-root usage produces addresses that are
all zero.

I am not wedded to the name or format of /proc/kallmodsyms, but felt it
best to split it out of /proc/kallsyms to avoid breaking existing
kallsyms parsers.  Another possible syntax might be to use {curly
brackets} or something to denote built-in modules: it might be possible
to drop /proc/kallmodsyms and make /proc/kallsyms emit things in this
format.  (Equally, now kallmodsyms data uses very little space, the
CONFIG_KALLMODSYMS config option might be something people don't want to
bother with.)

Internally, this uses a new kallsyms_builtin_module_address() almost
identical to kallsyms_sym_address() to get the address corresponding to
a given .kallsyms_modules index, and a new get_builtin_module_idx quite
similar to get_symbol_pos to determine the index in the
.kallsyms_modules array that relates to a given address.  Save a little
time by exploiting the fact that all callers will only ever traverse
this list from start to end by allowing them to pass in the previous
index returned from this function as a hint: thus very few bsearches are
actually needed.  (In theory this could change to just walk straight
down kallsyms_module_addresses/offsets and not bother bsearching at all,
but doing it this way is hardly any slower and much more robust.)

The display process is complicated a little by the weird format of the
.kallsyms_module_names table: we have to look for multimodule entries
and print them as space-separated lists of module names.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
---
 kernel/kallsyms.c | 242 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 227 insertions(+), 15 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 3011bc33a5ba..c81610ffc4ba 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -48,8 +48,18 @@ __section(".rodata") __attribute__((weak));
 extern const unsigned long kallsyms_relative_base
 __section(".rodata") __attribute__((weak));
 
+extern const unsigned long kallsyms_num_modules
+__section(".rodata") __attribute__((weak));
+
+extern const unsigned long kallsyms_module_names_len
+__section(".rodata") __attribute__((weak));
+
 extern const char kallsyms_token_table[] __weak;
 extern const u16 kallsyms_token_index[] __weak;
+extern const unsigned long kallsyms_module_addresses[] __weak;
+extern const int kallsyms_module_offsets[] __weak;
+extern const u32 kallsyms_modules[] __weak;
+extern const char kallsyms_module_names[] __weak;
 
 extern const unsigned int kallsyms_markers[] __weak;
 
@@ -205,6 +215,25 @@ static bool cleanup_symbol_name(char *s)
 	return false;
 }
 
+#ifdef CONFIG_KALLMODSYMS
+static unsigned long kallsyms_builtin_module_address(int idx)
+{
+	if (!IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE))
+		return kallsyms_module_addresses[idx];
+
+	/* values are unsigned offsets if --absolute-percpu is not in effect */
+	if (!IS_ENABLED(CONFIG_KALLSYMS_ABSOLUTE_PERCPU))
+		return kallsyms_relative_base + (u32)kallsyms_module_offsets[idx];
+
+	/* ...otherwise, positive offsets are absolute values */
+	if (kallsyms_module_offsets[idx] >= 0)
+		return kallsyms_module_offsets[idx];
+
+	/* ...and negative offsets are relative to kallsyms_relative_base - 1 */
+	return kallsyms_relative_base - 1 - kallsyms_module_offsets[idx];
+}
+#endif
+
 /* Lookup the address for this symbol. Returns 0 if not found. */
 unsigned long kallsyms_lookup_name(const char *name)
 {
@@ -308,6 +337,54 @@ static unsigned long get_symbol_pos(unsigned long addr,
 	return low;
 }
 
+/*
+ * The caller passes in an address, and we return an index to the corresponding
+ * builtin module index in .kallsyms_modules, or (unsigned long) -1 if none
+ * match.
+ *
+ * The hint_idx, if set, is a hint as to the possible return value, to handle
+ * the common case in which consecutive runs of addresses relate to the same
+ * index.
+ */
+#ifdef CONFIG_KALLMODSYMS
+static unsigned long get_builtin_module_idx(unsigned long addr, unsigned long hint_idx)
+{
+	unsigned long low, high, mid;
+
+	if (!IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE))
+		BUG_ON(!kallsyms_module_addresses);
+	else
+		BUG_ON(!kallsyms_module_offsets);
+
+	/*
+	 * Do a binary search on the sorted kallsyms_modules array.  The last
+	 * entry in this array indicates the end of the text section, not an
+	 * object file.
+	 */
+	low = 0;
+	high = kallsyms_num_modules - 1;
+
+	if (hint_idx > low && hint_idx < (high - 1) &&
+	    addr >= kallsyms_builtin_module_address(hint_idx) &&
+	    addr < kallsyms_builtin_module_address(hint_idx + 1))
+		return hint_idx;
+
+	if (addr >= kallsyms_builtin_module_address(low)
+	    && addr < kallsyms_builtin_module_address(high)) {
+		while (high - low > 1) {
+			mid = low + (high - low) / 2;
+			if (kallsyms_builtin_module_address(mid) <= addr)
+				low = mid;
+			else
+				high = mid;
+		}
+		return low;
+	}
+
+	return (unsigned long) -1;
+}
+#endif
+
 /*
  * Lookup an address but don't bother to find any names.
  */
@@ -579,6 +656,8 @@ struct kallsym_iter {
 	char type;
 	char name[KSYM_NAME_LEN];
 	char module_name[MODULE_NAME_LEN];
+	const char *builtin_module_names;
+	unsigned long hint_builtin_module_idx;
 	int exported;
 	int show_value;
 };
@@ -609,6 +688,8 @@ static int get_ksymbol_mod(struct kallsym_iter *iter)
 				     &iter->value, &iter->type,
 				     iter->name, iter->module_name,
 				     &iter->exported);
+	iter->builtin_module_names = NULL;
+
 	if (ret < 0) {
 		iter->pos_mod_end = iter->pos;
 		return 0;
@@ -628,6 +709,8 @@ static int get_ksymbol_ftrace_mod(struct kallsym_iter *iter)
 					 &iter->value, &iter->type,
 					 iter->name, iter->module_name,
 					 &iter->exported);
+	iter->builtin_module_names = NULL;
+
 	if (ret < 0) {
 		iter->pos_ftrace_mod_end = iter->pos;
 		return 0;
@@ -642,6 +725,7 @@ static int get_ksymbol_bpf(struct kallsym_iter *iter)
 
 	strlcpy(iter->module_name, "bpf", MODULE_NAME_LEN);
 	iter->exported = 0;
+	iter->builtin_module_names = NULL;
 	ret = bpf_get_kallsym(iter->pos - iter->pos_ftrace_mod_end,
 			      &iter->value, &iter->type,
 			      iter->name);
@@ -662,23 +746,53 @@ static int get_ksymbol_kprobe(struct kallsym_iter *iter)
 {
 	strlcpy(iter->module_name, "__builtin__kprobes", MODULE_NAME_LEN);
 	iter->exported = 0;
+	iter->builtin_module_names = NULL;
 	return kprobe_get_kallsym(iter->pos - iter->pos_bpf_end,
 				  &iter->value, &iter->type,
 				  iter->name) < 0 ? 0 : 1;
 }
 
 /* Returns space to next name. */
-static unsigned long get_ksymbol_core(struct kallsym_iter *iter)
+static unsigned long get_ksymbol_core(struct kallsym_iter *iter, int kallmodsyms)
 {
 	unsigned off = iter->nameoff;
 
-	iter->module_name[0] = '\0';
+	iter->exported = 0;
 	iter->value = kallsyms_sym_address(iter->pos);
 
 	iter->type = kallsyms_get_symbol_type(off);
 
+	iter->module_name[0] = '\0';
+	iter->builtin_module_names = NULL;
+
 	off = kallsyms_expand_symbol(off, iter->name, ARRAY_SIZE(iter->name));
+#ifdef CONFIG_KALLMODSYMS
+	if (kallmodsyms) {
+		unsigned long mod_idx = (unsigned long) -1;
+
+		if (kallsyms_module_offsets)
+			mod_idx =
+			  get_builtin_module_idx(iter->value,
+						 iter->hint_builtin_module_idx);
 
+		/*
+		 * This is a built-in module iff the tables of built-in modules
+		 * (address->module name mappings) and module names are known,
+		 * and if the address was found there, and if the corresponding
+		 * module index is nonzero.  All other cases mean off the end of
+		 * the binary or in a non-modular range in between one or more
+		 * modules.  (Also guard against a corrupt kallsyms_objfiles
+		 * array pointing off the end of kallsyms_modules.)
+		 */
+		if (kallsyms_modules != NULL && kallsyms_module_names != NULL &&
+		    mod_idx != (unsigned long) -1 &&
+		    kallsyms_modules[mod_idx] != 0 &&
+		    kallsyms_modules[mod_idx] < kallsyms_module_names_len)
+			iter->builtin_module_names =
+			  &kallsyms_module_names[kallsyms_modules[mod_idx]];
+		iter->hint_builtin_module_idx = mod_idx;
+	}
+#endif
 	return off - iter->nameoff;
 }
 
@@ -724,7 +838,7 @@ static int update_iter_mod(struct kallsym_iter *iter, loff_t pos)
 }
 
 /* Returns false if pos at or past end of file. */
-static int update_iter(struct kallsym_iter *iter, loff_t pos)
+static int update_iter(struct kallsym_iter *iter, loff_t pos, int kallmodsyms)
 {
 	/* Module symbols can be accessed randomly. */
 	if (pos >= kallsyms_num_syms)
@@ -734,7 +848,7 @@ static int update_iter(struct kallsym_iter *iter, loff_t pos)
 	if (pos != iter->pos)
 		reset_iter(iter, pos);
 
-	iter->nameoff += get_ksymbol_core(iter);
+	iter->nameoff += get_ksymbol_core(iter, kallmodsyms);
 	iter->pos++;
 
 	return 1;
@@ -744,14 +858,14 @@ static void *s_next(struct seq_file *m, void *p, loff_t *pos)
 {
 	(*pos)++;
 
-	if (!update_iter(m->private, *pos))
+	if (!update_iter(m->private, *pos, 0))
 		return NULL;
 	return p;
 }
 
 static void *s_start(struct seq_file *m, loff_t *pos)
 {
-	if (!update_iter(m->private, *pos))
+	if (!update_iter(m->private, *pos, 0))
 		return NULL;
 	return m->private;
 }
@@ -760,7 +874,7 @@ static void s_stop(struct seq_file *m, void *p)
 {
 }
 
-static int s_show(struct seq_file *m, void *p)
+static int s_show_internal(struct seq_file *m, void *p, int kallmodsyms)
 {
 	void *value;
 	struct kallsym_iter *iter = m->private;
@@ -771,23 +885,67 @@ static int s_show(struct seq_file *m, void *p)
 
 	value = iter->show_value ? (void *)iter->value : NULL;
 
-	if (iter->module_name[0]) {
+	/*
+	 * Real module, or built-in module and /proc/kallsyms being shown.
+	 */
+	if (iter->module_name[0] != '\0' ||
+	    (iter->builtin_module_names != NULL && kallmodsyms != 0)) {
 		char type;
 
 		/*
-		 * Label it "global" if it is exported,
-		 * "local" if not exported.
+		 * Label it "global" if it is exported, "local" if not exported.
 		 */
 		type = iter->exported ? toupper(iter->type) :
 					tolower(iter->type);
-		seq_printf(m, "%px %c %s\t[%s]\n", value,
-			   type, iter->name, iter->module_name);
+#ifdef CONFIG_KALLMODSYMS
+		if (kallmodsyms) {
+			/*
+			 * /proc/kallmodsyms, built as a module.
+			 */
+			if (iter->builtin_module_names == NULL)
+				seq_printf(m, "%px %c %s\t[%s]\n", value,
+					   type, iter->name,
+					   iter->module_name);
+			/*
+			 * /proc/kallmodsyms, single-module symbol.
+			 */
+			else if (*iter->builtin_module_names != '\0')
+				seq_printf(m, "%px %c %s\t[%s]\n", value,
+					   type, iter->name,
+					   iter->builtin_module_names);
+			/*
+			 * /proc/kallmodsyms, multimodule symbol.  Formatted
+			 * as \0MODULE_COUNTmodule-1\0module-2\0, where
+			 * MODULE_COUNT is a single byte, 2 or higher.
+			 */
+			else {
+				size_t i = *(char *)(iter->builtin_module_names + 1);
+				const char *walk = iter->builtin_module_names + 2;
+
+				seq_printf(m, "%px %c %s\t[%s]", value,
+					   type, iter->name, walk);
+
+                                while (--i > 0) {
+					walk += strlen(walk) + 1;
+					seq_printf (m, " [%s]", walk);
+				}
+				seq_printf(m, "\n");
+			}
+		} else				/* !kallmodsyms */
+#endif /* CONFIG_KALLMODSYMS */
+			seq_printf(m, "%px %c %s\t[%s]\n", value,
+				   type, iter->name, iter->module_name);
 	} else
 		seq_printf(m, "%px %c %s\n", value,
 			   iter->type, iter->name);
 	return 0;
 }
 
+static int s_show(struct seq_file *m, void *p)
+{
+	return s_show_internal(m, p, 0);
+}
+
 static const struct seq_operations kallsyms_op = {
 	.start = s_start,
 	.next = s_next,
@@ -795,6 +953,35 @@ static const struct seq_operations kallsyms_op = {
 	.show = s_show
 };
 
+#ifdef CONFIG_KALLMODSYMS
+static int s_mod_show(struct seq_file *m, void *p)
+{
+	return s_show_internal(m, p, 1);
+}
+static void *s_mod_next(struct seq_file *m, void *p, loff_t *pos)
+{
+	(*pos)++;
+
+	if (!update_iter(m->private, *pos, 1))
+		return NULL;
+	return p;
+}
+
+static void *s_mod_start(struct seq_file *m, loff_t *pos)
+{
+	if (!update_iter(m->private, *pos, 1))
+		return NULL;
+	return m->private;
+}
+
+static const struct seq_operations kallmodsyms_op = {
+	.start = s_mod_start,
+	.next = s_mod_next,
+	.stop = s_stop,
+	.show = s_mod_show
+};
+#endif
+
 static inline int kallsyms_for_perf(void)
 {
 #ifdef CONFIG_PERF_EVENTS
@@ -830,7 +1017,8 @@ bool kallsyms_show_value(const struct cred *cred)
 	}
 }
 
-static int kallsyms_open(struct inode *inode, struct file *file)
+static int kallsyms_open_internal(struct inode *inode, struct file *file,
+	const struct seq_operations *ops)
 {
 	/*
 	 * We keep iterator in m->private, since normal case is to
@@ -838,7 +1026,7 @@ static int kallsyms_open(struct inode *inode, struct file *file)
 	 * using get_symbol_offset for every symbol.
 	 */
 	struct kallsym_iter *iter;
-	iter = __seq_open_private(file, &kallsyms_op, sizeof(*iter));
+	iter = __seq_open_private(file, ops, sizeof(*iter));
 	if (!iter)
 		return -ENOMEM;
 	reset_iter(iter, 0);
@@ -851,6 +1039,18 @@ static int kallsyms_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static int kallsyms_open(struct inode *inode, struct file *file)
+{
+	return kallsyms_open_internal(inode, file, &kallsyms_op);
+}
+
+#ifdef CONFIG_KALLMODSYMS
+static int kallmodsyms_open(struct inode *inode, struct file *file)
+{
+	return kallsyms_open_internal(inode, file, &kallmodsyms_op);
+}
+#endif
+
 #ifdef	CONFIG_KGDB_KDB
 const char *kdb_walk_kallsyms(loff_t *pos)
 {
@@ -861,7 +1061,7 @@ const char *kdb_walk_kallsyms(loff_t *pos)
 		reset_iter(&kdb_walk_kallsyms_iter, 0);
 	}
 	while (1) {
-		if (!update_iter(&kdb_walk_kallsyms_iter, *pos))
+		if (!update_iter(&kdb_walk_kallsyms_iter, *pos, 0))
 			return NULL;
 		++*pos;
 		/* Some debugging symbols have no name.  Ignore them. */
@@ -878,9 +1078,21 @@ static const struct proc_ops kallsyms_proc_ops = {
 	.proc_release	= seq_release_private,
 };
 
+#ifdef CONFIG_KALLMODSYMS
+static const struct proc_ops kallmodsyms_proc_ops = {
+	.proc_open	= kallmodsyms_open,
+	.proc_read	= seq_read,
+	.proc_lseek	= seq_lseek,
+	.proc_release	= seq_release_private,
+};
+#endif
+
 static int __init kallsyms_init(void)
 {
 	proc_create("kallsyms", 0444, NULL, &kallsyms_proc_ops);
+#ifdef CONFIG_KALLMODSYMS
+	proc_create("kallmodsyms", 0444, NULL, &kallmodsyms_proc_ops);
+#endif
 	return 0;
 }
 device_initcall(kallsyms_init);
-- 
2.34.0.258.gc900572c39

