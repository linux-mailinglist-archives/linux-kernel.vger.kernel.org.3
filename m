Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DF54E8433
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 21:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbiCZUgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 16:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiCZUgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 16:36:31 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F4B40939
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 13:34:54 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y10so12792863edv.7
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 13:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q3ovlUP9oP3KOPVRzS2l45i5ewEnSWL0JFQ06/HulGU=;
        b=EmBMPQsMUA/1s+ovtWl8b3YvOukUQkZ8xl1UXloUpExBp4rGI43A1Je+tUV+cRKiCs
         MZXcIt7SEOhjabvrFz2BkMNoPF+8JlbkcPB2EVhcnkKiGSmZBXbDrviIJkNTfaxbNUlO
         hDoO/biIc7wr4gpcE+jcufS7I4ZTgOMJ2mfcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q3ovlUP9oP3KOPVRzS2l45i5ewEnSWL0JFQ06/HulGU=;
        b=U1yKMtB1kiokGPDmBmT4JRgS4qaBXsGqQpgwaUrVwzXkE38/qxYm25xPo1rKPcibQC
         ms+QqfncQmm2Mo6W2L4fhKbK3XHLJYx2EKZTR9YfS344IkNeTALMWkcIN/BYPtarSSRD
         ajNgx/bmNsdMGcXDO7LrfNBdd2DsiISC+u0NMbF68W/UKVKL4fc9UW1k2chYyEn6fH7n
         Ly7JvSQ4ma/KVr546bRrmZZQtFGRJrfiR8QzQwGlTnLMWmaP1WlLHGs/I/5qkAZYeujC
         DiRaWBhSJSwhLoLS+r8/dsLQLxwkgs+/M8Bvl3o/NuKoHmrgWi5EQS/bYwMRL8kk+jLs
         A6/g==
X-Gm-Message-State: AOAM532d9J7FX2GfAMBUm/l55q0e/P3I9ybvUP29emBA+P2ZgHXiGIvZ
        TdQzipcU132zK1jiC+duMsE1m8J6coxK6g23Bdo=
X-Google-Smtp-Source: ABdhPJxjRtU/Xrq5vgm7q+jqjKthyizMZGzzaXfYAKUdji7zmbFQutCPPNEfaNfXDiKNz4Azl5qWrQ==
X-Received: by 2002:a05:6402:2747:b0:419:4817:ba22 with SMTP id z7-20020a056402274700b004194817ba22mr6552472edd.253.1648326893346;
        Sat, 26 Mar 2022 13:34:53 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id u5-20020a170906b10500b006ce6fa4f510sm3891786ejy.165.2022.03.26.13.34.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Mar 2022 13:34:53 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id bq8so7501408ejb.10
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 13:34:52 -0700 (PDT)
X-Received: by 2002:a05:6512:3d8f:b0:44a:2c65:8323 with SMTP id
 k15-20020a0565123d8f00b0044a2c658323mr13197197lfv.52.1648326480783; Sat, 26
 Mar 2022 13:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220326010003.3155137-1-yuzhao@google.com> <CAHk-=wjp=jEhjvD9GPnHfuV5Kc1=rUnf84b_qscLJ8fkY74u3Q@mail.gmail.com>
 <CAOUHufbqum18T4kZ=d_hMehz=N=3iSuNfGrLof5tB8kjGkk8yw@mail.gmail.com>
In-Reply-To: <CAOUHufbqum18T4kZ=d_hMehz=N=3iSuNfGrLof5tB8kjGkk8yw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 26 Mar 2022 13:27:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbdpeeKbCYggJqfk0ExEPyxSW-yXSsNUqsGpd5ozt-Kg@mail.gmail.com>
Message-ID: <CAHk-=whbdpeeKbCYggJqfk0ExEPyxSW-yXSsNUqsGpd5ozt-Kg@mail.gmail.com>
Subject: Re: [page-reclaim] Re: [GIT PULL] Multi-gen LRU for 5.18-rc1
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <baohua@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Donald Carr <d@chaos-reins.com>,
        Hillf Danton <hdanton@sina.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Rik van Riel <riel@surriel.com>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 6:16 PM Yu Zhao <yuzhao@google.com> wrote:
>
> No. I could ask Stephen to see if he is willing to take this series. I
> was hoping to go through Andrew since his tree is what most MM
> developers test. I haven't heard from Andrew, so I assume he has no
> strong opinion and I don't want to put him in a different position.

So I'd definitely want to see this in linux-next for a while, which
implies it's not ready for this merge window.

I'm not convinced linux-next sees a lot of runtime testing (but it
gets *some* of that too, certainly), but it does get a fair amount of
at least build verification with a lot of odd configurations and a lot
of different architectures.

                Linus
