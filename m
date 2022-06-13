Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFB65483E4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 12:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241071AbiFMJsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240204AbiFMJsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:48:20 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3212E193D8;
        Mon, 13 Jun 2022 02:48:15 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LM69j4P5XzRj1n;
        Mon, 13 Jun 2022 17:44:57 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 17:48:03 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 17:48:03 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [RFC 00/13] perf: Add perf kwork
Date:   Mon, 13 Jun 2022 17:45:52 +0800
Message-ID: <20220613094605.208401-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes, we need to analyze time properties of kernel work such as irq,
softirq, and workqueue, such as delay and running time of specific interrupts.
Currently, these events have kernel tracepoints, but perf tool does not
directly analyze the delay of these events

The perf-kwork tool is used to trace time properties of kernel work
(such as irq, softirq, and workqueue), including runtime, latency,
and timehist, using the infrastructure in the perf tools to allow
tracing extra targets

test case:

  # perf kwork report

    Kwork Name                | Cpu  | Total Runtime | Frequency | Max runtime   | Max runtime start   | Max runtime end     |
   ---------------------------------------------------------------------------------------------------------------------------
    (s)RCU:9                  | 0007 |      3.488 ms |      1258 |      0.145 ms |    3398384.220013 s |    3398384.220157 s |
    (s)NET_RX:3               | 0003 |      1.866 ms |       156 |      0.042 ms |    3398385.629764 s |    3398385.629806 s |
    (s)TIMER:1                | 0000 |      1.799 ms |       117 |      0.055 ms |    3398385.568033 s |    3398385.568088 s |
    (w)0xffff9c66e563ee98     | 0006 |      1.561 ms |         5 |      0.351 ms |    3398384.060021 s |    3398384.060371 s |
    (s)RCU:9                  | 0003 |      0.819 ms |       138 |      0.110 ms |    3398384.220018 s |    3398384.220128 s |
    (s)TIMER:1                | 0006 |      0.548 ms |       149 |      0.022 ms |    3398385.404029 s |    3398385.404051 s |
    (s)RCU:9                  | 0005 |      0.525 ms |        52 |      0.147 ms |    3398384.208007 s |    3398384.208154 s |
    ata_piix:14               | 0005 |      0.508 ms |        10 |      0.098 ms |    3398382.044203 s |    3398382.044301 s |
    (s)RCU:9                  | 0001 |      0.446 ms |        77 |      0.117 ms |    3398384.220017 s |    3398384.220134 s |
    (s)RCU:9                  | 0000 |      0.439 ms |       103 |      0.104 ms |    3398384.196011 s |    3398384.196115 s |
    (w)0xffffffffc0793420     | 0006 |      0.376 ms |        57 |      0.017 ms |    3398386.700048 s |    3398386.700065 s |
    (s)RCU:9                  | 0002 |      0.319 ms |        50 |      0.103 ms |    3398384.196011 s |    3398384.196113 s |
    (w)0xffff9c6698efbc08     | 0006 |      0.303 ms |        68 |      0.012 ms |    3398387.723996 s |    3398387.724008 s |
    (w)0xffff9c66e321b1d0     | 0006 |      0.303 ms |        49 |      0.019 ms |    3398384.048042 s |    3398384.048061 s |
    virtio4-input.0:38        | 0003 |      0.300 ms |       156 |      0.022 ms |    3398388.234593 s |    3398388.234615 s |
    (s)RCU:9                  | 0006 |      0.297 ms |        92 |      0.066 ms |    3398384.228012 s |    3398384.228077 s |
    (s)TIMER:1                | 0003 |      0.291 ms |       162 |      0.024 ms |    3398388.648012 s |    3398388.648036 s |
    (s)SCHED:7                | 0003 |      0.271 ms |       103 |      0.005 ms |    3398384.780022 s |    3398384.780027 s |
    (s)SCHED:7                | 0000 |      0.263 ms |        74 |      0.015 ms |    3398385.636036 s |    3398385.636050 s |
    (s)RCU:9                  | 0004 |      0.256 ms |        63 |      0.083 ms |    3398384.196015 s |    3398384.196099 s |
    (s)SCHED:7                | 0006 |      0.248 ms |       100 |      0.012 ms |    3398385.404051 s |    3398385.404063 s |
    (s)TIMER:1                | 0007 |      0.224 ms |       227 |      0.008 ms |    3398381.916020 s |    3398381.916028 s |
    ...
    --------------------------------------------------------------------------------------------------------------------------

  # perf kwork latency

    Kwork Name                | Cpu  | Avg delay     | Frequency | Max delay     | Max delay start     | Max delay end       |
   ---------------------------------------------------------------------------------------------------------------------------
    (w)0xffff9c66f37deee0     | 0007 |      2.786 ms |         4 |     11.099 ms |    3398385.632034 s |    3398385.643133 s |
    (w)0xffff9c6698efbc08     | 0006 |      0.033 ms |        39 |      0.383 ms |    3398385.630078 s |    3398385.630461 s |
    (s)SCHED:7                | 0000 |      0.027 ms |        74 |      0.060 ms |    3398385.568029 s |    3398385.568089 s |
    (s)RCU:9                  | 0006 |      0.007 ms |        92 |      0.023 ms |    3398385.884016 s |    3398385.884039 s |
    (s)RCU:9                  | 0002 |      0.006 ms |        50 |      0.019 ms |    3398387.420012 s |    3398387.420031 s |
    (s)RCU:9                  | 0004 |      0.006 ms |        63 |      0.019 ms |    3398384.412019 s |    3398384.412039 s |
    (s)SCHED:7                | 0001 |      0.006 ms |        30 |      0.015 ms |    3398386.908018 s |    3398386.908034 s |
    (s)RCU:9                  | 0005 |      0.006 ms |        52 |      0.016 ms |    3398387.492007 s |    3398387.492024 s |
    (w)0xffff9c66e3f35040     | 0007 |      0.006 ms |         6 |      0.009 ms |    3398385.701201 s |    3398385.701210 s |
    (w)0xffff9c66e45a79d0     | 0006 |      0.005 ms |         1 |      0.005 ms |    3398383.836011 s |    3398383.836016 s |
    (w)0xffff9c66e50f40b8     | 0006 |      0.005 ms |         5 |      0.006 ms |    3398386.076145 s |    3398386.076151 s |
    (s)SCHED:7                | 0004 |      0.005 ms |        27 |      0.013 ms |    3398380.412016 s |    3398380.412029 s |
    (s)SCHED:7                | 0002 |      0.005 ms |        23 |      0.014 ms |    3398387.420013 s |    3398387.420027 s |
    (s)RCU:9                  | 0001 |      0.005 ms |        77 |      0.021 ms |    3398386.908017 s |    3398386.908038 s |
    (s)SCHED:7                | 0003 |      0.005 ms |       103 |      0.027 ms |    3398388.648010 s |    3398388.648036 s |
    (s)SCHED:7                | 0007 |      0.005 ms |        66 |      0.013 ms |    3398385.632026 s |    3398385.632039 s |
    (s)TIMER:1                | 0007 |      0.005 ms |       227 |      0.015 ms |    3398385.636010 s |    3398385.636025 s |
    (s)SCHED:7                | 0005 |      0.005 ms |        20 |      0.010 ms |    3398384.924020 s |    3398384.924030 s |
    (s)TIMER:1                | 0000 |      0.004 ms |       117 |      0.009 ms |    3398385.568024 s |    3398385.568033 s |
    (s)TIMER:1                | 0004 |      0.004 ms |        61 |      0.009 ms |    3398383.632005 s |    3398383.632014 s |
    (s)RCU:9                  | 0003 |      0.004 ms |       138 |      0.014 ms |    3398384.324014 s |    3398384.324028 s |
    ...
   ---------------------------------------------------------------------------------------------------------------------------
    INFO: 2.133% skipped events (383 including 86 raise, 297 entry, 0 exit)

  # perf kwork timehist
   Runtime start      Runtime end        Cpu     Kwork name                 Runtime     Delaytime
                                                 (TYPE)NAME:NUM             (msec)      (msec)
   -----------------  -----------------  ------  -------------------------  ----------  ----------
      3398378.780013     3398378.780014  [0007]  (s)TIMER:1                      0.001       0.005
      3398378.780013     3398378.780014  [0000]  (s)TIMER:1                      0.001       0.006
      3398378.780012     3398378.780015  [0004]  (s)TIMER:1                      0.002       0.005
      3398378.780014     3398378.780017  [0007]  (s)SCHED:7                      0.003       0.004
      3398378.780014     3398378.780017  [0000]  (s)SCHED:7                      0.002       0.005
      3398378.780015     3398378.780017  [0004]  (s)SCHED:7                      0.002       0.005
      3398378.780017     3398378.780018  [0004]  (s)RCU:9                        0.001       0.008
      3398378.780017     3398378.780023  [0000]  (s)RCU:9                        0.006       0.008
      3398378.780017     3398378.780030  [0007]  (s)RCU:9                        0.013       0.008
      3398378.784008     3398378.784008  [0007]  (s)TIMER:1                      0.000       0.003
      3398378.784008     3398378.784009  [0000]  (s)TIMER:1                      0.001       0.003
      3398378.784009     3398378.784009  [0000]  (s)RCU:9                        0.001       0.003
      3398378.784009     3398378.784010  [0007]  (s)RCU:9                        0.001       0.003
      3398378.784650     3398378.784653  [0003]  virtio4-input.0:38              0.003
      3398378.784656     3398378.784672  [0003]  (s)NET_RX:3                     0.016       0.004
      3398378.788007     3398378.788008  [0007]  (s)TIMER:1                      0.000       0.002
      3398378.788008     3398378.788009  [0007]  (s)RCU:9                        0.001       0.003
      3398378.788010     3398378.788011  [0000]  (s)TIMER:1                      0.001       0.003
      3398378.788011     3398378.788012  [0000]  (s)RCU:9                        0.001       0.003
      3398378.788009     3398378.788012  [0003]  (s)TIMER:1                      0.004       0.003
      3398378.788013     3398378.788015  [0003]  (s)SCHED:7                      0.002       0.006
      3398378.788015     3398378.788016  [0003]  (s)RCU:9                        0.001       0.009
      3398378.788019     3398378.788021  [0003]  (w)0xffff9c66f36deee0           0.002       0.009
      3398378.792007     3398378.792008  [0007]  (s)TIMER:1                      0.000       0.002
      3398378.792008     3398378.792009  [0000]  (s)TIMER:1                      0.000       0.002
      3398378.792009     3398378.792014  [0000]  (s)RCU:9                        0.005       0.003
    ...

Yang Jihong (13):
  perf kwork: New tool
  perf kwork: Add irq record support
  perf kwork: Add softirq record support
  perf kwork: Add workqueue record support
  tools lib: Add list_last_entry_or_null
  perf kwork: Implement perf kwork report
  perf kwork: Add irq report support
  perf kwork: Add softirq report support
  perf kwork: Add workqueue report support
  perf kwork: Implement perf kwork latency
  perf kwork: Add softirq latency support
  perf kwork: Add workqueue latency support
  perf kwork: Implement perf kwork timehist

 tools/include/linux/list.h              |   11 +
 tools/perf/Build                        |    1 +
 tools/perf/Documentation/perf-kwork.txt |  173 ++
 tools/perf/builtin-kwork.c              | 1915 +++++++++++++++++++++++
 tools/perf/builtin.h                    |    1 +
 tools/perf/command-list.txt             |    1 +
 tools/perf/perf.c                       |    1 +
 7 files changed, 2103 insertions(+)
 create mode 100644 tools/perf/Documentation/perf-kwork.txt
 create mode 100644 tools/perf/builtin-kwork.c

-- 
2.30.GIT

