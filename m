Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABD84AAD7F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 03:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381613AbiBFCWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 21:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348364AbiBFCWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 21:22:13 -0500
X-Greylist: delayed 4335 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 05 Feb 2022 18:22:13 PST
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33458C043186
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 18:22:13 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21609rth009008;
        Sun, 6 Feb 2022 01:09:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=JsM8+KDYdKDwAcfCrAbFfQ6CIN/j4iXJjj/4+A2eas0=;
 b=NCgT0Jyn0hs2dJj7Yk8HOCImPEHl+QvBFmt2igWClRthIHz1DjV+57P01vbPbc3ZeeZK
 Nj5P1SeXgZcaFJk8owWy1QYabP8mQbn54r9MRCCo2C5CEotKKhv9+ggFXuz+lToQi5Ps
 5i++kh7/ylueacjkPXamcLhNPjkpHNEOXJOdYzGiA0ckg9hGX1/zTBA2XqbXe6T4Vaq+
 SYiAniW2tqmHi9bCJ1LGF8qzG7atVrPddGDEpqAC3m1RlEMsqMolpaAygXF1rU5yEboo
 UGsV4Fh+5NSajhTsQw+OhqwxUNSZ+oAYz/b93PGFx/hODHEXkIxHJf5ob+bcHxEKKIQ7 3g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e1fu2j2kh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Feb 2022 01:09:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21615caZ015154;
        Sun, 6 Feb 2022 01:09:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by userp3030.oracle.com with ESMTP id 3e1eburra4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Feb 2022 01:09:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1BVOym8gLGzAxSVCiEXGvYZFFZUCiU4Q67ZvhGSa2i6qll3u8ALrXad2amyqgpYC3wb9WDT+tSy3sK9RWxNilQSKjl5uJyoxnxq1cEDYqBHCf/P6Q6agFm9y1HREwbhIrsM2eGVQnNMufw7iTa4Lq4V12xbYc5L06FjHxeGDYXZ9orkTjWVv77ZuqHCnrXQUxv24w+aGYV1g3XlfaxCOKwe1tohknIX2J165rfi/dTD2F0ENO6hcpPflz6vHB76Yp8nlmAxBxgje/Kc7r2Slm1vlTHTLVY4cYOL82smOxlwhTe7h9/hYBeTslpkqIrPpanCPaqpeGrfHQRlSDZ67A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsM8+KDYdKDwAcfCrAbFfQ6CIN/j4iXJjj/4+A2eas0=;
 b=lw4oxQ9wDlx+yIRjdc8pagpW3wkcFrRhfLNaC0Iw+sUmblctwmoDmcQ6HLwzgFohH/8fP3cl9QGPxPrH3W/p/JxxnwTY4pBtIfwktu8s9P8drN8KqyY2hMllQhsJ1Vdw+g547oKn1oYiPziqsE4wGFEzuV2XxAHRlOxemaFGbVQedPh0/V5q+WqVGw4IDS7og+CgkTeVLLy4LPlTCr4YfKe3PlT6FA4t87xxSn18fOuDiAMC5SO+jlM1FV8vZO4mlLwLcS5+/AQ5v5Fx86qIRrbbUGuQ851K/jjND9tM2Vbt+GD+vnwl9xo5nXRn1BJro7OAJQhNDsalKRzA6Th9EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsM8+KDYdKDwAcfCrAbFfQ6CIN/j4iXJjj/4+A2eas0=;
 b=uH9EhYb14ChWWlO7I8Pc4bR+AXBAs7xJ0vHEzX4eeRTAzLt45HYg/MRRXjOKEuj83Y0w1FY40Wq17q+4TUx+u8sdC3pYBk1sOvO+fuV9kS9XFn9U80yBZSg0r18VUV9UXW4clOWOlzT59cgzvnM09vJK5Vk8gic3doifOzyJlSk=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MN2PR10MB4079.namprd10.prod.outlook.com (2603:10b6:208:1b9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sun, 6 Feb
 2022 01:09:46 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1%3]) with mapi id 15.20.4951.017; Sun, 6 Feb 2022
 01:09:46 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] kernfs: use hashed mutex and spinlock in place of global ones.
Date:   Sun,  6 Feb 2022 12:09:23 +1100
Message-Id: <20220206010925.1033990-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYCPR01CA0019.ausprd01.prod.outlook.com
 (2603:10c6:10:31::31) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14ac61c7-056a-4b15-6430-08d9e90d5d72
X-MS-TrafficTypeDiagnostic: MN2PR10MB4079:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB4079FD63A36446BDFBAEFC41B02B9@MN2PR10MB4079.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:220;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Te93HRhFaD5Sw2cSfqpdQoWltdE8Uag/8J/uM0VRmjgsMOa/eXsUxtH2CjBpTEuZby4HdyJcwC5cyHOZ7jbyv+nFhmFvAW8+EAGXxWX+icSdGF+cPv2RFKgDKsAuQmvZSPJG5/0oRrEOuFqZoxCcQ2Tz/yTqGzyuc/qKOD10nYdPanv8kATPcGaawFWawXwFMpRwYR4DLvR4sX8uQ/Fm1MIGIhke37D84+29eL/mLrDZkisxwvWj3N8PDTmfW/NQ/y5RzM2z6/Y0k056Bqwb0QrjMClKbV+bf17uSxc+gyE9bIs43gobv/5BhWhf1PlJUXADDqK+0iraQCAf+KwN84OcuBD9uhQTusEAGMY84B2w75aRplJxlVrOe+OJQoftvncOveVsI+EZXFoqO1JdUXunHB7wzA3ZBB5zCHbvwIDJa9RAcdQ0cB20JU0jzw3lfUctse7rKwtuUCmlkbvV3SyxB8v+wiu1MBAHZi2Kan9i0HzDf4n1t3QMi7I1Xlf54ckxpiRyarOXpo9+nLzgIg9wMam2vYFW9DATRen7yi7C7hAlvP2OeAiBJlbgSxQUVvgoYniLEFIJuDdGn87RH1M2oHiVKn1w6EMWKQFcMXMkYZEdTbw+VVchGxZDJ0s0rkpOI914ywAGHc8SEoiaFUniy06rvDFsQgPJz1f5koRlNPdKRVhAnn6LSPQejRrw3QvCPT/RC7HWmg8GDxy5Yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66556008)(66946007)(6486002)(38100700002)(6506007)(86362001)(508600001)(8936002)(8676002)(4326008)(316002)(6666004)(38350700002)(52116002)(6512007)(2616005)(36756003)(5660300002)(1076003)(186003)(26005)(103116003)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b6gGjgMU08WlwyOSgHp6bA3vXe+bXOjyFZW/If4D5lKvMn1ARy1nVGz76Sfd?=
 =?us-ascii?Q?mCJ4q+mDOkFxDlzHreLpiFKPewAbF8s/79CewphYMIVSeDZymLQyUSQqU6qy?=
 =?us-ascii?Q?g4H9uldUe+PeuCuP9IuKtJkJRpZH51r4JJqPeVqQpP+YHp+aBqbERaJlEaFP?=
 =?us-ascii?Q?+G1PZCdGnGkZVSwfPM5MLYAC8VZ0SGtHatvuaCgyN8S0Ns65hgX62GCxF5cy?=
 =?us-ascii?Q?RYV/E1RESvq08AiiuL3A+RZ5DR9Cjkx4mPpSz7x9/xCR3qVc9dWlBaXVi8SG?=
 =?us-ascii?Q?vVjLkP4PgilEgJjTUx7gFTTdKbHGS9JlL4FK95lD2KkliZM1W8h2o61NSLA+?=
 =?us-ascii?Q?spNTtu5YR+eN+AytIkVjwYxBFB16XBgvW9ejUspbcZwFLWgY527srN4XIzUp?=
 =?us-ascii?Q?TIAODF5PehG2mMEKNMaTd/bLMGaAes+R5XyW6kVKTXWoBB/lP8zLbLRKycrC?=
 =?us-ascii?Q?CT9cD/GIvBxuC346gZ1u9t6DxvcZzr3Xkkbdpmxl/12XYeRPFoTVEJsQuR3y?=
 =?us-ascii?Q?cc/SjOWFg7+iEgPV1olRReKVtyvN09JEdyPbWzazuQbZtbK7WjENqYsrZm5j?=
 =?us-ascii?Q?iZ2WZC5XiO58mcbgdLS8qZkCDWunH5Lwg8eUx/WJMiPt+KqORS9ntJeFtZLh?=
 =?us-ascii?Q?QPkr+RWoabP6lguIrvbcwJTX4to3nJRmccDvfQVmc/GcXQTWE23WXuJXl6C/?=
 =?us-ascii?Q?gvw1K6MF5U3PC3i8vI1fVRycvzJLJcP9usvi1Ae8S0Bj2yWC96E2AoYDu2yH?=
 =?us-ascii?Q?7lezpW4yLxVvRjm1kOmgG7ysGmfdc/cHIkiIj+RDjGZnNuBnyEUPIAvByvfI?=
 =?us-ascii?Q?8GU8TwzU5PfJz6vHxJtlJOHPVJ+DTDFCJjVyeDMj5AckokkhW8a2wowzt/pj?=
 =?us-ascii?Q?WpeZrupytBUTflVhDwMCR6PdWsvw772Fy/x1aQ6h9hUhpJhlK8NlT6wQtJhn?=
 =?us-ascii?Q?2UjKynyiDZIa8NCB+VhLcE9zQy28HYOD47c9XOH/DJ7OatEXazIA4e9t0cK7?=
 =?us-ascii?Q?lEJQdiiJ5FU1oRlp7/PVysBChxs2PDOAFxmZAQLQVXiQhuL6k85SbnK+pTcP?=
 =?us-ascii?Q?oqSGpjCKzDGpgqy9wkFaktVCtZbg0ING5MfM6e9hAv892kBf8ABxqP/pKuVg?=
 =?us-ascii?Q?4eN8kGcXelYLGYR8756P/tyMBkaE0yWP/7dBddF9DPWHfahuPe4DCmETravR?=
 =?us-ascii?Q?L8PRIMQ0y+WJjg8kz5g3JVL3Kjm2wLWPjGR5ALFNK7OiwEeB0X23sf2T5Mt2?=
 =?us-ascii?Q?v2TagzawoCw1N2cqlshQrKSQZX9MHRZxGVBYxwA+v2wueD1gIkMbukipPzKI?=
 =?us-ascii?Q?Zn+4jp23P+vW3S1uSqglSazy7jSIXZwdOmgvtyqiojyHrRI0T8fvyV7xYPcQ?=
 =?us-ascii?Q?ArMxTVHsfS7N7ue2qEswIMr0+hdE8HtQpthy5r83LEUM1F3eTM/4owAUJZuj?=
 =?us-ascii?Q?JZGIzjheb0Uso2BbOoY8GLZ3RXZxAc8CKXd78YFKcicE75/N1zRpBK24Gg8d?=
 =?us-ascii?Q?n11OT4nTzuLmuBez6L9RiSipamIcANmvF0JtFL0t87NYKQEeKQnWm7FoaC62?=
 =?us-ascii?Q?06Ptr5c6kmBppyQCRn6NwVAd0vUDV28E0YkODecEMF9oPtinnMV0Co/ZEfO+?=
 =?us-ascii?Q?MmlOpnDj8J375VIWjAzoTv8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ac61c7-056a-4b15-6430-08d9e90d5d72
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2022 01:09:46.3291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+7XptdIyXUcMrIlkD4327TpuS0Tvf5nPUFkr0VMEJcKjq7lgReAs9DWGd81blnEBPeftV5fXToSacZPr+f2Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4079
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10249 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=612 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202060005
X-Proofpoint-ORIG-GUID: 7uJXEOlSUI0X_RmQ5jWxYL2nKcouKZTi
X-Proofpoint-GUID: 7uJXEOlSUI0X_RmQ5jWxYL2nKcouKZTi
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

The patches of this patchset introduce following chanages:

PATCH-1: Make global kernfs_open_file_mutex and kernfs_open_node_lock
	 per-fs hashed locks, where address of a kernfs_node acts as hash key.
	 This results in kernfs_node objects, whose address give the
	 different hash value, using different kernfs_open_file_mutex
	 and kernfs_open_node_lock rather than all kernfs_node objects
	 using the same kernfs_open_file_mutex and kernfs_open_node_lock
	 as was the case earlier.

PATCH-2: Replace per-fs single rw semaphore with per-fs hashed semaphore,
	 where address of a kernfs_node acts as hash key to reduce contention
	 around single per-fs rw semaphore.

------------------------------------------------------------------
Changes since v4:
 - Removed compilation warnings reported by the 0-day bot.

Changes since v3:
 - Make open_file_mutex and open_node_lock per-fs.
 - Replace per-fs rwsem with per-fs hashed rwsem.
   (Suggested by Tejun Heo <tj@kernel.org>)


Imran Khan (2):
  kernfs: use hashed mutex and spinlock in place of global ones.
  kernfs: Replace per-fs global rwsem with per-fs hashed rwsem.

 fs/kernfs/dir.c             | 281 +++++++++++++++++++++++++-----------
 fs/kernfs/file.c            |  67 ++++-----
 fs/kernfs/inode.c           |  22 +--
 fs/kernfs/kernfs-internal.h | 163 +++++++++++++++++++++
 fs/kernfs/mount.c           |  13 +-
 fs/kernfs/symlink.c         |   5 +-
 include/linux/kernfs.h      |  44 +++++-
 7 files changed, 445 insertions(+), 150 deletions(-)


base-commit: a70bf4a85b43cb952bd39dd948b103b1b3eb2cf8
-- 
2.30.2

