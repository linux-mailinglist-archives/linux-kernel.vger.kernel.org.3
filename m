Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D924AD3CC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351346AbiBHInn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351856AbiBHInW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:43:22 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0C1C03FED4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:43:08 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id p63so20166753iod.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Co3BUFT9beNFmBZeCDmBd4UzULJVNB7vW9mGtuUcPnM=;
        b=ohrEubPZBSY43eIQ5NQCK0B4O7CFbJ/HpKhbez278dzMobVWnfF2oOF3sOrc74B4QQ
         U41143EltG56aXzdjjzZm/GU4cXZGtH83mvjb2qCX+F563MQ3fpmYtycdSu5kzshBVG8
         DqWBAyQynUJHXWlGwhPQOK9if98mUmdwJ8Ir1N0avBzJ6forpYNFs3XqdV58s5cnDsMU
         W4bwCOSsmJHJTrTl6UvTk9gc5iIIE+0JWF2n38A2tLyC+ff1QK0lTH4UBYtz+UVESmVG
         gAIT3JizZEMLq6e110ENj51HMCyTWq0cX5c1QvY5BLrH4EK1/TJW9WkstrnYoO1NG7hG
         geNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Co3BUFT9beNFmBZeCDmBd4UzULJVNB7vW9mGtuUcPnM=;
        b=WAFfTvfVoz5fRDdYyEpUyWRQZyFEu3rb1M4xLoO5nK8DkFbt6000D3tGWNV1PXxWb+
         aYFR4jprb9FjldkxKj4SQ/enBN8kjRFIJAH3nFUw3NXf1bFrvUT8OYPqh1T0lvDBCyNw
         +O/9yZI64GGICqgoo24fPTrdo0NX9qt65+/3KghfZldXLvn8QuH+YIDMvXKnf+J/vtAN
         iniYAbn2pJRO5WSfSllHpO4DRMNman1PwtFeNHpicN4Iuzodx+aB4xLQzTZYsdsNXiS2
         J56zXkEe4oHK/kn9maPzoA5kD5l+0eeVqlYzqCfSKir9hI5Ej5FiVBONOnCVKhnkWaKM
         1Lyg==
X-Gm-Message-State: AOAM530/oIJ8RalVxl7L3Ca7LOuF3LoUG3XbQZ+x5cxeO24uFKFJT7lC
        iRnpEEjnbeqj6aBo0G11lOkjrw==
X-Google-Smtp-Source: ABdhPJzBcDi7EsMql8HPyIUlcRBl/OsFwSyoeS5mkLvsu+udWvl2GtuObFdyWK2J++yBEFuvf+uvKg==
X-Received: by 2002:a05:6638:1501:: with SMTP id b1mr1620304jat.251.1644309787998;
        Tue, 08 Feb 2022 00:43:07 -0800 (PST)
Received: from google.com ([2620:15c:183:200:5f31:19c3:21f5:7300])
        by smtp.gmail.com with ESMTPSA id x7sm3011504ilp.88.2022.02.08.00.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 00:43:07 -0800 (PST)
Date:   Tue, 8 Feb 2022 01:43:03 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Larabel <Michael@michaellarabel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Brian Geffon <bgeffon@google.com>,
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
        Sofia Trinh <sofia.trinh@edi.works>
Subject: Re: [PATCH v7 10/12] mm: multigenerational LRU: thrashing prevention
Message-ID: <YgItF/LcaTC6mpLN@google.com>
References: <20220208081902.3550911-1-yuzhao@google.com>
 <20220208081902.3550911-11-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208081902.3550911-11-yuzhao@google.com>
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

On Tue, Feb 08, 2022 at 01:19:00AM -0700, Yu Zhao wrote:
> Add /sys/kernel/mm/lru_gen/min_ttl_ms for thrashing prevention, as
> requested by many desktop users [1].
> 
> When set to value N, it prevents the working set of N milliseconds
> from getting evicted. The OOM killer is triggered if this working set
> can't be kept in memory. Based on the average human detectable lag
> (~100ms), N=1000 usually eliminates intolerable lags due to thrashing.
> Larger values like N=3000 make lags less noticeable at the risk of
> premature OOM kills.

Refactored min_ttl into a separate patch as requested here:
https://lore.kernel.org/linux-mm/YdxSUuDc3OC4pe+f@dhcp22.suse.cz/

<snipped>
