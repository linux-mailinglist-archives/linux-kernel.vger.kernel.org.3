Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A434502FB5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 22:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351793AbiDOUVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 16:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351798AbiDOUUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 16:20:55 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F6FDE932
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 13:18:21 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id v133so4311310vsv.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 13:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cbb1YDb5NaiuUde42DTRSKAfH6XbrCM5Doeox4W/L1U=;
        b=R+fWKSybpUALXVyi7dr5ULcwrcaXsKRmDx3orLXnDSP1dKdn6sslxaR84/Vt1idESV
         R0gbbnc2Eo5O2hvxGNOm5+O5l7zO9r5grwhRC/H1pjlfnAengg/oNlV3PjITQ52N9xvj
         ttmr00bahnI6zPcHkkGyVH85UyIFb3BiDQXe1wN6D7t4+4SOidckXgXl4WmZtYM9G8g/
         aed3/o6NSjZAcWDOvNGsi7PFryJv2kBPX+cLbidK7S7FBT3z2r51EStnpXahSrD5q8Gs
         bTdzVJmEmNuyfh9W4BKstW6XQcg/tnhQUf9CLonBDa0jnHYmD9BzjVmbUocVwfvlS2tZ
         ESWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cbb1YDb5NaiuUde42DTRSKAfH6XbrCM5Doeox4W/L1U=;
        b=pqOavZBdCec2Q9DCwM4X/hD6LvYbvO68mPFsVoOzEc7nHrQ6Km3WVZVCeGl80A+tc2
         k/5l74hhcdsvP392PhCEHDQykQeqOaUra2+rIWU7RMeOdrwHQFrCGreNfX8NQ+yYmMDp
         aZlXqW5LvDUPk5HWqe0MPUEmXQBkP3AuiW5B/EX3DWui8eejmWUFxX6IhxyGzVLjiQRY
         hPQGBZUI6Q/mlRwFUwOoZ5DNrhs26xLQeLkEb9/F6N1iyG94xNlrVnOSEZ1qf36bw6mO
         4g39K/6aQgtL2zY8G2xp2okXJvrDAgmxwV37asT3DxeHIE7Vjivh0TYCI5QkCyiE3BGw
         6BIQ==
X-Gm-Message-State: AOAM531DfJcsgSjIScSuDWwPOdofVr+AFlKiR8vhSb7jahJjNElK0lr1
        HRNbxOHp9F9aeeFGpRyl6QscxI4FrdjMGQajJ+oKpw==
X-Google-Smtp-Source: ABdhPJwO94bILh3nEx3+nxP4ZO5hEG2ftNGY6x330YGarczURLY5R/Y+L+rCRpLt0Wpji7SMuT9MzVQDZVeugH9nIdA=
X-Received: by 2002:a67:de17:0:b0:32a:4007:cd86 with SMTP id
 q23-20020a67de17000000b0032a4007cd86mr220678vsk.22.1650053900285; Fri, 15 Apr
 2022 13:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220407031525.2368067-1-yuzhao@google.com> <20220407031525.2368067-7-yuzhao@google.com>
 <CAGsJ_4xqm4L4E4dW4PPHos8Ed9ej6hph28tSGy21Re3u7WiuOA@mail.gmail.com>
 <YliFs3NOHeo2LeXl@google.com> <20220414143959.0daf4534613f2511b9b27f11@linux-foundation.org>
 <CAGsJ_4ymn55eEkmSh5nBkoHcazHxuTBO6wtPJ0C+xE8WB+jqLg@mail.gmail.com>
In-Reply-To: <CAGsJ_4ymn55eEkmSh5nBkoHcazHxuTBO6wtPJ0C+xE8WB+jqLg@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 15 Apr 2022 14:17:43 -0600
Message-ID: <CAOUHufY5EeXAn-H_A0V0rzwJOzMs+6cbbmjpxL1Yxrp7msiJog@mail.gmail.com>
Subject: Re: [PATCH v10 06/14] mm: multi-gen LRU: minimal implementation
To:     Barry Song <21cnbao@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@rothwell.id.au>,
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 4:16 AM Barry Song <21cnbao@gmail.com> wrote:
>
> On Fri, Apr 15, 2022 at 9:40 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Thu, 14 Apr 2022 14:36:03 -0600 Yu Zhao <yuzhao@google.com> wrote:
> >
> > > > or it is only something
> > > > meaningful for the internal code?
> > >
> > > This is how swappiness is interpreted.
> > >
> > > > if so, can we rename it to
> > > > something else? otherwise, it is quite confusing.
> > >
> > > Feel free to suggest something.
> >
> > It is confusing,   swap_preference?
>
> seems to be much better. might also be worth using MACRO to replace those
> 1, 200, 0 magic numbers  to tell readers the exact meaning?

How do you read "swap_preference=0"?

I read it as "no (swap) preference", which means anon and file are
equal. The real meaning though, is "don't swap"; and the "no
preference" value is actually 100.
