Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB7E46B980
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 11:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235346AbhLGKyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 05:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbhLGKyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 05:54:15 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0D1C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 02:50:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C32A1CE1A6F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 10:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522D0C341C8;
        Tue,  7 Dec 2021 10:50:40 +0000 (UTC)
Date:   Tue, 7 Dec 2021 10:50:36 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     will@kernel.org, wangkefeng.wang@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wuxu.wu@huawei.com, Hewenliang <hewenliang4@huawei.com>
Subject: Re: [PATCH] arm64: mm: Use asid2idx() and asid feature macro for
 cleanup
Message-ID: <Ya88fFJC4Kdjyb+B@arm.com>
References: <4aaabf1b-00c3-3365-e371-9d97dc0c06ab@huawei.com>
 <Ya44+GAmeGBFVAad@arm.com>
 <8f4ec1cd-fbb7-10f8-b515-500400308492@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f4ec1cd-fbb7-10f8-b515-500400308492@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 10:21:26AM +0800, Yunfeng Ye wrote:
> On 2021/12/7 0:23, Catalin Marinas wrote:
> > On Thu, Oct 28, 2021 at 08:27:23PM +0800, Yunfeng Ye wrote:
> >> @@ -162,7 +162,7 @@ static u64 new_context(struct mm_struct *mm)
> >>  	u64 generation = atomic64_read(&asid_generation);
> >>
> >>  	if (asid != 0) {
> >> -		u64 newasid = generation | (asid & ~ASID_MASK);
> >> +		u64 newasid = generation | asid2idx(asid);
> >>
> >>  		/*
> >>  		 * If our current ASID was active during a rollover, we
> >> @@ -306,7 +306,7 @@ unsigned long arm64_mm_context_get(struct mm_struct *mm)
> >>  out_unlock:
> >>  	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
> >>
> >> -	asid &= ~ASID_MASK;
> >> +	asid = asid2idx(asid);
> > 
> > While functionally the code is the same, I don't think this was the
> > intention of asid2idx(). It's meant to provide an index into asid_map,
> > while the ASID_MASK lines isolate the asid number and add a new
> > generation to it.
> 
> The commit 0c8ea531b774 ("arm64: mm: Allocate ASIDs in pairs") introduce the
> asid2idx and idx2asid macro, but these macros is not really useful after the
> commit f88f42f853a8 ("arm64: context: Free up kernel ASIDs if KPTI is not in use").
> 
> I think "(asid & ~ASID_MASK)" can be instead by a macro, it is the same code with
> asid2idx(). Can it be renamed?  (eg, ctxid2asid)

Yes, that would work.

-- 
Catalin
