Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DAA501CF3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 22:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239656AbiDNU4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 16:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiDNU4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 16:56:05 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64F1BC840
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 13:53:39 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id y5so3860530ilg.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 13:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pa6LgTwJKoCyDm1ouvnQaXSj0XUnafk1B7DnI+4ds5E=;
        b=YOLOl3QdEGf0HeVT/Gn6X9mQ4SlNVFfW1B2wWZPnauNvYBjdx92phALVWtyhmtOUiy
         /YckdceI2rkicz7tfSi3vOI586pm3t2iq/JoeQOCht91JmDq4gRXbBayAilFIiGC/9oc
         EyOw2zrv9r2uvnPxtAk+pi2ObkQUJqxEqPdSVks5sFBB/TP7HwujPSZT6cOxUxKxNNh5
         stc1Q2d7THmA3eb9ZUjFDh4AWcUNjj7PGCngcv/EpLd9vhEniIpbuZYm8GxfJNTvD8Wd
         Ka64OYy+PHR3cj3VeNKrERCvIj3UTCgN6YDX5zWT0DYYbnMNw/s1rsBDQnv17C9gsDg/
         ZZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pa6LgTwJKoCyDm1ouvnQaXSj0XUnafk1B7DnI+4ds5E=;
        b=k3P/BkgOMqMVFl7bHNjjFZ13Un9QEaps+pet1JLpUZoA+ARF69/D1Sk+mlyNVCmuvl
         YqzTjh0iy+zGAAKq193AZq/Ij0C4CcDh4AmB1a06hDpsxs3MOnXsxNrX+KR5RRK7JADX
         VKZZ7bF4g+ycjOE7lgf+0euyvi9Ak5FkcX0L1HWYZTh9i1DxFTgv78Vam5K8syFEAs3d
         yinIo8AFPi/FiIORl/OtycnUbr/BcM5gUS4yTOusHbY9whPVeLRUNHD4lSTrqq2OYJrv
         n4MqmzhIqQnXyj8BG0L1c9iIhdBYJ5tyYoEoM5MsO5M1iLexGzl8oI0rgtHEqtRNjmqC
         KCcQ==
X-Gm-Message-State: AOAM530u9nRpJdQXBiAaYI9B/f3Ukhl61vv+kQVN0j6wVAU1EfLuPMo5
        8G1dmeyk43Aj33R9ZCIw6CJwZw==
X-Google-Smtp-Source: ABdhPJyyDgmPB1FgemJ0ZnKu90qzgVNnbgA76O0ajimJW0cemV0EzujLhLiFOctL5zYuKP5jxsTu8g==
X-Received: by 2002:a92:d18b:0:b0:2c6:675:807c with SMTP id z11-20020a92d18b000000b002c60675807cmr1744365ilz.33.1649969618981;
        Thu, 14 Apr 2022 13:53:38 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:e02:decc:64d3:b1d3])
        by smtp.gmail.com with ESMTPSA id v18-20020a6b5b12000000b00645bd8bd288sm1764416ioh.47.2022.04.14.13.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 13:53:38 -0700 (PDT)
Date:   Thu, 14 Apr 2022 14:53:34 -0600
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
Message-ID: <YliJzrfXzwwxiCId@google.com>
References: <20220407031525.2368067-1-yuzhao@google.com>
 <20220407031525.2368067-7-yuzhao@google.com>
 <71af92d2-0777-c318-67fb-8f7d52c800bb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71af92d2-0777-c318-67fb-8f7d52c800bb@huawei.com>
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

On Thu, Apr 14, 2022 at 07:47:54PM +0800, Chen Wandun wrote:
> 
> On 2022/4/7 11:15, Yu Zhao wrote:
> > +static void inc_min_seq(struct lruvec *lruvec)
> > +{
> > +	int type;
> > +	struct lru_gen_struct *lrugen = &lruvec->lrugen;
> > +
> > +	VM_BUG_ON(!seq_is_valid(lruvec));
> > +
> > +	for (type = 0; type < ANON_AND_FILE; type++) {
> > +		if (get_nr_gens(lruvec, type) != MAX_NR_GENS)
> > +			continue;
> I'm confused about relation between aging and LRU list operation.
> 
> In function inc_max_seq,  both min_seq and max_seq will increase，
> the lrugen->lists[] indexed by lru_gen_from_seq(max_seq + 1) may
> be non-empty?

Yes.

> for example,
> before inc_max_seq:
> min_seq == 0, lrugen->lists[0][type][zone]
> max_seq ==3, lrugen->lists[3][type][zone]
> 
> after inc_max_seq:
> min_seq ==1, lrugen->lists[1][type][zone]
> max_seq ==4, lrugen->lists[0][type][zone]
> 
> If lrugen->lists[0][type][zone] is not empty before inc_max_seq and it is
> the most inactive list，however lurgen->lists[0][type][zone] will become
> the most active list after inc_max_seq.

Correct.

> So,  in this place,
> 
> if (get_nr_gens(lruvec, type) != MAX_NR_GENS)
> 	continue;
> 
> should change to
> 
> if (get_nr_gens(lruvec, type) == MAX_NR_GENS)
> 	continue;

No, because max/min_seq will overlap if we do so.

lrugen->lists[max_seq+1] can only be non-empty for anon LRU, for a
couple of reasons:
1. We can't swap at all.
2. Swapping is constrained, e.g., swapfile is full.

Both cases are similar to a producer (the aging) overrunning a
consumer (the eviction). We used to handle them, but I simplified the
code because I don't feel they are worth handling [1].

[1] https://lore.kernel.org/r/CAOUHufbDfwgm8PgCGkhCjbhMbm=fekfjgRR56NL-j+5iUGfVuw@mail.gmail.com/
