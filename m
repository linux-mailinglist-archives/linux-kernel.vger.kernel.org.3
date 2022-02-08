Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E242F4AE4A8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238700AbiBHWfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387104AbiBHVyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 16:54:18 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22F6C0612B8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 13:54:17 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id m14so678964wrg.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 13:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6Tm54El4HG7MbazohS8siU71VWTG6xnBb2XoAa6UZG8=;
        b=WbDthJ6/QLp/2khpvtMQqH10fgL1FhdoAlU46ZUezg+6dTNBtmPxn2z+zrRjm6R6yo
         y04zq/Ok0w9T3KibOozvWQxhvoO+L+RrTG1cCaSzlAkuVtQ8BHt7RqOjtcppt5UV4QpI
         l0u+sVRJ6qRYHcBuGtlVrTsAPuf0U0DGuPM/OtnBbtwS8KxygL/iaIAc2GmEW8meltBI
         q68fhJcFKgjkG3A1YLiB3EdynX2gw8rHqIngqd81fzwi2A9eTkQg5eRuNwQ9qsCFf6fS
         BGDag5u/1PAvqOvXgSb6gRE5ol+VqBQ0XRrgQVCFXq+WMIAvsBjxsq9cSxD3LFRBPctY
         a4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6Tm54El4HG7MbazohS8siU71VWTG6xnBb2XoAa6UZG8=;
        b=I+zaaFvBn3cvJJ9yiANI08SNaEOnEPQCD0jzLPZdSTLAOz5cvp5j81UdI4CFpu4bFo
         xu+PM6L7SusSCt+MpK479lRe2XhiK8cQ/VqqrPeORVqo1tat+7X+RXOxH+/RBMRlO2db
         i06vNw7YghhS571JkDQuShZdsRRTaEP2Is4FbWrOqz01fETNZ6quNGNau/6CAeuSdkgt
         N/AuRxzHxB2hn9Y1xR5kvHr6kQ/YoyddkY6Df0NMqn153ZVz2ON0CHgS3ALerKQgoxdd
         JE44q9SVd1WiOogzRalvKBRaIxsII4EK57HD2uB4WOu88X7BDRjPywPBK32sQPvrLnfg
         ZhKQ==
X-Gm-Message-State: AOAM531ZZrOI/xKfXdLinXtM1AT0Ist/ciEp+aNSGYCZrXZf96fgSwpg
        y7GyEfa52GF0HUrMqapun4k=
X-Google-Smtp-Source: ABdhPJwKTpxEDTXiUWsIMqoHyl0shrIjobidDJyAhFg2QydltV/HztdOYyBPdQ29J8eYingZKkReOA==
X-Received: by 2002:a05:6000:1189:: with SMTP id g9mr117534wrx.482.1644357256336;
        Tue, 08 Feb 2022 13:54:16 -0800 (PST)
Received: from ?IPV6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l10sm16578832wry.79.2022.02.08.13.54.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 13:54:15 -0800 (PST)
Message-ID: <a4865e63-4778-d701-f902-2753cb862077@gmail.com>
Date:   Tue, 8 Feb 2022 21:54:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
Content-Language: en-US
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Adrian Reber <adrian@lisas.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <YgAWVSGQg8FPCeba@kernel.org> <YgDIIpCm3UITk896@lisas.de>
 <8f96c2a6-9c03-f97a-df52-73ffc1d87957@intel.com>
 <YgI1A0CtfmT7GMIp@kernel.org> <YgI37n+3JfLSNQCQ@grain>
 <357664de-b089-4617-99d1-de5098953c80@www.fastmail.com>
 <YgKiKEcsNt7mpMHN@grain>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
In-Reply-To: <YgKiKEcsNt7mpMHN@grain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[un-Cc'ed a lot of people, as the question is highly off-topic, so I
don't feel like the answer is of big interest to them, keeping x86
maintainer in]

On 2/8/22 17:02, Cyrill Gorcunov wrote:
> On Tue, Feb 08, 2022 at 08:21:20AM -0800, Andy Lutomirski wrote:
>>>> But such a knob will immediately reduce the security value of the entire
>>>> thing, and I don't have good ideas how to deal with it :(
>>>
>>> Probably a kind of latch in the task_struct which would trigger off once
>>> returt to a different address happened, thus we would be able to jump inside
>>> paratite code. Of course such trigger should be available under proper
>>> capability only.
>>
>> I'm not fully in touch with how parasite, etc works.  Are we talking about save or restore?
> 
> We use parasite code in question during checkpoint phase as far as I remember.
> push addr/lret trick is used to run "injected" code (code injection itself is
> done via ptrace) in compat mode at least. Dima, Andrei, I didn't look into this code
> for years already, do we still need to support compat mode at all?

Cyrill, I haven't been working on/with Virtuozzo people last 5 years, so
I don't know. As you're more connected to Vz, your question seems to
imply that ia32 C/R is no longer needed by Vz customers. If it's not
needed anymore - I'm all for stopping testing of it in CRIU.

The only thing I ask before you go and remove that is to ping the person
who paid some substantial amount of money on bugsbounty to get ia32
support in CRIU. Albeit, in the end I didn't get a cent out of it (VZ
managers insisted on receiving all of the money), I still feel
responsible to that person as the amount he paid was the biggest bounty
at that moment and I was the person, who presented him ia32 C/R as
working and being tested.
If you need his contacts - ping me, I'll search and find it.

Other than that - if no one needs ia32 C/R, let's do go ahead and drop
testing (and maybe some complicated code) of it.

Thanks,
          Dmitry
