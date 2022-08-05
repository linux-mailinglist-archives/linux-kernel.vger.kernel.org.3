Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A0958A9AA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 12:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237743AbiHEKtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 06:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiHEKtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 06:49:21 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0222F20F5C;
        Fri,  5 Aug 2022 03:49:19 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lzhzn0L6hz67PFb;
        Fri,  5 Aug 2022 18:44:21 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Fri, 5 Aug 2022 12:49:16 +0200
Received: from [10.126.170.142] (10.126.170.142) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2375.24; Fri, 5 Aug 2022 11:49:15 +0100
Message-ID: <ad2ad328-89f9-7dea-a6fd-b473da2f1ad0@huawei.com>
Date:   Fri, 5 Aug 2022 11:49:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 07/17] perf jevents: Sort json files entries
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
 <20220804221816.1802790-8-irogers@google.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220804221816.1802790-8-irogers@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.170.142]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2022 23:18, Ian Rogers wrote:
> Sort the json files entries on conversion to C. The sort order tries to
> replicated cmp_sevent from pmu.c so that the input there is already

replicate

> sorted except for sysfs events.
> 
> Add the topic to JsonEvent on reading to simplify. Remove an unnecessary
> lambda in the json reading.

We sort the attributes of the events alphabetically by attribute name, 
right? Is there any advantage in this? Do we need it for later?

thanks,
John

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/pmu-events/jevents.py | 48 +++++++++++++++++++++++---------
>   1 file changed, 35 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index 12d2daf3570c..30e0e792221a 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -18,6 +18,8 @@ _sys_event_tables = []
>   _arch_std_events = {}
>   # Track whether an events table is currently being defined and needs closing.
>   _close_table = False
> +# Events to write out when the table is closed
> +_pending_events = []
>   
>   
>   def removesuffix(s: str, suffix: str) -> str:
> @@ -127,6 +129,7 @@ class JsonEvent:
>         eventcode |= int(jd['ExtSel']) << 8
>       configcode = int(jd['ConfigCode'], 0) if 'ConfigCode' in jd else None
>       self.name = jd['EventName'].lower() if 'EventName' in jd else None
> +    self.topic = ''
>       self.compat = jd.get('Compat')
>       self.desc = fixdesc(jd.get('BriefDescription'))
>       self.long_desc = fixdesc(jd.get('PublicDescription'))
> @@ -199,7 +202,7 @@ class JsonEvent:
>           s += f'\t{attr} = {value},\n'
>       return s + '}'
>   
> -  def to_c_string(self, topic_local: str) -> str:
> +  def to_c_string(self) -> str:
>       """Representation of the event as a C struct initializer."""
>   
>       def attr_string(attr: str, value: str) -> str:
> @@ -211,25 +214,27 @@ class JsonEvent:
>         return attr_string(attr, getattr(self, attr))
>   
>       s = '{\n'
> -    s += f'\t.topic = "{topic_local}",\n'
>       for attr in [
>           'aggr_mode', 'compat', 'deprecated', 'desc', 'event', 'long_desc',
>           'metric_constraint', 'metric_expr', 'metric_group', 'metric_name',
> -        'name', 'perpkg', 'pmu', 'unit'
> +        'name', 'perpkg', 'pmu', 'topic', 'unit'
>       ]:
>         s += str_if_present(self, attr)
>       s += '},\n'
>       return s
>   
>   
> -def read_json_events(path: str) -> Sequence[JsonEvent]:
> +def read_json_events(path: str, topic: str) -> Sequence[JsonEvent]:
>     """Read json events from the specified file."""
>   
>     try:
> -    return json.load(open(path), object_hook=lambda d: JsonEvent(d))
> +    result = json.load(open(path), object_hook=JsonEvent)
>     except BaseException as err:
>       print(f"Exception processing {path}")
>       raise
> +  for event in result:
> +    event.topic = topic
> +  return result
>   
>   
>   def preprocess_arch_std_files(archpath: str) -> None:
> @@ -237,7 +242,7 @@ def preprocess_arch_std_files(archpath: str) -> None:
>     global _arch_std_events
>     for item in os.scandir(archpath):
>       if item.is_file() and item.name.endswith('.json'):
> -      for event in read_json_events(item.path):
> +      for event in read_json_events(item.path, topic=''):
>           if event.name:
>             _arch_std_events[event.name.lower()] = event
>   
> @@ -251,19 +256,36 @@ def print_events_table_prefix(tblname: str) -> None:
>     _close_table = True
>   
>   
> -def print_events_table_entries(item: os.DirEntry, topic: str) -> None:
> -  """Create contents of an events table."""
> +def add_events_table_entries(item: os.DirEntry, topic: str) -> None:
> +  """Add contents of file to _pending_events table."""
>     if not _close_table:
>       raise IOError('Table entries missing prefix')
> -  for event in read_json_events(item.path):
> -    _args.output_file.write(event.to_c_string(topic))
> +  for e in read_json_events(item.path, topic):
> +    _pending_events.append(e)
>   
>   
>   def print_events_table_suffix() -> None:
>     """Optionally close events table."""
> +
> +  def event_cmp_key(j: JsonEvent):
> +    def fix_none(s: str):
> +      if s is None:
> +        return ''
> +      return s
> +
> +    return (not j.desc is None, fix_none(j.topic), fix_none(j.name), fix_none(j.pmu),
> +            fix_none(j.metric_name))
> +
>     global _close_table
> -  if _close_table:
> -    _args.output_file.write("""{
> +  if not _close_table:
> +    return
> +
> +  global _pending_events
> +  for event in sorted(_pending_events, key=event_cmp_key):
> +    _args.output_file.write(event.to_c_string())
> +    _pending_events = []
> +
> +  _args.output_file.write("""{
>   \t.name = 0,
>   \t.event = 0,
>   \t.desc = 0,
> @@ -306,7 +328,7 @@ def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
>     if not item.is_file() or not item.name.endswith('.json'):
>       return
>   
> -  print_events_table_entries(item, get_topic(item.name))
> +  add_events_table_entries(item, get_topic(item.name))
>   
>   
>   def print_mapping_table(archs: Sequence[str]) -> None:

