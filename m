Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7490558957
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiFWTlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiFWTlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:41:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2C4393D6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 12:32:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26BAAB82164
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 19:32:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE89C341C6;
        Thu, 23 Jun 2022 19:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656012731;
        bh=ERoOIE3XukZfOJmHWTtOTuImoF93fDbxR6+oSzM3aVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WVkJROCccCG62xbLHjMQLkZPFpvOV4R8FJuDHqxgFlYQr6LagN9sVUIiOBe+DA61y
         7Ajgfviu5YjvkKg/RjmjeYxKNIc9mzYkd62iKCR0MAYzcGfaYKYo72AoyGd0YfMw7b
         w2XtooYHNdPZYAiP2q0Zk4RVsMkjelrp9CQZfkJIKv+sKNCr08v3HqsxFK2zHV8EV6
         a94D+mP7qxA3jENIC1hrKwaA4JRkdy4wjbpvaNCMwaQdqmapgvLW4glm/rDs5+29fP
         RrLOkS4zQNneBSxO2ZTPdOHaV/GBo7cwiZR7DMowQdP2f0cK7aiE1cLYtxkHuqypV3
         TqleGinfXsAlg==
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, tglx@linutronix.de,
        peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: fix lockdep in NMI context
Date:   Thu, 23 Jun 2022 20:31:41 +0100
Message-Id: <165599516275.2981885.2147188564179543777.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220511131733.4074499-1-mark.rutland@arm.com>
References: <20220511131733.4074499-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2022 14:17:31 +0100, Mark Rutland wrote:
> For lockdep to function correctly in NMI context, architectures need to
> correctly save/restore lockdep state at NMI entry/exit time, correctly
> manage lockdep state within the NMI context, and need to select
> TRACE_IRQFLAGS_NMI_SUPPORT.
> 
> Currently arm64 falls short of this merely by failing to select
> TRACE_IRQFLAGS_NMI_SUPPORT, and this can result in spurious lockdep
> splats with GICv3 Pseudo-NMIs are in use. Patch 2 has an example.
> 
> [...]

This looks good to me and the x86 changes are trivial (famous last
words...), so I've queued the series up on its own branch in the arm64
tree.

Applied to arm64 (for-next/irqflags-nmi), thanks!

[1/2] arch: make TRACE_IRQFLAGS_NMI_SUPPORT generic
      https://git.kernel.org/arm64/c/4510bffb4d02
[2/2] arm64: select TRACE_IRQFLAGS_NMI_SUPPORT
      https://git.kernel.org/arm64/c/3381da254fab

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
