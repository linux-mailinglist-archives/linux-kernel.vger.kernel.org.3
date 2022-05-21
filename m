Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5861852FF41
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 22:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243003AbiEUUWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 16:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiEUUWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 16:22:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9FE543387
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 13:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653164532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7aIzRedNQK/WjAi9cIve+iXVnAR7Rs9ezkXRqJAQ8qc=;
        b=aCh//TtF8oJIc341nNQxMtrccLZl5a4lc2t7EW8oO+SsDcwHwQTQe0IdDaHqJ1E8ratLmw
        fX5J01uXeYMBrFD2e9IxziKwj4N0TtSsTwfCvphV56ffmh8qpf6EmPiq9sWBf6BHKCrLTM
        KF1vSTj2Lt+/6twz7iBBwhGl5ZWPRGE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-53-phPbjI9HNQmi4CJKc9rd9Q-1; Sat, 21 May 2022 16:22:10 -0400
X-MC-Unique: phPbjI9HNQmi4CJKc9rd9Q-1
Received: by mail-ed1-f71.google.com with SMTP id q12-20020a056402040c00b0042a84f9939dso7889724edv.7
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 13:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=7aIzRedNQK/WjAi9cIve+iXVnAR7Rs9ezkXRqJAQ8qc=;
        b=LA2LZ4jXROgaLgTOft/zo3YMacqwbuEfMtO3S4CF2aAFpfme4hYTPr7QD1ybRDt5eg
         QvBxo8lmpG11MgRsSO9nlUPVo0VfqaBTaUS/LjJz2r5FDWhgl96i5Iny70UP+h5uPgmd
         0bPjAedG/nBBdxInHwp0RLBCDRbai6F2vzOLxY/fOvmffaCN1KBiLmm8eJTmayGFX2xC
         01nJw/85OLvFCzhcGfOiROEs4W25vezLwMZn9hw97y23/MIwjMvEfGgkuqPDr0EwLNVx
         Q5unSSDUxf3PPZPiUjzGoUx9bgyjDjgUEsiyNCAPISq00zAimsT3WClAnKc4wOgybDFn
         qgUA==
X-Gm-Message-State: AOAM531tTMaRN+Nz6Xm9NlEqX9xmeVPStB76u70uEofPzsX7IenLc/TI
        xR9b2jVSfYyeu0skpLu0BupBg3KdWVF/yEaH8SrktZgj7YXiC8rWiF2HMD9dHfEqrT/7f31a0f6
        O+gWKkIklGtJNSoljRacvXjPx
X-Received: by 2002:a17:907:a089:b0:6f4:a99c:8e05 with SMTP id hu9-20020a170907a08900b006f4a99c8e05mr14309549ejc.31.1653164529435;
        Sat, 21 May 2022 13:22:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyj3lqwcJp5KL/sjnqTb4CYPqgoWP4iV9pJIdgaSMkNYgM6HoNUcTjp/+fvkTPJoCVpPLJmTg==
X-Received: by 2002:a17:907:a089:b0:6f4:a99c:8e05 with SMTP id hu9-20020a170907a08900b006f4a99c8e05mr14309532ejc.31.1653164529178;
        Sat, 21 May 2022 13:22:09 -0700 (PDT)
Received: from [172.29.4.249] ([45.90.93.190])
        by smtp.gmail.com with ESMTPSA id w9-20020aa7d289000000b0042ae2d4e2f2sm5921129edq.86.2022.05.21.13.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 13:22:08 -0700 (PDT)
Message-ID: <d4716615-fbac-9d93-c386-e47385e85bef@redhat.com>
Date:   Sat, 21 May 2022 22:22:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Chih-En Lin <shiyn.lin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Suren Baghdasaryan <surenb@google.com>,
        Colin Cross <ccross@google.com>,
        Feng Tang <feng.tang@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mike Rapoport <rppt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Daniel Axtens <dja@axtens.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        linux-kernel@vger.kernel.org, Kaiyang Zhao <zhao776@purdue.edu>,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Jim Huang <jserv.tw@gmail.com>
References: <20220519183127.3909598-1-shiyn.lin@gmail.com>
 <d1810538-9b4c-7f19-852f-7f6d255533c7@redhat.com>
 <YolHr1GwfA++i9jj@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 0/6] Introduce Copy-On-Write to Page Table
In-Reply-To: <YolHr1GwfA++i9jj@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.05.22 22:12, Matthew Wilcox wrote:
> On Sat, May 21, 2022 at 06:07:27PM +0200, David Hildenbrand wrote:
>> I'm missing the most important point: why do we care and why should we
>> care to make our COW/fork implementation even more complicated?
>>
>> Yes, we might save some page tables and we might reduce the fork() time,
>> however, which specific workload really benefits from this and why do we
>> really care about that workload? Without even hearing about an example
>> user in this cover letter (unless I missed it), I naturally wonder about
>> relevance in practice.
> 
> As I get older (and crankier), I get less convinced that fork() is
> really the right solution for implementing system().

Heh, I couldn't agree more. IMHO, fork() is mostly a blast from the
past. There *are* still a lot of user and there are a couple of sane use
cases.

Consequently, I am not convinced that it is something to optimize for,
especially if it adds additional complexity. For the use case of
snapshotting, we have better mechanisms nowadays (uffd-wp) that avoid
messing with copying address spaces.

Calling fork()/system() from a big, performance-sensitive process is
usually a bad idea.

Note: there is an (for me) interesting paper about this topic from 2019
("A fork() in the road"), although it might be a bit biased coming from
Microsoft research :). It comes to a similar conclusion regarding fork
and how it should or shouldn't dictate our OS design.

[1] https://www.microsoft.com/en-us/research/publication/a-fork-in-the-road/

-- 
Thanks,

David / dhildenb

