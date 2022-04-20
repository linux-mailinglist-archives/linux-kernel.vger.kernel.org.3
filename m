Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF556509132
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 22:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382079AbiDTUKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 16:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382028AbiDTUKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 16:10:33 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A2745AED
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 13:07:46 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id y20so5752005eju.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 13:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=or6JCjKhYhBiaiW00aMF7rUmRM1Om7N8+nnkFL4bbB4=;
        b=PwJpWKVjNrMu7Gg4yVflFwYwWc4nnM7umtCY/l7yKXyV5Ft110X2v0svZpu5ToN4Y5
         DixablUApzvMzWya52D6gsldNClKZ0hyWeT/vhefyz8p4NqsfRLxoQJka5SJ7qGYV5KB
         ffG4ldzo9WpYNDxAEPmlwy7ETPe2MogPwMbPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=or6JCjKhYhBiaiW00aMF7rUmRM1Om7N8+nnkFL4bbB4=;
        b=G4SkrcYNyC/3uBq/gzO2GRXNQEZwymj5Ewgb3jgveSN9AYpEXemWx/eGmIhdyIQYvJ
         yLP436nYbRCH+7qdUMk03AyxA4+rOkhlVSzSSQA6Tg0A7AWYUiW0RQGp7PxGuE+/IwJT
         rdUZACg8bM6S3zJjWLtOsPfLA1/meLhjVtacaWYHwYxJIFcH3O86qAS2Z880rQqnHVij
         JSUZK/adQMxzXAz2mb0j6Lmxc/sympQ1D+2Ln8wnnXwyL2oFV36WavSgTlPZLsVkKDkS
         AlWoOx4ZniMmEr9mROxjzmkD/r1zZrVriiKvflX3tqb546jJI1+C4Ec4keSaIyT7CsRk
         +qNw==
X-Gm-Message-State: AOAM533PN8itZSQVURtP2e1Xl/iBcD8w7T04UfVdYs6IwID45sFiR3YD
        0fmiwQtRJOk/6VnT8Q2HRMMSwAmSlwq2dnIzmx0=
X-Google-Smtp-Source: ABdhPJwcV73eWJKl6y1TZ8kmk+VMYL9f7Lq4R3XWgarfOsOR1Cp64ME3FwcsnnO7UkuI3clhFkNFZw==
X-Received: by 2002:a17:906:360d:b0:6e8:7f57:2d4d with SMTP id q13-20020a170906360d00b006e87f572d4dmr20453845ejb.736.1650485264557;
        Wed, 20 Apr 2022 13:07:44 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709063e8100b006ce06ed8aa7sm7133435ejj.142.2022.04.20.13.07.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 13:07:42 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id u3so3762384wrg.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 13:07:42 -0700 (PDT)
X-Received: by 2002:ac2:4203:0:b0:448:8053:d402 with SMTP id
 y3-20020ac24203000000b004488053d402mr15354025lfh.687.1650485251826; Wed, 20
 Apr 2022 13:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220407031525.2368067-1-yuzhao@google.com> <20220407031525.2368067-6-yuzhao@google.com>
 <20220411191615.a34959bdcc25ef3f9c16a7ce@linux-foundation.org>
 <20220412070616.GT2731@worktop.programming.kicks-ass.net> <CAOUHufbUyTL-xx1RBovfSh+CrK7mBHGOouvyQBjy1RX1f3dkzw@mail.gmail.com>
In-Reply-To: <CAOUHufbUyTL-xx1RBovfSh+CrK7mBHGOouvyQBjy1RX1f3dkzw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Apr 2022 13:07:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiPHodQRZuO=b9bzB_e42NkpW4MH6-kWbTp8oYnHMk0WA@mail.gmail.com>
Message-ID: <CAHk-=wiPHodQRZuO=b9bzB_e42NkpW4MH6-kWbTp8oYnHMk0WA@mail.gmail.com>
Subject: Re: [PATCH v10 05/14] mm: multi-gen LRU: groundwork
To:     Yu Zhao <yuzhao@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@rothwell.id.au>,
        Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
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
        Vaibhav Jain <vaibhav@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 5:39 PM Yu Zhao <yuzhao@google.com> wrote:
>
> A related question: if I pass new = old to try_cmpxchg(), does it know
> that and avoid an unnecessary atomic op?

No. try_cmpxchg() basically translates directly to a cmpxchg
instruction (on x86) with the return value being the eflags 'Z' bit.

               Linus
