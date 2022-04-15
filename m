Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7EB5023E9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 07:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbiDOFd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 01:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344938AbiDOFd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 01:33:27 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CDBA146B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 22:30:59 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id i186so6306601vsc.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 22:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Di+wr37U174Nx7w1oJa4ec3u7LAPibr5Hnogm0KQ5KA=;
        b=HODn7qI57pWt1oZWbQMZ3KJCt8UgF2sxF84uj3uKTo3R6eblGW4tKzonTWLm1pEFdT
         yG9qgeECK1ytcgWBIg43CscdMBJJAqPOA/zudzK/VTJyN7Vn4jq64VvB4EJTnAZo3xU9
         /tb4RBVKtNQnhCk9Nn4nDf8REhxVQGZ3TELX0jzmRqP/qaadUEj34ceL3HKuezdZsDUe
         YTq0cKMpvi3RGvjGlu/xtA4UgmNAeKG314EWDEPQ1nRXokxz3VfBJi+o4W1eH6Mh1eCE
         eCX8cIYTJ7tq19cO4pn1Wugsac81ETz55D5v4+CV4PJwbUYIakUlvJirdXAygbmf1Kv6
         W/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Di+wr37U174Nx7w1oJa4ec3u7LAPibr5Hnogm0KQ5KA=;
        b=cGmUDkpB+8hfpFn2blbNeNLJ5M0BJUrlfMhB3tztnjlyaN0NIAs1t7abmG4nBJSFzA
         0w4WGXb1tcepUq/sz/tYqw1a4ZFq6EtFK/99ucyoZEMzRhSclpRsYygyseWaesuojgme
         jJlcJsCVMOsyGv9FETqshYLEExM34MMJsCZswGPIlLVwSe2q5hSgfI6vRqaqf8q6D/1Z
         tAd1vs5Eiiw2YuIYo0i4Da/zalzanps87qtlzzSaSEdrGKhqwONBrg4zJani063KtsaD
         fUQbhkGquVAzBwIsg3GztsxKOmSM+HIfuV78PdVwVtgRH8ILwwvj7y8R51xhrZ07JW1V
         y6Ww==
X-Gm-Message-State: AOAM533gfTz1TiEK+9BFWmzIgNDI9O6l2fK93daxOC4Fha3+idqgyKTa
        EOWHIoVgRfQvsfx8f2ppoeXIUKNTXNzQtVtDXLyljQ==
X-Google-Smtp-Source: ABdhPJz/nQA8xxiMNDyTW4PUrlucKA7LqqG3BlyYwzZ4ZVXZvD8oivYN5l/8PMooP8q1SwXigPcaj8U6TIwW9K1TzWs=
X-Received: by 2002:a05:6102:5cc:b0:320:9bd2:3823 with SMTP id
 v12-20020a05610205cc00b003209bd23823mr2650275vsf.81.1650000658866; Thu, 14
 Apr 2022 22:30:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220407031525.2368067-1-yuzhao@google.com> <20220407031525.2368067-9-yuzhao@google.com>
 <20220411191621.0378467ad99ebc822d5ad005@linux-foundation.org> <20220412071026.GU2731@worktop.programming.kicks-ass.net>
In-Reply-To: <20220412071026.GU2731@worktop.programming.kicks-ass.net>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 14 Apr 2022 23:30:22 -0600
Message-ID: <CAOUHufYaJJ9s4Garn37aY0Gmfmn0Rpq=Ei4XYQ29DcpDHuvrZA@mail.gmail.com>
Subject: Re: [PATCH v10 08/14] mm: multi-gen LRU: support page table walks
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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

On Tue, Apr 12, 2022 at 1:10 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Apr 11, 2022 at 07:16:21PM -0700, Andrew Morton wrote:
> > On Wed,  6 Apr 2022 21:15:20 -0600 Yu Zhao <yuzhao@google.com> wrote:
>
> > > +#ifdef CONFIG_LRU_GEN
> > > +static void mem_cgroup_attach(struct cgroup_taskset *tset)
> > > +{
> > > +   struct cgroup_subsys_state *css;
> > > +   struct task_struct *task = NULL;
> > > +
> > > +   cgroup_taskset_for_each_leader(task, css, tset)
> > > +           break;
> >
> > Does this actually do anything?
>
> Yeah, it finds the first leader if there is any, but this is indeed
> quite terrible coding style.

I've added a one liner comment "find the first leader if there is
any", for now. I'm open to other suggestions.
