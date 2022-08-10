Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C6058EE70
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 16:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiHJOfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 10:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiHJOfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 10:35:30 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C91922BC8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 07:35:28 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id v5so7916363wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 07:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Ed56vkDi/zv5qaB9aD5u6z7vh8CobJ4CIVyP7SjogOA=;
        b=cl4O4zNlI8o2hN1iAjgolY/+xKu4KhMrG31mHyDpq5ocsyRt2KiYaH4lTnh6AhYErb
         ybTsYxm8tQgG+8e9Sk7tqMdCpizS2/S1xErsJaaMrrvlXa2ccYb3Ot8RaPjyuGIg9m/0
         4ROf7V5bGAjlfNU1b3BG8BLo+3hn8KfCx8BjU89vMrnt3Lujvel+knb++MAA6T5s2a5L
         kOXOThV1kHRRUmedyQ/kxKw61+C+E4hIxmc79pfAD1XoHsjcz+5HFEy7y0vLQseOsCDA
         C3Ey1/XEcAmsQ8Gfje+ia9jojQPqVqxBGK9ykf+Y9zntqc66ifPn4mV7LB16X3uJDdm8
         Ywmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Ed56vkDi/zv5qaB9aD5u6z7vh8CobJ4CIVyP7SjogOA=;
        b=M5/wVMRmezsvxCGN6k+JyznvWm/Obr4gvS+8nhaWDmvYShRXq7MmuTuNn9hbgje6na
         Fdhydg5jhZezHE81+Z/rRAHJx3UfVK8AjuxJ8aaaVaPAZs20JjydJ4Lvyy2PuMT5jnE9
         cgdqHWgXSIfnLoA9NJlVZBFXR84HYX25vyYg5IzQMcPCw9vpJ7wCakbkcHJA4TyEldCR
         8cHOL6YLwZXCTbfBbs8tadOfriz9oZw/dHkdAnBRFff/roZluAm4p4WtGqu+xLqfuQjy
         oXKGA2lLtRez1+gAJVRFXWy/+nrgdmvTa934VcX5QMwKd02ueHUcrSV75LqJ5hK6Q50+
         yJsg==
X-Gm-Message-State: ACgBeo3zeThumTbztZF8BPH06zasc1HM78Vzm4d4SYgxtlMRB0i8kidM
        5wyn37tlLyVYT5U0xqbWhbeJv1gS+P8MK5DC36cvrA==
X-Google-Smtp-Source: AA6agR4gcFHtIy3illRgki17dURdpQ5Zh+DycYrPqBY9v1nnVRKtn5Ex8UVpVnp+AbX+1jdVzLD2XCkNdgK0xL5q7o4=
X-Received: by 2002:a05:600c:25ce:b0:3a5:a3b7:bbfe with SMTP id
 14-20020a05600c25ce00b003a5a3b7bbfemr2807827wml.115.1660142126602; Wed, 10
 Aug 2022 07:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220804221816.1802790-1-irogers@google.com> <20220804221816.1802790-17-irogers@google.com>
 <955d5788-5eff-ccec-d089-d4331b025a81@huawei.com>
In-Reply-To: <955d5788-5eff-ccec-d089-d4331b025a81@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 10 Aug 2022 07:35:13 -0700
Message-ID: <CAP-5=fXtOLX2TMz2+pWgSCTKPoWJum1vbQztRC9NAUjeOrxyCQ@mail.gmail.com>
Subject: Re: [PATCH v4 16/17] perf jevents: Compress the pmu_events_table
To:     John Garry <john.garry@huawei.com>
Cc:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 5, 2022 at 7:02 AM John Garry <john.garry@huawei.com> wrote:
>
> On 04/08/2022 23:18, Ian Rogers wrote:
> > The pmu_events array requires 15 pointers per entry which in position
> > independent code need relocating. Change the array to be an array of
> > offsets within a big C string. Only the offset of the first variable is
> > required, subsequent variables are stored in order after the \0
> > terminator (requiring a byte per variable rather than 4 bytes per
> > offset).
> >
> > The file size savings are:
> > no jevents - the same 19,788,464bytes
> > x86 jevents - ~16.7% file size saving 23,744,288bytes vs 28,502,632bytes
> > all jevents - ~19.5% file size saving 24,469,056bytes vs 30,379,920bytes
> > default build options plus NO_LIBBFD=1.
> >
> > For example, the x86 build savings come from .rela.dyn and
> > .data.rel.ro becoming smaller by 3,157,032bytes and 3,042,016bytes
> > respectively. .rodata increases by 1,432,448bytes, giving an overall
> > 4,766,600bytes saving.
> >
> > To make metric strings more shareable, the topic is changed from say
> > 'skx metrics' to just 'metrics'.
> >
> > To try to help with the memory layout the pmu_events are ordered as used
> > by perf qsort comparator functions.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   tools/perf/pmu-events/jevents.py | 207 ++++++++++++++++++++++++-------
> >   1 file changed, 162 insertions(+), 45 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> > index aa8df649025a..a5e162558994 100755
> > --- a/tools/perf/pmu-events/jevents.py
> > +++ b/tools/perf/pmu-events/jevents.py
> > @@ -6,7 +6,8 @@ import csv
> >   import json
> >   import os
> >   import sys
> > -from typing import (Callable, Optional, Sequence)
> > +from typing import (Callable, Dict, Optional, Sequence, Set, Tuple)
> > +import collections
> >
> >   # Global command line arguments.
> >   _args = None
> > @@ -20,6 +21,19 @@ _arch_std_events = {}
> >   _close_table = False
> >   # Events to write out when the table is closed
> >   _pending_events = []
> > +# Global BigCString shared by all structures.
> > +_bcs = None
> > +# Order specific JsonEvent attributes will be visited.
> > +_json_event_attributes = [
> > +    # cmp_sevent related attributes.
> > +    'name', 'pmu', 'topic', 'desc', 'metric_name', 'metric_group',
> > +    # Seems useful, put it early.
> > +    'event',
> > +    # Short things in alphabetical order.
> > +    'aggr_mode', 'compat', 'deprecated', 'perpkg', 'unit',
> > +    # Longer things (the last won't be iterated over during decompress).
> > +    'metric_constraint', 'metric_expr', 'long_desc'
> > +]
> >
> >
> >   def removesuffix(s: str, suffix: str) -> str:
> > @@ -39,6 +53,66 @@ def file_name_to_table_name(parents: Sequence[str], dirname: str) -> str:
> >     tblname += '_' + dirname
> >     return tblname.replace('-', '_')
> >
> > +def c_len(s: str) -> int:
> > +  """Return the length of s a C string
> > +
> > +  This doesn't handle all escape characters properly. It first assumes
> > +  all \ are for escaping, it then adjusts as it will have over counted
> > +  \\. The code uses \000 rather than \0 as a terminator as an adjacent
> > +  number would be folded into a string of \0 (ie. "\0" + "5" doesn't
> > +  equal a terminator followed by the number 5 but the escape of
> > +  \05). The code adjusts for \000 but not properly for all octal, hex
> > +  or unicode values.
> > +  """
> > +  try:
> > +    utf = s.encode(encoding='utf-8',errors='strict')
> > +  except:
> > +    print(f'broken string {s}')
> > +    raise
> > +  return len(utf) - utf.count(b'\\') + utf.count(b'\\\\') - (utf.count(b'\\000') * 2)
> > +
> > +class BigCString:
> > +  """A class to hold many strings concatenated together.
> > +
> > +  Generating a large number of stand-alone C strings creates a large
> > +  number of relocations in position independent code. The BigCString
> > +  is a helper for this case. It builds a single string which within it
> > +  are all the other C strings (to avoid memory issues the string
> > +  itself is held as a list of strings). The offsets within the big
> > +  string are recorded and when stored to disk these don't need
> > +  relocation.
> > +  """
> > +  strings: Set[str]
> > +  big_string: Sequence[str]
> > +  offsets: Dict[str, int]
> > +
> > +  def __init__(self):
> > +    self.strings = set()
> > +
> > +  def add(self, s: str) -> None:
> > +    """Called to add to the big string."""
> > +    self.strings.add(s)
> > +
> > +  def compute(self) -> None:
> > +    """Called once all strings are added to compute the string and offsets."""
> > +
> > +    # big_string_offset is the current location within the C string
> > +    # being appended to - comments, etc. don't count. big_string is
> > +    # the string contents represented as a list. Strings are immutable
> > +    # in Python and so appending to one causes memory issues, while
> > +    # lists are mutable.
> > +    big_string_offset = 0
> > +    self.big_string = []
> > +    self.offsets = {}
> > +    # Emit all strings in a sorted manner.
> > +    for s in sorted(self.strings):
> > +      self.offsets[s] = big_string_offset
> > +      self.big_string.append(f'/* offset={big_string_offset} */ "')
> > +      self.big_string.append(s)
> > +      self.big_string.append('"\n')
> > +      big_string_offset += c_len(s)
> > +
> > +_bcs = BigCString()
> >
> >   class JsonEvent:
> >     """Representation of an event loaded from a json file dictionary."""
> > @@ -202,26 +276,18 @@ class JsonEvent:
> >           s += f'\t{attr} = {value},\n'
> >       return s + '}'
> >
> > +  def build_c_string(self) -> str:
> > +    s = ''
> > +    for attr in _json_event_attributes:
> > +      x = getattr(self, attr)
> > +      s += f'{x}\\000' if x else '\\000'
> > +    return s
> > +
> >     def to_c_string(self) -> str:
> >       """Representation of the event as a C struct initializer."""
> >
> > -    def attr_string(attr: str, value: str) -> str:
> > -      return f'\t.{attr} = \"{value}\",\n'
> > -
> > -    def str_if_present(self, attr: str) -> str:
> > -      if not getattr(self, attr):
> > -        return ''
> > -      return attr_string(attr, getattr(self, attr))
> > -
> > -    s = '{\n'
> > -    for attr in [
> > -        'aggr_mode', 'compat', 'deprecated', 'desc', 'event', 'long_desc',
> > -        'metric_constraint', 'metric_expr', 'metric_group', 'metric_name',
> > -        'name', 'perpkg', 'pmu', 'topic', 'unit'
> > -    ]:
> > -      s += str_if_present(self, attr)
> > -    s += '},\n'
> > -    return s
> > +    s = self.build_c_string()
> > +    return f'{{ { _bcs.offsets[s] } }}, /* {s} */\n'
> >
> >
> >   def read_json_events(path: str, topic: str) -> Sequence[JsonEvent]:
> > @@ -236,7 +302,6 @@ def read_json_events(path: str, topic: str) -> Sequence[JsonEvent]:
> >       event.topic = topic
> >     return result
> >
> > -
> >   def preprocess_arch_std_files(archpath: str) -> None:
> >     """Read in all architecture standard events."""
> >     global _arch_std_events
> > @@ -252,7 +317,7 @@ def print_events_table_prefix(tblname: str) -> None:
> >     global _close_table
> >     if _close_table:
> >       raise IOError('Printing table prefix but last table has no suffix')
> > -  _args.output_file.write(f'static const struct pmu_event {tblname}[] = {{\n')
> > +  _args.output_file.write(f'static const struct compact_pmu_event {tblname}[] = {{\n')
> >     _close_table = True
> >
> >
> > @@ -267,13 +332,13 @@ def add_events_table_entries(item: os.DirEntry, topic: str) -> None:
> >   def print_events_table_suffix() -> None:
> >     """Optionally close events table."""
> >
> > -  def event_cmp_key(j: JsonEvent):
> > -    def fix_none(s: str):
> > +  def event_cmp_key(j: JsonEvent) -> Tuple[bool, str, str, str, str]:
> > +    def fix_none(s: Optional[str]) -> str:
> >         if s is None:
> >           return ''
> >         return s
> >
> > -    return (not j.desc is None, fix_none(j.topic), fix_none(j.name), fix_none(j.pmu),
> > +    return (j.desc is not None, fix_none(j.topic), fix_none(j.name), fix_none(j.pmu),
> >               fix_none(j.metric_name))
> >
> >     global _close_table
> > @@ -285,23 +350,37 @@ def print_events_table_suffix() -> None:
> >       _args.output_file.write(event.to_c_string())
> >       _pending_events = []
> >
> > -  _args.output_file.write("""{
> > -\t.name = 0,
> > -\t.event = 0,
> > -\t.desc = 0,
> > -},
> > -};
> > -""")
> > +  _args.output_file.write('};\n\n')
> >     _close_table = False
> >
> > +def get_topic(topic: str) -> str:
> > +  if topic.endswith('metrics.json'):
> > +    return 'metrics'
> > +  return removesuffix(topic, '.json').replace('-', ' ')
> > +
> > +def preprocess_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
> > +
> > +  if item.is_dir():
> > +    return
> > +
> > +  # base dir or too deep
> > +  level = len(parents)
> > +  if level == 0 or level > 4:
> > +    return
> > +
> > +  # Ignore other directories. If the file name does not have a .json
> > +  # extension, ignore it. It could be a readme.txt for instance.
> > +  if not item.is_file() or not item.name.endswith('.json'):
> > +    return
> > +
> > +  topic = get_topic(item.name)
> > +  for event in read_json_events(item.path, topic):
> > +    _bcs.add(event.build_c_string())
> >
> >   def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
> >     """Process a JSON file during the main walk."""
> >     global _sys_event_tables
> >
> > -  def get_topic(topic: str) -> str:
> > -    return removesuffix(topic, '.json').replace('-', ' ')
> > -
> >     def is_leaf_dir(path: str) -> bool:
> >       for item in os.scandir(path):
> >         if item.is_dir():
> > @@ -336,7 +415,8 @@ def print_mapping_table(archs: Sequence[str]) -> None:
> >     _args.output_file.write("""
> >   /* Struct used to make the PMU event table implementation opaque to callers. */
> >   struct pmu_events_table {
> > -        const struct pmu_event *entries;
> > +        const struct compact_pmu_event *entries;
> > +        size_t length;
> >   };
> >
> >   /*
> > @@ -364,7 +444,10 @@ const struct pmu_events_map pmu_events_map[] = {
> >         _args.output_file.write("""{
> >   \t.arch = "testarch",
> >   \t.cpuid = "testcpu",
> > -\t.table = { pme_test_soc_cpu },
> > +\t.table = {
> > +\t.entries = pme_test_soc_cpu,
> > +\t.length = ARRAY_SIZE(pme_test_soc_cpu),
> > +\t}
> >   },
> >   """)
> >       else:
> > @@ -379,7 +462,10 @@ const struct pmu_events_map pmu_events_map[] = {
> >               _args.output_file.write(f"""{{
> >   \t.arch = "{arch}",
> >   \t.cpuid = "{cpuid}",
> > -\t.table = {{ {tblname} }}
> > +\t.table = {{
> > +\t\t.entries = {tblname},
> > +\t\t.length = ARRAY_SIZE({tblname})
> > +\t}}
> >   }},
> >   """)
> >             first = False
> > @@ -387,7 +473,7 @@ const struct pmu_events_map pmu_events_map[] = {
> >     _args.output_file.write("""{
> >   \t.arch = 0,
> >   \t.cpuid = 0,
> > -\t.table = { 0 },
> > +\t.table = { 0, 0 },
> >   }
> >   };
> >   """)
> > @@ -405,23 +491,41 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
> >   """)
> >     for tblname in _sys_event_tables:
> >       _args.output_file.write(f"""\t{{
> > -\t\t.table = {{ {tblname} }},
> > +\t\t.table = {{
> > +\t\t\t.entries = {tblname},
> > +\t\t\t.length = ARRAY_SIZE({tblname})
> > +\t\t}},
> >   \t\t.name = \"{tblname}\",
> >   \t}},
> >   """)
> >     _args.output_file.write("""\t{
> > -\t\t.table = { 0 }
> > +\t\t.table = { 0, 0 }
> >   \t},
> >   };
> >
> > -int pmu_events_table_for_each_event(const struct pmu_events_table *table, pmu_event_iter_fn fn,
> > +static void decompress(int offset, struct pmu_event *pe)
> > +{
> > +\tconst char *p = &big_c_string[offset];
> > +""")
> > +  for attr in _json_event_attributes:
> > +    _args.output_file.write(f"""
> > +\tpe->{attr} = (*p == '\\0' ? NULL : p);
> > +""")
> > +    if attr == _json_event_attributes[-1]:
> > +      continue
> > +    _args.output_file.write('\twhile (*p++);')
> > +  _args.output_file.write("""}
>
>
> I get this in generated pmu-events.c:
>
> static void decompress(int offset, struct pmu_event *pe)
> {
> const char *p = &big_c_string[offset];
>
> pe->name = (*p == '\0' ? NULL : p);
> while (*p++);
> pe->pmu = (*p == '\0' ? NULL : p);
> while (*p++);
> pe->topic = (*p == '\0' ? NULL : p);
> while (*p++);
> pe->desc = (*p == '\0' ? NULL : p);
> while (*p++);
> pe->metric_name = (*p == '\0' ? NULL : p);
> while (*p++);
> pe->metric_group = (*p == '\0' ? NULL : p);
> while (*p++);
> pe->event = (*p == '\0' ? NULL : p);
> while (*p++);
> pe->aggr_mode = (*p == '\0' ? NULL : p);
> while (*p++);
> pe->compat = (*p == '\0' ? NULL : p);
> while (*p++);
> pe->deprecated = (*p == '\0' ? NULL : p);
> while (*p++);
> pe->perpkg = (*p == '\0' ? NULL : p);
> while (*p++);
> pe->unit = (*p == '\0' ? NULL : p);
> while (*p++);
> pe->metric_constraint = (*p == '\0' ? NULL : p);
> while (*p++);
> pe->metric_expr = (*p == '\0' ? NULL : p);
> while (*p++);
> pe->long_desc = (*p == '\0' ? NULL : p);
> }
>
> int pmu_events_table_for_each_event(const struct pmu_events_table *table,
>                                      pmu_event_iter_fn fn,
>                                      void *data)
> {
>          for (size_t i = 0; i < table->length; i++) {
>                  struct pmu_event pe;
>                  int ret;
>
>                  decompress(table->entries[i].offset, &pe);
>                  ret = fn(&pe, table, data);
>                  if (ret)
>                          return ret;
>          }
>          return 0;
> }
>
> --->8---
>
> This seems a bit inefficient in terms of performance - if that really is
> a requirement, but I figure that it isn't really.

I think the main inefficiency is coming from the struct pmu_event
containing so many variables. I think we can modify that later, say by
separating metrics from events, I did look at performance and the
decompress function is hot but overall the performance was similar to
before the change for some hand crafted examples.

> Another observation is that although we compress and reduce size in this
> method, we are now losing out on some sharing of strings. For example,
> this is an extract from big_string:
>
> /* offset=3342573 */
> "unc_p_core0_transition_cycles\000uncore_pcu\000uncore power\000Core 0 C
> State Transition Cycles. Unit: uncore_pcu
> \000\000\000event=0x70\000\000\000\0001\000\000\000\000Number of cycles
> spent performing core C state transitions.  There is one event per core\000"
> /* offset=3342789 */
> "unc_p_core0_transition_cycles\000uncore_pcu\000uncore power\000Core C
> State Transition Cycles. Unit: uncore_pcu
> \000\000\000event=0x103\000\000\000\0001\000\000\000\000Number of cycles
> spent performing core C state transitions.  There is one event per core\000"
>
> These super-strings are not identical, but many sub-strings are, like
> "Number of cycles spent performing core C state transitions.  There is
> one event per core", so we are losing out there on sharing strings there.

Agreed. I found that the savings by having a single offset were in
O(100kbs) and so had to give up string sharing for this.

Thanks,
Ian

> Thanks,
> John
> > +
> > +int pmu_events_table_for_each_event(const struct pmu_events_table *table,
> > +                                    pmu_event_iter_fn fn,
> >                                       void *data)
> >   {
> > -        for (const struct pmu_event *pe = &table->entries[0];
> > -             pe->name || pe->metric_group || pe->metric_name;
> > -             pe++) {
> > -                int ret = fn(pe, table, data);
> > +        for (size_t i = 0; i < table->length; i++) {
> > +                struct pmu_event pe;
> > +                int ret;
> >
> > +                decompress(table->entries[i].offset, &pe);
> > +                ret = fn(&pe, table, data);
> >                   if (ret)
> >                           return ret;
> >           }
> > @@ -530,7 +634,7 @@ def main() -> None:
> >         help='Root of tree containing architecture directories containing json files'
> >     )
> >     ap.add_argument(
> > -      'output_file', type=argparse.FileType('w'), nargs='?', default=sys.stdout)
> > +      'output_file', type=argparse.FileType('w', encoding='utf-8'), nargs='?', default=sys.stdout)
> >     _args = ap.parse_args()
> >
> >     _args.output_file.write("""
> > @@ -540,6 +644,10 @@ def main() -> None:
> >   #include <string.h>
> >   #include <stddef.h>
> >
> > +struct compact_pmu_event {
> > +  int offset;
> > +};
> > +
> >   """)
> >     archs = []
> >     for item in os.scandir(_args.starting_dir):
> > @@ -555,6 +663,15 @@ def main() -> None:
> >     for arch in archs:
> >       arch_path = f'{_args.starting_dir}/{arch}'
> >       preprocess_arch_std_files(arch_path)
> > +    ftw(arch_path, [], preprocess_one_file)
> > +
> > +  _bcs.compute()
> > +  _args.output_file.write('static const char *const big_c_string =\n')
> > +  for s in _bcs.big_string:
> > +    _args.output_file.write(s)
> > +  _args.output_file.write(';\n\n')
> > +  for arch in archs:
> > +    arch_path = f'{_args.starting_dir}/{arch}'
> >       ftw(arch_path, [], process_one_file)
> >       print_events_table_suffix()
> >
>
