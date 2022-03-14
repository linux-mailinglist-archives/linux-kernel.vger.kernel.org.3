Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48394D7EA7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbiCNJcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238233AbiCNJcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:32:24 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A335945AE5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 02:30:44 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id j128so16322164vsc.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 02:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KeEKIGDs9aXtMIhttJqsnMc0I5powM9Tr74wlg/y0N4=;
        b=lJ3K5cO3Dq2yUA9tXv+g2KWoRQVbUQykq7rgnVsvdNTinvfq2zVR/yeWcYQ91TJnvm
         tgEhlsMQRIGR3LbKXt1i7eQBVLAIwooq1wvCKm2WmQ2slDHMaRu8xBxhaCBW482uRynU
         tE+hG69ChaKdnzLD1jMRGbnyP3MSuZlba7K1c7cBgQ5reXpaOdLgSh1wX9mVgBnrxEjI
         ymH2dl4bqWPZnYxoIjbGUbAD/bhuCjtJw7SN/Ra74Q7+T2YdUCqmV+O+K8TDvAh4HQ19
         0V+5K6ZMorsvLVs706dbT3zQzir4kkgQWkOXYGnJYffXDPM5a/UOKqy/Mr+hk6gKXtbQ
         /h0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KeEKIGDs9aXtMIhttJqsnMc0I5powM9Tr74wlg/y0N4=;
        b=VjZ/KpLiFiXQKau+Q1c6u3cirhpU9D3+EyE6n3ml1luthajzy70lH5mptISUj+uJp1
         4qsuyJjb/L3b1p3YVR4FYxBt4qwPbTtAEpN6lVLpM5rEG5qQ+dXFPWC4pAUeuXJe25OC
         2GWO1BVHhdy3rBgAAp4vl4F8s6dHBC6kbp3pthwOU7PIt1Pd7zvbG5N74kzPING8x+e3
         sg3tXzBML+a6lcQW+RCzhbInEkfQAlEy0OGPH/5RiupuK/KsjJz9xvQqKVlAhjQtIzUI
         GoUpPwvTVbv5bTL0Mp85MAwTAXmUkHOdT6dbTzvpkxoy6OQxF2rw29IR2h7sIDZX8XZq
         BndA==
X-Gm-Message-State: AOAM532U5lxOCgp4YaBfUi2BbfQ64IiK6ms128bdEGJS5pd2c9hEx8V5
        W/lHy27J1HKOoofrT9T8Y9Pw+3PrkgCva5OMoQn7oQ==
X-Google-Smtp-Source: ABdhPJysb3Sw3/ukECu2h8EIWocceI4MckxeGuz3tnGwSYqea1336M0S1Iw+cCwN7NQ7GEwY+pua/xA+S5ZNz8vIosY=
X-Received: by 2002:a05:6102:290c:b0:322:b864:22f5 with SMTP id
 cz12-20020a056102290c00b00322b86422f5mr6266141vsb.41.1647250243519; Mon, 14
 Mar 2022 02:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220309021230.721028-1-yuzhao@google.com> <20220309021230.721028-6-yuzhao@google.com>
 <875yoh552i.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <875yoh552i.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 14 Mar 2022 03:30:31 -0600
Message-ID: <CAOUHufYPSesiePfxaV=y9Vne5cb+Y_vQtJyQ1NiO1CFus=8WOA@mail.gmail.com>
Subject: Re: [PATCH v9 05/14] mm: multi-gen LRU: groundwork
To:     "Huang, Ying" <ying.huang@intel.com>,
        kernel@lists.fedoraproject.org, kernel-team@lists.ubuntu.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 2:09 AM Huang, Ying <ying.huang@intel.com> wrote:
>
> Hi, Yu,
>
> Yu Zhao <yuzhao@google.com> writes:
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 3326ee3903f3..747ab1690bcf 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -892,6 +892,16 @@ config ANON_VMA_NAME
> >         area from being merged with adjacent virtual memory areas due to the
> >         difference in their name.
> >
> > +# the multi-gen LRU {
> > +config LRU_GEN
> > +     bool "Multi-Gen LRU"
> > +     depends on MMU
> > +     # the following options can use up the spare bits in page flags
> > +     depends on !MAXSMP && (64BIT || !SPARSEMEM || SPARSEMEM_VMEMMAP)
>
> LRU_GEN depends on !MAXSMP.  So, What is the maximum NR_CPUS supported
> by LRU_GEN?

LRU_GEN doesn't really care about NR_CPUS. IOW, it doesn't impose a
max number. The dependency is with NODES_SHIFT selected by MAXSMP:
    default "10" if MAXSMP
This combined with LAST_CPUPID_SHIFT can exhaust the spare bits in page flags.

MAXSMP is meant for kernel developers to test their code, and it
should not be used in production [1]. But some distros unfortunately
ship kernels built with this option, e.g., Fedora and Ubuntu. And
their users reported build errors to me after they applied MGLRU on
those kernels ("Not enough bits in page flags"). Let me add Fedora and
Ubuntu to this thread.

Fedora and Ubuntu,

Could you please clarify if there is a reason to ship kernels built
with MAXSMP? Otherwise, please consider disabling this option. Thanks.

As per above, MAXSMP enables ridiculously large numbers of CPUs and
NUMA nodes for testing purposes. It is detrimental to performance,
e.g., CPUMASK_OFFSTACK.

[1] https://lore.kernel.org/lkml/20131106055634.GA24044@gmail.com/
