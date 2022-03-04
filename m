Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857294CCE18
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 07:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbiCDGuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 01:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiCDGuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 01:50:15 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDA514A200;
        Thu,  3 Mar 2022 22:49:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTLbpJb0+txVgGWplO3/QNIfjtsrE0ixQ0yBbSl6x1JQ8Vpfj2AwOpya98SQkldwSNqoMAZmmcxl1nABgjT1rRvVQ6WwGLejwhJfTsmvvFtwXBVkqya2PZXjrLKisGZMJVRbQ75ji4LWcIs4HIVDjPC3MH3iCCtBWrrns5Qu5y5nQYnnXaN5THHhUqFdxFCct67vNZovNvUBEaMoyW6u5PdsrwLLlEJPxOMci1kRfMdIt+dSkPJKPciEzAAOdMdcZcnACLPOLbk/3fzl48XFEAVIPVTPWCG1bas76lK83UCcGrWMSs1IPmMsfHzHCYbbBPAxlovLK6dGmpYSLi4VAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ul1j1pNN/9ZMcIlMOqZeWH2/++HXGLSXFpLSTKwsOvo=;
 b=fqiiJudA0hTZI4xlccz+6p3Mxxs6VjM6LUUnto+ItvTxsrse9hA29acYP8No76Ga5LvJRMg/7S5HCZvuMMdzwEDtXazw3MYcG/p5waSheYN4FX08qFb76dAGPMGL5jYEsce4g1q5Ajv9cD0/uwRp25IGyQWg27NDu0uOTeQwT8wVyq79DcmNxbTbxwQbTA15LKSSkJABYfN2JJH5aWXKwhLiW86+q4/XXefi+9Ni9So3Xy4pMXJhE/suQ6LDwL6Lwk2p49L+4DOQowG/obwZ0D+dEWJ7sLYt2eIfFFTtH6Sz5edngWUmtes8SHT/zeD5ODXmTJpCHmfIsIDahV5IPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ul1j1pNN/9ZMcIlMOqZeWH2/++HXGLSXFpLSTKwsOvo=;
 b=W6/2NaDOOhZWy3CdvNRW5uQyvWV3FZAHWkdXh97HhnAZ7HjRYexe4WD6cQBGdq5aleBEl97NwlzZA87vL/H/P6zjytvkrC9uZ++jiPC+jiGJ3DSscDt0mp9sCsYOtA/jDuL/iSP0jtDWsSO3RqqvSRtxF844/W2MwaSULuLWliA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 SN1PR12MB2384.namprd12.prod.outlook.com (2603:10b6:802:25::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.17; Fri, 4 Mar 2022 06:49:24 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8d40:da47:7312:64b8]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8d40:da47:7312:64b8%6]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 06:49:24 +0000
Date:   Fri, 4 Mar 2022 14:48:58 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "dsmythies@telus.net" <dsmythies@telus.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "todd.e.brandt@linux.intel.com" <todd.e.brandt@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>
Subject: Re: [PATCH V2 3/4] tools/power/x86/amd_pstate_tracer: Add tracer
 tool for AMD P-state
Message-ID: <YiG2Wja1D0EJpmG7@amd.com>
References: <20220304060724.314582-1-Jinzhou.Su@amd.com>
 <20220304060724.314582-4-Jinzhou.Su@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304060724.314582-4-Jinzhou.Su@amd.com>
X-ClientProxiedBy: SG2PR06CA0211.apcprd06.prod.outlook.com
 (2603:1096:4:68::19) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7905b67-d2e1-4d20-a604-08d9fdab1e41
X-MS-TrafficTypeDiagnostic: SN1PR12MB2384:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB238409A67FEE9090B2A9EB26EC059@SN1PR12MB2384.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KLpDaNRS+omVQwhDyqk8Z83MV5UfNoBEIi56BYRimUe9DeWq01xubLmcokqxH29d8OnCQXGKnAjDcJMeUL8cdwY9SgAiGUExRbt7Oei1ASJAeUNN0lljiHUpb+6K1MyarkT2Ha7bj6EBW3f72JwC6ejmgU/LucYkvZkTCoyE07/ESHl+vbXgTMF2z/LTti1uBmec/g8In2KmNnYK83sU8hmbLslDu70ltup+OXbgWUBM5oeq/rRpHbGBZVpqkUgG3rBxEIn5vv1uFULfP+BgWnQTFrbixJ08+W6SQGhmgSs9IYFKDNXY4JLCAW5gvxpt1fbOLlRiQM7Yq+KO+yq2GGkPMI0yWE2YmBdpK8pp4wmX8bxYCwHpWZ3w3YVvBpU/oqm63Ry/vRvV5SbtxIRlZDdkehTh7ieGeVO+0eaitCT3V7rbmmCtaL89AluEO5hKsVSGzvodwRo2kKUw2iFWsCKvGoJyISUDdDd9GmZOdR51V/7NiGAxNQ/nqDbd9nErzKKIV4TUWHyzzgEoyNwKT58RcQhZJfv4uJMqyT4/X3U91gkKMFylisb86WIAIaA71Y/ZHQRyDsbbiHLkTN/L9mOV7iSLWkCzbQe+5DqUxRAdiBAIHA6QhXhw4PpUq5+311VlW2OsaDrNsVxXFnlHiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6636002)(66946007)(86362001)(6486002)(2906002)(8676002)(6862004)(66556008)(66476007)(4326008)(83380400001)(5660300002)(316002)(30864003)(54906003)(36756003)(37006003)(8936002)(508600001)(38100700002)(6506007)(6512007)(6666004)(2616005)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8cOoLNzCg3MbP48Bounq/xC9X3x2heDiTcS8Q+rxZxdB2gvkfsp2YoKvQnPm?=
 =?us-ascii?Q?LEwRFPPSLz/J7iyZLmRiSGpAFurwbnot6bm2jjKHrhFOixXVbJtIylYywaBN?=
 =?us-ascii?Q?deLPe5BShGR06xi/I78mAfd0PBkkSfoS3teNSy5k0AUJJ5ojI+GnWH2Vx6BB?=
 =?us-ascii?Q?vVZKhGM9EvayPOXzSu7FGF8k50Bw1S7TACgWHZI6yiteXPeY70AXQHrKN013?=
 =?us-ascii?Q?Q2r2JDXc87GaCLZCaXQYp5drqneMY/BumHVsSItpNmzNW/Xo8gm1IMlQ25ay?=
 =?us-ascii?Q?n3K8m16L/KquQLo4xPKaE+jHiCrwJ6FRYcYM9nM/0twQyeht76qH5J+HBM0B?=
 =?us-ascii?Q?ND5afCkTnMr9QubBF0guczthpmW9MHp5mkyrFinGj/kYoM7qShGtktdUYfOT?=
 =?us-ascii?Q?Dj1sAgX5P//OWEvYlQxM+ILrhO1fpGg2yuks8Tvydwc9Bjkhg051PKSepNFx?=
 =?us-ascii?Q?t+Wm8F/dCUfoRMy1MuWhh4oaQ7w2Tgpt9ONP0sj2BD00vd/tTfKkA5IZQZiX?=
 =?us-ascii?Q?VXzzGFu1ULxcd1k3nvu5RTNCsWgHuJx0GrTfOsHjjl0RIvnrqqBQzZJJfdjQ?=
 =?us-ascii?Q?qJuG8FgbNmEJH6svaizuQqh8JYATr7t2g+qYvcE9nFn04+2AGow0tcdZL4zu?=
 =?us-ascii?Q?C0PHVP+bfG8V9iYJSWTJicE7nxUQ6UFFg4ov34EXaUV+PE+U1eJxm9xRBF0v?=
 =?us-ascii?Q?wTikjjdoZTxlAPfAhLvZFh9ehOe8+m2Uz4p9pY4xpIkiaTZzPCBDQasN1HHA?=
 =?us-ascii?Q?E+AHXvbdlK7rBhSmMsnaxaSHUL2CZjXEoiScNraU4mCFxc3dXWLgByTs8cIl?=
 =?us-ascii?Q?EmrqdPItQI3Ib7CXK/HlT+S7MhStYsm7QFrNrlo/bCAZDBicHs58TmaammIp?=
 =?us-ascii?Q?MwE6AR9iaNKKK34mq6OGUhQgjd3Xom6SllaMDvjkkV053O4IpNrlTF79gDJa?=
 =?us-ascii?Q?8bRVybmuCqXuCFYPUT6dM+XZpfWtn2D44xJHGKVIdaMS8yRXp4vCQal6cOH4?=
 =?us-ascii?Q?lUsw3aTgpG2sR3SC5i6sTe7lJsUIctVdKTKHDUml+9bdi4DPQ1QfPLHLcish?=
 =?us-ascii?Q?3w4iHFqLWeogjoMYnqo0mWG5/v9DeY2oNdLLP/gnkgefXP5PAzOjC5Owx/Jb?=
 =?us-ascii?Q?bAGQQe+n/lhLA91AQZORWjVeq/vkb4I/yvPHls2lf7eks4JOtD27EcaHcmyN?=
 =?us-ascii?Q?WIHqkWLvkfz3rIgl536cHTgYjQ1kGsowtLefTuBg+usfjXCs3zLO8ro2CBDU?=
 =?us-ascii?Q?bIQFgM0KcETZAm8ONl+1R7+T4l5ehaKxFXn397MDGxLKuvdYSiNJRjCxQEy9?=
 =?us-ascii?Q?rj03dcMa+e/S0Rxs53/sGoZeG3e22bJ+M7MuovF9fGNXIVzV2XM6xq62RtGW?=
 =?us-ascii?Q?iSzohsY5i+jbTEO63skVGCJCRL026BWVVVkUrLQ1FNrp0S1rorWLomrAKn2r?=
 =?us-ascii?Q?8wUa1BS/peV47BQKyMT+OOIySMOVnc2rtb8xS4JaSkj/s0ObaYT1+bHOJHbt?=
 =?us-ascii?Q?pNi1lJ+4GLBs2FNAIECWeA6T+mCG5ZAgGu0gc3Gy/57qt3YJY8vwFyU/HLw9?=
 =?us-ascii?Q?ZfswtaDOPYiPf30KVr+s89bT9kE1Qk/811YuW92ZNWs8zWv9I4/DBXJYeLxy?=
 =?us-ascii?Q?cFH30YWHkRsYSPPlG2/hw0w=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7905b67-d2e1-4d20-a604-08d9fdab1e41
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 06:49:24.0989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJrG3Eatmjb/TaZnJkzuToMX9z5fxYHniwBySDHU+lzKhaLGbXQj1TyBsTGObgmiZnGnK94rlsJTDsnLoeV/Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2384
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 02:07:23PM +0800, Su, Jinzhou (Joe) wrote:
> Intel P-state tracer is a useful tool to tune and debug Intel P-state
> driver. AMD P-state tracer import intel pstate tracer. This tool can
> be used to analyze the performance of AMD P-state tracer.
> 
> Now CPU frequency, load and desired perf can be traced.
> 
> Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  MAINTAINERS                                   |   1 +
>  .../x86/amd_pstate_tracer/amd_pstate_trace.py | 354 ++++++++++++++++++
>  2 files changed, 355 insertions(+)
>  create mode 100755 tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4f9acc183cdc..01ac42504dcd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1002,6 +1002,7 @@ L:	linux-pm@vger.kernel.org
>  S:	Supported
>  F:	Documentation/admin-guide/pm/amd-pstate.rst
>  F:	drivers/cpufreq/amd-pstate*
> +F:	tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
>  
>  AMD PTDMA DRIVER
>  M:	Sanjay R Mehta <sanju.mehta@amd.com>
> diff --git a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py b/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
> new file mode 100755
> index 000000000000..2dea4032ac56
> --- /dev/null
> +++ b/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
> @@ -0,0 +1,354 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0-only
> +# -*- coding: utf-8 -*-
> +#
> +""" This utility can be used to debug and tune the performance of the
> +AMD P-State driver. It imports intel_pstate_tracer to analyze AMD P-State
> +trace event.
> +
> +Prerequisites:
> +    Python version 2.7.x or higher
> +    gnuplot 5.0 or higher
> +    gnuplot-py 1.8 or higher
> +    (Most of the distributions have these required packages. They may be called
> +     gnuplot-py, phython-gnuplot or phython3-gnuplot, gnuplot-nox, ... )
> +
> +    Kernel config for Linux trace is enabled
> +
> +    see print_help(): for Usage and Output details
> +
> +"""
> +from __future__ import print_function
> +from datetime import datetime
> +import subprocess
> +import os
> +import time
> +import re
> +import signal
> +import sys
> +import getopt
> +import Gnuplot
> +from numpy import *
> +from decimal import *
> +sys.path.append('../intel_pstate_tracer')
> +#import intel_pstate_tracer
> +import intel_pstate_tracer as ipt
> +
> +__license__ = "GPL version 2"
> +
> +MAX_CPUS = 256
> +# Define the csv file columns
> +C_COMM = 15
> +C_ELAPSED = 14
> +C_SAMPLE = 13
> +C_DURATION = 12
> +C_LOAD = 11
> +C_TSC = 10
> +C_APERF = 9
> +C_MPERF = 8
> +C_FREQ = 7
> +C_MAX_PERF = 6
> +C_DES_PERF = 5
> +C_MIN_PERF = 4
> +C_USEC = 3
> +C_SEC = 2
> +C_CPU = 1
> +
> +global sample_num, last_sec_cpu, last_usec_cpu, start_time, test_name, trace_file
> +
> +getcontext().prec = 11
> +
> +sample_num =0
> +last_sec_cpu = [0] * MAX_CPUS
> +last_usec_cpu = [0] * MAX_CPUS
> +
> +def plot_per_cpu_freq(cpu_index):
> +    """ Plot per cpu frequency """
> +
> +    file_name = 'cpu{:0>3}.csv'.format(cpu_index)
> +    if os.path.exists(file_name):
> +        output_png = "cpu%03d_frequency.png" % cpu_index
> +        g_plot = ipt.common_gnuplot_settings()
> +        g_plot('set output "' + output_png + '"')
> +        g_plot('set yrange [0:7]')
> +        g_plot('set ytics 0, 1')
> +        g_plot('set ylabel "CPU Frequency (GHz)"')
> +        g_plot('set title "{} : frequency : CPU {:0>3} : {:%F %H:%M}"'.format(test_name, cpu_index, datetime.now()))
> +        g_plot('set ylabel "CPU frequency"')
> +        g_plot('set key off')
> +        ipt.set_4_plot_linestyles(g_plot)
> +        g_plot('plot "' + file_name + '" using {:d}:{:d} with linespoints linestyle 1 axis x1y1'.format(C_ELAPSED, C_FREQ))
> +
> +def plot_per_cpu_des_perf(cpu_index):
> +    """ Plot per cpu desired perf """
> +
> +    file_name = 'cpu{:0>3}.csv'.format(cpu_index)
> +    if os.path.exists(file_name):
> +        output_png = "cpu%03d_des_perf.png" % cpu_index
> +        g_plot = ipt.common_gnuplot_settings()
> +        g_plot('set output "' + output_png + '"')
> +        g_plot('set yrange [0:255]')
> +        g_plot('set ylabel "des perf"')
> +        g_plot('set title "{} : cpu des perf : CPU {:0>3} : {:%F %H:%M}"'.format(test_name, cpu_index, datetime.now()))
> +        g_plot('set key off')
> +        ipt.set_4_plot_linestyles(g_plot)
> +        g_plot('plot "' + file_name + '" using {:d}:{:d} with linespoints linestyle 1 axis x1y1'.format(C_ELAPSED, C_DES_PERF))
> +
> +def plot_per_cpu_load(cpu_index):
> +    """ Plot per cpu load """
> +
> +    file_name = 'cpu{:0>3}.csv'.format(cpu_index)
> +    if os.path.exists(file_name):
> +        output_png = "cpu%03d_load.png" % cpu_index
> +        g_plot = ipt.common_gnuplot_settings()
> +        g_plot('set output "' + output_png + '"')
> +        g_plot('set yrange [0:100]')
> +        g_plot('set ytics 0, 10')
> +        g_plot('set ylabel "CPU load (percent)"')
> +        g_plot('set title "{} : cpu load : CPU {:0>3} : {:%F %H:%M}"'.format(test_name, cpu_index, datetime.now()))
> +        g_plot('set key off')
> +        ipt.set_4_plot_linestyles(g_plot)
> +        g_plot('plot "' + file_name + '" using {:d}:{:d} with linespoints linestyle 1 axis x1y1'.format(C_ELAPSED, C_LOAD))
> +
> +def plot_all_cpu_frequency():
> +    """ Plot all cpu frequencies """
> +
> +    output_png = 'all_cpu_frequencies.png'
> +    g_plot = ipt.common_gnuplot_settings()
> +    g_plot('set output "' + output_png + '"')
> +    g_plot('set ylabel "CPU Frequency (GHz)"')
> +    g_plot('set title "{} : cpu frequencies : {:%F %H:%M}"'.format(test_name, datetime.now()))
> +
> +    title_list = subprocess.check_output('ls cpu???.csv | sed -e \'s/.csv//\'',shell=True).decode('utf-8').replace('\n', ' ')
> +    plot_str = "plot for [i in title_list] i.'.csv' using {:d}:{:d} pt 7 ps 1 title i".format(C_ELAPSED, C_FREQ)
> +    g_plot('title_list = "{}"'.format(title_list))
> +    g_plot(plot_str)
> +
> +def plot_all_cpu_des_perf():
> +    """ Plot all cpu desired perf """
> +
> +    output_png = 'all_cpu_des_perf.png'
> +    g_plot = ipt.common_gnuplot_settings()
> +    g_plot('set output "' + output_png + '"')
> +    g_plot('set ylabel "des perf"')
> +    g_plot('set title "{} : cpu des perf : {:%F %H:%M}"'.format(test_name, datetime.now()))
> +
> +    title_list = subprocess.check_output('ls cpu???.csv | sed -e \'s/.csv//\'',shell=True).decode('utf-8').replace('\n', ' ')
> +    plot_str = "plot for [i in title_list] i.'.csv' using {:d}:{:d} pt 255 ps 1 title i".format(C_ELAPSED, C_DES_PERF)
> +    g_plot('title_list = "{}"'.format(title_list))
> +    g_plot(plot_str)
> +
> +def plot_all_cpu_load():
> +    """ Plot all cpu load  """
> +
> +    output_png = 'all_cpu_load.png'
> +    g_plot = ipt.common_gnuplot_settings()
> +    g_plot('set output "' + output_png + '"')
> +    g_plot('set yrange [0:100]')
> +    g_plot('set ylabel "CPU load (percent)"')
> +    g_plot('set title "{} : cpu load : {:%F %H:%M}"'.format(test_name, datetime.now()))
> +
> +    title_list = subprocess.check_output('ls cpu???.csv | sed -e \'s/.csv//\'',shell=True).decode('utf-8').replace('\n', ' ')
> +    plot_str = "plot for [i in title_list] i.'.csv' using {:d}:{:d} pt 255 ps 1 title i".format(C_ELAPSED, C_LOAD)
> +    g_plot('title_list = "{}"'.format(title_list))
> +    g_plot(plot_str)
> +
> +def store_csv(cpu_int, time_pre_dec, time_post_dec, min_perf, des_perf, max_perf, freq_ghz, mperf, aperf, tsc, common_comm, load, duration_ms, sample_num, elapsed_time, cpu_mask):
> +    """ Store master csv file information """
> +
> +    global graph_data_present
> +
> +    if cpu_mask[cpu_int] == 0:
> +        return
> +
> +    try:
> +        f_handle = open('cpu.csv', 'a')
> +        string_buffer = "CPU_%03u, %05u, %06u, %u, %u, %u, %.4f, %u, %u, %u, %.2f, %.3f, %u, %.3f, %s\n" % (cpu_int, int(time_pre_dec), int(time_post_dec), int(min_perf), int(des_perf), int(max_perf), freq_ghz, int(mperf), int(aperf), int(tsc), load, duration_ms, sample_num, elapsed_time, common_comm)
> +        f_handle.write(string_buffer)
> +        f_handle.close()
> +    except:
> +        print('IO error cpu.csv')
> +        return
> +
> +    graph_data_present = True;
> +
> +
> +def cleanup_data_files():
> +    """ clean up existing data files """
> +
> +    if os.path.exists('cpu.csv'):
> +        os.remove('cpu.csv')
> +    f_handle = open('cpu.csv', 'a')
> +    f_handle.write('common_cpu, common_secs, common_usecs, min_perf, des_perf, max_perf, freq, mperf, aperf, tsc, load, duration_ms, sample_num, elapsed_time, common_comm')
> +    f_handle.write('\n')
> +    f_handle.close()
> +
> +def read_trace_data(file_name, cpu_mask):
> +    """ Read and parse trace data """
> +
> +    global current_max_cpu
> +    global sample_num, last_sec_cpu, last_usec_cpu, start_time
> +
> +    try:
> +        data = open(file_name, 'r').read()
> +    except:
> +        print('Error opening ', file_name)
> +        sys.exit(2)
> +
> +    for line in data.splitlines():
> +        search_obj = \
> +            re.search(r'(^(.*?)\[)((\d+)[^\]])(.*?)(\d+)([.])(\d+)(.*?amd_min_perf=)(\d+)(.*?amd_des_perf=)(\d+)(.*?amd_max_perf=)(\d+)(.*?freq=)(\d+)(.*?mperf=)(\d+)(.*?aperf=)(\d+)(.*?tsc=)(\d+)'
> +                      , line)
> +
> +        if search_obj:
> +            cpu = search_obj.group(3)
> +            cpu_int = int(cpu)
> +            cpu = str(cpu_int)
> +
> +            time_pre_dec = search_obj.group(6)
> +            time_post_dec = search_obj.group(8)
> +            min_perf = search_obj.group(10)
> +            des_perf = search_obj.group(12)
> +            max_perf = search_obj.group(14)
> +            freq = search_obj.group(16)
> +            mperf = search_obj.group(18)
> +            aperf = search_obj.group(20)
> +            tsc = search_obj.group(22)
> +
> +            common_comm = search_obj.group(2).replace(' ', '')
> +
> +            if sample_num == 0 :
> +                start_time = Decimal(time_pre_dec) + Decimal(time_post_dec) / Decimal(1000000)
> +            sample_num += 1
> +
> +            if last_sec_cpu[cpu_int] == 0 :
> +                last_sec_cpu[cpu_int] = time_pre_dec
> +                last_usec_cpu[cpu_int] = time_post_dec
> +            else :
> +                duration_us = (int(time_pre_dec) - int(last_sec_cpu[cpu_int])) * 1000000 + (int(time_post_dec) - int(last_usec_cpu[cpu_int]))
> +                duration_ms = Decimal(duration_us) / Decimal(1000)
> +                last_sec_cpu[cpu_int] = time_pre_dec
> +                last_usec_cpu[cpu_int] = time_post_dec
> +                elapsed_time = Decimal(time_pre_dec) + Decimal(time_post_dec) / Decimal(1000000) - start_time
> +                load = Decimal(int(mperf)*100)/ Decimal(tsc)
> +                freq_ghz = Decimal(freq)/Decimal(1000000)
> +                store_csv(cpu_int, time_pre_dec, time_post_dec, min_perf, des_perf, max_perf, freq_ghz, mperf, aperf, tsc, common_comm, load, duration_ms, sample_num, elapsed_time, cpu_mask)
> +
> +            if cpu_int > current_max_cpu:
> +                current_max_cpu = cpu_int
> +# Now separate the main overall csv file into per CPU csv files.
> +    ipt.split_csv(current_max_cpu, cpu_mask)
> +
> +
> +def signal_handler(signal, frame):
> +    print(' SIGINT: Forcing cleanup before exit.')
> +    if interval:
> +        ipt.disable_trace(trace_file)
> +        ipt.clear_trace_file()
> +        ipt.free_trace_buffer()
> +        sys.exit(0)
> +
> +trace_file = "/sys/kernel/debug/tracing/events/amd_cpu/enable"
> +signal.signal(signal.SIGINT, signal_handler)
> +
> +interval = ""
> +file_name = ""
> +cpu_list = ""
> +test_name = ""
> +memory = "10240"
> +graph_data_present = False;
> +
> +valid1 = False
> +valid2 = False
> +
> +cpu_mask = zeros((MAX_CPUS,), dtype=int)
> +
> +
> +try:
> +    opts, args = getopt.getopt(sys.argv[1:],"ht:i:c:n:m:",["help","trace_file=","interval=","cpu=","name=","memory="])
> +except getopt.GetoptError:
> +    ipt.print_help('amd_pstate')
> +    sys.exit(2)
> +for opt, arg in opts:
> +    if opt == '-h':
> +        print()
> +        sys.exit()
> +    elif opt in ("-t", "--trace_file"):
> +        valid1 = True
> +        location = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__)))
> +        file_name = os.path.join(location, arg)
> +    elif opt in ("-i", "--interval"):
> +        valid1 = True
> +        interval = arg
> +    elif opt in ("-c", "--cpu"):
> +        cpu_list = arg
> +    elif opt in ("-n", "--name"):
> +        valid2 = True
> +        test_name = arg
> +    elif opt in ("-m", "--memory"):
> +        memory = arg
> +
> +if not (valid1 and valid2):
> +    ipt.print_help('amd_pstate')
> +    sys.exit()
> +
> +if cpu_list:
> +    for p in re.split("[,]", cpu_list):
> +        if int(p) < MAX_CPUS :
> +            cpu_mask[int(p)] = 1
> +else:
> +    for i in range (0, MAX_CPUS):
> +        cpu_mask[i] = 1
> +
> +if not os.path.exists('results'):
> +    os.mkdir('results')
> +    ipt.fix_ownership('results')
> +
> +os.chdir('results')
> +if os.path.exists(test_name):
> +    print('The test name directory already exists. Please provide a unique test name. Test re-run not supported, yet.')
> +    sys.exit()
> +os.mkdir(test_name)
> +ipt.fix_ownership(test_name)
> +os.chdir(test_name)
> +
> +cur_version = sys.version_info
> +print('python version (should be >= 2.7):')
> +print(cur_version)
> +
> +cleanup_data_files()
> +
> +if interval:
> +    file_name = "/sys/kernel/debug/tracing/trace"
> +    ipt.clear_trace_file()
> +    ipt.set_trace_buffer_size(memory)
> +    ipt.enable_trace(trace_file)
> +    time.sleep(int(interval))
> +    ipt.disable_trace(trace_file)
> +
> +current_max_cpu = 0
> +
> +read_trace_data(file_name, cpu_mask)
> +
> +if interval:
> +    ipt.clear_trace_file()
> +    ipt.free_trace_buffer()
> +
> +if graph_data_present == False:
> +    print('No valid data to plot')
> +    sys.exit(2)
> +
> +for cpu_no in range(0, current_max_cpu + 1):
> +    plot_per_cpu_freq(cpu_no)
> +    plot_per_cpu_des_perf(cpu_no)
> +    plot_per_cpu_load(cpu_no)
> +
> +plot_all_cpu_des_perf()
> +plot_all_cpu_frequency()
> +plot_all_cpu_load()
> +
> +for root, dirs, files in os.walk('.'):
> +    for f in files:
> +        ipt.fix_ownership(f)
> +
> +os.chdir('../../')
> -- 
> 2.27.0
> 
