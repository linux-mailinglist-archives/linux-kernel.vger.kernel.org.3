Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153FB58A984
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 12:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237994AbiHEKeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 06:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiHEKeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 06:34:22 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831441F62E;
        Fri,  5 Aug 2022 03:34:19 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LzhfT4Z2xz67ZDL;
        Fri,  5 Aug 2022 18:29:21 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 5 Aug 2022 12:34:17 +0200
Received: from [10.126.170.142] (10.126.170.142) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2375.24; Fri, 5 Aug 2022 11:34:15 +0100
Message-ID: <74e839ed-0733-d2db-7744-75921705ac5d@huawei.com>
Date:   Fri, 5 Aug 2022 11:34:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 04/17] perf jevent: Add an 'all' architecture argument
To:     Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        "James Clark" <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Kan Liang" <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>
CC:     Stephane Eranian <eranian@google.com>
References: <20220804221816.1802790-1-irogers@google.com>
 <20220804221816.1802790-5-irogers@google.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220804221816.1802790-5-irogers@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.170.142]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_SBL_A autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2022 23:18, Ian Rogers wrote:
> When 'all' is passed as the architecture generate a mapping table for
> all architectures. This simplifies testing. To identify the table for an
> architecture add an arch variable to the pmu_events_map.

so could this 'all' arg ever passed for perf test? I thought maybe we 
could use to verify tables for all architectures - I didn't think that 
we did it today.

Thanks,
John

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/pmu-events/empty-pmu-events.c |  2 +
>   tools/perf/pmu-events/jevents.py         | 70 +++++++++++++++---------
>   tools/perf/pmu-events/pmu-events.h       |  1 +
>   tools/perf/tests/pmu-events.c            |  3 +-
>   4 files changed, 47 insertions(+), 29 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
> index 77e655c6f116..d8cf9283e486 100644
> --- a/tools/perf/pmu-events/empty-pmu-events.c
> +++ b/tools/perf/pmu-events/empty-pmu-events.c
> @@ -110,12 +110,14 @@ static const struct pmu_event pme_test_soc_cpu[] = {
>   
>   const struct pmu_events_map pmu_events_map[] = {
>   	{
> +		.arch = "testarch",
>   		.cpuid = "testcpu",
>   		.version = "v1",
>   		.type = "core",
>   		.table = pme_test_soc_cpu,
>   	},
>   	{
> +		.arch = 0,
>   		.cpuid = 0,
>   		.version = 0,
>   		.type = 0,
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index cdfa4e0e7557..e6e6c42c3f8a 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -304,38 +304,45 @@ def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
>     print_events_table_entries(item, get_topic(item.name))
>   
>   
> -def print_mapping_table() -> None:
> +def print_mapping_table(archs: Sequence[str]) -> None:
>     """Read the mapfile and generate the struct from cpuid string to event table."""
> -  with open(f'{_args.starting_dir}/{_args.arch}/mapfile.csv') as csvfile:
> -    table = csv.reader(csvfile)
> -    _args.output_file.write(
> -        'const struct pmu_events_map pmu_events_map[] = {\n')
> -    first = True
> -    for row in table:
> -      # Skip the first row or any row beginning with #.
> -      if not first and len(row) > 0 and not row[0].startswith('#'):
> -        tblname = file_name_to_table_name([], row[2].replace('/', '_'))
> -        _args.output_file.write("""{
> -\t.cpuid = \"%s\",
> -\t.version = \"%s\",
> -\t.type = \"%s\",
> -\t.table = %s
> -},
> -""" % (row[0].replace('\\', '\\\\'), row[1], row[3], tblname))
> -      first = False
> -
> -  _args.output_file.write("""{
> +  _args.output_file.write('const struct pmu_events_map pmu_events_map[] = {\n')
> +  for arch in archs:
> +    if arch == 'test':
> +      _args.output_file.write("""{
> +\t.arch = "testarch",
>   \t.cpuid = "testcpu",
>   \t.version = "v1",
>   \t.type = "core",
>   \t.table = pme_test_soc_cpu,
>   },
> -{
> +""")
> +    else:
> +      with open(f'{_args.starting_dir}/{arch}/mapfile.csv') as csvfile:
> +        table = csv.reader(csvfile)
> +        first = True
> +        for row in table:
> +          # Skip the first row or any row beginning with #.
> +          if not first and len(row) > 0 and not row[0].startswith('#'):
> +            tblname = file_name_to_table_name([], row[2].replace('/', '_'))
> +            cpuid = row[0].replace('\\', '\\\\')
> +            _args.output_file.write(f"""{{
> +\t.arch = "{arch}",
> +\t.cpuid = "{cpuid}",
> +\t.version = "{row[1]}",
> +\t.type = "{row[3]}",
> +\t.table = {tblname}
> +}},
> +""")
> +          first = False
> +
> +  _args.output_file.write("""{
> +\t.arch = 0,
>   \t.cpuid = 0,
>   \t.version = 0,
>   \t.type = 0,
>   \t.table = 0,
> -},
> +}
>   };
>   """)
>   
> @@ -386,15 +393,24 @@ def main() -> None:
>     _args = ap.parse_args()
>   
>     _args.output_file.write("#include \"pmu-events/pmu-events.h\"\n")
> -  for path in [_args.arch, 'test']:
> -    arch_path = f'{_args.starting_dir}/{path}'
> -    if not os.path.isdir(arch_path):
> -      raise IOError(f'Missing architecture directory in \'{arch_path}\'')
> +  archs = []
> +  for item in os.scandir(_args.starting_dir):
> +    if not item.is_dir():
> +      continue
> +    if item.name == _args.arch or _args.arch == 'all' or item.name == 'test':
> +      archs.append(item.name)
> +
> +  if len(archs) < 2:
> +    raise IOError(f'Missing architecture directory \'{_args.arch}\'')
> +
> +  archs.sort()
> +  for arch in archs:
> +    arch_path = f'{_args.starting_dir}/{arch}'
>       preprocess_arch_std_files(arch_path)
>       ftw(arch_path, [], process_one_file)
>       print_events_table_suffix()
>   
> -  print_mapping_table()
> +  print_mapping_table(archs)
>     print_system_mapping_table()
>   
>   
> diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
> index 6efe73976440..7a360792635f 100644
> --- a/tools/perf/pmu-events/pmu-events.h
> +++ b/tools/perf/pmu-events/pmu-events.h
> @@ -38,6 +38,7 @@ struct pmu_event {
>    * The  cpuid can contain any character other than the comma.
>    */
>   struct pmu_events_map {
> +	const char *arch;
>   	const char *cpuid;
>   	const char *version;
>   	const char *type;		/* core, uncore etc */
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index 263cbb67c861..82192f1a7bf7 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -864,8 +864,7 @@ static void expr_failure(const char *msg,
>   			 const struct pmu_events_map *map,
>   			 const struct pmu_event *pe)
>   {
> -	pr_debug("%s for map %s %s %s\n",
> -		msg, map->cpuid, map->version, map->type);
> +	pr_debug("%s for map %s %s\n", msg, map->arch, map->cpuid);
>   	pr_debug("On metric %s\n", pe->metric_name);
>   	pr_debug("On expression %s\n", pe->metric_expr);
>   }

