Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE5B4C0FCF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 11:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239488AbiBWKEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 05:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239481AbiBWKEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 05:04:52 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8858A6C1;
        Wed, 23 Feb 2022 02:04:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYTWVr1FS20aKJWTMUjxmvFLQyb6QldvyUFD5GXrhYdIDo+t3vuagFewM2GAJaqi6OrqC/zjBIVHO+Lsp0QXbUC5RX/B7cEyZz9oUlq/EmSg2n7eIyEjZ7eFZoHXU3AP8xrszb4lbQtA0VyurlIAg2OJ3wqnT+CKPf5n4nEgZW8ATC3Z00tim/G+/VjJkXlk06Tv00ZJHIXxXQ1aPFHI2JtopJACOfJX3wkr6jIN6lvJn5+VENyNwFj6QF789Pr6yTg4MYwNM7pL5l7kXanF2KEb843DvhV1WfxV+0ZsnCd4mO/jXZIKQqVu8N7zbJJ4Sk+zNicIjGqXsqJq+m95IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLSPD+Hc2UUckxPyZeTO2lEH9pbcIsVuD0h56fTFXv4=;
 b=IdSWj4Dzpxl/mcQS4QbaktpaZS3Cq/bV/8IWrB07qzLoem+epYrQ6myGIWahudVHLz0cS32PygbPEGSjv97PkzYE50DUtDQ+7xzzFukhvZG81wOQ9k8fjM6EhVnuq6q7LXyiq8YVDSLT5K5KsR6pcrR+pmLvKsRy58wKk2WbInQkk5QQEn35DO8v5vlKMemgGGmDRLeCRB6gNU6AxzfjV2Tfr8SlH5yjj6WjOXo9yXh1JYFukyJCg81JnSceTydcew16pHTN3kZNffP0pMC6AY4WJ7obWXX+SMqVrmfQHfCl2qkopWvh9Qx+Ye9GVCuo3RydC3qELqJxF/jmzjFa0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLSPD+Hc2UUckxPyZeTO2lEH9pbcIsVuD0h56fTFXv4=;
 b=DzkNnQ9hz/E+lt2OModEXaLSj54+LRsadvzgC3tVSinsk32bGZ4cquuzsMehYr28SofEhWpT6aaQX6TzcUbn+dS30xtOAeB+1qOTkO6KNBu68o6ppTSRsqiy5hlTxnXGxmL7/q0bSYLTgndQeS+kXLl7MS4P+tnt64Lr2YX+fCQ=
Received: from DM5PR2001CA0023.namprd20.prod.outlook.com (2603:10b6:4:16::33)
 by LV2PR12MB5773.namprd12.prod.outlook.com (2603:10b6:408:17b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Wed, 23 Feb
 2022 10:04:22 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:16:cafe::31) by DM5PR2001CA0023.outlook.office365.com
 (2603:10b6:4:16::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24 via Frontend
 Transport; Wed, 23 Feb 2022 10:04:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Wed, 23 Feb 2022 10:04:22 +0000
Received: from jinzhosu-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Wed, 23 Feb 2022 04:04:17 -0600
From:   Jinzhou Su <Jinzhou.Su@amd.com>
To:     <rjw@rjwysocki.net>, <linux-pm@vger.kernel.org>,
        <srinivas.pandruvada@linux.intel.com>, <dsmythies@telus.net>
CC:     <ray.huang@amd.com>, <viresh.kumar@linaro.org>,
        <todd.e.brandt@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <deepak.sharma@amd.com>, <alexander.deucher@amd.com>,
        <xiaojian.du@amd.com>, <perry.yuan@amd.com>, <li.meng@amd.com>,
        <jinzhou.su@amd.com>, Jinzhou Su <Jinzhou.Su@amd.com>
Subject: [PATCH 2/3] tools/power/x86/intel_pstate_tracer: make tracer as a module
Date:   Wed, 23 Feb 2022 18:03:49 +0800
Message-ID: <20220223100350.3523826-3-Jinzhou.Su@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 48892b90-c831-431e-c401-08d9f6b3dd52
X-MS-TrafficTypeDiagnostic: LV2PR12MB5773:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB577375E70C0DA71EB34B0D01903C9@LV2PR12MB5773.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tKju/0i6ErUrb0Qn6z1va2dZQdoMdkRokm1fj6yLaIb0bEp7vEQIKdfmdhWBpNyeTrTY3PyPMbFbWllRSpV6gkcOBVg2gPshnV6/PpW51nNbuFLXdUgzVoZvda9nVcOCT4rQyLDsBWENY73w7W1EyvRsHnoUhfmlS2A9a3kZsuW3NgryHL18kNht+PiuZfK7PwqeXWkmTp5CdGXe7EXrM2nXXd67khYvXzxRZosGr9jZSMICtjzB39dXiEnNVt0OvfRorO1gOFMy9gBjtGLLrm6ZRsvk0oMIrGK8GtzeMqQrvovJ4RO22P/GeMiWXCZddDbbzCl5Pzw0o3ol2jzNXHjTx9zbXf8GSCStxg3nuoVvVScLGwu7cAhlKRCgA6p3vM8Pdt7SLImoJeqtBZqnFljwT7V0J3dhM+0RYNk4c5R8f3lQW9BhxQ0bavAXVpNgzxOM496xJJCJDAmsbYvEXVreUzVuZnvo1q4oLZ68eVESC7tYcwTLJtjhG2b05tWhVDKel9Frme8UiyIktzFyk1KT4qYxPlMt+uum8TMNnhZvfyPnmF0uyEQgih8w8BaxIFTBWnfSKfYQp1bABqZMLUXDDswI7GH/YfBR5SbA2ov9CZiQS1R4I6AKZYEGDrSKq4FKyIcVc8udU/WTqyHlgUcgq3vKBXkCKX6jwjXDORGUjkHxqbQ7uqjmi7HhUlM727a9ki88K0Eh7sKSpa8kzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(4326008)(81166007)(16526019)(356005)(1076003)(26005)(82310400004)(8676002)(2616005)(186003)(70586007)(508600001)(70206006)(86362001)(316002)(2906002)(40460700003)(426003)(83380400001)(36860700001)(30864003)(336012)(8936002)(47076005)(36756003)(54906003)(7696005)(5660300002)(6666004)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 10:04:22.1466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48892b90-c831-431e-c401-08d9f6b3dd52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5773
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make intel_pstate_tracer as a module. Other trace event can import
this module to analyze their trace data.

Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
---
 .../intel_pstate_tracer.py                    | 260 +++++++++---------
 1 file changed, 129 insertions(+), 131 deletions(-)

diff --git a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
index e15e20696d17..b46e9eb8f5aa 100755
--- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
+++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
@@ -63,7 +63,7 @@ C_USEC = 3
 C_SEC = 2
 C_CPU = 1
 
-global sample_num, last_sec_cpu, last_usec_cpu, start_time, testname
+global sample_num, last_sec_cpu, last_usec_cpu, start_time, testname, trace_file
 
 # 11 digits covers uptime to 115 days
 getcontext().prec = 11
@@ -72,17 +72,17 @@ sample_num =0
 last_sec_cpu = [0] * MAX_CPUS
 last_usec_cpu = [0] * MAX_CPUS
 
-def print_help():
-    print('intel_pstate_tracer.py:')
+def print_help(driver_name):
+    print('%s_tracer.py:'%driver_name)
     print('  Usage:')
     print('    If the trace file is available, then to simply parse and plot, use (sudo not required):')
-    print('      ./intel_pstate_tracer.py [-c cpus] -t <trace_file> -n <test_name>')
+    print('      ./%s_tracer.py [-c cpus] -t <trace_file> -n <test_name>'%driver_name)
     print('    Or')
-    print('      ./intel_pstate_tracer.py [--cpu cpus] ---trace_file <trace_file> --name <test_name>')
+    print('      ./%s_tracer.py [--cpu cpus] ---trace_file <trace_file> --name <test_name>'%driver_name)
     print('    To generate trace file, parse and plot, use (sudo required):')
-    print('      sudo ./intel_pstate_tracer.py [-c cpus] -i <interval> -n <test_name> -m <kbytes>')
+    print('      sudo ./%s_tracer.py [-c cpus] -i <interval> -n <test_name> -m <kbytes>'%driver_name)
     print('    Or')
-    print('      sudo ./intel_pstate_tracer.py [--cpu cpus] --interval <interval> --name <test_name> --memory <kbytes>')
+    print('      sudo ./%s_tracer.py [--cpu cpus] --interval <interval> --name <test_name> --memory <kbytes>'%driver_name)
     print('    Optional argument:')
     print('      cpus:   comma separated list of CPUs')
     print('      kbytes: Kilo bytes of memory per CPU to allocate to the trace buffer. Default: 10240')
@@ -323,7 +323,7 @@ def set_4_plot_linestyles(g_plot):
     g_plot('set style line 3 linetype 1 linecolor rgb "purple" pointtype -1')
     g_plot('set style line 4 linetype 1 linecolor rgb "blue" pointtype -1')
 
-def store_csv(cpu_int, time_pre_dec, time_post_dec, core_busy, scaled, _from, _to, mperf, aperf, tsc, freq_ghz, io_boost, common_comm, load, duration_ms, sample_num, elapsed_time, tsc_ghz):
+def store_csv(cpu_int, time_pre_dec, time_post_dec, core_busy, scaled, _from, _to, mperf, aperf, tsc, freq_ghz, io_boost, common_comm, load, duration_ms, sample_num, elapsed_time, tsc_ghz, cpu_mask):
     """ Store master csv file information """
 
     global graph_data_present
@@ -342,11 +342,9 @@ def store_csv(cpu_int, time_pre_dec, time_post_dec, core_busy, scaled, _from, _t
 
     graph_data_present = True;
 
-def split_csv():
+def split_csv(current_max_cpu, cpu_mask):
     """ seperate the all csv file into per CPU csv files. """
 
-    global current_max_cpu
-
     if os.path.exists('cpu.csv'):
         for index in range(0, current_max_cpu + 1):
             if cpu_mask[int(index)] != 0:
@@ -381,27 +379,25 @@ def clear_trace_file():
         print('IO error clearing trace file ')
         sys.exit(2)
 
-def enable_trace():
+def enable_trace(trace_file):
     """ Enable trace """
 
     try:
-       open('/sys/kernel/debug/tracing/events/power/pstate_sample/enable'
-                 , 'w').write("1")
+        open(trace_file,'w').write("1")
     except:
         print('IO error enabling trace ')
         sys.exit(2)
 
-def disable_trace():
+def disable_trace(trace_file):
     """ Disable trace """
 
     try:
-       open('/sys/kernel/debug/tracing/events/power/pstate_sample/enable'
-                 , 'w').write("0")
+       open(trace_file, 'w').write("0")
     except:
         print('IO error disabling trace ')
         sys.exit(2)
 
-def set_trace_buffer_size():
+def set_trace_buffer_size(memory):
     """ Set trace buffer size """
 
     try:
@@ -421,7 +417,7 @@ def free_trace_buffer():
         print('IO error freeing trace buffer ')
         sys.exit(2)
 
-def read_trace_data(filename):
+def read_trace_data(filename, cpu_mask):
     """ Read and parse trace data """
 
     global current_max_cpu
@@ -481,135 +477,137 @@ def read_trace_data(filename):
                 tsc_ghz = Decimal(0)
                 if duration_ms != Decimal(0) :
                     tsc_ghz = Decimal(tsc)/duration_ms/Decimal(1000000)
-                store_csv(cpu_int, time_pre_dec, time_post_dec, core_busy, scaled, _from, _to, mperf, aperf, tsc, freq_ghz, io_boost, common_comm, load, duration_ms, sample_num, elapsed_time, tsc_ghz)
+                store_csv(cpu_int, time_pre_dec, time_post_dec, core_busy, scaled, _from, _to, mperf, aperf, tsc, freq_ghz, io_boost, common_comm, load, duration_ms, sample_num, elapsed_time, tsc_ghz, cpu_mask)
 
             if cpu_int > current_max_cpu:
                 current_max_cpu = cpu_int
 # End of for each trace line loop
 # Now seperate the main overall csv file into per CPU csv files.
-    split_csv()
+    split_csv(current_max_cpu, cpu_mask)
 
 def signal_handler(signal, frame):
     print(' SIGINT: Forcing cleanup before exit.')
     if interval:
-        disable_trace()
+        disable_trace(trace_file)
         clear_trace_file()
         # Free the memory
         free_trace_buffer()
         sys.exit(0)
 
-signal.signal(signal.SIGINT, signal_handler)
+if __name__ == "__main__":
+    trace_file = "/sys/kernel/debug/tracing/events/power/pstate_sample/enable"
+    signal.signal(signal.SIGINT, signal_handler)
 
-interval = ""
-filename = ""
-cpu_list = ""
-testname = ""
-memory = "10240"
-graph_data_present = False;
+    interval = ""
+    filename = ""
+    cpu_list = ""
+    testname = ""
+    memory = "10240"
+    graph_data_present = False;
 
-valid1 = False
-valid2 = False
+    valid1 = False
+    valid2 = False
 
-cpu_mask = zeros((MAX_CPUS,), dtype=int)
+    cpu_mask = zeros((MAX_CPUS,), dtype=int)
 
-try:
-    opts, args = getopt.getopt(sys.argv[1:],"ht:i:c:n:m:",["help","trace_file=","interval=","cpu=","name=","memory="])
-except getopt.GetoptError:
-    print_help()
-    sys.exit(2)
-for opt, arg in opts:
-    if opt == '-h':
-        print()
+    try:
+        opts, args = getopt.getopt(sys.argv[1:],"ht:i:c:n:m:",["help","trace_file=","interval=","cpu=","name=","memory="])
+    except getopt.GetoptError:
+        print_help('intel_pstate')
+        sys.exit(2)
+    for opt, arg in opts:
+        if opt == '-h':
+            print_help('intel_pstate')
+            sys.exit()
+        elif opt in ("-t", "--trace_file"):
+            valid1 = True
+            location = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__)))
+            filename = os.path.join(location, arg)
+        elif opt in ("-i", "--interval"):
+            valid1 = True
+            interval = arg
+        elif opt in ("-c", "--cpu"):
+            cpu_list = arg
+        elif opt in ("-n", "--name"):
+            valid2 = True
+            testname = arg
+        elif opt in ("-m", "--memory"):
+            memory = arg
+
+    if not (valid1 and valid2):
+        print_help('intel_pstate')
         sys.exit()
-    elif opt in ("-t", "--trace_file"):
-        valid1 = True
-        location = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__)))
-        filename = os.path.join(location, arg)
-    elif opt in ("-i", "--interval"):
-        valid1 = True
-        interval = arg
-    elif opt in ("-c", "--cpu"):
-        cpu_list = arg
-    elif opt in ("-n", "--name"):
-        valid2 = True
-        testname = arg
-    elif opt in ("-m", "--memory"):
-        memory = arg
-
-if not (valid1 and valid2):
-    print_help()
-    sys.exit()
-
-if cpu_list:
-    for p in re.split("[,]", cpu_list):
-        if int(p) < MAX_CPUS :
-            cpu_mask[int(p)] = 1
-else:
-    for i in range (0, MAX_CPUS):
-        cpu_mask[i] = 1
-
-if not os.path.exists('results'):
-    os.mkdir('results')
+
+    if cpu_list:
+        for p in re.split("[,]", cpu_list):
+            if int(p) < MAX_CPUS :
+                cpu_mask[int(p)] = 1
+    else:
+        for i in range (0, MAX_CPUS):
+            cpu_mask[i] = 1
+
+    if not os.path.exists('results'):
+        os.mkdir('results')
+        # The regular user needs to own the directory, not root.
+        fix_ownership('results')
+
+    os.chdir('results')
+    if os.path.exists(testname):
+        print('The test name directory already exists. Please provide a unique test name. Test re-run not supported, yet.')
+        sys.exit()
+    os.mkdir(testname)
     # The regular user needs to own the directory, not root.
-    fix_ownership('results')
-
-os.chdir('results')
-if os.path.exists(testname):
-    print('The test name directory already exists. Please provide a unique test name. Test re-run not supported, yet.')
-    sys.exit()
-os.mkdir(testname)
-# The regular user needs to own the directory, not root.
-fix_ownership(testname)
-os.chdir(testname)
-
-# Temporary (or perhaps not)
-cur_version = sys.version_info
-print('python version (should be >= 2.7):')
-print(cur_version)
-
-# Left as "cleanup" for potential future re-run ability.
-cleanup_data_files()
-
-if interval:
-    filename = "/sys/kernel/debug/tracing/trace"
-    clear_trace_file()
-    set_trace_buffer_size()
-    enable_trace()
-    print('Sleeping for ', interval, 'seconds')
-    time.sleep(int(interval))
-    disable_trace()
-
-current_max_cpu = 0
-
-read_trace_data(filename)
-
-if interval:
-    clear_trace_file()
-    # Free the memory
-    free_trace_buffer()
-
-if graph_data_present == False:
-    print('No valid data to plot')
-    sys.exit(2)
-
-for cpu_no in range(0, current_max_cpu + 1):
-    plot_perf_busy_with_sample(cpu_no)
-    plot_perf_busy(cpu_no)
-    plot_durations(cpu_no)
-    plot_loads(cpu_no)
-
-plot_pstate_cpu_with_sample()
-plot_pstate_cpu()
-plot_load_cpu()
-plot_frequency_cpu()
-plot_duration_cpu()
-plot_scaled_cpu()
-plot_boost_cpu()
-plot_ghz_cpu()
-
-# It is preferrable, but not necessary, that the regular user owns the files, not root.
-for root, dirs, files in os.walk('.'):
-    for f in files:
-        fix_ownership(f)
-
-os.chdir('../../')
+    fix_ownership(testname)
+    os.chdir(testname)
+
+    # Temporary (or perhaps not)
+    cur_version = sys.version_info
+    print('python version (should be >= 2.7):')
+    print(cur_version)
+
+    # Left as "cleanup" for potential future re-run ability.
+    cleanup_data_files()
+
+    if interval:
+        filename = "/sys/kernel/debug/tracing/trace"
+        clear_trace_file()
+        set_trace_buffer_size(memory)
+        enable_trace(trace_file)
+        print('Sleeping for ', interval, 'seconds')
+        time.sleep(int(interval))
+        disable_trace(trace_file)
+
+    current_max_cpu = 0
+
+    read_trace_data(filename, cpu_mask)
+
+    if interval:
+        clear_trace_file()
+        # Free the memory
+        free_trace_buffer()
+
+    if graph_data_present == False:
+        print('No valid data to plot')
+        sys.exit(2)
+
+    for cpu_no in range(0, current_max_cpu + 1):
+        plot_perf_busy_with_sample(cpu_no)
+        plot_perf_busy(cpu_no)
+        plot_durations(cpu_no)
+        plot_loads(cpu_no)
+
+    plot_pstate_cpu_with_sample()
+    plot_pstate_cpu()
+    plot_load_cpu()
+    plot_frequency_cpu()
+    plot_duration_cpu()
+    plot_scaled_cpu()
+    plot_boost_cpu()
+    plot_ghz_cpu()
+
+    # It is preferrable, but not necessary, that the regular user owns the files, not root.
+    for root, dirs, files in os.walk('.'):
+        for f in files:
+            fix_ownership(f)
+
+    os.chdir('../../')
-- 
2.27.0

