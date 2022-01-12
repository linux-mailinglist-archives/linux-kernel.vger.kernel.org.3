Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE1F48C254
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 11:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239706AbiALKcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 05:32:00 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36096 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239182AbiALKb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 05:31:59 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 347B21F461;
        Wed, 12 Jan 2022 10:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641983518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EZgKoHTkYozkeRvOASqvTf69IaXwtK5eJNoCLH3AhbI=;
        b=sanr4+/wNNMdO7ubzNxEAwyQj+vXii4/Tvu1+l3/Jvg+MJQZelEeBMZWNYSwkFPUJ8diEZ
        EyIbzejfDJPUj5HKVis1EWWBt8y6/TB9jz76pZOT2tL1HkmEJ8doGJf7TcY4wZZTL/SiCA
        AcQLqOB2y7cJjIJAjfTV559SuUS++bg=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BB99CA3B85;
        Wed, 12 Jan 2022 10:31:57 +0000 (UTC)
Date:   Wed, 12 Jan 2022 11:31:57 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH v6 8/9] mm: multigenerational lru: user interface
Message-ID: <Yd6uHYtjGfgqjDpw@dhcp22.suse.cz>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-9-yuzhao@google.com>
 <YdwKB3SfF7hkB9Xv@kernel.org>
 <Yd6S6Js1W4AnFFmv@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd6S6Js1W4AnFFmv@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-01-22 01:35:52, Yu Zhao wrote:
[...]
> But I saw people not following this practice, and I'm also tempted to
> do so. Can anybody remind me whether it's considered a bad practice to
> have code changes and Kconfig changes in the same patch?

If you want to have the patch series bisectable then it is preferable to
add kconfig options early so that the code is enabled in the respective
steps. Sometimes that can be impractical though (e.g. when the feature is
incomplete at that stage).
-- 
Michal Hocko
SUSE Labs
