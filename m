Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E644AF90B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 19:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238658AbiBISLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 13:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238684AbiBISK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 13:10:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5CEC0613C9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 10:10:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A44261990
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 18:10:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92932C340E7;
        Wed,  9 Feb 2022 18:10:55 +0000 (UTC)
Date:   Wed, 9 Feb 2022 18:10:52 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        bp@alien8.de, dave.hansen@linux.intel.com, frederic@kernel.org,
        james.morse@arm.com, joey.gouly@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, tglx@linutronix.de,
        valentin.schneider@arm.com, will@kernel.org
Subject: Re: [PATCH v3 6/7] arm64: entry: centralize premeption decision
Message-ID: <YgQDrGaWerGM3B2C@arm.com>
References: <20220209153535.818830-1-mark.rutland@arm.com>
 <20220209153535.818830-7-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209153535.818830-7-mark.rutland@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 03:35:34PM +0000, Mark Rutland wrote:
> For historical reasons, the decision of whether or not to preempt is
> spread across arm64_preempt_schedule_irq() and __el1_irq(), and it would
> be clearer if this were all in one place.
> 
> Also, arm64_preempt_schedule_irq() calls lockdep_assert_irqs_disabled(),
> but this is redundant, as we have a subsequent identical assertion in
> __exit_to_kernel_mode(), and preempt_schedule_irq() will
> BUG_ON(!irqs_disabled()) anyway.
> 
> This patch removes the redundant assertion and centralizes the
> preemption decision making within arm64_preempt_schedule_irq().
> 
> Other than the slight change to assertion behaviour, there should be no
> functional change as a result of this patch.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Joey Gouly <joey.gouly@arm.com>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Will Deacon <will@kernel.org>

I acked this patch in v2, has anything changed? Well, here it is again:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

BTW, you have a typo in the subject.
