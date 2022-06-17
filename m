Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788A154EEC9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 03:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379534AbiFQB1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 21:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbiFQB1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 21:27:13 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BD86350A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 18:27:10 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l126-20020a1c2584000000b0039c1a10507fso1666754wml.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 18:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=be++Yt+v8h2Npkf01xH3B96LQ8NGyWx1Ci4l08m8JNc=;
        b=dgenCcbrkx8HBxuTZ/ZWT0c6OMRxrzI3rnChG+gkqBu22iUTGk7fc7rAXV6reWDLP2
         4jnzGNbG0vuisZXzQSdoLJkyLclJt7c6jK/dS3ez0oCc1xSBwifNO3RG2iDzX7CJjF5o
         ojwJqEDm1zRfdI98IYLF/Qmy4bpBCAkGnDjGQpIrhyioCqMhulVDbSJJOubGmidNmdgP
         aySLZfgU8ZhNDbuoM3esCm5F4MLq2nsmJTNuPiazqh2bQiEjV1hcfJEgghkHCgmE24T7
         aLYeYvhuz0/a83m6vbEoRYgha4L1FFq34lUhrBMnmL6j/V/JhjjeaAR7Foas+NzBmcvg
         6aEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=be++Yt+v8h2Npkf01xH3B96LQ8NGyWx1Ci4l08m8JNc=;
        b=GXSZMXAqnkMhWrAL0jYlv00+cCMFiKyX8GKKx4a4iwpXE6Ib1RVV/10+5lZiVaH2f0
         DfY3x4dWFikpc4T7p+1QPn6bdMCQSIaTEPWimC6pkmm3cjqBrKVpLZsSRWpscYnrrGwd
         RJv0j2jidKtQ4oqXz1LJGC5FJAido//XU+pxms94gjNX5dRn4c5IeMMhqRQ8N2EQyWrr
         Y7qq13Jfycs7htYoJ07rwkq5oa57NYzy7vi3lhz7HhU9Jyvh6xTyXm9R0QhrHihWPBOb
         oiRwwKUyJ7ado8zs4jtkDdbriQxJ7Aq7Tlpo9icJSn3igPEReV5rAzXTjyjHSXk3+hJb
         zpxg==
X-Gm-Message-State: AOAM533G8uV2vmBoP08JgiWnldwpaMdELWKO8AI8KzF9mgL9huhpKD8/
        FOybQ4YIqxt9a3VtrDt/h2wfGZPPvo/0FWFM6lRGYA==
X-Google-Smtp-Source: ABdhPJzVNPQkKhAxNUS++opuHKsOJ/oC8y52uaSl3K/ZHUjBX9bajHGn35hWK1So7th14Lcsm/ho+7XMBTUpnkBwoIc=
X-Received: by 2002:a05:600c:19cb:b0:397:51db:446f with SMTP id
 u11-20020a05600c19cb00b0039751db446fmr18311922wmq.182.1655429229038; Thu, 16
 Jun 2022 18:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220616044806.47770-1-irogers@google.com> <20220616044806.47770-3-irogers@google.com>
 <7eb148e5-0763-1dbe-d1f5-80e5159be7c8@linux.intel.com>
In-Reply-To: <7eb148e5-0763-1dbe-d1f5-80e5159be7c8@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 16 Jun 2022 18:26:56 -0700
Message-ID: <CAP-5=fUy=_HFhhdghRJs-+G75ppsYCRg72SSnoeijvdqb8hyVQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] perf jevents: Add python converter script
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Felix Fietkau <nbd@nbd.name>,
        Qi Liu <liuqi115@huawei.com>, Like Xu <likexu@tencent.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com, sandipan.das@amd.com,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>,
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

On Thu, Jun 16, 2022 at 5:04 PM Xing Zhengjun
<zhengjun.xing@linux.intel.com> wrote:
>
> Hi Ian,
>
>    I applied this patch series based on the head of the perf/core
> branch, but it failed when do make.
>    My python version:
>    Python 2.7.18 (default, Mar  8 2021, 13:02:45)
>    [GCC 9.3.0] on linux2
>
>
>    GEN     pmu-events/pmu-events.c
> make[3]: Nothing to be done for 'install_headers'.
>    GEN     python/perf.so
> Traceback (most recent call last):
>    File "pmu-events/jevents.py", line 23, in <module>
>      def file_name_to_table_name(parents: list[str], dirname: str) -> str:
> TypeError: 'type' object is not subscriptable
> make[3]: *** [pmu-events/Build:20: pmu-events/pmu-events.c] Error 1
> make[2]: *** [Makefile.perf:663: pmu-events/pmu-events-in.o] Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [Makefile.perf:240: sub-make] Error 2
> make: *** [Makefile:70: all] Error 2

Hi Zhengjun,

Thanks for testing! You are running the test script and not the main
build. Unlike the main build I didn't add a Python version test for
the test script. As mentioned in the cover letter you need Python 3.6
as Python 2 was sunset in 2020.

Thanks,
Ian


> On 6/16/2022 12:48 PM, Ian Rogers wrote:
> > jevents.c is large, has a dependency on an old forked version of jsmn,
> > and is challenging to work upon. A lot of jevents.c's complexity comes
> > from needing to write json and csv parsing from first principles. In
> > contrast python has this functionality in standard libraries and is
> > already a build pre-requisite for tools like asciidoc (that builds all
> > of the perf man pages).
> >
> > Introduce jevents.py that produces identical output to jevents.c. Add a
> > test that runs both converter tools and validates there are no output
> > differences. The test can be invoked with a phony build target like:
> >
> > make -C tools/perf jevents-py-test
> >
> > The python code deliberately tries to replicate the behavior of
> > jevents.c so that the output matches and transitioning tools shouldn't
> > introduce regressions. In some cases the code isn't as elegant as hoped,
> > but fixing this can be done as follow up.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   tools/perf/Makefile.perf              |   6 +
> >   tools/perf/pmu-events/jevents-test.sh |  33 +++
> >   tools/perf/pmu-events/jevents.py      | 394 ++++++++++++++++++++++++++
> >   3 files changed, 433 insertions(+)
> >   create mode 100755 tools/perf/pmu-events/jevents-test.sh
> >   create mode 100755 tools/perf/pmu-events/jevents.py
> >
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index 8f738e11356d..1e29c8936f71 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -669,6 +669,12 @@ $(JEVENTS_IN): FORCE
> >   $(JEVENTS): $(JEVENTS_IN)
> >       $(QUIET_LINK)$(HOSTCC) $(JEVENTS_IN) -o $@
> >
> > +JEVENTS_PY   :=  pmu-events/jevents.py
> > +JEVENTS_PY_TEST      :=  pmu-events/jevents-test.sh
> > +.PHONY: jevents-py-test
> > +jevents-py-test: $(JEVENTS)
> > +     $(Q)$(call echo-cmd,gen)$(JEVENTS_PY_TEST) $(JEVENTS) $(JEVENTS_PY) pmu-events/arch
> > +
> >   $(PMU_EVENTS_IN): $(JEVENTS) FORCE
> >       $(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=pmu-events obj=pmu-events
> >
> > diff --git a/tools/perf/pmu-events/jevents-test.sh b/tools/perf/pmu-events/jevents-test.sh
> > new file mode 100755
> > index 000000000000..9ae852292576
> > --- /dev/null
> > +++ b/tools/perf/pmu-events/jevents-test.sh
> > @@ -0,0 +1,33 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> > +# Validate that the legacy jevents and jevents.py produce identical output.
> > +set -e
> > +
> > +JEVENTS="$1"
> > +JEVENTS_PY="$2"
> > +ARCH_PATH="$3"
> > +JEVENTS_C_GENERATED=$(mktemp /tmp/jevents_c.XXXXX.c)
> > +JEVENTS_PY_GENERATED=$(mktemp /tmp/jevents_py.XXXXX.c)
> > +
> > +cleanup() {
> > +  rm "$JEVENTS_C_GENERATED" "$JEVENTS_PY_GENERATED"
> > +  trap - exit term int
> > +}
> > +trap cleanup exit term int
> > +
> > +for path in "$ARCH_PATH"/*
> > +do
> > +  arch=$(basename $path)
> > +  if [ "$arch" = "test" ]
> > +  then
> > +    continue
> > +  fi
> > +  echo "Checking architecture: $arch"
> > +  echo "Generating using jevents.c"
> > +  "$JEVENTS" "$arch" "$ARCH_PATH" "$JEVENTS_C_GENERATED"
> > +  echo "Generating using jevents.py"
> > +  "$JEVENTS_PY" "$arch" "$ARCH_PATH" "$JEVENTS_PY_GENERATED"
> > +  echo "Diffing"
> > +  diff -u "$JEVENTS_C_GENERATED" "$JEVENTS_PY_GENERATED"
> > +done
> > +cleanup
> > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> > new file mode 100755
> > index 000000000000..658eb2696f9a
> > --- /dev/null
> > +++ b/tools/perf/pmu-events/jevents.py
> > @@ -0,0 +1,394 @@
> > +#!/usr/bin/env python3
> > +# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> > +"""Convert directories of JSON events to C code."""
> > +import argparse
> > +import csv
> > +import json
> > +import os
> > +import sys
> > +from typing import Callable
> > +
> > +# Global command line arguments.
> > +args = None
> > +# List of event tables generated from "/sys" directories.
> > +sys_event_tables = []
> > +# Map from an event name to an architecture standard
> > +# JsonEvent. Architecture standard events are in json files in the top
> > +# f'{args.starting_dir}/{args.arch}' directory.
> > +arch_std_events = dict()
> > +# Track whether an events table is currently being defined and needs closing.
> > +close_table = False
> > +
> > +
> > +def file_name_to_table_name(parents: list[str], dirname: str) -> str:
> > +  """Generate a C table name from directory names."""
> > +  tblname = 'pme'
> > +  for p in parents:
> > +    tblname += '_' + p
> > +  tblname += '_' + dirname
> > +  return tblname.replace('-', '_')
> > +
> > +
> > +class JsonEvent:
> > +  """Representation of an event loaded from a json file dictionary."""
> > +
> > +  def __init__(self, dict):
> > +    """Constructor passed the dictionary of parsed json values."""
> > +
> > +    def llx(x: int) -> str:
> > +      """Convert an int to a string similar to a printf modifier of %#llx."""
> > +      return '0' if x == 0 else hex(x)
> > +
> > +    def fixdesc(s: str) -> str:
> > +      """Fix formatting issue for the desc string."""
> > +      if s is None:
> > +        return None
> > +      return s.removesuffix('.  ').removesuffix('. ').removesuffix('.').replace(
> > +          '\n', '\\n').replace('\"', '\\"').replace('\r', '\\r')
> > +
> > +    def convert_aggr_mode(aggr_mode: str) -> str:
> > +      """Returns the aggr_mode_class enum value associated with the JSON string."""
> > +      if not aggr_mode:
> > +        return None
> > +      aggr_mode_to_enum = {
> > +          'PerChip': '1',
> > +          'PerCore': '2',
> > +      }
> > +      return aggr_mode_to_enum[aggr_mode]
> > +
> > +    def lookup_msr(num: str) -> str:
> > +      """Converts the msr number, or first in a list to the appropriate event field."""
> > +      if not num:
> > +        return None
> > +      msrmap = {
> > +          0x3F6: 'ldlat=',
> > +          0x1A6: 'offcore_rsp=',
> > +          0x1A7: 'offcore_rsp=',
> > +          0x3F7: 'frontend=',
> > +      }
> > +      return msrmap[int(num.split(',', 1)[0], 0)]
> > +
> > +    def real_event(name: str, event: str) -> str:
> > +      """Convert well known event names to an event string otherwise use the event argument."""
> > +      fixed = {
> > +          'inst_retired.any': 'event=0xc0,period=2000003',
> > +          'inst_retired.any_p': 'event=0xc0,period=2000003',
> > +          'cpu_clk_unhalted.ref': 'event=0x0,umask=0x03,period=2000003',
> > +          'cpu_clk_unhalted.thread': 'event=0x3c,period=2000003',
> > +          'cpu_clk_unhalted.core': 'event=0x3c,period=2000003',
> > +          'cpu_clk_unhalted.thread_any': 'event=0x3c,any=1,period=2000003',
> > +      }
> > +      if not name:
> > +        return None
> > +      if name.lower() in fixed:
> > +        return fixed[name.lower()]
> > +      return event
> > +
> > +    def unit_to_pmu(unit: str) -> str:
> > +      """Convert a JSON Unit to Linux PMU name."""
> > +      if not unit:
> > +        return None
> > +      # Comment brought over from jevents.c:
> > +      # it's not realistic to keep adding these, we need something more scalable ...
> > +      table = {
> > +          'CBO': 'uncore_cbox',
> > +          'QPI LL': 'uncore_qpi',
> > +          'SBO': 'uncore_sbox',
> > +          'iMPH-U': 'uncore_arb',
> > +          'CPU-M-CF': 'cpum_cf',
> > +          'CPU-M-SF': 'cpum_sf',
> > +          'UPI LL': 'uncore_upi',
> > +          'hisi_sicl,cpa': 'hisi_sicl,cpa',
> > +          'hisi_sccl,ddrc': 'hisi_sccl,ddrc',
> > +          'hisi_sccl,hha': 'hisi_sccl,hha',
> > +          'hisi_sccl,l3c': 'hisi_sccl,l3c',
> > +          'imx8_ddr': 'imx8_ddr',
> > +          'L3PMC': 'amd_l3',
> > +          'DFPMC': 'amd_df',
> > +          'cpu_core': 'cpu_core',
> > +          'cpu_atom': 'cpu_atom',
> > +      }
> > +      return table[unit] if unit in table else f'uncore_{unit.lower()}'
> > +
> > +    eventcode = 0
> > +    if 'EventCode' in dict:
> > +      eventcode = int(dict['EventCode'].split(',', 1)[0], 0)
> > +    if 'ExtSel' in dict:
> > +      eventcode |= int(dict['ExtSel']) << 8
> > +    configcode = int(dict['ConfigCode'], 0) if 'ConfigCode' in dict else None
> > +    self.name = dict['EventName'].lower() if 'EventName' in dict else None
> > +    self.compat = dict.get('Compat')
> > +    self.desc = fixdesc(dict.get('BriefDescription'))
> > +    self.long_desc = fixdesc(dict.get('PublicDescription'))
> > +    precise = dict.get('PEBS')
> > +    msr = lookup_msr(dict.get('MSRIndex'))
> > +    msrval = dict.get('MSRValue')
> > +    extra_desc = ''
> > +    if 'Data_LA' in dict:
> > +      extra_desc += '  Supports address when precise'
> > +      if 'Errata' in dict:
> > +        extra_desc += '.'
> > +    if 'Errata' in dict:
> > +      extra_desc += '  Spec update: ' + dict['Errata']
> > +    self.pmu = unit_to_pmu(dict.get('Unit'))
> > +    filter = dict.get('Filter')
> > +    self.unit = dict.get('ScaleUnit')
> > +    self.perpkg = dict.get('PerPkg')
> > +    self.aggr_mode = convert_aggr_mode(dict.get('AggregationMode'))
> > +    self.deprecated = dict.get('Deprecated')
> > +    self.metric_name = dict.get('MetricName')
> > +    self.metric_group = dict.get('MetricGroup')
> > +    self.metric_constraint = dict.get('MetricConstraint')
> > +    self.metric_expr = dict.get('MetricExpr')
> > +    if self.metric_expr:
> > +      self.metric_expr = self.metric_expr.replace('\\', '\\\\')
> > +    arch_std = dict.get('ArchStdEvent')
> > +    if precise and self.desc and not '(Precise Event)' in self.desc:
> > +      extra_desc += ' (Must be precise)' if precise == '2' else (' (Precise '
> > +                                                                 'event)')
> > +    event = f'config={llx(configcode)}' if configcode is not None else f'event={llx(eventcode)}'
> > +    event_fields = [
> > +        ('AnyThread', 'any='),
> > +        ('PortMask', 'ch_mask='),
> > +        ('CounterMask', 'cmask='),
> > +        ('EdgeDetect', 'edge='),
> > +        ('FCMask', 'fc_mask='),
> > +        ('Invert', 'inv='),
> > +        ('SampleAfterValue', 'period='),
> > +        ('UMask', 'umask='),
> > +    ]
> > +    for key, value in event_fields:
> > +      if key in dict and dict[key] != '0':
> > +        event += ',' + value + dict[key]
> > +    if filter:
> > +      event += f',{filter}'
> > +    if msr:
> > +      event += f',{msr}{msrval}'
> > +    if self.desc and extra_desc:
> > +      self.desc += extra_desc
> > +    if self.long_desc and extra_desc:
> > +      self.long_desc += extra_desc
> > +    if self.pmu:
> > +      if self.desc and not self.desc.endswith('. '):
> > +        self.desc += '. '
> > +      self.desc = (self.desc if self.desc else '') + ('Unit: ' + self.pmu + ' ')
> > +    if arch_std and arch_std.lower() in arch_std_events:
> > +      event = arch_std_events[arch_std.lower()].event
> > +      # Copy from the architecture standard event to self for undefined fields.
> > +      for attr, value in arch_std_events[arch_std.lower()].__dict__.items():
> > +        if hasattr(self, attr) and not getattr(self, attr):
> > +          setattr(self, attr, value)
> > +
> > +    self.event = real_event(self.name, event)
> > +
> > +  def __repr__(self) -> str:
> > +    """String representation primarily for debugging."""
> > +    s = '{\n'
> > +    for attr, value in self.__dict__.items():
> > +      if value:
> > +        s += f'\t{attr} = {value},\n'
> > +    return s + '}'
> > +
> > +  def ToCString(self, topic_local: str) -> str:
> > +    """Representation of the event as a C struct initializer."""
> > +
> > +    def AttrString(attr: str, value: str) -> str:
> > +      return '\t.%s = \"%s\",\n' % (attr, value)
> > +
> > +    def StrIfPresent(self, attr: str) -> str:
> > +      if not getattr(self, attr):
> > +        return ''
> > +      return AttrString(attr, getattr(self, attr))
> > +
> > +    s = '{\n'
> > +    for attr in ['name', 'event']:
> > +      s += StrIfPresent(self, attr)
> > +    if self.desc is not None:
> > +      s += AttrString('desc', self.desc)
> > +    else:
> > +      s += AttrString('desc', '(null)')
> > +    s += StrIfPresent(self, 'compat')
> > +    s += f'\t.topic = "{topic_local}",\n'
> > +    for attr in [
> > +        'long_desc', 'pmu', 'unit', 'perpkg', 'aggr_mode', 'metric_expr',
> > +        'metric_name', 'metric_group', 'deprecated', 'metric_constraint'
> > +    ]:
> > +      s += StrIfPresent(self, attr)
> > +    s += '},\n'
> > +    return s
> > +
> > +
> > +def read_json_events(path: str) -> list[JsonEvent]:
> > +  """Read json events from the specified file."""
> > +  return json.load(open(path), object_hook=lambda d: JsonEvent(d))
> > +
> > +def preprocess_arch_std_files(archpath: str) -> None:
> > +  """Read in all architecture standard events."""
> > +  global arch_std_events
> > +  for item in os.scandir(archpath):
> > +    if item.is_file() and item.name.endswith('.json'):
> > +      for event in read_json_events(item.path):
> > +        if event.name:
> > +          arch_std_events[event.name.lower()] = event
> > +
> > +
> > +def print_events_table_prefix(tblname: str) -> None:
> > +  """Called when a new events table is started."""
> > +  global close_table
> > +  if close_table:
> > +    raise IOError('Printing table prefix but last table has no suffix')
> > +  args.output_file.write('static const struct pmu_event %s[] = {\n' % tblname)
> > +  close_table = True
> > +
> > +
> > +def print_events_table_entries(item: os.DirEntry, topic: str) -> None:
> > +  """Create contents of an events table."""
> > +  if not close_table:
> > +    raise IOError('Table entries missing prefix')
> > +  for event in read_json_events(item.path):
> > +    args.output_file.write(event.ToCString(topic))
> > +
> > +def print_events_table_suffix() -> None:
> > +  """Optionally close events table."""
> > +  global close_table
> > +  if close_table:
> > +    args.output_file.write("""{
> > +\t.name = 0,
> > +\t.event = 0,
> > +\t.desc = 0,
> > +},
> > +};
> > +""")
> > +  close_table = False
> > +
> > +def process_one_file(parents: list[str], item: os.DirEntry) -> None:
> > +  """Process a JSON file during the main walk."""
> > +  global sys_event_tables
> > +
> > +  def get_topic(topic: str) -> str:
> > +    return topic.removesuffix('.json').replace('-', ' ')
> > +
> > +  def is_leaf_dir(path: str) -> bool:
> > +    for item in os.scandir(path):
> > +      if item.is_dir():
> > +        return False
> > +    return True
> > +
> > +  # model directory, reset topic
> > +  if item.is_dir() and is_leaf_dir(item.path):
> > +    print_events_table_suffix()
> > +
> > +    tblname = file_name_to_table_name(parents, item.name)
> > +    if item.name == 'sys':
> > +      sys_event_tables.append(tblname)
> > +    print_events_table_prefix(tblname)
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
> > +  print_events_table_entries(item, get_topic(item.name))
> > +
> > +
> > +def print_mapping_table() -> None:
> > +  """Read the mapfile and generate the struct from cpuid string to event table."""
> > +  table = csv.reader(open(f'{args.starting_dir}/{args.arch}/mapfile.csv'))
> > +  args.output_file.write('const struct pmu_events_map pmu_events_map[] = {\n')
> > +  first = True
> > +  for row in table:
> > +    # Skip the first row or any row beginning with #.
> > +    if not first and len(row) > 0 and not row[0].startswith('#'):
> > +      tblname = file_name_to_table_name([], row[2].replace('/', '_'))
> > +      args.output_file.write("""{
> > +\t.cpuid = \"%s\",
> > +\t.version = \"%s\",
> > +\t.type = \"%s\",
> > +\t.table = %s
> > +},
> > +""" % (row[0].replace('\\', '\\\\'), row[1], row[3], tblname))
> > +    first = False
> > +
> > +  args.output_file.write("""{
> > +\t.cpuid = "testcpu",
> > +\t.version = "v1",
> > +\t.type = "core",
> > +\t.table = pme_test_soc_cpu,
> > +},
> > +{
> > +\t.cpuid = 0,
> > +\t.version = 0,
> > +\t.type = 0,
> > +\t.table = 0,
> > +},
> > +};
> > +""")
> > +
> > +
> > +def print_system_mapping_table() -> None:
> > +  """C struct mapping table array for tables from /sys directories."""
> > +  args.output_file.write(
> > +      '\nconst struct pmu_sys_events pmu_sys_event_tables[] = {\n')
> > +  for tblname in sys_event_tables:
> > +    args.output_file.write("""\t{
> > +\t\t.table = %s,
> > +\t\t.name = \"%s\",
> > +\t},
> > +""" % (tblname, tblname))
> > +  args.output_file.write("""\t{
> > +\t\t.table = 0
> > +\t},
> > +};
> > +""")
> > +
> > +
> > +def main() -> None:
> > +  global args
> > +
> > +  def dir_path(path: str) -> str:
> > +    """Validate path is a directory for argparse."""
> > +    if os.path.isdir(path):
> > +      return path
> > +    else:
> > +      raise argparse.ArgumentTypeError(f'\'{path}\' is not a valid directory')
> > +
> > +  def ftw(path: str, parents: list[str],
> > +          action: Callable[[list[str], os.DirEntry], None]) -> None:
> > +    """Replicate the directory/file walking behavior of C's file tree walk."""
> > +    for item in os.scandir(path):
> > +      action(parents, item)
> > +      if item.is_dir():
> > +        ftw(item.path, parents + [item.name], action)
> > +
> > +  ap = argparse.ArgumentParser()
> > +  ap.add_argument('arch', help='Architecture name like x86')
> > +  ap.add_argument(
> > +      'starting_dir',
> > +      type=dir_path,
> > +      help='Root of tree containing architecture directories containing json files'
> > +  )
> > +  ap.add_argument(
> > +      'output_file', type=argparse.FileType('w'), nargs='?', default=sys.stdout)
> > +  args = ap.parse_args()
> > +
> > +  args.output_file.write("#include \"pmu-events/pmu-events.h\"\n")
> > +  for path in [args.arch, 'test']:
> > +    arch_path = f'{args.starting_dir}/{path}'
> > +    if not os.path.isdir(arch_path):
> > +      raise IOError(f'Missing architecture directory in \'{arch_path}\'')
> > +    preprocess_arch_std_files(arch_path)
> > +    ftw(arch_path, [], process_one_file)
> > +    print_events_table_suffix()
> > +
> > +  print_mapping_table()
> > +  print_system_mapping_table()
> > +
> > +
> > +if __name__ == '__main__':
> > +  main()
>
> --
> Zhengjun Xing
