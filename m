Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504474E8443
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 22:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbiCZVE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 17:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiCZVEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 17:04:54 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70391102
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 14:03:16 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id p143so6022518vkf.5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 14:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J8s39Hf+0zr8egKm//Mqpb+5/kH7X9BGZ05be3kJ96k=;
        b=cOVN4o+wgdD7dvKIYdB98sVRw16J+6jzP953f8PKKcHbIu7AgloP8MACx5VtPZm5+k
         sHDebP5KI0MEGXzKdpagdhmL9ec0ZIp0XSko3YKKQoJSR47669gqTTk+3whwAsVMzRIb
         cX7MuHhqhJOuPYojwwuxD/ifznzZCfMujTx1hTBOBXGKKrMHcvbfxlE8qrY7jnqg4FSk
         LanKficLPing2dBDIU3ydpVrdwgNgl50JFncIP1pOy/F76W3tZBx42zDZWFDNjTwVeCU
         8736ztS7wIO72EtxaxJ0lh9K53yF+n07XUFgmOcl2i4NLyBgHXaXEgCuqw/NO/p/6Rd3
         GllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J8s39Hf+0zr8egKm//Mqpb+5/kH7X9BGZ05be3kJ96k=;
        b=l9tLaddvBd6qk1/vZviUuAuDASGZ3PqUlPxQxLBngfi1bjlfKi9pQUUz5EJ2+G3ssl
         3iwl+FTHgI0uqlbhOirOHNd0jpAlDeRHaHcT0g9Xmxe2OOr61NpBr5nOcczYGJMbEYrP
         1GDilaAP/UrQGPCxI+nMFc2GTEvuk600psWvHLJXZWW08VDtH+J+ssuHHJy9k50D7vLV
         FqtVacxVWqIDa+WGVGUnZ45b3uaZdQAdDWaYh+cVIK3FkV7iJnCGIru3E+EXXClfvj/Q
         /veBkXKpaxqDXDzJl1TkywvE8gFpmU9hABA5eUWVjPc8G0q/Hh9bKWkowt+k7tEl0vfQ
         ZYOQ==
X-Gm-Message-State: AOAM533gx7cUjrTl3ys1XmF9faQj9u4cutF3eiOAEUjGd0zO+5PKS08u
        hGItAHTUbeKu36oURntm4hlwlW4gX+Fc3aUjrcFV4w==
X-Google-Smtp-Source: ABdhPJwagl7oEUUX31C3s4tj4gQK/i+pmRpDRgvmBdJJLJAvyM7y8gSo5aR2CqsTEOZb6pMz6zw8hoW9RMAq4c+uORg=
X-Received: by 2002:a1f:a9cb:0:b0:33e:d145:85f0 with SMTP id
 s194-20020a1fa9cb000000b0033ed14585f0mr7726646vke.7.1648328595748; Sat, 26
 Mar 2022 14:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220326010003.3155137-1-yuzhao@google.com> <CAHk-=wjp=jEhjvD9GPnHfuV5Kc1=rUnf84b_qscLJ8fkY74u3Q@mail.gmail.com>
 <CAOUHufbqum18T4kZ=d_hMehz=N=3iSuNfGrLof5tB8kjGkk8yw@mail.gmail.com> <20220326134928.ad739eeecd5d0855dbdc6257@linux-foundation.org>
In-Reply-To: <20220326134928.ad739eeecd5d0855dbdc6257@linux-foundation.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sat, 26 Mar 2022 15:03:04 -0600
Message-ID: <CAOUHufYU2m5UFbcvLDK7vNdqmh2utbwGK+fvDKYHz4rhw4WYXw@mail.gmail.com>
Subject: Re: [page-reclaim] Re: [GIT PULL] Multi-gen LRU for 5.18-rc1
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2022 at 2:49 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 25 Mar 2022 19:16:15 -0600 Yu Zhao <yuzhao@google.com> wrote:
>
> > On Fri, Mar 25, 2022 at 7:07 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Fri, Mar 25, 2022 at 6:00 PM Yu Zhao <yuzhao@google.com> wrote:
> > > >
> > > > This is more of an option than a request for 5.18. I'm sending it to
> > > > you directly because, in my judgement, it's now as ready as it'll ever
> > > > be.
> > >
> > > So I do expect to merge this, but I don't think it has been in
> > > linux-next, has it?
> >
> > No. I could ask Stephen to see if he is willing to take this series. I
> > was hoping to go through Andrew since his tree is what most MM
> > developers test. I haven't heard from Andrew, so I assume he has no
> > strong opinion and I don't want to put him in a different position.
>
> hm, sorry, something in the headers here fooled my (elaborate) procmail
> rules :(
>
> Please yes, let's have a cycle in -next.  I thought we decided to do
> that in discussion with Matthew Wilcox?

Will do.

> Also, sorry, but I'm not seeing many commonly-seen names amongst the
> reviewers.  I'd be more comfortable if people who have done most work on
> page reclaim up to this time have had time to review and comment.

Me too :) Unfortunately I can't dictate others' priorities or
methodologies. So I have reset my expectations from getting their
reviewed-by's to not getting their NAKs.
