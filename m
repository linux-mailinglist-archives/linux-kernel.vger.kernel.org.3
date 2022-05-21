Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BCB52FEE8
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 21:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240194AbiEUTJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 15:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344530AbiEUTJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 15:09:10 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237FE5997A
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 12:09:09 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id a38so7509020pgl.9
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 12:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oaRVpI7UKaHjd1HJ1AVlpEJxbT5arsQ6w+vrWxbxyBc=;
        b=QjeiO2j0PR+bAuyDJSqF15ySQ1DB9sPlRCiEHvyGkkNQOmuBfa8Qcd2TKibjVgehgj
         GHud8shaYCMMfDYGPXwc/TB2IUe1PuQU21YVJ6nniNXm63Ra9idXakDMhYQ2nWrxpdCQ
         OB3mD4diRV1Q1fISK9EkJdxpmtHAl42xa+aaF4W0ZTR9Otovkc23b9eZolNW1KbGqBGR
         nGzZJJEkhPCBKIruDE9S27ibpupAVpxvme3IsQWhG94z+i/Gat1ANKMSLLsMxOoW1RPq
         LHZzB96fLfe2QvY4AuHtVnWeIFfknkrCwJtTckuLeEF5NklQ6xR83pu6ofh/6PMJ+uOK
         hpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oaRVpI7UKaHjd1HJ1AVlpEJxbT5arsQ6w+vrWxbxyBc=;
        b=lkX6fn0vs5fj6L0guUvl0RYMSNeqPnObNEpxJkPaWcxKeUEMmPWuJIiT+sHRaW7nxf
         v0gS3huD/fEoLLFwuqyEqGECW1CAXKDxLV4ARg+p5ZR7DuZdjvb+A1FkCZYjQVmpNVze
         5vzkM5hYuJbgu73ODK3mtqpqYyDs5wZia3PIe9riW6lQR+3vYi4skrYpE587eFOm/MJx
         tfxBX2uRCCIEggu7Kl5HJp5LJic+Znoldzv0UN5NWs1PcLGVqwMQTXUiQE6zMIVw3ppo
         K++7dWcMx3WLe2z5Sr1YO5kZMLK6IIhDdbvKrvh3Vm2y2/NU3Kv+ahTfVJpobgdmvA+m
         y39A==
X-Gm-Message-State: AOAM530j47qVo2bnjH8yI1fK6IcNQ6xO4RTHT+0JD1M5aaDBa4aOrZ5/
        /gkmrIiWplzbEHH21sugoag=
X-Google-Smtp-Source: ABdhPJzp0ax3vDQvWbw9hzTH2DploUMC323OlGwE4au2JvTYsmhwhQ+S2X3uHGw7ahxTgjXRU9KoCg==
X-Received: by 2002:a05:6a00:178c:b0:518:86a0:3deb with SMTP id s12-20020a056a00178c00b0051886a03debmr3127347pfg.64.1653160148593;
        Sat, 21 May 2022 12:09:08 -0700 (PDT)
Received: from strix-laptop (2001-b011-20e0-15d4-84b3-8c62-a0b8-199e.dynamic-ip6.hinet.net. [2001:b011:20e0:15d4:84b3:8c62:a0b8:199e])
        by smtp.gmail.com with ESMTPSA id w5-20020a1709027b8500b001619fbb0e6dsm1959649pll.40.2022.05.21.12.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 12:09:08 -0700 (PDT)
Date:   Sun, 22 May 2022 03:08:59 +0800
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
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
        Jim Huang <jserv.tw@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [External] [RFC PATCH 0/6] Introduce Copy-On-Write to Page Table
Message-ID: <20220521190859.GA1551274@strix-laptop>
References: <20220519183127.3909598-1-shiyn.lin@gmail.com>
 <f9ccf33b-c81c-6b25-6471-80c600f06732@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9ccf33b-c81c-6b25-6471-80c600f06732@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 04:59:19PM +0800, Qi Zheng wrote:
> Hi,
> 
> To reduce the empty user PTE tables, I also introduced a reference
> count (pte_ref) for user PTE tables in my patch[1][2], It is used
> to track the usage of each user PTE tables.
> 
> The following people will hold a pte_ref:
>  - The !pte_none() entry, such as regular page table entry that map
>    physical pages, or swap entry, or migrate entry, etc.
>  - Visitor to the PTE page table entries, such as page table walker.
> 
> With COW PTE, a new holder (the process using the COW PTE) is added.
> 
> It's funny, it leads me to see more meaning of pte_ref.
> 
> Thanks,
> Qi
> 
> [1] [RFC PATCH 00/18] Try to free user PTE page table pages
>     link: https://lore.kernel.org/lkml/20220429133552.33768-1-zhengqi.arch@bytedance.com/
>     (percpu_ref version)
> 
> [2] [PATCH v3 00/15] Free user PTE page table pages
>     link: https://lore.kernel.org/lkml/20211110105428.32458-1-zhengqi.arch@bytedance.com/
>     (atomic count version)
> 
> -- 
> Thanks,
> Qi

Hi,

I saw your patch a few months ago.
Actually, my school's independent study is tracing the page table. And
one of the topics is your patch. It is really helpful from your pte_ref.
It's great to see you have more ideas for your pte_ref.

Thanks.
