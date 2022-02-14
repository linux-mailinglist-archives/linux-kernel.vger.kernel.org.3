Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC7B4B4F91
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352245AbiBNMDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:03:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237082AbiBNMDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:03:50 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76049E21
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 04:03:42 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21EAoZ0h018258;
        Mon, 14 Feb 2022 12:03:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=yDteRFShWMHGv8Fng3iU1P2zsEs8nX0tFp8AzeXmj64=;
 b=kf5snfIshXkJNH3mAtnkMf6RVvvnOB6eXtdVtCyqw7hdj4llyjfkFC/7k+B4c+rvGW6l
 cVL3TTNc2iM4XYDTTFI4Z36jxcKPASsqkoKkGpMuIqUUWHWB5Ti91Dk3CCglUwQc9cXz
 +enULTamfbjC5G1oEIgVNo2Ng/0MXA7Ryi9m9V9yUOqBdOkDoaVf8KTKvYVRrneOLc7f
 IxnNmfLSb9xTtGFseaq0FhjdYpAnhCVotcs5kAXzH/SQQcG4D/d+ygDA7Lke2zLWNI3U
 vXzF/12gxKENb5Z3Q3QR3ZBEI+5djMEdS1+3hVzybMEvV4u31aVtCqwhfG7WbJJWolUE tA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e65euc5q4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:03:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21EBu16l067147;
        Mon, 14 Feb 2022 12:03:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by aserp3020.oracle.com with ESMTP id 3e6qkwjgxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 12:03:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWArbbV5MPjH0EFXOsRMDHUt1v/Or4cWyIvpoZIJt3sNBeqZw6JoKiRfGMi5Pi7v2xHySXmx/3RdwI2z1BvRhIxnO7ve/Fb1cHOixi+Wk9r/SzkpAp97OP5L1nyQ4+Mfefu/qnlBoWlEf74mVTt1jhJYdpzy6Cp3s8Fad1KreI90vTg3q/Et+pL8TGMMmH+N7XOtELQ+hBqq4OUFQoq8ubIUV/qIX6Xl9gubh9UydVt70y/9B/57wOo1jN5Of+RP6lbJbAKPfSHbmfFl6Yls0lN1W54PASQpSip+wfigSB7o7K6x65s8LvawlKZdOMP92X68mQI/gwWp+FwDwZe14Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDteRFShWMHGv8Fng3iU1P2zsEs8nX0tFp8AzeXmj64=;
 b=DSSp4BXFhjzalg8HZoqmolCjjoK8fz4n/JfDy7JvVTj2wMtSL2kHbikkYriMkFgjXA8Y+s0I0+DTObGAm52317Kp6xGfT8fLV710EnpR2Zb2sabjJFSsYwmTZh7paEUUj3u5GOzT8udNOtnlYLzR2TAzhmwAo+a/gKwPOVnbVt71supkkXXmGiky4yF8eqX/NbZrCv22QA2dlECIvW0ASIXKWOOEchXzohHGr96yQ8BKYHfFmoPsnThOCDxFmdgYy44RHS+SsA5JORMzfbCCdznNzomSMZ3VI/LkEG5+kNxd4ML3N9SqiG2si8ZjbTfJDlMQxJ1bDMA+Hn9KU2opeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDteRFShWMHGv8Fng3iU1P2zsEs8nX0tFp8AzeXmj64=;
 b=mNzBz6wFrpNzLrjkTqsQm0UHxpfRZGmhfgkDPFdxl1sMwFr+aNVd2aJLfQqRnZTPhf3SJMuKyy4ptD3S2UTel+9Bk6lB4kf2gL0UYQC/FEMpjoWWec5Q4VL9zGTHq8AQ4AfX/MljV0juwvvDEvbKB5u6rr1L7rOiF4Ii5XCqvxk=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BN8PR10MB3538.namprd10.prod.outlook.com (2603:10b6:408:b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Mon, 14 Feb
 2022 12:03:35 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::a5d1:ed4:5ab6:e9b1%4]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 12:03:35 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/7] kernfs: Introduce hashed mutexes to replace global kernfs_open_file_mutex.
Date:   Mon, 14 Feb 2022 23:03:15 +1100
Message-Id: <20220214120322.2402628-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY2PR01CA0016.ausprd01.prod.outlook.com
 (2603:10c6:1:14::28) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b8e4531-d293-463c-1828-08d9efb20720
X-MS-TrafficTypeDiagnostic: BN8PR10MB3538:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB3538A9533684D9D7A72D205AB0339@BN8PR10MB3538.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:176;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5wSLotf4V27UCTeTgnKiX05PTdzvoeVSVlWK/3NYrIvWuUNFFV/wmebNANBxBtf8koLmJdOfLcLVtGnfD5/zoV+GyqKTfDuNQBjNHQxge1GrVMpXU+sY4UrlsTzNCBoGhWsDfpNFMBtJtpHb/FJVyUUbHrADkrPkDmI1tgI0kw/SnVPujhxM88i3PBMfr4fF1SKt+afim37iy/wNkR3ZpYr2jTOUO4MI+bOt45c7wqFHqPrmTCvlouKCBQdCfzsXmFGSN3CAIS7iusHIP7eGU/iLVGb+qisGhTLusZB8sn9DTLQQGvDSH+hbrO7+erKqeEzFVqHBJ5qVs7jTFqg8z54bgushqLKD1YG2tyxEijOzq03n8nBypJG2jVNGd7X8Qom9AyWYVSRgIpd9GEKSkSJ5C7eE9P3uqKtIcLCZqBYj6TdncT17I3z4kmXfNPXqxLFrcSXJkCoIUybL3OOcouv2blgzwUyzNemWV91sO0wPZzqhZW8hdYWNrIRJJ/mHK4hthLiMMXb7QN805+MybA8EiAV/RZy6JW+fG/L2eRP+dwa56tNbtJK4EkkA9TEqaCgcPPS7BXsAdCa/UShXN5muoLok6QjU7uyVFFo+J+oy5feeLpH8USVt2Gv5LQyWz8AYEMzlhBBn+67QesW0fskN62KtDlM4LvshgwmopGFbWzoLZW4KF9OdSbW91IxiSAxP1keX5Y/X61oIkD4SKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(66946007)(316002)(38100700002)(2616005)(36756003)(6486002)(66556008)(4326008)(66476007)(103116003)(186003)(1076003)(26005)(6666004)(6512007)(2906002)(86362001)(508600001)(52116002)(83380400001)(5660300002)(8936002)(6506007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TlJmrRrHP4j7LKFLasLuRXzm900LooMgAwA0W2lhopMnUm/xZUt3hy+9hd2W?=
 =?us-ascii?Q?yCqtf+A6ldD55bubh6I6gMWkD/7Ent5zMQmAxwmsZYjRQXt2JFpZKAGIgR21?=
 =?us-ascii?Q?x/b0seqqGJGj1rWiUCQzMBMyALxdOU2vt64m65YVI7tfVDKkalWsSpEh4uiq?=
 =?us-ascii?Q?amyxcB+KRRF3XGev5/TqEptVdT8pIjazp+FVc47SfkCvq0lohsQ3y9SS4bRb?=
 =?us-ascii?Q?xVoGrpeWk4LZEO85YwikuZu+tzfgrbqaHbeIoaoH8yXS2xeYNE5is4gz88bT?=
 =?us-ascii?Q?jfmMU/uBFGE491pnfm1CYsNORZuo3J4MYQK2J9WN4ji844obyeXJUFPjo/8U?=
 =?us-ascii?Q?cSw5OZ+4ha9IvWLSKYwdx2Gg1Z8BZ0FX222Gu48aw6AByAU98atx2eoS5AdR?=
 =?us-ascii?Q?x4A8kJCX05B2qllzaCPTy5ypAmr4oIuFs5igc83e/r31Bkz6Jfltq3k/v7Zj?=
 =?us-ascii?Q?d+rwP8RpWgaEFjmY2oW1TMYV0mY+FEhxp7qNSrrIKwBk9b8M15AtZqCDG3vW?=
 =?us-ascii?Q?FbZW6e/xkNeK7fwppAbc0QRWxaDUcJBMFbT2+zivz0gOpI4yIzgeciw3k32w?=
 =?us-ascii?Q?n3ZR7C08HhhnkzMek6Yzo2D+DA1Cooen8BWqO9u9cGalEMMERe+Ksxj9q9rW?=
 =?us-ascii?Q?OHh8WBaX8WJEishOIbGx/rEQ72+KtMEl63LN4O42I7Zyhtrtsykiy+y8o18e?=
 =?us-ascii?Q?DqFMv/choM2oOzE5ZZ3VbMItwEcHHa+MAtqJFIZeMDgAqMitBBrX6aB39/91?=
 =?us-ascii?Q?2VQZM6YRMTkMFHZ504mJn0qpw9uaHSCt++eVMNPBtxUuCNPmHVYes9/KpDKg?=
 =?us-ascii?Q?CSL1rgIJvFVdF6/x66hQhmxS+M8M/tpNidbRjAcub3gm0vD4HQk/ni2qIx70?=
 =?us-ascii?Q?jXcisOSlf2NEJ8Je5R/TlWdvz2toM5BkHLDALLmlsnjdUaLWY8/1uv/7KlJo?=
 =?us-ascii?Q?7xZPirWWezSkdVuKC4gCEgKB/bfUwlGIDv7pp0ma4aJO9oFCAv2XWQyfDDzU?=
 =?us-ascii?Q?lgnlJNWZZpt1Yi/FF+nNFumNNwvqJVsDaSC8cbuNr7V7u69Uio4FG/wE9pIZ?=
 =?us-ascii?Q?3gSURdJffi6HfVl6ugQPbkflPDrMMHxKUwWwy7xQ8vrNahS8TobSpFwt1NEZ?=
 =?us-ascii?Q?II6HaFr41TrsEkxM5rXV8tr3sd1GLHS21ufpzPHPwoEN6meV55mRtnuBQztt?=
 =?us-ascii?Q?y9t/QgvZj1jWuGum8w/NrMujMs+jsj69tjcVsqcDGS/JRSXNOCqG/gDIpM1n?=
 =?us-ascii?Q?WG8U/D9Mbpb/OMILaGEtu2j7MjLP5rKFWAaj2KWOIUN7Xc+KMuw3OyQOwPDk?=
 =?us-ascii?Q?XJvApF2vttIGAH20LGowc31tHoY699BF6/r10/LTKHg5srTdIKbUEgqJFM/+?=
 =?us-ascii?Q?8UJjdBb5FRVNiOm2VNhe19BThf5koXW/7fcpF26h7l2szxjJkp5zfhAJ2G1y?=
 =?us-ascii?Q?cwfi845untpZQiY83NZycTmtxlI3h8rKC3U6JCd82vqcE+C821kmBxJN66I/?=
 =?us-ascii?Q?/aSNmRYtHhwvMjRfpL+4rL4Y/R2ei/An7JJwj5ESgDv+DqiZ/Q4BxqMgWFYy?=
 =?us-ascii?Q?H3DbWBOcxLDhtFHmQSOcYgcVacwhZ5XLPTI7D73bEbfTrDStavIdJIZBHZQ0?=
 =?us-ascii?Q?K3AvpPQbbRObuS/tsDlX7wM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8e4531-d293-463c-1828-08d9efb20720
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 12:03:35.3802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxhfyXKai5kygr+Cja61JWWl8jWaIwnaWIqRtmXlx0QxC0UiNUTXW/JvGFmJr+YTymmGti6PvsrotetRqW7Y/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3538
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10257 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=775 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202140073
X-Proofpoint-ORIG-GUID: gCWgaJxG4Kl2MxeZzyFI4Xu9uAVoHUHb
X-Proofpoint-GUID: gCWgaJxG4Kl2MxeZzyFI4Xu9uAVoHUHb
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

PATCH-1: Introduce hashed mutexes to replace global kernfs_open_file_mutex.

PATCH-2: Replace global kernfs_open_file_mutex with hashed mutexes.

PATCH-3: Introduce hashed spinlocks to replace global kernfs_open_node_lock.

PATCH-4: Replace global kernfs_open_node_lock with hashed spinlocks.

PATCH-5: Use a per-fs rwsem to protect list of kernfs_super_info.

PATCH-6: Introduce hashed rw-sem to replace per-fs kernfs_rwsem.

PATCH-7: Replace per-fs rwsem with hashed ones.

------------------------------------------------------------------
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

Imran Khan (7):
  kernfs: Introduce hashed mutexes to replace global
    kernfs_open_file_mutex.
  kernfs: Replace global kernfs_open_file_mutex with hashed mutexes.
  kernfs: Introduce hashed spinlocks to replace global
    kernfs_open_node_lock.
  kernfs: Replace global kernfs_open_node_lock with hashed spinlocks.
  kernfs: Use a per-fs rwsem to protect per-fs list of
    kernfs_super_info.
  kernfs: Introduce hashed rw-sem to replace per-fs kernfs_rwsem.
  kernfs: Replace per-fs rwsem with hashed ones.

 fs/kernfs/dir.c             | 132 ++++----
 fs/kernfs/file.c            |  65 ++--
 fs/kernfs/inode.c           |  22 +-
 fs/kernfs/kernfs-internal.h | 604 +++++++++++++++++++++++++++++++++++-
 fs/kernfs/mount.c           |  29 +-
 fs/kernfs/symlink.c         |   5 +-
 include/linux/kernfs.h      |  69 ++++
 7 files changed, 802 insertions(+), 124 deletions(-)


base-commit: 6d9bd4ad4ca08b1114e814c2c42383b8b13be631
-- 
2.30.2

