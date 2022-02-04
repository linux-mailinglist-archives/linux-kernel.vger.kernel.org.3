Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB364A9F6F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 19:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377721AbiBDSqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 13:46:42 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60204 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239269AbiBDSql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 13:46:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E5C061C39
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 18:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984CEC004E1;
        Fri,  4 Feb 2022 18:46:37 +0000 (UTC)
Date:   Fri, 4 Feb 2022 18:46:34 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        bp@alien8.de, dave.hansen@linux.intel.com, frederic@kernel.org,
        james.morse@arm.com, joey.gouly@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, tglx@linutronix.de,
        valentin.schneider@arm.com, will@kernel.org
Subject: Re: [PATCH v2 6/7] arm64: entry: centralize premeption decision
Message-ID: <Yf10inOXewNOg15c@arm.com>
References: <20220204150557.434610-1-mark.rutland@arm.com>
 <20220204150557.434610-7-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204150557.434610-7-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 03:05:56PM +0000, Mark Rutland wrote:
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

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
