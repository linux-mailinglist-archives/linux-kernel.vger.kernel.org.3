Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0274BA1F8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241373AbiBQNwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:52:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241338AbiBQNwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:52:36 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3BD24F34
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:52:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1F964CE2B13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 13:52:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001A6C340EC;
        Thu, 17 Feb 2022 13:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645105934;
        bh=1FBELcGmNgV6WPqnzG9KqZxFGr79RBS+xeX0XZJnkjo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ACYy3WFkE3PdBBIvnhvya7apXL70pWr/FmXq6xHs5Mbn90yrrQshiL4/n6/d+eyXO
         KA+oAOmGfIAZZTA9+/dZZN/Y17zbtwuYggX9YM37Dj3yRre9No8JuDPSo48qNI2Mal
         bg+Ufy8Cjla9JPYzFgZ7OEvDMoc8AEuTr/lPAWlI5tMHu6eifavy7DoHpIm3of8VQ5
         FlxH+mlTEcJ11WJ0Nekb70Zc6Iah3oPV651xkKYM8TEoo0L3koyc8iFSX05QICRP4k
         JcJ2VJwox2b4f2LRbcVke1fNHhPIp0/EAwZ+kmTMjpRG+AguUTEfWCqn0WfE69ma/3
         xGdB6keScQ9gA==
Date:   Thu, 17 Feb 2022 14:52:11 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        bp@alien8.de, catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        james.morse@arm.com, joey.gouly@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, tglx@linutronix.de,
        valentin.schneider@arm.com, will@kernel.org
Subject: Re: [PATCH v4 0/7] arm64 / sched/preempt: support PREEMPT_DYNAMIC
 with static keys
Message-ID: <20220217135211.GA745330@lothringen>
References: <20220214165216.2231574-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214165216.2231574-1-mark.rutland@arm.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 04:52:09PM +0000, Mark Rutland wrote:
> This series enables PREEMPT_DYNAMIC on arm64. To do so, it adds a new
> mechanism allowing the preemption functions to be enabled/disabled using
> static keys rather than static calls, with architectures selecting
> whether they use static calls or static keys.
> 
> With non-inline static calls, each function call results in a call to
> the (out-of-line) trampoline which either tail-calls its associated
> callee or performs an early return.
> 
> The key idea is that where we're only enabling/disabling a single
> callee, we can inline this trampoline into the start of the callee,
> using a static key to decide whether to return early, and leaving the
> remaining codegen to the compiler. The overhead should be similar to
> (and likely lower than) using a static call trampoline. Since most
> codegen is up to the compiler, we sidestep a number of implementation
> pain-points (e.g. things like CFI should "just work" as well as they do
> for any other functions).
> 
> The bulk of the diffstat for kernel/sched/core.c is shuffling the
> PREEMPT_DYNAMIC code later in the file, and the actual additions are
> fairly trivial.
> 
> I've given this very light build+boot testing so far.

Acked-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!
