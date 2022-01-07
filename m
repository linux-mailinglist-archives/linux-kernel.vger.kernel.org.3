Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62A34875D4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 11:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237562AbiAGKm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 05:42:56 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36016 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236979AbiAGKmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:42:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F759B82564
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 10:42:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99F4C36AE0;
        Fri,  7 Jan 2022 10:42:50 +0000 (UTC)
Date:   Fri, 7 Jan 2022 10:42:47 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jianyong Wu <Jianyong.Wu@arm.com>
Cc:     "will@kernel.org" <will@kernel.org>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "david@redhat.com" <david@redhat.com>,
        "quic_qiancai@quicinc.com" <quic_qiancai@quicinc.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gshan@redhat.com" <gshan@redhat.com>,
        Justin He <Justin.He@arm.com>, nd <nd@arm.com>
Subject: Re: [PATCH v3] arm64/mm: avoid fixmap race condition when create pud
 mapping
Message-ID: <YdgZJ/mBG+BCxmEv@arm.com>
References: <20211216082812.165387-1-jianyong.wu@arm.com>
 <YdXdjcJ7jbnkFsqp@arm.com>
 <AM9PR08MB7276E0DE6B4224C22B20A89CF44C9@AM9PR08MB7276.eurprd08.prod.outlook.com>
 <YdcRLohx777jzWah@arm.com>
 <AM9PR08MB7276B412F02CA0431E30E06CF44D9@AM9PR08MB7276.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR08MB7276B412F02CA0431E30E06CF44D9@AM9PR08MB7276.eurprd08.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 09:10:57AM +0000, Jianyong Wu wrote:
> Hi Catalin,
> 
> I roughly find the root cause.
>  alloc_init_pud will be called at the very beginning of kernel boot in create_mapping_noalloc where no memory allocator is initialized. But lockdep check may need allocate memory. So, kernel take exception when acquire lock.(I have not found the exact code that cause this issue) that's say we may not be able to use a lock so early.
> 
> I come up with 2 methods to address it. 
> 1) skip dead lock check at the very beginning of kernel boot in lockdep code.
> 2) provided 2 two versions of __create_pgd_mapping, one with lock in
> it and the other without. There may be no possible of race for memory
> mapping at the very beginning time of kernel boot, thus we can use the
> no lock version of __create_pgd_mapping safely.
> In my test, this issue is gone if there is no lock held in
> create_mapping_noalloc. I think create_mapping_noalloc is called early
> enough to avoid the race conditions of memory mapping, however, I have
> not proved it.

I think method 2 would work better but rather than implementing new
nolock functions I'd add a NO_LOCK flag and check it in
alloc_init_pud() before mutex_lock/unlock. Also add a comment when
passing the NO_LOCK flag on why it's needed and why there wouldn't be
any races at that stage (early boot etc.)

Thanks.

-- 
Catalin
