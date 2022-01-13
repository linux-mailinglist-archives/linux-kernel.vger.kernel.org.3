Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A81648D4A3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 10:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbiAMJA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 04:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiAMJAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 04:00:02 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29787C06173F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 01:00:01 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id v1so7502175ioj.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 01:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TCw1GfHPeWJbnERy4xEg3GTF1yG8dQgLTkiWN1Lhx7M=;
        b=LALRlCh10PAc2bMPcvCm3naDkNyaorzpK7LKTAzW8WcrfS+3qduoVJglwUvwzpz/rI
         Hiav0QqojwxXr+qinZ2+8cHUcpguJl8rZcgH5uLqcJLimZRP2Lj4mLAPuWb7fpGDW236
         raP1bMtESLJyb4emruZI5IKskHl4kyTb+mCXBYiuxh8s/e+qVk7AIMI+qhLRCuX9E+jw
         jh/nRY+5FxshSj+m6Bm0MSDY9Uc/+FAvGvefg9VnEHJuHnnGxW1f5f5Dr68eOcjXWYSM
         Qo3v+n9PiJm0CNhU3WBtkH5TtYPl2RzilyL4OcMeLUZhVL3gDCt5Bn8DdVFpz+/2tppm
         IN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TCw1GfHPeWJbnERy4xEg3GTF1yG8dQgLTkiWN1Lhx7M=;
        b=SVjhWlWbxS/ju4FykZSiE9qFO0rSsRwBuG6qq0eq15bYmNSkP0VxCflEiE5FOnLjOL
         8cIOFFRk1pKVpAQBKFlBYK4MMsqxlShLovuAtNHtfb0iN1Mrtdh7y6W2nNzQnMyO92Nz
         lGpL+aPkt0eHO1qgrmTmoC5zbjwcBki8RXi8NQX+Fy1fpVkDCW4jSOw5hqAG68tQsNHF
         n+QjyvfFEQoDXWM9LoQhSieLW9UpJ24KmK35M+1vnWITTQUlorKgbldznb8m4TXZYRUf
         7ekOdqi/ruwFmV4KaJBa4ryp6J61RUz+O1reQGo1HokXuck0y/KpcgE6zVQow0IxCj19
         xSlw==
X-Gm-Message-State: AOAM533zgIKivyNAXhNW7k4XquFIOMm2D/QHuqlFwLYrcODnRd06czp/
        I/SzJoZ9tjhoXw+filkspm3O1g==
X-Google-Smtp-Source: ABdhPJxGrNEwdDTbSmbuKwltjfvyZ/ZjlF56GY0VO4e9TxcYm3q1KqtWE2AnPXYSj3SmpSSvCxff4Q==
X-Received: by 2002:a05:6638:2204:: with SMTP id l4mr1147691jas.142.1642064399718;
        Thu, 13 Jan 2022 00:59:59 -0800 (PST)
Received: from google.com ([2620:15c:183:200:ac2b:c4ef:2b56:374c])
        by smtp.gmail.com with ESMTPSA id f20sm1810130ile.14.2022.01.13.00.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 00:59:59 -0800 (PST)
Date:   Thu, 13 Jan 2022 01:59:54 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
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
        page-reclaim@google.com, x86@kernel.org
Subject: Re: [PATCH v6 0/9] Multigenerational LRU Framework
Message-ID: <Yd/qClw7x7SxmnJw@google.com>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <11900935.O9o76ZdvQC@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11900935.O9o76ZdvQC@natalenko.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 09:56:58PM +0100, Oleksandr Natalenko wrote:
> Hello.
> 
> On úterý 4. ledna 2022 21:22:19 CET Yu Zhao wrote:
> > TLDR
> > ====
> > The current page reclaim is too expensive in terms of CPU usage and it
> > often makes poor choices about what to evict. This patchset offers an
> > alternative solution that is performant, versatile and
> > straightforward.

<snipped>

> For the series:
> 
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> 
> I run this (and one of the previous spins) on nine machines (physical, virtual, workstations, servers) for quite some time with no hassle.
> 
> Thanks for your job, and please keep me in Cc once you post new spins. I'm more than happy to deploy those across the fleet.

Thanks, Oleksandr. And if I may take the liberty of introducing you as:

   Oleksandr - the post-factum kernel maintainer
               https://gitlab.com/post-factum/pf-kernel

in addition to other downstream kernel maintainers I've introduced:

>   Alexandre - the XanMod kernel maintainer
>               https://xanmod.org
>
>   Brian     - the Chrome OS kernel memory maintainer
>               https://www.chromium.org
>
>   Jan       - the Arch Linux Zen kernel maintainer
>               https://archlinux.org
>
>   Steven    - the Liquorix kernel maintainer
>               https://liquorix.net
>
>   Suleiman  - the ARCVM (Android downstream) kernel memory maintainer
>               https://chromium.googlesource.com/chromiumos/third_party/kernel
