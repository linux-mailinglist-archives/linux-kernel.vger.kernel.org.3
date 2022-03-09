Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178BD4D256F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 02:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiCIBCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiCIBCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:02:30 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2A32687A2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 16:40:13 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id j26so657589wrb.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 16:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KfA4JgIAwrzcTd/4yRkk1J8RUcB4FSjox1guvVqXM6M=;
        b=gOPY1r/wzB5jYwuwRc6y3Yxrhd0fGC6yPlpf9+UB9omWnf6GTz6QTzPrdA7qfkJfHM
         lJ75Qqxmjo1vD3lxkPsHj+ZIudClKUQfypotCbBgEG08N3dw/YuJs8qjwqUXz2qOvy2j
         h6d9I3cmIm/w83PdSf1CY1Sj7DgY3Rbzp9ZI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KfA4JgIAwrzcTd/4yRkk1J8RUcB4FSjox1guvVqXM6M=;
        b=VwkBOyn7Bc9wFqSMwGd7dg/O1mxGnSTdAKakcbjyIXZ2zSxEwI/xzddFr80K7x6dZI
         2AtZHVKlFihzWdUjmbVIzPh5XLi4IZtEAHZTVHRaKTLhFPgevlW+jBsGNme8Zb2OFjuN
         a8zoY/f8Vqa123IflWcP1z5hIUwUnlxsNVgwMMKy7zkXzD4p39wXXJfzuFFqjv76RXc4
         JB8jTdeGuynDRuH71wjCxbw8OB4RQpXJMXHOht9SgxGPnAt7Ls5Lyeb6F6M6hI9MSAFd
         n68HGhXssxqfvzPQ3fLrpA38g62PcNoMJivtaQzchF7Z6RjGIeTIIila4p0Hrdx9HFfH
         PpyA==
X-Gm-Message-State: AOAM5320NwZyDr+nr1r4drfhYJ+neZ1fH5cDsnpX81qIlu8QKMiVSCCJ
        a0dg4Wn7qVhPGUjCYLmqLzZAmUzay1+N8RIoGgY=
X-Google-Smtp-Source: ABdhPJzJxiT5z1M7rDiwDWLCrF9YQ9BeGsejiYL7Ky5zGL54b48M68262+W4xI54GpfpCoH4AzfUkw==
X-Received: by 2002:a05:6512:150d:b0:442:aad5:2550 with SMTP id bq13-20020a056512150d00b00442aad52550mr12656542lfb.678.1646784443296;
        Tue, 08 Mar 2022 16:07:23 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id z10-20020a19504a000000b004483c8359f9sm61289lfj.131.2022.03.08.16.07.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 16:07:22 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id h14so821674lfk.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 16:07:22 -0800 (PST)
X-Received: by 2002:a05:6512:3049:b0:447:d55d:4798 with SMTP id
 b9-20020a056512304900b00447d55d4798mr12256093lfb.531.1646784431050; Tue, 08
 Mar 2022 16:07:11 -0800 (PST)
MIME-Version: 1.0
References: <20220308234723.3834941-1-yuzhao@google.com>
In-Reply-To: <20220308234723.3834941-1-yuzhao@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Mar 2022 16:06:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi5wg=72exwHODJdVtAfqa1e85dGfjGftuhHQ5Z4v-DNA@mail.gmail.com>
Message-ID: <CAHk-=wi5wg=72exwHODJdVtAfqa1e85dGfjGftuhHQ5Z4v-DNA@mail.gmail.com>
Subject: Re: [PATCH v8 00/14] Multi-Gen LRU Framework
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, page-reclaim@google.com,
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

On Tue, Mar 8, 2022 at 3:48 PM Yu Zhao <yuzhao@google.com> wrote:
>
> The current page reclaim is too expensive in terms of CPU usage and it
> often makes poor choices about what to evict. This patchset offers an
> alternative solution that is performant, versatile and
> straightforward.

So apart from my complaints about asking users config questions that
simply should not be asked, I really think this just needs to start
getting merged.

We've seen several numbers on the upsides, and I don't think we'll see
any of the downsides until we try it. And I don't think there is any
question that we _shouldn't_ try it, given the numbers posted.

But yeah, I certainly _hope_ that all the benchmarking has been done
with a unified set of config values, and it's not some kind of bogus
"cherry-picked config values for this particular machine" kind of
benchmarking that has been done.

Because that isn't valid benchmarking - comparing some "tuned for this
paeticular machine or load" setup to a default one is just not worth
even setting numbers to, and debases the whole value of posting
results.

                    Linus
