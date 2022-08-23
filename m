Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B9E59E636
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 17:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242414AbiHWPlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 11:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243900AbiHWPkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 11:40:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EFE2871BE
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 04:35:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2F366146C
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 11:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48052C43140;
        Tue, 23 Aug 2022 11:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661254475;
        bh=e7ujlYGQy+ILTGDj+HqZf7WB+jlKh84s1EqEvQJvi+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d+OGk8d23f285DWgCWnocLb62X6I5b5JooIc+lwxAj1axicdm8NlaYpfc1kN1D6FH
         8taOWmJEwC8g8Bde1BO9IlL4mpj5gABE4PZGGq+oXCZLfyItLJAevhiaXO7BW9L1Rv
         whdJBJAcrJQ7+iEeq17wlEeLjttYUVsQV/j+6p3SnPuSYxN71fSHCvILum0gsrS/3+
         Qshdrl86SOclVuWVRkBLkLgIEEEbu/7ZAQpccr6CpPuQzKlUzhLI6uZqcBKCQqVWRC
         dpH5BudO/ouzaZiYcpBe0rpQAkoO0ntqD+/bAPF2cGxZRs3yNEcphAbQ+WMqbKbSI+
         T2Fqt2XQdBkNA==
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, willy@infradead.org,
        andy.shevchenko@gmail.com, jvgediya@linux.ibm.com, ardb@kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] arm64: fix rodata=full
Date:   Tue, 23 Aug 2022 12:34:20 +0100
Message-Id: <166124892296.3125128.7339949940987512196.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220817154022.3974645-1-mark.rutland@arm.com>
References: <20220817154022.3974645-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2022 16:40:22 +0100, Mark Rutland wrote:
> On arm64, "rodata=full" has been suppored (but not documented) since
> commit:
> 
>   c55191e96caa9d78 ("arm64: mm: apply r/o permissions of VM areas to its linear alias as well")
> 
> As it's necessary to determine the rodata configuration early during
> boot, arm64 has an early_param() handler for this, whereas init/main.c
> has a __setup() handler which is run later.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: fix rodata=full
      https://git.kernel.org/arm64/c/2e8cff0a0eee

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
