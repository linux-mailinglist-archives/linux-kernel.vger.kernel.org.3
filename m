Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170D550280A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 12:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352159AbiDOKSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 06:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344860AbiDOKSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 06:18:31 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F9E47067;
        Fri, 15 Apr 2022 03:16:03 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id k23so14671178ejd.3;
        Fri, 15 Apr 2022 03:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=isTdaKobIfw71vhVrWliledBvPWOo0t2AS4RMsJHhgw=;
        b=VojlBmOs7qhrPLjvBT58iz2RSikqaqngUp0thmoO0BrOKKvxGEcdaET1fQ4+qoAcgn
         wjJCU0JQ2q6uTuwg8ry+hQHp+25Gm+CW39abzWign/R5aY5PEckMm5LH2u7XepLGPknN
         WZinzb1UPdKxzdHiPemWbLb4RaZhe65B/6ZGLbPin/vigUjKbhUajeWXSwNrY/b7rf2V
         dI/+EJhDOQ+wn1JfdAQIlNjLkqBdqg0Iv/GK24ZpTgDjmw5zdhXnOUYE38UleN/WhHaA
         e5irtprXsvMP1VMv1U7incWvDTFHbd4avKLigZC9Iw1eYCZh7u4K+UIHoXORE8OG/M26
         1nLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=isTdaKobIfw71vhVrWliledBvPWOo0t2AS4RMsJHhgw=;
        b=xJb4mFbeGEqPhmmnG60VebxWM7FDCGaJbVT/VbypOL1rPP2FFiBlHexCnfX1rzi2vc
         Q88Nu4FDngxN4ThrWVLccfhCLVRv5QSV06HD8OGQ0YEKZR8DR//VUrQ76nVXm9TwicPn
         l9sTq/JiX39bi5zcqbHA+fqpGJ07kL64awyBPLkQzdoK3ivqjq40z+0/BTw6+fbm9jp6
         5taba3Zg7wFHOLaZ7TrC3/qb923vav3EMPP2qRwdCMtCCwQWlutNQFYwxZpgJmo/GwK8
         jjSuLC2Vryr/ZJW8gEPu2tcRJPX7rN6YXrl+sMJqgwJvyc+QLMWBf4sybPDk2KfLBOOM
         8Zdg==
X-Gm-Message-State: AOAM5304IGZmnCMWCX/SkXkRgyzei+/OYF5KEi2yQ3MLc91pLCarUWg1
        zgjnTNnI0JPvNJKfW+n7qVqsKhkfeO6nGzwZ04M=
X-Google-Smtp-Source: ABdhPJyLCZsI7fVraonfF0F+ehCoQyH2DCXZkx6+1XCDfSBeo4O7J2luzopYDAGCrcw8pNEf+1NRHyyIfn3f38d8GQo=
X-Received: by 2002:a17:907:2d23:b0:6e8:807c:cd94 with SMTP id
 gs35-20020a1709072d2300b006e8807ccd94mr5588243ejc.502.1650017761992; Fri, 15
 Apr 2022 03:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220407031525.2368067-1-yuzhao@google.com> <20220407031525.2368067-7-yuzhao@google.com>
 <CAGsJ_4xqm4L4E4dW4PPHos8Ed9ej6hph28tSGy21Re3u7WiuOA@mail.gmail.com>
 <YliFs3NOHeo2LeXl@google.com> <20220414143959.0daf4534613f2511b9b27f11@linux-foundation.org>
In-Reply-To: <20220414143959.0daf4534613f2511b9b27f11@linux-foundation.org>
From:   Barry Song <21cnbao@gmail.com>
Date:   Fri, 15 Apr 2022 22:15:50 +1200
Message-ID: <CAGsJ_4ymn55eEkmSh5nBkoHcazHxuTBO6wtPJ0C+xE8WB+jqLg@mail.gmail.com>
Subject: Re: [PATCH v10 06/14] mm: multi-gen LRU: minimal implementation
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yu Zhao <yuzhao@google.com>, Stephen Rothwell <sfr@rothwell.id.au>,
        Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        x86 <x86@kernel.org>, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 9:40 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 14 Apr 2022 14:36:03 -0600 Yu Zhao <yuzhao@google.com> wrote:
>
> > > or it is only something
> > > meaningful for the internal code?
> >
> > This is how swappiness is interpreted.
> >
> > > if so, can we rename it to
> > > something else? otherwise, it is quite confusing.
> >
> > Feel free to suggest something.
>
> It is confusing,   swap_preference?

seems to be much better. might also be worth using MACRO to replace those
1, 200, 0 magic numbers  to tell readers the exact meaning?

>
>
Thanks
Barry
