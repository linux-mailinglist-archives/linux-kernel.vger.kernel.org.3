Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE70C5033D4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbiDOXwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 19:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiDOXwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 19:52:18 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEE42BB14
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 16:49:47 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id i186so8127810vsc.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 16:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qr6XNF1bK3PdePl03u0gY6aVL4clB778VuHLiEk7Bus=;
        b=lf2+gHgcE6Sjq8PQbV9FP6YTAFbqNAhZzALie/K0UJSwp8Oa59xE5fwxN11DNM1jzF
         F3nCS/VDmcRfjfl+JURbhT1QwWlvTf6TMOvYedmPUuhYHZoZ3FWE5qDqrpcgiKwp2M5b
         jIKbKuIKL6O8SCdu+Nkg0t7A2o9CszAGzTa03ecBG4fd70UaiXXatm8yPzcBm+xkUc0w
         OlyD+/B7EBheiPusiGgfwCmbaSrnOrKXiajcUq9uILobC5vaoL8BOyYShHP5yPjJ3eKX
         +ZcE5PfQI7fVU5JbPATy7K69qjCUTJycQkXpbAtC/uy29svtVfrMRlXv8Zkh0xmeSuTJ
         tKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qr6XNF1bK3PdePl03u0gY6aVL4clB778VuHLiEk7Bus=;
        b=ZjULt1cRQCvHJHE2uo7Jnyfyaaz3pBbQJ+oEDBHSXjQ/IcIPvwKE/P+v+tAKhJovYr
         QA1z9iZkvIC308AHC+CkVo6d5lVvQD/uCn0uWPSbT3oWUxom2vVeIrs8Pjk9+XprA6sl
         f7nASaCCjiwXUgoNfsf7sZAwp/pnjSWvzuEsnjCPxLcpKFGP5tZ0iKy98b5CPI6cCeGz
         1W858d9rPjEmqau/11HI+ME+8oYfjeJgT7X2syWvpQ+WNHY2EdwGdbOPwhFXz29N+qVY
         nNIeQUZyrQ9gZftX8gulpthughPI3xUkTMgqgIZLUWomyeQ2i3OFsJ7gYESh+CB1TOw3
         Qghw==
X-Gm-Message-State: AOAM53372MmkHefMtXg0t/2PdroC2OVpzXMW3hB5BMDmkvijPT4dY2Nz
        tOG/dGQWKOtEZgfU6zfyiv05tXGZChuc5mH8jxrR4g==
X-Google-Smtp-Source: ABdhPJyW7+XQXBJpdsz4McEx26yYkMLlsqpGPfU1l0p0386BmKCCX+y/uTbiRr+7GHVmV1rMDNlghHYJg9Cw/My3+7o=
X-Received: by 2002:a05:6102:3753:b0:325:c20e:4b1c with SMTP id
 u19-20020a056102375300b00325c20e4b1cmr361726vst.84.1650066586474; Fri, 15 Apr
 2022 16:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220407031525.2368067-1-yuzhao@google.com> <20220407031525.2368067-9-yuzhao@google.com>
 <20220411191621.0378467ad99ebc822d5ad005@linux-foundation.org>
 <CAOUHufYeC=Kuu59BPL_48sM67CqACxH2wWy-SYGXpadgMDmY3w@mail.gmail.com>
 <20220414185654.e7150bcbe859e0dd4b9c61af@linux-foundation.org>
 <CAOUHufYy6yQS9ARN9C5+ODkopR+ez4TH3hZNZo4HtNHBExS1mA@mail.gmail.com>
 <20220415121521.764a88dda55ae8c676ad26b0@linux-foundation.org>
 <CAOUHufYsjwMGMFCfYoh79rFZqwqS1jDihcBS9sHd-gBxEAD3Ug@mail.gmail.com>
 <20220415143220.cc37b0b0a368ed2bf2a821f8@linux-foundation.org>
 <CAHk-=whvkRTVBhAamt0kYyp925jk_+g7T0CyPke_FbCWGQ1VvA@mail.gmail.com>
 <CAOUHufZ4KrjFTYH8wtwMGd9AriZfZtO4GhbiK1SuNbY31VTT9w@mail.gmail.com> <CAHk-=whneDk3Jde3J+O-fD32VjaK+fDf9+P6jgDtr2qyo0iu2w@mail.gmail.com>
In-Reply-To: <CAHk-=whneDk3Jde3J+O-fD32VjaK+fDf9+P6jgDtr2qyo0iu2w@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 15 Apr 2022 17:49:09 -0600
Message-ID: <CAOUHufbc9oZ03CcOmQ=4KWzh_cof26Avag+WVkfOGR3+W8-OaA@mail.gmail.com>
Subject: Re: [PATCH v10 08/14] mm: multi-gen LRU: support page table walks
To:     Linus Torvalds <torvalds@linux-foundation.org>
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

On Fri, Apr 15, 2022 at 5:03 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Apr 15, 2022 at 3:58 PM Yu Zhao <yuzhao@google.com> wrote:
> >
> > BUG_ONs are harmful but problems that trigger them would be
> > presummingly less penetrating to the user base; on the other hand,
> > from my experience working with some testers (ordinary users), they
> > ignore WARN_ON_ONCEs until the kernel crashes.
>
> I don't understand your argument.
>
> First you say that VM_BUG_ON() is only for VM developers.

I did? Probably I implied CONFIG_DEBUG_VM=y is meant for MM developers.

> Then you say "some testers (ordinary users) ignore WARN_ON_ONCEs until
> the kernel crashes".
>
> So which is it?
>
> VM developers, or ordinary users?

Ordinary users.

> Honestly, if a VM developer is ignoring a WARN_ON_ONCE() from the VM
> subsystem, I don't even know what to say.

Same here. I wasn't worried about kernel developers ignoring any warnings.

> And for ordinary users, a WARN_ON_ONCE() is about a million times
> better, becasue:
>
>  - the machine will hopefully continue working, so they can report the warning
>
>  - even when they don't notice them, distros tend to have automated
> reporting infrastructure
>
> That's why I absolutely *DETEST* those stupid BUG_ON() cases - they
> will often kill the machine with nasty locks held, resulting in a
> completely undebuggable thing that never gets reported.
>
> Yes, you can be careful and only put BUG_ON() in places where recovery
> is possible. But even then, they have no actual _advantages_ over just
> a WARN_ON_ONCE.

I hear you, and I wasn't arguing about anything, just sharing my two cents.
