Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF4F4DC01E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 08:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiCQH2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 03:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiCQH2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:28:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025BB1C16DA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 00:26:46 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22H3Rgg4030868;
        Thu, 17 Mar 2022 07:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=EKUFwlNv1FDedFXl72t1Pb4S/z4RfOsXGDuAp0EdtYA=;
 b=XuRhJe9XbVrPaSTMox+1vaGPuo4uxBTjMw8YnSd7xTGQySZSb/ABGayd0MvbUe+84cyZ
 GHNKhHau2PIcGHZkV8I52NgbciGWlY4KzUBOziuSPpuNZ2tKuwEcxZPa0u4zQIfWa5DS
 FbY9A+U3HNZFfTmEDofGR8sh2WkOgWBPYoTEoxU/LcUQPJLVmw2oZFM09EGuvSBj0AZ4
 4k7cgVQdMKdPmRpc66PjLJBZ0jJ0ZPrC+3crGkcB7pFOV9TC+qXFsXbdZC3yp6U7DLzG
 dKl2hkRKItVdac0M35d+MPw0lfDpA/XU7S+sMnWL1I/99jcDT+yBquL2VwVqlUFFeLKy xQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80] (may be forged))
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5s6reug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 07:26:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22H7BW5f180504;
        Thu, 17 Mar 2022 07:26:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by userp3030.oracle.com with ESMTP id 3et65q1vae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 07:26:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcJcXbjDtxpGf0SpLx1PW1J3Qy9Lmlm61NOPNQaEPxGG+ehUvRr/L7qv4X8gBnOFpNNXwny4F+1Tx+6wYERog0OprMKnmCllSjjAklb7iqb4WhwCY6RZ2j30/Yr79SmuYMF9eLck48ExZlaYUBJslOqk7dv2oyQjI2oo/eHM75ImPIKTGKZX0fwYnNvpVrwaXXN/7FU11KTTR2uWYDn/kWUL7Pf2uh0fDJ3fWOSVx4rVtXWotmsckUkcuTT+wHAyXldMWtD1lWYKIB+Td+sdTiFSTaiBLlPVY4YVHpgzj3prBx0n3pGxWemMphs0/k9CmGDOhSCQwMPI1Ekw2CgoFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKUFwlNv1FDedFXl72t1Pb4S/z4RfOsXGDuAp0EdtYA=;
 b=A+XK+OhrVi0BDPHAEUeoSQNGs8QqjW55fQ9yEj7fxouDuzgj0g4n0DREZ3bUFmCHfLbENsX2YPSbBa6eE3TokAo9+Qq7CA5zLPYlaX7kobmZYX8D1piusECMxUkNhCiT5ijvQ6OP6SrMOL0Z7cUHe0K9/CM/2lCNJKYomSFyuy1ukVemVHVbEXyKWXXJ0+++IzCYjNu5i022JAKNAjU4srChc3/wvNTwLFqepzEZPymd4RX50pRDPCCHd54YzbWC8AlNevOZi1vo6XvM3Pgy0PTblU/WSfhY0FAp5VDko0QXfL1wMaWY5E45eLzgvqR+nd43bnvRqfCbSztwMI7lqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKUFwlNv1FDedFXl72t1Pb4S/z4RfOsXGDuAp0EdtYA=;
 b=dNDXBSSIr3Dd5o98Ay4jAGhB0Eul37NmaK5+hLPbxaLat22NPwzhOaNyxsmFOKUB3DW8yHHkAkzZ46E/1OVgnulVLVS2T44PeqzP4bhZhFV696CB13caLvg3FZ5F9Lig5sYQf88Y44wXu62GTjZ0IWTf8G1M64tm4vo5S7NSs0w=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by DM6PR10MB4332.namprd10.prod.outlook.com (2603:10b6:5:220::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 07:26:38 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 07:26:38 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, viro@zeniv.linux.org.uk
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v7 7/8] kernfs: Replace per-fs rwsem with hashed rwsems.
Date:   Thu, 17 Mar 2022 18:26:11 +1100
Message-Id: <20220317072612.163143-8-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220317072612.163143-1-imran.f.khan@oracle.com>
References: <20220317072612.163143-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0035.ausprd01.prod.outlook.com
 (2603:10c6:10:eb::22) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25c81cbb-291a-429d-1138-08da07e7794e
X-MS-TrafficTypeDiagnostic: DM6PR10MB4332:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB4332BB035B04D17971FFEBE5B0129@DM6PR10MB4332.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2AMoFWB7Uo5Pr4ATkYOkdcbnxfLg+UJeR6I+MI+wxbl0ZMJ9GckyKmHzk5qiTKjN0bFJYJhy8mHTWWNSwrhbaDvLSnvN/TOxcHJwMrGu0TdbNlqFKiRZ+Yce6WcZuy3nP2a/ITisljWBBJd2Z+C6Vabqp7eR+wYIecwlMYsMq4I8++yOTXIQhr7DAtMnPXRQEQfrgy17dab7+GvrH/wvzokIgmbgBw1sROKVkTLzkXLVsarE4BvFedT6jzfUYPpIQZTjp/H9csIRCIjwy9K82ru/Re8JBKR043DFsQE6y+FQXZNz1qXJnqsIOlUmlgwWnp3bf4BrXUoxSn2+lxwJv1YLxZ9aOsI6kioUKoOwjL4e3BOUOYT+20jGQ42uRICcQl/oFttToHNflTOJ9vkte6ITMRb3lx49gUrCk0Ph76FMFBSxn/3GFOOnQwJ/Bfi//+OkkrUjpNJ2iAUqC/+5tRwzC7EGNvUqG+db+hDR96vzVoqZTUekdpmnBqnAwvFUtu8J9ezNyA3spi/tAfcM4kovlIUoSmxxmjRYUU1LgLhvYzHllqe7elgVMwq0Sy/reDVAENEaKkDeFUKT3n0RWOHBno+Pk96YI9IIlarbEMyXeqQnGL/ecMocCuVpvN3gO1T4GLNiS9zuedb5tvOVovMVz9i4NVypmtd0pQ2MO7pFQByY4u3aYKsDDXf0TLcZsnchCO6iavIc8jyF2SYpGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(2906002)(8936002)(26005)(52116002)(36756003)(38100700002)(316002)(186003)(38350700002)(103116003)(6506007)(86362001)(6666004)(83380400001)(1076003)(5660300002)(30864003)(4326008)(66946007)(6486002)(8676002)(66556008)(66476007)(508600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Doucg1r1G4zcUKEzvK2G0U5lBcKxwc9trJo9TuNXe59KG6ZbNiVLFd7Oj0UU?=
 =?us-ascii?Q?dIPTqFq6edKOM/eHtTzYoHhcZj4UweZ+xTPLNDtlv5tsaTK0CVc8Cb/Q+Q+G?=
 =?us-ascii?Q?CfqngC+c3cA/7hnFC3w8MLGPdbkaMdx8zKcE9KxIK2LD+YQVcZIwhs6Vy9kk?=
 =?us-ascii?Q?gymeO3OOhUXuOsh8Tr29XP0+sQZ8bqbzv0z/FFOZxvCR8fSvtkyxJ+rsiEce?=
 =?us-ascii?Q?e5yLD6xT82jmtgDEjzOFDqqUQovJkhpkz7XPzKlXj/7bS8ga+3lIAeqG6kSs?=
 =?us-ascii?Q?wpkCbWyCXaz+a8N9pAQVrvknM6K56y/zAgaiybFm7WAsZGF3k94nbPZpuO9n?=
 =?us-ascii?Q?PZCgCKHg0BLwW7vkn5+H2CwgMzrJozsBodUserCoQ7kn757WwKhmmpvNnEZg?=
 =?us-ascii?Q?Wi4kLlcZrHDtuURGEF9Ce5PgGlbTb8JjnLaxoUOlV0UJqPnAadZ8MwtcGkYo?=
 =?us-ascii?Q?+WU1QwDHrs1KImvaEYSjieoqGUz2d+z+CgfRyT1gdPuj8IQQ+s2LKc0QPvO7?=
 =?us-ascii?Q?xB9e3rsCUJLGgP6j9aIQWhPFFrX8afVuG74Fc3BhOGAK3aYn98KfTBxbJ4P2?=
 =?us-ascii?Q?E5mfP04+yfj5DwWimQCSDNLNBchirREsqjB2W5lL3DeXbKCJDCdq6qVK2F0g?=
 =?us-ascii?Q?gtHDDr8Pozfnpq+mqs6ub9dok7nl4Kr/OAtQVjAfZFLnDR4jPd76n5Frr4le?=
 =?us-ascii?Q?LgA0zThhLNrzvzqG0p2RLcVCoi0qynPqdcq1xSdFsw0fLIRD6JNcPkSUJCIH?=
 =?us-ascii?Q?h3vfLbFEHIBPb73W6QzxdYZ/QCEd6rQSxyOhXmdITB7DfIHTDQU8vnECwNBD?=
 =?us-ascii?Q?FSBlpG+3lKFqAdnfp9zCMpJowr9QoEzr1vQSuJ8Isuuf002gDC8Gt3lL5Nv2?=
 =?us-ascii?Q?ffm/8Fj1JjxNLKzv25cY5vZ35yF5gNl4A2KtZcp0s4psTM3gudwHksXBuXdQ?=
 =?us-ascii?Q?acgDvnbtGvsReA6UAdQFDiPaIthV5jecpEifX3lBWXy9+xNBJwY17qqUssOx?=
 =?us-ascii?Q?clnTryeVxi10PnJnZUBBWjQ0PlbLp0bSeYuWxsvl8SyjbCzHklWfiZ65zUxa?=
 =?us-ascii?Q?/ndjQxu0tY4E0yPrKq8B7I0EpLTow++DDfXCoDyMQXVrOP7iLfbRu8Wcssl+?=
 =?us-ascii?Q?+L39E1UAPDXv5iWAdKFDfv5fDH8C6P2G35jBcBXnfjvXVclKkMpQgb1TXvqW?=
 =?us-ascii?Q?sVx+LhgiF/9hOg5rfLYoied0DPkLK3D9S5FV9F/shsQPJAB7Xb1dWZo2iVyJ?=
 =?us-ascii?Q?b022NeeeJH0SIWq2vBApFPBUbeZL2fFHDaRj8aSQG/fylGrnGL/kijfctEoy?=
 =?us-ascii?Q?wAKMBRqt+qypKECUcLAEwewSVRl8NEt5PU61paw1VHC31R8ORAn7wRXkpJHj?=
 =?us-ascii?Q?3s1rs5s3KKBHYwFfJLvdjrKncJ3o4aSFC8qnuxYEs3hphEVPjxBAjTrXrcAX?=
 =?us-ascii?Q?4sejSTtYtmEFxvl3w/QtB69cUFkX611rOEBfJ6X6SJGXFMr+/02gGw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c81cbb-291a-429d-1138-08da07e7794e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 07:26:38.1988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yBxH4jWeYVgelP/zRCyB8dPAgYWExMRMpcIh7tIYixuBAzAc3yfXZ2AZr2jj4+reNDsOAy0AprwAufLNq5N+xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4332
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10288 signatures=693715
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203170042
X-Proofpoint-GUID: eCZYzly8CphlDmLHpkvb4pOaUkRz7Wyu
X-Proofpoint-ORIG-GUID: eCZYzly8CphlDmLHpkvb4pOaUkRz7Wyu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having a single rwsem to synchronize all operations across a kernfs
based file system (cgroup, sysfs etc.) does not scale well. The contention
around this single rwsem becomes more apparent in large scale systems with
few hundred CPUs where most of the CPUs have running tasks that are
opening, accessing or closing sysfs files at any point of time.

Using hashed rwsems in place of a per-fs rwsem, can significantly reduce
contention around per-fs rwsem and hence provide better scalability.
Moreover as these hashed rwsems are not part of kernfs_node objects we will
not see any singnificant change in memory utilization of kernfs based file
systems like sysfs, cgroupfs etc.

Modify interface introduced in previous patch to make use of hashed rwsems.
Just like earlier change use kernfs_node address as hashing key. Since we
are getting rid of per-fs lock, in certain cases we may need to acquire
locks corresponding to multiple nodes and in such cases of nested locking,
locks are taken in order of their addresses. Introduce helpers to acquire
rwsems corresponding to multiple nodes for such cases.

For operations that involve finding the node first and then operating on it
(for example operations involving find_and_get_ns), acquiring rwsem for the
node being searched is not possible. Such operations need to make sure that
a concurrent remove does not remove the found node. Introduce a per-fs
mutex that can be used to synchronize these operations against parallel
removal of involved node.

Replacing global mutex and spinlocks with hashed ones (as mentioned in
previous changes) and global rwsem with hashed rwsem (as done in this
change) reduces contention around kernfs and results in better performance
numbers.

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

With the patched kernel and on the same test setup, we no longer see
contention around osq_lock (i.e kernfs_open_file_mutex) and also
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

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 fs/kernfs/Makefile          |   2 +-
 fs/kernfs/dir.c             | 133 ++++++++++++++----
 fs/kernfs/inode.c           |  20 +++
 fs/kernfs/kernfs-internal.c | 259 ++++++++++++++++++++++++++++++++++++
 fs/kernfs/kernfs-internal.h |  46 ++++++-
 fs/kernfs/mount.c           |   1 +
 fs/kernfs/symlink.c         |  13 +-
 include/linux/kernfs.h      |   3 +-
 8 files changed, 444 insertions(+), 33 deletions(-)
 create mode 100644 fs/kernfs/kernfs-internal.c

diff --git a/fs/kernfs/Makefile b/fs/kernfs/Makefile
index 4ca54ff54c98..778da6b118e9 100644
--- a/fs/kernfs/Makefile
+++ b/fs/kernfs/Makefile
@@ -3,4 +3,4 @@
 # Makefile for the kernfs pseudo filesystem
 #
 
-obj-y		:= mount.o inode.o dir.o file.o symlink.o
+obj-y		:= mount.o inode.o dir.o file.o symlink.o kernfs-internal.o
diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 5dce041b10c3..1b28d99ff1c3 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -25,7 +25,6 @@ static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
 
 static bool kernfs_active(struct kernfs_node *kn)
 {
-	kernfs_rwsem_assert_held(kn);
 	return atomic_read(&kn->active) >= 0;
 }
 
@@ -450,26 +449,24 @@ void kernfs_put_active(struct kernfs_node *kn)
 /**
  * kernfs_drain - drain kernfs_node
  * @kn: kernfs_node to drain
+ * @anc: ancestor of kernfs_node to drain
  *
  * Drain existing usages and nuke all existing mmaps of @kn.  Mutiple
  * removers may invoke this function concurrently on @kn and all will
  * return after draining is complete.
  */
-static void kernfs_drain(struct kernfs_node *kn)
-	__releases(&kernfs_root(kn)->kernfs_rwsem)
-	__acquires(&kernfs_root(kn)->kernfs_rwsem)
+static void kernfs_drain(struct kernfs_node *kn, struct kernfs_node *anc)
+	__releases(kernfs_rwsem_ptr(anc))
+	__acquires(kernfs_rwsem_ptr(anc))
 {
 	struct kernfs_root *root = kernfs_root(kn);
 
-	/**
-	 * kn has the same root as its ancestor, so it can be used to get
-	 * per-fs rwsem.
-	 */
-	struct rw_semaphore *rwsem = kernfs_rwsem_ptr(kn);
+	struct rw_semaphore *rwsem;
 
-	kernfs_rwsem_assert_held_write(kn);
+	kernfs_rwsem_assert_held_write(anc);
 	WARN_ON_ONCE(kernfs_active(kn));
 
+	rwsem = kernfs_rwsem_ptr(anc);
 	kernfs_up_write(rwsem);
 
 	if (kernfs_lockdep(kn)) {
@@ -489,7 +486,7 @@ static void kernfs_drain(struct kernfs_node *kn)
 
 	kernfs_drain_open_files(kn);
 
-	kernfs_down_write(kn);
+	kernfs_down_write(anc);
 }
 
 /**
@@ -729,6 +726,11 @@ int kernfs_add_one(struct kernfs_node *kn)
 	bool has_ns;
 	int ret;
 
+	/**
+	 * The node being added is not active at this point of time and may
+	 * be activated later depending on CREATE_DEACTIVATED flag. So at
+	 * this point of time just locking the parent is enough.
+	 */
 	rwsem = kernfs_down_write(parent);
 
 	ret = -EINVAL;
@@ -867,11 +869,20 @@ struct kernfs_node *kernfs_find_and_get_ns(struct kernfs_node *parent,
 {
 	struct kernfs_node *kn;
 	struct rw_semaphore *rwsem;
+	struct kernfs_root *root = kernfs_root(parent);
 
+	/**
+	 * We don't have address of kernfs_node (that is being searched)
+	 * yet. Acquiring root->kernfs_rm_mutex and releasing it after
+	 * pinning the found kernfs_node, ensures that found kernfs_node
+	 * will not disappear due to a parallel remove operation.
+	 */
+	mutex_lock(&root->kernfs_rm_mutex);
 	rwsem = kernfs_down_read(parent);
 	kn = kernfs_find_ns(parent, name, ns);
 	kernfs_get(kn);
 	kernfs_up_read(rwsem);
+	mutex_unlock(&root->kernfs_rm_mutex);
 
 	return kn;
 }
@@ -892,11 +903,20 @@ struct kernfs_node *kernfs_walk_and_get_ns(struct kernfs_node *parent,
 {
 	struct kernfs_node *kn;
 	struct rw_semaphore *rwsem;
+	struct kernfs_root *root = kernfs_root(parent);
 
+	/**
+	 * We don't have address of kernfs_node (that is being searched)
+	 * yet. Acquiring root->kernfs_rm_mutex and releasing it after
+	 * pinning the found kernfs_node, ensures that found kernfs_node
+	 * will not disappear due to a parallel remove operation.
+	 */
+	mutex_lock(&root->kernfs_rm_mutex);
 	rwsem = kernfs_down_read(parent);
 	kn = kernfs_walk_ns(parent, path, ns);
 	kernfs_get(kn);
 	kernfs_up_read(rwsem);
+	mutex_unlock(&root->kernfs_rm_mutex);
 
 	return kn;
 }
@@ -921,9 +941,9 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
 		return ERR_PTR(-ENOMEM);
 
 	idr_init(&root->ino_idr);
-	init_rwsem(&root->kernfs_rwsem);
 	INIT_LIST_HEAD(&root->supers);
 	init_rwsem(&root->supers_rwsem);
+	mutex_init(&root->kernfs_rm_mutex);
 
 	/*
 	 * On 64bit ino setups, id is ino.  On 32bit, low 32bits are ino.
@@ -1093,6 +1113,11 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	}
 
 	kn = kernfs_dentry_node(dentry);
+	/**
+	 * For dentry revalidation just acquiring kernfs_node's rwsem for
+	 * reading should be enough. If a competing rename or remove wins
+	 * one of the checks below will fail.
+	 */
 	rwsem = kernfs_down_read(kn);
 
 	/* The kernfs node has been deactivated */
@@ -1132,24 +1157,35 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	struct inode *inode = NULL;
 	const void *ns = NULL;
 	struct rw_semaphore *rwsem;
+	struct kernfs_root *root = kernfs_root(parent);
 
+	/**
+	 * We don't have address of kernfs_node (that is being searched)
+	 * yet. So take root->kernfs_rm_mutex to avoid parallel removal of
+	 * found kernfs_node.
+	 */
+	mutex_lock(&root->kernfs_rm_mutex);
 	rwsem = kernfs_down_read(parent);
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dir->i_sb)->ns;
 
 	kn = kernfs_find_ns(parent, dentry->d_name.name, ns);
+	kernfs_up_read(rwsem);
 	/* attach dentry and inode */
 	if (kn) {
 		/* Inactive nodes are invisible to the VFS so don't
 		 * create a negative.
 		 */
+		rwsem = kernfs_down_read(kn);
 		if (!kernfs_active(kn)) {
 			kernfs_up_read(rwsem);
+			mutex_unlock(&root->kernfs_rm_mutex);
 			return NULL;
 		}
 		inode = kernfs_get_inode(dir->i_sb, kn);
 		if (!inode)
 			inode = ERR_PTR(-ENOMEM);
+		kernfs_up_read(rwsem);
 	}
 	/*
 	 * Needed for negative dentry validation.
@@ -1157,9 +1193,11 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	 * or transforms from positive dentry in dentry_unlink_inode()
 	 * called from vfs_rmdir().
 	 */
+	rwsem = kernfs_down_read(parent);
 	if (!IS_ERR(inode))
 		kernfs_set_rev(parent, dentry);
 	kernfs_up_read(rwsem);
+	mutex_unlock(&root->kernfs_rm_mutex);
 
 	/* instantiate and hash (possibly negative) dentry */
 	return d_splice_alias(inode, dentry);
@@ -1339,27 +1377,40 @@ void kernfs_activate(struct kernfs_node *kn)
 static void __kernfs_remove(struct kernfs_node *kn)
 {
 	struct kernfs_node *pos;
+	struct rw_semaphore *rwsem;
+	struct kernfs_root *root;
 
-	kernfs_rwsem_assert_held_write(kn);
+	if (!kn)
+		return;
+
+	root = kernfs_root(kn);
 
 	/*
 	 * Short-circuit if non-root @kn has already finished removal.
 	 * This is for kernfs_remove_self() which plays with active ref
 	 * after removal.
 	 */
-	if (!kn || (kn->parent && RB_EMPTY_NODE(&kn->rb)))
+	mutex_lock(&root->kernfs_rm_mutex);
+	rwsem = kernfs_down_write(kn);
+	if (kn->parent && RB_EMPTY_NODE(&kn->rb)) {
+		kernfs_up_write(rwsem);
+		mutex_unlock(&root->kernfs_rm_mutex);
 		return;
+	}
 
 	pr_debug("kernfs %s: removing\n", kn->name);
 
 	/* prevent any new usage under @kn by deactivating all nodes */
 	pos = NULL;
+
 	while ((pos = kernfs_next_descendant_post(pos, kn)))
 		if (kernfs_active(pos))
 			atomic_add(KN_DEACTIVATED_BIAS, &pos->active);
+	kernfs_up_write(rwsem);
 
 	/* deactivate and unlink the subtree node-by-node */
 	do {
+		rwsem = kernfs_down_write(kn);
 		pos = kernfs_leftmost_descendant(kn);
 
 		/*
@@ -1377,10 +1428,25 @@ static void __kernfs_remove(struct kernfs_node *kn)
 		 * error paths without worrying about draining.
 		 */
 		if (kn->flags & KERNFS_ACTIVATED)
-			kernfs_drain(pos);
+			kernfs_drain(pos, kn);
 		else
 			WARN_ON_ONCE(atomic_read(&kn->active) != KN_DEACTIVATED_BIAS);
 
+		kernfs_up_write(rwsem);
+
+		/**
+		 * By now node and all of its descendants have been deactivated
+		 * Once a descendant has been drained, acquire its parent's lock
+		 * and unlink it from parent's children rb tree.
+		 * We drop kn's lock before acquiring pos->parent's lock to avoid
+		 * deadlock that will happen if pos->parent and kn hash to same lock.
+		 * Dropping kn's lock should be safe because it is in deactived state.
+		 * Further root->kernfs_rm_mutex ensures that we will not have
+		 * concurrent instances of __kernfs_remove
+		 */
+		if (pos->parent)
+			rwsem = kernfs_down_write(pos->parent);
+
 		/*
 		 * kernfs_unlink_sibling() succeeds once per node.  Use it
 		 * to decide who's responsible for cleanups.
@@ -1398,8 +1464,12 @@ static void __kernfs_remove(struct kernfs_node *kn)
 			kernfs_put(pos);
 		}
 
+		if (pos->parent)
+			kernfs_up_write(rwsem);
 		kernfs_put(pos);
 	} while (pos != kn);
+
+	mutex_unlock(&root->kernfs_rm_mutex);
 }
 
 /**
@@ -1410,11 +1480,7 @@ static void __kernfs_remove(struct kernfs_node *kn)
  */
 void kernfs_remove(struct kernfs_node *kn)
 {
-	struct rw_semaphore *rwsem;
-
-	rwsem = kernfs_down_write(kn);
 	__kernfs_remove(kn);
-	kernfs_up_write(rwsem);
 }
 
 /**
@@ -1516,9 +1582,11 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 	 */
 	if (!(kn->flags & KERNFS_SUICIDAL)) {
 		kn->flags |= KERNFS_SUICIDAL;
+		kernfs_up_write(rwsem);
 		__kernfs_remove(kn);
 		kn->flags |= KERNFS_SUICIDED;
 		ret = true;
+		rwsem = kernfs_down_write(kn);
 	} else {
 		wait_queue_head_t *waitq = &kernfs_root(kn)->deactivate_waitq;
 		DEFINE_WAIT(wait);
@@ -1572,11 +1640,17 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
 
 	rwsem = kernfs_down_write(parent);
 
+	/**
+	 * Since the node being searched will be removed eventually,
+	 * we don't need to take root->kernfs_rm_mutex.
+	 * Even if a parallel remove succeeds, the subsequent __kernfs_remove
+	 * will detect it and bail-out early.
+	 */
 	kn = kernfs_find_ns(parent, name, ns);
-	if (kn)
-		__kernfs_remove(kn);
 
 	kernfs_up_write(rwsem);
+	if (kn)
+		__kernfs_remove(kn);
 
 	if (kn)
 		return 0;
@@ -1596,14 +1670,24 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 {
 	struct kernfs_node *old_parent;
 	const char *old_name = NULL;
-	struct rw_semaphore *rwsem;
+	struct kernfs_rwsem_token token;
 	int error;
 
 	/* can't move or rename root */
 	if (!kn->parent)
 		return -EINVAL;
 
-	rwsem = kernfs_down_write(kn);
+	old_parent = kn->parent;
+	kernfs_get(old_parent);
+	kernfs_down_write_triple_nodes(kn, old_parent, new_parent, &token);
+	while (old_parent != kn->parent) {
+		kernfs_put(old_parent);
+		kernfs_up_write_triple_nodes(kn, old_parent, new_parent, &token);
+		old_parent = kn->parent;
+		kernfs_get(old_parent);
+		kernfs_down_write_triple_nodes(kn, old_parent, new_parent, &token);
+	}
+	kernfs_put(old_parent);
 
 	error = -ENOENT;
 	if (!kernfs_active(kn) || !kernfs_active(new_parent) ||
@@ -1638,7 +1722,6 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 	/* rename_lock protects ->parent and ->name accessors */
 	spin_lock_irq(&kernfs_rename_lock);
 
-	old_parent = kn->parent;
 	kn->parent = new_parent;
 
 	kn->ns = new_ns;
@@ -1657,7 +1740,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 
 	error = 0;
  out:
-	kernfs_up_write(rwsem);
+	kernfs_up_write_triple_nodes(kn, new_parent, old_parent, &token);
 	return error;
 }
 
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index efe5ae98abf4..36a40b08b97f 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -101,6 +101,12 @@ int kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 	int ret;
 	struct rw_semaphore *rwsem;
 
+	/**
+	 * Since we are only modifying the inode attribute, we just need
+	 * to lock involved node. Operations that add or remove a node
+	 * acquire parent's lock before changing the inode attributes, so
+	 * such operations are also in sync with this interface.
+	 */
 	rwsem = kernfs_down_write(kn);
 	ret = __kernfs_setattr(kn, iattr);
 	kernfs_up_write(rwsem);
@@ -118,6 +124,12 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (!kn)
 		return -EINVAL;
 
+	/**
+	 * Since we are only modifying the inode attribute, we just need
+	 * to lock involved node. Operations that add or remove a node
+	 * acquire parent's lock before changing the inode attributes, so
+	 * such operations are also in sync with .setattr backend.
+	 */
 	rwsem = kernfs_down_write(kn);
 	error = setattr_prepare(&init_user_ns, dentry, iattr);
 	if (error)
@@ -188,6 +200,10 @@ int kernfs_iop_getattr(struct user_namespace *mnt_userns,
 	struct kernfs_node *kn = inode->i_private;
 	struct rw_semaphore *rwsem;
 
+	/**
+	 * As we are only reading ->iattr, acquiring kn's rwsem for
+	 * reading is enough.
+	 */
 	rwsem = kernfs_down_read(kn);
 	spin_lock(&inode->i_lock);
 	kernfs_refresh_inode(kn, inode);
@@ -285,6 +301,10 @@ int kernfs_iop_permission(struct user_namespace *mnt_userns,
 
 	kn = inode->i_private;
 
+	/**
+	 * As we are only reading ->iattr, acquiring kn's rwsem for
+	 * reading is enough.
+	 */
 	rwsem = kernfs_down_read(kn);
 	spin_lock(&inode->i_lock);
 	kernfs_refresh_inode(kn, inode);
diff --git a/fs/kernfs/kernfs-internal.c b/fs/kernfs/kernfs-internal.c
new file mode 100644
index 000000000000..80d7d64532fe
--- /dev/null
+++ b/fs/kernfs/kernfs-internal.c
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This file provides inernal helpers for kernfs.
+ */
+
+#include "kernfs-internal.h"
+
+static void kernfs_swap_rwsems(struct rw_semaphore **array, int i, int j)
+{
+	struct rw_semaphore *tmp;
+
+	tmp = array[i];
+	array[i] = array[j];
+	array[j] = tmp;
+}
+
+static void kernfs_sort_rwsems(struct kernfs_rwsem_token *token)
+{
+	struct rw_semaphore **array = &token->rwsems[0];
+
+	if (token->count == 2) {
+		if (array[0] == array[1])
+			token->count = 1;
+		else if (array[0] > array[1])
+			kernfs_swap_rwsems(array, 0, 1);
+	} else {
+		if (array[0] == array[1] && array[0] == array[2])
+			token->count = 1;
+		else {
+			if (array[0] > array[1])
+				kernfs_swap_rwsems(array, 0, 1);
+
+			if (array[0] > array[2])
+				kernfs_swap_rwsems(array, 0, 2);
+
+			if (array[1] > array[2])
+				kernfs_swap_rwsems(array, 1, 2);
+
+			if (array[0] == array[1] || array[1] == array[2])
+				token->count = 2;
+		}
+	}
+}
+
+/**
+ * kernfs_down_write_double_nodes() - take hashed rwsem for 2 nodes
+ *
+ * @kn1: first kernfs_node of interest
+ * @kn2: second kernfs_node of interest
+ * @token: token to pass unlocking information to caller
+ *
+ * Acquire hashed rwsem for 2 nodes. Some operation may need to acquire
+ * hashed rwsems for 2 nodes (for example for a node and its parent).
+ * This function can be used in such cases.
+ *
+ * Return: void
+ */
+void kernfs_down_write_double_nodes(struct kernfs_node *kn1,
+				    struct kernfs_node *kn2,
+				    struct kernfs_rwsem_token *token)
+{
+	struct rw_semaphore **array = &token->rwsems[0];
+
+	array[0] = kernfs_rwsem_ptr(kn1);
+	array[1] = kernfs_rwsem_ptr(kn2);
+	token->count = 2;
+
+	kernfs_sort_rwsems(token);
+
+	if (token->count == 1) {
+		/* Both nodes hash to same rwsem */
+		down_write_nested(array[0], 0);
+	} else {
+		/* Both nodes hash to different rwsems */
+		down_write_nested(array[0], 0);
+		down_write_nested(array[1], 1);
+	}
+}
+
+/**
+ * kernfs_up_write_double_nodes - release hashed rwsem for 2 nodes
+ *
+ * @kn1: first kernfs_node of interest
+ * @kn2: second kernfs_node of interest
+ * @token: token to indicate unlocking information
+ *		->rwsems is a sorted list of rwsem addresses
+ *		->count contains number of unique locks
+ *
+ * Release hashed rwsems for 2 nodes
+ *
+ * Return: void
+ */
+void kernfs_up_write_double_nodes(struct kernfs_node *kn1,
+				  struct kernfs_node *kn2,
+				  struct kernfs_rwsem_token *token)
+{
+	struct rw_semaphore **array = &token->rwsems[0];
+
+	if (token->count == 1) {
+		/* Both nodes hash to same rwsem */
+		up_write(array[0]);
+	} else {
+		/* Both nodes hashe to different rwsems */
+		up_write(array[0]);
+		up_write(array[1]);
+	}
+}
+
+/**
+ * kernfs_down_read_double_nodes() - take hashed rwsem for 2 nodes
+ *
+ * @kn1: first kernfs_node of interest
+ * @kn2: second kernfs_node of interest
+ * @token: token to pass unlocking information to caller
+ *
+ * Acquire hashed rwsem for 2 nodes. Some operation may need to acquire
+ * hashed rwsems for 2 nodes (for example for a node and its parent).
+ * This function can be used in such cases.
+ *
+ * Return: void
+ */
+void kernfs_down_read_double_nodes(struct kernfs_node *kn1,
+				    struct kernfs_node *kn2,
+				    struct kernfs_rwsem_token *token)
+{
+	struct rw_semaphore **array = &token->rwsems[0];
+
+	array[0] = kernfs_rwsem_ptr(kn1);
+	array[1] = kernfs_rwsem_ptr(kn2);
+	token->count = 2;
+
+	kernfs_sort_rwsems(token);
+
+	if (token->count == 1) {
+		/* Both nodes hash to same rwsem */
+		down_read_nested(array[0], 0);
+	} else {
+		/* Both nodes hash to different rwsems */
+		down_read_nested(array[0], 0);
+		down_read_nested(array[1], 1);
+	}
+}
+
+/**
+ * kernfs_up_read_double_nodes - release hashed rwsem for 2 nodes
+ *
+ * @kn1: first kernfs_node of interest
+ * @kn2: second kernfs_node of interest
+ * @token: token to indicate unlocking information
+ *		->rwsems is a sorted list of rwsem addresses
+ *		->count contains number of unique locks
+ *
+ * Release hashed rwsems for 2 nodes
+ *
+ * Return: void
+ */
+void kernfs_up_read_double_nodes(struct kernfs_node *kn1,
+				  struct kernfs_node *kn2,
+				  struct kernfs_rwsem_token *token)
+{
+	struct rw_semaphore **array = &token->rwsems[0];
+
+	if (token->count == 1) {
+		/* Both nodes hash to same rwsem */
+		up_read(array[0]);
+	} else {
+		/* Both nodes hashe to different rwsems */
+		up_read(array[0]);
+		up_read(array[1]);
+	}
+}
+
+/**
+ * kernfs_down_write_triple_nodes() - take hashed rwsem for 3 nodes
+ *
+ * @kn1: first kernfs_node of interest
+ * @kn2: second kernfs_node of interest
+ * @kn3: third kernfs_node of interest
+ * @token: token to pass unlocking information to caller
+ *
+ * Acquire hashed rwsem for 3 nodes. Some operation may need to acquire
+ * hashed rwsems for 3 nodes (for example rename operation needs to
+ * acquire rwsem corresponding to node, its current parent and its future
+ * parent). This function can be used in such cases.
+ *
+ * Return: void
+ */
+void kernfs_down_write_triple_nodes(struct kernfs_node *kn1,
+				    struct kernfs_node *kn2,
+				    struct kernfs_node *kn3,
+				    struct kernfs_rwsem_token *token)
+{
+	struct rw_semaphore **array = &token->rwsems[0];
+
+	array[0] = kernfs_rwsem_ptr(kn1);
+	array[1] = kernfs_rwsem_ptr(kn2);
+	array[2] = kernfs_rwsem_ptr(kn3);
+	token->count = 3;
+
+	kernfs_sort_rwsems(token);
+
+	if (token->count == 1) {
+		/* All 3 nodes hash to same rwsem */
+		down_write_nested(array[0], 0);
+	} else if (token->count == 2) {
+		/**
+		 * Two nodes hash to same rwsem, and these
+		 * will occupy consecutive places in array after
+		 * sorting.
+		 */
+		down_write_nested(array[0], 0);
+		down_write_nested(array[2], 1);
+	} else {
+		/* All 3 nodes hashe to different rwsems */
+		down_write_nested(array[0], 0);
+		down_write_nested(array[1], 1);
+		down_write_nested(array[2], 2);
+	}
+}
+
+/**
+ * kernfs_up_write_triple_nodes - release hashed rwsem for 3 nodes
+ *
+ * @kn1: first kernfs_node of interest
+ * @kn2: second kernfs_node of interest
+ * @kn3: third kernfs_node of interest
+ * @token: token to indicate unlocking information
+ *		->rwsems is a sorted list of rwsem addresses
+ *		->count contains number of unique locks
+ *
+ * Release hashed rwsems for 3 nodes
+ *
+ * Return: void
+ */
+void kernfs_up_write_triple_nodes(struct kernfs_node *kn1,
+				  struct kernfs_node *kn2,
+				  struct kernfs_node *kn3,
+				  struct kernfs_rwsem_token *token)
+{
+	struct rw_semaphore **array = &token->rwsems[0];
+
+	if (token->count == 1) {
+		/* All 3 nodes hash to same rwsem */
+		up_write(array[0]);
+	} else if (token->count == 2) {
+		/**
+		 * Two nodes hash to same rwsem, and these
+		 * will occupy consecutive places in array after
+		 * sorting.
+		 */
+		up_write(array[0]);
+		up_write(array[2]);
+	} else {
+		/* All 3 nodes hashe to different rwsems */
+		up_write(array[0]);
+		up_write(array[1]);
+		up_write(array[2]);
+	}
+}
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 8b24bc7e36c2..188e5680066c 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -19,6 +19,20 @@
 #include <linux/kernfs.h>
 #include <linux/fs_context.h>
 
+/**
+ * Token for nested locking interfaces.
+ *
+ * rwsems: array of rwsems to acquire
+ * count: has 2 uses
+ *	  As input argument it specifies size of ->rwsems array
+ *	  As return argument it specifies number of unique rwsems
+ *	  present in ->rwsems array
+ */
+struct kernfs_rwsem_token {
+	struct rw_semaphore *rwsems[3];
+	int count;
+};
+
 struct kernfs_iattrs {
 	kuid_t			ia_uid;
 	kgid_t			ia_gid;
@@ -46,8 +60,8 @@ struct kernfs_root {
 	struct list_head	supers;
 
 	wait_queue_head_t	deactivate_waitq;
-	struct rw_semaphore	kernfs_rwsem;
 	struct rw_semaphore     supers_rwsem;
+	struct mutex            kernfs_rm_mutex;
 };
 
 /* +1 to avoid triggering overflow warning when negating it */
@@ -208,9 +222,9 @@ static inline spinlock_t *kernfs_open_node_spinlock(struct kernfs_node *kn)
 
 static inline struct rw_semaphore *kernfs_rwsem_ptr(struct kernfs_node *kn)
 {
-	struct kernfs_root *root = kernfs_root(kn);
+	int idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
 
-	return &root->kernfs_rwsem;
+	return &kernfs_locks->kernfs_rwsem[idx];
 }
 
 static inline void kernfs_rwsem_assert_held(struct kernfs_node *kn)
@@ -284,4 +298,30 @@ static inline void kernfs_up_read(struct rw_semaphore *rwsem)
 	up_read(rwsem);
 }
 
+
+void kernfs_down_write_double_nodes(struct kernfs_node *kn1,
+				    struct kernfs_node *kn2,
+				    struct kernfs_rwsem_token *token);
+
+void kernfs_up_write_double_nodes(struct kernfs_node *kn1,
+				  struct kernfs_node *kn2,
+				  struct kernfs_rwsem_token *token);
+
+void kernfs_down_read_double_nodes(struct kernfs_node *kn1,
+				    struct kernfs_node *kn2,
+				    struct kernfs_rwsem_token *token);
+
+void kernfs_up_read_double_nodes(struct kernfs_node *kn1,
+				  struct kernfs_node *kn2,
+				  struct kernfs_rwsem_token *token);
+
+void kernfs_down_write_triple_nodes(struct kernfs_node *kn1,
+				    struct kernfs_node *kn2,
+				    struct kernfs_node *kn3,
+				    struct kernfs_rwsem_token *token);
+
+void kernfs_up_write_triple_nodes(struct kernfs_node *kn1,
+				  struct kernfs_node *kn2,
+				  struct kernfs_node *kn3,
+				  struct kernfs_rwsem_token *token);
 #endif	/* __KERNFS_INTERNAL_H */
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index f88dc4e26ffb..f2b3d981b42d 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -398,6 +398,7 @@ void __init kernfs_lock_init(void)
 	for (count = 0; count < NR_KERNFS_LOCKS; count++) {
 		mutex_init(&kernfs_locks->open_file_mutex[count].lock);
 		spin_lock_init(&kernfs_locks->open_node_locks[count].lock);
+		init_rwsem(&kernfs_locks->kernfs_rwsem[count]);
 	}
 }
 
diff --git a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
index 9d4103602554..cbdd1be5f0a8 100644
--- a/fs/kernfs/symlink.c
+++ b/fs/kernfs/symlink.c
@@ -113,12 +113,19 @@ static int kernfs_getlink(struct inode *inode, char *path)
 	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_node *parent = kn->parent;
 	struct kernfs_node *target = kn->symlink.target_kn;
-	struct rw_semaphore *rwsem;
+	struct kernfs_rwsem_token token;
 	int error;
 
-	rwsem = kernfs_down_read(parent);
+	/**
+	 * Lock both parent and target, to avoid their movement
+	 * or removal in the middle of path construction.
+	 * If a competing remove or rename for parent or target
+	 * wins, it will be reflected in result returned from
+	 * kernfs_get_target_path.
+	 */
+	kernfs_down_read_double_nodes(target, parent, &token);
 	error = kernfs_get_target_path(parent, target, path);
-	kernfs_up_read(rwsem);
+	kernfs_up_read_double_nodes(target, parent, &token);
 
 	return error;
 }
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 9f0926f553fc..46e71ae940d9 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -97,6 +97,7 @@ struct kernfs_open_node_lock {
 struct kernfs_global_locks {
 	struct kernfs_open_file_mutex open_file_mutex[NR_KERNFS_LOCKS];
 	struct kernfs_open_node_lock open_node_locks[NR_KERNFS_LOCKS];
+	struct rw_semaphore kernfs_rwsem[NR_KERNFS_LOCKS];
 };
 
 enum kernfs_node_type {
@@ -266,8 +267,8 @@ struct kernfs_root {
 	struct list_head	supers;
 
 	wait_queue_head_t	deactivate_waitq;
-	struct rw_semaphore	kernfs_rwsem;
 	struct rw_semaphore	supers_rwsem;
+	struct mutex		kernfs_rm_mutex;
 };
 #endif
 
-- 
2.30.2

