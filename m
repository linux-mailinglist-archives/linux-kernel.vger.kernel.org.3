Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D734501CD0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 22:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346528AbiDNUim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 16:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346530AbiDNUig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 16:38:36 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD4FE338C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 13:36:09 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id n134so1614279iod.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 13:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VOwb/LIajkynds1NOWj0jp1Wh/dVLVu/LuQcUbDz8pc=;
        b=Fl/3pmZMMXpOUXW9mpvpX/dnQQ8iA+BLm4Msn7syrUbuGNt6ScyDa/OeLqypvbAZD3
         mn/YqmGq1kRjD8kCuAkSd7Rl/xsRv9+bu/uYkJZYO6ztOmnXAmlF/Um+oHvfq8CBWlG8
         nmo2fZO/3i/n8sBlau9jKc8ktVdxUIL6KfVQt1UTGh6oKY3BuxQRcBomVOMM5T+JSRpZ
         G0XFcWIeCNOiY9mH6ebjC64b+MRHtWCr1HGLIEb9kbrQnYiAAybYpZVzGbnl8gaqCwCk
         4N7JMm/Zuv+rdDf+LtmAAt0BOUCUoOUGMh0tFQTPiieWZn2K8CxtWysktqjJtG83yiFW
         kv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VOwb/LIajkynds1NOWj0jp1Wh/dVLVu/LuQcUbDz8pc=;
        b=vngB0ebQxpW7wOfMc/5jHEUd1jdLSX+m9SX6HK1bX6YJYpSKK8xuWUjjua2ZZz1X1T
         pFn0BqBqr511K8GGhFwYV3MJs2f1gyZorNG93DO1Yr5fiEZiSbKoCZS4unbAUC4Gt2h5
         zux1c8wC9g+uKQmexmpajoMChFMoKoeXsOiGhY6euc0QRGLy4f0lXYGif8jBQesYJj75
         i/ua4mqtDFgFtSV0i9Cmitfc2X65271zPQIRfHWHLO+z2z9UPtBzkqgDjhTwKCmGwbJ9
         RU9b5+Hi+55yiCgAm3sMOsD7FNhVnvBRiEoMqrlZuspXbdXIEzrEWvF5j5zaCFl1gFW4
         xXAQ==
X-Gm-Message-State: AOAM531EqLK8iy0ERqPwDPyAO/V5i3Ay2lzC3mewdh8P0I0qFRPa0TAp
        jVqWrGrjMbzyL61N/axNSI8uVg==
X-Google-Smtp-Source: ABdhPJzV9I/1jO0ij8KF1ngerhZUW0uge9IpUFXv4nROGyQiw1Pt6a1Zao6nhgJZ9LT4b07U+qKwrA==
X-Received: by 2002:a05:6602:2f0a:b0:64f:99ed:d732 with SMTP id q10-20020a0566022f0a00b0064f99edd732mr1851747iow.150.1649968569030;
        Thu, 14 Apr 2022 13:36:09 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:e02:decc:64d3:b1d3])
        by smtp.gmail.com with ESMTPSA id h7-20020a056e021d8700b002ca753db1c9sm1660605ila.77.2022.04.14.13.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 13:36:08 -0700 (PDT)
Date:   Thu, 14 Apr 2022 14:36:03 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Barry Song <21cnbao@gmail.com>
Cc:     Stephen Rothwell <sfr@rothwell.id.au>,
        Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
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
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        x86 <x86@kernel.org>, Brian Geffon <bgeffon@google.com>,
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
Message-ID: <YliFs3NOHeo2LeXl@google.com>
References: <20220407031525.2368067-1-yuzhao@google.com>
 <20220407031525.2368067-7-yuzhao@google.com>
 <CAGsJ_4xqm4L4E4dW4PPHos8Ed9ej6hph28tSGy21Re3u7WiuOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4xqm4L4E4dW4PPHos8Ed9ej6hph28tSGy21Re3u7WiuOA@mail.gmail.com>
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

On Thu, Apr 14, 2022 at 06:03:10PM +1200, Barry Song wrote:
> 
> On Thu, Apr 7, 2022 at 3:16 PM Yu Zhao <yuzhao@google.com> wrote:
> >
> > +
> > +static int isolate_folios(struct lruvec *lruvec, struct scan_control *sc, int swappiness,
> > +                         int *type_scanned, struct list_head *list)
> > +{
> > +       int i;
> > +       int type;
> > +       int scanned;
> > +       int tier = -1;
> > +       DEFINE_MIN_SEQ(lruvec);
> > +
> > +       VM_BUG_ON(!seq_is_valid(lruvec));
> > +
> > +       /*
> > +        * Try to make the obvious choice first. When anon and file are both
> > +        * available from the same generation, interpret swappiness 1 as file
> > +        * first and 200 as anon first.
> > +        */
> 
> Has this changed the ABI of swapiness?

No.

> or it is only something
> meaningful for the internal code?

This is how swappiness is interpreted.

> if so, can we rename it to
> something else? otherwise, it is quite confusing.

Feel free to suggest something.

> it seems 1 is set internally as a magic number here:
> +static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct
> scan_control *sc)
> +{
> + ...
> + else if (!cgroup_reclaim(sc) && get_swappiness(lruvec, sc))
> + swappiness = 1;
> + else
> + swappiness = 0;
> + }
> obviously this swappiness is neither /proc/sys/vm/swappiness  nor
> /sys/fs/cgroup/memory/<group>/>memory.swappiness, right?

Right.

> > @@ -3928,6 +4726,11 @@ static void age_active_anon(struct pglist_data *pgdat,
> >         struct mem_cgroup *memcg;
> >         struct lruvec *lruvec;
> >
> > +       if (lru_gen_enabled()) {
> > +               lru_gen_age_node(pgdat, sc);
> > +               return;
> > +       }
> 
> is it really a good place for  lru_gen_age_node() since the function
> is named age_active_anon()
> but here you are doing aging for both anon and file pages?

Yes.

> obviously
> lru_gen_age_node() is not
> doing "age active anon".

We can rename it if you have something in mind.
