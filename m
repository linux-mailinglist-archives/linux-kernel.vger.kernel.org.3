Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57A74CCDF8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 07:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238473AbiCDGpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 01:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiCDGp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 01:45:29 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0913F18A794;
        Thu,  3 Mar 2022 22:44:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RW1IV9dHBmq+ijvB0WHZjHvHKvCXf2D9lNfLE3LBfZuwVOdv0i9mxxL9FXCrXvQOh0OGa+0IUCkCtXO3VM4JyBmqtiL5kQ78lwCSzqxFNCYm9DJZcrb8fUrN7hUwhkzWTjd4YBY42a+Pwc2PLjllZKqMciRJg8mdysfxIQfIjDCHO61dyh65q/zPKsW8lh9/G/EdNOsgj+y496he5O5+OYck4mPek6ohCWIiwCnXPEkGRrHTLs2fqQ5u1vKis6cJBpAbCkDT8au23uWhCbymptJ0pdDWLyesnhBQzioka5V+ipcYAMgG7NPsIJtn9VVjBQAqRn3GArPieiLefW+OZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mNNmJu5KFYbe9gjFJzOb9vaOsFuFM6GN2Vf6sA/7RE=;
 b=B+JM0z4PKv7ruQPCk43NXrICOp5+UvcIxe/cuaxFnIu+tsIehjvG2BxUttefG7fe1AOubiYaG1+AcpGEmDzkxV045FhoOJGFCMOHqAk8IvqkPsNbmzE5pX/VxQPtP9xhggHJlGs7YPNGYbo7CwUrpF4pVD/pgY4/EtvoqM7a8IckCNTAPOoTtVLZzepkHs/MgMlxx+tQ615xQhQ4t0gGVjdPzF0X0cTfBs9u5ICKnR1i2lJvaS5r7pN2TCwbP+hX8hUyu/MqRQSq7RxSv/VsVtJIflK3bDA0s9twCAW8rsUxKPekaqPIa0fpN9G3AwLafCQX/j2MXZzl53dNjBYGZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mNNmJu5KFYbe9gjFJzOb9vaOsFuFM6GN2Vf6sA/7RE=;
 b=m83RGmhQoNMYrRnDslxhIhxGAPRqFVdHyuygmXgmjas96y3kylYOuyh1ln4HRmx4agS6WZZQjAlJcWkFGC96EoyPMOXOorogA5RTcCJjIv2x3BwfwPmFWWi9iV+R3Y9lMw2VEIQypCrOXw3QW9rom8NP/ZoYnB7CbDdww7qil/Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 SA0PR12MB4414.namprd12.prod.outlook.com (2603:10b6:806:9a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Fri, 4 Mar 2022 06:44:40 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8d40:da47:7312:64b8]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8d40:da47:7312:64b8%6]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 06:44:40 +0000
Date:   Fri, 4 Mar 2022 14:44:14 +0800
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
Subject: Re: [PATCH V2 2/4] tools/power/x86/intel_pstate_tracer: make tracer
 as a module
Message-ID: <YiG1Ppe/wFfvuuPH@amd.com>
References: <20220304060724.314582-1-Jinzhou.Su@amd.com>
 <20220304060724.314582-3-Jinzhou.Su@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304060724.314582-3-Jinzhou.Su@amd.com>
X-ClientProxiedBy: SG2PR01CA0175.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::31) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9f5c032-5a78-40cb-2003-08d9fdaa74e3
X-MS-TrafficTypeDiagnostic: SA0PR12MB4414:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB441499EAE0D8C2EA9337F2FEEC059@SA0PR12MB4414.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fVQGBNvzGnPBdC0NSiZPICMF+wSfxZuTyHpLQ+nGy9jXmnDF2XLoStxP9j35C03Wz2wIZcMnY/5cTAbhCFnHgcpoSFsBwuG/N1W5acfpEm5IxEHoNLDzyRWrb+BndjAR+MvXlfoJWOR/2UEjN1iLVNlNcDp157xSZbuy+WcU5JrMPHyha+ah6HshF0cOBIOe5I5SkVKLPD6paLF84Yll0Me6KCAMnQZntA4ymQCN9tX7qvh15o3tEb41EGPCmLDSNLERJHEyJO0Dj+CcYx93AlmTFISl8i9T2g/wu8pmpjC5BPYShXEdIvJoqTiR6U8RrmieA6vlUaFfR8JYjMDdPIoh8ibEMoo06cYx/JfJxXGErSeuXcu6tMUMmQLV4hm0O7AKmZo7kxpARGU45s7YsP4vB1F+ogR2cSN/Ow6Jpes2+Yb/DUYExmW/jXDRJ0Acs7MMqQi5P79x7Yaxz8xJ4kw5mYXN5+I8wT/kmwMIJdnq7n5K2uctRtXlqdQNlUnHplyqCwYTMSPyidGKZrf1YqiPIqyEhM0UncGBS6xNdCfC/C9Q3b4YtcYoFnAOhJ4GzdYgff/Zs5HxyHk5YLrRtQusWNM+PnFWgL68HtRJ7C7GxnfnVBeeNkgKeWQLeXyl9ICL/G7ilXAHZEBWmNLbeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(2906002)(6506007)(6666004)(36756003)(2616005)(6512007)(5660300002)(508600001)(30864003)(316002)(6636002)(54906003)(37006003)(83380400001)(26005)(186003)(8936002)(8676002)(38100700002)(4326008)(6862004)(86362001)(66556008)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cCoyEIZt7dEHgoJdyakEAPD9ezO0ih0v2vI4nFs2SDl2opUFZ2ereGC93s+G?=
 =?us-ascii?Q?v+SqKcl78nzcGWCo71OdGZhdwTQ5ahJdial6l7dUxj1BEYPiZmMXRFqWZThJ?=
 =?us-ascii?Q?ahQMyqv/zsEZcmax7UD4/Bv2+HbVGUjmmAuulkzw8lItgAv+Y6dsNtRF8VXP?=
 =?us-ascii?Q?T8fbxB6y+WPKxrko8tMKOoQov/hsA4S8JCyky5ecI9CY1Z/jcczAq1qXIAtZ?=
 =?us-ascii?Q?pLv+hJTGGIu9pKzamd5SoPOMqzS3mWBcjLFfVOLVtMFKrQXMF3bODqYJwrR7?=
 =?us-ascii?Q?XBwA4Od+MdLZMWcCJyJ+vSBd3rAUhG/rM8j7woV/6a3niLEexUzycT6FrTgb?=
 =?us-ascii?Q?1D6L1QP4SK9ZECfl5Qzm0cz06XCb/uTRVF8lVmyeTKFBYyn7ldxu2+IGrfHq?=
 =?us-ascii?Q?/Q26I0nQ+P0gR/yr/LGkzkPBQYreHOLsqT1RdoX6vQfrmmqMStdkX2VLx/+a?=
 =?us-ascii?Q?Es+/VSOMzSPmqP9VBuZv1tOeh66DE+zJ8Pfif4EFRJCuBwMIlaMRtxbeBi6y?=
 =?us-ascii?Q?YjuS/h/ecge3pBR/3Qkcy2t5wGHyb8IsSDsHapgdHjKaSL3oR5NJp+jNrIUI?=
 =?us-ascii?Q?+thK3uhS/tydiuuDBTP1uvjQWczhCDWIe0+OLKYRdnm5FKxSzQZXIXFmiFVE?=
 =?us-ascii?Q?g9jOyFkB2CnSJiF98McIYnVYGsVWtfn0+ogtEtyLyOw8yPkQBi4YEyliMboM?=
 =?us-ascii?Q?e22/cmgP9dlamLzKslYaNHqHjF3bIhPzzLT0qKObBAIFQrCamV7q1u7L/l0P?=
 =?us-ascii?Q?XomNcFGrkBJxOuqWPEXYEzVRQkc6vX0N5FYrI9KGuW5FcAIDFrbq2V1Kq+yD?=
 =?us-ascii?Q?aqlXmtYsg8sa0Mx9nIrXIv4thc4xvaasjqFRVZitAWwa8KREAQpgYA8aygPO?=
 =?us-ascii?Q?IR/OmD2qmp8t+DvnR2/W0kExELftJRdHE4ox9aEEZ75mnAUxvXurTPKsVtjs?=
 =?us-ascii?Q?pjlOEkdAfbD6U+QgppzTPrUn8+fMLNLMsO+w2L24QsnH4Ylp/f3+kaIZe/mE?=
 =?us-ascii?Q?4RUHt34UOyZjCxbzYZcowqR9VfxSFKZw7znUthWLSeik2AX63O5G+zWPJhBX?=
 =?us-ascii?Q?nWXxrkQRiC6TZontoFNoXMtHbfivZ/8W9f2Wj7iBGzvjdQmGcj9BdlC15tpF?=
 =?us-ascii?Q?BFB0oTEPZJOuDi5JXxtX+GwFrHcb/mahTGq3SyiEnbrQtACs279sbqan8MtW?=
 =?us-ascii?Q?C2X4UKzHVfcaxM3kqNbQuegBFw08TicaogwMyEG8BWQI2eLI1huNtxlZvOs2?=
 =?us-ascii?Q?ZnxOucd3P+AOS6lvI4BbwKCrm2L1wAsbGuNeAfQddTr4wFSfAOTzmQPe+C3Y?=
 =?us-ascii?Q?6K/dK+jCDXoNnzQqGepZDfPZHljV44R1S3nSMn25FXjLFkDZzbkeC9diJ1Hg?=
 =?us-ascii?Q?nPion43AImDTB4n2itjjMtS60S/tZafBJhpWJSX/AmciCFCLyhXowDVo/+9l?=
 =?us-ascii?Q?C1basxkX/NdttqjbesTCrTvW0UCl+1xNh6P0CWay4Mov6lAwupBAB3ojJ53M?=
 =?us-ascii?Q?qEtoFSX7Kzb7cXp5OV2l0tsVTQDB1bppVTNRPVVwCDbponeXMmkHG4vQXBf8?=
 =?us-ascii?Q?C7lcniVREmfYMP8VD3X7hhSADYvlJUaBO+vX2wz8Zn2ZCld+qCzfNsHofQLa?=
 =?us-ascii?Q?8yThJf/wljnqiYCdo2faQI0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f5c032-5a78-40cb-2003-08d9fdaa74e3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 06:44:39.9913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g5+TxXhT/pMd7h3J9TlcEIY1iVYZ6ZYAD+BCtywH5rxulJO7FYxbLBnmiFCVZnojbgPTQIp3kF+98aEVyeAyVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4414
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 02:07:22PM +0800, Su, Jinzhou (Joe) wrote:
> Make intel_pstate_tracer as a module. Other trace event can import
> this module to analyze their trace data.
> 
> Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
> Acked-by: Doug Smythies <dsmythies@telus.net>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  .../intel_pstate_tracer.py                    | 260 +++++++++---------
>  1 file changed, 129 insertions(+), 131 deletions(-)
> 
> diff --git a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> index e15e20696d17..b46e9eb8f5aa 100755
> --- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> +++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> @@ -63,7 +63,7 @@ C_USEC = 3
>  C_SEC = 2
>  C_CPU = 1
>  
> -global sample_num, last_sec_cpu, last_usec_cpu, start_time, testname
> +global sample_num, last_sec_cpu, last_usec_cpu, start_time, testname, trace_file
>  
>  # 11 digits covers uptime to 115 days
>  getcontext().prec = 11
> @@ -72,17 +72,17 @@ sample_num =0
>  last_sec_cpu = [0] * MAX_CPUS
>  last_usec_cpu = [0] * MAX_CPUS
>  
> -def print_help():
> -    print('intel_pstate_tracer.py:')
> +def print_help(driver_name):
> +    print('%s_tracer.py:'%driver_name)
>      print('  Usage:')
>      print('    If the trace file is available, then to simply parse and plot, use (sudo not required):')
> -    print('      ./intel_pstate_tracer.py [-c cpus] -t <trace_file> -n <test_name>')
> +    print('      ./%s_tracer.py [-c cpus] -t <trace_file> -n <test_name>'%driver_name)
>      print('    Or')
> -    print('      ./intel_pstate_tracer.py [--cpu cpus] ---trace_file <trace_file> --name <test_name>')
> +    print('      ./%s_tracer.py [--cpu cpus] ---trace_file <trace_file> --name <test_name>'%driver_name)
>      print('    To generate trace file, parse and plot, use (sudo required):')
> -    print('      sudo ./intel_pstate_tracer.py [-c cpus] -i <interval> -n <test_name> -m <kbytes>')
> +    print('      sudo ./%s_tracer.py [-c cpus] -i <interval> -n <test_name> -m <kbytes>'%driver_name)
>      print('    Or')
> -    print('      sudo ./intel_pstate_tracer.py [--cpu cpus] --interval <interval> --name <test_name> --memory <kbytes>')
> +    print('      sudo ./%s_tracer.py [--cpu cpus] --interval <interval> --name <test_name> --memory <kbytes>'%driver_name)
>      print('    Optional argument:')
>      print('      cpus:   comma separated list of CPUs')
>      print('      kbytes: Kilo bytes of memory per CPU to allocate to the trace buffer. Default: 10240')
> @@ -323,7 +323,7 @@ def set_4_plot_linestyles(g_plot):
>      g_plot('set style line 3 linetype 1 linecolor rgb "purple" pointtype -1')
>      g_plot('set style line 4 linetype 1 linecolor rgb "blue" pointtype -1')
>  
> -def store_csv(cpu_int, time_pre_dec, time_post_dec, core_busy, scaled, _from, _to, mperf, aperf, tsc, freq_ghz, io_boost, common_comm, load, duration_ms, sample_num, elapsed_time, tsc_ghz):
> +def store_csv(cpu_int, time_pre_dec, time_post_dec, core_busy, scaled, _from, _to, mperf, aperf, tsc, freq_ghz, io_boost, common_comm, load, duration_ms, sample_num, elapsed_time, tsc_ghz, cpu_mask):
>      """ Store master csv file information """
>  
>      global graph_data_present
> @@ -342,11 +342,9 @@ def store_csv(cpu_int, time_pre_dec, time_post_dec, core_busy, scaled, _from, _t
>  
>      graph_data_present = True;
>  
> -def split_csv():
> +def split_csv(current_max_cpu, cpu_mask):
>      """ seperate the all csv file into per CPU csv files. """
>  
> -    global current_max_cpu
> -
>      if os.path.exists('cpu.csv'):
>          for index in range(0, current_max_cpu + 1):
>              if cpu_mask[int(index)] != 0:
> @@ -381,27 +379,25 @@ def clear_trace_file():
>          print('IO error clearing trace file ')
>          sys.exit(2)
>  
> -def enable_trace():
> +def enable_trace(trace_file):
>      """ Enable trace """
>  
>      try:
> -       open('/sys/kernel/debug/tracing/events/power/pstate_sample/enable'
> -                 , 'w').write("1")
> +        open(trace_file,'w').write("1")
>      except:
>          print('IO error enabling trace ')
>          sys.exit(2)
>  
> -def disable_trace():
> +def disable_trace(trace_file):
>      """ Disable trace """
>  
>      try:
> -       open('/sys/kernel/debug/tracing/events/power/pstate_sample/enable'
> -                 , 'w').write("0")
> +       open(trace_file, 'w').write("0")
>      except:
>          print('IO error disabling trace ')
>          sys.exit(2)
>  
> -def set_trace_buffer_size():
> +def set_trace_buffer_size(memory):
>      """ Set trace buffer size """
>  
>      try:
> @@ -421,7 +417,7 @@ def free_trace_buffer():
>          print('IO error freeing trace buffer ')
>          sys.exit(2)
>  
> -def read_trace_data(filename):
> +def read_trace_data(filename, cpu_mask):
>      """ Read and parse trace data """
>  
>      global current_max_cpu
> @@ -481,135 +477,137 @@ def read_trace_data(filename):
>                  tsc_ghz = Decimal(0)
>                  if duration_ms != Decimal(0) :
>                      tsc_ghz = Decimal(tsc)/duration_ms/Decimal(1000000)
> -                store_csv(cpu_int, time_pre_dec, time_post_dec, core_busy, scaled, _from, _to, mperf, aperf, tsc, freq_ghz, io_boost, common_comm, load, duration_ms, sample_num, elapsed_time, tsc_ghz)
> +                store_csv(cpu_int, time_pre_dec, time_post_dec, core_busy, scaled, _from, _to, mperf, aperf, tsc, freq_ghz, io_boost, common_comm, load, duration_ms, sample_num, elapsed_time, tsc_ghz, cpu_mask)
>  
>              if cpu_int > current_max_cpu:
>                  current_max_cpu = cpu_int
>  # End of for each trace line loop
>  # Now seperate the main overall csv file into per CPU csv files.
> -    split_csv()
> +    split_csv(current_max_cpu, cpu_mask)
>  
>  def signal_handler(signal, frame):
>      print(' SIGINT: Forcing cleanup before exit.')
>      if interval:
> -        disable_trace()
> +        disable_trace(trace_file)
>          clear_trace_file()
>          # Free the memory
>          free_trace_buffer()
>          sys.exit(0)
>  
> -signal.signal(signal.SIGINT, signal_handler)
> +if __name__ == "__main__":
> +    trace_file = "/sys/kernel/debug/tracing/events/power/pstate_sample/enable"
> +    signal.signal(signal.SIGINT, signal_handler)
>  
> -interval = ""
> -filename = ""
> -cpu_list = ""
> -testname = ""
> -memory = "10240"
> -graph_data_present = False;
> +    interval = ""
> +    filename = ""
> +    cpu_list = ""
> +    testname = ""
> +    memory = "10240"
> +    graph_data_present = False;
>  
> -valid1 = False
> -valid2 = False
> +    valid1 = False
> +    valid2 = False
>  
> -cpu_mask = zeros((MAX_CPUS,), dtype=int)
> +    cpu_mask = zeros((MAX_CPUS,), dtype=int)
>  
> -try:
> -    opts, args = getopt.getopt(sys.argv[1:],"ht:i:c:n:m:",["help","trace_file=","interval=","cpu=","name=","memory="])
> -except getopt.GetoptError:
> -    print_help()
> -    sys.exit(2)
> -for opt, arg in opts:
> -    if opt == '-h':
> -        print()
> +    try:
> +        opts, args = getopt.getopt(sys.argv[1:],"ht:i:c:n:m:",["help","trace_file=","interval=","cpu=","name=","memory="])
> +    except getopt.GetoptError:
> +        print_help('intel_pstate')
> +        sys.exit(2)
> +    for opt, arg in opts:
> +        if opt == '-h':
> +            print_help('intel_pstate')
> +            sys.exit()
> +        elif opt in ("-t", "--trace_file"):
> +            valid1 = True
> +            location = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__)))
> +            filename = os.path.join(location, arg)
> +        elif opt in ("-i", "--interval"):
> +            valid1 = True
> +            interval = arg
> +        elif opt in ("-c", "--cpu"):
> +            cpu_list = arg
> +        elif opt in ("-n", "--name"):
> +            valid2 = True
> +            testname = arg
> +        elif opt in ("-m", "--memory"):
> +            memory = arg
> +
> +    if not (valid1 and valid2):
> +        print_help('intel_pstate')
>          sys.exit()
> -    elif opt in ("-t", "--trace_file"):
> -        valid1 = True
> -        location = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__)))
> -        filename = os.path.join(location, arg)
> -    elif opt in ("-i", "--interval"):
> -        valid1 = True
> -        interval = arg
> -    elif opt in ("-c", "--cpu"):
> -        cpu_list = arg
> -    elif opt in ("-n", "--name"):
> -        valid2 = True
> -        testname = arg
> -    elif opt in ("-m", "--memory"):
> -        memory = arg
> -
> -if not (valid1 and valid2):
> -    print_help()
> -    sys.exit()
> -
> -if cpu_list:
> -    for p in re.split("[,]", cpu_list):
> -        if int(p) < MAX_CPUS :
> -            cpu_mask[int(p)] = 1
> -else:
> -    for i in range (0, MAX_CPUS):
> -        cpu_mask[i] = 1
> -
> -if not os.path.exists('results'):
> -    os.mkdir('results')
> +
> +    if cpu_list:
> +        for p in re.split("[,]", cpu_list):
> +            if int(p) < MAX_CPUS :
> +                cpu_mask[int(p)] = 1
> +    else:
> +        for i in range (0, MAX_CPUS):
> +            cpu_mask[i] = 1
> +
> +    if not os.path.exists('results'):
> +        os.mkdir('results')
> +        # The regular user needs to own the directory, not root.
> +        fix_ownership('results')
> +
> +    os.chdir('results')
> +    if os.path.exists(testname):
> +        print('The test name directory already exists. Please provide a unique test name. Test re-run not supported, yet.')
> +        sys.exit()
> +    os.mkdir(testname)
>      # The regular user needs to own the directory, not root.
> -    fix_ownership('results')
> -
> -os.chdir('results')
> -if os.path.exists(testname):
> -    print('The test name directory already exists. Please provide a unique test name. Test re-run not supported, yet.')
> -    sys.exit()
> -os.mkdir(testname)
> -# The regular user needs to own the directory, not root.
> -fix_ownership(testname)
> -os.chdir(testname)
> -
> -# Temporary (or perhaps not)
> -cur_version = sys.version_info
> -print('python version (should be >= 2.7):')
> -print(cur_version)
> -
> -# Left as "cleanup" for potential future re-run ability.
> -cleanup_data_files()
> -
> -if interval:
> -    filename = "/sys/kernel/debug/tracing/trace"
> -    clear_trace_file()
> -    set_trace_buffer_size()
> -    enable_trace()
> -    print('Sleeping for ', interval, 'seconds')
> -    time.sleep(int(interval))
> -    disable_trace()
> -
> -current_max_cpu = 0
> -
> -read_trace_data(filename)
> -
> -if interval:
> -    clear_trace_file()
> -    # Free the memory
> -    free_trace_buffer()
> -
> -if graph_data_present == False:
> -    print('No valid data to plot')
> -    sys.exit(2)
> -
> -for cpu_no in range(0, current_max_cpu + 1):
> -    plot_perf_busy_with_sample(cpu_no)
> -    plot_perf_busy(cpu_no)
> -    plot_durations(cpu_no)
> -    plot_loads(cpu_no)
> -
> -plot_pstate_cpu_with_sample()
> -plot_pstate_cpu()
> -plot_load_cpu()
> -plot_frequency_cpu()
> -plot_duration_cpu()
> -plot_scaled_cpu()
> -plot_boost_cpu()
> -plot_ghz_cpu()
> -
> -# It is preferrable, but not necessary, that the regular user owns the files, not root.
> -for root, dirs, files in os.walk('.'):
> -    for f in files:
> -        fix_ownership(f)
> -
> -os.chdir('../../')
> +    fix_ownership(testname)
> +    os.chdir(testname)
> +
> +    # Temporary (or perhaps not)
> +    cur_version = sys.version_info
> +    print('python version (should be >= 2.7):')
> +    print(cur_version)
> +
> +    # Left as "cleanup" for potential future re-run ability.
> +    cleanup_data_files()
> +
> +    if interval:
> +        filename = "/sys/kernel/debug/tracing/trace"
> +        clear_trace_file()
> +        set_trace_buffer_size(memory)
> +        enable_trace(trace_file)
> +        print('Sleeping for ', interval, 'seconds')
> +        time.sleep(int(interval))
> +        disable_trace(trace_file)
> +
> +    current_max_cpu = 0
> +
> +    read_trace_data(filename, cpu_mask)
> +
> +    if interval:
> +        clear_trace_file()
> +        # Free the memory
> +        free_trace_buffer()
> +
> +    if graph_data_present == False:
> +        print('No valid data to plot')
> +        sys.exit(2)
> +
> +    for cpu_no in range(0, current_max_cpu + 1):
> +        plot_perf_busy_with_sample(cpu_no)
> +        plot_perf_busy(cpu_no)
> +        plot_durations(cpu_no)
> +        plot_loads(cpu_no)
> +
> +    plot_pstate_cpu_with_sample()
> +    plot_pstate_cpu()
> +    plot_load_cpu()
> +    plot_frequency_cpu()
> +    plot_duration_cpu()
> +    plot_scaled_cpu()
> +    plot_boost_cpu()
> +    plot_ghz_cpu()
> +
> +    # It is preferrable, but not necessary, that the regular user owns the files, not root.
> +    for root, dirs, files in os.walk('.'):
> +        for f in files:
> +            fix_ownership(f)
> +
> +    os.chdir('../../')
> -- 
> 2.27.0
> 
