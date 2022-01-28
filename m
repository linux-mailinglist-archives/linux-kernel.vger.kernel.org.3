Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6C049F309
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 06:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242033AbiA1F3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 00:29:17 -0500
Received: from mail-bn8nam12on2075.outbound.protection.outlook.com ([40.107.237.75]:39979
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233232AbiA1F3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 00:29:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXLVgwL3flUexjGGEt/8Yeqwig9ecOzDROdwlqb+rFwY0SY7PArug4c7Ipby1TUQ7vtimk5tYCCsAO9ufe2f1Hj1ydnzD6JJIyUrbGhMKLIKzJMQi6M/Lo/lc086XGmTTmz5RseOOAcdGrYahs978lHfP78jZRRx11gqODbUBOMljVcwjqJp3Qqbo5W6lKeiThcJo5yJ6UTZ9ESHTHVJa5CYkIlw1ZBQMz7aWn0hQc3UwD7nkvjRPNTsQ5WiH60H0I1i23KIp2UMduoR7+Ln7QrwqdFz1RTbcP8Ft0uXQqo3+PCVFfyXH2Y4sJPhUCHbSGzIxo3b2tpwkIqrEq1A3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkZBvmdrXNEzCodP+vwAusbrQ93jUrj0Xz2zw8qTARE=;
 b=M5XOLS+mP5yicaxDyMdL3/45ctv6r20tQv872WjBQZ/Wi4Hc3qUp2DJwAYeoA+oH/8c8AGBJwd0gc7+D5FF5TOoyAWQ4WZTFAlaIdqon5cs3Gf1jXLiPkJ8nsjGmYNGwZFqwhTNiz38h1mHqS2eLy8EgoWxSI/RXeJwaAoNi5r1M4SIL6bN9MKeBKBn2yurCtBpMpYC1LDJMxB8LDEwycjtC3dEhzuYFJ74PSHP0ehSRwe0I4FJUGJ3N186cvst/OuD4hUHLbACbSeYRN/Ol7GUgnWwiRFGE/zf2tHuTtf0bQr/aL+ppAmHXw2Hp8H7T2L5wuas/cJ3M4Mu2eVzb2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkZBvmdrXNEzCodP+vwAusbrQ93jUrj0Xz2zw8qTARE=;
 b=H1k6dDIGqKBych9xYHSWEFdChSw63GOLxpndXhHzZHoNn1oq5aC82AsW8Bw5zgwX/f9br/T64m1MJ2RvqlbfnF3NmWUXf+REsEVxYS2Dcf0wGL4XpFVf8N+EapYiCoghOp9nL4SdzgUGkfTm6D/s+WBB7LQk/Xna/tivAZ5ehV4=
Received: from DM5PR10CA0002.namprd10.prod.outlook.com (2603:10b6:4:2::12) by
 MWHPR1201MB0063.namprd12.prod.outlook.com (2603:10b6:301:4d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 05:29:10 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::a9) by DM5PR10CA0002.outlook.office365.com
 (2603:10b6:4:2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Fri, 28 Jan 2022 05:29:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 05:29:10 +0000
Received: from BLR-5CG1133937.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 27 Jan
 2022 23:29:01 -0600
From:   Bharata B Rao <bharata@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <dishaa.talreja@amd.com>, Bharata B Rao <bharata@amd.com>
Subject: [RFC PATCH v0 0/3] sched/numa: Process Adaptive autoNUMA
Date:   Fri, 28 Jan 2022 10:58:48 +0530
Message-ID: <20220128052851.17162-1-bharata@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ee95f7f-d951-46c2-77a7-08d9e21f1cb5
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0063:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB006360592DF9BC43DBEF7954B0229@MWHPR1201MB0063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aX6jYfDXdQX0cH6gcSBE5g5ARatVdmIqW+OCe5YLB+ZX73MRmvYv8uP/U8KabFcLE3FXwPUqo1KHNVnHbX6UD8AI2q4E12c9x3kN1vie9n3Q5gg/8KgIZOhibfOq2dgDsLC3R+C+RKdEXClPoRyYMLVCTC8QJP7lobhPjP4qrM8Z+ovNOtveQb5hN2rispukZK92uxsof4xj1Enzf9q80i9zQ9SDF9tjUIhH9ZAJvNbjJvK9gZB71HDFqUIY7WyO1PAsBgiTNnp9t76bbsCaNx/pPefXybrgAajOOEyL/UP0N/eifgj9PbH91ig57jT3lltz9Q5D5xBRwgtnpNv3zGDT6S8417Qu+rGCLp3LPft5ngO81Nml4HMVyxIyCNfH1opEqu8dsMXb3SjVn5SDEkUYnOiBv2Om5vjP59u4RH9njfxDWSQ16TZ75yOyQ5+dkKVQq0/HnkUaQa2hVlMHVUiri/eXlBPlslkHFnHxlj9RonN45ZHxf1jKmuz7X4qfayq9bXeN5QpFbuYbAdsC/gj4N6+9vfDuo7XjZdZ1SC/NKk+QLVkg4k1xJ6eFwqdT+9gfVjLx/WI9uHnQTn4q67uJ3blwEM6UL4clU04D7K/gLz5TNhr3glNc775i42Pi9y+8rYkDTekCmMq0ZBCBvaeEIst8FsLevj3J1GZuzFEgbVoPhfpaDlNu04A+TuK9z0v7uXJxqSVivgIiaJoMVxnfmiSG/vHnZ1txwFUuKiffuJzF0RhUzX/FBuVvTflxddWFjGXlHttHfieLpCFaudDFTFOe90/xxsptu0W2OLXllLKyC7AxKUE/OWlTU5bOYvJPmUVfM58F2+fhD/hLwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(81166007)(54906003)(356005)(316002)(82310400004)(7696005)(6916009)(5660300002)(6666004)(8936002)(8676002)(4326008)(40460700003)(70206006)(86362001)(966005)(70586007)(2906002)(508600001)(36860700001)(426003)(2616005)(1076003)(336012)(186003)(26005)(36756003)(16526019)(7416002)(47076005)(83380400001)(30864003)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 05:29:10.2216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee95f7f-d951-46c2-77a7-08d9e21f1cb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0063
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset implements an adaptive algorithm for calculating the autonuma
scan period. In the existing mechanism of scan period calculation,

- scan period is derived from the per-thread stats.
- static threshold (NUMA_PERIOD_THRESHOLD) is used for changing the
  scan rate.

In this new approach (Process Adaptive autoNUMA or PAN), we gather NUMA
fault stats at per-process level which allows for capturing the application
behaviour better. In addition, the algorithm learns and adjusts the scan
rate based on remote fault rate. By not sticking to a static threshold, the
algorithm can respond better to different workload behaviours.

Since the threads of a processes are already considered as a group,
we add a bunch of metrics to the task's mm to track the various
types of faults and derive the scan rate from them.

The new per-process fault stats contribute only to the per-process
scan period calculation, while the existing per-thread stats continue
to contribute towards the numa_group stats which eventually
determine the thresholds for migrating memory and threads
across nodes.

This patchset has been tested with a bunch of benchmarks on the
following system:

2 socket AMD Milan System
32 cores or 64 threads per socket
256GB memory per socket amounting to 512GB in total
transparent_hugepage=never has been used for all the below tests.
NPS1 NUMA configuration where each socket is a NUMA node

$ numactl -H
available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95
node 0 size: 257645 MB
node 0 free: 255193 MB
node 1 cpus: 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127
node 1 size: 257984 MB
node 1 free: 257017 MB
node distances:
node   0   1 
  0:  10  32 
  1:  32  10 

While this is an early version that we are experimenting on NPS1
configuration with THP off, we plan to test it on other configurations
as well. However posting it now for some early feedback.

Here are the numbers from some of the benchmarks that we have
tried. A brief description of these benchmarks is also given at
end of this mail. The detailed results are available at
https://drive.google.com/drive/folders/1O7sY-YBsT3F5GHZMiOGQbXkgpp6O0BEo

Plots of how scan period varies in default vs PAN for a couple
of benchmarks are also present in the above folder.

------------------------------------------------------
% gain of PAN vs default (Avg of 3 runs)
------------------------------------------------------
NAS-BT		-0.17
NAS-CG		+9.39
NAS-MG		+8.19
NAS-FT		+2.23
Hashjoin	+0.58
Graph500	+14.93
Pagerank	+0.37
------------------------------------------------------
		Default		PAN		%diff
------------------------------------------------------
		NUMA hint faults(Total of 3 runs)
------------------------------------------------------
NAS-BT		758282358	539850429	+29
NAS-CG		2179458823	1180301361	+46
NAS-MG		517641172	346066391	+33
NAS-FT		297044964	230033861	+23
Hashjoin	201684863	268436275	-33
Graph500	261808733	154338827	+41
Pagerank	217917818	211260310	+03
------------------------------------------------------
		Migrations(Total of 3 runs)
------------------------------------------------------
NAS-BT		106888517	86482076	+19
NAS-CG		81191368	12859924	+84
NAS-MG		83927451	39651254	+53
NAS-FT		61807715	38934618	+37
Hashjoin	45406983	59828843	-32
Graph500	22798837	21560714	+05
Pagerank	59072135	44968673	+24
------------------------------------------------------

And here are some tests from a few microbenchmarks of mmtests suite.
(The results are trimmed a bit here, the complete results can
be viewed in the above mentioned link)

Hackbench
---------
hackbench-process-pipes
                           hackbench              hackbench
                             default                    pan
Min       256     23.5510 (   0.00%)     23.1900 (   1.53%)
Amean     256     24.4604 (   0.00%)     24.0353 *   1.74%*
Stddev    256      0.4420 (   0.00%)      0.7611 ( -72.18%)
CoeffVar  256      1.8072 (   0.00%)      3.1666 ( -75.22%)
Max       256     25.4930 (   0.00%)     30.5450 ( -19.82%)
BAmean-50 256     24.1074 (   0.00%)     23.6616 (   1.85%)
BAmean-95 256     24.4111 (   0.00%)     23.9308 (   1.97%)
BAmean-99 256     24.4499 (   0.00%)     23.9696 (   1.96%)

                   hackbench   hackbench
                     default         pan
Duration User       25810.02    25158.93
Duration System    276322.70   271729.32
Duration Elapsed     2707.75     2671.33

                                      hackbench      hackbench
                                        default            pan
Ops NUMA alloc hit                1082415453.00  1088025994.00
Ops NUMA alloc miss                        0.00           0.00
Ops NUMA interleave hit                    0.00           0.00
Ops NUMA alloc local              1082415441.00  1088025974.00
Ops NUMA base-page range updates       33475.00      228900.00
Ops NUMA PTE updates                   33475.00      228900.00
Ops NUMA PMD updates                       0.00           0.00
Ops NUMA hint faults                   15758.00      222100.00
Ops NUMA hint local faults %           15371.00      214570.00
Ops NUMA hint local percent               97.54          96.61
Ops NUMA pages migrated                  235.00        4029.00
Ops AutoNUMA cost                         79.03        1112.18

tbench
------
tbench4
                              tbench                 tbench
                             default                    pan
Hmean     1        436.89 (   0.00%)      432.73 *  -0.95%*
Hmean     2        834.27 (   0.00%)      848.11 *   1.66%*
Hmean     4       1629.50 (   0.00%)     1614.22 *  -0.94%*
Hmean     8       2944.06 (   0.00%)     3031.66 *   2.98%*
Hmean     16      5418.25 (   0.00%)     5674.74 *   4.73%*
Hmean     32      9959.60 (   0.00%)     9009.82 *  -9.54%*
Hmean     64     13999.14 (   0.00%)    12160.51 * -13.13%*
Hmean     128    16797.09 (   0.00%)    16506.14 *  -1.73%*
Hmean     256    25344.27 (   0.00%)    25683.66 *   1.34%*
Hmean     512    25289.03 (   0.00%)    25513.77 *   0.89%*
BHmean-50 1        437.13 (   0.00%)      433.01 (  -0.94%)
BHmean-50 2        836.35 (   0.00%)      848.85 (   1.49%)
BHmean-50 4       1631.39 (   0.00%)     1618.43 (  -0.79%)
BHmean-50 8       2948.25 (   0.00%)     3037.86 (   3.04%)
BHmean-50 16      5425.17 (   0.00%)     5684.25 (   4.78%)
BHmean-50 32      9969.17 (   0.00%)     9034.06 (  -9.38%)
BHmean-50 64     14013.93 (   0.00%)    12202.07 ( -12.93%)
BHmean-50 128    16881.94 (   0.00%)    16571.27 (  -1.84%)
BHmean-50 256    25379.59 (   0.00%)    25819.18 (   1.73%)
BHmean-50 512    25435.41 (   0.00%)    25718.02 (   1.11%)
BHmean-95 1        436.92 (   0.00%)      432.81 (  -0.94%)
BHmean-95 2        834.59 (   0.00%)      848.23 (   1.63%)
BHmean-95 4       1629.73 (   0.00%)     1614.83 (  -0.91%)
BHmean-95 8       2945.02 (   0.00%)     3032.19 (   2.96%)
BHmean-95 16      5418.86 (   0.00%)     5675.91 (   4.74%)
BHmean-95 32      9962.57 (   0.00%)     9014.17 (  -9.52%)
BHmean-95 64     14002.44 (   0.00%)    12164.32 ( -13.13%)
BHmean-95 128    16820.56 (   0.00%)    16522.82 (  -1.77%)
BHmean-95 256    25347.34 (   0.00%)    25692.56 (   1.36%)
BHmean-95 512    25302.10 (   0.00%)    25528.52 (   0.89%)
BHmean-99 1        436.90 (   0.00%)      432.75 (  -0.95%)
BHmean-99 2        834.35 (   0.00%)      848.17 (   1.66%)
BHmean-99 4       1629.57 (   0.00%)     1614.38 (  -0.93%)
BHmean-99 8       2944.36 (   0.00%)     3031.77 (   2.97%)
BHmean-99 16      5418.40 (   0.00%)     5675.01 (   4.74%)
BHmean-99 32      9961.01 (   0.00%)     9011.43 (  -9.53%)
BHmean-99 64     14000.68 (   0.00%)    12161.34 ( -13.14%)
BHmean-99 128    16803.44 (   0.00%)    16511.94 (  -1.73%)
BHmean-99 256    25344.93 (   0.00%)    25685.57 (   1.34%)
BHmean-99 512    25291.87 (   0.00%)    25516.94 (   0.89%)

                      tbench      tbench
                     default         pan
Duration User        8482.50     8289.35
Duration System     49462.63    49364.56
Duration Elapsed     2217.10     2217.08

                                         tbench         tbench
                                        default            pan
Ops NUMA alloc hit                 388738400.00   378941469.00
Ops NUMA alloc miss                        0.00           0.00
Ops NUMA interleave hit                    0.00           0.00
Ops NUMA alloc local               388738391.00   378941455.00
Ops NUMA base-page range updates      266760.00      266275.00
Ops NUMA PTE updates                  266760.00      266275.00
Ops NUMA PMD updates                       0.00           0.00
Ops NUMA hint faults                  241547.00      257790.00
Ops NUMA hint local faults %          145814.00      126410.00
Ops NUMA hint local percent               60.37          49.04
Ops NUMA pages migrated                51535.00       66083.00
Ops AutoNUMA cost                       1210.58        1292.07

dbench
------
dbench4 Latency
                                       dbench                 dbench
                                      default                    pan
Amean     latency-1           2.02 (   0.00%)        2.05 *  -1.52%*
Amean     latency-2           2.60 (   0.00%)        2.55 *   1.64%*
Amean     latency-4           3.52 (   0.00%)        3.56 *  -1.17%*
Amean     latency-8          12.79 (   0.00%)       11.83 *   7.49%*
Amean     latency-16         23.33 (   0.00%)       19.09 *  18.19%*
Amean     latency-32         19.30 (   0.00%)       18.83 *   2.43%*
Amean     latency-64         25.32 (   0.00%)       24.30 *   4.00%*
Amean     latency-128        45.25 (   0.00%)       42.93 *   5.13%*
Amean     latency-1024        0.00 (   0.00%)        0.00 *   0.00%*
BAmean-50 latency-1           1.65 (   0.00%)        1.74 (  -5.16%)
BAmean-50 latency-2           2.10 (   0.00%)        2.10 (  -0.13%)
BAmean-50 latency-4           2.65 (   0.00%)        2.71 (  -2.28%)
BAmean-50 latency-8           6.21 (   0.00%)        4.64 (  25.30%)
BAmean-50 latency-16         17.64 (   0.00%)       14.08 (  20.16%)
BAmean-50 latency-32         15.58 (   0.00%)       15.90 (  -2.07%)
BAmean-50 latency-64         20.76 (   0.00%)       20.31 (   2.15%)
BAmean-50 latency-128        36.22 (   0.00%)       34.85 (   3.80%)
BAmean-50 latency-1024        0.00 (   0.00%)        0.00 (   0.00%)
BAmean-95 latency-1           1.88 (   0.00%)        1.94 (  -3.17%)
BAmean-95 latency-2           2.25 (   0.00%)        2.26 (  -0.26%)
BAmean-95 latency-4           3.00 (   0.00%)        3.08 (  -2.71%)
BAmean-95 latency-8          11.66 (   0.00%)       10.03 (  13.97%)
BAmean-95 latency-16         22.30 (   0.00%)       17.68 (  20.73%)
BAmean-95 latency-32         17.95 (   0.00%)       17.70 (   1.38%)
BAmean-95 latency-64         23.57 (   0.00%)       22.72 (   3.62%)
BAmean-95 latency-128        42.44 (   0.00%)       39.96 (   5.84%)
BAmean-95 latency-1024        0.00 (   0.00%)        0.00 (   0.00%)
BAmean-99 latency-1           1.90 (   0.00%)        1.96 (  -3.30%)
BAmean-99 latency-2           2.38 (   0.00%)        2.37 (   0.48%)
BAmean-99 latency-4           3.24 (   0.00%)        3.34 (  -3.26%)
BAmean-99 latency-8          12.34 (   0.00%)       10.71 (  13.27%)
BAmean-99 latency-16         22.79 (   0.00%)       18.27 (  19.82%)
BAmean-99 latency-32         18.68 (   0.00%)       18.32 (   1.93%)
BAmean-99 latency-64         24.69 (   0.00%)       23.69 (   4.06%)
BAmean-99 latency-128        44.44 (   0.00%)       42.15 (   5.17%)
BAmean-99 latency-1024        0.00 (   0.00%)        0.00 (   0.00%)

dbench4 Throughput (misleading but traditional)
                               dbench                 dbench
                              default                    pan
Hmean     1         505.12 (   0.00%)      492.96 *  -2.41%*
Hmean     2         824.14 (   0.00%)      824.06 *  -0.01%*
Hmean     4        1174.61 (   0.00%)     1207.86 *   2.83%*
Hmean     8        1665.10 (   0.00%)     1667.27 *   0.13%*
Hmean     16       2215.59 (   0.00%)     2160.93 *  -2.47%*
Hmean     32       2727.05 (   0.00%)     2633.26 *  -3.44%*
Hmean     64       3128.64 (   0.00%)     3098.73 *  -0.96%*
Hmean     128      3282.89 (   0.00%)     3340.26 *   1.75%*
Hmean     1024     2551.02 (   0.00%)     2559.41 *   0.33%*
BHmean-50 1         509.87 (   0.00%)      495.10 (  -2.90%)
BHmean-50 2         829.35 (   0.00%)      828.14 (  -0.15%)
BHmean-50 4        1182.38 (   0.00%)     1219.30 (   3.12%)
BHmean-50 8        1678.49 (   0.00%)     1678.83 (   0.02%)
BHmean-50 16       2251.01 (   0.00%)     2194.52 (  -2.51%)
BHmean-50 32       2751.39 (   0.00%)     2678.45 (  -2.65%)
BHmean-50 64       3189.69 (   0.00%)     3154.45 (  -1.10%)
BHmean-50 128      3396.18 (   0.00%)     3451.59 (   1.63%)
BHmean-50 1024     2836.80 (   0.00%)     2836.84 (   0.00%)
BHmean-95 1         506.13 (   0.00%)      493.24 (  -2.55%)
BHmean-95 2         824.84 (   0.00%)      824.30 (  -0.06%)
BHmean-95 4        1175.91 (   0.00%)     1208.57 (   2.78%)
BHmean-95 8        1666.46 (   0.00%)     1668.22 (   0.11%)
BHmean-95 16       2219.59 (   0.00%)     2163.86 (  -2.51%)
BHmean-95 32       2731.26 (   0.00%)     2640.34 (  -3.33%)
BHmean-95 64       3144.73 (   0.00%)     3108.59 (  -1.15%)
BHmean-95 128      3306.51 (   0.00%)     3363.33 (   1.72%)
BHmean-95 1024     2658.37 (   0.00%)     2668.88 (   0.40%)
BHmean-99 1         505.37 (   0.00%)      493.08 (  -2.43%)
BHmean-99 2         824.31 (   0.00%)      824.12 (  -0.02%)
BHmean-99 4        1174.94 (   0.00%)     1208.02 (   2.81%)
BHmean-99 8        1665.40 (   0.00%)     1667.48 (   0.12%)
BHmean-99 16       2216.51 (   0.00%)     2161.60 (  -2.48%)
BHmean-99 32       2728.09 (   0.00%)     2635.09 (  -3.41%)
BHmean-99 64       3135.81 (   0.00%)     3102.12 (  -1.07%)
BHmean-99 128      3291.11 (   0.00%)     3349.16 (   1.76%)
BHmean-99 1024     2645.54 (   0.00%)     2655.67 (   0.38%)


                      dbench      dbench
                     default         pan
Duration User         822.55      827.85
Duration System      8384.99     8164.83
Duration Elapsed     1671.36     1670.74

                                         dbench         dbench
                                        default            pan
Ops NUMA alloc hit                 183324626.00   182350114.00
Ops NUMA alloc miss                        0.00           0.00
Ops NUMA interleave hit                    0.00           0.00
Ops NUMA alloc local               183324508.00   182350004.00
Ops NUMA base-page range updates      181531.00      515929.00
Ops NUMA PTE updates                  181531.00      515929.00
Ops NUMA PMD updates                       0.00           0.00
Ops NUMA hint faults                  162742.00      510979.00
Ops NUMA hint local faults %          120309.00      426848.00
Ops NUMA hint local percent               73.93          83.54
Ops NUMA pages migrated                37605.00       59519.00
Ops AutoNUMA cost                        815.70        2559.64

Netperf-RR
----------
netperf-udp-rr
                           netperf                netperf
                        rr-default                 rr-pan
Min       1   104915.69 (   0.00%)   104505.71 (  -0.39%)
Hmean     1   105865.46 (   0.00%)   105899.22 *   0.03%*
Stddev    1      528.45 (   0.00%)      881.92 ( -66.89%)
CoeffVar  1        0.50 (   0.00%)        0.83 ( -66.83%)
Max       1   106410.28 (   0.00%)   107196.52 (   0.74%)
BHmean-50 1   106232.53 (   0.00%)   106568.26 (   0.32%)
BHmean-95 1   105972.05 (   0.00%)   106056.35 (   0.08%)
BHmean-99 1   105972.05 (   0.00%)   106056.35 (   0.08%)

                     netperf     netperf
                  rr-default      rr-pan
Duration User          11.20       10.74
Duration System       202.40      201.32
Duration Elapsed      303.09      303.08

                                        netperf        netperf
                                     rr-default         rr-pan
Ops NUMA alloc hit                    183999.00      183853.00
Ops NUMA alloc miss                        0.00           0.00
Ops NUMA interleave hit                    0.00           0.00
Ops NUMA alloc local                  183999.00      183853.00
Ops NUMA base-page range updates           0.00       24370.00
Ops NUMA PTE updates                       0.00       24370.00
Ops NUMA PMD updates                       0.00           0.00
Ops NUMA hint faults                     539.00       24470.00
Ops NUMA hint local faults %             539.00       24447.00
Ops NUMA hint local percent              100.00          99.91
Ops NUMA pages migrated                    0.00          23.00
Ops AutoNUMA cost                          2.69         122.52

netperf-tcp-rr
                           netperf                netperf
                        rr-default                 rr-pan
Min       1    96156.03 (   0.00%)    96556.87 (   0.42%)
Hmean     1    96627.24 (   0.00%)    97551.38 *   0.96%*
Stddev    1      284.71 (   0.00%)      637.74 (-123.99%)
CoeffVar  1        0.29 (   0.00%)        0.65 (-121.87%)
Max       1    96974.45 (   0.00%)    98554.94 (   1.63%)
BHmean-50 1    96840.81 (   0.00%)    98067.19 (   1.27%)
BHmean-95 1    96679.89 (   0.00%)    97663.14 (   1.02%)
BHmean-99 1    96679.89 (   0.00%)    97663.14 (   1.02%)

                     netperf     netperf
                  rr-default      rr-pan
Duration User          10.21       10.26
Duration System       207.90      208.28
Duration Elapsed      302.99      303.02

                                        netperf        netperf
                                     rr-default         rr-pan
Ops NUMA alloc hit                    183669.00      183695.00
Ops NUMA alloc miss                        0.00           0.00
Ops NUMA interleave hit                    0.00           0.00
Ops NUMA alloc local                  183657.00      183695.00
Ops NUMA base-page range updates        3949.00       38561.00
Ops NUMA PTE updates                    3949.00       38561.00
Ops NUMA PMD updates                       0.00           0.00
Ops NUMA hint faults                    4186.00       43328.00
Ops NUMA hint local faults %            4100.00       43195.00
Ops NUMA hint local percent               97.95          99.69
Ops NUMA pages migrated                    9.00          73.00
Ops AutoNUMA cost                         20.96         216.91

Autonumabench
-------------
autonumabench
                                           autonumabench          autonumabench
                                                 default                    pan
Amean     syst-NUMA01                11664.40 (   0.00%)    11616.17 *   0.41%*
Amean     syst-NUMA01_THREADLOCAL        0.24 (   0.00%)        0.22 *   7.78%*
Amean     syst-NUMA02                    1.55 (   0.00%)        9.31 *-499.26%*
Amean     syst-NUMA02_SMT                1.14 (   0.00%)        4.04 *-254.39%*
Amean     elsp-NUMA01                  223.52 (   0.00%)      221.43 *   0.93%*
Amean     elsp-NUMA01_THREADLOCAL        0.95 (   0.00%)        0.94 *   0.76%*
Amean     elsp-NUMA02                    6.83 (   0.00%)        5.74 *  15.90%*
Amean     elsp-NUMA02_SMT                6.65 (   0.00%)        6.25 *   5.97%*
BAmean-50 syst-NUMA01                11455.44 (   0.00%)    10985.76 (   4.10%)
BAmean-50 syst-NUMA01_THREADLOCAL        0.22 (   0.00%)        0.21 (   7.46%)
BAmean-50 syst-NUMA02                    1.11 (   0.00%)        8.91 (-703.00%)
BAmean-50 syst-NUMA02_SMT                0.94 (   0.00%)        3.42 (-262.19%)
BAmean-50 elsp-NUMA01                  217.38 (   0.00%)      214.03 (   1.54%)
BAmean-50 elsp-NUMA01_THREADLOCAL        0.94 (   0.00%)        0.94 (   0.35%)
BAmean-50 elsp-NUMA02                    6.66 (   0.00%)        5.45 (  18.08%)
BAmean-50 elsp-NUMA02_SMT                6.50 (   0.00%)        6.09 (   6.31%)
BAmean-95 syst-NUMA01                11611.74 (   0.00%)    11448.30 (   1.41%)
BAmean-95 syst-NUMA01_THREADLOCAL        0.23 (   0.00%)        0.22 (   7.14%)
BAmean-95 syst-NUMA02                    1.27 (   0.00%)        9.21 (-624.93%)
BAmean-95 syst-NUMA02_SMT                0.97 (   0.00%)        3.90 (-300.34%)
BAmean-95 elsp-NUMA01                  221.75 (   0.00%)      218.53 (   1.45%)
BAmean-95 elsp-NUMA01_THREADLOCAL        0.94 (   0.00%)        0.94 (   0.53%)
BAmean-95 elsp-NUMA02                    6.75 (   0.00%)        5.68 (  15.81%)
BAmean-95 elsp-NUMA02_SMT                6.61 (   0.00%)        6.23 (   5.82%)
BAmean-99 syst-NUMA01                11611.74 (   0.00%)    11448.30 (   1.41%)
BAmean-99 syst-NUMA01_THREADLOCAL        0.23 (   0.00%)        0.22 (   7.14%)
BAmean-99 syst-NUMA02                    1.27 (   0.00%)        9.21 (-624.93%)
BAmean-99 syst-NUMA02_SMT                0.97 (   0.00%)        3.90 (-300.34%)
BAmean-99 elsp-NUMA01                  221.75 (   0.00%)      218.53 (   1.45%)
BAmean-99 elsp-NUMA01_THREADLOCAL        0.94 (   0.00%)        0.94 (   0.53%)
BAmean-99 elsp-NUMA02                    6.75 (   0.00%)        5.68 (  15.81%)
BAmean-99 elsp-NUMA02_SMT                6.61 (   0.00%)        6.23 (   5.82%)

                autonumabenchautonumabench
                     default         pan
Duration User       94363.43    94436.71
Duration System     81671.72    81408.53
Duration Elapsed     1676.81     1647.99

                                  autonumabench  autonumabench
                                        default            pan
Ops NUMA alloc hit                 539544115.00   539522029.00
Ops NUMA alloc miss                        0.00           0.00
Ops NUMA interleave hit                    0.00           0.00
Ops NUMA alloc local               279025768.00   281735736.00
Ops NUMA base-page range updates    69695169.00    84767502.00
Ops NUMA PTE updates                69695169.00    84767502.00
Ops NUMA PMD updates                       0.00           0.00
Ops NUMA hint faults                69691818.00    87895044.00
Ops NUMA hint local faults %        56565519.00    65819747.00
Ops NUMA hint local percent               81.17          74.88
Ops NUMA pages migrated              5950362.00     8310169.00
Ops AutoNUMA cost                     349060.01      440226.49

Here is a short description of different benchmarks used:

NAS Parallel benchmarks
-----------------------
Using OpenMP version from https://www.nas.nasa.gov/software/npb.html
Variations tried: BT, CG, MT and FT
Memory Footprint:
BT - 170GB
CG - 196GB
MG - 211GB
FT - 81GB
Results: Operations per second.

Hashjoin
--------
Benchmark from IISc that does SQL join between two tables.
Used the version from https://github.com/mitosis-project/mitosis-asplos20-artifact 
It performs a fixed number of join operations
Memory Footprint: 80GB
Results: Time taken

Graph500
--------
Benchmark from https://graph500.org/ that does bread first search
on a graph. The score is reported as TEPS (Traversed Edges Per Second).
It comprises of both search and validation phases, but only the
score phase is contributing to the final score here.
Memory Footprint: 70GB
Results: TEPS

PageRank
--------
This is part of GAP Benchmark Suite from https://github.com/sbeamer/gapbs
It performs basic search operations.
Memory Footprint: 91GB
Results: Time taken

Disha Talreja (3):
  sched/numa: Process based autonuma scan period framework
  sched/numa: Add cumulative history of per-process fault stats
  sched/numa: Add adaptive scan period calculation

 include/linux/mm_types.h |  14 ++
 kernel/sched/debug.c     |   2 +
 kernel/sched/fair.c      | 344 ++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h     |   2 +
 4 files changed, 358 insertions(+), 4 deletions(-)

-- 
2.25.1

