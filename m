Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B2450312A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356231AbiDOVkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 17:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356119AbiDOVjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 17:39:53 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33783C4A9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 14:37:23 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id g19so1868431lfv.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 14:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lLriqQ645VZTKiVXonXX4zRxAjFhyB+B/84wbgqzXws=;
        b=Gq2Vs1cFahE54e4owDzXlpQ6dM9RqC+NMapopJ2Rgvnza5P4DZtfb948KXCZcASNMh
         Iezdw+NJsOwznSxZ1Bpo42TB6jsvbJqRWxbAc6bUJkl3zS3MuE5HboWtBp6hRyTXcZb5
         RQkyzuR9gn2IlHUb49/bg4XA6i75eDo/o8CNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lLriqQ645VZTKiVXonXX4zRxAjFhyB+B/84wbgqzXws=;
        b=UFhfGDnY6R6Pxy5tJ30czsul6xQRhMMcA32izsXfLx5BBQCUJLiC4UoWHpalp8L1xq
         /8An+/UEDiaqhbCJsHN0h27xIVjAUg9OEa0GVP9kLdeIZHB9LMKtmnEjpbKwWBZfZFV2
         o1w2EuUH+adi2NdfyW+eE+icY0MnWUmoaz7LPM+j0zkgsNIrgHAnS/mpYX6QsB3Ng8Yc
         690itLYG9aVY5ef9ttx0308SKGOk9AGlPIX4CXYlcWpYQt5OYPFbbP69PM/odWOTkn/Y
         vdQr1aodT5/9bQEYqWqNoRvprtFyYqNEc+qej/BzWBy3xcRi8QWhkSc8+GHlBqDw4sfV
         VLjA==
X-Gm-Message-State: AOAM531C4XYbgZlFDDn+KoEZEg46dMzFn1vh/V3NxSiOPNRqiMPcFST8
        AeCQPn9Opnr1svjXzoA6UGRaInhSO0m14nqa
X-Google-Smtp-Source: ABdhPJx9PFG9YQQogXd0yLyGn6+Eiyhq25DEC6qFuQfwL1ogzJJhVxIjlL1IXkXz3x5PW5i8RsoC7A==
X-Received: by 2002:a19:8c4b:0:b0:44a:b6a4:4873 with SMTP id i11-20020a198c4b000000b0044ab6a44873mr542669lfj.549.1650058642102;
        Fri, 15 Apr 2022 14:37:22 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id s11-20020a2e9c0b000000b0024ace83744asm386424lji.116.2022.04.15.14.37.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 14:37:19 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id o2so15677465lfu.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 14:37:18 -0700 (PDT)
X-Received: by 2002:a2e:a78d:0:b0:24b:62bc:28ab with SMTP id
 c13-20020a2ea78d000000b0024b62bc28abmr551675ljf.164.1650058628048; Fri, 15
 Apr 2022 14:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220407031525.2368067-1-yuzhao@google.com> <20220407031525.2368067-9-yuzhao@google.com>
 <20220411191621.0378467ad99ebc822d5ad005@linux-foundation.org>
 <CAOUHufYeC=Kuu59BPL_48sM67CqACxH2wWy-SYGXpadgMDmY3w@mail.gmail.com>
 <20220414185654.e7150bcbe859e0dd4b9c61af@linux-foundation.org>
 <CAOUHufYy6yQS9ARN9C5+ODkopR+ez4TH3hZNZo4HtNHBExS1mA@mail.gmail.com>
 <20220415121521.764a88dda55ae8c676ad26b0@linux-foundation.org>
 <CAOUHufYsjwMGMFCfYoh79rFZqwqS1jDihcBS9sHd-gBxEAD3Ug@mail.gmail.com> <20220415143220.cc37b0b0a368ed2bf2a821f8@linux-foundation.org>
In-Reply-To: <20220415143220.cc37b0b0a368ed2bf2a821f8@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Apr 2022 14:36:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=whvkRTVBhAamt0kYyp925jk_+g7T0CyPke_FbCWGQ1VvA@mail.gmail.com>
Message-ID: <CAHk-=whvkRTVBhAamt0kYyp925jk_+g7T0CyPke_FbCWGQ1VvA@mail.gmail.com>
Subject: Re: [PATCH v10 08/14] mm: multi-gen LRU: support page table walks
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yu Zhao <yuzhao@google.com>,
        Justin Forbes <jforbes@fedoraproject.org>,
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 2:32 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> We could create a new MM-developer-only assertion.  Might even call it
> MM_BUG_ON().  With compile-time enablement but perhaps not a runtime
> switch.

.. or VM_BUG_ON() could just become a WARN_ON_ONCE().

Which it should be anyway - since the code has to be written to
continue after that BUG_ON() anyway.

There is absolutely _zero_ advantage to killing the machine. If you
want to be notified about "this must not happen", then WARN_ON_ONCE()
is the right thing to use.

BUG_ON() is basically always the wrong thing to do.

                Linus
