Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C8B5025C1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 08:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350639AbiDOGqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 02:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245567AbiDOGqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 02:46:47 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9185EAFB3F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 23:44:19 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id 125so7597662iov.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 23:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/fLGJbyPSE6xRKCPoqOb0r29CUXjvQxIOZTemHPZg9I=;
        b=dfGKPZIrjcd9mm+yubZt6QjiN5aGfnKq8fln8jmtj6lgprpmUfDA/ocuYvoro1yuX/
         Aaw4gnYOVtnG8xAqM4x8YukqX6UHi1qPVR512nIqQ0alEUiD79cE5dbK4+9MChqkGQ8D
         Vl7TqarR4PYbuygD3gGYOjB+19TitOapup1F9ynJRRI5B0ugNwc/+PhUZUYwqu93mjE2
         hLYsF9igmKUd/MPswbIdk5HiZIygq0ynFVby2OjjcI0hws9yHg42+0b3YbT8cC18hohQ
         R/zQPDZBGaORvQ5GsPDzcM8UExE/AH5eVxGhxDC6vrw9GFS2aV35ptlvCM0/nQfFlcpX
         Cnsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/fLGJbyPSE6xRKCPoqOb0r29CUXjvQxIOZTemHPZg9I=;
        b=B0obwTsFAEqpF5iubtoNt726GdhitszJcUgdsCfatSK68oDETrlRIUp1KJ6wIbSGaU
         fkhUAlkgeyDtgAJtHA8K5LHRWmx/BOE5YSaIBOKsPrrH6TQs5Dpww8EbZXtDmRhMGVfm
         /nIXr0sVThankVovy26piz60RQuQKhAgMs8f6AjQ8qZV5dtwfzRBoCyQ4sLWa6v6AYN2
         7/Eu6BO1i8L2NqM/QFlADM6o8hbjt3tRvgjU3Z/R5ZzOIpCuZmIIPzJf+JIqzCFbs0bA
         8A69YltcR4nXTa0JdduO2NbLBro3Tybr6jtUKbXvXamwDlN57gRpFXhq1wUaUIpbZgVx
         sv4Q==
X-Gm-Message-State: AOAM533LMrQw7NSoFgbIXJCyDnPoTED4XHrbn5I5EzTiJGmmo4mkATfC
        R87/L1RwOYzly4E49CHqt8rzSw==
X-Google-Smtp-Source: ABdhPJyLCRXzb7HIHHESkI0VcqbNjDKYQkRX+ir+tnPRtFjnFebfY+a4CCujF2b5x20BRFZderliUg==
X-Received: by 2002:a5d:848a:0:b0:648:b2f4:d5cd with SMTP id t10-20020a5d848a000000b00648b2f4d5cdmr2706447iom.53.1650005058681;
        Thu, 14 Apr 2022 23:44:18 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:e02:decc:64d3:b1d3])
        by smtp.gmail.com with ESMTPSA id f15-20020a056e020c6f00b002cbc9935527sm2191136ilj.83.2022.04.14.23.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 23:44:18 -0700 (PDT)
Date:   Fri, 15 Apr 2022 00:44:14 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     Stephen Rothwell <sfr@rothwell.id.au>, linux-mm@kvack.org,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, page-reclaim@google.com,
        x86@kernel.org, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v10 06/14] mm: multi-gen LRU: minimal implementation
Message-ID: <YlkUPmi77qtZTaV9@google.com>
References: <20220407031525.2368067-1-yuzhao@google.com>
 <20220407031525.2368067-7-yuzhao@google.com>
 <71af92d2-0777-c318-67fb-8f7d52c800bb@huawei.com>
 <YliJzrfXzwwxiCId@google.com>
 <4c416f09-5304-07fd-cb53-5c9c8c75f6fa@huawei.com>
 <YlkBrHOFgah3vHaK@google.com>
 <9e3ca922-1448-2eb1-b056-218236e7c72f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e3ca922-1448-2eb1-b056-218236e7c72f@huawei.com>
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

On Fri, Apr 15, 2022 at 02:31:37PM +0800, Chen Wandun wrote:
> 
> 
> 在 2022/4/15 13:25, Yu Zhao 写道:
> > On Fri, Apr 15, 2022 at 10:23:18AM +0800, Chen Wandun wrote:
> > > 在 2022/4/15 4:53, Yu Zhao 写道:
> > > > On Thu, Apr 14, 2022 at 07:47:54PM +0800, Chen Wandun wrote:
> > > > > On 2022/4/7 11:15, Yu Zhao wrote:
> > > > > > +static void inc_min_seq(struct lruvec *lruvec)
> > > > > > +{
> > > > > > +	int type;
> > > > > > +	struct lru_gen_struct *lrugen = &lruvec->lrugen;
> > > > > > +
> > > > > > +	VM_BUG_ON(!seq_is_valid(lruvec));
> > > > > > +
> > > > > > +	for (type = 0; type < ANON_AND_FILE; type++) {
> > > > > > +		if (get_nr_gens(lruvec, type) != MAX_NR_GENS)
> > > > > > +			continue;
> > > > > I'm confused about relation between aging and LRU list operation.
> > > > > 
> > > > > In function inc_max_seq,  both min_seq and max_seq will increase，
> > > > > the lrugen->lists[] indexed by lru_gen_from_seq(max_seq + 1) may
> > > > > be non-empty?
> > > > Yes.
> > > > 
> > > > > for example,
> > > > > before inc_max_seq:
> > > > > min_seq == 0, lrugen->lists[0][type][zone]
> > > > > max_seq ==3, lrugen->lists[3][type][zone]
> > > > > 
> > > > > after inc_max_seq:
> > > > > min_seq ==1, lrugen->lists[1][type][zone]
> > > > > max_seq ==4, lrugen->lists[0][type][zone]
> > > > > 
> > > > > If lrugen->lists[0][type][zone] is not empty before inc_max_seq and it is
> > > > > the most inactive list，however lurgen->lists[0][type][zone] will become
> > > > > the most active list after inc_max_seq.
> > > > Correct.
> > > > 
> > > > > So,  in this place,
> > > > > 
> > > > > if (get_nr_gens(lruvec, type) != MAX_NR_GENS)
> > > > > 	continue;
> > > > > 
> > > > > should change to
> > > > > 
> > > > > if (get_nr_gens(lruvec, type) == MAX_NR_GENS)
> > > > > 	continue;
> > > > No, because max/min_seq will overlap if we do so.
> > > > 
> > > > lrugen->lists[max_seq+1] can only be non-empty for anon LRU, for a
> > > > couple of reasons:
> > > > 1. We can't swap at all.
> > > > 2. Swapping is constrained, e.g., swapfile is full.
> > > > 
> > > > Both cases are similar to a producer (the aging) overrunning a
> > > > consumer (the eviction). We used to handle them, but I simplified the
> > > > code because I don't feel they are worth handling [1].
> > > Can lrugen->lists[max_seq+1]  also be non-empty for file LRU？
> > On reclaim path, no. But it can be forced to do so via debugfs.
> > 
> > > such as in dont reclaim mapped file page case(isolation will fail).
> > You mean may_unmap=false? Pages stays in the same generation if
> > isolation fails. So lrugen->lists[min_seq] won't be empty in this
> > case.
> > 
> > > If so, after aging, eviction will reclaim memory start from
> > > lrugen->lists[min_seq+1], but some oldest file page still
> > > remain in lrugen->lists[max_seq+1].
> > > 
> > > sort_folio can help to put misplaced pages to the right
> > > LRU list, but in this case, it does't help, because sort_folio
> > > only sort lrugen->lists[min_seq+1].
> > On reclaim path, inc_max_seq() is only called when need_aging=true,
> > and this guarantees max_seq-min_seq[LRU_GEN_FILE]+1 < MAX_NR_GENS.
> yes, I think so, but I did't find the logical in function get_nr_evictable,
> or am I missing something
> 
>         if (min_seq[LRU_GEN_FILE] + MIN_NR_GENS > max_seq)
>                 *need_aging = true;
>         else if (min_seq[LRU_GEN_FILE] + MIN_NR_GENS < max_seq)
>                 *need_aging = false;

This branch.

And the following is also relavent:

    static int __init init_lru_gen(void)
    {
        BUILD_BUG_ON(MIN_NR_GENS + 1 >= MAX_NR_GENS);
