Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574EE48AC1E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 12:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238373AbiAKLFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 06:05:16 -0500
Received: from foss.arm.com ([217.140.110.172]:44722 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238096AbiAKLFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 06:05:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17A9E1FB;
        Tue, 11 Jan 2022 03:05:14 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.1.156])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A49723F766;
        Tue, 11 Jan 2022 03:05:12 -0800 (PST)
Date:   Tue, 11 Jan 2022 11:05:06 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     He Ying <heying24@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, marcan@marcan.st,
        maz@kernel.org, joey.gouly@arm.com, pcc@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Make CONFIG_ARM64_PSEUDO_NMI macro wrap all the
 pseudo-NMI code
Message-ID: <Yd1kYu8CMlGYeb20@FVFF77S0Q05N>
References: <20220107085536.214501-1-heying24@huawei.com>
 <Ydg939btY/bzEAe4@FVFF77S0Q05N>
 <bd82d240-34d7-4df9-650b-c039555f05e3@huawei.com>
 <YdwX5RTVbw8veM98@FVFF77S0Q05N>
 <168f7e83-e815-f10e-3a43-8529aab77f1e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <168f7e83-e815-f10e-3a43-8529aab77f1e@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 04:52:32PM +0800, He Ying wrote:
> 在 2022/1/10 19:26, Mark Rutland 写道:
> > On Mon, Jan 10, 2022 at 11:00:43AM +0800, He Ying wrote:
> > > 在 2022/1/7 21:19, Mark Rutland 写道:
> > > > On Fri, Jan 07, 2022 at 03:55:36AM -0500, He Ying wrote:
 
> > Due to the large numbers, I suspect this must be due to a specific fast-path,
> > and it's possible that this is due to secondary factors (e.g. alignment of
> > code) rather than the pseudo-NMK code itself.
> > 
> > We need to narrow down *where* time is being spent. Since it appears that this
> > is related to the local IRQ state management, it isn't likely that we can
> > determine that reliably with the PMU. Given that, I think the first step is to
> > reproduce the result elsewhere, for which we will need some plublicly available
> > test-case.
> 
> As said before, I asked our collegues how they did the ARP test. In one word,
> a very small performance regression may bring the big change to the test
> result.
> 
> I feel very sorry for missing this important information. So, this patch may
> improve the performance a little and then lead to the big change to the
> test result.

No problem; thanks for confirming.

[...]

> OK, I see. What do you think if I send a v2 patch that only adds ifdeffery
> to
> 
> arch/arm64/kernel/entry.S and leave the rework to ALERNATIVE behind?

I think that would be reasonable given we do that for other bits in entry.S;
I'd be happy with such a patch.

Thanks,
Mark.
