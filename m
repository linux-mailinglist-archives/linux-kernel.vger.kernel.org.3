Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D29B4676F0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 13:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380666AbhLCMEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 07:04:07 -0500
Received: from foss.arm.com ([217.140.110.172]:48280 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380642AbhLCMD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 07:03:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68B981396;
        Fri,  3 Dec 2021 04:00:35 -0800 (PST)
Received: from [10.1.29.138] (e127744.cambridge.arm.com [10.1.29.138])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 213453F5A1;
        Fri,  3 Dec 2021 04:00:31 -0800 (PST)
Subject: Re: [PATCH v1 2/4] perf script: Add "struct machine" parameter to
 process_event callback
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20211201123334.679131-1-german.gomez@arm.com>
 <20211201123334.679131-3-german.gomez@arm.com>
 <D6A3A8F3-9946-44FE-A70F-42977C6F38A1@linux.vnet.ibm.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <38fd4992-63ae-4871-ddfd-27d40b5c48d2@arm.com>
Date:   Fri, 3 Dec 2021 12:00:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <D6A3A8F3-9946-44FE-A70F-42977C6F38A1@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Athira,

On 02/12/2021 16:03, Athira Rajeev wrote:
>
>> On 01-Dec-2021, at 6:03 PM, German Gomez <german.gomez@arm.com> wrote:
>>
>> Include a "struct machine*" parameter to the process_event callback in
>> the scripting layer. This will allow access to the perf_env from within
>> this callback.
>>
>> Followup patches will build on top of this to report the correct name of
>> the registers in a perf.data file, consistently with the architecture
>> the file was recorded in.
>>
>> Signed-off-by: German Gomez <german.gomez@arm.com>
>> ---
>> tools/perf/builtin-script.c                   |  2 +-
>> .../util/scripting-engines/trace-event-perl.c |  3 ++-
>> .../scripting-engines/trace-event-python.c    | 23 +++++++++++--------
>> tools/perf/util/trace-event-scripting.c       |  3 ++-
>> tools/perf/util/trace-event.h                 |  3 ++-
>> 5 files changed, 21 insertions(+), 13 deletions(-)
>>
>> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
>> index 9434367af..711132f0b 100644
>> --- a/tools/perf/builtin-script.c
>> +++ b/tools/perf/builtin-script.c
>> @@ -2256,7 +2256,7 @@ static int process_sample_event(struct perf_tool *tool,
>> 				thread__resolve(al.thread, &addr_al, sample);
>> 			addr_al_ptr = &addr_al;
>> 		}
>> -		scripting_ops->process_event(event, sample, evsel, &al, addr_al_ptr);
>> +		scripting_ops->process_event(event, sample, evsel, &al, addr_al_ptr, machine);
> Hi,
>
> Looks like the patch is using “machine” to allow access to perf_env__arch and there by to get the “arch” value.
> But can we use from evsel, like  "perf_env__arch(evsel__env(evsel))” to get arch value instead of including new parameter for “struct machine” ?
>
> Thanks
> Athira

Thanks for the suggestion. It looks like we can skip this patch if we
can get the arch value that way.

Thanks!
German

