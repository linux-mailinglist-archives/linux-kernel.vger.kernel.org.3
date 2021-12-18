Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD31B479949
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 08:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbhLRHMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 02:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbhLRHMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 02:12:46 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95230C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 23:12:45 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id 132so4428707qkj.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 23:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edi.works; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PwL8wIkTOyjgtNkwFSM8qrD5vBbMoqMOLnchknihk3s=;
        b=Epy4M/J0wTytOQUJ31lQGrSX0OVU/I4MS9mB+9f11skFGJ+BVzl4xtw6edGxzVPH+b
         CgIQxiezHoNqDcV8+ZF0ZFUFhYBmE18X0NP4t4VHIl1G/SebjA4cWQU2vqHmuHIfzZDc
         /ZwBsSBduEjKQy+ZPG9BEsefJBNWa4SJNDuqN+1JP1+Jjh6EKfXAmAFbkSQfJCouqvkv
         gpNGgu4WQSYOrka56NY5n0vSxWAOWl4DJjC+kXxd1uIN5+zIwaL3M4S3erD6KwLVmQ7e
         KBh7eN5hfw/MvvwCAEcpTzLFPT+CmT1aBeR/YssFkXdvQi1Te2Po3UdcNbsa+jvbPrzU
         DPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PwL8wIkTOyjgtNkwFSM8qrD5vBbMoqMOLnchknihk3s=;
        b=ZfJPNWUJFgO4WjAjpfrkQx40qInw2ncu8Jk1UfnF/JCgpHoV0AIuMjfE2m4ohDSgpK
         BTHdHZYG+a6pF2f/eBcBJBCmoTpf2CkxpUYD0aVdePnDK4odbwE6x8tWJgyKT/z+dmjk
         uRjCDlBTbYubwgh37Xt3qWSPHiwppwpn5mv0ioDOO/0PZZUujD7IRgFK7K1trm/H/va8
         nNsy6p2eF53X9Fbb7qjRM0uijAgt2E/gvJDQ++XauHzHfGThPPJMi+KHH+4xJTUNe4k2
         itrdQ1ZrHNrBvmpe9X66Y/e1C2JwcyA9zGPC+XnB/0kXHazZ7xMPuyYN9IX45llLZ3Ot
         u9Sw==
X-Gm-Message-State: AOAM530HWswC5u6xFuaEtKr+/EuXwFk8+e26qV9sJJUWqhF7oqqtAuxu
        x+oD0Lc0jQRE+5Nkr15KpUvvXg==
X-Google-Smtp-Source: ABdhPJyN9fxKJ74zGQh5vpfuZzaqrMa1rtoR2ARC6DljWGqrO4v6kA4L/RaCaKdU1gPeG+rjubRlVw==
X-Received: by 2002:ae9:ef0e:: with SMTP id d14mr4063248qkg.773.1639811564491;
        Fri, 17 Dec 2021 23:12:44 -0800 (PST)
Received: from localhost.localdomain (c-67-169-44-201.hsd1.ca.comcast.net. [67.169.44.201])
        by smtp.gmail.com with ESMTPSA id d6sm8108004qtq.15.2021.12.17.23.12.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Dec 2021 23:12:43 -0800 (PST)
From:   bot@edi.works
To:     yuzhao@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, corbet@lwn.net,
        michael@michaellarabel.com, sofia.trinh@edi.works
Subject: Re: [PATCH v5 00/10] Multigenerational LRU Framework
Date:   Fri, 17 Dec 2021 23:10:41 -0800
Message-Id: <20211218071041.24077-1-bot@edi.works>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211111041510.402534-1-yuzhao@google.com>
References: <20211111041510.402534-1-yuzhao@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel / PostgreSQL benchmark with MGLRU

TLDR
====
With the MGLRU, PostgreSQL achieved 95% CI [1.75, 6.42]% more
transactions per minute (TPM) under the high-concurrency conditions,
when swap was off; 95% CIs [12.82, 18.69]% and [22.70, 46.86]% more
TPM, respectively, under the medium- and the high-concurrency
conditions, when swap was on. There were no statistically significant
changes in TPM for the rest of the test matrix.

Background
==========
Memory overcommit can increase utilization and, if carried out
properly, can also increase throughput. The challenges are to improve
working set estimation and to optimize page reclaim. The risks are
performance degradation and OOM kills. Short of overcoming the
challenges, the only way to reduce the risks is to underutilize
memory.

PostgreSQL is one of the most popular open-source RDBMSs. HammerDB is
the leading open-source benchmarking software derived from the TPC
specifications. OLTP is the most important use case for RDBMSs.

Matrix
======
Kernels: version [+ patchset]
* Baseline: 5.15
* Patched: 5.15 + MGLRU

Swap configurations:
* Off
* On (vm.swappiness=1)

Concurrency conditions: average # of users per CPU
* Low: ~4
* Medium: ~8
* High: ~12

Total configurations: 12
Data points per configuration: 10
Total run duration (minutes) per data point: ~50

Procedure
=========
The latest MGLRU patchset for the 5.15 kernel is available at
git fetch https://linux-mm.googlesource.com/page-reclaim \
    refs/changes/30/1430/2

The baseline and the patched 5.15 kernel images are available at
https://drive.google.com/drive/folders/1eMkQleAFGkP2vzM_JyRA21oKE0ESHBqp

<install and configure OS>
hammerdbcli auto prep_tpcc.tcl
systemctl stop postgresql
e2image <backup /mnt/data>

<for each kernel>
    grub-set-default <baseline, patched>
    <for each swap configuration>
        <swapoff, swapon>
        <update /etc/postgresql/13/main/postgresql.conf>
        <for each concurrency condition>
            <update run_tpcc.tcl>
            <for each data point>
                systemctl stop postgresql
                e2image <restore /mnt/data>
                reboot
                hammerdbcli auto run_tpcc.tcl
                <collect TPM>

Hardware
========
Memory (GB): 256
CPU (total #): 48
NVMe SSD (GB): 2048

OS
==
$ cat /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=21.10
DISTRIB_CODENAME=impish
DISTRIB_DESCRIPTION="Ubuntu 21.10"

$ cat /proc/swaps
Filename          Type          Size          Used     Priority
/swap.img         partition     67108860      0        -2

$ cat /proc/sys/vm/overcommit_memory
1

$ cat /proc/sys/vm/swappiness
1

$ cat /sys/fs/cgroup/user.slice/memory.min
4294967296

PostgreSQL
==========
$ pg_config --version
PostgreSQL 13.5 (Ubuntu 13.5-0ubuntu0.21.10.1)

$ cat /etc/postgresql/13/main/postgresql.conf
<existing parameters>

data_directory = '/mnt/data'
max_connections = 1000
shared_buffers = <swapoff: 120GB, swapon: 150GB>
temp_buffers = 1GB
work_mem = 1GB
maintenance_work_mem = 1GB
logical_decoding_work_mem = 1GB
bgwriter_delay = 1000ms
bgwriter_lru_maxpages = 100000
bgwriter_lru_multiplier = 1.0
bgwriter_flush_after = 0
effective_io_concurrency = 1000
wal_compression = on
wal_writer_delay = 1000ms
wal_writer_flush_after = 128MB
max_wal_size = 100GB
min_wal_size = 10GB
checkpoint_flush_after = 0
effective_cache_size = 150GB

<existing parameters>

HammerDB
========
$ hammerdbcli -h
HammerDB CLI v4.3
Copyright (C) 2003-2021 Steve Shaw
Type "help" for a list of commands
Usage: hammerdbcli [ auto [ script_to_autoload.tcl  ] ]

$ cat prep_tpcc.tcl
dbset db pg
diset connection pg_host /var/run/postgresql
diset tpcc pg_count_ware 2400
diset tpcc pg_num_vu 48
buildschema
waittocomplete
quit

$ cat run_tpcc.tcl
dbset db pg
diset connection pg_host /var/run/postgresql
diset tpcc pg_total_iterations 20000000
diset tpcc pg_driver timed
diset tpcc pg_rampup 30
diset tpcc pg_duration 10
diset tpcc pg_allwarehouse true
vuset logtotemp 1
vuset unique 1
loadscript
vuset vu <200, 400, 600>
vucreate
vurun
runtimer 3000
vudestroy

Results
=======
Comparing the patched with the baseline kernel, PostgreSQL achieved
95% CI [1.75, 6.42]% more TPM under the high-concurrency conditions,
when swap was off; 95% CIs [12.82, 18.69]% and [22.70, 46.86]% more
TPM, respectively, under the medium- and the high-concurrency
conditions, when swap was on. There were no statistically significant
changes in TPM for the rest of the test matrix.

+--------------------+--------------------+--------------------+
| Mean TPM [95% CI]  | Swap off           | Swap on            |
+--------------------+--------------------+--------------------+
| Low concurrency    | 466430 / 467521    | 475060 / 475047    |
|                    | [-6931, 9112]      | [-7431, 7405]      |
+--------------------+--------------------+--------------------+
| Medium concurrency | 453871 / 459592    | 388245 / 449409    |
|                    | [-774, 12216]      | [49755, 72572]     |
+--------------------+--------------------+--------------------+
| High concurrency   | 443014 / 461112    | 157106 / 211752    |
|                    | [7771, 28423]      | [35664, 73627]     |
+--------------------+--------------------+--------------------+
Table 1. Comparison between the baseline and the patched kernels

Comparing swap on with swap off, PostgreSQL achieved 95% CIs [0.46,
3.24]%, [-16.91, -12.01]% and [-68.64, -60.43]% more TPM,
respectively, under the low-, the medium- and the high-concurrency
conditions, when using the baseline kernel; 95% CIs [-3.76, -0.67]%
and [-56.70, -51.46]% more TPM, respectively, under the medium- and
the high-concurrency conditions, when using the patched kernel. There
were no statistically significant changes in TPM for the rest of the
test matrix.

+--------------------+--------------------+--------------------+
| Mean TPM [95% CI]  | Baseline kernel    | Patched kernel     |
+--------------------+--------------------+--------------------+
| Low concurrency    | 466430 / 475060    | 467521 / 475047    |
|                    | [2160, 15100]      | [-1204, 16256]     |
+--------------------+--------------------+--------------------+
| Medium concurrency | 453871 / 388245    | 459592 / 449409    |
|                    | [-76757, -54494]   | [-17292, -3073]    |
+--------------------+--------------------+--------------------+
| High concurrency   | 443014 / 157106    | 461112 / 211752    |
|                    | [-304097, -267718] | [-261442, -237275] |
+--------------------+--------------------+--------------------+
Table 2. Comparison between swap off and swap on

Metrics collected during each run are available at
https://github.com/ediworks/KernelPerf/tree/master/mglru/postgres/5.15

Appendix
========
$ cat raw_data_postgres.r
v <- c(
    # baseline swapoff 200vu
    462379, 462998, 463363, 464949, 465605, 466977, 467290, 468658, 469682, 472404,
    # baseline swapoff 400vu
    446111, 446305, 447339, 448043, 450604, 452160, 453846, 461309, 465101, 467893,
    # baseline swapoff 600vu
    434061, 435645, 435974, 436026, 436581, 439138, 442121, 445990, 454687, 469926,
    # baseline swapon 200vu
    466546, 467298, 467882, 469185, 472114, 473868, 475217, 481319, 483246, 493931,
    # baseline swapon 400vu
    367605, 371855, 373991, 380763, 388456, 389768, 395270, 403536, 404457, 406749,
    # baseline swapon 600vu
    123036, 127174, 131863, 150724, 155572, 158938, 170892, 179302, 183783, 189785,
    # patched swapoff 200vu
    456088, 457197, 457341, 458069, 459630, 472291, 474782, 475727, 478015, 486071,
    # patched swapoff 400vu
    452681, 453758, 455800, 457675, 458812, 459304, 460897, 461252, 465269, 470475,
    # patched swapoff 600vu
    448009, 452465, 453655, 454333, 456111, 456304, 465371, 471431, 475092, 478351,
    # patched swapon 200vu
    465540, 468681, 471682, 473134, 473148, 474015, 475734, 476691, 481974, 489873,
    # patched swapon 400vu
    436300, 440202, 441955, 445214, 445817, 452176, 452379, 456931, 457724, 465393,
    # patched swapon 600vu
    195315, 197186, 199332, 199667, 209630, 211162, 214787, 222783, 230000, 237667
)

a <- array(v, dim = c(10, 3, 2, 2))

# baseline vs patched
for (swap in 1:2) {
    for (vu in 1:3) {
        r <- t.test(a[, vu, swap, 1], a[, vu, swap, 2])
        print(r)

        p <- r$conf.int * 100 / r$estimate[1]
        if ((p[1] > 0 && p[2] < 0) || (p[1] < 0 && p[2] > 0)) {
            s <- sprintf("swap%d vu%d: no significance", swap, vu)
        } else {
            s <- sprintf("swap%d vu%d: [%.2f, %.2f]%%", swap, vu, -p[2], -p[1])
        }
        print(s)
    }
}

# swapoff vs swapon
for (kern in 1:2) {
    for (vu in 1:3) {
        r <- t.test(a[, vu, 1, kern], a[, vu, 2, kern])
        print(r)

        p <- r$conf.int * 100 / r$estimate[1]
        if ((p[1] > 0 && p[2] < 0) || (p[1] < 0 && p[2] > 0)) {
            s <- sprintf("kern%d vu%d: no significance", kern, vu)
        } else {
            s <- sprintf("kern%d vu%d: [%.2f, %.2f]%%", kern, vu, -p[2], -p[1])
        }
        print(s)
    }
}

$ R -q -s -f raw_data_postgres.r

        Welch Two Sample t-test

data:  a[, vu, swap, 1] and a[, vu, swap, 2]
t = -0.3009, df = 10.521, p-value = 0.7694
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -9112.559  6931.359
sample estimates:
mean of x mean of y
 466430.5  467521.1

[1] "swap1 vu1: no significance"

        Welch Two Sample t-test

data:  a[, vu, swap, 1] and a[, vu, swap, 2]
t = -1.8711, df = 15.599, p-value = 0.08021
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -12216.64    774.24
sample estimates:
mean of x mean of y
 453871.1  459592.3

[1] "swap1 vu2: no significance"

        Welch Two Sample t-test

data:  a[, vu, swap, 1] and a[, vu, swap, 2]
t = -3.6832, df = 17.919, p-value = 0.001712
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -28423.515  -7771.085
sample estimates:
mean of x mean of y
 443014.9  461112.2

[1] "swap1 vu3: [1.75, 6.42]%"

        Welch Two Sample t-test

data:  a[, vu, swap, 1] and a[, vu, swap, 2]
t = 0.0038109, df = 17.001, p-value = 0.997
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -7405.094  7431.894
sample estimates:
mean of x mean of y
 475060.6  475047.2

[1] "swap2 vu1: no significance"

        Welch Two Sample t-test

data:  a[, vu, swap, 1] and a[, vu, swap, 2]
t = -11.413, df = 15.222, p-value = 7.301e-09
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -72572.5 -49755.7
sample estimates:
mean of x mean of y
 388245.0  449409.1

[1] "swap2 vu2: [12.82, 18.69]%"

        Welch Two Sample t-test

data:  a[, vu, swap, 1] and a[, vu, swap, 2]
t = -6.1414, df = 14.853, p-value = 1.97e-05
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -73627.83 -35664.17
sample estimates:
mean of x mean of y
 157106.9  211752.9

[1] "swap2 vu3: [22.70, 46.86]%"

        Welch Two Sample t-test

data:  a[, vu, 1, kern] and a[, vu, 2, kern]
t = -2.9241, df = 11.372, p-value = 0.0134
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -15100.107  -2160.093
sample estimates:
mean of x mean of y
 466430.5  475060.6

[1] "kern1 vu1: [0.46, 3.24]%"

        Welch Two Sample t-test

data:  a[, vu, 1, kern] and a[, vu, 2, kern]
t = 12.629, df = 14.192, p-value = 4.129e-09
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 54494.92 76757.28
sample estimates:
mean of x mean of y
 453871.1  388245.0

[1] "kern1 vu2: [-16.91, -12.01]%"

        Welch Two Sample t-test

data:  a[, vu, 1, kern] and a[, vu, 2, kern]
t = 34.005, df = 12.822, p-value = 5.981e-14
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 267718.5 304097.5
sample estimates:
mean of x mean of y
 443014.9  157106.9

[1] "kern1 vu3: [-68.64, -60.43]%"

        Welch Two Sample t-test

data:  a[, vu, 1, kern] and a[, vu, 2, kern]
t = -1.8367, df = 15.057, p-value = 0.08607
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -16256.986   1204.786
sample estimates:
mean of x mean of y
 467521.1  475047.2

[1] "kern2 vu1: no significance"

        Welch Two Sample t-test

data:  a[, vu, 1, kern] and a[, vu, 2, kern]
t = 3.061, df = 14.554, p-value = 0.008153
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
  3073.49 17292.91
sample estimates:
mean of x mean of y
 459592.3  449409.1

[1] "kern2 vu2: [-3.76, -0.67]%"

        Welch Two Sample t-test

data:  a[, vu, 1, kern] and a[, vu, 2, kern]
t = 43.656, df = 16.424, p-value < 2.2e-16
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 237275.9 261442.7
sample estimates:
mean of x mean of y
 461112.2  211752.9

[1] "kern2 vu3: [-56.70, -51.46]%"
