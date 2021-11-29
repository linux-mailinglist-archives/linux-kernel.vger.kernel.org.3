Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912C5462101
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 20:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379581AbhK2TxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 14:53:11 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:18444 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351267AbhK2TvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:51:00 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATJV3JD028124;
        Mon, 29 Nov 2021 19:47:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=xbO5O7K2w9jDtkzysYbzl3+6Bhc7/bBlcpCzJygg5wM=;
 b=O0G4vmIJkGPpupKWtWFhb3AHIKT0SSI0xeEbNtirUDOBo8l0B0DzqgyK93SzKuJUIlG5
 JQQ+s2sX4Ihu+oUSxk2U7/hJ3KfmlFd4qCj+8HCtg9mws6+WgjeiTWdDhCWjM6sTVv2v
 s1BB5jLPHkveMpIO9K9KwsVqjcEjTEh3ZX2J6Omqabef52XNub71TtA172R6NypfN0Pl
 bVqskW8KrhCeafcyrFqBAhiY3LMRRT3EKoVJMF0vUCSOe8SFHbbGvhZk+00AClyfeukX
 vReafULQa4lt2MyY560lIhOhv/SqIC3cPXi+EVYoBC3GbTNc3zRJmMGfsQ+fUwED87k7 WA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmu1wbqxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 19:47:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ATJjb8Y181733;
        Mon, 29 Nov 2021 19:47:18 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by aserp3030.oracle.com with ESMTP id 3ckaqdcbmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 19:47:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSwsU0UrA24k3s2X6C5xJEUrRu+pkzW1vpx7ytjoJJkhO6gr+voe0+AzCqVduim6SkbciCYS1LBetklfqwuztprAD3XweBo45tvlk+JkwDEpnsAhrdlJI6/EBw88A4Cr9GIft2FX9oD6J7tZ4svL+SSpZKsgCn9WuD3/1SgzfYqK5s3E2Hz88JlzhMBYTZoiEwWGF1A4ZP1MyHVU8UJ8swaAz+BrnxdR/I4f/T78d3079b+oDddFs65DcB2Axo5eknsLo0P8wvhJZC+cytO9TABCAw9C0KaN9u0nZUmB8O3OJU75VPgQTNC44a6LZc1yDBeonQvLSoh3qeLwfAyACQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbO5O7K2w9jDtkzysYbzl3+6Bhc7/bBlcpCzJygg5wM=;
 b=IlH/nXRhLmpImOyRQZ2WqKVrG4DOtYkDaCeOBgB9K/eRcWeeiMkJ9zD/okAqUJok3CC8hvgh9Iz6VBMgF9lJFvTFBU8FzmFJ1Wn5huS8v93fhbfyaqii9IFgq+CVQr5f4XFWvftsVNBpa9TPfGYD9X+UDd9yzDRtUxMvorP69TE+E+DnPYqkvZWvsO4AB6CNH5n7B21ah1sHYcRO6w92IF1maJ6FAo81Clal7rBf/aDnDHN8ZKGEoezeTOFh1R10wmewPIHVFocmz2uIOPPp+Bgds7fsPqBrtX/1yVJKIBE4WJ/XN2/Obos5M6L6NuTKfnIJ5zeRobzgaQjmd4PixA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbO5O7K2w9jDtkzysYbzl3+6Bhc7/bBlcpCzJygg5wM=;
 b=Zm1QUjxA5QpiihM+VpvBFCHYPbjkLhFVE1Eu8xjF5zAgoAo2ruatZtvQ4gn+VnZB+qM3XzSqNXnL4JEh90oa5CPSud/lrutpKDNplWRAlkBP1Au7df9gVBOJ2wxmHxXF352TPuK4oXVwLUN/1QprnbP3u2hDMgIhbu0QPm36cPU=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM5PR10MB1307.namprd10.prod.outlook.com (2603:10b6:3:e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.21; Mon, 29 Nov 2021 19:47:15 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4734.024; Mon, 29 Nov
 2021 19:47:15 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
        hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Subject: [PATCH V6 01/10] Use copy_process in vhost layer
Date:   Mon, 29 Nov 2021 13:46:57 -0600
Message-Id: <20211129194707.5863-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:610:cc::31) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by CH0PR03CA0086.namprd03.prod.outlook.com (2603:10b6:610:cc::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 19:47:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5de19a5a-0d3a-4315-593b-08d9b3710b7c
X-MS-TrafficTypeDiagnostic: DM5PR10MB1307:
X-Microsoft-Antispam-PRVS: <DM5PR10MB1307E438050D80742147DB0CF1669@DM5PR10MB1307.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hSWC1etEDuDWDf2xS3uCicTcaDwhX73IU//C/l+B8o0ATwpmYPK6omMjpgb1qWWVyxnkSCHLOPVoswgTu5xyV6mvHiQOnxo/9vbWefKt7K/da0tU+0YNQm6cm1WS6ndAwjiOPR2iFZNtTsd58lzdLhePt76fiKFwF3Bxn8R0x68zSuykAR8UWyWvrMQhlbxFiGD1keXBRDCdI1h1hHNVp2wfEzd8RDbD3ijY4qvHTxNhb3lkzdCSuSGnbKyZ6rZTtf6JtkfwmipHI2NC6yg3zRCKgqB3KD9ir8X81AodVNFh1bA7cEbIt2K/jnKbOSTIXBMZv8MmYHBCJ99T341z1hACI529Mw//bDNea97lDE4ujdsrWH5bm+KkUlKfJkkyKP9zCZfomVa86Jr9X3Y6+uSBhzMuJhxOtGZVueDO0eMIt9nzEx077Wuci7sc9KO2EnlzWR8c3M2mblHkGN+i47RjIvTCTZp2SJztiFG8Z90PYmrphvcwTMPUOzWnPUSKPem8HEzd7Z6l72T8vlREOWTTzQzwiJJ0XqbZGnYLBC3WkID1ChD0IDquXvbvuduo65w4sIVe1HjJnN5HmuP2nPwgz6WbPlDPi3MP6430b9VD7ugWeu6w4PW1GZkhkDCMmeV3fCEwB19BSHawqCmmEi/BcZOB5pBAdMHiqfJrNc2XfC8/nCeyTFwevU8efxA/nQTNdGHW+lUMYVed/DXfrpJ1heNteYsPPOO3B0/9gxlgNEHYmnIXO/TlbyOCARubhZCcoA6RQfJszCIA2mF/ZDph0Y4m/pmr+JUNOSohcuDs8AinFOyUvSEgmHuv1KU7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(36756003)(8936002)(8676002)(38350700002)(86362001)(6512007)(2906002)(966005)(956004)(52116002)(1076003)(26005)(66556008)(66476007)(186003)(508600001)(5660300002)(921005)(6666004)(2616005)(6486002)(66946007)(38100700002)(316002)(83380400001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u5MlMfXlo6NsbwyKAfQpMuGeqlCeBGtoi6AKJgtZFUwL7sHKp0PNrGYQG+GR?=
 =?us-ascii?Q?ZwUVmRKJtusLhzsnNMEmYHLXbC6knFQyTdM1nhk2pTDiicEq3Gx4y3hEksxw?=
 =?us-ascii?Q?cbgLXnXyyOu1XD44lKbcHjqaueslBnFziZ88c3I/FE8oHn6y+vStIzvmhBBh?=
 =?us-ascii?Q?TYF+uVJh69gKVqfdI2WzkSIxEpFUNA+yYGZBxIk8QDYg723NvhBSbLzT7J8K?=
 =?us-ascii?Q?IKbjEo2kepXL25x3+iidTdB8/Dz38y+WPahHnSnWQDSzFyM2nslOAtJ9WBK6?=
 =?us-ascii?Q?/mL8a6AJFIu7CRthT4YQc90GRCfPEvc8WVQDwTvdaQTashqh1aH0yXmSgZp8?=
 =?us-ascii?Q?fS0o2z93+6PxwiE71P0ouevZWYMDLLQTnHtCRSTw1y9bAhudqo/H6nKSejBI?=
 =?us-ascii?Q?7+2zQxHvB9cT5IPTnOVhC/TwST28ubl2YhT/MAFE0J+3r9TJLKISihOxOYcB?=
 =?us-ascii?Q?bz1ULB+dsQotAGN/o1iJ0/cCa+j92V7RAVu/hHpV7DnyR2M35SNx6H7R8APe?=
 =?us-ascii?Q?LmJKpqkKoC8y8euw0wwjMNY8Nz7f2kR+SCsLDj6vZn5unifR5MN/ns12QheU?=
 =?us-ascii?Q?QjiXJBmzCQk/qCIdSIgb4aWB7xvobBgNursRz+FoIiX2kISbdozbM/RkAv1p?=
 =?us-ascii?Q?gWz3rQGVRqqMmVNTgQM2jrHYB96OtY5G0TkA6PfFCw0drzMEnl1McwGd3+HL?=
 =?us-ascii?Q?q4RIOKWZPwqDkXiE9WTzicT87PyAulipBCidepobAECAJcasGQqXziRJYoGn?=
 =?us-ascii?Q?YqVbq8Rx7Yn9xBovSuOQ+5RTze8LrM1adtVGgXCQmLADmi3uaOwCxHorsLUf?=
 =?us-ascii?Q?3HWr2suyeLq3uj8JnRj/KTU1Rs+ttWaa//hZO8gSPipcKExnsZ78T/xjtlI1?=
 =?us-ascii?Q?r3vxU19J53oUnAgd6/HCzlCy9KAX3hlcJXRHmV//EZ3KWvQFnfl716nWh8K7?=
 =?us-ascii?Q?Ei/qtfiIjQMlHwagThewrIk6Fhv8cz11qtIMApbkAUN5kbtU8XQLXb9EKyt3?=
 =?us-ascii?Q?COzeA/x5iliHg/f8NkyXxT20RgqzNaTSyskkJLwhSq7bCKWw5HvskC0uVVeE?=
 =?us-ascii?Q?JgqW1oDLtImC7BSFzhSIsh8NSKKLzavYL1eTEhnMS2eW+SSbb3YzmNRWfVW1?=
 =?us-ascii?Q?loNB7yFkiaTG4KoWBgK4s1BBM/rvI+Dw8CWlOo0qvUFS/65AmiELmdxqaBVB?=
 =?us-ascii?Q?aqYkA2sSsXfV9xTuU9wbT/w6Yen/GyUK/g9la7YRjBTqV7mJK+cLDgqU+24U?=
 =?us-ascii?Q?OCiEomPXADm8wC8rgpDkoxVvzCA51vFRPmFmjxuWOKAR6UIRFn1FFcdLpPp6?=
 =?us-ascii?Q?MSWbE1hFzg6wdxXJphOomSDOQaIYLYPozcbw8dAkoXlnxDB7dqPu8E1MtTaA?=
 =?us-ascii?Q?9CS4SZA46i7PPsIkda94uOv691vkWeDVh/6j+BMuSQSuuAXGynU++XmTpEYI?=
 =?us-ascii?Q?0JkK7cOS8Qkg7Q/teWXsYt6FS991GeO5v8KMogxO4KKXRoyYl1MjNLHE6Hi+?=
 =?us-ascii?Q?Gyd6d14NFmvI9ujLlsLG/AiDcjln1QSG3HzPtmluL3PJqXRjd9cgX+YMDRfg?=
 =?us-ascii?Q?0+7QQRakDEqf0+wvc3K06pWLDl0TtFphqyTN4HCUCLIuUwTa1O2Db3HvZRqi?=
 =?us-ascii?Q?wiwrbJVb2TyHE1hxEygeSs7V3OpjIx5VEFj/8ILDohSxSgzXW0wMigqVgUkB?=
 =?us-ascii?Q?9QZaOw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de19a5a-0d3a-4315-593b-08d9b3710b7c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 19:47:15.7129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XHHVjJgPqlYLnfTDsm/r3BOqAnQO2NeELKf/VGAuh4rkuwvWrOCJ+46M0whGfDK/VzsQab3Hj6h3n2kqIVPrQgcjy/cEG82ih6Lk7ZHOGEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1307
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=451 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111290092
X-Proofpoint-GUID: 1XGa1tx18e0OVTsjgQ4BIzICCCIS7EoP
X-Proofpoint-ORIG-GUID: 1XGa1tx18e0OVTsjgQ4BIzICCCIS7EoP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches made over Linus's tree, allow the vhost layer to do
a copy_process on the thread that does the VHOST_SET_OWNER ioctl like how
io_uring does a copy_process against its userspace app. This allows the
vhost layer's worker threads to inherit cgroups, namespaces, address
space, etc and this worker thread will also be accounted for against that
owner/parent process's RLIMIT_NPROC limit.

If you are not familiar with qemu and vhost here is more detailed
problem description:

Qemu will create vhost devices in the kernel which perform network, SCSI,
etc IO and management operations from worker threads created by the
kthread API. Because the kthread API does a copy_process on the kthreadd
thread, the vhost layer has to use kthread_use_mm to access the Qemu
thread's memory and cgroup_attach_task_all to add itself to the Qemu
thread's cgroups.

The problem with this approach is that we then have to add new functions/
args/functionality for every thing we want to inherit. I started doing
that here:

https://lkml.org/lkml/2021/6/23/1233

for the RLIMIT_NPROC check, but it seems it might be easier to just
inherit everything from the beginning, becuase I'd need to do something
like that patch several times.

V6:
- Rename kernel_worker to user_worker and fix prefixes.
- Add better patch descriptions.
V5:
- Handle kbuild errors by building patchset against current kernel that
  has all deps merged. Also add patch to remove create_io_thread code as
  it's not used anymore.
- Rebase patchset against current kernel and handle a new vm PF_IO_WORKER
  case added in 5.16-rc1.
- Add PF_USER_WORKER flag so we can check it later after the initial
  thread creation for the wake up, vm and singal cses.
- Added patch to auto reap the worker thread.
V4:
- Drop NO_SIG patch and replaced with Christian's SIG_IGN patch.
- Merged Christian's kernel_worker_flags_valid helpers into patch 5 that
  added the new kernel worker functions.
- Fixed extra "i" issue.
- Added PF_USER_WORKER flag and added check that kernel_worker_start users
  had that flag set. Also dropped patches that passed worker flags to
  copy_thread and replaced with PF_USER_WORKER check.
V3:
- Add parentheses in p->flag and work_flags check in copy_thread.
- Fix check in arm/arm64 which was doing the reverse of other archs
  where it did likely(!flags) instead of unlikely(flags).
V2:
- Rename kernel_copy_process to kernel_worker.
- Instead of exporting functions, make kernel_worker() a proper
  function/API that does common work for the caller.
- Instead of adding new fields to kernel_clone_args for each option
  make it flag based similar to CLONE_*.
- Drop unused completion struct in vhost.
- Fix compile warnings by merging vhost cgroup cleanup patch and
  vhost conversion patch.
~                              


