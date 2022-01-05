Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1526B484CE7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 04:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbiAEDek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 22:34:40 -0500
Received: from slate.cs.rochester.edu ([128.151.167.14]:55642 "EHLO
        slate.cs.rochester.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiAEDeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 22:34:36 -0500
X-Greylist: delayed 2874 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jan 2022 22:34:32 EST
Received: from node1x10a.cs.rochester.edu (node1x10a.cs.rochester.edu [192.5.53.74])
        by slate.cs.rochester.edu (8.14.7/8.14.7) with ESMTP id 2052ikd2018776
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 4 Jan 2022 21:44:46 -0500
Received: from node1x10a.cs.rochester.edu (localhost [127.0.0.1])
        by node1x10a.cs.rochester.edu (8.15.2/8.15.1) with ESMTP id 2052ikc5026449;
        Tue, 4 Jan 2022 21:44:46 -0500
Received: (from szhai2@localhost)
        by node1x10a.cs.rochester.edu (8.15.2/8.15.1/Submit) id 2052ieJE026448;
        Tue, 4 Jan 2022 21:44:40 -0500
From:   Shuang Zhai <szhai2@cs.rochester.edu>
To:     yuzhao@google.com
Cc:     Michael@michaellarabel.com, ak@linux.intel.com,
        akpm@linux-foundation.org, axboe@kernel.dk,
        catalin.marinas@arm.com, corbet@lwn.net,
        dave.hansen@linux.intel.com, hannes@cmpxchg.org, hdanton@sina.com,
        jsbarnes@google.com, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@suse.de, mhocko@kernel.org,
        page-reclaim@google.com, riel@surriel.com,
        torvalds@linux-foundation.org, vbabka@suse.cz, will@kernel.org,
        willy@infradead.org, x86@kernel.org, ying.huang@intel.com
Subject: Re: [PATCH v6 0/9] Multigenerational LRU Framework
Date:   Tue,  4 Jan 2022 21:44:23 -0500
Message-Id: <20220105024423.26409-1-szhai2@cs.rochester.edu>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20220104202227.2903605-1-yuzhao@google.com>
References: <20220104202227.2903605-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fio / pmem benchmark with MGLRU

TLDR
====
With the MGLRU, fio achieved 95% CIs [38.95, 40.26]%, [4.12, 6.64]%
and [9.26, 10.36]% higher throughput, respectively, for random
access, Zipfian (distribution) access and Gaussian (distribution)
access, when the average number of jobs per CPU is 1; 95% CIs
[42.32, 49.15]%, [9.44, 9.89]% and [20.99, 22.86]% higher throughput,
respectively, for random access, Zipfian access and Gaussian access,
when the average number of jobs per CPU is 2.

Background
==========
Many applications running on warehouse-scale computers heavily use
POSIX read(2)/write(2) and page cache, e.g., Apache Kafka, a
distributed streaming application used by "more than 80% of all
Fortune 100 companies" [1] and PostgreSQL, "the world's most advanced
open source relational database" [2].

Intel DC Persistent Memory, as an affordable alternative to DRAM, can
deliver large capacity and data persistence. Specifically, the device
used in this benchmark can achieve up to 36 GiB/s and 15 GiB/s
throughput, respectively, for sequential and random read access.

Our research group at the University of Rochester focuses on the
intersection of computer architecture and system software. My current
research interest is memory management on tiered memory systems.

Matrix
======
Kernels: version [+ patchset]
* Baseline: 5.15
* Patched: 5.15 + MGLRU

Access patterns (4KB read):
* Random (uniform)
* Zipfian (theta 0.8; the recommended range is 0-2)
* Gaussian (deviation 40; the possible range is 0-100)

Concurrency conditions (the average number of jobs per CPU):
* 1
* 2

Total file size (GB): 400 (~2x memory capacity)
Total configurations: 12
Data points per configuration: 10
Total run duration (minutes) per data point: ~30

Notes
-----
1. All files were stored on pmem. Each job had the exclusive access to
   a single file.
2. Due to the hardware limitation when accessing remote pmem [3],
   numactl was used to bind the fio processes to the local pmem. Only
   one of the two NUMA nodes was used during the benchmark.
3. During dry runs, we observed that the throughput doesn't improve
   beyond 2 jobs per CPU for random access. Moreover, the patched
   kernel showed consistent improvements over the baseline kernel
   when using 3 or 4 jobs per CPU.
4. We wanted to simulate the real-world scenarios and therefore used
   default swap configuration (on). Moreover, we didn't observe any
   negative impact on performance with dry runs that disabled swap.

Procedure
=========
<for each kernel>
    grub2-reboot <baseline, patched>
    <for each concurrency condition>
        <generate test files>
        <for each access pattern>
            <for each data point>
                <reboot>
                <run fio>

Hardware
--------
Memory (GiB per socket): 192
CPU (# per socket): 40
Pmem (GiB per socket): 768

Fio
---
$ fio -version
fio-3.28

$ numactl --cpubind=0 --membind=0 fio --name=randread \
  --directory=/mnt/pmem/ --size={10G, 5G} --io_size=1000TB \
  --time_based --numjobs={40, 80} --ioengine=io_uring \
  --ramp_time=20m --runtime=10m --iodepth=128 \
  --iodepth_batch_submit=32 --iodepth_batch_complete=32 \
  --rw=randread --random_distribution={random, zipf:0.8, normal:40} \
  --direct=0 --norandommap --group_reporting

Results
=======
Throughput
----------
The patched kernel achieved substantially higher throughput for all
three access patterns and two concurrency conditions. Specifically,
comparing the patched with the baseline kernel, fio achieved 95% CIs
[38.95, 40.26]%, [4.12, 6.64]% and [9.26, 10.36]% higher throughput,
respectively, for random access, Zipfian access, and Gaussian access,
when the average number of jobs per CPU is 1; 95% CIs [42.32, 49.15]%,
[9.44, 9.89]% and [20.99, 22.86]% higher throughput, respectively, for
random access, Zipfian access and Gaussian access, when the average
number of jobs per CPU is 2.

+---------------------+---------------+---------------+
| Mean MiB/s [95% CI] | 1 job / CPU   | 2 jobs / CPU  |
+---------------------+---------------+---------------+
| Random access       | 8411 / 11742  | 8417 / 12267  |
|                     | [3275, 3387]  | [3562, 4137]  |
+---------------------+---------------+---------------+
| Zipfian access      | 14576 / 15360 | 12932 / 14181 |
|                     | [600, 967]    | [1220, 1279]  |
+---------------------+---------------+---------------+
| Gaussian access     | 14564 / 15993 | 11513 / 14037 |
|                     | [1348, 1508]  | [2417, 2631]  |
+---------------------+---------------+---------------+
Table 1. Throughput comparison between the baseline and the patched
         kernels

The patched kernel exhibited less degradation in throughput when
running more concurrent jobs. Comparing 2 jobs per CPU with 1 job per
CPU, fio achieved 95% CIs [-11.54, -11.02]%, [-16.91, -12.01]% and
[-21.61, -20.30]% higher throughput, respectively, for random access,
Zipfian access and Gaussian access, when using the baseline kernel;
95% CIs [2.04, 6.92]%, [-8.86, -6.48]% and [-12.83, -11.64]% higher
throughput, respectively, for random access, Zipfian access and
Gaussian access, when using the patched kernel. There were no
statistically significant changes in throughput for the rest of the
test matrix.

+---------------------+-----------------+----------------+
| Mean MiB/s [95% CI] | Baseline kernel | Patched kernel |
+---------------------+-----------------+----------------+
| Random access       | 8411 / 8417     | 11741 / 12267  |
|                     | [-55, 69]       | [239, 812]     |
+---------------------+-----------------+----------------+
| Zipfian access      | 14576 / 12932   | 15360/ 14181   |
|                     | [-1682, -1607]  | [-1361, -996]  |
+---------------------+-----------------+----------------+
| Gaussian access     | 14565 / 11513   | 15993 / 14037  |
|                     | [-3147, -2957]  | [-2051, -1861] |
+---------------------+-----------------+----------------+
Table 2. Throughput comparison between 1 job per CPU and 2 jobs per
         CPU

Tail Latency
------------
Comparing the patched with the baseline kernel, fio experienced 95%
CIs [-41.77, -40.35]% and [6.64, 13.95]% higher latency at the 99th
percentile, respectively, for random access and Gaussian access, when
the average number of jobs per CPU is 1; 95% CIs [-41.97, -40.59]%,
[-47.74, -47.04]% and [-51.32, -50.27]% higher latency at the 99th
percentile, respectively, for random access, Zipfian access and
Gaussian access, when the average number of jobs per CPU is 2. There
were no statistically significant changes in latency at the 99th
percentile for the rest of the test matrix.

+------------------------------+----------------+------------------+
| 99th percentile latency (us) | 1 job / CPU    | 2 jobs / CPU     |
+------------------------------+----------------+------------------+
| Random access                | 12466 / 7347   | 25560 / 15008    |
|                              | [-5207, -5030] | [-10729, -10375] |
+------------------------------+----------------+------------------+
| Zipfian access               | 3395 / 3382    | 14563 / 7661     |
|                              | [-131, 105]    | [-6953,-6850]    |
+------------------------------+----------------+------------------+
| Gaussian access              | 3280 / 3618    | 15611 / 7681     |
|                              | [217, 457]     | [-8012, -7848]   |
+------------------------------+----------------+------------------+
Table 3. Comparison of the 99th percentile latency between the
         baseline and the patched kernels (lower is better)

Metrics collected during each run are available at:
https://github.com/zhaishuang1/MglruPerf/tree/master

A peek at 5.16-rc6
------------------
We also ran the benchmark on 5.16-rc6 with swap off. However, we
haven't collected enough data points to establish a 95% CI. Here are
a few numbers we've collected:

+----------------+------------+----------+----------------+----------+
| Access pattern | Jobs / CPU | 5.16-rc6 | 5.16-rc6-mglru | % change |
+----------------+------------+----------+----------------+----------+
| Random access  | 1          | 7467     | 10440          | 39.8%    |
+----------------+------------+----------+----------------+----------+
| Random access  | 2          | 7504     | 13417          | 78.8%    |
+----------------+------------+----------+----------------+----------+
| Random access  | 3          | 7511     | 13954          | 85.8%    |
+----------------+------------+----------+----------------+----------+
| Random access  | 4          | 7542     | 13925          | 84.6%    |
+----------------+------------+----------+----------------+----------+

Reference
=========
[1] https://kafka.apache.org/documentation/#design_filesystem
[2] https://www.postgresql.org/docs/11/runtime-config-resource.html#RUNTIME-CONFIG-RESOURCE-MEMORY
[3] System Evaluation of the Intel Optane byte-addressable NVM, MEMSYS 2019.

Appendix
========
Throughput
----------
$ cat raw_data_fio.r
v <- c(
    # baseline 40 procs random
    8467.89, 8428.34, 8383.32, 8253.12, 8464.65, 8307.42, 8424.78, 8434.44, 8474.88, 8468.26,
    # baseline 40 procs zipf
    14570.44, 14598.03, 14550.74, 14640.29, 14591.4, 14573.35, 14503.18, 14613.39, 14598.61, 14522.27,
    # baseline 40 procs gaussian
    14504.95, 14427.23, 14652.19, 14519.47, 14557.97, 14617.92, 14555.87, 14446.94, 14678.12, 14688.33,
    # baseline 80 procs random
    8427.51, 8267.23, 8437.48, 8432.37, 8441.4, 8454.26, 8413.13, 8412.44, 8444.36, 8444.32,
    # baseline 80 procs zipf
    12980.12, 12946.43, 12911.95, 12925.83, 12952.75, 12841.44, 12920.35, 12924.19, 12944.38, 12967.72,
    # baseline 80 procs gaussian
    11666.29, 11624.72, 11454.82, 11482.36, 11462.24, 11379.46, 11691.5, 11471.19, 11402.08, 11494.13,
    # patched 40 procs random
    11706.69, 11778.1, 11774.07, 11750.07, 11744.97, 11766.65, 11727.79, 11708.41, 11745.3, 11716.45,
    # patched 40 procs zipf
    15498.31, 14647.94, 15423.35, 15467.32, 15467.05, 15342.49, 15511.34, 15414.06, 15401.1, 15431.57,
    # patched 40 procs gaussian
    15957.86, 15957.13, 16022.69, 16035.85, 16150.2, 15904.5, 15943.36, 16036.78, 16025.95, 15900.56,
    # patched 80 procs random
    12568.51, 11772.25, 11622.15, 12057.66, 11971.72, 12693.36, 12399.71, 12553.23, 12242.74, 12793.34,
    # patched 80 procs zipf
    14194.78, 14213.61, 14148.66, 14182.35, 14183.91, 14192.23, 14163.2, 14179.7, 14162.12, 14196.34,
    # patched 80 procs gaussian
    14084.86, 13706.34, 14089.42, 14058.4, 14096.74, 14108.06, 14043.41, 14072.15, 14088.44, 14024.51
)

a <- array(v, dim = c(10, 3, 2, 2))

# baseline vs patched
for (concurr in 1:2) {
    for (dist in 1:3) {
        r <- t.test(a[, dist, concurr, 1], a[, dist, concurr, 2])
        print(r)

        p <- r$conf.int * 100 / r$estimate[1]
        if ((p[1] > 0 && p[2] < 0) || (p[1] < 0 && p[2] > 0)) {
            s <- sprintf("concurr%d dist%d: no significance", concurr, dist)
        } else {
            s <- sprintf("concurr%d dist%d: [%.2f, %.2f]%%", concurr, dist, -p[2], -p[1])
        }
        print(s)
    }
}

# low concurr vs high concurr
for (kern in 1:2) {
    for (dist in 1:3) {
        r <- t.test(a[, dist, 1, kern], a[, dist, 2, kern])
        print(r)

        p <- r$conf.int * 100 / r$estimate[1]
        if ((p[1] > 0 && p[2] < 0) || (p[1] < 0 && p[2] > 0)) {
            s <- sprintf("kern%d dist%d: no significance", kern, dist)
        } else {
            s <- sprintf("kern%d dist%d: [%.2f, %.2f]%%", kern, dist, -p[2], -p[1])
        }
        print(s)
    }
}

$ R -q -s -f raw_data_fio.r

	Welch Two Sample t-test

data:  a[, dist, concurr, 1] and a[, dist, concurr, 2]
t = -132.15, df = 11.177, p-value < 2.2e-16
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -3386.514 -3275.766
sample estimates:
mean of x mean of y
  8410.71  11741.85

[1] "concurr1 dist1: [38.95, 40.26]%"

	Welch Two Sample t-test

data:  a[, dist, concurr, 1] and a[, dist, concurr, 2]
t = -9.5917, df = 9.4797, p-value = 3.463e-06
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -967.8353 -600.7307
sample estimates:
mean of x mean of y
 14576.17  15360.45

[1] "concurr1 dist2: [4.12, 6.64]%"

	Welch Two Sample t-test

data:  a[, dist, concurr, 1] and a[, dist, concurr, 2]
t = -37.744, df = 17.33, p-value < 2.2e-16
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -1508.328 -1348.850
sample estimates:
mean of x mean of y
 14564.90  15993.49

[1] "concurr1 dist3: [9.26, 10.36]%"

	Welch Two Sample t-test

data:  a[, dist, concurr, 1] and a[, dist, concurr, 2]
t = -30.144, df = 9.3334, p-value = 1.281e-10
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -4137.381 -3562.653
sample estimates:
mean of x mean of y
  8417.45  12267.47

[1] "concurr2 dist1: [42.32, 49.15]%"

	Welch Two Sample t-test

data:  a[, dist, concurr, 1] and a[, dist, concurr, 2]
t = -92.164, df = 13.276, p-value < 2.2e-16
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -1279.417 -1220.931
sample estimates:
mean of x mean of y
 12931.52  14181.69

[1] "concurr2 dist2: [9.44, 9.89]%"

	Welch Two Sample t-test

data:  a[, dist, concurr, 1] and a[, dist, concurr, 2]
t = -49.453, df = 17.863, p-value < 2.2e-16
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -2631.656 -2417.052
sample estimates:
mean of x mean of y
 11512.88  14037.23

[1] "concurr2 dist3: [20.99, 22.86]%"

	Welch Two Sample t-test

data:  a[, dist, 1, kern] and a[, dist, 2, kern]
t = -0.22947, df = 16.403, p-value = 0.8213
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -68.88155  55.40155
sample estimates:
mean of x mean of y
  8410.71   8417.45

[1] "kern1 dist1: no significance"

	Welch Two Sample t-test

data:  a[, dist, 1, kern] and a[, dist, 2, kern]
t = 91.86, df = 17.875, p-value < 2.2e-16
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 1607.021 1682.287
sample estimates:
mean of x mean of y
 14576.17  12931.52

[1] "kern1 dist2: [-11.54, -11.02]%"

	Welch Two Sample t-test

data:  a[, dist, 1, kern] and a[, dist, 2, kern]
t = 67.477, df = 17.539, p-value < 2.2e-16
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 2956.815 3147.225
sample estimates:
mean of x mean of y
 14564.90  11512.88

[1] "kern1 dist3: [-21.61, -20.30]%"

	Welch Two Sample t-test

data:  a[, dist, 1, kern] and a[, dist, 2, kern]
t = -4.1443, df = 9.0781, p-value = 0.002459
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -812.1507 -239.0833
sample estimates:
mean of x mean of y
 11741.85  12267.47

[1] "kern2 dist1: [2.04, 6.92]%"

	Welch Two Sample t-test

data:  a[, dist, 1, kern] and a[, dist, 2, kern]
t = 14.566, df = 9.1026, p-value = 1.291e-07
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
  996.0064 1361.5196
sample estimates:
mean of x mean of y
 15360.45  14181.69

[1] "kern2 dist2: [-8.86, -6.48]%"

	Welch Two Sample t-test

data:  a[, dist, 1, kern] and a[, dist, 2, kern]
t = 43.826, df = 15.275, p-value < 2.2e-16
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 1861.263 2051.247
sample estimates:
mean of x mean of y
 15993.49  14037.23

[1] "kern2 dist3: [-12.83, -11.64]%"

99th Percentile Latency
-----------------------
$ cat raw_data_fio_lat.r
v <- c(
    # baseline 40 procs random
    12649, 12387, 12518, 12518, 12518, 12387, 12518, 12518, 12387, 12256,
    # baseline 40 procs zipf
    3458, 3294, 3425, 3294, 3294, 3359, 3752, 3326, 3294, 3458,
    # baseline 40 procs gaussian
    3326, 3458, 3195, 3392, 3326, 3228, 3228, 3326, 3130, 3195,
    # baseline 80 procs random
    25560, 26084, 25560, 25560, 25297, 25297, 25822, 25560, 25560, 25297,
    # baseline 80 procs zipf
    14484, 14615, 14615, 14484, 14484, 14615, 14615, 14615, 14615, 14484,
    # baseline 80 procs gaussian
    15664, 15664, 15533, 15533, 15533, 15664, 15795, 15533, 15664, 15533,
    # patched 40 procs random
    7439, 7242, 7373, 7373, 7373, 7439, 7242, 7308, 7308, 7373,
    # patched 40 procs zipf
    3261, 3425, 3392, 3294, 3359, 3556, 3228, 3490, 3458, 3359,
    # patched 40 procs gaussian
    3687, 3523, 3556, 3523, 3752, 3654, 3884, 3490, 3392, 3720,
    # patched 80 procs random
    15008, 15008, 15008, 15008, 15008, 15008, 15008, 15008, 15008, 15008,
    # patched 80 procs zipf
    7701, 7635, 7701, 7701, 7635, 7635, 7701, 7635, 7635, 7635,
    # patched 80 procs gaussian
    7635, 7898, 7701, 7635, 7635, 7635, 7635, 7635, 7701, 7701
)

a <- array(v, dim = c(10, 3, 2, 2))

# baseline vs patched
for (concurr in 1:2) {
    for (dist in 1:3) {
        r <- t.test(a[, dist, concurr, 1], a[, dist, concurr, 2])
        print(r)

        p <- r$conf.int * 100 / r$estimate[1]
        if ((p[1] > 0 && p[2] < 0) || (p[1] < 0 && p[2] > 0)) {
            s <- sprintf("concurr%d dist%d: no significance", concurr, dist)
        } else {
            s <- sprintf("concurr%d dist%d: [%.2f, %.2f]%%", concurr, dist, -p[2], -p[1])
        }
        print(s)
    }
}

$ R -q -s -f raw_data_fio_lat.r

	Welch Two Sample t-test

data:  a[, dist, concurr, 1] and a[, dist, concurr, 2]
t = 123.52, df = 15.287, p-value < 2.2e-16
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 5030.417 5206.783
sample estimates:
mean of x mean of y
  12465.6    7347.0

[1] "concurr1 dist1: [-41.77, -40.35]%"

	Welch Two Sample t-test

data:  a[, dist, concurr, 1] and a[, dist, concurr, 2]
t = 0.23667, df = 16.437, p-value = 0.8158
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -104.7812  131.1812
sample estimates:
mean of x mean of y
   3395.4    3382.2

[1] "concurr1 dist2: no significance"

	Welch Two Sample t-test

data:  a[, dist, concurr, 1] and a[, dist, concurr, 2]
t = -5.9754, df = 16.001, p-value = 1.94e-05
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -457.5065 -217.8935
sample estimates:
mean of x mean of y
   3280.4    3618.1

[1] "concurr1 dist3: [6.64, 13.95]%"

	Welch Two Sample t-test

data:  a[, dist, concurr, 1] and a[, dist, concurr, 2]
t = 134.89, df = 9, p-value = 3.437e-16
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 10374.74 10728.66
sample estimates:
mean of x mean of y
  25559.7   15008.0

[1] "concurr2 dist1: [-41.97, -40.59]%"

	Welch Two Sample t-test

data:  a[, dist, concurr, 1] and a[, dist, concurr, 2]
t = 288.1, df = 13.292, p-value < 2.2e-16
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 6849.566 6952.834
sample estimates:
mean of x mean of y
  14562.6    7661.4

[1] "concurr2 dist2: [-47.74, -47.04]%"

	Welch Two Sample t-test

data:  a[, dist, concurr, 1] and a[, dist, concurr, 2]
t = 203.64, df = 17.798, p-value < 2.2e-16
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 7848.616 8012.384
sample estimates:
mean of x mean of y
  15611.6    7681.1

[1] "concurr2 dist3: [-51.32, -50.27]%"
