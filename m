Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BDD489B93
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 15:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbiAJOtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 09:49:50 -0500
Received: from shark1.inbox.lv ([194.152.32.81]:45432 "EHLO shark1.inbox.lv"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230426AbiAJOtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 09:49:49 -0500
Received: from shark1.inbox.lv (localhost [127.0.0.1])
        by shark1-out.inbox.lv (Postfix) with ESMTP id 048B61118140;
        Mon, 10 Jan 2022 16:49:48 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.lv; s=30062014;
        t=1641826188; bh=v8M5awXlRgm8CQPFWrxz5Yn/2aXPYkjUaIMnTlnA2j4=;
        h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
         Content-Type:X-ESPOL:from:date;
        b=ETkKyFBSqlmwxhHpOAPlyeai+0JG5EsOAxPGfHaxqA+mKrNVrafW5wHuqE9QQOdMj
         fkYp9FiHF5ouPE742u0Z4OYws+vdRodvMKwZg4yPdnwSk2m8KG7fxrtK2j6yOU0Fju
         hYNdJxDDysBQmZCy8v1k5aZExcslKHO6gl19u3Sw=
Received: from localhost (localhost [127.0.0.1])
        by shark1-in.inbox.lv (Postfix) with ESMTP id EDA2011180B4;
        Mon, 10 Jan 2022 16:49:47 +0200 (EET)
Received: from shark1.inbox.lv ([127.0.0.1])
        by localhost (shark1.inbox.lv [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id 49NQ99mX1Zp1; Mon, 10 Jan 2022 16:49:47 +0200 (EET)
Received: from mail.inbox.lv (pop1 [127.0.0.1])
        by shark1-in.inbox.lv (Postfix) with ESMTP id 9C3971118085;
        Mon, 10 Jan 2022 16:49:47 +0200 (EET)
Date:   Mon, 10 Jan 2022 23:49:32 +0900
From:   Alexey Avramov <hakavlad@inbox.lv>
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
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org, hakavlad@gmail.com
Subject: Re: [PATCH v6 0/9] Multigenerational LRU Framework
Message-ID: <20220110234932.6eb6c356@mail.inbox.lv>
In-Reply-To: <20220104202227.2903605-1-yuzhao@google.com>
References: <20220104202227.2903605-1-yuzhao@google.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: OK
X-ESPOL: AJqEQH8B6gpL2qWiUuRh4Or6x9a2SFs9vyXmrMk96HRYtbrGu9h2dXPmZYmvRkKl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note that with vm.swappiness=0, the vm.watermark_scale_factor value does
not affect the swap possibility: MGLRU ignores sc->file_is_tiny.

With the classic 2-gen LRU swapping goes well at swappiness=0 and
high vm.watermark_scale_factor, which is expected according to the
documentation:
"At 0, the kernel will not initiate swap until the amount of free and
file-backed pages is less than the high watermark in a zone." [1]

With vm.swappiness=0, no swap occurs with any vm.watermark_scale_factor
value with MGLRU.

I used to see in practice (with MGLRU v3) the impossibility of swapping 
when vm.swappiness=0 and vm.watermark_scale_factor=1000.

At a minimum, this will require updating the documentation for
vm.swappiness.

BTW, why MGLRU doesn't use something like sc->file_is_tiny?

[1] https://github.com/torvalds/linux/blob/v5.16/Documentation/admin-guide/sysctl/vm.rst#swappiness
