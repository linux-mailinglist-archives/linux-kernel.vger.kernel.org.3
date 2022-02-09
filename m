Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C434B0150
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 00:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiBIXaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 18:30:15 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiBIXaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 18:30:12 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DFFE050BA5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 15:30:14 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219KHBjg013543;
        Wed, 9 Feb 2022 23:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=4PLb8pAjndy5eOo6mhSlKUbzzSLEonBrw8II+9coMt0=;
 b=I3PrZqX0vB4O3rPmYr37uZ72gBrGyDo13lRq1MYDi/O551jquys2DUDh0NbDGPlK4J7y
 kl6gaQ1ZleZ5bkEgwotw/IjaOtoq87JQ4E01s5hitco3iiyqZRZ+YwV5fTwPsQHBg8oP
 WKicgBWYpS3Tat1cRHMSDe3L6cYjhVI9/fJWjRLmYSiDqIZTHvlOUeR2iFl6AOOAq15V
 LjaUkpHhuEAkte4Hc5Oe5ldl43p3EoLY7ad8TrNlB3sxSddxDPFNijSoCcJvc1HTatek
 4h7S+ayz8AavJMQFaO1WCP7ZT8FVSR3ActsLHG7cYGa5rSVaDL0pQfXmkAvePtSsFbDX Ww== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e345sr1jw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 23:29:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 219NFrFU117827;
        Wed, 9 Feb 2022 23:29:52 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2170.outbound.protection.outlook.com [104.47.73.170])
        by userp3030.oracle.com with ESMTP id 3e1ec3m196-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 23:29:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUl2Kg8IpiXzov+tZzK70T4Gh5gq00fIVzyL58abj6QYaf0jNG6AqwhrDUhiT5sepirjAus/ThZ8LmTS7NpqZCVCzTRbiBNHIh/26KBV37IRLMjCJWnpxqivIh5zSALur8CtSNjhoBsvTZRy3kyt5Af/whGiXpAzowKLWqVeV+au8RocuzUmxv0T55f5YE5kebLWiKMzhCGt3StNRWh7nut+C5OUmoAovwcJ85qCp3HCtwrCKK1HggiBKHWvrJM5tLVS5Sjmf2AjAhmbkzzoJaR34qg+FRdYaKgUQ7xesjSovoGO4HYgpnGgmQ2ssHQ78IaLOmbQUpDLbpXIyGmMvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PLb8pAjndy5eOo6mhSlKUbzzSLEonBrw8II+9coMt0=;
 b=WjWoPxz8ziIQcTU14PM5daC7enKS+1HMdPunsxKqYsJ0rtCbU7wJS2forCmnHepduzXNFEY85sT6XmsoNxPqoMe4ys5btsT5LBw+lx9C8UzbEX0AhjQLiy28JYouu/K4am1jjge0CHdruPnwF0TpgRx5NkROELxNIseR/RkzCciA4NCz7eEP5H4n9bsF7sMXnPnkV75J34qnZbhHC4WGRKK81SUwbCGxNVAt1Qh1O/y8rDUeo4Ff5RrV6T5BXe0lsXwoBCszhYFlEUP94EW+9iJhvJKEGHkIDfsmZBF5oj2PvOmu84SemRvyxz3qImmBr+2Dtydkc9PKggJsDtlPIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PLb8pAjndy5eOo6mhSlKUbzzSLEonBrw8II+9coMt0=;
 b=DXNSFjruZtJutxOcELNvPIL9MQuhHzVJcLemOKwPTdil+qylksry6ajohrDrgABX8BcEXvnAewTz9V1BGxofHG4Gq/PiQqXD64MWRB/+ocm3NLCRiW3D13BpyXBSbM3QE9pQcvOmuwOyjP4znrirGO5fsMnPmILynN6RUrd4Kh0=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 SN6PR10MB3007.namprd10.prod.outlook.com (2603:10b6:805:d9::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.17; Wed, 9 Feb 2022 23:29:49 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3448:8685:9668:b4d5]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3448:8685:9668:b4d5%5]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 23:29:49 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     geert@linux-m68k.org, hdanton@sina.com, hch@infradead.org,
        stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: [PATCH V8 0/8] Use copy_process in vhost layer
Date:   Wed,  9 Feb 2022 17:29:31 -0600
Message-Id: <20220209232939.9169-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0043.namprd03.prod.outlook.com
 (2603:10b6:610:b3::18) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfd4c91f-2613-4b3d-b1e1-08d9ec24106b
X-MS-TrafficTypeDiagnostic: SN6PR10MB3007:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB3007A7C0B0E4E1DD79DF7DBFF12E9@SN6PR10MB3007.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qqae5E6a7/tEdmBX2YYqBtaPx+qO7Abcvg59sFl8dtOclHPixMkJy2PoTZag3mLc1C7+owtUFXz5lXUWC5ec/To/5w5zce6nJGez+ByR3miOd7yeUofx3SPSYVqhbfZqBShmGJfVbvNdRI5K7fRx64mxauWdtLhTcGhwU4hlUH7r6KtasNIHdTSRpabzdjTahuG9+dGvxgUDf2YZ+UknBPAJQ4WWzmDWvn6xhj1V1PgDLdmW0eEtFvrkRU72bjFWz7/40v+sLY3ZVxtXDjdZBUlDOxVdY6KE0WKh+1xSebg6LpjlyNTsu8vT5VsfxIkeopQbwAd6kzLrViJdp5Nf/zt6mIW6FWLq8ZUiTlvqiV2Uto3tgdEoGHMhpel9BdKXYFBju2gazDAfTiuqQa+egKzG5u/Isqd+fupryZ7nkzJBgmR0euo/sIu7WWFYGFyqgKXAi59jYjl7BpMvJkpzp7dbcw2SRXo8PDVdZeP83PqljqRqGoD5uoqqiWNw0T1vmAQUNTyRNW4aogfjI81GW5QuVHpQQtY726Cklikjgb0c9a9cpMKC/4FYtblWe5L5Sdpp9vqpZc/rMk+jtRbyKEefTC0dYAOYjbiNFgDHncc/S6bAUFLifuKZaZpaCtDZj77H6Xi0HopErrBKBZOugZHhH0ZHBuPZ7qX1sojQjXmFvLHU6riCxebjnDe1YhsZ9U1bcCRdiahClzIWj2yfnbYFI1A7vsNOhIOr2oxtgfxzh1mnIbMuVO66XG7e5I4N1PcE75oFRB6YoA4GgoUiMA8+TRVK6GlI3eQilk6aOfPC8odvurz1IG4i8q6ttVu3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(921005)(86362001)(966005)(508600001)(2616005)(1076003)(2906002)(36756003)(26005)(186003)(83380400001)(6486002)(6506007)(8936002)(52116002)(38350700002)(38100700002)(66476007)(66556008)(66946007)(8676002)(7416002)(6666004)(5660300002)(316002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iY2AbJ2LfoaDkaw7/7cJ2pm4rMQYRlpQThQtuaRnEumPVlwgUv0LzESt/gwC?=
 =?us-ascii?Q?ZdSXIDqDPTtA3SCyOn0vQ1cO41oAe0Wf1zPdkbi5z0t3ZNz4uFD/S7cSWTdC?=
 =?us-ascii?Q?Q0JkuIp5L/JR0YjTw79vExOyocw1Cq4GjtmFnxwLt9xrzMmxTJR+tsjHoD/G?=
 =?us-ascii?Q?xItP84dLj4t9NQo8ei3DOfuCMRm3oUzC9s0Ra1abSr9gBcm6NbGxSRVv/lxJ?=
 =?us-ascii?Q?oiGno1vtFzc0SvX2JI3ehkp/uTTIhePVwQG7UzNdm3fcd824rUJjfPIrHO6Y?=
 =?us-ascii?Q?oaOhUSOQ0vm8H72+7Mdcs7Y+6FlPwEyDsEWjqH/oRdFZzQClOSMbIknQ1mV4?=
 =?us-ascii?Q?dmY4EX+hW1x5VholSdqKc54cAl+/gG+gnPMtVzxSP6KzSBoANgmczNzYdZ53?=
 =?us-ascii?Q?q/k4K4rl8mqHN3w9BtDnbqoIHXV572uPnmP7uaQxCYkakeOKF7wxV8CzggTt?=
 =?us-ascii?Q?9q5IHOdoSEmBrS9W8OYBZ6scM8653FcMwwTiLIskJCsq4/DSRPmP0pfOJ0gy?=
 =?us-ascii?Q?+gHbn3+tWNcc3m0/J2+ztVLxVhmLtzPnXW2iYaeUzFbA7I8HVKy1X/sVlcDZ?=
 =?us-ascii?Q?tK/RklSdW/q7JPSLQYLzKoiQn3sf00I1V9vJO6BPlLKt6bVD3UkIjALRc+G7?=
 =?us-ascii?Q?UqDWu9rj5P/Gb0KdZVgDFS9R/LhyhOmYI2DaRFes9to2rRAwGkKoZoR46z+o?=
 =?us-ascii?Q?WEypGUiksD/pi3NNxtDyNa1U232EntkZ+vY7ScCI3QJ9bfqfwXBN91I58SZW?=
 =?us-ascii?Q?QZCIJtMhegEMfPm051Vy9MJ7YIXprFiUMM5IP8RQNT96i4HmdktTg6U0ZyHP?=
 =?us-ascii?Q?d/YYycUt65UcXvvH7w7dknxVsUD3Czu1HSg1zZfMMN9W0tFgKquxgWa06EkY?=
 =?us-ascii?Q?ki4u+fgcFHX0hBqFfHylYV0qbHW9DKx3WAhyYm3tZTwsE7tQDleIx5Umkam3?=
 =?us-ascii?Q?xzExTglL1fMDbIgtS0KvGUAfmuPkaj9mwW/sJo8a6QujxAyX44+k9OumViW5?=
 =?us-ascii?Q?ZTSTlST/ODSxRR+Jps+mfPObtnl0KltouYHfXlwPzrZUJTpcnK2tegHYtxXZ?=
 =?us-ascii?Q?J/NTO5dGhIsKhB8Yc/dN2pyHJaXlaKjAl8MCRd7AMjoHnRxb67A+XR2ZuHck?=
 =?us-ascii?Q?sD3V5tuDqxaCPXpT1v5R5jEMbI1YufxMI5QsSQBBHVknLQuHfP8u0/6v3eGE?=
 =?us-ascii?Q?GRNafazPRR0YaV51nIeosKC00VU3NYkRh0bAhCT/Ctlw/F36nHvlRRl2vqSf?=
 =?us-ascii?Q?KCtGo4JyNyEJz2snuM3ZGw829cX8F3VFFpEXn1KBCXlINet+zsqJPndQ61XA?=
 =?us-ascii?Q?PDqMFeQTKVywC1qxA668KLqSMKejSap5bxNoSjpOQ5XGhug1i0/I7BcfogJI?=
 =?us-ascii?Q?W1E56QEZHPjbOGbYL+tCQZoSEVunwqxsZSux6jnLbczjKawkcbQ8TgdGyRCW?=
 =?us-ascii?Q?GKHSBJraCIDVDfMtVZnbTgaDCM2Zk+UI4H4Pf8c/AFeX+D5a8o33QR5P8ew7?=
 =?us-ascii?Q?J97Y43H5rqX3u7fPHCg70sfCrQleG1WPT1dkdVMGPFGdh0ph/Bk7Hy32Bbtz?=
 =?us-ascii?Q?S+DmwcboYiLnoa7fWDvjQv01aNe6tqaCS3yyEfvFdbzWXdhWR/bkRYkruvDo?=
 =?us-ascii?Q?FxYJ8huiIcP2k+VZStCo9mIT2StpJq+bXkic21TnsCD92g0KWZ02RXpmMNV+?=
 =?us-ascii?Q?aORahw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd4c91f-2613-4b3d-b1e1-08d9ec24106b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 23:29:49.0450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3xKQIEBBdqAmsnl3R04ro+CsNJhL3vchFq9FnzwfSmzeYpSWhPmIfzX2SKxffLGy68xszTlBf4qU1WyxI3Hrc81h2gSnsfdOqnYw1FEtTF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3007
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=478 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090122
X-Proofpoint-GUID: cMJ_dgWGzELLzXzKhfk9AmTT9u33Ne0S
X-Proofpoint-ORIG-GUID: cMJ_dgWGzELLzXzKhfk9AmTT9u33Ne0S
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

V8:
- Fix kzalloc GFP use.
- Fix email subject version number.
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



