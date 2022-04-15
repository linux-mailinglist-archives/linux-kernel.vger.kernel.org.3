Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9585023D5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 07:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243677AbiDOF1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 01:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343549AbiDOF1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 01:27:35 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6148D6B1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 22:25:06 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e1so4354571ile.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 22:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=L+9PwRwxAOH1Mg2qf7uyf326MX2+3tpgbGJqOX1obhw=;
        b=ikrPxUBOlq0l84T9KUCmPb1Dso9glrpW4pHENs1lllPfIu5SM48kjcjZkPGMrTqRab
         gh/IC05IWtF77az/lKxuNa3D0X55vsQ+bMGWXg5ypgS+C7ab8E4x0HRr8UnNYDqVHrWL
         xSaYWfmy31jI93loGb5PhHppDwjovao1m0URYzeiQVHfV3sXvkaPzgiJ4mXdE+SHlBqG
         ko5a1HlW0V/5Z/brlwszjKQfDwHwuDM1WXgO1oG5mtJekWlYeMrVUx4fw+E7DJi90sp3
         pRcL7Cl5N985MFtbCJQQ4ycRVLqegQ2markt+DzYaySEZ4P3TILJFJTy1QiSdJt78XD8
         oDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=L+9PwRwxAOH1Mg2qf7uyf326MX2+3tpgbGJqOX1obhw=;
        b=q55vscLvTbvoHGfCNkeQUkjwhF9wWThNWwpCjePZoH3s1iK3RDXLSKzrILfTTYhv2V
         YFqT0hpfZlomBcaGhmqtfDDYzR/WWEMmsJSuhVmaCxHAAsQBFIZQCXl0c0SdGREIdwnT
         l1gl/MTscpimrZavJcn11iaN65R7RGwLgPsGWyMlxFU6qmZKENNitjm0bbGxs5zwOTLv
         rw0VKH/paMAgWU5geT8zdwjluEYAKpSNAPOhRSQBfWPYu7Gj9DB4P3BuAD70Ozc1Yg5p
         d8NZGerMDqhF+L07vuIkXZred5B5XudwcteBqBtwA/EcqGKmr7dneQAZQpPfq1vOpYKJ
         KkIA==
X-Gm-Message-State: AOAM5302eMtdFvQHw8hyDOOj85lNUzJ40HuzVIwoSAoNpoPu9bcDMKAl
        Kk5WL/uAfGitXC1uZwFgdL2lgQ==
X-Google-Smtp-Source: ABdhPJxwK0O9V9eItDsXmWepGDGd15nU87HCouhVO3FNKAtTXKXhS4qqzoLcN8wv1Qkc0ZXdB+azMw==
X-Received: by 2002:a05:6e02:20c4:b0:2c9:a514:6a99 with SMTP id 4-20020a056e0220c400b002c9a5146a99mr2719338ilq.50.1650000305951;
        Thu, 14 Apr 2022 22:25:05 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:e02:decc:64d3:b1d3])
        by smtp.gmail.com with ESMTPSA id h24-20020a6bfb18000000b006497692016bsm2386879iog.15.2022.04.14.22.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 22:25:05 -0700 (PDT)
Date:   Thu, 14 Apr 2022 23:25:00 -0600
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
Message-ID: <YlkBrHOFgah3vHaK@google.com>
References: <20220407031525.2368067-1-yuzhao@google.com>
 <20220407031525.2368067-7-yuzhao@google.com>
 <71af92d2-0777-c318-67fb-8f7d52c800bb@huawei.com>
 <YliJzrfXzwwxiCId@google.com>
 <4c416f09-5304-07fd-cb53-5c9c8c75f6fa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c416f09-5304-07fd-cb53-5c9c8c75f6fa@huawei.com>
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

On Fri, Apr 15, 2022 at 10:23:18AM +0800, Chen Wandun wrote:
> 
> 在 2022/4/15 4:53, Yu Zhao 写道:
> > On Thu, Apr 14, 2022 at 07:47:54PM +0800, Chen Wandun wrote:
> > > On 2022/4/7 11:15, Yu Zhao wrote:
> > > > +static void inc_min_seq(struct lruvec *lruvec)
> > > > +{
> > > > +	int type;
> > > > +	struct lru_gen_struct *lrugen = &lruvec->lrugen;
> > > > +
> > > > +	VM_BUG_ON(!seq_is_valid(lruvec));
> > > > +
> > > > +	for (type = 0; type < ANON_AND_FILE; type++) {
> > > > +		if (get_nr_gens(lruvec, type) != MAX_NR_GENS)
> > > > +			continue;
> > > I'm confused about relation between aging and LRU list operation.
> > > 
> > > In function inc_max_seq,  both min_seq and max_seq will increase，
> > > the lrugen->lists[] indexed by lru_gen_from_seq(max_seq + 1) may
> > > be non-empty?
> > Yes.
> > 
> > > for example,
> > > before inc_max_seq:
> > > min_seq == 0, lrugen->lists[0][type][zone]
> > > max_seq ==3, lrugen->lists[3][type][zone]
> > > 
> > > after inc_max_seq:
> > > min_seq ==1, lrugen->lists[1][type][zone]
> > > max_seq ==4, lrugen->lists[0][type][zone]
> > > 
> > > If lrugen->lists[0][type][zone] is not empty before inc_max_seq and it is
> > > the most inactive list，however lurgen->lists[0][type][zone] will become
> > > the most active list after inc_max_seq.
> > Correct.
> > 
> > > So,  in this place,
> > > 
> > > if (get_nr_gens(lruvec, type) != MAX_NR_GENS)
> > > 	continue;
> > > 
> > > should change to
> > > 
> > > if (get_nr_gens(lruvec, type) == MAX_NR_GENS)
> > > 	continue;
> > No, because max/min_seq will overlap if we do so.
> > 
> > lrugen->lists[max_seq+1] can only be non-empty for anon LRU, for a
> > couple of reasons:
> > 1. We can't swap at all.
> > 2. Swapping is constrained, e.g., swapfile is full.
> > 
> > Both cases are similar to a producer (the aging) overrunning a
> > consumer (the eviction). We used to handle them, but I simplified the
> > code because I don't feel they are worth handling [1].
> 
> Can lrugen->lists[max_seq+1]  also be non-empty for file LRU？

On reclaim path, no. But it can be forced to do so via debugfs.

> such as in dont reclaim mapped file page case(isolation will fail).

You mean may_unmap=false? Pages stays in the same generation if
isolation fails. So lrugen->lists[min_seq] won't be empty in this
case.

> If so, after aging, eviction will reclaim memory start from
> lrugen->lists[min_seq+1], but some oldest file page still
> remain in lrugen->lists[max_seq+1].
> 
> sort_folio can help to put misplaced pages to the right
> LRU list, but in this case, it does't help, because sort_folio
> only sort lrugen->lists[min_seq+1].

On reclaim path, inc_max_seq() is only called when need_aging=true,
and this guarantees max_seq-min_seq[LRU_GEN_FILE]+1 < MAX_NR_GENS.
