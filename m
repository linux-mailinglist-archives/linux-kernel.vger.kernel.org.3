Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7820A4F9D18
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239062AbiDHSnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237887AbiDHSm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:42:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7690190B77;
        Fri,  8 Apr 2022 11:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F15360B4D;
        Fri,  8 Apr 2022 18:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37DAEC385A3;
        Fri,  8 Apr 2022 18:40:19 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hw7ZM3DK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1649443217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5p8HbWxOv/2pCcrFRIk5uy5GvnZxVWWqGCXEJeAr/VI=;
        b=hw7ZM3DKXNV/PCbZ27tOsMmXRTiv/fRiwXtCpNB0Y95WzzR8bK+prKfASznhrt+sI6VYcP
        JgT9H5GtkoA+jROggAq+JYownqGfREZ8MSGOuZKcJzf+CHaADipObRJFEs60xwyHJ1+hny
        xsJ6FQ5svtLEpIhYOh3ZMRBXxb2C+BU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6baee431 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 8 Apr 2022 18:40:17 +0000 (UTC)
Date:   Fri, 8 Apr 2022 20:40:08 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        arnd@arndb.de, Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, x86@kernel.org,
        linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH RFC v1 07/10] arm64: use sched_clock() for
 random_get_entropy() instead of zero
Message-ID: <YlCBiLIh5ZFqMr6X@zx2c4.com>
References: <20220408182145.142506-1-Jason@zx2c4.com>
 <20220408182145.142506-8-Jason@zx2c4.com>
 <YlCAEaG4i/OuMKet@lakrids>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YlCAEaG4i/OuMKet@lakrids>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Fri, Apr 08, 2022 at 07:33:53PM +0100, Mark Rutland wrote:
> On Fri, Apr 08, 2022 at 08:21:42PM +0200, Jason A. Donenfeld wrote:
> > In the event that random_get_entropy() can't access a cycle counter or
> > similar, falling back to returning 0 is really not the best we can do.
> > Instead, at least calling sched_clock() would be preferable, because
> > that always needs to return _something_, even falling back to jiffies
> > eventually. It's not as though sched_clock() is super high precision or
> > guaranteed to be entropic, but basically anything that's not zero all
> > the time is better than returning zero all the time.
> > 
> > If CONFIG_ARM_ARCH_TIMER=n, then get_cycles() will return 0, so we only
> > need the fallback code for that case.
> 
> In arch/arm64/Kconfig we unconditionally select CONFIG_ARM_ARCH_TIMER,
> so that configuration shouldn't be possible, and I don't think this
> patch is necessary.
> 
> On arm64 we depend on the architected timer in a bunch of places, so
> anyone hacking that out has bigger problems.

Thanks for the tip. I'll drop this patch from the series.

Jason
