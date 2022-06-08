Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7546354381C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 17:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244533AbiFHPwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 11:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244444AbiFHPwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:52:12 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16B0200145
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 08:52:10 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id y19so42312287ejq.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 08:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZWg+EByLX2ZJm6vETAdONT4qynX6hRsnoJ5CqHfmhnw=;
        b=RIC59qPhiDzIZcT8mYyjAWaAQYTLQ7GhRgZF/6BRjG+QgO5oJlG53QfqIVGPQr43sM
         mFzgNuQm3ojwsX+1IRo9briF7hE+utjRHjinwFhHpgE88u2jNmmweoRbMO1shu19pMzO
         26zbeFKBWGXTcj7YREyPZa6Ia1w4WYPW6e3E4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZWg+EByLX2ZJm6vETAdONT4qynX6hRsnoJ5CqHfmhnw=;
        b=qq4y+GJlaN7PtDP7nyjvdKGJ9ak9a80Qj/ADXq3vnxsEIzDXGH7mJkXPGWnsvoshwD
         Kb+f9RP0KhaiTEs1tjccXnLBEdKHVnKhDXcbJ7lGR/mwU4KPdc48WGlTemQlgDaUCo/X
         gRqVOJHAEkwB+b3VyOkA+6wQZXuVlyDS2b/PTrmYzUewGb/sfopQEmv5zhDoFhjea6a2
         Wuno+CUXvgykDCtiddJZstMeeDyPfntG3utW7V4LEfTJomHx6Dl+5azFdmKlg9fzOh6A
         jvjxqNXCJag3bMeiRVA958/AEk/kOxzDN9R22Is5zuXTQjMAjiHVMUueHAO2DGrqjgDO
         ZsbQ==
X-Gm-Message-State: AOAM531c48jPqO+W9fYrpQm1eVC8CzNUOXH77xYqPH9TyqDSo11+va8b
        9ytMsdaVjrjtjwlNR7Ef0oeyYXjwMRw8Rzg5Sxg=
X-Google-Smtp-Source: ABdhPJxfLgNc8pEKr5EUlQSsiX0L135fg6kTRqwNV9+JIBgUv6N9h+POUmxelxKuXpzyU/gOt3sY6A==
X-Received: by 2002:a17:906:9753:b0:6fe:dece:982a with SMTP id o19-20020a170906975300b006fedece982amr32587311ejy.560.1654703529249;
        Wed, 08 Jun 2022 08:52:09 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id bs13-20020a056402304d00b0042bd6f745fasm12492246edb.92.2022.06.08.08.52.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 08:52:08 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id n124-20020a1c2782000000b003972dfca96cso11300362wmn.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 08:52:08 -0700 (PDT)
X-Received: by 2002:a05:600c:4982:b0:39c:3c0d:437c with SMTP id
 h2-20020a05600c498200b0039c3c0d437cmr30759229wmp.38.1654703516902; Wed, 08
 Jun 2022 08:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220518014632.922072-1-yuzhao@google.com> <20220518014632.922072-8-yuzhao@google.com>
 <CAGsJ_4yboZEY9OfyujPxBa_AEuGM3OAq5y_L9gvzSMUv70BxeQ@mail.gmail.com>
 <CAGsJ_4w3S_8Kaw2GyB3hg7b4N_D+6yBO7D6qmgxD9Fqz3_dhAg@mail.gmail.com>
 <20220607102135.GA32448@willie-the-truck> <CAGsJ_4zGEdHDv0ObZ-5y8sFKLO7Y6ZjTsZFs0KvdLwA_-iGJ5A@mail.gmail.com>
 <20220607104358.GA32583@willie-the-truck> <CAOUHufZh46A2hh_fn-8vVBDi_621rgbZq64_afDt8VxrzqJz1g@mail.gmail.com>
 <CAGsJ_4yvsXCj8snemAyX3jPJgWJR+tFCtUhV-3QJ75RNi=q_KA@mail.gmail.com>
In-Reply-To: <CAGsJ_4yvsXCj8snemAyX3jPJgWJR+tFCtUhV-3QJ75RNi=q_KA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Jun 2022 08:51:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wirMfOpzNavjWao5GA65ve=9LQN-6=YCUtJGRpu=ujdoA@mail.gmail.com>
Message-ID: <CAHk-=wirMfOpzNavjWao5GA65ve=9LQN-6=YCUtJGRpu=ujdoA@mail.gmail.com>
Subject: Re: [PATCH v11 07/14] mm: multi-gen LRU: exploit locality in rmap
To:     Barry Song <21cnbao@gmail.com>
Cc:     Yu Zhao <yuzhao@google.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        Brian Geffon <bgeffon@google.com>,
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
        Vaibhav Jain <vaibhav@linux.ibm.com>, huzhanyuan@oppo.com
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

On Tue, Jun 7, 2022 at 5:43 PM Barry Song <21cnbao@gmail.com> wrote:
>
> Given we used to have a flush for clear pte young in LRU, right now we are
> moving to nop in almost all cases for the flush unless the address becomes
> young exactly after look_around and before ptep_clear_flush_young_notify.
> It means we are actually dropping flush. So the question is,  were we
> overcautious? we actually don't need the flush at all even without mglru?

We stopped flushing the TLB on A bit clears on x86 back in 2014.

See commit b13b1d2d8692 ("x86/mm: In the PTE swapout page reclaim case
clear the accessed bit instead of flushing the TLB").

               Linus
