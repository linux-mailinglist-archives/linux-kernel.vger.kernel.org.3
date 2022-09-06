Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF51D5AEE9F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbiIFPYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbiIFPXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:23:15 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B773A72EDC;
        Tue,  6 Sep 2022 07:34:53 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286Dj5Gb027112;
        Tue, 6 Sep 2022 13:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=EjSUCynkpK2rj1hPgs3oxee0iwh/SYPXYSJGwalBnUI=;
 b=WXZcSz68eQGC7+3FqImksK34L4mv1xfj41sUXmVR/eRX6BOA4U1L5FaehevCJQ2SciRg
 9qcLcUK/c5EW7S2fjF8Hu7BSSYBk3uorF/NEob/dWycwhX7CLADjlDIB+O/kJ9cGapYW
 fWoz9jUpk1O+TlDTsWM+Knu+cO4vW3+vTjR4+jrozyOzCqEtYUt74XHdH9jyei+kcS48
 T/Ew+d8UpfV5MOU++DDL+eH6rGAKFoO+7BRJ59bt0Nzg8PYR2usUAUI0RWoGNibzOWDs
 PqIWCChloHWbAVuGBCzRPEitZ5vc1zvyCActJNPlC1tm+b8Ro3BOf9nx7yHsBFwCw0hB nA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3je7c70dm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 13:57:34 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 286DlAnQ013470;
        Tue, 6 Sep 2022 13:57:33 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3je7c70djr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 13:57:33 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 286DogJb025031;
        Tue, 6 Sep 2022 13:57:30 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 3jbxj8tu7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 13:57:30 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 286DvQa628049898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Sep 2022 13:57:26 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2478A4051;
        Tue,  6 Sep 2022 13:57:26 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20EB0A4040;
        Tue,  6 Sep 2022 13:57:26 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  6 Sep 2022 13:57:26 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-s390@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 4/8] hugetlb: handle truncate racing with page faults
References: <20220824175757.20590-1-mike.kravetz@oracle.com>
        <20220824175757.20590-5-mike.kravetz@oracle.com>
Date:   Tue, 06 Sep 2022 15:57:25 +0200
In-Reply-To: <20220824175757.20590-5-mike.kravetz@oracle.com> (Mike Kravetz's
        message of "Wed, 24 Aug 2022 10:57:53 -0700")
Message-ID: <yt9dr10ok3lm.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: drlOMToPnC3xAFT10lh6bW5aSlDSx33j
X-Proofpoint-GUID: rPaqgr_t1NJYXw1Y3rS-QPHhwMbOHSqG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_07,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1011 mlxscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060065
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

Mike Kravetz <mike.kravetz@oracle.com> writes:

> When page fault code needs to allocate and instantiate a new hugetlb
> page (huegtlb_no_page), it checks early to determine if the fault is
> beyond i_size.  When discovered early, it is easy to abort the fault and
> return an error.  However, it becomes much more difficult to handle when
> discovered later after allocating the page and consuming reservations
> and adding to the page cache.  Backing out changes in such instances
> becomes difficult and error prone.
>
> Instead of trying to catch and backout all such races, use the hugetlb
> fault mutex to handle truncate racing with page faults.  The most
> significant change is modification of the routine remove_inode_hugepages
> such that it will take the fault mutex for EVERY index in the truncated
> range (or hole in the case of hole punch).  Since remove_inode_hugepages
> is called in the truncate path after updating i_size, we can experience
> races as follows.
> - truncate code updates i_size and takes fault mutex before a racing
>   fault.  After fault code takes mutex, it will notice fault beyond
>   i_size and abort early.
> - fault code obtains mutex, and truncate updates i_size after early
>   checks in fault code.  fault code will add page beyond i_size.
>   When truncate code takes mutex for page/index, it will remove the
>   page.
> - truncate updates i_size, but fault code obtains mutex first.  If
>   fault code sees updated i_size it will abort early.  If fault code
>   does not see updated i_size, it will add page beyond i_size and
>   truncate code will remove page when it obtains fault mutex.
>
> Note, for performance reasons remove_inode_hugepages will still use
> filemap_get_folios for bulk folio lookups.  For indicies not returned in
> the bulk lookup, it will need to lookup individual folios to check for
> races with page fault.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  fs/hugetlbfs/inode.c | 184 +++++++++++++++++++++++++++++++------------
>  mm/hugetlb.c         |  41 +++++-----
>  2 files changed, 152 insertions(+), 73 deletions(-)

With linux next starting from next-20220831 i see hangs with this
patch applied while running the glibc test suite. The patch doesn't
revert cleanly on top, so i checked out one commit before that one and
with that revision everything works.

It looks like the malloc test suite in glibc triggers this. I cannot
identify a single test causing it, but instead the combination of
multiple tests. Running the test suite on a single CPU works. Given the
subject of the patch that's likely not a surprise.

This is on s390, and the warning i get from RCU is:

[ 1951.906997] rcu: INFO: rcu_sched self-detected stall on CPU
[ 1951.907009] rcu:     60-....: (6000 ticks this GP) idle=968c/1/0x4000000000000000 softirq=43971/43972 fqs=2765
[ 1951.907018]  (t=6000 jiffies g=116125 q=1008072 ncpus=64)
[ 1951.907024] CPU: 60 PID: 1236661 Comm: ld64.so.1 Not tainted 6.0.0-rc3-next-20220901 #340
[ 1951.907027] Hardware name: IBM 3906 M04 704 (z/VM 7.1.0)
[ 1951.907029] Krnl PSW : 0704e00180000000 00000000003d9042 (hugetlb_fault_mutex_hash+0x2a/0xd8)
[ 1951.907044]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
[ 1951.907095] Call Trace:
[ 1951.907098]  [<00000000003d9042>] hugetlb_fault_mutex_hash+0x2a/0xd8
[ 1951.907101] ([<00000000005845a6>] fault_lock_inode_indicies+0x8e/0x128)
[ 1951.907107]  [<0000000000584876>] remove_inode_hugepages+0x236/0x280
[ 1951.907109]  [<0000000000584a7c>] hugetlbfs_evict_inode+0x3c/0x60
[ 1951.907111]  [<000000000044fe96>] evict+0xe6/0x1c0
[ 1951.907116]  [<000000000044a608>] __dentry_kill+0x108/0x1e0
[ 1951.907119]  [<000000000044ac64>] dentry_kill+0x6c/0x290
[ 1951.907121]  [<000000000044afec>] dput+0x164/0x1c0
[ 1951.907123]  [<000000000042a4d6>] __fput+0xee/0x290
[ 1951.907127]  [<00000000001794a8>] task_work_run+0x88/0xe0
[ 1951.907133]  [<00000000001f77a0>] exit_to_user_mode_prepare+0x1a0/0x1a8
[ 1951.907137]  [<0000000000d0e42e>] __do_syscall+0x11e/0x200
[ 1951.907142]  [<0000000000d1d392>] system_call+0x82/0xb0
[ 1951.907145] Last Breaking-Event-Address:
[ 1951.907146]  [<0000038001d839c0>] 0x38001d839c0

One of the hanging test cases is usually malloc/tst-malloc-too-large-malloc-hugetlb2.

Any thoughts?

Thanks,
Sven
