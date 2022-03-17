Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0B44DC018
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 08:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiCQH2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 03:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiCQH1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:27:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6942FE1266
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 00:26:33 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22H3UMa1018260;
        Thu, 17 Mar 2022 07:26:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=07fU4qskkBYuVEjz59GqmXycsKhLGQVOuQSBxFXTGzo=;
 b=Vj/bnXgxFOXD8oz1FtFWj5+dTlAphHXS2F0EIDzKlTfBoAGKyA2CBjQVyYuzbl659fPR
 Iue9omRJp33bxMO8H50tIuYzLlcRUDLVA+EBjB+1T2GnK5jR37EeLPhwYYV9JP8dam1u
 LedYVjEA4uX1JcO9uPcNJLs5kBdWyjZEpYwYjA5/nYXo6VNpa7aAIVFb4BD/MPkYOIYq
 17Mdgn852KXS6z4oh3VoI6NCGh9Gw+V6IY/FW6lAJL/0+VIW5MGsw6YMHuDzL7hUeEoP
 Xi2hJPBYY1vQdJAhso3Z2sWLnCxETrl5vzR+afuwNUguqDp4tMMDEoMLe6t4RSshjLqm cA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et60rrdkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 07:26:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22H7AuHS137978;
        Thu, 17 Mar 2022 07:26:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by userp3020.oracle.com with ESMTP id 3et659b1q4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 07:26:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgsjmvgLnVAPH4W9eWd/rOkbM2IrOYCC+3OxaIIVmquL0rMuOZDuynNnat2E8hYUUhHhMlArTb0ZUtlo4VFxuGoEan9Kkl3JmY1lxV8BQ3d3xeV/z7iCKksV7Xv58uKT6/ZgKXr4jCM/eIZ6TQQNfazLB6JvVIujYzSbL+a03qq5pM1JOfl6Sw5kwknJCmuu5JEDhmkWKaRExnpnmZjMhR3fRGr6y7TGLV+DAEAj/p32id2koK7Y4/5gQEJsPDi/469rn3T0ZXNa5r3mmQsPwGEW8iTNeJ2br8SCVE1TwRPX4BN86W0ESVRlwEju4wserrB0V8YUvP0QLZInCP1eug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07fU4qskkBYuVEjz59GqmXycsKhLGQVOuQSBxFXTGzo=;
 b=F/IjXCxswkwgBAjHHCHS6m34ATSFsLXfqfvv6ICK3ggct6HC0DCPjW53umZcQiWtMEhHZNVkowa1kev3KDlc1GiSLU0TGLgQSDfRNw2S9apFi6QYdyYA3mbMW0UMUhK+c0eB1gkTpfJLMmowMOOrQf5TeIthFVIG9ma0x4jRkySuj9VBbcbO0ZkFdjv3Cqa0ebZvu8MDeio0nVZ9XjX1LYWanSMRA3pn/IYMm5Rgm1DYApTifNsxY3zA0z67bVWLSYyVL8Z9JvCw5PdwwPc3bXCMq+AA2k9rBmCn7FhI3wS4tG98Hrt8W7neWOzqhdx9NQC9xNk4FBJVCwW7EpFQAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07fU4qskkBYuVEjz59GqmXycsKhLGQVOuQSBxFXTGzo=;
 b=uwEe4F6bMOVYwwdUQkA1j43E8uIbvOPaa0K2GmpzbONUzSigop6pz6Gy/Yen794+q8XbWwgJKB9jFWaaZ53tcI0U4alrPZUS+N0hrMrLopSWJrroAWTObBzl8NAN1GGz0atv1HwIrS6apZR2iBbcE9WfR9o2X8LJ1D9uwWcLn60=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by DM6PR10MB4332.namprd10.prod.outlook.com (2603:10b6:5:220::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 07:26:24 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 07:26:24 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v7 0/8] kernfs: Introduce interface to access global kernfs_open_file_mutex.
Date:   Thu, 17 Mar 2022 18:26:04 +1100
Message-Id: <20220317072612.163143-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0035.ausprd01.prod.outlook.com
 (2603:10c6:10:eb::22) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0dffb8ad-d800-48f3-4382-08da07e770ff
X-MS-TrafficTypeDiagnostic: DM6PR10MB4332:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB43320A672CC152A8CB4DAF48B0129@DM6PR10MB4332.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XiIYyNT1EeiAYZVadxqga1nJoSCycBPdOi/FeLCodsC8FNQaWGjNWWkZAMXYXFM5yHQhEnwxhhfIRIA02RfYTYaToaMYhmyeJuajVjn05cgntCwrM4a6Mw5idvAJWF5vdmFTHXJaYBkQFr4d1A60aGz+ukmr/XN98RKu8VcdTyDb2f9kR5rFyuIRM/fvxDmb+/wDWu8Zm5slA/yYIC7jcFKQ4lC/C76oi4puGlOMuo7btmsfg+ucbsPH6vTLQ02HwPAHlC02gRegBq8SpNCIhees0/5dQDhr56pCvtPqmn6ZKqPyDfdXTHArGtSyo95bzyI9HXaJx8XSbgXih2QheoCVbL/yy+gL7U6V2TFFLc3fDvW/q69iHJgJUnAQzA6blueMJTIqWfFNWzUA1Xufz/4zHYxPpk/ObOf+D45FaXDk/qKDDgB7QV/KS2hsRukIPOKkORjPCozCaTMQKPbxfFUJvHP+EnNAqrwKpdE+MbGlwO/N+PuWGceTIO4MfctfCWX/yyPG6zzoLG2hY2kDKmGXsu9GY01aa/nDJuQEHlC2GWv3LzFkETopJ5uF3OPTToNvqiWsKC5yQFFfWyn3yH1d4okK8T2Gj70pXjFsH6Ej+Z+4VmX4e4dEg0weWimGS3IYeOWa3ntXgJlD/zsFpa+4SPHxZ1SpgKBT8TeB1g0j6eTNfvmbu0SRgXw9arCnno7e6rr7e91W24DCn2X7mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(2906002)(8936002)(26005)(52116002)(36756003)(38100700002)(316002)(186003)(38350700002)(103116003)(6506007)(86362001)(6666004)(83380400001)(1076003)(5660300002)(4326008)(66946007)(6486002)(8676002)(66556008)(66476007)(508600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6k4JQrAB9zxuByQ5l9NUjNWHgllZXphaD7fr4i1IAbOMxjCy/3GZkw7CuIZQ?=
 =?us-ascii?Q?qzOyunIOYWo/lvdffS/H9XN91WBDKq2OQcyVVy88ZqAQIdCQ/itUNzmR6ofp?=
 =?us-ascii?Q?ZINaMSL66Bz5NQ4d7+CE6DoOk8rFfraytZ3FoReZYzZ24ruuFdM/ok2fHh4S?=
 =?us-ascii?Q?T+j+FyF0t9BoOTEQC7xZFUGiS0LB3unuJg0TYV0s6nh7S8TRNVaWyqzluXvw?=
 =?us-ascii?Q?XXG8AxnusblIhSq2rmGy3sOfSf6HX8W2IZvefpDj+VaCKJs6g+DQMPzVWVoj?=
 =?us-ascii?Q?R94iFB2Qdu/6nB7Lwur7qVNlE0wA4d1pBcn3KCdm6fI9nYnsn2TouqUY0TdJ?=
 =?us-ascii?Q?wNPM3uJk1nBWjVrr/VrFA7XygGCDQO9P0P34GfJT60HQDKdS5tiixiREMkiV?=
 =?us-ascii?Q?qQmG0OYDKuYGoXKP+XjK/KTOZ2xw6HWkTCXwc0UGdwZ7FxS79nIQBCEHIFip?=
 =?us-ascii?Q?xhAZEztJTythbeCl9Kns/HrNqeCcC5EGjqY34T5HEidusJANoRzIBDH1SKFa?=
 =?us-ascii?Q?ER0LhgzXvhMPIhVpkk+h1enrMYTbxqL2IVHjpaOxoUVLxCPRTaXZWSk5wnsV?=
 =?us-ascii?Q?9vXqYVhnhxC9d2/iwpLQ+E4LEnVtYJRyTqSq8RUQNXIHlcNJR2ybdQ9ulZ81?=
 =?us-ascii?Q?8CXM+0LVuVIYht0kdTHyF7zIqzaMGQ9TtAkldvDedASRiV0/KDo72D06sg1m?=
 =?us-ascii?Q?Nw51oym68xv7mQfeGPn01RSm1irLJky8GX/aHV4/DcxMCGcTjYjhRjx2QmWm?=
 =?us-ascii?Q?tYWPyZBaX15i5OZVm2Ge2OSmcO2Fezlat+VAZlW/w0wquofcyGXW4gYk2oS+?=
 =?us-ascii?Q?NQRgmA8SVoiJ9J6YO12fqT63XbX+gCr2gRYj5bQPF8N9Np+tGJJ2Hit8G1g1?=
 =?us-ascii?Q?rhM9HMlpIGjxLrXMTNty7HNCi2mmJ6A4gjOWa5urO78SEdXdSP/FpizEKtwN?=
 =?us-ascii?Q?ptMnlGy/zYVmsHPejfIpE4llFe8rOdfcZ7q2Fb5QutiVbxeHSYPlUEm7nm1L?=
 =?us-ascii?Q?P0IhMwb5MtU7j2+sqksFrC2IAz6FeyWLnpCkK5VdkBMEzSC5UcFe2oWTpcjE?=
 =?us-ascii?Q?6rU8M+zCifURsjUxZE+yamTtcZ3a/PFZABoS4paoaMWutAZM7bTUk6DNGEI0?=
 =?us-ascii?Q?az/7sHdCd/CRG5x1yd2zOsFNnBZj2J4tDtOuqZaUo6Mk+iJinKEovNstt/Hk?=
 =?us-ascii?Q?kFhw/ALuQx3JHQiOWopl5va2XGk19WrzbcdHW9vgqZMTEAUF1pQNixqFNVgf?=
 =?us-ascii?Q?fDyNXf61ST3vPaC38uFlW502uGV8nCjIF+czYSUSEmxvXBP9984mYP8ZnykT?=
 =?us-ascii?Q?YEPb1tibd7q83PSdaICRmApqnOuueo25r4kEli+tXhn801mMZIYZvKiO5NDJ?=
 =?us-ascii?Q?0yHB8ZaRGAIwqh8LRfvfhJaaHRSrT16ouL810hOt+inx4nNv0doLsh6/5E1L?=
 =?us-ascii?Q?nn8f9ssMBXUvk0+vqvzx5fiMnM/NnMrn+Nr49Zfi6akgUvmW+zu/tg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dffb8ad-d800-48f3-4382-08da07e770ff
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 07:26:24.4244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xpvbt/xBtDYGosEAM7PZIMFXguhEX9uRvZ3p8LAlqlu4wotFzIr7HBzMTtxGnhKi1Qd7W3V3xTWEQ5oe98aMSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4332
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10288 signatures=693715
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=996
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203170042
X-Proofpoint-ORIG-GUID: XsVEBQR8NJS7fHMiwnzxtFgm9dPeTYLV
X-Proofpoint-GUID: XsVEBQR8NJS7fHMiwnzxtFgm9dPeTYLV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce contention around global locks used in kernfs.

The current kernfs design makes use of 3 global locks to synchronize
various operations. There are a few other global locks as well but
they are used for specific cases and hence don't cause severe contention.

The above mentioned 3 main global locks used in kernfs are:

1. A global mutex, kernfs_open_file_mutex, to protect the list of
kernfs_open_file instances correspondng to a sysfs attribute.

2. A global spinlock, kernfs_open_node_lock, to protect
kernfs_node->attr.open which points to kernfs_open_node instance
corresponding to a kernfs_node.

3. A global per-fs rw semaphore, root->kernfs_rwsem, to synchronize most
of the other operations like adding, removing, renaming etc. of a file
or directory.

Since these locks are global, they can cause contention when multiple
(for example few hundred) applications try to access sysfs (or other kernfs
based file system) files in parallel, even if the applications are
accessing different and unrelated files.

For example on a system with 384 cores, if I run 200 instances of an
application which is mostly executing the following loop:

  for (int loop = 0; loop <100 ; loop++)
  {
    for (int port_num = 1; port_num < 2; port_num++)
    {
      for (int gid_index = 0; gid_index < 254; gid_index++ )
      {
        char ret_buf[64], ret_buf_lo[64];
        char gid_file_path[1024];

        int      ret_len;
        int      ret_fd;
        ssize_t  ret_rd;

        ub4  i, saved_errno;

        memset(ret_buf, 0, sizeof(ret_buf));
        memset(gid_file_path, 0, sizeof(gid_file_path));

        ret_len = snprintf(gid_file_path, sizeof(gid_file_path),
                           "/sys/class/infiniband/%s/ports/%d/gids/%d",
                           dev_name,
                           port_num,
                           gid_index);

        ret_fd = open(gid_file_path, O_RDONLY | O_CLOEXEC);
        if (ret_fd < 0)
        {
          printf("Failed to open %s\n", gid_file_path);
          continue;
        }

        /* Read the GID */
        ret_rd = read(ret_fd, ret_buf, 40);

        if (ret_rd == -1)
        {
          printf("Failed to read from file %s, errno: %u\n",
                 gid_file_path, saved_errno);

          continue;
        }

        close(ret_fd);
      }
    }

I can see contention around above mentioned locks as follows:

-   54.07%    53.60%  showgids         [kernel.kallsyms]       [k] osq_lock
   - 53.60% __libc_start_main
      - 32.29% __GI___libc_open
           entry_SYSCALL_64_after_hwframe
           do_syscall_64
           sys_open
           do_sys_open
           do_filp_open
           path_openat
           vfs_open
           do_dentry_open
           kernfs_fop_open
           mutex_lock
         - __mutex_lock_slowpath
            - 32.23% __mutex_lock.isra.5
                 osq_lock
      - 21.31% __GI___libc_close
           entry_SYSCALL_64_after_hwframe
           do_syscall_64
           exit_to_usermode_loop
           task_work_run
           ____fput
           __fput
           kernfs_fop_release
           kernfs_put_open_node.isra.8
           mutex_lock
         - __mutex_lock_slowpath
            - 21.28% __mutex_lock.isra.5
                 osq_lock

-   10.49%    10.39%  showgids         [kernel.kallsyms]      [k] down_read
     10.39% __libc_start_main
        __GI___libc_open
        entry_SYSCALL_64_after_hwframe
        do_syscall_64
        sys_open
        do_sys_open
        do_filp_open
      - path_openat
         - 9.72% link_path_walk
            - 5.21% inode_permission
               - __inode_permission
                  - 5.21% kernfs_iop_permission
                       down_read
            - 4.08% walk_component
                 lookup_fast
               - d_revalidate.part.24
                  - 4.08% kernfs_dop_revalidate

-    7.48%     7.41%  showgids         [kernel.kallsyms]       [k] up_read
     7.41% __libc_start_main
        __GI___libc_open
        entry_SYSCALL_64_after_hwframe
        do_syscall_64
        sys_open
        do_sys_open
        do_filp_open
      - path_openat
         - 7.01% link_path_walk
            - 4.12% inode_permission
               - __inode_permission
                  - 4.12% kernfs_iop_permission
                       up_read
            - 2.61% walk_component
                 lookup_fast
               - d_revalidate.part.24
                  - 2.61% kernfs_dop_revalidate

Moreover this run of 200 application isntances takes 32-34 secs. to
complete.                                                     

This patch set is reducing the above mentioned contention by replacing
these global locks with hashed locks. 

For example with the patched kernel and on the same test setup, we no
longer see contention around osq_lock (i.e kernfs_open_file_mutex) and also
contention around per-fs kernfs_rwsem has reduced significantly as well.
This can be seen in the following perf snippet:

-    1.66%     1.65%  showgids         [kernel.kallsyms]      [k] down_read
     1.65% __libc_start_main
        __GI___libc_open
        entry_SYSCALL_64_after_hwframe
        do_syscall_64
        sys_open
        do_sys_open
        do_filp_open
      - path_openat
         - 1.62% link_path_walk
            - 0.98% inode_permission
               - __inode_permission
                  + 0.98% kernfs_iop_permission
            - 0.52% walk_component
                 lookup_fast
               - d_revalidate.part.24
                  - 0.52% kernfs_dop_revalidate

-    1.12%     1.11%  showgids         [kernel.kallsyms]      [k] up_read
     1.11% __libc_start_main
        __GI___libc_open
        entry_SYSCALL_64_after_hwframe
        do_syscall_64
        sys_open
        do_sys_open
        do_filp_open
      - path_openat
         - 1.11% link_path_walk
            - 0.69% inode_permission
               - __inode_permission
                  - 0.69% kernfs_iop_permission
                       up_read

Moreover the test execution time has reduced from 32-34 secs to 18-19 secs.

The patches of this patchset introduce following changes:

PATCH-1: Introduce interface to access global kernfs_open_file_mutex.

PATCH-2: Replace global kernfs_open_file_mutex with hashed mutexes.

PATCH-3: Introduce interface to access kernfs_open_node_lock.

PATCH-4: Replace global kernfs_open_node_lock with hashed spinlocks.

PATCH-5: Use a per-fs rwsem to protect per-fs list of kernfs_super_info.

PATCH-6: Introduce interface to access per-fs rwsem.

PATCH-7: Replace per-fs rwsem with hashed rwsems.

PATCH-8: Add a document to describe hashed locks used in kernfs.

------------------------------------------------------------------

I did not receive any feedback for v7 of the patchset. Resending
v7 after rebasing on tag next-20220315 of linux-next.

Changes since v6:
 - Addressed review comments from Tejun
	- Make locking helpers compact and remove unlock_parent from node.
 
 - Addressed review comments from Al Viro
	- Make multi node lock helpers non-inline
	- Account for change of parent while waiting on semaphores during
	  rename operation
	- Add a document to describe hashed locks introduced in this patch
	  and to provide proof of correctness 
 
 - Fix for some issues that I observed while preparing lock correctness
   document
	- Lock both parent and target while looking for symlink
	- Introduce a per-fs mutex to synchronize lookup and removal of a node
	- Avoid locking parent in remove_self, because only the first instance
	  does actual removal so other invocations of remove_self don't need
	  to lock the parent
 
 - Remove refcounting from lock helpers
	- Refcounting was present in lock helpers for cases where an execution
	  path acquires node's rwsem and then deletes the node. For such cases
	  release helpers should not try to acquire semaphore for this already
	  freed node. Refcounting was ensuring that release helpers could get
	  an still existing node.
	  I have modified locking helpers such that helpers that acquire rwsem
	  returns its address which can later be used by release helpers.

Changes since v5:
 - Addressed review comments from Greg
	- Clean up duplicate code.
 - Addressed review comments from Tejun
	- Explain how current value of NR_KERNFS_LOCKS were obtained for
	  different values of NR_CPUS.
	- Use single hash table for locks in place of per-fs hash table
	  for locks.
	- Move introduction of supers_rwsem to a separate patch.
	- Separate interface and usage part of hashed rwsem implementation
	  into 2 patches.
	- Use address of rwsems to determine locking order in case of
	  nested locking. This approach avoids ABBA deadlock possibility.
	- Change some #define macros into enum, with proper prefix.
 - Taking a cue from Tejun's feedback about separating hashed rwsem
   interface and usage into 2 patches, I have also divided the patch
   that introduced hashed mutex and spinlock, into separate patches. 	  
 - Rebase on linux-next tag: next-20220211

Changes since v4:
 - Removed compilation warnings reported by the 0-day bot.

Changes since v3:
 - Make open_file_mutex and open_node_lock per-fs.
 - Replace per-fs rwsem with per-fs hashed rwsem.
   (Suggested by Tejun Heo <tj@kernel.org>)

Imran Khan (8):
  kernfs: Introduce interface to access global kernfs_open_file_mutex.
  kernfs: Replace global kernfs_open_file_mutex with hashed mutexes.
  kernfs: Introduce interface to access kernfs_open_node_lock.
  kernfs: Replace global kernfs_open_node_lock with hashed spinlocks.
  kernfs: Use a per-fs rwsem to protect per-fs list of
    kernfs_super_info.
  kernfs: Introduce interface to access per-fs rwsem.
  kernfs: Replace per-fs rwsem with hashed rwsems.
  kernfs: Add a document to describe hashed locks used in kernfs.

 .../filesystems/kernfs-hashed-locks.rst       | 245 +++++++++++++++++
 fs/kernfs/Makefile                            |   2 +-
 fs/kernfs/dir.c                               | 212 +++++++++-----
 fs/kernfs/file.c                              |  66 +++--
 fs/kernfs/inode.c                             |  48 +++-
 fs/kernfs/kernfs-internal.c                   | 259 ++++++++++++++++++
 fs/kernfs/kernfs-internal.h                   | 162 ++++++++++-
 fs/kernfs/mount.c                             |  30 +-
 fs/kernfs/symlink.c                           |  13 +-
 include/linux/kernfs.h                        |  71 ++++-
 10 files changed, 982 insertions(+), 126 deletions(-)
 create mode 100644 Documentation/filesystems/kernfs-hashed-locks.rst
 create mode 100644 fs/kernfs/kernfs-internal.c


base-commit: a32cd981a6da2373c093d471ee4405a915e217d5
-- 
2.30.2

