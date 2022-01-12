Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8182348C4EC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 14:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353624AbiALNe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 08:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240715AbiALNe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 08:34:57 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195C5C06173F;
        Wed, 12 Jan 2022 05:34:57 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id a8so2925117qvx.2;
        Wed, 12 Jan 2022 05:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=NFDSAYWWEghRl249PD7UteTcbSMKGi0YcLFLy79Axow=;
        b=p7BRPXKkP1fBOaFgkVehg1eJ0KX49x2xCmJQ/QQzF3OcUb3UTAs266QUsqncZ2D3rA
         i7Q4cR2WvrUMa7ZTDydcIJnX16NprRykRscIfg5PCestLZLGQ0w0ACW30Z7A04DkZy2q
         B3y8bEPARillo4b4sP75cqwieZw+nEM6XITeAn96F3D1DdBMegYHguA1w0wTYnAgBcAf
         nD67kpuL+s2R+zOHHgQ+j/aWxXE84DOk7af3VvAYX4Mnntd8GUyK6Jxbt0jzI4hKJYdc
         MIi4VZF4ApnmI0FTzwtTlmHseGE1wzTRD/092gMROxjP353viyk1XpDPcpqKTkCyO7oO
         uJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=NFDSAYWWEghRl249PD7UteTcbSMKGi0YcLFLy79Axow=;
        b=FruH/k4GV1LvDxA6zfZ3J/WfEGljvGE5sesbx4tlP7IPMNzZ9mqyDffE/DVrLLEPt4
         84LJmbQbsLPD/1bh655nRwaP1WK/2ZnJCw2Byxo3bl5pAXsj/ymnPj8JX3DqiO6O3BiH
         xv2WWcanKS4XeoZKNxcwhAVygTyUQssPvHxaZorGBtkRYLegJXMGxAhAcS2g60gxawkh
         vlXgCcaLR3VuqqeqdiDQJ7+rqjQSPkcYTAe0JhReSNapAgVxIad26CuMQSOVrmvBqXTB
         8Megq7gJOhVLvNhLO37GcM6rQvPCoUinyhw+XrUgITS4agb1B0MX14FLbBEDx7llL59D
         tzYQ==
X-Gm-Message-State: AOAM531phiHC9O7tnSkTSX3KX7T3GYkBudyeSz887eblI2X3iLVymjug
        23TmKOk/7wsmB6PxA5exl0eeXx4rcUE=
X-Google-Smtp-Source: ABdhPJzOaQ2XRHQILa9r/cjG3JRd8PNhh9UpaMgoEkNLkFkOcc7cA71wKuxOdButm8XZbTZZP8VKjA==
X-Received: by 2002:a05:6214:2344:: with SMTP id hu4mr7934600qvb.55.1641994496223;
        Wed, 12 Jan 2022 05:34:56 -0800 (PST)
Received: from [127.0.0.1] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id h20sm8403640qka.126.2022.01.12.05.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 05:34:55 -0800 (PST)
Date:   Wed, 12 Jan 2022 10:34:50 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     John Garry <john.garry@huawei.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_1/2=5D_perf_test=3A_Workl?= =?US-ASCII?Q?oad_test_of_metric_and_metricgroups?=
User-Agent: K-9 Mail for Android
In-Reply-To: <158a1451-9d69-d67d-3fad-9e947112f9e6@huawei.com>
References: <20210917184240.2181186-1-irogers@google.com> <YU4iVcVc6uYAWft4@kernel.org> <158a1451-9d69-d67d-3fad-9e947112f9e6@huawei.com>
Message-ID: <BD3A5CA5-B566-4FD9-9409-0329CC322060@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On January 12, 2022 9:24:29 AM GMT-03:00, John Garry <john=2Egarry@huawei=
=2Ecom> wrote:
>On 24/09/2021 20:09, Arnaldo Carvalho de Melo wrote:
>> Em Fri, Sep 17, 2021 at 11:42:39AM -0700, Ian Rogers escreveu:
>>> Test every metric and metricgroup with 'true' as a workload=2E For
>>> metrics, check that we see the metric printed or get unsupported=2E If=
 the
>>> 'true' workload executes too quickly retry with 'perf bench internals
>>> synthesize'=2E
>>>
>>> v3=2E Fix test condition (thanks to Paul A=2E Clarke<pc@us=2Eibm=2Ecom=
>)=2E Add a
>>>      fallback case of a larger workload so that we don't ignore "<not
>>>      counted>"=2E
>>> v2=2E Switched the workload to something faster=2E
>
>Hi Ian,
>
>I just noticed that this test fails on my broadwell machine=2E
>
>I am using acme perf/core @ 09dd3c22daaf

Hi,

Can you try with tmp=2Eperf/perf_cpu instead?

There's a patch there that maybe fixes this=2E

- Arnaldo
>
>metricgroup Memory_Bw fails, and it seems because of the "true" argument=
=20
>to "perf stat" (or any argument, like sleep 1):
>
>john@localhost:~/kernel-dev9/tools/perf> sudo =2E/perf stat -M Memory_BW
>^C
>  Performance counter stats for 'system wide':
>
>              2,184      arb/event=3D0x84,umask=3D0x1/ #     0=2E26=20
>DRAM_BW_Use
>          2,954,938      arb/event=3D0x81,umask=3D0x1/=20
>
>        736,368,852 ns   duration_time=20
>
>         58,202,980      l1d_pend_miss=2Epending_cycles #     2=2E34 MLP=
=20
>                  (80=2E11%)
>        136,293,194      l1d_pend_miss=2Epending=20
>               (19=2E89%)
>        736,368,852 ns   duration_time=20
>
>          1,065,656      longest_lat_cache=2Emiss    #     0=2E09=20
>L3_Cache_Fill_BW         (39=2E71%)
>        736,368,852 ns   duration_time=20
>
>          5,365,477      l2_lines_in=2Eall           #     0=2E47=20
>L2_Cache_Fill_BW         (59=2E80%)
>        736,368,852 ns   duration_time=20
>
>          3,557,362      l1d=2Ereplacement           #     0=2E31=20
>L1D_Cache_Fill_BW        (79=2E90%)
>        736,368,852 ns   duration_time=20
>
>
>        0=2E736368852 seconds time elapsed
>
>
>john@localhost:~/kernel-dev9/tools/perf> sudo =2E/perf stat -M Memory_BW =
true
>Error:
>The sys_perf_event_open() syscall returned with 22 (Invalid argument)=20
>for event (arb/event=3D0x84,umask=3D0x1/)=2E
>/bin/dmesg | grep -i perf may provide additional information=2E
>
>john@localhost:~/kernel-dev9/tools/perf>
>
>Anyone any idea on this before I start digging?
>
>Thanks,
>John
