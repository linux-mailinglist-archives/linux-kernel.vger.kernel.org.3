Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010D14B02CE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 03:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbiBJB6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 20:58:38 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbiBJB5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:57:22 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F75628CE4;
        Wed,  9 Feb 2022 17:35:25 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nHwd4-0005XG-Kr; Thu, 10 Feb 2022 00:44:06 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Jisheng Zhang <jszhang@kernel.org>
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
Date:   Thu, 10 Feb 2022 00:44:04 +0100
Message-ID: <14426959.46CLvVMboC@diego>
In-Reply-To: <YgP+n5OMhQPSbICV@xhacker>
References: <20220209123800.269774-1-heiko@sntech.de> <YgP+n5OMhQPSbICV@xhacker>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Mittwoch, 9. Februar 2022, 18:49:19 CET schrieb Jisheng Zhang:
> On Wed, Feb 09, 2022 at 01:37:46PM +0100, Heiko Stuebner wrote:
> > Svpbmt is an extension defining "Supervisor-mode: page-based memory types"
> > for things like non-cacheable pages or I/O memory pages.
> > 
> > 
> > So this is my 2nd try at implementing Svpbmt (and the diverging D1 memory
> > types) using the alternatives framework.
> > 
> > This includes a number of changes to the alternatives mechanism itself.
> > The biggest one being the move to a more central location, as I expect
> > in the future, nearly every chip needing some sort of patching, be it
> > either for erratas or for optional features (svpbmt or others).
> > 
> > The dt-binding for svpbmt itself is of course not finished and is still
> > using the binding introduced in previous versions, as where to put
> > a svpbmt-property in the devicetree is still under dicussion.
> > Atish seems to be working on a framework for extensions [0],
> > 
> > The series also introduces support for the memory types of the D1
> > which are implemented differently to svpbmt. But when patching anyway
> > it's pretty clean to add the D1 variant via ALTERNATIVE_2 to the same
> > location.
> > 
> > The only slightly bigger difference is that the "normal" type is not 0
> > as with svpbmt, so kernel patches for this PMA type need to be applied
> > even before the MMU is brought up, so the series introduces a separate
> > stage for that.
> > 
> > 
> > In theory this series is 3 parts:
> > - sbi cache-flush / null-ptr
> > - alternatives improvements
> > - svpbmt+d1
> > 
> > So expecially patches from the first 2 areas could be applied when
> > deemed ready, I just thought to keep it together to show-case where
> > the end-goal is and not requiring jumping between different series.
> > 
> > 
> > The sbi cache-flush patch is based on Atish's sparse-hartid patch [1],
> > as it touches a similar area in mm/cacheflush.c
> > 
> > 
> > I picked the recipient list from the previous version, hopefully
> > I didn't forget anybody.
> > 
> > changes in v6:
> > - rebase onto 5.17-rc1
> > - handle sbi null-ptr differently
> > - improve commit messages
> > - use riscv,mmu as property name
> > 
> > changes in v5:
> > - move to use alternatives for runtime-patching
> 
> another choice is using static key mechanism. Pros: no need to coding
> in asm, all in c.
> 
> To support new arch features, I see other arch sometimes use static
> key, sometimes use alternative mechanism, so one question here would
> be which mechanism is better? Any guide?

For me it's also a bit of a learn-as-you-go experience, but I do see some
advantages in using alternatives:

- Static keys need the jump-label infrastructure, which the RiscV kernel
  only seems to provide on non-XIP kernels [0]
- the amount of asm here is somewhat minimal for the core no-cache and io
  types (load immediate + shift)
- using the static key mechanism still does incur more overhead for the
  conditional
- and if we want to support the strange family-members like the D1,
  (and it seems we do want that) this would create more conditionals
  as we have to test for svpbmt, d1 and maybe future special cases,
  where alternatives-patching on the other hand simply replaces the
  relevant code with the appropriate variant.


Heiko


[0] https://elixir.bootlin.com/linux/latest/source/arch/riscv/Kconfig#L67


