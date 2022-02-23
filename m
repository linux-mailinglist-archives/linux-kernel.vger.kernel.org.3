Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E478A4C0FD2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 11:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239486AbiBWKFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 05:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239481AbiBWKE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 05:04:57 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EC48A6E8;
        Wed, 23 Feb 2022 02:04:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djnmFORSuTBjOdUV9KL2/aBUG6aah3Z/EWeNOObPHz+rXUwlQl4HI2H7ZZV54X+uFQJ0RcHCQewGt82mJ9RVbv2nY+rwrGta1aK11br8q62ifcfT2x+0+3fQhQwq8aOrhAboU4ciPVJAv5ItsYx72Ld9NK9HiXInW6xp6TpJ3HfPLCQRwu4wmFMciXrfkjvQKYrkYF9vKfognfzSMISlSKzvwOtKAo8qbyuWBUGC56dv05fDSzp6Es1PbmtdSBFGhCv7KIatTzF9MiAxLLK+g4nY3WVRvW1t7AskNpCl7vzz7t3a1VssIpKfvqJXOVSSXzqWgGkQhZ4zvlvpwhRlCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kJQJIdwAtz3lkZeyAZGB8SSXBDon/isBXmUvxeMXL8=;
 b=ZIPUMtDIdWC9EGGoNVgXHVt/wjyBaIXtWxjOf7I5vmB9+z4pkPWqozsHow0dCBkKC8sIPXLofK4GLuO/9OzZkpSDMap7QVAHxsDNkFh6kOs8jJnNATG34wswjNN5pleLEqorOjDPFo6jHTqJrRAaC096UtxYR4VHUCl6F3SJ7kV+JFCPupCBd0JHmt9yAXHPAM2y+eNJzqCQeoHyzMNpvC/qKic9gElOcVl9Po4qFRy+LcH1a2TdClTTmE1kd0ty4ju768gcsFvR9UnhLkIKK45S8qRbl3UTVpA+SjW+bEkV3m5xdhsgXRcHw0sud4xj7y2oaZsROR2N5hBRd8/E8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kJQJIdwAtz3lkZeyAZGB8SSXBDon/isBXmUvxeMXL8=;
 b=ILrRELfTiBRbc+Nc6SoR0eUg8ribmIDm9K4bdR2SYQbf7sGMcLM2DRHbr18ZPmE/1LGI1x8h23suxROSSoZP52GRR7xVIYXnV/YI8qrNt40Rh+xdPwbh6eXUHdgGHxJvJarELTvWZAOla1IN+EySgX/+KO8guhSBArpsqqHZFCI=
Received: from DM5PR21CA0009.namprd21.prod.outlook.com (2603:10b6:3:ac::19) by
 CY4PR12MB1589.namprd12.prod.outlook.com (2603:10b6:910:e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.24; Wed, 23 Feb 2022 10:04:27 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::f7) by DM5PR21CA0009.outlook.office365.com
 (2603:10b6:3:ac::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9 via Frontend
 Transport; Wed, 23 Feb 2022 10:04:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Wed, 23 Feb 2022 10:04:27 +0000
Received: from jinzhosu-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Wed, 23 Feb 2022 04:04:22 -0600
From:   Jinzhou Su <Jinzhou.Su@amd.com>
To:     <rjw@rjwysocki.net>, <linux-pm@vger.kernel.org>,
        <srinivas.pandruvada@linux.intel.com>, <dsmythies@telus.net>
CC:     <ray.huang@amd.com>, <viresh.kumar@linaro.org>,
        <todd.e.brandt@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <deepak.sharma@amd.com>, <alexander.deucher@amd.com>,
        <xiaojian.du@amd.com>, <perry.yuan@amd.com>, <li.meng@amd.com>,
        <jinzhou.su@amd.com>, Jinzhou Su <Jinzhou.Su@amd.com>
Subject: [PATCH 3/3] tools/power/x86/amd_pstate_tracer: Add tracer tool for AMD P-state
Date:   Wed, 23 Feb 2022 18:03:50 +0800
Message-ID: <20220223100350.3523826-4-Jinzhou.Su@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220223100350.3523826-1-Jinzhou.Su@amd.com>
References: <20220223100350.3523826-1-Jinzhou.Su@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ebca8ed-59da-4cdb-6d27-08d9f6b3e03c
X-MS-TrafficTypeDiagnostic: CY4PR12MB1589:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB158900786A74C0EC60C0D232903C9@CY4PR12MB1589.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6IXVkbZ2vHfrhxXd+ZkgqCpL3dhAfiO4Ij9GD3PtRLkABgVzWjYI6u/3TXgKBhLuVwcds6YETVwMZNVpVYb6KMvQrL7C5DqosQ+G75mhLV7twayP0+Ah8kcVel2pszJbtKoL1SDLhby9Kbh7n+MgT5UrTGeNppjfq/SVG7deFyXuHG7h3XsddRnelWYrTrRWzz9NOaNHtfdU2jw2QEq8JjMS2dItqaBdeCwZB89cw2VLDxQWS3LkMPW8tZkHZAT0qI1sBemle2LW8TTo5iCzoXp3yzt1gTl2ztxL0zZY9FyytQPv0jV/hXxcR+3baM/87pqZM5ZPPEb9UusWvkWgz4SWguznRL3/AZIw2zFozaTEbfohHmdKFS6SXM5P1njcKPtH8TKkLhi2L3Y0evxitYKnhmEs886p9ZjooYflp31PsCoNf9y8PPZIBfMrXYK8MoxHhrFFfDKLYZNq+wHPstoNWL3oZyChmmdQiv+aTKdxjH5sk9eAP9u4ICcWaDXHIqxmNyt8Sy0FmhSfsMhBFO3KQ5uhfon56v2zBBjKfd5RmlaVzhjFcz22Vu9gthy5KJBTSwDDOOj0HCdH0we7clB77SQTPRjy/C0DkOiJzgiHK2Y6rbqHrpU/dB3kwJmXBanYnCDIdvR5/9bw0U4uufJ13l2EBZ5ybetd27kX0y5TXtpP4ddsjZloA+n4mSUgNivq6bc8GS3hvKZXmhvZAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2906002)(40460700003)(54906003)(36860700001)(86362001)(82310400004)(81166007)(356005)(1076003)(6666004)(7696005)(508600001)(70206006)(5660300002)(4326008)(8676002)(30864003)(70586007)(8936002)(26005)(186003)(316002)(110136005)(83380400001)(36756003)(2616005)(16526019)(426003)(47076005)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 10:04:27.0177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ebca8ed-59da-4cdb-6d27-08d9f6b3e03c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1589
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel P-state tracer is a useful tool to tune and debug Intel P-state
driver. AMD P-state tracer import intel pstate tracer. This tool can
be used to analyze the performance of AMD P-state tracer.

Now CPU frequency, load and desired perf can be traced.

Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
---
 MAINTAINERS                                   |   1 +
 .../x86/amd_pstate_tracer/amd_pstate_trace.py | 354 ++++++++++++++++++
 2 files changed, 355 insertions(+)
 create mode 100755 tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py

diff --git a/MAINTAINERS b/MAINTAINERS
index f41088418aae..6c90da80982e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1002,6 +1002,7 @@ L:	linux-pm@vger.kernel.org
 S:	Supported
 F:	Documentation/admin-guide/pm/amd-pstate.rst
 F:	drivers/cpufreq/amd-pstate*
+F:	tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
 
 AMD PTDMA DRIVER
 M:	Sanjay R Mehta <sanju.mehta@amd.com>
diff --git a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py b/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
new file mode 100755
index 000000000000..43de7181d4ba
--- /dev/null
+++ b/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
@@ -0,0 +1,354 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+# -*- coding: utf-8 -*-
+#
+""" This utility can be used to debug and tune the performance of the
+AMD P-State driver. It imports intel_pstate_tracer to analyze AMD P-State
+trace event.
+
+Prerequisites:
+    Python version 2.7.x or higher
+    gnuplot 5.0 or higher
+    gnuplot-py 1.8 or higher
+    (Most of the distributions have these required packages. They may be called
+     gnuplot-py, phython-gnuplot or phython3-gnuplot, gnuplot-nox, ... )
+
+    Kernel config for Linux trace is enabled
+
+    see print_help(): for Usage and Output details
+
+"""
+from __future__ import print_function
+from datetime import datetime
+import subprocess
+import os
+import time
+import re
+import signal
+import sys
+import getopt
+import Gnuplot
+from numpy import *
+from decimal import *
+sys.path.append('../intel_pstate_tracer')
+#import intel_pstate_tracer
+import intel_pstate_tracer as ipt
+
+__license__ = "GPL version 2"
+
+MAX_CPUS = 256
+# Define the csv file columns
+C_COMM = 15
+C_ELAPSED = 14
+C_SAMPLE = 13
+C_DURATION = 12
+C_LOAD = 11
+C_TSC = 10
+C_APERF = 9
+C_MPERF = 8
+C_FREQ = 7
+C_MAX_PERF = 6
+C_DES_PERF = 5
+C_MIN_PERF = 4
+C_USEC = 3
+C_SEC = 2
+C_CPU = 1
+
+global sample_num, last_sec_cpu, last_usec_cpu, start_time, test_name, trace_file
+
+getcontext().prec = 11
+
+sample_num =0
+last_sec_cpu = [0] * MAX_CPUS
+last_usec_cpu = [0] * MAX_CPUS
+
+def plot_per_cpu_freq(cpu_index):
+    """ Plot per cpu frequency """
+
+    file_name = 'cpu{:0>3}.csv'.format(cpu_index)
+    if os.path.exists(file_name):
+        output_png = "cpu%03d_frequency.png" % cpu_index
+        g_plot = ipt.common_gnuplot_settings()
+        g_plot('set output "' + output_png + '"')
+        g_plot('set yrange [0:7]')
+        g_plot('set ytics 0, 1')
+        g_plot('set ylabel "CPU Frequency (GHz)"')
+        g_plot('set title "{} : frequency : CPU {:0>3} : {:%F %H:%M}"'.format(test_name, cpu_index, datetime.now()))
+        g_plot('set ylabel "CPU frequency"')
+        g_plot('set key off')
+        ipt.set_4_plot_linestyles(g_plot)
+        g_plot('plot "' + file_name + '" using {:d}:{:d} with linespoints linestyle 1 axis x1y1'.format(C_ELAPSED, C_FREQ))
+
+def plot_per_cpu_des_perf(cpu_index):
+    """ Plot per cpu desired perf """
+
+    file_name = 'cpu{:0>3}.csv'.format(cpu_index)
+    if os.path.exists(file_name):
+        output_png = "cpu%03d_des_perf.png" % cpu_index
+        g_plot = ipt.common_gnuplot_settings()
+        g_plot('set output "' + output_png + '"')
+        g_plot('set yrange [0:255]')
+        g_plot('set ylabel "des perf"')
+        g_plot('set title "{} : cpu des perf : CPU {:0>3} : {:%F %H:%M}"'.format(test_name, cpu_index, datetime.now()))
+        g_plot('set key off')
+        ipt.set_4_plot_linestyles(g_plot)
+        g_plot('plot "' + file_name + '" using {:d}:{:d} with linespoints linestyle 1 axis x1y1'.format(C_ELAPSED, C_DES_PERF))
+
+def plot_per_cpu_load(cpu_index):
+    """ Plot per cpu load """
+
+    file_name = 'cpu{:0>3}.csv'.format(cpu_index)
+    if os.path.exists(file_name):
+        output_png = "cpu%03d_load.png" % cpu_index
+        g_plot = ipt.common_gnuplot_settings()
+        g_plot('set output "' + output_png + '"')
+        g_plot('set yrange [0:100]')
+        g_plot('set ytics 0, 10')
+        g_plot('set ylabel "CPU load (percent)"')
+        g_plot('set title "{} : cpu load : CPU {:0>3} : {:%F %H:%M}"'.format(test_name, cpu_index, datetime.now()))
+        g_plot('set key off')
+        ipt.set_4_plot_linestyles(g_plot)
+        g_plot('plot "' + file_name + '" using {:d}:{:d} with linespoints linestyle 1 axis x1y1'.format(C_ELAPSED, C_LOAD))
+
+def plot_all_cpu_frequency():
+    """ Plot all cpu frequencies """
+
+    output_png = 'all_cpu_frequencies.png'
+    g_plot = ipt.common_gnuplot_settings()
+    g_plot('set output "' + output_png + '"')
+    g_plot('set ylabel "CPU Frequency (GHz)"')
+    g_plot('set title "{} : cpu frequencies : {:%F %H:%M}"'.format(test_name, datetime.now()))
+
+    title_list = subprocess.check_output('ls cpu???.csv | sed -e \'s/.csv//\'',shell=True).decode('utf-8').replace('\n', ' ')
+    plot_str = "plot for [i in title_list] i.'.csv' using {:d}:{:d} pt 7 ps 1 title i".format(C_ELAPSED, C_FREQ)
+    g_plot('title_list = "{}"'.format(title_list))
+    g_plot(plot_str)
+
+def plot_all_cpu_des_perf():
+    """ Plot all cpu desired perf """
+
+    output_png = 'all_cpu_des_perf.png'
+    g_plot = ipt.common_gnuplot_settings()
+    g_plot('set output "' + output_png + '"')
+    g_plot('set ylabel "des perf"')
+    g_plot('set title "{} : cpu des perf : {:%F %H:%M}"'.format(test_name, datetime.now()))
+
+    title_list = subprocess.check_output('ls cpu???.csv | sed -e \'s/.csv//\'',shell=True).decode('utf-8').replace('\n', ' ')
+    plot_str = "plot for [i in title_list] i.'.csv' using {:d}:{:d} pt 255 ps 1 title i".format(C_ELAPSED, C_DES_PERF)
+    g_plot('title_list = "{}"'.format(title_list))
+    g_plot(plot_str)
+
+def plot_all_cpu_load():
+    """ Plot all cpu load  """
+
+    output_png = 'all_cpu_load.png'
+    g_plot = ipt.common_gnuplot_settings()
+    g_plot('set output "' + output_png + '"')
+    g_plot('set yrange [0:100]')
+    g_plot('set ylabel "CPU load (percent)"')
+    g_plot('set title "{} : cpu load : {:%F %H:%M}"'.format(test_name, datetime.now()))
+
+    title_list = subprocess.check_output('ls cpu???.csv | sed -e \'s/.csv//\'',shell=True).decode('utf-8').replace('\n', ' ')
+    plot_str = "plot for [i in title_list] i.'.csv' using {:d}:{:d} pt 255 ps 1 title i".format(C_ELAPSED, C_LOAD)
+    g_plot('title_list = "{}"'.format(title_list))
+    g_plot(plot_str)
+
+def store_csv(cpu_int, time_pre_dec, time_post_dec, min_perf, des_perf, max_perf, freq_ghz, mperf, aperf, tsc, common_comm, load, duration_ms, sample_num, elapsed_time, cpu_mask):
+    """ Store master csv file information """
+
+    global graph_data_present
+
+    if cpu_mask[cpu_int] == 0:
+        return
+
+    try:
+        f_handle = open('cpu.csv', 'a')
+        string_buffer = "CPU_%03u, %05u, %06u, %u, %u, %u, %.4f, %u, %u, %u, %.2f, %.3f, %u, %.3f, %s\n" % (cpu_int, int(time_pre_dec), int(time_post_dec), int(min_perf), int(des_perf), int(max_perf), freq_ghz, int(mperf), int(aperf), int(tsc), load, duration_ms, sample_num, elapsed_time, common_comm)
+        f_handle.write(string_buffer)
+        f_handle.close()
+    except:
+        print('IO error cpu.csv')
+        return
+
+    graph_data_present = True;
+
+
+def cleanup_data_files():
+    """ clean up existing data files """
+
+    if os.path.exists('cpu.csv'):
+        os.remove('cpu.csv')
+    f_handle = open('cpu.csv', 'a')
+    f_handle.write('common_cpu, common_secs, common_usecs, min_perf, des_perf, max_perf, freq, mperf, apef, tsc, load, duration_ms, sample_num, elapsed_time, common_comm')
+    f_handle.write('\n')
+    f_handle.close()
+
+def read_trace_data(file_name, cpu_mask):
+    """ Read and parse trace data """
+
+    global current_max_cpu
+    global sample_num, last_sec_cpu, last_usec_cpu, start_time
+
+    try:
+        data = open(file_name, 'r').read()
+    except:
+        print('Error opening ', file_name)
+        sys.exit(2)
+
+    for line in data.splitlines():
+        search_obj = \
+            re.search(r'(^(.*?)\[)((\d+)[^\]])(.*?)(\d+)([.])(\d+)(.*?amd_min_perf=)(\d+)(.*?amd_des_perf=)(\d+)(.*?amd_max_perf=)(\d+)(.*?freq=)(\d+)(.*?mperf=)(\d+)(.*?aperf=)(\d+)(.*?tsc=)(\d+)'
+                      , line)
+
+        if search_obj:
+            cpu = search_obj.group(3)
+            cpu_int = int(cpu)
+            cpu = str(cpu_int)
+
+            time_pre_dec = search_obj.group(6)
+            time_post_dec = search_obj.group(8)
+            min_perf = search_obj.group(10)
+            des_perf = search_obj.group(12)
+            max_perf = search_obj.group(14)
+            freq = search_obj.group(16)
+            mperf = search_obj.group(18)
+            aperf = search_obj.group(20)
+            tsc = search_obj.group(22)
+
+            common_comm = search_obj.group(2).replace(' ', '')
+
+            if sample_num == 0 :
+                start_time = Decimal(time_pre_dec) + Decimal(time_post_dec) / Decimal(1000000)
+            sample_num += 1
+
+            if last_sec_cpu[cpu_int] == 0 :
+                last_sec_cpu[cpu_int] = time_pre_dec
+                last_usec_cpu[cpu_int] = time_post_dec
+            else :
+                duration_us = (int(time_pre_dec) - int(last_sec_cpu[cpu_int])) * 1000000 + (int(time_post_dec) - int(last_usec_cpu[cpu_int]))
+                duration_ms = Decimal(duration_us) / Decimal(1000)
+                last_sec_cpu[cpu_int] = time_pre_dec
+                last_usec_cpu[cpu_int] = time_post_dec
+                elapsed_time = Decimal(time_pre_dec) + Decimal(time_post_dec) / Decimal(1000000) - start_time
+                load = Decimal(int(mperf)*100)/ Decimal(tsc)
+                freq_ghz = Decimal(freq)/Decimal(1000000)
+                store_csv(cpu_int, time_pre_dec, time_post_dec, min_perf, des_perf, max_perf, freq_ghz, mperf, aperf, tsc, common_comm, load, duration_ms, sample_num, elapsed_time, cpu_mask)
+
+            if cpu_int > current_max_cpu:
+                current_max_cpu = cpu_int
+# Now separate the main overall csv file into per CPU csv files.
+    ipt.split_csv(current_max_cpu, cpu_mask)
+
+
+def signal_handler(signal, frame):
+    print(' SIGINT: Forcing cleanup before exit.')
+    if interval:
+        ipt.disable_trace(trace_file)
+        ipt.clear_trace_file()
+        ipt.free_trace_buffer()
+        sys.exit(0)
+
+trace_file = "/sys/kernel/debug/tracing/events/amd_cpu/enable"
+signal.signal(signal.SIGINT, signal_handler)
+
+interval = ""
+file_name = ""
+cpu_list = ""
+test_name = ""
+memory = "10240"
+graph_data_present = False;
+
+valid1 = False
+valid2 = False
+
+cpu_mask = zeros((MAX_CPUS,), dtype=int)
+
+
+try:
+    opts, args = getopt.getopt(sys.argv[1:],"ht:i:c:n:m:",["help","trace_file=","interval=","cpu=","name=","memory="])
+except getopt.GetoptError:
+    ipt.print_help('amd_pstate')
+    sys.exit(2)
+for opt, arg in opts:
+    if opt == '-h':
+        print()
+        sys.exit()
+    elif opt in ("-t", "--trace_file"):
+        valid1 = True
+        location = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__)))
+        file_name = os.path.join(location, arg)
+    elif opt in ("-i", "--interval"):
+        valid1 = True
+        interval = arg
+    elif opt in ("-c", "--cpu"):
+        cpu_list = arg
+    elif opt in ("-n", "--name"):
+        valid2 = True
+        test_name = arg
+    elif opt in ("-m", "--memory"):
+        memory = arg
+
+if not (valid1 and valid2):
+    ipt.print_help('amd_pstate')
+    sys.exit()
+
+if cpu_list:
+    for p in re.split("[,]", cpu_list):
+        if int(p) < MAX_CPUS :
+            cpu_mask[int(p)] = 1
+else:
+    for i in range (0, MAX_CPUS):
+        cpu_mask[i] = 1
+
+if not os.path.exists('results'):
+    os.mkdir('results')
+    ipt.fix_ownership('results')
+
+os.chdir('results')
+if os.path.exists(test_name):
+    print('The test name directory already exists. Please provide a unique test name. Test re-run not supported, yet.')
+    sys.exit()
+os.mkdir(test_name)
+ipt.fix_ownership(test_name)
+os.chdir(test_name)
+
+cur_version = sys.version_info
+print('python version (should be >= 2.7):')
+print(cur_version)
+
+cleanup_data_files()
+
+if interval:
+    file_name = "/sys/kernel/debug/tracing/trace"
+    ipt.clear_trace_file()
+    ipt.set_trace_buffer_size(memory)
+    ipt.enable_trace(trace_file)
+    time.sleep(int(interval))
+    ipt.disable_trace(trace_file)
+
+current_max_cpu = 0
+
+read_trace_data(file_name, cpu_mask)
+
+if interval:
+    ipt.clear_trace_file()
+    ipt.free_trace_buffer()
+
+if graph_data_present == False:
+    print('No valid data to plot')
+    sys.exit(2)
+
+for cpu_no in range(0, current_max_cpu + 1):
+    plot_per_cpu_freq(cpu_no)
+    plot_per_cpu_des_perf(cpu_no)
+    plot_per_cpu_load(cpu_no)
+
+plot_all_cpu_des_perf()
+plot_all_cpu_frequency()
+plot_all_cpu_load()
+
+for root, dirs, files in os.walk('.'):
+    for f in files:
+        ipt.fix_ownership(f)
+
+os.chdir('../../')
-- 
2.27.0

