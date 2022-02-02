Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9EC4A79F2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 22:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347368AbiBBVCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 16:02:40 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:30678 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347354AbiBBVCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:02:39 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212KwhBI023474;
        Wed, 2 Feb 2022 21:02:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=tjQ+cUq/Es1EXERZ2yjKelNsYg8yUkoeYIygEgWH5OA=;
 b=gBayqc8P+gb4sN0e6hFJARRkcVE3qaCla9RYJNAxHMfHuLxtK9/2eE07nlWUMgMj75MB
 /K5QTGuIj68isK+jbNIxSo0ykyDE9uIoiE3nle8rnh3gxEcOAYUXptXy8pRB6B58y4ck
 eCkXKKg9dO+EuhW347obSfu8aIe6R+1Eaq6ZBfS/s8o0SfdOmYL2LDSyWT8VMlOxd8se
 uRSmD5DgrH93Gzj+SjuCV5/iN7fCCmbNVJIcazp1vEcoMm6NQal9t3nh3DyINZKTA/Tu
 AnOfNQlhK4AxtSlf1TRTcpNdk374SkxlYnucZLkAiKqNUu1oJCqQGLCP9Z+qozEyQ/bz Ag== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxnk2pxcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 21:02:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 212L1SZq079411;
        Wed, 2 Feb 2022 21:02:12 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by userp3030.oracle.com with ESMTP id 3dvtq3h0e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 21:02:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmhFm/QAQPhh4Ld8E2BqRtClysbnlw8DvnFGPk0MCZc6cydEm4JF8hdsbxehsw3vVK5uCI+/2XGnKywDUc3sTPMIDoFrGxXKxNidL/nQnFyQhkTu9OkIlQ6txRIcT5OJchEtzkuZWIoMxLMsWSFq1ct2hgfDjY2D/CYLamRzUMtaIFV42EjlLIKoZ1hcNSgj15UIogToyUypNU6bgOmZcGdsBQCm6B5xcqd1osd3ZRcvvXFyZ/1BFiazhoKigvHkjf0OgVAOcm6d8eBM6m2hjKVKAR7a2LNe2GGxx1LYRuMKZUiGB5sPpDglS5Iirpsi6d9m39nPksTDyceRXLP1/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjQ+cUq/Es1EXERZ2yjKelNsYg8yUkoeYIygEgWH5OA=;
 b=dxK1q/lTcuT4a+/iHAN2xfFlSTEQqIwYoMTmgnpyOhrCB4J/hsi/EX3p1Eoez1wrosz8J4qtmasIiD68deqOs6Xn9u8AbQ7cYxkcIuD+KhoQOCZH+Pjo8nll+Ac/0L1hCtLxzO2rUT7y6h3oVh4+HT2/LZSktN5lr9jFV7Z1/5uaSUTfvATs0QfmBaH2BFe+IjJEUZsY2EJh9edxfFkCTPPBQng2ehpVJu/D0+ZjC5dl5lNVaAr7td0i3JDhqyks8dmzgNH0F7KysfaPPhrKgx0fz+U1YXqocx3L6fEGilgXJGK6NX0JhlODnWMqQNGZGRVC0ECp9ozd84dgSuxb1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjQ+cUq/Es1EXERZ2yjKelNsYg8yUkoeYIygEgWH5OA=;
 b=P2rdo3L/cKbE8fsKmOW2WWowtdW43jWXfniI3o3M2FNtpLzkgdzY4MkITwmoNrkWWLvX92BpjJqu7aUw7VdbNclktlWFeycyXuLp/kakTUwEwK2aake58GQlecdOoVamxKfPRFBOIY5qk3Xqi5GRQbLWjbRrEdu78wN4dmOk2CM=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 MN2PR10MB4014.namprd10.prod.outlook.com (2603:10b6:208:182::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Wed, 2 Feb
 2022 21:02:09 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::21b5:910:b965:9e6c]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::21b5:910:b965:9e6c%6]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 21:02:09 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     geert@linux-m68k.org, hdanton@sina.com, hch@infradead.org,
        stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] Use copy_process in vhost layer
Date:   Wed,  2 Feb 2022 15:01:52 -0600
Message-Id: <20220202210200.5235-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR05CA0067.namprd05.prod.outlook.com
 (2603:10b6:8:57::12) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c0baa37-3dd7-41a9-fad2-08d9e68f46a7
X-MS-TrafficTypeDiagnostic: MN2PR10MB4014:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB40143DB668F0CEC8A7F3BD1CF1279@MN2PR10MB4014.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q1vuXCjsRHKQuQ4+qRIaHcCMUlCsEQ7AJeLUsWev0+cocPf4Yj12aiHlDUFPbI3WepaLgatV37/1rEKRJV6TfkCWFg6O9sTgGbgvYcqaef3Cy+u14W3ZogqFRHkdQlAapnI8Wzx8ECc5ANkSO5NFl7C5MOU5z6drzAvD5ujg6XvhfK4wOOn5ThU6kqF1ajfB0+gRcajtEv76OU4dIdymr2Bu6PczGTZA9lEaD1cLLWz+GTTenxoowfA7wCxnZk1eYIzhSn9gMcSxsbSF0f2NxwEPQxuO6wioQszz5CnAzaPKbKxex2R4BK8HqbBqAT2IPDTcv5z4HWegs6g2sjQTB7VsvL1rE8UCwHDLmyzTpGj7pGaBXC64YpHpGpeq9Ofn7PxVJUWPEvVE0H+XwaThxtQkHw0qEFjwmHatStB7+5v3fAqGotUJQLQ7I6ZhUcB1rk1BQl+CYToPAok37qPnuQRpo0VxYGGorAjBCg1IpRl7FHG/aToNjJUu7gcODsrdccRrytRztwN5CizRYrz0oryeaU9eC/Ho8xaGZ+vh1baU+C7y7qWweKcndWZs9V8bquP8CRj3sUlCXfrj5kmu4YfaWTpJKr94IUIpMbgvyV952eq08RTVGzcadK/I+GlsthppAOCbOTyuOaWCdqq8ML+3TGDDFcAKAW1/WJ2ITh1FPOcEd56scAOfDhATsS0jNRqYI5oZrhwyuAyp0Nc0In+j1tNjEJB0f06AjJfbP+Bfa4vxKr+KtkXoC8OO8wo9k+gU3BGlv7Fu6gqAfMnKzVqkMp5aGbQMN0kWQyYvvaM4BANbLFeLOSfDfQ5BpuyZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(6666004)(2906002)(316002)(38100700002)(1076003)(38350700002)(5660300002)(186003)(26005)(2616005)(66556008)(66476007)(7416002)(6506007)(66946007)(8676002)(52116002)(921005)(6486002)(8936002)(508600001)(6512007)(36756003)(86362001)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?59WJB9/+jssyzwTO1oB1PqN+vxpm9J7mFu7aEd3XHgldF2AhJ/b2P0R6wxKg?=
 =?us-ascii?Q?crnbhFCwi3ilKOD84/qFr4pVNzeJecyg9HHoVXr02zo8Z5liYolZ0b78WHQ5?=
 =?us-ascii?Q?tLtA+vy+E3Sg0kMtuEjcTsvkP/2NqTqZrYuhwvr5i3MP8HoTdNn4e3Kdji0h?=
 =?us-ascii?Q?Cq6xzSQcUm0dezf7tzWwUO/HhokfwwiS9oA46K8tK5ygAPLtVnpeOjwSZhuS?=
 =?us-ascii?Q?0xsuw2CW9eJue1KO8D9MCT2zdhXjx1ULYehUXIZwNO42GeR7DCKa38FL8Rp5?=
 =?us-ascii?Q?zdribi0Y7pS4ZhnycONznkNZFtDjODAcpQWtTLjM/EDmwaNtJ70K4YjdK/md?=
 =?us-ascii?Q?FmcLh8ZPUYoSLIbG+NwlahFsBqGZz3kvAEdT2MjedSTgSQ57W6bu5UVvBv+r?=
 =?us-ascii?Q?Uf8OEnvEDJpQsqu9LZn9tAaN8cZxS37LIuwajREj5oOGzzyG0notoSWv4f9f?=
 =?us-ascii?Q?pSpSLnfS1oHO9wCe2kcUiUXz40CwYVpVKwBQn2tHWr5P7SvFW5vDS8Qk1YWy?=
 =?us-ascii?Q?kEzW6BKyLIjlrDyL4/dieL1CKO5KxBGpRm0fIZzuhRq4uTffKmAfN3/5KK+v?=
 =?us-ascii?Q?0SIGDpU834e9HRmxAwQzrem3X27XF0/cVJnOkUGmEzQIxZQtivoht7gZk7Jb?=
 =?us-ascii?Q?wXt/HHdeyG1eEe6+MynDWkiYWSRYgk67kYjVrEM9kn0RDg9OQh5id4Psir30?=
 =?us-ascii?Q?oM47sHRLskES1sq5n4BGBjfHZh7/3peZE/tZtQVrxwc+SjMh82L5ZFz/R7zj?=
 =?us-ascii?Q?HiyHsmyfBgxie+pK/ou2p8aJ7wdgcmVbhlF7rUhPfUIcqJx1w2kC7Px7ZIhA?=
 =?us-ascii?Q?6lTUlHzNEdNy6h/o5S643U0ILz2bWU3ObyeuwYzo1BwIjddaPN5JWvoLl8Uh?=
 =?us-ascii?Q?P7GwKaEvp1e4iD5GDAfAeGG2WylkppSl55kmQuSxz2OSJrUEZ8FQEZ7XiBZE?=
 =?us-ascii?Q?8bF92EKnZi7mONgZbw2tVfDbD13gEU2hA8ZUefAuoR4KnEIYtzcv+l2KNA/1?=
 =?us-ascii?Q?YPhGrUba4lzObOrFdnuaQmaAQQifSxy7x0XuaUubjoj1nm8Z7wv0XEyHPDyc?=
 =?us-ascii?Q?VYgh2WqAii+hE/mgU5QnfVE7ie5VJV1H/u+RwadGCIq9K0EpwXxH5oyV07EQ?=
 =?us-ascii?Q?1kVwIEoC4Oggndc4mO7ybrxJu1Fln/lhjIQV5O48+IqGkGtByLOzAkdr0rjD?=
 =?us-ascii?Q?ZtPZoD9gR+Ev3XwgqtTEgFiFlYvl4u5DgD+cAcFZ6uLF1M3kpmIep2or+mEB?=
 =?us-ascii?Q?ZA1FJJ5NJFXMKmAPLTwjkK8FYZtMtnE2HGbT+rphoJ8/HCd4NBel//NZgfXi?=
 =?us-ascii?Q?cBOkROOJsg3MANuYEmemvDYN7v13GapaiwnPioZrWX9EEikeueM/SriU+ocO?=
 =?us-ascii?Q?RotPLjEW+iMNLw7bn4HS0CCVEzaa6A/VBh1pH30Dq5/CVF34VGdpmDYaw91h?=
 =?us-ascii?Q?+zis1XES3H7HwvS9+lFcqs4X3QyAORgojG+dHRyO9eaIbpbKJU3z0QSN+VQl?=
 =?us-ascii?Q?vT+UGSM0byrcwrXJkKbtItYVu5X3FVm9CkMTJ2QsqilBr9kRFfFq33BqjxF4?=
 =?us-ascii?Q?FqXpyRwMXkRrEqlU59TiionNnKVq1CA22KtVgS4A0syOXxtpvszBXJnvp75X?=
 =?us-ascii?Q?7SWLVGr7vBJdsKv0QKlpkKJt/iLzY2OfZuP9wETsyv5C72GyfkVr73tKx8Ox?=
 =?us-ascii?Q?HtZ1gA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0baa37-3dd7-41a9-fad2-08d9e68f46a7
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 21:02:09.1480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VK3NKc8ubpT2YXDhPVtt9PxBstnv1q12UWH26j6iRTcXoZFcYYJBe/Lo6DP5qCmTtXgoENW6ocfCxJz42gC7h2nseaLdZ+4GHhZAJN7pQxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4014
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=426
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020115
X-Proofpoint-GUID: M_5WQglbm2MUhlkR2eZ4fj0x1wbUq-8C
X-Proofpoint-ORIG-GUID: M_5WQglbm2MUhlkR2eZ4fj0x1wbUq-8C
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

V7:
- Drop generic user_worker_* helpers and replace with vhost_task specific
  ones.
- Drop autoreap patch. Use kernel_wait4 instead.
- Fix issue where vhost.ko could be removed while the worker function is
  still running.
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



