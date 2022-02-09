Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFDA44AF8D6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 18:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238515AbiBIR5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 12:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbiBIR5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 12:57:11 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB61C0613C9;
        Wed,  9 Feb 2022 09:57:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5C00ECE2253;
        Wed,  9 Feb 2022 17:57:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DBE7C340E9;
        Wed,  9 Feb 2022 17:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644429430;
        bh=iOxYp/R4z6NyCd4CMctrHVzFrNaRVI37GlqDqEU6psI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gQbP413M18GeHBjrV/vjinZHhOzGZMJZ6pHXdH/yNQLJ675oDAEskxhGDuqhftcSS
         ROlfUZvpjGqjojoJZ85WrCEardNq5D3mMhQDJSzsLO1gH1+Wf8mm4XI2O446r8TmJl
         uTBLjK2DBH8l0wSBzm8XNFzRDlFIW4YFeOSonQd9RxpoFxLHMq3iNCEekd6J/xzAwB
         eecKsemaKrIU95miFZupeAkvItH4v/aoCPxU8wzm2KE3aSUHFi6XdYdUWEoZHdKSJC
         9AMzp8Qcth27749Vdhr8WxgRuyf185fo3c2F+5lD16DF8uIIykAxbJMpzFLQgBOC0h
         bmTTmkqZ4HYWA==
Date:   Thu, 10 Feb 2022 01:49:19 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
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
Message-ID: <YgP+n5OMhQPSbICV@xhacker>
References: <20220209123800.269774-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220209123800.269774-1-heiko@sntech.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 01:37:46PM +0100, Heiko Stuebner wrote:
> Svpbmt is an extension defining "Supervisor-mode: page-based memory types"
> for things like non-cacheable pages or I/O memory pages.
> 
> 
> So this is my 2nd try at implementing Svpbmt (and the diverging D1 memory
> types) using the alternatives framework.
> 
> This includes a number of changes to the alternatives mechanism itself.
> The biggest one being the move to a more central location, as I expect
> in the future, nearly every chip needing some sort of patching, be it
> either for erratas or for optional features (svpbmt or others).
> 
> The dt-binding for svpbmt itself is of course not finished and is still
> using the binding introduced in previous versions, as where to put
> a svpbmt-property in the devicetree is still under dicussion.
> Atish seems to be working on a framework for extensions [0],
> 
> The series also introduces support for the memory types of the D1
> which are implemented differently to svpbmt. But when patching anyway
> it's pretty clean to add the D1 variant via ALTERNATIVE_2 to the same
> location.
> 
> The only slightly bigger difference is that the "normal" type is not 0
> as with svpbmt, so kernel patches for this PMA type need to be applied
> even before the MMU is brought up, so the series introduces a separate
> stage for that.
> 
> 
> In theory this series is 3 parts:
> - sbi cache-flush / null-ptr
> - alternatives improvements
> - svpbmt+d1
> 
> So expecially patches from the first 2 areas could be applied when
> deemed ready, I just thought to keep it together to show-case where
> the end-goal is and not requiring jumping between different series.
> 
> 
> The sbi cache-flush patch is based on Atish's sparse-hartid patch [1],
> as it touches a similar area in mm/cacheflush.c
> 
> 
> I picked the recipient list from the previous version, hopefully
> I didn't forget anybody.
> 
> changes in v6:
> - rebase onto 5.17-rc1
> - handle sbi null-ptr differently
> - improve commit messages
> - use riscv,mmu as property name
> 
> changes in v5:
> - move to use alternatives for runtime-patching

Hi,

another choice is using static key mechanism. Pros: no need to coding
in asm, all in c.

To support new arch features, I see other arch sometimes use static
key, sometimes use alternative mechanism, so one question here would
be which mechanism is better? Any guide?

Thanks in advance
