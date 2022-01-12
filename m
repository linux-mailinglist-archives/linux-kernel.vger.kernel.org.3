Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B0548BF7A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351389AbiALIGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351388AbiALIF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:05:58 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CE0C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:05:57 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id q5so2473649ioj.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pyw7GGJuc0hBOwmctWzhV5NE4YVpQMRChj4A/vKkkr4=;
        b=Z+qDYRtw4H7+Xhjv9rXrIpQm265j7kHSqnL11bYAwhEcsXLlyCTMo4DGQMSeyO22BX
         IjKFWkNtLTgesG7Dn90valcqe2XUfiJ5fv7aqbCbm0gtpV2aRAJ/6H/f6hZL/ZpJXmh9
         6cbze64uaBbCwy+JMGzKYboFBVl+cMocBG9e5v+YJmevCYJ0bH0chy6VC9DXMG/IAWO8
         bwJQ8FzyaP+8SF9sUohyCD0DwZkzr1qLhTz8HHaHRF9v1ge8ypjGonWRsQH18MvTwvnc
         YR1tfC6ouTRJowyCKbTSk44cHOVHtB/1i7achYXAt7eVF4T5cfzcr61g8W0DZC6jFbjr
         H3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pyw7GGJuc0hBOwmctWzhV5NE4YVpQMRChj4A/vKkkr4=;
        b=yINvPH00hPbsRG6I96MoTOIecjt7o8pcLuEP5wHf3+fulEDAKS89/x47Ex9VGTVhSG
         dg+x+4ChIHtN52yZFVsMUL1Xf7mL7Zq6c0QVpHdE2ayWef22Ok1ULmUywfwEI/turulr
         2bY8hvnMWiwWlDr78OWXGDxiFO9s2UArKEfYSc3w37MAEntlJId8eFvyS+HbwxrFF2rQ
         9Ps2QlI5j2J5IERjSAaNPniujqYiep68ZxCxQ1aDMpD+3ZW546+tjVzKwlIXw1CgKVHG
         SA3+RrFMFRfMLmplPkZHjGM9T43SD/KYFWJUkKshy4J/0Qd9bvlmwvgU9ZkUPv9QKdl2
         YRJQ==
X-Gm-Message-State: AOAM533cOPcMaxvZ17wKhTnLNZFvghWjOtuPg13TJ1IQpWBE/Z8WgsQD
        f74Qe1hRzW+sT+71L9ILPN2/2A==
X-Google-Smtp-Source: ABdhPJxS1FZp/i/SPqHdj4pGDjPeqMB4/I876fPMsGFsuuH99sxVcJWSlXkHHhif8uuR0sVcS/X06A==
X-Received: by 2002:a05:6638:d01:: with SMTP id q1mr4064289jaj.248.1641974756815;
        Wed, 12 Jan 2022 00:05:56 -0800 (PST)
Received: from google.com ([2620:15c:183:200:b6b6:70f4:b540:6383])
        by smtp.gmail.com with ESMTPSA id c3sm1856408iow.28.2022.01.12.00.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 00:05:56 -0800 (PST)
Date:   Wed, 12 Jan 2022 01:05:51 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
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
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>
Subject: Re: [PATCH v6 7/9] mm: multigenerational lru: eviction
Message-ID: <Yd6L349/aJd8hbYn@google.com>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-8-yuzhao@google.com>
 <87czkyzhfe.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czkyzhfe.fsf@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 04:07:57PM +0530, Aneesh Kumar K.V wrote:
> ...
> 
>  +static int isolate_folios(struct lruvec *lruvec, struct scan_control *sc, int swappiness,
> > +			  int *type_scanned, struct list_head *list)
> > +{
> > +	int i;
> > +	int type;
> > +	int scanned;
> > +	int tier = -1;
> > +	DEFINE_MIN_SEQ(lruvec);
> > +
> > +	VM_BUG_ON(!seq_is_valid(lruvec));
> > +
> > +	/*
> > +	 * Try to make the obvious choice first. When anon and file are both
> > +	 * available from the same generation, interpret swappiness 1 as file
> > +	 * first and 200 as anon first.
> > +	 */
> > +	if (!swappiness)
> > +		type = 1;
> > +	else if (min_seq[0] < min_seq[1])
> > +		type = 0;
> > +	else if (swappiness == 1)
> > +		type = 1;
> > +	else if (swappiness == 200)
> > +		type = 0;
> > +	else
> > +		type = get_type_to_scan(lruvec, swappiness, &tier);
> > +
> 
> Wondering wether it will make it simpler to use
> #define ANON 0
> #define FILE 1
> 
> and then
> 	else if (min_seq[ANON] < min_seq[FILE])
> 		type = ANON;
> 
> The usage of 0/1 across code do confuse

I agree, and I plan to do this later because the existing code uses
this convention and needs renaming too.
