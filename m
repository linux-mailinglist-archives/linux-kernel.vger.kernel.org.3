Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632805031A7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356417AbiDOXG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 19:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiDOXG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 19:06:26 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF5367D3E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 16:03:56 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 11so6314901edw.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 16:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mmeqzLMQT+kSYtEORk1VQwlIZb6II2FKZzIIoMsERjA=;
        b=DFSvW1LWVTiymV77lsnzL39NC77zBC5b3vG2LyDRFg75tX7jB/+k2JToy5gqlw7HJs
         IIT2qvLXLio9Tcg1LD3U9WtQ7/udodG+XgSQ9MMnDsc+T31mCAh5A6DsEpeeX15WWL3B
         ZuLUndHdgC4QOguxf+eu7BTSPyStUlOobqGVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mmeqzLMQT+kSYtEORk1VQwlIZb6II2FKZzIIoMsERjA=;
        b=qAVKxLRsro40eyI5WyIogZIUau7Btq9sf3bKjxnPBm6wJhLQHJbPBRtFb0LRGI+gVh
         kc3GnLTksr/iPcxO9gZiO0vJ71HEYlyBEwtaKZYitTTR97U4jINTIDKj8KFH0bs3TCGN
         FZJFuHfnUd3e4PaLMAF+HD6rk8k44kFWbDW0+ow4nb5xfB0keCKATswwwmkTycR3vkHH
         DtePK7VCQqZDRYDQuchhPdGOWvYbJggsAH1rJdDYhXHUACCtMiE6mPKZh86v3Ap4GIRt
         AHOZnJRj4u/W27eYA1R2+pFIlNxJcX7Mto/MA+OB3sbrOxBLiAYnbbtTMZYHNtdLHVxF
         OV2A==
X-Gm-Message-State: AOAM531HU045wzhzIOuZwJGvF4CbiQuD4KnpCsGHCH2v+js2zGTodtBU
        o6wXne+zQfyPR0p1+VF/F1PoNF5FSjjJQFfERRY=
X-Google-Smtp-Source: ABdhPJzbYnmnM3/OIzH3e6BXpANuHIzER9X86nsUqcSAqBaAXoQ/bW6vqReqnqA5e7tKyYA/4C9Rhg==
X-Received: by 2002:a05:6402:354d:b0:41d:dfe:6a8c with SMTP id f13-20020a056402354d00b0041d0dfe6a8cmr1325067edd.286.1650063835212;
        Fri, 15 Apr 2022 16:03:55 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090622ce00b006e898c912e5sm2074353eja.217.2022.04.15.16.03.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 16:03:55 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id g18so17438561ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 16:03:54 -0700 (PDT)
X-Received: by 2002:a2e:b8d6:0:b0:24b:6b40:a96a with SMTP id
 s22-20020a2eb8d6000000b0024b6b40a96amr711923ljp.176.1650063824686; Fri, 15
 Apr 2022 16:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220407031525.2368067-1-yuzhao@google.com> <20220407031525.2368067-9-yuzhao@google.com>
 <20220411191621.0378467ad99ebc822d5ad005@linux-foundation.org>
 <CAOUHufYeC=Kuu59BPL_48sM67CqACxH2wWy-SYGXpadgMDmY3w@mail.gmail.com>
 <20220414185654.e7150bcbe859e0dd4b9c61af@linux-foundation.org>
 <CAOUHufYy6yQS9ARN9C5+ODkopR+ez4TH3hZNZo4HtNHBExS1mA@mail.gmail.com>
 <20220415121521.764a88dda55ae8c676ad26b0@linux-foundation.org>
 <CAOUHufYsjwMGMFCfYoh79rFZqwqS1jDihcBS9sHd-gBxEAD3Ug@mail.gmail.com>
 <20220415143220.cc37b0b0a368ed2bf2a821f8@linux-foundation.org>
 <CAHk-=whvkRTVBhAamt0kYyp925jk_+g7T0CyPke_FbCWGQ1VvA@mail.gmail.com> <CAOUHufZ4KrjFTYH8wtwMGd9AriZfZtO4GhbiK1SuNbY31VTT9w@mail.gmail.com>
In-Reply-To: <CAOUHufZ4KrjFTYH8wtwMGd9AriZfZtO4GhbiK1SuNbY31VTT9w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Apr 2022 16:03:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=whneDk3Jde3J+O-fD32VjaK+fDf9+P6jgDtr2qyo0iu2w@mail.gmail.com>
Message-ID: <CAHk-=whneDk3Jde3J+O-fD32VjaK+fDf9+P6jgDtr2qyo0iu2w@mail.gmail.com>
Subject: Re: [PATCH v10 08/14] mm: multi-gen LRU: support page table walks
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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

On Fri, Apr 15, 2022 at 3:58 PM Yu Zhao <yuzhao@google.com> wrote:
>
> BUG_ONs are harmful but problems that trigger them would be
> presummingly less penetrating to the user base; on the other hand,
> from my experience working with some testers (ordinary users), they
> ignore WARN_ON_ONCEs until the kernel crashes.

I don't understand your argument.

First you say that VM_BUG_ON() is only for VM developers.

Then you say "some testers (ordinary users) ignore WARN_ON_ONCEs until
the kernel crashes".

So which is it?

VM developers, or ordinary users?

Honestly, if a VM developer is ignoring a WARN_ON_ONCE() from the VM
subsystem, I don't even know what to say.

And for ordinary users, a WARN_ON_ONCE() is about a million times
better, becasue:

 - the machine will hopefully continue working, so they can report the warning

 - even when they don't notice them, distros tend to have automated
reporting infrastructure

That's why I absolutely *DETEST* those stupid BUG_ON() cases - they
will often kill the machine with nasty locks held, resulting in a
completely undebuggable thing that never gets reported.

Yes, you can be careful and only put BUG_ON() in places where recovery
is possible. But even then, they have no actual _advantages_ over just
a WARN_ON_ONCE.

                  Linus
