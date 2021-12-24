Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8A347ECC7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 08:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351881AbhLXHia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 02:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343542AbhLXHi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 02:38:29 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A32C061759
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 23:38:29 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id h6so2281339plf.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 23:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=H4F2V9c1PkaLdgAGnpv/RVBL4kcIo1QcKpTTOJdHTl8=;
        b=5g17BbspCXEjkr/biCb9GIUQZp6ikmFHO9oQ7M9syNHod4TQPjy9KgaAhfyp/pDYIa
         6wo2jxDJH3sf7U3taB21xkPkZSbbdsSwjAOUj9X7pB/QlqFk1T0w7gK7VFiBNxH3MPie
         gONr5XgIk7HlnswoqMwk+Vv9I5sgS+KnP+sSMcKHAyulFhOp6DQbTpeTAlq7q22t7Pey
         vukNgxmR/vobRl9HgrXSxUfL6OTROePcoqXiJdOn/SwZu/YfnBem7RCzpBJqiAoAoTyR
         /D89UkytgMOKtDiP26wuFbGfatHXwL0EJp+2Ffpr/GrLOleRBiitmofzKape974xNi6M
         J8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H4F2V9c1PkaLdgAGnpv/RVBL4kcIo1QcKpTTOJdHTl8=;
        b=XlggDDTsvYNJ+7v6QnN/E6aX7wyjEmapcOKS3OukWvm7qH0wRJMypz/fiCwjIdb+wk
         L46ZXpczidVjop/SoSAjlJaWrNAEAV0BrW/kCPiDY9vzpW8HbOMg9wapCFuq+kU9plZs
         J6lMZgqjBVgiuiYdGVgQgHSEnWjDm2W36Noo6nytIwAp76Cyu/C+TeXxyS1ZeE+pqPrA
         AD+hGKK36cyaYKQpK8F2feenSE6iStDzmog6MnQm27ow/QJ9hoqNpnXxkG4j/wTai13r
         HTsv732T3Xkjwslzku6rAXANWBIhglv//od+845QAC9mf4yG2nUxB1UtpF1CqImIozKZ
         kykQ==
X-Gm-Message-State: AOAM530cP45GVtDkgBBL5wihErG2Tmw3BSKKsLMfYUs/KIN4UhGwbZHO
        aCj6zHEC3HeFwtvxNDcXpSzxlw==
X-Google-Smtp-Source: ABdhPJyAuuuagOuqWpDZBvJEssG6KbMUcW2iSpjeuECd5mLWotysn9+jj4/g+7wtBYp3NHlntU1IIA==
X-Received: by 2002:a17:902:ecc3:b0:149:5a6d:c5e with SMTP id a3-20020a170902ecc300b001495a6d0c5emr3080082plh.20.1640331508636;
        Thu, 23 Dec 2021 23:38:28 -0800 (PST)
Received: from [10.255.186.155] ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id z2sm8564478pfe.93.2021.12.23.23.38.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Dec 2021 23:38:28 -0800 (PST)
Message-ID: <5dcbb13e-322f-a8d0-3bcf-d91b72ab51b9@bytedance.com>
Date:   Fri, 24 Dec 2021 15:38:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [External] Re: Fix repeated legacy kprobes on same function
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Qiang Wang <wangqiang.wq.frank@bytedance.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        duanxiongchun@bytedance.com, shekairui@bytedance.com,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <c84094d2-75c1-a50d-ea9e-9dded5f01fb9@bytedance.com>
 <CAEf4Bza200bB3d-E3rMyxZs7wxijbzJ_0xmRSy+=tHm2Ot14Eg@mail.gmail.com>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAEf4Bza200bB3d-E3rMyxZs7wxijbzJ_0xmRSy+=tHm2Ot14Eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/24 2:57 下午, Andrii Nakryiko wrote:
> On Thu, Dec 23, 2021 at 8:01 PM Qiang Wang
> <wangqiang.wq.frank@bytedance.com> wrote:
>>
>> If repeated legacy kprobes on same function in one process,
>> libbpf will register using the same probe name and got -EBUSY
>> error. So append index to the probe name format to fix this
>> problem.
>>
>> And fix a bug in commit 46ed5fc33db9, which wrongly used the
>> func_name instead of probe_name to register.
>>
>> Fixes: 46ed5fc33db9 ("libbpf: Refactor and simplify legacy kprobe code")
>> Co-developed-by: Chengming Zhou <zhouchengming@bytedance.com>
>> Signed-off-by: Qiang Wang <wangqiang.wq.frank@bytedance.com>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> ---
>>   tools/lib/bpf/libbpf.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 7c74342bb668..7d1097958459 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -9634,7 +9634,8 @@ static int append_to_file(const char *file, const
>> char *fmt, ...)
>>   static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
>>                                           const char *kfunc_name, size_t
>> offset)
>>   {
>> -       snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx", getpid(),
>> kfunc_name, offset);
>> +       static int index = 0;
>> +       snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx_%d", getpid(),
>> kfunc_name, offset, index++);
> 
> BCC doesn't add this auto-increment (which is also not thread-safe)
> and it seems like that works fine for all users.
> 

Yes, BCC has the same problem, we will send a fix patch to BCC later.
We thought libbpf was used in single-threaded environment, so will
change to use __sync_fetch_and_add() to keep thread-safe. Thanks for
pointing this out.

> What is the use case where you'd like to attach to the same kernel
> function multiple times with legacy kprobe?
> 

We used many different BPF modules writen by different people in one
monitor process to analyze all data, there maybe repeated legacy kprobes
on the same function. So we want to add a unique index suffix to support
this use case.

>>   }
>>
>>   static int add_kprobe_event_legacy(const char *probe_name, bool retprobe,
>> @@ -9735,7 +9736,7 @@ bpf_program__attach_kprobe_opts(const struct
>> bpf_program *prog,
>>                  gen_kprobe_legacy_event_name(probe_name,
>> sizeof(probe_name),
>>                                               func_name, offset);
>>
>> -               legacy_probe = strdup(func_name);
>> +               legacy_probe = strdup(probe_name);
> 
> please send this as a separate fix
> 

Ok, will do.

Thanks.

>>                  if (!legacy_probe)
>>                          return libbpf_err_ptr(-ENOMEM);
>>
>> --
>> 2.20.1
>>
