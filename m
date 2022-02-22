Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D67E4BFBEA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbiBVPF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiBVPF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:05:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A68B410E05B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645542330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BMyEEXf8ImD/PSnAQUSmvDiDS2I/otKWXaxekjUtwkM=;
        b=XJEzM4wC/CRVQGXNn3P8Um//KwhVCp1m7f/H8hcloTD/rMidO6bQ66TWdAcWPfb1XpxOWs
        uom9hl/xrGnCAltS1WLD0M8XB+yT4EBuPYVhcvZa3ZRguiu/ffK9jDkYwGbMQgsOABVnWQ
        lSCM2gzNmSbZXeDTeKe46GMbQyhUMFU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-Oa3wgshwN5GOqYV8FoXY7g-1; Tue, 22 Feb 2022 10:05:29 -0500
X-MC-Unique: Oa3wgshwN5GOqYV8FoXY7g-1
Received: by mail-ed1-f71.google.com with SMTP id e10-20020a056402190a00b00410f20467abso12099997edz.14
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:05:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BMyEEXf8ImD/PSnAQUSmvDiDS2I/otKWXaxekjUtwkM=;
        b=ULgGfKbYWgmuTvMjfPwzpJoU5HQ5rOlvtapI0vjBdEzW9wDQfR9+gS5zj+2ByVkpuM
         ly68ADgXJt1lnp148WYX0I9YJfVjSTes96/lhBb+ynoEWhw9l+Fvv/EQl/3tb/yzxpYQ
         9h4/fuLVA/v7cynSsw1zUiD0WsHVh70zS09c6CJQQ0OnGbm+MrLIW++h3UnjYKVLwEFj
         0eVB7PHwz3FwDy72fAqRg/7hPj/LbzSz8igLvxo2ZY4IR9gjDndXq5KWaW2SZVGKu5bz
         jZqjfbUv9d6SSSIgUfJ66xr6L3blILZSMgDWsMapQKI7XyLJAN7VtZxWn/Vm/eCuGQim
         BU9w==
X-Gm-Message-State: AOAM530ULqIgCjuvLvaN8VmsokyqhBLNpJLdRntW/3dpFYabIDER++vm
        zYAyNxs1+JdAf6u4kg+w4vwXUny7rYZUuvJc/26LILYbMoHQLuqD1xyUaMVRLghvBzm/1cILdSm
        hLyb2O5bcwU55HnVfLKxlFFbO
X-Received: by 2002:a17:906:b2c6:b0:6cf:e599:6b81 with SMTP id cf6-20020a170906b2c600b006cfe5996b81mr19181087ejb.578.1645542328139;
        Tue, 22 Feb 2022 07:05:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy1KJPfCHkAFDmEoSxesHnytFaMWyys7pSySGit2iNIkGs8qHqhLn5Ow49sRO57tzqWjQtkYw==
X-Received: by 2002:a17:906:b2c6:b0:6cf:e599:6b81 with SMTP id cf6-20020a170906b2c600b006cfe5996b81mr19181055ejb.578.1645542327839;
        Tue, 22 Feb 2022 07:05:27 -0800 (PST)
Received: from [10.39.193.15] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id ay16sm3760460ejb.61.2022.02.22.07.05.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Feb 2022 07:05:27 -0800 (PST)
From:   Eelco Chaudron <echaudro@redhat.com>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf scripting python: expose symbol offset and source information
Date:   Tue, 22 Feb 2022 16:05:26 +0100
X-Mailer: MailMate (1.14r5870)
Message-ID: <3D8DDD29-A919-4E3C-8256-B7F1DC4CFFED@redhat.com>
In-Reply-To: <YgTENKDfI/2+DZhJ@krava>
References: <164389947295.382219.17025049915445689710.stgit@wsfd-netdev64.ntdv.lab.eng.bos.redhat.com>
 <YgTENKDfI/2+DZhJ@krava>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10 Feb 2022, at 8:52, Jiri Olsa wrote:

> On Thu, Feb 03, 2022 at 09:44:33AM -0500, Eelco Chaudron wrote:
>> This change adds the symbol offset to the data exported for each
>> call-chain entry. This can not be calculated from the script and
>> only the ip value, and no related mmap information.
>>
>> In addition, also export the source file and line information, if
>> available, to avoid an external lookup if this information is needed.
>
> could you please update Documentation/perf-script-python.txt with that?=

>
> any example script under scripts/python would be great

Looks like there is no documentation at all regarding the call chains, on=
ly the auto-generate script.
So rather than trying to describe this, I decided to update the auto-gene=
rated script to include this information as an example.

The current output, if it included a callchain is:

        [ffffffff99e03f0e] syscall_trace_enter
        [ffffffff99e03f0e] syscall_trace_enter
        [ffffffff99e043a9] do_syscall_64
        [ffffffff9a8000ad] entry_SYSCALL_64_after_hwframe
        [7f5b552280db] __GI_getrusage
        [17a4d78] getrusage_thread
        [17a4d78] refresh_rusage
        [17a4d78] time_poll
        [178f683] poll_block
        [16bceb5] udpif_revalidator
        [177b71c] ovsthread_wrapper
        [7f5b57a66179] start_thread
        [7f5b55231dc2] __GI___clone

The new output will be (dependend on the information available):

        [ffffffff99e0392f] syscall_slow_exit_work+0xaf ([kernel.kallsyms]=
)
        [ffffffff99e0392f] syscall_slow_exit_work+0xaf ([kernel.kallsyms]=
)
        [ffffffff99e043d0] do_syscall_64+0x170 ([kernel.kallsyms])
        [ffffffff9a8000ad] entry_SYSCALL_64_after_hwframe+0x65 ([kernel.k=
allsyms])
        [7f5b55226a41] __GI___poll+0x51 (/usr/lib64/libc-2.28.so)
        [17a4c50] time_poll+0x190 (/usr/sbin/ovs-vswitchd) timeval.c:326
        [178f683] poll_block+0x83 (/usr/sbin/ovs-vswitchd) poll-loop.c:36=
4
        [16bceb5] udpif_revalidator+0x185 (/usr/sbin/ovs-vswitchd) ofprot=
o-dpif-upcall.c:1024
        [177b71c] ovsthread_wrapper+0x5c (/usr/sbin/ovs-vswitchd) ovs-thr=
ead.c:422
        [7f5b57a66179] start_thread+0xe9 (/usr/lib64/libpthread-2.28.so)
        [7f5b55231dc2] __GI___clone+0x42 (/usr/lib64/libc-2.28.so)

I will send out the v2 soon.

>>
>> Signed-off-by: Eelco Chaudron <echaudro@redhat.com>
>> ---
>>  .../util/scripting-engines/trace-event-python.c    |   42 +++++++++++=
+++------
>>  1 file changed, 30 insertions(+), 12 deletions(-)
>>
>> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/=
tools/perf/util/scripting-engines/trace-event-python.c
>> index e752e1f4a5f0..0f392b4ff663 100644
>> --- a/tools/perf/util/scripting-engines/trace-event-python.c
>> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
>> @@ -392,6 +392,18 @@ static const char *get_dsoname(struct map *map)
>>  	return dsoname;
>>  }
>>
>> +static unsigned long get_offset(struct symbol *sym, struct addr_locat=
ion *al)
>> +{
>> +	unsigned long offset;
>> +
>> +	if (al->addr < sym->end)
>> +		offset =3D al->addr - sym->start;
>> +	else
>> +		offset =3D al->addr - al->map->start - sym->start;
>> +
>> +	return offset;
>> +}
>> +
>>  static PyObject *python_process_callchain(struct perf_sample *sample,=

>>  					 struct evsel *evsel,
>>  					 struct addr_location *al)
>> @@ -443,6 +455,24 @@ static PyObject *python_process_callchain(struct =
perf_sample *sample,
>>  					_PyUnicode_FromStringAndSize(node->ms.sym->name,
>>  							node->ms.sym->namelen));
>>  			pydict_set_item_string_decref(pyelem, "sym", pysym);
>> +
>> +			if (node->ms.map) {
>> +				struct map *map =3D node->ms.map;
>> +				struct addr_location node_al;
>> +				unsigned long offset;
>> +
>> +				node_al.addr =3D map->map_ip(map, node->ip);
>> +				node_al.map  =3D map;
>> +				offset =3D get_offset(node->ms.sym, &node_al);
>> +
>> +				pydict_set_item_string_decref(
>> +					pyelem, "sym_off",
>> +					PyLong_FromUnsignedLongLong(offset));
>> +			}
>> +			if (node->srcline && strcmp(":0", node->srcline))
>> +				pydict_set_item_string_decref(
>> +					pyelem, "sym_srcline",
>> +					_PyUnicode_FromString(node->srcline));
>
> nit missing { } for multiline if code
>

Will fix in v2
>>  		}
>>
>>  		if (node->ms.map) {
>> @@ -520,18 +550,6 @@ static PyObject *python_process_brstack(struct pe=
rf_sample *sample,
>>  	return pylist;
>>  }
>>
>> -static unsigned long get_offset(struct symbol *sym, struct addr_locat=
ion *al)
>> -{
>> -	unsigned long offset;
>> -
>> -	if (al->addr < sym->end)
>> -		offset =3D al->addr - sym->start;
>> -	else
>> -		offset =3D al->addr - al->map->start - sym->start;
>> -
>> -	return offset;
>> -}
>> -
>>  static int get_symoff(struct symbol *sym, struct addr_location *al,
>>  		      bool print_off, char *bf, int size)
>>  {
>>

