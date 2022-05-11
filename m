Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87A2523225
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 13:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240301AbiEKLtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 07:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbiEKLtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 07:49:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 115E62438C7;
        Wed, 11 May 2022 04:49:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E882ED1;
        Wed, 11 May 2022 04:49:27 -0700 (PDT)
Received: from [10.57.65.69] (unknown [10.57.65.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDE243F73D;
        Wed, 11 May 2022 04:49:24 -0700 (PDT)
Subject: Re: [PATCH 1/4] perf pmu: Add function to check if a pmu file exists
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
References: <20220504150216.581281-1-german.gomez@arm.com>
 <20220504150216.581281-2-german.gomez@arm.com> <YnqVqq5QW/b14oPZ@kernel.org>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <c738398a-d512-6a4d-9d62-b67b0aac091a@arm.com>
Date:   Wed, 11 May 2022 12:49:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YnqVqq5QW/b14oPZ@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo, thanks for the review

On 10/05/2022 17:41, Arnaldo Carvalho de Melo wrote:
> Em Wed, May 04, 2022 at 04:02:12PM +0100, German Gomez escreveu:
>> Add a utility function perf_pmu__file_exists() to check if a given pmu
>> file exists in the sysfs filesystem.
> While reviewing this I noticed:
>
> int perf_pmu__caps_parse(struct perf_pmu *pmu)
> {
>         struct stat st;
>         char caps_path[PATH_MAX];
>         const char *sysfs = sysfs__mountpoint();
>         DIR *caps_dir;
>         struct dirent *evt_ent;
>         int nr_caps = 0;
>
>         if (!sysfs)
>                 return -1;
>
>         snprintf(caps_path, PATH_MAX,
>                  "%s" EVENT_SOURCE_DEVICE_PATH "%s/caps", sysfs, pmu->name);
>
>         if (stat(caps_path, &st) < 0)
>                 return 0;       /* no error if caps does not exist */
>
>
> ------------------------
>
> Shouldn't we introduce a:
>
> const int perf__pmu_pathname_scnprintf(struct perf_pmu *pmu, char *pathname, size_t size, char *filename)
> {
>
> 	return scnprintf(pathname, size, "%s" EVENT_SOURCE_DEVICE_PATH "%s/%s", sysfs, pmu->name, filename);
> }
>
> And use in your perf_pmu__file_exists() and in the other places where
> this open coded pattern appears?

I agree. If nobody else has done it before me, I will send the refactor
in the next respin.

Thanks,
German

>
> I'm waiting for reviews for the ARM specific bits.
>
> - Arnaldo
>  
>> Signed-off-by: German Gomez <german.gomez@arm.com>
>> ---
>>  tools/perf/util/pmu.c | 17 +++++++++++++++++
>>  tools/perf/util/pmu.h |  2 ++
>>  2 files changed, 19 insertions(+)
>>
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index 9a1c7e63e663..9479e9a4da54 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -1854,6 +1854,23 @@ int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt,
>>  	return ret;
>>  }
>>  
>> +bool perf_pmu__file_exists(struct perf_pmu *pmu, const char *name)
>> +{
>> +	char path[PATH_MAX];
>> +	struct stat statbuf;
>> +	const char *sysfs = sysfs__mountpoint();
>> +
>> +	if (!sysfs)
>> +		return false;
>> +
>> +	snprintf(path, PATH_MAX,
>> +		 "%s" EVENT_SOURCE_DEVICE_PATH "%s/%s", sysfs, pmu->name, name);
>> +	if (!file_available(path))
>> +		return false;
>> +
>> +	return stat(path, &statbuf) == 0;
>> +}
>> +
>>  static int perf_pmu__new_caps(struct list_head *list, char *name, char *value)
>>  {
>>  	struct perf_pmu_caps *caps = zalloc(sizeof(*caps));
>> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
>> index 541889fa9f9c..ab728eaf13b6 100644
>> --- a/tools/perf/util/pmu.h
>> +++ b/tools/perf/util/pmu.h
>> @@ -120,6 +120,8 @@ bool pmu_have_event(const char *pname, const char *name);
>>  
>>  int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt, ...) __scanf(3, 4);
>>  
>> +bool perf_pmu__file_exists(struct perf_pmu *pmu, const char *name);
>> +
>>  int perf_pmu__test(void);
>>  
>>  struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu);
>> -- 
>> 2.25.1
