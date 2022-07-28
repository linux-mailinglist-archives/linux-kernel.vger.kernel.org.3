Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A13F58430C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiG1P0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbiG1P0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:26:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C985F9B4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 08:26:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D150961B7C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 15:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9827EC433C1;
        Thu, 28 Jul 2022 15:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659022000;
        bh=OY1CFZWT7ad7PEe4fFSJDPEcJ11GALMZHQVGZ3Tqumo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f9HytRqrLmomx4xvTJW+cidOARGraS/srKv4Akng2xTx86OJwLfVXVsQNcUJe/lUx
         FSRGeGiMnAZZEfv7CZKiUgWdyhmUTnyfQN11WTrQY0Pd2mkEWw7v2IOoNeR7ykcVU1
         QxTddwr5DpEWzduPI2YTdW9uizrIMy2GXFZWpIIw7sxnhJpz05suP/6Qvkrqk7kz6p
         5wcDu9SGemwnxkdCGm1RztjLoQyZ68jhQHwMMiqtS88KqDpDIOUHsIrk1z4HpFoTht
         rsCjPt5wg5mRIOXMgH5zQ0WZHCPK3AvzyL/+A3rjLTMR2mrAk0cR0LuasMgPYNrzMb
         rS9qHXl3UX4hg==
Date:   Thu, 28 Jul 2022 23:17:38 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: save movk instructions in mov_q when the lower
 16|32 bits are all zero
Message-ID: <YuKokvBjDxATePpH@xhacker>
References: <20220709084830.3124-1-jszhang@kernel.org>
 <CAMj1kXEy7_zyDqQC_e9Rf1a8HuMBz_HbZOAP-WBzeeDVu8Mwmw@mail.gmail.com>
 <YuKh2pmJC6/17Riy@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YuKh2pmJC6/17Riy@xhacker>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 10:49:02PM +0800, Jisheng Zhang wrote:
> On Wed, Jul 27, 2022 at 08:15:11AM -0700, Ard Biesheuvel wrote:
> > On Sat, 9 Jul 2022 at 01:58, Jisheng Zhang <jszhang@kernel.org> wrote:
> > >
> > > Currently mov_q is used to move a constant into a 64-bit register,
> > > when the lower 16 or 32bits of the constant are all zero, the mov_q
> > > emits one or two useless movk instructions. If the mov_q macro is used
> > > in hot code path, we want to save the movk instructions as much as
> > > possible. For example, when CONFIG_ARM64_MTE is 'Y' and
> > > CONFIG_KASAN_HW_TAGS is 'N', the following code in __cpu_setup()
> > > routine is the pontential optimization target:
> > >
> > >         /* set the TCR_EL1 bits */
> > >         mov_q   x10, TCR_MTE_FLAGS
> > >
> > > Before the patch:
> > >         mov     x10, #0x10000000000000
> > >         movk    x10, #0x40, lsl #32
> > >         movk    x10, #0x0, lsl #16
> > >         movk    x10, #0x0
> > >
> > > After the patch:
> > >         mov     x10, #0x10000000000000
> > >         movk    x10, #0x40, lsl #32
> > >
> > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > 
> > This is broken for constants that have 0xffff in the top 16 bits, as
> > in that case, we will emit a MOVN/MOVK/MOVK sequence, and omitting the
> > MOVKs will set the corresponding field to 0xffff not 0x0.
> 
> Thanks so much for this hint. I think you are right about the 0xffff in
> top 16bits case.
> 

the patch breaks below usage case:
mov_q x0, 0xffffffff00000000

I think the reason is mov_q starts from high bits, if we change the
macro to start from LSB, then that could solve the breakage. But this
needs a rewrite of mov_q
