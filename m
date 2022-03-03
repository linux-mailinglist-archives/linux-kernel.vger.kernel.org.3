Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15F74CB6AB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 07:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiCCGJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 01:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiCCGJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 01:09:21 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5926158E87;
        Wed,  2 Mar 2022 22:08:34 -0800 (PST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2235Mj7l027039;
        Thu, 3 Mar 2022 06:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=tAFo2nAVBHlJm3WcjxdMbljcwPYV8sMq6b92Cb6CE4k=;
 b=jnVcU8lBfvLwuVJpmTgJ5mT1SAtlcxDgfBsNv1Un6nzwd/gFRfOdIMh7db1SA1JJmPzd
 ynzEWS5zJeUKiHC6lKpfGBpkoEbQiV0MGQG+p3oblydwSzvoICLzGMAL7JilWdr1Rwvm
 ljYC3Ljar2SxIZu/vSJUZRvgXq3CHlmUAFVElqKr+KddJ4R4sLqwbfTE37ZYYBaz/0Ll
 X1ePODYgLIoL4iNLLYB8nl8Sdovf0mTKfuaNh5Hjj9Ud0Gy1vvpmV/wrzaGUEu9vV0Qm
 p3KxVqiHptc4TLOq8cNCrtfpNN3EENs0yK6X00RPmKkydImIl2ZvKviQ7C9KVUsPfG7U Cg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ejqfr0pjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 06:07:17 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2235NL2D029716;
        Thu, 3 Mar 2022 06:07:16 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ejqfr0phy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 06:07:16 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22364tR9020914;
        Thu, 3 Mar 2022 06:07:14 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3efbu9gthq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 06:07:13 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22367B5D34603464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Mar 2022 06:07:11 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AD6E4C040;
        Thu,  3 Mar 2022 06:07:11 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFC274C046;
        Thu,  3 Mar 2022 06:06:54 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.163.20.88])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Thu,  3 Mar 2022 06:06:54 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Thu, 03 Mar 2022 11:36:51 +0530
From:   Vaibhav Jain <vaibhav@linux.ibm.com>
To:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Larabel <Michael@michaellarabel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v7 00/12] Multigenerational LRU Framework
In-Reply-To: <20220208081902.3550911-1-yuzhao@google.com>
References: <20220208081902.3550911-1-yuzhao@google.com>
Date:   Thu, 03 Mar 2022 11:36:51 +0530
Message-ID: <87czj3mux0.fsf@vajain21.in.ibm.com>
Content-Type: text/plain; charset=utf-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FeXKMhmdtlwCLyty8s-Fq5RgMLRv5zGR
X-Proofpoint-ORIG-GUID: H1XbNMky1SKwfWuu_TXkq8ftQ8J3pmpO
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-03_01,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203030027
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In a synthetic MongoDB Benchmark (YCSB) seeing an average of ~19% throughput
improvement on POWER10(Radix MMU + 64K Page Size) with MGLRU patches on
top of v5.16 kernel for MongoDB + YCSB bench across three different
request distriburions namely Exponential,Uniform and Zipfan

Test-Results
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Average YCSB reported throughput (95% Confidence Interval):
|---------------------+---------------------+---------------------+--------=
-------------|
| Kernel-Type         | Exponential         | Uniform             | Zipfan =
             |
|---------------------+---------------------+---------------------+--------=
-------------|
| Base Kernel (v5.16) | 27324.701 =C2=B1 759.652 | 20671.590 =C2=B1 412.974=
 | 37713.761 =C2=B1 621.213 |
| v5.16 + MGLRU       | 32702.231 =C2=B1 287.957 | 24916.239 =C2=B1 217.977=
 | 44308.839 =C2=B1 701.829 |
|---------------------+---------------------+---------------------+--------=
-------------|
| Speedup             | 19.68% =C2=B1 4.03%      | 20.11% =C2=B1 2.95%     =
 | 17.49% =C2=B1 2.82%      |
|---------------------+---------------------+---------------------+--------=
-------------|

n =3D 11 Samples x 3 (Distributions) x 2 (Kernels) =3D 66 Observations

Test Environment
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Cpu: POWER10 (architected), altivec supported
platform: pSeries
CPUs: 32
MMU: Radix
Page-Size: 64K
Total-Memory: 64G

Distro
-------
# cat /etc/os-release
NAME=3D"Red Hat Enterprise Linux"
VERSION=3D"8.4 (Ootpa)"
ID=3D"rhel"
ID_LIKE=3D"fedora"
VERSION_ID=3D"8.4"
PLATFORM_ID=3D"platform:el8"
PRETTY_NAME=3D"Red Hat Enterprise Linux 8.4 (Ootpa)"
ANSI_COLOR=3D"0;31"
CPE_NAME=3D"cpe:/o:redhat:enterprise_linux:8.4:GA"
HOME_URL=3D"https://www.redhat.com/"
DOCUMENTATION_URL=3D"https://access.redhat.com/documentation/red_hat_enterp=
rise_linux/8/"
BUG_REPORT_URL=3D"https://bugzilla.redhat.com/"

REDHAT_BUGZILLA_PRODUCT=3D"Red Hat Enterprise Linux 8"
REDHAT_BUGZILLA_PRODUCT_VERSION=3D8.4
REDHAT_SUPPORT_PRODUCT=3D"Red Hat Enterprise Linux"
REDHAT_SUPPORT_PRODUCT_VERSION=3D"8.4"

System-config
-------------
# cat /sys/kernel/mm/transparent_hugepage/enabled
always madvise [never]

# cat /proc/swaps=20
Filename                                Type            Size            Use=
d            Priority
/dev/dm-5                               partition       10485696        940=
864          -2

# cat /proc/sys/vm/overcommit_memory
0

#cat /proc/cmdline
<existing parameters> systemd.unified_cgroup_hierarchy=3D1 transparent_huge=
page=3Dnever

MongoDB data partition
----------------------
lsblk /dev/sdb
NAME MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sdb    8:16   0  128G  0 disk <home>/data/mongodb

mount | grep /dev/sdb
/dev/sdb on /root/vajain21/mglru/data/mongodb type ext4 (rw,relatime)

Testing Artifacts
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

MongoDB-configuration
---------------------
MongoDB Commounity Server built from https://github.com/mongodb/mongo relea=
se v5.0.6

# mongod --version
db version v5.0.6
Build Info: {
      "version": "5.0.6",
      "gitVersion": "212a8dbb47f07427dae194a9c75baec1d81d9259",
      "openSSLVersion": "OpenSSL 1.1.1g FIPS  21 Apr 2020",
      "modules": [],
      "allocator": "tcmalloc",
      "environment": {
      "distarch": "ppc64le",
      "target_arch": "ppc64le"
      }
}

# cat /etc/mongod.conf=20
storage:
  dbPath: <home-path>/data/mongodb
  journal:
     enabled: true
  engine: wiredTiger
  wiredTiger:
    engineConfig:
    cacheSizeGB: 50
  net:
    bindIp: 127.0.0.1
    unixDomainSocket:
    enabled: true
    pathPrefix: /run/mongodb
setParameter:
    enableLocalhostAuthBypass: true

YCSB (https://github.com/vaibhav92/YCSB/tree/mongodb-domain-sockets)
--------------------------------------------------------------------

YCSB forked from https://github.com/brianfrankcooper/YCSB.git. This fixes a
problem with YCSB when trying to connect to MongoDB on a unix domain socket=
. PR
raised to the project at https://github.com/brianfrankcooper/YCSB/pull/1587

Head Commit: fb2555a77005ae70c26e4adc46c945caf4daa2f9(" [core] Generate
classpath from all dependencies rather than just compile scoped")

Kernel-Config
-------------

Base-Kernel: https://github.com/torvalds/linux/ v5.16
Base-Kernel-Config:
https://github.com/vaibhav92/mglru-benchmark/blob/auto_build/config-non-mgl=
ru

Test-Kernel: https://linux-mm.googlesource.com/page-reclaim refs/changes/49=
/1549/1
Test-Kernel-Config:
https://github.com/vaibhav92/mglru-benchmark/blob/auto_build/config-mglru

CONFIG_LRU_GEN=3Dy
CONFIG_LRU_GEN_ENABLED=3Dy
CONFIG_NR_LRU_GENS=3D4
CONFIG_TIERS_PER_GEN=3D4

YCSB:
recordcount=3D80000000
operationcount=3D80000000
readproportion=3D0.8
updateproportion=3D0.2
workload=3Dsite.ycsb.workloads.CoreWorkload
threads=3D64
requestdistributions=3D{uniform, exponential, zipfian}

Test-Bench
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Source: https://github.com/vaibhav92/mglru-benchmark/tree/auto_build

Invoked via following command that will *destroy* contents of /dev/sdd
and use it as data disk for MongoDB:

$ export MONGODB_DISK=3D/dev/sdd; curl \
https://raw.githubusercontent.com/vaibhav92/mglru-benchmark/auto_build/buil=
d.sh
\ | sudo bash -s

Test-Methodology
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Setup
-----
1. Pull & Build testing artifact v5.16 Base Kernel, MGLRU Kernel,
MongoDB, YCSB & Qemu for qemu-img tools
2. Format and mount provided MongoDB Data disk with ext4.
3. Generate Systemd service/slice files for MongoDB and place them into /et=
c/systemd/system/
4. Generate MongoDB configration pointing to the data disk mount.
5. Start the built MongoDB instance.
6. Ensure that MongoDB is running.

Load Test Data
---------------
1. Ensure that MongoDB instance is stopped.
2. Unmount the data disk and reformat it with ext4.
3. Restart MongoDB.
4. Spin off YCSB to load data into the Mongo instance.
5. Stop MongoDB + Unmount data Disk
6. Create a qcow2 image of the data disk and store it with test data.
7. Kexec into base kernel.

Test Phase (Happens at each boot)
---------------------------------
1. Select the distribution to be used for YCSB from
{"Uniform","Exponential","Zipfan"}
2. Restore the MongoDB qcow2 data disk Image to the disk
3. Mount the data disk and restart MongoDB daemon.
4. Start YCSB to generate the workload on MongoDB.
5. Once finished collect results.
6. Kexec into next-kernel which keeps switching between Base-Kernel &
MGLRU-Kernel when all three distriutions have been tested.

Setup and Load Test Data stages can be accomplished by following command:
#export MONGODB_DISK=3D/dev/sdd; \
curl https://raw.githubusercontent.com/vaibhav92/mglru-benchmark/auto_build=
/build.sh | bash -s

Once completed successfully it will kexec into the base kernel and start the
Test phase on boot via systemd service named 'mglru-benchmark'

Based on above results,
Tested-by: Vaibhav Jain<vaibhav@linux.ibm.com>

Yu Zhao <yuzhao@google.com> writes:

> What's new
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1) Addressed all the comments received on the mailing list and in the
>    meeting with the stakeholders (will note on individual patches).
> 2) Measured the performance improvements for each patch between 5-8
>    (reported in the commit messages).
>
> TLDR
> =3D=3D=3D=3D
> The current page reclaim is too expensive in terms of CPU usage and it
> often makes poor choices about what to evict. This patchset offers an
> alternative solution that is performant, versatile and straightforward.
>
> Patchset overview
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> The design and implementation overview was moved to patch 12 so that
> people can finish reading this cover letter.
>
> 1. mm: x86, arm64: add arch_has_hw_pte_young()
> 2. mm: x86: add CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
> Using hardware optimizations when trying to clear the accessed bit in
> many PTEs.
>
> 3. mm/vmscan.c: refactor shrink_node()
> A minor refactor.
>
> 4. mm: multigenerational LRU: groundwork
> Adding the basic data structure and the functions that insert/remove
> pages to/from the multigenerational LRU (MGLRU) lists.
>
> 5. mm: multigenerational LRU: minimal implementation
> A minimal (functional) implementation without any optimizations.
>
> 6. mm: multigenerational LRU: exploit locality in rmap
> Improving the efficiency when using the rmap.
>
> 7. mm: multigenerational LRU: support page table walks
> Adding the (optional) page table scanning.
>
> 8. mm: multigenerational LRU: optimize multiple memcgs
> Optimizing the overall performance for multiple memcgs running mixed
> types of workloads.
>
> 9. mm: multigenerational LRU: runtime switch
> Adding a runtime switch to enable or disable MGLRU.
>
> 10. mm: multigenerational LRU: thrashing prevention
> 11. mm: multigenerational LRU: debugfs interface
> Providing userspace with additional features like thrashing prevention,
> working set estimation and proactive reclaim.
>
> 12. mm: multigenerational LRU: documentation
> Adding a design doc and an admin guide.
>
> Benchmark results
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Independent lab results
> -----------------------
> Based on the popularity of searches [01] and the memory usage in
> Google's public cloud, the most popular open-source memory-hungry
> applications, in alphabetical order, are:
>       Apache Cassandra      Memcached
>       Apache Hadoop         MongoDB
>       Apache Spark          PostgreSQL
>       MariaDB (MySQL)       Redis
>
> An independent lab evaluated MGLRU with the most widely used benchmark
> suites for the above applications. They posted 960 data points along
> with kernel metrics and perf profiles collected over more than 500
> hours of total benchmark time. Their final reports show that, with 95%
> confidence intervals (CIs), the above applications all performed
> significantly better for at least part of their benchmark matrices.
>
> On 5.14:
> 1. Apache Spark [02] took 95% CIs [9.28, 11.19]% and [12.20, 14.93]%
>    less wall time to sort three billion random integers, respectively,
>    under the medium- and the high-concurrency conditions, when
>    overcommitting memory. There were no statistically significant
>    changes in wall time for the rest of the benchmark matrix.
> 2. MariaDB [03] achieved 95% CIs [5.24, 10.71]% and [20.22, 25.97]%
>    more transactions per minute (TPM), respectively, under the medium-
>    and the high-concurrency conditions, when overcommitting memory.
>    There were no statistically significant changes in TPM for the rest
>    of the benchmark matrix.
> 3. Memcached [04] achieved 95% CIs [23.54, 32.25]%, [20.76, 41.61]%
>    and [21.59, 30.02]% more operations per second (OPS), respectively,
>    for sequential access, random access and Gaussian (distribution)
>    access, when THP=3Dalways; 95% CIs [13.85, 15.97]% and
>    [23.94, 29.92]% more OPS, respectively, for random access and
>    Gaussian access, when THP=3Dnever. There were no statistically
>    significant changes in OPS for the rest of the benchmark matrix.
> 4. MongoDB [05] achieved 95% CIs [2.23, 3.44]%, [6.97, 9.73]% and
>    [2.16, 3.55]% more operations per second (OPS), respectively, for
>    exponential (distribution) access, random access and Zipfian
>    (distribution) access, when underutilizing memory; 95% CIs
>    [8.83, 10.03]%, [21.12, 23.14]% and [5.53, 6.46]% more OPS,
>    respectively, for exponential access, random access and Zipfian
>    access, when overcommitting memory.
>
> On 5.15:
> 5. Apache Cassandra [06] achieved 95% CIs [1.06, 4.10]%, [1.94, 5.43]%
>    and [4.11, 7.50]% more operations per second (OPS), respectively,
>    for exponential (distribution) access, random access and Zipfian
>    (distribution) access, when swap was off; 95% CIs [0.50, 2.60]%,
>    [6.51, 8.77]% and [3.29, 6.75]% more OPS, respectively, for
>    exponential access, random access and Zipfian access, when swap was
>    on.
> 6. Apache Hadoop [07] took 95% CIs [5.31, 9.69]% and [2.02, 7.86]%
>    less average wall time to finish twelve parallel TeraSort jobs,
>    respectively, under the medium- and the high-concurrency
>    conditions, when swap was on. There were no statistically
>    significant changes in average wall time for the rest of the
>    benchmark matrix.
> 7. PostgreSQL [08] achieved 95% CI [1.75, 6.42]% more transactions per
>    minute (TPM) under the high-concurrency condition, when swap was
>    off; 95% CIs [12.82, 18.69]% and [22.70, 46.86]% more TPM,
>    respectively, under the medium- and the high-concurrency
>    conditions, when swap was on. There were no statistically
>    significant changes in TPM for the rest of the benchmark matrix.
> 8. Redis [09] achieved 95% CIs [0.58, 5.94]%, [6.55, 14.58]% and
>    [11.47, 19.36]% more total operations per second (OPS),
>    respectively, for sequential access, random access and Gaussian
>    (distribution) access, when THP=3Dalways; 95% CIs [1.27, 3.54]%,
>    [10.11, 14.81]% and [8.75, 13.64]% more total OPS, respectively,
>    for sequential access, random access and Gaussian access, when
>    THP=3Dnever.
>
> Our lab results
> ---------------
> To supplement the above results, we ran the following benchmark suites
> on 5.16-rc7 and found no regressions [10]. (These synthetic benchmarks
> are popular among MM developers, but we prefer large-scale A/B
> experiments to validate improvements.)
>       fs_fio_bench_hdd_mq      pft
>       fs_lmbench               pgsql-hammerdb
>       fs_parallelio            redis
>       fs_postmark              stream
>       hackbench                sysbenchthread
>       kernbench                tpcc_spark
>       memcached                unixbench
>       multichase               vm-scalability
>       mutilate                 will-it-scale
>       nginx
>
> [01] https://trends.google.com
> [02] https://lore.kernel.org/lkml/20211102002002.92051-1-bot@edi.works/
> [03] https://lore.kernel.org/lkml/20211009054315.47073-1-bot@edi.works/
> [04] https://lore.kernel.org/lkml/20211021194103.65648-1-bot@edi.works/
> [05] https://lore.kernel.org/lkml/20211109021346.50266-1-bot@edi.works/
> [06] https://lore.kernel.org/lkml/20211202062806.80365-1-bot@edi.works/
> [07] https://lore.kernel.org/lkml/20211209072416.33606-1-bot@edi.works/
> [08] https://lore.kernel.org/lkml/20211218071041.24077-1-bot@edi.works/
> [09] https://lore.kernel.org/lkml/20211122053248.57311-1-bot@edi.works/
> [10] https://lore.kernel.org/lkml/20220104202247.2903702-1-yuzhao@google.=
com/
>
> Read-world applications
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Third-party testimonials
> ------------------------
> Konstantin wrote [11]:
>    I have Archlinux with 8G RAM + zswap + swap. While developing, I
>    have lots of apps opened such as multiple LSP-servers for different
>    langs, chats, two browsers, etc... Usually, my system gets quickly
>    to a point of SWAP-storms, where I have to kill LSP-servers,
>    restart browsers to free memory, etc, otherwise the system lags
>    heavily and is barely usable.
>=20=20=20=20
>    1.5 day ago I migrated from 5.11.15 kernel to 5.12 + the LRU
>    patchset, and I started up by opening lots of apps to create memory
>    pressure, and worked for a day like this. Till now I had *not a
>    single SWAP-storm*, and mind you I got 3.4G in SWAP. I was never
>    getting to the point of 3G in SWAP before without a single
>    SWAP-storm.
>
> An anonymous user wrote [12]:
>    Using that v5 for some time and confirm that difference under heavy
>    load and memory pressure is significant.
>
> Shuang wrote [13]:
>    With the MGLRU, fio achieved 95% CIs [38.95, 40.26]%, [4.12, 6.64]%
>    and [9.26, 10.36]% higher throughput, respectively, for random
>    access, Zipfian (distribution) access and Gaussian (distribution)
>    access, when the average number of jobs per CPU is 1; 95% CIs
>    [42.32, 49.15]%, [9.44, 9.89]% and [20.99, 22.86]% higher throughput,
>    respectively, for random access, Zipfian access and Gaussian access,
>    when the average number of jobs per CPU is 2.
>
> Daniel wrote [14]:
>    With memcached allocating ~100GB of byte-addressable Optante,
>    performance improvement in terms of throughput (measured as queries
>    per second) was about 10% for a series of workloads.
>
> Large-scale deployments
> -----------------------
> The downstream kernels that have been using MGLRU include:
> 1. Android ARCVM [15]
> 2. Arch Linux Zen [16]
> 3. Chrome OS [17]
> 4. Liquorix [18]
> 5. post-factum [19]
> 6. XanMod [20]
>
> We've rolled out MGLRU to tens of millions of Chrome OS users and
> about a million Android users. Google's fleetwide profiling [21] shows
> an overall 40% decrease in kswapd CPU usage, in addition to
> improvements in other UX metrics, e.g., an 85% decrease in the number
> of low-memory kills at the 75th percentile and an 18% decrease in
> rendering latency at the 50th percentile.
>
> [11] https://lore.kernel.org/lkml/140226722f2032c86301fbd326d91baefe3d7d2=
3.camel@yandex.ru/
> [12] https://phoronix.com/forums/forum/software/general-linux-open-source=
/1301258-mglru-is-a-very-enticing-enhancement-for-linux-in-2022?p=3D1301275=
#post1301275
> [13] https://lore.kernel.org/lkml/20220105024423.26409-1-szhai2@cs.roches=
ter.edu/
> [14] https://lore.kernel.org/linux-mm/CA+4-3vksGvKd18FgRinxhqHetBS1hQekJE=
2gwco8Ja-bJWKtFw@mail.gmail.com/
> [15] https://chromium.googlesource.com/chromiumos/third_party/kernel
> [16] https://archlinux.org
> [17] https://chromium.org
> [18] https://liquorix.net
> [19] https://gitlab.com/post-factum/pf-kernel
> [20] https://xanmod.org
> [21] https://research.google/pubs/pub44271/
>
> Summery
> =3D=3D=3D=3D=3D=3D=3D
> The facts are:
> 1. The independent lab results and the real-world applications
>    indicate substantial improvements; there are no known regressions.
> 2. Thrashing prevention, working set estimation and proactive reclaim
>    work out of the box; there are no equivalent solutions.
> 3. There is a lot of new code; nobody has demonstrated smaller changes
>    with similar effects.
>
> Our options, accordingly, are:
> 1. Given the amount of evidence, the reported improvements will likely
>    materialize for a wide range of workloads.
> 2. Gauging the interest from the past discussions [22][23][24], the
>    new features will likely be put to use for both personal computers
>    and data centers.
> 3. Based on Google's track record, the new code will likely be well
>    maintained in the long term. It'd be more difficult if not
>    impossible to achieve similar effects on top of the existing
>    design.
>
> [22] https://lore.kernel.org/lkml/20201005081313.732745-1-andrea.righi@ca=
nonical.com/
> [23] https://lore.kernel.org/lkml/20210716081449.22187-1-sj38.park@gmail.=
com/
> [24] https://lore.kernel.org/lkml/20211130201652.2218636d@mail.inbox.lv/
>
> Yu Zhao (12):
>   mm: x86, arm64: add arch_has_hw_pte_young()
>   mm: x86: add CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
>   mm/vmscan.c: refactor shrink_node()
>   mm: multigenerational LRU: groundwork
>   mm: multigenerational LRU: minimal implementation
>   mm: multigenerational LRU: exploit locality in rmap
>   mm: multigenerational LRU: support page table walks
>   mm: multigenerational LRU: optimize multiple memcgs
>   mm: multigenerational LRU: runtime switch
>   mm: multigenerational LRU: thrashing prevention
>   mm: multigenerational LRU: debugfs interface
>   mm: multigenerational LRU: documentation
>
>  Documentation/admin-guide/mm/index.rst        |    1 +
>  Documentation/admin-guide/mm/multigen_lru.rst |  121 +
>  Documentation/vm/index.rst                    |    1 +
>  Documentation/vm/multigen_lru.rst             |  152 +
>  arch/Kconfig                                  |    9 +
>  arch/arm64/include/asm/pgtable.h              |   14 +-
>  arch/x86/Kconfig                              |    1 +
>  arch/x86/include/asm/pgtable.h                |    9 +-
>  arch/x86/mm/pgtable.c                         |    5 +-
>  fs/exec.c                                     |    2 +
>  fs/fuse/dev.c                                 |    3 +-
>  include/linux/cgroup.h                        |   15 +-
>  include/linux/memcontrol.h                    |   36 +
>  include/linux/mm.h                            |    8 +
>  include/linux/mm_inline.h                     |  214 ++
>  include/linux/mm_types.h                      |   78 +
>  include/linux/mmzone.h                        |  182 ++
>  include/linux/nodemask.h                      |    1 +
>  include/linux/page-flags-layout.h             |   19 +-
>  include/linux/page-flags.h                    |    4 +-
>  include/linux/pgtable.h                       |   17 +-
>  include/linux/sched.h                         |    4 +
>  include/linux/swap.h                          |    5 +
>  kernel/bounds.c                               |    3 +
>  kernel/cgroup/cgroup-internal.h               |    1 -
>  kernel/exit.c                                 |    1 +
>  kernel/fork.c                                 |    9 +
>  kernel/sched/core.c                           |    1 +
>  mm/Kconfig                                    |   50 +
>  mm/huge_memory.c                              |    3 +-
>  mm/memcontrol.c                               |   27 +
>  mm/memory.c                                   |   39 +-
>  mm/mm_init.c                                  |    6 +-
>  mm/page_alloc.c                               |    1 +
>  mm/rmap.c                                     |    7 +
>  mm/swap.c                                     |   55 +-
>  mm/vmscan.c                                   | 2831 ++++++++++++++++-
>  mm/workingset.c                               |  119 +-
>  38 files changed, 3908 insertions(+), 146 deletions(-)
>  create mode 100644 Documentation/admin-guide/mm/multigen_lru.rst
>  create mode 100644 Documentation/vm/multigen_lru.rst
>
> --=20
> 2.35.0.263.gb82422642f-goog
>
>

--=20
Cheers
~ Vaibhav
