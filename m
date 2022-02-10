Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3714B1260
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244037AbiBJQKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:10:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238711AbiBJQKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:10:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E153EB;
        Thu, 10 Feb 2022 08:10:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2557B82656;
        Thu, 10 Feb 2022 16:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3A9C004E1;
        Thu, 10 Feb 2022 16:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644509412;
        bh=ZAorFPJpvUFVFfC8NuB8t266XcSbj42njOVNokd0dNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZeNgkJL9Trv43cyPqcRNLgzsO9LuxFTQK2vJ1dEhPqEN7KQ3PmsPrIwNYbDpvKGZn
         69d0QHkczLmrGiQqx+EbiEEYNRPZupkA2CJ70hnLTad+V4HKubd5nfhRlgJVAOROLF
         +yhe7l1O2oYK/N+DTMpY5XAMN2O/GjdubZisOnu+ZMRIDx/C1U9h6t0DK/RmDS+gDz
         k9KrryjofYBOiuRRRVj71l4dCBP8uNIfapILtwiz03tA6wE9GyNBYT8iiIYSqcKeyc
         dXGm3ASW46sBzRiPJ4Mfd+l8b2SM6KZMU8E4PS/u+VAkDizpgLU0qpPcSuxXng9Pa8
         rLGhJD9zkLtyQ==
Date:   Fri, 11 Feb 2022 00:01:42 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, wefu@redhat.com, liush@allwinnertech.com,
        guoren@kernel.org, atishp@atishpatra.org, anup@brainfault.org,
        drew@beagleboard.org, hch@lst.de, arnd@arndb.de, wens@csie.org,
        maxime@cerno.tech, gfavor@ventanamicro.com,
        andrea.mondelli@huawei.com, behrensj@mit.edu, xinhaoqu@huawei.com,
        huffman@cadence.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, samuel@sholland.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu
Subject: Re: [PATCH v6 00/14] riscv: support for Svpbmt and D1 memory types
Message-ID: <YgU25sWTf8EXTina@xhacker>
References: <20220209123800.269774-1-heiko@sntech.de>
 <YgP+n5OMhQPSbICV@xhacker>
 <14426959.46CLvVMboC@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14426959.46CLvVMboC@diego>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 12:44:04AM +0100, Heiko Stübner wrote:
> Hi,
> 
> Am Mittwoch, 9. Februar 2022, 18:49:19 CET schrieb Jisheng Zhang:
> > On Wed, Feb 09, 2022 at 01:37:46PM +0100, Heiko Stuebner wrote:
> > > Svpbmt is an extension defining "Supervisor-mode: page-based memory types"
> > > for things like non-cacheable pages or I/O memory pages.
> > > 
> > > 
> > > So this is my 2nd try at implementing Svpbmt (and the diverging D1 memory
> > > types) using the alternatives framework.
> > > 
> > > This includes a number of changes to the alternatives mechanism itself.
> > > The biggest one being the move to a more central location, as I expect
> > > in the future, nearly every chip needing some sort of patching, be it
> > > either for erratas or for optional features (svpbmt or others).
> > > 
> > > The dt-binding for svpbmt itself is of course not finished and is still
> > > using the binding introduced in previous versions, as where to put
> > > a svpbmt-property in the devicetree is still under dicussion.
> > > Atish seems to be working on a framework for extensions [0],
> > > 
> > > The series also introduces support for the memory types of the D1
> > > which are implemented differently to svpbmt. But when patching anyway
> > > it's pretty clean to add the D1 variant via ALTERNATIVE_2 to the same
> > > location.
> > > 
> > > The only slightly bigger difference is that the "normal" type is not 0
> > > as with svpbmt, so kernel patches for this PMA type need to be applied
> > > even before the MMU is brought up, so the series introduces a separate
> > > stage for that.
> > > 
> > > 
> > > In theory this series is 3 parts:
> > > - sbi cache-flush / null-ptr
> > > - alternatives improvements
> > > - svpbmt+d1
> > > 
> > > So expecially patches from the first 2 areas could be applied when
> > > deemed ready, I just thought to keep it together to show-case where
> > > the end-goal is and not requiring jumping between different series.
> > > 
> > > 
> > > The sbi cache-flush patch is based on Atish's sparse-hartid patch [1],
> > > as it touches a similar area in mm/cacheflush.c
> > > 
> > > 
> > > I picked the recipient list from the previous version, hopefully
> > > I didn't forget anybody.
> > > 
> > > changes in v6:
> > > - rebase onto 5.17-rc1
> > > - handle sbi null-ptr differently
> > > - improve commit messages
> > > - use riscv,mmu as property name
> > > 
> > > changes in v5:
> > > - move to use alternatives for runtime-patching
> > 
> > another choice is using static key mechanism. Pros: no need to coding
> > in asm, all in c.
> > 
> > To support new arch features, I see other arch sometimes use static
> > key, sometimes use alternative mechanism, so one question here would
> > be which mechanism is better? Any guide?
> 
> For me it's also a bit of a learn-as-you-go experience, but I do see some

I hope old hands can give some suggestions here about static key VS.
alternative ;). When to use which mechanism, and why.

> advantages in using alternatives:
> 
> - Static keys need the jump-label infrastructure, which the RiscV kernel
>   only seems to provide on non-XIP kernels [0]

I think you found one bug here.
I believe alternative mechanism also doesn't work for XIP kernel. I will
submit a patch for this case.

> - the amount of asm here is somewhat minimal for the core no-cache and io
>   types (load immediate + shift)
> - using the static key mechanism still does incur more overhead for the
>   conditional

do you mean the icache overhead due to the other disabled branch of
static key? It deserves a check.

> - and if we want to support the strange family-members like the D1,
>   (and it seems we do want that) this would create more conditionals

Maybe implement the standard svpbmt via. static key and cope with D1 as
errata alternative.
>   as we have to test for svpbmt, d1 and maybe future special cases,

From Documentation/riscv/patch-acceptance.rst, the "Submit Checklist
Addendum" section, "we'll only to accept patches for extensions that
have been officially frozen or ratified by the RISC-V Foundation."
This rule hasn't been changed.
Per my understanding of history of the svpbmt patch set, no future
special cases any more.

>   where alternatives-patching on the other hand simply replaces the
>   relevant code with the appropriate variant.
> 

