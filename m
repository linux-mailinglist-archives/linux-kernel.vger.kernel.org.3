Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B734B0951
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 10:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238389AbiBJJTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 04:19:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbiBJJTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:19:31 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D2C4F5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 01:19:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B02B3113E;
        Thu, 10 Feb 2022 01:19:32 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1E173F718;
        Thu, 10 Feb 2022 01:19:28 -0800 (PST)
Date:   Thu, 10 Feb 2022 09:19:10 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        bp@alien8.de, dave.hansen@linux.intel.com, frederic@kernel.org,
        james.morse@arm.com, joey.gouly@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, tglx@linutronix.de,
        valentin.schneider@arm.com, will@kernel.org
Subject: Re: [PATCH v3 6/7] arm64: entry: centralize premeption decision
Message-ID: <YgTYcmrKAmHzU2im@FVFF77S0Q05N>
References: <20220209153535.818830-1-mark.rutland@arm.com>
 <20220209153535.818830-7-mark.rutland@arm.com>
 <YgQDrGaWerGM3B2C@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgQDrGaWerGM3B2C@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 06:10:52PM +0000, Catalin Marinas wrote:
> On Wed, Feb 09, 2022 at 03:35:34PM +0000, Mark Rutland wrote:
> > For historical reasons, the decision of whether or not to preempt is
> > spread across arm64_preempt_schedule_irq() and __el1_irq(), and it would
> > be clearer if this were all in one place.
> > 
> > Also, arm64_preempt_schedule_irq() calls lockdep_assert_irqs_disabled(),
> > but this is redundant, as we have a subsequent identical assertion in
> > __exit_to_kernel_mode(), and preempt_schedule_irq() will
> > BUG_ON(!irqs_disabled()) anyway.
> > 
> > This patch removes the redundant assertion and centralizes the
> > preemption decision making within arm64_preempt_schedule_irq().
> > 
> > Other than the slight change to assertion behaviour, there should be no
> > functional change as a result of this patch.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: James Morse <james.morse@arm.com>
> > Cc: Joey Gouly <joey.gouly@arm.com>
> > Cc: Valentin Schneider <valentin.schneider@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> 
> I acked this patch in v2, has anything changed? Well, here it is again:

Sorry; I had meant to add your acks.

This patch is the same as in v2; the other patch has some minor changes as in
the cover letter (adding includes and always exposing a couple of function
prototypes).

> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks!

> BTW, you have a typo in the subject.

I'll go fix that now.

Mark.
