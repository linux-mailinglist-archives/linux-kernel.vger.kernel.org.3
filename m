Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D32448CF31
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 00:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbiALXnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 18:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbiALXnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 18:43:21 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4113C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 15:43:20 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id w9so5933096iol.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 15:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BaIEd4azRffEg4unDNu3vsM967zzodtSvI+HO9xblew=;
        b=L8O+0OVX45MTK0bIwZtr0Xzs4Q8XHHPBf0k+YHk1TfBnsWsX6/eh9SUyPwi6iG3kwK
         0iRhOsvBovQoAUaLCU6lkfmXa2bQv09r3ziUwv8plzoDrnXAL+LCmK+Gh93Gr9G2f1Xi
         +fBCf+WKROvUyqQI8zr56hOdcK7pYa1MSLCsh/dQWKy89Zyu8o3Qts+TYFW47ig/AxXe
         WcLnJPcdEvPRs10Jz/86rnfHcgUAk3HMOTiiQJ8+3eT6tJ2pE6cMLpDLHzhMB7Irj0V7
         Gc5RlGs2TgG2NGpk4Y//DcGwpcbmYiXbiN+ZV4ezeAxjRn9AnHXQ7KikX7PsdSTZqVfL
         zavw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BaIEd4azRffEg4unDNu3vsM967zzodtSvI+HO9xblew=;
        b=JimhRJltkF6Wk3aGdx3MfAxIo1RlOVFycx0LqiGKa0u+ZGWbRzpl7ah85ZACf9Jix5
         boe09phzChcXFvaIm9/ceF+UoyJ9hsTJF9RRwIsu5WWry8rNaOO0qXgrQO97dNLfAaQF
         z2axt0Upz0dQXEnP+azzusOEIVNYcphePXn8SNF0jGHn+Pps/AAOcF2Wbhzw/UYi4PU/
         7rZEmcHAJ0kpOtBDnw7BajXrQQHz685QehFX46d5yeLv/letuRr4W/CpWUnrHGQRrGYZ
         0/F2yBBKLFLsVH9P6k/ORiuuNYDj4uz+H5erOwiTaMcvbt7sK5/kcOf1/o1fwhnnW1f6
         9BJA==
X-Gm-Message-State: AOAM530BksSua0b51FYs56F/NeaZgUMAgdRdp29kBM0ZVbwy0YE9m/jT
        ijzxkOIoQ6xjojzYwNUEOkPUHg==
X-Google-Smtp-Source: ABdhPJwjyIAd/qG5g5lRDwYWNJCUGBoB3cLknLrXPs+wVsBV2bmPfZwZAO5qzY0E/Fj5GwfSdS77gQ==
X-Received: by 2002:a6b:dc0d:: with SMTP id s13mr1002999ioc.186.1642030999695;
        Wed, 12 Jan 2022 15:43:19 -0800 (PST)
Received: from google.com ([2620:15c:183:200:ac2b:c4ef:2b56:374c])
        by smtp.gmail.com with ESMTPSA id y8sm914835ilu.72.2022.01.12.15.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 15:43:19 -0800 (PST)
Date:   Wed, 12 Jan 2022 16:43:15 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>
Subject: Re: [PATCH v6 6/9] mm: multigenerational lru: aging
Message-ID: <Yd9nk0qlK3jK9baN@google.com>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-7-yuzhao@google.com>
 <Ydxlg5rI4ZvODQvF@dhcp22.suse.cz>
 <Yd4oaUwHkpadAKwe@google.com>
 <Yd6q0QdLVTS53vu4@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd6q0QdLVTS53vu4@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 11:17:53AM +0100, Michal Hocko wrote:
> On Tue 11-01-22 18:01:29, Yu Zhao wrote:
> > On Mon, Jan 10, 2022 at 05:57:39PM +0100, Michal Hocko wrote:
> > > On Tue 04-01-22 13:22:25, Yu Zhao wrote:
> > > [...]
> > > > +static void walk_mm(struct lruvec *lruvec, struct mm_struct *mm, struct lru_gen_mm_walk *walk)
> > > > +{
> > > > +	static const struct mm_walk_ops mm_walk_ops = {
> > > > +		.test_walk = should_skip_vma,
> > > > +		.p4d_entry = walk_pud_range,
> > > > +	};
> > > > +
> > > > +	int err;
> > > > +#ifdef CONFIG_MEMCG
> > > > +	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
> > > > +#endif
> > > > +
> > > > +	walk->next_addr = FIRST_USER_ADDRESS;
> > > > +
> > > > +	do {
> > > > +		unsigned long start = walk->next_addr;
> > > > +		unsigned long end = mm->highest_vm_end;
> > > > +
> > > > +		err = -EBUSY;
> > > > +
> > > > +		rcu_read_lock();
> > > > +#ifdef CONFIG_MEMCG
> > > > +		if (memcg && atomic_read(&memcg->moving_account))
> > > > +			goto contended;
> > > > +#endif
> > > 
> > > Why do you need to check for moving_account?
> > 
> > This check, if succeeds, blocks memcg migration.
> 
> OK, I can see that you rely on the RCU here for the synchronization. A
> comment which mentions mem_cgroup_move_charge would be helpful for
> clarity.

Will do

> Is there any reason you are not using folio_memcg_lock in the
> pte walk instead?

We have a particular lruvec (the first arg), hence a particular memcg
to lock. But we don't have a particular page to lock.
