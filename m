Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5211148747B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 10:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346358AbiAGJGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 04:06:18 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55142 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236746AbiAGJGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 04:06:17 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7DF231F39C;
        Fri,  7 Jan 2022 09:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641546376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/+rkleY2pIdK7PXNX7lUi9qQ2IGYdAkkl5TG1LGhbIQ=;
        b=sBVGhGr6l4U+RSvPC9eGfELzbL4s1aqGpH+E88SrDgSd/jnjr3QQB2+xND6183ZRKWEMeP
        Zj4IiU4WZKdPGQc224yRvWu9/WIRCgHUCwF8nMPSEhluQyxZyZx4Gf01omL4jcmSiuyOIZ
        nvJq0a2R8LkwcGxxmHToeJFaVmCY4aE=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BD8D9A3B8C;
        Fri,  7 Jan 2022 09:06:15 +0000 (UTC)
Date:   Fri, 7 Jan 2022 10:06:15 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Yu Zhao <yuzhao@google.com>
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
Subject: Re: [PATCH v6 5/9] mm: multigenerational lru: mm_struct list
Message-ID: <YdgChw4vNb43XsU/@dhcp22.suse.cz>
References: <20220104202227.2903605-1-yuzhao@google.com>
 <20220104202227.2903605-6-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104202227.2903605-6-yuzhao@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04-01-22 13:22:24, Yu Zhao wrote:
> To exploit spatial locality, the aging prefers to walk page tables to
> search for young PTEs. And this patch paves the way for that.
> 
> An mm_struct list is maintained for each memcg, and an mm_struct
> follows its owner task to the new memcg when this task is migrated.

How does this work actually for the memcg reclaim? I can see you
lru_gen_migrate_mm on the task migration. My concern is, though, that
such a task leaves all the memory behind in the previous memcg (in
cgroup v2, in v1 you can opt in for charge migration). If you move the
mm to a new memcg then you age it somewhere where the memory is not
really consumed.
-- 
Michal Hocko
SUSE Labs
