Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4388F586D7B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 17:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbiHAPP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 11:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiHAPPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:15:24 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E8E2DDD
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 08:15:22 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id c22so5945003wmr.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 08:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=96Xr7qKz5ack5qH/ZGABDE9Es1mQum1SPPmyZMWuVb0=;
        b=NRhLsGGK9Cp2XRhXOyFF3HEayo/v7taBs96mDKbEh1gDPfUlLRSdoaNh6+nrIF1KpJ
         xplCj6HcLU0Twzjx6x8Q5IOj6N8bEuYoEOJ0c/uDYXn+/ckynObmvfjKCC01Kh7wMHVz
         tnBiS2B2UVA/yAa9t0a20++GRUwxBT57koZKqm5F9/k5KANyvg6F7C1QkAzCNloJNlGE
         3YP9PdPehgqmaIJCt93/jRl58Ypa7Tn5XMzKOHbN+Zu6+R8UM44PXfGBrnVwUEc89Tdy
         jIKCYNE36qaL0LB2lqYML1GYsCiuVKYPxR0PWx0bAQkWu1P66IUGT0UbeX7tR8F8yPDm
         pRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=96Xr7qKz5ack5qH/ZGABDE9Es1mQum1SPPmyZMWuVb0=;
        b=1qf7JTGtfhlygXAiEO1EHGupWii+l+CSNViEJUgE4UsuDoDMHJ0L6dpVIlWvZMMBHb
         8LrYouFW3kkengFaExVO7BD1lA5mxsbSyFxJ+WgSvQavQWkiWqkGVMlI7DL9FcnnabFA
         qbDauhQA1jXKschqDzSj49ZS52Nuvgu0ic6uNqNtIieSNz6FqXZyw0ok3z4uY7M6+6dM
         2fIbcVv+QEYFkbCDU6Gg8RpdC3OyOSeD2YSHdkAvP8lxWRPgBV9rSr/6/4ubq62LNl25
         RDajBt3EjFzWAis7GZGSUcEjMIJSMny1NobM3TG+rVgFF5uNyaO99Qh/bBDyViOlUlEB
         OHZA==
X-Gm-Message-State: AJIora83FjI5+pWMfVQnZbKXsJpF1VSJPwv5UdiFs8dS0qFjUs9doIgl
        eddXjLaiz0ujk57yPYwqLmkQTg==
X-Google-Smtp-Source: AGRyM1t/z4itj1Q7sE4GtvJZ8Pg3VaUy4jflIEoi7u0f7v5OXJ8B0TFjW4P6WktF0+sXnyUGqjfK0w==
X-Received: by 2002:a05:600c:2906:b0:3a3:81a1:34fe with SMTP id i6-20020a05600c290600b003a381a134femr11304110wmd.162.1659366920747;
        Mon, 01 Aug 2022 08:15:20 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id w13-20020adfee4d000000b0021f0af83142sm11811289wro.91.2022.08.01.08.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 08:15:20 -0700 (PDT)
Message-ID: <ce9140c7-dd4b-0c4e-db7c-d25022cfe739@isovalent.com>
Date:   Mon, 1 Aug 2022 16:15:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v3 0/8] tools: fix compilation failure caused by
 init_disassemble_info API changes
Content-Language: en-GB
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andres Freund <andres@anarazel.de>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Ben Hutchings <benh@debian.org>
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
 <20220801013834.156015-1-andres@anarazel.de> <YufK0qnvVWCAFGEH@kernel.org>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <YufK0qnvVWCAFGEH@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2022 13:45, Arnaldo Carvalho de Melo wrote:
> Em Sun, Jul 31, 2022 at 06:38:26PM -0700, Andres Freund escreveu:
>> binutils changed the signature of init_disassemble_info(), which now causes
>> compilation failures for tools/{perf,bpf} on e.g. debian unstable. Relevant
>> binutils commit:
>> https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=60a3da00bd5407f07
>>
>> I first fixed this without introducing the compat header, as suggested by
>> Quentin, but I thought the amount of repeated boilerplate was a bit too
>> much. So instead I introduced a compat header to wrap the API changes. Even
>> tools/bpf/bpftool/jit_disasm.c, which needs its own callbacks for json, imo
>> looks nicer this way.
>>
>> I'm not regular contributor, so it very well might be my procedures are a
>> bit off...
>>
>> I am not sure I added the right [number of] people to CC?
> 
> I think its ok
>  
>> WRT the feature test: Not sure what the point of the -DPACKAGE='"perf"' is,
> 
> I think its related to libbfd, and it comes from a long time ago, trying
> to find the cset adding that...
> 
>> nor why tools/perf/Makefile.config sets some LDFLAGS/CFLAGS that are also
>> in feature/Makefile and why -ldl isn't needed in the other places. But...
>>
>> V2:
>> - split patches further, so that tools/bpf and tools/perf part are entirely
>>   separate
> 
> Cool, thanks, I'll process the first 4 patches, then at some point the
> bpftool bits can be merged, alternatively I can process those as well if
> the bpftool maintainers are ok with it.
> 
> I'll just wait a bit to see if Jiri and others have something to say.
> 
> - Arnaldo

Thanks for this work! For the series:

Acked-by: Quentin Monnet <quentin@isovalent.com>

For what it's worth, it would make sense to me that these patches remain
together (so, through Arnaldo's tree), given that both the perf and
bpftool parts depend on dis-asm-compat.h being available.

Quentin
