Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BCE4C3D99
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 06:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237482AbiBYFWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 00:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiBYFWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 00:22:08 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5C864C6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 21:21:35 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21P4xJ1m028596;
        Fri, 25 Feb 2022 05:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=imo8QILbVwgeOQ8Oeo3Q/RGY1nXmn2ns2kBPMALIXfU=;
 b=Qu7/f6Gli8LGCTNoKwJB9vhYgXiTazrNcD23E5FaXLe6EOZ+5KuCakCEx6boKXme5Jxf
 wgDGBXVWu4Vr0mME/vjSs64sUSYV/dBDQOdTU85wMdQUsFfkbkCEnO15qqOXGQK+eVI4
 m/zQSl+SkVAeVa44ysby0oa0sVhXHuqh7xaMjiS3iZ+PN6O7ynlqDiDLakfQUuI3jncU
 Xu1iGLLD834T2Uw+ivf+Z/+dVE2CYmXHKNfjoIHqHcCa8eRkAGBu7karTe8jFAGpMgti
 WDUtZR97mqf2+wQxR64uAhrEPf88grYL2k6V3I/6Dt3Dia1Obom3hv3vD+apGfXjGM9i ow== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ecvar8uh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 05:21:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21P5B08N181414;
        Fri, 25 Feb 2022 05:21:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by aserp3030.oracle.com with ESMTP id 3eapkm8a2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 05:21:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bn3LY+85LxZ9S3jPGKWQA+UR/OAS0KHkJfCZPI1/LdZDIUaldNPaXC7UcINt/VV5bk2kmd0y4WmQxFe5sNx0o/ryMdSyDbp6nxOsgwA2kaqn8c63ruUmAf7XRp0Qa1pzZCeVURjcm6wUjJRuny3MtKFc0XFxDepDBzdNvIa3k7Kg4UV/Ege2ne+zDqqPEEwgZhUcM7dio75OqxwfCdQMl1smOjlAToOwuzXPBfcxRZ9uzMfnS1+fEgNcAPDMrau3OC16UgsTiowSq281147CiFnntOgkwLzg4hNOl7OdLH70H1RlGW7dyPYsNnNwb4TEiBdu8dSEVmz/HUg2gxVKyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imo8QILbVwgeOQ8Oeo3Q/RGY1nXmn2ns2kBPMALIXfU=;
 b=QrMh7fMPFe94yuXp/SbeUSvThqqm3fZ1mQRE+bESH8nGyMq6QtbbYQ3bc7efbCAeYg6cWU4Y/ucRU/2pDeKluABwGds1ohYZlWjfcNMMdHlprBltITz1kWk15kVBopzBuBPghR9UhtA/4yENcquNJbG4yzflMBNbgyQMa9fhj3Tth97R7fBbInbJhepvJw32nnoiy5pCUb73PieEH/EVoXVIYyPjJyGcz6beodbxWRRApGGPBPkcZPILxRXPRydUxtPkz9ovIQmUeFuZuJvyW/VL7rty85F5kYHlE4exFxe63Qe48Bc9S5WZetrslsVqwZVgAxAv0g24iczUrBrO4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imo8QILbVwgeOQ8Oeo3Q/RGY1nXmn2ns2kBPMALIXfU=;
 b=KSK/lVCc8D/8RcaPGghwPJL8igRoMPTiVDFTr9XmnxlSchZ6yHFSV967RA/diEgmbSXzIQCUZNYzQZVO4+LNYOlcJltXZNRhAssHLjVTi1aqvHR7dgMzoQ9IjIVJz0od7MGIA+N/JWslT1YJ311xN6NXT0VbBM9F4e6YVKD5rAc=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR10MB1677.namprd10.prod.outlook.com (2603:10b6:301:a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Fri, 25 Feb
 2022 05:21:27 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 05:21:27 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/8] kernfs: Introduce interface to access global kernfs_open_file_mutex.
Date:   Fri, 25 Feb 2022 16:21:08 +1100
Message-Id: <20220225052116.1243150-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYAPR01CA0043.ausprd01.prod.outlook.com (2603:10c6:1:1::31)
 To CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ebbed74-c7ed-43c1-165e-08d9f81eac4e
X-MS-TrafficTypeDiagnostic: MWHPR10MB1677:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB167768381AE9C42E673EF2C4B03E9@MWHPR10MB1677.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j7LLbtfUnzvbpunVErNaQztFzLH5bPwrteDQ1Ar8+Hg8JN7c48/VXBtMl4aFkgjvE+reF0oQDwsAIsqkPeM+4xcHTrKu5MWAGacDzCRfE7/NDg658J2VlDgApHKfRbqp9apoiHN0ThxGYbkptIiHu6rki+5wkUBqlTF0cEhOXctseXpi69PF/oWBCF+pA3pMUiC6oAOtkbdQvyVdQAHg2zyfXrAKl10gmpOJFGqsGBv8oJxWVE3YWN3sfRJ682e0fup2VV3qOl1PcxOV1/49IarEdd/itI42lAyKSFiEYvqby/hkhbdMLIn5mF6hZBnzhge3N870FszOa3T7eHA0Kz1pUQ6GQnCRMJbqFvtmzMVmodwzwb0hZYoj6pff4I5aQCgFDdgrc97aoU7BgvpGYApKV0SaCDrkFUK29NkdzN5UH6mPkBgVtNLB5JPPIjX5ELaDi/QQaxpZ+mZyWWtZZiw1C7ZjvvyqUSZPuYqpkwwYH8dHrRnAVgXtn/Ue6Z8+ARJwpQz5Lf/ahuTzG6DQx9aPtbY7cry1E0TaJlVC5ihk9ePWKQYPMv8Qj1DgvRmCX/RgMRSS00UENRAedFU5JB0d9GNrMO6/PWF7fob5yzmjZIXGJ4SAcxmY5KjxU+oFXEvL+5ENNNtauXGZpSTN6CPMl19Rj98WGUq19vrwYqJs/9i3cvxi+vryJkyrv6DlgPkT+E1AIMPL8FbI4HuIBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(26005)(38350700002)(6666004)(8936002)(38100700002)(83380400001)(1076003)(6512007)(508600001)(86362001)(6486002)(6506007)(2906002)(52116002)(316002)(66946007)(36756003)(4326008)(5660300002)(8676002)(66476007)(103116003)(66556008)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?86P1RcynDKddCbYq7aHOcDLMeympKQDofVGkmsQhkuoA39tEiiNMXkxCX/aj?=
 =?us-ascii?Q?wNsnbCWeQf6ySjUt6C/R7n2Gjjel9hg1l0Fb9SSSG1RIleJPDVK+y0Xukr/K?=
 =?us-ascii?Q?jEk3WHcqC2z3LjWTabqlfEZIjpr1vMvpqu1Y2838zomlFzBMdm3OQzo9ou5b?=
 =?us-ascii?Q?silA4ijhC+e1dilq7jIiaNhmekj98A7sAPJ++hK79/22kZXd8nT0zKR/0wE6?=
 =?us-ascii?Q?6WrAGLCjPLWGj4ucFackac3T9t5tUmo+Q+ZPMVVfNCzMLkn+Jn4QAyPRFbtk?=
 =?us-ascii?Q?3TT5H+ApAc0rfoQ2bm+TP1J7VDgsj9JH6wMuMi3SDv2sWQsrKX8DTHzS7Exg?=
 =?us-ascii?Q?zPmPKehoZA1GmiYMmOpAZarPEsrKAcNiw4WuoENanmQltXDxZzlDJ7KG+HSY?=
 =?us-ascii?Q?DqoRqT/8+adj0ceXxGw2LGT3PmrPVdkVk7WwGfbGOZDq9yaw61Z7TL6T/TVw?=
 =?us-ascii?Q?VqqeahKWFnWt3qvxhFjD5DnsGLR4mthk/GdxEgf18I6oRCvyb0bTg7VyzYpM?=
 =?us-ascii?Q?Iz4R1a9FaGULO/2mH6yTUalAcigouA6vdEyZtzu2RvWV/WW6uN1HS0Debimg?=
 =?us-ascii?Q?2q3tDUSzTkdp32wtZG0O5Xp295YR+FRNKYV10hUo1vvdsj0owNmYQ9v6S2SU?=
 =?us-ascii?Q?dS+ZNuKX2fX1e1t7T44jcyh4MxHPoK0YLdNrhtS0pFUWMGXzav6I+EKjT7I9?=
 =?us-ascii?Q?nRIV14yLIP40PqAECFnn5OIBDGL8u1iO+yJCFfLhvy0esxrpE2s1/9VHNceJ?=
 =?us-ascii?Q?2zgvQua2sp9ce67nn8BCrOQ4211/MJxdnZDLa8TRbiD+6HMKVQCDH3kTOQfd?=
 =?us-ascii?Q?3qrnxQkuIDXr0zSUeTZrD0+sflVcWecyjADJkPf73Z8LHtQSpJm/vBZeg417?=
 =?us-ascii?Q?5auvyXL5Sl9wuVw8bPG4K5uE11dJYzB4T2QdNwvAQ7fF+gkGLzVCL9VxhQuX?=
 =?us-ascii?Q?SdATC8ujVcRVdPCT4zs5HC0VAM+FBa91uNw3rGBq+AjsSZihuLdg67KJpl5T?=
 =?us-ascii?Q?PBsrq1qfA04lbtSu/7cm7+Y8aXFAKN2jOq4h1oAsf4hTLrnE721C6vGmGHnD?=
 =?us-ascii?Q?sPBtB4MbmPbBmwfE6QWcaw9y+alL02JWTJeD8e0uKl9R2CLAKjFIBDQdQobQ?=
 =?us-ascii?Q?aY5AD2V+Mncx4p17dw1ccCtmtoeKerPTQjHTg+IyBGSRV+5BQUZisrAKa9OH?=
 =?us-ascii?Q?NG7zgNd0pfmR3UoE8giGaI78cM8QoNTfjCeO+sfoBpivtMcc8ejDRDzi0eb+?=
 =?us-ascii?Q?z3wcFQJM/4wwnaIDphFxNAPNpk3aAbgWVV5PDREpz5cQdmp/eX1g+qlixgVV?=
 =?us-ascii?Q?ojyEhbhpVMHoeOuRDBKLzwpaW8MHc1iBSRjpBqrSv3XAanI3Bu6CTgu7Z4lt?=
 =?us-ascii?Q?tBKsDXnDOoHB6wQFsA+bn1JG8Ib/Wb3T+1opK5oyzszKxC/OAN+fvZ5WNFLY?=
 =?us-ascii?Q?5bbUdKDXnb51Be2OyhnMWj+PEvUed1fsGFgbG8lyzIvRjLlypYPbh8TrkNw7?=
 =?us-ascii?Q?jZVjYczAfVaKlNvStESl2iE/ER+MAnOerR9vTtKnF8ew2XlF+kqdHQTlAnVK?=
 =?us-ascii?Q?xx+US/dM0fUQjlUGDm99vSI7RYndin/kM9EwY/Rfq2tuZy1WJS2wwH11+NaP?=
 =?us-ascii?Q?l9ZWjigJueE7zJg7VQscqys=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ebbed74-c7ed-43c1-165e-08d9f81eac4e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 05:21:27.6110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oA+GjQESxcxOGgF/hATKVOIVStPfqL/FEypVXAVg5LSFTx5U40guI/WEMJ7x4L7tkU6JCHPgaCtDxo2dG+4iIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1677
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202250027
X-Proofpoint-GUID: QUFDLjvObY3bcUOs8SPW-QHFLiZkXN6x
X-Proofpoint-ORIG-GUID: QUFDLjvObY3bcUOs8SPW-QHFLiZkXN6x
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
 fs/kernfs/kernfs-internal.h                   | 159 +++++++++++
 fs/kernfs/mount.c                             |  30 +-
 fs/kernfs/symlink.c                           |  13 +-
 include/linux/kernfs.h                        |  71 ++++-
 10 files changed, 980 insertions(+), 125 deletions(-)
 create mode 100644 Documentation/filesystems/kernfs-hashed-locks.rst
 create mode 100644 fs/kernfs/kernfs-internal.c


base-commit: 196d330d7fb1e7cc0d85641c89ce4602cb36f12e
-- 
2.30.2

