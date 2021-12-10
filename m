Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F16470575
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240377AbhLJQXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbhLJQX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:23:29 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F69EC061746;
        Fri, 10 Dec 2021 08:19:54 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id p3so8389994qvj.9;
        Fri, 10 Dec 2021 08:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=tMMxFmdx6MfMkYIe7s/tX2fGsd/7SaUGLt53xeNBSto=;
        b=jHaNUOm+bAFT/71ZTymVQb/kmN4r5rYXWFg+VqSDFuvYGhNE+xv4y1Y+bnH2sb+fhj
         NV919Z87+m+44Qr4B7KsYG4OujDtURNuCUuqHDtU3xv4d/RbPDoPsRgyllsKOLKHqNiq
         ufBBokrSbKEDD8kj0nZnTl3JaT8Nstvuxfev+U0iEv6QotJD7DRirfQMLB2KI0CvSOS/
         vDTh9L0/QWze5Aqk8HRlsWW8O5Aa5sVaj4QDc2+PH7Fk454q3wl2/k59cshgL2mBYhvR
         kWFDXIgne1fyDDwJnK4lufmM9r6u+SOrZ6Llz6vhyOOauwgoFnbav/nHigDNqgPed3l+
         sD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=tMMxFmdx6MfMkYIe7s/tX2fGsd/7SaUGLt53xeNBSto=;
        b=R/XCFXvtti1gRu44gPJL5UdNvYPsZ190gKAzXh84w+TYquy0S4KW2ylR7cmobV4RrV
         Efrgjsl6HNJnxQTit8UcRSTkV/skylKSUtzzhWWr8GZJaGav0tX8LOl13HJi88YjuwOf
         Pd7LdPioXtwNgwLi3rHBYrTvtMq3RYqDCF4Q1fElP0/9K6qzmKcKOcqD6p9xllO5pBxy
         mFAc9QcK1na6otw7nyZ8ERTPwI7NHJ9R3hJ6NuNHKCP6lKD/AwXhpl7tLuRKdS7/sarm
         wQJAkexknamDTDxoQvD8ZQy2btoabuon9WGg4ycsVA9z/xFybUD4ozyaNGRrv//cALXD
         MxUw==
X-Gm-Message-State: AOAM532oJPjCDt/RCkj/FHNzt2qHgyS3hpB9/F9cfHtUjQNDdZxhyB7c
        aUmh6M5/MByKTAHWmmR7cVc=
X-Google-Smtp-Source: ABdhPJzdk7VpNonY+bRlvorAlgEXJPEuVKPvG89stBQW6JD1wHoFdSsWe1YbNMAuaoBBJCFP3aNM4A==
X-Received: by 2002:a05:6214:27ee:: with SMTP id jt14mr25674296qvb.112.1639153193232;
        Fri, 10 Dec 2021 08:19:53 -0800 (PST)
Received: from [127.0.0.1] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id t9sm1379657qkp.110.2021.12.10.08.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 08:19:52 -0800 (PST)
Date:   Fri, 10 Dec 2021 13:19:47 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     German Gomez <german.gomez@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        kajoljain <kjain@linux.ibm.com>
CC:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
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
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_1/4=5D_perf_tools=3A_Preve?= =?US-ASCII?Q?nt_out-of-bounds_access_to_registers?=
User-Agent: K-9 Mail for Android
In-Reply-To: <42c6ea29-5904-bb8b-d9c6-a0516c3a564f@arm.com>
References: <20211201123334.679131-1-german.gomez@arm.com> <20211201123334.679131-2-german.gomez@arm.com> <6705021e-5b02-3323-7dbc-4b774f22a435@linux.ibm.com> <YbNYUC1poqzrWynP@kernel.org> <42c6ea29-5904-bb8b-d9c6-a0516c3a564f@arm.com>
Message-ID: <95E7589C-3822-4F73-A0CA-42E64654E021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On December 10, 2021 12:28:56 PM GMT-03:00, German Gomez <german=2Egomez@a=
rm=2Ecom> wrote:
>
>On 10/12/2021 13:38, Arnaldo Carvalho de Melo wrote:
>> Em Fri, Dec 10, 2021 at 02:47:49PM +0530, kajoljain escreveu:
>>>
>>> On 12/1/21 6:03 PM, German Gomez wrote:
>>>> The size of the cache of register values is arch-dependant
>>>> (PERF_REGS_MAX)=2E This has the potential of causing an out-of-bounds
>>>> access in the function "perf_reg_value" if the local architecture
>>>> contains less registers than the one the perf=2Edata file was recorde=
d on=2E
>>>>
>>>> Since the maximum number of registers is bound by the bitmask "u64
>>>> cache_mask", and the size of the cache when running under x86 systems=
 is
>>>> 64 already, fix the size to 64 and add a range-check to the function
>>>> "perf_reg_value" to prevent out-of-bounds access=2E
>>>>
>>> Patch looks good to me=2E
>>>
>>> Reviewed-by: Kajol Jain<kjain@linux=2Eibm=2Ecom>
>> Thanks, applied=2E
>>
>> - Arnaldo
>
>Thanks Arnaldo, and the rest for the review=2E
>
>I did send a v2 of this patch afterwards=2E The only difference was to
>give credit to the reporter in the commit message with:
>
>Reported-by: Alexandre Truong <alexandre=2Etruong@arm=2Ecom>


I'll add it=2E

- Arnaldo
>
>Thanks,
>German
>
>> =20
>>> Thanks,
>>> Kajol Jain
>>>
>>>> Signed-off-by: German Gomez <german=2Egomez@arm=2Ecom>
>>>> ---
>>>>  tools/perf/util/event=2Eh     | 5 ++++-
>>>>  tools/perf/util/perf_regs=2Ec | 3 +++
>>>>  2 files changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/perf/util/event=2Eh b/tools/perf/util/event=2Eh
>>>> index 95ffed663=2E=2Ec59331eea 100644
>>>> --- a/tools/perf/util/event=2Eh
>>>> +++ b/tools/perf/util/event=2Eh
>>>> @@ -44,13 +44,16 @@ struct perf_event_attr;
>>>>  /* perf sample has 16 bits size limit */
>>>>  #define PERF_SAMPLE_MAX_SIZE (1 << 16)
>>>> =20
>>>> +/* number of register is bound by the number of bits in regs_dump::m=
ask (64) */
>>>> +#define PERF_SAMPLE_REGS_CACHE_SIZE (8 * sizeof(u64))
>>>> +
>>>>  struct regs_dump {
>>>>  	u64 abi;
>>>>  	u64 mask;
>>>>  	u64 *regs;
>>>> =20
>>>>  	/* Cached values/mask filled by first register access=2E */
>>>> -	u64 cache_regs[PERF_REGS_MAX];
>>>> +	u64 cache_regs[PERF_SAMPLE_REGS_CACHE_SIZE];
>>>>  	u64 cache_mask;
>>>>  };
>>>> =20
>>>> diff --git a/tools/perf/util/perf_regs=2Ec b/tools/perf/util/perf_reg=
s=2Ec
>>>> index 5ee47ae15=2E=2E06a7461ba 100644
>>>> --- a/tools/perf/util/perf_regs=2Ec
>>>> +++ b/tools/perf/util/perf_regs=2Ec
>>>> @@ -25,6 +25,9 @@ int perf_reg_value(u64 *valp, struct regs_dump *reg=
s, int id)
>>>>  	int i, idx =3D 0;
>>>>  	u64 mask =3D regs->mask;
>>>> =20
>>>> +	if ((u64)id >=3D PERF_SAMPLE_REGS_CACHE_SIZE)
>>>> +		return -EINVAL;
>>>> +
>>>>  	if (regs->cache_mask & (1ULL << id))
>>>>  		goto out;
>>>> =20
>>>>
