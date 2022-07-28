Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F0158426D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 16:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiG1O6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 10:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiG1O6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:58:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A744D25D5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 07:58:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63F70B82483
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 14:58:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C37C433D6;
        Thu, 28 Jul 2022 14:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659020280;
        bh=6M9eeRLOMpyd2fv8oifdFaKJnoAlGspljCnu9f2IJFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vBFc2PN+5phwjOZXiEV258XXch99IrfdLHkkQWzoQDxy5izyp6BpHFkat4b8DnWJX
         DAq1/mozFFHXc3OEAGCdZD47/rEuRSqeOhfZmFfOcf1umPuBLrYQlf97iFI+d62Xku
         R4sGoBNdPBtxe0eCEu6FqU+b/mLMkpSQ9VPSLzLCDRPC4veI1ujaBh+jzOog1lNryH
         qRYXp8ZyrRuJuMtR+gcLEP54WGMUgC1q6NHpl57UEwE2wgCvIsJhWQWAeiEX0kuyqR
         nrs8BDJ7fnyZr8iJ1/q6r4zYlBTBFm9XW9MV1N1n+TPuHrBJh7p/6Zvz5vtCP+hnJL
         Vv3dKx7IYcewA==
Date:   Thu, 28 Jul 2022 22:48:58 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: save movk instructions in mov_q when the lower
 16|32 bits are all zero
Message-ID: <YuKh2pmJC6/17Riy@xhacker>
References: <20220709084830.3124-1-jszhang@kernel.org>
 <CAMj1kXEy7_zyDqQC_e9Rf1a8HuMBz_HbZOAP-WBzeeDVu8Mwmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXEy7_zyDqQC_e9Rf1a8HuMBz_HbZOAP-WBzeeDVu8Mwmw@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 08:15:11AM -0700, Ard Biesheuvel wrote:
> On Sat, 9 Jul 2022 at 01:58, Jisheng Zhang <jszhang@kernel.org> wrote:
> >
> > Currently mov_q is used to move a constant into a 64-bit register,
> > when the lower 16 or 32bits of the constant are all zero, the mov_q
> > emits one or two useless movk instructions. If the mov_q macro is used
> > in hot code path, we want to save the movk instructions as much as
> > possible. For example, when CONFIG_ARM64_MTE is 'Y' and
> > CONFIG_KASAN_HW_TAGS is 'N', the following code in __cpu_setup()
> > routine is the pontential optimization target:
> >
> >         /* set the TCR_EL1 bits */
> >         mov_q   x10, TCR_MTE_FLAGS
> >
> > Before the patch:
> >         mov     x10, #0x10000000000000
> >         movk    x10, #0x40, lsl #32
> >         movk    x10, #0x0, lsl #16
> >         movk    x10, #0x0
> >
> > After the patch:
> >         mov     x10, #0x10000000000000
> >         movk    x10, #0x40, lsl #32
> >
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> 
> This is broken for constants that have 0xffff in the top 16 bits, as
> in that case, we will emit a MOVN/MOVK/MOVK sequence, and omitting the
> MOVKs will set the corresponding field to 0xffff not 0x0.

Thanks so much for this hint. I think you are right about the 0xffff in
top 16bits case.

