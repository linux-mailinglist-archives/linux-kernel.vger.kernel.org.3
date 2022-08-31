Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481EC5A74BB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 06:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiHaERg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 00:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiHaERe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 00:17:34 -0400
Received: from mail-oo1-xc4a.google.com (mail-oo1-xc4a.google.com [IPv6:2607:f8b0:4864:20::c4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223FFA8CFE
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 21:17:33 -0700 (PDT)
Received: by mail-oo1-xc4a.google.com with SMTP id q12-20020a056820028c00b0044b61786c50so6229767ood.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 21:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=2WLkoSjROr4dVg417JvRyW3lh8V45iB1BA/WLXoVDwU=;
        b=Q/NeHipnwhKmx3pm3k4gks3o8edSuETNqiubQqLpCOTog2jIvfr7k3DvFS/jBq0dyh
         twz6SUtKyMZXsokG28aUtkvyel454tb89m/BHuekcTWU2R+6Y6k6Iyw82P2J5tA0V/qA
         5K9izJtVosFUTabjVjHk+MiujLLrzfstFnkQhRZQAhbF2rxu3RGYI3irnR0rEYZHTa/j
         X5HDdmbvWm5Y6GCfbCSSRwzdrev/X6ALbSGOJdaKI1+VinJPPL2ZJWgbRwBkLsrMwLzO
         n9OLG1TXYU+dXASpYchWbP7elmYi4Svrt9OsU29QeTSH0TkVWRR5vjDLpgEPkNnWSkIX
         Jy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=2WLkoSjROr4dVg417JvRyW3lh8V45iB1BA/WLXoVDwU=;
        b=aZUwk3tSq3d1ld/8dlGdc3YQ7yHpV449r6cUzrE26bQcsvJqK8MzEI/nkhkaip7agB
         ds+12xcAxe0E/bceMvDEBuIKjipY/mEYLTC/dVApS9fFXy2/f5aR73BFHmXZrYcWZwWm
         7+bbMC4NWAhmC1UAheOuUn8bpb4puVIfilZjF8XSkLsqSQVScfQE6cIUlofVjKZcVtJD
         EKW++EKTKk2aO5NZS4/y7qqTynE7fS6Q0VqmRol28OvhAHAta9hxgkbbBYDGLLmpqGe9
         5sJbiO2W2JqzgNS43ps72YLzyU5TSdSvqkX/ikjTvJ56KEU+EbPKyZEFwY5z+OtdE8kK
         f+qw==
X-Gm-Message-State: ACgBeo0naDb/t/g+fyLdwynt4AmNQ22GI6VQyaSLn6WKaguJMqUz4260
        0pnwWrVRKtcrhOCXbLxw9OCCKDl9Dwo=
X-Google-Smtp-Source: AA6agR75Q0XVPlf3icInNGSIRS0IdIWElwixKSUIneiAq5sNLZxjdixFpkzHz4f5gvYnzc9T2TZqXFHJGLI=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:103:daa9:a72c:751a])
 (user=yuzhao job=sendgmr) by 2002:a9d:27a8:0:b0:637:8ef:ba3d with SMTP id
 c37-20020a9d27a8000000b0063708efba3dmr9853871otb.48.1661919452445; Tue, 30
 Aug 2022 21:17:32 -0700 (PDT)
Date:   Tue, 30 Aug 2022 22:17:31 -0600
In-Reply-To: <20220815071332.627393-1-yuzhao@google.com>
Message-Id: <20220831041731.3836322-1-yuzhao@google.com>
Mime-Version: 1.0
References: <20220815071332.627393-1-yuzhao@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: OpenWrt / MIPS benchmark with MGLRU
From:   Yu Zhao <yuzhao@google.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        page-reclaim@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TLDR
====
RAM utilization  Throughput (95% CI)  P99 Latency (95% CI)
----------------------------------------------------------
~90%             NS                   NS
~110%            +[12, 16]%           -[20, 22]%

Abbreviations
=============
CI:   confidence interval
NS:   no statistically significant difference
DUT:  device under test
ATE:  automatic test equipment

Rational
========
1. OpenWrt is the most popular distro for WiFi routers; many of its
   targets use big endianness [1].
2. 4 out of the top 5 bestselling WiFi routers in the US use MIPS [2];
   MIPS uses software-managed TLB.
3. Memcached is the best available memory benchmark on OpenWrt;
   admittedly such a use case is very limited in the real world.

Hardware
========
DUT: Ubiquiti EdgeRouter (ER-8) [3]

DUT # cat /proc/cpuinfo
system type             : UBNT_E200 (CN6120p1.1-800-NSP)
machine                 : Unknown
processor               : 0
cpu model               : Cavium Octeon II V0.1
BogoMIPS                : 1600.00
wait instruction        : yes
microsecond timers      : yes
tlb_entries             : 128
extra interrupt vector  : yes
hardware watchpoint     : yes, count: 2, address/irw mask: [0x0ffc, 0x0ffb]
isa                     : mips1 mips2 mips3 mips4 mips5 mips32r1 mips32r2 mips64r1 mips64r2
ASEs implemented        :
Options implemented     : tlb rixiex 4kex octeon_cache 32fpr prefetch mcheck ejtag llsc rixi lpa vtag_icache userlocal perf_cntr_intr_bit perf
shadow register sets    : 1
kscratch registers      : 3
package                 : 0
core                    : 0
VCED exceptions         : not available
VCEI exceptions         : not available

processor               : 1
cpu model               : Cavium Octeon II V0.1
BogoMIPS                : 1600.00
wait instruction        : yes
microsecond timers      : yes
tlb_entries             : 128
extra interrupt vector  : yes
hardware watchpoint     : yes, count: 2, address/irw mask: [0x0ffc, 0x0ffb]
isa                     : mips1 mips2 mips3 mips4 mips5 mips32r1 mips32r2 mips64r1 mips64r2
ASEs implemented        :
Options implemented     : tlb rixiex 4kex octeon_cache 32fpr prefetch mcheck ejtag llsc rixi lpa vtag_icache userlocal perf_cntr_intr_bit perf
shadow register sets    : 1
kscratch registers      : 3
package                 : 0
core                    : 1
VCED exceptions         : not available
VCEI exceptions         : not available

DUT # cat /proc/meminfo
MemTotal:        1991964 kB
MemFree:         1917304 kB
MemAvailable:    1896856 kB
Buffers:               4 kB
Cached:            33464 kB
SwapCached:            0 kB
Active:             1316 kB
Inactive:          33500 kB
Active(anon):       1316 kB
Inactive(anon):    33496 kB
Active(file):          0 kB
Inactive(file):        4 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:        995324 kB
SwapFree:         995324 kB
Dirty:                 0 kB
Writeback:             0 kB
AnonPages:          1360 kB
Mapped:             2688 kB
Shmem:             33464 kB
KReclaimable:       8244 kB
Slab:              19772 kB
SReclaimable:       8244 kB
SUnreclaim:        11528 kB
KernelStack:        1056 kB
PageTables:          336 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:     1991304 kB
Committed_AS:      38916 kB
VmallocTotal: 1069547512 kB
VmallocUsed:        4856 kB
VmallocChunk:          0 kB
Percpu:              272 kB

Software
========
DUT # cat /etc/openwrt_release
DISTRIB_ID='OpenWrt'
DISTRIB_RELEASE='22.03.0-rc6'
DISTRIB_REVISION='r19590-042d558536'
DISTRIB_TARGET='octeon/generic'
DISTRIB_ARCH='mips64_octeonplus'
DISTRIB_DESCRIPTION='OpenWrt 22.03.0-rc6 r19590-042d558536'
DISTRIB_TAINTS='no-all no-ipv6'

DUT # uname -a
Linux OpenWrt 6.0.0-rc3+ #0 SMP Sun Jul 31 15:12:47 2022 mips64 GNU/Linux

DUT # cat /proc/swaps
Filename    Type       Size    Used  Priority
/dev/zram0  partition  995324  0     100

DUT # memcached -V
memcached 1.6.9

DUT # cat /etc/config/memcached
config memcached
        option user 'memcached'
        option maxconn '1024'
        option listen '0.0.0.0'
        option port '11211'
        option memory '6400'

ATE $ memtier_benchmark -v
memtier_benchmark 1.3.0
Copyright (C) 2011-2022 Redis Ltd.
This is free software.  You may redistribute copies of it under the terms of
the GNU General Public License <http://www.gnu.org/licenses/gpl.html>.
There is NO WARRANTY, to the extent permitted by law.

Procedure
=========
ATE $ cat run_benchmark_matrix.sh
run_memtier_benchmark()
{
    # boot to kernel $3

    # populate dataset
    memtier_benchmark/memtier_benchmark -s $DUT_IP -p 11211 \
        -P memcache_binary -n allkeys -c 1 --ratio 1:0 --pipeline 8 \
        --key-minimum=1 --key-maximum=$2 --key-pattern=P:P \
        -d 1000

    # access dataset using Guassian pattern
    memtier_benchmark/memtier_benchmark -s $DUT_IP -p 11211 \
        -P memcache_binary --test-time $1 -c 1 --ratio 0:1 \
        --pipeline 8 --key-minimum=1 --key-maximum=$2 \
        --key-pattern=G:G --randomize --distinct-client-seed

    # collect results
}

run_duration_secs=1200
mem_utils_90_110=(1600000 2000000)
kernels=("baseline" "patched")

for mem_util in ${mem_utils_90_110[@]}; do
    for kernel in ${kernels[@]}; do
        run_memtier_benchmark $run_duration_secs $mem_util $kernel
    done
done

Results
=======
Baseline                                 90% RAM utilization
------------------------------------------------------------
Ops/sec   Avg. Lat.  p50 Lat.  p99 Lat.  p99.9 Lat.  KB/sec
------------------------------------------------------------
48550.71  0.65687    0.48700   2.84700   5.56700     1812.25
48600.55  0.65629    0.48700   2.86300   5.59900     1814.11
48562.37  0.65674    0.48700   2.84700   5.50300     1812.68
48556.66  0.65688    0.48700   2.84700   5.53500     1812.47
48619.50  0.65600    0.48700   2.87900   5.63100     1814.82
48579.74  0.65654    0.48700   2.84700   5.56700     1813.33
48593.25  0.65764    0.48700   2.86300   5.56700     1814.10
48535.52  0.65716    0.48700   2.86300   5.56700     1811.68
48587.24  0.65645    0.48700   2.83100   5.50300     1813.61
48541.92  0.65704    0.48700   2.81500   5.47100     1811.92

MGLRU                                    90% RAM utilization
------------------------------------------------------------
Ops/sec   Avg. Lat.  p50 Lat.  p99 Lat.  p99.9 Lat.  KB/sec
------------------------------------------------------------
48622.38  0.65594    0.48700   2.81500   5.47100     1814.92
48537.74  0.65715    0.48700   2.84700   5.53500     1811.76
48586.82  0.65646    0.48700   2.84700   5.50300     1813.59
48552.44  0.65695    0.48700   2.83100   5.43900     1812.31
48557.35  0.65680    0.49500   2.83100   5.53500     1812.49
48625.48  0.65593    0.48700   2.81500   5.43900     1815.04
48655.75  0.65557    0.48700   2.84700   5.53500     1816.17
48625.67  0.65595    0.48700   2.84700   5.53500     1815.04
48622.22  0.65600    0.48700   2.84700   5.47100     1814.91
48617.10  0.65610    0.48700   2.84700   5.56700     1814.73

Baseline                                110% RAM utilization
------------------------------------------------------------
Ops/sec   Avg. Lat.  p50 Lat.  p99 Lat.  p99.9 Lat.  KB/sec
------------------------------------------------------------
19813.79  1.61245    0.63100   17.79100  31.74300    744.91
20328.29  1.57158    0.62300   17.27900  31.10300    764.25
20104.12  1.58913    0.62300   17.40700  31.10300    755.82
20342.03  1.57053    0.61500   17.27900  30.84700    764.77
19688.05  1.62268    0.62300   17.91900  31.35900    740.18
19607.31  1.62943    0.63900   17.91900  31.23100    737.15
19250.96  1.65963    0.65500   17.91900  31.10300    723.75
20182.79  1.58290    0.63100   17.40700  30.84700    758.78
20181.88  1.58299    0.63100   17.40700  30.84700    758.75
20615.90  1.54963    0.62300   17.02300  30.84700    775.06

MGLRU                                   110% RAM utilization
------------------------------------------------------------
Ops/sec   Avg. Lat.  p50 Lat.  p99 Lat.  p99.9 Lat.  KB/sec
------------------------------------------------------------
22911.33  1.39405    0.61500   13.69500  28.79900    861.36
22339.08  1.42989    0.61500   14.07900  30.07900    839.85
23394.22  1.36521    0.59900   13.56700  29.05500    879.51
22521.48  1.41830    0.61500   13.88700  29.82300    846.70
22678.10  1.40818    0.61500   13.82300  29.69500    852.59
22344.50  1.42952    0.61500   14.07900  29.95100    840.05
23245.65  1.37406    0.60700   13.50300  28.92700    873.93
23140.17  1.38032    0.59900   13.69500  29.18300    869.96
23003.34  1.38856    0.61500   13.63100  29.05500    864.82
22937.52  1.39253    0.61500   13.69500  29.43900    862.35

Flame graphs
------------
Baseline: https://drive.google.com/file/d/1-Ac4HMPAyZIqxtvKerUTqNNAgBLhpX9R
MGLRU: https://drive.google.com/file/d/1-9x0W2yIYeiRvXWiYRzL6niTqW7zCVPX

References
==========
[1] https://openwrt.org/docs/platforms/start
[2] https://www.amazon.com/bestsellers/pc/300189
[3] https://openwrt.org/toh/ubiquiti/edgerouter
