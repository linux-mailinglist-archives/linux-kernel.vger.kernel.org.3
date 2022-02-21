Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1754BEAD8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbiBUTS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 14:18:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbiBUTSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 14:18:45 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE7E5F88
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 11:18:21 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id 189-20020a4a03c6000000b003179d7b30d8so14459885ooi.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 11:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=plpN+UuKJNWQr4MOMNoUeOB4idktsGTTWBNT7w75w4Y=;
        b=AJiCYOZd2uKFxYIxqv2sEJ7IfemSF5bjc3bL2FSKlSSD/w8O9C28oNA7f9AVL51+MM
         G03vGTHqgmS6BVzp3bcfGvkab3izVmFA+Tn0rNbCK1kEAjIyH723rq76QuMBGKqbmx/a
         b43TeKEDlMszAZ393DHoeCChDVwnO3R2FOPjAYpe9Vhp9h4V5BA8zzazNVCG3zZgBmLs
         a17KLyRVObqM7x3IFpHzF25aiSP1G7MQQbyp8Z/yqvbvzW3Ke/TlL26/3e20CIwbGyxi
         3oOLcWRLrATv3jRQ8YRv2zDfrFfmE0JcP+Vp8xZMOXW9mhfSUd76i/qE6R0zvpif7n5D
         dKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=plpN+UuKJNWQr4MOMNoUeOB4idktsGTTWBNT7w75w4Y=;
        b=wYodtscwumz6tM+fTczCcyhm/1cbHuxD6jV2wBfRCOLyr6QfDlAGaWmGeeRviDE2iL
         IUKetRFt3PNXsUI4Je8w/yRB6F3pgMUG1rB4nr6y6NCbSUAxeDamQBwxNCl/84FRbxCA
         EJtvCKBQAehdiB8GmjxDaJM4XEmvzUB99KRTysz3bvsVatKGdMcAIt2ngJ0PBtwKmO5s
         sooxSB2qFg1EB/nbfO4lBK5bmAuiKXMP9p8XQFaqX+969h6Lx7aQ9d/MbpG0b+vgJF7F
         TCJGqPEvWaJxHyqt3kkzGdmacHp/LNFAO5gUqrUxZp9nbYWM0qOwPR9WboqZ9ekXzehG
         D4Ng==
X-Gm-Message-State: AOAM531lwXDxhhpcCk4Mjp+XtDhdB6biOyp6OOx/qtBhLRlqNl7qK5E0
        /5vofKUOoS+QpXjd2vZqaIA=
X-Google-Smtp-Source: ABdhPJxkYj2UNaUUWFKm9dtoFOmFweigRWZ0vYJ0UnRWNb8Zcbuev5QPXZm/LRnP4jkLZk9O/Vbkgg==
X-Received: by 2002:a05:6870:7c06:b0:d2:8a08:3b53 with SMTP id je6-20020a0568707c0600b000d28a083b53mr192656oab.61.1645471099965;
        Mon, 21 Feb 2022 11:18:19 -0800 (PST)
Received: from [127.0.0.1] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id n11sm15470985oal.1.2022.02.21.11.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 11:18:19 -0800 (PST)
Date:   Mon, 21 Feb 2022 16:16:44 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>,
        Jiri Olsa <olsajiri@gmail.com>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_core=5D_perf_data=3A_Adding_erro?= =?US-ASCII?Q?r_message_if_perf=5Fdata=5F=5Fcreate=5Fdir_fails?=
User-Agent: K-9 Mail for Android
In-Reply-To: <f5a97d51-fa64-0e48-d150-e8a983f88a32@linux.intel.com>
References: <20220218152341.5197-1-alexey.v.bayduraev@linux.intel.com> <YhLEHCttvXmRu78G@krava> <60253e6d-e8c5-550e-73b5-40720114c2a4@linux.intel.com> <YhPY3B3QumIZWukQ@krava> <f5a97d51-fa64-0e48-d150-e8a983f88a32@linux.intel.com>
Message-ID: <C5DD162C-1991-40F1-93ED-62924E7916A9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On February 21, 2022 3:45:55 PM GMT-03:00, "Bayduraev, Alexey V" <alexey=
=2Ev=2Ebayduraev@linux=2Eintel=2Ecom> wrote:
>
>On 21=2E02=2E2022 21:24, Jiri Olsa wrote:
>> On Mon, Feb 21, 2022 at 04:24:28PM +0300, Bayduraev, Alexey V wrote:
>>> On 21=2E02=2E2022 1:43, Jiri Olsa wrote:
>>>> On Fri, Feb 18, 2022 at 06:23:40PM +0300, Alexey Bayduraev wrote:
>>>>> There is no notification about data directory creation failure=2E Ad=
d it=2E
>>>>>
>>>>> Signed-off-by: Alexey Bayduraev <alexey=2Ev=2Ebayduraev@linux=2Einte=
l=2Ecom>
>>>>> ---
>>>>>  tools/perf/builtin-record=2Ec | 4 +++-
>>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/tools/perf/builtin-record=2Ec b/tools/perf/builtin-reco=
rd=2Ec
>>>>> index 0bc6529814b2=2E=2E0306d5911de2 100644
>>>>> --- a/tools/perf/builtin-record=2Ec
>>>>> +++ b/tools/perf/builtin-record=2Ec
>>>>> @@ -1186,8 +1186,10 @@ static int record__mmap_evlist(struct record =
*rec,
>>>>> =20
>>>>>  	if (record__threads_enabled(rec)) {
>>>>>  		ret =3D perf_data__create_dir(&rec->data, evlist->core=2Enr_mmaps=
);
>>>>> -		if (ret)
>>>>> +		if (ret) {
>>>>> +			pr_err("Failed to create data directory: %s\n", strerror(errno))=
;
>>>>
>>>> errno will be misleading in here, because perf_data__create_dir
>>>> calls other syscalls on error path
>>>
>>> Mostly I want to output something like:
>>>
>>>   Failed to create data dir: Too many open files
>>>
>>> This will trigger the user to increase the open files limit=2E
>>> Would it be better to place such message to perf_data__create_dir afte=
r=20
>>> open() syscall?
>>=20
>> how about something like below (with your change)
>
>Looks better, I will apply this to my patch=2E


Thanks a lot, I'll check when you post it=2E

Thanks for splitting that original patch, it was the correct thing to do i=
n the first place, and now one of the patches got reviews I even missed :-)

- Arnaldo

>
>Thanks,
>Alexey
>
>>=20
>> jirka
>>=20
>>=20
>> ---
>> diff --git a/tools/perf/util/data=2Ec b/tools/perf/util/data=2Ec
>> index 15a4547d608e=2E=2Ed3382098d6f9 100644
>> --- a/tools/perf/util/data=2Ec
>> +++ b/tools/perf/util/data=2Ec
>> @@ -52,8 +52,10 @@ int perf_data__create_dir(struct perf_data *data, in=
t nr)
>>  			goto out_err;
>> =20
>>  		ret =3D open(file->path, O_RDWR|O_CREAT|O_TRUNC, S_IRUSR|S_IWUSR);
>> -		if (ret < 0)
>> +		if (ret < 0) {
>> +			ret =3D -errno;
>>  			goto out_err;
>> +		}
>> =20
>>  		file->fd =3D ret;
>>  	}
