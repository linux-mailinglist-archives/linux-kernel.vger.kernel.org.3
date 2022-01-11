Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E73B48AB68
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 11:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348894AbiAKKbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 05:31:53 -0500
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:43294 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236960AbiAKKbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 05:31:52 -0500
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20B9sw1F020500;
        Tue, 11 Jan 2022 10:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=PPS06212021;
 bh=ecFoWGWSPpsGVdbKTwIQIXVrCzP5kXhzoxbSNfHkUuM=;
 b=bCRdG06ar5KwWQIvj5jx05iJqOmWAB9tJI2oSmXnFzhvDA6pLPE9jtP2bw5dlVTveZQV
 NguU7qtQHoeDgW1YEWa/AEdkmxotDRmejihJOwbrnD7YGRMII8A3+UPLhhqt/jO1oPx5
 AHKMvqt3PvopffGBYMjNt0rYhCTUPJsJWtIlhtYwHTXnpj91qT84KPcB9oz8aOaRZY8j
 mp5/K3YmgRjJrFGUPLQTmniMk8Zru4adOSvC+/tyFcIYCFSvtMbIikhBvgJu/jA9QEjt
 oQcCPf71W/fZmRmgewWiiWP3VjTWXQZ5/hiAGpG11kwiV5y9Li+5+lGtKe5l8DpYM63u 2A== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3dgd99gybh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 10:31:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPC2AkhZbIK/w2a0uZ8Sl/k6rAlObrVwxw0pb/yq6n46h/V4kJ61CzWLf4MG2KyVVlTh8OlDWgOO0qnSciH/o0mlnRNSUoKq97THObgbwbaKqXNG6mIVdiorq+sjlqEtKixUJb9R1u2ARWr/YFvZ4ba2PprV5jLeqcTxVGfY0eMlsb++CimWmKWdsGNWdD7rlAr7H/OBDKeeTIzpX2ZF2N0hpTKfocDw2dIGWcdiJqsiJE651bKSxb0kVgHkz3z0FAUgAzw978B2C55sj0rJ2m364ZwOnZ/6GKouc3ASmyHCLfmCw0X31vOxGwXqyrtN8p1UJzm/GQmOXLNg5YY1zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecFoWGWSPpsGVdbKTwIQIXVrCzP5kXhzoxbSNfHkUuM=;
 b=VOUiRhkwwTDt7FQSxWx6dSthr18KSoqH1kfC+7UC9bRp7ndxYcHKUWCLbDyb8LtUM4fZyoWqDfP/6LxmfyoRKEp3cLwgSBOyEE2319B54AlZ3KkSFGxRaiaxDvcnX8rpP57IeQCSCRhTVPJj+oXsaqFFlfQ4N8lN9hsMDJWLtKBhdRTbQNBzv21KM0EwzvB9L1HMmjsdMWe0HXxnW3EpYGN42cIl1YRfIz5fUeJPa4gNJlXYrzrPjQi4kzcSySLTp2LJyV0MJ1fUMXk6AtliqrTvIQIGltY7Vj19aopT29qmZG/2R95NTj8y3nC65Do85HKUm+yFyEQeF4zHmNJHPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5348.namprd11.prod.outlook.com (2603:10b6:610:bb::16)
 by SA0PR11MB4720.namprd11.prod.outlook.com (2603:10b6:806:72::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 10:31:37 +0000
Received: from CH0PR11MB5348.namprd11.prod.outlook.com
 ([fe80::dd33:eca5:868e:f800]) by CH0PR11MB5348.namprd11.prod.outlook.com
 ([fe80::dd33:eca5:868e:f800%7]) with mapi id 15.20.4888.009; Tue, 11 Jan 2022
 10:31:37 +0000
From:   Liwei Song <liwei.song@windriver.com>
To:     SrinivasPandruvada <srinivas.pandruvada@linux.intel.com>,
        HansdeGoede <hdegoede@redhat.com>,
        MarkGross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        liwei.song@windriver.com
Subject: [PATCH] platform/x86: ISST: do not hold lock punit_misc_dev_lock when register misc
Date:   Tue, 11 Jan 2022 18:31:22 +0800
Message-Id: <20220111103122.32362-1-liwei.song@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0113.apcprd03.prod.outlook.com
 (2603:1096:203:b0::29) To CH0PR11MB5348.namprd11.prod.outlook.com
 (2603:10b6:610:bb::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccc6297d-0b0c-49ea-a59f-08d9d4ed8bc7
X-MS-TrafficTypeDiagnostic: SA0PR11MB4720:EE_
X-Microsoft-Antispam-PRVS: <SA0PR11MB4720F839534640A287DFD25D9E519@SA0PR11MB4720.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MsP3GbLBnqozQxYg+t6UwpJC3o8jinYzt9viOKEBoxx/rLOrnI2HcXDBZnv7ph8ZEZ9GIuv+hq1FUWXcsX0zkU/tsKafm6ZBOkowdUrUgHevLbIdJEv7mVEJqxGZKzNLZnOI52M3VnY1VDJUIejiGpjUaZBE0IBUdITZ7TC6Y+m6mSXOen72mXtDcgjr5OtQXjsKbtl4L1eCwB/+fK/pimit5KQ4HeS4mqAm42vEwImLr6bS+8yRjElemTTn1IXgcHfn7YDA7LLVEgMBK1i3wtpMIQFfFH3JYl4dkrPib9gKB+Tq24SdFzlkZgBbshjlKWDajyoxRZZSe0/YtIqURuXQCXyND34kO6+og2XTBt6hXdx1BcoTHloONLdPJgemqngK8u+jMLzzT76ThPYC6MaD9A/aX0Z8bwX5lIMCt69xRbUUE0WLFrequuXGWIqDjCpdqTOAzAL9DhLRet+hsM1PHEbxXwCRt524nNYzcTAVHrEWpXMSG8RqBrc0aLBN2J9bZsf3c3EL2c3rx1piQFcxuUr+0UOmwhfDF5IQIRJQnliXw+F/vX6rQU6h/pqDOAHwVAtVUTgdX+3sRv9kyLemL4GOYrD5AF503hh16LDFMc+jdYxuXsjNFf5QLx7B1o96H80W4ouGbtzO6BEW42BYMlzjROkX+GsK1JImnCrM9YM1KdGguMtKPSHy0jEBjRGfFopxS+vJTkGwGmI9Pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5348.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(6512007)(38350700002)(52116002)(6486002)(38100700002)(6666004)(110136005)(316002)(66556008)(66946007)(66476007)(1076003)(5660300002)(86362001)(44832011)(8936002)(186003)(6506007)(508600001)(2616005)(26005)(107886003)(8676002)(83380400001)(4326008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p4Tlo7txyBnHO02LKRR6RRkWzkI5jemC3hRq3EusoaNsxyhZaNtWZWCeq8CU?=
 =?us-ascii?Q?6hsNt9KasbRZhExSNrG3QVDUMhzf44hjxQDjq8etkt1MXeXEz2BbLrtlwtQj?=
 =?us-ascii?Q?FPbW5MCTv6hhbWcInOj8vFiVtNl4Iga0T4vcCm3mzMcCtX/7VEF+gv5VAg48?=
 =?us-ascii?Q?Qrtp4B5oeVVYNZzBIxmKRtgsoatL2Elr5GeNL+e72EuQlTfjbBt4pFSsB91W?=
 =?us-ascii?Q?A1aXt85alsR/I/g1IOKFf1jomBPzJ6LzGwlJfkgIy8ABhZfMnLYtgj336SAh?=
 =?us-ascii?Q?qhV1275EC/wjsUEH2uOG2kUH09Vv12QPfvXVMQSJJAfIF11SG2YingztLid9?=
 =?us-ascii?Q?nCkX0hpLTP4/pW+MvpHKG9sXWvJLxBG3tdAxPMZW6TojBi+3Aunqy1FZa+IZ?=
 =?us-ascii?Q?sp3kpnQP5gq6X5gXC4mRoudArg9J0J/uICaZUIzEEUW/v5m0Ph7tSuLzdYGE?=
 =?us-ascii?Q?GoYIZrOjLZ8E7hFtidjXoNu7mJ8Eb6u8qWmW2/s5wgIkD69sQ7dW1UgkHgjh?=
 =?us-ascii?Q?a5gFsMtBaV56/FJ29ZHMqDsq8Yh0pQHUvkIc9jQeCQuBgt7C+EkreZsIlN8x?=
 =?us-ascii?Q?8/OoFhGgFzD5hqrHhbg7QuZLkXgHMjTnWuw1OEEZbh8y6biLd4Zv0nB+o+cC?=
 =?us-ascii?Q?wDIBxRu54eLIboYyxY8gMLTjO813dfNcXJyYeLL5FmSmLxeu2/O1byhX5Ydn?=
 =?us-ascii?Q?acSKZ9mGjgizZA+AvtmkuJFMRLJdFcO2GjkD5inyLcXdKzfTiQeG6EvrNr+I?=
 =?us-ascii?Q?78RvKMtJM62MHZzoum/11E1NVNxMpw4jq+qcgVsGY1HHsWVs0359UbueIFCN?=
 =?us-ascii?Q?SSi7LvUXw8ah6MxodwpY33w5L02h/dnIOPBsMB/F3riR9mroE2Xy/2jGmjPh?=
 =?us-ascii?Q?UaxN9BtUwH2EI9hwZWd4+boeyvd4EtS02K3VO9w5+jF7YCmTdHf+Fq9NvX+8?=
 =?us-ascii?Q?v3DbZvHSmQ2hhwAfQElGvFA7P9dxl9at5A49/vs1t974DecIMaYRCXBbrBh/?=
 =?us-ascii?Q?JW1KVvp8mIkKs8/AgXQBs6zIi6rZoZU44ITJvqyK0OalM6K7cx1lN18VuP+4?=
 =?us-ascii?Q?gpFmBt410XYGu/AYp14oMzhZQytzDI5uamSZ0A/dTZRGg4cDtwW2ZoL8xF1g?=
 =?us-ascii?Q?jaq4CoSMb+AzTDmKtYjryHj746bssMfPA5ztUpGFwy2WwoqmevyPF36wLIxP?=
 =?us-ascii?Q?HhlQGahBvfLlkksaG484CTWIBr1r1RcC466xfco6sV7m+il8+yOPtKoJlF5K?=
 =?us-ascii?Q?F///ahLVrEqJ6wRXN/D/YK0K4bbBSRvrDtBPoEimkCYOLgpTHIYE+43I7Kzq?=
 =?us-ascii?Q?5+z9BzAEW82gFGd5fQUhXFIXbxuC7aX75EsuCssIBp8YXhdJ/HL+55Rn7bR6?=
 =?us-ascii?Q?pPtD1a8TuNHqDHOIsQMJWh5B1Hv6J9IB/Aivvsei6k0OZUGap//H9oPGo/sU?=
 =?us-ascii?Q?ro1II8FRkXlH7URGgTAaZuZhJqYJit9Hcg4NZ4N37uKbiurNVaN4GFKngiGA?=
 =?us-ascii?Q?9iE5v9GNXxWqVvDQfIqhGbx+e3O9nDh/gWiqUd/2/HeFz9gckbN3k7HlV4OZ?=
 =?us-ascii?Q?0wjAyNABuOvKG7zDQIWxQs0xren0oUI7niGit0si/zbYSENNskH2V59o1osv?=
 =?us-ascii?Q?XWIXLnrOgHjvtHmw9DfzXK8Ayvo8VxEbDpwD6uY4tOBENNqBLUJEQMy9f1KO?=
 =?us-ascii?Q?1Q+2tA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc6297d-0b0c-49ea-a59f-08d9d4ed8bc7
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5348.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 10:31:36.8340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k5f5jJrGmEU4H67yaNkMdEUSM0RQ7GgO4mxV1clHNuQxhVyCd7hTtpdfvNP5t+W+ZJ1fUoyjftc8ZCzlqZ6gexBIb0aa1GZ0e41anmnm2Q4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4720
X-Proofpoint-ORIG-GUID: U3DqnBJEq_K6MIOxR_xq3g31iWK-PK6f
X-Proofpoint-GUID: U3DqnBJEq_K6MIOxR_xq3g31iWK-PK6f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-11_03,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1011 impostorscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201110061
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

exist the below call sequences may cause deadlock:

isst_if_probe()
   --> isst_if_cdev_register()
      --> mutex_lock(&punit_misc_dev_lock)
   --> misc_register()
      --> mutex_lock(&misc_mtx)

misc_open()
   --> mutex_lock(&misc_mtx)
   --> isst_if_open()
      --> mutex_lock(&punit_misc_dev_lock)

to fix this do not hold punit_misc_dev_lock when call misc_register
since it has misc_mtx lock for sync.

[  256.104522] ======================================================
[  256.113783] WARNING: possible circular locking dependency detected
[  256.120093] 5.16.0-rc6-yocto-standard+ #99 Not tainted
[  256.125362] ------------------------------------------------------
[  256.131673] intel-speed-sel/844 is trying to acquire lock:
[  256.137290] ffffffffc036f0d0 (punit_misc_dev_lock){+.+.}-{3:3}, at: isst_if_open+0x18/0x90 [isst_if_common]
[  256.147171]
[  256.147171] but task is already holding lock:
[  256.153135] ffffffff8ee7cb50 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x2a/0x170
[  256.160407]
[  256.160407] which lock already depends on the new lock.
[  256.160407]
[  256.168712]
[  256.168712] the existing dependency chain (in reverse order) is:
[  256.176327]
[  256.176327] -> #1 (misc_mtx){+.+.}-{3:3}:
[  256.181946]        lock_acquire+0x1e6/0x330
[  256.186265]        __mutex_lock+0x9b/0x9b0
[  256.190497]        mutex_lock_nested+0x1b/0x20
[  256.195075]        misc_register+0x32/0x1a0
[  256.199390]        isst_if_cdev_register+0x65/0x180 [isst_if_common]
[  256.205878]        isst_if_probe+0x144/0x16e [isst_if_mmio]
[  256.209991] hrtimer: interrupt took 10370 ns
[  256.211582]        local_pci_probe+0x47/0xa0
[  256.220384]        work_for_cpu_fn+0x17/0x30
[  256.224790]        process_one_work+0x26a/0x650
[  256.229456]        worker_thread+0x1dd/0x3b0
[  256.233861]        kthread+0x191/0x1c0
[  256.237745]        ret_from_fork+0x1f/0x30
[  256.241976]
[  256.241976] -> #0 (punit_misc_dev_lock){+.+.}-{3:3}:
[  256.248552]        validate_chain+0xbc6/0x1750
[  256.253131]        __lock_acquire+0x88c/0xc10
[  256.257618]        lock_acquire+0x1e6/0x330
[  256.261933]        __mutex_lock+0x9b/0x9b0
[  256.266165]        mutex_lock_nested+0x1b/0x20
[  256.270739]        isst_if_open+0x18/0x90 [isst_if_common]
[  256.276356]        misc_open+0x100/0x170
[  256.280409]        chrdev_open+0xa5/0x1e0
[  256.284550]        do_dentry_open+0x23d/0x3c0
[  256.289039]        vfs_open+0x2f/0x40
[  256.292836]        path_openat+0x87a/0x940
[  256.297064]        do_filp_open+0xc5/0x140
[  256.301295]        do_sys_openat2+0x23d/0x320
[  256.305782]        do_sys_open+0x59/0x80
[  256.309836]        __x64_sys_openat+0x20/0x30
[  256.314324]        do_syscall_64+0x3f/0x90
[  256.318552]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[  256.324259]
[  256.324259] other info that might help us debug this:
[  256.324259]
[  256.332394]  Possible unsafe locking scenario:
[  256.332394]
[  256.338444]        CPU0                    CPU1
[  256.343105]        ----                    ----
[  256.347768]   lock(misc_mtx);
[  256.350870]                                lock(punit_misc_dev_lock);
[  256.357441]                                lock(misc_mtx);
[  256.363058]   lock(punit_misc_dev_lock);
[  256.367110]
[  256.367110]  *** DEADLOCK ***
[  256.367110]
[  256.373162] 1 lock held by intel-speed-sel/844:
[  256.377824]  #0: ffffffff8ee7cb50 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x2a/0x170
[  256.385531]
[  256.385531] stack backtrace:
[  256.390021] CPU: 12 PID: 844 Comm: intel-speed-sel Not tainted 5.16.0-rc6-yocto-standard+ #99
[  256.398678] Hardware name: ACCTON MOROCITY/MOROCITY, BIOS IDVLCRB1.86B.0021.D09.2111010103 11/01/2021
[  256.408028] Call Trace:
[  256.410605]  <TASK>
[  256.412837]  dump_stack_lvl+0x5b/0x82
[  256.416635]  dump_stack+0x10/0x12
[  256.420085]  print_circular_bug.isra.43+0x261/0x2c0
[  256.425095]  check_noncircular+0x126/0x140
[  256.429326]  ? __this_cpu_preempt_check+0x13/0x20
[  256.434167]  validate_chain+0xbc6/0x1750
[  256.438223]  ? validate_chain+0xbc6/0x1750
[  256.442451]  ? validate_chain+0x236/0x1750
[  256.446687]  __lock_acquire+0x88c/0xc10
[  256.450658]  lock_acquire+0x1e6/0x330
[  256.454452]  ? isst_if_open+0x18/0x90 [isst_if_common]
[  256.459726]  ? __mutex_lock+0x79/0x9b0
[  256.463610]  ? __mutex_lock+0x79/0x9b0
[  256.467493]  ? isst_if_open+0x18/0x90 [isst_if_common]
[  256.472764]  ? isst_if_open+0x18/0x90 [isst_if_common]
[  256.478038]  __mutex_lock+0x9b/0x9b0
[  256.481748]  ? isst_if_open+0x18/0x90 [isst_if_common]
[  256.487021]  ? __mutex_lock+0x102/0x9b0
[  256.490993]  ? __this_cpu_preempt_check+0x13/0x20
[  256.495837]  mutex_lock_nested+0x1b/0x20
[  256.499893]  ? mutex_lock_nested+0x1b/0x20
[  256.504121]  isst_if_open+0x18/0x90 [isst_if_common]
[  256.509222]  misc_open+0x100/0x170
[  256.512759]  chrdev_open+0xa5/0x1e0
[  256.516386]  ? cdev_put.part.1+0x20/0x20
[  256.520441]  do_dentry_open+0x23d/0x3c0
[  256.524414]  vfs_open+0x2f/0x40
[  256.527689]  path_openat+0x87a/0x940
[  256.531399]  do_filp_open+0xc5/0x140
[  256.535112]  ? trace_preempt_on+0x28/0xd0
[  256.539255]  ? alloc_fd+0x152/0x230
[  256.542880]  ? preempt_count_sub+0x9b/0x100
[  256.547200]  ? _raw_spin_unlock+0x2c/0x50
[  256.551348]  do_sys_openat2+0x23d/0x320
[  256.555320]  ? do_sys_openat2+0x23d/0x320
[  256.559467]  do_sys_open+0x59/0x80
[  256.563003]  __x64_sys_openat+0x20/0x30
[  256.566972]  do_syscall_64+0x3f/0x90
[  256.570680]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  256.575866] RIP: 0033:0x7f9be4b97c27
[  256.579576] Code: 25 00 00 41 00 3d 00 00 41 00 74 37 64 8b 04 25 18 00 00 00 85 c0 75 5b 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 85 00 00 00 48 83 c4 68 5d 41 5c c3 0f 1f
[  256.598474] RSP: 002b:00007ffd8fc01b70 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
[  256.606177] RAX: ffffffffffffffda RBX: 00005572f20332b0 RCX: 00007f9be4b97c27
[  256.613443] RDX: 0000000000000000 RSI: 00005572f202936a RDI: 00000000ffffff9c
[  256.620709] RBP: 00005572f202936a R08: 0000000000000008 R09: 0000000000000001
[  256.627974] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  256.635241] R13: 00005572f20332b0 R14: 0000000000000001 R15: 0000000000000000
[  256.642513]  </TASK>

Signed-off-by: Liwei Song <liwei.song@windriver.com>
---
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index c9a85eb2e860..bcbc0d508ec4 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -693,10 +693,12 @@ int isst_if_cdev_register(int device_type, struct isst_if_cmd_cb *cb)
 	if (!misc_usage_count) {
 		int ret;
 
+		mutex_unlock(&punit_misc_dev_lock);
 		misc_device_ret = misc_register(&isst_if_char_driver);
 		if (misc_device_ret)
-			goto unlock_exit;
+			return misc_device_ret;
 
+		mutex_lock(&punit_misc_dev_lock);
 		ret = isst_if_cpu_info_init();
 		if (ret) {
 			misc_deregister(&isst_if_char_driver);
@@ -731,7 +733,9 @@ void isst_if_cdev_unregister(int device_type)
 	if (device_type == ISST_IF_DEV_MBOX)
 		isst_delete_hash();
 	if (!misc_usage_count && !misc_device_ret) {
+		mutex_unlock(&punit_misc_dev_lock);
 		misc_deregister(&isst_if_char_driver);
+		mutex_lock(&punit_misc_dev_lock);
 		isst_if_cpu_info_exit();
 	}
 	mutex_unlock(&punit_misc_dev_lock);
-- 
2.17.1

