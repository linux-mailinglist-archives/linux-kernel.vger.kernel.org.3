Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05434DC7B0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 14:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbiCQNg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 09:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiCQNgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 09:36:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B42AB1DA8D7;
        Thu, 17 Mar 2022 06:35:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AFA61515;
        Thu, 17 Mar 2022 06:35:38 -0700 (PDT)
Received: from e126645.arm.com (unknown [10.57.41.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AFEB73F766;
        Thu, 17 Mar 2022 06:35:33 -0700 (PDT)
From:   Pierre Gondois <Pierre.Gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ionela.Voinescu@arm.com, Lukasz.Luba@arm.com,
        Morten.Rasmussen@arm.com, Dietmar.Eggemann@arm.com,
        mka@chromium.org, daniel.lezcano@linaro.org,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Fuad Tabba <tabba@google.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hector Martin <marcan@marcan.st>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH v1 0/3] Enable EAS for CPPC/ACPI based systems
Date:   Thu, 17 Mar 2022 14:34:14 +0100
Message-Id: <20220317133419.3901736-1-Pierre.Gondois@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0. Overview

The current Energy Model (EM) for CPUs requires knowledge about CPU
performance states and their power consumption. Both of these
information is not available for ACPI based systems.

In ACPI, describing power efficiency of CPUs can be done through the
following arm specific field:

ACPI 6.4, s5.2.12.14 "GIC CPU Interface (GICC) Structure",
"Processor Power Efficiency Class field":
Describes the relative power efficiency of the associated pro-
cessor. Lower efficiency class numbers are more efficient than
higher ones (e.g. efficiency class 0 should be treated as more
efficient than efficiency class 1). However, absolute values
of this number have no meaning: 2 isn't necessarily half as
efficient as 1.

Add an 'efficiency_class' field to describe the relative power
efficiency of CPUs. CPUs relying on this field will have performance
states (power and frequency values) artificially created. Such EM will
be referred to as an artificial EM.

The artificial EM is used for the CPPC driver.

1. Dependencies

This patch-set has a dependency on:
 - [0/8] Introduce support for artificial Energy Model
https://lkml.org/lkml/2022/3/16/850
introduces a new callback in the Energy Model (EM) and prevents the
registration of devices using power values from an EM when the EM
is artificial. Not having this patch-set would break builds.
 - This patch-set based on linux-next.

2. Testing

This patch-set has been tested on a Juno-r2 and a Pixel4. Two types
of tests were done: energy testing, and performance testing.

The energy testing was done with 2 sets of tasks:
- homogeneous tasks (#Tasks at 5% utilization and 16ms period)
- heterogeneous tasks (#Tasks at 5|10|15% utilization and 16ms period).
  If a test has 3 tasks, then there is one with each utilization
  (1 at 5%, 1 at 10%, 1 at 15%).
Tasks spawn on the biggest CPU(s) of the platform. If there are
multiple big CPUs, tasks spawn alternatively on big CPUs.

2.1. Juno-r2 testing

The Juno-r2 has 6 CPUs:
- 4 little [0, 3-5], max_capa=383
- 2 big [1-2], max_capa=1024
Base kernel is v5.17-rc5.

2.1.1. Energy testing

The tests were done on:
- a system using a DT and the scmi cpufreq driver. Comparison
  is done between no-EAS and EAS.
- a system using ACPI and the cppc cpufreq driver. Comparison
  is done between CPPC-no-EAS and CPPC-EAS. CPPC-EAS uses
  the artificial EM.

Energy numbers come from the Juno energy counter, by summing
little and big clusters energy spending. There has been 5 iterations
of each test. Lower energy spending is better.

2.1.1.1. Homogeneous tasks

Energy results (Joules):
+--------+-------------------+-----------------------------+
|        |            no-EAS |                         EAS |
+--------+---------+---------+-------------------+---------+
| #Tasks |    Mean | ci(+/-) |              Mean | ci(+/-) |
+--------+---------+---------+-------------------+---------+
|    10  |   7.89  |    0.26 |     6.99 (-11.36) |    0.49 |
|    20  |  13.42  |    0.32 |    13.42 ( -0.02) |    0.08 |
|    30  |  21.43  |    0.98 |    21.62 ( +0.87) |    0.63 |
|    40  |  30.03  |    0.82 |    30.31 ( +0.94) |    0.37 |
|    50  |  43.19  |    0.56 |    43.50 ( +0.72) |    0.52 |
+--------+---------+---------+-------------------+---------+
+--------+-------------------+-----------------------------+
|        |       CPPC-no-EAS |                    CPPC-EAS |
+--------+---------+---------+-------------------+---------+
| #Tasks |    Mean | ci(+/-) |              Mean | ci(+/-) |
+--------+---------+---------+-------------------+---------+
|    10  |    7.86 |    0.37 |     5.64 (-28.23) |    0.05 |
|    20  |   13.36 |    0.20 |    10.92 (-18.31) |    0.31 |
|    30  |   19.28 |    0.34 |    18.30 ( -5.07) |    0.64 |
|    40  |   28.33 |    0.59 |    27.13 ( -4.23) |    0.42 |
|    50  |   40.78 |    0.58 |    40.77 ( -0.04) |    0.45 |
+--------+---------+---------+-------------------+---------+

Missed activations were measured while comparing CPPC-no-EAS/CPPC-EAS
energy values. They were of 0.00% for all tests and both
configurations. Missed activations start to appear in a significant
number starting from ~70 tasks.

2.1.1.2. Heterogeneous tasks

Energy results (Joules):
+--------+-------------------+-----------------------------+
|        |            no-EAS |                         EAS |
+--------+---------+---------+-------------------+---------+
| #Tasks |    Mean | ci(+/-) |              Mean | ci(+/-) |
+--------+---------+---------+-------------------+---------+
|     3  |    5.25 |    0.50 |    4.58 (-12.82%) |    0.07 |
|     9  |   12.30 |    0.28 |   11.45 ( -6.97%) |    0.34 |
|    15  |   20.06 |    1.32 |   20.60 (  2.66%) |    1.00 |
|    21  |   30.03 |    0.63 |   30.07 (  0.12%) |    0.41 |
+--------+---------+---------+-------------------+---------+
+--------+-------------------+-----------------------------+
|        |       CPPC-no-EAS |                    CPPC-EAS |
+--------+---------+---------+-------------------+---------+
| #Tasks |    Mean | ci(+/-) |              Mean | ci(+/-) |
+--------+---------+---------+-------------------+---------+
|     3  |    4.58 |    0.31 |    3.65 (-20.31%) |    0.05 |
|     9  |   11.53 |    0.20 |    9.23 (-19.97%) |    0.22 |
|    15  |   19.19 |    0.16 |   18.33 ( -4.49%) |    0.71 |
|    21  |   29.07 |    0.29 |   29.06 ( -0.01%) |    0.08 |
+--------+---------+---------+-------------------+---------+

Missed activations were measured while comparing CPPC-no-EAS/CPPC-EAS
energy values. They were of 0.00% for all tests and both
configurations. Missed activations start to appear in a significant
number starting from ~36 tasks.

2.1.1.3. Analysis:

The artificial EM often shows better energy gains than the EM,
especially for small loads. Indeed, the artificial power values
show a huge energy gain by placing tasks on little CPUs. The 6%
margin is always reached, so tasks are easily placed on little
CPUs. The margin is not always reached with real power values,
leading to tasks staying on big CPUs.

2.1.2. Performance testing

10 iterations of HackBench with the "--pipe --thread" options and
1000 loops. Compared value is the testing time in seconds. A lower
timing is better.
+----------------+-------------------+---------------------------+
|                |       CPPC-no-EAS |                  CPPC-EAS |
+--------+-------+---------+---------+-----------------+---------+
| Groups | Tasks |    Mean | ci(+/-) |           Mean  | ci(+/-) |
+--------+-------+---------+---------+-----------------+---------+
|      1 |    40 |    2.39 |    0.19 |   2.39 (-0.24%) |    0.07 |
|      2 |    80 |    5.56 |    0.48 |   5.28 (-5.02%) |    0.42 |
|      4 |   160 |   12.15 |    0.84 |  12.06 (-0.80%) |    0.48 |
|      8 |   320 |   23.03 |    0.94 |  23.12 (+0.36%) |    0.70 |
+--------+-------+---------+---------+-----------------+---------+

The performance is overall sligthly better, but stays in the margin
or error.


2.2. Pixel4 testing

Pixel4 has 7 CPUs:
- 4 little [0-3], max_capa=261
- 3 medium [4-6], max_capa=861
- 1 big [7], max_capa=1024

Base kernel is android-10.0.0_r0.81. The performance states advertised
in the DT were modified with performance states that would be generated
by this patch-set.
The artificial EM was set such as little CPUs > medium CPUs > big CPU,
meaning little CPUs are the most energy efficient.
Comparing the power/capacity ratio, little CPUs' performance states are
all more energy efficient than the medium CPUs' performance states.
This is wrong when comparing medium and big CPUs.

2.2.1. Energy testing

The 2 sets of tests (heterogeneous/homogeneous) were tested while
registering battery voltage and current (power is obtained by
multiplying them).
Voltage is averaged over a rolling period of ~11s and current over a
period of ~6s. Usb-C cable is plugged in but alimentation is cut.
Pixel4 is on airplane mode. The tests lasts 120s, the first 50s and
last 10s are trimmed as the power is slowly raising to reach a
plateau.
Are compared:
- android with EAS (but NO_FIND_BEST_TARGET is set):
  echo ENERGY_AWARE > /sys/kernel/debug/sched_features
  echo NO_FIND_BEST_TARGET > /sys/kernel/debug/sched_features
- android without EAS:
  echo NO_ENERGY_AWARE > /sys/kernel/debug/sched_features
- android with the artificial energy model
Lower energy spending is better.

2.2.1.2. Homogeneous tasks

Energy results (in uW):
+--------+-------------------+-----------------------------+
|        |       Without EAS |                    With EAS |
+--------+---------+---------+-------------------+---------+
| #Tasks |    Mean | ci(+/-) |              Mean | ci(+/-) |
+--------+---------+---------+-------------------+---------+
|    10  | 6.21+05 | 3.12+02 | 5.09+05 (-18.01%) | 2.18+03 |
|    20  | 9.12+05 | 9.71+02 | 7.91+05 (-13.26%) | 9.92+02 |
|    30  | 1.25+06 | 2.02+03 | 1.09+06 (-12.12%) | 2.00+03 |
|    40  | 2.05+06 | 5.15+03 | 1.38+06 (-32.36%) | 1.21+03 |
|    50  | 3.03+06 | 6.94+03 | 1.89+06 (-37.44%) | 3.21+03 |
+--------+---------+---------+-------------------+---------+
+--------+-------------------+-----------------------------+
|        |       Without EAS |                  With patch |
+--------+---------+---------+-------------------+---------+
| #Tasks |    Mean | ci(+/-) |              Mean | ci(+/-) |
+--------+---------+---------+-------------------+---------+
|    10  | 6.21+05 | 3.12+02 | 4.39+05 (-29.29%) | 5.63+02 |
|    20  | 9.12+05 | 9.71+02 | 7.30+05 (-19.90%) | 1.98+03 |
|    30  | 1.25+06 | 2.02+03 | 1.01+06 (-18.60%) | 1.72+03 |
|    40  | 2.05+06 | 5.15+03 | 1.38+06 (-32.60%) | 3.93+03 |
|    50  | 3.03+06 | 6.94+03 | 2.05+06 (-32.08%) | 1.25+04 |
+--------+---------+---------+-------------------+---------+

2.2.1.2. Heterogeneous tasks

Energy results (in uW):
+--------+-------------------+-----------------------------+
|        |       Without EAS |                    With EAS |
+--------+---------+---------+-------------------+---------+
| #Tasks |    Mean | ci(+/-) |              Mean | ci(+/-) |
+--------+---------+---------+-------------------+---------+
|     3  | 5.14+05 | 1.06+03 | 3.76+05 (-26.82%) | 4.58+02 |
|     9  | 8.52+05 | 1.18+03 | 7.25+05 (-14.96%) | 1.39+03 |
|    15  | 1.42+06 | 3.14+03 | 1.20+06 (-15.41%) | 1.06+04 |
|    21  | 2.73+06 | 3.49+03 | 1.49+06 (-45.47%) | 3.43+03 |
|    27  | 3.17+06 | 6.92+03 | 2.42+06 (-23.77%) | 8.43+03 |
+--------+---------+---------+-------------------+---------+
+--------+-------------------+-----------------------------+
|        |       Without EAS |                  With patch |
+--------+---------+---------+-------------------+---------+
| #Tasks |    Mean | ci(+/-) |              Mean | ci(+/-) |
+--------+---------+---------+-------------------+---------+
|     3  | 5.14+05 | 1.06+03 | 3.82+05 (-25.70%) | 7.67+02 |
|     9  | 8.52+05 | 1.18+03 | 7.05+05 (-17.30%) | 9.79+02 |
|    15  | 1.42+06 | 3.14+03 | 1.05+06 (-26.00%) | 1.15+03 |
|    21  | 2.73+06 | 3.49+03 | 1.53+06 (-43.68%) | 2.23+03 |
|    27  | 3.17+06 | 6.92+03 | 2.86+06 ( -9.77%) | 4.26+03 |
+--------+---------+---------+-------------------+---------+

2.2.1.2. Analysis

Similarly to Juno, the artificial performance states show a huge
gain to place tasks on small CPUs, leading to better energy results.

2.2.2. Performance testing

10 iterations of PcMark. Compared value is the final score
(PcmaWorkv3Score). A bigger score is better.
+----------------+-------------------------+-------------------------+
|    Without EAS |                With EAS |              With patch |
+------+---------+---------------+---------+---------------+---------+
| Mean | ci(+/-) |          Mean | ci(+/-) |          Mean | ci(+/-) |
+------+---------+---------------+---------+---------------+---------+
| 8026 |      86 |          8003 |      74 | 7840 (-2.00%) |     104 |
+------+---------+---------------+---------+---------------+---------+

Performance is lower, but still in the margin of error.


3. Summary

The artificial performance states show overall better energy results
and a small performance decrease. They lead to a more aggressive task
placement on the most energy efficient CPUs, and this explains the
results.

 arch/arm64/kernel/smp.c        |   1 +
 drivers/cpufreq/cppc_cpufreq.c | 212 +++++++++++++++++++++++++++++++++
 2 files changed, 213 insertions(+)

-- 
2.25.1

